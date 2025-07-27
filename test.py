from apps.check_deployment.models import Product
from django.db import transaction, IntegrityError

@transaction.atomic
def remove_record(product_id: int) -> None:
    product = Product.object.get(id=product_id)
    
    try:
        Product.remove(product)
    except IntegrityError as e:
        raise IntegrityError(f"Error occured while deleting record id: {product_id} e: {e}")


=======================================================================================================================
from apps.check_deployment.models impoprt Producdt, FlavorProfile
from django.db import transaction

@transaction.atomic
def create_product(data: dict) -> Product:
    flavor_profiles = data.get("flavor_profiles", [])
    flavor_names = [FlavorProfile.object.get_or_create(name.strip())[0] name in flavor_profiles]

    product = Product.object.create(
        name=data.get("name"),
        roast=data.get("roast"),
        caffeine_type=data.get("caffeine_type"),
    )
    product.flavor_profiles.set(flavor_names)
    return product


