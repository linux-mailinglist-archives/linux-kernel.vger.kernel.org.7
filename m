Return-Path: <linux-kernel+bounces-788447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE8AB38483
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 622334E1CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAC72F3C0E;
	Wed, 27 Aug 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PB7mrJ3g"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2635A293
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303905; cv=none; b=OuSL9GWKvf+LPuDK0qzyjwN5srl84T2j0us5UqaxQgaJncrSBrKeB12QT/7DkpwXxgsMz8oZ6P4RZNO7dk8VI1Z2MsVfMqejsNZvJ17y3cAhjD1S97k3GLR4kNzYSaDu2Cn/u5jJ2sCWQSXATgD8oGffESoQLWJmOQSNexZ4478=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303905; c=relaxed/simple;
	bh=EDozGPUpvYJuuXzm7nob+gG7cbwaHnhY+kQ5YXHli5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sD7d7QIJIKonTsEIeXDS0XBcBWKnm7kB6n0IIAsXZPrmsiH5TRX1sDtfmUxOg6nNFlfcsv02v879WyAOSM7lHi45p4mkTeTci8m+us/khv+4qr+dB/7AyKu6Bhi/TdKO0CkFuGk7AXD6zUDSibjuqAM+v5kyPLYvH15yCDnZj4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PB7mrJ3g; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b4d892175so35055025e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756303901; x=1756908701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMePyw9O5KE5+I+55ZDooMs3QSwvO9W807m9fzQ8hRU=;
        b=PB7mrJ3g5ExcF5afrqX77NKUf8S3ghtAMeMt01mwFWhElDtu0fN5a+B0VWExO8dz1f
         RDGi1nu6Y+jM9cZnflNemGCb3xETg1rLPnN8kbzmjD136Y8/vldpPDPV2b40HIwhorfW
         cZhoS/wTOasjGp/CSwuzDEmwLXFVMEqf9Cc1H9zZBXBZEZxG7I4GYYAIuCqfJd/sb2dP
         1xJLiPS7740iLBpDUZEOqIs2Ca5ORpPcSdwKhgibuW1kRMx4pxtmchYzguH7reXOl4/b
         3nJjLM8E80V8OhW0SNP9QHBMfsvA+t4b6UthFIowCdF6jQovxX4zfrEBe6AAnzCEM7dI
         hcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756303901; x=1756908701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMePyw9O5KE5+I+55ZDooMs3QSwvO9W807m9fzQ8hRU=;
        b=FQFtrmkAEq8rk4VuV6MlcRjxyIYRSGlDeqluV5N3T9hhzNNPdTWF2O83XewFjdb/Na
         jra791HAjxYiOBvetc0QpmLp659J3FyBrXl5+/hQmrS/RQCP4Iqkni8//kZbTy0JAaCu
         ZmVcJ6RTRYEqxRqX20tqilQa8/OXBTNXyUGB7Rgucy4m7dl+Kb1/bQ76KmytG2FBlvk6
         yXoKaKz4s5YTR3dkP6SGHX9kxij2j7ZzK/gXWiY7NEywIgb9XNUxxIVHVFIXuat5ZVnu
         qA5exmXJyN14gL906k8/dY46dtlmRNX5ErMyNC6O4JIVFJmx66VQsH6SsbGsXQa9HB+m
         /aYw==
X-Forwarded-Encrypted: i=1; AJvYcCUkcCHvlVLdKxBV6UqdpUJL00R7o4lNz2AGp9hUMTUraDnN/PbiREU15tdq02PJ2rOWf07NpfEKveRno+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSzYylc8E+WOURtTYv2o++B/MhHTma1A0A3ZrKqlCchH1DCPlB
	CqJfLBjo2wVKX/6Oec/eo4MHtqSJNzXbIdl/lbydaSYPYeoMB6Vl5xsV
X-Gm-Gg: ASbGncuQBUQxUor6u05k9kAeU4P6omKH3oakupa0XRYfmTFMD8Si1/uEtT3m8S9+S/a
	lvHJFTgVhfRS/Uyc9XNDA3wtPy9MfjaQ30GjOlMqkVW15/M62FkR4f+xc5PvanjT11098AVKiCL
	V6eMq6OyZXv5EYwjaLk+9SHoJ5QGdb9YIQ0srUUgNMQYgrIZOTavY6c14t5abH9wf/896q0CiOU
	mYcCxnm2Yj4aMP3frr1MLpIIyeckWGRhsi2ra7qynMv+RqvSnwZ+w6JQFnJYqsEFBXAKfGzov1r
	t5ai0MRZtnQ5t7k38w5Pog/5j3fuNJAhwYtodCGg19joJPHwUSpmkDmDC9LW8Hm8iUJvacAP4LD
	kT37ldkUhq74H59HSQv7DxctycW/I+QZtrP2Ouw==
