Return-Path: <linux-kernel+bounces-580671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE8FA754E0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 08:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AD43B0301
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 07:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CE219D8A0;
	Sat, 29 Mar 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="a7IGOrxC"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8B18BC36
	for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743234914; cv=none; b=VCX4b9jJYIrtGiyPkZrEHSqvZX++qP+nkFYAjnoRQA52tvBruRh/D2wvBdctLID7lW8BkBYw7fGovovECS65wp/HjNgTUomUENsdqIuT0O609WKrJHirNAU3/yT2ukWg9UKgrVY9nFlISM4T4oE+B56MiFA6o4pgIAjbCnskRyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743234914; c=relaxed/simple;
	bh=gdAiGcHA9ACA8gEU5ZV3breg3WLc8uWPyOoly+XVgws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gp/j6DZfIEmYcXNXnmmzAqLryFkCI5UdfHWjHAf6lGkIAYCXJ1eubd9rDrttx80ABfRr7l2apfFNiMDGXFdvi1X1V+XDtDXctxhIpPKeASyj4K0HxQqSZ3Xq4Ae+stqbGdyrYH8SkuvN4/t29BPFEnHT8DezVaDxclxIJ+QtGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=a7IGOrxC; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id yQtAtsN3Ol9slyQtPteVWL; Sat, 29 Mar 2025 08:46:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743234371;
	bh=lxG5GpmIEqwoUGwr9bKBwNL+mtU3l6sCszbqj7Kxf5k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=a7IGOrxC3ED9Gj0NKMZBuUpb3nmtMAW5WTnV5xDlQida/pNILs6MYQAfcCUYl8jQM
	 HfhLvVpPiVOa65RHj8V97d82otML7mK/Agj6jM1g/GbYix2BhHCk06AmNZ8ZS35N5E
	 i0Dab7gM3eqHYuAHh0pQqEMy1EACDJ5TR0cGvsM2laAi16LGag3xSdGI5o8VZHs0ie
	 dblxMUNIl8nkxDiCiftaPx+yCk1iz3XGYyl+xaym2Xr0XQxjy7grz0hFjFLpxsgIs2
	 LvU6T4Yfs1eeXMX1tRVZeX1eq849X2xJbjUH8TVGamh+KvvSL4s/mHXcYiD4Duknyr
	 ALJWB3QkNN4OA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 29 Mar 2025 08:46:11 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: lee@kernel.org,
	krzk@kernel.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	beomho.seo@samsung.com,
	ideal.song@samsung.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/4] mfd: exynos-lpass: Fix an error handling path in exynos_lpass_probe()
Date: Sat, 29 Mar 2025 08:45:45 +0100
Message-ID: <d125cbc479f1fa838ed0ff25f0e11d25f382e9d4.1743231856.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743231856.git.christophe.jaillet@wanadoo.fr>
References: <cover.1743231856.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an error occurs after a successful regmap_init_mmio(), regmap_exit()
should be called as already done in the .remove() function.

Switch to devm_regmap_init_mmio() to avoid the leak and simplify the
.remove() function.

Fixes: c695abab2429 ("mfd: Add Samsung Exynos Low Power Audio Subsystem driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The .remove function was added in commit c414df12bdf7 ("mfd: exynos-lpass:
Add missing remove() function")

Compile tested only.
---
 drivers/mfd/exynos-lpass.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 6a585173230b..6b95927e99be 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -122,8 +122,8 @@ static int exynos_lpass_probe(struct platform_device *pdev)
 	if (IS_ERR(lpass->sfr0_clk))
 		return PTR_ERR(lpass->sfr0_clk);
 
-	lpass->top = regmap_init_mmio(dev, base_top,
-					&exynos_lpass_reg_conf);
+	lpass->top = devm_regmap_init_mmio(dev, base_top,
+					   &exynos_lpass_reg_conf);
 	if (IS_ERR(lpass->top)) {
 		dev_err(dev, "LPASS top regmap initialization failed\n");
 		return PTR_ERR(lpass->top);
@@ -145,7 +145,6 @@ static void exynos_lpass_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		exynos_lpass_disable(lpass);
-	regmap_exit(lpass->top);
 }
 
 static int __maybe_unused exynos_lpass_suspend(struct device *dev)
-- 
2.49.0


