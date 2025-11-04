Return-Path: <linux-kernel+bounces-885442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DC9C32E49
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 21:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D44F18C0105
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 20:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4697B267B94;
	Tue,  4 Nov 2025 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ES3s0Thd"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A078221FB2;
	Tue,  4 Nov 2025 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762287617; cv=none; b=YyTiaYxg71rw7tryr0zbsFsgKEk4qdsyvf4a/I/q2HO3pD50eOGCUtsDEegPCRJTbSX0TpZDtyiHP258ZiHq73TIu5QQN/WreliFNob9QabiqCqZDJvAwbTzIVyM4wDD0jW8o9bypQY8YYwfeiFYsFY9cUyvTQj3036I0bl+J/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762287617; c=relaxed/simple;
	bh=Dq20Mw4VNAHOQ4YAE/3GTuyj1DZZ8AuxS8UdqtaiZVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGGOkFvwQBLOing2bGuLxxA+FvdqDMCQPlxk/t2Uc0VHeL/Gaueua6/SO9wZrHLd8CKuGuh07obihD1hBx94cnGJI73PrUVlvAh+RT+4oRaXYI2s1SC6ij3X0cBsWb27RVzZ0hWamkDaikeHnP9dw8ncLSoJgz7S3D4zCXsPhe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ES3s0Thd; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762287603; x=1762892403; i=w_armin@gmx.de;
	bh=syXcaXM35g8+3oG8wE5ws8JhknYS6Wz+pRM1Xd1jmI8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ES3s0Thdie3Z2lQxJMJ8r4upCjf4BLPnTneJrxHucINVsyK7EHXUG9hs0NgwvIf2
	 LJx0ymV3oC8lMhukU8tUfcRdTLDv74IbXMqKTIuWvJ3t3G15ayvkaK7+fPw2A5JMi
	 Op8QxNEwNcEbobtyvQjTMpqbPNmMN7q/MWI+bP1Vf5HZwI2QC0USkoRWJc7QjG/CT
	 8kavIZZTNshBO/11H9lN7QLUJcVNFSrnrYKM7ZVUtG9vlZTTO+FTdYct3b27s7dMA
	 iFH63OZENndPgLEuAWOG+KjTb2Vzl2Z2RzCgL9vTqAn+iLpXSwgNsY3HaUp/Wj0N0
	 XiAi7Qh3fcGbGzW5JA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fnj-1vLZu140HP-00DMgB; Tue, 04
 Nov 2025 21:20:03 +0100
Message-ID: <8c14706f-f3cc-45e9-bdef-db2c9171f46e@gmx.de>
Date: Tue, 4 Nov 2025 21:20:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] platform/x86: lenovo-wmi-{capdata,other}: Support
 multiple Capability Data
To: Rong Zhang <i@rong.moe>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20251031155349.24693-1-i@rong.moe>
 <20251031155349.24693-4-i@rong.moe>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20251031155349.24693-4-i@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UFCF6sWlyZcmmt9+aZlrcc++hidVpbfv0qtDHQH3lWIpbV2gEqJ
 72iisjGeY7+iY/jFE0gjZ0vofkP8pKoiPzCa0RDBXwdV+s7a7IkKRdZQnHguziB0H1CmzIO
 SH76ruNXFJt5TS5weo0FvI39pxTmnGjBVLB87ksNS7nAyt9Ht1U1ax60HQRHRfs/dqf64OZ
 jwvz0JBMfcShudcAC9ZQQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QbBmix/1PPQ=;lr5AOszAmztUaZxbd5aJezdBa5Y
 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

Am 31.10.25 um 16:51 schrieb Rong Zhang:

