
describe('Product detail page', () => {
  it('successfully loads', () => {
    cy.visit('/');
  });
  it("checks that there are products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
  it("checks for 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
  // Find a product on the page and click on its link
  it("clicks on the first product", () => {
    cy.get('.products article').first().find('a').click();
  });

  // Assert that the URL contains the expected product ID
  it("checks the url", () => {
    cy.url().should('include', '/products/');
  });

  // Assert that the product detail page is displayed
  it("checks that product exists", () => {
    cy.get('.product-detail').should('exist');
  });
});