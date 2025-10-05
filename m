Return-Path: <linux-kernel+bounces-842227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6EEBB947A
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 09:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6FEFB3458A8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 07:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04C81EA7CF;
	Sun,  5 Oct 2025 07:31:17 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C51D3BB48
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759649477; cv=none; b=iN38sKfE64duRDZWJ/RI/HqIC6iJDim7j2tG9eDj8XJ7jS+mZyEB2pVtk/uArVc7IAu1OH9RFJALw8JRyumVmL/2wq3zMwy9bVIV9bCKpLdMyn/xQ7a5GQ3QG67Eg/cDZJyWyrgF+D6OKNzB3+M8EasQxEQwR0U7dgSFtHHM3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759649477; c=relaxed/simple;
	bh=//J9zrjS38rnrVl8EjJ3d4tBXaEE7EHJu2CG8NsJ944=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rJ6QL5Dt/0Cw2TYavcx+P0WARQZ+MXkiVMmeIFfvdr3nUmAItaXR2gRa0M+G6e0d0QZe3tlvvRhQMEmIPjHR1Pw474dYZyWksljcvKB9tp41heblQ79Lx3NfZnFbYcpgmYGid+TFV3fFvQQl1M9b271bFAY86brAo4toV7M16lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] timers/migration: Remove redundant ternary operator
Date: Sun, 5 Oct 2025 15:30:21 +0800
Message-ID: <20251005073021.6810-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc10.internal.baidu.com (172.31.3.20) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

The ternary operator is redundant here, so remove it.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 kernel/time/timer_migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index c0c54dc5314c..b869b244025f 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -751,7 +751,7 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 		 * be scheduled. If the activate wins, the event is properly
 		 * ignored.
 		 */
-		ignore = (nextexp == KTIME_MAX) ? true : false;
+		ignore = (nextexp == KTIME_MAX);
 		WRITE_ONCE(evt->ignore, ignore);
 	} else {
 		nextexp = data->nextexp;
-- 
2.36.1


