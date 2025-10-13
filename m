Return-Path: <linux-kernel+bounces-850263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC72FBD25DF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0B9C4EFB89
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC782FE076;
	Mon, 13 Oct 2025 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQhPBtrJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935892FBDF7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348926; cv=none; b=AINoEahCKrk3+8J1iuuSKytBPmLBcEJnkLewLqc19gJP5fgp+18yE6O/n4PBOFYLiGEMthsKyBseTrrbpkmdTNpy5lSQqKDQVeztva0fUleEY/FkXKEMSb21ddu9Z6LyIN0uvWzgZeb9mflqtT9k2bIAArQIZiPnSGKHVtFr8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348926; c=relaxed/simple;
	bh=xMvnxHJzPj+IB35wtsxst4yJqf9dtCebsKDIjlWmLEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUJJUeSDd4yaazxZsNYY4aQu+sZ+R3Ma/XVnh+t651378sbKRpb8m8yaKaNg/VGSaHvaRc99abB2cDM1VzVHU3yEyG6rq2z2eWNiGLUcg3mry3DQxxYwPt3mmTHv884+qtBA95L/Bug1BiffPcdl75LDEFrUCM1D8S8oVhV9Z9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQhPBtrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EDDC19422;
	Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760348926;
	bh=xMvnxHJzPj+IB35wtsxst4yJqf9dtCebsKDIjlWmLEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQhPBtrJDFN+CyiaIZPTFvmn7xzrAvx9I8cG8TAwZdUGCczRYuHIVGavv833dfZRL
	 U3+1uHGMNZ1yVNSIJx0XCrH0t8M5Jttw16Rg2Lj2Qm1kFCDunjSZrdZzAYq+jYt6Gn
	 UBGil/DS9BI/6/jz2yrkXMh5moIlLYWhUqsuOvk3T5NOLmHPh5/uIqeczhB1endmGd
	 COL1VPtUNLKda/rmZ0JjyGmCJAGhqLiDXD4aTF+kTsl5r2yWqBqMWv9eU/D/Or6rGR
	 HY0AHtrf6mlPh3nlus4q7BvqM6ztC+tSlN5GvERTMGvqYPWR2R2GHrYUtNUm4bxctd
	 kH6ZZJRVIglew==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FAZ-0000000036Q-3dt5;
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
Subject: [PATCH 04/11] irqchip/irq-bcm7120-l2: Fix section mismatch
Date: Mon, 13 Oct 2025 11:46:04 +0200
Message-ID: <20251013094611.11745-5-johan@kernel.org>
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
discarded so the irqchip init callbacks must not live in init.

Fixes: 3ac268d5ed22 ("irqchip/irq-bcm7120-l2: Switch to IRQCHIP_PLATFORM_DRIVER")
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/irqchip/irq-bcm7120-l2.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index ff22c3104401..63ff68d33787 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -143,8 +143,7 @@ static int bcm7120_l2_intc_init_one(struct device_node *dn,
 	return 0;
 }
 
-static int __init bcm7120_l2_intc_iomap_7120(struct device_node *dn,
-					     struct bcm7120_l2_intc_data *data)
+static int bcm7120_l2_intc_iomap_7120(struct device_node *dn, struct bcm7120_l2_intc_data *data)
 {
 	int ret;
 
@@ -177,8 +176,7 @@ static int __init bcm7120_l2_intc_iomap_7120(struct device_node *dn,
 	return 0;
 }
 
-static int __init bcm7120_l2_intc_iomap_3380(struct device_node *dn,
-					     struct bcm7120_l2_intc_data *data)
+static int bcm7120_l2_intc_iomap_3380(struct device_node *dn, struct bcm7120_l2_intc_data *data)
 {
 	unsigned int gc_idx;
 
@@ -208,7 +206,7 @@ static int __init bcm7120_l2_intc_iomap_3380(struct device_node *dn,
 	return 0;
 }
 
-static int __init bcm7120_l2_intc_probe(struct device_node *dn,
+static int bcm7120_l2_intc_probe(struct device_node *dn,
 				 struct device_node *parent,
 				 int (*iomap_regs_fn)(struct device_node *,
 					struct bcm7120_l2_intc_data *),
@@ -339,15 +337,13 @@ static int __init bcm7120_l2_intc_probe(struct device_node *dn,
 	return ret;
 }
 
-static int __init bcm7120_l2_intc_probe_7120(struct device_node *dn,
-					     struct device_node *parent)
+static int bcm7120_l2_intc_probe_7120(struct device_node *dn, struct device_node *parent)
 {
 	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_7120,
 				     "BCM7120 L2");
 }
 
-static int __init bcm7120_l2_intc_probe_3380(struct device_node *dn,
-					     struct device_node *parent)
+static int bcm7120_l2_intc_probe_3380(struct device_node *dn, struct device_node *parent)
 {
 	return bcm7120_l2_intc_probe(dn, parent, bcm7120_l2_intc_iomap_3380,
 				     "BCM3380 L2");
-- 
2.49.1


