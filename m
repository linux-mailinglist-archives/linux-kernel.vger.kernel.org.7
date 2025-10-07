Return-Path: <linux-kernel+bounces-844793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF5BC2C94
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 23:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCA11899185
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 21:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D580C2580E1;
	Tue,  7 Oct 2025 21:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pEsKjfEh"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C6123D7EB
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759873463; cv=none; b=gXoF8/B3G67QQcpa78qedpC0fTsPGLVF/SByEuCN6cu2A9uPM4ZwCGbxDqqk+skXHbLbTWAMlD3Iw6IQy2s8752J3As7Jv25Wg+wDiNIJEIrhjY9J41oSA8uJTi4zvsJ9D6e5GNEdUnsXWCpwfOpFWSgQv+YYpp8r1B57IXzsXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759873463; c=relaxed/simple;
	bh=9ATgpajYqPbWUEOZbjmpVFtNwtU+nUdpqff+qkI9n6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tfno7qO0M13e14if4nvzMa3/rEzhFjt2blquwndvkk4M3Cmfna619S1JK6hCgcsS1v4B+VZP7mV1ipJITriO62YQRRyS7lCqL4W07MUcZXNnNShFV312EGUhM+fOVqyY/40qjKrKnvIrizXzd6vz5LmOpJpmqjZgx3rCtMnK218=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pEsKjfEh; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-85b94fe19e2so661093185a.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759873460; x=1760478260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZ6FNVlq5hGhSL7hTDiUZ66uQN+FQVKqg+d4ewOqZ7w=;
        b=pEsKjfEh825le5gbTJjmBtcoSKNfF4369718MK2el+WkKOnduJy7PfAFO380bev/d1
         xrqmKdcyCYWcpoXkG9+YEu0eFi2dBWjxwMHAD8iZJ1P71ChDtwydPuLb0lXIqK0hP0tz
         daBtc1MgiQnP1Z95VZQlVoNIs2ZaUSJ3sVjYUgFN8VKpkd3s1mhBooCdfIgDCJ/j4F8q
         VW+bdr79js76JN2jWiCPEQhV/RQ+l5j4quxhQHDNUob8Kreudoe7vULaeVb0kWvumofB
         wNAqPK3qZ8n6RmLXZr15V1X71kzBS4ni5vMxrySOrbe+baL585wqycC1ouOFmfLwosac
         J0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759873460; x=1760478260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZ6FNVlq5hGhSL7hTDiUZ66uQN+FQVKqg+d4ewOqZ7w=;
        b=BdqlzUvgvmG6dFLcAacxj2bsHsNPHcOH8d4OpBr+11s6tHOJSXGUPf/3yt/e8EO/Vi
         VriWBgkyaxMWNEkjuurwLObAaXuAga9FTAAcJs7EIXJNDNOYjOjrpAphqLsesw5ej9F3
         Aq9mamSfiH83g5S1jsshdqbUEMofdbVRxkBlK7F2ymGizoqsXBKlG8A2sLD1Qc9Cw0DD
         fWKd3JAiMtWslRpQPDsFmd0/X13ssz2gSUKPK9GF8+djWT8Xq9QtN9LjaSdSmJr2Ksal
         7C9n/CANBCp1W9xnb4/au6NZY/o3mo28j2d6yZ/aakb5YFLRLURN7rc1HTxzQ7uBnpni
         ew7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEPBzPEBRwnPd88JVwezPxhmLyuiZ3/BdoZawoBLWpqibUQhNzpwVBe/s0zBmJ4S2ia4Ze7HYYKLcOytQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXuvR+R25EQptQ9pB5Y7VLWqBZW0gDKT3ZnAcDWzwGccOmFPUO
	6M0Ozs5Ku6ZtDReXj+KOgjDUCNtBwpaB77JkpjC6lXvTpxnLg8IEii6bexNBd2hTCjg=
X-Gm-Gg: ASbGnct4ip/K84Cv6C7s66zc4dlux5rnIO+HZhz75+ZpaFnWFmQZ4Qq7wqlaCbhmWZ4
	BxwRpTehIwKoKQll531tl5OSEqzLyyVk/DZgQrN5mPiRMlyIdWjOxdGzcyscfmxlm67FaClM6iy
	F/gHn8ZN2MDUMect5ZrYlTr0FhCFJoPv84rFTm5BfdQS6ZWbJfPTpNgEXvuB2bEeDduw1c2hLTe
	+m/seWFBtJgt5vzeaA1FDkxazavWYXVisYXCHwP+7ajQjSZXPRuX/v2nYm7S4yS9sOOEQCdBNM4
	10pTG0YAiF+WK0xcrY9lLkI+vjHrX2/CVkMe01MsFfravO+t4rjZxGrlV29PGHgP0lecb4WzLxO
	rz2qLxJW3PK9+JOPcw0RcJogShI+El9ivuEdQkY6edYqiFy4xmzx02BKWHEjLGh7Mwb2c519ZuM
	E9cbCp+Y7eW8muTFMK1w9ngUkvrwHH/HQpKfw=
X-Google-Smtp-Source: AGHT+IGN6hSDMo/jOmPaXEPkY0HVxfHCLbCnKRX69X29HAgR3RScLY8hno4OXo4smrIIuH6tZiBVUQ==
X-Received: by 2002:a05:620a:1a8a:b0:80d:6f37:ed35 with SMTP id af79cd13be357-88352d95aa5mr264472085a.73.1759873459722;
        Tue, 07 Oct 2025 14:44:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129fcdsm1574102885a.13.2025.10.07.14.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 14:44:19 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: corbet@lwn.net,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	laoar.shao@gmail.com,
	gourry@gourry.net,
	brauner@kernel.org,
	mclapinski@google.com,
	joel.granados@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	David Rientjes <rientjes@google.com>
