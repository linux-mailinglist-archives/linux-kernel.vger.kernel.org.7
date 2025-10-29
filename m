Return-Path: <linux-kernel+bounces-877267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C050C1D9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 23:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11F7834BA9B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB862DC77D;
	Wed, 29 Oct 2025 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7j/LnSg"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641F13FEE
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 22:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761777991; cv=none; b=MHZbVuvIfdvOEVi9fO/FcJT54bafb1O0pUf07/HTA5Ni0QT79snEyeDvxZp6HK0njdqhlHO/gZ8c+dwEQgyaBVNn4grv9jYEeRIJo1VWnyKcuGWKaaUtWqn5wL+0mPpdEmy0T5q1477YOBABxA8DTl46i3e0CZsrtJtwiGWCuG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761777991; c=relaxed/simple;
	bh=jOXVNBp21d6LAP5gElhEiaLtnhLBJdjWja+P/lcNTeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZZiEK3tF7zLAF19QL0VkBOCKz+1xh1PurpwbeXRoWBW5XHXHvdp9cD7UQ26lOp93IXGA71yX7OQTaFYvP0T53jfZPpS4VOfp/2iiC//sma8FF1m9zJrnAR4MrMKIWDzLnWjIh4r4gqO55UQxGO+SyOEo1E4ymZg/clJ5Ta+rYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7j/LnSg; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-427084a641aso316245f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761777989; x=1762382789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VF8ZKyr3ZTfy82XIYaeDjMzSL78nhQTOJhUiruXf8W8=;
        b=Q7j/LnSgvcxO6ESyZALzvWJUm4+RDRtHKO8OVEXY/F196jW7WWFrm5h4WkqUJkyALX
         NQtPxy4nqu2ZKs6Wz+agMTHfzZ8PTjDlG7SeI3HEUL0AwpwleEe6ClUP/1LrvkIWJ5xl
         ibfEI0ZPhdg1qjimuvDhCkwNSN0MT9LrdAjmjYVX75qgf/wF9xXm50Vkw1r2gvduDMxK
         VdFvAtkcrZD90u/7tGJzkBYOjAKhB1WJlWw1ZNkF1XRaB6UVIzqczrkXK3Q9Ne0tYMni
         YYwkbr3EGAqAuPtjgRhF64RQcsonSlfbAUi1GkOtSQmYEEPUPKERgMVr7GUXEAV8apon
         axsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761777989; x=1762382789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF8ZKyr3ZTfy82XIYaeDjMzSL78nhQTOJhUiruXf8W8=;
        b=H3TNAmAESNMzvXNzLBWFGs9iGGn2KdJJvxw3IuMaS1D6rYEkrMcdc4cHWE5iwk0m04
         ZgQ4COD3fx07Kf4pIMxfiSc5ZYZtYUPo8K7nDmi1d3tKiZ2SC9TQVux9JmV56jjWKsUk
         JEDK2kxGMfxp0nShFiJy7feJ+J7fMND2NwPivL56QuGH6yeCa/6DtHL6NmfvR54aI6cj
         vYGvoNyApEtHhb8rWO4OtK1ir85K5N/PhSs5j2AHOwX6cfSChrzwWYCCsER6GlIRA5J+
         9E18gJJDGhKvpGgcCN/C6HNDX3sUrEH4LHPJT1YylwvG1VBiVYeqgp6321yPQar6ltG7
         EBdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPO20caiMXB7q+YpVpddD9f5+zt+z9aNUCdu+dwNjeZ7qcFXdfqSbEoDeOHNAvdZkt4ree9hmevvPdtUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqFrl81wQUNUs4b16hPAOpVSDIUkRlf4fliBZd9874XW9UjGZO
	K7Mn3gEakZXYIlm/kic6ZgOgZJGy+Tp534k9puN+sAYq1sz3trZ1gmGX
X-Gm-Gg: ASbGncsAvzBgfdn55cV1Lo7hWkwsDWWtzETYTBABTSrSP7WRxeP6xqZU1N7qkGkFzet
	afyHkpYMsnSAwQ9Vc5D5MjN1m2x1Z20fft8mKBoBIVRpYICc7B7aK3tNisGT0prdzjbyd6AqCQl
	5aVDOBc8OqLcrpqQ7dENnPkfGfA7LVGRx0+dkmuMJlSQqdqd4hrPAPM6HVqYnuXYOxs+1da6idO
	rXxY8ApIZp5gjPlCbhDjYEJK65whFjB5WXR1YTBcstEnAU1JK061jzctLOj6oP0GLspgzCOCNyp
	xbuhecfdmQMYQaIBFEDFAKWVX59IJ3ylh6D8XpMjK9UwdJ1bC9O0tKCHZqz5S8j1yX+INTzA9xs
	a1EwrHWkCi5dXkA58akayfThCp0/Dqo4Wzn7i5vwinXjN1ejOwA2IE8RlAD1lro1lnHeHyabs8T
	t99exL6j2p1xMnZZAf8FprIlenYaxOcWSjs6Hir6KgcXA=
