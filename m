Return-Path: <linux-kernel+bounces-742472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 871B9B0F21E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7937B967E37
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC312E5B1F;
	Wed, 23 Jul 2025 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="jBIAMN3v"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072392E5B21
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753273424; cv=none; b=Ei6YZOzXAKmhTwlHxxzHuH9b02VyrYClxq+xp12xM/MnyGM31+tWynxjyrsNXAL3WGYFdYxAgq4xalYf/SLm8CTisWXIg90m9UqkJM0uxHYSYoI20KQGjYWn+PrZPJf4wPZLsV1abJd9PueoO7xN9I6sB0HXw0cJWj3wipKORF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753273424; c=relaxed/simple;
	bh=d48SEyX6uFg0vX9REauKj4hMLQEIfm88QlaAm4kh32Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqyJ4s+tc8fqpk75coo0cgtQW0tlLZ5l1tqWQ1Uhg8rYlAUFmCLXYrZJ3+Wx6vTYTVlYxQxZuZG9ZX3Behee5iYEuyMc17FEHNdHayqIFH5QuWqc9Qq8Ku/Bobp0eqBgtH0QFUeuL6dzpsvRdUMU/2Im/e+Vheo/oT9LNG6vrUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=jBIAMN3v; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753273422; bh=VrGCDldEDfJlmA3L8IBuQRXGokqWnwHgnzli9QRW/iI=;
 b=jBIAMN3vrYmLvH8U71yItm6xG4BHr6ySCfVKzz69ruBDp/wjewHDMUIeHK+5wfim74vKEOn/z
 bDX5aRAwbcv13bbeL9At6OYM0cyTK1Xxutz5foUDP5fiebJ0oC5DrY+gHKUQOzoIeMydtEkUXk3
 +iRT+os5ZSBJ+0lwSEnl4Fgt36fSER6nDI5dAW+2wL9UT2CtvX3p0pdyKg+GW0q/97PBR1aGgOo
 PfrCU760NXGQRtRAnKLDlJtB0WT1dVoeZqCb31r28wi3kHFVjbKQvF0BHkBInnlRr7ibWeHcs69
 Dxz3DjQ0OHjr/0iAMllkZJDll1U+qGpuR+MX4zFC4Yvg==
X-Forward-Email-ID: 6880d445cb0ee86f9731a05b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 01/11] dt-bindings: phy: rockchip,inno-usb2phy: Require GRF for RK3568/RV1108
Date: Wed, 23 Jul 2025 12:22:59 +0000
Message-ID: <20250723122323.2344916-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723122323.2344916-1-jonas@kwiboo.se>
References: <20250723122323.2344916-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Typically these Rockchip USB2 PHYs are fully contained within a single
GRF. However, for RK3568 and RV1108 regs to control the USB2 PHY is
located in a different GRF compared to the base address.

Update this binding to require rockchip,usbgrf for RK3568 and RV1108 to
properly reflect that the USB GRF is required to control the USB2 PHYs
on these variants. Also disable use of rockchip,usbgrf for variants
where it is not required.

This should not introduce any breakage as the affected usb2phy nodes for
RK3568 and RV1108 were added together with a rockchip,usbgrf phandle in
their initial commit.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../bindings/phy/rockchip,inno-usb2phy.yaml        | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
index 58e735b5dd05..b95c9e3e44fe 100644
--- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
@@ -145,6 +145,20 @@ anyOf:
       - host-port
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - rockchip,rk3568-usb2phy
+              - rockchip,rv1108-usb2phy
+    then:
+      required:
+        - rockchip,usbgrf
+    else:
+      properties:
+        rockchip,usbgrf: false
+
   - if:
       properties:
         compatible:
-- 
2.50.1


