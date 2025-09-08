Return-Path: <linux-kernel+bounces-806106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E384B491F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E086162B92
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DA31FBCA1;
	Mon,  8 Sep 2025 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ8YA2Ik"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0FA30BB9D;
	Mon,  8 Sep 2025 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757342713; cv=none; b=HAx4Fg8r3jO9JX6PaNbMqZ+4Bo17o07G1NE7Q2ZShX80DuViyfllYZHxgKkhTaG6vMeizSq8RL940MGnm6dfJ3Vvawh6fkaYiUBKxPjlxtN6LtdEKUbcirM7SSCwl1dBUvveaP7XV6gOZj6Q/AFuulBS6Zx41+mazkOF2Si9mbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757342713; c=relaxed/simple;
	bh=wI6SpAffNdI2VJI2r6W6mIMJ6ctpCyKFmqkR9gg+2vE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUjays6jTREqnutoN6MpVSuSTXHln9zYpI41t4JKgUuB7EfCKDuWQgKmhqYmVRlJ++NkkuaydIMivKp2AnUvFhywIUVshw5PXHHmw7rzP5tFmn+hXU5DsonlIrZoHP9AhYXLxz5HhHRN5Uwhc0yL5Ttbm3CasPOwNU+ssCkng7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ8YA2Ik; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so27313405e9.0;
        Mon, 08 Sep 2025 07:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757342710; x=1757947510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NBXXUhb2BmggesthHwWGiC3WVEvKONX11k5/N5kirYY=;
        b=bZ8YA2Ika+MnXYrOCH4aZlRQg+EpYm6P2bvr8QP6uz0GFI63HYNS14UJsGhDRnKVQ/
         OuEWv9d34SbSIVhaD5dPuz03mylfJQIFwiWrColJQepimqie1/jiCZ0AONrA0vePg3dG
         LwUwlOgYgEmgSHLeJHUVAKBA0Y4E+XxzP2MW3iVgJSEuODWRNZeoNGfXieWhLUJfOB9y
         HXvjbBP3IDjbRf1Z3N3fvIjCsmb7gztc+z8SBonFQdSS4d11VQk/yjdXIwTVhJpaONFL
         Hj9shD2S8HeFXFsjXbPBzmW0rig6juLbOBNLtCArnnu6koRp1gUShuH6+tOZxQlFth9w
         He1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757342710; x=1757947510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBXXUhb2BmggesthHwWGiC3WVEvKONX11k5/N5kirYY=;
        b=Gp0UXOpSxsfZ4X4RLYJDHK8QzJdHxWvOD3M9YpyFzo8UFRmosVpZ61RRkQnKlz/qIg
         o2DMuseouvxnoAVQXaz5JgOzSwyqmoDPYKcgn5tLRLNMVLGCP/W0e9PnhZqArqlbmAtV
         Q2Zd1RE/2ifgBkKhJaM2/PwY+GndrPTBiCKaeGYs6RzuuMkKi0uUTkX+t5fZB1WoVX0Y
         9L9VJkg2UHdirBV8DjwEwyvnMOq5tePb2innigLU8LWVJQ9WBft2cswLZpLcpRNYIkDL
         uCQ9IVWVhSmiJtgIbahKJMXBGI1qF99kVEaRHEgWUMTpFY563RKDyQVLvirsSZONYlyn
         K14w==
X-Forwarded-Encrypted: i=1; AJvYcCUQgPyYO9J6rtYiAGLd7B2JNhCIJhMGVCtvmt9QoJ+JC4lb20Ax3W6CGTtw3bCH+ijufiJIgSfwA9Yt/gHo@vger.kernel.org, AJvYcCUyzlRHbuKe9sVOse97A37vo+db6mrGihcA1sBv8w7IpXoThbEjxM15TiCv7Vh/s45WhMZBK5u9gHMo@vger.kernel.org
X-Gm-Message-State: AOJu0YxBWuNMAbFb5BWXap+MPhgxOiTiFuTkoAyQkjbsfhqOVvFZuvsT
	AGdurklQVDBFmHHjIWAeU+25hKxBi3JfxzpEDsW3LkYkDNaOxnZsAUGB
