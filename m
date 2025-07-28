Return-Path: <linux-kernel+bounces-747840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9481EB138FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A431C7A9982
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145F921CC5A;
	Mon, 28 Jul 2025 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="AN3F9qHU"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A028FD;
	Mon, 28 Jul 2025 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753698697; cv=none; b=WPcuQKSUSqye7lHBtmOh2zzqpFwEVWmVJLdutOX1cHFnd+ttUCoHsHCe/c64sOdGhJi7KqzUka283FGt28qdOC9DS2oDoSsXpGr7ZY1a1I81+pELLh1L5vMmfdiD8wM6L2WRRK7i13VGk/MCXmLRmMsLAdGYP9MM0YNdmNiAfk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753698697; c=relaxed/simple;
	bh=71Nflu6ZSpSla06ibWGymwe/vOoXdf0KH4ceGapV22M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaOWJEMzidHlZQlNZVY1K9g4XQXjKmkpcSz5h5gZYLOA8FBhrMEXT3MKDczVTm7Kjs1QMmw/hslYkZvxB1WThHrLI2R9QPnPHIVOaCrjlvZe9GMWWCwBHLnW5rosv9pMM8UIo6NfXV9hpZU+loDYXC6U2J0cyhRHul17fUdVMiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=AN3F9qHU; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 94C6B20937;
	Mon, 28 Jul 2025 12:31:34 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oeKHiVJoWaZv; Mon, 28 Jul 2025 12:31:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753698691; bh=71Nflu6ZSpSla06ibWGymwe/vOoXdf0KH4ceGapV22M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AN3F9qHU7kxzi0BCj8fvL5CbV0+7N/rLjp0497l7VSsSd1BUNN3/98Dd8nuCqww+K
	 U3y4k5eW6XPqw9/yQfmuE0/Ql+eh1jvDm/DdbNMFruRn6bQvOU/yDLjFQHd+x0fsdO
	 gTKkuop+/qpc2+aKlG3RZgxPwk85eoVcLwO4lZI48YnJyX71w1ijgkxfmRqP+hMUJI
	 eWpK3DogH+Mi8dREBvX/z8VRt2IQsex1634ZRBKarCIW9O6ssmVlqP4w6z1cRM6kT0
	 zBNof9+S1JJPJWpLLBrXrinAVDUAbZ2sE9QW1VSON28D4Yws4l+kDMfanZN7bLmLxh
	 SuqvoEOEREcgQ==
From: Yao Zi <ziyao@disroot.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Yao Zi <ziyao@disroot.org>,
	Frank Wang <frank.wang@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Jonas Karlman <jonas@kwiboo.se>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 3/6] dt-bindings: phy: rockchip: naneng-combphy: Add RK3528 variant
Date: Mon, 28 Jul 2025 10:29:45 +0000
Message-ID: <20250728102947.38984-5-ziyao@disroot.org>
In-Reply-To: <20250728102947.38984-2-ziyao@disroot.org>
References: <20250728102947.38984-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK3528 ships one naneng-combphy which operates in either PCIe
or USB 3 mode. Document its compatible string.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
index db293d2fbf1a..379b08bd9e97 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -12,6 +12,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - rockchip,rk3528-naneng-combphy
       - rockchip,rk3562-naneng-combphy
       - rockchip,rk3568-naneng-combphy
       - rockchip,rk3576-naneng-combphy
@@ -108,7 +109,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: rockchip,rk3588-naneng-combphy
+            enum:
+              - rockchip,rk3528-naneng-combphy
+              - rockchip,rk3588-naneng-combphy
     then:
       properties:
         resets:
-- 
2.50.1


