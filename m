Return-Path: <linux-kernel+bounces-889658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7387FC3E2A8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9C31887E28
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E0E2F9DAF;
	Fri,  7 Nov 2025 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+3wDGWh"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1881F12E0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480429; cv=none; b=lVwlHcMgQKgFmqfHH1qXl37R3JRpdmugycemaZ1UNrAY7MB2wLvrAv7Qc5x/8zCQ3bJMBS4qcGDgN44wcibxG57xo76uSBQssV9lj5+133kjYfvQU4nruBZGFzDDXH1maQLv3RRINY2xpbZRrmLJKDq9iBqggP4KwXhQ7rgQav8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480429; c=relaxed/simple;
	bh=q87xcR0fF564ia62mdHYwusdWAN6B+KzP9Ns05as0mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ4Z4mc5iM7faUiwqx7s0tNp0GRFTa7nx6fozx7scV/MVZk5vnv3DnJEqZ8isK03t7k62dHxyZGL61n/KAQ+FqybGhzyz7q4dXt2VKXG1rtwY/m4R0EgMlT4tj8y5odQ5UbKDSlmIDRsEg1YEnPuBNB+nwGum4Wlgz0bEPEfp6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+3wDGWh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-782e93932ffso207848b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 17:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762480428; x=1763085228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fDOKCxMylV7jhy3wGWnM3j+qZQ6bCToNFKqiv9ib6xM=;
        b=D+3wDGWh349cFx4pbS2qLuNnr/fVsT/HPgMvk60H9JXiylKe8Qjo1MrIlJlV7qby2A
         oXuEezBvq45RVUf3a/rJH1NcBd1kV7o1Za4VnbhhKBZ+T0em2P3bPWl0p1uHmd088fVI
         K5Hj7qNAg3o9+7rS63eAA7ktRH837exf8DjpR9qwMkrWVONdiDRbuLWTpzn4bEmJNc0e
         SgnO97bk7U77KClmYF996Ls5C1hU5+ny5mpEAdBJfR2R9dF4iInts7UEt2SM6nrs+KBW
         NVTC3FXOeUTDoacQof91BRnPdQMH8uxWO9rFaOSeuneLFlIMQKp5JAayrEswgZ8MCDVN
         l8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762480428; x=1763085228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDOKCxMylV7jhy3wGWnM3j+qZQ6bCToNFKqiv9ib6xM=;
        b=dMkNJloj1UGDsdeR4yBvR4SMOmYikMhYjQcMwmpCyS3M/f+vyX/dGJaEBfhDE6P5yr
         cqacQuQxuZ4SaUWgMlHizFx3fEPOxfpvLR3kjdAZJwvuRC6b37WvY3IdmtITtGl40e1G
         Uua3dEvOgUlihb2ZIbzHFjHRFTXmIhmHHsjsYy7RKgby9HR5koPLNBAr/cFDMltQWWVf
         RWZZVLxy3EzLuUvRUu2peCJ2FwqF6Nh8pzM64a8CwvM4YiRKG/GDrUdw4BHZHJvu9/b3
         JFLxDOMfKnkWopEoZVYTcoLEf0kknrK9RAVI1X8TF9bRtJNENWFL4gDNGtKvgMmoATqJ
         pisQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJPVATVFFE/Pu2fPQpgtDP1tN4KjdfZW0pJfqfCJX2RPo/59znH97wA0/ilPmaFtNCLzGVPpf0pcsr2Gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOKLw5jBQhOf/QsvfllnAi29lxVR6bOVelIJ/F5uixn08i7Irn
	QlxOvuTbNlpL131BeUb++xQWbyLgAQNOWM7M6P7kR4vIYb4J2/zj1dWH
X-Gm-Gg: ASbGncszHARFGR6Ny96LJmTmbYzMdUSguABBW661aTp9CYW38EhE1uf+H7F4JvQncel
	Y3OdZwBaxH7gcMqMI3O7QyXZHC0DNA0YnIU0Sq28ebDwy8I7zuI8Y7/jZl2apK/L3Na5FHZroop
	mxiTlETuooQ00BfPDnlNVoj5NbrjHE1O+vGvcRaAUbCnGEgZHgFGADgy3SoKPRKb0SYNtqMzX27
	/ai2f+9Jp4gRxmwPabHNKjAFllxgfmJvYBV0sZheBUlNp1RrX5GD/e31xv7SY6DqcWJMt4Yznlx
	7ulDYntAU3gZ/YugbjMSeNo2gNvqAZ0BqiV6qKxSNP/GTMyrFoq0M+uU6uaf61Ele7CP3FJ/bpC
	AwtF4YDstPSKpZCNjpo/0rvaUsGUKNRwUfIbhlDyBi/cM+7iMeg6p/chzj75vbBWcjAH6U2L2w7
	/1GeVCB//k+Q==
X-Google-Smtp-Source: AGHT+IFB+Zl6zjqWsS0NOUSlCSS78ppjsDoqoEr+nv9M952CWuF2yyz0SdKRbGPURZsPlphRY2wjWg==
X-Received: by 2002:a05:6a20:6a13:b0:342:6c97:3693 with SMTP id adf61e73a8af0-3522a772f7dmr2127084637.47.1762480427616;
        Thu, 06 Nov 2025 17:53:47 -0800 (PST)
Received: from localhost ([2804:30c:1653:6900:3b53:af9d:48d6:f107])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7b0cc179e7esm974255b3a.46.2025.11.06.17.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 17:53:46 -0800 (PST)
Date: Thu, 6 Nov 2025 22:55:01 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: mpl3115: add threshold events support
Message-ID: <aQ1Rdcbi3e8lzOvM@debian-BULLSEYE-live-builder-AMD64>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-3-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105095615.4310-3-apokusinski01@gmail.com>

Hi Antoni,

v3 looks mostly good to me.
A couple of minor suggestions in addition to Andy's.

On 11/05, Antoni Pokusinski wrote:
> Add support for pressure and temperature rising threshold events. For
> both channels *_en and *_value (in raw units) attributes are exposed.
> 
> Since in write_event_config() the ctrl_reg1.active and ctrl_reg4
> are modified, accessing the data->ctrl_reg{1,4} in set_trigger_state()
> and write_event_config() needs to be now guarded by data->lock.
> Otherwise, it would be possible that 2 concurrent threads executing
> these functions would access the data->ctrl_reg{1,4} at the same time
> and then one would overwrite the other's result.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
...
> +
> +static int mpl3115_write_thresh(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				enum iio_event_type type,
> +				enum iio_event_direction dir,
> +				enum iio_event_info info,
> +				int val, int val2)
> +{
> +	struct mpl3115_data *data = iio_priv(indio_dev);
> +	__be16 tmp;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	switch (chan->type) {
> +	case IIO_PRESSURE:
> +		val >>= 1;
> +
> +		if (val < 0 || val > U16_MAX)
Alternatively, could use in_range() for the check.

> +			return -EINVAL;
> +
> +		tmp = cpu_to_be16(val);
> +
> +		return i2c_smbus_write_i2c_block_data(data->client,
> +						      MPL3115_PRESS_TGT,
> +						      sizeof(tmp), (u8 *)&tmp);
> +	case IIO_TEMP:
> +		if (val < S8_MIN || val > S8_MAX)
this could also use in_range().

If you opt for the macro,
#include <linux/minmax.h>

> +			return -EINVAL;
> +
> +		return i2c_smbus_write_byte_data(data->client,
> +						 MPL3115_TEMP_TGT, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

