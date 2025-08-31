Return-Path: <linux-kernel+bounces-793455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC93B3D3A6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 15:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EEE1894753
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F93526560D;
	Sun, 31 Aug 2025 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWnTr8fa"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A20267B94
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756646900; cv=none; b=sd2xps8foJKcTcaGCm7C7PSda4538i241lTqTcGj4iXOCjziIRsod4Hd3PyklYumrjOz+oX7BsfRMBdnbCNeB3x57VBBeLCP/lratqGmAWL4qecAU9giFrD79wOZSMIRr2OHVcrZrilxRfDopCh8oRiODI6dafhZ4sn8MsDHPOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756646900; c=relaxed/simple;
	bh=ST8wHdef2LgPonMkQdZRXjWtFBeRH6dlNAeB4eL/Hmo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l7GfWcTqpGO4eX31bzLTal1k+wZ256NZWgh9O3pWj/K1I1Pj93fGTkGDWOclZ/eGyqSXhSRHJwA1CXCH+SsauHIzK/Ko+EowHBiyKylQN/fcg5JEtQXE4i1HNSsBpHyza9MfqjIOKuLKuZBuBuD7FN2p/HDCmyCoz8Eahzsf5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FWnTr8fa; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b0ce15fso3810115e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 06:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756646896; x=1757251696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUsiiWH7g4d6FEVfKTRPbe3R6ugJoOhF5bsWtOAIO6k=;
        b=FWnTr8faMjnNB12zUdraVl3FGqwHH7oQQBg/HvIOi2vusa0cjXY5fuooqPXTj4dFli
         VtgDnoa+ZaTHrrYUSDBCChpWQVNqrtrpiQUyD48qbtzGkRnXPq1KmiAvpvTYKRs+qGv9
         mfgVIhNJ1fmsNlxtfZExJ82+ItcrK0KDzfFE9iKrVGxQ0YxY7aBsONFOTYsUjFfO3Q1S
         /UKViy098h4uWO3VcDgyRLLuQy2q2RZPORi6ox2NrOtbxwFxLUZaopOv3r4CRfSZ4xsU
         tWyfbou35YmlbpGkbJgCcDlQ0CMtoMn//8sb99G2Qh8AJGEnvQYAV89LGJXJkle11gq4
         7Tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756646896; x=1757251696;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUsiiWH7g4d6FEVfKTRPbe3R6ugJoOhF5bsWtOAIO6k=;
        b=ORKch1k5ZRSAx+QB9Jxd0n1QTa9WrtfjuWf61nJqNIDigM9Oh04lC/+VH3Jl5w2RfL
         b8fLIvb0WPvlpYn8y4wcEKrjFwpOQgWcIpxGrYWs6au8WYAuZao5DjFRd5RoL+Dn84rf
         +ewU6w8sq+hiuuN94lerkAMdeuKcn/axhUTOxCQKqGTDR3aAnTZHHRLSx0AIMPTL0D+B
         hD/NxH+6vKOSAAUbfxUZzecqpBDCEIHg28R/onDYeCNwCwF4lgyV5LKriyC36SSQMvVa
         HzeFKIE+wAPwf9O7FpnzRyveyvkeGc7zKCftNHgU/1bc2nsbLkFYcjzx8KEqhnJNEBXM
         Ex3g==
X-Forwarded-Encrypted: i=1; AJvYcCVQn7qKIJfF56DScTzytyezbxDyGRByM1/fUVCSoSA1qTdtJjc6rivuN9IMueIPfjpoEcSCEd5XSxlgCxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3U8wI6AWXow1XO+vxzFPhu4TW8aTG/4LhqDlAD1d8SoXh4Ez
	8P/d9YeDIteeUBaaRd0V4OiiMg0uo6PG7Q0KFQglM2dlp9/+SZ170xwteFsN2F1/AW0=
