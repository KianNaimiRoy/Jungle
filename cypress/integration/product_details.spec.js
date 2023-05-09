
describe('Product detail page', () => {
  it('can be accessed from home page by clicking on a product', () => {
    cy.visit('/'); // Visit the home page

    // Find a product on the page and click on its link
    cy.get('.products article').first().find('a').click();

    // Assert that the URL contains the expected product ID
    cy.url().should('include', '/products/');

    // Assert that the product detail page is displayed
    cy.get('.product-detail').should('exist');
  });
});