Return-Path: <linux-kernel+bounces-769921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57682B2750F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A20818990F3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE28D29B22C;
	Fri, 15 Aug 2025 01:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYnlBBBc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478B6298CB1;
	Fri, 15 Aug 2025 01:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222839; cv=none; b=cTD4wQYzYbMX78Eg2dFm0buxGScT2wFuowliIXBOAVISLHMWxOeEI1SQaUIYhhYaH0S4so/g83rh3yH6GS/RklBblj2NrkfNuomPtu93sx1+OpOKqrEuUghXX0GryTjFbh/sf/I1sWmjl0wLaeCATK/R6JAANGXnVZNBQplC+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222839; c=relaxed/simple;
	bh=dUnZJf0fPVnkZVwOXFMDCViTMe3JuJxKZh0p/jfBxS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S7J85DKxZLrOwAnYkDfNq+dAv9TVfmtXCeYZ32TM+iytSr8zLdm7Bj3DtY+mCFG/GPMqqAOqbn8xRYY86a6GyuBN60UERFLPHQzGf9fU/c4OHdOnRLd44OEsAlMF40aMYTTNxtN2+EZGi0wb58BuAVyT2pf4BowZLkEpEaVxBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYnlBBBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1D2C4CEF7;
	Fri, 15 Aug 2025 01:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222838;
	bh=dUnZJf0fPVnkZVwOXFMDCViTMe3JuJxKZh0p/jfBxS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYnlBBBcY3wdoPrtw6iXcYvQJymPF52fQvTYWmDaZ766EvFsIwBXQD28VruhOyMbY
	 fzat/+dp8uvfXBRjY7HafzX/PobdyoBTTG7Y/VnvrDN1GnsgVKbYlx7oLSy0lw5kws
	 OjYkfoixl8X82WJnxbEe+bJidkaku33uzSfy/xc8SlKMCPRLWlrIhdKZzqmhiZKdAW
	 IRLzhX+WeqffdJ39GGGLGe2jqGosm1RhE4v5NuhrX65TO+UWR2KiVjwVgQJJEd4hL3
	 VIxo3jBr4Em0UNpN6F1i22QaLOTp/5r0SJF7YRc8hVZ4CBUppjf+NB3ty001S+5LTK
	 CeDbvRCB3FOPA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Russell King <linux@armlinux.org.uk>,
	Chaotian Jing <chaotian.jing@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Michal Simek <michal.simek@amd.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexey Charkov <alchark@gmail.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/38] mmc: sdhci-of-at91: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:55 +0800
Message-ID: <20250815013413.28641-21-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250815013413.28641-1-jszhang@kernel.org>
References: <20250815013413.28641-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the modern PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM or
CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/mmc/host/sdhci-of-at91.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 1ba2effaf376..7c4ac65f247d 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -229,7 +229,6 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sdhci_at91_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -243,9 +242,7 @@ static int sdhci_at91_suspend(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-#ifdef CONFIG_PM
 static int sdhci_at91_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -302,13 +299,10 @@ static int sdhci_at91_runtime_resume(struct device *dev)
 	sdhci_runtime_resume_host(host, 0);
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops sdhci_at91_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sdhci_at91_suspend, pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(sdhci_at91_runtime_suspend,
-			   sdhci_at91_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(sdhci_at91_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(sdhci_at91_runtime_suspend, sdhci_at91_runtime_resume, NULL)
 };
 
 static int sdhci_at91_probe(struct platform_device *pdev)
@@ -460,7 +454,7 @@ static struct platform_driver sdhci_at91_driver = {
 		.name	= "sdhci-at91",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_at91_dt_match,
-		.pm	= &sdhci_at91_dev_pm_ops,
+		.pm	= pm_ptr(&sdhci_at91_dev_pm_ops),
 	},
 	.probe		= sdhci_at91_probe,
 	.remove		= sdhci_at91_remove,
-- 
2.50.0


