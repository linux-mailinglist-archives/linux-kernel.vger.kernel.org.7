Return-Path: <linux-kernel+bounces-791230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 321AFB3B3B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FB0A01B70
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B9261B75;
	Fri, 29 Aug 2025 06:56:07 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44D725FA0E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 06:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756450567; cv=none; b=AAesKGOSV8mvikmAGQGr/NIgEY/mxD88guVIUlD3CVGRZwPt0tIuYQOMoupnUydjs9EXX6bJM48AGzsnJkwbqXgJpwAbWdGTwc3403Zw89wCgh1hNgOoVzoNynu2a+dXosnPTS4adIjNu1q1sMd//PzOT+Qs5MTPqM18zq/2lZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756450567; c=relaxed/simple;
	bh=H+/h9lfQ+FH6La1N6uX7OFtg3RJaGWFPxhs44OcZ1aU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A90o5hUR7dCatcA6F26r9g+V0hk6wh1yuI9wO7DgECqeaBgh9xhko17v9Y6zhq+/V84T2iearPvvas95az/2YIY09m4XEWsdOWz5KruH0XskMgGjWEfiPRlmpKlOg4lFFR5HTzb6bFYwTg9/3sFu/UROtnhIGfcOCcvGdtDHgCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w013.hihonor.com (unknown [10.68.26.19])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cCptx4dPpzYlK91;
	Fri, 29 Aug 2025 14:55:37 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w013.hihonor.com
 (10.68.26.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 29 Aug
 2025 14:55:55 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 29 Aug
 2025 14:55:54 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
	<liam.howlett@oracle.com>, <lorenzo.stoakes@oracle.com>, <surenb@google.com>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, <tianxiaobin@honor.com>,
	<fengbaopeng@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v6 0/2] Do not delay OOM reaper when the victim is frozen
Date: Fri, 29 Aug 2025 14:55:48 +0800
Message-ID: <20250829065550.29571-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a018.hihonor.com
 (10.68.17.250)

An overview of the relationship between patch 1 and patch 2:
With patch 1 applied, the OOM reaper is no longer delayed when the victim
process is frozen. If the victim process is thawed in time, the OOM reaper
and the exit_mmap() thread may run concurrently, which can lead to
significant spinlock contention. Patch 2 mitigates this issue by traversing
the maple tree in reverse order, reducing the likelihood of such lock
contention.

The attached test data was collected on Android. It shows that when the OOM
reaper and exit_mmap are executed at the same time, pte spinlock contention
becomes more intense. This results in increased running time for both
processes, which in turn means higher system load. It also shows that
reverse-order traversal of the VMA maple tree by the OOM reaper can
significantly reduce pte spinlock contention.

The test data indicate that it can significantly reduce spinlock contention
and decrease the load (measured by process running time) of both oom_reaper
and exit_mmap by 30%.

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

This is test data regarding the process running time.

With oom reaper (reverse traverse):
  Thread            TID     State     Wall duration (ms)
  RxComputationT   13708    Running   60.69
  oom_reaper        81      Running   46.49
  Total (ms): 107.18

With oom reaper:
  Thread            TID     State     Wall duration (ms)
  vdp:vidtask:m    14040    Running   81.85
  oom_reaper        81      Running   69.32
  Total (ms): 151.17

Without oom reaper:
  Thread            TID     State     Wall duration (ms)
  tp-background     12424   Running   106.02
  Total (ms): 106.02

Note: RxComputationT, vdp:vidtask:m, and tp-background are threads of the
same process, and they are the last threads to exit.

---
v5 -> v6:
- Use mas_for_each_rev() for VMA traversal [6]
- Simplify the judgment of whether to delay in queue_oom_reaper() [7]
- Refine changelog to better capture the essence of the changes [8]
- Use READ_ONCE(tsk->frozen) instead of checking mm and additional
  checks inside for_each_process(), as it is sufficient [9]
- Add report tags because fengbaopeng and tianxiaobin reported the
  high load issue of the reaper

v4 -> v5:
- Detect frozen state directly, avoid special futex handling. [3]
- Use mas_find_rev() for VMA traversal to avoid skipping entries. [4]
- Only check should_delay_oom_reap() in queue_oom_reaper(). [5]

v3 -> v4:
- Renamed functions and parameters for clarity. [2]
- Added should_delay_oom_reap() for OOM reap decisions.
- Traverse maple tree in reverse for improved behavior.

v2 -> v3:
- Fixed Subject prefix error.

v1 -> v2:
- Check robust_list for all threads, not just one. [1]

Reference:
[1] https://lore.kernel.org/linux-mm/u3mepw3oxj7cywezna4v72y2hvyc7bafkmsbirsbfuf34zpa7c@b23sc3rvp2gp/
[2] https://lore.kernel.org/linux-mm/87cy99g3k6.ffs@tglx/
[3] https://lore.kernel.org/linux-mm/aKRWtjRhE_HgFlp2@tiehlicka/
[4] https://lore.kernel.org/linux-mm/26larxehoe3a627s4fxsqghriwctays4opm4hhme3uk7ybjc5r@pmwh4s4yv7lm/
[5] https://lore.kernel.org/linux-mm/d5013a33-c08a-44c5-a67f-9dc8fd73c969@lucifer.local/
[6] https://lore.kernel.org/linux-mm/nwh7gegmvoisbxlsfwslobpbqku376uxdj2z32owkbftvozt3x@4dfet73fh2yy/
[7] https://lore.kernel.org/linux-mm/af4edeaf-d3c9-46a9-a300-dbaf5936e7d6@lucifer.local/
[8] https://lore.kernel.org/linux-mm/aK71W1ITmC_4I_RY@tiehlicka/
[9] https://lore.kernel.org/linux-mm/jzzdeczuyraup2zrspl6b74muf3bly2a3acejfftcldfmz4ekk@s5mcbeim34my/

The earlier post:
v5: https://lore.kernel.org/linux-mm/20250825133855.30229-1-zhongjinji@honor.com/
v4: https://lore.kernel.org/linux-mm/20250814135555.17493-1-zhongjinji@honor.com/
v3: https://lore.kernel.org/linux-mm/20250804030341.18619-1-zhongjinji@honor.com/
v2: https://lore.kernel.org/linux-mm/20250801153649.23244-1-zhongjinji@honor.com/
v1: https://lore.kernel.org/linux-mm/20250731102904.8615-1-zhongjinji@honor.com/

zhongjinji (2):
  mm/oom_kill: Do not delay oom reaper when the victim is frozen
  mm/oom_kill: The OOM reaper traverses the VMA maple tree in reverse
    order

 mm/oom_kill.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

-- 
2.17.1


