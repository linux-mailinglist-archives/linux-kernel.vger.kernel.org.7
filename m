Return-Path: <linux-kernel+bounces-857971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2692ABE86C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7237350817E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E332C234A;
	Fri, 17 Oct 2025 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReV0lAbr"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D288D2E091E
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700878; cv=none; b=iCie6n2ismmVJ24hazKnciRXQ195YpaGa4eIzCD6uFcnKwxDyyFvCBuu2Se1VCTcOw95RKAQ7M9E9YkjfKTFwsUvtzyv+sl1ubUSiJiD+51iCj9phZqYblKJHGGfG4HSNCCCimZXzKbAI1j4p0FZKNmdZgTKkq4RCb4TR76ro4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700878; c=relaxed/simple;
	bh=xPKudPe20LVyFE+p3IxJr16x4wx/uGvtSa6tEowpGec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oATi7joR3j7wO/9FC5uUgc/Qlaq/nP0Ukx9w55Z9unzIjqeRendVFZmchQWh8eRibcPOGJamRXydW8JhAnapVS0gbz7jJ8fh5MveYFpd4nMkEBu0/tHd9aFh7VQKvDOB3yla1VLps+KxxTzMPyggzVc+wXtJlp3e/O2hCRQyJ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReV0lAbr; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso1729872a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760700874; x=1761305674; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYfAPtHB/RHiXWE9XxOgOmtRX2AfdTu8oaK5y1u+j8I=;
        b=ReV0lAbrEXLoA7ZSlXmh6jSMZz275urgTCRGceEXFqCRCX0VQT54AfF3hsM8TWVFtr
         FFXpYDARFTcKsWF9Jqn2rfqav0xnJb+eIQwEKp1IKncxnIF188wMUgG5m1EX/uS7Xq4W
         hYvJsZDQUbAsm4D/IXCsoQ+K4sBPGluodtQvePY7YDwv/TD+m20/Tn4qVIzNkuEUn3WS
         dmpJZDIauzCUvz4hJYTEDIf2tvp4fL7JroMNGwYZk2+QAcIPxuw5cygFMnlJAjgNwVAY
         fbcTtt71NozCqFaxE5dyUaGqEcOI1flztoB0QmBLxxC1+xgJwi9U6UM0okiiHHsQws9P
         ZcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760700874; x=1761305674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYfAPtHB/RHiXWE9XxOgOmtRX2AfdTu8oaK5y1u+j8I=;
        b=kbUtoXO82m6zabPBDRlVmYwuRf9OgplsS+13xRyhC1lbiOFBvQRDiVaPkMFqqMTARQ
         wPvG16xyvMk8m6rWGw2TnmTt2wHCOGmO3hhvLiRkc5C3iL+4t135+l7zAjav81i7b3Gy
         1HyjjelYNBR9uHdwq+3FkawLAs0ZfcnxbogbIkQexSRe0j4gxHuzQB1Sf/RhdSlj3tXq
         bBiYzywg/n0yrQxC4Tf1zJLb3tg9Xe3lA3sygaGRxHU4Vvg3f9x4F6lMmenECPb+8bGS
         ThiX4i/VzVYzGs0HiBMKxwcoI8jHlg3Hs4zG+oDX+HpUzZjUljMp3l/ZFQmr20bBMuMC
         Bpkg==
X-Forwarded-Encrypted: i=1; AJvYcCViy7CoTPfSPwjIR+HvZw2QrF5pMV7GkPORaL2bUWcAjRR9iBeZsKelslVVIbUll1p7qggDyMkZsJCz4vU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc7aADT9MQ3SykPYy+feLHVoeV5EnrA3ELQqCAzOD4pxhgQjcx
	eQez4CzJXnxSdiPqVvCBHef6QfqmWYA54e/n22DHcGXyQ0Lxx4MBoj6N
