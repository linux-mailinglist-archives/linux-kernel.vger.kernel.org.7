Return-Path: <linux-kernel+bounces-857400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF59BE6BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD64624CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2A630F940;
	Fri, 17 Oct 2025 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EV5sMN6i"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E299521FF28;
	Fri, 17 Oct 2025 06:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682769; cv=none; b=M89TMs/D59E/VnDiUJw3QA80EBNz8XsSzhmOcZGg3/UYrDq36y0JeaSFtrSjlDYihJRj9thMkjsswxI8XBnKZ95Bjr/pjRbfszRXg/JoINr53cb9oQeyrUoJv76sG3MOkN4G7bocvK4k0BolFiN1YJcA1hdJjP0wvi0Z3230yUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682769; c=relaxed/simple;
	bh=kxWb2v3kc92Dzy3+joMpABr5I3NLk5PWsLbNzW+zSXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFGjkOsaMt4jAXcqx5rwsB10RB6ug46/YgC67Fh2tOC7OqUVHC6uA4z503ocgpxI9xX+qWMbcVzConjZwjKkeQzAloNU0T2tJvS8fi/TURoyysXSQtmbOGkFRyPQhEHvTI5gp9i3SjNlb2bQ8jnPSRh/34CyyMEffwkjfGSHzBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EV5sMN6i; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C3ED14E41115;
	Fri, 17 Oct 2025 06:32:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 91211606DB;
	Fri, 17 Oct 2025 06:32:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE510102F22FF;
	Fri, 17 Oct 2025 08:32:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760682762; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Yfh8KNtPJgL5dEOBYcZ+FOqECZ1ufTn2Q+8/o1+dnNU=;
	b=EV5sMN6iU4XCN0aL+jp41FSTSRIKiBGUfkWtao0P+0srDp3W2VmOkkY4uZN4NahTNNaQJk
	YPqJb+trP2jIT68qeWbJwojXn99WyoqqidKisnc6Q0rlgWQky2eQ3iKEVMBmUr+QgS8iUg
	O4PNT7CIipL4qQZ5dv7e9bbZcIuriy+R1hVGPD+coPCMWYW3PhbZ+N6WolmwEw2pRibZMn
	Y/9xhUQKVSaRqZukJX9wztATTWLwsSQy2G2STtBV6Xabvuv3sb4bTFWbl2rpvp8Zoc4mmf
	piHedWYoNwcasNLj/217UwGApttb6xmMck4DyAnIuMwG9pxiab19Z5v9lca/Lw==
Date: Fri, 17 Oct 2025 08:32:32 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: David Rhodes	 <david.rhodes@cirrus.com>, Richard Fitzgerald
 <rf@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela	
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Nikita Shubin	
 <nikita.shubin@maquefel.me>, Axel Lin <axel.lin@ingics.com>, Brian Austin	
 <brian.austin@cirrus.com>, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni 
 <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: cs4271: Fix cs4271 I2C and SPI drivers
 automatic module loading
Message-ID: <20251017083232.31e53478@bootlin.com>
In-Reply-To: <60fbaaef249e6f5af602fe4087eab31cd70905de.camel@gmail.com>
References: <20251016130340.1442090-1-herve.codina@bootlin.com>
	<20251016130340.1442090-2-herve.codina@bootlin.com>
	<60fbaaef249e6f5af602fe4087eab31cd70905de.camel@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Alexander,

On Thu, 16 Oct 2025 20:40:34 +0200
Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:

...

> > In order to have the I2C or the SPI module loaded automatically, move
> > the MODULE_DEVICE_TABLE(of, ...) the core to I2C and SPI parts.
> > Also move cs4271_dt_ids itself from the core part to I2C and SPI parts
> > as both the call to MODULE_DEVICE_TABLE(of, ...) and the cs4271_dt_ids
> > table itself need to be in the same file.  
> 
> I'm a bit confused by this change.
> What do you have in SYSFS "uevent" entry for the real device?

Here is my uevent content:
--- 8<---
# cat /sys/bus/i2c/devices/3-0010/uevent 
DRIVER=cs4271
OF_NAME=cs4271
OF_FULLNAME=/i2c@ff130000/cs4271@10
OF_COMPATIBLE_0=cirrus,cs4271
OF_COMPATIBLE_N=1
MODALIAS=of:Ncs4271T(null)Ccirrus,cs4271
# 
--- 8< ---

> 
> If you consider spi_uevent() and i2c_device_uevent(), "MODALIAS=" in the
> "uevent" should be prefixed with either "spi:" or "i2c:".
> And this isn't what you adress in your patch.
> 
> You provide [identical] "of:" prefixed modalias to two different modules
> (not sure, how this should work), but cs4271 is not an MMIO device,
> so it should not generate an "of:" prefixed uevent.
> 
> Could you please show the relevant DT snippet for the affected HW?

And this is the related DT part:
--- 8< ---
&i2c3 {
	status = "okay";

	cs4271@10 {
		compatible = "cirrus,cs4271";
		reg = <0x10>;
		clocks = <&cru SCLK_I2S_8CH_OUT>;
		clock-names = "mclk";

		...
	};
};
--- 8< ---

i2c3 is the following node:
https://elixir.bootlin.com/linux/v6.17.1/source/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi#L732

About the related module, I have the following:
--- 8< ---
# modinfo snd_soc_cs4271_i2c
filename:       /lib/modules/6.18.0-rc1xxxx-00050-g4fa36970abe5-dirty/kernel/sound/soc/codecs/snd-soc-cs4271-i2c.ko
license:        GPL
author:         Alexander Sverdlin <subaparts@yandex.ru>
description:    ASoC CS4271 I2C Driver
alias:          i2c:cs4271
alias:          of:N*T*Ccirrus,cs4271C*
alias:          of:N*T*Ccirrus,cs4271
depends:        snd-soc-cs4271
intree:         Y
name:           snd_soc_cs4271_i2c
vermagic:       6.18.0-rc1xxxx-00050-g4fa36970abe5-dirty SMP preempt mod_unload aarch64
# 
--- 8< ---

Best regards,
Hervé

