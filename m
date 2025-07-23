Return-Path: <linux-kernel+bounces-743117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F74B0FAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08F31CC3106
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E19231827;
	Wed, 23 Jul 2025 19:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Xbxbfaso"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C3226D00;
	Wed, 23 Jul 2025 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753297768; cv=none; b=T3szW+egi3hPqEfboSO8C+8FYiRUcws249VvaWQwDf4QxEKwqf+W6mO1WjLh9C8cDSWYCg3d/3aBwwnmVsuSvYWMAuPj5X2Y5uPRLR/1pyEER6xa3EN1b6k1Blv+V4n5K8qWHxF4jrffRPX+9+fEM6qxPRvz/rkIexuZ56mpuUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753297768; c=relaxed/simple;
	bh=/o8eA41/k00e1TvzmV6Q+WTLGVw7R/xeyNTNdal9u+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBkqoNDc1Z6+x3/Eaqle+tsEp2IqAB5XnJLwa8u2qIPdqoNRAxzJgGhzd3RbGqOYQd7zHph7q8lZJowNyT5Bdlm88fym6zq96Aq9H30hC7kIDr5DOeac0e9tq0KE6tbNpt3HjZhtyqs1OVRD6+EqzZAZeqZ9hc2X+7BIjUGZWNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Xbxbfaso; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=G3QZ8UpWeh0MVZj2F0Gtz5OdAukQFaHfnnkhgWoxjaA=; b=XbxbfasoVHV/i1TT9BOZhP1pCl
	ZbmvSC4YLfZOMypqPDQ6k2MN7iYG5J9eWd/dvrt5+wFjRDFTsnq8++MuUwDlI0zqp8e30zfG3UgMa
	8FTH+cyTTAluSF//16G6+IyJ3n5oqiyCQRwcX3dfrymWVPj8+Bd8tASO+CRgd5iftj3DBR18VMlRn
	WZf0Li/ZvYsxSA3GKV+Z7f2mIsK7UEA4AYRN5WefdDGDiy5V7PS3AezIuaPhDwEC7RKgWChjlNxNU
	QwEqQDq4etSLcjjFbPLe11pVJx5NluJf90dYsV7PjUnWKe8pENnM5hD8AB9KctlaF1MNgRMz9Kisu
	uVeBHblg==;
Received: from i53875aba.versanet.de ([83.135.90.186] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ueeq1-0007Mn-Gi; Wed, 23 Jul 2025 21:09:13 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	damon.ding@rock-chips.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: add RK3588 DP carrier from Theobroma Systems
Date: Wed, 23 Jul 2025 21:09:03 +0200
Message-ID: <20250723190904.37792-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250723190904.37792-1-heiko@sntech.de>
References: <20250723190904.37792-1-heiko@sntech.de>
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

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


