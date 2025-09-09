Return-Path: <linux-kernel+bounces-808852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD06B5056A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971BF3B02A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D763F2FFDD2;
	Tue,  9 Sep 2025 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKR8dC1Z"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C1E214A93
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442914; cv=none; b=kJvpShtOAojyC3NyhDjm9tFF21Uv9g30hDXJaYgpwIWQ6vPxNkb6EICEZIG0FkhctsJ0QiPDlVTosidVbpYO+VEbZzgDzNxfIlIgUhuR+Q+GXvPpyp3wICzLET0mjpLjZkhK1DeVAHJiSaDlt1fNi4m5thzeWdNu/NZSRUewA9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442914; c=relaxed/simple;
	bh=SP/f/OHmyENYFgXEHOPc8/Rf7ucWnwCMfoZXoYcF+Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtWDL9qsAkuq6ps5RC9Jqhun+yZDIhQACIode3ziPDc/hnvpo4evC01nVw1WtamnwmJSx9CWGQICspXMc8vRuZou3RLfBAAUbxHJMKWa8qU2Ll2KqGCT+Uz1HWrsWVkRphQsPaA4OHn6C9mR7G44ltJFC5Q9aMl3gtntUFVEf24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fKR8dC1Z; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-628f2102581so445762a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757442910; x=1758047710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SwcRmJEpAdsIjXtM8gO5g337Luht7EqqgA9HVxaMN/w=;
        b=fKR8dC1ZxKD5eQ7nCZs3VKAlInEJo8EKtOYvE3rDFMsIzkw0wjavw5+MX9zl0qT23H
         m7/vdMni+VTvOnjDZJY/DHzbA7mbI9VLUryA8ogVsaeWbxsXKdQX7MPrVEBiZXK8+1I4
         PnjvEmroIY5ULlBIvH9OyCDwDcHIlBigPivfFDoR7GXF50HCb3ZI+WRJozasyQD5NNXl
         L+y2/kZUcNkOcjvIuWKqathysmv8ybpkak3eZtoZ5AFSHBGZa099BD66fDp0AW7pVjak
         OxiHkussRUTU6cVXJ+R84bxjTxZbhY0zCor70/yWY0IZ8guEO43HHesICiYASt5+5jGS
         yF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757442910; x=1758047710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwcRmJEpAdsIjXtM8gO5g337Luht7EqqgA9HVxaMN/w=;
        b=RlRuuyQbIlNcgYBr/ILzTkz2seAXvDrAbtfWQsG82lmn1dFXZRq0+Zgs+kWWj62iSt
         r7Ph5aOLy/vRFVVXJlAyt4vcWMNLGBwRq5gHsp7YvAoWs7TnEmIytohi1lIq0TC+TsGS
         uN8O9YA/5ChXkYsuZbwZykqTh+wnDe6IInMwPTHuzozFat2y8Tvonz0c/lHF8wJN3G1S
         9nsogRgMRry8Mwc7sEs9Qd5yCkFjvglXglWdFzpk8OmCaXOzDmu9+SSAoRPMFxa2hS+Y
         ZDuJz6RCQtkvbQ2i56pCo2fn5ayn/EDI0FkEWD0d+ii6lsWNJuTUZcKtNlz2ZeN1zA2N
         FUyg==
X-Forwarded-Encrypted: i=1; AJvYcCU997XapI8NKxyGjZKrdvLqIL9e0MSIU+A0r/DovyTYuA8sNE7/P2vxbc54NpXJk2r6l16b9wHxAvii9so=@vger.kernel.org
X-Gm-Message-State: AOJu0YwborMwiIepG3b7gYDYSn6Km+08kVyLvuKsiXbca8+SI8hgpkjj
	v2Y7tGZo62zOEyH+n/jPAxf1kSKrP30NtJm8SzjOrwl949J5F92jTF0LfMaVrVQVG64=
X-Gm-Gg: ASbGnctFc9A69ewA1+F9CLsP1RytTHxym8Ms6snvxG5Nx3ZA7zggu94qF/m6Y/L/twN
	H/X2WMiydcXDbM93HZ++e06lf01PvsawIISIiRZp/mx/B2dtUZUadLL3/qvF9d2cGzryNVNvPaC
	284B9TlCE1rph4/aE7ZFW9DcigXcSaF3hnLxRxtdqSH97qv0AbYm2+SrSGrXhEO0fV13OvQceGE
	dsXlPXXqqUsXsph0+gxGp8qwI3Y9NmK92ZbL0HDoddSoViiU6k31LG7gNrMmwJInzxIpYOA7Y6R
	TWNeA82ZnTu9xbbfZZeJcZgWcCm12l9HnktQXoIyUR90yKGpl7Ca5nzvHCqkKTUzmHfFiU+d2uc
	tISjGW8jK/TKxdXi3NsIqjWEA0X0QU0uzzA==
X-Google-Smtp-Source: AGHT+IEtJecmV/jjQmnrF4shDa6h9ku/souQrmOu0T5Vo6piPtCO7DvbXGp5/2Tji0sGHNxwh00KNw==
X-Received: by 2002:a05:6402:1e92:b0:627:6281:e432 with SMTP id 4fb4d7f45d1cf-6276281e7c1mr4700848a12.6.1757442910428;
        Tue, 09 Sep 2025 11:35:10 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c0123f08esm1707282a12.33.2025.09.09.11.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:35:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-clk@vger.kernel.org,
	Sylwester Nawrocki <snawrocki@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] clk: samsung: drivers for v6.18
