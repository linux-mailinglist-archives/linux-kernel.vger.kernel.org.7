Return-Path: <linux-kernel+bounces-824710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C59A8B89F50
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F93D1CC18F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654F8314D09;
	Fri, 19 Sep 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="D8t47JzY"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017F313D50;
	Fri, 19 Sep 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292046; cv=none; b=VRzUqP/W2H2oDB3g/G1Oh7RTFli9dpVB7uP49E7SJqpYMTZ2IA6CqqUlD5Asy/ZDoNGpJEuDPESXUCNn85cTfxWZOiS+3cGI+QQMmGb4xaFDrSEVeqkl/OB6VMmWg6AU9mL7TO5paBN2Dyqt9WdzozNF//7XPwn9+lBjVVFTObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292046; c=relaxed/simple;
	bh=wG7HP8U4mFstc/9UQjpKbDZQqvBNpc0oXj8XRRmh6HI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUVfsPhCSfwzeuJHqyuF4bHvRxCyCi4Qb5/N5AhRKAXfn8h6/HTbdfVO0zkD8YmTihyFSdIvsejzn04172R0VW7CBr0+9Pwv78X6CDHLqLJF6e1g/CDw13a4FylvPuxel8bU62hdW/dKujPcKuwpsdKYSBV3WjntZT5IxVEOEik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=D8t47JzY; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id E1DFB20CA1;
	Fri, 19 Sep 2025 16:27:20 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G4GDa5VZ5iKv; Fri, 19 Sep 2025 16:27:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1758292039; bh=wG7HP8U4mFstc/9UQjpKbDZQqvBNpc0oXj8XRRmh6HI=;
	h=From:To:Cc:Subject:Date;
	b=D8t47JzYnRkojo9f1P59p7RXww3Wj+XBEcyQvo2qfY7mNl3xNxwJjVztZsvbXNN3r
	 bCaEEwX24aaGl+MVIOsdat88lOZrg0RaGbKRRfXUcwdk8T8UCEJuD5LtKutg/5Feoo
	 lOg6jdbG4+wHzR2ka8+R6ImRk/NKxUh60yPvnaB5kMZ+n4OAzh9WebLCr7YBdy9BRI
	 NXIlKsbIM5BpHTE5pj2e3U4jwrsGYFV7mjCfsf0tliBwIEXiGM2kFr8Jn3OhJ9AGHr
	 8/FQLDKXgDprG0yDVT9dRMKf+3IVhVELq9VR6kWiR6N3lUuZmU+7crWsMuSfe/It+6
	 SBG1nD1717WeQ==
From: Yao Zi <ziyao@disroot.org>
To: Yinbo Zhu <zhuyinbo@loongson.cn>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v4 0/8] Add clock support for Loongson 2K0300 SoC
Date: Fri, 19 Sep 2025 14:26:41 +0000
Message-ID: <20250919142649.58859-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for Loongson-2K0300's clock controller.
Loongson 2 clock driver is prepared to support more clock variants and
its flexibility is improved. All clock hardwares except the output one
for GMAC module are then defined.

A clock tree dump could be obtained here[1]. Devicetree changes (PATCH 7
and 8) depends on v3 of series "Initial support for CTCISZ Forever Pi"[2]
to apply.

[1]: https://gist.github.com/ziyao233/5261c5983d7ccb0a4299cfd7f26b2027
[2]: https://lore.kernel.org/all/20250523095408.25919-1-ziyao@disroot.org/

Changed from v3:
- Collect review tags
- Change "Loongson 2K0300" to "Loongson-2K0300", and "2K0300" to
  "LS2K0300" in commit messages
- dt-bindings
  - Merge loongson,ls2k0300-clk.h into loongson,ls2k-clk.h
  - Change LS2K0300_PLL_{NODE,DDR,PIX} to LS2K0300_{NODE,DDR,PIX}_PLL
    for consistency
- driver
  - Fold clock definition into a single line if possible
- Link to v3: https://lore.kernel.org/all/20250805150147.25909-1-ziyao@disroot.org/

Changed from v2:
- Disallow clock-names property for loongson,2k0300-clk's binding, avoid
  overriding content of clock-names property within an allOf block
- Correct clock-controller's MMIO-region size in SoC devicetree
- Link to v2: https://lore.kernel.org/all/20250617162426.12629-1-ziyao@disroot.org/

Changed from v1:
- Fold loongson,ls2k0300-clk.yaml into loongson,ls2k-clk.yaml
- Include the new binding header in MAINTAINERS
- Link to v1: https://lore.kernel.org/all/20250523104552.32742-1-ziyao@disroot.org/

Yao Zi (8):
  dt-bindings: clock: loongson2: Add Loongson-2K0300 compatible
  clk: loongson2: Allow specifying clock flags for gate clock
  clk: loongson2: Support scale clocks with an alternative mode
  clk: loongson2: Allow zero divisors for dividers
  clk: loongson2: Avoid hardcoding firmware name of the reference clock
  clk: loongson2: Add clock definitions for Loongson-2K0300 SoC
  LoongArch: dts: Add clock tree for Loongson-2K0300
  LoongArch: dts: Remove clock-frquency from UART0 of CTCISZ Forever Pi

 .../bindings/clock/loongson,ls2k-clk.yaml     |  18 ++-
 .../dts/loongson-2k0300-ctcisz-forever-pi.dts |   1 -
 arch/loongarch/boot/dts/loongson-2k0300.dtsi  |  16 ++-
 drivers/clk/clk-loongson2.c                   | 122 +++++++++++++++---
 include/dt-bindings/clock/loongson,ls2k-clk.h |  36 ++++++
 5 files changed, 166 insertions(+), 27 deletions(-)

-- 
2.50.1


