Return-Path: <linux-kernel+bounces-864277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A894BFA5D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA7BA4FDB44
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6F02F39C2;
	Wed, 22 Oct 2025 06:55:26 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE52F39A8;
	Wed, 22 Oct 2025 06:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761116125; cv=none; b=FjVt2kUqk0WWOVB39tBSsqrLUfqpcwh/vO055DUmiuM3M1v41ZHSCJqZidA2oNXfMg/CJY2JY/lWBpD2Ea7fbU9JgVvSoyOxgWrjZyQkM/0hphOUsvBeBGicRpqRIYDEa+2AP+sLruxa02qUQk9ax8diE0hLukKh4ylPArW/N7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761116125; c=relaxed/simple;
	bh=KXojSMrKGmza35LeBneSk1MTVlpNu6ZtVMClPdM2fc0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qq6CF1ayq5T/Gu+Zjap/oajDyw2dPIq0xV50JYYIMUD21MTQ8VZIi7auovWB6HF3ONF8Np82DaghTsE1azDo8z00JNsDWO9mp4JDuBUr6lN0OnyT/sLpEOPgF+t56If1sr0sWHMfWeK3Ot1qgbD18X3sGukpt3LTxSzyGyeLcpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 22 Oct
 2025 14:55:08 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 22 Oct 2025 14:55:08 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	<jk@codeconstruct.com.au>, Kevin Chen <kevin_chen@aspeedtech.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>
Subject: [PATCH v5 3/3] irqchip: aspeed: add compatible strings for ast2700-intc0-ic and ast2700-intc1-ic
Date: Wed, 22 Oct 2025 14:55:07 +0800
Message-ID: <20251022065507.1152071-4-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
References: <20251022065507.1152071-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AST2700 SoC defines two parent interrupt controller blocks
(INTC0 and INTC1), each containing multiple interrupt-controller
child instances ("*-intc-ic"). The existing irqchip driver
(irq-aspeed-intc.c) currently only registers a single compatible
string: "aspeed,ast2700-intc-ic"

To support device trees that describe the INTC0 and INTC1
hierarchy more precisely, this patch adds two additional
compatible strings:
 - "aspeed,ast2700-intc0-ic"
 - "aspeed,ast2700-intc1-ic"

Both map to the same initialization function
`aspeed_intc_ic_of_init()`.

This allows DTS bindings and drivers for AST2700 INTC0/INTC1
to be matched correctly, while maintaining backward compatibility
with the original compatible string.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/irqchip/irq-aspeed-intc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-aspeed-intc.c b/drivers/irqchip/irq-aspeed-intc.c
index 8330221799a0..a40b406dc8fa 100644
--- a/drivers/irqchip/irq-aspeed-intc.c
+++ b/drivers/irqchip/irq-aspeed-intc.c
@@ -137,3 +137,5 @@ static int __init aspeed_intc_ic_of_init(struct device_node *node,
 }
 
 IRQCHIP_DECLARE(ast2700_intc_ic, "aspeed,ast2700-intc-ic", aspeed_intc_ic_of_init);
+IRQCHIP_DECLARE(ast2700_intc0_ic, "aspeed,ast2700-intc0-ic", aspeed_intc_ic_of_init);
+IRQCHIP_DECLARE(ast2700_intc1_ic, "aspeed,ast2700-intc1-ic", aspeed_intc_ic_of_init);
-- 
2.34.1


