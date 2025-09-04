Return-Path: <linux-kernel+bounces-801467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 017B9B4454D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC04B175D70
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C9C343214;
	Thu,  4 Sep 2025 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K85Qajxb"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD7342CAD;
	Thu,  4 Sep 2025 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010374; cv=none; b=euuKVrCyxDrYk6LfhadVYfmvIBOiOceJlKRC+r2THbVIr5nKazdAYD3VdpdLUgAshvq4BG4EgORGIzadE54PoKsYcZ8nfa2L4uD1kRAsgNpV8x8tIZx2CmFrQwA70x2hC72ydA7PoC7QBJqa9BGrnqAACSUyBGq/7tQxCajcuOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010374; c=relaxed/simple;
	bh=xYV/jhtksKq4lVUs85jfHk2X62icSbuXC1EZccF5b3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LvxLKkKXZ5Td74Zk+BDpoRvGOMz/Ta+ANbDkgijTSlDOkuYmHIj2mESxsdYeuMkDAmjDMkHgqr8Sr9FyNe6f3P2VjxdFKsQbZAK4X0ZknE5TnCwkWicq8eg4nlu26FglVuR45fbcYuckWvA1kzFZ054yG6migmLxpo0frP7MzNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K85Qajxb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757010370;
	bh=xYV/jhtksKq4lVUs85jfHk2X62icSbuXC1EZccF5b3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=K85QajxbTBd2Ihz0ZcqdrCig0I/7kyxGnXAwoDvP0lyaOHG16x18uUoz8aLMQxmFV
	 DnMRoThOmbrQ8vHm+f8QMeoxncUQ/1W8kGAFaYKy0OFjbV1box0ouyG93X4uQj/LSP
	 8HwN8dpdSrTDyk4Ez4HPey9nUuD0jQ0PD9hxTeu4JH1nmbEbdHOwFg8ZlTwzFNGy4D
	 S5h8MDwWOR4wg5nw2X881aTrvcuGzvtxvcLf9ubqGgy376mr2sXfUvYBqsDIJ3YahS
	 vX0Y/pI6Ii1vBwzqkVII0c3VCgUIf7XRCPnEowJOg2401SetEfvKM1yibj2r/sSPdX
	 RcZMesB184t/w==
Received: from jupiter.universe (dyndsl-091-248-191-002.ewe-ip-backbone.de [91.248.191.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9813117E10C8;
	Thu,  4 Sep 2025 20:26:10 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 3EEBF480041; Thu, 04 Sep 2025 20:26:10 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 04 Sep 2025 20:26:02 +0200
Subject: [PATCH RFC 1/2] dt-bindings: phy: rockchip-usbdp: add improved
 ports scheme
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-rock5b-dp-alt-mode-v1-1-23df726b31ce@collabora.com>
References: <20250904-rock5b-dp-alt-mode-v1-0-23df726b31ce@collabora.com>
In-Reply-To: <20250904-rock5b-dp-alt-mode-v1-0-23df726b31ce@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Frank Wang <frank.wang@rock-chips.com>, 
 Zhang Yubing <yubing.zhang@rock-chips.com>
Cc: Andy Yan <andyshrk@163.com>, 
 Maud Spierings <maud_spierings@hotmail.com>, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2234;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=xYV/jhtksKq4lVUs85jfHk2X62icSbuXC1EZccF5b3I=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGi52cLhj3jKlAVRnMAW3LugrZurm8z0D9P/V
 RrhnhbRafEXUokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJoudnCAAoJENju1/PI
 O/qaOhYP/i2I1Ced4+um4xbadx4569zlypDyvVfIQP8me5BtiZAX3WbjxXSJQLHHu3zwDtbJ3t6
 4vQ3u5uJpqHyKk13qeFyfzhcXKFCSvrcEvyFJyCGJzCOjZr12Bc2Z6Im2xP2V3GX3Hy2K1Ofj0Y
 sj71gpzf6ZoqUnrGdQ+qq+s89Bh1RtcghRo/TGT4QTuadsKzhl0RcmIV3MBi1QfC8JiqE4nSds5
 QwdAZgSB0pCZ4DuK7rI4pfL9X8P2qNjUzS5bJBinS5+ZD290kBQnqUTXvEQgiz3T8Lw1ycpGy81
 qK0ijINMkwXT5apiLa02leLZLFf7yg9k+H5VEtLxSMQBQXiD2eMgAVZRtwVocIptadh4C2e2BgH
 sgsKa5KXDhPxFWF/iQ+2l8YUEmiNuLFXGBpIFBDYIvRGTqt41khcOgBQWDeWWZFQM9gOTLDQ9jg
 /Byz5XBT85pAQVqBSNsqtTVl+f8wSjbKL0a8lSU9dV/QJvTOoX8Oq1MhxnFVcoxANjzbbUYWtLR
 6Hpjtx2L9RXltUi0bEs3PDifkcTJTWr47qFN617uQ3AaKEGoMo48THtX+te4LX0R60SzfEwNWfz
 OaDfdKP//w90lwNx+JB+nqQKke3BzXDJJClFiIUX6C0OxuSOvE3ilDmoN8W2SjN49Kmsd8fWi4a
 Atafc3j3sv3sdSI6SdbU0xw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Currently the Rockchip USBDP PHY as a very simply port scheme: It just
offers a single port, which is supposed to point towards the connector.
Usually with 2 endpoints, one for the USB-C superspeed port and one for
the USB-C SBU port.

This scheme is not good enough to properly handle DP AltMode, so add
a new scheme, which has separate ports for everything. This has been
modelled after the Qualcomm QMP USB4-USB3-DP PHY controller binding
with a slight difference that there is an additional port for the
USB-C SBU port as the Rockchip USB-DP PHY also contains the mux.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../bindings/phy/phy-rockchip-usbdp.yaml           | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
index 8b7059d5b1826fdec5170cf78d6e27f2bd6766bb..f728acf057e4046a4d254ee687af3451f17bcd01 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-usbdp.yaml
@@ -114,6 +114,29 @@ properties:
       A port node to link the PHY to a TypeC controller for the purpose of
       handling orientation switching.
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Output endpoint of the PHY for USB (or DP when configured into 4 lane
+          mode), which should point to the superspeed port of a USB connector.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Incoming endpoint from the USB controller
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Incoming endpoint from the DisplayPort controller
+
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Output endpoint of the PHY for DP, which should either point to the
+          SBU port of a USB-C connector or a DisplayPort connector input port.
+
 required:
   - compatible
   - reg

-- 
2.50.1


