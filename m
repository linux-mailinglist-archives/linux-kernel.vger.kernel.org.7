Return-Path: <linux-kernel+bounces-729335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28BB03517
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 06:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A37B3B898D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 04:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40B21E00A0;
	Mon, 14 Jul 2025 04:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGZacxgG"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C794A11
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752465927; cv=none; b=kWGHvHRQ9Zn9r9QdIhxZCenUblkxG+FbwumNxGaJPXtoYxzgNNFQBMtckEdIBxrLUM39/cZPh9dLory/vYg8DhU8waqkpstAKLBcz63fubALT3Z0A2BEKiAiKgcuAPpKb6vKFGpkyv/fxv11ZTLakn8bfHbejTNfjYvLv6Y6X1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752465927; c=relaxed/simple;
	bh=rccaMSjcsovTEuAr2IUb9f0GeP8mr0MO/9YswAXr4/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qjxqn4M7TKVmjXInDbq/wzdLhjNBcpzVZC1r8ZIU2gqkaVCmGXV2L1sEyDjqqO5Yd5GzBzvvHY/MWBaHhNGmsKZNiI3QH439O24tfyXl8rFLQ6jDVFFvpd5L40tTfop5W3Ze54cxsSbZmY0MX9qO928ASrfOSo+fhY0anI9FsJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGZacxgG; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-af51596da56so3090046a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 21:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752465925; x=1753070725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yUx6Kpacbbv22zmbKXmQwmZBrxyIzEaW0Pe8fwuZw8=;
        b=RGZacxgGRS1mWsvh6O3r5UNTVO16Xq5OgWRG9aUHp2J/GuiVzwwauw8l5615sxvTnt
         Mx8f345fqZitHbOrvuQYK2rbbCmbTB45SWlJ6+VMtJTkpdQ7If6AlDIV9d1K41D3iflK
         OmKOtkaEC02zIB7JIpymC85wMLMaFd6TOrTInuIb4R2SVkkSXCgEQJ8g9o8Rvtb5Xuq9
         D81t9ZSwyj0TArXB156hsz2xyxgQp3q+jKU+bP0V1R+Fht5JQ6Ko5dHscKG1wJ/yorQw
         DGZy3Rf9etWgNFNAxdZRSGaPNLdIJ54CocTHad1QZw6pEEui5p3/RUFhvJXXEXHzwzK4
         XcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752465925; x=1753070725;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yUx6Kpacbbv22zmbKXmQwmZBrxyIzEaW0Pe8fwuZw8=;
        b=hNH3DPEU51IL8Uw2XXO5EJtBAJ3fnpfeVuBXnsulHbZWPcrR7FT3NnXWSSV0roB2FE
         7/4hHJcyt1n5rFxzgEwuZXo2cdrFkjS1bykF6yGk5ybsOvh6+666xeDbJOFi9ezZbA5l
         c+vULeW5eUxpJ9Dfr6G3HxymemitMg5OzUDvrR2BKl7GbUbx5Mdjhx9WV7+AyhlLprjQ
         cxfb7vX9YXE1tgWMiEY9eWUWEy/sgtjUGECwPJTHn82MFgiEdk/wnHe9iXxuf/VlMEiS
         OmDyrxLrXgM82Tp4PvmqtGHfWiIbqgi+1Lo44Y+ah0fIgSwfZU/gSxU82F1PBKRvnbWl
         CMAg==
X-Gm-Message-State: AOJu0YzG25u+HMHirdWIiFpisG8xj5F8g+qNbull4cwr56fGkkd7LA/R
	tu+oG+GiS0XBZxl+/ze/UVrd41DlHC38hbELxK4ZC0DCGEkD7v2VJSwijhQNmadR/kM=
