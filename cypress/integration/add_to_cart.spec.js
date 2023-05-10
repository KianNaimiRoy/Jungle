describe('add to cart button', () => {
  it('successfully loads', () => {
    cy.visit('/');
  });
  it('should add first product to cart', () => {
    // find the first product on the home page and click the 'Add to Cart' button
    cy.get('.products article').first().find('button').contains('Add').click({force: true});
  });
  
  it('should increase cart count by one', () => {
    // assert that the cart count has increased by one
    cy.contains('My Cart (1)').should('be.visible')
  });
});