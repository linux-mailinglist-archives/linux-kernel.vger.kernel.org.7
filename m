Return-Path: <linux-kernel+bounces-755889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C46B1ACF8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 05:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA7B189D3A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 03:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0477B1F4C99;
	Tue,  5 Aug 2025 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNJP62h7"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8441F4192
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 03:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754366102; cv=none; b=E4WlemA3nBrqOfPJ89KezO6wD6KREGeHw0c5sPl7QPLx2ZjVOy+xtEIzjTtos6g76auILCQ0wPQDXe7Y/pahYIrXRiT96hlHxSRIplMMN0RFBOtfT1OYQXHSO4GbfyB+JRMSnPmZ65Oz/arS+3JdHPMWh+fuxka6oc7ulHzlZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754366102; c=relaxed/simple;
	bh=NcmlCtxHcEDQIZTMhwl38EYOWlxw5i9mob2Lw9fJyJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=txIM18ReuktpfSiLdd8249ADtAjNufhmKM1wy2evy/CjtSicMNXL0oOfbJWzAnByXY3B8cmiW+PkpaEhB7aDGrkxujvzMh8BEPCTHg1wY0agmkSk/CQRHEzKWfr7XR7SuRfyVv80nJznZuvXTZCyDMuxGVFSoX88BLTGev4Pxws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNJP62h7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bd202ef81so5559168b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 20:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754366100; x=1754970900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kn/kjDJbLDIHElYk8Kpqr2EGBYFuzsNf7XyiOkmYajw=;
        b=cNJP62h7FqP5KbQp4jlLRO6GFqjRlPeQupW2YhmUf5GHIw2suqgxyasrHMuKnHZAIW
         ltb78QGjmq1aB0P2Z8KN4IqJ5vMvpTt+vQxaY4CKWgMgUH3nC5BPWIvbCnEbEJvhHVts
         bHhUfDyN0o+gnVa8ufhZy7Q6l8ut3UWG11SedJU9qMJ732X5BPwUgySKVsBAIyEE6r3B
         /p5YiGIS2dpKGfhQ/BoL3WCYw0nlo/1sXE97Q+DesHeQGrVhOFonD9811HzwI3Lok8Lu
         M/fFgDinqzu65w5+ajp5AmVkYbX8MXWh0s5f+JxdV4YZ0/jYOAH1Q6N8WrUuH0xyYyyg
         NpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754366100; x=1754970900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kn/kjDJbLDIHElYk8Kpqr2EGBYFuzsNf7XyiOkmYajw=;
        b=ocz7ZYG5OfwQsNS7oRKCTnYrWVPQ+fDW7F9BH2xpx5M3b+GXVlM7VjpFgdDBjo80IQ
         9VhCSiqjOTDd08jNiAZuWKVu82zqaVqvS/7qBhgMVgs/OxvSTUowNuUajcfD72QLgIf1
         9C2VhcAaMvscranlwaGJDCQAATj4Kq3GhnBzkDuR/cuYbMgEOFTX1CS5MT8M+AdZ6VbC
         epH0yA0cm4z4zJptcMKpGWYcv6TUiYJxMgoYXySBPgdic2TpPdYhE9YaFxI9BbR13/AJ
         NLRYLoiJvbnqQwMfT4l1LkoSTKjybsinle6fLHvnxj3NF37UOcvubDdLiFd1L6F7D8mu
         rz6g==
X-Gm-Message-State: AOJu0Yyocj0DuuDuImvV5+RG4fTc7okRTMYsRlsO4dMDSpl1WwzSbwg6
	7aj/P/ocSoyQ/ADz50mTNDxFfvyZSovEP3r03OJ8FTfzYgLqoRyDWbbj
X-Gm-Gg: ASbGncs7LRK+tc1aqPpMiGkw9yP/hvl31q51AeEoxMKVTSX3Nm0XziQkFUnofr+mZzz
	tKIgOZD+Z4TvqhxtJj9rmT1V2/bE2fpnCONtGyAHdv+TYN78uUv29zRhg2flxw0Gvw649VIec7G
	jwxWqDbd/voEWX0bZxLrq9Q3K6GYQeVSsFogaEJU23oHxu+SK9WzhSrrROiNGryDnBHPLHYLOjN
	yMV7k7sOKu/BnIgrJ8JunjSFD0gVn+P2odmvVYtZdxQXSds8sTA45v9JsMKCkD3bUI55qYG9Zhn
	VyeOK/8e42sCW0XoX5PHhZDL0kpUPzQlcZRhrJcvIWvOSp6WzzsrKyBEJeEct3uA4pkqc9YuQ96
	7bJNi3D2yebsFPTw2G+h7Ykh9PMh5aqg5
X-Google-Smtp-Source: AGHT+IEDoMfcCLIiYtU2HXEp6LOx9BrUl8fsP0ILlEd7EEB3Sw0CsktiKiv4Pv2bZ6wBHJQxNBmbsA==
X-Received: by 2002:a05:6a20:a83:b0:23f:f99d:462b with SMTP id adf61e73a8af0-23ff99d48a9mr9270147637.41.1754366099904;
        Mon, 04 Aug 2025 20:54:59 -0700 (PDT)
