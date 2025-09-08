Return-Path: <linux-kernel+bounces-804915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D76C2B481E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 03:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EAA67AF2C0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 01:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB721A0BFD;
	Mon,  8 Sep 2025 01:18:23 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA61315D40;
	Mon,  8 Sep 2025 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294303; cv=none; b=UkfGrkrOxH6TELSVlWtc68WxFxit4WLDSR4WBLskfOdCoEAGMipv1ex21znfI15oA9lxBteJys7v2x+bxy1U8vyNvOXnfcnhhKVL9gWxQAtXbCWZ15lb/H1A0UCe67VerMsqHZ3+wS44rNW2x43Vcm/BKHgO+RDP2YVuZgwns8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294303; c=relaxed/simple;
	bh=Lgjijrp9qcMVaLCk4ZLmj/hlICCbVh7mqiq0FPS1wHE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IDXB6FRBQF87hDiy/ohTmUCxQU89NVZOGc8c0UlFNtWidlzN+6osuqSdbC0uVqaWC6iQX4/2wqRXG0HxAGoh//Ag10L3LyQcbrO20Kz531V0K+sx5FPVr7HUQRNMbf+HEHwgqUH4bUMqAa/ldh35qDT8XoTS/j3QjUmwhRmt6Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 8 Sep
 2025 09:18:12 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 8 Sep 2025 09:18:12 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 0/4] irqchip: Add support for Aspeed AST2700 SCU interrupt controller
Date: Mon, 8 Sep 2025 09:18:08 +0800
Message-ID: <20250908011812.1033858-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series adds support for the SCU (System Control Unit) interrupt
controllers on the Aspeed AST2700 SoC.

AST2700 follows the same multi-instance SCU interrupt controller design
as AST2600, with four independent interrupt domains (scu-ic0 to 3).
However, unlike previous SoCs that use a single register for both enable
and status bits, AST2700 splits them into separate IER (Interrupt Enable)
and ISR (Interrupt Status) registers.

To support this, the driver is refactored to use a variant-based init
structure, selected by compatible string. Register access is also
converted from regmap to MMIO (via `of_iomap()`), and a per-variant
IRQ handler is used depending on register layout.

v4:
- irq-aspeed-scu-ic.c
 - fixed missing inital mask = scu_ic->irq_enable << ASPEED_SCU_IC_STATUS_SHIFT;

v3:
- irq-aspeed-scu-ic.c
 - update for bracket-rules.
 - update TAB not spaces to align.
 - remove stray TAB.
 - update end up aligned.
 - add missing _ier, _isr in SCU_VARIANT.
 - add two different mask/unmask/ functions for split and combined.

v2:
- Refactor SCU IC driver to support variant-based initialization
- Add AST2700 compatible strings to YAML and header files
- Extend DT bindings in mfd and irqchip for AST2700
- Add IRQ handler logic for separate IER/ISR layout

Ryan Chen (4):
  irqchip/aspeed-scu-ic: Refactor driver to support variant-based
    initialization
  dt-bindings: mfd: aspeed: Add AST2700 SCU compatibles
  dt-bindings: interrupt-controller: aspeed: Add AST2700 SCU IC
    compatibles
  irqchip/aspeed-scu-ic: Add support AST2700 SCU interrupt controllers

 .../aspeed,ast2500-scu-ic.yaml                |   6 +-
 .../bindings/mfd/aspeed,ast2x00-scu.yaml      |   4 +
 drivers/irqchip/irq-aspeed-scu-ic.c           | 243 +++++++++++-------
 .../interrupt-controller/aspeed-scu-ic.h      |  14 +
 4 files changed, 174 insertions(+), 93 deletions(-)

-- 
2.34.1