X-Gm-Gg: ASbGncsdYS5dpeyaTK2xSeo+ztaluuO9GCLN7WJTAi1UOvJKUV8L0bgImX5wExgjfVE
	mQCH9sSqNrbC4qx4LjgonWvAbpifkrpVj8F6F/p/aXyNWwhOvyBfuxh8yUAfpDdJab4zUeCHeI1
	6ZBhWG+yCy5BexXSSVZ+mcMWtRvqZI7rrO7jH4tAdFv9juju3TEsU0y93R47V+92o4LvK3fkVD1
	c6XKZ+q0GipMUaL6fjLh/jwfAL14MGNh96YzRmsFfryQUtwErFjXLgXnsxllvFgkZYVaKh1YmoG
	DHrbznNTEi4LDL7F69qcDZzbIyZUxBzvm7L8ajpyIU81s6I9i1+p9NxMDM3MiQ/lFBIJjN8tY2Z
	QdQQowgx9Pz8uMD6wOsGNlLfVcksCBkb4iCCaqySGO08sLMZiHZzm95Hdx0uqlrS7Wzs2j7HyAm
	o=
X-Google-Smtp-Source: AGHT+IHoH/kzU+cENxZgae4niFxHNIBgU2yBvIXmO8kprk/rkDniF9PtdgAaS1TlIlleNmcUNrw0ug==
X-Received: by 2002:a05:600c:5249:b0:45d:d68c:2a43 with SMTP id 5b1f17b1804b1-45de3c66dd3mr52823045e9.33.1757342709588;
        Mon, 08 Sep 2025 07:45:09 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45ddb779eb6sm130993655e9.8.2025.09.08.07.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 07:45:09 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, wens@csie.org,
 samuel@sholland.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: Re: [PATCH] arm64: dts: allwiner: h5: OrangePi PC2: add ethernet LEDs
Date: Mon, 08 Sep 2025 16:45:07 +0200
Message-ID: <2012341.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <20250818163520.1004528-1-olek2@wp.pl>
References: <20250818163520.1004528-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne ponedeljek, 18. avgust 2025 ob 18:35:13 Srednjeevropski poletni =C4=8Da=
s je Aleksander Jan Bajkowski napisal(a):
> This patch adds support for Ethernet LEDs.

How did you tested this? According to linux-sunxi wiki, this board has
RTL8211E, while LED control is supported only with RTL8211F driver.

>=20
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/a=
rch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> index 0f29da7d51e6..7688f565ec9b 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> @@ -7,6 +7,7 @@
> =20
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/leds/common.h>
>  #include <dt-bindings/pinctrl/sun4i-a10.h>
> =20
>  / {
> @@ -132,6 +133,25 @@ &external_mdio {
>  	ext_rgmii_phy: ethernet-phy@1 {
>  		compatible =3D "ethernet-phy-ieee802.3-c22";
>  		reg =3D <1>;
> +
> +		leds {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			led@0 {
> +				reg =3D <0>;
> +				color =3D <LED_COLOR_ID_GREEN>;
> +				function =3D LED_FUNCTION_LAN;
> +				linux,default-trigger =3D "netdev";
> +			};
> +
> +			led@1 {
> +				reg =3D <1>;
> +				color =3D <LED_COLOR_ID_AMBER>;
> +				function =3D LED_FUNCTION_LAN;
> +				linux,default-trigger =3D "netdev";
> +			};

Schematic says LED0 is "Yellow" or Amber in this DT. So LED1 should be gree=
n.

Also, I'm not sure if trigger really needs to be added, since PHY network
will set it as such.

Best regards,
Jernej

> +		};
>  	};
>  };
> =20
>=20





