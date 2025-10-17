Return-Path: <linux-kernel+bounces-858372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77667BEA8E5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA1474678F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0A625E469;
	Fri, 17 Oct 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FhUWtwoC"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D325F994
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717010; cv=none; b=N0/3Ky/u5/RJ+usZlQDQBDMxPI5ZyN6f/LEXhsqupeGHSaMcdjRtb3qfC6yGjBNyng4x5UK93OlzAdCF8hr9ATIGxEha+xSHlHFvbtMVHyU04eZkwjN1bFLs/sdS7IaYNgqyFHvAMIqvmetL83IfgqB39o6E6oNNAEdhA8+aVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717010; c=relaxed/simple;
	bh=V5nvHHyMpT2oBH9OXx7GRjutbxS7EJ70S9GS3ixgU8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTvXPn6Mum6p2kPaDk3dtH4SIwUZP88QAsxnRQrbnGNIt2CE/ThRsIQdsaG/QtWhMTtAkcql3hVi09aPRBOSdFsMc/xSC1Y3xYu389RdVJr6NQ/zmj+ovKY4ntZa3x5ecOnEVGLCaiXJPzg1fy6uwvmryciUjiVou9aCnmVGNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FhUWtwoC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 14B781A1483;
	Fri, 17 Oct 2025 16:03:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DC1EA606DB;
	Fri, 17 Oct 2025 16:03:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C050102F2366;
	Fri, 17 Oct 2025 18:03:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760717005; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VRVsgwJpNbMCtPLDUTdNjde66pvJANzuRr/rOO23+SI=;
	b=FhUWtwoCP04yqOiDmI1EwaKM4t/9LEDySI/yars/wRXf4nwS1KPl3FYGVxS3pmy7ayjfu8
	dimGqZSBI2FGcQlJrtl6CuIigftt/sPbKmUzjtVWd7ionCy4fpOa/M8nKedz3JOo86KR1u
	9el4cFyMXPTJGKtxHrFcK8VXxf288PmRZUD8X0dZ7dsGnXh0B64g6B7HVjNsE5EhoT21Wu
	LCItfKgk3M/74O35AivJ+XyBN42PTfngM8l/su5jrljiUluJ5oMhe6S8C7o2JV2p7GIUAb
	e29UtSHdxEByIa2NfNLGUUcmCF4en4fOyWC5pCDXbfz22setFP8TodIdDqYWUQ==
Date: Fri, 17 Oct 2025 18:03:13 +0200
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
Message-ID: <20251017180313.0f0f71d7@bootlin.com>
In-Reply-To: <336e169019bd3eadc475c981abef3db07149a5db.camel@gmail.com>
References: <20251016130340.1442090-1-herve.codina@bootlin.com>
	<20251016130340.1442090-2-herve.codina@bootlin.com>
	<60fbaaef249e6f5af602fe4087eab31cd70905de.camel@gmail.com>
	<20251017083232.31e53478@bootlin.com>
	<d6bd466a5d11b016183db0ac3c25185fad3036fc.camel@gmail.com>
	<20251017171024.5a16da34@bootlin.com>
	<336e169019bd3eadc475c981abef3db07149a5db.camel@gmail.com>
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

On Fri, 17 Oct 2025 17:35:56 +0200
Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:

> Hi Herve,
> 
> On Fri, 2025-10-17 at 17:10 +0200, Herve Codina wrote:
> > > > > > In order to have the I2C or the SPI module loaded automatically, move
> > > > > > the MODULE_DEVICE_TABLE(of, ...) the core to I2C and SPI parts.
> > > > > > Also move cs4271_dt_ids itself from the core part to I2C and SPI parts
> > > > > > as both the call to MODULE_DEVICE_TABLE(of, ...) and the cs4271_dt_ids
> > > > > > table itself need to be in the same file.      
> > > > > 
> > > > > I'm a bit confused by this change.
> > > > > What do you have in SYSFS "uevent" entry for the real device?    
> > > > 
> > > > Here is my uevent content:
> > > > --- 8<---
> > > > # cat /sys/bus/i2c/devices/3-0010/uevent 
> > > > DRIVER=cs4271
> > > > OF_NAME=cs4271
> > > > OF_FULLNAME=/i2c@ff130000/cs4271@10
> > > > OF_COMPATIBLE_0=cirrus,cs4271
> > > > OF_COMPATIBLE_N=1
> > > > MODALIAS=of:Ncs4271T(null)Ccirrus,cs4271
> > > > # 
> > > > --- 8< ---    
> > > 
> > > that's what I get with SPI-connected CS4271, and this is actually what I'd
> > > expect (linux-next as of 2433b8476165):
> > > 
> > > # cat /sys/bus/spi/devices/spi0.0/uevent
> > > DRIVER=cs4271
> > > OF_NAME=codec
> > > OF_FULLNAME=/soc/spi@808a0000/codec@0
> > > OF_COMPATIBLE_0=cirrus,cs4271
> > > OF_COMPATIBLE_N=1
> > > MODALIAS=spi:cs4271  
> > 
> > So, this is without my patch applied.  
> 
> this is the modalias of the device, it doesn't depend on your patch series.
> 
> I'd say that modalias for SPI device is correct but commit c973b8a7dc50
> lacks MODULE_DEVICE_TABLE(spi, ...) in the driver.
> 
> I'd argue that I2C modalias is correct in the driver:
> 
> # modinfo snd-soc-cs4271-i2c
> ...
> alias:          i2c:cs4271
> 
> But I still have to understand what happened to I2C core.
> 
> > I don't have any CS4271 connected on SPI bus to perform the same test
> > with my patch applied.  
> 

In my next iteration, I will fix the MODULE_DEVICE_TABLE() in cs4271-spi.c
replacing
  MODULE_DEVICE_TABLE(of, cs4271_dt_ids);
by
  MODULE_DEVICE_TABLE(spi, cs4271_dt_ids);

For the moment, related to I2C, I keep MODULE_DEVICE_TABLE(of, cs4271_dt_ids)
in cs4271-i2c.c

Best regards,
Hervé

