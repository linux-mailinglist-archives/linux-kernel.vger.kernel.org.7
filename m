Return-Path: <linux-kernel+bounces-793360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A9FB3D250
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 12:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4997A17E5FC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2792459C9;
	Sun, 31 Aug 2025 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7ZEfBg8"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37D81F3BAE
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756637750; cv=none; b=CMMHEcsOZT5Kn/99ZNMs7pyHgtruT26Z7klSxklwvZ77XeojOmYPf0vvNtvxEsQTJCTO/chG2ULdf44WBZY9LbeG+AdBotlpoq7yCAUZ8Su7QQrq18OMpZaQyO1DCixVFX9mrmnqDbHNjlVMFQ/Z08NmwTEmeyKBJiNWo0/OA7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756637750; c=relaxed/simple;
	bh=xi1fLpfGfUX4eRrB19iaWWJsrywWFFqGcHHL0PuDem4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BNCplU4xef2IC6tzhdg1Iuo3rgv1whTYq+uv3CNOOLoLTCIZLMNeub0yP8xyRc9VtsDerKMArZIxnUeogyCLRDEAfr9TxE9dizg2DWMQxDzGrpigxismAD8nj3EbmnX704grHuN0SOTUmOAEdDiWWROxALfWzhZdVV10Y2WGzZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d7ZEfBg8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aff08beb8b8so32371866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756637747; x=1757242547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9Ikcisp0DawIJEHv4fsbvQNKoZVQCvvL3i/2eqE6R0=;
        b=d7ZEfBg8w+/45HKi1OdAwAejyFJwpmygh5Y7puMvIEh43PxrcgBIKbtrbWQ/SKKdzB
         1GvqM4nEBa5w0JE+WgOuQraSM7mp5pNdvf6rRioYh0VttSvrTtRHNVN72sHy+W4yrXqj
         dO4Z6kHDMTrb9VzGRRlK9JDpy9Tr4WQcNWOa7llccqBLeJvMQ3yyJl7JYjCII36d4yid
         0C3/V0lI5i7+cJJwjpsOjQVsMZhi+9d1EnCwaVLjsATtkfWgCgValWscRcpUtywgqbaL
         kZFCwPc6P0i3XL3JGo5Lf5LTdecRWjCUEy3IjcSFytRmU/9xfz/bYEL0WJY70wKoJLin
         /LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756637747; x=1757242547;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9Ikcisp0DawIJEHv4fsbvQNKoZVQCvvL3i/2eqE6R0=;
        b=Mrza/AhFXlU/ME+rTQtAZ0+QHXYq63ww2XaQLdagTRwHng/5lGqrhfwJic1Ro8JGTQ
         MdlGgYlMG23tT4AMtVbTyKiEQB1RHes6M44riv7y6V0k19VeFz+b3DimAs4f2SYORThC
         5hpC/J7tZyoIJdTBlFJCDqIERxaaTF09NZKMplsojA0CD0jZbOl5JSHqCPxB9kDUwhCv
         jIZovwbrNvqHVpS1PjzCv5gM2Xny7Ne891lYOr62Ks2+Glfhduvb/7PRp62mFQ/86i90
         45YhRegyfC9XGfoQS8VY5ap6sv3j6tMexaGNfwe8/bybRpOUkqDzUGUM7G6xyBvZ3NbA
         a4ew==
X-Forwarded-Encrypted: i=1; AJvYcCUPfIeizDIVQV6Afa0taSvX+OP3ja8Xm682iY7E6aXtd8TXwsBjyBUbcZGcoSMucP5+5FM+ZWgGOkdsI08=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeXlY68xz4fzmBJKmnZXZCPY+WR31AwrqfTuJF0Ci7qNiiOm6J
	K8nyJBV5BAU3pZLG0iatBqttQi6tGy29s9UCklXSsNMy0l/SYh8U8OHnWEKewpmxyhc=
X-Gm-Gg: ASbGncvMUkkAvj/xmlHydm1VtnnlX2rAddTgs6lwQ/A+O9h5yEph3JkXJ1dsmXnXsoW
	D4myjb6kn6g2IwYc+Bx+izjNdBWeDBE53xO/QNDbdLekBUgHARA1OuvVj+qtsd9pUDd2T//WbBV
	Elhf36Y77SuH2L28qMAlEyziX7mtqZMVkTo9joHIotfCZQ88Ey041ZjnkS5WqRGUSaZd2RWYMkD
	H4oFgFWilaR8m6XxAzG6EtmTGISxQmDuBTcKNvJwbFLE20+UXONxaQwiS9vu9uxDwudh9TepKX/
	7pUJ9Ahd3K+MtUM7uZkJhsrATtpP+kGzB0ZmVtu0SS/hX189wvnGl1V/qUBhJ/nQe63LLduvx/F
	ZDrTe7hImVxd6FiUFZhu6bFENo97Ppdmuj8hfHroXGxoYDXeFdg==
X-Google-Smtp-Source: AGHT+IGQnHEGxYKHduO0rCDVlsbQla5BpUnmcBYqLI8jWWy/4+T75FA5udztvTzcc7SvlOo9rfc4BA==
X-Received: by 2002:a17:907:e8d:b0:afe:d218:3d21 with SMTP id a640c23a62f3a-aff040b2788mr405254066b.4.1756637747009;
        Sun, 31 Aug 2025 03:55:47 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff12a6b404sm468318066b.88.2025.08.31.03.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 03:55:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20250830-fix-cmu-top-v5-0-7c62f608309e@gmail.com>
References: <20250830-fix-cmu-top-v5-0-7c62f608309e@gmail.com>
Subject: Re: [PATCH v5 0/5] clk: samsung: exynos990: CMU_TOP fixes (mux
 regs, widths, factors)
Message-Id: <175663774498.35421.6694005756444857104.b4-ty@linaro.org>
Date: Sun, 31 Aug 2025 12:55:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 30 Aug 2025 16:28:37 +0000, Denzeel Oliva wrote:
> Two small fixes for Exynos990 CMU_TOP:
> 
> Correct PLL mux register selection (use PLL_CON0), add DPU_BUS and
> CMUREF mux/div, and update clock IDs.
> Fix mux/div bit widths and replace a few bogus divs with fixed-factor
> clocks (HSI1/2 PCIe, USBDP debug); also fix OTP rate.
> 
> [...]

Applied, thanks!

[1/5] clk: samsung: exynos990: Use PLL_CON0 for PLL parent muxes
      https://git.kernel.org/krzk/linux/c/19b50ab02eddbbd87ec2f0ad4a5bc93ac1c9b82d
[2/5] clk: samsung: exynos990: Fix CMU_TOP mux/div bit widths
      https://git.kernel.org/krzk/linux/c/ce2eb09b430ddf9d7c9d685bdd81de011bccd4ad
[3/5] clk: samsung: exynos990: Replace bogus divs with fixed-factor clocks
      https://git.kernel.org/krzk/linux/c/a66dabcd2cb8389fd73cab8896fd727fa2ea8d8b
[4/5] dt-bindings: clock: exynos990: Extend clocks IDs
      https://git.kernel.org/krzk/linux/c/76f1e2ee545b3165e1e24293b59414699118266a
[5/5] clk: samsung: exynos990: Add DPU_BUS and CMUREF mux/div and update CLKS_NR_TOP
      https://git.kernel.org/krzk/linux/c/8c82bb53669b1e82435b5a00a170b7c079940b82

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


