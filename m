Return-Path: <linux-kernel+bounces-808859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0489BB50585
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99A914E2A76
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D02301470;
	Tue,  9 Sep 2025 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LAxG5VzH"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D00D219A7D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443567; cv=none; b=g2YZyKYfGS36wAubKviTNc70e8z/t8px/5X4DornvtbfBwKgpO6CULNkmXxgij7ekPPQf8wtPMSSX6Sli2ItcziKZnk8LiuL3qpa5FWAZcb9uP+FIQzgQxs60dsq1hiaJ79yFm0k5vsqrxBMeneb/uJBMcIoN8oW4q3yp1NubC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443567; c=relaxed/simple;
	bh=96PWMU27/jrXI2PVjuNvBWIsi+qKgC6GLk3JCeyEiAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knj9KRbzSemiFbSsj2PCDp2nKSoOkTQdiXXs1nFUwuqvrMNc2YPUja93REfrpipBCK5FXqb/65PVGkF2CBZ28N1+nKqOReV/mF6fj4V5ejiA8AVOammVz2aDRJGPgzvfDNVgA75y4vOBndPWspNYfghi3UEZ4Wklnlmi1JOmxxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LAxG5VzH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b04962540a0so94700166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757443563; x=1758048363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sbgtE9csO6Cvgxlo8b8Cy8qgsxjaxLMfDvbV/GRdzeA=;
        b=LAxG5VzHV79ivAapLxx8qvj5C6R9vJ0oenYiGuG1kYc/0UkToCZ7R90/wubKRcmNY3
         JNxnghhA2/ebzIE4gscYjcILh1WlDw5OW2fRLD0Jtjha00yDbS3OLNCcTHJt1WMHmL62
         9XCFORCImaN+bhfZPXoUJqkj3ZlAerI8iI2sktfRnULDZ7I0Cw8cec3lzj5hoVco1f9v
         4d3zXsEwaDc+xFvoC0LEYrZLj5Mn7whx4Z2E8KOIpyJqc/KwZiRXfMYOb2Wmp0XJIUIA
         87RQYj06zeOwzMSzXigd3KEHpBbs2xoH8ONFBV7Rhp48CO4iehboaEGBfd1NnyDSMHQz
         NeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443563; x=1758048363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbgtE9csO6Cvgxlo8b8Cy8qgsxjaxLMfDvbV/GRdzeA=;
        b=sBhbW4bdn4LjtXHhSPRNia/UusBXqx+05r9BparLt65jKIblgxyfMmahwkbV4P77Ny
         TgRIdcmTUhj+rFnXCezciVm5VTM2rsXCWMNnctPbaLF6ZJIZ5bDRHHXmfoNWpumPyNJT
         j4VFQAj3pPOA36PmBujee58LiB5AW97CUqjF07Hors7lj7i2UiV8paesz8B60LT2wLel
         xf6VFHbd1FKpe9MtPAnI2DTafpT8r5kEnaDHt3zT93mfOOhWkFVXfN4Y1asf+8gCFpkL
         3ONYFCxhwo1domH+ckZCzFnj9R1rRKok99RsETEFyKQO/0jMSvqEAGjUyPqGETHxiQNf
         wfig==
X-Forwarded-Encrypted: i=1; AJvYcCUNsIYIeRXkbZhIigR2KbxpdqNGxRj9rLdvecgtYPSXxHBAHJdNDHHcuQJcCfJ52P+lLuDGWR5QCUzOLzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1p4lkX0C4ZtPmIc0bF5EPSvJSoybWmkl7t95mWcMX+L83TgAM
	TsZ/w7fjlvEMCL2gZ0Qqn87DNmh4A3Hw16Sj9GugfM0GhQbocVYy0Q62/tXM52/g+cc=
X-Gm-Gg: ASbGncudf9YcIyl30dLBUALtxI9MsNmsikHTt4hO9h+8crV6i6DrUj2vO9Yr/3mi7c4
	sRD06CPtcczONEihNzzeSQHGpJHIriZhYNMnYJMZH3/sChLrMbigYnHIyqVyHX1O4e+Lw8LfV/A
	d4y0SB1NU82yN/nIKp15lg6k8ihhwMt/bpEy79gPmp31M+Ob9GjskoSSqQKb0t6aDb+RInPdQlL
	e9Rd+8JkkY9VwoS7YBrOqkz2ZT23FMGbQ2dwc5QHH8HiwyjLdQRbLcdiNIF9GC0bYjNErPAWX52
	cZjG2CquVH3629z+MD46gaFGzMekSssLHgla6MnUYaOY3e9oElIdTYNXgcg4K4FziAx5jdfTUSp
	MxwqN9TWPI4WeAWdqbSBesj7cskJegy7I3w/AGmcNaz6dPSNzRlIz0NM=
