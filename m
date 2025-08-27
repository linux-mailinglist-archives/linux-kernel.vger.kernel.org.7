Return-Path: <linux-kernel+bounces-788311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA3B382B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5095D7B8870
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434E235082B;
	Wed, 27 Aug 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6hBbi7r"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6093338F40
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298539; cv=none; b=utBVh9MEXXE/tSihnftbtYeyL/q6tKUe4/VNpLqqkZAaJdCj6kKYeRgn4ZTjgB0ssJ9ezRVauinZfx+fUsWjJmZtY06g5HHw5FY1pvSlt08+6lO+umRziCsasmfzFAeGJdVLQgwU8kOoutB9YnLEamAtrk96bw2SgxespVmr/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298539; c=relaxed/simple;
	bh=IapQAGw++5352d3xzeDl5P6o6TxheEyCzjaqOyMO4SQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A+h+qCTIzpgN+Sp8kJFVwsksKdv2zKfq8TTBV6qvhCLIJMSl0YIO5Kj8aHEH6TLkIANzwGWDbuq+Rnc0ApcNKoawuxCoLH4yOLa5j1ppp6wIgmdAcyx7PupT3Y4gfnJ403qIVNXBMuoCpqUN9olfLn8p6waOjIx3ObZ8gblnWSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r6hBbi7r; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so36457205e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756298536; x=1756903336; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qCX9OHIqw+xdYsktQQqiE2IMYgIse2ihYLYopEmEHJc=;
        b=r6hBbi7r5F47ja19Uhl3YPNqRuAWl3wMKjOnsPAnwylLMs1AZSJxB5I9YzuXnIfpW1
         IdHOzJ3XIybYux5xcCgH4wgvsBS4LEIrFOHBQG+sBHKPyEOU0Dz5vF7riFMevtjmK0hW
         9KYY9PrRVi1j46XVCTMajZ61ig8SxLjGFvAnguCm2wyDmaxV5oL0s5fTYZfbbsu5S0uu
         syIGUznrAEPrQ2l/3oAESEb22QD2GlCsDD/ZpN4loNCuR/wuq9+EpY2Akh/ZL6hFBb2G
         0JRtVGU/drCpOCMixJXhzEs29/pJRAVtIDARl2I6uAqiQkGM/8UVotojgeLN21MWFNPO
         gWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756298536; x=1756903336;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCX9OHIqw+xdYsktQQqiE2IMYgIse2ihYLYopEmEHJc=;
        b=ntecNJIWMu9NSj3wY08uZr27+dm+GcdMOqwXQ+nscjQOjaHgWb0Z6bvkj6n+qe+lxp
         pM/fYOP7yYPMPrFkQ2fGpTrPQUu8Dwf4Zz0eWPdB8+A2WmlvYcUS5Rxzb0xleWjXVpl5
         TKkmerUOKiE9UuSiQgIqfkArY3aq+paJ99L+OFhO5xJ7umtoLD7XZ1C1ICD7ITkFoRon
         2WiC1SGf5n0U+H3VW5iI8B5Pg01LGZM9QJJjT8DfdyerI6HzqnuSPm7xSZlJmBi42XUC
         JvrhUE0AT5e7X777sDiFXQejBlP7n8HiAha9SNk/SASBktwcgb4HFOb5b6fV6e09BMdk
         CPmw==
X-Gm-Message-State: AOJu0Yzl1zvEAWe5jwvKpgPAMU/r41Dzytr49wxXQ+lE8ejJAaODgoV0
	SZoix3m2CcIcORmfMECaZ+Eui/uMFUu1qS6Vz5ubrKHeULUj7c3gZvz/YAcloB0cX2U=
X-Gm-Gg: ASbGnctuYfRQZyhvziSwkvEbvMHyTMo4Mv3jq41Z6lacwIG/SoutGKxH0WvBrvVicm8
	J60gdb71wii56ubQBNNgR28n4m2C8LQaHEm0BlBpDNshD+7eo4S1VIaK3BQJaS7elKet5bsRcxC
	EuZ1xiaUjz/sRkiGi+ehuUMqtwRd3EOvxZGpeZen4QDdT7E2c0Aas4GxbfsvoclB7VoiCvs76tI
	yEtgEFFYECgn/DysftuJFiTWF+ksVl6pSihE0EK/lm60LYExRtlLaDNxFpMdewJ8pwwZ2vbSoyw
	5+x35qm128ltXpsfscWjnZBy9rRNksmJMGPKizyQy0YmkMkBSZFs7Ukb3N7JuDpl0McWq7g3GyX
	RduR3TyXyOR4RUXKMjaeHksnGafUPz1rSl8dgQbWSv3Md//H4BcwwHpf+d/Xpx/+3mt+fcgihsq
	xPEQ==
