describe('My First Test', () => {
  it('Visits the homepage', () => {
    cy.visit('localhost:3000')
  })
  it('Redirects to products page after click', () => {
    cy.contains('Cliff Collard')
      .click()
  })
})