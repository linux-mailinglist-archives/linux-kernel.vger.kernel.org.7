Return-Path: <linux-kernel+bounces-767384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF3EB253AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD573A89BF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8602FFDCA;
	Wed, 13 Aug 2025 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="OavCC8Ll"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619892BF016
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112028; cv=none; b=kTPD+kvNw/APXtD9I8sIVswFk65o33LmzFwGGZiZjD0IzEOGVZjr632sAALp9GPB1++/pSRGZqS4crynht2fdwqAYoTKRUm9JfyFgxTdz7xT+HsFjkwzxTenYh07PVtH+Ed2Jgymc5LdA+9FDO3KFS3cvBTsnjVbhQkJi2pT6I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112028; c=relaxed/simple;
	bh=SXOksErSWrCg3g7862V1L2s5ZhMbzgX1mzW405r3WH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BdQ71fhpZl4oVv/AdTsRuiOVd/PUiSxhcr5zrxzpodr/sbEgTXZIqhu6K06/Tk3j0NBqUDmLUPBzQ2E+2691hNoGXddMCDsp63sjDDHybid+YyBfIWAYPCyixskLTG9XVZgq2MEwseOVDgs1qEVJcgeQxOhy512bk+WMfXRGaBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=OavCC8Ll; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=Ejth9SW7Cq2Pib
	I98quiVFxWB9ohLsN0xTesctVUDq8=; b=OavCC8LlExNbi7VBkXN2LRJpHN4KXN
	TWQUfxTFnqQ3Iu/XA35fbo1EBAD4+AzRsL9F6srcgYJvdt9LbH7JJ8wtNce5tpa0
	PRZl901oaQQ1osKFGMoQXczmYHTqbr6g2eUXA3U3uxnLC/1wYB5Cq0WZbjBZnqxi
	SaeRKOvq/Iu0v2L20vnP3uogCytumt1/ZWPJ3H4so+I+hkPVFUbBEku1TBq5nFbQ
	GhNRuJSbq2rTifK7Yn3ucbJRglus8DzqDKexuaA1hb+qNc9EKIr+Suxf244o4zPF
	kSrvKSQIRl5Yjws50bNAu3d+nf1UJoBcOCn1cjDgypfkS7NGPRbvS1dg==
Received: (qmail 733111 invoked from network); 13 Aug 2025 21:07:04 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Aug 2025 21:07:04 +0200
X-UD-Smtp-Session: l3s3148p1@AXO03EM8tO1tKDDX
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-tegra@vger.kernel.org
Subject: [PATCH] clocksource/drivers/timer-tegra186: don't print superfluous errors
Date: Wed, 13 Aug 2025 21:06:58 +0200
Message-ID: <20250813190657.3628-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The watchdog core will handle error messages already.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/clocksource/timer-tegra186.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index e5394f98a02e..b40d7ed37936 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -328,16 +328,12 @@ static struct tegra186_wdt *tegra186_wdt_create(struct tegra186_timer *tegra,
 	wdt->base.parent = tegra->dev;
 
 	err = watchdog_init_timeout(&wdt->base, 5, tegra->dev);
-	if (err < 0) {
-		dev_err(tegra->dev, "failed to initialize timeout: %d\n", err);
+	if (err < 0)
 		return ERR_PTR(err);
-	}
 
 	err = devm_watchdog_register_device(tegra->dev, &wdt->base);
-	if (err < 0) {
-		dev_err(tegra->dev, "failed to register WDT: %d\n", err);
+	if (err < 0)
 		return ERR_PTR(err);
-	}
 
 	return wdt;
 }
-- 
2.47.2


