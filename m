Return-Path: <linux-kernel+bounces-724308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BBBAFF11A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF44543126
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74CB23CEFF;
	Wed,  9 Jul 2025 18:45:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4623C4FA;
	Wed,  9 Jul 2025 18:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752086747; cv=none; b=Swxbjtiij9RMYMgnX79NvmQ+AR4nicY5BuH/bs5BAdQf1XDxKZ7MYp3SuIX3b1kzjUZl2AMkiCOYSBJaL6vNx8+c9wiGmY0RaxRivnxkuffuVbIMJcF7zH4X3+pc7QzO1Hiqo9Lh7wWcnkR611AQG01UKiGS1exTDxEB6kZ6WKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752086747; c=relaxed/simple;
	bh=jUdzrww5SftydKZX1SJX7BwKJwqNYOuRfAOy82gsH7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrRf8/4QUIlu6K0b9PekuD4+AzTC7u2eToCkO34qLQWRuiWoQnZ2RUn8ZfbSxt4kMxpI1H+c/HUT8+Oqbx3N94RVJQp0Ep/IR5om2pgZbRIIuGyP8KdjOlfjz2suuzi+gNs3gv6ClMotDVepLTKvAae//0EJ/u+7EJvRtg/gsKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8081DC4CEF4;
	Wed,  9 Jul 2025 18:45:45 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Thomas Gleixner <tglx@linutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip/renesas-irqc: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Wed,  9 Jul 2025 20:45:42 +0200
Message-ID: <5a14f9932da20ec46cde27f314414474072755ed.1752086718.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Renesas IRQC driver from SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr().  This lets us drop the
__maybe_unused annotations from its suspend callback, and reduces kernel
size in case CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-renesas-irqc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index b46bbb66c2641ab4..a20a6471b0e48ba2 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -227,7 +227,7 @@ static void irqc_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-static int __maybe_unused irqc_suspend(struct device *dev)
+static int irqc_suspend(struct device *dev)
 {
 	struct irqc_priv *p = dev_get_drvdata(dev);
 
@@ -237,7 +237,7 @@ static int __maybe_unused irqc_suspend(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(irqc_pm_ops, irqc_suspend, NULL);
+static DEFINE_SIMPLE_DEV_PM_OPS(irqc_pm_ops, irqc_suspend, NULL);
 
 static const struct of_device_id irqc_dt_ids[] = {
 	{ .compatible = "renesas,irqc", },
@@ -251,7 +251,7 @@ static struct platform_driver irqc_device_driver = {
 	.driver		= {
 		.name		= "renesas_irqc",
 		.of_match_table	= irqc_dt_ids,
-		.pm		= &irqc_pm_ops,
+		.pm		= pm_sleep_ptr(&irqc_pm_ops),
 	}
 };
 
-- 
2.43.0


