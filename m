Return-Path: <linux-kernel+bounces-871579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E557C0DAF8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F42C4FCE3A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B691430F93C;
	Mon, 27 Oct 2025 12:44:26 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0EE30F7E3
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569066; cv=none; b=YtSOYSTSspTub7bqL9k1MgFUcsxC/UNSrqC9LiBKkN/d1J4OtgmSNHU3u2NESTzihgjvq13O0aYhaLDLVzL3HXLAlJuVZxd8TY/av/lmGw7UcgKs2wHXRHCC7cpKRc/+Buh3K5pO3BvIm6XT1uyMTY7FhKJ/k+s/2SY5HO1V9As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569066; c=relaxed/simple;
	bh=ofzwrrbpUXj9+VPZYYc9UCNL2vP0exyZw44cg/jrA9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EClTk3PriCXV3bhHvkJMrqF2uIj4zzA+B0NaIbAbw5yAwoPnWbEA8Eqnxfy8WKFdkKXOu1Mn31XHc0dEF7nrRWERitYHCKb7cPclidglhSKH1KX7d8DTWmKWA8IuspXl1tJ0AffriekgzHa0BmD+GxfPk1fgDjS9FWJSkWTxwUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMa8-0007PN-DC; Mon, 27 Oct 2025 13:44:16 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMa8-005htS-0R;
	Mon, 27 Oct 2025 13:44:16 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vDMa8-000000049NI-0HZ2;
	Mon, 27 Oct 2025 13:44:16 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robin Gong <yibin.gong@nxp.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: regulator: nxp,pca9450: document input supplies
Date: Mon, 27 Oct 2025 13:44:14 +0100
Message-ID: <20251027124415.989301-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027124415.989301-1-o.rempel@pengutronix.de>
References: <20251027124415.989301-1-o.rempel@pengutronix.de>
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

Add missing supply properties for PCA945x input pin groups:
- inl1-supply (for LDOs)
- inb13-supply (for BUCK1/3)
- inb26-supply (for BUCK2/6)
- inb45-supply (for BUCK4/5)

These properties describe external power sources for each input group.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../bindings/regulator/nxp,pca9450-regulator.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
index a5486c36830f..863717984a79 100644
--- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
@@ -41,6 +41,21 @@ properties:
   interrupts:
     maxItems: 1
 
+  inl1-supply:
+    description: Regulator supply for the INL1 pin group, powering LDOx
+
+  inb13-supply:
+    description:
+      Regulator supply for the INB13 pin group, powering BUCK1 and BUCK3.
+
+  inb26-supply:
+    description:
+      Regulator supply for the INB26 pin group, powering BUCK2 and BUCK6.
+
+  inb45-supply:
+    description:
+      Regulator supply for the INB45 pin group, powering BUCK4 and BUCK5.
+
   regulators:
     type: object
     description: |
-- 
2.47.3


