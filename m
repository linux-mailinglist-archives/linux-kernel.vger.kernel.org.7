Return-Path: <linux-kernel+bounces-898235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 430D5C54A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4183A4624
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBC62E9EAE;
	Wed, 12 Nov 2025 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="gC1cEODl"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87C52E2846;
	Wed, 12 Nov 2025 21:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762983752; cv=none; b=Gshq6U98RfadKd2RHFFK3FxyTZ+nlUzeFsL0ee99aehQuoLz99LeNBUEOZ+Ol70O00PHxWfWOZvEpa4cBguy2P2iLMAm/u+/Mkwz6oowzoltLgzGElYN1oYJsd+jnHWKY4K/Kh8SVT7ZBMyeoDLemaD6iXj1VfEI4nUs3UbcRuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762983752; c=relaxed/simple;
	bh=tevx7cYXDLjFeZ6QCZfg0FIpmWpV8EN/xU+ru3Pg+rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaONbmrIUtMEQg6lyNY8/0vNBeAMRflQYca6j3W5a8J9yDjgP1UuI3JUfOz74PD/ncLQdV6reBUCA4JRG2tcXsldz5blUQcGp9c5IoOxgX6kyzufZM/gu/dZDGzslyI6lB4prZn3CmZcdAeTisg9J7hRqmJXudR7EqXtjp0n+jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=gC1cEODl; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=m2DpkjORXKClcfZTmW7CaccU88dCo7Vxf1K3yE+R8sc=; b=gC1cEODl4Rnftt6sX/oOIDWLGl
	fzFAclVMca07MkCloXmDpTfcO9Jf+QCg+X0gEbgf8Tcb9Ft9dnb58Agekwrs71TCBIocIjAhSeDlV
	MZpsC5Udws9nEUnXd4+BB8vCMYjkQJ2VItN1vB4Fdm2IYEHWS45fpZOaKpOzV8lYYh/BrMmrmyIlH
	vxV0TZpsSXpPzH8ktzYl2t3eu28NU3RGOZi4DavejB/LJXOCngLiG8mTalu5MlaTqF5nysH8nOj9D
	0AX+c+BvEaEEcOXKIx9qobaS58pdwezMLOkPb22NuK9p3+TMWfGIDV3PJjwZQtXQvAMHtis/2EeOO
	6OFSyxUg==;
Received: from i53875b63.versanet.de ([83.135.91.99] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vJIba-0003tg-5D; Wed, 12 Nov 2025 22:42:18 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ukleinek@debian.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 4/5] dt-bindings: arm: rockchip: add TS233 to RK3568-based QNAP NAS devices
Date: Wed, 12 Nov 2025 22:42:05 +0100
Message-ID: <20251112214206.423244-5-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251112214206.423244-1-heiko@sntech.de>
References: <20251112214206.423244-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QNAP builds a number of variants of the RK3568-based NAS design.

Add the 2-bay TS233 variant.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 6aceaa8acbb2..790f910aa38b 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -868,9 +868,11 @@ properties:
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


