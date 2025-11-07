Return-Path: <linux-kernel+bounces-889761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5B2C3E74D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 05:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 590323AC7B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 04:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D20923645D;
	Fri,  7 Nov 2025 04:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pUm4QSQw"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106A013D51E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762490294; cv=none; b=CP6782qPtJ3rgGFNgUwCkQVcbLnFG9dxzmTHyPfmC95z3eHlVAhq6GkBQf+l9fhNyjWcdPb0X8tclgJ+O7XV5YaptgI9ZaWiME9d5O0S5IcqkhQJ87fHL4tsgExj3y5dcPXpL5+x46gkI3IOHAJDkUHB9KqKVUBm2ugzn7z8QwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762490294; c=relaxed/simple;
	bh=wIWs2iDM+S5H4IBmphBmWyqozqQ+5W7vo9pFBotx1w0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e0GFt3JHhwFTOvqr5rDPn8iTMrfYdUC1Ix9nFqNNO654QsA3C5ct+/E83k6yJT6dZCJM306PY/apAr3cNG0xkq8Gf8Ll+r53Pf9Zxf4W/UMcTMd2l32iB2L7BpMIa1HmxwUPRlER1OzMzL/UtazkSyGYTYWFOkISK0lK/+Ti4+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pUm4QSQw; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zecheng.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8b21dfdfd00so92105885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 20:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762490292; x=1763095092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MzgbBXKhcbKM9AgDj4L6etW4gGMqP1OB0Ze+8gJkHw=;
        b=pUm4QSQwbDaWcWPIawcCHRjRcgoqSsl6WfrptE9fVfwFPy1ktKn56gsjYKKDqaW1Mr
         VCsMFbXltMC3j9slgbaTqbu2rTH93YNSUeHEUCS6R2DtP2jTwZ8zAnriUvTeq3ziq+jd
         mD6ze+kYTD8WPFRwiUG4di6ay2nkaRPA9ERhSnhqDHIX8q0RVLbL4UUjseeIZFJmXdKJ
         WtWDQSmHAXHkek1d7b0kfKuNWNq3kR+4xAaAJI+x1As2z4qkP3LDucUeQ9uXj++Q1fJC
         svRqytEiHXwtisUq5izcriRKSFBdwdIVLEAHh0UA1l9fsGgz98kf/r/b3PHLFwPEjsem
         Lpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762490292; x=1763095092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MzgbBXKhcbKM9AgDj4L6etW4gGMqP1OB0Ze+8gJkHw=;
        b=uWxuKFtK5jrQHexbg8/bxTTQrF0H5uZ9KFn3toT42dMPjNwcqaAJp0HpHLBffZ3TB6
         30ez2AwgyszJftYBCbQVaUZA1tZ6MsLGMWBPhlx59/cVjMdqd76ZL7pTtwWv2xOgD/3B
         ppT4/sPqDZD3N9qZ37ARaEUO3GujXwlNb1jnH03J9ENptBj8mh8LBKtTaaojAQI/P6fr
         4XYlvCh9jTpX416pDCgQJxJSSl3Ej81DcXsioBHjfGlM6ikJl1z2+PNQ+C1mzAZ2g/am
         4dROl1fUfS8OqndEk/5lOZv+i4ajz9OnBOpYrn2ZhUdaX32Rebkxm9mNV/jHImICfHfY
         H5KA==
X-Forwarded-Encrypted: i=1; AJvYcCVnuWVOcvUEEc2WWQws+e8pK5vH+IQrj7rZHLizboYrCOeodtMce1/ccV53Rnc0NzIh5lv5HpqeRIXSgaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4MhxFZGaSx753gBJYkmLvZHgbZfEPB4zns+AEjcAVeUHvshN
	HizuTJufsUU6vCNXUubtkMa1v/E8c8nHxmx2Nf2KQvJ+MUp2wNK+ZMeRp3AAsHizQh/MdpadENa
	RkHEwRViDNA==
