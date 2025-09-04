Return-Path: <linux-kernel+bounces-799853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56718B430FA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAEB58170E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3311FA272;
	Thu,  4 Sep 2025 04:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pmQesyCT"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E2322D4C8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 04:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959313; cv=none; b=kYaP0GRxuUOTcdLN6CjSidQi9qMMUKX90MPtRXTHl91NKQnY8Ucs8ygbYF+E5M0+/ToUvnWDV7zBJVhOisyKffIKwQpowO9vvclhh47ke4IgbHjyqyjvK990gHFikQ2xL2Yij07xbEuuDThVzqiYZlDtM6dy0lDamrj0RYl+iy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959313; c=relaxed/simple;
	bh=7w4cLow4zoTj3t3VFgU+EAKFpZeDQOwq+3I8t8BGIJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5PTc4Tcu7hyBY73ubMZybj5J4y80CiRGKTABlixLE4JbxGPOeVA5fpHQwgNtxKTTYqpb3BM0M6Y4yJCqc0gY1tGQ2CJ3y/ojq8FmjdiO2IQQRS+jMhFQ2yzPC2mYa1/uz5Zj6gfaLj1ObK1GvsECa2ZXE5uRRkrnusng1+Mh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pmQesyCT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445826fd9dso8433105ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 21:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756959311; x=1757564111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S43g/iM9x7KG2QXyDYYbjoHBOM2uDSh9d3OO0kWMQhw=;
        b=pmQesyCT4kQ3bjSG43CVD0s+PVAEHjCH9foyg4bRnbcrXjzzDIwVFKQzIQilV3JZfg
         Etej/qVQsU2VnYq79Ovhos5CmqGnEg8Mld/8TzNZ3yCCIs7F0Nrt1pONUlZPaLtQOULI
         qV2vH5OgdysJuiN99hpgh+xxSoo9w46VQ6VviR+Fhjq2Ez6FCX2e7oxWqGKWoZhCuKn5
         PYOknBz6xuli+5QeFmKqIz1tN3bnA+kpCq6RIjNTCi8Mrn8Ai6HPjHBAuS+YLF5d/7QJ
         DxQYhZdqtgWiOFa3zgZNLV3cx7S3nMIqGLHbli1728dQkm9X7uKvN/NILOiVMyq6bcfK
         mvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756959311; x=1757564111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S43g/iM9x7KG2QXyDYYbjoHBOM2uDSh9d3OO0kWMQhw=;
        b=PjzeDdHHezqFblEkxmU7og2sCh4pck0QbveKNJSCnOOjCL1AJfwtgWi6vQxeh6U0SS
         KOZwB3zNEu/AVDD/W1yK4aX+SzrU7QBFHOQ33Va20b07e7pGz4anHFFNr7Cwt/8+CYzo
         W3LTe0R+7hDwMprlh5XzRoKD9k51UYJL69Hl6aST+8Qpg300ojzRHuJCERWn/+UhFnXN
         80wK6cptAXKwRV7q/Q73+6p/hqO1iOTmaodYidZhKg7C7GwaSjFtJ8H2BP0KMEzWbrPv
         wb26li1Nck1aWL0E3alkcSe58j/lk+/xHxQv1/aoOkHDvQgUezwKi0K9H2ReM7+3+ewb
         wSXw==
X-Forwarded-Encrypted: i=1; AJvYcCW7skrU0XA6SIHy35HIUn3XKzP0Pa9J8/ykJqR6UAw99SocwD6CJV4G6hvwMEd85qBUXY6OTmrqK/M1suA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrCPXgoZATzdMKr0lq4D2yoR0C+9Dl31OmLYG7Gkh0rIrAjEK4
	lxhJLh3pu8DNgUzwb4atSnHWYL6uONCVgEesfJxpcXJz3USsPALNoa2zTiC1uBt+9Y4=
X-Gm-Gg: ASbGncsSI1U9Rjvw87ax60oYrSg29hBkCYM7yP+zgmn0ayqUIxoy/iOD2p8tPgCpAcD
	n+CKfayUT7bTbMeC7jy0aHqw0HtAg0XWreSrwoSBI23gKhAvxvmhYfXFgrrllcbeHKuwT5tePo7
	yqWosD7sW+P4ZhBhUi4/uuRS9MG/9Gai1ZGWCTYwgSwYTpFfKuLEqRXH/JCGgXEgMwTKvVhrjiL
	GnzJJEdfPDQ8QkIgdXbfIUnXvfDfgeU+wukHdpbgIuJcMFCvDhaKVL3peUhblKzp0h8ujqVOhDQ
	LEOeJhBaqvUJnXkHb+P5mO+27298vzC5Yd/crFpabFTQYeorOpsGaQ6DnmIRxRaRCqdspMqGlmK
	+7NzOIroOupb/zfhJda3d3SoNQXd9YnbrQ9DheNfJ7r5eLw==
X-Google-Smtp-Source: AGHT+IE3j8/7JmxRYMrFCkc+SleGi42PqTbqK6XvQkwoGiztnAW0oV/bspfky6fJCoeKLSS9D4mPdg==
X-Received: by 2002:a17:902:d50c:b0:245:f771:4232 with SMTP id d9443c01a7336-249448cfbb0mr229747055ad.14.1756959311119;
        Wed, 03 Sep 2025 21:15:11 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24af8ab7e7bsm75847965ad.138.2025.09.03.21.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 21:15:10 -0700 (PDT)
Date: Thu, 4 Sep 2025 09:45:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Zihuan Zhang <zhangzihuan@kylinos.cn>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Rearrange variable declaration
 involving __free()
Message-ID: <20250904041508.z5546b6a4usk5go2@vireshk-i7>
References: <2251447.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2251447.irdbgypaU6@rafael.j.wysocki>

On 03-09-25, 16:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Follow cleanup.h recommendations and define and assign a variable
> in one statement when __free() is used.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Zhang, I said the code structure here was intentional, but that was before
> the cleanup.h recommendation was pointed out to me.
> 
> ---
>  drivers/cpufreq/intel_pstate.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1502,9 +1502,7 @@ static void __intel_pstate_update_max_fr
>  
>  static bool intel_pstate_update_max_freq(struct cpudata *cpudata)
>  {
> -	struct cpufreq_policy *policy __free(put_cpufreq_policy);
> -
> -	policy = cpufreq_cpu_get(cpudata->cpu);
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(cpudata->cpu);
>  	if (!policy)
>  		return false;
>  
> 
> 

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

