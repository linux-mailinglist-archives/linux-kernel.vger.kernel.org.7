Return-Path: <linux-kernel+bounces-769027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA975B26973
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8429D606CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70671C861A;
	Thu, 14 Aug 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="ZR9RNxbe"
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDB1ADC93
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180718; cv=none; b=LVMdBfpiGX4J1CX59kJLwvOtSkaBgrAUrUb0lfJfDphKGhvGC8PU3I/fhUMyjXYtN1ldyq0NFz/3BX44evEz1UXhZejv56RvaKUxxfRjbdOyDsa6dbMSDEWqu5N1O0+rotUeE7QGEES2b4yaygHGM1qeIFS6f2GKpnA3MIwRpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180718; c=relaxed/simple;
	bh=Y1o6emuvsPrqT+WdWAFVSifqHHuldu2i2ckRsNT25/I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TnRjlG5wIUSnO0WARvLSDekBPCZVfEEIe5qWmYWAjIQjhTuWE7SBisMYQylmPPSGnZX3Ab6snhQaGT93CGa2RT1dQhyJdO4OgQ3f0Lk1U3fPVXIUBk5MxXIr1jcicaCjtJhQ9fZDfSSFss86nMpesPLHO7E7URt+t7P5jurJEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=ZR9RNxbe; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=BBLjP4xvKDuUFhARlS1Ydysza6+nSWdlIM3BlOBCokY=;
	b=ZR9RNxbeiqfWaz2YieZy484lT4aLrYRkBa5eVtHwAqoPKkWgCviGZXx0vOXHsCpdj7MYN2Gec
	InkLNagzTTNNaNc9F3YunmB677AjilGx6mLexq8iT454fQi9NACXsrLPHx0zDCz7D8eTr28ASYA
	m7Vu/RyqCaZkSVciXfLv8Fs=
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4c2mwn2tTvzYlnhn;
	Thu, 14 Aug 2025 21:55:53 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 21:55:59 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 21:55:59 +0800
From: <zhongjinji@honor.com>
To: <linux-mm@kvack.org>
CC: <akpm@linux-foundation.org>, <mhocko@suse.com>, <rientjes@google.com>,
	<shakeel.butt@linux.dev>, <npache@redhat.com>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <dvhart@infradead.org>, <dave@stgolabs.net>,
	<andrealmeid@igalia.com>, <liam.howlett@oracle.com>, <liulu.liu@honor.com>,
	<feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v4 0/3] mm/oom_kill: Only delay OOM reaper for processes using robust futexes
Date: Thu, 14 Aug 2025 21:55:52 +0800
Message-ID: <20250814135555.17493-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a018.hihonor.com
 (10.68.17.250)

From: zhongjinji <zhongjinji@honor.com>

The OOM reaper quickly reclaims a process's memory when the system hits OOM,
helping the system recover. Without the OOM reaper, if a process frozen by
cgroup v1 is OOM killed, the victim's memory cannot be freed, leaving the
system in a poor state. Even if the process is not frozen by cgroup v1,
reclaiming victims' memory remains important, as having one more process
working speeds up memory release.

When processes holding robust futexes are OOM killed but waiters on those
futexes remain alive, the robust futexes might be reaped before
futex_cleanup() runs. This can cause the waiters to block indefinitely [1].

To prevent this issue, the OOM reaper's work is delayed by 2 seconds [1]. Since
many killed processes exit within 2 seconds, the OOM reaper rarely runs after
this delay. However, robust futex users are few, so delaying OOM reap for all
victims is unnecessary.

If each thread's robust_list in a process is NULL, the process holds no robust
futexes. For such processes, the OOM reaper should not be delayed. For
processes holding robust futexes, to avoid issue [1], the OOM reaper must
still be delayed.

Patch 1 introduces process_has_robust_futex() to detect whether a process uses
robust futexes. Patch 2 delays the OOM reaper only for processes holding robust
futexes, improving OOM reaper performance. Patch 3 makes the OOM reaper and
exit_mmap() traverse the maple tree in opposite orders to reduce PTE lock
contention caused by unmapping the same vma.

Link: https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u [1]

---

v3 -> v4:

1. Rename check_robust_futex() to process_has_robust_futex() for clearer
   intent.
2. Because the delay_reap parameter was added to task_will_free_mem(),
   the function is renamed to should_reap_task() to better clarify
   its purpose.
3. Add should_delay_oom_reap() to decide whether to delay OOM reap.
4. Modify the OOM reaper to traverse the maple tree in reverse order; see patch
   3 for details.
These changes improve code readability and enhance OOM reaper behavior.

zhongjinji (3):
  futex: Introduce function process_has_robust_futex()
  mm/oom_kill: Only delay OOM reaper for processes using robust futexes
  mm/oom_kill: Have the OOM reaper and exit_mmap() traverse the maple
    tree in opposite orders

 include/linux/futex.h |  5 ++++
 include/linux/mm.h    |  3 +++
 kernel/futex/core.c   | 30 +++++++++++++++++++++++
 mm/oom_kill.c         | 55 +++++++++++++++++++++++++++++++------------
 4 files changed, 78 insertions(+), 15 deletions(-)

-- 
2.17.1


