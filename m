Return-Path: <linux-kernel+bounces-775784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4405B2C514
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB01A21914
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D510F33CE93;
	Tue, 19 Aug 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MdiZtMud"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A995B2AE66;
	Tue, 19 Aug 2025 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755608908; cv=none; b=e8Ziox4m/cbCG7uJSUdDJ8RGg2/THja9z0UT5bRUe+pbqOiUVx18CqMBnoqpVjTw7jcMuXvbE6yR3ldN05l8zkFIvz53dLb5FDIMvVvC5E43IdED7K/Ru7Fws80iPA2JVyMI1ubulGU5fvcz//I0ph5l5ZlFlCyGNQ9H8jV9344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755608908; c=relaxed/simple;
	bh=R+2gPThMfHQBIp4Sff0U97ez0sG9B4cUDaHaX8fQwGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jc5CtQavo12HKFBYWDbON0LrO3V6oqPcf1dmiu8JB+cLUvM63C8HqKBPVQVNKzaSUBk9tsBhGYfStWNmii3KSGy66VKSNjIj3tln2Wu12L4m9YjGPR/+JXktgi/vRRS5IY7/Mx5KqcNLW0rUxJ+QdHiUX6mrfv+uVKhjXj5TydE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MdiZtMud; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JD8Bpw2898662;
	Tue, 19 Aug 2025 08:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755608891;
	bh=ECY0T638c1KZ6ND2Cy0e9ISpZNxxtCUFnZoH1Z46FKE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MdiZtMudLCmshUaB7biwqgMztd+MEetcuzowg61hBe8cfdqrywNaVePVlFBFfZiiM
	 fw7KHvTdNmVib0oXpLwzSCbVniE085zDAmMtCWhaWTDsLIhwRyMf9xMhp4CJa3aytA
	 2g7Sq3F+QIXKeBchEDPzdHs9n+o/Ac6BRXlrmBJ4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JD8BUm605552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 08:08:11 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 08:08:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 08:08:10 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JD8AfY3034870;
	Tue, 19 Aug 2025 08:08:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, David Airlie
	<airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>, <afd@ti.com>,
        <tomi.valkeinen@ideasonboard.com>, <devarsht@ti.com>,
        <dmitry.baryshkov@oss.qualcomm.com>, Nishanth Menon <nm@ti.com>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 1/5] dt-bindings: display: bridge: it66121: Add compatible string for IT66122
Date: Tue, 19 Aug 2025 08:08:03 -0500
Message-ID: <20250819130807.3322536-2-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250819130807.3322536-1-nm@ti.com>
References: <20250819130807.3322536-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add a new ite,it66122 compatible string to the IT66121 binding
documentation, since the two chips are practically same except for id
register difference.

Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Andrew Davis <afd@ti.com>
---
Changes in V4:
* Picked Andrew's review

V3: https://lore.kernel.org/all/20250815034105.1276548-2-nm@ti.com/
V2: https://lore.kernel.org/all/20250813204106.580141-2-nm@ti.com/
V1: https://lore.kernel.org/all/20250813190835.344563-2-nm@ti.com/

 .../devicetree/bindings/display/bridge/ite,it66121.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
index a7eb2603691f..c99b67f0bb73 100644
--- a/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - ite,it66121
+      - ite,it66122
       - ite,it6610
 
   reg:
-- 
2.47.0