Subject: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable sysctl"
Date: Tue,  7 Oct 2025 17:44:12 -0400
Message-ID: <20251007214412.3832340-1-gourry@gourry.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit d6cb41cc44c63492702281b1d329955ca767d399.

This sysctl provides some flexibility between multiple requirements which
are difficult to square without adding significantly more complexity.

1) onlining memory in ZONE_MOVABLE to maintain hotplug compatibility
2) onlining memory in ZONE_MOVABLE to prevent GFP_KERNEL usage
3) passing NUMA structure through to a virtual machine (node0=vnode0,
   node1=vnode1) so a guest can make good placement decisions.
4) utilizing 1GB hugepages for VM host memory to reduce TLB pressure
5) Managing device memory after init-time to avoid incidental usage
   at boot (due to being placed in ZONE_NORMAL), or to provide users
   configuration flexibility.

When device-hotplugged memory does not require hot-unplug assurances,
there is no reason to avoid allowing otherwise non-migratable hugepages
in this zone.  This allows for allocation of 1GB gigantic pages for VMs
with existing mechanisms.

Boot-time CMA is not possible for driver-managed hotplug memory, as CMA
requires the memory to be registered as SystemRAM at boot time.

Updated the code to land in appropriate locations since it all moved.
Updated the documentation to add more context when this is useful.

Cc: David Hildenbrand <david@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Alexandru Moise <00moses.alexander00@gmail.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Suggested-by: David Rientjes <rientjes@google.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
Link: https://lore.kernel.org/all/20180201193132.Hk7vI_xaU%25akpm@linux-foundation.org/
---
 Documentation/admin-guide/sysctl/vm.rst | 31 +++++++++++++++++++++++++
 include/linux/hugetlb.h                 |  4 +++-
 mm/hugetlb.c                            |  9 +++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 4d71211fdad8..c9f26cd447d7 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -40,6 +40,7 @@ Currently, these files are in /proc/sys/vm:
 - enable_soft_offline
 - extfrag_threshold
 - highmem_is_dirtyable
+- hugepages_treat_as_movable
 - hugetlb_shm_group
 - laptop_mode
 - legacy_va_layout
@@ -356,6 +357,36 @@ only use the low memory and they can fill it up with dirty data without
 any throttling.
 
 
+hugepages_treat_as_movable
+==========================
+
+This parameter controls whether otherwise immovable hugepages (e.g. 1GB
+gigantic pages) may be allocated from from ZONE_MOVABLE. If set to non-zero,
+gigantic hugepages can be allocated from ZONE_MOVABLE. ZONE_MOVABLE memory
+may be created via the kernel boot parameter `kernelcore` or via memory
+hotplug as discussed in Documentation/admin-guide/mm/memory-hotplug.rst.
+
+Support may depend on specific architecture and/or the hugepage size. If
+a hugepage supports migration, allocation from ZONE_MOVABLE is always
+enabled (for example 2MB on x86) for the hugepage regardless of the value
+of this parameter. IOW, this parameter affects only non-migratable hugepages.
+
+Assuming that hugepages are not migratable in your system, one usecase of
+this parameter is that users can make hugepage pool more extensible by
+enabling the allocation from ZONE_MOVABLE. This is because on ZONE_MOVABLE
+page reclaim/migration/compaction work more and you can get contiguous
+memory more likely. Note that using ZONE_MOVABLE for non-migratable
+hugepages can do harm to other features like memory hotremove (because
+memory hotremove expects that memory blocks on ZONE_MOVABLE are always
+removable,) so it's a trade-off responsible for the users.
+
+One common use-case of this feature is allocate 1GB gigantic pages for
+virtual machines from otherwise not-hotplugged memory which has been
+isolated from kernel allocations by being onlined into ZONE_MOVABLE.
+These pages tend to be allocated and released more explicitly, and so
+hotplug can still be achieved with appropriate orchestration.
+
+
 hugetlb_shm_group
 =================
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 526d27e88b3b..bbaa1b4908b6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -172,6 +172,7 @@ bool hugetlbfs_pagecache_present(struct hstate *h,
 
 struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio);
 
+extern int hugepages_treat_as_movable;
 extern int sysctl_hugetlb_shm_group;
 extern struct list_head huge_boot_pages[MAX_NUMNODES];
 
@@ -926,7 +927,8 @@ static inline gfp_t htlb_alloc_mask(struct hstate *h)
 {
 	gfp_t gfp = __GFP_COMP | __GFP_NOWARN;
 
-	gfp |= hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
+	gfp |= (hugepage_movable_supported(h) || hugepages_treat_as_movable) ?
+	       GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
 
 	return gfp;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 753f99b4c718..4b2213ccbb29 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -55,6 +55,8 @@
 #include "hugetlb_cma.h"
 #include <linux/page-isolation.h>
 
+int hugepages_treat_as_movable;
+
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
 struct hstate hstates[HUGE_MAX_HSTATE];
@@ -5195,6 +5197,13 @@ static const struct ctl_table hugetlb_table[] = {
 		.mode		= 0644,
 		.proc_handler	= hugetlb_overcommit_handler,
 	},
+	{
+		.procname	= "hugepages_treat_as_movable",
+		.data		= &hugepages_treat_as_movable,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 };
 
 static void __init hugetlb_sysctl_init(void)
-- 
2.51.0


