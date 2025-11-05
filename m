Return-Path: <linux-kernel+bounces-886175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C9FC34EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFC9A4FCDC6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A481D3043AD;
	Wed,  5 Nov 2025 09:39:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBC02FF665
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335578; cv=none; b=Lk210/LHGqd5RBn9ACbqElFMeVQDTbQvdW+JGQSAhpLR/VmR4/cu3B22cSumOY8EFqW+NrhnQ0NvIBIJCPe5I2ivr7r8OTHuwq4JJ6GTqA0icm5zuvGTlGtYvnx0n2oQ33HHk5DMXCGxdlpdl7LZYuJpgrIkDH3h0/TwnSx81D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335578; c=relaxed/simple;
	bh=/xJb15nXloWY1fpkvsG2pfi30jLLBzk4yjkiy7n2T/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGcMzY5kKXniXJRzu19yMQ1mSqmQ/cfYoHPyOge4epTW2yD2FYssMXcA6T3klz0SjQi8rVk7mB2asJSlteUWmOikZNNSh4fFZYGMWdIzpt4gv/1IJHykbHPAoeSf8MVoddG3QWY+R1zqgHE6fKQyyXbWDaeUBNOHAD4HF7YfyTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1vGZzC-0003Pt-GD; Wed, 05 Nov 2025 10:39:26 +0100
From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	kernel@pengutronix.de,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] Revert "reset: always bail out on missing RESET_GPIO driver"
Date: Wed,  5 Nov 2025 10:39:20 +0100
Message-ID: <20251105093920.2345333-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This reverts commit 25d4d4604d01eb0ce5254f0516826127dacb5015, which
caused unexpected fallout:

Drivers that handle optional reset GPIOs via the reset controller API,
on platforms that have a reset-gpios property in the device tree node,
would fail to probe instead of falling back to either ignoring the reset
or handling it via the GPIO API, if the RESET_GPIO driver was disabled.

Suggested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 4fbaa67a6f79..8029e547e3db 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -1001,6 +1001,9 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 	if (ret == -EINVAL)
 		return ERR_PTR(ret);
 	if (ret) {
+		if (!IS_ENABLED(CONFIG_RESET_GPIO))
+			return optional ? NULL : ERR_PTR(ret);
+
 		/*
 		 * There can be only one reset-gpio for regular devices, so
 		 * don't bother with the "reset-gpios" phandle index.
@@ -1010,11 +1013,6 @@ __of_reset_control_get(struct device_node *node, const char *id, int index,
 		if (ret)
 			return optional ? NULL : ERR_PTR(ret);
 
-		if (!IS_ENABLED(CONFIG_RESET_GPIO)) {
-			pr_err("%s(): RESET_GPIO driver not enabled, cannot fall back\n", __func__);
-			return ERR_PTR(-ENOEXEC);
-		}
-
 		gpio_fallback = true;
 
 		ret = __reset_add_reset_gpio_device(&args);
-- 
2.47.3


