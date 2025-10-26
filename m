Return-Path: <linux-kernel+bounces-870197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A27DBC0A28D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 05:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 886F04E3172
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 04:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5731723D7FD;
	Sun, 26 Oct 2025 04:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdDAoqvQ"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DD22FE0A
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 04:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761453800; cv=none; b=AwNFlHlc2BF7Du0x5O+AJes7aDoVpIxXj6oACOxbu053V6N3/5uJ0YG7JqedzMo8vagNiOdkL2pjNl+PVBNhwk4oAZrffPGdGx9o4z314i1rXiW+UPg0h/9uEWhcj0BMfqKnCFnCp7QR1vcaD+GvHBsNx5P/ZyKpW2x55i3owJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761453800; c=relaxed/simple;
	bh=IFnR9AQJVniins4SN21nwp1IM/SRlu/7AbRnjE8lLcY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uf0DYUeIHxA/KhZ+D4TXRQGTSS+z3yATmtpOS7zQ6vlQd/5i6FRTsqOCUzQQdgstfG2b5vugSKDe5yDG1OKgCYz/7KWUNKO07Ge88n0e3uoM7As0D07trjmrFkDTb41CQ/zTt54YzbNMBs4587f/jc+I/x6IERqmw85G9bp18J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdDAoqvQ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-87d8fa51993so41200286d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761453797; x=1762058597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ex5LS/Pm0O98RzE23ukkEaOseDRj1dm3Q22X9QVzPlU=;
        b=FdDAoqvQBcBMuy9bXQtIP0qe1PqSv6GPQ1KCiUR4yFhnnLKXM0gq3muWtR2KqArZNT
         oAzN50BT1wJoheuyYqnij+xQm8l5dF4ahdbDqyTjUyLZzXCY2LnImUTzW8Q2n9CsazMH
         O1L8zhXp74h3Ir1084mq3senCgxsVY/d7/+GuZTdQ8bw9uEi3wGqdQU9tf8UnodShD4K
         Ez90notTdNTOYh5jXgKN1TC3qt3yMr9eahhckvlWX8prVVdEAcVNzh88RwF487p5o3pu
         6Fp9N3PramWI228pGtqsUs0wLsn3BCxCAShcRPQYsCUe/Kavk3RF+qUgBkTzKo/sssDR
         O33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761453797; x=1762058597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ex5LS/Pm0O98RzE23ukkEaOseDRj1dm3Q22X9QVzPlU=;
        b=P/0O9An3yKyptBSYWYJv8hv8BRIOSQ6LV18b0Pc+3kmrshVyTppJ0Wjb6GP2+VY4CQ
         HJ8w6M0exJEPQ4SQv3T26qFDGKHWswQ3U/MXJmT29kpThcgH8fCKEzNkfzxZcLBODdfM
         Y7UV0Z/TS3QxzfqcJW9QqvDYimxCfo7Cj0eV9GgNrtejQsVUkO2jH1lrgXxZYNaK/9C1
         psuRxLXB92I6jm97C9k19htyRG6Uq6mM+nrKAIKJSY/nGZmBhR24AZUOl3m9NTp2oRAV
         HBdVACvezaaiT+Dfiq1l5vg62oZJ8IUtA9RmtDn9UWN7o8heQCupJddIPumv5EEK8X+J
         nYlA==
X-Forwarded-Encrypted: i=1; AJvYcCUHgYq91lBKA0M64h9JIKJe9GC3OkqPlawete5RDrV3IjFScJUaU7hBBvsiq1IGfD9dY4Dg41KnMoYk3zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIHn5J4PO9i7t2CuwPUUA9WPEHhzLcvabNV/kbqT4eVY7NzFRw
	zEQ598PeC+y8EGvt0zng6ogDjH9hUb6pmKry03U3CcLhzJeISp8WHyvNWvAm9qJqkqZGiksHZ45
	yn5h2MYyMeEbIi4HR/MzgQHs92vvsDus=
X-Gm-Gg: ASbGncuDPf8Sjjk/MpHRgoIA7q74NipYsB+/0p2PWJbGDtmL7r/nhGJ4O0fRPdIiWsm
	s9IeNluyG/VsupnajxEcs1VMkVOMbZI13PPGj1m/heAFgKId5CjZncIn5ehszqsKVAi0wGKzVIh
	XsZK+NdCDy29j4c1BOvWzAY2kDFw5hMXwrwrfwGx29+GmH5DG53EbwliVbJbAE4t6pqm0vN5Q7M
	0bitjr0mtldpXSmohK3lwP9kw1woK6pI/W7lO/00nazuNv93VqG6O+X+2D8w98ZaGqMwmKFHgXD
	o1Gmds0=
