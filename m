Return-Path: <linux-kernel+bounces-858325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE27BEA0BF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C841887C52
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793CF336EFB;
	Fri, 17 Oct 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHR94A4w"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5CE336EDC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715362; cv=none; b=I4Ycb3QP9hqirFA9vJD++QIYB95lOzQ95g1xiirERAp/HVUcaDj6AwwHELXqYo1awuXibfmQImz2RTa9m7WA0Zq2oqefRcMm5JefW5+jjOW2vPL60Fi1zK66EPJESJrEZ6DI7jEwCzeOxvCCy4FRAM85Y2EDYOkH90WfHoCWmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715362; c=relaxed/simple;
	bh=K2qsVubYn8CjPdJ5wxrhOx1EatQUzPg4cvi5piJsRvg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EVDU65RGPV76NsQ0iG402KfYnI8DmU7HBxlM1vVpJ7VbDjXksyLfYxu8yK4xpzxQtgicr3MDRq/QTfZGSNJHh5irrCvOvlNRuJoSv2nbNuvNlWy13vTy4PCPpEoo05RY3dSNQhh6k+vmCNSFOWRbW+q4kJD4wr7Unr9CI92TnwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHR94A4w; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4270a3464bcso261405f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760715357; x=1761320157; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jXEmmH8KoIy+3oXIIcxfKQybPt2IeFDnPMZ3gpQBr8I=;
        b=OHR94A4wi7UuKhVMy2p0jHbB3azRh7iDoA0SAMo0JnGyTVamlfctEEb5IM9J8yLEGx
         zz2xkVhJ5cyQOfGqNyWJVmeUDdclYaxJoIUrqIUgG2knhD3PhO/3MwW/wnowhHVESIbB
         TKncrp0Di3lZZOokMU4xXnlJBeNK7All53/UD6H6QetaYzz76dCL9Lx9RNyIVnSEZLGD
         4baLTmyQt0KplV3SpaAtgqnK/6rrz4IJwTeaaVOHCrynn5xSejre7O4Uj+OxAe+orFE3
         czCRg3zFr/sMoz/HwIc622Gqixe4Xee4tJWJVrBYjV7rPlpeVRaRR0coA0uO5y+mrdIx
         TP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760715357; x=1761320157;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jXEmmH8KoIy+3oXIIcxfKQybPt2IeFDnPMZ3gpQBr8I=;
        b=JZrnfMUZ0z8HZJ54kCyBaiuqjPhK7qdMcyzVW2i0+nsN9HOGUdSnlR9wAEWb4XXiED
         roK6RxmbR88iZN98OSZyHV7fXDPpL9u5j8jqFpTQ2o4Ad8+38UbiIZw3KmjYpcYhrysC
         GorQlvy1AyGgiSdVcTjQECnuhQpGowkr8HbYcNcimzECucdgZGhFIxBdWArD6B3f+qJh
         HcHqf9g5d8XlyiTFf02jIh45gXgVi0SWE8QHk5LoX/7JTNPtBGm6/z03YqS0fvgA5fG+
         cKEswLzQY8haimkXF4zvStezIvIHFIlDgD+uUShmx1tKHsiBwQlNHfcf/z3JjkAYA8BC
         7r6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7kvQMLxojcn4Dtmj3LBS2qb+JQoEUBHpLXqeHOYKoVaYWJsHb6dwpBEDN1F2ACPbiYNbzTR1jjs6kXvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvM2ztuV7WeaKsu+I/xOyc7GN9cABPemHGEsw2ul2H+IeIdCp
	dBKKCdJLfOvjriSFJ12yTuJnW19mouhA1ZCbq9szkaHPE01XJf8h9nmH
X-Gm-Gg: ASbGncvJ/EAJ0C/MEepqvDe/g/m+1TuoKKcR1PMJxxmipWnx+iCeDcnaNpTxwSk7dfw
	ftoGGivEEPOt8ow6topw+KdhjYa9/OxgfanVJOUYwfdYKJ50UT4EgvyTzCWq+bgNNPjh6O/QFUL
	fGg1l/35G8ql6QqUIpCh0nx1zhfw33wsJNoKnEiY12ANMbcbyiMzSjmfWH4MKnZc1egTP3gVbTY
	v7eRCgbvdrqqLwt+uAN/Th8xeNctGcARe4Th4FRWG76QR+WpvvNJc7nMjmKj+PETjGiNsMX6IGO
	eSv+p/OS3PuNrHNOVJiZdtSX/3TuyUcDpqGo6Bm+XHXZHLntv2skYR1NueycfV0QgZwgmcL/vBl
	VSSZZN8UIMIemWuKYzHZRJbZ81LdO6Ibk7MzIs1r6sO9L6fyWPPMIPEO4e3eUba4EWxDG9bhNeJ
	eSKowf/Q2oMwjWu5xcUw==
