Return-Path: <linux-kernel+bounces-893109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0EEC4688E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 378DC4EBA66
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8751E31077A;
	Mon, 10 Nov 2025 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vv5lL8lW"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04AA3074A0
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776840; cv=none; b=BlyomUYsnHkmBcJF8HGkmjdngEewdrvL/PFiXQSXz/TX5FEJpIHFWLG0EgQ+3VpiVgX6wsmEsYbRpFlH31tf/A4eeJMEzSFCTbPa3iQm9p0WZwOT6Al6y6NFjY3PvNnhdlp61p+JYYDgkNUfAwrPF1uMl8E6A2ilyJsAh1W9xvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776840; c=relaxed/simple;
	bh=prTJ8Oc+m1RLqjNAKESRe03pqfxl99t8fUIb/LcjQWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S7tlaZEQeiv/i4NLS42bf/J/8SkZ/P/iZEpWmTwZf6RZ13d0eA9riwSWe8MZ5ABILiDE5cWupnZH1z46+Ce6tQN656+1bQ5/0fGh0vw3Yc4zdLlWrUO0RCLg2YDpb03+I8PivCMvh7UddsKYdyaplLNPtniC877oOqdEN6abBiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vv5lL8lW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b2a64d425so296179f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762776837; x=1763381637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+J9DK7umCkB0lH75JtGcDU05puxofKEqqEJe5YRpEM=;
        b=Vv5lL8lWdI9S/vjHelzxhr6h/3QI8VylGoRrQ7MC8SL6GsRzEJOAn/SCOLcYozBNmH
         g7b79puMi27Pz+erb9KJy0VzbR5t5/+tlBG/fAZPWt2yNI2/Gk0DP50xMh+ewcpWf41P
         JNzwrV2AclViKKqhdX7vAaNHda9KyfZw8WFiXWowlctyMTnLmFweEepI/aZLgv2xCSIY
         39E4fe7jt7EU5TiplbjFff7VegfXUJkPVb3LvkcYq+sl5fGeEV/uq7MbdGumlhvqE16c
         RwvHCUcJ/HBWtIPIqJ+XhQQ9yO5Ice945mqgbqxPB9DKMMz8UIfdyR2/VOeYaY4FCK9S
         QfMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762776837; x=1763381637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o+J9DK7umCkB0lH75JtGcDU05puxofKEqqEJe5YRpEM=;
        b=vCnejG+UnZGN3gsmt+YhKm9Ixu1iDL32SkaNzx3szJZF+9X4Cyy72/t/VCRsaxdX3+
         z1ddP5FR6/W6OTTjbQa0RYssrd6moluaq1CqKTEUXRj10YXfpM5hCvbCSqHvklVrN9e3
         VIElumAVWGL7xqLpJ1gWdWb/tJz6CM8q9ACm9EzVfu/r7e2dgBsU61aa9NfbM4CwmZLM
         JMLtgu98vDruaJk8p7FsluAicoPgAEVqcAzjl7x0lwSDQVHmNhdS4UmJbxVMnglQtnio
         INwthRMMOr9HjZY56S+lkNGOxhxBAz+r/rToF7Syf34w5//5BcxBkE/RX07sjgrp1arN
         Z+BA==
X-Forwarded-Encrypted: i=1; AJvYcCWnVZTLIYpUITLrukHi0s7qI/e2qY/F5dW/RiCNkb4WeCzkVBQFQvr2HodwoaLc18dKN+sOkV/Xfm9Lw1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeoYk4GF3SGCNpGOM3n5qgg63Ok87/f1cSY61GwyCIfkdFvx52
	B8Buw+EuXD+H7Z5JbR2jDNe+sDPxxSSCcieV9uVwG8R1yxb4e3c1STy/L2PkXi2S7mg=
X-Gm-Gg: ASbGnctWSV1exCWybaD3/u1fhFp7TWDXVI5g/ReKUpNdQZshQq4+GK5uH2w/7eOG2k4
	3ZetoSrUVlOA6aKo2rUcY4f9cLNdMKqcqG9NoifCVv34jYI+64ycBY1XGBS9UorNPqQ8UWqd5Na
	2iOZXJH3NAD0Egs/H5ferSr+h1OXaJKYM0Scsz7wxjjDM4zozQOq9h98ZwcYkqQuRkBmbhDgMR8
	LomS+Y6gOKZ8yq+DIaA8ciR1j7I/uaiR9N0P5eMno1LhSRbcLh3BIXTeK84IQwTJpm1LlYMf7f0
	II5eKq8voYvkdqgieOI7L/YNOm54uJo/uAs6tRa+dcduo3b4XO7prnEu2KhRBhDCc0MdPOhywsD
	c6Kd4CMWjBvbNyEYGvAVwc40s1fiQfCHXNHFqixB2clpExQ1CzAtL5SGDsmOb40ClPG3wld02M3
	lrhzWTE07mWpI=