X-Google-Smtp-Source: AGHT+IF9qmGIbHHgyLkF+cuxfT/tBA4kZKk5q6FFmJEiexmBUNMRyqAXcs52z+BMBR9gWhKpKR+C/Q==
X-Received: by 2002:a17:907:60cc:b0:afe:ee31:4b93 with SMTP id a640c23a62f3a-b04b10a4accmr652443266b.0.1757443562945;
        Tue, 09 Sep 2025 11:46:02 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0783046d34sm35399566b.6.2025.09.09.11.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:46:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] ARM: dts: samsung: dts for v6.18
Date: Tue,  9 Sep 2025 20:45:58 +0200
Message-ID: <20250909184559.105777-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=96PWMU27/jrXI2PVjuNvBWIsi+qKgC6GLk3JCeyEiAg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowHXnwqcshQhMcnuW6z945CPT+bxhcKDTjVPRJ
 pSWTYWfHrmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMB15wAKCRDBN2bmhouD
 1zUdD/wN+EBFSwGSxuGwG1tuhq5rNoCYRiolY1hHazJfxBx0abVi8Ilgrp0VoAWG5kZW8Jq+wTc
 QTTQoqHCyv4RKvO0jKM5gNCEWFMw1fhyO8k393+Ct+aGDCpbP1IbZZtfx3t3Zzs4D1gCXDH6T40
 jVWun62rnKoj3YKcyvic0Whd7ABzCRfNuXmDvgCLdEW9rqPUBNty/kpShQZTc3Md3Oqm5z1guUI
 OeVkU4ZKuX0IQBoZZQ8ODIVf1SiRtMyr289ULGsTBe713UsZfTBwxL4XVlVaZ7qA5PUSVJtioCV
 CL74u9paL/IB/6h8/KCxN5r0pIaKHU/NLrOEqpgg7NycD5m595Uwaw5FuB6F5fphQ8WaDLVuSC/
 7e58lPDbPHOKQ6fpTTlGGPJegDmTDrp4pnRmKCTzwnO2EjayT7tKpjvrlBg+OqnZOM0qfi0vsP8
 sHaza3Vm1GXFIQmaMkedoebzzjDUmVBG9WyxtnJEMbbuxZesUK35A00qjAvo1pBWm3+3mrHMDc9
 6XlBUm67Sk18/hrFeDi+Of/AMke7AWftXc4n+ZBRgYEcYj5gc4UdLzL3TyXT9PS7v3hiRhRf4+c
 dKLibr+/ix3V32BBRNSWoDGZ4AoUaLQPboAZxi1xy8y8FsWOW0nOTxOCcKm6JaORP4XrrTruBCv VxkqT4s/l9dTxDQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-6.18

for you to fetch changes up to d19b1773362adfe8c0d5ccc4faf6aea0249976a6:

  ARM: dts: samsung: smdk5250: add sromc node (2025-09-08 09:35:51 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v6.18

1. Drop S3C2416 SoC from bindings, because it was removed from kernel
   in 2023.

2. Add Ethernet attached via SROM controller (memory bus) on SMDK5250.
   This wasn't tested, but code should work just like it is working on
   Exynos5410-based boards.

----------------------------------------------------------------
Henrik Grimler (3):
      ARM: dts: samsung: exynos5410: use multiple tuples for sromc ranges
      ARM: dts: samsung: exynos5250: describe sromc bank memory map
      ARM: dts: samsung: smdk5250: add sromc node

Krzysztof Kozlowski (1):
      dt-bindings: arm: samsung: Drop S3C2416

 .../bindings/arm/samsung/samsung-boards.yaml       |  6 ----
 arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts  | 37 ++++++++++++++++++++++
 arch/arm/boot/dts/samsung/exynos5250.dtsi          |  9 ++++++
 arch/arm/boot/dts/samsung/exynos5410.dtsi          |  8 ++---
 4 files changed, 50 insertions(+), 10 deletions(-)

