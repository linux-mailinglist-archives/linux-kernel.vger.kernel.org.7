Return-Path: <linux-kernel+bounces-870482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64586C0AE99
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9021A3B4582
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B72C262FCB;
	Sun, 26 Oct 2025 17:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="bMup0W5D"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93972222AA;
	Sun, 26 Oct 2025 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761499423; cv=pass; b=JRXsNXSr3TF00p8tW8fkm5hWgCmagCG5oTbZHiA+Ilm/XvXus6ML50BtN1Brj+VYuROWVVyV1oSlLhoa7FKXgPYbS61BRqmUmmMr/gT3Yi2FWeGZBge4/P+srKZXgPHwKJfL3oxeBMe5NDXux8awDj7fzb8kHwieoe4QrzImwpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761499423; c=relaxed/simple;
	bh=yVq4Ctc6ADSlIZTLIQNvCaRWaWH5Uk3AiU+jfZC7JWE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=XV2ykvJOUIsI7pvDRHJpprmy0rNMMCqf+PzhMy2RiGkty6SSy43IvBor/drK5PUef8htI/a9rRfac7hHZzWiofyj22qpw7QwwKklABNLHWQK10sRFhPEmKFkRnZ6eKl4iCDZLnTelKXTMeZi/hKGKrjEmjYGxGm9OYHH+6VmLS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=bMup0W5D; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1761499397; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h/Pxgl8punt7dlnp7FX8SM3VJorXNECzLK3KhJohVKvXdmgnQ6A2Dlxwddv2PXltIb1bzbefl+D8WeAs5ae8kYqnxiKZ7sn4XvGESm5fONLPt/utOMkV7xlIs/zAjHpb44KRiOtGol3laMgOQpGw044uqBubyXLA8cfUlDPNId0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761499397; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hu3ydCLg81YQ2jnbLLmrL9+S8ZIjCPHZfnGJMPoxubI=; 
	b=nc/MitLcX6pOJtfkmZWwngysNAjqz65FPJJgjXPrjNC9ehrCWBuVGlJZf61Xz7nqYAPR1BSVSQrnMii+3fQ+2X08iLCEWeuyvAQ/ZePXS9eO8+OGpAHhIIBhB2Kcav+bZL+2h4f9ky5hqNX5G2br14UUvN+d/b/+ibt1jTsV7WA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761499397;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=hu3ydCLg81YQ2jnbLLmrL9+S8ZIjCPHZfnGJMPoxubI=;
	b=bMup0W5D6vcroFWwk9zxY8o8BtUB7TMcu2D6MXuJsQfzKSspiL4P8R79y4Addw/V
	wO20VP8/OzRheLJ2Tyd8mZBaBVC4JQSyuLudbaAVa7r9CixOCqr5HWekS2VxcoYUdK4
	PBjRjA9n32x8KLsynfRipVEDfS22SIRlQ/ODfQpU=
Received: by mx.zohomail.com with SMTPS id 176149939569196.28217356278651;
	Sun, 26 Oct 2025 10:23:15 -0700 (PDT)
Message-ID: <e85aa61b4cf3d3dbbe5ce32a7e97a949171d1110.camel@rong.moe>
Subject: Re: [PATCH 3/6] platform/x86: lenovo-wmi-capdata: Add support for
 Capability Data 00
From: Rong Zhang <i@rong.moe>
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,  Guenter Roeck <linux@roeck-us.net>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
In-Reply-To: <CAFqHKT=bMLHvkcohaSNSUqxSkeFg_7aZxMVpBSbWqtsOeuT7rg@mail.gmail.com>
References: <20251019210450.88830-1-i@rong.moe>
	 <20251019210450.88830-4-i@rong.moe>
	 <CAFqHKT=bMLHvkcohaSNSUqxSkeFg_7aZxMVpBSbWqtsOeuT7rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Oct 2025 01:18:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-5 
X-ZohoMailClient: External

Hi Derek,

