Return-Path: <linux-kernel+bounces-863461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A253BF7E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57F4F19C6264
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC7034B693;
	Tue, 21 Oct 2025 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="t7Moe0G+"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBF0238C03
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067546; cv=none; b=bU8hW7w4aeLT408MG5U9MezlEqxctwdQrx/VYumk8wdaVJxw2Z+ctvUDZhPqQG+rmZ2pXqlg8l6E8h8OqjhLyQMr8nuKHoGAR1WSkSfy256hHSF5mtoXBDWE6/rfaQ+Z9jrHPjr7mqxSSUkSf68k2Eu4xRC30WvbYBDJxvAlHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067546; c=relaxed/simple;
	bh=Zb+AiFJ7AZtrvjOzIRVha7PNEUVhODqDXu1v2ydol2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sD6INvNdqUExiDhCegtYe19tb7ShUKrMkkcj+dC87mXAFJD2SIbB8EPQqe/El1nDRJY3p8xcmCz6JnQaPxltzLHVTp8pnYLTycXzyHXwkRUG2sg1M1W6EP6J/BMLMcKfeAzQlXSQo3nvacNIh6gqhakl3c6T15tCLvLdTiGkhC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=t7Moe0G+; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C7D9D1A1560;
	Tue, 21 Oct 2025 17:25:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9AEDF60680;
	Tue, 21 Oct 2025 17:25:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7972B102F241C;
	Tue, 21 Oct 2025 19:25:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761067540; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NjixtuDyztScGI1GFZ3ocZ4UXIMoOGMB3PcdvJm1nfk=;
	b=t7Moe0G+YJDHJKc3YRrgBTM1FWDcBBVYA+vTgiCDx9fnu0JzRw9pQeSr2pGJHonNNs4UWJ
	PSLZ+pOi6HXAlstcadargnr2F8DW7LQCPYDdrZCMS1i3xJh+QDlUjRw6EIcoJnNNpvF87+
	utUITDi7IZCKOAs3lFIHvfGUEy5wAS/UMfs92wTcGFIdI8lAfecNUIvTJrBArSmxNvPJt7
	hflazOtVMu7NyAyRaybpbcI0JZrqGSDdEe16JGsvXOHC4U2q4+B1eAo2R2G8jvGLhxDBjA
	Mw3HnXQEFitrkVmVXMEEIk64smOg8ooJ8GChU3JNS3i7Z5x/c7lzwTV8b2FKUA==
Date: Tue, 21 Oct 2025 19:25:27 +0200
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
Message-ID: <20251021192527.2aea3b89@bootlin.com>
In-Reply-To: <20251017180313.0f0f71d7@bootlin.com>
References: <20251016130340.1442090-1-herve.codina@bootlin.com>
	<20251016130340.1442090-2-herve.codina@bootlin.com>
	<60fbaaef249e6f5af602fe4087eab31cd70905de.camel@gmail.com>
	<20251017083232.31e53478@bootlin.com>
	<d6bd466a5d11b016183db0ac3c25185fad3036fc.camel@gmail.com>
	<20251017171024.5a16da34@bootlin.com>
	<336e169019bd3eadc475c981abef3db07149a5db.camel@gmail.com>
	<20251017180313.0f0f71d7@bootlin.com>
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

