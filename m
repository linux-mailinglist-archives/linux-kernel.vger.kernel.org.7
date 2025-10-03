Return-Path: <linux-kernel+bounces-841696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E35ABB8027
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 21:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 047873B5479
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 19:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E25A23B61E;
	Fri,  3 Oct 2025 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czwRrBOu"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB23D221F26
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 19:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521260; cv=none; b=LeX2sroOAh0xkjJ/Ks6qofyhx7TE9Jn9M13kLzZcMLI7AJAVpwghe+UJp71zBXzlYET8q3MVEHkyPciQRP7Qt8VnQS9Gqq9TgdnBKP13WRpcCC4Sr0Jk+K95VFXI0h9jNwL6AmMZvg3H/NfZNfKHCRlASU8m31Z6iPOz+9vdDOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521260; c=relaxed/simple;
	bh=GkNgdKcnmVi9+/B+M+46U59wKu6VH1KFNJYzGItdEhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0rIJYZ4ssdyId6fT6VN5HbVy9fD6WmZ8dDNkj0vBtb9dw0PH8aNGQYf5o3BxLVqoxnfMW1aOzZajicB7JvjZIHILP70GtbgVCsgwg+F69rB2wH58pErakP2EulamU3Ty3Sqlkze4WyEj51OZjH8YYEyhDj7qU/YmhwxFxp/uCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czwRrBOu; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-42f5e9e4314so8327815ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 12:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759521257; x=1760126057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMp+XHfNq1nZpZJaFDK8t9UIIN13yunZQqK1KQ41Wew=;
        b=czwRrBOurknv6mijwM6YBUX7IOdSZNnFpKzacq8mPyZOwRC2cVhfErWk9OOsVzWCz3
         Igys9wDp1PEprNg0mp45np/A+hzxAh7ljnV9wmTO7snKJSJfnA5VWCaIzaURsAnsX9Zl
         7PIUZLknZFKzskLDnpSK877/BE8iEjW+SxH7JotCUdJYT9IaMJXIHnE8luaqern3TqGL
         AAJGkHYMkGrnlM3uWx15C6/XDbw4GBaBNR+Jyr7AJp8Qm0HPo1j/6V5HD+JljyHx/dcT
         o6WfJwxSWlcWckZE4B+E/Vti2PsoPPk1wh2W0cXG3KaGCGOAtnEykMR0RxcNWeEL9cMX
         kOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759521257; x=1760126057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMp+XHfNq1nZpZJaFDK8t9UIIN13yunZQqK1KQ41Wew=;
        b=Y2HNFBNFGo9ZMukZbzg7WO/MPIJVf8MM0n1kt22EIjTtFBi9lO+jgk15vKzB4wF9tS
         BORCVkOQ1YWb8TX8q0IQexLi0cCHQpKnLDRYXg5kiqewU3b97nMgBweKS5AKUedCg4uy
         NwpyhAuAkGFIdo/6WChznoWt7A8ze3tLhrwEWPx7ZPPQ7+u1P2wwCnSMBs3Ka5ysOKG0
         Aw7LXtmlG+Q4GaTNmd4wU94LgMV0r/YnhIdH1mA649DF3C+wYpedzXR8Me3b5x2pWQgm
         zU5r5SSz7WDIflqw0kx0xEZe2a3DvMoRu+Ht/dOiAgN4SFyK9qVgfThYj1ferIRpgrE9
         gZUA==
X-Gm-Message-State: AOJu0YwrMjF0MFYgRevfmcgXD5I4bEsEoQ6f5k2NsNH4x78F4kQqVg8o
	jUgQsj0AvP8Bmq2K/CghLfnIXTDbPMTqiz2M+z90UPGb4fdTwA6oCPcPXSuYuL79
