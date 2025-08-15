Return-Path: <linux-kernel+bounces-770474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8998AB27B45
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C921CC2E59
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889F92D0C88;
	Fri, 15 Aug 2025 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+8I6vEB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF07423ABBB;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247062; cv=none; b=CKNZ+BHvzAt1zM9FwyswaNRC4ioD5j0TYiz+ppNkiukhAQ/Uisg+hcQQVKTVUbYMmpmvV3GEjinURjV1GictZYvpxVbVnYnqX2sRM8OKTyIU72wM4Fh+7hb6KVmoAGB/dcgZI4qDuODRAfQa3l7jhrMHtXb1cO/TFEsIlzYoWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247062; c=relaxed/simple;
	bh=nCRulO6K/H4lFvEhCNrgEuQoW1aO9yFrduMC+IOo29c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hXiQsnqOIugMAz5kHl0oSKnmVC2oyJ1IXmgr+GCisy4Gsvndt7zc+UST8HhkwZXFUcBOn1hcBrmJPuaoFNhRKc2g8KKaHdg/sZzd3YNkKssWIK5qTBCcaU3XbWj0qWcjW5k+pZgd6kiAOP39QDJRFch22gbYk+4+tz2OY6q4fo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+8I6vEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E585C4CEFD;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755247061;
	bh=nCRulO6K/H4lFvEhCNrgEuQoW1aO9yFrduMC+IOo29c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b+8I6vEBUOUM7Yt4lOsrIUfyux0sPT5VzNi9AGq+wOuC9W/F3hv14/aiZm6CgvU4+
	 JQFLnMQE1aMo8T7uKT4XE+DStdC55xYhPa2PeD7sbw4p3MjS6yHwlT3dJD8DlzAkBk
	 XCtoD4nZqVjevEzMNQf8McXCVLAPAcqLBvny9WWxI0eguvL/eTZTsYvg8ejy+5HKCX
	 PzRKw3dKJtYcCH7lMgdBx96B30F58kUEu9TVSeOn/2iindnnn1BWvaMSHwLk5vNPXF
	 QtINd/Sumxu/ifaNFiPD5X5+zWsEScA8QCM0DozfcWt5CTQWhdIlfNwvctqVuc8al3
	 r7dtq10yQ9zaQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E89CA0EE9;
	Fri, 15 Aug 2025 08:37:41 +0000 (UTC)
From: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>
Date: Fri, 15 Aug 2025 16:37:31 +0800
Subject: [PATCH 05/13] dt-bindings: soc: amlogic: Unify the compatible
 property for clk-measure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-add-more-socs-to-support-clk_measure-v1-5-59f04ba67457@amlogic.com>
References: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
In-Reply-To: <20250815-add-more-socs-to-support-clk_measure-v1-0-59f04ba67457@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chuan Liu <chuan.liu@amlogic.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755247057; l=1771;
 i=chuan.liu@amlogic.com; s=20240902; h=from:subject:message-id;
 bh=WLsFB3kZYI5SRTtCiEJNIQMGbbEEbhu5OiVfqIrbRCU=;
 b=15BeFKwtMUW4Xf1NqNuNqnhEhMKHY/rAApALIEl3odOLL/43sqwREMcPMGqW3A7x/6AJvI4oR
 U3KLtA0rnWGCvCtUm3EXXlqWfXYYS9nC2B8xxigjirG1/dmavcx3I62
X-Developer-Key: i=chuan.liu@amlogic.com; a=ed25519;
 pk=fnKDB+81SoWGKW2GJNFkKy/ULvsDmJZRGBE7pR5Xcpo=
X-Endpoint-Received: by B4 Relay for chuan.liu@amlogic.com/20240902 with
 auth_id=203
X-Original-From: Chuan Liu <chuan.liu@amlogic.com>
Reply-To: chuan.liu@amlogic.com

From: Chuan Liu <chuan.liu@amlogic.com>

The clk-measure IPs across Amlogic SoCs have minimal differences, so
they can be managed with a unified compatible property.

Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
---
 .../bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
index 1c9d37eef5f0..a7927acde2fe 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-clk-measure.yaml
@@ -15,15 +15,7 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - amlogic,meson-gx-clk-measure
-      - amlogic,meson8-clk-measure
-      - amlogic,meson8b-clk-measure
-      - amlogic,meson-axg-clk-measure
-      - amlogic,meson-g12a-clk-measure
-      - amlogic,meson-sm1-clk-measure
-      - amlogic,c3-clk-measure
-      - amlogic,s4-clk-measure
+    const: amlogic,clk-measure
 
   reg:
     maxItems: 1
@@ -67,7 +59,7 @@ examples:
      * offsets.
      */
     clock-measure@8758 {
-        compatible = "amlogic,meson-gx-clk-measure";
+        compatible = "amlogic,clk-measure";
         reg = <0x8758 0x10>;
         clkmsr-indices = <0>,
                          <1>,
@@ -82,7 +74,7 @@ examples:
      * Example 2: clk-measure uses V2 version register address offsets.
      */
     clock-measure@48000 {
-        compatible = "amlogic,c3-clk-measure";
+        compatible = "amlogic,clk-measure";
         reg = <0x48000 0x1c>;
         clkmsr-reg-v2;
         clkmsr-indices = <0>,

-- 
2.42.0