X-Google-Smtp-Source: AGHT+IFIbAtMObhmtPyCgMPcO1Opp+Xy+pPXm2lE4u/n9a432p5A5AvgL2F2qHUK5dDeTjGyXPbmEw==
X-Received: by 2002:a05:6000:18a7:b0:428:3d75:b0e8 with SMTP id ffacd0b85a97d-429b4ca2941mr936653f8f.62.1761777988338;
        Wed, 29 Oct 2025 15:46:28 -0700 (PDT)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([78.211.131.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb7d1sm29049186f8f.16.2025.10.29.15.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:46:27 -0700 (PDT)
Date: Wed, 29 Oct 2025 23:46:05 +0100
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: mpl3115: add threshold events support
Message-ID: <20251029224605.3ixkvmmkm36iwh22@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20251028213351.77368-1-apokusinski01@gmail.com>
 <20251028213351.77368-3-apokusinski01@gmail.com>
 <aQHPUQ5bU7sFojul@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQHPUQ5bU7sFojul@smile.fi.intel.com>

On Wed, Oct 29, 2025 at 10:24:49AM +0200, Andy Shevchenko wrote:
> On Tue, Oct 28, 2025 at 10:33:52PM +0100, Antoni Pokusinski wrote:
> > Add support for pressure and temperature rising threshold events.
> 
> ...
> 
> > @@ -322,7 +339,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
> >  			.storagebits = 32,
> >  			.shift = 12,
> >  			.endianness = IIO_BE,
> > -		}
> > +		},
> > +		.event_spec = mpl3115_temp_press_event,
> > +		.num_event_specs = ARRAY_SIZE(mpl3115_temp_press_event),
> >  	},
> >  	{
> >  		.type = IIO_TEMP,
> > @@ -338,7 +357,9 @@ static const struct iio_chan_spec mpl3115_channels[] = {
> >  			.storagebits = 16,
> >  			.shift = 4,
> >  			.endianness = IIO_BE,
> > -		}
> > +		},
> 
> Just a side note below, no action from you required on this!
> 
> Yeah, yet another reminder for the comma/not-a-comma choices made initially and
> why it's important to follow the advice
> 
> > +		.event_spec = mpl3115_temp_press_event,
> > +		.num_event_specs = ARRAY_SIZE(mpl3115_temp_press_event),
> >  	},
> >  	IIO_CHAN_SOFT_TIMESTAMP(2),
> >  };
> 
> ...
> 
> > -	if (!(ret & MPL3115_INT_SRC_DRDY))
> > +	if (!(ret & (MPL3115_INT_SRC_DRDY | MPL3115_INT_SRC_PTH |
> > +		     MPL3115_INT_SRC_TTH)))
> 
> Can we rather keep this split logical?
> 
> 	if (!(ret & (MPL3115_INT_SRC_TTH | MPL3115_INT_SRC_PTH |
> 		     MPL3115_INT_SRC_DRDY)))
> 
> >  		return IRQ_NONE;
> 
> ...
> 
> > -	u8 ctrl_reg1 = data->ctrl_reg1;
> > -	u8 ctrl_reg4 = data->ctrl_reg4;
> > +	u8 ctrl_reg1, ctrl_reg4;
> 
> > +	guard(mutex)(&data->lock);
> 
> Why this is moved? Before the access to the data->ctrl* was done without
> locking. Is it an existing bug?
> 
Since this patchset adds `write_event_config()` in which CTRL_REG1.ACTIVE
and CTRL_REG4 are modified, the lock now needs to guard the read of
data->ctrl_regX as well. Otherwise, we could have e.g. 2 concurrent
threads executing `set_trigger_state()` and `write_event_config()` that
would read data->ctrl_regX at the same time and then one would overwrite
the other's values in `config_interrupt()`.

In the current driver I don't think there is any bug in here. The only
place (except probe) where the data->ctrl_regX is modified is
`config_interrupt()`, called from `set_trigger_state()`. If we had
concurrent calls to this function, then the final values of CTRL_REG1
and CTRL_REG4 would simply depend on which thread is scheduled as the last one.
With the `guard(mutex)` before accessing data->ctrl_reg1, the situation
would be exactly the same.

