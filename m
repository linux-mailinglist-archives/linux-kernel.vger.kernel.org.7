Return-Path: <linux-kernel+bounces-734108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEFEB07D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B93B1C417ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6ED29DB95;
	Wed, 16 Jul 2025 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="WQQvhwWf"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1F0285C8A;
	Wed, 16 Jul 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752691838; cv=none; b=QK7Q78EoF1HY/Qxk/4ZhnKVivASAHJUtIYsOBDtJetRiE98RO4L4NkTrP+0c3haGtSBObQMmTtx0GmC81euEXqAH+Ust2vhjOYTylwcGIccK/2jWfIuAeiZWH4KLQd5CcDRxleK9OytEzey3fuNFvpIx97hpWH5A6yQqiftZDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752691838; c=relaxed/simple;
	bh=yEw9Jcb/N+5m2RbpyZAvjxau5dR2bfrlSm2/PYl8TrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rR76Q/U/WkG45iv4/bBTtsAfeqNrDCZjhIEcVYd//k/eEYbJI/oCpzUXk/G8JauQY9tFrfKIh5KNtD0Y9XT4kczkaOREFvJU6gHjkGwr6Hcdbe/Yy6LMbXa284BuJGseYy3HS8yasmxpiiKDVf1hXbkuVQa/HDD+4artIE/SxG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=WQQvhwWf; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=wX/LhM0XGTPFpXq6PulOm5cC+DI6p0qBV6qG8eHjyLY=; b=WQQvhwWf7yBG3Ewk+e9vfV58cH
	hbEkT6JNw6YW8oiYnBuXcmRgVbe34uwWPAxDYRCactrW6wAtGroV5Fida6vvb9VQSv76TuZxXldX5
	AtwW+ab1QNlEcXCq36whi4oiQ9XL69z2K7N8bhiNh9h4tYvdJgu+Jf1NBHpy2nEXNbWNO0S+tEdXi
	i0AfJCNHdvBPn1wzMIUk7977q25f4sRz3PQxraFoyi1oHy8zDC6oDwf+bDuPBju9lOjc7VjK4HRTs
	V6XEU5j3MwvemXINcU7d7mx66SvEROGnufi4WqxzW9M66kBUreZhfh+skXVv4tdLjj/vgO+X2pgH4
	m7qAbOIg==;
Received: from i53875a74.versanet.de ([83.135.90.116] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uc7D3-0004Hf-Uc; Wed, 16 Jul 2025 20:50:30 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	damon.ding@rock-chips.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: add RK3588 DP carrier from Theobroma Systems
Date: Wed, 16 Jul 2025 20:50:26 +0200
Message-ID: <20250716185027.2762175-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250716185027.2762175-1-heiko@sntech.de>
References: <20250716185027.2762175-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The DisplayPort carrier is a very simple baseboard only providing serial,
ethernet and a displayport output.

But its main functionality is that it routes the Analogix eDP controller
to this DisplayPort output, which allows to test that controller simply
by hooking it up to a suitable monitor.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 5772d905f390..8dc83263c892 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -1164,9 +1164,11 @@ properties:
           - const: tsd,rk3588-jaguar
           - const: rockchip,rk3588
 
-      - description: Theobroma Systems RK3588-Q7 with Haikou baseboard
+      - description: Theobroma Systems RK3588-Q7 with baseboards
         items:
-          - const: tsd,rk3588-tiger-haikou
+          - enum:
+              - tsd,rk3588-tiger-displayport-carrier
+              - tsd,rk3588-tiger-haikou
           - const: tsd,rk3588-tiger
           - const: rockchip,rk3588
 
-- 
2.47.2


