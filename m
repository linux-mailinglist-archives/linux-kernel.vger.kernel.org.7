Return-Path: <linux-kernel+bounces-784782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B375BB340EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8303BE207
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 13:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9DB275108;
	Mon, 25 Aug 2025 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="Wun4vL/m"
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE9A26E14C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129152; cv=none; b=nS8fZNMC81J7PUgaeOF3OH+SlQC+Wx8b+tnJM7XcF6XZINMLO+oNnJvBs1eWn6QcCpGa8YRwRPRIPJ48992v8l1mU4Kvlw9n7uOVQ7OoO9cLl3zJVee4Yx5TCBNsJA8ovrvDROM089NBCuCKDFL0k/cI+0J/TplUfv2lJM39Wtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129152; c=relaxed/simple;
	bh=4A5/VK+2MG1GRC9acky8SRqZUMeTDDinHw+H0vvsnJg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PkV6i6XJktnK+xcr6CpOBfvtX0cjXgG6BLkRgklSO5nrXGP6fBzB0VwDV8fSuvPv6O0AuG7xrM0REjGhc7NM+P96sgmYE76uOzl8QShtLYo92vn9YQxQ8O+7Opb3+8/qFCOVJBongmlMmoQtYxx7f1FgXr900oeP9QtJeVeV+oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=Wun4vL/m; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=1uI8pqsofK/GNmEXp9mUWfXJG229oaayJTNKizO6zrw=;
	b=Wun4vL/mvOPwY8ZObukK2adv46/rIqHhWS5r5L9LK+0ogCDWsmQoUrE138XEHxHt2q5sqGkNm
	Z0VUDzWjl2lctQ59IfXNAnf7MYfnPT/gSfQk+999Bds4zQ8+Sj3tjpnfeJXchivXUszgGPyVcQa
	SUOrW960YSrENGB2PyoNu00=
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4c9X211S54zYkxf9;
	Mon, 25 Aug 2025 21:38:49 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Aug
 2025 21:39:00 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 25 Aug
 2025 21:38:59 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
	<liam.howlett@oracle.com>, <lorenzo.stoakes@oracle.com>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v5 0/2] Do not delay oom reaper when the victim is frozen
Date: Mon, 25 Aug 2025 21:38:53 +0800
Message-ID: <20250825133855.30229-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a018.hihonor.com
 (10.68.17.250)

patch 1 do not delay oom reaper when the victim is frozen, patch 2 makes
the OOM reaper and exit_mmap() traverse the maple tree in opposite orders
to reduce PTE lock contention caused by unmapping the same vma.

About patch 1:
Patch 1 uses frozen() to check the frozen state of a single thread to
determine if a process is frozen, rather than checking all threads,
because the frozen state of all threads in a process will eventually be
consistent. There is no need to strictly confirm that all threads are
frozen; it is only necessary to check whether the process has been frozen
or is about to be frozen.

When a process is frozen, if it cannot be unfrozen promptly, the delayed
two-second oom reaper cannot guarantee that robust futexes will not be
reaped. So the processes holding robust futexes should not be frozen.
This patch will not make issue [1] worse.

About patch 2:
I tested the changes of patch 2 on Android. The reproduction steps are as
follows: Start a process, then kill it like oom kill does, and actively add
it to the oom reaper.

The perf data applying patch 1 but not patch 2:
|--99.74%-- oom_reaper
|  |--76.67%-- unmap_page_range
|  |  |--33.70%-- __pte_offset_map_lock
|  |  |  |--98.46%-- _raw_spin_lock
|  |  |--27.61%-- free_swap_and_cache_nr
|  |  |--16.40%-- folio_remove_rmap_ptes
|  |  |--12.25%-- tlb_flush_mmu
|  |--12.61%-- tlb_finish_mmu

The perf data applying patch 1 and patch 2:
|--98.84%-- oom_reaper
|  |--53.45%-- unmap_page_range
|  |  |--24.29%-- [hit in function]
|  |  |--48.06%-- folio_remove_rmap_ptes
|  |  |--17.99%-- tlb_flush_mmu
|  |  |--1.72%-- __pte_offset_map_lock
|  |  
|  |--30.43%-- tlb_finish_mmu

It is obvious that the lock contention on the pte spinlock will be very
intense when they traverse the tree along the same path.

On low-memory Android devices, high memory pressure often requires killing
processes to free memory, which is generally accepted on Android. lmkd, a
user-space program that actively kills processes, needs to asynchronously
call process_mrelease to release memory from killed processes, similar to
the oom reaper. At the same time, OOM events are not rare. Therefore,
reducing lock contention on __oom_reap_task_mm is meaningful.

Link: https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u [1]

---
v4 -> v5:
1. Detect the frozen state of the process instead of checking the futex state,
   as special handling of futex locks should be avoided during OOM kill [2].
2. Use mas_find_rev() to traverse the VMA tree instead of vma_prev(), because
   vma_prev() may skip the first VMA and should not be used here. [3]
3. Just check ishould_delay_oom_reap() in queue_oom_reaper() since it is not
   hot path. [4]

v4 link:
https://lore.kernel.org/linux-mm/20250814135555.17493-1-zhongjinji@honor.com/

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

v3 link:  
https://lore.kernel.org/all/20250804030341.18619-1-zhongjinji@honor.com/
https://lore.kernel.org/all/20250804030341.18619-2-zhongjinji@honor.com/

v2 -> v3:
1. It mainly fixed the error in the Subject prefix, changing it from futex to
   mm/oom_kill.
v2 link:
https://lore.kernel.org/linux-mm/20250801153649.23244-1-zhongjinji@honor.com/
https://lore.kernel.org/linux-mm/20250801153649.23244-2-zhongjinji@honor.com/

v1 -> v2:
1. Check the robust_list of all threads instead of just a single thread.
v1 link:
https://lore.kernel.org/linux-mm/20250731102904.8615-1-zhongjinji@honor.com/

Reference:
https://lore.kernel.org/linux-mm/aKRWtjRhE_HgFlp2@tiehlicka/ [2]
https://lore.kernel.org/linux-mm/26larxehoe3a627s4fxsqghriwctays4opm4hhme3uk7ybjc5r@pmwh4s4yv7lm/
[3]
https://lore.kernel.org/linux-mm/d5013a33-c08a-44c5-a67f-9dc8fd73c969@lucifer.local/ [4]

*** BLURB HERE ***

zhongjinji (2):
  mm/oom_kill: Do not delay oom reaper when the victim is frozen
  mm/oom_kill: Have the OOM reaper and exit_mmap() traverse the maple
    tree in opposite order

 mm/oom_kill.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

-- 
2.17.1


