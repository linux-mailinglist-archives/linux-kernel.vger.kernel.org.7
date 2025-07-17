Return-Path: <linux-kernel+bounces-735094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC5B08AE7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 109F2A63313
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8C5299928;
	Thu, 17 Jul 2025 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZsMP88Rr"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D4328C005
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748682; cv=none; b=BTrpMZ4KB00nJSwe7ATuMPzVbzatNqsD0sgi1GUmI+xpmKj9PbFe7bS96Wp8tPMc8+oa6YvsKcGSe/X4WcOFcae7arZDJUzUT/Iz17Q6qY1fFtGrqI4jt/7dplx7Nn0QFTq1SBtz5bcasS1nqOtknzXjcfArVeNchFsMMp7q+EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748682; c=relaxed/simple;
	bh=va0d3jfWFeCPRM7m0cBeHlpz915i+WUA9Y4YH3HNjYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJfx9jZIyZAuld7JFurGhCCnbQCKUk4yRk4E5RV6UBo9qvfxA/sEBTFACGjKsZLnmfKWkN0H+1/90u4ha5XA4Dku9oUuXI1tGe9BI5Li1N+oGXQDotyxUqDPI1h+v/uotvtGB8Vxh/lUAOUWCowETBiy7Fl4DyTamsD40MhgUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=ZsMP88Rr; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752748674; bh=9FSOoEwsfuL0j5eOh3+NN20FVwSxKcx9YlJVAcwj+eI=;
 b=ZsMP88Rr5PRG0mcnI1KG77nPVePE2nIkRTRCcye9bWUIcWVFyzRCIQGzo4jWjnxqs88kwuTty
 xx5/7U5keECh7WSwx+Tjx4nfqWmcVzSJkE+CeR/a1UDiCjydNjDOrpzpxrXjFGS3nGNqxlRfPiV
 9HjoVgcBIaNGEeo+NuONxotMWPkr2zqSXA4iXMwnIpS5p8MWbpEMHSVHF+tiHO3GzIEy8g+ZuGK
 Lwzt+8BfLtF4ggu6w5xOuoYchBwHDcg6Yh/r0JkfSMkq2gnxuJmIZt3mv7uwqNhiDE8A5jDroTU
 cXvoq1dYfWwuWh9Zl7ssSSfeGjvhEnI4NPNE/IwaTFhA==
X-Forward-Email-ID: 6878d2735e51505848fe5ffe
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
Subject: [PATCH v4 3/6] dt-bindings: arm: rockchip: Add ArmSoM Sige1
Date: Thu, 17 Jul 2025 10:37:05 +0000
Message-ID: <20250717103720.2853031-4-jonas@kwiboo.se>
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

The Sige1 is a single board computer developed by ArmSoM, based on the
Rockchip RK3528A SoC.

Add devicetree binding documentation for the ArmSoM Sige1 board.

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
index c5690098f2ed..43f6403ecad6 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -54,6 +54,11 @@ properties:
           - const: ariaboard,photonicat
           - const: rockchip,rk3568
 
+      - description: ArmSoM Sige1 board
+        items:
+          - const: armsom,sige1
+          - const: rockchip,rk3528
+
       - description: ArmSoM Sige5 board
         items:
           - const: armsom,sige5
-- 
2.50.1


