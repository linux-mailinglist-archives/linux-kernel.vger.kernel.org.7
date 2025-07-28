Return-Path: <linux-kernel+bounces-747839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E1CB138FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B1C51893B4F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C57520125F;
	Mon, 28 Jul 2025 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="TUchOU/S"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE0D1CAA79;
	Mon, 28 Jul 2025 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753698647; cv=none; b=P7ALPxGKyB+a7hzU9F3WsB6aoD4acyXIq/3Sf/rajtuEGaaR1/YWJ4AMS4vEHGtcMLh921TrnSkABXXjk2sl2DI6BiNK+tvsVNFUKxIqkbXkhtKqLjeHQSVy+CqEiOOsZu2NMoHzsHiYyE4hj9Cm1tq513ddUEananwPxD/kuDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753698647; c=relaxed/simple;
	bh=qBq1mAbqPGcYbgpJSKXM1JGiaWrzbRbM/TI0PBE0xY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2CAYVlnHj3Z9l++jSekO8zqrrXk14duUUrU9axikvizujTeqJqboMjoF3Qhwc2SAS8jgOE4k2pKFItS9s19jM4MEOtJlEZR3uCcsn07Btgd1BY3QM5QCcVv/SM0P+j2bvzBd0OlSrEISomJvcmUB+nWVLpzmARdPsuOS7fZ3As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=TUchOU/S; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7F4A420543;
	Mon, 28 Jul 2025 12:30:44 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gwt0ajRAJT6O; Mon, 28 Jul 2025 12:30:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1753698643; bh=qBq1mAbqPGcYbgpJSKXM1JGiaWrzbRbM/TI0PBE0xY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TUchOU/SQEB9L4HSGKdfTXHX2uvc99PVC0fxVj0a+JJIdSxcTldtffVCTJCs9RrDR
	 mIajvxVZ9IRcn0Lwwle3hMQP0Vtc4Oo+Dpe4nAnunD8BKTV3Ekc6d6/Wl7uEwSdc0L
	 Hzq9xapTQwd3XnVaHLtFWoPaW/dfVkaF5QZh4RDbkCVyJmssQCHpSzK2lzBBTWnR3w
	 xMVTIFSmV3t3s+OXhASb1HDuEu1uI7bja8wX5Quq4nuqjcIwUF5x8zl9qPPxg4AnLQ
	 /6eFhhX5rRbJgKsjtJkbvnQ6KuTjOlHb/4IiJvg5r1K9d0hRF5tutOWzWoMYKBjDOQ
	 NWeh9mz4Rlw1A==
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 2/6] dt-bindings: phy: rockchip: naneng-combphy: Add power-domains property
Date: Mon, 28 Jul 2025 10:29:44 +0000
Message-ID: <20250728102947.38984-4-ziyao@disroot.org>
In-Reply-To: <20250728102947.38984-2-ziyao@disroot.org>
References: <20250728102947.38984-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Though isn't described in existing devicetrees, most Rockchip combphys
belong to a specific power-domain of the SoC. Taking RK3588 as example,
combphy 0 and combphy 2 belong to the PD_BUS domain. Document the
power-domains property to allow describing the information correctly
in devicetree.

Signed-off-by: Yao Zi <ziyao@disroot.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
index 3e101c3c5ea9..db293d2fbf1a 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
@@ -45,6 +45,9 @@ properties:
   phy-supply:
     description: Single PHY regulator
 
+  power-domains:
+    maxItems: 1
+
   rockchip,enable-ssc:
     type: boolean
     description:
-- 
2.50.1


