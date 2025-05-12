// Populate the sidebar
//
// This is a script, and not included directly in the page, to control the total size of the book.
// The TOC contains an entry for each page, so if each page includes a copy of the TOC,
// the total size of the page becomes O(n**2).
class MDBookSidebarScrollbox extends HTMLElement {
    constructor() {
        super();
    }
    connectedCallback() {
        this.innerHTML = '<ol class="chapter"><li class="chapter-item expanded affix "><a href="index.html">Introducción</a></li><li class="chapter-item expanded affix "><li class="part-title">Teoría</li><li class="chapter-item expanded "><a href="teoria/conceptos_basicos.html"><strong aria-hidden="true">1.</strong> Conceptos Básicos</a></li><li class="chapter-item expanded "><a href="teoria/system_thinking.html"><strong aria-hidden="true">2.</strong> Pensamiento Sistémico</a></li><li class="chapter-item expanded "><a href="teoria/diagrama_causal.html"><strong aria-hidden="true">3.</strong> Diagrama Causal</a></li><li class="chapter-item expanded "><a href="teoria/stock_flow_diagram.html"><strong aria-hidden="true">4.</strong> Diagrama Stock Flow</a></li><li class="chapter-item expanded "><a href="teoria/crecimiento_economico.html"><strong aria-hidden="true">5.</strong> Crecimiento Económico</a></li><li class="chapter-item expanded "><a href="teoria/limites_crecimiento.html"><strong aria-hidden="true">6.</strong> Límites al Crecimiento</a></li><li class="chapter-item expanded "><a href="teoria/modelando_restricciones.html"><strong aria-hidden="true">7.</strong> Modelando Restricciones</a></li><li class="chapter-item expanded affix "><li class="part-title">Laboratorios</li><li class="chapter-item expanded "><a href="laboratorios/sir.html"><strong aria-hidden="true">8.</strong> SIR Model</a></li><li class="chapter-item expanded "><a href="laboratorios/overshoot_and_collapse.html"><strong aria-hidden="true">9.</strong> Economic Overshoot and Collapse</a></li><li class="chapter-item expanded "><a href="laboratorios/debt_and_crisis.html"><strong aria-hidden="true">10.</strong> Debt Crisis in a Developing Country</a></li><li class="chapter-item expanded affix "><li class="part-title">Tareas</li><li class="chapter-item expanded "><a href="tareas/environmental_management.html"><strong aria-hidden="true">11.</strong> Environmental Management in Miniworld</a></li></ol>';
        // Set the current, active page, and reveal it if it's hidden
        let current_page = document.location.href.toString().split("#")[0];
        if (current_page.endsWith("/")) {
            current_page += "index.html";
        }
        var links = Array.prototype.slice.call(this.querySelectorAll("a"));
        var l = links.length;
        for (var i = 0; i < l; ++i) {
            var link = links[i];
            var href = link.getAttribute("href");
            if (href && !href.startsWith("#") && !/^(?:[a-z+]+:)?\/\//.test(href)) {
                link.href = path_to_root + href;
            }
            // The "index" page is supposed to alias the first chapter in the book.
            if (link.href === current_page || (i === 0 && path_to_root === "" && current_page.endsWith("/index.html"))) {
                link.classList.add("active");
                var parent = link.parentElement;
                if (parent && parent.classList.contains("chapter-item")) {
                    parent.classList.add("expanded");
                }
                while (parent) {
                    if (parent.tagName === "LI" && parent.previousElementSibling) {
                        if (parent.previousElementSibling.classList.contains("chapter-item")) {
                            parent.previousElementSibling.classList.add("expanded");
                        }
                    }
                    parent = parent.parentElement;
                }
            }
        }
        // Track and set sidebar scroll position
        this.addEventListener('click', function(e) {
            if (e.target.tagName === 'A') {
                sessionStorage.setItem('sidebar-scroll', this.scrollTop);
            }
        }, { passive: true });
        var sidebarScrollTop = sessionStorage.getItem('sidebar-scroll');
        sessionStorage.removeItem('sidebar-scroll');
        if (sidebarScrollTop) {
            // preserve sidebar scroll position when navigating via links within sidebar
            this.scrollTop = sidebarScrollTop;
        } else {
            // scroll sidebar to current active section when navigating via "next/previous chapter" buttons
            var activeSection = document.querySelector('#sidebar .active');
            if (activeSection) {
                activeSection.scrollIntoView({ block: 'center' });
            }
        }
        // Toggle buttons
        var sidebarAnchorToggles = document.querySelectorAll('#sidebar a.toggle');
        function toggleSection(ev) {
            ev.currentTarget.parentElement.classList.toggle('expanded');
        }
        Array.from(sidebarAnchorToggles).forEach(function (el) {
            el.addEventListener('click', toggleSection);
        });
    }
}
window.customElements.define("mdbook-sidebar-scrollbox", MDBookSidebarScrollbox);
