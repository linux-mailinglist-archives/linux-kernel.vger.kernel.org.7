Return-Path: <linux-kernel+bounces-830794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAF9B9A8F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC083A4B70
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E6030F556;
	Wed, 24 Sep 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lsD1Rgpv"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB2D225401
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726923; cv=none; b=q0I4L0YIoGUcWb2zjBhW5SOFRAGlh8T9NZNUs/GS674js/YDpW0QiRE6HrNsQzROqKPxYkZRDamIfvNLjRopMXKXxJG5lHRL6n4mqpdWjxwUE2u7qfmiT4cqcAYCj/qmYI9qgbCzFQzE1VrKYnTpSjlvUxSFtDjqqMSaA8ENzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726923; c=relaxed/simple;
	bh=bhWNtW8YfXRFrgAGBa8Pe/LU7bIl4qECaoks+lgJxd0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E95pjLPpJHln6leuyibIV4w6t3gehEZE6IJlQ3auM9887FybRMYJrdSCWsK+KNRKda6RG7noOUqaRzJ4p1rP+vKFE1SCveP9zHi+ZdXNW/2yHq/fQ9eEwpRv4MAd11UCenmATp4tAerNDZvzxT93RiB2QBclU8K0z8rWa1s+kEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lsD1Rgpv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so43973575e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758726919; x=1759331719; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jbpj7od+TV+IzXBxJrvElPKTl19Mzk+byoMNx/6qPFM=;
        b=lsD1RgpvMFBFmOlTEyl6hqss7riCamUOvBcy/dPjP2+DQz9m1RYmH2ELBdy+SDItk7
         1ASs7hRVHTsTcrElD4JBVNIbg+lO4CcgmcyGnLmA76+uZfBDxDAyX+cOBqkUsJ8fSyfr
         m6xPz6wX90WZ4wQ4Lw8sBdjTDNzcnVTEKP+CW9B/mwr/AXsHTtes5j0Ag3hSAk3I+rBN
         EpaejPkl9y2ojckh+TFDLFWRJIPVWBUhacH8Ca282IAkLGgmUCOiN8XQd/XhEDmNGSwK
         4TNgdfyw6PHjITvJcrp1TaJwG8Gl6HFT6dbHaOshntonNGQXEgvj/2SOWci9EFctw1IY
         /S9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726919; x=1759331719;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbpj7od+TV+IzXBxJrvElPKTl19Mzk+byoMNx/6qPFM=;
        b=HmJoFXFrCf4fhj/sGHrGwcJMNp7mhE8VxDflXYuaYtMt4Yqj6c2Ys3TMz6BxgSDMM1
         XZ6dktG3BMgqa2gqEeCpA6261fp8sjtMZRsk1I392gOJjgDb8mAJQVyXq5Jhn5d7sE0O
         mGLqiR9lg2PZQuweSZgAE9k0eHVaVePpWyq//cZrgza7sLuKD96oxEVtTOcnoP3LOe7O
         S7y2hgNkXXb5F2WGlfBw0+yz81iHbyVEWl7h2GBNB1adoQS4SH4cSNmQ7N1MPMhwLQef
         u2DzHj4Dfib9iFoUKEuZ83F8IeLdZlh2E1qkHd/uDJUc65UKJAGpxteA4/ItNnbOVdZU
         0NoA==
X-Forwarded-Encrypted: i=1; AJvYcCWYnz8MjtIqSGxp2jgTTrqT9R+BV6fr150BYy9Nx0TxxvO735Unff9fHdHGq1Gk2AqNYfZWsbQsgXYD8zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQkmXnnYGxYK5H/t/NGel/ngeWMh9uFFRfDvguJCDVuBqIW++
	4IiVjr4eX3rRyJhefNL76F4V/apNaF0K41Pwcl72iuQTZJqLiY+EElFjGk6VPciWPh/AbzbSqV1
	cND9BqHU=
