Return-Path: <linux-kernel+bounces-731332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B7B052AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B6417DAED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF9B2749EA;
	Tue, 15 Jul 2025 07:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BS9ZkBX7"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993D2749C0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563859; cv=none; b=lY0MfLU0yK22oiRiUEgZ2atQ8k63Lf1xfBZZ/gYYV7vxYSYAXTEHmo3Y+EBnzZ4zuwCg/PyaU0Gg/QfEx1R8omdo1imq6sMVQn9fCFgy0/rd/0VH8u964vqNM4FHulHTPymaPkyXVfv9RyX4uizmTSi90LTeVRAnNwONok8to88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563859; c=relaxed/simple;
	bh=kv4q1+GtNsNWkkzIL7fvKJeWh15IGR2DYt5dRt6h4h8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ik+C3N4A3TqUap+IxLGY89upBRw+ButzJuZ9ryWz7eu/urbFLx2z3yef1ezwUnJ/7Uw+V1j+0Xiqr5ItMx74KoC3dVcM38Cj1NCnT2F+nQDpLDIc2f5DeksljHVWmRzn/Z6gMDa6OunQmydQXQj08fJ0UoNCwOOA2tAVPoXcr1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BS9ZkBX7; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b34c068faf8so5378647a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752563855; x=1753168655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jm+5GtZBsuCDlQuPvsVi8w+p/Jy1KYl1D9W0MemFZY=;
        b=BS9ZkBX7FeQYro54DIzHHHDg8c9fDGGQbgUcbUMFVn9KQK0E8oikp4UkftG2ens+Tr
         YbpT2rcrCtshq/0jiGPNRhGPBtkOxljemGDeVoeL+8HlQ62Hj+sQeh9DtfgmQ9dR5DKv
         ob/88zq9/+8AngY+jfY9mxxhKr7Blf75Dn2yhbDkaAjvDePxy5bvEbccHVphISrV8phd
         FS4faMuJDHcm4Y7jq3fkcBLO0uGclZYn3k8wFfMBIEw81O+RgI/qxgrBe9Y5GgAqL+af
         aYPcRRUYltYZpCwM/NktwAC1h8S/Kk/YHgoNPj7J65U660PTiSMFC8UQTAtiNPDt9MH/
         jj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752563855; x=1753168655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jm+5GtZBsuCDlQuPvsVi8w+p/Jy1KYl1D9W0MemFZY=;
        b=XGB9nsO86sy4QuZe0L3qlIkYK5+J2t+aFXyW4VGALOrcBHva8DA2+gdeCDxrgIsyUY
         TwyNTNp7JovMJWgTypsp9WCSwC2yoGSf+E752dI91f1Kjut1VVQ08d4wAwV4Iii9SlQv
         2sRUrbCoA9T7GJf0UzIoMg7fRKxvzCRQtgISiWo/38aJ9HKQzINtaYOXTVUtdYkiW/LZ
         Un+WBURNB2CKbuwZQinDKFWL5du7DnKwpHNWztFSG3ArCn5izWoWfg94ntkhYbRfmL+s
         iVSh19Wcelwa4Cj6DGF+iTytjkZm6Ib3P1qcRcBG7Lfs0YvzA469f69DZLEB5kI/Wc90
         ffTQ==
X-Gm-Message-State: AOJu0YwdJnRsNC5Gq4ovBy5NdwV740L22r+Tes+9+zSuhs9LOLxXKMZj
	+tGKbWq9GBfqu/t/9bVjt4Y4NyjJPvfHDCcawC7pbFAFVEsNrtn0x9dxkaMFQ8HfgA==
X-Gm-Gg: ASbGnculsOja61Y1O4c6FWSWRuWDXGY035ViPMfX3KoKjkEQ2dp1CjCEEudymWWaUmS
	v8hTF38cXfc6ZAOax1wtes1XP64ISCzGmwEyDVWT39MAB5s1AxIJD+kkYrmqxPU8L/n3p1AayKu
	EajgLDExz4QZ0dA8HcZAUyDbFVHbdMxckNpnls6ddAc01lDxPc8V/bcsd1kJZc+SBzZcwNxE8LD
	C8x2uspLJO8O8K1xrDYpz3w9V3U8iBzMQg10KFM3e19FOqwZQDaKoPktBuI4GNE4VANqCmTYgCQ
	jlyh1TYTalbHbk58s6BV07ragqQfceWd7rFSO/8Nx5GI2PgApEyRX+HO+dUmDRZOGfv9yWpngyO
	YRgZQ4xZezoV2EbwOR7L/Zxv3pwlaN62pqhuP3Rf4c/qnkk/SgTsAxcH/vFvvhd67QgJJ
