Return-Path: <linux-kernel+bounces-886232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85646C350BD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E24B7560A6E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9722F3611;
	Wed,  5 Nov 2025 10:10:11 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0482C17B3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337410; cv=none; b=XTWfwQxvoHxp1Tr1oQP+B4auyY12Ruen8Ke2ejnDtY1/nwRIHjztoTWXn5gcSpya6A++38jiC7NdTqAmNWd3Oz4Wt8VDH2iR0RJc+5t7lmd7OWja4hnDZ4wYpXKZ8oNeyTFLfcLnTXcdynxhHtMcvAyLu2I+FZ+2SZFNDjxBdx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337410; c=relaxed/simple;
	bh=rzaWTvEZ+GvPQjWgFis8VB8tviMQ0ztqRHkDpGV4jHo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G1yxWKqar50EvZhG7qaqXLrZGOs/5J6SZLNjf8wiHaA7WdiHU9RCyi1cgJQvY4mkDKP5R1pJdUY86DdOAiQU2vwJG4WF+W0+GlKPRbvdwV1rwM4lFlOd84El34EpqSYkhdgvOTl7dTm/BaQG8/Vm6GeW3EEjMZCPRafS0Lniet8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from spb1wst022.omp.ru (87.226.253.162) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 5 Nov
 2025 13:09:42 +0300
From: Karina Yankevich <k.yankevich@omp.ru>
To: Sandy Huang <hjc@rock-chips.com>
CC: Karina Yankevich <k.yankevich@omp.ru>, =?UTF-8?q?Heiko=20St=C3=BCbner?=
	<heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
	<linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] drm/rockchip: gem: Fix memory leak when drm object init failed
Date: Wed, 5 Nov 2025 13:04:39 +0300
Message-ID: <20251105100439.2780370-1-k.yankevich@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/05/2025 09:53:46
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 197782 [Nov 05 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: k.yankevich@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 74 0.3.74
 076026cf5b16801374fbd5d19166f5aeefca6115
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;87.226.253.162:7.1.2;spb1wst022.omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 87.226.253.162
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/05/2025 09:55:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/5/2025 9:03:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

If drm_gem_object_init() call in rockchip_gem_alloc_object() fails
then rk_obj isn't freed. Fix this by checking drm_gem_object_init()'s
result.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 6fd0bfe2f7ea ("drm/rockchip: support prime import sg table")
Signed-off-by: Karina Yankevich <k.yankevich@omp.ru>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 6330b883efc3..ad888f9379db 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -284,6 +284,7 @@ static struct rockchip_gem_object *
 {
 	struct rockchip_gem_object *rk_obj;
 	struct drm_gem_object *obj;
+	int ret;
 
 	size = round_up(size, PAGE_SIZE);
 
@@ -295,7 +296,12 @@ static struct rockchip_gem_object *
 
 	obj->funcs = &rockchip_gem_object_funcs;
 
-	drm_gem_object_init(drm, obj, size);
+	ret = drm_gem_object_init(drm, obj, size);
+	if (ret) {
+		DRM_ERROR("failed to initialize gem object: %d\n", ret);
+		kfree(rk_obj);
+		return ERR_PTR(ret);
+	}
 
 	return rk_obj;
 }
-- 
2.34.1


