Return-Path: <linux-kernel+bounces-877788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0CAC1F069
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7060418845EE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE6633769A;
	Thu, 30 Oct 2025 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="02ciOq9H"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083903358B4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813672; cv=none; b=tNwinCLjIAfRbQNuI2S8Kj23i1xEz6eafmsw0OOIOMrJAFqV2hMdSM8NZ4nYESLUmTpv/yStFaQ4sfFv4lCyZKKWLclSxk6VmuQHa4zT8sqh3TKzNIErETfyXWDkSa/BST/DO6WVkPxMddM5iarKIO/6q1vUhV7zqjXSHdEpJ0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813672; c=relaxed/simple;
	bh=jjcYsGRKW7uvKP+ugbkLpV4PJ98w/smU3/AsOL2MCMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i3yLZkzRUM10Li6ZQUcnJ0KIjjEoMhqyJZbveqTmSeQ8LKXW9NeGcxtCtZaSUMq8nAIgvEt68Pn2Jx9OBxmISsWtmGXS3Hhz6OGz8/qtde0JKt/BHJLJRqTAzT1aBMwcdoIzaTcckAyIotB7Iqug71gZiWfAAfe/XnCjLoILOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=02ciOq9H; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so493557f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761813669; x=1762418469; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VU8uRCsjTSwrlvmYL3d8u/PULJsMie63xUHiHDK3zBs=;
        b=02ciOq9Hyazep3goEe6AqfMbdRmv+dyKZp74IPhNpuW6pDmvLo7zzRB+VDF6nO3j+8
         qFwI1evlXeuowwolzoVgvFQccU3qqAfcWxEvdyzbOihkkoQMtTUijeni5YOEJLd0NFsB
         8k/NX51ny2EnPHyoZVHMA+Ncar1Uc/4UK8Fwz2fGLvPUGTIQV2roxPqxrOW2zPwEUtsz
         BJ4wJ7VrVJ/8uy5ZoqVoahOoGjOCNJRmeFd7RV7Q+80vhAkIM2ctNAsoxivLV6mwZ8ei
         Z75tUvkGlBQLI5NJnyqLgKghbegk22jSJiShTu6B9wHmqx59nL4PwJ5seq5SBk9gt33P
         ropQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761813669; x=1762418469;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU8uRCsjTSwrlvmYL3d8u/PULJsMie63xUHiHDK3zBs=;
        b=qnA74iTkUByIi942SoX6MIFriS0mg83b1w2DsXEFT1yBOhYBKF5wGCNacFKbYb+XuG
         PfRolXhBW3ioklTNNWVnwBNXrBzET/SL4XsgDwlyjkrQRYMeO8Fp/5ve0EVO8Yam+1L2
         FJNH41MLvpf1vFTAEFcw4hhfftNTktY3Dy78JdPEVmDw6S1EFcqQIGZpH2LEt3Gd+kCZ
         kboMJq3B4nFfLOrdT4fR6jYHI/Z5RJ7/WKJNc17WUBv5vkwGm1xYy+bHXzn9dsK3gRWW
         POgb83F10MyPOEkna263VMKPd3MYEISpvEOQdgV7WeynaZVVN8alYqxTogjsFWxPQbQz
         zueQ==
X-Forwarded-Encrypted: i=1; AJvYcCUty8WJH2LqvnduwDSuk2kCMW5NNTzC3E9vDD3VK5xTbrcWVyh3gaxlTO1oVOZfg5GotYHNML5hBjzSXOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8urv4R+fZqjvP0QVFVNNU6AKTw0+wVWf/mTxrUHWcKAtgMqnn
	Y7+vEYgONdoBghy2wf7pi4UaJXCHCZzYO+qH59ZGX11zw/vmrO4Dli33qOVH8VdVqqI=
X-Gm-Gg: ASbGncv7C45d/e40EE79niqhSUuw7FgPJelC5QxhVuITtm31ydB5amEyeuUKRSqgfue
	LYJ671D/GbGRRmgcNoOrw/Nzi2iYFugtrkXH0w3oBZQhN6wgsP9TImWOsHr+CNl4zK5VsPdQbd4
	UVKTTAAZiF6bQbtNDiNfOVKMl75O5+e0l84eXngS1qyQ0Lu/Wf8QvnpKUPtxqFZ5rmfSMk4v2i/
	OJY9G1gHZplbO2xhEgoD5LE8L5GC8pzH6tvqeWOhARTzdN2S1XKmnhazAz/oVLlODiFMrT4PGR0
	Ovvm0HLaBoZRuRhrXBpQWEsch6InhPIHoiUU6y0LuTOlWXuRopfD4sBPUrG3HM/bc6au7AEdgje
	G0s3lteunUCLvd3+VrM6m2V5O/u5e3SGl6pcXVi58iQfNISibNj+cJgzuxtykPaO1M1KYT6YHVg
	==
X-Google-Smtp-Source: AGHT+IFwKPzXQBj8+qdUcovmW5nKytQ1wr3jkj35PQinv3BFL4IiVgDQRKAM+0DPrZKXF0WjOPRCMA==
X-Received: by 2002:a05:6000:25c2:b0:429:8ceb:ac3d with SMTP id ffacd0b85a97d-429b4ca2f6emr2088198f8f.56.1761813669384;
        Thu, 30 Oct 2025 01:41:09 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:64bd:9043:d05:7012])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-477285d1e43sm32002085e9.0.2025.10.30.01.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:41:08 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  chuan.liu@amlogic.com,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  da@libre.computer
Subject: Re: [PATCH v2 2/5] clk: amlogic: Improve the issue of PLL lock
 failures
In-Reply-To: <20251030-optimize_pll_driver-v2-2-37273f5b25ab@amlogic.com>
	(Chuan Liu via's message of "Thu, 30 Oct 2025 13:24:12 +0800")
References: <20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com>
	<20251030-optimize_pll_driver-v2-2-37273f5b25ab@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 30 Oct 2025 09:41:07 +0100
Message-ID: <1jy0osye70.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 30 Oct 2025 at 13:24, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:

> From: Chuan Liu <chuan.liu@amlogic.com>
>
> Due to factors such as temperature and process variations, the
> internal circuits of the PLL may require a longer time to reach a
> steady state, which can result in occasional lock failures on some
> SoCs under low-temperature conditions.
>
> After enabling the PLL and releasing its reset, a 20 us delay is
> added at each step to provide enough time for the internal PLL
> circuit to stabilize, thus reducing the probability of PLL lock
> failure.
>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  drivers/clk/meson/clk-pll.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index 629f6af18ea1..f81ebf6cc981 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -368,11 +368,16 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>  
>  	/* Enable the pll */
>  	meson_parm_write(clk->map, &pll->en, 1);

New line

> +	/* Wait for Bandgap and LDO to power up and stabilize */
> +	udelay(20);
>  
>  	/* Take the pll out reset */
>  	if (MESON_PARM_APPLICABLE(&pll->rst))
>  		meson_parm_write(clk->map, &pll->rst, 0);
>  
> +	/* Wait for PLL loop stabilization */
> +	udelay(20);
> +
>  	/*
>  	 * Compared with the previous SoCs, self-adaption current module
>  	 * is newly added for A1, keep the new power-on sequence to enable the

-- 
Jerome

