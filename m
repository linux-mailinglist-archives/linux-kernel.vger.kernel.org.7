Return-Path: <linux-kernel+bounces-784290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B932B3398E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E5134848A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2B22BDC28;
	Mon, 25 Aug 2025 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FUpEX1aA"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9B428642D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756110992; cv=none; b=S4PA0CxNsDg8doZUzQ8f19rF0JQXLj1ccQsJ9hdIwibImDP7QGvAI8RQ+VuVFnf1prZlBoN2wI3Yhy4TayTPSuA6D3h53G3Auz9wRBeZsETWyu+4VAt6ZvMsikWckQA1+mvOIb2xrYow+lWPgyvtbiyTanrCuqW0C7diGT+dMKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756110992; c=relaxed/simple;
	bh=yEIYjWl6ezBClWzYKCGr5752vL7ppckrbHSq1WORKUM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VSY3ESQh1sEIZD7up0CT7FWY/GhBlpLCLR5EovWBCOJXpk5tfingo55DqA62jSa4+cxxy7LFSkqWOAIZjn9nuYWqOFQwf6kjLW+F1Pu62oz3ktLllurfktoD1CIIXeA7cJKQqxTwDDCmscVjA5bHRDOUnp4V1CysB0Y0ZWMmSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FUpEX1aA; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso20754825e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756110986; x=1756715786; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XO1+IS9STBCj34Lw+wOXXrOpWS+ZkYDToI4PIiLJ9vs=;
        b=FUpEX1aAKSNcHCXt3khGfAz+rLqvRSUZ6pui5i2UTtnM0sSyIeB9g5ydTRErxatRuU
         IlZZjY6Pvapzv+crsCnvMAImPionUmBLjBN+EPIJOgEy++gnBk494T0y3q3vXde3/z6Y
         sOPeiZKCT/1daRuUmBShyzXnbDByhvluc0Fl4DFORdUhOruGC/Ih2fOk/cO03sal78Ms
         jEPDgpJGnZeKAxpxqQrGN6YDvOygDN5hCDoGVU+YhYhfhTJcXUNazH/09LAzxwpZlrV6
         DzML3flc41ZNNHOFKTYpA5nUTnsYB1oIjN93zaXHL3KxNC7NWFFKahOczGj/Q+ICo7b4
         zcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756110986; x=1756715786;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XO1+IS9STBCj34Lw+wOXXrOpWS+ZkYDToI4PIiLJ9vs=;
        b=FJWfRnyHHn6UT0XgWqAUz/0aMNaQHFuH8vRrZQNn3B5amfML99rUUVkMGQ4fFCDPkP
         gKuS080Pkw6p2U4hb4JQUgtYFKIvBx0Ov0gDr+Pm/VdDyNQ5t0ctN6/vh0kljyKqp8Ix
         H1ExvDgMKbB9hoxqgRHvYLbR9B5S62BpEm3o7GCXSUweKMYd0jwas6YHjNziXPMb9MQq
         Qsrt/8U+N3uiFl3orSh7aeWhYD3L14AYP/ErGJV9hy/AHmkPbXCyWJmsauwtyZb3uBtP
         d8ua4Q1E4rv8/UWSvjD0dUZ0pvc0FiJnAcDxyf/tffA0jnj6fh8ibluS7PvayvJmVjJ3
         DExw==
X-Forwarded-Encrypted: i=1; AJvYcCUsQsLxE2dqZBaLRgmBftlNCOuNEgcx3MvbwQkBsPUxYn2oHVX+0EgPe2P4FPieet4sD/Y6O7YaETdZ7mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8mA4dxN9HhOsgq6ZFYGeueAnL3F55IZiKsvrnf5Ox7YGWLNzD
	8bR5uClbEBJtVVDyRcmy20Mfh9656JpzawJkwha0ByEsTM/4PPb1SkvH+d8r99p+3oc=
X-Gm-Gg: ASbGncs1zKGK6l1xEwpMIaApHjFS9Z8V1kvJsCI1FGtvAotfSiuM+e3BDMmn28vN8Ft
	LMIG676lOMqY70HVJXGnAgNdFTWcpNRne15/cr9Jj9ZIyx9lCYTSY9k0QmymC0f3kv9qlAv3+4R
	qfcXtZ19KXDmjfggt2GJpcvrc7UOsKoYcADoZDBVZ2i7411lIGB6fxLmKS3gcSGDRg0iUNdveCE
	+FEgKsEbmn8kEJhQcGqEoc3JiCrZAB6afUoco0S+e1njeUgVhts/vjl65K8DA/x/78uGJ+aKg0F
	CZU4vZmtDftL9CASUEYVZDfetaebLxGAhhcXianyNKfEWvATYTliAtIwIGIKNl3RELVWjDsDBXa
	X7BdvvTqrnd79jCqPtVoBdw==