X-Google-Smtp-Source: AGHT+IGssWzQE1qRhw2A96ZDXU9OUN21LRVg5+1RgRu9peV7czo27sICi7ARZbII5U0WPBJJyI0/+w==
X-Received: by 2002:a05:600c:3544:b0:459:d709:e59f with SMTP id 5b1f17b1804b1-45b5173f9d3mr156334235e9.0.1756303901246;
        Wed, 27 Aug 2025 07:11:41 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0f320esm32693575e9.16.2025.08.27.07.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:11:40 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:11:38 +0200
From: Dave Penkler <dpenkler@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	gregkh@linuxfoundation.org, matchstick@neverthere.org,
	arnd@arndb.de, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, marcello.carla@gmx.com
Subject: Re: [PATCH v2] staging: gpib: simplify and fix get_data_lines
Message-ID: <aK8SGpevZsGM5CCF@egonzo>
References: <20250827113858.17265-1-osama.abdelkader@gmail.com>
 <aK73HPDKu6rqg9Ya@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK73HPDKu6rqg9Ya@stanley.mountain>

On Wed, Aug 27, 2025 at 03:16:28PM +0300, Dan Carpenter wrote:
> On Wed, Aug 27, 2025 at 01:38:57PM +0200, Osama Abdelkader wrote:
> > The function `get_data_lines()` in gpib_bitbang.c currently reads 8
> > GPIO descriptors individually and combines them into a byte.
> > This has two issues:
> > 
> >   * `gpiod_get_value()` returns an `int` which may be negative on
> >     error. Assigning it directly into a `u8` may propagate unexpected
> >     values. Masking ensures only the LSB is used.
> 
> This part isn't really true any more.
> 
> >   * The code is repetitive and harder to extend.
> > 
> > Fix this by introducing a local array of GPIO descriptors and looping
> > over them, while masking the return value to its least significant bit.
> 
> There really isn't any need to mask now that we're checking for
> negatives.
> 
> > 
> > This reduces duplication, makes the code more maintainable, and avoids
> > possible data corruption from negative `gpiod_get_value()` returns.
> > 
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > ---
> > v2:
> > Just print the gpio pin error and leave the bit as zero
> > ---
> >  drivers/staging/gpib/gpio/gpib_bitbang.c | 28 ++++++++++++++----------
> >  1 file changed, 17 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
> > index 17884810fd69..f4ca59c007dd 100644
> > --- a/drivers/staging/gpib/gpio/gpib_bitbang.c
> > +++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
> > @@ -1403,17 +1403,23 @@ static void set_data_lines(u8 byte)
> >  
> >  static u8 get_data_lines(void)
> >  {
> > -	u8 ret;
> > -
> > -	ret = gpiod_get_value(D01);
> > -	ret |= gpiod_get_value(D02) << 1;
> > -	ret |= gpiod_get_value(D03) << 2;
> > -	ret |= gpiod_get_value(D04) << 3;
> > -	ret |= gpiod_get_value(D05) << 4;
> > -	ret |= gpiod_get_value(D06) << 5;
> > -	ret |= gpiod_get_value(D07) << 6;
> > -	ret |= gpiod_get_value(D08) << 7;
> > -	return ~ret;
> > +	struct gpio_desc *lines[8] = {
> > +		D01, D02, D03, D04, D05, D06, D07, D08
> > +	};
> > +
> 
> Delete this blank line.
> 
> > +	u8 val = 0;
> > +	int ret, i;
> > +
> > +	for (i = 0; i < 8; i++) {
> > +		ret = gpiod_get_value(lines[i]);
> > +		if (ret < 0) {
> > +			pr_err("get GPIO pin %d error: %d\n", i, ret);
> > +			continue;
> > +		}
> > +		val |= (ret & 1) << i;
> 
> Delete the mask.
> 
> (I wavered on whether I should comment on the nit picky things I've
> said in this email, but in the end it was the out of date commit
> message which pushed me over the edge.  I would have ignored the
> other things otherwise).
> 
> regards,
> dan carpenter
> 
> 
This patch seems unnecessary.
The code will never be extended.
In the unlikely case of errors it will produce a huge streams of console spam.
It negatively impacts performance:  114209 bytes/sec vs 118274 bytes/sec.
regards,
-Dave

