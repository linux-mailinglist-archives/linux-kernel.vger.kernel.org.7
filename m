Return-Path: <linux-kernel+bounces-639752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C14F9AAFBDC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 15:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067D03B4425
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 13:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2FA22DF8F;
	Thu,  8 May 2025 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XEDdEjmv"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AE3227BA1;
	Thu,  8 May 2025 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711866; cv=none; b=OKRI5+U0TE7j3S5DzV16mS0DCwPMRyxY770Djy3LUKBBkKyOCee0rOB+b7tuiFnBvDFSmpi9TmZrzjzXgm6O+0cAo0V2fvDeoqoHLuGERpTnooVjntpAyCCS9hzVfEc5IJYFsfpDaqVsJBA8j604erxq8/FNQ5+xyxpRfwAsYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711866; c=relaxed/simple;
	bh=vbK2zlww38wck9vMVg+gzO7EFS+YMqh3QyFokhlVYPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+V/z1yU5lj30D29FKe42FBQZhX/CUPpl0JyRvW/UFn7XafTCDe/xQmFBm76aG84MQssWN4pzAHKoNTUcXxWFK9PRvbmI7YgIDeoW+1vBwt5cZ8UzvmtzGp7wvYE5q7/LF4PksHNy+yBjQOpGXLY4csDx2PSmK/EdVrDAnBhVc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XEDdEjmv; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 906A525C52;
	Thu,  8 May 2025 15:44:23 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lMjFUx90zjFi; Thu,  8 May 2025 15:44:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1746711853; bh=vbK2zlww38wck9vMVg+gzO7EFS+YMqh3QyFokhlVYPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XEDdEjmv+TFPMoZbsGPFMLUFPr3hv5wGVOsjsjMQTUgGxk5FaNTe2Fu7My9Rh88k+
	 RUOVKcWm+67PqrZHn76PVs0tzCwx9modPkz7qznkABZI2UjyoTkLYv8+qNnlThjjRE
	 TM9D6UHOlJWvMNqWKZcEuRSF+zDxe4QQBnex7qBLr1DAnXVIvgHnNZx8V8MnpDKQof
	 pfh9oBipnyxIogtXdyz7n0zFBmvGx2fosjVZYIx2SZCLnuFh4fgduyk0XePlz8zzBD
	 1Kd2jgxBeK6pvJDaLiGlJsv/9YFOApuTDUddmPC+McZFaGAANgnlz6G17CmGhL//51
	 lHIcDT+Qrieyg==
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: phy: rockchip: naneng-combphy: Add RK3528 variant
Date: Thu,  8 May 2025 13:43:30 +0000
Message-ID: <20250508134332.14668-4-ziyao@disroot.org>
In-Reply-To: <20250508134332.14668-2-ziyao@disroot.org>
References: <20250508134332.14668-2-ziyao@disroot.org>
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
---
 .../devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
index 888e6b2aac5a..bd064754e537 100644
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
@@ -102,7 +103,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: rockchip,rk3588-naneng-combphy
+            enum:
+             - rockchip,rk3528-naneng-combphy
+             - rockchip,rk3588-naneng-combphy
     then:
       properties:
         resets:
-- 
2.49.0