X-Gm-Gg: ASbGncvGHL4eIYonA0gN8hohquGAxvyo7+6KypChsDD1uTzJRmQeR9GfqeVdO+jQDNQ
	VE5c3xapGaNj7dmNpfJSeBhPoEYUYSIcBYzevziDLw1a/iClYS8df/JsTFPs/LRGwQdwHsUfI2u
	k6Zl/IgOGEUNtz8GuXPiKKKxed9JgdQmwOfx15/6kCO/d8SlE4bjoGBqrUSjVIBC2LPMvpV4jhJ
	tTK0fynqsjgMOU2iBB5Qx6QCCbE00V33YAlZPKxT+PlpTp8lxHyUXBlDZ3qZwSoOkmN2FG/yVab
	urEgQxvi4y0L34hxAvPvHCTYpEV9erdqTdQUJUGLDLxCmNsrlo4ywzoVscgNMZ6OvU6Z3AcZIt1
	m8dyMX4mEYnl4sEuRTfvDg4hvyNiB+xTYjpg3BgcvFzI5mKAArQ==
X-Google-Smtp-Source: AGHT+IHuGuVHHk5pZhTIqaJ6T0pRMpVLKOi+qYDhard/uCHRhDaK8a/HDroJFFPgp6qQQ0xTGeYLmw==
X-Received: by 2002:a05:600c:6385:b0:451:dee4:cd07 with SMTP id 5b1f17b1804b1-45b81e23616mr32007925e9.0.1756646895694;
        Sun, 31 Aug 2025 06:28:15 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b87b3900dsm29956925e9.0.2025.08.31.06.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 06:28:15 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: jesper.nilsson@axis.com, mturquette@baylibre.com, sboyd@kernel.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org, 
 s.nawrocki@samsung.com, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
 linus.walleij@linaro.org, tomasz.figa@gmail.com, catalin.marinas@arm.com, 
 will@kernel.org, arnd@arndb.de, Ravi Patel <ravi.patel@samsung.com>
Cc: ksk4725@coasia.com, kenkim@coasia.com, pjsin865@coasia.com, 
 gwk1013@coasia.com, hgkim05@coasia.com, mingyoungbo@coasia.com, 
 smn1196@coasia.com, pankaj.dubey@samsung.com, shradha.t@samsung.com, 
 inbaraj.e@samsung.com, swathi.ks@samsung.com, hrishikesh.d@samsung.com, 
 dj76.yang@samsung.com, hypmean.kim@samsung.com, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, soc@lists.linux.dev, 
 Varada Pavani <v.pavani@samsung.com>
In-Reply-To: <20250825114436.46882-4-ravi.patel@samsung.com>
References: <20250825114436.46882-1-ravi.patel@samsung.com>
 <CGME20250825120710epcas5p421c3c8169019599e76f782bb7086e0e1@epcas5p4.samsung.com>
 <20250825114436.46882-4-ravi.patel@samsung.com>
Subject: Re: (subset) [PATCH v3 03/10] clk: samsung: artpec-8: Add initial
 clock support for ARTPEC-8 SoC
Message-Id: <175664689350.195158.6648344469963977673.b4-ty@linaro.org>
Date: Sun, 31 Aug 2025 15:28:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 25 Aug 2025 17:14:29 +0530, Ravi Patel wrote:
> Add initial clock support for Axis ARTPEC-8 SoC which is required
> for enabling basic clock management.
> 
> Add clock support for below CMU (Clock Management Unit) blocks
> in ARTPEC-8 SoC:
>  - CMU_CMU
>  - CMU_BUS
>  - CMU_CORE
>  - CMU_CPUCL
>  - CMU_FSYS
>  - CMU_IMEM
>  - CMU_PERI
> 
> [...]

Applied, thanks!

[03/10] clk: samsung: artpec-8: Add initial clock support for ARTPEC-8 SoC
        https://git.kernel.org/krzk/linux/c/bd5336e3f7040f300b01702215b45e6267a400cc

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


