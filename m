Return-Path: <linux-kernel+bounces-850265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831D6BD25E5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42A923C3B95
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4209D2FF17D;
	Mon, 13 Oct 2025 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hg9JNZND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C027F2FE041
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348926; cv=none; b=b+st2MpeJRSi1v3P5IByiN+v31mWmOWAppRfkzRdXgNiDiqt7pdD8bkBuyR2VjaZ2oMX4ePRznUFJ+kVYXMB+h6jA/mFgXNm9QJ/JYujmKhc+122yd1Lhi+2PhFh+qmpWPKV82YYmoOsalBrqfC/COuA29qcKG5XSFcbTOYj5QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348926; c=relaxed/simple;
	bh=qIgoBlkWclsRYWytwAMF5I10sjbvmsyYhn4jiOSJGHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jfdpj0zfGvwbwZkD5uu7DUfPyFvJRm8eYOaOnQIehx4MmoIQ4bg+3lxplXmtVDXy+7u8QJYpcKfsEkPhOoTzN+5Y2gU6cwQZeP5wyD2jLJF4NZyOrPBa+rFPXZ8ZDHoutmgPOqdEOYEesqxZJ3I5ISmvZBmRLXSvdru6p5dLShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hg9JNZND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69601C16AAE;
	Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760348926;
	bh=qIgoBlkWclsRYWytwAMF5I10sjbvmsyYhn4jiOSJGHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hg9JNZNDTILCmwTrkKOpfV9uZdfVpi1vH9IJNjFu7NlWIJliTSHR1H3UTTeKz+K6P
	 VBqo00/BEQOVtMpAK6QVFTUj6c1xD4gPe/irtDrn3y0Vch9iuNXfzjKq6ehThPEBxs
	 9EiLVu4/NpYV3Fbkp5xymAc1r6IbnbPk6LUaJGJ5PrftirvHCN71rh0/CJAkqkGosB
	 mRb8KmdktNhJsBf+PMo2a6t4WA1tSm1s+TEMuZIeDGkHHtgYT1noouWBBEaTBcnJUl
	 cph0Qa7X1p6NmASwjJZDWlYeb2hRebQWH2Kjq/Cr+DRfthrc4rymjExGtut2ApIqj1
	 glFPTzAt4p6rA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FAZ-0000000036T-3y9l;
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
Subject: [PATCH 05/11] irqchip/irq-brcmstb-l2: Fix section mismatch
Date: Mon, 13 Oct 2025 11:46:05 +0200
Message-ID: <20251013094611.11745-6-johan@kernel.org>
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

Fixes: 51d9db5c8fbb ("irqchip/irq-brcmstb-l2: Switch to IRQCHIP_PLATFORM_DRIVER")
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/irqchip/irq-brcmstb-l2.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index 1bec5b2cd3f0..53e67c6c01f7 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -138,10 +138,8 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	irq_reg_writel(gc, ~b->saved_mask, ct->regs.enable);
 }
 
-static int __init brcmstb_l2_intc_of_init(struct device_node *np,
-					  struct device_node *parent,
-					  const struct brcmstb_intc_init_params
-					  *init_params)
+static int brcmstb_l2_intc_of_init(struct device_node *np, struct device_node *parent,
+				   const struct brcmstb_intc_init_params *init_params)
 {
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	unsigned int set = 0;
@@ -257,14 +255,12 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	return ret;
 }
 
-static int __init brcmstb_l2_edge_intc_of_init(struct device_node *np,
-	struct device_node *parent)
+static int brcmstb_l2_edge_intc_of_init(struct device_node *np, struct device_node *parent)
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_edge_intc_init);
 }
 
-static int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
-	struct device_node *parent)
+static int brcmstb_l2_lvl_intc_of_init(struct device_node *np, struct device_node *parent)
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_lvl_intc_init);
 }
-- 
2.49.1


