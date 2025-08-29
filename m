Return-Path: <linux-kernel+bounces-792055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E060DB3BFD6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD3918835AD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF1631064E;
	Fri, 29 Aug 2025 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa8/zBzn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E269F326D54
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482512; cv=none; b=M59JDWiO9tA1kDbx3hhZ63afMW79oQWCF67A2pIDzsRr1ZeYTpW+T38+B0Fe0Dp/HI+XkA2o55i2u+bCSdI0y1b3o0zBRX4LF83B5PN/dITvBRi/xRCa1qPo2+E4sCcNgK+w88zFmInnmZedC707XzzTj8R1bPkfI/sZkJFheQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482512; c=relaxed/simple;
	bh=Vc04EDItjBp0X7n1yxJukk3IkSy0glb+ldt8bl29/7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrzKzdsT7k0AGkI5GDMayd5n+a0BxldvKoEAWg3BfHFkvsX/snvZnWi9wg1jlxxxNO5iUdEMdirRFAk9geYE7wAoAxuNq9MdUdlcYYe3wFjgpvem0INMIcRrvqDsV+8Od1VxALv2EL7b4/vEXRUQ3IEeZZNIPljz1FgA7pCOLn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa8/zBzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FD9C4CEF0;
	Fri, 29 Aug 2025 15:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482511;
	bh=Vc04EDItjBp0X7n1yxJukk3IkSy0glb+ldt8bl29/7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wa8/zBzn24d587hcSzZFIZNPrU+pNKrPHUthBF8v1o9NY8ztws8/YKkyWqZwno5P2
	 VTEQsxifGJt5CmuaACbgMPuimdEei+byFBX16twmP13JEbO8x+YpK7uM8Ox6u9rBj3
	 CdTShUAmqDj4W7arX0GKOrKIz+xomVva87kiSgdK2LlGkrLnwYIoToVNGV/gJ4nyNr
	 ZJGNLdJQrZxeYuwBIxAiXUN+0Z3tkfnOECX30OP+/MCiNpEG1I9OP31pEY5Hpi4hXn
	 XM6bfvHsdjgD3GNOR91xi2W51AMsy+dyQ0XbogVdwkhgcGGbikebtofFx3znCEUvNX
	 A+nPcxZjv5W4g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 04/33] memcg: Prepare to protect against concurrent isolated cpuset change
Date: Fri, 29 Aug 2025 17:47:45 +0200
Message-ID: <20250829154814.47015-5-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifyable at
runtime. In order to synchronize against memcg workqueue to make sure
that no asynchronous draining is pending or executing on a newly made
isolated CPU, target and queue a drain work under the same RCU critical
section.

Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a memcg
workqueue flush will also be issued in a further change to make sure
that no work remains pending after a CPU has been made isolated.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/memcontrol.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..2649d6c09160 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1970,6 +1970,13 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
 	return flush;
 }
 
+static void schedule_drain_work(int cpu, struct work_struct *work)
+{
+	guard(rcu)();
+	if (!cpu_is_isolated(cpu))
+		schedule_work_on(cpu, work);
+}
+
 /*
  * Drains all per-CPU charge caches for given root_memcg resp. subtree
  * of the hierarchy under it.
@@ -1999,8 +2006,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 				      &memcg_st->flags)) {
 			if (cpu == curcpu)
 				drain_local_memcg_stock(&memcg_st->work);
-			else if (!cpu_is_isolated(cpu))
-				schedule_work_on(cpu, &memcg_st->work);
+			else
+				schedule_drain_work(cpu, &memcg_st->work);
 		}
 
 		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
@@ -2009,8 +2016,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 				      &obj_st->flags)) {
 			if (cpu == curcpu)
 				drain_local_obj_stock(&obj_st->work);
-			else if (!cpu_is_isolated(cpu))
-				schedule_work_on(cpu, &obj_st->work);
+			else
+				schedule_drain_work(cpu, &obj_st->work);
 		}
 	}
 	migrate_enable();
-- 
2.51.0


