Return-Path: <linux-kernel+bounces-815649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D70B56968
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B00117B948
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0B1DB95E;
	Sun, 14 Sep 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J2f43tdq"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7CC1DE4CA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757857476; cv=none; b=PgrE/qDf5b/zcQlC2+GL0lnMJxjEHIxl2lvJQEXHaDGOrye82l4i38WgF/pdnotMMrx1MKlv8ZN6gehQY1ZVlpzMgWbO4EexrUi/EduaoqXag+rSh7CQGduX7FWkpheb1mUycBSPuZF2p719/T4wDBFjjthFGlSH1BpGxkuhIsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757857476; c=relaxed/simple;
	bh=gIeZApGTCwvtD7M1UghQoeDndvD7iONfL9+9xZQ0bRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZ8td4lmiWfe1+3ERJOTOvtdUpoKMNd8ensgqKZ2kJfmzVAz6lRDQ2PVelVyXmfEdyA8tkMXRvAGRItCrYt2XjTvRGxSmlMAbAA0nuNy8DP8JbQLqvWJYLA9Z/61KR9AEIDk0+T8mkAcxYFpr1s7DLN7U7ZzICFq9vhLxgLHggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J2f43tdq; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso2666940f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757857473; x=1758462273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/OI2IrFU0L9C9qBVFLLx/VxHOwRiUSqRs+R1r3rC/g=;
        b=J2f43tdqgLJcbr7iiS5teQaYfECRBvTPFOqhpmfHeoQBiKn8NwmoZ5nAm9P1tu1OTZ
         h8e5QJ7cbPyRA5MoEGhMwqjfTW7IGA2W/n0x/uwJ4YqBwbHJwknmdowohcVmYhcw025c
         ISnPWprlQ2KwSkjLjsE9j6rQvdkMo9NbUNZrw7cNUDa3uNMZcauVjp2tfsDj+Ac5Kad4
         aH7hd7oYTDh1mztsQPU4juICecFVHBXLdSEjT4+ME7sN9ahUzmafzP/UzxAPu2+ScPjt
         ls3/YyXuGKn1IL5iAoBwNMIHqc+y/6q/vTNLjDQ6uiXVVrVcFfB3+IKWRgCEcZB5u0m6
         6org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757857473; x=1758462273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/OI2IrFU0L9C9qBVFLLx/VxHOwRiUSqRs+R1r3rC/g=;
        b=swG05JXmOab2YkBZuRlQBm7MdfiYw1A1reyQLevJUKXh7iZs+3/50HgcbNzt+cNQJP
         lEmxvbyPqSYiCRw3aQsahzaxQxFlwMuBCjYG2KwbswZSdTRMku67V5VVbQJUwHq+AY4C
         qPW/UcTp2KqatVXv2Ba5Ifu666frXbqQ/XfzTh801JLpK0ZdxMUB+Vlni02Kz5fwndO7
         WvfJ1UFFPLLL4Kk6nRl/NtniYmTiIbSnpD7YvhkREleGLpwXlwto6mki4l2aMkYIk746
         i5J6ciE3Qb8KtGKFbFN4w0/APeQ1ThqVoFw0G2TV6k+YauApUMRfR4D3kXZnQYj9yxFr
         cXXw==
X-Gm-Message-State: AOJu0YyQBNz2E7kCx8ety7TTgHwEl7EYwWeYqQR3PpsSpIdQDuyMfBhE
	ZkH5pZohEY83VSaYH9nv0f51iBEGBZzECrpmc1pky4CiGGSAsV+udCg4dspfS85osMQFAAaFptv
	A3X6iQE8=
X-Gm-Gg: ASbGncuTjnyWAQ8erFwTzQUZwPl5rOsuhByy5bI/QblfjXQnJXEjI0htpffdL6NouLo
	qwQSKJDaDklOtIIFLa8RSIlC8niDKacoOEc2GUkUmPXDXSXlb3UGEWMQYvYL5Kd+zmPpqo4H4Zh
	qpex5IGUMdEXr1y+3R+Bso3RXiLoIn6EeH0y9uaCXl7ySf9AWTX0TZo6AM6V/Pza0wTmbX8/8au
	fYqrjtoUTcfYP0jF19MUPIxCMlTkcX3wvlPjC0dEsGWjVDmn/G7URINbdqnzax+Vzyc8e5kjNwh
	XatEQqx44g/BAWjWdfFJsYLeKdghE/cY0aD8qLZMZk5PAt1vssu9c0UInmaco4ixintzX1/Xi1r
	uUp/FLvACqsUJ36rUgU3W/5WckWiXu92DnT67BCt+6KI825Q=
