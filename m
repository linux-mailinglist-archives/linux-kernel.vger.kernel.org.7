Return-Path: <linux-kernel+bounces-735096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E477B08AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9211B1669F3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6E929B79B;
	Thu, 17 Jul 2025 10:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="LRNLI7xm"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C34299A83
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748684; cv=none; b=LgMvcaiMH7dfPtcug2Y9lLv3rSsD87DPTwwjirMDbopm3y2CpW9H8Hog4R3pct3jpt5ptok1S0HxSD7Fts042XoPOWjO2e3b572sZTGKH2zOBN+ITNThtVN2KRukpPeal8Sezq82upgV9Bbn/nSemtrc0JWbxyf2LszuBS/kVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748684; c=relaxed/simple;
	bh=662KHiIUQ31wzJBD2XKShR8YstdvK6ZN0fV8y2HLooo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/0yYGQIWJ2LPh3zeeXGluRMsllXbgLDIUAx7FMYXh0uLeLMN5teFgxE1NKIxIGIz7VZBsBMfPiyO37PVVFVjLfLoCsXGtgFn0DTlM0QRWxHz7o4QzJ1Y27TBF3bJKLIsaqXskBt2g8OT3VlFMAWsfA/2GzxHd8VQbgDIjUAM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=LRNLI7xm; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752748676; bh=k7+9NHA8uHKcSqN4ck0qSZ7hO6Im2rYR1f73RFBsaas=;
 b=LRNLI7xmhC2Wyu66lCG+AZ/U66/cZBe11HZiYDStjjJAf8DN3ffBSqfG+TlqogsBLo9Ljky/x
 Bz4STv3vrw5bXqeY2dU1EDB9hj2ED1MGwlT/xvJTckcDWiUAJCnu8xskHM6W5dNXogWEecECWuU
 k9FPLma1NuKfQJu8GezcsFpsYGQtTL1Fk/iJmM6o41Rgbj8uVIZYhRwjJF8Hggjd722Ouyt4c1V
 7MnLaWUq3qspdLnLY2fAZTAu1fxdbVrkUouuI/gPV8SsXnkMEpWHVHDV3g6XRFZoo0ob/4BmUYk
 Vtpv31KUV4WEJxxkU7WqgNYCa5H+f81BfVEQ1rAyj20A==
X-Forward-Email-ID: 6878d27c5e51505848fe6067
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
	Conor Dooley <conor+dt@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 5/6] dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
Date: Thu, 17 Jul 2025 10:37:07 +0000
Message-ID: <20250717103720.2853031-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717103720.2853031-1-jonas@kwiboo.se>
References: <20250717103720.2853031-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NanoPi Zero2 is small single board computer developed by
FriendlyElec, based on the Rockchip RK3528A SoC.

Add devicetree binding documentation for the FriendlyElec NanoPi Zero2
board.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v4: No change
v3: Collect a-b tag
v2: No change
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 43f6403ecad6..e3d3d483de4a 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -325,6 +325,11 @@ properties:
               - friendlyarm,nanopi-r6s
           - const: rockchip,rk3588s
 
+      - description: FriendlyElec NanoPi Zero2
+        items:
+          - const: friendlyarm,nanopi-zero2
+          - const: rockchip,rk3528
+
       - description: FriendlyElec NanoPC T6 series boards
         items:
           - enum:
-- 
2.50.1


