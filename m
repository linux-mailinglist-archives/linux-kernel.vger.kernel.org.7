Return-Path: <linux-kernel+bounces-722431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD79AFDA75
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A2AD7AAAA2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB7524E4C4;
	Tue,  8 Jul 2025 22:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="QXRHR7qJ"
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A8D23ED69
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012262; cv=none; b=WKb2JGIRPcBhTAa/qhLiQ0mQnBqh9FvIBEfVWiLzqg6i9N7Q/7b//6RWVgRdfhk3eDNwNwEMh2+BIa6qPj9fSd+mqf86iXfK/YpfjYe0CaWnriatlkGe+op57LPysl2XYzdVBWfTuZwGJzcBOFdIomTGHT4Lr1MedSteMrbM1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012262; c=relaxed/simple;
	bh=JEwjDFc86PrkewUj6jreBP+U0UYWAlrwDl5oWy0MiqM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F66ESiuutJi/+AG2QZjuuGjIs3GSxnbUX9tA6uDeoZGiOG+7m5HkrospFR6nK1zIe0lwAIrFIYlGAzDFtnjrCLv186yVYXgxpTLIk6mZHPAmCxXysOb6C9oNQ15jWAiewAhyXKBk4pP+fnaLaoLCqNxYS4uxCdn0ivw1U+elzSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=QXRHR7qJ; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 8905 invoked from network); 9 Jul 2025 00:04:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1752012250; bh=7zoO974m1IZgYR3D++13RTWoZ8Kdq6ybz200zav34PI=;
          h=From:To:Subject;
          b=QXRHR7qJJvAHQZdMNvlf/AyebVRU2/hfT/WxggoNBkAjDF18RcjFIYu57JoqrgVLr
           VZMZqOj8FsxM4bOG8MzsT1wZ3pAQ9QyZ0ozo+cy+iOfVXSIAs+FwSHVDNj/+/4CS4R
           uLui1CBCj+lrmJScrQaQjxXGRUSHrB5+QVCi0tsDOchZLUgqej2cK8tgBmOmACe/6H
           5Vv4184pQaIfRaDIWaopmPi75gAaR8uvi6EINO3y9Z40H8NKsu/hJ+Xu1fxAg6qkAJ
           vnx75Wh0PF27JArkiOr2uu7ERdXWmlIHiu42yRLPgn8EPPPKwvctMEIGqFaTgexeFt
           ngQ/k7zJ9P7dw==
Received: from 83.24.138.239.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.138.239])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <rafael@kernel.org>; 9 Jul 2025 00:04:10 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	s.hauer@pengutronix.de,
	olek2@wp.pl,
	zhiyong.tao@mediatek.com,
	linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 2/3] dt-bindings: thermal: mediatek: add falback compatible string for MT7981 and MT8516
Date: Wed,  9 Jul 2025 00:04:04 +0200
Message-Id: <20250708220405.1072393-3-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708220405.1072393-1-olek2@wp.pl>
References: <20250708220405.1072393-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 30c928d7f745ab1bbbf0f926fc259679
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [gXKh]                               

The ‘mediatek,mt7981-thermal’ and ‘mediatek,mt8516-thermal’ strings
aren't definied in the driver. Both should have fallback compatible
strings. This commit fixes this issue.

Fixes: 788494ba0999 ("dt-bindings: thermal: convert Mediatek Thermal to the json-schema")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 .../bindings/thermal/mediatek,thermal.yaml    | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
index d96a2e32bd8f..1c10d7adc77a 100644
--- a/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
@@ -20,16 +20,23 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt2701-thermal
-      - mediatek,mt2712-thermal
-      - mediatek,mt7622-thermal
-      - mediatek,mt7981-thermal
-      - mediatek,mt7986-thermal
-      - mediatek,mt8173-thermal
-      - mediatek,mt8183-thermal
-      - mediatek,mt8365-thermal
-      - mediatek,mt8516-thermal
+    oneOf:
+      - enum:
+          - mediatek,mt2701-thermal
+          - mediatek,mt2712-thermal
+          - mediatek,mt7622-thermal
+          - mediatek,mt7986-thermal
+          - mediatek,mt8173-thermal
+          - mediatek,mt8183-thermal
+          - mediatek,mt8365-thermal
+      - items:
+          - enum:
+              - mediatek,mt7981-thermal
+          - const: mediatek,mt7986-thermal
+      - items:
+          - enum:
+              - mediatek,mt8516-thermal
+          - const: mediatek,mt2701-thermal
 
   reg:
     maxItems: 1
-- 
2.39.5


