Return-Path: <linux-kernel+bounces-864274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B1FBFA5AE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F1519A0D39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645B22F28F1;
	Wed, 22 Oct 2025 06:55:19 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3422F25F7;
	Wed, 22 Oct 2025 06:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116119; cv=none; b=rJb3rC+H0tke1FgrZ7/W5fowZ425j7WZXA+AdRxlihQyrd9ACOixnznp/xYU0NWTJ9HQzx+FMZgFcXL+LtvG37aXc0yfzBqpXoDSVn/QLvkzBoUVXITUdhwq0BHzl3mihMmYuoZB4pqdxlSD2lmHo2cv+N26Q4/E6U2W7GiEloA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116119; c=relaxed/simple;
	bh=EiQSRNGTHLdZpN+0NcBZ+2IyylgiuzCdjU6E9xsQZhQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F4NDJ1zFUheUVBMkxOetyrhLsznx2odNR7Jxv64hIBP67Ts0loPY5VYZCFut6TLjBzl/KFVroVFdmpviQYv8o761pa1MkVScr8wMa5oYYafvFKkBC/1VzonqREpVLPhjWzyggqkN1uOBwVBnoRYf+0pUtdpMQNqp+lwtRFBVtuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 22 Oct
 2025 14:55:07 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 22 Oct 2025 14:55:07 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	<jk@codeconstruct.com.au>, Kevin Chen <kevin_chen@aspeedtech.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v5 0/3] AST2700 interrupt controller hierarchy support
Date: Wed, 22 Oct 2025 14:55:04 +0800
Message-ID: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series introduces YAML bindings and driver support for the
ASPEED AST2700 interrupt controller hierarchy. The AST2700 SoC
contains two top-level interrupt controller blocks, INTC0 and
INTC1, each responsible for routing different interrupt groups
to various CPU targets.

v5:
- Adds two new YAML bindings:
 - aspeed,ast2700-intc0.yaml
 - aspeed,ast2700-intc1.yaml
- irq-aspeed-intc.c
 - add aspeed,ast2700-intc0-ic, aspeed,ast2700-intc0-ic compatible.

v4:
- aspeed,ast2700-intc.yaml
 - Clarify the relationship between INTC0/INTC1 parent nodes, the
   aspeed,ast2700-intc-ic child nodes, and the GIC.
 - Add a block diagram and DT examples showing the cascaded wiring
   (GIC <- INTC0 <- INTC1 children).
 - Mirrors the datasheet-described topology and register map, including
   the separation of INTC0/INTC1 regions.
 - Lets DT unambiguously express first-level (GIC parent) and cascaded
   second-level (INTC0 parent) interrupt controllers via examples that
   use `interrupts` for INTC0 children and `interrupts-extended` for
   INTC1 children routed into INTC0.

- irq-ast2700-intc.c
 - Drop all string decoding and human readable tables.
   Debugfs now dumps raw routing/protection registers only.
 - Split into a separate source file and made it modular
 - If the compatible not match ast2700-intc0/1, bail out return -ENODEV.

v3:
- aspeed,ast2700-intc.yaml
  - Clarify the relationship between INTC0/INTC1 parent nodes, the
    aspeed,ast2700-intc-ic child nodes, and the GIC.
  - Add a block diagram and DT examples showing the cascaded wiring
    (GIC <- INTC0 <- INTC1 children).
  - Mirrors the datasheet-described topology and register map, including
    the separation of INTC0/INTC1 regions and their routing/protection
    registers.
  - Lets DT unambiguously express first-level (GIC parent) and cascaded
    second-level (INTC0 parent) interrupt controllers via examples that
    use `interrupts` for INTC0 children and `interrupts-extended` for
    INTC1 children routed into INTC0.
  
- irq-aspeed-intc.c
  - separate c file from irq-aspeed-intc.c
  - make m

v2:
- fix dt bindingcheck

Ryan Chen (3):
  dt-bindings: interrupt-controller: aspeed,ast2700: Add support for
    INTC hierarchy
  Irqchip/ast2700-intc: add debugfs support for routing/protection
    display
  irqchip: aspeed: add compatible strings for ast2700-intc0-ic and
    ast2700-intc1-ic

 .../aspeed,ast2700-intc0.yaml                 |  97 ++++++++++
 .../aspeed,ast2700-intc1.yaml                 |  94 ++++++++++
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-aspeed-intc.c             |   2 +
 drivers/irqchip/irq-ast2700-intc.c            | 174 ++++++++++++++++++
 6 files changed, 374 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc0.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc1.yaml
 create mode 100644 drivers/irqchip/irq-ast2700-intc.c

-- 
2.34.1


