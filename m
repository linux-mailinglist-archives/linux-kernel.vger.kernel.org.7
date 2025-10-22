Return-Path: <linux-kernel+bounces-864873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99079BFBBF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8471353F64
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C6733FE07;
	Wed, 22 Oct 2025 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KGcrgbF/"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D4033FE03
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134265; cv=none; b=USsaME4UzhRqnzn/Bte2ugaQwpYa/lOWLomedlRi2Nfltx1sSloyGJlOgn22hVbgxIjpKVoPXyed4Q4i+ypaQSpnYS+SpvLICOaIrSs2uMSMGelBm5aBBccrcjZHZbdKQsuoY4cE9iCY6QaHbgICzIg96gFK3Ux4ganuWVJFgDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134265; c=relaxed/simple;
	bh=8BaPCfQX7vMiRGCgF2IvivSuUs/Be4XjQvQi+SyJU6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tTXMKUmb/vrvZHL+Lw5MZGkx0X4D/J96Sc/Ob4Pfxyh0Mdj17xnX9Ol29t0stjOgtMM6ZBTVroVAU3GMiKAI+5IcXe3aTcJpx9qPrAQJaZuHnzftkc1q2ir7wL3p9lmQ5jXWm4nKiUbA47Oc7A5+H1VO0XyGZEXjTUK0xwH9GRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KGcrgbF/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47118259fd8so42510625e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761134261; x=1761739061; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nvWvVWsMp2HvZc/pRVfJNYeSWgEzu4aPg/sGoBmwFsM=;
        b=KGcrgbF/nxXSNFBtJQd+KbXkPWyf7y2INCIFWkWDIHRbCbj1sFryx8SIUwbbvbrjMF
         GabrLHd2SDU58Gt4I/bFPRUDdztxSKO+BB+x+3mTcHrvbz0BtU3epjqGox74XCnqH2/S
         DFU4TMQbW1QGsOmJ+HpFt0ssk/9BljaFsdbiRhIQD7fj0ignx9zEk8/Ym2fzGDg5vbgg
         TKc1x7mCITfTU2u8UtfKDak/MLJYL4Ijhwh/tK+xuHtGGR5Zp2bYIuPP7Vnro5nbOWTP
         FJhPHvK/cjuhdGI5rftV5euGZkKLrfFiKzmALQABVUYZTI3nOM5zLflM/fCWniqBXZlq
         zDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761134261; x=1761739061;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvWvVWsMp2HvZc/pRVfJNYeSWgEzu4aPg/sGoBmwFsM=;
        b=TGTFachFKNtqAobREPxz+4EqSIEoEjSULjKYba+Vzpi8FjfxMUrXM72NsMs01hgY5C
         sn/+Nd3G9dLr74pF5zYggEnFrIzph/bNOoSpOoMmJSolz1l12izzf0sZ0zq/w+v6IcUg
         B8u2txcckhYrvXW+JoThj0/+keiqu3WFhdmXzNE87nTpbuaLpUIU+cdg2PJdn6EKkj5h
         RI6HorKIq0KKB5/PgjO9WcjQJiB5hOEmioeNF8MRKYIYYykpt1FcJnz/t0d+X6EUwqxr
         Bbo5G/Yzdv2BiwhZnKdJsfsojPYc/77GpsXtRyFBWVgYJ+HEab0oIeiXF4f6a44hZlWQ
         k55w==
X-Forwarded-Encrypted: i=1; AJvYcCVbus9Mhv+u36FPn/z8O2VNBCg7MvWDdsQclktOnS+bEJLg5msnoYlQSHOn04/MitrIrlLOnT/xuId1A1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaBUAFy2HkJ/79DqI/+Q+4jSGZGRsORJ9r8dr8X1w7jaAjKuZX
	BLnYRhhqDTfSr3iSUbbtBZQ87cEWjnIryB9Q26+OQT/jNTNb9Espw6ux9r4Hgva9j3E=
X-Gm-Gg: ASbGncujPMVtzdGzMPxuWzQeJ+CXKT/Pz7oC2H9O8FlDSzGPaCfeqSAqoQojanXAmPx
	j3auykWmOLLKEfVy41OIylDtbaZUsRIUygSb+KUwenT65VPwuzHRpqnLMYXSVEX5hmbetC4Y47g
	xut83kmLDFbRBELwXwmkX6tjb9f/88iyvBOzaDHaLDzbkUAv+ddLug+cBMfYP3w2K8qqiGkEztP
	b/LMJMcoAKwKzHgNW7JPzQU2OBObHnFroGSHiFz78fuBNIp88d208FM5SCIvbtgEfjq3w+8j6+t
	mKEiuWIO3Cg5xcLmBBCBRuLy+pLymdOdWV07a6LVfjJAMRlPAwIWKWixRCupp4QnRhGxxpsOu/4
	n+yRVDgofxK+t7HbwfLEN47xik+Y2QSdZQfIFuQsC6PzDdCQ31DdvMqW8dK42SutV4Sk6RYsNkv
	1YH3AgDZSP7w==
X-Google-Smtp-Source: AGHT+IHU1kUQ/j+2c0DWldc7DeJQPageEV0i7vez8IloaeUnW6bD/qTCz4m2QvWTUpZaGhquDY3CAg==
X-Received: by 2002:a05:600c:6385:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-47117912365mr156602265e9.29.1761134260710;
        Wed, 22 Oct 2025 04:57:40 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:bdae:f4f4:58be:ea26])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c42d9524sm39570535e9.18.2025.10.22.04.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:57:40 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  chuan.liu@amlogic.com,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] clk: amlogic: Fix out-of-range PLL frequency setting
In-Reply-To: <20251022-optimize_pll_driver-v1-1-a275722fb6f4@amlogic.com>
	(Chuan Liu via's message of "Wed, 22 Oct 2025 14:58:51 +0800")
References: <20251022-optimize_pll_driver-v1-0-a275722fb6f4@amlogic.com>
	<20251022-optimize_pll_driver-v1-1-a275722fb6f4@amlogic.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 22 Oct 2025 13:57:39 +0200
Message-ID: <1j8qh34098.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 22 Oct 2025 at 14:58, Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org> wrote:

> From: Chuan Liu <chuan.liu@amlogic.com>
>
> meson_clk_get_pll_range_index incorrectly determines the maximum value
> of 'm'.

This explanation is little light !

How did the problem show up ? Under which condition ? How did you come
this conclusion ?

Other people having problems might benefit from the explanation 

>
> Fixes: 8eed1db1adec6 ("clk: meson: pll: update driver for the g12a")
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> ---
>  drivers/clk/meson/clk-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index 1ea6579a760f..b07e1eb19d12 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -191,7 +191,7 @@ static int meson_clk_get_pll_range_index(unsigned long rate,
>  	*m = meson_clk_get_pll_range_m(rate, parent_rate, *n, pll);
>  
>  	/* the pre-divider gives a multiplier too big - stop */
> -	if (*m >= (1 << pll->m.width))
> +	if (*m > pll->range->max)

Making sure m does not exceed the maximum value is valid too.
You should check both conditions then

>  		return -EINVAL;
>  
>  	return 0;

-- 
Jerome