X-Google-Smtp-Source: AGHT+IHt37j6LI8uNP0iBAJah2pqyimZMIMU1zgKSqocNIoMlPlz3HIKdSdVZSOFodLiybkW1k8Tbw==
X-Received: by 2002:a5d:5885:0:b0:3ca:43ce:8a72 with SMTP id ffacd0b85a97d-3ca43ce8f6amr6069633f8f.1.1756298535966;
        Wed, 27 Aug 2025 05:42:15 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cbab3ead0dsm6439420f8f.29.2025.08.27.05.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:42:15 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 0/5] exynos-acpm: add DVFS protocol and clock driver
Date: Wed, 27 Aug 2025 12:42:10 +0000
Message-Id: <20250827-acpm-clk-v2-0-de5c86b49b64@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACL9rmgC/23MQQ7CIBCF4as0sxYDWAt15T1MFxTGdmKFBgzRN
 Nxd7Nrl//LybZAwEia4NBtEzJQo+Bry0ICdjZ+QkasNkssz16Jnxq5PZpcHk9pJozTyE1dQ72v
 EO7136jbUnim9Qvzscha/9Q+SBeOsG0fXq1a1nRLXhbyJ4RjiBEMp5Qs65JL7oQAAAA==
X-Change-ID: 20250819-acpm-clk-28d2a78e0307
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756298535; l=2851;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=IapQAGw++5352d3xzeDl5P6o6TxheEyCzjaqOyMO4SQ=;
 b=O9xpUqQDN1LzCYV4GZ9rTx2Jek/bWnSZPIckwh8LaFDZ+hx8nuCwS2i9XjAkNMvh7TBz2VJGu
 4heJcreMWsKDOjMvCIPXZyNGqcFmMnKD8stlhDXXNdELEPn0qjS+XyD
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The Alive CLock and Power Manager (ACPM) firmware exposes clocks that
are variable and index based. These clocks don't provide an entire range
of values between the limits but only discrete points within the range.
The firmware also manages the voltage scaling appropriately with the
clock scaling. Make the ACPM node a clock provider.

Add support for the ACPM DVFS protocol. It translates clock frequency
requests to messages that can be interpreted by the ACPM firmware.
Add an ACPM clock driver to model the clocks exposed by the ACPM firmware.

All patches can go through the samsung tree.

Thanks,
ta

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Changes in v2:
- dt-bindings: clocks are not longer a child of ACPM protocol. Instead
  make Alive Clock and Power Manager (ACPM) node a clock provider.
  Update commit message.
- firmware: exynos-acpm: register by hand the ACPM clocks dev (new
  patch)
- firmware: exynos-acpm: use defines intead of enum
- acpm-clk:
  - switch to determine_rate
  - drop __init, __refdata, __initconst, this is a module, we need those
    methods and data, after boot as well.
  - fix the assumption that the clocks are defined by ID in ascending order.
    There's still an assumption that the clk_id < nr_clks, but this is
    now covered by a sanity check in the clock driver.
- arm64: defconfig: enable Exynos ACPM clocks (add patch together with
  this patch set) 
- Link to v1: https://lore.kernel.org/r/20250819-acpm-clk-v1-0-6bbd97474671@linaro.org

---
Tudor Ambarus (5):
      dt-bindings: firmware: google,gs101-acpm-ipc: add #clock-cells
      firmware: exynos-acpm: add DVFS protocol
      clk: samsung: add Exynos ACPM clock driver
      firmware: exynos-acpm: register ACPM clocks dev
      arm64: defconfig: enable Exynos ACPM clocks

 .../bindings/firmware/google,gs101-acpm-ipc.yaml   |  11 ++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/clk/samsung/Kconfig                        |  10 ++
 drivers/clk/samsung/Makefile                       |   1 +
 drivers/clk/samsung/clk-acpm.c                     | 148 +++++++++++++++++++++
 drivers/firmware/samsung/Makefile                  |   4 +-
 drivers/firmware/samsung/exynos-acpm-dvfs.c        |  83 ++++++++++++
 drivers/firmware/samsung/exynos-acpm-dvfs.h        |  21 +++
 drivers/firmware/samsung/exynos-acpm.c             |  69 +++++++++-
 include/dt-bindings/clock/google,gs101.h           |  15 +++
 .../linux/firmware/samsung/exynos-acpm-protocol.h  |  10 ++
 include/linux/platform_data/clk-acpm.h             |  24 ++++
 12 files changed, 395 insertions(+), 2 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250819-acpm-clk-28d2a78e0307

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


