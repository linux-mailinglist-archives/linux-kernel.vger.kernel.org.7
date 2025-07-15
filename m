Return-Path: <linux-kernel+bounces-731631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8D1B05769
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 12:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CBA84E2B52
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3076F26E6F8;
	Tue, 15 Jul 2025 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ODKNC9Sy"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197D5BA42
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573864; cv=none; b=EYksZRRYHp5PsBxKg7P4U204JuvU9yMvTzYhoSOT/N7m1bgcgEsohs7lAxRLjkMXvZXcK/FDsT7viVRod+sspD0kOoMpJz4XxlJb53eBRlzxx3vQGjVgivSOF6+fxbXlyRRudiJ2UdAs6BVb4xzTipqKOF6rEtR0MlFEis5YRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573864; c=relaxed/simple;
	bh=SB5SCWzU4SrF0bpQDxGLNYlzODumqwqpchHlKL/3Y8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rHKWG0HUkw6o0Pai4Iq/t8ktEJ8HeossDzzvF2m/i3E9HLAuuVZVhIs20iued7bwlCWaxuDHwPs4mXhvjCqehjgPTI77Bg6IWWFEjgK1rm2HYlAm1lDGEoAWZU4nOVHxuOCuJvZy+Bh5px++txvCkCCAYi71qpY/xu6I3uixzgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ODKNC9Sy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a4ebbfb18fso263374f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752573860; x=1753178660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h3GwjKh4XQxSRfwQPxwqnuf4H24N1Uv5D1O1oOMjSyM=;
        b=ODKNC9Syvry0oOq7pYFH3Gro88yybGuhg2Jie6d38ZL/EmzVteEBvqJRoSkUqgonLq
         5GJdBXGpsF3xnyJez3cnDMwfE1qLMww0yn1bRdlxwzaYiZvv3HSWZCIbIIJd6Fr1W0n3
         w2JiCB5jNvLKzoFzE+sd3RTlCakGDY+5XY5DtC1t1rkTDdeNuPojOXtcZ2fTyCSqElV5
         GlRR361P7QQKvZRrW/c7zaa4ZeXAw+Uy1RnU4slpSNv8ySzlK7Jjxy/2cTM2su4WbfjI
         FGvg+P2J5dmZ9g3TPDqGEgeUW0Tc1u3dkmtvEW7a/6coX3bbIX9Ls9cl+weqg5Pi9sbc
         lvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573860; x=1753178660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3GwjKh4XQxSRfwQPxwqnuf4H24N1Uv5D1O1oOMjSyM=;
        b=SR7s8wTKPV8QWSMUbel0geklubNQCp5nDrEwCs2TBqiQxVVJCe/vVx3dbAFrHdK+TU
         94c046cCwJQHTKpVlupKNBsPozamqw0i5l2HiSlh+aHnSOdymkaS3zwMuiszYofx/NZq
         rLxQMBHV0llQtGLDIWuhbXl7D/eDTSJLuDgJqhJW2N3TOJ+04W3s/DYeNygXh7M1y8WB
         /sD8T07NDnABk/f9DY5WGzo4WLsujxEc+AS9yrY9PfcxCl5lUy7KuS/5YGNmFS8jr4r1
         atSmc68/wp8j5czrL+l3cR3gE712SxcytR8uSMavPpac1xlKqfn/vR13W4i6xVtRWHla
         79PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXi8pHER30EC0iLpUmf/sY8TaBzga9oMRlRDA/vg8sRnddPRh0AgmHBBggjqRNZFLkbcvnra4Zn7FovBXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwq5vEjfWp5xSuHHaATy+EM5rSjycE3iLuBNnFGMAtJwEnTNnJ
	caZY7xARhbJi4Mt5wWxeCEqrI64AxgEuhx1odp48lthBxUO3JkedXDIoYXPwyKWi1Q4=