X-Gm-Gg: ASbGncvAtJerXh2+ZCcfdYYcZLtBA3nnl89ZtCA8BW1NMgPsSWdZLwULiq74Sz7hcRX
	CAxknAAmGuy9DMc7UEbzokyNAguGsjUrPWwE5plKCXL4AeVv56y3uGJV6iuxAngzUP5k7liTLT9
	22WMPbqxX7LqphIzR5yyB5couYWd4vKXL7vzk7AkXcG2vRwcsING1FHug0R5lbmz9wJcW+lf7vB
	fFdYqJqkx2NpC9LC477fRx5b7qy0reyQysIOvpoSixuwdPz207oqlF0eKT29uSJcpnK5z7rFA0e
	XyR9culcMSHFndg2mi4T6gdjw9tCIKCIYPRMpPHWc4S3LLR82Y7vgl1hho7zdTky03VQGV3iegB
	cPQLL2NSTp6GBelIBuDsBQWfyYGy3834gN384XByF9LUslawobuQtudgkzcehhAyu3jm35KauUP
	I=
X-Google-Smtp-Source: AGHT+IEIcfDqKrBiciMrBL2BnTBcgOSqblrqMr6nWvMZe5xfLOYpgYG9knlnJMKE7RPGTu6ZiHxPvw==
X-Received: by 2002:a05:600c:a43:b0:46d:d949:daba with SMTP id 5b1f17b1804b1-46e329a7fe3mr2802315e9.4.1758726919462;
        Wed, 24 Sep 2025 08:15:19 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm36541855e9.1.2025.09.24.08.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:15:18 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v4 0/3] arm64: dts: exynos: gs101: add cpufreq support
Date: Wed, 24 Sep 2025 15:14:40 +0000
Message-Id: <20250924-acpm-dvfs-dt-v4-0-3106d49e03f5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOAK1GgC/3XMTQ7CIBhF0a0YxmL4teDIfRgHBb62JFoaaIim6
 d6lnag1Dt9Lzp1QgughodNuQhGyTz70ZYj9Dtmu7lvA3pWNGGGSKKpxbYc7drlJ2I2YHI2ttDD
 OWocKGSI0/rHmLteyO5/GEJ9rPdPl/RPKFBMsgCujpSDKivPN93UMhxBbtJQy+9Cs2mhWNFDHl
 CaOMvOr+VtrwjeaF90wQaQGaZ2WX3qe5xd3S12JJQEAAA==
X-Change-ID: 20250819-acpm-dvfs-dt-06bc794bdccd
To: Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758726918; l=1425;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=bhWNtW8YfXRFrgAGBa8Pe/LU7bIl4qECaoks+lgJxd0=;
 b=nc/cwrihP0XJJ/99OHcjZsa0WdK1sLevklpPI/Gmh2co9jIBvtLyBkmkIkXMC9i0kAKCg/GHU
 eBlAnjokIYaCeA9SWUwuE0fuigcuV8LgtunmknD2H4uHaDlwYnqSkpe
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Define the CPU clocks and OPPs.

Patch #2 has a dependency on the ACPM clock bindings sent at:
https://lore.kernel.org/linux-samsung-soc/20250924-acpm-clk-v5-1-4cca1fadd00d@linaro.org/T/#u

Thanks,
ta

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Changes in v4:
- update clock-latency-ns from 5ms to 500us (recent downstream change)
- collect Peter's R-b and T-b tags
- Link to v3: https://lore.kernel.org/r/20250903-acpm-dvfs-dt-v3-0-f24059e5cd95@linaro.org

Changes in v3:
- the ACPM clock bindings were moved to their own file, update the
  references accordingly.
- Link to v2: https://lore.kernel.org/r/20250827-acpm-dvfs-dt-v2-0-e1d2890d12b4@linaro.org

Changes in v2:
- acpm node becomes a clock provider.
- reword commit message, extend cover letter with info about dependency
  on a bindings patch.
- Link to v1: https://lore.kernel.org/r/20250819-acpm-dvfs-dt-v1-0-4e38b95408c4@linaro.org

---
Tudor Ambarus (3):
      arm64: dts: exynos: gs101: add #clock-cells to the ACPM protocol node
      arm64: dts: exynos: gs101: add CPU clocks
      arm64: dts: exynos: gs101: add OPPs

 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 285 +++++++++++++++++++++++++++
 1 file changed, 285 insertions(+)
---
base-commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
change-id: 20250819-acpm-dvfs-dt-06bc794bdccd

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


