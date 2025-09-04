Return-Path: <linux-kernel+bounces-800914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C24D6B43DA8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBFF1C85510
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308652D47F1;
	Thu,  4 Sep 2025 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ll3IK9Mz"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDD3301025
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993699; cv=none; b=ltOqDzi+AdGrxomQhmYtNoghEm4Y4nB7ygYwa/I4vaJiwMC4mGtDfBbHBBEmIEVpLv0ZfY0uF51cNF6Mn2HBXadRkmD1TsBVUmDUtsKAKo7oBsc4qLVRfl5QL13wq0oov3xHA6VOO6ydteOdDm7AfSEhYV7PRNKCp5zCn/Gk6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993699; c=relaxed/simple;
	bh=5b17D17KCNLnqi/G2Z2dTgyoEWSeb8SG6sPYeTo5izY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Hwo6lXPY7PCEHRSaZ8/lSKFoU1uKiF3IemqyvozQh8OCjXPAAdju/hBBbEWD0arqGtFI4QYF85YMfjyuqIDpoeccbBABxSpZavbMWaJt7TUs3avARxtCSAaWB6Y0Qglit6ZmSokKob6M/p7F19KTD5ypk4K0VLV4I0JkyuX7BAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ll3IK9Mz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61ec2b5cb49so178923a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 06:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756993689; x=1757598489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5PfVj7z1U9Fq+QcRMWYVttXEzyn9uOL+vv6a+ytkds=;
        b=ll3IK9MzbAsGWBYZYSLZwhueudyH7E5mbvXA6FF7OJ+F5GdVVJ5/9kzlfA7Rs00Zdk
         wWLm4/l8mU3uD17NgaH9Dw9w8gvCt96No8IhNVO5h1BkSzxDdcvRKCVwAZCyUTRTFm9E
         xya6RRwKJVKmRupE+mBQoap7vojfayhu+UxgPYGMb8FY+b/YQNU8UpD4ilz/yqaFI8+t
         WpHkmXptPNt6EfA3sH5G8inCFiDVj2Hz9WEqfEwQEBt7CBpbLue/4Qn6wigdH+A93mJr
         dNGeduqbBTL23LYBgzbYpSnWmDnyfjZD9qbw4LWfpNUP4bTYAdRgYeBjz3ourSxYXFOJ
         3XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756993689; x=1757598489;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5PfVj7z1U9Fq+QcRMWYVttXEzyn9uOL+vv6a+ytkds=;
        b=dHq46KRK2eCfgO5WuB2LGfJUNyoIFAAaZDH8JGAAkiwYnaJVm1Cmu8q4hkh/gFK6aM
         CthO3g/2oy04FrFMr1Leabrdbdq20t16fuHOnrnC3d5TgcQeVjREmRT4qCRcQKUxKgpX
         /vk0TZ5IRZvPGAHMhI4hUJiMniBRrWrGv3U2BSXNn8Dc9wDN3rpk20UZwlhOSJR1ec9H
         BX3M+YdrHyfm8+irT6d2XR0DcxbQNzV8DCofJx06KYveMMVuGveuZoPn9aaoOiulzfHs
         zoVJoQLhb/deK3+2DtrI0wc1/It+EtFYbvO4wdEhjdMtfGQhrfiTULa5V9pERjz/Yqtl
         KsCw==
X-Forwarded-Encrypted: i=1; AJvYcCVKQhyAH4sncKJE2c1NW4BxZBKXSXTSi2Wk2++Ps47T3L4j7OnN/lnLMd3T6FEOMUiKkX1fu+Spne04a8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIKqIN/WQAV+KRsOVMaYDGkhT+jB1IpOJeWg6xIaQZiAbQ5tA
	z9rm0aJo/7E5StMIZ0Ea+Gp2wdOSRAwcI077t9/0Td32TTdlwew85QTaGyMsHP4Xnh5yuDJ8YFg
	d68Kl
X-Gm-Gg: ASbGncvh2rnaG8D2ZlCMVEbuLmzsIeRZLGjz+Ycgo7GXR/y81Xd93IZkvDIqtCS+W0W
	jfOwk2QWJ3cbl43+mm76dDUos1QjOkhI6w83rkR4xheYhIh0xasRyu1feMb8s7j2JKoG8sNuYCB
	qj5uW7SCSG8zLxoxM5Xn0j84gvRHNlBYRJU3mJwrewsfcsmxbhUVNNabw27tVQ/jI69eUaG9aJo
	8vPNowpaphTOB46cUxS4yX/P1/nUFUyV2sRQNag3DLIiiyDik4l9Knx3Yx519rjuecVtD3gCAgY
	eF485Z5YYtG1dELWo0G1DhLSON7qhQoqM/qx6kkWIEaAGk9JvgsIpQXQ7CHU5JJSzpA4D/DnUAT
	6eut/dvOcltIyxjdAABwuJrNij2GbGVqynREL+/Q=
X-Google-Smtp-Source: AGHT+IFXmHyLiRikp8i7AT0rm9igyDk82338TdO+dG49oonCsmp2DJJwv/hKJNb9HHXBa/ePNM0EKw==
X-Received: by 2002:a05:6402:354c:b0:61c:d7e5:47a3 with SMTP id 4fb4d7f45d1cf-61d0d365421mr10482985a12.3.1756993689530;
        Thu, 04 Sep 2025 06:48:09 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61edb0fdf1dsm4243221a12.18.2025.09.04.06.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:48:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250831-usb-v2-0-00b9c0559733@gmail.com>
References: <20250831-usb-v2-0-00b9c0559733@gmail.com>
Subject: Re: [PATCH v2 0/3] clk: samsung: exynos990: Fix USB clock support
Message-Id: <175699368813.172086.8536010951360222334.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 15:48:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sun, 31 Aug 2025 12:13:13 +0000, Denzeel Oliva wrote:
> Small fixes for Exynos990 HSI0 USB clocks:
> 
> Add missing LHS_ACEL clock ID and implementation, plus two missing
> USB clock registers. Without these, USB connections fail with errors
> like device descriptor read timeouts and address response issues.
> 
> These changes ensure proper USB operation by adding critical missing
> clock definitions.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: exynos990: Add LHS_ACEL clock ID for HSI0 block
      https://git.kernel.org/krzk/linux/c/eb9bc162775cabfc4cf2b37cb0d3c2c2bf4c4b54
[2/3] clk: samsung: exynos990: Add LHS_ACEL gate clock for HSI0 and update CLK_NR_TOP
      https://git.kernel.org/krzk/linux/c/d0563d320b6014a8d56170253fe0aec524658b9f
[3/3] clk: samsung: exynos990: Add missing USB clock registers to HSI0
      https://git.kernel.org/krzk/linux/c/f00a5dc81744250e7a3f843adfe12d7883282c56

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