X-Google-Smtp-Source: AGHT+IEME4vbar5zrCtbvo9r3yRuv4Rny+7JWmyzqBnLMtW9G2FgIbKoIiHlECaRgYBpPdAXQ5fWQ7eidFiIcJ1amvk=
X-Received: by 2002:a05:6214:248a:b0:87c:113c:f1d2 with SMTP id
 6a1803df08f44-87c206129b8mr454591116d6.38.1761453796783; Sat, 25 Oct 2025
 21:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019210450.88830-1-i@rong.moe> <20251019210450.88830-3-i@rong.moe>
In-Reply-To: <20251019210450.88830-3-i@rong.moe>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Sat, 25 Oct 2025 21:43:06 -0700
X-Gm-Features: AWmQ_blu0TJ753CLFrr4C_m_X9IHK8RGa6fkGr_rvTKh9hz-btqHPtYGAvzxRr4
Message-ID: <CAFqHKTn9SSgnVR6PxQtPcjGyBEUL0g+G7b5wwXdtv-bSUHy=RA@mail.gmail.com>
Subject: Re: [PATCH 2/6] platform/x86: lenovo-wmi-{capdata,other}: Support
 multiple Capability Data
To: Rong Zhang <i@rong.moe>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Guenter Roeck <linux@roeck-us.net>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 2:05=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
>
> The current inplementation are heavily bound to capdata01. Rewrite it so
> that it is suitable to utilize other Capability Data as well.
>
> No functional changes are introduced.
>
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  drivers/platform/x86/lenovo/wmi-capdata.c | 208 +++++++++++++++++-----
>  drivers/platform/x86/lenovo/wmi-capdata.h |   7 +-
>  drivers/platform/x86/lenovo/wmi-other.c   |  27 ++-
>  3 files changed, 190 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/platform/x86/lenovo/wmi-capdata.c b/drivers/platform=
/x86/lenovo/wmi-capdata.c
> index c5e74b2bfeb36..14175fe19247e 100644
> --- a/drivers/platform/x86/lenovo/wmi-capdata.c
> +++ b/drivers/platform/x86/lenovo/wmi-capdata.c
> @@ -12,8 +12,13 @@
>   *
>   * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
>   *   - Initial implementation (formerly named lenovo-wmi-capdata01)
> + *
> + * Copyright (C) 2025 Rong Zhang <i@rong.moe>
> + *   - Unified implementation
>   */
>
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/acpi.h>
>  #include <linux/cleanup.h>
>  #include <linux/component.h>
> @@ -36,6 +41,25 @@
>  #define ACPI_AC_CLASS "ac_adapter"
>  #define ACPI_AC_NOTIFY_STATUS 0x80
>
> +enum lwmi_cd_type {
> +       LENOVO_CAPABILITY_DATA_01,
> +};
> +
> +#define LWMI_CD_TABLE_ITEM(_type)              \
> +       [_type] =3D {                             \
> +               .guid_string =3D _type##_GUID,    \
> +               .name =3D #_type,                 \
> +               .type =3D _type,                  \
> +       }
> +
> +static const struct lwmi_cd_info {
> +       const char *guid_string;
> +       const char *name;
> +       enum lwmi_cd_type type;
> +} lwmi_cd_table[] =3D {
> +       LWMI_CD_TABLE_ITEM(LENOVO_CAPABILITY_DATA_01),
> +};
> +
>  struct lwmi_cd_priv {
>         struct notifier_block acpi_nb; /* ACPI events */
>         struct wmi_device *wdev;
> @@ -44,15 +68,19 @@ struct lwmi_cd_priv {
>
>  struct cd_list {
>         struct mutex list_mutex; /* list R/W mutex */
> +       enum lwmi_cd_type type;
>         u8 count;
> -       struct capdata01 data[];
> +
> +       union {
> +               DECLARE_FLEX_ARRAY(struct capdata01, cd01);
> +       };
>  };
>
>  /**
>   * lwmi_cd_component_bind() - Bind component to master device.
>   * @cd_dev: Pointer to the lenovo-wmi-capdata driver parent device.
>   * @om_dev: Pointer to the lenovo-wmi-other driver parent device.
> - * @data: cd_list object pointer used to return the capability data.
> + * @data: lwmi_cd_binder object pointer used to return the capability da=
ta.
>   *
>   * On lenovo-wmi-other's master bind, provide a pointer to the local cap=
data
>   * list. This is used to call lwmi_cd*_get_data to look up attribute dat=
a
> @@ -64,9 +92,15 @@ static int lwmi_cd_component_bind(struct device *cd_de=
v,
>                                   struct device *om_dev, void *data)
>  {
>         struct lwmi_cd_priv *priv =3D dev_get_drvdata(cd_dev);
> -       struct cd_list **cd_list =3D data;
> +       struct lwmi_cd_binder *binder =3D data;
>
> -       *cd_list =3D priv->list;
> +       switch (priv->list->type) {
> +       case LENOVO_CAPABILITY_DATA_01:
> +               binder->cd01_list =3D priv->list;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
>
>         return 0;
>  }
> @@ -76,30 +110,33 @@ static const struct component_ops lwmi_cd_component_=
ops =3D {
>  };
>
>  /**
> - * lwmi_cd01_get_data - Get the data of the specified attribute
> + * lwmi_cd*_get_data - Get the data of the specified attribute
>   * @list: The lenovo-wmi-capdata pointer to its cd_list struct.
>   * @attribute_id: The capdata attribute ID to be found.
> - * @output: Pointer to a capdata01 struct to return the data.
> + * @output: Pointer to a capdata* struct to return the data.
>   *
> - * Retrieves the capability data 01 struct pointer for the given
> - * attribute for its specified thermal mode.
> + * Retrieves the capability data struct pointer for the given
> + * attribute.
>   *
>   * Return: 0 on success, or -EINVAL.
>   */
> -int lwmi_cd01_get_data(struct cd_list *list, u32 attribute_id, struct ca=
pdata01 *output)
> -{
> -       u8 idx;
> -
> -       guard(mutex)(&list->list_mutex);
> -       for (idx =3D 0; idx < list->count; idx++) {
> -               if (list->data[idx].id !=3D attribute_id)
> -                       continue;
> -               memcpy(output, &list->data[idx], sizeof(list->data[idx]))=
;
> -               return 0;
> +#define DEF_LWMI_CDXX_GET_DATA(_cdxx, _cd_type, _output_t)              =
                       \
> +       int lwmi_##_cdxx##_get_data(struct cd_list *list, u32 attribute_i=
d, _output_t *output)  \
> +       {                                                                =
                       \
> +               u8 idx;                                                  =
                       \
> +               if (WARN_ON(list->type !=3D _cd_type))                   =
                         \
> +                       return -EINVAL;                                  =
                       \
> +               guard(mutex)(&list->list_mutex);                         =
                       \
> +               for (idx =3D 0; idx < list->count; idx++) {              =
                         \
> +                       if (list->_cdxx[idx].id !=3D attribute_id)       =
                         \
> +                               continue;                                =
                       \
> +                       memcpy(output, &list->_cdxx[idx], sizeof(list->_c=
dxx[idx]));            \
> +                       return 0;                                        =
                       \
> +               }                                                        =
                       \
> +               return -EINVAL;                                          =
                       \
>         }
>
> -       return -EINVAL;
> -}
> +DEF_LWMI_CDXX_GET_DATA(cd01, LENOVO_CAPABILITY_DATA_01, struct capdata01=
);
>  EXPORT_SYMBOL_NS_GPL(lwmi_cd01_get_data, "LENOVO_WMI_CD");
>
>  /**
> @@ -112,10 +149,21 @@ EXPORT_SYMBOL_NS_GPL(lwmi_cd01_get_data, "LENOVO_WM=
I_CD");
>   */
>  static int lwmi_cd_cache(struct lwmi_cd_priv *priv)
>  {
> +       size_t size;
>         int idx;
> +       void *p;
> +
> +       switch (priv->list->type) {
> +       case LENOVO_CAPABILITY_DATA_01:
> +               p =3D &priv->list->cd01[0];
> +               size =3D sizeof(priv->list->cd01[0]);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
>
>         guard(mutex)(&priv->list->list_mutex);
> -       for (idx =3D 0; idx < priv->list->count; idx++) {
> +       for (idx =3D 0; idx < priv->list->count; idx++, p +=3D size) {
>                 union acpi_object *ret_obj __free(kfree) =3D NULL;
>
>                 ret_obj =3D wmidev_block_query(priv->wdev, idx);
> @@ -123,11 +171,10 @@ static int lwmi_cd_cache(struct lwmi_cd_priv *priv)
>                         return -ENODEV;
>
>                 if (ret_obj->type !=3D ACPI_TYPE_BUFFER ||
> -                   ret_obj->buffer.length < sizeof(priv->list->data[idx]=
))
> +                   ret_obj->buffer.length < size)
>                         continue;
>
> -               memcpy(&priv->list->data[idx], ret_obj->buffer.pointer,
> -                      ret_obj->buffer.length);
> +               memcpy(p, ret_obj->buffer.pointer, size);
>         }
>
>         return 0;
> @@ -136,20 +183,28 @@ static int lwmi_cd_cache(struct lwmi_cd_priv *priv)
>  /**
>   * lwmi_cd_alloc() - Allocate a cd_list struct in drvdata
>   * @priv: lenovo-wmi-capdata driver data.
> + * @type: The type of capability data.
>   *
>   * Allocate a cd_list struct large enough to contain data from all WMI d=
ata
>   * blocks provided by the interface.
>   *
>   * Return: 0 on success, or an error.
>   */
> -static int lwmi_cd_alloc(struct lwmi_cd_priv *priv)
> +static int lwmi_cd_alloc(struct lwmi_cd_priv *priv, enum lwmi_cd_type ty=
pe)
>  {
>         struct cd_list *list;
>         size_t list_size;
>         int count, ret;
>
>         count =3D wmidev_instance_count(priv->wdev);
> -       list_size =3D struct_size(list, data, count);
> +
> +       switch (type) {
> +       case LENOVO_CAPABILITY_DATA_01:
> +               list_size =3D struct_size(list, cd01, count);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
>
>         list =3D devm_kzalloc(&priv->wdev->dev, list_size, GFP_KERNEL);
>         if (!list)
> @@ -159,6 +214,7 @@ static int lwmi_cd_alloc(struct lwmi_cd_priv *priv)
>         if (ret)
>                 return ret;
>
> +       list->type =3D type;
>         list->count =3D count;
>         priv->list =3D list;
>
> @@ -168,6 +224,7 @@ static int lwmi_cd_alloc(struct lwmi_cd_priv *priv)
>  /**
>   * lwmi_cd_setup() - Cache all WMI data block information
>   * @priv: lenovo-wmi-capdata driver data.
> + * @type: The type of capability data.
>   *
>   * Allocate a cd_list struct large enough to contain data from all WMI d=
ata
>   * blocks provided by the interface. Then loop through each data block a=
nd
> @@ -175,11 +232,11 @@ static int lwmi_cd_alloc(struct lwmi_cd_priv *priv)
>   *
>   * Return: 0 on success, or an error code.
>   */
> -static int lwmi_cd_setup(struct lwmi_cd_priv *priv)
> +static int lwmi_cd_setup(struct lwmi_cd_priv *priv, enum lwmi_cd_type ty=
pe)
>  {
>         int ret;
>
> -       ret =3D lwmi_cd_alloc(priv);
> +       ret =3D lwmi_cd_alloc(priv, type);
>         if (ret)
>                 return ret;
>
> @@ -235,9 +292,13 @@ static void lwmi_cd01_unregister(void *data)
>
>  static int lwmi_cd_probe(struct wmi_device *wdev, const void *context)
>  {
> +       const struct lwmi_cd_info *info =3D context;
>         struct lwmi_cd_priv *priv;
>         int ret;
>
> +       if (!info)
> +               return -EINVAL;
> +
>         priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
>                 return -ENOMEM;
> @@ -245,21 +306,34 @@ static int lwmi_cd_probe(struct wmi_device *wdev, c=
onst void *context)
>         priv->wdev =3D wdev;
>         dev_set_drvdata(&wdev->dev, priv);
>
> -       ret =3D lwmi_cd_setup(priv);
> +       ret =3D lwmi_cd_setup(priv, info->type);
>         if (ret)
> -               return ret;
> +               goto out;
>
> -       priv->acpi_nb.notifier_call =3D lwmi_cd01_notifier_call;
> +       if (info->type =3D=3D LENOVO_CAPABILITY_DATA_01) {
> +               priv->acpi_nb.notifier_call =3D lwmi_cd01_notifier_call;
>
> -       ret =3D register_acpi_notifier(&priv->acpi_nb);
> -       if (ret)
> -               return ret;
> +               ret =3D register_acpi_notifier(&priv->acpi_nb);
> +               if (ret)
> +                       goto out;
>
> -       ret =3D devm_add_action_or_reset(&wdev->dev, lwmi_cd01_unregister=
, &priv->acpi_nb);
> -       if (ret)
> -               return ret;
> +               ret =3D devm_add_action_or_reset(&wdev->dev, lwmi_cd01_un=
register,
> +                                              &priv->acpi_nb);
> +               if (ret)
> +                       goto out;
> +       }
> +
> +       ret =3D component_add(&wdev->dev, &lwmi_cd_component_ops);
>
> -       return component_add(&wdev->dev, &lwmi_cd_component_ops);
> +out:
> +       if (ret) {
> +               dev_err(&wdev->dev, "failed to register %s: %d\n",
> +                       info->name, ret);
> +       } else {
> +               dev_info(&wdev->dev, "registered %s with %u items\n",
> +                        info->name, priv->list->count);
> +       }
> +       return ret;
>  }
>
>  static void lwmi_cd_remove(struct wmi_device *wdev)
> @@ -267,8 +341,12 @@ static void lwmi_cd_remove(struct wmi_device *wdev)
>         component_del(&wdev->dev, &lwmi_cd_component_ops);
>  }
>
> +#define LWMI_CD_WDEV_ID(_type)                         \
> +       .guid_string =3D _type##_GUID,                    \
> +       .context =3D &lwmi_cd_table[_type]
> +
>  static const struct wmi_device_id lwmi_cd_id_table[] =3D {
> -       { LENOVO_CAPABILITY_DATA_01_GUID, NULL },
> +       { LWMI_CD_WDEV_ID(LENOVO_CAPABILITY_DATA_01) },
>         {}
>  };
>
> @@ -284,21 +362,61 @@ static struct wmi_driver lwmi_cd_driver =3D {
>  };
>
>  /**
> - * lwmi_cd01_match() - Match rule for the master driver.
> - * @dev: Pointer to the capability data 01 parent device.
> - * @data: Unused void pointer for passing match criteria.
> + * lwmi_cd_match() - Match rule for the master driver.
> + * @dev: Pointer to the capability data parent device.
> + * @data: Pointer to capability data type (enum lwmi_cd_type *) to match=
.
>   *
>   * Return: int.
>   */
> -int lwmi_cd01_match(struct device *dev, void *data)
> +static int lwmi_cd_match(struct device *dev, void *type)
> +{
> +       struct lwmi_cd_priv *priv;
> +
> +       if (dev->driver !=3D &lwmi_cd_driver.driver)
> +               return false;
> +
> +       priv =3D dev_get_drvdata(dev);
> +       return priv->list->type =3D=3D *(enum lwmi_cd_type *)type;
> +}
> +
> +/**
> + * lwmi_cd_match_add_all() - Add all match rule for the master driver.
> + * @master: Pointer to the master device.
> + * @matchptr: Pointer to the returned component_match pointer.
> + *
> + * Adds all component matches to the list stored in @matchptr for the @m=
aster
> + * device. @matchptr must be initialized to NULL. This matches all avail=
able
> + * capdata types on the machine.
> + */
> +void lwmi_cd_match_add_all(struct device *master, struct component_match=
 **matchptr)
>  {
> -       return dev->driver =3D=3D &lwmi_cd_driver.driver;
> +       int i;
> +
> +       if (WARN_ON(*matchptr))
> +               return;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(lwmi_cd_table); i++) {
> +               if (!lwmi_cd_table[i].guid_string ||
> +                   !wmi_has_guid(lwmi_cd_table[i].guid_string))
> +                       continue;
> +
> +               component_match_add(master, matchptr, lwmi_cd_match,
> +                                   (void *)&lwmi_cd_table[i].type);
> +               if (IS_ERR(matchptr))
> +                       return;
> +       }
> +
> +       if (!*matchptr) {
> +               pr_warn("a master driver requested capability data, but n=
othing is available\n");
> +               *matchptr =3D ERR_PTR(-ENODEV);
> +       }
>  }
> -EXPORT_SYMBOL_NS_GPL(lwmi_cd01_match, "LENOVO_WMI_CD");
> +EXPORT_SYMBOL_NS_GPL(lwmi_cd_match_add_all, "LENOVO_WMI_CD");
>
>  module_wmi_driver(lwmi_cd_driver);
>
>  MODULE_DEVICE_TABLE(wmi, lwmi_cd_id_table);
>  MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_AUTHOR("Rong Zhang <i@rong.moe>");
>  MODULE_DESCRIPTION("Lenovo Capability Data WMI Driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/lenovo/wmi-capdata.h b/drivers/platform=
/x86/lenovo/wmi-capdata.h
> index 2a4746e38ad43..1e5fce7836cbf 100644
> --- a/drivers/platform/x86/lenovo/wmi-capdata.h
> +++ b/drivers/platform/x86/lenovo/wmi-capdata.h
> @@ -7,6 +7,7 @@
>
>  #include <linux/types.h>
>
> +struct component_match;
>  struct device;
>  struct cd_list;
>
> @@ -19,7 +20,11 @@ struct capdata01 {
>         u32 max_value;
>  };
>
> +struct lwmi_cd_binder {
> +       struct cd_list *cd01_list;
> +};
> +
>  int lwmi_cd01_get_data(struct cd_list *list, u32 attribute_id, struct ca=
pdata01 *output);
> -int lwmi_cd01_match(struct device *dev, void *data);
> +void lwmi_cd_match_add_all(struct device *master, struct component_match=
 **matchptr);
>
>  #endif /* !_LENOVO_WMI_CAPDATA_H_ */
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x=
86/lenovo/wmi-other.c
> index c6dc1b4cff841..20c6ff0be37a1 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -579,14 +579,14 @@ static void lwmi_om_fw_attr_remove(struct lwmi_om_p=
riv *priv)
>  static int lwmi_om_master_bind(struct device *dev)
>  {
>         struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
> -       struct cd_list *tmp_list;
> +       struct lwmi_cd_binder binder =3D { 0 };
>         int ret;
>
> -       ret =3D component_bind_all(dev, &tmp_list);
> +       ret =3D component_bind_all(dev, &binder);
>         if (ret)
>                 return ret;
>
> -       priv->cd01_list =3D tmp_list;
> +       priv->cd01_list =3D binder.cd01_list;
>         if (!priv->cd01_list)
>                 return -ENODEV;
>
> @@ -618,6 +618,7 @@ static int lwmi_other_probe(struct wmi_device *wdev, =
const void *context)
>  {
>         struct component_match *master_match =3D NULL;
>         struct lwmi_om_priv *priv;
> +       int ret;
>
>         priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
>         if (!priv)
> @@ -626,12 +627,26 @@ static int lwmi_other_probe(struct wmi_device *wdev=
, const void *context)
>         priv->wdev =3D wdev;
>         dev_set_drvdata(&wdev->dev, priv);
>
> -       component_match_add(&wdev->dev, &master_match, lwmi_cd01_match, N=
ULL);
> +       lwmi_cd_match_add_all(&wdev->dev, &master_match);
>         if (IS_ERR(master_match))
>                 return PTR_ERR(master_match);
>
> -       return component_master_add_with_match(&wdev->dev, &lwmi_om_maste=
r_ops,
> -                                              master_match);
> +       ret =3D component_master_add_with_match(&wdev->dev, &lwmi_om_mast=
er_ops,
> +                                             master_match);
> +       if (ret)
> +               return ret;
> +
> +       if (likely(component_master_is_bound(&wdev->dev, &lwmi_om_master_=
ops)))
> +               return 0;
> +
> +       /*
> +        * The bind callbacks of both master and components were never ca=
lled in
> +        * this case - this driver won't work at all. Failing...
> +        */
> +       dev_err(&wdev->dev, "unbound master; is any component failing to =
be probed?");
> +
> +       component_master_del(&wdev->dev, &lwmi_om_master_ops);
> +       return -EXDEV;
>  }
>
>  static void lwmi_other_remove(struct wmi_device *wdev)
> --
> 2.51.0
>

After fixing the kernel bot warning, I have no further comments on this one=
.

Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>

Cheers,
- Derek

