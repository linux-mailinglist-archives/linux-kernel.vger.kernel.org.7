Return-Path: <linux-kernel+bounces-808125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55835B4F9FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 472544E2C9D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831C032CF87;
	Tue,  9 Sep 2025 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="l504Y8J+"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E5132CF61
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419971; cv=none; b=Bzk965hXk5fpvv3iX1PB60pk+dNdSVft1ir2/wXzZI0ekX2I5SG+n3pQso3VRyuxz7HmLEaoIsP2hxQaXzyQpcrfcpzg74+MuiS8H9TRAhz5BVDmnaYkwQqxNn2diH7put77gNY14tWBkg2qXe0vNapEZJEkWuDXHEVbh+C/wHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419971; c=relaxed/simple;
	bh=XavOBPWoiohB/KH7IvM7lBCug9BbrbJbY6t4BbKWmTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRHybJciEPwjfEFKiDThpRFUWh1RfYijBFRxdFKoHSkqVWg/KNrk/b91S2A+BdlvMzWYcxQQ3+A/JDb3mxztPhbHyeuZffj121LYPqPSxj/3aV9mfX9GeB++e31jozWl7eD0trAoNII5k5fnmN6Es69iauv0HsXs4ZHtCuW40uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=l504Y8J+; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id D1709101193E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 17:42:45 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in D1709101193E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1757419965; bh=XavOBPWoiohB/KH7IvM7lBCug9BbrbJbY6t4BbKWmTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l504Y8J+oTgcJ/mahb1ga8FRsGlshm+DRiCzJhK0A3aOELk2re+wMUvs8AeOnt45y
	 jDSNipkHX1f/HEWeD9/GT7NvUvIj9pqmbEepcxGUQR80Xgf88qz6QW0ATaGACq+HGr
	 ZAB8YZHjvKhO4lyNh1AIhSKsB4hw9WUVT6lzskKo=
Received: (qmail 1161 invoked by uid 510); 9 Sep 2025 17:42:45 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns1 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.101.4/26439} 
 Clear:RC:1(10.200.1.25):SA:0(0.2/7.0):. Processed in 5.151824 secs; 09 Sep 2025 17:42:45 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns1.iitb.ac.in) (10.200.1.25)
  by ldns1.iitb.ac.in with SMTP; 9 Sep 2025 17:42:40 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id 229F7360047;
	Tue,  9 Sep 2025 17:42:40 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id EDD751E8138D;
	Tue,  9 Sep 2025 17:42:39 +0530 (IST)
Date: Tue, 9 Sep 2025 17:42:35 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	skhan@linuxfoundation.org, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: Re: [PATCH 5/7] rtc: m41t93: fix device connection/detection logic
 during probe
Message-ID: <20250909121235.GA2071423@bhairav-test.ee.iitb.ac.in>
References: <cover.1756908788.git.akhilesh@ee.iitb.ac.in>
 <c3deec9e679cd4e4a49a2cc1cba340c552faefdc.1756908788.git.akhilesh@ee.iitb.ac.in>
 <2025090314472377b79cdf@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025090314472377b79cdf@mail.local>

On Wed, Sep 03, 2025 at 04:47:23PM +0200, Alexandre Belloni wrote:
> On 03/09/2025 19:57:21+0530, Akhilesh Patil wrote:
> > Fix the incorrect assumption about WDAY register (0x4) bits 3 to 7
> > being 0 after initial power-on to test response from device during probe
> > 
> > Do not expect these bits to be 0 after power on as datasheet does not
> > explicitly mention these power on defaults but recommends software to
> > clear these bits during operation. Refer section 3.15 for initial
> > power-on default bits.
> > 
> > Fix the random probe failures after power on by removing this condition
> > check. Add alternate response check logic which performs write, read,
> > compare check on device SRAM register to check device connection.
> > 
> > Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> > ---
> >  drivers/rtc/rtc-m41t93.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-m41t93.c b/drivers/rtc/rtc-m41t93.c
> > index 8cc179e08a4a..902797070246 100644
> > --- a/drivers/rtc/rtc-m41t93.c
> > +++ b/drivers/rtc/rtc-m41t93.c
> > @@ -30,6 +30,7 @@
> >  #define M41T93_BIT_A1IE                 BIT(7)
> >  #define M41T93_BIT_ABE			BIT(5)
> >  #define M41T93_FLAG_AF1                 BIT(6)
> > +#define M41T93_SRAM_BASE		0x19
> >  
> >  
> >  #define M41T93_REG_ALM_HOUR_HT		0xc
> > @@ -290,17 +291,25 @@ static int m41t93_probe(struct spi_device *spi)
> >  		return PTR_ERR(m41t93->regmap);
> >  	}
> >  
> > -	ret = regmap_read(m41t93->regmap, M41T93_REG_WDAY, &res);
> > -	if (ret < 0) {
> > +	ret = regmap_write(m41t93->regmap, M41T93_SRAM_BASE, 0xA5);
> 
> Nope, probe is not called at RTC power on but when linux starts. The
> whole point of the RTC is to survive Linux. Writing to this register is
> breaking functionnality.

Okay. 
I did not get the intent of original author to read WDAY register
and check bits 3 to 7 to be 0 (as per datasheet, these are reserved bits
and it does not explicitly say these are 0). I assume it is checking if
device is connected, but IMO this check can be skipped altogether.
Anaways, I would like to take this seperately and focus this series only
on features, hence will skip this patch in v2.

> 
> > +	if (ret) {
> >  		dev_err(&spi->dev, "IO error\n");
> >  		return -EIO;
> >  	}
> >  
> > -	if (res < 0 || (res & 0xf8) != 0) {
> > -		dev_err(&spi->dev, "not found 0x%x.\n", res);

motivation for this change was - I was hitting this with res = 0x77
ocassionally after soft reboot on my setup (am62x SK + m41t93 chip on spi0).
I will confirm if it is any setup issue before taking up this code fix
seperately.

> > +	ret = regmap_read(m41t93->regmap, M41T93_SRAM_BASE, &res);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "IO error\n");
> > +		return -EIO;
> > +	}
> > +
> > +	if (res != 0xA5) {
> > +		dev_err(&spi->dev, "No valid response from device 0x%x.\n", res);
> >  		return -ENODEV;
> >  	}
> >  
> > +	dev_notice(&spi->dev, "m41t93 device response success\n");
> > +
> 
> This is too verbose.

Sure. will remove this.

> 
> >  	spi_set_drvdata(spi, m41t93);
> >  
> >  	m41t93->rtc = devm_rtc_device_register(&spi->dev, m41t93_driver.driver.name,
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

Thanks for the review, 

Regards,
Akhilesh



