Return-Path: <linux-kernel+bounces-580672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9777A754E2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 08:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6697016CA36
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 07:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C98198A08;
	Sat, 29 Mar 2025 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gMqSk2Sb"
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B399E18BC36
	for <linux-kernel@vger.kernel.org>; Sat, 29 Mar 2025 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743234940; cv=none; b=X0aI2MKnltzrdWaFoE/eveWvLOaLWaZF90wlYH8KHrfEfQO6LVU5A8eU2UiFrBiBepgOSglgNostH9L/aUI5ga28wZ5UItmKxB7f0QY5fjkqA92U5yP0k5v3J+ObgoLKfIbBYw9nNesl2Tw9lJf1zwuEzRMzOues0iSPB3QWh2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743234940; c=relaxed/simple;
	bh=duZT+wz2v9SXSXUndHbCY9Wa4VglcZG5ovPv+XecIc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftJfs4Byooi75viNhDllYnrzpLNY/eSzzsFFyP6vOeBdosC1a0IFRXzv6eqgYGr6d9TP7B4r0ch0XCv+Q2h+U2jK85eXc/hoYOsA7xRlLp9f3UxgPmbG/2hzrYXg2ChLxQElSmZBIeh7YTK8nrD6fTxrCAN9vEGAzlJT27I4oOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gMqSk2Sb; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id yQtAtsN3Ol9slyQtbteVkC; Sat, 29 Mar 2025 08:46:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743234384;
	bh=388xrznfvx3yUimg5kNws/DNZuCQE1j80sB1rbo3xPc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gMqSk2Sb96QmihcEfm2HH+vPYGVUcku53uvdvYXABZH++CMEHLYHCGS41nAOtVnnx
	 hdyCnNSeMgSTKbDo0nmbONgBqUrLnruKolB7Coxuy+XgG4J0Csg1vAd7+ll5rte7hI
	 DIXcQva1JvEQL8EjYqZiP80ZnqjZa/sf3rFqMCZZ0IxAYheyrfpOTNXxe81LbG/LE7
	 Te4kQ0JvtSWczjdjEoFS3qzrlVba4EXxKUgoj53l71j3b5KwrSpCi2AhIjqczF7C2H
	 YF9yRqYzzb5RaMTSgWtnZ+l0N0vZFBVGc0uNLf/91tG0HuMbKEZMSnG/Dr44kf5Mti
	 YujWgPBiN4FMw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 29 Mar 2025 08:46:24 +0100
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
Subject: [PATCH 4/4] mfd: exynos-lpass: Fix another error handling path in exynos_lpass_probe()
Date: Sat, 29 Mar 2025 08:45:48 +0100
Message-ID: <d224865a16b50498279b044a819e1e187d01bb28.1743231856.git.christophe.jaillet@wanadoo.fr>
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

If devm_of_platform_populate() fails, some clean-up needs to be done, as
already done in the remove function.

Add the needed error handling path.

Fixes: c695abab2429 ("mfd: Add Samsung Exynos Low Power Audio Subsystem driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/mfd/exynos-lpass.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 7fd8585ba35a..9f2601e4e583 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -118,6 +118,7 @@ static int exynos_lpass_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct exynos_lpass *lpass;
 	void __iomem *base_top;
+	int ret;
 
 	lpass = devm_kzalloc(dev, sizeof(*lpass), GFP_KERNEL);
 	if (!lpass)
@@ -143,7 +144,15 @@ static int exynos_lpass_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	exynos_lpass_enable(lpass);
 
-	return devm_of_platform_populate(dev);
+	ret = devm_of_platform_populate(dev);
+	if (ret)
+		goto err_remove_exynos_lpass;
+
+	return 0;
+
+err_remove_exynos_lpass:
+	exynos_lpass_remove(pdev);
+	return ret;
 }
 
 static int __maybe_unused exynos_lpass_suspend(struct device *dev)
-- 
2.49.0


