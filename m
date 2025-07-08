Return-Path: <linux-kernel+bounces-722499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CEBAFDB56
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9ECF1C252E5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADF123A993;
	Tue,  8 Jul 2025 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="UIvDqOlC"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB601238141
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.127.44.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015002; cv=none; b=Y4bkX89gZW9aKUXVdzGfwMsF0RB1NqbBYpl0g7PHnsrzqu87GlICjVE6F8WuSsNzCJsXVKLLuEJfwNAN12Ns6KxF9tW74aWhiJGgcZAFxejBkz4Sa83JCas/cWFIUkUhpGQElaQxqBsMI1njyrvMRY0ToNpmgB+FyHqmUkE9GRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015002; c=relaxed/simple;
	bh=G3EzXvM1hqwbY3XBaRofWbCKSnkQEoC3P3yWrgnffyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tasymp68hp7RVtJaOQI/n3HrtMYI9YhLGluGOlF2iWj5/QI5kjjdJLZ1MGZAOF87NDKGFD3dV48wjmt+bmNeo1iJ7FqRvsFpJzpPqylN84dRUdYlbtvhGbjGYayov8whnnU7Ac52o0ltSrfWp4uaU6Dxm98ZplL6IqvSVxEm62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=UIvDqOlC; arc=none smtp.client-ip=121.127.44.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752014999; bh=61CNx8jWm6k6gYCQPCbrbHlIUBzdc15o+3AlaTE4Qpw=;
 b=UIvDqOlCZ1ULKMma708G7Lx46A49CMI0HahtxXPPNz7np5Ret4qEr/eDVU91fjbasiQw8Q5uK
 TNWrjJxlwR1GFYy94kSVD06fAcbPmv1AQkeP029IxFdGNNhyIXcXEiZT4tjLMU7HBFZyIBLlyML
 G1BYWdZEIvImig8Yjwlfd8WPuXG4AO0SG1keULDhj67ShdPdyV1SzpTUzriEI7E0nhFNYp+3IFy
 uUeb+gikdHFl0OJfv/kU/gx/fbAcJ/9Kqfg4h6FNPFO1/GxmsYWjLrEClVNz1Mx4aWG33QnE94Y
 7Irn1EMVDJb05ZiSW7BzWERESqZ2EOu760l331v3jZgQ==
X-Forward-Email-ID: 686da09575317ad3cfdad433
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.3
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
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 5/6] dt-bindings: arm: rockchip: Add FriendlyElec NanoPi Zero2
Date: Tue,  8 Jul 2025 22:48:55 +0000
Message-ID: <20250708224921.2254116-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250708224921.2254116-1-jonas@kwiboo.se>
References: <20250708224921.2254116-1-jonas@kwiboo.se>
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
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index e955e3334e35..a84076841504 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -319,6 +319,11 @@ properties:
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
2.49.0


