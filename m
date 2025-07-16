Return-Path: <linux-kernel+bounces-733147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ED0B070D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D8B189067C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7092EE998;
	Wed, 16 Jul 2025 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YCYr+BL7"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D2F2EE962
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655369; cv=none; b=iHVHjlv3siNsrQ/kxr8t4Ycx1Me/720qnubIPduXzXRqvg8gyR1DKl/tzMaA39IicRJ/JSqn11wjNJKezog7pagRTptq2VCjBkr+19gNnkA5E1nAcb+0u9kzmPuXGkccE27YssHSer2roHCnagL/Di9t0qTmo1xkrL70LryInig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655369; c=relaxed/simple;
	bh=B7SsdO+MenMYckXWR84ZUdMgGeszbtfwtQYKlL+IKug=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U41uT043vWUj1X+EPaqbCvdpA1gNTLv1GfB91UdKT1v4EvIqi4Bp7wJtliRdS8ENrjbMZj5jgkdx/7vCtGkwQH/2dXHKSVs8/EGOdbwZN+fGj4BgLTmdEr6XrLcutMVpsmwygcW07p75kDUxzNtQ4Yhzt2DeO7xH8USR/5vVd9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YCYr+BL7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3ead39d72so134008866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752655366; x=1753260166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEwTO6jDq9O1mX9IG6Eme66k2aXlrb5FWoDpo6lnm8I=;
        b=YCYr+BL79jTPQR9L1CxHCYOtcpEswJv268F2OgdQcRxjzaEmNFdYmAZu2zHQAk63of
         ONFw7M5fHR46bIsXgDAny65czF1Rvozo7nqGMSYshOLgrArYDIsoXSRf/vFFYj8tdXvn
         w39FGMlQ0pi3PUhp1uEb6c3tyET1t/ZkhSQgQXWK+QMZc+4p0X9XK6pVDaT0/FuUqRqJ
         XrK3S5305s4595oqFfmTYxw2hqR+zKYV1AwAqPT80WMO1/3YOok1bw657wwzB2sWnn7A
         eO7LiQx25JDmbR7hgIiJuQdNJV3j52yQDGjFFhsb3ulqukl5fkj5UtUPjyBO44pFcZU6
         xXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752655366; x=1753260166;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEwTO6jDq9O1mX9IG6Eme66k2aXlrb5FWoDpo6lnm8I=;
        b=H3j2ylCFuaRNxIxknQe3qgReXrsfZeTZ27EkW1tOlCOxh8oHjeEx5AKB1ksAsRAmR9
         uSYCV1JRFp13B30kpVvGnL8TrRr0AhRnJLc1J41kutvmXAHxp4NqFq1o8JtdUMFwyyKo
         onpq9NMPVWr2gfzECiWfe9giW+sjqwXCYwHDYz9qOCny+JwCbOLqYFshcVkSp/cwd9t/
         GxlUNtoXOblcQtOLhHpDGGV5E2uYbErceZQ9vzbTz53XYMrqLpkM2YlyuE3Jsf7Q43/s
         AgcaJtxVC13mF1nYbOsR4LxobCu03T1YssIrengb7uKhVganxQ9m5Hfv1wwQJd/+HkZE
         kxfg==
X-Forwarded-Encrypted: i=1; AJvYcCUHIm2L4o5BA49S0JtLUJMihRZCVqgbDtxZyh4pKFDrizHM1LySDqSQvzwuCih0cvyQ3NPioQ05Mw/opns=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymfk2uwWisF3TZO3vHTVtxFIFmxHZTfZVTkgxpgt+NVUNXyvio
	YqqzI9aysiX7MaLSJ8WE21nI1swIMcgtF0dM55U2Bfad7tkhcyAT+SB0tkIOJUzwyOs=
X-Gm-Gg: ASbGncu/TJiiyXrkaOoyGLnj96gxu9orQzlP3aDv/qzF7Z8+/L1gp9LO+H+X9EzS7eP
	/1thvpm44yGqzON3LY0UYt3T4ZOkd07zB4yWI8zPM9dsOwhnqU80IeqvtGXiSVfahPKQWsvfrmB
	aUaOwQuoydo69OwlOmBo8XCUUHkvyV4bG1JZb3XuT93P8EGp0SjFfTScLpwavTgxrNhK7cDWeoA
	WH/6NAQll+i9PbdDNUcrEeppBy+PdYHQRARinOtPfDScficxM7vXbXYHk+Y6y34iI0ita/JjX4S
	pQjOavtobe4lMuOD+Vc3rg80Crz6Jd+xpdZ7yd6wtum/ESebNgB1KhgSGoY+x8tlGDa7c9YtJnB
	IKes/RNH6tip9+/14CW7Ma4sZ0n1GwiI73032
X-Google-Smtp-Source: AGHT+IG5VzneoFYbewswXVJiJQA7X4tnJGGDHvgb8EgFHw+/z6nhgITDJiBHyRBEDaIMb0avqqonAA==
X-Received: by 2002:a17:907:86a5:b0:ae0:8621:2233 with SMTP id a640c23a62f3a-ae9c99cf09bmr84890266b.6.1752655366273;
        Wed, 16 Jul 2025 01:42:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bfdsm1132749566b.120.2025.07.16.01.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:42:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: robh@kernel.org, krzk@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, 
 alim.akhtar@samsung.com, kishon@kernel.org, Sowon Na <sowon.na@samsung.com>
Cc: krzk+dt@kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
In-Reply-To: <20250702013316.2837427-4-sowon.na@samsung.com>
References: <20250702013316.2837427-1-sowon.na@samsung.com>
 <CGME20250702013332epcas2p4ea41cc442d42fd7b2c742e1d08b26182@epcas2p4.samsung.com>
 <20250702013316.2837427-4-sowon.na@samsung.com>
Subject: Re: (subset) [PATCH 3/5] dt-bindings: soc: samsung: exynos-sysreg:
 add hsi2 for ExynosAutov920
Message-Id: <175265536480.111577.14907577908476237198.b4-ty@linaro.org>
Date: Wed, 16 Jul 2025 10:42:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 02 Jul 2025 10:33:09 +0900, Sowon Na wrote:
> Add hsi2 compatible for ExynosAutov920 ufs shareability register to
> set io coherency of the ExynosAutov920 ufs.
> 
> 

Applied, thanks!

[3/5] dt-bindings: soc: samsung: exynos-sysreg: add hsi2 for ExynosAutov920
      https://git.kernel.org/krzk/linux/c/687d974a218a719f7e729bef9c498ec36f18115e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


