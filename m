Return-Path: <linux-kernel+bounces-889352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D732DC3D5AD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 21:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF62E4E345E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 20:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6194F2FB98A;
	Thu,  6 Nov 2025 20:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmhIkOBZ"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E0F2FB62C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 20:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762460930; cv=none; b=Xhv2npz/Rm6RH5EHj0qcjY3XWKIeYdWW5tt7JhZvEFdYirJY/eO4L6+eoJjHiYc3NLvqPpKW8p9f5Ol1jlSDyWsWJtpf0VgyNkPq5iu4n48sqBDkPybvdk9nZAVMFfsYNh+CzrA1BzhBmljF/pVNa2LmtoLmOj+GzdNrl/ttBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762460930; c=relaxed/simple;
	bh=B4MV3a78BmAOsDcZT7VlxQ8YoFXZlfgiZoml033GCjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ji7rFbi2YEC6ohGMxsTorYW32D7cLuvYNICpWIGwXMaAR9nybk+UrSYpGOyc4EGqBZ/VDGB0rFKwCHjnJSdp4r8kPpY0RZM60hcXOw9FvZ3ngUWlgHEvZui4hPobFS4eIqc1QzLmhTwTD5jiAOm+olGGsUQ16WoEuZ63YvoE+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmhIkOBZ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso27495f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 12:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762460927; x=1763065727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HhPIfP8De21bOH+Y4KvdOsnM2WwwWLHXmrn7DnA7LPU=;
        b=MmhIkOBZTphXlxRYnteH2IhD6m4pob6tyZFMEchoQJHTNdGPmbEm0YtQj6VGvGf930
         upZri9Z6wA8do06fVQYkp17XzkFuCRmyb+5qiQHXO/1lrGcJgqWqNYz0cuSbdHcqn8A1
         xMDY3+oFgIZGDVvciWn2NejZ4Ito54ThOmH/6LgJYW8UcMMi/QSJUcXFzSYEOCg/oOoT
         62OUYlG4m96HyB4CdBbBkkSgPMz8uoWo80yaCgEYSWFgzAXl/Tlm9UVnH7fiEaOeaaV7
         jdCYedRzMVm1JyUKgM2iEVh8KKcIV5jPMIuWWG0TIWiM7UW7f5QjJlmAP+op6u4GsL9S
         JqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762460927; x=1763065727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhPIfP8De21bOH+Y4KvdOsnM2WwwWLHXmrn7DnA7LPU=;
        b=TdgABKq5wKAh/EfdmLEO5xDUOEHreb6uWvmhVhG5soiAsgvK5YETn1PGMu4ruSJPlz
         Xn3Qk9gNe320kkV3P2rg7JrpozjQ04Vk3qOvUwq81O1wMqP5InX6/aFAlKGU3H+p0Nl5
         i0qlBBn5TwdaQxoCJyy0jJyKZmSzOm9fRmj6WZ6tWOFvk7QGHKEFVhIz2Xaq6tlHYN6n
         NxpVqF1OahJsTjOWn0+tnosOpzmzOehgkpbMJ0e+JDulLX/XA/sbE1sQxTHhr0FTXpZL
         iKKf386GhJ5p936/5LTWbDjFBNA8jR0yQH6xbNtsdEckLjRfF1pywQImIAI5h/sZAFtB
         Uikw==
X-Forwarded-Encrypted: i=1; AJvYcCWzn8ty+K7UYcmJFk/8S23nfhHP3KFYG/VkEK+lvKJ57TIXipnogo0S9prtCtT8EwP1SgA1x7NIdC3gLyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQ8zqPzDjeXfEMTwhyvghdaJ12hO4TFRis9E7VZb30bCcMtzq
	6Jv6cJ8nWdOu3PPnSWCCRmkOlrb+t3JeJfXiKhztcx0GtyTk6etu8vJU
