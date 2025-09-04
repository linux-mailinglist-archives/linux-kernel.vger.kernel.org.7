Return-Path: <linux-kernel+bounces-800659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BE2B43A2E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 312707B41EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 11:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6192FD7CD;
	Thu,  4 Sep 2025 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rg1BXN0z"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26892F3607
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985505; cv=none; b=pcT8EVHgNKWmzh0Yld5LRaKUGpTI9Xpwes/oGbCukezTzlOe/Zzu474XSc1pFhW7zpWBlZbVQe/ABdMmR9AE0P5xvuk3NQHtCA6pj4jog1dWrXfhSi+ideDRWgV7IuibL66ADP3wW+19DE4rYIecz/u7MlfzskvdeD3bOGObnew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985505; c=relaxed/simple;
	bh=EAoBbbVmSRmbNZa5BV4QC/YYqqMmItDW+fEgPkvRvVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Y3kXWXtGJymJl3nVyPtPAGxoF4k3OM6scYZwlruznR9y4MEHmIZLT/Vgo4puz3ef0gyfbZ5cnyARlJAlrZ0e6/7vmMnt70tSW8xJFnWUotvzY6PPFfOYQc4AJBkI1/FvlROURlkoWMWq1OGZ6OUjSd21k2zM7Qxw1k4Jj6T5I1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rg1BXN0z; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756985501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=gYz0fWZ4h/RACuX13dZ0pm+0iSLijaSXJ7iE8QkES48=;
	b=Rg1BXN0z2vIoEcFM68HhqIaJWB/h+iAMN3V8Qgz05RKvfY3LYLP6OGGm6NSsOnLy3zeYs6
	jFJaSA4rqiRin2OCNEwtOOciseCQAvs/wmHrTlvFAGkZTxdSJ1w93mK9qA171Yy/PNsrdm
	JPkRJcJAAhREAb0pVfYWLVc1NNQJsYE=
From: Zqiang <qiang.zhang@linux.dev>
To: tj@kernel.org,
	jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	qiang.zhang@linux.dev
Subject: [PATCH] workqueue: Remove rcu_read_lock/unlock() in wq_watchdog_timer_fn()
Date: Thu,  4 Sep 2025 19:31:33 +0800
Message-Id: <20250904113133.24487-2-qiang.zhang@linux.dev>
In-Reply-To: <20250904113133.24487-1-qiang.zhang@linux.dev>
References: <20250904113133.24487-1-qiang.zhang@linux.dev>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The wq_watchdog_timer_fn() is executed in the softirq context, this
is already in the RCU read critical section, this commit therefore
remove rcu_read_lock/unlock() in wq_watchdog_timer_fn().

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/workqueue.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 831754e90071..63b2685c2cb4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7544,8 +7544,6 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 	if (!thresh)
 		return;
 
-	rcu_read_lock();
-
 	for_each_pool(pool, pi) {
 		unsigned long pool_ts, touched, ts;
 
@@ -7587,8 +7585,6 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 
 	}
 
-	rcu_read_unlock();
-
 	if (lockup_detected)
 		show_all_workqueues();
 
-- 
2.17.1