On Sat, 2025-10-25 at 21:55 -0700, Derek John Clark wrote:
> On Sun, Oct 19, 2025 at 2:05=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
> >=20
> > Add support for LENOVO_CAPABILITY_DATA_00 WMI data block that comes on
> > "Other Mode" enabled hardware. Provides an interface for querying if a
> > given attribute is supported by the hardware, as well as its default
> > value.
> >=20
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > ---
> >  .../wmi/devices/lenovo-wmi-other.rst          |  8 +++++++
> >  drivers/platform/x86/lenovo/wmi-capdata.c     | 23 ++++++++++++++++++-
> >  drivers/platform/x86/lenovo/wmi-capdata.h     |  8 +++++++
> >  3 files changed, 38 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/wmi/devices/lenovo-wmi-other.rst b/Documenta=
tion/wmi/devices/lenovo-wmi-other.rst
> > index d7928b8dfb4b5..adbd7943c6756 100644
> > --- a/Documentation/wmi/devices/lenovo-wmi-other.rst
> > +++ b/Documentation/wmi/devices/lenovo-wmi-other.rst
> > @@ -31,6 +31,14 @@ under the following path:
> >=20
> >    /sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribut=
e>/
> >=20
> > +LENOVO_CAPABILITY_DATA_00
> > +-------------------------
> > +
> > +WMI GUID ``362A3AFE-3D96-4665-8530-96DAD5BB300E``
> > +
> > +The LENOVO-CAPABILITD_DATA_00 interface provides information on whethe=
r the
> > +device supports querying or setting fan speed.
> > +
>=20
> There is a lot more data provided by this interface that hasn't been
> implemented yet. To avoid having to touch this too often I'd prefer if
> it were formatted similarly to the 01 interface where the opening
> paragraph is generic for the interface and the specific features that
> have been implemented in the driver are listed below that. From
> documentation, the 00 interface seems to deal with enabling or
> disabling  various hardware features that don't rely on the gamezone
> thermal mode. I'd also be okay with specifying in the change that 01
> features do rely on the gamezone thermal mode.

Makes sense. Will reword it in v2. Thanks for the suggestion and
information.

> >  LENOVO_CAPABILITY_DATA_01
> >  -------------------------
> >=20
> > diff --git a/drivers/platform/x86/lenovo/wmi-capdata.c b/drivers/platfo=
rm/x86/lenovo/wmi-capdata.c
> > index 14175fe19247e..6927de409b09d 100644
> > --- a/drivers/platform/x86/lenovo/wmi-capdata.c
> > +++ b/drivers/platform/x86/lenovo/wmi-capdata.c
> > @@ -5,6 +5,9 @@
> >   * Lenovo Capability Data provides information on tunable attributes u=
sed by
> >   * the "Other Mode" WMI interface.
> >   *
> > + * Capability Data 00 includes if the attribute is supported by the ha=
rdware,
> > + * and the default_value. All attributes are independent of thermal mo=
des.
> > + *
> >   * Capability Data 01 includes if the attribute is supported by the ha=
rdware,
> >   * and the default_value, max_value, min_value, and step increment. Ea=
ch
> >   * attribute has multiple pages, one for each of the thermal modes man=
aged by
> > @@ -14,7 +17,7 @@
> >   *   - Initial implementation (formerly named lenovo-wmi-capdata01)
> >   *
> >   * Copyright (C) 2025 Rong Zhang <i@rong.moe>
> > - *   - Unified implementation
> > + *   - Unified implementation for Capability Data 00 and 01
> >   */
>=20
> This might be a bit verbose considering the changes are all part of
> the same series.

ACK. Will drop "for ..." in v2.

> Thanks,
> Derek

Thanks,
Rong

