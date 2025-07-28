Return-Path: <linux-kernel+bounces-747420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1925CB133A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F86B18943C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B92215F4A;
	Mon, 28 Jul 2025 04:19:33 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11501DF75D;
	Mon, 28 Jul 2025 04:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753676373; cv=none; b=uNlPdbq8MaeaMnUOrPaPpCJeZS9GUXjIDcRFjdbJAxzq3UY7WVr5xv/Nj3IZ6fs2fz2uER5GGCEd0/LqRKIrlceJmP3gAio1sHKYETgGflcCIuWTWKVdYpis8VMt7oE4jW7T6pNTqHuq7NX9Pm2fhL2g1zacqLo6rdjIiCEXDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753676373; c=relaxed/simple;
	bh=JYUwfe9CP1mfGjt+Nvr0i1MyksIbtQFRuOl+AH0T/gw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u4ImMTTTwtaGIfCZvm4eC5RNLHz82PH2XcVS81cPZ5cxdi+zDYvkuLOWa3203GvkCcQg0NGoACyQCchz2mD+MIzbjoyvuaKQVeuBniVLYHRKg92LHzqgPz+f56FxNd+OVht9SExml/72U53H/KndlufX3ldPB1fotmC+U+/az2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3E9DC1A1476;
	Mon, 28 Jul 2025 06:19:24 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 00F031A1456;
	Mon, 28 Jul 2025 06:19:24 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7F74D1800079;
	Mon, 28 Jul 2025 12:19:22 +0800 (+08)
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: linux-kernel@vger.kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: [PATCH v2 1/2] dt-bindings: hwmon: (lm75) Add binding for NXP P3T1750
Date: Mon, 28 Jul 2025 09:49:12 +0530
Message-Id: <20250728041913.3754236-1-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add "nxp,p3t1750" to the lm75 compatible list.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
---
Changes in v2:
- Sorted compatible strings alphabetically

 Documentation/devicetree/bindings/hwmon/lm75.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
index c38255243f57..ecdd09a032e5 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -28,6 +28,7 @@ properties:
       - maxim,max31725
       - maxim,max31726
       - maxim,mcp980x
+      - nxp,p3t1750
       - nxp,p3t1755
       - nxp,pct2075
       - st,stds75
-- 
2.25.1


