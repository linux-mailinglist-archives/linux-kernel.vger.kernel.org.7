Return-Path: <linux-kernel+bounces-890047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DADE7C3F245
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE7D188E368
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1295F2BDC00;
	Fri,  7 Nov 2025 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NUtESZYw"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A12B1EE033
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507509; cv=none; b=P3cmsVkCymr7dWIlEabIXWAyIx+9w0BX4Ugs6cUbfoxLjxCtk+VV8aOoq8cAx7XnUVtxotH2uv86F5kWLQYKYK9JOAsS9i36yiFD824lNYlI1AzeEmMtMwhGRNi7str6zOEsL8dJ/gaIkBiijgL+gUEEstmrxj0oz3V6dq6PRfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507509; c=relaxed/simple;
	bh=o2QA6NFW2gjwjK1bP1ddC1mkAJO2AlUTvrMzla0pcn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxuUADOciClQGjoUH+gimSrHfjkkjh313lFjlSeaj7CsPTr5Y3UlLjJpAbTSdeBD7e4PMCZ9ZnIHjcT4rjLJbIIkbJnBfmHT4cWL3ysJhq0bYwj0413RHsJqoW6i1RI0IdY8vCn8T3aEnTu2Ze/C84DnCAS9hHL9WZ815R9IOjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NUtESZYw; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso470338f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762507504; x=1763112304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1+fzNhn5ZPLBwwlnPL/X9jgIx3/DiIULE7dla0BVHUg=;
        b=NUtESZYw7qjJ3QWIikMF6GkEj49SVaFKtH1GKzRXXP1WWlnHNGMFK6x8N1gihaufIm
         vydbRLkDgBwESitTJZgn38+cg+xGmUXrWVBRTEqXWiMqScbVRznLJnfcaua0MD9O+0tU
         g4GspN8mvI9eI6pavxwQ/WjXbs07sSkeRZ91gPEmkZ5c9lXUojoaHwpTJLMiJcuNVxaS
         t3ujvhlfQK6FCZNdz+/7dpM1vv7yrwqNAnaHGwyhlzxh1EpcaBaXL6MNepr+m9B3oIfu
         iYMl3dDcu/lWC/or2Hs0WLffcWZ14XSeUZ1cUtEzrMfyTlyPCj+5MhOXEmHsK199vkYv
         WGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762507504; x=1763112304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+fzNhn5ZPLBwwlnPL/X9jgIx3/DiIULE7dla0BVHUg=;
        b=CyFoRG7bdq0wP235YljIuDFBEtE/znuX0DxuZT05swPdMQQm/CQWdA4GNF+akTyq90
         JY1zV3ptzHG1OkrREj/RhukPZWbQvDgFD+QUNx7bEKjMenJmKSGb+hOfDCaeiC/saoUN
         jJraBfgRx940IpCgVFmtQ3/T0Rr0JX40Bf/8O1ALOosbDvkAvQgIqHt6wyv7I3b/5/4P
         F1nF3b5og7Ng3mpHqlNV3n2vkWWHGJu5Ox252NdmikLAGrWpbFwOOALqBM5q8TeNZG6Z
         5rV1Mtdj5DylKkTdFuKc+7jJ0u7cdWb48h6Bl7lgg5fiDnCdD+lnQxY/pgOlV95hYAnM
         T/wQ==
X-Gm-Message-State: AOJu0Yx4FbaoHy7sMvoPzxaN5nAfUElobWYU9utS+kpGqqC1SnG/Tftj
	WizQGghpLniwrecRwCTB/jiMBD36rEXhX0qRTq81uohOin6GGiQ3ox4dDQju3vY5rbZrv2T3M9R
	mudWL
X-Gm-Gg: ASbGncsuFOit7igcQjA6HVDHNz9pcMxS7BCKluEHKkAGc6JaCws87stQ3ayn1ZD28V+
	lv/HIIyyY3ub2B9qnJcoKVk8ucVzQsA81Faw8oGNqyQArFR2FHVczQl2BwqVLyPE3OdPiOtT7ZR
	CDSnkZoFgJwHsTrsi+/sbl/IkJk4IUzATemMR8YuVu1uXeRkr/qd9Ast2TUifKn7yO2tiqqoefr
	TY6H/2X4agYiSEjEIWJAwc5g1KGBIYa7HkL1zHpoIJALub3Q/i4ERZm1blVkXe1PKbPgE3HpBQT
	FR5Q0+Lg+1vICabVl7UwHC4lEyeXoHLspt61bkWQD5ZrYBak7/rhqjdQqjzjyHYVD8qcPFSfnIb
	qA+uB5c/TBGdrZI7u8ytkwRfGNI1Mhty8xh/W+HRMntDf65dYWGf4pNxUpN7qIe1h8POSZHBBLa
	2EyfZqxjqC8XtLeQKHXtHrJgQc
X-Google-Smtp-Source: AGHT+IHccDjY6gkmAw3mgOK/2zGmir0et5vCzxlS04Z450pmXNLCTBS1eVFiwd/RWp09DXm21qAYJg==
X-Received: by 2002:a05:6000:430e:b0:429:c4bb:fbd1 with SMTP id ffacd0b85a97d-42ae587f47fmr1717117f8f.18.1762507504062;
        Fri, 07 Nov 2025 01:25:04 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac675c9fdsm4150413f8f.28.2025.11.07.01.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:25:03 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  7 Nov 2025 10:24:52 +0100
Message-ID: <20251107092452.43399-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.
For more details see the Link tag below.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Switch to using system_dfl_wq because system_unbound_wq is going away as part of
a workqueue restructuring.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/sched/core.c | 4 ++--
 kernel/sched/ext.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f1ebf67b48e2..c878be03236a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5709,7 +5709,7 @@ static void sched_tick_remote(struct work_struct *work)
 	os = atomic_fetch_add_unless(&twork->state, -1, TICK_SCHED_REMOTE_RUNNING);
 	WARN_ON_ONCE(os == TICK_SCHED_REMOTE_OFFLINE);
 	if (os == TICK_SCHED_REMOTE_RUNNING)
-		queue_delayed_work(system_unbound_wq, dwork, HZ);
+		queue_delayed_work(system_dfl_wq, dwork, HZ);
 }
 
 static void sched_tick_start(int cpu)
@@ -5728,7 +5728,7 @@ static void sched_tick_start(int cpu)
 	if (os == TICK_SCHED_REMOTE_OFFLINE) {
 		twork->cpu = cpu;
 		INIT_DELAYED_WORK(&twork->work, sched_tick_remote);
-		queue_delayed_work(system_unbound_wq, &twork->work, HZ);
+		queue_delayed_work(system_dfl_wq, &twork->work, HZ);
 	}
 }
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ecb251e883ea..78da6ab5259e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2653,7 +2653,7 @@ static void scx_watchdog_workfn(struct work_struct *work)
 
 		cond_resched();
 	}
-	queue_delayed_work(system_unbound_wq, to_delayed_work(work),
+	queue_delayed_work(system_dfl_wq, to_delayed_work(work),
 			   scx_watchdog_timeout / 2);
 }
 
@@ -4659,7 +4659,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	WRITE_ONCE(scx_watchdog_timeout, timeout);
 	WRITE_ONCE(scx_watchdog_timestamp, jiffies);
-	queue_delayed_work(system_unbound_wq, &scx_watchdog_work,
+	queue_delayed_work(system_dfl_wq, &scx_watchdog_work,
 			   scx_watchdog_timeout / 2);
 
 	/*
-- 
2.51.1


