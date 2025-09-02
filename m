Return-Path: <linux-kernel+bounces-795673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F55B3F641
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D21D1A81C41
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD872E5B2D;
	Tue,  2 Sep 2025 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NxPGfhMa"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C042E36E9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 07:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756797126; cv=none; b=oWOESOfasnH1cpW7OA8Qz3HLOjbW1VDtJPO8fxu3RyrVeYpONFnDL1J1g8lTi/hfSsdaFTQrwwiyYm16cNzkjm4jPsdGx2Twoo/RM4z/KTwWx4cejaC2yfWXdqgeNAgARjYJDmcsZYX8pYiK7Kc5+k5Joa3wOnht4AV0lyBTmiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756797126; c=relaxed/simple;
	bh=4Dj8wHzcKZ+KE+l9JlZw2/wgZaNm5SI7Vg6vhkZUvrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzORWWlcaxnnNYDhMs2pCoruRF3SBlYfkF8cNjAiPmPyioNvX02qVBYgfos0ITLzZcND/udQeGGGuDqsIa+xm9MVQ6hsaqQNUBQqrDQLDqMmP/bWcPhmcOmz0Zsb+CKmJcUdXYJ5ObgidMLQIP3ppONEnAWXv2BUctufN8SLLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NxPGfhMa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b7c56a987so15010555e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 00:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756797122; x=1757401922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=leRMEPgF8RUEvULChzHRAQuhgrQpyQ/k4NKGFx3/OIQ=;
        b=NxPGfhMalr0puieqZ0NjhnLO4k+g37416+742QxVCL39sCZ8MZ0jb++o2JkAxij8ZN
         vJn/GLrFHv4il+X4O+S9k0gc1m3dqqP0sPeNNzTjEIkm47mcjrtddBFWbt0r9Dl7xhtM
         n/Nt60RDPFxYA5LqefiznDa6Dwj1ALVZPuYSoeFC+Po/xGqv2pFlPxJBIAnAM1d4hNb6
         qcND8K1zagmtFFVrGGOii5GgbfTLWGMbqXAYTr3inpqcsYAWui9z0GxlN1GOzu8SK9Hi
         HqUdBxZrkWRxtoDJZRwKzQGI11wktL4skOeXqnTWj9NG88mpdOP4Xw2vAKnsK/vMicQ2
         dE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756797122; x=1757401922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leRMEPgF8RUEvULChzHRAQuhgrQpyQ/k4NKGFx3/OIQ=;
        b=Kq8f86dU9MfvT20V4Yu+dUHFr1X/9/X+RuAU6Tf/ktLOzXEauAcSc6618+VpTfJDKs
         uxRFZoKJOKQgNtW+G31YPR+Szbo3zqDpeTPiL7JNS9731wFxGc2G1M8+Lt942YoPg3Kr
         3NdPWeiuUfUkKKSkPyNR7bSti+QqyMnikGeuIj18KmwcO7UultTSImfEcWzhbuPJ0VnZ
         C5E7P5JNxX8taIhH1kF8VKF9juW0Eadk5lr3Ao6qPNZv6LJYgBhh/kEAzR+p6qJaYJxG
         VfSDJr3ISCq5MRD9NAqxrLxIGMpjjwMsAP7WSk9zRbFmB6+50HE7ESm5r+hUPuoGXa3t
         U/RA==
X-Forwarded-Encrypted: i=1; AJvYcCUnpvXhkCEhzzGihSrQD5HzoUsJrUDnWVv9pU/XACL2ecSmoQ9J87RrqmCBoe38U4nsd4SXeyPWhfrx1/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj7eAl4m3pyKmyGtdSUsq7tBssew9RpRlssUXH0B2QBSIPOE6Y
	TMGiX/o5q7bhgeXyAYLHWxTKyQWVqTCWsilOpUvoDaKNdXRp6PTik/ThdmOofX/FoGM=
X-Gm-Gg: ASbGnctNJC9Npb4Jm9h5c6LG2kfIIlzLQhhGzqvbio5jCBr7Qhd0cSjUljLlrm8owJG
	PynpuKCwwe+NE/goom4nBiFiLkdKniZhRCYo5sAULsQHyZLWPkvpacptxLbB8k0ij0XK27qQUxK
	SkDNFBPsRmVS/+rqc+qkgKikxAMkOQPAJ79mrrw2zbxQCva5Vvhl8nnTvdQaJ2tX6p3vdeqLTjE
	8Ek4VgpJC0oKDdQMweH3Yti8HGet3t5oqZs2wd2WYCWQSfY/AEiQRAmz/z4v3kW5ia2WCs7C++y
	lsU2vtNz2/z++L/rQKa82YK6fSBgG7jjmAvtHZ7yediHYRFxNaIfY4pM1s5Fzsy4apOOgtNITKf
	ma9TS7aXXWL9k/Eusp5qcqSdk/HH5/5udZhaiNg==
X-Google-Smtp-Source: AGHT+IFYuCWJOgHXp+J/kYURbVc6VnwzlfI13ByiraVfMdlwIoA3Pz1WV9KjlyYQt58VCk3unM9JLQ==
X-Received: by 2002:a05:600c:4f8f:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-45b8558baefmr77527515e9.33.1756797122251;
        Tue, 02 Sep 2025 00:12:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f0c6dc1sm267152735e9.1.2025.09.02.00.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 00:12:01 -0700 (PDT)
Date: Tue, 2 Sep 2025 10:11:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mikko Perttunen <mperttunen@nvidia.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Charan Pedumuru <charan.pedumuru@gmail.com>,
	linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: Re: [PATCH v1 19/19] staging: media: tegra-video: add CSI support
 for Tegra20 and Tegra30
Message-ID: <aLaYvsh1sCF7uF6Z@stanley.mountain>
References: <20250819121631.84280-1-clamor95@gmail.com>
 <20250819121631.84280-20-clamor95@gmail.com>
 <3643424.irdbgypaU6@senjougahara>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3643424.irdbgypaU6@senjougahara>

On Tue, Sep 02, 2025 at 11:38:18AM +0900, Mikko Perttunen wrote:
> > @@ -282,20 +411,27 @@ static int tegra20_vi_enable(struct tegra_vi *vi, bool on)
> >  static int tegra20_channel_host1x_syncpt_init(struct tegra_vi_channel *chan)
> >  {
> >  	struct tegra_vi *vi = chan->vi;
> > -	struct host1x_syncpt *out_sp;
> > +	struct host1x_syncpt *out_sp, *fs_sp;
> >  
> >  	out_sp = host1x_syncpt_request(&vi->client, HOST1X_SYNCPT_CLIENT_MANAGED);
> >  	if (!out_sp)
> > -		return dev_err_probe(vi->dev, -ENOMEM, "failed to request syncpoint\n");
> > +		return dev_err_probe(vi->dev, -ENOMEM, "failed to request mw ack syncpoint\n");
> 
> Existing issue, but dev_err_probe doesn't print anything when the error is
> -ENOMEM, since "there is already enough output". But that's not necessarily
> the case with failing syncpoint allocation. Maybe we should be using a
> different error code like EBUSY?
> 

I'm not sure I love the rule that -ENOMEM doesn't print a message.
Deleting error messages is fine because it makes the code simpler and
saves a little memory.  But with dev_err_probe() the message is still
there in the memory, we just don't print it.  Printing the error message
doesn't hurt anything.

But if we go down that road, we should make it make it a checkpatch
warning to pass a hard coded -ENOMEM to dev_err_probe().

regards,
dan carpenter

