Return-Path: <linux-kernel+bounces-870206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BC4C0A2BE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 05:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B90334AD11
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 04:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E64F17BA6;
	Sun, 26 Oct 2025 04:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7PMOEXR"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACC6258ECE
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761454551; cv=none; b=J7aVeNUAvdToFJ/piU1tE/LqjHfK35E6WtWac3XJ+chOXzPJZsm911lU3pz4G+EhjBVD+l8zUkOjvo+WqzpdrzNG9h2sgdi27GChOI5W7+CBc5RVbJc5NzFJWDI9aMrNfwlPQ4FH65kXrtXBlwxdQWeZvTRUpgtW2kMcFi0MJsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761454551; c=relaxed/simple;
	bh=ABYH4V+pRu87+wKNK9R9g/m9KLGynD3ygc6mDpRpy/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIn9/dZMgqM3QeW7qejNOeQyuASv596D6aNFMWTpx5MTKn6U4oICNtJsXaSz2ogJKwJWovVhSXim/EjbR9lWRcH3YHgZndxmPG9vJZWI6+O5pXbp3yPNc28MSabDDCBgxsbbUq6bpWYZUeNo4wCT4aBRQerTLAVH7JTuJLryyNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7PMOEXR; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-78ea15d3489so31000466d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761454548; x=1762059348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgU2jlNzIRT+Gs0Wufj5JnrZE9nnyyOZY0imGkHnrgI=;
        b=I7PMOEXRaeP6gwDE3yExswKiBYqmtr3vYNH1B7svQDs4RdoCfmpVuYJ/jVS72kGAlX
         MbDmff6CjZ9MIvCvxwycD55wUIJtzLQsY4GJznZ8qVgMNoDM0wAW0dBgIYppR4m7PW3r
         Nu7BfRhmY1vt+m+2go5gKv5EQL/FKEo/W4A5edHC9YEpvmm97eY/D1846vIrbk/QP3vI
         W9p5Yze/8t7U+X7vJDN+vw2xgnotcM719G01iZYEkE0H6/6ajAx1rVpOlJeQUJLtdEDS
         RHLk6O7NK20PK2YWzTTdu0FhQhqFZPS75H4W8g+pvZgZ3yBvsAj6crzU1LN3HyCWvshL
         yW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761454548; x=1762059348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgU2jlNzIRT+Gs0Wufj5JnrZE9nnyyOZY0imGkHnrgI=;
        b=XRw2yiNnF6NgvQnzdrZe0bQ7wRq/h/pLM+V00IpIoQvc+1m06jtli/9RWHuzO//TLS
         6rCT+WXLxSLUkWwNct0+jQCc+dELWE02v/0xy+CA0xoAnzljP42qY3UQaad6RX//sv9p
         PMhOAldSkJM74kxqXm2lf7XpTyedVXL9IrGXM+iBOguJpAUczXujx1/os8RMUClQ28h0
         oW16ZTezcZZ0Ne9bUt2/GOuaR/9qbDEcLrCMBVfMY89s0O1QIJi7ftKNcMjq6wb0JIgV
         RUYwueKOTCIj5cV5aYqkw8UrxpU64QhX4/MAW+4jc5FaHs7Qp3eVbai8jdhK/GYgvXGs
         RJPw==
X-Forwarded-Encrypted: i=1; AJvYcCWvoINJr0UO9IeAGcExP3M0pgkQzMpyZJNcH07I+DOfMWhTHIZTTC+JdJJe6bXzSk6UBUwmOfMfQ95WHOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUGZN/fbUsbVaEsuebtMpD0Hl3QaJzmV8Ls5+jTNDh437rM3xu
	t09v9gqRq97rzyBP1sFZ+IRiyeFz6lpecPHGqQtKVQ3Z9mMnFylbWZlfu1ymp7j+Hgvd2iE2Lj3
	JdNIZJVh66CxdjPkxXDq0EJIPaits5VI=
X-Gm-Gg: ASbGncvND7L3TWolbSjC+LeSVepxgbYYHWxPtaUfZEtieeVmCX5jTReinoJ/+FowFKH
	6AWP8sw8zFJrH8oQi6oiBYXineE8oGNtz/WhoQOGWU9marmFn+VjlZupd4RHTcowLm7ZwhQ68QZ
	2yZdPVA4azWKpDNiQdVup0cBFRZDqm91mzlRlUy5jctaHwgPJVFIYEFpBciX+0rkyi6APQae8Pb
	FB9maNFLInH72XaWTIyc6BPFschB7Zpz2DXk8cIjE5DfKi3gmeSwUsnVfEzrrl2ibX+sfcP
