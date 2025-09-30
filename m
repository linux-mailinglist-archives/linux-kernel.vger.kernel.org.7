Return-Path: <linux-kernel+bounces-837623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58537BACC75
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAB03AE624
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD4D2FB0A4;
	Tue, 30 Sep 2025 12:09:13 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B5D2F7AC3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759234153; cv=none; b=IwXg/9mEKLqNE6RlF2YwX+7+l6urTpxbwXNfXwC9RZ8+AD9L6XPpouSB2YjMGljnFt4WMKkzAF+cN4dOyh1X2RNJSigpc05B8EpvDKVqShgn/R1hfnnUalu+zvJo+ZFhVQx4jnAOxH95XjZAfFEqki7C9jCq5Aj5a8DG534AY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759234153; c=relaxed/simple;
	bh=2z2xyS2Gem1UuV6kiHxMR8zC2p9KZzmAWdrhdIiG404=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iL5qg70IfFiwr8d0tnr1NPenfnOAYK9YNdJ5eqIO+Z0HmlQQQtQ1CHCwPzGxhBxb1+QKUGZyekudpS7o3PB6mLZ9RiucvPh1Ewm4adzwyfwInMT18MZQqlFTf0VWmaBOw1isT7bfALlxYWhYxv6SDr5lT4u1oQK5BH1IsPRDNKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v3ZAE-0008O1-WC; Tue, 30 Sep 2025 14:09:03 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v3ZAE-001F1b-2a;
	Tue, 30 Sep 2025 14:09:02 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1v3ZAE-00000009Lkg-364o;
	Tue, 30 Sep 2025 14:09:02 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] regulator: fixed: opt in to downstream event forwarding
Date: Tue, 30 Sep 2025 14:08:57 +0200
Message-ID: <20250930120857.2228296-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250930120857.2228296-1-o.rempel@pengutronix.de>
References: <20250930120857.2228296-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Enable supply event forwarding for fixed regulators by registering the
core helper at probe. This allows critical upstream events (currently
REGULATOR_EVENT_UNDER_VOLTAGE) to propagate to consumers of the fixed
regulator, so users like MMC can take emergency action.

No change for regulators without an upstream supply.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/regulator/fixed.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index c63d57c5bd27..4d520fc94e05 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -348,6 +348,13 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = register_regulator_event_forwarding(drvdata->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable supply event forwarding: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.47.3


