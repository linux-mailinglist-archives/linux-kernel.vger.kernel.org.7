Return-Path: <linux-kernel+bounces-772961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D3CB299D8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C12F3BBBBC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079B7275AFA;
	Mon, 18 Aug 2025 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v0XlbMI7"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AB5275AF4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499143; cv=none; b=Ukn/OGD6CeQ1/HJEvRX6wmlnS2dh4Bp2Q7fdZ9nJYsh8Hdd/4zp5F4Ufq7b79qMsty2NnZWUnHdiDDyKva3uLaA8OpYUHLGK1NwyaFwr55Q6GZIy8qKFrlAtLt4Jd+Hpb6eklZPwH7ZnJWbVQoh6fCPAl5VblvCDl+RSl1BW+y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499143; c=relaxed/simple;
	bh=fdsSMUVN1tYyzzsYzCtSu+U/f8dLCqieMT5Xde4c0lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMWCrRBQGwXp6j+3FfkHWGPJAlR/7QBK+Qhtijacy3F28PqUzJ4BkSUx7BM3Wb/oMUTJ8Pqh2UN7NMXI9INZIZOa6KRJ2vM5jjOyoR0cK0mAbTaje+PqJ3bh4O/ImL/fkGlwcLZn8zKpCuPWxJaBV9+FWNxdXmkzHI/KAy2qABU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v0XlbMI7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24456f3f669so36356255ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 23:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755499141; x=1756103941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWdZCD7J/kohgzpk9nhXOytmOUzsGpBOAbeomBtF8rg=;
        b=v0XlbMI730Z1GoPkyjE9LMZLTtwd/ItJQ1M9oEfYgvHSlBul79b8OA3qtIXMl+LVYa
         ci7ZrpSYRsGYrak/TnCk0IC5U41JBi0Fnq6PpSkYuEZhiU78IeUrH5ZaRQVVgEt/bWKL
         Pk96Bwai5rgytS7Ft6a2ZGERboCgOIeAoC5Cqeg9D6OuMJg6zkAUiNXM3evip24RALKo
         hqEqfbPkEDhJbqqvrPrYo2a2dhfy2PqXXQ28I7FpKrmQoGiXTxUYZ/a4zBKT8vF8He2P
         Ic/+6C6JlhXd4M2j/tjbWfaB3hNrrmfTkKaro2wVaqMUudUFSGFHdH1tafBXoZ3XLwEQ
         XLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755499141; x=1756103941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWdZCD7J/kohgzpk9nhXOytmOUzsGpBOAbeomBtF8rg=;
        b=FOJwuq+1RwcPbjV88VXLLtGvNBdxGXNxOsOWMm96SBR0XkPIxBFh2TpybPjq5AJTcZ
         w8SgfAku7jz2TfblJwzWeGFOgChWxu0pkd0pMv+24UoLhL0OhXJDBLhhye/TjEAcIm+e
         CZxct4PCtgaFPOIbPD9r6m37CpmJCGDxWR+X9HK0Xxi93ZTB6qYb9LG/VXEfoENwBC5S
         G2BG+UmJGPdiTHafPGuzUh/4DpJ2484AypvhqzZneXOLs2IsSx9ZTktmysxcM3+bGlLH
         pMrzsLP6k7Z8gg+ZckuMr3jl8FodzM31E/4Ly4z7xjCmh3gznq8980d42SEzlTrKYwAU
         zP6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/bGWvdjmfK8HCCui68hX5fy5yDw1BNf7Dt81kjO2I3/NC0OZ9gCsjmxBBLhrQ1lpa+ljdnO/zX5+agY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyOdHmc7JKqqgOLScIgRpFYlC2yKLnAn6pXibzS50B2+PVF1mD
	6hZXKY6Fm9NI21NNDurXgW9YpXc7+YsJcqWaEFRKtNaB8PsCPt8xPb9v4kExTGtC6D8=
X-Gm-Gg: ASbGncuxPBKI2H9YXE7COAt6I4D0tUmgXPw/iZm/j8WbzSIS36BKOq5X4J3jIKDonyu
	4NJUCs52g9J8iH4ORdE2ql9Ni4TR3/icWCYCHV9IhNJvQDKRtk29qmb+qnyvxF5U8yAckSoz1//
	TCLrVubMkjhoK9r7YHPwA2BKx8nK8uecIDitt6tUgukKdZoV11Hw+7k2ALhBZNzuOJICGWCzQ+i
	kWbEnmIYT4YKBz4ZaHfQPt6qBf/rHv2zV0ePyde0aAPiQc+1d9S1MvXEhyRS33fjNfi6JB6WXNl
	nxtXVT6e5fTPm3nHEHWfhjz69kP8fq3TKobD+pkFqRMSIFA1dkAJbqybR6kPd4Q4Gn3xvl1cu2d
	mehtXHcFQ/Bh+rNSwyrYaJ1hauslTsJkqjNg=
X-Google-Smtp-Source: AGHT+IEIqesHT4FYr8rc/TuuqDEF+1Y4JGz8Td6OnM3CiT51lBb9Lc+1prXyz1kcF+i7d3fJEqxJOQ==
X-Received: by 2002:a17:903:181:b0:23f:b94d:7da7 with SMTP id d9443c01a7336-2445978c962mr231605965ad.14.1755499140970;
        Sun, 17 Aug 2025 23:39:00 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f836cfsm10420234a91.5.2025.08.17.23.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:39:00 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:08:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Russell King <linux@armlinux.org.uk>,
	Chaotian Jing <chaotian.jing@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Michal Simek <michal.simek@amd.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ben Dooks <ben-linux@fluff.org>, Viresh Kumar <vireshk@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexey Charkov <alchark@gmail.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/38] mmc: sdhci-spear: use modern PM macros
Message-ID: <20250818063858.azqmrwjrlugafuvl@vireshk-i7>
References: <20250815013413.28641-1-jszhang@kernel.org>
 <20250815013413.28641-26-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815013413.28641-26-jszhang@kernel.org>

On 15-08-25, 09:34, Jisheng Zhang wrote:
> Use the modern PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/mmc/host/sdhci-spear.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

