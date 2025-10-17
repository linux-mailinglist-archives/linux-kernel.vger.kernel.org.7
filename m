Return-Path: <linux-kernel+bounces-858682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26BCBEB69B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8708940183A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CFA23EA82;
	Fri, 17 Oct 2025 19:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBvNa1Ka"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902B23EA85
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760730827; cv=none; b=A2pCdtsQQS31HRoOw3pPA/4QjkZy952UcqTsDw/e/u9pmwg7JyjN4jdHh7Hh37m63rkwCY6n71vr+NRl3HHWac2Fc5ey5Zn5S4dZGknfis4sj2jkYqUSR+iWM5nYuIiARuCGGRs7loSTdZuaZ4uggdW5Uwyh35DxAYlMWq9EDgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760730827; c=relaxed/simple;
	bh=i5Hk7l6xoSrN+AXcpR4MGOF8Rj8+Hz0UPLQLCeNrNAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJMYYRgRGhOtq7ag1ztFTPvXuqO4oFbwKYXhVi/q5XxM4x6bZcHHKKZ+9Wc067O4Tz34SMKe7KJoyyCijer+VmilT1tXiK8iKTEHQbqFI/AhiklJQ9CGAmgpRY+FiEbOOeoTnqJe5CpwBxYpRuJ2OtmHrG70P0gsLRQdbWZBctw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HBvNa1Ka; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2907948c1d2so25224035ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760730825; x=1761335625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=66FjiNXaw8TmphFF9eNaWop8aMdiITfbjide+1BjBFk=;
        b=HBvNa1KaWts9c2rgQWDkU20KWOrpUxl8AmeijyxnjLCTYQ+yX8wZwQBP1+mInRgJU/
         nDuIMZ3LOacOaNqmO7/rDisXD7QbkgKSFnhRI3vVVV2Rk1Zocd6Qg9ZsXe6kr8D2gTcZ
         yZ5aK+e3qiqVvqypWxOyx0mIZhNcq+NGNtCk1v9VxxGpqYuGZg+F6BH4qArboXz8CpIV
         k3UWekdRN1beDAIdt1uztpZWQ+dLekrvQbUbekmVnrXh5+tjezrS/7+76K8oSX1SRV/c
         EmPO0qDPVpbbDsgTiy8wuNSOAllCtDjcSHPkQ11Pb7VSZ8oUW862fefddu+fzKlY9raP
         5exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760730825; x=1761335625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66FjiNXaw8TmphFF9eNaWop8aMdiITfbjide+1BjBFk=;
        b=StVnAe1EkVGwy4dikPvliOaL+KsutPLI2sum4m5Ow1yXd9uyGKsuFtvJsmBK6I7jlf
         dwQ2/p0owNAB7DNaiKbV72K917IEtMg7QpWvaUBnVSNn0HR+RBaznn41YPmKMmFxOXdn
         Pyeer+gHOBX//KelF8KAxHXC8a2YgwstDG+2cx8NU5k1kRCegLcGx7UotfeWdhM8toAn
         Q5ijWLBxKBmQYZQB284gWJASLGYb6i5nK6/puw0UfPA48eJtI9nS5LRoLs4ADBUd5s2U
         pQvg2rZc90r5fvMZkdKXG+ZqNGQdMfHAU2q7kNn+RCv7Egh4SCvyX+17BF33/GwjwzR1
         ItGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEuhtNyg4R3ycPmWY+SJEBKoLY6llh4tsRWEuS8ZXhc3AKVhLs0gPathY/GKRwuO5Div76zUq6YQRUyOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Ww5qHCK4bb+e8ukKWw+53WvRotGrsupQ7dgz+yzzrr+yJsQ/
	hM8FoiYeuUCrBysvTgY7y00+jiRXOCxzroQNV6nbdHCAPAmGw4gIzBl1