X-Google-Smtp-Source: AGHT+IHXmMAMgHGLYPHdNXeuo+MZBbEjpXPzE5xhKoqUU5naZQ2bnEDU9zb8O6kz0C5VmdKT1m/FAQ==
X-Received: by 2002:a5d:584b:0:b0:429:b4ce:c333 with SMTP id ffacd0b85a97d-42b2dc20b7amr3337629f8f.3.1762776836988;
        Mon, 10 Nov 2025 04:13:56 -0800 (PST)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac6794f6esm24922667f8f.41.2025.11.10.04.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:13:56 -0800 (PST)
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
Subject: [GIT PULL 2/4] samsung: drivers for v6.19
Date: Mon, 10 Nov 2025 13:13:40 +0100
Message-ID: <20251110121344.120785-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251110121344.120785-5-krzysztof.kozlowski@linaro.org>
References: <20251110121344.120785-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3147; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=prTJ8Oc+m1RLqjNAKESRe03pqfxl99t8fUIb/LcjQWk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpEdb54uvgcIsvJkyeUuAsVPO83CjVSmDVgud5l
 2LOf1gbAw+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaRHW+QAKCRDBN2bmhouD
 1xCwD/9fQop5LN4wvcGWsg5PtGyKeubevwoDlObwaQN/15SYy87W6CxtCNV9dU/3SM3XPUCmLxy
 uawL7DFzPR6UBCAz7+k115KcJsrWJ58J8ZN/sq6svzOwBU2eYXkGWaO4eAGEyfYWgX/of3DDa0n
 Z0M0AifAC5lkYD2gnppGvNQUa+xIUelZD3jB3ObaZ265L76q8gtLdwImZ1ab5ceJ96tn+eypUgi
 qDiOaWZUFR2ymvuY69ivf21U5/MkM5X3862NhjhQH98JHywbcdB6XT98a+OZRXo0z88cD54OPKU
 uqHXlZEEF4OzDd6/qys4ESBxMzYUEwvDc7k+tZ1phMgORBgkQPl6D1jOjVrO+ZWgdhLwMMrk2WL
 cuEqbXgxdL8MhDOMfrtFoKTsMklYtQUXyBqCH/3OB2hyAFdjeeZt4xsL0j+fWLC1bQ5rD7M4zbP
 rw8+XEqZOLWKVa3wjMDlmg1PsLpsfZrcwjI+Yzf/lIVprnKmBkCtLxSaMCBoNvUhIyj0gkQcc8i
 7G3LQKWCYj7DM+f4RvdbrixjruolAA+rJHNQ0jEa2OVlRB8czyUHKOqT42Itll2JM32X0VcEzxe
 PgJc3iP3M1JZ96vJkm6qgZyuIy3IceO8y474AgSC6FERBGdNoEEoOvR+BpCltuZ5eV7S8ANZldx moJ9/Njf6RuKBSg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-6.19

for you to fetch changes up to 81280d39a2f9e7dc12056db889da52cce067b1b6:

  dt-bindings: soc: samsung: exynos-pmu: allow mipi-phy subnode for Exynos7870 PMU (2025-11-05 08:20:21 +0100)

----------------------------------------------------------------
Samsung SoC drivers for v6.19

1. ChipID driver: Add support for identifying Exynos8890 and Exynos9610.

2. PMU driver: Allow specifying list of valid registers for the custom
   regmap used on Google GS101 SoC.  The PMU (Power Management Unit) on
   that SoC uses more complex access to registers than simple MMIO and
   invalid registers trigger aborts halting the system.

3. Few minor cleanups.

4. Several new bindings for compatible devices.

----------------------------------------------------------------
Alexandru Chimac (2):
      dt-bindings: hwinfo: samsung,exynos-chipid: add exynos9610 compatible
      soc: samsung: exynos-chipid: Add exynos9610 SoC support

André Draszik (4):
      soc: samsung: exynos-pmu: allow specifying read & write access tables for secure regmap
      soc: samsung: exynos-pmu: move some gs101 related code into new file
      soc: samsung: gs101-pmu: implement access tables for read and write
      dt-bindings: soc: samsung: exynos-sysreg: add power-domains

Denzeel Oliva (1):
      dt-bindings: soc: samsung: exynos-sysreg: Add Exynos990 PERIC0/1 compatibles

Ivaylo Ivanov (3):
      dt-bindings: soc: samsung: exynos-pmu: add exynos8890 compatible
      dt-bindings: hwinfo: samsung,exynos-chipid: add exynos8890-chipid compatible
      soc: samsung: exynos-chipid: add exynos8890 SoC support

Kaustabh Chakraborty (2):
      dt-bindings: samsung: exynos-sysreg: add exynos7870 sysregs
      dt-bindings: soc: samsung: exynos-pmu: allow mipi-phy subnode for Exynos7870 PMU

Krzysztof Kozlowski (1):
      soc: samsung: exynos-pmu: Annotate online/offline functions with __must_hold

Peter Griffin (1):
      dt-bindings: soc: samsung: exynos-sysreg: add gs101 hsi0 and misc compatibles

Tudor Ambarus (1):
      soc: samsung: exynos-chipid: use a local dev variable

 .../bindings/hwinfo/samsung,exynos-chipid.yaml     |   2 +
 .../bindings/soc/samsung/exynos-pmu.yaml           |   2 +
 .../soc/samsung/samsung,exynos-sysreg.yaml         |  23 ++
 MAINTAINERS                                        |   1 +
 drivers/soc/samsung/Makefile                       |   3 +-
 drivers/soc/samsung/exynos-chipid.c                |  18 +-
 drivers/soc/samsung/exynos-pmu.c                   | 138 +------
 drivers/soc/samsung/exynos-pmu.h                   |  37 ++
 drivers/soc/samsung/gs101-pmu.c                    | 446 +++++++++++++++++++++
 include/linux/soc/samsung/exynos-regs-pmu.h        | 343 +++++++++++++++-
 10 files changed, 863 insertions(+), 150 deletions(-)
 create mode 100644 drivers/soc/samsung/gs101-pmu.c

