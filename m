Return-Path: <linux-kernel+bounces-791186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5085AB3B318
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A2367A176C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECED2248B8;
	Fri, 29 Aug 2025 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flKqZX05"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D4521CFFA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447999; cv=none; b=OtFq51BpQLfP5Jw2RAA147D1cuy4gcG2cf+iOHSYf2B8bZ5oNZp5b04Z5ea/I9nshek+c7GVGdYSResvyXYnexX5fqL+L3u5ov5gKoh4P3pky2pn0yWaRcEYF7lO/+6Y5Cj6JCOhnvKcYrn2mQERQIlQoUuRhZxTougNWLnx6+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447999; c=relaxed/simple;
	bh=ME3U1EvqRDpeRv8iU5ieehT4bOumrWu/AM01apJTyWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHXQ8E6xkAKdq4nLvv751YarNxqAvILOQVb+UBUDWn2Mi6Nra3YoQG4nHq4mImtCrP3jZi2xLnh20ABygOQWeMf13JAt4b5rs7iygHCyUsU+PxaQ/Wq8O12lny8/Wxc3fpGgZxAn/hP1nfo7bvTHgXYiL36W/vabalJy75u7Fpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=flKqZX05; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445806df50so14500925ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 23:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756447997; x=1757052797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3x6b/e3MpUD14LIMocrPRNaCjXydrgPTujas71bYH8=;
        b=flKqZX05+50sa/v7L26xkuDxUTGPnqFYxY7+DsKe80BonZ0SS7nVFJ10puk86edNWU
         gJodVrddYyKLwUZ5Dsgr9g0H2+qFZM8RE/3JD419Tnc4l8NEuiFlpX+4rUNEyQbSlFAX
         eYDUPVB1I/RuqE7P4H1mHWjglPQztCBhc0WqbxPqqDKJn5LwvjdAx487V/70nFnqkEMr
         KVTgHmo9yGibCoyvQf+tUHIo3HKG3GZHnx225J/zaA1NEl0suhP3j6lBfa6v5p6SfUYz
         8v/BRORln/QmTnV8JaqwzCCujak8+thiSvHA1fVruNcMxX8KKwDAuA6fSACD0KUWF+1r
         MvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756447997; x=1757052797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3x6b/e3MpUD14LIMocrPRNaCjXydrgPTujas71bYH8=;
        b=EevWNHD/kgAAjvlqdxjpYDnCLwQXX8KrZFVOm6uTAe7w+p4OpDjfUyqw2a6uN5Mv6C
         1No0tUMeNYihDLj3NStDEXkWZnu6wJwBYjBaN2PlqfleIm5FVK8x1I+51S2AzAqhneWF
         V2CiHaVnxovNCwViCspxsQ/JTvLW2m9tR1FRSvVaPPtwF+yC9pWoB0l4j9ZlR+Gp3+eB
         SMz+G9W1yOrhp3pyNW1XFT7600hPy5PIHnUvr+WnLr8dj5bS3G1fBik/ALr3i4tfY19Q
         4ovyZdpv1iZDkdlFVqojm0VJsg2NMCvfH9COD9x6jck8H0u4cqIF3XrFJteOX+HvWWej
         Q5TA==
X-Forwarded-Encrypted: i=1; AJvYcCXzit4AJgG+m/QgJop1CWBFIPodwzFwHvAqJ8GlaPSAiwY3jS/BMCizdZbID9GgfsHKC5bT3Dv17C+iljY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCe4n/xXTgRyQXcNxyuYQOLygpzuqqNzdH0Gia15QlRsve+HTK
	6081xHKvPWCsG7Chg3rw7VBERivpWZS8833aG9s1QzvWEWtyhTF3A4eWzgfhCM2Nn0E=
X-Gm-Gg: ASbGncvC8OKOLIHwQy+pdN0bsuQS/CqZE0MpSsGiluWI5UCxN3J38mjWDGf1VB435Yj
	xH21z4fAJYczmJmjn5Om3VMlg31APiEsI+PxbwQXrKUu4RomSKmnl0nwZ5kV3OU3FgdOkP9tI1k
	oboGxvZBhBCFFGPj2rQ+F92x+Cy0EHAlH49fblbVpDvx6ZNzXgHagoqVU+ZYIUKDpFxPQTLyh6q
	Gt7xraRNNQ1hVud/uw+GtbwQBTTd+q1KUlPPFvKouYVNJqay8y3Ts+9uur6hW5RiXOq7b20Fr8M
	1myY3XJWRFQ+zKKoyUteJ9kjyBcTrsBLp2A0HRK2RqlGsfUZMoODYdb67qhnnUDuMF+vidhNOnj
	Y2oh2sVp81A436MuSJwMzLEbzjvgK+NNVOvI=
X-Google-Smtp-Source: AGHT+IFWh4jzpCyQazo33Du3vwJOQK6BMtgUKuJSYiyNvSKeAM+9t6q52OKXzZUwBWVIjDVwh5LnnA==
X-Received: by 2002:a17:903:248:b0:248:7018:c739 with SMTP id d9443c01a7336-2487018c906mr177164055ad.28.1756447996693;
        Thu, 28 Aug 2025 23:13:16 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490658999fsm13362715ad.112.2025.08.28.23.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 23:13:16 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:43:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Markus Mayer <mmayer@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	zhenglifeng <zhenglifeng1@huawei.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Zhang Rui <rui.zhang@intel.com>,
	Len Brown <lenb@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Beata Michalska <beata.michalska@arm.com>,
	Fabio Estevam <festevam@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Sumit Gupta <sumitg@nvidia.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-pm@vger.kernel.org,
	x86@kernel.org, kvm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev, linux-omap@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/18] cpufreq: s5pv210: Use
 __free(put_cpufreq_policy) for policy reference
Message-ID: <20250829061313.bloyct5htjym6b3j@vireshk-i7>
References: <20250827023202.10310-1-zhangzihuan@kylinos.cn>
 <20250827023202.10310-11-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827023202.10310-11-zhangzihuan@kylinos.cn>

On 27-08-25, 10:31, Zihuan Zhang wrote:
> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> annotation for policy references. This reduces the risk of reference
> counting mistakes and aligns the code with the latest kernel style.
> 
> No functional change intended.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index 76c888ed8d16..95f1568e9530 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -555,7 +555,7 @@ static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
>  						 unsigned long event, void *ptr)
>  {
>  	int ret;
> -	struct cpufreq_policy *policy;
> +	struct cpufreq_policy *policy __free(put_cpufreq_policy);
>  
>  	policy = cpufreq_cpu_get(0);
>  	if (!policy) {
> @@ -564,7 +564,6 @@ static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
>  	}
>  
>  	ret = cpufreq_driver_target(policy, SLEEP_FREQ, 0);
> -	cpufreq_cpu_put(policy);
>  
>  	if (ret < 0)
>  		return NOTIFY_BAD;

Merged with minor change:

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 95f1568e9530..4215621deb3f 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -554,10 +554,9 @@ static int s5pv210_cpu_init(struct cpufreq_policy *policy)
 static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
                                                 unsigned long event, void *ptr)
 {
+       struct cpufreq_policy *policy __free(put_cpufreq_policy) = cpufreq_cpu_get(0);
        int ret;
-       struct cpufreq_policy *policy __free(put_cpufreq_policy);

-       policy = cpufreq_cpu_get(0);
        if (!policy) {
                pr_debug("cpufreq: get no policy for cpu0\n");
                return NOTIFY_BAD;

-- 
viresh