X-Google-Smtp-Source: AGHT+IGNdbbIW5Y4wifswNmspmg9VMlv68g0YdMBe6cDt/hhtuqAEJjANxFJ8pxMPtLK9p5JasumB40TZptvnTTCFjs=
X-Received: by 2002:a05:6214:262d:b0:87d:cb8d:2a8a with SMTP id
 6a1803df08f44-87dcb8d3223mr338355326d6.21.1761454547636; Sat, 25 Oct 2025
 21:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019210450.88830-1-i@rong.moe> <20251019210450.88830-4-i@rong.moe>
In-Reply-To: <20251019210450.88830-4-i@rong.moe>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Sat, 25 Oct 2025 21:55:36 -0700
X-Gm-Features: AWmQ_blorlCWqUh9Ix9FfXfBqLoJMJJkhFqXYbIp_x2-MJkysBYS4xkunmDWwhE
Message-ID: <CAFqHKT=bMLHvkcohaSNSUqxSkeFg_7aZxMVpBSbWqtsOeuT7rg@mail.gmail.com>
Subject: Re: [PATCH 3/6] platform/x86: lenovo-wmi-capdata: Add support for
 Capability Data 00
To: Rong Zhang <i@rong.moe>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Guenter Roeck <linux@roeck-us.net>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 2:05=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
>
> Add support for LENOVO_CAPABILITY_DATA_00 WMI data block that comes on
> "Other Mode" enabled hardware. Provides an interface for querying if a
> given attribute is supported by the hardware, as well as its default
> value.
>
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  .../wmi/devices/lenovo-wmi-other.rst          |  8 +++++++
>  drivers/platform/x86/lenovo/wmi-capdata.c     | 23 ++++++++++++++++++-
>  drivers/platform/x86/lenovo/wmi-capdata.h     |  8 +++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/wmi/devices/lenovo-wmi-other.rst b/Documentati=
on/wmi/devices/lenovo-wmi-other.rst
> index d7928b8dfb4b5..adbd7943c6756 100644
> --- a/Documentation/wmi/devices/lenovo-wmi-other.rst
> +++ b/Documentation/wmi/devices/lenovo-wmi-other.rst
> @@ -31,6 +31,14 @@ under the following path:
>
>    /sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribute>=
/
>
> +LENOVO_CAPABILITY_DATA_00
> +-------------------------
> +
> +WMI GUID ``362A3AFE-3D96-4665-8530-96DAD5BB300E``
> +
> +The LENOVO-CAPABILITD_DATA_00 interface provides information on whether =
the
> +device supports querying or setting fan speed.
> +

There is a lot more data provided by this interface that hasn't been
implemented yet. To avoid having to touch this too often I'd prefer if
it were formatted similarly to the 01 interface where the opening
paragraph is generic for the interface and the specific features that
have been implemented in the driver are listed below that. From
documentation, the 00 interface seems to deal with enabling or
disabling  various hardware features that don't rely on the gamezone
thermal mode. I'd also be okay with specifying in the change that 01
features do rely on the gamezone thermal mode.

>  LENOVO_CAPABILITY_DATA_01
>  -------------------------
>
> diff --git a/drivers/platform/x86/lenovo/wmi-capdata.c b/drivers/platform=
/x86/lenovo/wmi-capdata.c
> index 14175fe19247e..6927de409b09d 100644
> --- a/drivers/platform/x86/lenovo/wmi-capdata.c
> +++ b/drivers/platform/x86/lenovo/wmi-capdata.c
> @@ -5,6 +5,9 @@
>   * Lenovo Capability Data provides information on tunable attributes use=
d by
>   * the "Other Mode" WMI interface.
>   *
> + * Capability Data 00 includes if the attribute is supported by the hard=
ware,
> + * and the default_value. All attributes are independent of thermal mode=
s.
> + *
>   * Capability Data 01 includes if the attribute is supported by the hard=
ware,
>   * and the default_value, max_value, min_value, and step increment. Each
>   * attribute has multiple pages, one for each of the thermal modes manag=
ed by
> @@ -14,7 +17,7 @@
>   *   - Initial implementation (formerly named lenovo-wmi-capdata01)
>   *
>   * Copyright (C) 2025 Rong Zhang <i@rong.moe>
> - *   - Unified implementation
> + *   - Unified implementation for Capability Data 00 and 01
>   */

This might be a bit verbose considering the changes are all part of
the same series.

