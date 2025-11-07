Return-Path: <linux-kernel+bounces-889825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 105E4C3E9F8
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C0F94E78EA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C348626FA5A;
	Fri,  7 Nov 2025 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="aGEbnJ6h"
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5505F1E570D
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497193; cv=none; b=ORHabKzqu8Y12EF+fz8iciwGNo5sbXm6GsO+Do1yo786vRu+09qNRi9h/UUFqsd5WxUFxqtYknlG45dCK5NgOCkm2QSDhOl0FydqqRTQuHnt40tFRCzlC4FZ59MQWuZzrp17VGlMl/0jKwsxR6bFceu1LSSvs7nKwJW2+Zuv3rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497193; c=relaxed/simple;
	bh=NENEyUnoRdiI/27NhAgusqOSOvgAHLCR2pTgMHVIvaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJnSzvwYfsM3mY1ctODByE0cFJns0e/qlaWGkVgnYdapkGHB1dRdl16ucz940yt5H2cQKY5i+j7YsoOtwe8mq+PO9foI7gBqIjn3UYMEocFyjqyIsCfDtK7Id+RVuRttEil98uuw/SFQh1VTJypZwTcYCrmFUbFpLgf4qeY4sK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=aGEbnJ6h; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+0JpDoPakWYsOQgf+bX/kge5ophVP6G/4GHe/HQObQU=;
	b=aGEbnJ6hoQtDmcW++2e00Ja5p5u7IEHwfBBOCjVNeIHL3EH4G70yvaky9Py75FFfOlemsOTF/
	5QrqCWbLVfKQmRi2ru48ajMV5ldktqr9jK7op01lGNXl/o03XiLnH2k2MDFjF5/S2c8Yuf764Pb
	aEdut5lSjsw2kMkBtq/vNHc=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d2q2n6rk8zLlV9;
	Fri,  7 Nov 2025 14:31:29 +0800 (CST)
Received: from kwepemf100008.china.huawei.com (unknown [7.202.181.222])
	by mail.maildlp.com (Postfix) with ESMTPS id EE91D140230;
	Fri,  7 Nov 2025 14:33:05 +0800 (CST)
Received: from huawei.com (10.50.87.109) by kwepemf100008.china.huawei.com
 (7.202.181.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 7 Nov
 2025 14:33:05 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <james.morse@arm.com>, <Dave.Martin@arm.com>, <ben.horgan@arm.com>
CC: <sunnanyong@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <zengheng4@huawei.com>,
	<jonathan.cameron@huawei.com>
Subject: [PATCH mpam mpam/snapshot+extras/v6.17-rc2 1/2] fs/resctrl: Fix the iommu_group parsing process
Date: Fri, 7 Nov 2025 14:32:59 +0800
Message-ID: <20251107063300.1580046-2-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251107063300.1580046-1-zengheng4@huawei.com>
References: <20251107063300.1580046-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100008.china.huawei.com (7.202.181.222)

When the tasks interface receives the iommu_group:id configuration, it
should return after completing its parsing, and continue to the next
token, rather than erroneously proceeding directly to pid parsing.
Otherwise, an EINVAL error is returned.

This fix supports processing multiple consecutive iommu_group:id and pid
configurations.

Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 fs/resctrl/rdtgroup.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 839d568b8798..4f4468e11dca 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -854,24 +854,33 @@ static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 		pid_str = strim(strsep(&buf, ","));
 
 		is_iommu = string_is_iommu_group(pid_str, &iommu_group_id);
-		if (is_iommu)
+		if (is_iommu) {
 			ret = rdtgroup_move_iommu(iommu_group_id, rdtgrp, of);
-		else if (kstrtoint(pid_str, 0, &pid)) {
-			rdt_last_cmd_printf("Task list parsing error pid %s\n", pid_str);
-			ret = -EINVAL;
-			break;
-		}
+			if (ret) {
+				rdt_last_cmd_printf("Error while processing iommu_group %d\n",
+						     iommu_group_id);
+				break;
+			}
+		} else {
+			if (kstrtoint(pid_str, 0, &pid)) {
+				rdt_last_cmd_printf("Task list parsing error pid %s\n",
+						     pid_str);
+				ret = -EINVAL;
+				break;
+			}
 
-		if (pid < 0) {
-			rdt_last_cmd_printf("Invalid pid %d\n", pid);
-			ret = -EINVAL;
-			break;
-		}
+			if (pid < 0) {
+				rdt_last_cmd_printf("Invalid pid %d\n", pid);
+				ret = -EINVAL;
+				break;
+			}
 
-		ret = rdtgroup_move_task(pid, rdtgrp, of);
-		if (ret) {
-			rdt_last_cmd_printf("Error while processing task %d\n", pid);
-			break;
+			ret = rdtgroup_move_task(pid, rdtgrp, of);
+			if (ret) {
+				rdt_last_cmd_printf("Error while processing task %d\n",
+						     pid);
+				break;
+			}
 		}
 	}
 
-- 
2.25.1


