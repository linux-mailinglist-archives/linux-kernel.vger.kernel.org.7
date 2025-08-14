Return-Path: <linux-kernel+bounces-768842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B3EB26631
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDFA188E1D0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DA22E7BD0;
	Thu, 14 Aug 2025 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="facQrNiu"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429F12E7BBC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176685; cv=none; b=Uv2WzaOdKyVbgzfffYB8g+ZWyE0QM2kAYDnCAjeyhjPDn35GDGE73+IybK10NSJTSaUm59MJ55YkF+coMMsNYgfuREoj0CJrnFnxD6jEZ4v6rBirvcfAp/BsQXnK53cbCFQTn93FVzC9GPQHOixz0ymieXyA66d1+iDwMaAPYpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176685; c=relaxed/simple;
	bh=HFDxZg4Ai0fLc5oa764XhDADIuqJqKaI0ThaTfnnsq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d6trwGceLwrAwJWvMzGxsHG1JgAsEhFH0EztDoje7yRkBQz/Xjw7jD6QR49kK93Jn1kfOYdzqQ4iAhRQhBVZERGKBjVzTvqtzK/Y5V4zPpkwTXrmnUTLWWPslOvnGQdVfumKeiTm0+cmyMRn/Hvl3UNsGf2kdnejCWQgFn4YGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=facQrNiu; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 200B7C6CC2;
	Thu, 14 Aug 2025 16:04:39 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id B1A88C6CF0;
	Thu, 14 Aug 2025 16:04:38 +0300 (EEST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 3B7931FEE86;
	Thu, 14 Aug 2025 16:04:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1755176678;
	bh=OCsw0oZ0W2d0AO6GjXss/Dd178wHIudozYsf+Py3vm0=;
	h=Received:From:Subject:To;
	b=facQrNiuhRgJrsKQ4LHxX00eGp+imQSAOpadU4sVVQGoXfWtyTEOYdbGkqFTvGkJ7
	 vEBrddtBwsbeEHY0P6AQ0GuB+zdud+0u1wp1dRUkv4rEfq+myPY67H+NV2ccODVR+h
	 0fDQhvfz9I9C06P4P1YMdosrhiDSKTRIYPkEHSoqBR/sQWLth7evGQpNE1Pxb9z7fB
	 xMqAbadwnxR8RNJTRXII1W+v6jkb9SnCgGj3z+qOMq91BcVW8klAmvG7clXWhViwQu
	 Dh7+HJNd5sytxeabfkThIMSCoUn3VLkWtWxzA0At9gk8c+YxMw7P2DrDpKuQ12LvCg
	 2DGinvbVw05xA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f176.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f176.google.com with SMTP id
 38308e7fff4ca-333f8db5aedso6362631fa.0;
        Thu, 14 Aug 2025 06:04:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YzYtrY8+fOvxDWCKN5oMx2kSGdLmE+0unDEAqFDpZvPy7IejEv2
	MNH4BXXeLVxO35DHNt4p5CiO3fUES5V9ZLpZCz4Ns1JfdQ6/vmS+u0uqU9BwEuFPIjA+5sy55ZP
	GID3sjlKp9aV7Sg3Bfh8hogGXBjPCNv4=
X-Google-Smtp-Source: 
 AGHT+IGKpSGK+fFt/PdNsfeUMl9C4ZFHiiZMUvW898JeMGpkN/ONfAUUVi3lCBy7Hx20OYjAl4DVwAAQmfyO9sxyZtA=
X-Received: by 2002:a05:651c:200b:b0:332:6b5e:b1a0 with SMTP id
 38308e7fff4ca-333fa7b74abmr4706711fa.22.1755176677677; Thu, 14 Aug 2025
 06:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814130151.8276-1-lkml@antheas.dev>
In-Reply-To: <20250814130151.8276-1-lkml@antheas.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Thu, 14 Aug 2025 15:04:25 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEJyTt_5yri5zj3W1VURNUJr=HQzPOf1dP619NVtEL-pA@mail.gmail.com>
X-Gm-Features: Ac12FXyI8B1pot5-sRluuiI9brQSaRo2USB5z_bcYnmhm-3Zy6LtJ2DUDCSsMYM
Message-ID: 
 <CAGwozwEJyTt_5yri5zj3W1VURNUJr=HQzPOf1dP619NVtEL-pA@mail.gmail.com>
Subject: Re: [PATCH v1] HID: Asus: add Z13 folio to generic group for
 multitouch to work
To: inux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>, "Luke D . Jones" <luke@ljones.dev>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175517667844.1712834.3153843287919842899@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

I will slowly start breaking up the Asus WMI series I sent earlier in
the year so it can slowly start going through.

This quirk can merge to stable too, so I will start with it first. I
am compile testing it for 6.17rc1 atm if there are any issues I will
report back.

Antheas

On Thu, 14 Aug 2025 at 15:02, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> The Asus Z13 folio has a multitouch touchpad that needs to bind
> to the hid-multitouch driver in order to work properly. So bind
> it to the HID_GROUP_GENERIC group to release the touchpad and
> move it to the bottom so that the comment applies to it.
>
> While at it, change the generic KEYBOARD3 name to Z13_FOLIO.
>
> Reviewed-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/hid/hid-asus.c | 6 +++---
>  drivers/hid/hid-ids.h  | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 4b45e31f0bab..10b2f9ff78a3 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1378,9 +1378,6 @@ static const struct hid_device_id asus_devices[] = {
>         { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>             USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
>           QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
> -       { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
> -           USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD3),
> -         QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
>         { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>             USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
>           QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
> @@ -1410,6 +1407,9 @@ static const struct hid_device_id asus_devices[] = {
>          * Note bind to the HID_GROUP_GENERIC group, so that we only bind to the keyboard
>          * part, while letting hid-multitouch.c handle the touchpad.
>          */
> +       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> +               USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_Z13_FOLIO),
> +         QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
>         { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>                 USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD) },
>         { }
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 5a1096283855..cff7d95c8d59 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -223,7 +223,7 @@
>  #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3 0x1822
>  #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD        0x1866
>  #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2       0x19b6
> -#define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD3       0x1a30
> +#define USB_DEVICE_ID_ASUSTEK_ROG_Z13_FOLIO            0x1a30
>  #define USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR         0x18c6
>  #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY            0x1abe
>  #define USB_DEVICE_ID_ASUSTEK_ROG_NKEY_ALLY_X          0x1b4c
>
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> --
> 2.50.1
>
>