X-Gm-Gg: ASbGncsfSpJlftXPptBSV7udTESoC1Q4l3ghkuJOjSFtHPZcB5c3CjqwGs9ENNdPlmm
	BT4khp/IyQv8ZAudiTodastqyEBavakGux2/8Gij5FmVIOM+0z6VSiPNyOJFGzERIsPh9sLM41u
	Oz5vqbyrGohrKJusHsHEZCOy4Fj9qP0QkW81qsgDdMvzAP7msSrgZhtrGM20jTB3xwDE7GDcXt7
	sV6Xpv0/aCjiVtdJcTN4PvQec7HEksFH7Bd2SM1Vyrd9YQPoxUwq1gkSI3+XpmfFgiVsWYHIVBC
	B/1mdo4B/VXHtdWcy6MClwIXnTpEub8/tjgctqVidpEn9Ivw6u544cHDpwrA4A2nnbfQ+PBPX1l
	RAQlzGCs/p8J7kQLNKZcdQweuFlhxd/RXJhwJpl8qrpAsaITpKCtKzjPxL47oAWosz+cCIIChZa
	ALcHn766T/QdC29QOg6atHrQuGAMG4Lgl3qkyU/12uqEyo6EGYEhsd2ao5
X-Google-Smtp-Source: AGHT+IFQq2tzXBb8pGJy0qlKDCFi99sDxKwKKAyXjgAgc7tyG0D296gU4ZRzy+caryXGUg13+peFjA==
X-Received: by 2002:a05:6e02:16c6:b0:42e:712c:b15 with SMTP id e9e14a558f8ab-42e7acd2c6bmr54475085ab.1.1759521257174;
        Fri, 03 Oct 2025 12:54:17 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ebc8181sm2296390173.47.2025.10.03.12.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:54:16 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	arighi@nvidia.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v2 2/3] sched_ext: optimize first_task update logic
Date: Fri,  3 Oct 2025 15:54:07 -0400
Message-ID: <20251003195408.675527-3-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003195408.675527-1-rrnewton@gmail.com>
References: <20251003195408.675527-1-rrnewton@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Newton <newton@meta.com>

This is a follow-on optimization to the prior commit which added a
lockless peek operation on DSQs. That implementation is correct and
simple, but elides several optimizations.

Previously, we read the first_task using the same slowpath, irrespective
of where we enqueue the task. With this change, we instead base the
update on what we know about the calling context. On both insert and
removal we can break down whether the change (1) definitely, (2) never,
or (3) sometimes changes first task. In some cases we know what the new
first task will be, and can set it more directly.

Signed-off-by: Ryan Newton <newton@meta.com>
---
 kernel/sched/ext.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ea0fe4019eca..53d7ba64a483 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -965,8 +965,11 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 				container_of(rbp, struct task_struct,
 					     scx.dsq_priq);
 			list_add(&p->scx.dsq_list.node, &prev->scx.dsq_list.node);
+			/* first task unchanged - no update needed */
 		} else {
 			list_add(&p->scx.dsq_list.node, &dsq->list);
+			/* not builtin and new task is at head - use fastpath */
+			rcu_assign_pointer(dsq->first_task, p);
 		}
 	} else {
 		/* a FIFO DSQ shouldn't be using PRIQ enqueuing */
@@ -974,15 +977,20 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			scx_error(sch, "DSQ ID 0x%016llx already had PRIQ-enqueued tasks",
 				  dsq->id);
 
-		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
+		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT)) {
 			list_add(&p->scx.dsq_list.node, &dsq->list);
-		else
+			/* new task inserted at head - use fastpath */
+			dsq_set_first_task(dsq, p);
+		} else {
+			bool was_empty;
+
+			was_empty = list_empty(&dsq->list);
 			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
+			if (was_empty)
+				dsq_set_first_task(dsq, p);
+		}
 	}
 
-	/* even the add_tail code path may have changed the first element */
-	dsq_update_first_task(dsq);
-
 	/* seq records the order tasks are queued, used by BPF DSQ iterator */
 	dsq->seq++;
 	p->scx.dsq_seq = dsq->seq;
@@ -1035,9 +1043,11 @@ static void task_unlink_from_dsq(struct task_struct *p,
 		p->scx.dsq_flags &= ~SCX_TASK_DSQ_ON_PRIQ;
 	}
 
+	if (dsq->first_task == p)
+		dsq_update_first_task(dsq);
+
 	list_del_init(&p->scx.dsq_list.node);
 	dsq_mod_nr(dsq, -1);
-	dsq_update_first_task(dsq);
 }
 
 static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
-- 
2.51.0


