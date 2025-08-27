Return-Path: <linux-kernel+bounces-788615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CDBB38749
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A32E4E225C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051113090C4;
	Wed, 27 Aug 2025 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdXySKoj"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AAA17C91;
	Wed, 27 Aug 2025 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310699; cv=none; b=eS7U0CIb2+1WTu2QJ5GccEQe+WG9nuxEpol0N9aY4re/XpT0VPUMxmYlORoo0ZtmslwVo52U9RwyTI6c9AkHeiHh16fvDU2Tlf4NAkzY5exGp11ZWV0b/VdZolqs+UlN38knZJ81o1bu0K5unVG7jjDH20TDVm0C5RKp3h5cYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310699; c=relaxed/simple;
	bh=+W496T3KZweap+ELZ3ZrFcPesJjNCwj4MNGY9V/0gGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzMe+mG61/OuQXrkEt15j4RnFmPcX9s5LOT30bXlUN8hmHb4jlDPE1GC9pnPrPPYwNeHCz2bBmg8s5R2jbzcCn20YxEG00kWzZ0J709NhS4nqVeSP+QTapPa2LtPu97+CmqkVhJajdq+ngkS92MMO3Z4eehbVq+VIiYh3ciT8vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdXySKoj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77057266dacso26938b3a.2;
        Wed, 27 Aug 2025 09:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310697; x=1756915497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vffvRG13APrqSH7IWKHSJsI3WUIeBFV9tAXYguyYiBw=;
        b=LdXySKoj5orZeLr9tx5zoqqZjC4SuHUPTzqmsjyFMzQs3Vyq9io/4p68K7cO9uQAcf
         jEjUp+p4zTQUDo9MuBLxUcJ9uwnbTmrrxd7PaW22VgfF8ZE/mBbO8rTnDsr7hqlqJCen
         0SkNlY9xsNoH/S/QWZL3IyCBHEwTys20dzCzvX7YciqVdy9RtPN+NFZQo03kmyMQbbuL
         xpExLLR1u5DIUpbHdfBebGQ3q+1rWRI8Hc2DNvODjF5K7yKSaiO/g3FwW4+xUsmf7Pup
         PDBbg6w4ndmAYesgtX5dBm3s3z1ZA3pu+sVG7iVd4/2PFGPIb3vP9KxOUBgu+YREV/VQ
         m5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310697; x=1756915497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vffvRG13APrqSH7IWKHSJsI3WUIeBFV9tAXYguyYiBw=;
        b=U2QTz5y6yEIeYIGJx+DPWvllfH4EKsueh3jr+VD37sG+g98aI3P9d71k9vehrzh+Ho
         xFxmu8ghIzfS28idUucigskTJ1Br6u5zdAloGVg+9FsqvXjU79YNBuv8lAtAOjSgFpHh
         BeRtunb5BpWAd2n9gM3bd4RUSwy5RDC4nLxdG+HZnfYDOG9Y/nVYJTfWkE7mgBfx6bF1
         fNtdzFyriHYqeymPMnWf60C+94UGq3bUjoVYBI05dxRMjND5k1ttSRPxVXQBZh1pf/AE
         cIMnccbq89s2ydwLnWVE4oM1+dnD5465SgMqrT+ao6ShigSipVBZas/5ZQNBm7jyM3Lk
         cWow==
X-Forwarded-Encrypted: i=1; AJvYcCVFco2BRbkBqzP9M14funYOGn0O1buE65bmoP1k8x6jy+ObPbsy08TGDX1CQDareb2peuZPWuFIwm16TF8=@vger.kernel.org, AJvYcCWYnNKo3O2kuARwQqboPZ/OAtWLvG6EwwF3sNFytHQRV5yd0cFE/d9EcpC/O6xnsuBoEpub7Nco2Egl/4E9@vger.kernel.org, AJvYcCX14w1woFNqcU+Va5iCIHf8XuVGEF38bnfZMjh25qypdkv7o5MX3l46KEGqRZml07aHMEZNhh6v37TN@vger.kernel.org
X-Gm-Message-State: AOJu0YzuHUMWSk/WUCeO4NHfpIAvCt8qBP4jy+1ODdSNe9IDczDGgcNi
	pSiPyKBDeLECpl6YesqcL1NpgUon2xkAZPEFmE5ZMh3mSxDf4F/dRODj
X-Gm-Gg: ASbGncsy/DWOVZqIY2zrraKBJLqIiomkttmRkdAXWfFeQS+6InbQzWRfdkJhQJuxdjF
	lqr+kLHTBC/uEPRPdZrJJa5FpIo8rP6GgoOXrqPtRtUerQsKhWxou7952NnT0WHhBACgMvC/bRa
	pJXYWHHDih7T4v5cTPX7xqZGC2ih/wrD/oADePPJam5O6hxoQzfJumiRc/ga5Y8AxiaASzy28a/
	zEi72kkkelcDs2v+TaWHYdtHkHOrJ/qxobOGeCBQDgKAlHZi+0vrAUKWVHM8kSdB9Cwb2u/Cb6B
	FT2y0TfP0D3fyowNK7tngH1b1E0cAS7Ig0W/8JHyEeRnAdoWWbPOrQ92fI0ChG5HNe97dkgJlWq
	qqrfpKzv+tc5hEtknsNkZRxyV9+8/s2LOIQVD1/fdctY6UA==
X-Google-Smtp-Source: AGHT+IEm2FAHPWEasWg3eew07hdsXjmBVFzXNOQYDSE2MP50r3zjMIG2xigPK+pgfzB43lzHwLMVzw==
X-Received: by 2002:a05:6a20:12c8:b0:240:2371:d003 with SMTP id adf61e73a8af0-24340cd311cmr30277615637.28.1756310695711;
        Wed, 27 Aug 2025 09:04:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afc11sm11747978a12.17.2025.08.27.09.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 09:04:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 27 Aug 2025 09:04:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (ina238) Add support for INA780
Message-ID: <4381440d-cd92-40df-bf4b-53ba629abc0c@roeck-us.net>
References: <20250808030510.552724-1-chris.packham@alliedtelesis.co.nz>
 <20250808030510.552724-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808030510.552724-3-chris.packham@alliedtelesis.co.nz>

Chis,

On Fri, Aug 08, 2025 at 03:05:10PM +1200, Chris Packham wrote:
> Add support for the TI INA780 Digital Power Monitor. The INA780 uses
> EZShunt(tm) technology, which means there are fixed LSB conversions for
> a number of fields rather than needing to be calibrated.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Please send me a register dump for the chip so I can add unit test code
for its support by the driver.

Thanks,
Guenter

