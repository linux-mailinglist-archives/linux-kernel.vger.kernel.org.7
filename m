Return-Path: <linux-kernel+bounces-792056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F74B3BFD8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0F4A2754F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64C832C338;
	Fri, 29 Aug 2025 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBCCVwqS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D37932C327
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482514; cv=none; b=CNZKf0LwF9T7zK99sWoVPKM8RupM7y4Q1bC/sdEa+zco4d7/04wkoNKws09jnu49tthneEub96H/IfzBvUlMUQX4LRD1LfJkkH+91IQ6nzzS7gt8TWWuft+jcGhgUiJEdwXgOSd3/o7aer7cPFOBHy1+kEn1kxYKcUOp8rzaOBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482514; c=relaxed/simple;
	bh=tKKwBK9xX0xg3Dm/NJEdQ7r5p4nUDr3fqs7FMV7Y/xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBPY9125fZBl+/1fIfCGFzQGmToWQ7svMt3wZQHfY3plzHd3hkKrtur7N0WBW/g5Hy7aP19EMyPC1Gt61PITwxWrYYWyHsxtOAnFqX54vf2GgkDNvZA+oZmGhUx3i5Rar+pJzeMrGK53NBJnWnSTFVE5NL6vKdi8XWrob7eGx/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBCCVwqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C938AC4CEF5;
	Fri, 29 Aug 2025 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482514;
	bh=tKKwBK9xX0xg3Dm/NJEdQ7r5p4nUDr3fqs7FMV7Y/xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JBCCVwqSjumn7XT4pVDMZEQLI5ogqSOLLqGspHQDWXhvD0P1ULdzN5pTeo2YYyls9
	 R1X0QNhPHFsw7zRULaD26WedF9faUpfaOdmDue3V+AlLjmpiuVjqW6ACLSQh0SNmbr
	 dsb63Wt0czGmui5C6jv6RImZDkq7MhoITNU7+llg+qFQy+uOOTL0n6jNdOXsVzugv5
	 onzVLJ0B+qvls4RBWOQ5FmzyvIUvBjo6pcO4XanBU+cvUhEGyDwWroQcN/+opq93XB
	 hNCXxaTRCVJ94BZun8eg+Rl+qFXPj1mkU88P5VcLTsoRIioeEpdrZpQDgXZhpkmvMe
	 vvWARYaBRDQGQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	linux-mm@kvack.org
Subject: [PATCH 05/33] mm: vmstat: Prepare to protect against concurrent isolated cpuset change
Date: Fri, 29 Aug 2025 17:47:46 +0200
Message-ID: <20250829154814.47015-6-frederic@kernel.org>
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
runtime. In order to synchronize against vmstat workqueue to make sure
that no asynchronous vmstat work is pending or executing on a newly made
isolated CPU, target and queue a vmstat work under the same RCU read
side critical section.

Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a vmstat
workqueue flush will also be issued in a further change to make sure
that no work remains pending after a CPU has been made isolated.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/vmstat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 71cd1ceba191..b90325ee49d3 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2133,11 +2133,13 @@ static void vmstat_shepherd(struct work_struct *w)
 		 * infrastructure ever noticing. Skip regular flushing from vmstat_shepherd
 		 * for all isolated CPUs to avoid interference with the isolated workload.
 		 */
-		if (cpu_is_isolated(cpu))
-			continue;
+		scoped_guard(rcu) {
+			if (cpu_is_isolated(cpu))
+				continue;
 
-		if (!delayed_work_pending(dw) && need_update(cpu))
-			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
+			if (!delayed_work_pending(dw) && need_update(cpu))
+				queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
+		}
 
 		cond_resched();
 	}
-- 
2.51.0


