Return-Path: <linux-kernel+bounces-756628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02EFB1B703
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB57A622A90
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485B5279783;
	Tue,  5 Aug 2025 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="mQIvw7Pq"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667261607A4;
	Tue,  5 Aug 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406195; cv=none; b=JoRJo02JACstxiux0HMuZcLQtbWql4HjkfnRDeO1iXdZ5al4Y8UsnSOCrYFHNbhyaTEEYsunZ9nQGwkCNTZIQFpxAJpQBOGBLmWbWtZxLHHX0pqxePtN3G0W2rk9DlH4p68fcV8eCDkIgLzjJp3l4FkBRU0NfZCo/+9qolUyTr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406195; c=relaxed/simple;
	bh=PM0ucKzjFtT3FImy4Ip367R0u7NFzW5Ncae8+HumlbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HucJNWzKjv3tQL6DHPlj3gatE0ixCYhkdvNFiwDnyBHwXSUPH9qYMNxf7cAy5qNVtygUlZ53xPGIVwSbuove4PUNBPyEx1FXPDkNFTYVw4p+JpmVEj3k6Qrs8pxz55/+qooudv+7luOBDcObnK5DsciyyYFF47jT84WMgHGso38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=mQIvw7Pq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 2743C25EE6;
	Tue,  5 Aug 2025 17:03:06 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xiyP9XL3EPH5; Tue,  5 Aug 2025 17:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754406185; bh=PM0ucKzjFtT3FImy4Ip367R0u7NFzW5Ncae8+HumlbY=;
	h=From:To:Cc:Subject:Date;
	b=mQIvw7PqtPV9iLkRADe2XZeVIeLuPECOsv9VknZRMImvsctAHDC78gU9qmFkH2BvX
	 0cztnradAWemwRFkIcJYzzdnyxfWPM4OQqp4nh9nVyrKw06uJkkpcYe3Pr6Q7lZbRU
	 th2yOFLGWEXVqNs4pDRikumAuW7DP3W1xVPgRA1IdGUNEHsE1JEX/hm8kvBs1l556h
	 zcUcav/JPwZNpap24SdqJr99Z3Wm11cmaCqfHSbYBDmxrqtwtsgtHZvV9HZX/etk4j
	 pRtv/DlgeGxK0ZMviDtn4LgaGVdQTXNpdU+H81h8A0VMEKVARl+dD4j48KjDqe4Pgn
	 P+zwEIPE9+OAA==
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
Subject: [PATCH v3 0/8] Add clock support for Loongson 2K0300 SoC
Date: Tue,  5 Aug 2025 15:01:39 +0000
Message-ID: <20250805150147.25909-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for Loongson 2K0300's clock controller.
Loongson 2 clock driver is prepared to support more clock variants and
its flexibility is improved. All clock hardwares except the output one
for GMAC module are then defined.

A clock tree dump could be obtained here[1]. This series depends on v3
of series "Initial support for CTCISZ Forever Pi"[2] to apply.

Krzysztof, sorry I don't fully understand your comments in v2, I've
asked once again later[3] but got no reply, thus sent this new version
with my current understanding. I'm willing to hear from you more on the
binding issue, thanks.

[1]: https://gist.github.com/ziyao233/f7c4edcfbc1d6b325c71117af7233cc2
[2]: https://lore.kernel.org/all/20250523095408.25919-1-ziyao@disroot.org/
[3]: https://lore.kernel.org/all/aHB3Wvu-CVlYzhU7@pie.lan/

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
  dt-bindings: clock: loongson2: Add Loongson 2K0300 compatible
  clk: loongson2: Allow specifying clock flags for gate clock
  clk: loongson2: Support scale clocks with an alternative mode
  clk: loongson2: Allow zero divisors for dividers
  clk: loongson2: Avoid hardcoding firmware name of the reference clock
  clk: loongson2: Add clock definitions for Loongson 2K0300 SoC
  LoongArch: dts: Add clock tree for Loongson 2K0300
  LoongArch: dts: Remove clock-frquency from UART0 of CTCISZ Forever Pi

 .../bindings/clock/loongson,ls2k-clk.yaml     |  21 ++-
 MAINTAINERS                                   |   1 +
 .../dts/loongson-2k0300-ctcisz-forever-pi.dts |   1 -
 arch/loongarch/boot/dts/loongson-2k0300.dtsi  |  16 ++-
 drivers/clk/clk-loongson2.c                   | 124 +++++++++++++++---
 .../dt-bindings/clock/loongson,ls2k0300-clk.h |  54 ++++++++
 6 files changed, 189 insertions(+), 28 deletions(-)
 create mode 100644 include/dt-bindings/clock/loongson,ls2k0300-clk.h

-- 
2.50.1