Received: from Barrys-MBP.hub ([118.92.21.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7e4fc1sm10071141a12.28.2025.08.04.20.54.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Aug 2025 20:54:59 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Lance Yang <ioworker0@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] mm: Fix the race between collapse and PT_RECLAIM under per-vma lock
Date: Tue,  5 Aug 2025 11:54:47 +0800
Message-Id: <20250805035447.7958-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

The check_pmd_still_valid() call during collapse is currently only
protected by the mmap_lock in write mode, which was sufficient when
pt_reclaim always ran under mmap_lock in read mode. However, since
madvise_dontneed can now execute under a per-VMA lock, this assumption
is no longer valid. As a result, a race condition can occur between
collapse and PT_RECLAIM, potentially leading to a kernel panic.

 [   38.151897] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASI
 [   38.153519] KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
 [   38.154605] CPU: 0 UID: 0 PID: 721 Comm: repro Not tainted 6.16.0-next-20250801-next-2025080 #1 PREEMPT(voluntary)
 [   38.155929] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org4
 [   38.157418] RIP: 0010:kasan_byte_accessible+0x15/0x30
 [   38.158125] Code: 03 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 0f 1f 00 48 b8 00 00 00 00 00 fc0
 [   38.160461] RSP: 0018:ffff88800feef678 EFLAGS: 00010286
 [   38.161220] RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 1ffffffff0dde60c
 [   38.162232] RDX: 0000000000000000 RSI: ffffffff85da1e18 RDI: dffffc0000000003
 [   38.163176] RBP: ffff88800feef698 R08: 0000000000000001 R09: 0000000000000000
 [   38.164195] R10: 0000000000000000 R11: ffff888016a8ba58 R12: 0000000000000018
 [   38.165189] R13: 0000000000000018 R14: ffffffff85da1e18 R15: 0000000000000000
 [   38.166100] FS:  0000000000000000(0000) GS:ffff8880e3b40000(0000) knlGS:0000000000000000
 [   38.167137] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [   38.167891] CR2: 00007f97fadfe504 CR3: 0000000007088005 CR4: 0000000000770ef0
 [   38.168812] PKRU: 55555554
 [   38.169275] Call Trace:
 [   38.169647]  <TASK>
 [   38.169975]  ? __kasan_check_byte+0x19/0x50
 [   38.170581]  lock_acquire+0xea/0x310
 [   38.171083]  ? rcu_is_watching+0x19/0xc0
 [   38.171615]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
 [   38.172343]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
 [   38.173130]  _raw_spin_lock+0x38/0x50
 [   38.173707]  ? __pte_offset_map_lock+0x1a2/0x3c0
 [   38.174390]  __pte_offset_map_lock+0x1a2/0x3c0
 [   38.174987]  ? __pfx___pte_offset_map_lock+0x10/0x10
 [   38.175724]  ? __pfx_pud_val+0x10/0x10
 [   38.176308]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
 [   38.177183]  unmap_page_range+0xb60/0x43e0
 [   38.177824]  ? __pfx_unmap_page_range+0x10/0x10
 [   38.178485]  ? mas_next_slot+0x133a/0x1a50
 [   38.179079]  unmap_single_vma.constprop.0+0x15b/0x250
 [   38.179830]  unmap_vmas+0x1fa/0x460
 [   38.180373]  ? __pfx_unmap_vmas+0x10/0x10
 [   38.180994]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
 [   38.181877]  exit_mmap+0x1a2/0xb40
 [   38.182396]  ? lock_release+0x14f/0x2c0
 [   38.182929]  ? __pfx_exit_mmap+0x10/0x10
 [   38.183474]  ? __pfx___mutex_unlock_slowpath+0x10/0x10
 [   38.184188]  ? mutex_unlock+0x16/0x20
 [   38.184704]  mmput+0x132/0x370
 [   38.185208]  do_exit+0x7e7/0x28c0
 [   38.185682]  ? __this_cpu_preempt_check+0x21/0x30
 [   38.186328]  ? do_group_exit+0x1d8/0x2c0
 [   38.186873]  ? __pfx_do_exit+0x10/0x10
 [   38.187401]  ? __this_cpu_preempt_check+0x21/0x30
 [   38.188036]  ? _raw_spin_unlock_irq+0x2c/0x60
 [   38.188634]  ? lockdep_hardirqs_on+0x89/0x110
 [   38.189313]  do_group_exit+0xe4/0x2c0
 [   38.189831]  __x64_sys_exit_group+0x4d/0x60
 [   38.190413]  x64_sys_call+0x2174/0x2180
 [   38.190935]  do_syscall_64+0x6d/0x2e0
 [   38.191449]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

This patch moves the vma_start_write() call to precede
check_pmd_still_valid(), ensuring that the check is also properly
protected by the per-VMA lock.

Fixes: a6fde7add78d ("mm: use per_vma lock for MADV_DONTNEED")
Tested-by: "Lai, Yi" <yi1.lai@linux.intel.com>
Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
Closes: https://lore.kernel.org/all/aJAFrYfyzGpbm+0m@ly-workstation/
Cc: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Dev Jain <dev.jain@arm.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 374a6a5193a7..6b40bdfd224c 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1172,11 +1172,11 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 	/* check if the pmd is still valid */
+	vma_start_write(vma);
 	result = check_pmd_still_valid(mm, address, pmd);
 	if (result != SCAN_SUCCEED)
 		goto out_up_write;
 
-	vma_start_write(vma);
 	anon_vma_lock_write(vma->anon_vma);
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
-- 
2.39.3 (Apple Git-146)


