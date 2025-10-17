Return-Path: <linux-kernel+bounces-858277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD79BE9BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 90FC258113C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC78133507C;
	Fri, 17 Oct 2025 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tzqo0eok"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE0335073;
	Fri, 17 Oct 2025 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713838; cv=none; b=OPa0eLZQAXlXv21ImWwtzFLVA+2YJB/V7+9E9/2z25J1nani9j3AHf9ziXqjWs/HbnGyk4Zn0jiY3Nfy49lPTPABdSZNbQMaeXEQ9NIn7UBK9Gv9UGukWZC2b2P6voDKf28ffphRgSOyz3tPQyH5OAN3YdmOWshfWj7rE8vJFEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713838; c=relaxed/simple;
	bh=Gm4P2a9S/HHIpbqj/1/WVKWFwzH85G3VJQhBIXcpX5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTv0xQa3fdK4Bvaf56SlcItI4eFTVrQLDRcfH9qLe9L+CAoqySqzvsEmRbWjPXNihiFCMZQX/Zx+3Y9s+pPARzvEo13ArfABCsV6E3oxidGmsobyQPUmHw8KK6NS27O+eBRhrOGC6YlyMeHiBBYqRFC44P3LnKy45JeKlzMW/JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tzqo0eok; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A6A4A1A1452;
	Fri, 17 Oct 2025 15:10:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7AAB3606DB;
	Fri, 17 Oct 2025 15:10:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 11888102F2330;
	Fri, 17 Oct 2025 17:10:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760713833; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tz1YrBtjgqKAjBOhZdtsBw6j4wrL2DMmdPaWBNAh2s8=;
	b=tzqo0eokJ+Cb1HPhb7hvZnwRbkJG3ORsnEhEfsleM9+rDD2KW5srX8MkdOSFv6JWcAGm0a
	gH31tvSj5/HNhHA7PIUzQyhXTXZeKv4Wn7V4Gvuucs/K9glYAeJPgva0/yTbLvNInIlTIY
	kE5rZijgGSw7vmKavNRzveTJOgi/AGWfkLFt2Hx01RKnb5YKjCbViXT6qcTsjKZG5ec3Vs
	7MW+9YP9zxDYPyKBepNLN8mf5K9l9RUhhImLmRdR3l0dy0HnHvlO9Ci1Hevz5VtX2VkfqS
	Ynk+jtfUQ2ZB2iNlbRGGFuZW+K3B7y4EaCbsRxlhpQM5XqaI6J1HgkayBtFDzg==
Date: Fri, 17 Oct 2025 17:10:24 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: David Rhodes <david.rhodes@cirrus.com>, Richard Fitzgerald	
 <rf@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
  <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela	
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Nikita Shubin	
 <nikita.shubin@maquefel.me>, Axel Lin <axel.lin@ingics.com>, Brian Austin	
 <brian.austin@cirrus.com>, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/3] ASoC: cs4271: Fix cs4271 I2C and SPI drivers
 automatic module loading
Message-ID: <20251017171024.5a16da34@bootlin.com>
In-Reply-To: <d6bd466a5d11b016183db0ac3c25185fad3036fc.camel@gmail.com>
References: <20251016130340.1442090-1-herve.codina@bootlin.com>
	<20251016130340.1442090-2-herve.codina@bootlin.com>
	<60fbaaef249e6f5af602fe4087eab31cd70905de.camel@gmail.com>
	<20251017083232.31e53478@bootlin.com>
	<d6bd466a5d11b016183db0ac3c25185fad3036fc.camel@gmail.com>
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

On Fri, 17 Oct 2025 15:25:42 +0200
Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:

> Hi Herve,
> 
> On Fri, 2025-10-17 at 08:32 +0200, Herve Codina wrote:
> > ...
> >   
> > > > In order to have the I2C or the SPI module loaded automatically, move
> > > > the MODULE_DEVICE_TABLE(of, ...) the core to I2C and SPI parts.
> > > > Also move cs4271_dt_ids itself from the core part to I2C and SPI parts
> > > > as both the call to MODULE_DEVICE_TABLE(of, ...) and the cs4271_dt_ids
> > > > table itself need to be in the same file.    
> > > 
> > > I'm a bit confused by this change.
> > > What do you have in SYSFS "uevent" entry for the real device?  
> > 
> > Here is my uevent content:
> > --- 8<---
> > # cat /sys/bus/i2c/devices/3-0010/uevent 
> > DRIVER=cs4271
> > OF_NAME=cs4271
> > OF_FULLNAME=/i2c@ff130000/cs4271@10
> > OF_COMPATIBLE_0=cirrus,cs4271
> > OF_COMPATIBLE_N=1
> > MODALIAS=of:Ncs4271T(null)Ccirrus,cs4271
> > # 
> > --- 8< ---  
> 
> that's what I get with SPI-connected CS4271, and this is actually what I'd
> expect (linux-next as of 2433b8476165):
> 
> # cat /sys/bus/spi/devices/spi0.0/uevent
> DRIVER=cs4271
> OF_NAME=codec
> OF_FULLNAME=/soc/spi@808a0000/codec@0
> OF_COMPATIBLE_0=cirrus,cs4271
> OF_COMPATIBLE_N=1
> MODALIAS=spi:cs4271

So, this is without my patch applied.
I don't have any CS4271 connected on SPI bus to perform the same test
with my patch applied.

> 
> > > If you consider spi_uevent() and i2c_device_uevent(), "MODALIAS=" in the
> > > "uevent" should be prefixed with either "spi:" or "i2c:".
> > > And this isn't what you adress in your patch.
> > > 
> > > You provide [identical] "of:" prefixed modalias to two different modules
> > > (not sure, how this should work), but cs4271 is not an MMIO device,
> > > so it should not generate an "of:" prefixed uevent.
> > > 
> > > Could you please show the relevant DT snippet for the affected HW?  
> > 
> > And this is the related DT part:
> > --- 8< ---
> > &i2c3 {
> >  status = "okay";
> > 
> >  cs4271@10 {
> >  compatible = "cirrus,cs4271";
> >  reg = <0x10>;
> >  clocks = <&cru SCLK_I2S_8CH_OUT>;
> >  clock-names = "mclk";
> > 
> >  ...
> >  };
> > };
> > --- 8< ---
> > 
> > i2c3 is the following node:
> > https://elixir.bootlin.com/linux/v6.17.1/source/arch/arm64/boot/dts/rockchip/rk3399-base.dtsi#L732  
> 
> the above looks OK to me on the first glance, I'm really puzzled what
> is the reason for "of:" prefixed MODALIAS in the uevent for an i2c device.
> 
> I still believe, that the culprit is the creation of a platform device
> from the DT for an i2c device.
> 
> I don't have any real I2C-connected CS4271, but I think I could fake one
> in any DT just to verify how uevents would look like on my side.
> 
> > About the related module, I have the following:  
> 
> I assume, this is with your patch applied though.

Yes, exactly.

> 
> > --- 8< ---
> > # modinfo snd_soc_cs4271_i2c
> > filename:       /lib/modules/6.18.0-rc1xxxx-00050-g4fa36970abe5-dirty/kernel/sound/soc/codecs/snd-soc-cs4271-i2c.ko
> > license:        GPL
> > author:         Alexander Sverdlin <subaparts@yandex.ru>
> > description:    ASoC CS4271 I2C Driver
> > alias:          i2c:cs4271
> > alias:          of:N*T*Ccirrus,cs4271C*
> > alias:          of:N*T*Ccirrus,cs4271
> > depends:        snd-soc-cs4271
> > intree:         Y
> > name:           snd_soc_cs4271_i2c
> > vermagic:       6.18.0-rc1xxxx-00050-g4fa36970abe5-dirty SMP preempt mod_unload aarch64
> > # 
> > --- 8< ---  
> 

Best regards,
Hervé

