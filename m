Return-Path: <linux-kernel+bounces-766532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D04DB247CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09951BC1AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0473F2F6572;
	Wed, 13 Aug 2025 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvOADzl6"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826F197A76;
	Wed, 13 Aug 2025 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082820; cv=none; b=B+rC7ybGJbpVOjgbPqNnkYD2vo6CrkFpczhkAc+a7x7dLBxt5cCK3JLxMwA2lwbXvITTgXnmTguDSIMaWGOfdCDINCvVxdwW0deB/Cjk4ez1fHgwSyZjslRnMI8JBVzq7NE+FCraoP66MSLDOmMoathqM8tDzhZ6EYp9OW1/UVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082820; c=relaxed/simple;
	bh=me8EWh422YPo3cERqnPRxnV9qzRXPkVz2TeOOkHXTbc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YwQ7k79ogFdm/W0QkwEE+QSgvA0wLmRE/bCgJKLy67C/Y4ozsP/0alDVBIPlQ+q4Sc9crePStIEW3V1nNhUp3Vk44stnlJfnTNawpIHxBVgr0mzXdOiuPtfys9FqDF1nYSdKIaXhzhWjKYgUUin5BXWGPrQejgTnXg78E8oehwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvOADzl6; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so1123323966b.1;
        Wed, 13 Aug 2025 04:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755082817; x=1755687617; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3kL1xnjqe2uzC0tVKSkm6SdseVayTEiArpVj+WQ0yDk=;
        b=OvOADzl6FAyxJ2ornGMtIl0cgTdvnn5BWTxnpNvF9Rj1EQZZd3/BXdReFQTNxIOgwo
         3LhConio/LbBLGxiHjLCbNy41o5G4apiGWAbj4NR44VaQtITk1mZ5WZHD0FjQDrYr6mY
         F1CtgOORdIuv8DzJcU3k6LfL3Hayb9rPyH34tflb5SdyXXwcBpI3Dvmfd/YLdlpLhMpp
         zi0kTPeoT44UHIW8dIt8GB6IVkc061lM7efbKMd/1eFcRnY8AL2aFNROX7uqNGyX7Ykc
         /vsq57gpk6jvvCVps+IPFgpK2LtVbjrbG1VqQwMgTdmN2m14v+LxYMeVnf72fAQ9TeqW
         CuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082817; x=1755687617;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3kL1xnjqe2uzC0tVKSkm6SdseVayTEiArpVj+WQ0yDk=;
        b=YEkwga2Zxco7kHbUm4KLlkEiR1LYOEiUcogMexsow2Aq19P21NXXMtGMxEwgA6IJXy
         OUiFM+Oq8hEvV2VpRzTyaAxDKsPYMEJ8rfIie/929fnadEM5TKRaswhyH4NfYEDy3d1C
         h+fjDaxG7UVbq4TJfyjllGIQrQAXSkes07RdN4ltHJRq3VYzCirihG5HObceEDgEQVH9
         x2KR564CYLWMOZZ8Id7fVsttU1F03hDXtAaABN/bfuViKc+u+vy2bw7xa3/oMRmioTab
         z2N9kpctc+nVMYd2hLcwNMBDgtGJV+AQrAE9o40i3uz8+OCTnG/sxJNInpuElpHeWFZ1
         mohg==
X-Forwarded-Encrypted: i=1; AJvYcCU8pUo24n4SV1gv46V5p5c+sFHtTCklyLCrBu018mGC6PJyMbi9uxHL/WRpOxEimUHUhmbSnGqYQ75m@vger.kernel.org, AJvYcCWfCFYzlwArmfy4nuecC3L1HaAtUefFApDa69fqd1DD+Sc3YlyAl2GVSQHEh8PL8aXBx9yn1EweJit1vy9u@vger.kernel.org, AJvYcCXpzj6h8h5pd3EEFQXX0qNVWgiwfbs//B3Ae8SjjWAD620HqR/UWbkxAw+/BCSvpwv2M1Yq81ZDHki1@vger.kernel.org
X-Gm-Message-State: AOJu0Yznf7VrUyhhacXGWdXpZqpXmYvcxSl6TNRAutH526hNCcMtZWJw
	lZtOhe3czQvSagBDtCdqeTguzkChDtHeILQ22MGVMtFx8Xpr6zjvoooB
