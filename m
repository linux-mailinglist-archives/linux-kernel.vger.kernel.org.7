Return-Path: <linux-kernel+bounces-735091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E63B08ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230E617C6F2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FC129A301;
	Thu, 17 Jul 2025 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="LqdXjgPI"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339D29992E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748671; cv=none; b=Dg6h/O4eWMMf3LLZ1Piz9j/T4+Kc4nJIpg5NDHUeGGpFrhhUocHGBbb3VmIuo3mgIEBZn1FBc6VsDkh2Z5r0nZTmH+NWMGk7bLzW/jkEXUQ+58UCg4waJrtDsEnr3Guu1RB80aZ6RWcPHJu/Ut73qdt+paFo202yX9uB8e1ZAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748671; c=relaxed/simple;
	bh=WTCmEgroE7xLdK+wx5mCjkRcrz5PP871ZaINUraGaHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+LrD61FxkGu+P8zyNXNsSSXd01EHmfJ4v7wVt2wIrjWZJjZfRa7d7tQDkO0xhMFsaPJ37iuH2K3cfqIRpZ1Qpk6ayXLn1onXniD4I2f/ITlh2bJd/zaKUbW9KN//QCbwFWnawavOVEpofrAu7sOP4PYaQu1rlsiR2H5uKR0X0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=LqdXjgPI; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752748668; bh=h+Hw8lQ0o+mOFqv9n5gcTSKBcsWJil+YqWJxNjP2g4Y=;
 b=LqdXjgPIp9+k2/XUyn4eYsNsCpvYWg3FRpk1vuQpQc9S3D+3seKJ77aPm/NdgDYs8jEsNkDKG
 9FAKQIQTlO+CoGOEzuClG3L2EesOrGjU19WladIaw+bYppsBNY0EmBISaVe5diTTQbArY0tDjCk
 wwzJEWmDRLvg/5wT3WyqWTwnubK/3Zg9I3fSk1lxfPn1wMQn/+Q7FcabrYja4opaMEzm91EYlr2
 HK2KsYl9R7nVZEn84gnP54R6nOxRhQJhxF2D2ogbmb6JVSllblu+ZZjK+2OIQw1y8RYrta2E5uv
 U+JjJqyTPbnFZLHCIKhzSXxCyKVEWZre9eO7rE3h7JMw==
X-Forward-Email-ID: 6878d2695e51505848fe5f9e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
Subject: [PATCH v4 1/6] dt-bindings: arm: rockchip: Add Radxa ROCK 2A/2F
Date: Thu, 17 Jul 2025 10:37:03 +0000
Message-ID: <20250717103720.2853031-2-jonas@kwiboo.se>
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

The ROCK 2A and ROCK 2F is a high-performance single board computer
developed by Radxa, based on the Rockchip RK3528A SoC.

Add devicetree binding documentation for the Radxa ROCK 2A and ROCK 2F
boards.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v4: No change
v3: Collect a-b tag
v2: No change
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 28db6bd6aa5b..c5690098f2ed 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -881,6 +881,13 @@ properties:
           - const: radxa,rock
           - const: rockchip,rk3188
 
+      - description: Radxa ROCK 2A/2F
+        items:
+          - enum:
+              - radxa,rock-2a
+              - radxa,rock-2f
+          - const: rockchip,rk3528
+
       - description: Radxa ROCK Pi 4A/A+/B/B+/C
         items:
           - enum:
-- 
2.50.1