> >=20
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > @@ -36,12 +39,14 @@
> >=20
> >  #include "wmi-capdata.h"
> >=20
> > +#define LENOVO_CAPABILITY_DATA_00_GUID "362A3AFE-3D96-4665-8530-96DAD5=
BB300E"
> >  #define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE=
018154"
> >=20
> >  #define ACPI_AC_CLASS "ac_adapter"
> >  #define ACPI_AC_NOTIFY_STATUS 0x80
> >=20
> >  enum lwmi_cd_type {
> > +       LENOVO_CAPABILITY_DATA_00,
> >         LENOVO_CAPABILITY_DATA_01,
> >  };
> >=20
> > @@ -57,6 +62,7 @@ static const struct lwmi_cd_info {
> >         const char *name;
> >         enum lwmi_cd_type type;
> >  } lwmi_cd_table[] =3D {
> > +       LWMI_CD_TABLE_ITEM(LENOVO_CAPABILITY_DATA_00),
> >         LWMI_CD_TABLE_ITEM(LENOVO_CAPABILITY_DATA_01),
> >  };
> >=20
> > @@ -72,6 +78,7 @@ struct cd_list {
> >         u8 count;
> >=20
> >         union {
> > +               DECLARE_FLEX_ARRAY(struct capdata00, cd00);
> >                 DECLARE_FLEX_ARRAY(struct capdata01, cd01);
> >         };
> >  };
> > @@ -95,6 +102,9 @@ static int lwmi_cd_component_bind(struct device *cd_=
dev,
> >         struct lwmi_cd_binder *binder =3D data;
> >=20
> >         switch (priv->list->type) {
> > +       case LENOVO_CAPABILITY_DATA_00:
> > +               binder->cd00_list =3D priv->list;
> > +               break;
> >         case LENOVO_CAPABILITY_DATA_01:
> >                 binder->cd01_list =3D priv->list;
> >                 break;
> > @@ -136,6 +146,9 @@ static const struct component_ops lwmi_cd_component=
_ops =3D {
> >                 return -EINVAL;                                        =
                         \
> >         }
> >=20
> > +DEF_LWMI_CDXX_GET_DATA(cd00, LENOVO_CAPABILITY_DATA_00, struct capdata=
00);
> > +EXPORT_SYMBOL_NS_GPL(lwmi_cd00_get_data, "LENOVO_WMI_CD");
> > +
> >  DEF_LWMI_CDXX_GET_DATA(cd01, LENOVO_CAPABILITY_DATA_01, struct capdata=
01);
> >  EXPORT_SYMBOL_NS_GPL(lwmi_cd01_get_data, "LENOVO_WMI_CD");
> >=20
> > @@ -154,6 +167,10 @@ static int lwmi_cd_cache(struct lwmi_cd_priv *priv=
)
> >         void *p;
> >=20
> >         switch (priv->list->type) {
> > +       case LENOVO_CAPABILITY_DATA_00:
> > +               p =3D &priv->list->cd00[0];
> > +               size =3D sizeof(priv->list->cd00[0]);
> > +               break;
> >         case LENOVO_CAPABILITY_DATA_01:
> >                 p =3D &priv->list->cd01[0];
> >                 size =3D sizeof(priv->list->cd01[0]);
> > @@ -199,6 +216,9 @@ static int lwmi_cd_alloc(struct lwmi_cd_priv *priv,=
 enum lwmi_cd_type type)
> >         count =3D wmidev_instance_count(priv->wdev);
> >=20
> >         switch (type) {
> > +       case LENOVO_CAPABILITY_DATA_00:
> > +               list_size =3D struct_size(list, cd00, count);
> > +               break;
> >         case LENOVO_CAPABILITY_DATA_01:
> >                 list_size =3D struct_size(list, cd01, count);
> >                 break;
> > @@ -346,6 +366,7 @@ static void lwmi_cd_remove(struct wmi_device *wdev)
> >         .context =3D &lwmi_cd_table[_type]
> >=20
> >  static const struct wmi_device_id lwmi_cd_id_table[] =3D {
> > +       { LWMI_CD_WDEV_ID(LENOVO_CAPABILITY_DATA_00) },
> >         { LWMI_CD_WDEV_ID(LENOVO_CAPABILITY_DATA_01) },
> >         {}
> >  };
> > diff --git a/drivers/platform/x86/lenovo/wmi-capdata.h b/drivers/platfo=
rm/x86/lenovo/wmi-capdata.h
> > index 1e5fce7836cbf..a6f0cb006e745 100644
> > --- a/drivers/platform/x86/lenovo/wmi-capdata.h
> > +++ b/drivers/platform/x86/lenovo/wmi-capdata.h
> > @@ -11,6 +11,12 @@ struct component_match;
> >  struct device;
> >  struct cd_list;
> >=20
> > +struct capdata00 {
> > +       u32 id;
> > +       u32 supported;
> > +       u32 default_value;
> > +};
> > +
> >  struct capdata01 {
> >         u32 id;
> >         u32 supported;
> > @@ -21,9 +27,11 @@ struct capdata01 {
> >  };
> >=20
> >  struct lwmi_cd_binder {
> > +       struct cd_list *cd00_list;
> >         struct cd_list *cd01_list;
> >  };
> >=20
> > +int lwmi_cd00_get_data(struct cd_list *list, u32 attribute_id, struct =
capdata00 *output);
> >  int lwmi_cd01_get_data(struct cd_list *list, u32 attribute_id, struct =
capdata01 *output);
> >  void lwmi_cd_match_add_all(struct device *master, struct component_mat=
ch **matchptr);
> >=20
> > --
> > 2.51.0
> >=20