X-Gm-Gg: ASbGncudPY3XWnOFLAiC1XhmtVVEfsCjk6JO2rujUfYGHNpDAiad3AaSzMBgHwDokqP
	YkvBQjQdy1GBPqE+qo7SdQIchtiY+wcw7loeS//sbO5U1NwVg3wREbEZGm2b836gXtZPLfuxZww
	KdQuQcX4CbFri5ENlRMm9JMjyLyTuj8h6tiaJyAx0dWqQl7gWH84xRkvveEIcujk6fmMS2XGuMh
	awn2hH+b6pdWdClA5HVa+zdVdto1pDNCjUfFOF3+mMQtlYZ5CTUNUi2vLTwls+I5dLckRtyr45m
	f/FLCX5CaD0DSJ3tcKCi7DkocZTY7CQ6SgkR34dqXJdpBJEvUvZCA8hBsL9nd7osevNvF81Kfrf
	LVaKsDtqauJyaO/CZdb7zG2r3yoZ0Oxwp4Flr+qDM+grG5KVtaxoWceScjndvqzVzOSlB56XcZu
	X0LkvP5/i4WWgntyyz6JPANe7WqGBkzXU=
X-Google-Smtp-Source: AGHT+IFmw4xfU96UxI5JCpiksAaEuctIniSQG6RkIj6XxJvpDrHo87ypYEHktyPgkIumG9POKqgUKQ==
X-Received: by 2002:a17:902:f550:b0:269:874c:4e48 with SMTP id d9443c01a7336-290cb65ca69mr70425735ad.47.1760730824956;
        Fri, 17 Oct 2025 12:53:44 -0700 (PDT)
Received: from localhost ([2804:30c:402b:1a00:ec78:db53:a246:207a])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-292471fd9ddsm3303605ad.89.2025.10.17.12.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 12:53:44 -0700 (PDT)
Date: Fri, 17 Oct 2025 16:54:49 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, Trevor Gamblin <tgamblin@baylibre.com>,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v5 5/7] iio: adc: ad4030: Add SPI offload support
Message-ID: <aPKfCbZSXxaHICel@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
 <c12569f251962ad6034395e53cd6d998ce78a63f.1760479760.git.marcelo.schmitt@analog.com>
 <5e3a1d31f3cec340650e2e63db79903b78ab9a1f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e3a1d31f3cec340650e2e63db79903b78ab9a1f.camel@gmail.com>

On 10/17, Nuno Sá wrote:
> On Tue, 2025-10-14 at 19:22 -0300, Marcelo Schmitt wrote:
> > AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> > samples per second (MSPS). Not all SPI controllers are able to achieve such
> > high throughputs and even when the controller is fast enough to run
> > transfers at the required speed, it may be costly to the CPU to handle
> > transfer data at such high sample rates. Add SPI offload support for AD4030
> > and similar ADCs to enable data capture at maximum sample rates.
> > 
> > Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> > Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> > Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> > Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> 
...
> > +static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4030_state *st = iio_priv(indio_dev);
> > +	unsigned int reg_modes;
> > +	int ret, ret2;
> > +
...
> > +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> > +					 &st->offload_trigger_config);
> > +	if (ret)
> > +		goto out_pwm_disable;
> > +
> > +	return 0;
> > +
> > +out_pwm_disable:
> > +	pwm_disable(st->cnv_trigger);
> > +out_unoptimize:
> > +	spi_unoptimize_message(&st->offload_msg);
> > +out_reset_mode:
> > +	/* reenter register configuration mode */
> > +	ret2 = ad4030_enter_config_mode(st);
> 
> nit: if ret2 is not being used at all, maybe just
ret2 is logged on the error message below so I guess I'll keep it as it is.
> 
> if (ad4030_enter_config_mode(st))
> 	
> > +	if (ret2)
> > +		dev_err(&st->spi->dev,
> > +			"couldn't reenter register configuration mode: %d\n",
> > +			ret2);
here we log the error code. We only reach it if reg access fails after
something on offload buffer enable have failed first. We cannot reuse ret here 
because we would be shadowing the original error code.

> > +
> > +	return ret;
> > +}
> > 
> 
> ...
> 
...
> > +	} else {
> > +		/*
> > +		 * One hardware channel is split in two software channels
> > when
> > +		 * using common byte mode. Offloaded SPI transfers can't
> > support
> > +		 * software timestamp so no additional timestamp channel is
> > added.
> > +		 */
> > +		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs;
> 
> Maybe I'm missing something but common mode is not supported for now so isn't
> the above wrong?
> 

Yes, that was buggy. Dropping common-mode channels as last minute change was a
bad idea. I did another set of tests with ADAQ4216 and fixed that for v6. I'll
also re-add common-mode channel support as a separate patch.

Thanks,
Marcelo

