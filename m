Return-Path: <linux-kernel+bounces-788830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A234B38AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28AD9208178
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0562F1FFB;
	Wed, 27 Aug 2025 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MRqjuAsc"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27E2EB85D;
	Wed, 27 Aug 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756326250; cv=none; b=tNhMw+9LmNjuoY8N57cDEWk/cIyvrwrEQXzLqEcJx2Qvhu5CL4LUd4DSzSZ6ER47rTLtzE04pLVt0qBOHX8K2eqi+/jcm6Hjx7CLw+bh5kCuJV/MhlHXS7V9tp0viGYYWeyEImSpi4MJYhiuHMQu8ECxaQaeP43n8OF43BpUDjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756326250; c=relaxed/simple;
	bh=Qx7HgWweJC0iBiCsiTAuxGIumAKR6tAjbidbRrcNPBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ry8BKYnsdab1lhjwfADgx4/5RPI/ME+c+I9qDQxmqXXU0lc3SoSt32K6VLapLEGFAppGsm2kg2mLJhDXIwwo1esJ1ZfN3lPa0XbJd21K+JJkEdUnbtU3AE9KfttrYR5Rjen49mxTdNjA9n2hHFxS8gqxhPIgpESOS9IOX285EH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MRqjuAsc; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57RKNvU91848599;
	Wed, 27 Aug 2025 15:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756326237;
	bh=91iFr4naHIXlcV9GivKcF6EgtPgOgYZQJGU5T0IlmwA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=MRqjuAsc9XSXF8yTvjLC3do/Ez1UFUMU1Mn6GEZEAjx4U9NT8ImKbnYPVacb2BdyD
	 6xgD/tP9jgpGtfRyBtX3dUxzHXEBtHqxlqvdXXZvgYJPrpU1zDPiSVyJXBNaEEqRCs
	 MGju3CQ7ex7cOvNMmTjDP+qJC/2JvFtiELl1l7Ro=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57RKNvnu2707068
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 27 Aug 2025 15:23:57 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 27
 Aug 2025 15:23:57 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 27 Aug 2025 15:23:57 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57RKNvhF3367088;
	Wed, 27 Aug 2025 15:23:57 -0500
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
Subject: [PATCH V5 1/5] dt-bindings: display: bridge: it66121: Add compatible string for IT66122
Date: Wed, 27 Aug 2025 15:23:50 -0500
Message-ID: <20250827202354.2017972-2-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250827202354.2017972-1-nm@ti.com>
References: <20250827202354.2017972-1-nm@ti.com>
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
Changes since V4:
None

V4: https://lore.kernel.org/all/20250819130807.3322536-2-nm@ti.com/
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