On Fri, 17 Oct 2025 18:03:13 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi Alexander,
> 
> On Fri, 17 Oct 2025 17:35:56 +0200
> Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:
> 
> > Hi Herve,
> > 
> > On Fri, 2025-10-17 at 17:10 +0200, Herve Codina wrote:  
> > > > > > > In order to have the I2C or the SPI module loaded automatically, move
> > > > > > > the MODULE_DEVICE_TABLE(of, ...) the core to I2C and SPI parts.
> > > > > > > Also move cs4271_dt_ids itself from the core part to I2C and SPI parts
> > > > > > > as both the call to MODULE_DEVICE_TABLE(of, ...) and the cs4271_dt_ids
> > > > > > > table itself need to be in the same file.        
> > > > > > 
> > > > > > I'm a bit confused by this change.
> > > > > > What do you have in SYSFS "uevent" entry for the real device?      
> > > > > 
> > > > > Here is my uevent content:
> > > > > --- 8<---
> > > > > # cat /sys/bus/i2c/devices/3-0010/uevent 
> > > > > DRIVER=cs4271
> > > > > OF_NAME=cs4271
> > > > > OF_FULLNAME=/i2c@ff130000/cs4271@10
> > > > > OF_COMPATIBLE_0=cirrus,cs4271
> > > > > OF_COMPATIBLE_N=1
> > > > > MODALIAS=of:Ncs4271T(null)Ccirrus,cs4271
> > > > > # 
> > > > > --- 8< ---      
> > > > 
> > > > that's what I get with SPI-connected CS4271, and this is actually what I'd
> > > > expect (linux-next as of 2433b8476165):
> > > > 
> > > > # cat /sys/bus/spi/devices/spi0.0/uevent
> > > > DRIVER=cs4271
> > > > OF_NAME=codec
> > > > OF_FULLNAME=/soc/spi@808a0000/codec@0
> > > > OF_COMPATIBLE_0=cirrus,cs4271
> > > > OF_COMPATIBLE_N=1
> > > > MODALIAS=spi:cs4271    
> > > 
> > > So, this is without my patch applied.    
> > 
> > this is the modalias of the device, it doesn't depend on your patch series.
> > 
> > I'd say that modalias for SPI device is correct but commit c973b8a7dc50
> > lacks MODULE_DEVICE_TABLE(spi, ...) in the driver.
> > 
> > I'd argue that I2C modalias is correct in the driver:
> > 
> > # modinfo snd-soc-cs4271-i2c
> > ...
> > alias:          i2c:cs4271
> > 
> > But I still have to understand what happened to I2C core.
> >   
> > > I don't have any CS4271 connected on SPI bus to perform the same test
> > > with my patch applied.    
> >   
> 
> In my next iteration, I will fix the MODULE_DEVICE_TABLE() in cs4271-spi.c
> replacing
>   MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
> by
>   MODULE_DEVICE_TABLE(spi, cs4271_dt_ids);

I have the feeling that this was not correct.

Looking at several SPI driver, both
MODULE_DEVICE_TABLE(of, ...) and MODULE_DEVICE_TABLE(spi, ...) are present.

I should keep the MODULE_DEVICE_TABLE(of, cs4271_dt_ids) in the cs4271-spi.c
but a MODULE_DEVICE_TABLE(spi, ...) is missing.

I plan to add the following for the cs4271-spi.c file:
--- 8< ---
static const struct spi_device_id cs4271_spi_id[] = {
	{ "cs4271" },
	{ }
};
MODULE_DEVICE_TABLE(spi, cs4271_spi_id);

static struct spi_driver cs4271_spi_driver = {
	...
	.id_table = cs4271_spi_id,     /* <---- This was also missing */
};

--- 8< ---

Also no change on cs4271-i2c.c file as both MODULE_DEVICE_TABLE(i2c, ...)
and MODULE_DEVICE_TABLE(of, ...) are already present.

Looking at other drivers in the kernel for devices that can be available on
SPI or I2C busses, a lot of them have the same MODULE_DEVICE_TABLE(of, ...)
for the SPI and the I2C parts and a specific MODULE_DEVICE_TABLE(spi, ...)
for the SPI part or MODULE_DEVICE_TABLE(i2c, ...) for the I2C part.

My next iteration will be consistent with this pattern.
- cs4271-spi.c:
    The cs4271_spi_id table contains { "cs4271" }
    The cs4271_dt_ids table contains { .compatible = "cirrus,cs4271" }
    
    MODULE_DEVICE_TABLE(spi, cs4271_spi_id);
    MODULE_DEVICE_TABLE(of, cs4271_dt_ids);

- cs4271-i2c.c
    The cs4271_i2c_id table contains { "cs4271" }
    The cs4271_dt_ids table contains { .compatible = "cirrus,cs4271" }

    MODULE_DEVICE_TABLE(i2c, cs4271_i2c_id);
    MODULE_DEVICE_TABLE(of, cs4271_dt_ids);

Best regards,
Hervé

