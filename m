Return-Path: <linux-kernel+bounces-899823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B0DC593B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B286A4F75C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8557F2F83B5;
	Thu, 13 Nov 2025 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd+brwPR"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC533BBCD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051439; cv=none; b=S8JAX1p03fF11p6z4C9TWuM76pb12C9wY8eoCqbgyCQSir2R1940jXgQ7moZsfkvxKD1RU474EzaRZmDlok+3b9ObcLuF+3nnpIXGBxymrEQq9loCfUcgf9rD1svxwwoPLWEPABMYhi8XgYF3pmvhMhLworjwaslDtfNtUoE6kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051439; c=relaxed/simple;
	bh=lDcbgzKm1A1BDV3SM0DPx/JiXa8W6wK14N811bSt92Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=APaBibHNXgR1XFQljv+X/0RB1+iCEKU+eIJD01CTpMkB1C+PpZn7Wj3AKE1ScR+LEgEddeq8FhHYV+0tPvQhBV25zj2/LBKB6kHuA4wRQB9c2vdPjasa+OpYNbweoIaeQulwR2PrTflkNsR/t4b+cZ1o4mw5RsHVxYs7N+myzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nd+brwPR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7af603c06easo1180488b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763051437; x=1763656237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WEPEw95TUeNoEGxsn2I81dzYb8IydIwfTBuC8qkSEz8=;
        b=Nd+brwPR/KhW0Fq3LF7yUlBIxK/canIcPxCqLa50MI2z6Q3Qcw2cuwIuSa4lyWU8FX
         6poT5IWWPg96QZ64cEZG7z/S7CspiKCdfMDP80VdY1RKfDYI0znRHsA2JLjSftHjt37w
         F9NnYFzsGrwTW/Yh4EvEbkan3OmDgT9aUglzfcWJ5fZNdCT+9Y+uW4cpuN7GlwnPgTkx
         dHPNGMEXHuE4Stcy74SUJ096jpAj3T+hqkCZthgdqjX8NzBqbUz43Qgx5y/N/Mxy5OEh
         0WT8tiA10fU/zCA6VOolzJ4IwTWRnWO+u+x/8E8DONh1sQW0UCg1kRzOZo3qjaV6CVsx
         0NBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051437; x=1763656237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEPEw95TUeNoEGxsn2I81dzYb8IydIwfTBuC8qkSEz8=;
        b=asBxjzP2H2LIO/5s7mXRpJXIgQZr0i1X/YJxeqzVGzG1DCAjFaQCDS6UtpR9WKY1qB
         kser/fCADN3oUn/CkTZ8Low2WtsV/oS8XXFC0lAZQl6gpE8h6BiQ958kXNgcoiSV6Odw
         7zuhZG0823tDrB8OaP0OVv4H13MS51/ACccgiOU82BbA48AwZW3CHwRN5iGSJmN2dRx3
         JU8s18m8P9/6OnbZl4JkzVsHDGLixYoJChgpiZ/xD1A2NkcNLzVROMdUI8y1wam9zcNC
         BJJbSUpgEwRacdlNSdXwLME4XrG4JvyjSAGG2oogTs4A8wrRtmd0py9rqTY3WSYLrTo9
         OiIQ==
X-Gm-Message-State: AOJu0Yw/0zAp1balkU/MslqOOLE9GHceUrCkill2k5eNj7hsAILA09Ni
	eZ9JDHMD3vEqlXDDe1NIQPn/oJQb8qkEkGTVkloUCBciEGCHxyn6iyxo1N++DT2cy+k=
X-Gm-Gg: ASbGncvPYSTnGV205z30lT6CAnxfuWEQOkwRR5YnhSCafSEqbo/8rOyceh3GayU9ywk
	GnAJtv3FNU7+jJdSTXOra8igEmpSA+dWF/6oDWLc1i0pi9u1kNk/Rs/RwenI60kUJHF2M5eDGJ8
	DtRzjzIpLR3fWj9e4jSsNiTsAC8XTCaDFww9TUcrGgEI8JfHvCzwuEcwhqYUlqCWva+Zc4TmOk1
	MuLjzpX6SYvSHaNAAtJhU6CcngX5pjI7bFimCjsSzZtEmMx9bRDSc+yj2BWwbKjz8qBIvPx0BCt
	tlVGa+xHcsOhqX+53rw/kavp18/0BUIDSky0lJrNTvqFHH5E/pb7ykSjvAup9gNz72Xj9CgGbY1
	bcTS2d30gxzTisKw6Z2r8+ni/0JFM1nUdgwcJ6F3kvP4woEJvItj9SLrQuWFV8YreA72R/tKvXU
	2h
