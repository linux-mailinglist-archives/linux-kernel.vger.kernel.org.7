Return-Path: <linux-kernel+bounces-791174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6FEB3B2E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE55188F174
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6912253EE;
	Fri, 29 Aug 2025 06:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+jD0xnE"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3ECD1F4634
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447473; cv=none; b=jx8F3ho5WLFqYENh7cnUec46/UApSS/+zaHCgR+rde+xNXRiCeSIpEu8HWw0Rje0srpSqbXPSkmMT368rflor3sXM5C3gXCO6FWv6iXip2ttB2XcZhOQuVO4491F+ZH4DuDiNJwsCidUlwm6tBBRnxIfmP6ROTsq2unA1E1nfdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447473; c=relaxed/simple;
	bh=R1W3jiVVzxWYPVNevFrweFrVDinP+HnDaHhtFMQbjkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0mscLwOXdCCoi7Clr5pFgxjGgogiqb+nNxzezyh6ZcUHeHZjq1PsW9MUBbDR/iAlMFLevIZfTQqeAW9nqwPUay5qCxZk4Q6xKFZw71V1tfsVC8DV1XFVULIiOWDcF7AoHXCh5naKQJ7DlYK+TAzXzmIwOBHeNWAcTnbVmp6biY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m+jD0xnE; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-327aa47c928so1359664a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 23:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756447471; x=1757052271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KKw32u8ZnOL0uI6AwPEDfGz9pjVdeOgj9SolEPmlghw=;
        b=m+jD0xnE7GCiAkVAglKtXgcoX3DOtHjH5eJ/z12vQ0EUPug5ettryEbC3i3fXOYDbJ
         N1IPvxbY/20L7KAESc27kBg0702VvpxufywHsy+jF6i8lkVIvbsD0e4WXBnYfcThsNVf
         qrR7ODR2Ezt301nRkjRBGWwq+BykggUireqxIV7YMSbyq6ZwzMf+IOoPu2OARBm+avFI
         Dx/cLaSXe7biClDWbnAm77v9zp2p4lYbs58a1/uI4d3NVD48TppfogVjMUPmtuF4PbNc
         sBU5VbgYUP8bTNaL5KGGGjEzZusvDO0rtZSCRAUnxDnwnl0djNz9D+5ZGB9P2z3gYbRs
         iWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756447471; x=1757052271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKw32u8ZnOL0uI6AwPEDfGz9pjVdeOgj9SolEPmlghw=;
        b=vb1HeJCiAZKX0v0k4PWz7Cx4G2aF2c00aUpWO9eL6yf4ajtgkARoYGNDS4LQ30eitl
         8VJqeTYXoenuWCusX2aINUUhCxgMS2mafb1NSSjcJuR6uFwnvib5SUFcA5SHt+cprJ5M
         eo9jz44QEWCUO6+glqHP+lEyGNBGWQw1ytg9o1bZhzh0Bxe9rObCcDCAUjVYyrYc66xM
         9uTkEN3LEQ4LMNgRlAOaucGr8En3MkJUTwpRBmu/IRng/sLf4uOASX6d2kWaq994YPiP
         BPtYcM0T5yikFnJtQRJqrEG0cvSRr9yswm8K4i1oKysqN8x4UGuZHvePvEN36ECdOaWk
         Ngxw==
X-Forwarded-Encrypted: i=1; AJvYcCVMof9vdWEH+NEWdWYReAlw65sSQOX1VHhasN937HpsThu1gNnlD0roSrNt4pbDFSsUwx2+zxxgCPWJ5ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDY4BfGvK5xK3q2R+/4kqJe+G6jAWMy4abgXAXDUrMFDemmTvx
	taPSEaMyvFSaKLB+AQ/Tc/tMxGI4pznqeaSSCXWlCwW9YFgJZksP0eQRonXrrqEvmfg=
X-Gm-Gg: ASbGncsSR1/3qPDSH0Dew5w0X5Ol8C5oMb7aAApsQQ67d5plMAryeoKcYe3EJTRfY6Y
	1Q5+4XF6Rpp5uOdApiXh+cm1v9Y5knLICVj+cw3eD88GxDvY9k8Cr3AI/RhkedS2a+CT0l6Jf0C
	2LXrwLJP3W4ub+r1f1vwW15O13yafjVMdnAY7YeJA1U1vY/8jDc4NU2o6zwtTBi0fY1gVOxSvrN
	usQihXjtiyWpW2n+wDjCwFyYdynt4aVAjLKo7v0Y6zuMbH2wdI6bUz3IdmHeWUDtGxQDw7iMzYe
	yd84i+ugbSGEZAePi6LItEKjYgkpVFrP7GbEoq/HHB4DJe/ZOcZMo6m7BCaj12cTl6sN4/0/RfV
	OgL8TconHqe8R5Mbsg3fOHuS4
X-Google-Smtp-Source: AGHT+IHJm0ouStNvxO+mrh5P3XbGCZbjhM83KCGZEDW+lDzAXYoH2OUF1pt2Xet0QmziR4vBgyThHQ==
X-Received: by 2002:a17:90b:4ec7:b0:31f:42e8:a896 with SMTP id 98e67ed59e1d1-32518b8233amr31504637a91.34.1756447471082;
        Thu, 28 Aug 2025 23:04:31 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f57ab9esm7074127a91.4.2025.08.28.23.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 23:04:30 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:34:28 +0530
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
Subject: Re: [PATCH v2 05/18] cpufreq: CPPC: Use __free(put_cpufreq_policy)
 for policy reference
Message-ID: <20250829060428.aoo4wlp67celupv5@vireshk-i7>
References: <20250827023202.10310-1-zhangzihuan@kylinos.cn>
 <20250827023202.10310-6-zhangzihuan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827023202.10310-6-zhangzihuan@kylinos.cn>

On 27-08-25, 10:31, Zihuan Zhang wrote:
> Replace the manual cpufreq_cpu_put() with __free(put_cpufreq_policy)
> annotation for policy references. This reduces the risk of reference
> counting mistakes and aligns the code with the latest kernel style.
> 
> No functional change intended.
> 
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied. Thanks.

-- 
viresh

