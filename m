Return-Path: <linux-kernel+bounces-804771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A74B47CCF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 20:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D9E3BB2A7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AFF284883;
	Sun,  7 Sep 2025 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zDO93rbG"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399861F09B6
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757269402; cv=none; b=Sa/8U4OsciSTMg10Cc/7botnCUv4aIoAhGyxRWy7006uXJGhNcdYIWSlclF1tkQi6Wpupp//INBDC4GDYjFbB0TS0PAgHd8cZpapiarLI7Qb/r5Mrs3SmMS4d39J2DXDwAt7MI+S35coytFYIjJZI8u2nt06eiLgVKsnKTIdVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757269402; c=relaxed/simple;
	bh=cbEZMS74rpq6el/gYUc5kypR1LCfQts0/E65eFZ95L0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ohfcNqIsPbFm9f8M31FZrZIeF0F8S1gEmevssyFquAQv147xT+ejbzVvXY7rJAaLl/EnvR8H7ZwdRvL38v7DtbVZOdGmFacHTf8nPTb+sOe82JO2ZMmZeUY8TvHos10oGaeDb4ZH1+l+p7QnByTsx536FUlw8l7W5X581g0pwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zDO93rbG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b627ea685so27642065e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 11:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757269397; x=1757874197; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJFVpcWLs8hzJhZRxA8jQtAdYhxmsHzd/bzdk6pJg5A=;
        b=zDO93rbG8U/YUOqALpbisoM4dai2xARsZfIFlcYaAHKrTF1AM5vk7w8n1l+X0IzupL
         FpnFUHDW/EUSAbkXmpAGUyfnVaWYtXVVZdhr8jMWv6VMojCyhr+fqYE3T3GOaGzwDiSk
         yVnnUMB+WCyc77F8vswJ7RI7E9BWWloN2Vag18obFFML6v8H7R+iY68ZlkTDBe+eunHD
         R2DLHsjRgpCa/Az1c1/S9eYLJBR+SfGE8N8OlRyhAFDcxzer7SicISKjNk7mljPq00vy
         mmNZYj0k10F5T7GZ8acgiW5d5YPJzmGwvddSTjZsRPbpl8zXA7fJwNnCjnl4JAWV2QkK
         L3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757269397; x=1757874197;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJFVpcWLs8hzJhZRxA8jQtAdYhxmsHzd/bzdk6pJg5A=;
        b=ijBBWhmWtgWQmaQNUHl0Lkx8A4m1XIlcY7kv7fehw0BlUlc5XrHEvk6xOaB1AcHFG1
         9ZES4ExehPE5h/01d9lOBdojhQTZEb9ogL0z/K3F41ruaiHavPsY06X0Ir2GfBPBtRRe
         gs5Q/3snAGk7yhPjg6joE5rqupzUDtrM+02cEtxskW35K1OJJXpLZLfHEeV6D8RSHrgj
         C9Fi7yQ9XBJPBxJeU5q6VLNbdYhbIeNHLKObXybkAj7twtmZ54aYGrsmshbZuUciofxa
         z2jaq88G+jFfpXW9N/IrgumbgxuiIewyhR6LqHxZZynCNu8328PChR61DKY6TyWruqm5
         YyEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRVTMUBWH4APeQxeb999EIGnNJgITgZWqGte4Q+qrflS6ve2uInEdW+zhbgc9+XrS4ZsVcK8S2of+afvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YykpwEWq4yv22oxXQoZHZ6lbGKBPW5z3A9GquCJxTBLj6uroSZY
	4mkQfBSQjBsGJ4eBywBtVCy02fcIHL9ohjwF7ZBNdEwuulHoYH/hdjnQuxFStpto5KM=
X-Gm-Gg: ASbGncvn41xqNePgfeeA8cLT/N3YHocScCnJM38qZGbK5ituPZOVHZLpEMpDXpQbGmz
	tZUFScZjQta2kl4oPrkynbiSNFuk2Iyg31v6ZuJPEuRPC/QVLnMr0wOwIajcDtC5xki0rlbxMFq
	Uf/Q6oeQK5lb6+K21B+FZDmYAnqC+R0JaCSkXJ/4cAKgqXiAwYcwcpKllQriDSgi1TjPkXboJZo
	NaUV7H55vUoAIm1ReFxmhpmw99GAefPUMaTD6QNPdsl40D3KnZY0Upe6L4vabask5UzeSXSVoxA
	SzefCysCiCJrjbDtwWoS+rc4JRd4EdQmoEKX3g4w4tQ9V2Nh2UoVz4h+uwVEaDNmsCP9WrZZvQk
	3T7+6LtcW7Zk3hRCvSvybXzRwL9AzLmpO027+XdW2Wdo=
