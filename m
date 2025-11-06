Return-Path: <linux-kernel+bounces-889240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 375B5C3D0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 19:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D27DC4E1DB4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 18:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC2234E741;
	Thu,  6 Nov 2025 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EsYWlP1A"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD734DCE9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453118; cv=none; b=WDVhS6lN+/poCm/M3EYWRPv32TGBKubHZDlCnWNi7Z6zYRJFB4pcApj5UOsh16lx5CmVf0C4WEIlQlI8sHR5uhIvt2ONSEfAr9zg4/JYO/2Fux1b5QUfduoCAFdMcTi0tcK71OKmalumuLLjekvDYnAS333HzQ+bHuZIN+ppwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453118; c=relaxed/simple;
	bh=oMS8T+OT/9Nui4b46aIksLQJ0N9ZjMFuDvzZmhiJqww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3LVRt/fa6zuax9RCoF69ItInWGcWwokQxraW+qM8n9enpFZBIathFGpGx0HKJ6wIbFMBREAMleyxhNEm7ZVbaM9x7gTduDESa4cizODZV2wiM38F61DckFQzG6/TuyVdhIepWKmA02Yxcl/3vH2OwgKeq4d4SwSdiKCds5cQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EsYWlP1A; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6409e985505so2084664a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 10:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762453115; x=1763057915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FN9+63BCY6a91Sh11P8wg56sTIKFRq6Ev4z9/iG60s=;
        b=EsYWlP1ADJyWJPFJt8M1pGT5r7dFof4P7To9cSsuwzhEt2ALxkPkUrN63ZeXMIOXs1
         Pvy5q9FeRTMhGbGov7O2U6XLQT5ZlY0G5RvtiIiSY8vMsLL0Sv9QTfr4NHwszUCiXs+t
         VRjQXFXylzOjljIjiiL8cp/bY1l4meidbZoS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762453115; x=1763057915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0FN9+63BCY6a91Sh11P8wg56sTIKFRq6Ev4z9/iG60s=;
        b=GPa0VFjBTrnyP6yBkBGTA9JlqvpzOF4wkMxJPqYLRwHDxkmCiORQQKCLJKYeQXPpsG
         +sRTXeSrsXFUrOPdJRfh4wBPUeeppjdFzxPK/jD/uFXhF68BQnpO+uVqsnTTrJCc2tTY
         vmuY0bhwdgEVFACwnEnfI/eoqYIwqOHDqsUjsxJiEOcxVTESmgaqPF4XsNyPVhi2pa/G
         /qb+Xg+44nfTS7L1mJ6hz/Ojzuj6+INVClX+9EpNG4j+qaBNy3qfmviPpWZ9C2kAnju6
         J1MuN+Un25WH4aSKZZzxEv+TDQcFyJODKdZwQBYvuvJ3UmF+fOo4Ip6aANR93mxfEGFY
         RpHA==
X-Forwarded-Encrypted: i=1; AJvYcCU2uNNQRTyRwZytp17SnSDJxMxBMab5feQ0+PlMVMu5TlF/oTq8S4LFeEJqihPi0X+M6pMfE5LJfS17V3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzikRqnNjI9vlX+YM3SXNqXIA/ZPRTyjfmuoWy+poGQoPBez8zL
	Y0cQsefvBh3fc3ffz2sLagXF854mFoEWCfqPi0MUEjM6rKz3CCGxLdBOAz26tmkSGVLmWCicnV3
	IxWCu/km03bHqMTs3Vvoeik8GyUP/L01jt+vqBp/5
X-Gm-Gg: ASbGncvA2xzwbLekbC9IWeUJzK5sWuYsuyaQz8c0JrQ5r4uD6JSzbALImlGAJ9phc+k
	AW8YbOrIaAs0kJQqdT81zF90XUg5NlL4vYvOIkNtiTzKyOilCRd+JPX4sI8pOhPGjQE4QdnSWol
	in5jGqu3pKHKYgJgg03zsw+mGRZ+xZs5jB/ZTBogUNs2KZU8DGsZWlbRcvlIXtKfqVekEnaF9l/
	bU1KE6eLMzl9NbggpxrRmNoETKcSGVugwpqc95td6px8uaf1BQCQ/LEQZsNCkfK3O0sOCeJYtw3
	KGk=
