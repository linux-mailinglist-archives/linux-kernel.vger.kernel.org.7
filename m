Return-Path: <linux-kernel+bounces-770118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910A7B276F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071BD5E3999
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8532BE050;
	Fri, 15 Aug 2025 03:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LfPY3zRs"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF3277C8E;
	Fri, 15 Aug 2025 03:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755229279; cv=none; b=rTAiBbINtDrl6FGZ2Mx2kvLWQJ0iSoGbjexSxJz3YowbeCpg6I0fx7XBX9WOY8zssQWa3NAF8fYEqr9MKzcM6k81As8dVmgtsA7t5uvvehhsAYEZYoRb3bJPJdz6yJttNVmF/3E2UJmJYsayiByU/6LsTPlFAqw38F4jZcICdeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755229279; c=relaxed/simple;
	bh=TsBqCmyguoqmJGeuD2guEZjGyjejQEzomefUgzSZ85I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NW2ZXMh0HqEjSozLmkkhpf2j+s5Y1peiz7QCMA1K/cudKOGdqI7QCSEtXh8xO2ahQWz1hy/i6ejf4pijGwe9ABibAxDUNRUDp38BIVKJYG1XD0xXlmX93iLwZH/kImwZmC9Y6Th36ru4CWYoStCG58LbhsaqEGW+Yqd6yFg9eis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LfPY3zRs; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57F3f9ei2075242;
	Thu, 14 Aug 2025 22:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755229269;
	bh=LijDDfJj/HnoCFvNR7KrheABUM4ZJ0FRRu4mRC43Pq0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=LfPY3zRsxyCwRu0QikM8lIR+jhzIorh6Q5s68vuND4v54nq647I429JXcWhw+f4dR
	 1j2IANOhNbn4MMiZhEfPgnD5P7GjhGK3NL3nb91E8G0XJSJ3SwjY8A3J6iGONd7ZyL
	 uAF+fshiCl5WaCPARnl6sxxQ50YBH0WnEaGmXJbU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57F3f9G22167606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 14 Aug 2025 22:41:09 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 14
 Aug 2025 22:41:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 14 Aug 2025 22:41:08 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57F3f8gh419041;
	Thu, 14 Aug 2025 22:41:08 -0500
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
        Nishanth Menon
	<nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 1/4] dt-bindings: display: bridge: it66121: Add compatible string for IT66122
Date: Thu, 14 Aug 2025 22:41:02 -0500
Message-ID: <20250815034105.1276548-2-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250815034105.1276548-1-nm@ti.com>
References: <20250815034105.1276548-1-nm@ti.com>
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
---
Changes in V3:
* None.

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


