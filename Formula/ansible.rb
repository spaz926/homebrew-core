class Ansible < Formula
  include Language::Python::Virtualenv

  desc "Automate deployment, configuration, and upgrading"
  homepage "https://www.ansible.com/"
  url "https://files.pythonhosted.org/packages/82/33/53edc29f74573d6059dc8ad0a6bc4c55427788c9f15fe42948d430636348/ansible-4.3.0.tar.gz"
  sha256 "aeb0007a18e8914dd3ffe0acb2c4377f2d1f25e01c39e845c6cb8b16bdc1018b"
  license "GPL-3.0-or-later"
  head "https://github.com/ansible/ansible.git", branch: "devel"

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "61a15f344b350a738d0d7f4b13d756aa238d290094c1156a9be2b13b5c0be36a"
    sha256 cellar: :any,                 big_sur:       "4b90371532be77da00f23876df17831e37c0be66058e23292f44fd7a7e1c062c"
    sha256 cellar: :any,                 catalina:      "b042a8e16f0538d1e31e520a7d96a4d973e3f20517da8288c3af196b9cc09e86"
    sha256 cellar: :any,                 mojave:        "d0838e21d568bef35f5bc4aa4449010abb81bd069696f1ca147031d4c2f90dbd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9a2e0df4474348b6a834df6a865774a04c67ea9657db61eac6296eed3e1acc23"
  end

  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "libyaml"
  depends_on "openssl@1.1"
  depends_on "python@3.9"

  uses_from_macos "krb5"
  uses_from_macos "libffi"
  uses_from_macos "libxslt"

  # This will collect requirements from:
  #   ansible
  #   docker
  #   python-neutronclient (OpenStack)
  #   shade (OpenStack)
  #   pywinrm (Windows)
  #   kerberos (Windows)
  #   boto3 (AWS)
  #   apache-libcloud (Google GCE)
  #   passlib (htpasswd core module)
  #   zabbix-api (Zabbix extras module)
  #   junos-eznc (Juniper device support)
  #   jxmlease (Juniper device support)
  #   dnspython (DNS Lookup - dig)
  #   pysphere3 (VMware vSphere support)
  #   python-consul (Consul support)
  #   requests-credssp (CredSSP support for windows hosts)
  #   openshift (k8s module support)
  #   pexpect (expect module support)
  #   ntc-templates (Parsing semi-structured text)

  # Automatically updated resources
  resource "ansible-core" do
    url "https://files.pythonhosted.org/packages/96/eb/437cbb50b2faa1458e1ad38912acb20dd228b5a0ae0aa198eef9887ac192/ansible-core-2.11.3.tar.gz"
    sha256 "0ced1b4f67197edb27b50934c95d4cb644c6d635d72c7f826c4425dfe4537674"
  end

  resource "apache-libcloud" do
    url "https://files.pythonhosted.org/packages/39/e0/64f54da78a1856713810e7b5f540fec53582ca91afaab0568ed44527d4fe/apache-libcloud-3.3.1.tar.gz"
    sha256 "d7450453eaf5904eb4fb4f74cf9f37dc83721a719bce34f5abb336b1a1ab974d"
  end

  resource "appdirs" do
    url "https://files.pythonhosted.org/packages/d7/d8/05696357e0311f5b5c316d7b95f46c669dd9c15aaeecbb48c7d0aeb88c40/appdirs-1.4.4.tar.gz"
    sha256 "7d5d0167b2b1ba821647616af46a749d1c653740dd0d2415100fe26e27afdf41"
  end

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/ed/d6/3ebca4ca65157c12bd08a63e20ac0bdc21ac7f3694040711f9fd073c0ffb/attrs-21.2.0.tar.gz"
    sha256 "ef6aaac3ca6cd92904cdd0d83f629a15f18053ec84e6432106f7a4d04ae4f5fb"
  end

  resource "bcrypt" do
    url "https://files.pythonhosted.org/packages/d8/ba/21c475ead997ee21502d30f76fd93ad8d5858d19a3fad7cd153de698c4dd/bcrypt-3.2.0.tar.gz"
    sha256 "5b93c1726e50a93a033c36e5ca7fdcd29a5c7395af50a6892f5d9e7c6cfbfb29"
  end

  resource "boto3" do
    url "https://files.pythonhosted.org/packages/fa/d8/a677b94a9982b3e0dd1997dcb6aa0be174169af238fe4836d58a447412cf/boto3-1.18.3.tar.gz"
    sha256 "13e60f88d13161df951d6e52bd483cdbe1a36a31f818746289d8ba0879465710"
  end

  resource "botocore" do
    url "https://files.pythonhosted.org/packages/1b/88/90cc742609dc5a0d0815ea5b13dc9b96fe8ce1cc6c099765c80864746899/botocore-1.21.3.tar.gz"
    sha256 "0b6f378c9efbc72eee61aba1e16cab90bde53a37bd2d861f6435552fd7030adf"
  end

  resource "cachetools" do
    url "https://files.pythonhosted.org/packages/52/ba/619250fa6bc11ce6aa4de0604d45843090a53cd7d10d7253b89669313370/cachetools-4.2.2.tar.gz"
    sha256 "61b5ed1e22a0924aed1d23b478f37e8d52549ff8a961de2909c69bf950020cff"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/6d/78/f8db8d57f520a54f0b8a438319c342c61c22759d8f9a1cd2e2180b5e5ea9/certifi-2021.5.30.tar.gz"
    sha256 "2bbf76fd432960138b3ef6dda3dde0544f27cbf8546c458e60baf371917ba9ee"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/2e/92/87bb61538d7e60da8a7ec247dc048f7671afe17016cd0008b3b710012804/cffi-1.14.6.tar.gz"
    sha256 "c9a875ce9d7fe32887784274dd533c57909b7b1dcadcc128a2ac21331a9765dd"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/37/fd/05a04d7e14548474d30d90ad0db5d90ee2ba55cd967511a354cf88b534f1/charset-normalizer-2.0.3.tar.gz"
    sha256 "c46c3ace2d744cfbdebceaa3c19ae691f53ae621b39fd7570f59d14fb7f2fd12"
  end

  resource "cliff" do
    url "https://files.pythonhosted.org/packages/cd/ba/da7f1c8f63e6171b3cdf38afc103574d27c885e007352e35bba01b235263/cliff-3.8.0.tar.gz"
    sha256 "8dd215d0a84c9a3ab2fa2aa700849f4e7b786639f66caa0ad4108c85dca95a7c"
  end

  resource "cmd2" do
    url "https://files.pythonhosted.org/packages/a6/93/adfe582bbb6123cbe3ae7214a3ba2688c51b42c7c39fa3fea6ab87bcfac1/cmd2-2.1.2.tar.gz"
    sha256 "25dbb2e9847aaa686a8a21e84e3d101db8b79f5cb992e044fc54210ab8c0ad41"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/1f/bb/5d3246097ab77fa083a61bd8d3d527b7ae063c7d8e8671b1cf8c4ec10cbe/colorama-0.4.4.tar.gz"
    sha256 "5941b2b48a20143d2267e95b1c2a7603ce057ee39fd88e7329b0c292aa16869b"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/9b/77/461087a514d2e8ece1c975d8216bc03f7048e6090c5166bc34115afdaa53/cryptography-3.4.7.tar.gz"
    sha256 "3d10de8116d25649631977cb37da6cbdd2d6fa0e0281d014a5b7d337255ca713"
  end

  resource "debtcollector" do
    url "https://files.pythonhosted.org/packages/43/db/878dd456ccdbba6e466fc91e2534fd183a345a3fe261c4780a0e46c6dab0/debtcollector-2.2.0.tar.gz"
    sha256 "787981f4d235841bf6eb0467e23057fb1ac7ee24047c32028a8498b9128b6829"
  end

  resource "decorator" do
    url "https://files.pythonhosted.org/packages/4f/51/15a4f6b8154d292e130e5e566c730d8ec6c9802563d58760666f1818ba58/decorator-5.0.9.tar.gz"
    sha256 "72ecfba4320a893c53f9706bebb2d55c270c1e51a28789361aa93e4a21319ed5"
  end

  resource "dnspython" do
    url "https://files.pythonhosted.org/packages/13/27/5277de856f605f3429d752a39af3588e29d10181a3aa2e2ee471d817485a/dnspython-2.1.0.zip"
    sha256 "e4a87f0b573201a0f3727fa18a516b055fd1107e0e5477cded4a2de497df1dd4"
  end

  resource "docker" do
    url "https://files.pythonhosted.org/packages/fa/a2/e46d7c1b51394a09271a3b07c3a68deb3a669429beafd444d9553ed52868/docker-5.0.0.tar.gz"
    sha256 "3e8bc47534e0ca9331d72c32f2881bb13b93ded0bcdeab3c833fb7cf61c0a9a5"
  end

  resource "dogpile.cache" do
    url "https://files.pythonhosted.org/packages/99/d3/36efc44d13ec2eca3fb3aa918844a941a4d3bb6619d46d609a641c0ab3d6/dogpile.cache-1.1.3.tar.gz"
    sha256 "6f0bcf97c73bfec1a7bf14e5a248488cee00c2d494bf63f3789ea6d95a57c1cf"
  end

  resource "future" do
    url "https://files.pythonhosted.org/packages/45/0b/38b06fd9b92dc2b68d58b75f900e97884c45bedd2ff83203d933cf5851c9/future-0.18.2.tar.gz"
    sha256 "b1bead90b70cf6ec3f0710ae53a525360fa360d306a86583adc6bf83a4db537d"
  end

  resource "google-auth" do
    url "https://files.pythonhosted.org/packages/4d/71/b0cfe841fb477554438a1c16983213c897c5e22f425c4698df6b0ed3e9d9/google-auth-1.33.1.tar.gz"
    sha256 "7665c04f2df13cc938dc7d9066cddb1f8af62b038bc8b2306848c1b23121865f"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/cb/38/4c4d00ddfa48abe616d7e572e02a04273603db446975ab46bbcd36552005/idna-3.2.tar.gz"
    sha256 "467fbad99067910785144ce333826c71fb0e63a425657295239737f7ecd125f3"
  end

  resource "iso8601" do
    url "https://files.pythonhosted.org/packages/45/66/a943f702763c879e2754b46089a136ee1e58f0f720c58fa640c00281d3fd/iso8601-0.1.16.tar.gz"
    sha256 "36532f77cc800594e8f16641edae7f1baf7932f05d8e508545b95fc53c6dc85b"
  end

  resource "Jinja2" do
    url "https://files.pythonhosted.org/packages/39/11/8076571afd97303dfeb6e466f27187ca4970918d4b36d5326725514d3ed3/Jinja2-3.0.1.tar.gz"
    sha256 "703f484b47a6af502e743c9122595cc812b0271f661722403114f71a79d0f5a4"
  end

  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/3c/56/3f325b1eef9791759784aa5046a8f6a1aff8f7c898a2e34506771d3b99d8/jmespath-0.10.0.tar.gz"
    sha256 "b85d0567b8666149a93172712e68920734333c0ce7e89b78b3e987f71e5ed4f9"
  end

  resource "jsonpatch" do
    url "https://files.pythonhosted.org/packages/21/67/83452af2a6db7c4596d1e2ecaa841b9a900980103013b867f2865e5e1cf0/jsonpatch-1.32.tar.gz"
    sha256 "b6ddfe6c3db30d81a96aaeceb6baf916094ffa23d7dd5fa2c13e13f8b6e600c2"
  end

  resource "jsonpointer" do
    url "https://files.pythonhosted.org/packages/6b/35/400557d3df63269a4c010cbd4865910b3c1718fbfe8d83210b216cd3efcf/jsonpointer-2.1.tar.gz"
    sha256 "5a34b698db1eb79ceac454159d3f7c12a451a91f6334a4f638454327b7a89962"
  end

  resource "junos-eznc" do
    url "https://files.pythonhosted.org/packages/7b/9b/59569f1de4080a29952924973763b501ae04d2c4be51d4f173cecb735368/junos-eznc-2.6.2.tar.gz"
    sha256 "878c479c933346cc8cc60b6d145973568ac23e7c453e193cf55625e7921a9b62"
  end

  resource "jxmlease" do
    url "https://files.pythonhosted.org/packages/8d/6a/b2944628e019c753894552c1499bf60e2cef9efea138756c5d66f0d5eb98/jxmlease-1.0.3.tar.gz"
    sha256 "612c1575d8a87026dea096bb75acec7302dd69040fa23d9116e71e30d5e0839e"
  end

  resource "kerberos" do
    url "https://files.pythonhosted.org/packages/39/cd/f98699a6e806b9d974ea1d3376b91f09edcb90415adbf31e3b56ee99ba64/kerberos-1.3.1.tar.gz"
    sha256 "cdd046142a4e0060f96a00eb13d82a5d9ebc0f2d7934393ed559bac773460a2c"
  end

  resource "keystoneauth1" do
    url "https://files.pythonhosted.org/packages/d3/65/e6a02ffec522bc5382438b1c4c855899f4d65978d4cfc23cded2dcab931e/keystoneauth1-4.3.1.tar.gz"
    sha256 "93605430a6d1424f31659bc5685e9dc1be9a6254e88c99f00cffc0a60c648a64"
  end

  resource "kubernetes" do
    url "https://files.pythonhosted.org/packages/a1/56/fd57e391f60dc143402e45560ca87df1d74ddade5ac9b7e9f2cc0338171e/kubernetes-12.0.1.tar.gz"
    sha256 "ec52ea01d52e2ec3da255992f7e859f3a76f2bdb51cf65ba8cd71dfc309d8daa"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/e5/21/a2e4517e3d216f0051687eea3d3317557bde68736f038a3b105ac3809247/lxml-4.6.3.tar.gz"
    sha256 "39b78571b3b30645ac77b95f7c69d1bffc4cf8c3b157c435a34da72e78c82468"
  end

  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/bf/10/ff66fea6d1788c458663a84d88787bae15d45daa16f6b3ef33322a51fc7e/MarkupSafe-2.0.1.tar.gz"
    sha256 "594c67807fb16238b30c44bdf74f36c02cdf22d1c8cda91ef8a0ed8dabf5620a"
  end

  resource "msgpack" do
    url "https://files.pythonhosted.org/packages/59/04/87fc6708659c2ed3b0b6d4954f270b6e931def707b227c4554f99bd5401e/msgpack-1.0.2.tar.gz"
    sha256 "fae04496f5bc150eefad4e9571d1a76c55d021325dcd484ce45065ebbdd00984"
  end

  resource "munch" do
    url "https://files.pythonhosted.org/packages/43/a1/ec48010724eedfe2add68eb7592a0d238590e14e08b95a4ffb3c7b2f0808/munch-2.5.0.tar.gz"
    sha256 "2d735f6f24d4dba3417fa448cae40c6e896ec1fdab6cdb5e6510999758a4dbd2"
  end

  resource "ncclient" do
    url "https://files.pythonhosted.org/packages/72/fd/ccae38393c22099229b68e8cdf061408b824e09ee207e2401c224398c5b0/ncclient-0.6.9.tar.gz"
    sha256 "0112f2ad41fb658f52446d870853a63691d69299c73c7351c520d38dbd8dc0c4"
  end

  resource "netaddr" do
    url "https://files.pythonhosted.org/packages/c3/3b/fe5bda7a3e927d9008c897cf1a0858a9ba9924a6b4750ec1824c9e617587/netaddr-0.8.0.tar.gz"
    sha256 "d6cc57c7a07b1d9d2e917aa8b36ae8ce61c35ba3fcd1b83ca31c5a0ee2b5a243"
  end

  resource "netifaces" do
    url "https://files.pythonhosted.org/packages/a6/91/86a6eac449ddfae239e93ffc1918cf33fd9bab35c04d1e963b311e347a73/netifaces-0.11.0.tar.gz"
    sha256 "043a79146eb2907edf439899f262b3dfe41717d34124298ed281139a8b93ca32"
  end

  resource "ntc-templates" do
    url "https://files.pythonhosted.org/packages/22/1a/e0fc1d7016500986639d6f9a3470fd91ac6e4732c61ecbf4e892dc01673f/ntc_templates-2.1.0.tar.gz"
    sha256 "6ce17e48d951d531afa83ad3b68fda822a3d8937e8c955387053c501edfec41f"
  end

  resource "ntlm-auth" do
    url "https://files.pythonhosted.org/packages/44/a5/ab45529cc1860a1cb05129b438b189af971928d9c9c9d1990b549a6707f9/ntlm-auth-1.5.0.tar.gz"
    sha256 "c9667d361dc09f6b3750283d503c689070ff7d89f2f6ff0d38088d5436ff8543"
  end

  resource "oauthlib" do
    url "https://files.pythonhosted.org/packages/9e/84/001a3f8d9680f3b26d5e7711e13d5ff92e4b511766a72ac6b4a4e5f06796/oauthlib-3.1.1.tar.gz"
    sha256 "8f0215fcc533dd8dd1bee6f4c412d4f0cd7297307d43ac61666389e3bc3198a3"
  end

  resource "openshift" do
    url "https://files.pythonhosted.org/packages/bf/61/395013f4378b12f4755522d50fc3649a774a1d6b1d95d4682bade4abeba1/openshift-0.12.1.tar.gz"
    sha256 "a38957684b17ad0e140a87226249bf26de7267db0c83a6d512b48be258052e1a"
  end

  resource "openstacksdk" do
    url "https://files.pythonhosted.org/packages/9c/11/1d366df84f002de860754becea31b21455437a56532c3cbffed0c59a407f/openstacksdk-0.58.0.tar.gz"
    sha256 "d8368d1728f686114213d22cc8e3eef71629fae1424b2ad2c5d22a7b9a04a278"
  end

  resource "os-client-config" do
    url "https://files.pythonhosted.org/packages/58/be/ba2e4d71dd57653c8fefe8577ade06bf5f87826e835b3c7d5bb513225227/os-client-config-2.1.0.tar.gz"
    sha256 "abc38a351f8c006d34f7ee5f3f648de5e3ecf6455cc5d76cfd889d291cdf3f4e"
  end

  resource "os-service-types" do
    url "https://files.pythonhosted.org/packages/58/3f/09e93eb484b69d2a0d31361962fb667591a850630c8ce47bb177324910ec/os-service-types-1.7.0.tar.gz"
    sha256 "31800299a82239363995b91f1ebf9106ac7758542a1e4ef6dc737a5932878c6c"
  end

  resource "osc-lib" do
    url "https://files.pythonhosted.org/packages/68/7f/9acfaf98c2073a5104716983db550d6422e7307d0211243387c162bb760e/osc-lib-2.4.1.tar.gz"
    sha256 "257ef0cda902664605a850a858172306acb2b08b0e7e32d7a5b4f12dc6bc56c5"
  end

  resource "oslo.config" do
    url "https://files.pythonhosted.org/packages/5a/97/44d9370a7d73f38e79d5bf0c6fef82c526d9ac580d2aabacedf177430dad/oslo.config-8.7.1.tar.gz"
    sha256 "a0c346d778cdc8870ab945e438bea251b5f45fae05d6d99dfe4953cca2277b60"
  end

  resource "oslo.context" do
    url "https://files.pythonhosted.org/packages/00/3b/9088add726eb883c3e7950c9875a3a1b3f88801b738c00ef8c585f9cb402/oslo.context-3.3.0.tar.gz"
    sha256 "d83f098e79ee0731c352fe2d59a82c16b213e2cf3259958c019defabf510fc08"
  end

  resource "oslo.i18n" do
    url "https://files.pythonhosted.org/packages/de/6f/e8343be26e69e42b3d30610c3ffee576e5b901be6792e5c3af1384613b40/oslo.i18n-5.0.1.tar.gz"
    sha256 "3484b71e30f75c437523302d1151c291caf4098928269ceec65ce535456e035b"
  end

  resource "oslo.log" do
    url "https://files.pythonhosted.org/packages/c6/25/27d09d4ca0138f154f7f3ded780ed884eeb9941b9351b3f14a6a4e6c0b29/oslo.log-4.6.0.tar.gz"
    sha256 "dad5d7ff1290f01132b356d36a1bb79f98a3929d5005cce73e849ed31b385ba7"
  end

  resource "oslo.serialization" do
    url "https://files.pythonhosted.org/packages/0a/85/9af1feeff44ee56868145674e0c2e6654e8ff2241c5bc178bb9539065c3d/oslo.serialization-4.1.0.tar.gz"
    sha256 "cecc7794df806c85cb70dbd6c2b3af19bc68047ad29e3c6442be90a0a4de5379"
  end

  resource "oslo.utils" do
    url "https://files.pythonhosted.org/packages/4c/8d/53957d87c9aa14bdad33858c5c3dd79c2131679b871f18de837e4a6b2e8a/oslo.utils-4.9.2.tar.gz"
    sha256 "20db285734ff6c3b50d5a6afcb2790ade0c7ba02fbc876feed43733f2c41a5c9"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/df/86/aef78bab3afd461faecf9955a6501c4999933a48394e90f03cd512aad844/packaging-21.0.tar.gz"
    sha256 "7dc96269f53a4ccec5c0670940a4281106dd0bb343f47b7471f779df49c2fbe7"
  end

  resource "paramiko" do
    url "https://files.pythonhosted.org/packages/cf/a1/20d00ce559a692911f11cadb7f94737aca3ede1c51de16e002c7d3a888e0/paramiko-2.7.2.tar.gz"
    sha256 "7f36f4ba2c0d81d219f4595e35f70d56cc94f9ac40a6acdf51d6ca210ce65035"
  end

  resource "passlib" do
    url "https://files.pythonhosted.org/packages/b6/06/9da9ee59a67fae7761aab3ccc84fa4f3f33f125b370f1ccdb915bf967c11/passlib-1.7.4.tar.gz"
    sha256 "defd50f72b65c5402ab2c573830a6978e5f202ad0d984793c8dde2c4152ebe04"
  end

  resource "pbr" do
    url "https://files.pythonhosted.org/packages/35/8c/69ed04ae31ad498c9bdea55766ed4c0c72de596e75ac0d70b58aa25e0acf/pbr-5.6.0.tar.gz"
    sha256 "42df03e7797b796625b1029c0400279c7c34fd7df24a7d7818a1abb5b38710dd"
  end

  resource "pexpect" do
    url "https://files.pythonhosted.org/packages/e5/9b/ff402e0e930e70467a7178abb7c128709a30dfb22d8777c043e501bc1b10/pexpect-4.8.0.tar.gz"
    sha256 "fc65a43959d153d0114afe13997d439c22823a27cefceb5ff35c2178c6784c0c"
  end

  resource "prettytable" do
    url "https://files.pythonhosted.org/packages/d4/c6/d388b3d4992acf413d1b67101107b7f4651cc2835abd0bbd6661678eb2c1/prettytable-2.1.0.tar.gz"
    sha256 "5882ed9092b391bb8f6e91f59bcdbd748924ff556bb7c634089d5519be87baa0"
  end

  resource "ptyprocess" do
    url "https://files.pythonhosted.org/packages/20/e5/16ff212c1e452235a90aeb09066144d0c5a6a8c0834397e03f5224495c4e/ptyprocess-0.7.0.tar.gz"
    sha256 "5c5d0a3b48ceee0b48485e0c26037c0acd7d29765ca3fbb5cb3831d347423220"
  end

  resource "pyasn1" do
    url "https://files.pythonhosted.org/packages/a4/db/fffec68299e6d7bad3d504147f9094830b704527a7fc098b721d38cc7fa7/pyasn1-0.4.8.tar.gz"
    sha256 "aef77c9fb94a3ac588e87841208bdec464471d9871bd5050a287cc9a475cd0ba"
  end

  resource "pyasn1-modules" do
    url "https://files.pythonhosted.org/packages/88/87/72eb9ccf8a58021c542de2588a867dbefc7556e14b2866d1e40e9e2b587e/pyasn1-modules-0.2.8.tar.gz"
    sha256 "905f84c712230b2c592c19470d3ca8d552de726050d1d1716282a1f6146be65e"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/0f/86/e19659527668d70be91d0369aeaa055b4eb396b0f387a4f92293a20035bd/pycparser-2.20.tar.gz"
    sha256 "2d475327684562c3a96cc71adf7dc8c4f0565175cf86b6d7a404ff4c771f15f0"
  end

  resource "PyNaCl" do
    url "https://files.pythonhosted.org/packages/cf/5a/25aeb636baeceab15c8e57e66b8aa930c011ec1c035f284170cacb05025e/PyNaCl-1.4.0.tar.gz"
    sha256 "54e9a2c849c742006516ad56a88f5c74bf2ce92c9f67435187c3c5953b346505"
  end

  resource "pyOpenSSL" do
    url "https://files.pythonhosted.org/packages/98/cd/cbc9c152daba9b5de6094a185c66f1c6eb91c507f378bb7cad83d623ea88/pyOpenSSL-20.0.1.tar.gz"
    sha256 "4c231c759543ba02560fcd2480c48dcec4dae34c9da7d3747c508227e0624b51"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/c1/47/dfc9c342c9842bbe0036c7f763d2d6686bcf5eb1808ba3e170afdb282210/pyparsing-2.4.7.tar.gz"
    sha256 "c203ec8783bf771a155b207279b9bccb8dea02d8f0c9e5f8ead507bc3246ecc1"
  end

  resource "pyperclip" do
    url "https://files.pythonhosted.org/packages/a7/2c/4c64579f847bd5d539803c8b909e54ba087a79d01bb3aba433a95879a6c5/pyperclip-1.8.2.tar.gz"
    sha256 "105254a8b04934f0bc84e9c24eb360a591aaf6535c9def5f29d92af107a9bf57"
  end

  resource "pyserial" do
    url "https://files.pythonhosted.org/packages/1e/7d/ae3f0a63f41e4d2f6cb66a5b57197850f919f59e558159a4dd3a818f5082/pyserial-3.5.tar.gz"
    sha256 "3c77e014170dfffbd816e6ffc205e9842efb10be9f58ec16d3e8675b4925cddb"
  end

  resource "pysphere3" do
    url "https://files.pythonhosted.org/packages/fa/1e/16cf889e0e38380678631a4afebeeb840cb29f54f11413356770efe29240/pysphere3-0.1.8.tar.gz"
    sha256 "c8efe92e7802b59ef67e09fb20b008fc1bd0d253ba97ba689aa892b125283ae1"
  end

  resource "pyspnego" do
    url "https://files.pythonhosted.org/packages/31/67/1e34ece99b804bd26b0043d584ffb5bc789e34001ac1612eeb073b5c283f/pyspnego-0.1.6.tar.gz"
    sha256 "0356bccedc033b7266d89503eca50717f81fc9d3b98cb1dd5227bb7c1a9275ae"
  end

  resource "python-consul" do
    url "https://files.pythonhosted.org/packages/7f/06/c12ff73cb1059c453603ba5378521e079c3f0ab0f0660c410627daca64b7/python-consul-1.1.0.tar.gz"
    sha256 "168f1fa53948047effe4f14d53fc1dab50192e2a2cf7855703f126f469ea11f4"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end

  resource "python-keystoneclient" do
    url "https://files.pythonhosted.org/packages/0d/17/aaaa6e508ca437360eb348486d6ac7cf17e434400acd222548361959b4bd/python-keystoneclient-4.2.0.tar.gz"
    sha256 "0248426e483b95de395086482c077d48e45990d3b1a3e334b2ec8b2e108f5a8a"
  end

  resource "python-neutronclient" do
    url "https://files.pythonhosted.org/packages/b5/f1/51ee933d67cedb8dbdb4100ab02d2058db5e847b2e8f781b1e076e4dea3c/python-neutronclient-7.5.0.tar.gz"
    sha256 "0ea80c3ec6ba77fecc14ac609abdeb1e6ca5f0591be905f00378039483f0b789"
  end

  resource "python-string-utils" do
    url "https://files.pythonhosted.org/packages/10/91/8c883b83c7d039ca7e6c8f8a7e154a27fdeddd98d14c10c5ee8fe425b6c0/python-string-utils-1.0.0.tar.gz"
    sha256 "dcf9060b03f07647c0a603408dc8b03f807f3b54a05c6e19eb14460256fac0cb"
  end

  resource "pytz" do
    url "https://files.pythonhosted.org/packages/b0/61/eddc6eb2c682ea6fd97a7e1018a6294be80dba08fa28e7a3570148b4612d/pytz-2021.1.tar.gz"
    sha256 "83a4a90894bf38e243cf052c8b58f381bfe9a7a483f6a9cab140bc7f702ac4da"
  end

  resource "pywinrm" do
    url "https://files.pythonhosted.org/packages/a6/2c/b43e69d5f8938f443e369a32b4a70c0874bb4b52cd2e378107f3eddb8cf9/pywinrm-0.4.2.tar.gz"
    sha256 "e7865ec5e46e7fedb859c656cfaba4fcf669de7c042b5a7d8a759544636bcfb7"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/a0/a4/d63f2d7597e1a4b55aa3b4d6c5b029991d3b824b5bd331af8d4ab1ed687d/PyYAML-5.4.1.tar.gz"
    sha256 "607774cbba28732bfa802b54baa7484215f530991055bb562efbed5b2f20a45e"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/e7/01/3569e0b535fb2e4a6c384bdbed00c55b9d78b5084e0fb7f4d0bf523d7670/requests-2.26.0.tar.gz"
    sha256 "b8aa58f8cf793ffd8782d3d8cb19e66ef36f7aba4353eec859e74678b01b07a7"
  end

  resource "requests-credssp" do
    url "https://files.pythonhosted.org/packages/45/d6/c308425fe38e33b5942e7ebd0a20b0dccafc1c89b6276241ccf1ea2f0922/requests-credssp-1.2.0.tar.gz"
    sha256 "63709d23bf66cff5af0c1abab8f99c308be501f7ab4d47d896ad43d20fc441f1"
  end

  resource "requests_ntlm" do
    url "https://files.pythonhosted.org/packages/3e/02/6b31dfc8334caeea446a2ac3aea5b8e197710e0b8ad3c3035f7c79e792a8/requests_ntlm-1.1.0.tar.gz"
    sha256 "9189c92e8c61ae91402a64b972c4802b2457ce6a799d658256ebf084d5c7eb71"
  end

  resource "requests-oauthlib" do
    url "https://files.pythonhosted.org/packages/23/eb/68fc8fa86e0f5789832f275c8289257d8dc44dbe93fce7ff819112b9df8f/requests-oauthlib-1.3.0.tar.gz"
    sha256 "b4261601a71fd721a8bd6d7aa1cc1d6a8a93b4a9f5e96626f8e4d91e8beeaa6a"
  end

  resource "requestsexceptions" do
    url "https://files.pythonhosted.org/packages/82/ed/61b9652d3256503c99b0b8f145d9c8aa24c514caff6efc229989505937c1/requestsexceptions-1.4.0.tar.gz"
    sha256 "b095cbc77618f066d459a02b137b020c37da9f46d9b057704019c9f77dba3065"
  end

  resource "resolvelib" do
    url "https://files.pythonhosted.org/packages/52/ba/3860b1bfe6b08a727deddda52287282e10303d20f01321c3666f2e602c18/resolvelib-0.5.5.tar.gz"
    sha256 "123de56548c90df85137425a3f51eb93df89e2ba719aeb6a8023c032758be950"
  end

  resource "rfc3986" do
    url "https://files.pythonhosted.org/packages/79/30/5b1b6c28c105629cc12b33bdcbb0b11b5bb1880c6cfbd955f9e792921aa8/rfc3986-1.5.0.tar.gz"
    sha256 "270aaf10d87d0d4e095063c65bf3ddbc6ee3d0b226328ce21e036f946e421835"
  end

  resource "rsa" do
    url "https://files.pythonhosted.org/packages/db/b5/475c45a58650b0580421746504b680cd2db4e81bc941e94ca53785250269/rsa-4.7.2.tar.gz"
    sha256 "9d689e6ca1b3038bc82bf8d23e944b6b6037bc02301a574935b2dd946e0353b9"
  end

  resource "ruamel.yaml" do
    url "https://files.pythonhosted.org/packages/83/59/4f576abb336d30b3d47061717224be714a9dc39c774061c34cb41c1795cf/ruamel.yaml-0.17.10.tar.gz"
    sha256 "106bc8d6dc6a0ff7c9196a47570432036f41d556b779c6b4e618085f57e39e67"
  end

  resource "ruamel.yaml.clib" do
    url "https://files.pythonhosted.org/packages/8b/25/08e5ad2431a028d0723ca5540b3af6a32f58f25e83c6dda4d0fcef7288a3/ruamel.yaml.clib-0.2.6.tar.gz"
    sha256 "4ff604ce439abb20794f05613c374759ce10e3595d1867764dd1ae675b85acbd"
  end

  resource "s3transfer" do
    url "https://files.pythonhosted.org/packages/88/ef/4d1b3f52ae20a7e72151fde5c9f254cd83f8a49047351f34006e517e1655/s3transfer-0.5.0.tar.gz"
    sha256 "50ed823e1dc5868ad40c8dc92072f757aa0e653a192845c94a3b676f4a62da4c"
  end

  resource "scp" do
    url "https://files.pythonhosted.org/packages/10/fc/26467959b83c3f68a8dda16cfd09d856008a5caa66a0f7d726c44023fb8a/scp-0.13.6.tar.gz"
    sha256 "0a72f9d782e968b09b114d5607f96b1f16fe9942857afb355399edd55372fcf1"
  end

  resource "shade" do
    url "https://files.pythonhosted.org/packages/b0/a6/a83f14eca6f7223319d9d564030bd322ca52c910c34943f38a59ad2a6549/shade-1.33.0.tar.gz"
    sha256 "36f6936da93723f34bf99d00bae24aa4cc36125d597392ead8319720035d21e8"
  end

  resource "simplejson" do
    url "https://files.pythonhosted.org/packages/2f/58/2bc9d908d3b52bc53876b438055ff129e28cc8b1a83a669ccc87e515c0a5/simplejson-3.17.3.tar.gz"
    sha256 "da72a452bcf4349fc467a12b54ab0e63e654a571cacc44084826d52bde12b6ee"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
    sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
  end

  resource "stevedore" do
    url "https://files.pythonhosted.org/packages/95/bc/dc386a920942dbdfe480c8a4d953ff77ed3dec99ce736634b6ec4f2d97c1/stevedore-3.3.0.tar.gz"
    sha256 "3a5bbd0652bf552748871eaa73a4a8dc2899786bc497a2aa1fcb4dcdb0debeee"
  end

  resource "textfsm" do
    url "https://files.pythonhosted.org/packages/9f/53/fa46575d30be6aa591712aa9c44caa7fa9f057f3bb726fe42519a5ae2d8e/textfsm-1.1.2.tar.gz"
    sha256 "85a450b441aff04b1cac726bdb36f35534a5b196cca08c8bc14fddd879c4255c"
  end

  resource "transitions" do
    url "https://files.pythonhosted.org/packages/ee/ca/8e6eafd9f2d1af7f0bee4af9add66ea633c82519d3d2c40701fa5fb66ad6/transitions-0.8.8.tar.gz"
    sha256 "e7a86b31a161a76133f189b3ae9dad2755a80ea4c1e0eee1805648d021fb677d"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/4f/5a/597ef5911cb8919efe4d86206aa8b2658616d676a7088f0825ca08bd7cb8/urllib3-1.26.6.tar.gz"
    sha256 "f57b4c16c62fa2760b7e3d97c35b255512fb6b59a259730f36ba32ce9f8e342f"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/89/38/459b727c381504f361832b9e5ace19966de1a235d73cdbdea91c771a1155/wcwidth-0.2.5.tar.gz"
    sha256 "c4d647b99872929fdb7bdcaa4fbe7f01413ed3d98077df798530e5b04f116c83"
  end

  resource "websocket-client" do
    url "https://files.pythonhosted.org/packages/58/0d/af54f4732115a20c370f43f179523d189a5cb75711c60ba00b41e163a065/websocket-client-1.1.0.tar.gz"
    sha256 "b68e4959d704768fa20e35c9d508c8dc2bbc041fd8d267c0d7345cffe2824568"
  end

  resource "wrapt" do
    url "https://files.pythonhosted.org/packages/82/f7/e43cefbe88c5fd371f4cf0cf5eb3feccd07515af9fd6cf7dbf1d1793a797/wrapt-1.12.1.tar.gz"
    sha256 "b62ffa81fb85f4332a4f609cab4ac40709470da05643a082ec1eb88e6d9b97d7"
  end

  resource "xmltodict" do
    url "https://files.pythonhosted.org/packages/58/40/0d783e14112e064127063fbf5d1fe1351723e5dfe9d6daad346a305f6c49/xmltodict-0.12.0.tar.gz"
    sha256 "50d8c638ed7ecb88d90561beedbf720c9b4e851a9fa6c47ebd64e99d166d8a21"
  end

  resource "yamlordereddictloader" do
    url "https://files.pythonhosted.org/packages/56/e1/1ca77da64cc355f0de483095e841d96f2366f93b095b83869440a296c21d/yamlordereddictloader-0.4.0.tar.gz"
    sha256 "7f30f0b99ea3f877f7cb340c570921fa9d639b7f69cba18be051e27f8de2080e"
  end

  resource "zabbix-api" do
    url "https://files.pythonhosted.org/packages/e3/ed/2092731880f0de5b07067fc446dc0fc5166f2ee98018b6d524cd3e28a69d/zabbix-api-0.5.4.tar.gz"
    sha256 "2d6c62001cb79a7de6fe286424967276edaca09d3833b72fb04f7863f29fce4b"
  end

  def install
    ENV.prepend_path "PATH", Formula["python@3.9"].opt_libexec/"bin"

    on_macos do
      # Fix "ld: file not found: /usr/lib/system/libsystem_darwin.dylib" for lxml
      ENV["SDKROOT"] = MacOS.sdk_path if MacOS.version <= :sierra
    end

    venv = virtualenv_create(libexec, "python3")
    # Install all of the resources declared on the formula into the virtualenv.
    resources.each do |r|
      # ansible-core provides all ansible binaries
      if r.name == "ansible-core"
        venv.pip_install_and_link r
      else
        venv.pip_install r
      end
    end
    venv.pip_install_and_link buildpath

    resource("ansible-core").stage do
      man1.install Dir["docs/man/man1/*.1"]
    end
  end

  test do
    ENV["ANSIBLE_REMOTE_TEMP"] = testpath/"tmp"
    (testpath/"playbook.yml").write <<~EOS
      ---
      - hosts: all
        gather_facts: False
        tasks:
        - name: ping
          ping:
    EOS
    (testpath/"hosts.ini").write [
      "localhost ansible_connection=local",
      " ansible_python_interpreter=#{Formula["python@3.9"].opt_bin}/python3",
      "\n",
    ].join
    system bin/"ansible-playbook", testpath/"playbook.yml", "-i", testpath/"hosts.ini"

    # Ensure requests[security] is activated
    script = "import requests as r; r.get('https://mozilla-modern.badssl.com')"
    system libexec/"bin/python3", "-c", script
  end
end
