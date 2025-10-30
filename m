Return-Path: <linux-kernel+bounces-877787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF277C1F063
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2C018848DD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C573F33769A;
	Thu, 30 Oct 2025 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WDizQboA"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB30826FA6F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813651; cv=none; b=FHZEp5FDL8L+fOLDFX8BgjnD2c7avhf5PLBKbHnbEfF45cOFk5Xx+Iy9N92mz98/FPV9ds/xl4C3LVWNL8HdIB2jDay3o5YGtuF/lPJL3ugbIwenxcNQCZn5QUkXrrr5os8DRbFqwu8Hq2xL2yP/t9vS4GFpWOYcA/HDHlAzilM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813651; c=relaxed/simple;
	bh=k/S2yzJ6cOQPLI5rFjmKTI7kOQZm/WqgPVc416+Mxdw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=axZrso7+9McgKR49zg08xh8Mi9YF0Lt2/Rl/aoYniMRcJpkNClf3I18eAVsX/aOIwuL6NBFzKR+lMieLe9g0ewOMo2KZqEXlg6ZWDdJtSAufhGhafVCeYY0RNU0PJkTJnz38mN8h0XU9zd6TgmEIPsgHoxTd7PoAk2F8K1BwkJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WDizQboA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso599922f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 01:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761813646; x=1762418446; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6Foz8MaHxrmEMOx8NcxHNFwNAdtDbaYeCNwJR7rWXU=;
        b=WDizQboA4FS+U81Jwa0fZw00YAiXsgi4SiQ6llE2YZOOvvak4kxtRtzqhWUQ9cOu1p
         vJtyySQYb9EnKCeG3bdBw1sY5hgYJBfJ6Q3qZ5y4oTL3Hcwy3bjRas/VgT4aACQ+Y/dU
         HECkXZnRWI3jv+aebXfYGDyw4XQybvESxzmtZUWlzsD1DN/y4FAAEjIeu3JOd1/RYnCq
         Q/xdPipykx56qkOwFy1zYXc5LAVW34C9OHFxKUvWbft1oPjr4tzdts3uz7ZY6dFYwGj0
         UF7KHLVvKhYrhmCgJbDSUNzKAVE1pIMZbE+dacIvW/acNI/AAESyJ1QZOVMQonEvLBpV
         /wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761813646; x=1762418446;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6Foz8MaHxrmEMOx8NcxHNFwNAdtDbaYeCNwJR7rWXU=;
        b=uts9h4IE4l4TYGrjNeeUQBqAEvpeuXQlr4S5g1fRTNLB2arDloNCO0woYvrsuA5INw
         B2lTZd+KQhmu7lLg9bWhPpsgQVXKxD3c43gjh7GTzJRkGF+wasOZBh7NXsG2uLAZ9l+u
         0dqVypDVbkM6g3mXF+CesPkRpe/vghQJDh/tezLJTL3d8uerO236z3bzvh6TbJzS5pef
         1Z9KxRWOx3ZoW5NtruH+3z8Z3Lu5NQqEFVTs3n7pOqZm3T12+jMQg8zb/7UdeukNT8aw
         IBfl4bIlX6wOOAuL5soJjOiRT5nmq6iAGoCR0aX1q69YDZlrQh4Qy3h0JC2JNcDvnE2z
         E4/A==
X-Forwarded-Encrypted: i=1; AJvYcCXDhwWQBAE8DMnBVOW+AujElFmy3D+5yC6aqdfunHCEVVm2E9lxBgzMW4356RREJdtirgCyM5D3iiaQrzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YylHPOUJcz90mY+HeT1JyHC+TG39EaJ2wK7F/zWUayh9uuVn9mk
	KINGDMMn1vLwNkD1oetKHaHw4rx8tncoet4twa+mLTxDnMq7nn9XktQPgxGNVi+jcA0=
X-Gm-Gg: ASbGncsPJ2bhifxBQcsPglWgGxbh0fpIda6XbBc+pDt+fTWoh/riqQBfMhH0fRSk043
	vRVMlTvv39wCcmt+9i9B3p0KKGTQXXFD+CRhEZjdOR1n7pG4pgngUyzQWvkdhWMf/Ny4sQp3jNi
	DbY1ogvmTkKXhvgdJ/qLb5sC4Lt4lONyIH05PsZAxNi4DA2lhAZjOaGI5GtowEEMa+d/HHFzsom
	rv++pvFjw2G38bc9gV3+YgntoaNnu3n8HMnVtk3XOtymwYdZpSJKzNh4mpvkbGdow5zgBNVBxo5
	5p4T76hZztjaaZCu40r/1WLKwkE/aRf/V2XltY0zVFB3/+tu9K7O/r6L6PvRFBuI5D8sN39kVvH
	nqX+xk15I0suoD3vX+gBj1XB1mU5FUMU7fGLs7CBphvlSN/9lqZUtadLgKPpvLUrmWxxTPJh3Q6
	jCYbd93lb0