X-Gm-Gg: ASbGncsoV9/1lnTrCnLvJ8oiVSrBCMTVoR9RcSNIPzZXA0nzAgG51lVZ7M/CJs4Htma
	UMBzVBoY4bioyYMQ8/gAPEBom3D+q5hHUmrk7EBflLstljE6gu8JJfvCvp7Og7G962w+UnPbQDf
	XDqmR0xPq3jl8WL/Fq36/K/v67qayayQxYtSOl3rVkZCoa48eG4/SkESr/xwUImilFElT4R72DN
	dwX2cxWpHq4Tr5b5rORKqyYCg/YlgnOm3pqubTEdac7ynVzFwsJzA9ykVxoOr3t33698Bg0Z9Kj
	yTnMzWLHPMa4B3cPf5CaZUEBCIzs2t0TIUdHyDt9bAziCGoAUvYQBnoM9DAOwzEBnKwLQtCZis/
	qXJpHKXnNglL/55UEz70A9Y9oMMDdrHEg8WMdtnk33HOrvPpi7fZP1TQBpSyCPoo74iCH8MStvR
	MgPT2Q
X-Google-Smtp-Source: AGHT+IFoEKaitmZozrkaIV2lMO9akto5+yC9M/iP5+uw8oBSm22duN29iN/S3y04sK2bfwHVNKAamQ==
X-Received: by 2002:a17:907:7f9f:b0:ae0:df46:abd1 with SMTP id a640c23a62f3a-afca4e3f98amr247549266b.45.1755082816613;
        Wed, 13 Aug 2025 04:00:16 -0700 (PDT)