> The current implementation are heavily bound to capdata01. Rewrite it so
> that it is suitable to utilize other Capability Data as well.
>
> No functional change intended.
>
> Signed-off-by: Rong Zhang <i@rong.moe>
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
> Changes in v2:
> - Fix function parameter 'type' not described in 'lwmi_cd_match' (thanks
>    kernel test bot)
> ---
>   drivers/platform/x86/lenovo/wmi-capdata.c | 208 +++++++++++++++++-----
>   drivers/platform/x86/lenovo/wmi-capdata.h |   7 +-
>   drivers/platform/x86/lenovo/wmi-other.c   |  27 ++-
>   3 files changed, 190 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/platform/x86/lenovo/wmi-capdata.c b/drivers/platfor=
m/x86/lenovo/wmi-capdata.c
> index c5e74b2bfeb3..1f7fc09b7c3f 100644
> --- a/drivers/platform/x86/lenovo/wmi-capdata.c
> +++ b/drivers/platform/x86/lenovo/wmi-capdata.c
> @@ -12,8 +12,13 @@
>    *
>    * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
>    *   - Initial implementation (formerly named lenovo-wmi-capdata01)
> + *
> + * Copyright (C) 2025 Rong Zhang <i@rong.moe>
> + *   - Unified implementation
>    */
>  =20
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>   #include <linux/acpi.h>
>   #include <linux/cleanup.h>
>   #include <linux/component.h>
> @@ -36,6 +41,25 @@
>   #define ACPI_AC_CLASS "ac_adapter"
>   #define ACPI_AC_NOTIFY_STATUS 0x80
>  =20
> +enum lwmi_cd_type {
> +	LENOVO_CAPABILITY_DATA_01,
> +};
> +
> +#define LWMI_CD_TABLE_ITEM(_type)		\
> +	[_type] =3D {				\
> +		.guid_string =3D _type##_GUID,	\
> +		.name =3D #_type,			\
> +		.type =3D _type,			\
> +	}
> +
> +static const struct lwmi_cd_info {
> +	const char *guid_string;
> +	const char *name;
> +	enum lwmi_cd_type type;
> +} lwmi_cd_table[] =3D {
> +	LWMI_CD_TABLE_ITEM(LENOVO_CAPABILITY_DATA_01),
> +};
> +
>   struct lwmi_cd_priv {
>   	struct notifier_block acpi_nb; /* ACPI events */
>   	struct wmi_device *wdev;
> @@ -44,15 +68,19 @@ struct lwmi_cd_priv {
>  =20
>   struct cd_list {
>   	struct mutex list_mutex; /* list R/W mutex */
> +	enum lwmi_cd_type type;
>   	u8 count;
> -	struct capdata01 data[];
> +
> +	union {
> +		DECLARE_FLEX_ARRAY(struct capdata01, cd01);
> +	};
>   };
>  =20
>   /**
>    * lwmi_cd_component_bind() - Bind component to master device.
>    * @cd_dev: Pointer to the lenovo-wmi-capdata driver parent device.
>    * @om_dev: Pointer to the lenovo-wmi-other driver parent device.
> - * @data: cd_list object pointer used to return the capability data.
> + * @data: lwmi_cd_binder object pointer used to return the capability d=
ata.
>    *
>    * On lenovo-wmi-other's master bind, provide a pointer to the local c=
apdata
>    * list. This is used to call lwmi_cd*_get_data to look up attribute d=
ata
> @@ -64,9 +92,15 @@ static int lwmi_cd_component_bind(struct device *cd_d=
ev,
>   				  struct device *om_dev, void *data)
>   {
>   	struct lwmi_cd_priv *priv =3D dev_get_drvdata(cd_dev);
> -	struct cd_list **cd_list =3D data;
> +	struct lwmi_cd_binder *binder =3D data;
>  =20
> -	*cd_list =3D priv->list;
> +	switch (priv->list->type) {
> +	case LENOVO_CAPABILITY_DATA_01:
> +		binder->cd01_list =3D priv->list;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  =20
>   	return 0;
>   }
> @@ -76,30 +110,33 @@ static const struct component_ops lwmi_cd_component=
_ops =3D {
>   };
>  =20
>   /**
> - * lwmi_cd01_get_data - Get the data of the specified attribute
> + * lwmi_cd*_get_data - Get the data of the specified attribute
>    * @list: The lenovo-wmi-capdata pointer to its cd_list struct.
>    * @attribute_id: The capdata attribute ID to be found.
> - * @output: Pointer to a capdata01 struct to return the data.
> + * @output: Pointer to a capdata* struct to return the data.
>    *
> - * Retrieves the capability data 01 struct pointer for the given
> - * attribute for its specified thermal mode.
> + * Retrieves the capability data struct pointer for the given
> + * attribute.
>    *
>    * Return: 0 on success, or -EINVAL.
>    */
> -int lwmi_cd01_get_data(struct cd_list *list, u32 attribute_id, struct c=
apdata01 *output)
> -{
> -	u8 idx;
> -
> -	guard(mutex)(&list->list_mutex);
> -	for (idx =3D 0; idx < list->count; idx++) {
> -		if (list->data[idx].id !=3D attribute_id)
> -			continue;
> -		memcpy(output, &list->data[idx], sizeof(list->data[idx]));
> -		return 0;
> +#define DEF_LWMI_CDXX_GET_DATA(_cdxx, _cd_type, _output_t)					\
> +	int lwmi_##_cdxx##_get_data(struct cd_list *list, u32 attribute_id, _o=
utput_t *output)	\
> +	{											\
> +		u8 idx;										\
> +		if (WARN_ON(list->type !=3D _cd_type))						\
> +			return -EINVAL;								\
> +		guard(mutex)(&list->list_mutex);						\
> +		for (idx =3D 0; idx < list->count; idx++) {					\
> +			if (list->_cdxx[idx].id !=3D attribute_id)				\
> +				continue;							\
> +			memcpy(output, &list->_cdxx[idx], sizeof(list->_cdxx[idx]));		\
> +			return 0;								\
> +		}										\
> +		return -EINVAL;									\
>   	}
>  =20
> -	return -EINVAL;
> -}
> +DEF_LWMI_CDXX_GET_DATA(cd01, LENOVO_CAPABILITY_DATA_01, struct capdata0=
1);
>   EXPORT_SYMBOL_NS_GPL(lwmi_cd01_get_data, "LENOVO_WMI_CD");
>  =20
>   /**
> @@ -112,10 +149,21 @@ EXPORT_SYMBOL_NS_GPL(lwmi_cd01_get_data, "LENOVO_W=
MI_CD");
>    */
>   static int lwmi_cd_cache(struct lwmi_cd_priv *priv)
>   {
> +	size_t size;
>   	int idx;
> +	void *p;
> +
> +	switch (priv->list->type) {
> +	case LENOVO_CAPABILITY_DATA_01:
> +		p =3D &priv->list->cd01[0];
> +		size =3D sizeof(priv->list->cd01[0]);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  =20
>   	guard(mutex)(&priv->list->list_mutex);
> -	for (idx =3D 0; idx < priv->list->count; idx++) {
> +	for (idx =3D 0; idx < priv->list->count; idx++, p +=3D size) {
>   		union acpi_object *ret_obj __free(kfree) =3D NULL;
>  =20
>   		ret_obj =3D wmidev_block_query(priv->wdev, idx);
> @@ -123,11 +171,10 @@ static int lwmi_cd_cache(struct lwmi_cd_priv *priv=
)
>   			return -ENODEV;
>  =20
>   		if (ret_obj->type !=3D ACPI_TYPE_BUFFER ||
> -		    ret_obj->buffer.length < sizeof(priv->list->data[idx]))
> +		    ret_obj->buffer.length < size)
>   			continue;
>  =20
> -		memcpy(&priv->list->data[idx], ret_obj->buffer.pointer,
> -		       ret_obj->buffer.length);
> +		memcpy(p, ret_obj->buffer.pointer, size);
>   	}
>  =20
>   	return 0;
> @@ -136,20 +183,28 @@ static int lwmi_cd_cache(struct lwmi_cd_priv *priv=
)
>   /**
>    * lwmi_cd_alloc() - Allocate a cd_list struct in drvdata
>    * @priv: lenovo-wmi-capdata driver data.
> + * @type: The type of capability data.
>    *
>    * Allocate a cd_list struct large enough to contain data from all WMI=
 data
>    * blocks provided by the interface.
>    *
>    * Return: 0 on success, or an error.
>    */
> -static int lwmi_cd_alloc(struct lwmi_cd_priv *priv)
> +static int lwmi_cd_alloc(struct lwmi_cd_priv *priv, enum lwmi_cd_type t=
ype)
>   {
>   	struct cd_list *list;
>   	size_t list_size;
>   	int count, ret;
>  =20
>   	count =3D wmidev_instance_count(priv->wdev);
> -	list_size =3D struct_size(list, data, count);
> +
> +	switch (type) {
> +	case LENOVO_CAPABILITY_DATA_01:
> +		list_size =3D struct_size(list, cd01, count);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  =20
>   	list =3D devm_kzalloc(&priv->wdev->dev, list_size, GFP_KERNEL);
>   	if (!list)
> @@ -159,6 +214,7 @@ static int lwmi_cd_alloc(struct lwmi_cd_priv *priv)
>   	if (ret)
>   		return ret;
>  =20
> +	list->type =3D type;
>   	list->count =3D count;
>   	priv->list =3D list;
>  =20
> @@ -168,6 +224,7 @@ static int lwmi_cd_alloc(struct lwmi_cd_priv *priv)
>   /**
>    * lwmi_cd_setup() - Cache all WMI data block information
>    * @priv: lenovo-wmi-capdata driver data.
> + * @type: The type of capability data.
>    *
>    * Allocate a cd_list struct large enough to contain data from all WMI=
 data
>    * blocks provided by the interface. Then loop through each data block=
 and
> @@ -175,11 +232,11 @@ static int lwmi_cd_alloc(struct lwmi_cd_priv *priv=
)
>    *
>    * Return: 0 on success, or an error code.
>    */
> -static int lwmi_cd_setup(struct lwmi_cd_priv *priv)
> +static int lwmi_cd_setup(struct lwmi_cd_priv *priv, enum lwmi_cd_type t=
ype)
>   {
>   	int ret;
>  =20
> -	ret =3D lwmi_cd_alloc(priv);
> +	ret =3D lwmi_cd_alloc(priv, type);
>   	if (ret)
>   		return ret;
>  =20
> @@ -235,9 +292,13 @@ static void lwmi_cd01_unregister(void *data)
>  =20
>   static int lwmi_cd_probe(struct wmi_device *wdev, const void *context)
>   {
> +	const struct lwmi_cd_info *info =3D context;
>   	struct lwmi_cd_priv *priv;
>   	int ret;
>  =20
> +	if (!info)
> +		return -EINVAL;
> +
>   	priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
>   		return -ENOMEM;
> @@ -245,21 +306,34 @@ static int lwmi_cd_probe(struct wmi_device *wdev, =
const void *context)
>   	priv->wdev =3D wdev;
>   	dev_set_drvdata(&wdev->dev, priv);
>  =20
> -	ret =3D lwmi_cd_setup(priv);
> +	ret =3D lwmi_cd_setup(priv, info->type);
>   	if (ret)
> -		return ret;
> +		goto out;
>  =20
> -	priv->acpi_nb.notifier_call =3D lwmi_cd01_notifier_call;
> +	if (info->type =3D=3D LENOVO_CAPABILITY_DATA_01) {
> +		priv->acpi_nb.notifier_call =3D lwmi_cd01_notifier_call;
>  =20
> -	ret =3D register_acpi_notifier(&priv->acpi_nb);
> -	if (ret)
> -		return ret;
> +		ret =3D register_acpi_notifier(&priv->acpi_nb);
> +		if (ret)
> +			goto out;
>  =20
> -	ret =3D devm_add_action_or_reset(&wdev->dev, lwmi_cd01_unregister, &pr=
iv->acpi_nb);
> -	if (ret)
> -		return ret;
> +		ret =3D devm_add_action_or_reset(&wdev->dev, lwmi_cd01_unregister,
> +					       &priv->acpi_nb);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	ret =3D component_add(&wdev->dev, &lwmi_cd_component_ops);
>  =20
> -	return component_add(&wdev->dev, &lwmi_cd_component_ops);
> +out:
> +	if (ret) {
> +		dev_err(&wdev->dev, "failed to register %s: %d\n",
> +			info->name, ret);
> +	} else {
> +		dev_info(&wdev->dev, "registered %s with %u items\n",
> +			 info->name, priv->list->count);
> +	}
> +	return ret;
>   }
>  =20
>   static void lwmi_cd_remove(struct wmi_device *wdev)
> @@ -267,8 +341,12 @@ static void lwmi_cd_remove(struct wmi_device *wdev)
>   	component_del(&wdev->dev, &lwmi_cd_component_ops);
>   }
>  =20
> +#define LWMI_CD_WDEV_ID(_type)				\
> +	.guid_string =3D _type##_GUID,			\
> +	.context =3D &lwmi_cd_table[_type]
> +
>   static const struct wmi_device_id lwmi_cd_id_table[] =3D {
> -	{ LENOVO_CAPABILITY_DATA_01_GUID, NULL },
> +	{ LWMI_CD_WDEV_ID(LENOVO_CAPABILITY_DATA_01) },
>   	{}
>   };
>  =20
> @@ -284,21 +362,61 @@ static struct wmi_driver lwmi_cd_driver =3D {
>   };
>  =20
>   /**
> - * lwmi_cd01_match() - Match rule for the master driver.
> - * @dev: Pointer to the capability data 01 parent device.
> - * @data: Unused void pointer for passing match criteria.
> + * lwmi_cd_match() - Match rule for the master driver.
> + * @dev: Pointer to the capability data parent device.
> + * @type: Pointer to capability data type (enum lwmi_cd_type *) to matc=
h.
>    *
>    * Return: int.
>    */
> -int lwmi_cd01_match(struct device *dev, void *data)
> +static int lwmi_cd_match(struct device *dev, void *type)
> +{
> +	struct lwmi_cd_priv *priv;
> +
> +	if (dev->driver !=3D &lwmi_cd_driver.driver)
> +		return false;
> +
> +	priv =3D dev_get_drvdata(dev);
> +	return priv->list->type =3D=3D *(enum lwmi_cd_type *)type;
> +}
> +
> +/**
> + * lwmi_cd_match_add_all() - Add all match rule for the master driver.
> + * @master: Pointer to the master device.
> + * @matchptr: Pointer to the returned component_match pointer.
> + *
> + * Adds all component matches to the list stored in @matchptr for the @=
master
> + * device. @matchptr must be initialized to NULL. This matches all avai=
lable
> + * capdata types on the machine.
> + */
> +void lwmi_cd_match_add_all(struct device *master, struct component_matc=
h **matchptr)
>   {
> -	return dev->driver =3D=3D &lwmi_cd_driver.driver;
> +	int i;
> +
> +	if (WARN_ON(*matchptr))
> +		return;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(lwmi_cd_table); i++) {
> +		if (!lwmi_cd_table[i].guid_string ||
> +		    !wmi_has_guid(lwmi_cd_table[i].guid_string))
> +			continue;

I am still not happy about this. AFAIK as soon as the ordinary capdata WMI=
 devices are bound together,
the firmware tells you whether or not the additional fan data WMI device i=
s available. Maybe you can do
something like this:

1. Bind both capdata WMI devices as usual.
2. Check if a fan data WMI device is available (you can use a DMI-based qu=
irk list for devices were
    the firmware reports invalid data).
3. Register an additional component that binds to the fan data WMI device.
4. Bind both the additional component and the component registered by the =
fan data WMI device.
5. Register the hwmon device with additional fan data.

If the fan data WMI device is not available, you can simply skip steps 3 a=
nd 4 and simply
register the hwmon device with any additional fan data.

What do you think?

Thanks,
Armin Wolf

> +
> +		component_match_add(master, matchptr, lwmi_cd_match,
> +				    (void *)&lwmi_cd_table[i].type);
> +		if (IS_ERR(matchptr))
> +			return;
> +	}
> +
> +	if (!*matchptr) {
> +		pr_warn("a master driver requested capability data, but nothing is av=
ailable\n");
> +		*matchptr =3D ERR_PTR(-ENODEV);
> +	}
>   }
> -EXPORT_SYMBOL_NS_GPL(lwmi_cd01_match, "LENOVO_WMI_CD");
> +EXPORT_SYMBOL_NS_GPL(lwmi_cd_match_add_all, "LENOVO_WMI_CD");
>  =20
>   module_wmi_driver(lwmi_cd_driver);
>  =20
>   MODULE_DEVICE_TABLE(wmi, lwmi_cd_id_table);
>   MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_AUTHOR("Rong Zhang <i@rong.moe>");
>   MODULE_DESCRIPTION("Lenovo Capability Data WMI Driver");
>   MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/lenovo/wmi-capdata.h b/drivers/platfor=
m/x86/lenovo/wmi-capdata.h
> index 2a4746e38ad4..1e5fce7836cb 100644
> --- a/drivers/platform/x86/lenovo/wmi-capdata.h
> +++ b/drivers/platform/x86/lenovo/wmi-capdata.h
> @@ -7,6 +7,7 @@
>  =20
>   #include <linux/types.h>
>  =20
> +struct component_match;
>   struct device;
>   struct cd_list;
>  =20
> @@ -19,7 +20,11 @@ struct capdata01 {
>   	u32 max_value;
>   };
>  =20
> +struct lwmi_cd_binder {
> +	struct cd_list *cd01_list;
> +};
> +
>   int lwmi_cd01_get_data(struct cd_list *list, u32 attribute_id, struct =
capdata01 *output);
> -int lwmi_cd01_match(struct device *dev, void *data);
> +void lwmi_cd_match_add_all(struct device *master, struct component_matc=
h **matchptr);
>  =20
>   #endif /* !_LENOVO_WMI_CAPDATA_H_ */
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/=
x86/lenovo/wmi-other.c
> index c6dc1b4cff84..20c6ff0be37a 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -579,14 +579,14 @@ static void lwmi_om_fw_attr_remove(struct lwmi_om_=
priv *priv)
>   static int lwmi_om_master_bind(struct device *dev)
>   {
>   	struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
> -	struct cd_list *tmp_list;
> +	struct lwmi_cd_binder binder =3D { 0 };
>   	int ret;
>  =20
> -	ret =3D component_bind_all(dev, &tmp_list);
> +	ret =3D component_bind_all(dev, &binder);
>   	if (ret)
>   		return ret;
>  =20
> -	priv->cd01_list =3D tmp_list;
> +	priv->cd01_list =3D binder.cd01_list;
>   	if (!priv->cd01_list)
>   		return -ENODEV;
>  =20
> @@ -618,6 +618,7 @@ static int lwmi_other_probe(struct wmi_device *wdev,=
 const void *context)
>   {
>   	struct component_match *master_match =3D NULL;
>   	struct lwmi_om_priv *priv;
> +	int ret;
>  =20
>   	priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>   	if (!priv)
> @@ -626,12 +627,26 @@ static int lwmi_other_probe(struct wmi_device *wde=
v, const void *context)
>   	priv->wdev =3D wdev;
>   	dev_set_drvdata(&wdev->dev, priv);
>  =20
> -	component_match_add(&wdev->dev, &master_match, lwmi_cd01_match, NULL);
> +	lwmi_cd_match_add_all(&wdev->dev, &master_match);
>   	if (IS_ERR(master_match))
>   		return PTR_ERR(master_match);
>  =20
> -	return component_master_add_with_match(&wdev->dev, &lwmi_om_master_ops=
,
> -					       master_match);
> +	ret =3D component_master_add_with_match(&wdev->dev, &lwmi_om_master_op=
s,
> +					      master_match);
> +	if (ret)
> +		return ret;
> +
> +	if (likely(component_master_is_bound(&wdev->dev, &lwmi_om_master_ops))=
)
> +		return 0;
> +
> +	/*
> +	 * The bind callbacks of both master and components were never called =
in
> +	 * this case - this driver won't work at all. Failing...
> +	 */
> +	dev_err(&wdev->dev, "unbound master; is any component failing to be pr=
obed?");
> +
> +	component_master_del(&wdev->dev, &lwmi_om_master_ops);
> +	return -EXDEV;
>   }
>  =20
>   static void lwmi_other_remove(struct wmi_device *wdev)