Date: Tue,  9 Sep 2025 20:35:04 +0200
Message-ID: <20250909183504.104261-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3592; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=SP/f/OHmyENYFgXEHOPc8/Rf7ucWnwCMfoZXoYcF+Ug=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowHNYyTMtXdgVINSVVMUfHhVmyZrZSKfFw9c6L
 Pz+Jl63/jeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMBzWAAKCRDBN2bmhouD
 18jGD/9/DW7x7Gnncm+III6OLPIJRggeJ3ahi+ZOIbPAcqzETQjteI+PC1+r+WVnJR4LgRTjnfy
 nh99rONItP2xQpqCUvO78IyTJlg55fci64+pL/81Zy0VuFeCNxKhzfudG3mVs8C3fmGO1v2V5SH
 mdpHObusWdByV49x327xv2Gdt/WR//yjaPLKQH4ALm/XaX8CqB7fEVqULhcBXoJw1gwffBkYPVE
 2O2jXhQ6WnmvQb04PLoizDRtfAJ5FkemhjCuuvkDRxBlycZR5P+8dEH3v+R8CKUI6XcFV/KUW3M
 loomE0efVKlueZz/d+cG3v5aGtLfpCPnCTXjWbEW2ey8aqtJSZO27Jd34CkP4+Q6BnIUv4vqlGU
 NgJFFQc7IcgMicy2YaqUM1mAj5U99y13U+Ec7w52T9R4sts0SYZoQjuNd2/jCkIM/kLZLAs7PiN
 IbpQXdtUQe6OqfSS8ixhQ/UM3Gu6P1tmRukxzTt5+7thjhbYz5N5Yt67ixKFq+t+MpNhDMIRdQJ
 68ZKfAxI7Pw1F0S2Vj/qj0oNKMO/qIhlaCjKseMfTmysXUjKYKsiZu2Xyd+WoMnAY5z0ziCEsVK
 KtI81ktQne6TXowGhZTHLfCmfvBIKdBxRcArVAz245DgcLmUnOBj9tJiX38qUjO2ib9M+UJQbgK ki7dl0vi6BLGViQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-6.18

for you to fetch changes up to b3b314ef13e46dce1cdd97a856bd0250dac8feb9:

  clk: samsung: exynos990: Add PERIC0 and PERIC1 clock support (2025-09-07 11:12:45 +0200)

----------------------------------------------------------------
Samsung SoC clock drivers changes for 6.18

1. Tesla FSD: Expose CSI clocks to consumers (DTS).

2. Exynos990:
   - Few fixes for fixed factor clocks, register widths and proper PLL
     parents.
   - Add four more clocks for the DPU and HSI0 clock for USB.
   - Add PERIC0 and PERIC1 clock controllers (CMU), responsible for
     providing clocks to serial engines.

3. Add seven clock controllers for the new Axis ARTPEC-8 SoC.  The SoC
   shares all main blocks, including the clock controllers, with Samsung
   SoC, so same drivers and bindings are used.

4. Cleanups: switch to determine_rate().

----------------------------------------------------------------
Brian Masney (2):
      clk: samsung: cpu: convert from round_rate() to determine_rate()
      clk: samsung: pll: convert from round_rate() to determine_rate()

Denzeel Oliva (10):
      clk: samsung: exynos990: Use PLL_CON0 for PLL parent muxes
      clk: samsung: exynos990: Fix CMU_TOP mux/div bit widths
      clk: samsung: exynos990: Replace bogus divs with fixed-factor clocks
      dt-bindings: clock: exynos990: Extend clocks IDs
      clk: samsung: exynos990: Add DPU_BUS and CMUREF mux/div and update CLKS_NR_TOP
      dt-bindings: clock: exynos990: Add LHS_ACEL clock ID for HSI0 block
      clk: samsung: exynos990: Add LHS_ACEL gate clock for HSI0 and update CLK_NR_TOP
      clk: samsung: exynos990: Add missing USB clock registers to HSI0
      dt-bindings: clock: exynos990: Add PERIC0 and PERIC1 clock units
      clk: samsung: exynos990: Add PERIC0 and PERIC1 clock support

Hakyeong Kim (3):
      dt-bindings: clock: Add ARTPEC-8 clock controller
      clk: samsung: Add clock PLL support for ARTPEC-8 SoC
      clk: samsung: artpec-8: Add initial clock support for ARTPEC-8 SoC

Inbaraj E (2):
      dt-bindings: clock: Add CAM_CSI clock macro for FSD
      clk: samsung: fsd: Add clk id for PCLK and PLL in CAM_CSI block

Krzysztof Kozlowski (1):
      Merge branch 'for-v6.18/dt-bindings-clk' into next/clk

 .../bindings/clock/axis,artpec8-clock.yaml         |  213 ++++
 .../bindings/clock/samsung,exynos990-clock.yaml    |   24 +
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-artpec8.c                  | 1044 ++++++++++++++++
 drivers/clk/samsung/clk-cpu.c                      |   12 +-
 drivers/clk/samsung/clk-exynos990.c                | 1240 +++++++++++++++++++-
 drivers/clk/samsung/clk-fsd.c                      |   28 +-
 drivers/clk/samsung/clk-pll.c                      |  161 ++-
 drivers/clk/samsung/clk-pll.h                      |    2 +
 include/dt-bindings/clock/axis,artpec8-clk.h       |  169 +++
 include/dt-bindings/clock/fsd-clk.h                |   13 +
 include/dt-bindings/clock/samsung,exynos990.h      |  181 +++
 12 files changed, 3032 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/axis,artpec8-clock.yaml
 create mode 100644 drivers/clk/samsung/clk-artpec8.c
 create mode 100644 include/dt-bindings/clock/axis,artpec8-clk.h