X-Gm-Gg: ASbGncuwKvZ5qHWkTwCZDmgMyODthAfmj9wuZ/lDVtNO9m9U3obmvdcFwbp6QeSjZIc
	QqQXVdsMtK5WFjmKlMjh1EkOWjg9TagXxObYRMC5ZIjiKmqJh4LJfyoKaCgIOda0Eyewro5ey3h
	chs5U5g09jBSVf87CLTTN0Dc//KzNmS6lrX2ybm0DYulQifvTc/QJMsLZJ0edQ1QjrTuMzojHgV
	0kT+zqeUZVJZr1cNbiIkeHUgo11QhPtygo8/nTIPXpKoH2/5IFhx/pUPrCDFSoOVWM5skwFVE1n
	2iU7SWiO+TYNxuWbraAAqEbxNdCzleXUDgO6I/3tzRQeZMddVWnE/rsaCK6Uhh4oN6uQWH9Qye4
	M6l3jAvUz8VKN1MTTruCtt3aKW8JMoJ5ALIoIyK1TW6g9+bzmy7onUy2TtYL6OmlwafY8eFrjUq
	F5GVtm5iFQiA==
X-Google-Smtp-Source: AGHT+IFWkL4x7nbwb+9Uvguh+3df9cfdWGeCUM99KzCsQewGs4kLcYRtKcEcc6/or/fk3QS39PWIIA==
X-Received: by 2002:a17:90b:2f8e:b0:33b:c5f6:40ec with SMTP id 98e67ed59e1d1-33bcf914840mr3603295a91.30.1760700874068;
        Fri, 17 Oct 2025 04:34:34 -0700 (PDT)
Received: from localhost ([2804:30c:402b:1a00:ec78:db53:a246:207a])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7992bc13543sm25483583b3a.35.2025.10.17.04.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 04:34:33 -0700 (PDT)
Date: Fri, 17 Oct 2025 08:35:38 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v5 5/7] iio: adc: ad4030: Add SPI offload support
Message-ID: <aPIqCrvaPQZg7Lo8@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
 <c12569f251962ad6034395e53cd6d998ce78a63f.1760479760.git.marcelo.schmitt@analog.com>
 <e677f27a-787a-433c-8516-99ff1d33f2c6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e677f27a-787a-433c-8516-99ff1d33f2c6@baylibre.com>

On 10/16, David Lechner wrote:
> On 10/14/25 5:22 PM, Marcelo Schmitt wrote:
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
> > Change log v4 -> v5
> > - Made Kconfig entry depend on PWM and select other features.
> > - Reused ad4030_exit_config_mode() in ad4030_offload_buffer_postenable().
> > - Dropped common-mode voltage support on SPI offload setup.
> 
> Curious why you chose this. I guess it will be fine to add it later
> if anyone ever actually needs it.
> 
I had coded that in a way I think would work for the dual channel devices, but
it didn't really work for single-channel adaq4216. And yes, if anyone asks
for offload with common-mode data, we shall probably be able to it that later.


> > - Adjusted offload trigger period calculation.
> > - No longer setting data frame mode from ad4030_set_avg_frame_len().
> > - Rearranged code to reduce patch diff.
> > 
> >  drivers/iio/adc/Kconfig  |   5 +
> >  drivers/iio/adc/ad4030.c | 425 +++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 416 insertions(+), 14 deletions(-)
> > 
> 
> ...
> 
> > @@ -512,11 +643,30 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
> >  	struct ad4030_state *st = iio_priv(dev);
> >  	unsigned int avg_log2 = ilog2(avg_val);
> >  	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
> > +	int freq_hz;
> >  	int ret;
> >  
> >  	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> >  		return -EINVAL;
> >  
> > +	if (st->offload_trigger) {
> > +		/*
> > +		 * The sample averaging and sampling frequency configurations
> > +		 * are mutually dependent one from another. That's because the
> 
> s/one from another/on each other/
> 
> "one from another" makes it sound like they are independent rather than
> dependent.

Ack.
> 
> > +		 * effective data sample rate is fCNV / 2^N, where N is the
> > +		 * number of samples being averaged.
> > +		 *
> > +		 * When SPI offload is supported and we have control over the
> > +		 * sample rate, the conversion start signal (CNV) and the SPI
> > +		 * offload trigger frequencies must be re-evaluated so data is
> > +		 * fetched only after 'avg_val' conversions.
> > +		 */
> > +		ad4030_get_sampling_freq(st, &freq_hz);
> > +		ret = ad4030_update_conversion_rate(st, freq_hz, avg_log2);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> LGTM.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 
Thanks,
Marcelo