Thanks,
Derek
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -36,12 +39,14 @@
>
>  #include "wmi-capdata.h"
>
> +#define LENOVO_CAPABILITY_DATA_00_GUID "362A3AFE-3D96-4665-8530-96DAD5BB=
300E"
>  #define LENOVO_CAPABILITY_DATA_01_GUID "7A8F5407-CB67-4D6E-B547-39B3BE01=
8154"
>
>  #define ACPI_AC_CLASS "ac_adapter"
>  #define ACPI_AC_NOTIFY_STATUS 0x80
>
>  enum lwmi_cd_type {
> +       LENOVO_CAPABILITY_DATA_00,
>         LENOVO_CAPABILITY_DATA_01,
>  };
>
> @@ -57,6 +62,7 @@ static const struct lwmi_cd_info {
>         const char *name;
>         enum lwmi_cd_type type;
>  } lwmi_cd_table[] =3D {
> +       LWMI_CD_TABLE_ITEM(LENOVO_CAPABILITY_DATA_00),
>         LWMI_CD_TABLE_ITEM(LENOVO_CAPABILITY_DATA_01),
>  };
>
> @@ -72,6 +78,7 @@ struct cd_list {
>         u8 count;
>
>         union {
> +               DECLARE_FLEX_ARRAY(struct capdata00, cd00);
>                 DECLARE_FLEX_ARRAY(struct capdata01, cd01);
>         };
>  };
> @@ -95,6 +102,9 @@ static int lwmi_cd_component_bind(struct device *cd_de=
v,
>         struct lwmi_cd_binder *binder =3D data;
>
>         switch (priv->list->type) {
> +       case LENOVO_CAPABILITY_DATA_00:
> +               binder->cd00_list =3D priv->list;
> +               break;
>         case LENOVO_CAPABILITY_DATA_01:
>                 binder->cd01_list =3D priv->list;
>                 break;
> @@ -136,6 +146,9 @@ static const struct component_ops lwmi_cd_component_o=
ps =3D {
>                 return -EINVAL;                                          =
                       \
>         }
>
> +DEF_LWMI_CDXX_GET_DATA(cd00, LENOVO_CAPABILITY_DATA_00, struct capdata00=
);
> +EXPORT_SYMBOL_NS_GPL(lwmi_cd00_get_data, "LENOVO_WMI_CD");
> +
>  DEF_LWMI_CDXX_GET_DATA(cd01, LENOVO_CAPABILITY_DATA_01, struct capdata01=
);
>  EXPORT_SYMBOL_NS_GPL(lwmi_cd01_get_data, "LENOVO_WMI_CD");
>
> @@ -154,6 +167,10 @@ static int lwmi_cd_cache(struct lwmi_cd_priv *priv)
>         void *p;
>
>         switch (priv->list->type) {
> +       case LENOVO_CAPABILITY_DATA_00:
> +               p =3D &priv->list->cd00[0];
> +               size =3D sizeof(priv->list->cd00[0]);
> +               break;
>         case LENOVO_CAPABILITY_DATA_01:
>                 p =3D &priv->list->cd01[0];
>                 size =3D sizeof(priv->list->cd01[0]);
> @@ -199,6 +216,9 @@ static int lwmi_cd_alloc(struct lwmi_cd_priv *priv, e=
num lwmi_cd_type type)
>         count =3D wmidev_instance_count(priv->wdev);
>
>         switch (type) {
> +       case LENOVO_CAPABILITY_DATA_00:
> +               list_size =3D struct_size(list, cd00, count);
> +               break;
>         case LENOVO_CAPABILITY_DATA_01:
>                 list_size =3D struct_size(list, cd01, count);
>                 break;
> @@ -346,6 +366,7 @@ static void lwmi_cd_remove(struct wmi_device *wdev)
>         .context =3D &lwmi_cd_table[_type]
>
>  static const struct wmi_device_id lwmi_cd_id_table[] =3D {
> +       { LWMI_CD_WDEV_ID(LENOVO_CAPABILITY_DATA_00) },
>         { LWMI_CD_WDEV_ID(LENOVO_CAPABILITY_DATA_01) },
>         {}
>  };
> diff --git a/drivers/platform/x86/lenovo/wmi-capdata.h b/drivers/platform=
/x86/lenovo/wmi-capdata.h
> index 1e5fce7836cbf..a6f0cb006e745 100644
> --- a/drivers/platform/x86/lenovo/wmi-capdata.h
> +++ b/drivers/platform/x86/lenovo/wmi-capdata.h
> @@ -11,6 +11,12 @@ struct component_match;
>  struct device;
>  struct cd_list;
>
> +struct capdata00 {
> +       u32 id;
> +       u32 supported;
> +       u32 default_value;
> +};
> +
>  struct capdata01 {
>         u32 id;
>         u32 supported;
> @@ -21,9 +27,11 @@ struct capdata01 {
>  };
>
>  struct lwmi_cd_binder {
> +       struct cd_list *cd00_list;
>         struct cd_list *cd01_list;
>  };
>
> +int lwmi_cd00_get_data(struct cd_list *list, u32 attribute_id, struct ca=
pdata00 *output);
>  int lwmi_cd01_get_data(struct cd_list *list, u32 attribute_id, struct ca=
pdata01 *output);
>  void lwmi_cd_match_add_all(struct device *master, struct component_match=
 **matchptr);
>
> --
> 2.51.0
>

