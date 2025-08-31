Return-Path: <linux-kernel+bounces-793223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FFAB3D0B3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 04:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF93C445555
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 02:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA461E521D;
	Sun, 31 Aug 2025 02:14:49 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C4E54723;
	Sun, 31 Aug 2025 02:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756606489; cv=none; b=kDW0LAIZ9bwvjVm7jfS5mUaioIn5gxt5Wtn8ZwBkQV9z1SrD85LTsKlp4vpbmOqlHccFMqLs4OO536J0GuQSHG4lwwutFRCtSJJ52fjdHjwg2RCQ+BisjkPo2aiWFFFba9RvDUYe3Pexjyn27ZiJfRxYI+Oa/Rg3fgI32ySNdp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756606489; c=relaxed/simple;
	bh=SNg+FmqZ16vCa13YLfAMHKe9V2Ku+glFAjh0Z6qAP/E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Kx9g7eQtKPvWK7yKTIq/UMnILz7QLdzOq9GyNOnA732pIpwZfI3kMsYRVSZpSlSdkmL33BZlh48n8BV90IgieDXkGePpZFtJso79+5vT8ImxMhpruR+auvED2PFkcNvvhzxRslUOEsQ8JohmluqVhZXFCmw8YFV+qpNFQXoP2yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Sun, 31 Aug
 2025 10:14:38 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Sun, 31 Aug 2025 10:14:38 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Eddie James <eajames@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Lee Jones <lee@kernel.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/4] irqchip: Add support for Aspeed AST2700 SCU interrupt controller
Date: Sun, 31 Aug 2025 10:14:34 +0800
Message-ID: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
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
 drivers/irqchip/irq-aspeed-scu-ic.c           | 238 ++++++++++--------
 .../interrupt-controller/aspeed-scu-ic.h      |  14 ++
 4 files changed, 163 insertions(+), 99 deletions(-)

-- 
2.34.1