X-Google-Smtp-Source: AGHT+IF3YfYKMBWsgTXNij7jgiY24DXO3RTVsSksMok16uzg//yaJeb+az/gY7raTFA3vyXOAItHsQ==
X-Received: by 2002:a05:6000:61e:b0:3e7:4414:794b with SMTP id ffacd0b85a97d-3e765a018a5mr7370811f8f.50.1757857472960;
        Sun, 14 Sep 2025 06:44:32 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e86602a7d5sm6318876f8f.62.2025.09.14.06.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:44:32 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 1/1] workqueue: WQ_PERCPU added to alloc_workqueue users
Date: Sun, 14 Sep 2025 15:44:26 +0200
Message-ID: <20250914134426.43269-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250914134426.43269-1-marco.crivellari@suse.com>
References: <20250914134426.43269-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 include/linux/workqueue.h |  4 ++--
 kernel/workqueue.c        | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 45d5dd470ff6..70db0acf74fc 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -410,7 +410,7 @@ enum wq_flags {
 	__WQ_LEGACY		= 1 << 18, /* internal: create*_workqueue() */
 
 	/* BH wq only allows the following flags */
-	__WQ_BH_ALLOWS		= WQ_BH | WQ_HIGHPRI,
+	__WQ_BH_ALLOWS		= WQ_BH | WQ_HIGHPRI | WQ_PERCPU,
 };
 
 enum wq_consts {
@@ -570,7 +570,7 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
 	alloc_workqueue(fmt, WQ_UNBOUND | __WQ_ORDERED | (flags), 1, ##args)
 
 #define create_workqueue(name)						\
-	alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM, 1, (name))
+	alloc_workqueue("%s", __WQ_LEGACY | WQ_MEM_RECLAIM | WQ_PERCPU, 1, (name))
 #define create_freezable_workqueue(name)				\
 	alloc_workqueue("%s", __WQ_LEGACY | WQ_FREEZABLE | WQ_UNBOUND |	\
 			WQ_MEM_RECLAIM, 1, (name))
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c6b79b3675c3..5a1cb3026b31 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -7802,22 +7802,22 @@ void __init workqueue_init_early(void)
 		ordered_wq_attrs[i] = attrs;
 	}
 
-	system_wq = alloc_workqueue("events", 0, 0);
-	system_percpu_wq = alloc_workqueue("events", 0, 0);
-	system_highpri_wq = alloc_workqueue("events_highpri", WQ_HIGHPRI, 0);
-	system_long_wq = alloc_workqueue("events_long", 0, 0);
+	system_wq = alloc_workqueue("events", WQ_PERCPU, 0);
+	system_percpu_wq = alloc_workqueue("events", WQ_PERCPU, 0);
+	system_highpri_wq = alloc_workqueue("events_highpri",
+					    WQ_HIGHPRI | WQ_PERCPU, 0);
+	system_long_wq = alloc_workqueue("events_long", WQ_PERCPU, 0);
 	system_unbound_wq = alloc_workqueue("events_unbound", WQ_UNBOUND, WQ_MAX_ACTIVE);
 	system_dfl_wq = alloc_workqueue("events_unbound", WQ_UNBOUND, WQ_MAX_ACTIVE);
 	system_freezable_wq = alloc_workqueue("events_freezable",
-					      WQ_FREEZABLE, 0);
+					      WQ_FREEZABLE | WQ_PERCPU, 0);
 	system_power_efficient_wq = alloc_workqueue("events_power_efficient",
-					      WQ_POWER_EFFICIENT, 0);
+					      WQ_POWER_EFFICIENT | WQ_PERCPU, 0);
 	system_freezable_power_efficient_wq = alloc_workqueue("events_freezable_pwr_efficient",
-					      WQ_FREEZABLE | WQ_POWER_EFFICIENT,
-					      0);
-	system_bh_wq = alloc_workqueue("events_bh", WQ_BH, 0);
+					      WQ_FREEZABLE | WQ_POWER_EFFICIENT | WQ_PERCPU, 0);
+	system_bh_wq = alloc_workqueue("events_bh", WQ_BH | WQ_PERCPU, 0);
 	system_bh_highpri_wq = alloc_workqueue("events_bh_highpri",
-					       WQ_BH | WQ_HIGHPRI, 0);
+					       WQ_BH | WQ_HIGHPRI | WQ_PERCPU, 0);
 	BUG_ON(!system_wq || !system_percpu_wq|| !system_highpri_wq || !system_long_wq ||
 	       !system_unbound_wq || !system_freezable_wq || !system_dfl_wq ||
 	       !system_power_efficient_wq ||
-- 
2.51.0


