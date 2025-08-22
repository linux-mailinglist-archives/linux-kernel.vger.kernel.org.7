Return-Path: <linux-kernel+bounces-781261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14514B31016
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F971CE1246
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3E32E7646;
	Fri, 22 Aug 2025 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKnvPTdr"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC137261B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755846999; cv=none; b=QLKS9GAw+1AOV2OWGjvL0DoVejlJgIQg4dfRLzwVUD3iFkqV8KGZzEwg1Ul+pWnLGreQSLpjcQgjmUIs1VPIRLy3aBiaUD/5c6UUiyFo/F0FOXYL8SY7zWvkoMl+SthbV6+TViAbxV247kLEvGjRm8RnVSRpANQkjphH9LBGJsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755846999; c=relaxed/simple;
	bh=cDIzX2IA4iCvUt9uoFiM/dYZHQNcGBqjkXSrXhdyemw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTv52A/LKj691PF38w8JPzgeOx871k2cYmEdoWCpkp+rwtj4ppD0aeyaRyRqTvvds6+M+mkYCognXZxkXCfY+c1Xmp7Fq49rYAn4wfa2NraMDabDM2fjkvf8A4yaBYsOLC+gkDn78jC+nY6BedIgf2KxvOL6mIuBNmJq/URthRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FKnvPTdr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e34c4ce54so1678016b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755846997; x=1756451797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ja7wvVZV81xXr8Zz3s/sGO5DAQWfSLxex83XaeAoBcA=;
        b=FKnvPTdrQ/HP7l/t98sdn0Rk7QbBzW1emUYpqs4k5fs+aMv82jWE/YCoGX/SPRwzGl
         fy4I5QKx48QOdDw5zYoJqudfIldbwu3c6nfvNW9FkzMdsBR7qoAdDcqgt410JRnQR+mi
         l5N7s6HPja/fgcT6GQzOU/lNrxDvGsBIB3Zi2jqkSdY3OJVH3wKgS0WqAaDMKJ/Wx0+f
         4IUWVdmKW84b24zMzAClVBWTtxji4nzvW61xnFoM0Ot6SYg+CWWbED5QB8kRSkGjtM5L
         Jw5rOd2ooWM2Z7suxG5xqH/WY9zJr3KPBWIygDZ6ii9lkU/H+0Tm5CEMu6iVYkqcbYUA
         Ftkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755846997; x=1756451797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ja7wvVZV81xXr8Zz3s/sGO5DAQWfSLxex83XaeAoBcA=;
        b=p+TWzz24n1+bBTl6ll/wFXGuPoiDjswKgAMak1eM3+VOOs6nj5QmmcWY/Sjw1NFjPA
         jxx/zVc95hiYCJfGYuS9M6iscCvcdaJ3SVNcUlYE8ONA+g/SP0hqkI4K79WtxxlGSi1z
         s36gl9kblnR5PDHWDWqmWHMlQ427P75BfzK7LVbCWow33Dt9Dw/aHpLQfdP+gebSi7hY
         EhV0ziVG6QXxsF0kcWCdgFZKNNR5W11UcZq5H8MrAlsNzcElQMA2R2+nG7NA6mzZSQQV
         7IElCrbd7h7UaZnuBv94pPVsQg4tLLo0IJllsEx9HimET/G/cRgwzSvgFNPUOmmwrL5+
         Q9Zg==
X-Forwarded-Encrypted: i=1; AJvYcCWpUSOo/Q6vv1TLKR5jCwjLKj7rpmP9CNbzSj/mclUxAqvByC0Hao0zy4rCljSyzbpiEIPSUNTA7ktVxgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw266J+OGzVs5UGBsXZpCSk+ea2cd5Cim7Pev66YgUZo6sMuFID
	Yfdw2GgqAWr4q0z0cuVQGW1P4gk1A7XYnuJjxc1m7yyWemAWjQP2o1btqMdC6XDwOrY=
X-Gm-Gg: ASbGncszRH1HT9HGaxRmcyyi0lhHyzlFoNDCIhDQgP2B8tely8UG4M8siTLpUZ2mu6j
	j1nYfTMQEXQCMdaaTUR8qM9eyLRLHo2Y/apsPLkNt879x3kKRR4IZNfN39CwWkHfTmPLWCO/YLy
	I6iYlUEp2bbS89adXoo/tI7EjIKeFgToJ+MDEVbXz2cLohzB70lNuMhrWSafdhPRK75phe5+LLI
	aCVYXbjjo9Kdw58Ps6cC5SUJm5VjD7bT0FiPXeDvjuMcEjNmA3ErN46KzHjxwXINwCJGLcJJhSp
	IiMEYgAv4CNCwecEHqLrrLQdqD/ENwvxaQuah/WAyTWP7DLIaffyYURs6w17+gplObWDnbcA82D
	wI6vARWN/NFE/9SC1udhkwCDBSnOf8o/ISNQ=
X-Google-Smtp-Source: AGHT+IGS7GxI+46a344dMZve29EjbWYSjTDmdGR6AlyUm74ISA0tlK6mXmcup9whsfYIjr+Qux5ILw==
X-Received: by 2002:a05:6a20:9188:b0:23f:f712:4103 with SMTP id adf61e73a8af0-2433028c04cmr8907124637.18.1755846996745;
        Fri, 22 Aug 2025 00:16:36 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640908e4sm6331466a12.26.2025.08.22.00.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 00:16:36 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:46:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] cpufreq: simplify setpolicy/target check in
 driver verification
Message-ID: <20250822071634.r4hxnfy7ofgi33az@vireshk-i7>
References: <20250822070424.166795-1-zhangzihuan@kylinos.cn>
 <20250822070424.166795-3-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822070424.166795-3-zhangzihuan@kylinos.cn>

On 22-08-25, 15:04, Zihuan Zhang wrote:
> Cpufreq drivers are supposed to use either ->setpolicy or
> ->target/->target_index. This patch simplifies the existing check by
> collapsing it into a single boolean expression:
> 
>     (!!driver->setpolicy == (driver->target_index || driver->target))
> 
> This is a readability/maintainability cleanup and keeps the semantics
> unchanged.
> 
> No functional change intended.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/cpufreq.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a067b5447fe8..633be16297d6 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2921,10 +2921,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  		return -EPROBE_DEFER;
>  
>  	if (!driver_data || !driver_data->verify || !driver_data->init ||
> -	    !(driver_data->setpolicy || driver_data->target_index ||
> -		    driver_data->target) ||
> -	     (driver_data->setpolicy && (driver_data->target_index ||
> -		    driver_data->target)) ||
> +	     (!!driver_data->setpolicy == (driver_data->target_index || driver_data->target)) ||
>  	     (!driver_data->get_intermediate != !driver_data->target_intermediate) ||
>  	     (!driver_data->online != !driver_data->offline) ||
>  		 (driver_data->adjust_perf && !driver_data->fast_switch))

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