X-Google-Smtp-Source: AGHT+IE6RDEiLwcasbBdE0LPNjDhpsGZDA4EiihKALekxMSwJpfjCJY24Bcafcx9a6gHqSOR398clf2PRutl
X-Received: from qkao13.prod.google.com ([2002:a05:620a:a80d:b0:8b2:4d20:bb9f])
 (user=zecheng job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:29c4:b0:891:ae32:d696
 with SMTP id af79cd13be357-8b24534f829mr299898785a.66.1762490291964; Thu, 06
 Nov 2025 20:38:11 -0800 (PST)
Date: Fri,  7 Nov 2025 04:38:03 +0000
In-Reply-To: <20251107043807.1758889-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107043807.1758889-1-zecheng@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107043807.1758889-2-zecheng@google.com>
Subject: [PATCH v5 1/3] sched/fair: Co-locate cfs_rq and sched_entity
From: Zecheng Li <zecheng@google.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Rik van Riel <riel@surriel.com>, Chris Mason <clm@fb.com>, 
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>, Xu Liu <xliuprof@google.com>, 
	Blake Jones <blakejones@google.com>, Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org, 
	Zecheng Li <zecheng@google.com>
Content-Type: text/plain; charset="UTF-8"

Improve data locality and reduce pointer chasing by allocating struct
cfs_rq and struct sched_entity together for non-root task groups. This
is achieved by introducing a new combined struct cfs_rq_with_se that
holds both objects in a single allocation.

This patch:

- Defines the new struct cfs_rq_with_se.

- Modifies alloc_fair_sched_group() and free_fair_sched_group() to
allocate and free the new struct as a single unit.

- Modifies the per-CPU pointers in task_group->se and task_group->cfs_rq
to point to the members in the new combined structure.

Signed-off-by: Zecheng Li <zecheng@google.com>
---
 kernel/sched/fair.c  | 23 ++++++++++-------------
 kernel/sched/sched.h |  8 ++++++++
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 273e2871b59e..1676119e302b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13359,10 +13359,11 @@ void free_fair_sched_group(struct task_group *tg)
 	int i;
 
 	for_each_possible_cpu(i) {
-		if (tg->cfs_rq)
-			kfree(tg->cfs_rq[i]);
-		if (tg->se)
-			kfree(tg->se[i]);
+		if (tg->cfs_rq && tg->cfs_rq[i]) {
+			struct cfs_rq_with_se *combined =
+				container_of(tg->cfs_rq[i], struct cfs_rq_with_se, cfs_rq);
+			kfree(combined);
+		}
 	}
 
 	kfree(tg->cfs_rq);
@@ -13371,6 +13372,7 @@ void free_fair_sched_group(struct task_group *tg)
 
 int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 {
+	struct cfs_rq_with_se *combined;
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
 	int i;
@@ -13387,16 +13389,13 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 	init_cfs_bandwidth(tg_cfs_bandwidth(tg), tg_cfs_bandwidth(parent));
 
 	for_each_possible_cpu(i) {
-		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
+		combined = kzalloc_node(sizeof(struct cfs_rq_with_se),
 				      GFP_KERNEL, cpu_to_node(i));
-		if (!cfs_rq)
+		if (!combined)
 			goto err;
 
-		se = kzalloc_node(sizeof(struct sched_entity_stats),
-				  GFP_KERNEL, cpu_to_node(i));
-		if (!se)
-			goto err_free_rq;
-
+		cfs_rq = &combined->cfs_rq;
+		se = &combined->se;
 		init_cfs_rq(cfs_rq);
 		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
 		init_entity_runnable_average(se);
@@ -13404,8 +13403,6 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 
 	return 1;
 
-err_free_rq:
-	kfree(cfs_rq);
 err:
 	return 0;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d04e007608a3..8db53f4d4d06 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -769,6 +769,14 @@ struct cfs_rq {
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
 
+#ifdef CONFIG_FAIR_GROUP_SCHED
+struct cfs_rq_with_se {
+	struct cfs_rq		cfs_rq;
+	/* cfs_rq's sched_entity on parent runqueue */
+	struct sched_entity	se ____cacheline_aligned;
+};
+#endif
+
 #ifdef CONFIG_SCHED_CLASS_EXT
 /* scx_rq->flags, protected by the rq lock */
 enum scx_rq_flags {
-- 
2.51.2.1041.gc1ab5b90ca-goog