X-Google-Smtp-Source: AGHT+IGOULUshdeLRil6HKEu9zZo7J9O1jxxfK8N+bL8o+p4kBnHT1aasX29KcGupM6Cw5i6XsgkhQ==
X-Received: by 2002:a05:600c:4e93:b0:45d:e0d8:a0aa with SMTP id 5b1f17b1804b1-45de0d8a342mr47706135e9.17.1757269397175;
        Sun, 07 Sep 2025 11:23:17 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:c6e0:b19c:fab9:63fe])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45dd296ed51sm154484725e9.3.2025.09.07.11.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 11:23:16 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Valerio Setti via B4 Relay <devnull+vsetti.baylibre.com@kernel.org>
Cc: Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Kevin Hilman <khilman@baylibre.com>,  Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,  vsetti@baylibre.com,
  devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: amlogic: gxbb-odroidc2: remove UHS
 capability for SD card
In-Reply-To: <20250907-fix-reboot-v1-1-7606fc91254e@baylibre.com> (Valerio
	Setti via's message of "Sun, 07 Sep 2025 14:29:21 +0200")
References: <20250907-fix-reboot-v1-1-7606fc91254e@baylibre.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Sun, 07 Sep 2025 20:23:16 +0200
Message-ID: <1jecsi3ywb.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun 07 Sep 2025 at 14:29, Valerio Setti via B4 Relay <devnull+vsetti.baylibre.com@kernel.org> wrote:

> From: Valerio Setti <vsetti@baylibre.com>
>
> This is meant to resolve reboot not working on this board.
>
> The problem is as follows. In order to be able to switch from HS to UHS
> mode the bus voltage needs to be reduced from 3.3V down to 1.8V and this
> is achieved by the "vqmmc-supply" regulator. The ROM bootloader is only
> able to manage the card in HS mode (3.3V) and the switch HS->UHS happen
> at boottime in the kernel. The problem appears when the reboot command
> is issued or watchdog expires because in this case the "vqmmc-supply"
> voltage is not returned back at 3.3V before rebooting the board so the
> ROM bootloader will be completely stuck.
>
> Therefore this commit removes both "vqmmc-supply" property, which is the
> one causing the reboot problem, as well as all the UHS modes which would
> now became unreachable due to this regulator control removal.
>
> In terms of performance the main drawback of this commit is limiting the
> SD card bus speed to HS (25 MB/s) instead of UHS DDR50 (50 MB/s). However
> this comes with the benefit of being able to reboot the board, so it
> sounds like a reasonable compromise.
>
> Signed-off-by: Valerio Setti <vsetti@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 959bd8d77a82ebc78c5e0592d7613e692e4ede4e..331a0a62b884389b4e0d4d157fff7f9c8738c89d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -348,17 +348,16 @@ &sd_emmc_b {
>  
>  	bus-width = <4>;
>  	cap-sd-highspeed;
> -	sd-uhs-sdr12;
> -	sd-uhs-sdr25;
> -	sd-uhs-sdr50;
> -	sd-uhs-ddr50;

That's a compromise we had to make on other boards using similar SoCs.
With the ROM code not reseting the GPIO used for the supply, It don't
think there is way around that.

The above should be enough.

>  	max-frequency = <100000000>;
>  	disable-wp;
>  
>  	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_LOW>;
>  
>  	vmmc-supply = <&tflash_vdd>;
> -	vqmmc-supply = <&tf_io>;

... but do not remove that.

That way the description is complete and the kernel is able to verify
the regulator is properly configured.

It is also easier for a bootloader to alter DT to add the UHS modes back
(it is safe to do so if booting from another device that SD, such as
eMMC)

With that
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> +	/*
> +	 * Control of vqmmc-supply is intentionally omitted because it would
> +	 * prevent the board from rebooting properly.
> +	 */
>  };
>  
>  /* eMMC */
>
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250907-fix-reboot-04e0fc919ae0
>
> Best regards,

-- 
Jerome

