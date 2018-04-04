function Item(attributes){
  this.description = attributes.description ;
  this.id = attributes.id;
}

Item.success = function(json){
  let item = new Item(json);
  let itemLi = item.renderLI()

  $("ul.todo-list").prepend(itemLi)
  $("#item_description").val("")  
}

Item.error = function(response){
  console.log("You broke it?", response)
}

Item.formSubmit = function(e){
  e.preventDefault()
    let $form = $(this);
    let action = $form.attr("action")
    let params = $form.serialize()

  $.ajax({
    method: "POST",
    url: action,
    data: params, 
    dataType: "json"
  })
    .success(Item.success)
     .error(Item.error)
}

Item.destroy = function(json){
  let item = new Item(json);
  item.destroy();
}

Item.prototype.$li = function(){
  debugger
  return $("li#item_"+this.id)
}

Item.prototype.destroy = function(){
  $("li#item_"+this.id).remove();  
}

Item.destroyListener = function(){
  $("input.destroy").on("click",  function(e){
    e.preventDefault();
    console.log("is this working?")
    // submit this form via ajax and remoe the item
    let $form = $(this).parent("form");
    let action = $form.attr("action");
    let params = $form.serialize();

    $.ajax({
    method: "DELETE",
    url: action,
    data: params, 
    dataType: "json"
    }).success(Item.destroy)
  })  
}

 Item.formSubmitListener = function(){
  $("form#new_item").on("submit", Item.formSubmit)
}

Item.prototype.renderLI = function(){
  return Item.template(this)   
}

Item.ready = function(){
  Item.templateSource = $("#item_template").html()
  Item.template = Handlebars.compile(Item.templateSource);
  Item.formSubmitListener()
  Item.destroyListener()
}  

$(function(){
  Item.ready()
}) 