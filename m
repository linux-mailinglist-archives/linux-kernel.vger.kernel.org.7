Return-Path: <linux-kernel+bounces-784024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41515B335AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8CE1B21D31
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EED222D4FF;
	Mon, 25 Aug 2025 04:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QiHmOUzg"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A41F5846
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 04:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097807; cv=none; b=qKKMUVt2m73Ade3KTlOqeb9ZdkH/K/XapEkuoCyjoylODlKx5Fy1wp/jhgK3VH4Zn7UCAA8TD2f07vw+j6/3OEcomhzLqeEXNYV/F8mybZimaXTbCZlNPNXSen2M161YwITDnNpQRakawEUI1KM7XQvzkG1Ku3ew8vyoPt/c24s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097807; c=relaxed/simple;
	bh=5I5emsoasSGYMQYjrmKTvp+4GnV3GfMEYFcm5BGc304=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3c8A4BjMYbCXu/b+nxieSMmqXMnqHKvl0zdyk0t6d86Cy9Xv7o5eFxBPUe7JUo/ObdVY9KFS0pzVcql86YrsSttshqtO9d6LHOAQibLqnLqOSKCC6caiRt/kChqbN/e6PcLamtnwmw6dLJvTYU/6OLZW1wXnAW1tUvHawU3s40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QiHmOUzg; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b474d0f1d5eso2628257a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 21:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756097805; x=1756702605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn5hdQ52sFt9aeXF9yASEnTdR4TK2NpcO83dNRAIXDI=;
        b=QiHmOUzgUrxhnH5cya2/kEj+2ZoSiB4Gn7ECKWZHXq0k4hZfbcdBSGNUn5AWAX/q+i
         3ag4bx3BDU2DgyzyaksOqtDPSNAh2TW8xFpc8MUVfDj3A78MAZoN0MHinfcgB8tuTjdO
         bdcEci6BuOkzrj/ytwm8tqg31BeKH8s4jfdYE59QxoQTn9Q0lndM9ouxXWGQxGrU/TVD
         9BA6PGexq3ChExUnQm21sIQM0MfU/SPlhD/CxX5s5yLlnao8PS1Dlgy9mKxvywoUx7wb
         9mkSkW4f2MiOkL9cDNsCkoQjy5mUpLB0nrQoZCSkM9pocMIeKsuMT0wzIp8xn71EpN4i
         nNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756097805; x=1756702605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn5hdQ52sFt9aeXF9yASEnTdR4TK2NpcO83dNRAIXDI=;
        b=cLDc9w7ibuSY67yJS5+Vk0b1ciUmgUdNxE5Lxyu1SzE2l7viurcYjECAo7L/OkAIVa
         cBvm4Y1/gkgavWc3RIWE0GyUbXSU1dUoAHGNZvZam5UiYbJ2Oh+spphjh3KYE8Fu3q70
         siSV8sm06n10driT2bSsW5IwGWwRYw5EjTkcRYzFKEqyzOMJ1FOcbJGchk7y0jLaL3rE
         JIeENLV8LvsHctd6UJBGz12Dx8QxuCPOPK0D2iUBgmHSMry7ofKcYIoP8K924stMgdho
         GJaZPuwklPV/47hA6gtQ6lBj/VW7yPUogL4oi8160AhyO/0eEFQePMmxRkXXqmEv1UQP
         S0PA==
X-Gm-Message-State: AOJu0Yx2qZSCYI4COykSyHAayd413kTgEpGAqJW3VVrM7dNcTYpJompy
	28vtuu2/cqqy/2ORDXl3r5/GS8KtZ1nu2Vhwf0bJyYa+FBDX6Ch77+h7izhJod03GQKBMUBC3qw
	LBGNq
X-Gm-Gg: ASbGncub7DKSPD1ctsn32PPgT18Is+eKiWNqf8ZN+VlgcRXpEUE+O6CSPDrmawbMUjK
	1YFoies/HsQ7DLrJ9LMWtenyom3yal1yv2KxWVD8xudarwbV3GfI2iVhGWBsMCvUup/cz6o0adQ
	904L29PRmTn25x1wHr5iR/fFUp6VMSlH9ZkfQMDMxrKR9iaeqBI37pWt2eCWSYKh+GWFAYtE66T
	eIQkj4X3VRleqqmkhOEOuabn2+rncHx1s9LUik5ktUfoChbq9NIpxjVROyVVhUUHkbdEZ3oHfEG
	VsAT3j0ETlgfUzWGFG3iPmVDuic2iyWd+qoFa/JdrSGaWSgbKdHUFbv9VJhm8zURPZbAhTgKqi9
	QdicUdnc1xh2qvvAFX5KrgqY8
X-Google-Smtp-Source: AGHT+IHBpKNx6ZAMY6igw9fblWtX3oz6z3/u0C9tOCrVTWeSsHlWo1lfect2GuNIBpq3YHar5IiKlA==
X-Received: by 2002:a17:903:3c2b:b0:240:3e72:efb3 with SMTP id d9443c01a7336-2462ef6ad6fmr159665325ad.43.1756097805039;
        Sun, 24 Aug 2025 21:56:45 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687b0c61sm56323385ad.56.2025.08.24.21.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 21:56:44 -0700 (PDT)
Date: Mon, 25 Aug 2025 10:26:41 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Prashant Malani <pmalani@google.com>
Cc: open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Beata Michalska <beata.michalska@arm.com>
Subject: Re: [PATCH 1/2] cpufreq: Add driver flag to avoid initial frequency
 verification
Message-ID: <20250825045641.o2thjvs3xyuxavyk@vireshk-i7>
References: <20250823001937.2765316-1-pmalani@google.com>
 <20250823001937.2765316-3-pmalani@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250823001937.2765316-3-pmalani@google.com>

On 23-08-25, 00:17, Prashant Malani wrote:
> Some cpufreq drivers have a get() function which can return an unreliable
> frequency. This can cause issues when switching governors. For instance,
> a CPU would be on performance governor and have it's frequency (and
> policy->cur) set to max. When the governor is switched to userspace, the
> policy->cur is re-used, but it is checked against the frequency returned
> by the driver's get() function. If it's different, the frequency will
> get set to the new (incorrect) value.
> 
> To avoid this, add a flag that avoids this verify step on governor start
> if the cpufreq driver opts in to it.
> 
> Since there are no users of this flag, no functional changes are
> introduced here.
> 
> Cc: Beata Michalska <beata.michalska@arm.com>
> Signed-off-by: Prashant Malani <pmalani@google.com>
> ---
>  drivers/cpufreq/cpufreq.c |  3 ++-
>  include/linux/cpufreq.h   | 10 ++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b8937737d096..72e6552a40ea 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2482,7 +2482,8 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
>  
>  	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
>  
> -	cpufreq_verify_current_freq(policy, false);
> +	if (!(cpufreq_driver->flags & CPUFREQ_DONT_VERIFY_FREQ_ON_GOVERNOR_START))
> +		cpufreq_verify_current_freq(policy, false);

I don't think it is okay to do this to hide a driver's failure to
return the right frequency. What about all the other places where
get() is still used ? Won't that cause similar issues elsewhere ?

The driver must be fixed for this, not the core. The core is doing the
right thing here, asking the driver to return the current frequency.
If the driver is unsure, it can just return the current frequency from
policy->cur instead.

-- 
viresh