> > +	ctrl_reg1 = data->ctrl_reg1;
> > +	ctrl_reg4 = data->ctrl_reg4;
> >  
> >  	if (state) {
> >  		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
> >  		ctrl_reg4 |= MPL3115_CTRL4_INT_EN_DRDY;
> >  	} else {
> > -		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> >  		ctrl_reg4 &= ~MPL3115_CTRL4_INT_EN_DRDY;
> > -	}
> >  
> > -	guard(mutex)(&data->lock);
> > +		if (!ctrl_reg4)
> > +			ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> > +	}
> >  
> >  	return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);
> 
> ...
> 
> > +static int mpl3115_write_event_config(struct iio_dev *indio_dev,
> > +				      const struct iio_chan_spec *chan,
> > +				      enum iio_event_type type,
> > +				      enum iio_event_direction dir,
> > +				      bool state)
> > +{
> > +	struct mpl3115_data *data = iio_priv(indio_dev);
> > +	u8 int_en_mask;
> > +	u8 ctrl_reg1, ctrl_reg4;
> > +
> > +	switch (chan->type) {
> > +	case IIO_PRESSURE:
> > +		int_en_mask = MPL3115_CTRL4_INT_EN_PTH;
> > +		break;
> > +	case IIO_TEMP:
> > +		int_en_mask = MPL3115_CTRL4_INT_EN_TTH;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> 
> > +	guard(mutex)(&data->lock);
> 
> Similar Q here, why do you protect data that was (still is?) not protected before?
> 
Same situation here as in `set_trigger_state()`
> > +	ctrl_reg1 = data->ctrl_reg1;
> > +	ctrl_reg4 = data->ctrl_reg4;
> > +
> > +	if (state) {
> > +		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
> > +		ctrl_reg4 |= int_en_mask;
> > +	} else {
> > +		ctrl_reg4 &= ~int_en_mask;
> > +
> > +		if (!ctrl_reg4)
> > +			ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> > +	}
> > +
> > +	return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);
> > +}
> 
> ...
> 
> > +static int mpl3115_read_thresh(struct iio_dev *indio_dev,
> > +			       const struct iio_chan_spec *chan,
> > +			       enum iio_event_type type,
> > +			       enum iio_event_direction dir,
> > +			       enum iio_event_info info,
> > +			       int *val, int *val2)
> > +{
> > +	struct mpl3115_data *data = iio_priv(indio_dev);
> > +	int ret, press_pa;
> > +	__be16 tmp;
> > +
> > +	if (info != IIO_EV_INFO_VALUE)
> > +		return -EINVAL;
> > +
> > +	switch (chan->type) {
> > +	case IIO_PRESSURE:
> > +		ret = i2c_smbus_read_i2c_block_data(data->client,
> > +						    MPL3115_PRESS_TGT, 2,
> 
> sizeof() ?
> 
> > +						    (u8 *) &tmp);
> 
> Here and elsewhere, drop the space between casting and operand.
> 
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		/**
> 
> It's not a kernel-doc.
> 
> > +		 * Target value for the pressure is
> > +		 * 16-bit unsigned value in 2 Pa units
> > +		 */
> > +		press_pa = be16_to_cpu(tmp) << 1;
> > +		*val = press_pa / KILO;
> > +		*val2 = (press_pa % KILO) * MILLI;
> > +
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_TEMP:
> > +		ret = i2c_smbus_read_byte_data(data->client, MPL3115_TEMP_TGT);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		/* Target value for the temperature is 8-bit 2's complement */
> > +		*val = sign_extend32(ret, 7);
> > +
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> 
> ...
> 
> > +static int mpl3115_write_thresh(struct iio_dev *indio_dev,
> > +				const struct iio_chan_spec *chan,
> > +				enum iio_event_type type,
> > +				enum iio_event_direction dir,
> > +				enum iio_event_info info,
> > +				int val, int val2)
> > +{
> > +	struct mpl3115_data *data = iio_priv(indio_dev);
> > +	u8 tmp[2];
> 
> Use proper __be16 type.
> 
> > +	if (info != IIO_EV_INFO_VALUE)
> > +		return -EINVAL;
> > +
> > +	switch (chan->type) {
> > +	case IIO_PRESSURE:
> > +		val = (val * KILO + val2 / MILLI) >> 1;
> 
> > +		if (val < 0 || val > 0xffff)
> > +			return -EINVAL;
> 
> U16_MAX?
> 
> > +		tmp[0] = FIELD_GET(GENMASK(15, 8), val);
> > +		tmp[1] = FIELD_GET(GENMASK(7, 0), val);
> > +
> > +		return i2c_smbus_write_i2c_block_data(data->client,
> > +						      MPL3115_PRESS_TGT, 2, tmp);
> 
> sizeof()
> 
> > +	case IIO_TEMP:
> > +		if (val < -128 || val > 127)
> > +			return -EINVAL;
> 
> S8_MIN, S8_MAX ?
> 
> > +		return i2c_smbus_write_byte_data(data->client,
> > +						 MPL3115_TEMP_TGT, val);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
>
Kind regards,
Antoni