X-Google-Smtp-Source: AGHT+IGwgkS7kM3RE06V/HkLJNjMRlWeQ3z1eYRlCMXE2II174VLn8RIAaLYjqz/6xJH+FF23reQDg==
X-Received: by 2002:a5d:64c8:0:b0:426:d53a:fbb6 with SMTP id ffacd0b85a97d-429aefafca2mr5110907f8f.31.1761813646130;
        Thu, 30 Oct 2025 01:40:46 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:64bd:9043:d05:7012])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429952b7a7csm30904879f8f.8.2025.10.30.01.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 01:40:44 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  chuan.liu@amlogic.com,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  da@libre.computer
Subject: Re: [PATCH v2 5/5] clk: amlogic: Change the active level of l_detect
In-Reply-To: <20251030-optimize_pll_driver-v2-5-37273f5b25ab@amlogic.com>
	(Chuan Liu via's message of "Thu, 30 Oct 2025 13:24:15 +0800")
References: <20251030-optimize_pll_driver-v2-0-37273f5b25ab@amlogic.com>
	<20251030-optimize_pll_driver-v2-5-37273f5b25ab@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 30 Oct 2025 09:40:43 +0100
Message-ID: <1j4irgzss4.fsf@starbuckisacylon.baylibre.com>
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
> l_detect controls the enable/disable of the PLL lock-detect module.
>
> The enable signal is normally active-high. This design ensures that
> the module remains disabled during the power-on process, preventing
> power fluctuations from affecting its operating state.
>
> For A1, the l_detect signal is active-low:
> 0 -> Enable lock-detect module;
> 1 -> Disable lock-detect module.
>
> Here, a flag CLK_MESON_PLL_L_DETECT_N is added to handle cases like
> A1, where the signal is active-low.

Given that A1 is the only ship supporting l_detect, this change is not
necessary.

Not now at least.

>
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  drivers/clk/meson/a1-pll.c  |  1 +
>  drivers/clk/meson/clk-pll.c | 16 ++++++++++++----
>  drivers/clk/meson/clk-pll.h |  2 ++
>  3 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
> index 1f82e9c7c14e..bfe559c71402 100644
> --- a/drivers/clk/meson/a1-pll.c
> +++ b/drivers/clk/meson/a1-pll.c
> @@ -137,6 +137,7 @@ static struct clk_regmap a1_hifi_pll = {
>  		.range = &a1_hifi_pll_range,
>  		.init_regs = a1_hifi_pll_init_regs,
>  		.init_count = ARRAY_SIZE(a1_hifi_pll_init_regs),
> +		.flags = CLK_MESON_PLL_L_DETECT_N
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "hifi_pll",
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index c6eebde1f516..d729e933aa1c 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -384,8 +384,12 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>  		meson_parm_write(clk->map, &pll->rst, 1);
>  
>  	/* Disable the PLL lock-detect module */
> -	if (MESON_PARM_APPLICABLE(&pll->l_detect))
> -		meson_parm_write(clk->map, &pll->l_detect, 1);
> +	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
> +		if (pll->flags & CLK_MESON_PLL_L_DETECT_N)
> +			meson_parm_write(clk->map, &pll->l_detect, 1);
> +		else
> +			meson_parm_write(clk->map, &pll->l_detect, 0);
> +	}
>  
>  	/* Enable the pll */
>  	meson_parm_write(clk->map, &pll->en, 1);
> @@ -413,8 +417,12 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>  	udelay(20);
>  
>  	/* Enable the lock-detect module */
> -	if (MESON_PARM_APPLICABLE(&pll->l_detect))
> -		meson_parm_write(clk->map, &pll->l_detect, 0);
> +	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
> +		if (pll->flags & CLK_MESON_PLL_L_DETECT_N)
> +			meson_parm_write(clk->map, &pll->l_detect, 0);
> +		else
> +			meson_parm_write(clk->map, &pll->l_detect, 1);
> +	}
>  
>  	if (meson_clk_pll_wait_lock(hw)) {
>  		/* disable PLL when PLL lock failed. */
> diff --git a/drivers/clk/meson/clk-pll.h b/drivers/clk/meson/clk-pll.h
> index 949157fb7bf5..83295a24721f 100644
> --- a/drivers/clk/meson/clk-pll.h
> +++ b/drivers/clk/meson/clk-pll.h
> @@ -29,6 +29,8 @@ struct pll_mult_range {
>  
>  #define CLK_MESON_PLL_ROUND_CLOSEST	BIT(0)
>  #define CLK_MESON_PLL_NOINIT_ENABLED	BIT(1)
> +/* l_detect signal is active-low */
> +#define CLK_MESON_PLL_L_DETECT_N	BIT(2)
>  
>  struct meson_clk_pll_data {
>  	struct parm en;

-- 
Jerome

