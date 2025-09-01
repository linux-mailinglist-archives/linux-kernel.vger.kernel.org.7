Return-Path: <linux-kernel+bounces-794602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD245B3E3CA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A151C1780B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174A4334374;
	Mon,  1 Sep 2025 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Awce9pZ6"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB62D3314B7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731436; cv=none; b=hrDg28R4mHsqT2lc/CN3lfNG8dCIwoImmCwmOFXh/71ijrosgbY0LtKldwBmM6zxJtne+5xpvIxjGi6ZuGaTETm8hpLHblPYR/6dtTYGKdN5VdzBSECrElWzJwwmBUN7JNiMQD46XFeG+3nEo1HpM6dOjOpaP5zZMoAi1A9fuKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731436; c=relaxed/simple;
	bh=LA2Cde+xwNLHGVNxK+nOoJLLEK4E0j9VLsGVDb7DoCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDDQk6CCCt8htTGXTnj4RqxtgSI2F3B55lQr5JOwE+neKw4TxCJ1vaBQFoC+g3e1NS7+3NsOXZGqSzwBAhp+VH3OzZC3lOA876AuxBRtoI+Y3BDWSbpq2/jIdmW8Kr+sCoGYwfpldUkg2690LPArpKbI4HLBzrc3w6f9aSd04fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Awce9pZ6; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3d17f24d42fso1671506f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756731433; x=1757336233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6CcZZgmXTEgXi67UOd8flewdG478TxsuC7DDhDV9EhI=;
        b=Awce9pZ6KKPpqfDStm6grTv6TraGZ2p8PretycNa9sV5G3eSgzJvqpCJcm8gV4EWSb
         D5toCoTaOa8VA6BgR0rFcZ5O3B9qFcROxZaOdj7gG9KYPw20eidJ3E3WYqsKcXyAWMpW
         7gM0nrHH0z+sVCJ3we8YL+x3i00B41E8hnVJ3c0R0J1Wh7vjKIh54G9yUl2s5C6rxy5f
         raqPU5Rg0x95su+ppJz8/HXtucfzq7cfw1S/8URMIcgPgOgFgh8fH8txVPpIgPjKzY82
         BgdVu6ALnGakh3TLcMPeozZ9SQg6/HpikTF1EP5P3UEMwUWbr6iqziC6DWj2tMd89Vv9
         OfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756731433; x=1757336233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CcZZgmXTEgXi67UOd8flewdG478TxsuC7DDhDV9EhI=;
        b=odFX01/jlJJHQpwl2gC+WGItuM+iIhffYDmxRrTHJbWmAhIuMZQHbj1mWFvfrA2Fc1
         dl5TeIe0x0ADbrn0T+jOuQUk6zG24JtC7Ztq+MSJnH+IZD0HopAS4uMoxPXrXsnliIz1
         564zAV5BpTSewNpP87038VZdbnTOGhrX8Rqm4Mz6bxCallr6GnKsvEa8H35whgWTICjE
         NGhxPSIK3Cj6SSk7ozKuFr61cXqkazqYcODXdKOKCvCckwmnBBAyqpyP+WFAtGfxLrwZ
         qOq2lizUX7dCG8evA8xdb5u/xsCXajee7nDOUWPw1Fadt0AHdjT0x3BoiNirtCXcIEsA
         +GRw==
X-Forwarded-Encrypted: i=1; AJvYcCVqJCjVmQEeJ3pKz2D9/4a0PU4AOmBUcUNMSQjSG2dHbPlsbkzT6BI6TXP0VN/LGPhOOgmQJXc/wNWo66g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw63420tbShoeQYWZG9H1R7mwnzau2JX4XWjucp/wN9HTaUOgST
	gCtINSjsxNeCEZsg7PqSV5p28vlhC4Pf93zYfHUn2+ZFbYVIAwRzSXXR3Lqks0KRMPk=
X-Gm-Gg: ASbGnctNwFVaicj0l6wZSWFQZTNEc9nP3h1FwSkd5WfBzXcZPa087mi6GAPAs4nzPK2
	ilVW80AycsB0h5nIYrY/5YuhmdjnNLDS3Fe6NpYebbYQRtOXH0Hdt+8Dvuxpi7EEB4FSc3oqTOB
	Ja+G2lvZ03r5IcGmEmBcHuBjVkDsXlb7W6KukAePyUr1CsrXgbSrPxjeharwUDOlHVYSrAAYj0H
	dtaY7hJ6lya8JeGy+sEAzxQDg2znffaO72mjNv/QH+v9voVMnwltA2xo5fxq8t9vVVAUqrkMDLJ
	V4kNw6EMT++N5zPk/BwnVjHwJUWLS78Dkf64ASyO6bIg8wHd4YjmQQ7G/BRz1u+W/hkOfvs7K8z
	lSqJMO0dyYWsv8qwingUw7ZU5rwACWa6iw8JAEg==
X-Google-Smtp-Source: AGHT+IFGr7/8/ZT9kzcrMvxG5Dy4K+Li2LIxqb9UOtAyrwkmZc8eBIyFR7BB1vat/tRDTqmJKwd0jQ==
X-Received: by 2002:a05:6000:4013:b0:3b7:94a2:87e8 with SMTP id ffacd0b85a97d-3d1dcb75006mr6117687f8f.18.1756731432991;
        Mon, 01 Sep 2025 05:57:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b87b38fcfsm51362895e9.0.2025.09.01.05.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:57:12 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:57:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: add mutex to serialize
 SPI/GPIO operations
Message-ID: <aLWYJKSDjNajmAlh@stanley.mountain>
References: <20250901065445.8787-1-moahmmad.hosseinii@gmail.com>
 <aLV0LBxD0KIHPSmo@stanley.mountain>
 <aLWULUIcYEz3N-Rx@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLWULUIcYEz3N-Rx@smile.fi.intel.com>

On Mon, Sep 01, 2025 at 03:40:13PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 01, 2025 at 01:23:40PM +0300, Dan Carpenter wrote:
> > On Mon, Sep 01, 2025 at 10:24:45AM +0330, Mohammad Amin Hosseini wrote:
> > > From: mohammad amin hosseini <moahmmad.hosseinii@gmail.com>
> > > 
> > > The ad7816 driver was accessing SPI and GPIO lines without
> > > synchronization, which could lead to race conditions when accessed
> > > concurrently from multiple contexts. This might result in corrupted
> > > readings or inconsistent GPIO states.
> > > 
> > > Introduce an io_lock mutex in the driver structure to serialize:
> > > - SPI transactions in ad7816_spi_read() and ad7816_spi_write()
> > > - GPIO pin toggling sequences
> > > - Updates to device state via sysfs store functions (mode, channel, oti)
> > > 
> > > The mutex ensures proper mutual exclusion and prevents race
> > > conditions under concurrent access.
> 
> ...
> 
> > > +	mutex_lock(&chip->io_lock);
> > >  	chip->channel_id = data;
> > > +	mutex_unlock(&chip->io_lock);
> 
> > > +	mutex_lock(&chip->io_lock);
> > >  	chip->oti_data[chip->channel_id] = data;
> > > +	mutex_unlock(&chip->io_lock);
> 
> > I'm not really knowledgeable to review the others, if they are
> > required or how the locking is supposed to work.  But these aren't
> > correct because we're only locking around the writers and not the
> > readers so it could still race.
> 
> Readers are in spi_write(), or what do you imply by this comment?
> I.o.w. I do not see the issue with the idea of locking and how it's
> done (I haven't checked all of the details, though).

Sorry, I meant we don't have locking in ad7816_show_oti(), for example.

regards,
dan carpenter

