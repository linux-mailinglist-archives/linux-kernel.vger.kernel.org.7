Return-Path: <linux-kernel+bounces-745295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E000B11810
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F4837A6978
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 05:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703D124468D;
	Fri, 25 Jul 2025 05:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sFxUG9Br"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DBA1E260C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753422554; cv=none; b=ONRASiX7kxZT+7PB+ao2mmvq8Vi7LsTaqHeQOYPP2pmodJjr08UJfFnoChI6Xd7Z78pStElE1Vb2YzGukxEF21/Ham99Macbgs2H6TLlvCVoHpWt8PdWk0xdOBocWwe3g3wGSS6mMo+66PmTzuHTpuIRPsSw9D6+DeyWG8zoc6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753422554; c=relaxed/simple;
	bh=kt81b78tGqE2fXMs1hgKSZPNjtRJ+zYxTvIAg+AkKBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbT3FjDJiNz4XNZ9c64OAxc/kfw5vxtd2phUjViPeWawSSRu/NYKCgyyQv1VFkHwBkGGiA9G4sYNWvKOFRz0/c7Oej6O4Fb/Bjq2AkNFdV/cDQ2Y4vYTCUkgRSaRho5HWWw6YqkHS5p9UGPCKBD5/ts7CGQyub57HpvF4Tmxz2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sFxUG9Br; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23aeac7d77aso17169545ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753422552; x=1754027352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hskrk8phHu4wT3pcdJrDYqFkEsU4W/M9XPNUZYaY9go=;
        b=sFxUG9BrBmSyUk8Z4eclTrW5qOPSE2xPjEW9Zjug/PP2fDxw++MaP9VS7qx6lMEx4v
         FkG7/yVwom5NQUKjlRE2zDlDK3Mh4avEgGs0WW9fPiZVmkkbGDV1OpS4lpvuLFGmkGS0
         IbrZyBVdWrxCbWegkQs67EmZbwWeLQwd1f8D7Vgm7RSvEus9DRlA2xkYMGNUZXj3/PfF
         bFK3qiPUPmsrXqcnQNFQU9k2GgH4EG014BhROPh8cY0ier5EnaR2HstW3lvWPLsk+iiw
         676XSRv18A/M5q5Gz0ZHgOtQDG8VUMFrSUtdDSoZvf67JAiUU3ib98RdSEskj/iUf6Px
         b8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753422552; x=1754027352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hskrk8phHu4wT3pcdJrDYqFkEsU4W/M9XPNUZYaY9go=;
        b=JjBwT/drgfgrp7MLu0FG2JqBSpcuhBWA7lHLMpY9qVpKg17LmvVo+860CMGA4ZVL/T
         ecf1uovtz9zrLAkABeFwmVi3zfPVtSsGg1hxQkG3i1LU4T6edpZP9U7xc6HETzbEAsxt
         cVQCSo6jGeKYmGzN51kPHdif2Qat4W3IVxwRolCsYvKNYoFp5zTBOrpXzitUkKgpAZ4Q
         xkM2MCz11R4YfRikdi4EZIVNENRcU6wUUQoAB+LYPy9aSHuIxroYxFL0rBHc68e9+/wa
         r0UQokQG5wNF/iKoVXELZa2Lxaq2+uJ4TOMlnsiL6tidWn7Nqri5acouzP925XbEVVS8
         IfLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUINZ0sEqBUM/tFV0qNhg4rf9RlFH7EnEUzD4uX1g8TG4ICLyw2SOlNzYdPec5oxQcNIplfIPINPJYmWyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDgR00cDSbeDkvdmQL6Mt3SINwMIg0yebT5eZSNuMmDGnXVIkW
	MPv1r7G469DWDYg6wJ6b7TV1B9cyGx6nv/Ys05/GQfg3cs3hf0gtclqBkGfr6thbjymo2zXPNcJ
	JVL+G
X-Gm-Gg: ASbGncvIj9lq/BiWRsSYxIbpRECZl72x9SJDgOyOurIVqcxxW2yBbLp5ORPw3FegG5E
	+rkEGXlPrWeTbJdeefwBNQXpDKfyAffSuoQE4R7yZ/Wad2owVRaUvC/Ocw+hQEkqSo2WmbP9Wu0
	0nu6wF7WSAKYJiAD6bnXIBj2hHmU34a5RoL90EH65JA6NbdTD0w/QKtt3BgvkYfuhicnsb3EC7e
	3r9HlW16/fR6Wr6xbkegsYwigwA1pirxDya8ov/iHjon3CAZ2amdttRhGd40aq1v9HoQhmXyYwx
	qIOLO7fB1FoDyAlIlO95EtdiigYAOGQdvkbRYra2ghU5scNUuC0lCl2aJ5W99j+koCtY8SBtcaO
	k8JZZv3PytUUFokSc2E/ZSME=
X-Google-Smtp-Source: AGHT+IEFuvuyjcT7lJtRzHLQ3JJkqLEhR4KgQjICzcTCzi4yg8xUN1GJ2tFV3c36Z7EcNgPK0alcHA==
X-Received: by 2002:a17:902:e78e:b0:234:9375:e07c with SMTP id d9443c01a7336-23fb3171f12mr9502175ad.46.1753422552072;
        Thu, 24 Jul 2025 22:49:12 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f6c07f942sm2626823a12.7.2025.07.24.22.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 22:49:11 -0700 (PDT)
Date: Fri, 25 Jul 2025 11:19:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "rafael J . wysocki" <rafael@kernel.org>,
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: Avoid get_governor() for first policy
Message-ID: <20250725054909.gplhe37mstwvkuv6@vireshk-i7>
References: <20250725041450.68754-1-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725041450.68754-1-zhangzihuan@kylinos.cn>

On 25-07-25, 12:14, Zihuan Zhang wrote:
> When a cpufreq driver registers the first policy, it may attempt to
> initialize the policy governor from `last_governor`. However, this is
> meaningless for the first policy instance, because `last_governor` is
> only updated when policies are removed (e.g. during CPU offline).
> 
> The `last_governor` mechanism is intended to restore the previously
> used governor across CPU hotplug events. For the very first policy,
> there is no "previous governor" to restore, so calling
> get_governor(last_governor) is unnecessary and potentially confusing.
> 
> This patch skips looking up `last_governor` when registering the first
> policy. Instead, it directly uses the default governor after all
> governors have been registered and are available.
> 
> This avoids meaningless lookups, reduces unnecessary module reference
> handling, and simplifies the initial policy path.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> 
> ---
> Changes in v2:
>  - Fix the case where the governor is NULL.
> ---
> ---
>  drivers/cpufreq/cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index d7426e1d8bdd..1aa559f53479 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1122,7 +1122,8 @@ static int cpufreq_init_policy(struct cpufreq_policy *policy)
>  
>  	if (has_target()) {
>  		/* Update policy governor to the one used before hotplug. */
> -		gov = get_governor(policy->last_governor);
> +		if (policy->last_governor[0] != '\0')
> +			gov = get_governor(policy->last_governor);
>  		if (gov) {
>  			pr_debug("Restoring governor %s for cpu %d\n",
>  				 gov->name, policy->cpu);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