X-Google-Smtp-Source: AGHT+IHTr+cr4pD2Q5L/4iOAGLsSCPeig0jxKP7Dee7DZpSlHoYA71JGE/ocPsbi5QvLfJrQsxjvtQ==
X-Received: by 2002:a05:6a20:748a:b0:342:1aab:4c88 with SMTP id adf61e73a8af0-35a52789f2dmr5557689637.29.1763051436730;
        Thu, 13 Nov 2025 08:30:36 -0800 (PST)
Received: from localhost ([240b:4000:bb:1700:7b36:494d:5625:5a1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc375177be4sm2643794a12.19.2025.11.13.08.30.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Nov 2025 08:30:36 -0800 (PST)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	ying chen <yc1082463@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Process rescuer work items one-by-one using a positional marker
Date: Fri, 14 Nov 2025 00:34:26 +0800
Message-Id: <20251113163426.2950-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Previously, the rescuer scanned for all matching work items at once and
processed them within a single rescuer thread, which could cause one
blocking work item to stall all others.

Make the rescuer process work items one-by-one instead of slurping all
matches in a single pass.

Break the rescuer loop after finding and processing the first matching
work item, then restart the search to pick up the next. This gives normal
worker threads a chance to process other items and prevents a blocking
work item from stalling the rest once memory pressure is relieved.

Introduce a positional dummy work item to avoid potentially O(N^2)
rescans of the work list.  The marker records the resume position for
the next scan, eliminating redundant traversals.

The positional marker also has an additional benefit:
if it is processed by a normal worker rather than the rescuer, this
indicates that the pool has made forward progress. In that case, the pwq
does not need to be rescued until the next mayday event, allowing the
rescuer to focus on other stalled pools.

Processing items one-by-one also naturally handles newly scheduled work
items during rescue.  For example, work items dispatched via
pwq_activate_first_inactive() or chained queueing will be picked up in
subsequent rescuer iterations without special handling.

Reported-by: ying chen <yc1082463@gmail.com>
Cc: ying chen <yc1082463@gmail.com>
Fixes: e22bee782b3b ("workqueue: implement concurrency managed dynamic worker pool")
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 99 +++++++++++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 32 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 45320e27a16c..af182a19a8b1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -286,6 +286,7 @@ struct pool_workqueue {
 	struct list_head	pending_node;	/* LN: node on wq_node_nr_active->pending_pwqs */
 	struct list_head	pwqs_node;	/* WR: node on wq->pwqs */
 	struct list_head	mayday_node;	/* MD: node on wq->maydays */
+	struct work_struct	mayday_pos_work;/* L: position on pool->worklist */
 
 	u64			stats[PWQ_NR_STATS];
 
@@ -2982,6 +2983,50 @@ static void idle_cull_fn(struct work_struct *work)
 	reap_dying_workers(&cull_list);
 }
 
+static void mayday_pos_func(struct work_struct *work)
+{
+}
+
+/**
+ * insert_mayday_pos - Insert the positional work for mayday
+ * @pwq: The pwq that needs to be rescued
+ * @next: The next work where positional work will be inserted before
+ *
+ * CONTEXT:
+ * raw_spin_lock_irq(pool->lock).
+ */
+static void insert_mayday_pos(struct pool_workqueue *pwq, struct work_struct *next)
+{
+	unsigned int work_flags;
+	unsigned int work_color;
+
+	__set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&pwq->mayday_pos_work));
+
+	/* The mayday positional work item does not participate in nr_active. */
+	work_flags = WORK_STRUCT_INACTIVE;
+	work_color = pwq->work_color;
+	work_flags |= work_color_to_flags(work_color);
+	pwq->nr_in_flight[work_color]++;
+	insert_work(pwq, &pwq->mayday_pos_work, &next->entry, work_flags);
+}
+
+/**
+ * remove_mayday_pos - Remove the inserted positional work
+ * @pwq: The pwq that needs to be rescued
+ *
+ * WORK_STRUCT_INACTIVE ensures that the pool lock is not dropped in
+ * pwq_dec_nr_in_flight()
+ *
+ * CONTEXT:
+ * raw_spin_lock_irq(pool->lock).
+ */
+static void remove_mayday_pos(struct pool_workqueue *pwq)
+{
+	list_del_init(&pwq->mayday_pos_work.entry);
+	pwq_dec_nr_in_flight(pwq, *work_data_bits(&pwq->mayday_pos_work));
+	INIT_WORK(&pwq->mayday_pos_work, mayday_pos_func);
+}
+
 static void send_mayday(struct work_struct *work)
 {
 	struct pool_workqueue *pwq = get_work_pwq(work);
@@ -2992,6 +3037,9 @@ static void send_mayday(struct work_struct *work)
 	if (!wq->rescuer)
 		return;
 
+	if (!work_pending(&pwq->mayday_pos_work))
+		insert_mayday_pos(pwq, work);
+
 	/* mayday mayday mayday */
 	if (list_empty(&pwq->mayday_node)) {
 		/*
@@ -3508,41 +3556,27 @@ static int rescuer_thread(void *__rescuer)
 
 		raw_spin_lock_irq(&pool->lock);
 
-		/*
-		 * Slurp in all works issued via this workqueue and
-		 * process'em.
-		 */
-		WARN_ON_ONCE(!list_empty(&rescuer->scheduled));
-		list_for_each_entry_safe(work, n, &pool->worklist, entry) {
-			if (get_work_pwq(work) == pwq &&
-			    assign_work(work, rescuer, &n))
+rescan:
+		/* If the positional work is processed by a normal worker,
+		 * the pwq doesn't need to be rescued. */
+		if (work_pending(&pwq->mayday_pos_work)) {
+			/* scan from the positional work to avoid potentially O(N^2) scanning */
+			work = &pwq->mayday_pos_work;
+			list_for_each_entry_safe_continue(work, n, &pool->worklist, entry) {
+				if (get_work_pwq(work) != pwq)
+					continue;
+				if (!assign_work(work, rescuer, &n))
+					continue;
 				pwq->stats[PWQ_STAT_RESCUED]++;
-		}
-
-		if (!list_empty(&rescuer->scheduled)) {
-			process_scheduled_works(rescuer);
-
-			/*
-			 * The above execution of rescued work items could
-			 * have created more to rescue through
-			 * pwq_activate_first_inactive() or chained
-			 * queueing.  Let's put @pwq back on mayday list so
-			 * that such back-to-back work items, which may be
-			 * being used to relieve memory pressure, don't
-			 * incur MAYDAY_INTERVAL delay inbetween.
-			 */
-			if (pwq->nr_active && need_to_create_worker(pool)) {
-				raw_spin_lock(&wq_mayday_lock);
-				/*
-				 * Queue iff we aren't racing destruction
-				 * and somebody else hasn't queued it already.
-				 */
-				if (wq->rescuer && list_empty(&pwq->mayday_node)) {
-					get_pwq(pwq);
-					list_add_tail(&pwq->mayday_node, &wq->maydays);
+				/* reset the position and handle the assigned work */
+				if (list_next_entry(&pwq->mayday_pos_work, entry) != n) {
+					remove_mayday_pos(pwq);
+					insert_mayday_pos(pwq, n);
 				}
-				raw_spin_unlock(&wq_mayday_lock);
+				process_scheduled_works(rescuer);
+				goto rescan;
 			}
+			remove_mayday_pos(pwq);
 		}
 
 		/*
@@ -5162,6 +5196,7 @@ static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 	INIT_LIST_HEAD(&pwq->pending_node);
 	INIT_LIST_HEAD(&pwq->pwqs_node);
 	INIT_LIST_HEAD(&pwq->mayday_node);
+	INIT_WORK(&pwq->mayday_pos_work, mayday_pos_func);
 	kthread_init_work(&pwq->release_work, pwq_release_workfn);
 }
 
-- 
2.19.1.6.gb485710b