X-Gm-Gg: ASbGncvNG2O/Dgs8ktEfCejYwCj5eDz4Ui1kx/TWGDzp6VzCtZJdcmbOGfZECGkqMkX
	AMxhnxgWvjoN0lhJE7wSstloaT2qkDxyrv0fAzeLOku9hym1WfBzOZnWTdzytR0+vWW2FqduzE1
	MCOSuWUs+ik0wRepZDmlIJNIrQGv+N+DEBXxd1Ii9ybFcev7bqmk/6cHPpb11Tjnrdtt8vivdp9
	JgzRTU9LdnLTx2Y8rNYo7h8AJXiS0MIk+5ZltlKxMvkVZ0HyQsa7r6E2YoLUEekJ6mcaslbyEjl
	z9tnZ95jZ74ML7U/w7MxhH2Cp1RqA3saQw8UsdQFKoynYYVL4NeTvKQFfpPJhzvGEFPQSdDWknY
	DFlTIvZuab7k994XOlKP45g==
X-Google-Smtp-Source: AGHT+IHl/s5y5BxecLricbiYOnBfm+gQh1H7ZQQhosnyysxFUHErtPU8NdGxxCu6fRQixLRubU4OXg==
X-Received: by 2002:a17:90b:2f07:b0:313:dcf4:37bc with SMTP id 98e67ed59e1d1-31c4f586468mr12882641a91.34.1752465924907;
        Sun, 13 Jul 2025 21:05:24 -0700 (PDT)
Received: from jemmy.. ([180.172.48.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3003e413sm12617896a91.9.2025.07.13.21.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 21:05:24 -0700 (PDT)
From: Jemmy Wong <jemmywong512@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	dtcccc@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v1] sched/eevdf: propagate min slice during {throttle, unthrottle}_cfs_rq
Date: Mon, 14 Jul 2025 12:05:16 +0800
Message-ID: <20250714040516.10196-1-jemmywong512@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The min slice should be propagated through task group hierarchy during
{throttle, unthrottle}_cfs_rq similar to how normal tasks are handled in
{enqueue, dequeue}_entities.

Signed-off-by: Jemmy Wong <jemmywong512@gmail.com>

---
 kernel/sched/fair.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a14da5396fb..a0fa2df65e42 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5890,6 +5890,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct sched_entity *se;
 	long queued_delta, runnable_delta, idle_delta, dequeue = 1;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
+	u64 slice = 0;

 	raw_spin_lock(&cfs_b->lock);
 	/* This will start the period timer if necessary */
@@ -5950,6 +5951,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (qcfs_rq->load.weight) {
 			/* Avoid re-evaluating load for this entity: */
 			se = parent_entity(se);
+			slice = cfs_rq_min_slice(qcfs_rq);
 			break;
 		}
 	}
@@ -5963,6 +5965,11 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		update_load_avg(qcfs_rq, se, 0);
 		se_update_runnable(se);

+		se->slice = slice;
+		if (se != qcfs_rq->curr)
+			min_vruntime_cb_propagate(&se->run_node, NULL);
+		slice = cfs_rq_min_slice(qcfs_rq);
+
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
 			idle_delta = cfs_rq->h_nr_queued;

@@ -5996,6 +6003,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct sched_entity *se;
 	long queued_delta, runnable_delta, idle_delta;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
+	u64 slice = 0;

 	se = cfs_rq->tg->se[cpu_of(rq)];

@@ -6041,7 +6049,13 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			dequeue_entity(qcfs_rq, se, flags);
 		} else if (se->on_rq)
 			break;
+
+		if (slice) {
+			se->slice = slice;
+			se->custom_slice = 1;
+		}
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
+		slice = cfs_rq_min_slice(qcfs_rq);

 		if (cfs_rq_is_idle(group_cfs_rq(se)))
 			idle_delta = cfs_rq->h_nr_queued;
@@ -6064,6 +6078,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
 			idle_delta = cfs_rq->h_nr_queued;

+		se->slice = slice;
+		if (se != qcfs_rq->curr)
+			min_vruntime_cb_propagate(&se->run_node, NULL);
+		slice = cfs_rq_min_slice(qcfs_rq);
+
 		qcfs_rq->h_nr_queued += queued_delta;
 		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->h_nr_idle += idle_delta;
--
2.43.0