X-Gm-Gg: ASbGncto1wWU3ww0OYo7H8Q+1y+vgOXfGWuF1z5JAIltacTMLtXM+b9IBsVbHkJOXUV
	EbD/7p7YX6K6bGrFVUnOrLePtpH/WHSw3s57jxk+ZsNYXpfr1K7AbGymvsfH3Urq5NTCbiCQhP0
	8Y9TFKDnCNp0GnFclXxEzk9gRiotCfE+WW+Oqj37YP8CHv0FFQkyYpXDA9kPBAsXnIrUSvvXyO1
	lxjOICX/a/rUvl2/YsB7GVDh+0QTFrLdK9/rTBQY4iCZya2ea5Gm1lDY0QWXc3l9NBEta8h54KB
	R7GKyn+OjJj8gfPlt1J/7FJkmzXPaDCDQoJv7eDU/w2Vsc0jy7TMLurIbT0BYMV+AWpqKQwmGei
	EQ5uxcLsAHgc+Eh/HGygtktC1h8h2mvlcK9oKa58tH/4QKtBmVJ76ZoPngnvlRdafgZR1mfZn+l
	PpLO2zRtU18AB8bipSVuKbz0QSB9Ya4OOESuWBv1KSKA==
X-Google-Smtp-Source: AGHT+IGi4oopRGqO7VlJNFJdPy+Tg07BkrBGU2k4ZbWfn30X2KSeolXIbSvjfrVYP9WC+iZ49D20iw==
X-Received: by 2002:a05:6000:4103:b0:429:c774:dbfc with SMTP id ffacd0b85a97d-42adc68837fmr419498f8f.12.1762460927240;
        Thu, 06 Nov 2025 12:28:47 -0800 (PST)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([78.208.193.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e13csm1001842f8f.19.2025.11.06.12.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 12:28:45 -0800 (PST)
Date: Thu, 6 Nov 2025 21:28:07 +0100
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: mpl3115: add threshold events support
Message-ID: <20251106202748.zuysikmqfy3mfacd@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-3-apokusinski01@gmail.com>
 <aQtsXcf_rHVdwqeZ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQtsXcf_rHVdwqeZ@smile.fi.intel.com>

On Wed, Nov 05, 2025 at 05:25:17PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 05, 2025 at 10:56:14AM +0100, Antoni Pokusinski wrote:
> > static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
> 
> >  	struct iio_dev *indio_dev = private;
> >  	struct mpl3115_data *data = iio_priv(indio_dev);
> >  	int ret;
> > +	u8 val_press[3];
> > +	__be16 val_temp;
> 
> s/_temp/$SOMETHING meaningful/ ?
> 
In this case I'd leave the "val_temp". We have "val_press" and
"val_temp" here so imo it indicates quite clearly that this variable
stores a temperature measurement.

The cases with "tmp" that you pointed out can be a bit confusing indeed, so
I'm going to replace them with something more meaningful (e.g.
"tmp" -> "press_tgt" in read_thresh() )  

> >  	ret = i2c_smbus_read_byte_data(data->client, MPL3115_INT_SOURCE);
> >  	if (ret < 0)
> >  		return IRQ_HANDLED;
> >  
> > -	if (!(ret & MPL3115_INT_SRC_DRDY))
> > +	if (!(ret & (MPL3115_INT_SRC_TTH | MPL3115_INT_SRC_PTH |
> > +		     MPL3115_INT_SRC_DRDY)))
> >  		return IRQ_NONE;
> >  
> > -	iio_trigger_poll_nested(data->drdy_trig);
> > +	if (ret & MPL3115_INT_SRC_DRDY)
> > +		iio_trigger_poll_nested(data->drdy_trig);
> > +
> > +	if (ret & MPL3115_INT_SRC_PTH) {
> > +		iio_push_event(indio_dev,
> > +			       IIO_UNMOD_EVENT_CODE(IIO_PRESSURE, 0,
> > +						    IIO_EV_TYPE_THRESH,
> > +						    IIO_EV_DIR_RISING),
> > +						    iio_get_time_ns(indio_dev));
> > +
> > +		/* Reset the SRC_PTH bit in INT_SOURCE */
> > +		i2c_smbus_read_i2c_block_data(data->client,
> > +					      MPL3115_OUT_PRESS,
> > +					      sizeof(val_press), val_press);
> > +	}
> > +
> > +	if (ret & MPL3115_INT_SRC_TTH) {
> > +		iio_push_event(indio_dev,
> > +			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
> > +						    IIO_EV_TYPE_THRESH,
> > +						    IIO_EV_DIR_RISING),
> > +						    iio_get_time_ns(indio_dev));
> > +
> > +		/* Reset the SRC_TTH bit in INT_SOURCE */
> > +		i2c_smbus_read_i2c_block_data(data->client,
> > +					      MPL3115_OUT_TEMP,
> > +					      2, (u8 *)&val_temp);

Kind regards,
Antoni