X-Gm-Gg: ASbGnctWVzfxZzRdevbRcZF6sTptebhjIn9xfOfAZQg4Y4/f9ACSMhJG37RwPJ2P9wA
	DDU1i/YFHfdo1T7FiyFAPBbfXrrhGHVX1lgyVoHzR0MT6SI+ArNM0kFTzkZonGsRyEfHC1xRa1T
	+h+Fl20pziVhNHvenGWHiFA56mZiazD1Te497z/ExloXFEVvCjv6HJg3QbJ+tt59sMLjmAyEr21
	SL9YTfm7Ldh4SPraveNzjljaQW+sRoVyPMkvNNEXQW89ADOQ//EEaYN+LC7nrqCePhBVHFYoKfT
	GAHgbxRD72AK2duZrVwWJ8LpSTx3gKm+fCNqlsUobX9ooszPe+Ds7666vBDNSz5KU8Jl2Cnkfoc
	NKouEmkuc0qgzSe0hfLy0sXfHTCZfOtPalC5E+jGoTkS6xw==
X-Google-Smtp-Source: AGHT+IHMrjY0VOQQ9jAAOgpScWai9DyRMoY9ri1wzCPDLxklTJKGMPp+lNZbCBa7EyLMTB8MbldPmg==
X-Received: by 2002:a05:6000:22c4:b0:3a5:7991:fee with SMTP id ffacd0b85a97d-3b60b3affadmr360862f8f.14.1752573860331;
        Tue, 15 Jul 2025 03:04:20 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d571sm14964623f8f.57.2025.07.15.03.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 03:04:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Sylwester Nawrocki <snawrocki@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] pinctrl: samsung: drivers for v6.17
Date: Tue, 15 Jul 2025 12:04:15 +0200
Message-ID: <20250715100415.60487-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=SB5SCWzU4SrF0bpQDxGLNYlzODumqwqpchHlKL/3Y8I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBodiefBvfgeeH/sRvJWFZDCiNYk4oeYz1pS3qxy
 jayWCXCSCKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHYnnwAKCRDBN2bmhouD
 10t9D/wLdtc2naCJk+QxDqceFLLmw9n17tnaDNQLktCQYeD1Oj7BiPOYSnvKeu9IG72Ru6pTQom
 t0ivRHMXRkjNg71dTTq6hYzeNMwJw7aa9FLd5BmYivYmQ8v3LyLau7tVDwQp+mne+uKAwpI+DdA
 JaiOqgxoenmPLxUpOlHwwmTqqfeMoO+5ra9LsspbkIeXQrSZ/ZBnCz/OlCPFEVFmPUJ57vdJecC
 Ik7N5ll7va/s7Wze8FVj5nBAYVd3O4TrJyf1betn5N82xkdpYGpRTvzbjoBQNlco/7q/fJW73cb
 8GCl5Y9NWoG4yUJjYwytEc7waT6sil08JcnWdOVSVdq7Ekcfmy2Ior8ooXXMjuLxvyKglJh1CWZ
 YU+VVpYaQmqpgn1Z6Njq6M2t6Yc+u4no6sRCd1s2gCDTVBPmtacsN/uIwMBpbYYbrH7Pi/0OBQw
 NJ5ryZM8Jw3oC3iIZDqfCD0c/D3NHkIZgXstzEC6CohnbvnARNNLWKKqMnFwwjuhwrNjlQjcbW8
 g51fowHAe4Bw+t3NtQn5u3+3iYHJc4oTHet5S4T6K617H8KMtk5gyEDc7v8aJ4ShnEPwBbp77EY
 n5IN7ezkxsmMrWi/AwRiA+TxofirQlpx01/rk9cS/qdOc+dFIjZW86wT/GZkAr7RImesc3ptZ/p i2w0gdEkgVu03hA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-6.17

for you to fetch changes up to 683d532dfc9657ab8aae25204f378352ed144646:

  pinctrl: samsung: Fix gs101 irq chip (2025-07-05 09:35:22 +0200)

----------------------------------------------------------------
Samsung pinctrl drivers changes for v6.17

Add support for programming wake up for Google GS101 SoC pin
controllers, so the SoC can be properly woken up from low power states.

----------------------------------------------------------------
Peter Griffin (3):
      pinctrl: samsung: rename exynosautov920_retention_data to no_retention_data
      pinctrl: samsung: add support for gs101 wakeup mask programming
      pinctrl: samsung: Fix gs101 irq chip

 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c |   6 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c       | 103 +++++++++++++++++++++----
 drivers/pinctrl/samsung/pinctrl-samsung.h      |   4 +
 include/linux/soc/samsung/exynos-regs-pmu.h    |   1 +
 4 files changed, 98 insertions(+), 16 deletions(-)

