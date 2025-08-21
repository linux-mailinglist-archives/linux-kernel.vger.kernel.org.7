Return-Path: <linux-kernel+bounces-779407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E57B2F3B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C39CAA0A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FA52EF661;
	Thu, 21 Aug 2025 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JhKs4JyT"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009FE2EF643
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755767843; cv=none; b=k89FFBE2w2+CYAEUmfNifG+6BfV4w9AJyFp+xcnmyYlZhV9A23TcDDdOzIQe5OM9jnLvXSO/IWN2xyf9LHYtwbm5CDNK2zfN/lPPRcYXmHZzlDJgikpo1DiLmhLCqvJwe2xdctqTkVji3xOaw6n/rrEkMkAujOZaQOSQKGvxvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755767843; c=relaxed/simple;
	bh=f+A/i3bR5ISOezI/sppQsmMZuL47OcJ2YdUaWhHzuYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyg2v3ufc1iDpPM3oEVYb8ujCc42vBaIf1tL1/YAWNG+h+sehAx/xvBgdtr1vRjyY1CAEbXBkJY5dBvueRnMy92YeuR0fj/rbFsCFbGCEvvq5EP0fMu8UOElFbnaGBG0VXG7doOh2hZlBFCVebY2LhT1CCg6l/5uj92GgfoDgIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JhKs4JyT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4717ba0d5dso550787a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755767840; x=1756372640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJ1EY1hPDVOro5O3UrQaYb9eHNygUaCfbat5MCnKEpk=;
        b=JhKs4JyTusPMrTCcwkPJ1zECgKeY6X5o5Ij1hbPfGH4cH7letWw6eeDgJUrVKTRQQn
         HSa6MvVuEzjSDHEEIHBkuLgFMmQDwwqr2Afc9urjH4Fl7KGwVbzR4h9q/lkwOjftHFkJ
         9o/tibE/JPLs9LCnp+PXZsCA06rjfaAXrBMUYvwq93yubNXesse9PoEEncLHyDfrZp6F
         +31Djco5psW+HI+WoU7ptkd1g79RHjKy6C7K86URtfmD3SQbVuSlwjt9CnEEdkD9/5lK
         aWMGDHoBdLgTOP59VdnC5pfvj/7eA/UVblotMbzJNA2a4IhSW7og8cLYMjd9L+Rs+p57
         QGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755767840; x=1756372640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ1EY1hPDVOro5O3UrQaYb9eHNygUaCfbat5MCnKEpk=;
        b=HpN79TLRW6u3JK/N+1RIop7OkQXjfU9LBo2cjmlFGHrEfiPpNPB37e/dcXpqEGChOB
         jF7XxbSnK8EiHBxXy2vdwH39kMDVuvc7nF/XH2xMrU47nhm6T61I/oiKiCTbw4Kx0XZM
         cPIvpT58/yspvlrXnSOv03fPL4oygoOzwqE9NABftulOpyraxjD+SOZMkYQdeva9WvNx
         CynOXIBF1SFvV8hn7s738yBTSVVB0LNdMNDuR1WlQWuWajT8TaRhwhfbcC7TK8BMMH3s
         q/krVeqzdJ//BAF+w4/oDjxLLCSe70EXZ8E3A3FP0TwvILwXryMlJETGt0E1HA6WeWws
         EEMw==
X-Forwarded-Encrypted: i=1; AJvYcCXxSkxD7Ega85khSvp+zEblBJ3nuOd1MnjGDXDBzc7qN07Hc7ovH2VLEh6CIgHKSsMwW2xF1uLM9qrYjAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjZWXPojt2qy35Sk9K7aLjclWqPszrinW89pyeVbxoUd63IyDK
	/Dgteul1+1hcBJMzGWwqJDW5vgAfB7pucx2pU2n+AwoP+RBUDVZkDvyfFP3LnYuuwzw=
X-Gm-Gg: ASbGncsRqm2XwqPlhhUbOYxM7cSrhBU30EXkLk8M1nDk9vxubyWMWtgKbc0Z80VDNLR
	RgiAmHOxxdN1AIBv7C+m/jDG3RBggOI8DSYU/wnfmWr/Y3EAQmU02+YCqogGCQsbEsp7bBFyXiv
	bAi2+ve1FTsWZY/mSNHouuWpDHbVCR0myuW4B1h5PKGcY5rbz5LNVSFUM7T0qdqreCuXiGUEzO7
	DzQymyO+Bw4RQBccnAVu0W/GsbBq1qO7uyFkGZQVGa3Iu8vRaYza/l1Gmv0RmmJrJei0bDUILRX
	xmq19fesraQnEpqHlNtfdE6k9uPpef09fphW5GUMimOuRbo5Myissw5qXV+De0BRhSZ/GOecz3o
	xAMnA8mF4mcvqq7eueSbKxXO+DYvs6rlA1Ng=
X-Google-Smtp-Source: AGHT+IHMF3tjK6S0GPTNw3RdPrAfiT61SZT/HliL7uh12owm90LocC10fCZ2Chb6bAuDk+kOZRD8zg==
X-Received: by 2002:a17:902:f688:b0:242:fea2:8bf2 with SMTP id d9443c01a7336-2460238be3fmr24757025ad.5.1755767839877;
        Thu, 21 Aug 2025 02:17:19 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245f38ab988sm39467585ad.124.2025.08.21.02.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:17:19 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:47:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpufreq: simplify setpolicy/target check in
 driver verification
Message-ID: <20250821091716.x7y76wfvvez6g7el@vireshk-i7>
References: <20250821090020.167786-1-zhangzihuan@kylinos.cn>
 <20250821090020.167786-3-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821090020.167786-3-zhangzihuan@kylinos.cn>

On 21-08-25, 17:00, Zihuan Zhang wrote:
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a067b5447fe8..92633ff2c4f3 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2908,6 +2908,8 @@ static int cpuhp_cpufreq_offline(unsigned int cpu)
>  int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  {
>  	unsigned long flags;

driver_data can be NULL here. It is checked at a later point.

> +	bool has_setpolicy = driver_data->setpolicy;

This is a pointer and ..

> +	bool has_target = driver_data->target_index || driver_data->target;

.. this is bool.

Their comparison will always fail. Did you actually try this with both
setpolicy and target() set for a cpufreq driver to check if it really
fails ?

What you need is:

	bool has_setpolicy = !!driver_data->setpolicy;

>  	int ret;
>  
>  	if (cpufreq_disabled())
> @@ -2921,10 +2923,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  		return -EPROBE_DEFER;
>  
>  	if (!driver_data || !driver_data->verify || !driver_data->init ||
> -	    !(driver_data->setpolicy || driver_data->target_index ||
> -		    driver_data->target) ||
> -	     (driver_data->setpolicy && (driver_data->target_index ||
> -		    driver_data->target)) ||
> +	     (has_setpolicy == has_target) ||

I would rather do:

	(!!driver_data->setpolicy == (driver_data->target_index || driver_data->target))

>  	     (!driver_data->get_intermediate != !driver_data->target_intermediate) ||
>  	     (!driver_data->online != !driver_data->offline) ||
>  		 (driver_data->adjust_perf && !driver_data->fast_switch))
> -- 
> 2.25.1

-- 
viresh