X-Google-Smtp-Source: AGHT+IEP/nwzlykeSLaebiXJLfmr7cwOpqfsasygiy3POXKTjyaWp0Ppxd+0Gxo3zqPuZbdRPhQDcPYGjLKAO0sPWyQ=
X-Received: by 2002:a17:907:3c91:b0:b33:b8bc:d1da with SMTP id
 a640c23a62f3a-b72c08e023emr12144066b.1.1762453115425; Thu, 06 Nov 2025
 10:18:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013203331.398517-1-jthies@google.com> <20251013203331.398517-4-jthies@google.com>
In-Reply-To: <20251013203331.398517-4-jthies@google.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Thu, 6 Nov 2025 10:18:22 -0800
X-Gm-Features: AWmQ_blOKtSWKrioiTuTVnOpd2P7YQAJP4q98Q_uCp-RggagsBRvuHIuk3LHNVM
Message-ID: <CANFp7mV0FjZ-4OB8uMeVfyQn_BAMhnhYs-w+ABzupoiiywN1Gg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mfd: cros_ec: Don't add cros_ec_ucsi if it is
 defined in OF or ACPI
To: Jameson Thies <jthies@google.com>
Cc: dmitry.baryshkov@oss.qualcomm.com, akuchynski@chromium.org, 
	krzk+dt@kernel.org, robh@kernel.org, bleung@chromium.org, 
	heikki.krogerus@linux.intel.com, ukaszb@chromium.org, tzungbi@kernel.org, 
	devicetree@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 1:34=E2=80=AFPM Jameson Thies <jthies@google.com> w=
rote:
>
> On devices with a UCSI PPM in the EC, check for cros_ec_ucsi to be
> defined in the OF device tree or an ACPI node. If it is defined by
> either OF or ACPI, it does not need to be added as a subdevice of
> cros_ec_dev mfd. cros_ec_ucsi will load from the OF or ACPI node.
>
> Signed-off-by: Jameson Thies <jthies@google.com>
> Reviewed-by: Benson Leung <bleung@chromium.org>
> ---
>  drivers/mfd/cros_ec_dev.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index dc80a272726b..1928c2ea2b8f 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2014 Google, Inc.
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/dmi.h>
>  #include <linux/kconfig.h>
>  #include <linux/mfd/core.h>
> @@ -131,11 +132,6 @@ static const struct cros_feature_to_cells cros_subde=
vices[] =3D {
>                 .mfd_cells      =3D cros_ec_rtc_cells,
>                 .num_cells      =3D ARRAY_SIZE(cros_ec_rtc_cells),
>         },
> -       {
> -               .id             =3D EC_FEATURE_UCSI_PPM,
> -               .mfd_cells      =3D cros_ec_ucsi_cells,
> -               .num_cells      =3D ARRAY_SIZE(cros_ec_ucsi_cells),
> -       },
>         {
>                 .id             =3D EC_FEATURE_HANG_DETECT,
>                 .mfd_cells      =3D cros_ec_wdt_cells,
> @@ -264,6 +260,23 @@ static int ec_device_probe(struct platform_device *p=
dev)
>                 }
>         }
>
> +       /*
> +        * FW nodes can load cros_ec_ucsi, but early PDC devices did not =
define
> +        * the required nodes. On PDC systems without FW nodes for cros_e=
c_ucsi,
> +        * the driver should be added as an mfd subdevice.
> +        */
> +       if (cros_ec_check_features(ec, EC_FEATURE_USB_PD) &&
> +           cros_ec_check_features(ec, EC_FEATURE_UCSI_PPM) &&
> +           !acpi_dev_found("GOOG0021") &&
> +           !of_find_compatible_node(NULL, NULL, "google,cros-ec-ucsi")) =
{
> +               retval =3D mfd_add_hotplug_devices(ec->dev,
> +                                                cros_ec_ucsi_cells,
> +                                                ARRAY_SIZE(cros_ec_ucsi_=
cells));
> +
> +               if (retval)
> +                       dev_warn(ec->dev, "failed to add cros_ec_ucsi: %d=
\n", retval);
> +       }
> +
>         /*
>          * UCSI provides power supply information so we don't need to sep=
arately
>          * load the cros_usbpd_charger driver.
> --
> 2.51.0.858.gf9c4a03a3a-goog
>

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

