Return-Path: <linux-kernel+bounces-809887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C251B5132E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0341C25327
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D1925DB06;
	Wed, 10 Sep 2025 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hYYJaIOa"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F3C1DFF7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497873; cv=none; b=rloOm47Y2oLLHzqotSBRq9qdiTconoTRW6kY5oLw0AGvU1k0W2BVh2RuqyB9XO2lAkuQX+YjBr+PbfPsx68yhDjzKv+U07S95BftD0Go1zKMDhkDhtltVbH5a2HqivenjokL/BqU/aJIYTfzGAjcTH/vQPCwVBM0nyg1pkQoJZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497873; c=relaxed/simple;
	bh=AX7DJgKmuwY1JHqB34E9VPYI7r8lViLIWSnF1A1HikY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=njMypAvChFAFeYxGmwBZKZ/W7wEsBilgoUurr7D1t+3gBm5SLUprL8tOYr+imhX5dXz1b10lB9EcOtOxa0VQcL4jSh1ea0Surjcegb/RmBKqZLhJT1bWkXJ4jb9Q6dG4A2Fs0qGQoOrXoJbLrXcFn7Y+FmNZK8f4WQ45SSsQ/ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hYYJaIOa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-772627dd50aso469147b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757497871; x=1758102671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hwnY1xbsQsVWYPohOmtJfOKnNCQAY4lc0iZDXl0QLc=;
        b=hYYJaIOaJ3R6RsvJHuLRXDlJMOAQzYmjRsJJwy5U24iRGnlBuR9RNYndm4kjigIEEZ
         ngi1yUY/TWvEnBMyV1jrwEBJQzOIHpHzyzKtu8v0mI5V4CnsPPYuJIcQDvcOLZco4AEt
         qjAuUtxWtmG/LyofvahsQHI6RSIkkkKUJg7tbGPhPdXPNySU0Ut6br4ssiojjoo2c7UU
         aiPs8+2UZpKeqNfdt3jz6Z+c5mwx/VmR5SbKScmnA1bzcbE/DAINZcPjy1EJkM4MIlYo
         MRk7aJJ7tpWVscHPDhpXmZK7Q03KySpvq/s4jjFPsx8WQfKbbhT354nLH0AuUPTNtyEz
         BOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497871; x=1758102671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hwnY1xbsQsVWYPohOmtJfOKnNCQAY4lc0iZDXl0QLc=;
        b=jcGDMlkbNhUG7CpELrWC7AF9uWwjao6BvpmkmYJ6LasxWkTj0/yPvYMR3r6SQM/ySN
         yLmq2cuIfb0uo9Rl3C1ttLwQ5ggr7xYR6jf/n87WwCECnImfeF1auQvIdQIjpfjcxWRG
         hCiUAVDrEJsi0kF9K0zV+1RkOwvdXk7RtEiriGF409GIUFZIKubjjCeZRPaPF/iLlHYU
         gxt44JamIKjrqWHx9RifYqi8yTC5HTVzHIFuc7BuMEcJPt1V6AxWEA4n8OCec3eNDK8V
         fKupP77jezCKptTrpiiMr6IY9TsMdZDFQyCYZaH9oPCyja+D9Tpej2UvcNbTnBRAZ8Td
         EpIQ==
X-Gm-Message-State: AOJu0Ywdr6iL7JEYPHKZJZLqMOghIEO0KIqrKVN5hnrWXXvwtcPlJNwa
	8pAoimUTtuE2qtBERIFgQlo6M0oizshJSlQ7EYkZ9ck45GGJGktLWtfGW3c3Q7VLhQ==
X-Gm-Gg: ASbGncuAWxQsqgyvXGbrlfLCXEVY1um+E+5HR5WyxIG22BztzhRN8dQ9fbb4L+Om+DP
	TkV0NhGb2l0XjrKqFfoR5ZH8NBYqaJMhq/dCMElYzSe0g+YIvjwcob4/2UKYJXK988qIGIUgz8Y
	ubcs9W6wZa0MtU6VUY2wyc20JNv18CUR5O/czxmCZnUhgwh6lA0MvxxW1JTooZzi4rCpbvFWj5N
	QyTYB7IaAmnXBmPDwgeeNeizOwPHrsHGgcI5EXTerTUrbT1a8BVvTl2u8FHAIJc2ig996joHxU/
	fr3xjvWtuZyGuZiYciDTv1ITt/3Fx6fjqQuYlpc+bpuTT+HefxxJ216Px6mViGZcjPHiEPWVvRn
	WLQ4Eq6dowyW7xqoBCYXwJz6yyQIz13RZUBgmLMg9LHCE9MEsj1HvKJm3o8MQsD9kJfP3erHzBG
	8=
X-Google-Smtp-Source: AGHT+IGEt1O774I1Gfw72/Z9hsnCoDWdTF+fzrOjKaCYbYtP4yrLq7WfyATRGLAXIYyRtV1THGki8g==
X-Received: by 2002:a05:6a20:1596:b0:248:ef8:66df with SMTP id adf61e73a8af0-24e87b2898dmr32078846637.30.1757497870911;
        Wed, 10 Sep 2025 02:51:10 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548b81f5acsm1850623a12.1.2025.09.10.02.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:51:10 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/4] sched/fair: Propagate load for throttled cfs_rq
Date: Wed, 10 Sep 2025 17:50:41 +0800
Message-Id: <20250910095044.278-2-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250910095044.278-1-ziqianlu@bytedance.com>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before task based throttle model, propagating load will stop at a
throttled cfs_rq and that propagate will happen on unthrottle time by
update_load_avg().

Now that there is no update_load_avg() on unthrottle for throttled
cfs_rq and all load tracking is done by task related operations, let the
propagate happen immediately.

While at it, add a comment to explain why cfs_rqs that are not affected
by throttle have to be added to leaf cfs_rq list in
propagate_entity_cfs_rq() per my understanding of commit 0258bdfaff5b
("sched/fair: Fix unfairness caused by missing load decay").

Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df8dc389af8e1..f993de30e1466 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5729,6 +5729,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 	return cfs_bandwidth_used() && cfs_rq->throttled;
 }
 
+static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
+{
+	return cfs_bandwidth_used() && cfs_rq->pelt_clock_throttled;
+}
+
 /* check whether cfs_rq, or any parent, is throttled */
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
@@ -6721,6 +6726,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 	return 0;
 }
 
+static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
+{
+	return false;
+}
+
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
 	return 0;
@@ -13151,10 +13161,13 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-	if (cfs_rq_throttled(cfs_rq))
-		return;
-
-	if (!throttled_hierarchy(cfs_rq))
+	/*
+	 * If a task gets attached to this cfs_rq and before being queued,
+	 * it gets migrated to another CPU due to reasons like affinity
+	 * change, make sure this cfs_rq stays on leaf cfs_rq list to have
+	 * that removed load decayed or it can cause faireness problem.
+	 */
+	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 		list_add_leaf_cfs_rq(cfs_rq);
 
 	/* Start to propagate at parent */
@@ -13165,10 +13178,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 
-		if (cfs_rq_throttled(cfs_rq))
-			break;
-
-		if (!throttled_hierarchy(cfs_rq))
+		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 }
-- 
2.39.5


