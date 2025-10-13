Return-Path: <linux-kernel+bounces-850267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14884BD25EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45C5189AF23
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422102FF641;
	Mon, 13 Oct 2025 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djen3c3B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C1C2FE047
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348926; cv=none; b=Z/uFc4+23f4g5Dyysn6NkxWJbem5YDokuGGBPEeO7LAWdvpjWx/LTrCVUhwHrJWzad13gbgQyrz2c/HOQL2wH3j61JAVeDu5aTaRfuW6YMC5/ahCHGemwT/19R9nQO1LtW44HOeDNzliOftoj7W8IPxkN9LhQAjqZ8/Yb4nHvI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348926; c=relaxed/simple;
	bh=LpL8z06eYxg/1F9BJOGNQcja3KLalHkuQrBZOERB5hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mUrXlYM2VGuN0JXP5m/SSD2Wt3ak63j8P8HAnwwmGXVYGa6o9oOY0UwahawdFabvq4gLfYn2bRNsQOuEZwK5u90dGf9jGylQWqr+LTjjSOoy6E0ijfXdnam4Q7K4TUtcJ8hajbN6F9V9Y4RhplbPQf0N95roXNLnZApIQ4Bfu80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djen3c3B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02B2C19424;
	Mon, 13 Oct 2025 09:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760348926;
	bh=LpL8z06eYxg/1F9BJOGNQcja3KLalHkuQrBZOERB5hU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=djen3c3BjBlLmYNeEE3vAVKp/5Xpp6tviFa9raVvA5bmJRCdfFF/aQ6PxTRGQWU74
	 EPsQUfwT60tKatvuq80lM421IQBl+D8D+yjNlXdHceebnLQSvLlc8euvt6fRnArwmy
	 YHAJk2Nui3W0UMVRkfvx4lJimJod8g9CgxTm3yQ0DItZ3dalUrqxG9ILzazAap8noL
	 Hbum54tfmUnYMPKKvbTid8OpokEFghCeM4TuYkq+OQGumPZEvqR3ED5tyOmZtGzGxU
	 xuaKIYqg+/UlpaSqk2czNsbFhrZyVpaVHDfxGGj9wWGt7znDIozLDQU0yVTHANT2YN
	 EKl3G6Jg21oBw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v8FAa-0000000036i-1hSA;
	Mon, 13 Oct 2025 11:48:44 +0200
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
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 10/11] irqchip: Drop leftover brackets
Date: Mon, 13 Oct 2025 11:46:10 +0200
Message-ID: <20251013094611.11745-11-johan@kernel.org>
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

Drop some unnecessary brackets in platform_irqchip_probe() mistakenly
left by commit 9322d1915f9d ("irqchip: Plug a OF node reference leak in
platform_irqchip_probe()").

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/irqchip/irqchip.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
index 0ee7b6b71f5f..652d20d2b07f 100644
--- a/drivers/irqchip/irqchip.c
+++ b/drivers/irqchip/irqchip.c
@@ -38,9 +38,8 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	struct device_node *par_np __free(device_node) = of_irq_find_parent(np);
 	of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
 
-	if (!irq_init_cb) {
+	if (!irq_init_cb)
 		return -EINVAL;
-	}
 
 	if (par_np == np)
 		par_np = NULL;
@@ -53,9 +52,8 @@ int platform_irqchip_probe(struct platform_device *pdev)
 	 * interrupt controller. The actual initialization callback of this
 	 * interrupt controller can check for specific domains as necessary.
 	 */
-	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY)) {
+	if (par_np && !irq_find_matching_host(par_np, DOMAIN_BUS_ANY))
 		return -EPROBE_DEFER;
-	}
 
 	return irq_init_cb(np, par_np);
 }
-- 
2.49.1


