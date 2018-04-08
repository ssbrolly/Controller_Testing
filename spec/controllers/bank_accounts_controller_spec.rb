require 'rails_helper'

RSpec.describe BankAccountsController, type: :controller do
  login_user

  let(:valid_attributes) {
    { institution: 'Chase', amount: 200, active: true }
  }

  let(:invalid_attributes) {
    { institution: '', amount: 200, active: true }
  }

  describe "GET #index" do
    it "returns http success" do
      FactoryBot.create(:bank_account, user: @user)
      binding.pry
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      bank_account = FactoryBot.create(:bank_account, user: @user)
      get :show, params: {id: bank_account.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      bank_account = FactoryBot.create(:bank_account, user: @user)
      get :edit, params: {id: bank_account.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new BankAccount" do
        expect {
          post :create, params: {bank_account: valid_attributes}
        }.to change(BankAccount, :count).by(1)
      end

      it "redirects to the created bank_account" do
        post :create, params: {bank_account: valid_attributes}
        expect(response).to redirect_to(BankAccount.last)
      end
    end

    context "with invalid params" do
      it "does not create a new BankAccount" do
        expect {
          post :create, params: {bank_account: invalid_attributes}
        }.to change(BankAccount, :count).by(0)
      end

      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {bank_account: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    let(:new_attributes) {
      { amount: 220 }
    }

    before(:each) do
      @bank_account = FactoryBot.create(:bank_account, user: @user)
    end

    context "with valid params" do

      it "updates the requested bank_account" do
        put :update, params: {id: @bank_account.id, bank_account: new_attributes}
        @bank_account.reload
        expect(@bank_account.amount).to eq(new_attributes[:amount])
      end

      it "redirects to the bank_account" do
        put :update, params: {id: @bank_account.id, bank_account: valid_attributes}
        expect(response).to redirect_to(@bank_account)
      end
    end

    context "with invalid params" do
      it 'does not update the bank account' do
        put :update, params: {id: @bank_account.id, bank_account: invalid_attributes}
        @bank_account.reload
        expect(@bank_account.institution).to_not eq(invalid_attributes[:institution])
      end

      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: {id: @bank_account.id, bank_account: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested bank_account" do
      bank_account = FactoryBot.create(:bank_account, user: @user)
      binding.pry
      expect {
        delete :destroy, params: {id: bank_account.id}
      }.to change(BankAccount, :count).by(-1)
    end

    it "redirects to the bank_accounts list" do
      bank_account = FactoryBot.create(:bank_account, user: @user)
      delete :destroy, params: {id: bank_account.id}
      expect(response).to redirect_to(bank_accounts_url)
    end
  end


end
