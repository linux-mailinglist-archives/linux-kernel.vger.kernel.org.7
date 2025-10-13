Return-Path: <linux-kernel+bounces-850262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C35FCBD25DC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8A814EFADE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475D62FE073;
	Mon, 13 Oct 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5X7CS6l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E082FB632
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348926; cv=none; b=mpsrTpA9Y498VmcE8LWGn4F1RajRMnIk7//lbMzfWJpzqgw970rUs7yccZTgaGY5H8uEu8YlvlAXAuEiZrlUQpHRpOUK2lMUeAkTvFD9j4TBKlIiMY/MfOEghPCnu7xJrIux1Ub7tHJk8kqIfXopE3SU5wnO2aI0GAXkz4L7JYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348926; c=relaxed/simple;
	bh=g6X8oJ5DSXDBk0NgBv7aeqsGUGeoDtV/vwL93P6tfMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdP2XCpM2SjZTICn3GCXAAw6bYCXhcy2oUxRzqVmzgKRunckv/332r4yuPbSo76Wx5neHUFxe6yNboL914dqkD4zoZdMMsvA5YrWSVDUn5Jjx2SDtQZ7cJ6s0bGNwusUdgQ8kBOL4tS717YhsI3C6fBWb6vD3B8kztmgl5pw9dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5X7CS6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D99C19421;
	Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760348926;
	bh=g6X8oJ5DSXDBk0NgBv7aeqsGUGeoDtV/vwL93P6tfMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5X7CS6la6bszhJ8EwUy3oZAODH/jy8fiSGO5O+v/14dWyadLYaP9bVRHsXrJ21ra
	 ujdgis5J6HviDgCDu/YP0HYGYKtJuG7fdxfylh6TD7M4wnIL0fjUEXTy8QUV/LOn0x
	 9bCWAQrO2KDNwHc4s2d/dTjKPsFP0cbaILZf0uHBvS2DofAc2eUODBLxep8Wr5zu2G
	 sb/HT0XYQGlZKpA3liQLSODd1nG3WDZveXNUUs1UYKLud0OAQvyjPePEOZOBUd3duR
	 RnGaTlx2I1t6iTD78uN6pr9pqubDc7aEW2SqbVOpi24H4kUcBo69vqV3HEL8/iEB4M
	 9Zj/O/TNFCpaQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FAZ-0000000036O-3DcQ;
	Mon, 13 Oct 2025 11:48:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 03/11] irqchip/irq-bcm7038-l1: Fix section mismatch
Date: Mon, 13 Oct 2025 11:46:03 +0200
Message-ID: <20251013094611.11745-4-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251013094611.11745-1-johan@kernel.org>
References: <20251013094611.11745-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Platform drivers can be probed after their init sections have been
discarded so the irqchip init callback must not live in init.

Fixes: c057c799e379 ("irqchip/irq-bcm7038-l1: Switch to IRQCHIP_PLATFORM_DRIVER")
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/irqchip/irq-bcm7038-l1.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l1.c
index 04fac0cc857f..e28be83872cb 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -219,9 +219,9 @@ static int bcm7038_l1_set_affinity(struct irq_data *d,
 }
 #endif
 
-static int __init bcm7038_l1_init_one(struct device_node *dn,
-				      unsigned int idx,
-				      struct bcm7038_l1_chip *intc)
+static int bcm7038_l1_init_one(struct device_node *dn,
+			       unsigned int idx,
+			       struct bcm7038_l1_chip *intc)
 {
 	struct resource res;
 	resource_size_t sz;
@@ -395,8 +395,7 @@ static const struct irq_domain_ops bcm7038_l1_domain_ops = {
 	.map			= bcm7038_l1_map,
 };
 
-static int __init bcm7038_l1_of_init(struct device_node *dn,
-			      struct device_node *parent)
+static int bcm7038_l1_of_init(struct device_node *dn, struct device_node *parent)
 {
 	struct bcm7038_l1_chip *intc;
 	int idx, ret;
-- 
2.49.1


