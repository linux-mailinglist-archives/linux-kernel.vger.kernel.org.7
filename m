Return-Path: <linux-kernel+bounces-738638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B188B0BB55
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8A118975F6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 03:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAFB1D9324;
	Mon, 21 Jul 2025 03:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VVB1WIB/"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF4E2C181
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 03:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753067891; cv=none; b=VfiP/oTsrNBFxVrgW3XAGfbF32e4jHljfXzx8GoNAI7p+X6pIicBdwjn+61wi0D9lIlupyZX/HD4KGLvxR/Ot0AVV3cQN57tcpLZjWYk6kaDSASJY2WlSMAMIAra3rr+wplUuwinFijTjhPO7aFxu4eOgYrby6sw+AMbCbgzc9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753067891; c=relaxed/simple;
	bh=1Nwz/6JrXgkK+3JyABNkT+B6lJu9/HJVvsPknVATutE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAQjX4saHEpGLQA+VUbFuy9MKEUK+ykHODHXWGdpjU62YbYt4KEACUNdcRm1eNIHn8egR+k8v4JUFVztlLbcB4cvtURfW+qOsK3SabAZ2Oy6WeqKoxMUL/SOnweK8UJCryZnPNHCNkso5RTBdlPIFrT2eRhioirwD22ZBtab8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VVB1WIB/; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753067883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LEVQWDNiwgMGDi1tqQCTSAM70YFvUepOfjgTtjrX/DY=;
	b=VVB1WIB/6VDwWEGZd4RB1DTk37lSElBL4ind2OUc0Af8JpZE3h3ZEKb1lrf4uDZ4wlWFvs
	F6HfSCKNeilmSfwQC7CKD6YAWbALeWtSSOIn26iJrD54851xXVwEO/RLSHLo5WOgNmwzuk
	yx/MmqMMRlkU8gcAZCt2u/yipir9iE8=
From: Ye Liu <ye.liu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ye Liu <liuye@kylinos.cn>,
	Lance Yang <lance.yang@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hung_task: add warning counter to blocked task report
Date: Mon, 21 Jul 2025 11:17:54 +0800
Message-ID: <20250721031755.1418556-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Ye Liu <liuye@kylinos.cn>

Add a warning counter to each hung task message to make it easier
to analyze and locate issues in the logs.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 kernel/hung_task.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 8708a1205f82..9e5f86148d47 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -58,6 +58,7 @@ EXPORT_SYMBOL_GPL(sysctl_hung_task_timeout_secs);
 static unsigned long __read_mostly sysctl_hung_task_check_interval_secs;
 
 static int __read_mostly sysctl_hung_task_warnings = 10;
+static int hung_task_warning_count;
 
 static int __read_mostly did_panic;
 static bool hung_task_show_lock;
@@ -232,8 +233,9 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	if (sysctl_hung_task_warnings || hung_task_call_panic) {
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
-		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
-		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
+		pr_err("INFO: task %s:%d blocked for more than %ld seconds. [Warning #%d]\n",
+		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ,
+		       ++hung_task_warning_count);
 		pr_err("      %s %s %.*s\n",
 			print_tainted(), init_utsname()->release,
 			(int)strcspn(init_utsname()->version, " "),
-- 
2.43.0


