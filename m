Return-Path: <linux-kernel+bounces-800658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DBCB43A31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16B2540ABC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F792FD1B5;
	Thu,  4 Sep 2025 11:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aOZTpZ8H"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1F233155
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985503; cv=none; b=Mt0mQAm9vR2oOrUX4iDwtnp7RrEpT3CYZWQamgZC1p1L3fXr60GW82XIujX4IQA96xmYaWvwqkEaynBBzY7ywBZ+YooDy6bykvJTla3oStBxGxaFlHjrl4ftkVR7a5SdFEOXVFOHeLJX/o2Gki5dfaCfXP9vRKLVB0xY1/GO4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985503; c=relaxed/simple;
	bh=tEmb3TS/Um42PL6DO7gFO5RTZKVXT4ONWWxUd8gjXp8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AzpG2tX4hQhsi37lrKEdUEzbbjm+aO1i+FTbXAZXsgPvwSbWWMN2YoAnXgBM3NI8sSdW50Q+dE/vjstmK/yeaok2o2Nj5X+Xx/1+dMlScu/DTEuGBJiOwTkbdch/q4RRe/nJC/3n3JyxprfZAKMoEwilwvsNe8DYrOPujC5f3Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aOZTpZ8H; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756985499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=3P2m5VDEe93c98S3nl5n9YXUtn/rtPjQU09VvLjkoDc=;
	b=aOZTpZ8Hh6ABLeXh0My4n87AEsXvSCBs3lzA5inhPmmlf6URyHnrCLzOjkYbcjy0JZtgTN
	HCDyt+Qv+ocFDZjKwZuD7fovqWD0kLPY4KKLKwnhzPZ7S/AJyBWDFgyZkGLYqt7d07fplc
	5WLkXAPw+eb1ogu1v3i+1HqFJIjb6Jw=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] workqueue: Remove redundant rcu_read_lock/unlock() in workqueue_congested()
Date: Thu,  4 Sep 2025 19:31:32 +0800
Message-Id: <20250904113133.24487-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The preempt_disable/enable() has already formed RCU read crtical
section, this commit therefore remove rcu_read_lock/unlock() in
workqueue_congested().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/workqueue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c6b79b3675c3..831754e90071 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6046,7 +6046,6 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
 	struct pool_workqueue *pwq;
 	bool ret;
 
-	rcu_read_lock();
 	preempt_disable();
 
 	if (cpu == WORK_CPU_UNBOUND)
@@ -6056,7 +6055,6 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
 	ret = !list_empty(&pwq->inactive_works);
 
 	preempt_enable();
-	rcu_read_unlock();
 
 	return ret;
 }
-- 
2.17.1