X-Google-Smtp-Source: AGHT+IFyT1Ik0zXeCGBE2QwHTLZmpbbOjcSgg1Wptb8qYhrZIBd25XN2NSqPB/D9VelyoqlG3l71LA==
X-Received: by 2002:a05:600c:820b:b0:46e:6d5f:f59 with SMTP id 5b1f17b1804b1-47117878465mr37367015e9.4.1760715357144;
        Fri, 17 Oct 2025 08:35:57 -0700 (PDT)
Received: from giga-mm.home ([2a02:1210:8642:2b00:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe69sm42472598f8f.32.2025.10.17.08.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:35:56 -0700 (PDT)
Message-ID: <336e169019bd3eadc475c981abef3db07149a5db.camel@gmail.com>
Subject: Re: [PATCH 1/3] ASoC: cs4271: Fix cs4271 I2C and SPI drivers
 automatic module loading
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Herve Codina <herve.codina@bootlin.com>
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
Date: Fri, 17 Oct 2025 17:35:56 +0200
In-Reply-To: <20251017171024.5a16da34@bootlin.com>
References: <20251016130340.1442090-1-herve.codina@bootlin.com>
		<20251016130340.1442090-2-herve.codina@bootlin.com>
		<60fbaaef249e6f5af602fe4087eab31cd70905de.camel@gmail.com>
		<20251017083232.31e53478@bootlin.com>
		<d6bd466a5d11b016183db0ac3c25185fad3036fc.camel@gmail.com>
	 <20251017171024.5a16da34@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Herve,

On Fri, 2025-10-17 at 17:10 +0200, Herve Codina wrote:
> > > > > In order to have the I2C or the SPI module loaded automatically, =
move
> > > > > the MODULE_DEVICE_TABLE(of, ...) the core to I2C and SPI parts.
> > > > > Also move cs4271_dt_ids itself from the core part to I2C and SPI =
parts
> > > > > as both the call to MODULE_DEVICE_TABLE(of, ...) and the cs4271_d=
t_ids
> > > > > table itself need to be in the same file.=C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > I'm a bit confused by this change.
> > > > What do you have in SYSFS "uevent" entry for the real device?=C2=A0=
=20
> > >=20
> > > Here is my uevent content:
> > > --- 8<---
> > > # cat /sys/bus/i2c/devices/3-0010/uevent=20
> > > DRIVER=3Dcs4271
> > > OF_NAME=3Dcs4271
> > > OF_FULLNAME=3D/i2c@ff130000/cs4271@10
> > > OF_COMPATIBLE_0=3Dcirrus,cs4271
> > > OF_COMPATIBLE_N=3D1
> > > MODALIAS=3Dof:Ncs4271T(null)Ccirrus,cs4271
> > > #=20
> > > --- 8< ---=C2=A0=20
> >=20
> > that's what I get with SPI-connected CS4271, and this is actually what =
I'd
> > expect (linux-next as of 2433b8476165):
> >=20
> > # cat /sys/bus/spi/devices/spi0.0/uevent
> > DRIVER=3Dcs4271
> > OF_NAME=3Dcodec
> > OF_FULLNAME=3D/soc/spi@808a0000/codec@0
> > OF_COMPATIBLE_0=3Dcirrus,cs4271
> > OF_COMPATIBLE_N=3D1
> > MODALIAS=3Dspi:cs4271
>=20
> So, this is without my patch applied.

this is the modalias of the device, it doesn't depend on your patch series.

I'd say that modalias for SPI device is correct but commit c973b8a7dc50
lacks MODULE_DEVICE_TABLE(spi, ...) in the driver.

I'd argue that I2C modalias is correct in the driver:

# modinfo snd-soc-cs4271-i2c
...
alias:          i2c:cs4271

But I still have to understand what happened to I2C core.

> I don't have any CS4271 connected on SPI bus to perform the same test
> with my patch applied.

--=20
Alexander Sverdlin.

