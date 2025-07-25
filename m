Return-Path: <linux-kernel+bounces-745538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FB7B11B56
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D549AA821F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711D32D5423;
	Fri, 25 Jul 2025 09:58:26 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4762D46BA;
	Fri, 25 Jul 2025 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753437506; cv=none; b=kTtwcDwEdmAhEDBIds4HysiW9a6K03aQUUNu4xU7vxK8kebs8jzm+5iY2sYuFO7jDjtZXnmmU7aen3PQiA8SKUsnFIr6Q+So0EWP3j4m4yqzPIgV2zN7nm+cZqLUAn3hGu6q/lQCP4VqniGNxRiTMul8bK9I96UfL08lfAwVyrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753437506; c=relaxed/simple;
	bh=5pOPhajBbxWRHUanALO1t6Y++n2BiPrJFpZteErUpKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lAxgs+D7Ykv7A5eDbN3pIgZ7UqtpkwIMwog1Gw6QG/VsnzcKdwdijOMAgIQ4bMGCoSSItCgeupkLdboprcu32YSizfFl70L6zyJ8Ws2u310+E87KFcEUH+jq8XX4FnAsmPHYZXXtxtXqu0NsL2eczvYafRAt9QJLqIwHUl1OAoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 654382003FD;
	Fri, 25 Jul 2025 11:58:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 29143200219;
	Fri, 25 Jul 2025 11:58:15 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AE525180007B;
	Fri, 25 Jul 2025 17:58:13 +0800 (+08)
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
Subject: [PATCH 1/2] dt-bindings: hwmon: (lm75) Add binding for NXP P3T1750
Date: Fri, 25 Jul 2025 15:28:10 +0530
Message-Id: <20250725095811.2717763-1-lakshay.piplani@nxp.com>
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
 Documentation/devicetree/bindings/hwmon/lm75.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentation/devicetree/bindings/hwmon/lm75.yaml
index c38255243f57..d0fa98eb38b1 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -29,6 +29,7 @@ properties:
       - maxim,max31726
       - maxim,mcp980x
       - nxp,p3t1755
+      - nxp,p3t1750
       - nxp,pct2075
       - st,stds75
       - st,stlm75
-- 
2.25.1