Received: from tablet.my.domain (ip-31-0-121-4.multi.internet.cyfrowypolsat.pl. [31.0.121.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df10asm2377046966b.59.2025.08.13.04.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 04:00:16 -0700 (PDT)
From: Artur Weber <aweber.kernel@gmail.com>
Subject: [PATCH v6 0/9] clk: bcm: kona: Add bus clock support, bus clocks
 for BCM21664/BCM281xx
Date: Wed, 13 Aug 2025 13:00:06 +0200
Message-Id: <20250813-kona-bus-clock-v6-0-f5a63d4920a4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADZwnGgC/2XMQW7DIBCF4atErEMFAx5wV71H1AXgIUFJTGUaq
 5Hlu4dEqmLZy/ek759YoSFRYZ+7iQ00ppJyXwfudyycXH8knrq6GQhoBEjg59w77m+Fh0sOZ66
 hNUTRUasFq+hnoJj+XsHDd92nVH7zcH/1R/l8/1O4To2SC07WmLYzxmGEr+PVpctHyFf2TI3w5
 kqoDYfKnUIV0KE3rV1zteR2w1XlHUbf+BiUR7PmesHlluvKY6O1RLIKbFzyeZ4f3wH9YGkBAAA
 =
X-Change-ID: 20250212-kona-bus-clock-4297eefae940
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Alex Elder <elder@kernel.org>, 
 Stanislav Jakubek <stano.jakubek@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, linux-arm-kernel@lists.infradead.org, 
 Artur Weber <aweber.kernel@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Alex Elder <elder@riscstar.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3153;
 i=aweber.kernel@gmail.com; h=from:subject:message-id;
 bh=me8EWh422YPo3cERqnPRxnV9qzRXPkVz2TeOOkHXTbc=;
 b=owEBbQKS/ZANAwAKAbO7+KEToFFoAcsmYgBonHA8O6A2pkp8j9hGUKYkuQ/MG/naw+/K46WAl
 1fvHeefl62JAjMEAAEKAB0WIQTmYwAOrB3szWrSiQ2zu/ihE6BRaAUCaJxwPAAKCRCzu/ihE6BR
 aI2AD/9prGAajhmB12IaeM+1QVgtX+yglvCsBau0vEnAQZdHlXUv1rS9vdQOhk/Gfx7Pm+TWoKT
 k4Rwe3nRoOsdxUaPq6c2RqcY6J/5RmzT7op4pzH+5Blkv93ttFD/Mng0aje/OnZfJU/k9KUDyE4
 0Blgk8xkO+4RporUvcQ7LGtwooYt5XoMpsraUYRQ3NvIwyGB+dV1PayawYcGX4PgseRl81q5E5H
 3cRvvr4ttwj+Wsc2Ac1bBUojXx4kVSz+rEYg3smTHviam/TJaaKx9fz+2ogpX/rfBDkUa9i9yIM
 lu5hDAQwLdXpSxexuUTiUXqKsWHPiWfZqWGSCsQkTX+5FWibZCo8taGrnJ2QyED5n4B6necBJab
 cjT2nukhlODxEigxQ0AP2AGL6JAck3KKJ8k+7vk7l4Nvq67e466DpDZqrDIyEQuZGrgEv4BRm6+
 HRMuKkPoxx8RT5gFeIsN2DiF1f4YMrvOdbqg/tP0lPovNi9ebQXpR3txft4PXuPSj9IS6DXb6S8
 0FjEISVa4q6P56CfRsED6gwO+envY6oUO+YgsxUPTuJ+nW8IfuS+rsKhFVE6BeucnwjH/hEhM89
 8KFLWHywA4Fd0FvByEaIJtsRCOQjFXrO5KFJOLAi/M4nQaLqZ+qJnAoET5OKCEZgdVuM5tDwBGD
 VPHGgP9jEZpU7ww==
X-Developer-Key: i=aweber.kernel@gmail.com; a=openpgp;
 fpr=E663000EAC1DECCD6AD2890DB3BBF8A113A05168

This patchset does the following:

- Introduce support for bus clocks. These are fairly similar to
  peripheral clocks, but only implement policy, gate and hyst.

- Add matching bus clocks for BCM21664 and BCM281xx peripheral clocks
  and update device tree bindings to match.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
Changes in v6:
- Rebase on v6.16
- Make kona_bus_clk_ops const, add a new commit to make kona_peri_clk_ops const as well
- Link to v5: https://lore.kernel.org/r/20250430-kona-bus-clock-v5-0-46766b28b93a@gmail.com/

Changes in v5:
- Pick up Reviewed-by trailer from Krzysztof on patch 3
- Rebase on v6.14
- No code changes since v4
- Link to v4: https://lore.kernel.org/r/20250318-kona-bus-clock-v4-0-f54416e8328f@gmail.com

Changes in v4:
- Rename moved CLOCK_COUNT defines to CLK_COUNT to avoid redefinition
- Squash BCM21664/BCM281xx bus clock DT bindings commits together
- Link to v3: https://lore.kernel.org/r/20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com

Changes in v3:
- Fix DT schema example in BCM281xx bus clock bindings
- Move CLOCK_COUNT defines from dt-bindings header to the driver
- Fix BCM21664 UARTBx_APB IDs being out of order compared to clock
  driver
- Link to v2: https://lore.kernel.org/r/20250303-kona-bus-clock-v2-0-a363c6a6b798@gmail.com

Changes in v2:
- Drop prerequisite clock patch
- Move clock/bcm21664.h dt-bindings header change to dt-bindings patch
- Add BCM281xx bus clocks
- Link to v1: https://lore.kernel.org/r/20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com

---
Artur Weber (9):
      clk: bcm: kona: Move CLOCK_COUNT defines into the driver
      dt-bindings: clock: brcm,kona-ccu: Drop CLOCK_COUNT defines from DT headers
      dt-bindings: clock: brcm,kona-ccu: Add BCM21664 and BCM281xx bus clocks
      clk: bcm: kona: Make kona_peri_clk_ops const
      clk: bcm: kona: Add support for bus clocks
      clk: bcm21664: Add corresponding bus clocks for peripheral clocks
      clk: bcm281xx: Add corresponding bus clocks for peripheral clocks
      ARM: dts: bcm2166x-common: Add matching bus clocks for peripheral clocks
      ARM: dts: bcm11351: Add corresponding bus clocks for peripheral clocks

 .../devicetree/bindings/clock/brcm,kona-ccu.yaml   |  49 ++++++-
 arch/arm/boot/dts/broadcom/bcm11351.dtsi           |  33 +++--
 arch/arm/boot/dts/broadcom/bcm2166x-common.dtsi    |  28 ++--
 drivers/clk/bcm/clk-bcm21664.c                     |  99 ++++++++++++++-
 drivers/clk/bcm/clk-bcm281xx.c                     | 141 ++++++++++++++++++++-
 drivers/clk/bcm/clk-kona-setup.c                   | 116 +++++++++++++++++
 drivers/clk/bcm/clk-kona.c                         |  64 +++++++++-
 drivers/clk/bcm/clk-kona.h                         |  14 +-
 include/dt-bindings/clock/bcm21664.h               |  17 ++-
 include/dt-bindings/clock/bcm281xx.h               |  24 +++-
 10 files changed, 540 insertions(+), 45 deletions(-)
---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250212-kona-bus-clock-4297eefae940

Best regards,
-- 
Artur Weber <aweber.kernel@gmail.com>


