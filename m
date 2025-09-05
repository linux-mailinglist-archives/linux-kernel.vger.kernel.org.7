Return-Path: <linux-kernel+bounces-802449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB6DB4527C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45462A05A22
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CADA3019D2;
	Fri,  5 Sep 2025 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fe8cPrFM"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1378828851F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063018; cv=none; b=TGpUd2lBK1Xdr0W/BB8WK5SxBxMLIwnhdaGO9RZfxslxpe5pJzJmld7Na0pAlT+1bMAsGQEpe7vqHvarzohhfSFloLj8ETxufQ3MjUEGtTi5wrJ7Os/61C8DOYfd+TEFLHhNs/BL0zWbRMfQOmWXdfeULkkk84lil5URdAOYofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063018; c=relaxed/simple;
	bh=x0SccWkwwkQaMO1gCO3MC2G88/zGpVNyC8XvWOJlo5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGF6LPy+uc1hcEAPQoovhPJ39qDKtlqndiy8N95dnCH5uQ/LHEggaD9qLP8wsDafbHtJN9ozzD18S1FFFSTRu+UKZySj85rgeD4MiiRpKzQFM8Gc34u8Y9Vr/fKj5ruo79cdNHjJ14OdiBARdrcidhoxIvX0A0HI9tDMxXJVx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fe8cPrFM; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so1150991f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063015; x=1757667815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYtBCkO9DqKzKcyS43porMi3LTjby1/YOgTfwITaJ5Q=;
        b=Fe8cPrFMp5q7sOnNUyeKVCHrwdmT2TGzHoxuyLwMqizb9l4Vel0PbQMX2B167myHeg
         TjR1+8iIxT9UtBoRbumfzLMdr0gk8HYhgEF5Ia92R+IRPCRhhQLmj0qe1QDK99YIGNdk
         zsHVi1c5mDf3j3iag7YgXHSLcAcZAUKB8IVaATT8ALxyFwxJWgTvVEix5ZBN+VddSOBP
         710Zyi8eQnpEkkmHcDbJTCht9ZktketqHe/Wa0VcYkhhI/wo+hfwbAVEJzuBzXhzupRy
         TN+jGrvqSqgoJEwprqUyz3j17qCM13KaO8c6EBUyfY6thGJueddt7FpcVq4Q/oqHqd+8
         nfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063015; x=1757667815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYtBCkO9DqKzKcyS43porMi3LTjby1/YOgTfwITaJ5Q=;
        b=VYo8viGtnsZKRQFC1TJkA2ND7z9mjwE21OHdr5bLPigiDj9sPbH/P9iecWDMsV1txx
         Bzwb5cVg8j6EYNrPRXkCwskypd1UUOa9seaUsOq+SrjWVwnB4nIWdpLP/abKvcQpFaxM
         zoMdt/a51rQiazSDZJB/lzmvCdEV3ZLyhx9lP487gLBH5GpxgumljihsN2BfKYE8UtYa
         v8qrhrVh6rgq431L5aeaCo7YvLZBc8cIJADNb6lUcj3ajkdudu1kA23yVA3YBWig9E+3
         dbqrz9Xk3r2Yn4Ix1YMcdMZ2B4lnZYy83oNWUFTMhGrERKQ9VSxCMM31v9Zh+9y0Q3MD
         P3Pw==
X-Gm-Message-State: AOJu0YyRTVUbAS1o32Krvyt01QLv5GhGs+WxYNJ0ED9YRF8xOCEJlgLS
	F/+di0VZHNyW/7OB3TPlzjyOd/lGxxUTy0cW+2V5T8oighMfk6cvjZi4Z+196MSyWE7w2L68o4F
	9vLDS
X-Gm-Gg: ASbGnctBVj0rvJ3vgC0OQaRFXYSh8iJxm5JZSO9uKqzmdy09buf2a8bZrm4WpBhU6bG
	KkNysjku10qhWjje6ERTBJkH6E5FvjGxoYdubrdbepxQ0Ip1YqZebeK/Vhowl16JU6xZT5HMgXt
	f8hw87Xe+gguZcAFycMfC5FzHVNr9LsziNqxc4t3b5tTzz/hTx0ucdrRJJaJF1FTJyg0EN+tqY2
	d6vh+/rKEl5lpgtby66HjcbC8ILGTr0sPJF+Q28OxpxTwSBp4J6I1m5WiQFPFPApARVHK27e2v1
	Xvr86+gV96jV2hHGt0iytAP+kaZm+R33VcIV/8LLebd8kadtU0Q0sitjWhHyZYg+uChkSVpbwal
	CAZLGYqD2e0UNxcQWy/IH1HauUPLAWT9Cj/t5a4Ua3pU0Q25pIiIrqHvM5w==
X-Google-Smtp-Source: AGHT+IEjaLZymkByczPO22uKZMFn/gyrcDISUwcAhC9QIjk27LsuQ5PsAm7XYe1kQO+OONf4843osQ==
X-Received: by 2002:a05:6000:2586:b0:3cd:c10d:3b6b with SMTP id ffacd0b85a97d-3d1de4b9891mr17256852f8f.27.1757063015005;
        Fri, 05 Sep 2025 02:03:35 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf3458a67fsm3614543f8f.62.2025.09.05.02.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:03:34 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] mm: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 11:03:23 +0200
Message-ID: <20250905090323.103401-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090323.103401-1-marco.crivellari@suse.com>
References: <20250905090323.103401-1-marco.crivellari@suse.com>
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

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to all the mm subsystem users to
explicitly request the use of the per-CPU behavior. Both flags coexist
for one release cycle to allow callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 mm/backing-dev.c | 2 +-
 mm/slub.c        | 3 ++-
 mm/vmstat.c      | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 7e672424f928..3b392de6367e 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -969,7 +969,7 @@ static int __init cgwb_init(void)
 	 * system_percpu_wq.  Put them in a separate wq and limit concurrency.
 	 * There's no point in executing many of these in parallel.
 	 */
-	cgwb_release_wq = alloc_workqueue("cgwb_release", 0, 1);
+	cgwb_release_wq = alloc_workqueue("cgwb_release", WQ_PERCPU, 1);
 	if (!cgwb_release_wq)
 		return -ENOMEM;
 
diff --git a/mm/slub.c b/mm/slub.c
index b46f87662e71..cac9d5d7c924 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6364,7 +6364,8 @@ void __init kmem_cache_init(void)
 void __init kmem_cache_init_late(void)
 {
 #ifndef CONFIG_SLUB_TINY
-	flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM, 0);
+	flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM | WQ_PERCPU,
+				  0);
 	WARN_ON(!flushwq);
 #endif
 }
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4c268ce39ff2..57bf76b1d9d4 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2244,7 +2244,8 @@ void __init init_mm_internals(void)
 {
 	int ret __maybe_unused;
 
-	mm_percpu_wq = alloc_workqueue("mm_percpu_wq", WQ_MEM_RECLAIM, 0);
+	mm_percpu_wq = alloc_workqueue("mm_percpu_wq",
+				       WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 
 #ifdef CONFIG_SMP
 	ret = cpuhp_setup_state_nocalls(CPUHP_MM_VMSTAT_DEAD, "mm/vmstat:dead",
-- 
2.51.0


