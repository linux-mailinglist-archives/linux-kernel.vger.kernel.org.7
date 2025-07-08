Return-Path: <linux-kernel+bounces-721177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2C8AFC5CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71120167246
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A602BE057;
	Tue,  8 Jul 2025 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNZazJ7S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3831E231E;
	Tue,  8 Jul 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963698; cv=none; b=Ak9qd6adUw4fpXJt/rZzkCIQivgVmdC8lSUXQFwAbfOqJUybr1VcSHqvobKybjK2oUa2Y70B+lRzR5dsivHdltf0rxluSFi5SzwlGzDsTnoIalgu3qxmK9XeL44l0pjcvykyEY3GeK548TNcb0S5unMCg/+Qe12bq32J5/lcLbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963698; c=relaxed/simple;
	bh=2Jz1qIaKUbxfjh+EnpAbS6pNmd5Pwbb3QUeKA2lWqes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld0uoR36Sfqd0uT0gl7sBc+rqOHa10QGZMTyvFXTv/MqdbX1tW2cTXic/Of0gFrEew0mFcTdE1I5gfxD5PRwzyB4+jX/bgMuca8tova/rviBrTU1NY7+/+iweeFXG5lviriGMHDx8G+f5WDuYYGXkHM+0lVyw4A7T4/T6pGhZec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNZazJ7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABCD4C4CEED;
	Tue,  8 Jul 2025 08:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751963698;
	bh=2Jz1qIaKUbxfjh+EnpAbS6pNmd5Pwbb3QUeKA2lWqes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNZazJ7SNy74UDkThqwB6ngXolMFPE4YQIak1LVtjrjLOQqhZb2lyIL1zDfvKyss5
	 8zZaVhRWqqvYx6+BZRknWfKOrFiHmj4bG/6KptMbcaVq9xYFQdYnBKHaNmi6ZGqq8T
	 hNuoO5w5SgW+IA3hmVWLxWWIcAJ9DUGHwE7K0omaO5srh0oo2XRu97/L6QAtTR3O2k
	 se5093I87pD3BnlIR+HKXRXOGs+/QOvjwyrtT5BEdokep7OAgEfxgIWtCgDhWnozKK
	 6Zv97ge9pV/StWeXK6qM3J0Y8B5x1c4SSaXHCiqcmli1VOmcen9XVrKtgzKpSYTcqr
	 AVghupSINM7Zw==
Date: Tue, 8 Jul 2025 10:34:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Taishi Shimizu <s.taishi14142@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Rafal Milecki <zajec5@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 2/2] ARM: dts: BCM5301X: Add support for Buffalo
 WXR-1750DHP
Message-ID: <20250708-elite-indigo-wombat-faa74f@krzk-bin>
References: <20250625154315.114139-1-s.taishi14142@gmail.com>
 <20250625154315.114139-2-s.taishi14142@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250625154315.114139-2-s.taishi14142@gmail.com>

On Thu, Jun 26, 2025 at 12:43:15AM +0900, Taishi Shimizu wrote:
> +
> +#include "bcm4708.dtsi"
> +#include "bcm5301x-nand-cs0-bch8.dtsi"
> +
> +/ {
> +	compatible = "buffalo,wxr-1750dhp", "brcm,bcm4708";
> +	model = "Buffalo WXR-1750DHP";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200";

Please use stdout path property.

> +	};
> +
> +	memory@0 {
> +		reg = <0x00000000 0x08000000>,
> +		      <0x88000000 0x08000000>;
> +		device_type = "memory";
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		button-aoss {
> +			label = "AOSS";
> +			linux,code = <KEY_WPS_BUTTON>;
> +			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		/* GPIO 8 and 9 are a tri-state switch button with
> +		 * ROUTER / AP / WB.
> +		 */
> +		button-bridge {
> +			label = "WB";
> +			linux,code = <BTN_2>;
> +			linux,input-type = <EV_SW>;
> +			gpios = <&chipcommon 8 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		/* GPIO 3 is a switch button with AUTO / MANUAL. */
> +		button-manual {
> +			label = "MANUAL";
> +			linux,code = <BTN_0>;
> +			linux,input-type = <EV_SW>;
> +			gpios = <&chipcommon 3 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		button-restart {
> +			label = "Reset";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		button-router {
> +			label = "ROUTER";
> +			linux,code = <BTN_1>;
> +			linux,input-type = <EV_SW>;
> +			gpios = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		led-power0 {
> +			label = "bcm53xx:white:power";

You should use rather color and function properties.

> +			linux,default-trigger = "default-on";
> +			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
> +		};

Best regards,
Krzysztof


