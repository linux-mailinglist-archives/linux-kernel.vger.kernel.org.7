Return-Path: <linux-kernel+bounces-832118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DEDB9E604
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D19C4E2D36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06212ED84C;
	Thu, 25 Sep 2025 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="eCdggl4l"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCDE28468C;
	Thu, 25 Sep 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792649; cv=none; b=YyKdzh/7QLg9VEQhic+98orHQ1RMtHROg60/yiheap6Wm4UdaCltxtCW/YCAD1onxY8XK16SejCZ3++/YcRVbbh/Xok7uNd6V/Y7oTVEQr40EXDidb6pmwrdR9AjLusXrw6QAzyc7qjg4yHhlVn54vqlK2T9nh7/7NB4wj16a74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792649; c=relaxed/simple;
	bh=7GYcMwK51zwkp+8g97pVFE9NzZk3qgfAxXMATMaX3aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFq3mcFcb96vL0NE79O9N1mGmjRXeu/UU3zZ3WI6JIiavWDGV2EWa3FTy4+jCiuBb9cvperUyPOLBJlq1P4fiUmzwUGudjxVLn6FcncU7YyxtAXs6hIjSXfC4BNVDFDHbrw09kXqfmESGwOMTqcyZgizQB9r6LES/SPcxduzKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=eCdggl4l; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=2qN0FqsVUISBvXoaqv4EYKW7KLfiSBDet0Hh1gfEi1U=; b=eCdggl4lv/fqUGDXszcglk9RpV
	5rlEBVUB0iFS6KuLthsRFwAfe3KmKAVx08gM/VW6QEuQr8+H9EHfD/Itd9Mpug9Lw2U2njvbFcO5E
	IOxZcxG3oTw/zjY+UJzCzV1V/LfB4Rmi3DLoYM0gl2mADYuYWdXfRHdGStx+a8y89X/ghW0IGRU6w
	WELjEJT7HZ5mW4pcFE+jcnBzv8MAoec09Zgg6WZNtvdGKCe/EhWxkDnmzjwkyHHXjdLs/5djFajSz
	AsS6Qg+b7+abXsISjgn0fjMEZ4kTaX20EBE7WLFupXPlKAVgDdYwUd7tXCwV70E0sQQFcjpgajgSV
	fNuJGtgg==;
Received: from i53875a54.versanet.de ([83.135.90.84] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v1iJH-0001Nz-C6; Thu, 25 Sep 2025 11:30:43 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ukleinek@debian.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 5/6] dt-bindings: arm: rockchip: add TS233 to RK3568-based QNAP NAS devices
Date: Thu, 25 Sep 2025 11:29:22 +0200
Message-ID: <20250925092923.2184187-6-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250925092923.2184187-1-heiko@sntech.de>
References: <20250925092923.2184187-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QNAP builds a number of variants of the RK3568-based NAS design.

Add the 2-bay TS233 variant.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 28db6bd6aa5b..27c353c4452f 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -846,9 +846,11 @@ properties:
           - const: prt,mecsbc
           - const: rockchip,rk3568
 
-      - description: QNAP TS-433-4G 4-Bay NAS
+      - description: QNAP TS-x33 NAS devices
         items:
-          - const: qnap,ts433
+          - enum:
+              - qnap,ts233
+              - qnap,ts433
           - const: rockchip,rk3568
 
       - description: Radxa Compute Module 3 (CM3)
-- 
2.47.2