X-Google-Smtp-Source: AGHT+IFEpAh3PcSCPddU1wf4eLRvvEkday1d0d69gMr5UtRzx1og9SMqMF57153D01itmcA3A+x0CA==
X-Received: by 2002:a17:90b:4b49:b0:312:db8:dbdc with SMTP id 98e67ed59e1d1-31c4ccea7a7mr21828418a91.20.1752563855062;
        Tue, 15 Jul 2025 00:17:35 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017c9dasm15013418a91.25.2025.07.15.00.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 00:17:34 -0700 (PDT)
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
	Songtang Liu <liusongtang@bytedance.com>
Subject: [PATCH v3 2/5] sched/fair: Implement throttle task work and related helpers
Date: Tue, 15 Jul 2025 15:16:55 +0800
Message-Id: <20250715071658.267-3-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715071658.267-1-ziqianlu@bytedance.com>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

Implement throttle_cfs_rq_work() task work which gets executed on task's
ret2user path where the task is dequeued and marked as throttled.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c | 65 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c072e87c5bd9f..54c2a4df6a5d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5742,8 +5742,51 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	       throttled_hierarchy(dest_cfs_rq);
 }
 
+static inline bool task_is_throttled(struct task_struct *p)
+{
+	return p->throttled;
+}
+
+static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags);
 static void throttle_cfs_rq_work(struct callback_head *work)
 {
+	struct task_struct *p = container_of(work, struct task_struct, sched_throttle_work);
+	struct sched_entity *se;
+	struct cfs_rq *cfs_rq;
+	struct rq *rq;
+
+	WARN_ON_ONCE(p != current);
+	p->sched_throttle_work.next = &p->sched_throttle_work;
+
+	/*
+	 * If task is exiting, then there won't be a return to userspace, so we
+	 * don't have to bother with any of this.
+	 */
+	if ((p->flags & PF_EXITING))
+		return;
+
+	scoped_guard(task_rq_lock, p) {
+		se = &p->se;
+		cfs_rq = cfs_rq_of(se);
+
+		/* Raced, forget */
+		if (p->sched_class != &fair_sched_class)
+			return;
+
+		/*
+		 * If not in limbo, then either replenish has happened or this
+		 * task got migrated out of the throttled cfs_rq, move along.
+		 */
+		if (!cfs_rq->throttle_count)
+			return;
+		rq = scope.rq;
+		update_rq_clock(rq);
+		WARN_ON_ONCE(p->throttled || !list_empty(&p->throttle_node));
+		dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
+		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
+		p->throttled = true;
+		resched_curr(rq);
+	}
 }
 
 void init_cfs_throttle_work(struct task_struct *p)
@@ -5783,6 +5826,26 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 	return 0;
 }
 
+static inline bool task_has_throttle_work(struct task_struct *p)
+{
+	return p->sched_throttle_work.next != &p->sched_throttle_work;
+}
+
+static inline void task_throttle_setup_work(struct task_struct *p)
+{
+	if (task_has_throttle_work(p))
+		return;
+
+	/*
+	 * Kthreads and exiting tasks don't return to userspace, so adding the
+	 * work is pointless
+	 */
+	if ((p->flags & (PF_EXITING | PF_KTHREAD)))
+		return;
+
+	task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
+}
+
 static int tg_throttle_down(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
@@ -6646,6 +6709,8 @@ static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}
 static inline void sync_throttle(struct task_group *tg, int cpu) {}
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
+static void task_throttle_setup_work(struct task_struct *p) {}
+static bool task_is_throttled(struct task_struct *p) { return false; }
 
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 {
-- 
2.39.5