X-Google-Smtp-Source: AGHT+IGiamtdsGY2kDX6w9f/mzPofYs3vSisqz5ZM4c90dOvsj+B0bgxdt8+7FzKKa6/ub2RebLE1A==
X-Received: by 2002:a05:600c:b8d:b0:459:e35e:a90d with SMTP id 5b1f17b1804b1-45b517c2eebmr91517135e9.27.1756110986280;
        Mon, 25 Aug 2025 01:36:26 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:af88:b6ba:23b9:97e3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b5753adf7sm99733285e9.7.2025.08.25.01.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 01:36:25 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Da Xue <da@libre.computer>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Jian Hu <jian.hu@amlogic.com>,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: meson-g12a: fix bit range for fixed sys and
 hifi pll
In-Reply-To: <20250822002203.1979235-1-da@libre.computer> (Da Xue's message of
	"Thu, 21 Aug 2025 20:22:02 -0400")
References: <20250822002203.1979235-1-da@libre.computer>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 25 Aug 2025 10:36:25 +0200
Message-ID: <1jcy8j6bna.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 21 Aug 2025 at 20:22, Da Xue <da@libre.computer> wrote:

> The bit range 17:0 does not match the datasheet for A311D / S905D3.
> Change the bit range to 18:0 for FIX and HIFI PLLs to match datasheet.
>
> The frac field is missing for sys pll so add that as well.
>
> Patched:
>
> + sudo cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq \
> /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_cur_freq
> 996999
> 500000
> + sudo cat /sys/kernel/debug/meson-clk-msr/measure_summary
> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>  hifi_pll                      0    +/-1562Hz
>  sys_pll_div16                 0    +/-1562Hz
>  sys_pll_cpub_div16            0    +/-1562Hz
> + sudo cat /sys/kernel/debug/clk/clk_summary
> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>     hifi_pll_dco                     0       0        0        0
>        hifi_pll                      0       0        0        0
>     sys_pll_dco                      1       1        0        3999999985
>        sys_pll                       0       0        0        499999999
>           sys_pll_div16_en           0       0        0        499999999
>              sys_pll_div16           0       0        0        31249999
>     fixed_pll_dco                    1       1        1        3987999985
>        fixed_pll                     3       3        1        1993999993
>
> Unpatch:
>
> + sudo cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq \
> /sys/devices/system/cpu/cpufreq/policy2/cpuinfo_cur_freq
> 1000000
> 500000
> + sudo cat /sys/kernel/debug/meson-clk-msr/measure_summary
> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>  hifi_pll                      0    +/-1562Hz
>  sys_pll_div16                 0    +/-1562Hz
>  sys_pll_cpub_div16            0    +/-1562Hz
> + sudo cat /sys/kernel/debug/clk/clk_summary
> + grep -i '\(sys_\|hifi_\|fixed_\)pll'
>     hifi_pll_dco                     0       0        0        0
>        hifi_pll                      0       0        0        0
>     sys_pll_dco                      1       1        0        4800000000
>        sys_pll                       0       0        0        1200000000
>           sys_pll_div16_en           0       0        0        1200000000
>              sys_pll_div16           0       0        0        75000000
>     fixed_pll_dco                    1       1        1        3999999939
>        fixed_pll                     3       3        1        1999999970
>
> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
> Signed-off-by: Da Xue <da@libre.computer>
> ---
>  drivers/clk/meson/g12a.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index 66f0e817e416..f78cca619ca5 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -157,7 +157,7 @@ static struct clk_regmap g12a_fixed_pll_dco = {
>  		.frac = {
>  			.reg_off = HHI_FIX_PLL_CNTL1,
>  			.shift   = 0,
> -			.width   = 17,
> +			.width   = 19,
>  		},
>  		.l = {
>  			.reg_off = HHI_FIX_PLL_CNTL0,
> @@ -223,6 +223,11 @@ static struct clk_regmap g12a_sys_pll_dco = {
>  			.shift   = 10,
>  			.width   = 5,
>  		},
> +		.frac = {
> +			.reg_off = HHI_SYS_PLL_CNTL1,
> +			.shift   = 0,
> +			.width   = 19,
> +		},
>  		.l = {
>  			.reg_off = HHI_SYS_PLL_CNTL0,
>  			.shift   = 31,
> @@ -1901,7 +1906,7 @@ static struct clk_regmap g12a_hifi_pll_dco = {
>  		.frac = {
>  			.reg_off = HHI_HIFI_PLL_CNTL1,
>  			.shift   = 0,
> -			.width   = 17,
> +			.width   = 19,
>  		},
>  		.l = {
>  			.reg_off = HHI_HIFI_PLL_CNTL0,

Thanks for this.

While this is indeed the same topic, this is doing 2 things at once.
Could you please split this, fixup in one change, adding the missing
frac in another ?

It is much easier to handle in case something needs to be reverted.

-- 
Jerome

