Return-Path: <linux-kernel+bounces-845876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F92BC664F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 20:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073723C1830
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12122C0F8C;
	Wed,  8 Oct 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IfCjrhai"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205CD2BDC32
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759949909; cv=none; b=OqfV+lNKn9e/7N7/I66rJtr93udP/1EdZKIqgxdiAbhf2UNJ5ZtubIhSPVz9f+9HRCPn4FlbXtYg51z/dEUSPelSeM1dIHrSv2K/6nmS87G7NcZX91rMnCQeo+9/Sw88nCz1d9tSU1gJ471gscGWf4rKAMmiiu436IeDlZfGsyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759949909; c=relaxed/simple;
	bh=TYq9VoRcLXA9kbxCY/pbpd/mmhsJc874jIXXCR7fgco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0wTw1IByPsupgPdu4WsbEBExlh1N8e9Ff7awLg+nksiur9MdZwy/TWiXeRyuRxPWmM0TLpV/7a2ILVEyI5CEMhPC2zlNrgp4nl+HjL/MLxovafWi+jNvPJ/DGr7xLDDPsbE/1lSFbNO2qZJSkdkRcWMq6zgrL2U1xHlJTs1gsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IfCjrhai; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4d7b4b3c06dso707611cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 11:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759949907; x=1760554707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CgUP0/WmGKx+IVOsX9zNZJUjUIw/PkapcpGfi4V2VtU=;
        b=IfCjrhaiI3VNQeTXzTH7vicL6G1s40jiNuBn4ZAm9saidURQGgbkt9PpUbAl1C191Z
         7rC20W6rASFifwYEUfYSoPoyxT5otKhwLBwR58bA+RUsN29ithJ1xMLG8iLwEuLMdQVG
         68nhWXZQeFFoPW+Mi4En+yiI78STI4cft8tvKWKYvesrBGfLl2Ge1AiagAXbWnYQfnJ2
         LpCY4fD3HWG7XuG28aJIg5LKUyb1oOF4NVnupBKOWxcmTGs5FiOTseYxCe6MT2aYQUX1
         x6Y3MYVHyBxOJyPLNrUS38w+YRO1xyWHvhHbUBlNiZkfXc14gaXKK4GVeUmDRFvKI8Su
         DpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759949907; x=1760554707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgUP0/WmGKx+IVOsX9zNZJUjUIw/PkapcpGfi4V2VtU=;
        b=OemxpURWbmDDOSUiscUt39Kk6pm8SQHlED9jx3O/oK27KEmKuFO8kIpav2Qm0mOdkE
         VGDjdo6U0kRHfN4Bh6z8OQ9VxW73StLlrgMVkKrH3/t1ETEKqdAYXCw+CX/NnphPRwcF
         Fajf9csyfRxUUgoOFeqMOwVUy10c/bJNztU7dtQzYkVLCaHg7Eu2V2yHt8LNBBT8zydx
         MKQC8HnO2Sk38MySPd885qwX6NvTjukeGH5RHb6M6cHDTVbxlEIGD1VROHpdPL54dhqz
         7f11KlTl0+2LvH7IyDzdOsNj4amyqAtyqbSnEpiPosmfFaX2ZDGZAanh2U0fP/UQlQn0
         DEiA==
X-Forwarded-Encrypted: i=1; AJvYcCUTXztgU+7OztrwfwZsiRYwlc8MLVR3GekUwBEXz9AQTF0C4ljaGS+u4vLxL3AZmUjIw/4mVtUYqhiBNA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH4URtPodHzvUkTjU4noifRy3/rj47QwVGb06vvdIWObIrZXA1
	xq11HYcmek5bFfiy8YDw6MjqxadBFgJ0eztRJIEJlPH7KPU6nVaBY99NIuZtt9aOZDc=
X-Gm-Gg: ASbGncvRWgJ6wxcdqmSDzjx4JhZisCnsp7de1NVfl3SHSHEKyH01H7IyrzMP6ZaCZxk
	dZbzABht8JJfauZAENlAX90Fu98q69YasuS/VnQhdZJFmhnMA9r8ghDiK4LKAMmv8ff3b/fLSxD
	NOIfSOdsvN39jp+0RXHLNZo02RpdSqBx+8zde9Cz3Hiy5BjtiOY87EV2WwqBGI1tbdXMPiTSRy3
	iO88EQYMKIVPNaR1YXgFOCTAtwXo95TsVGovPUqj8yi4oUWolJSfYN+q2W/19dX8mgv5b4OaX7y
	fgbuXlrT+9PoSON1AvIOOyOebtefgYXOiKxrBqn+ZSL1WD/qxbQli0o4513Cxc8VZ7ise5ta2zG
	DzdGdzdIbS7wOF/EaBiinZuI66i9hxqGVR/XLz5LkQO5VSGgt9lT5bTAg2DEQaOwwJnMRJDZelX
	mQ88ctfUCBJXKQhRvR4nYSC8N2En7n+F45w4Y2vaOI
X-Google-Smtp-Source: AGHT+IH5XZl1zP5WV2H5vB1vEumTSPp138/9F+4pHEKVvEJpneB5APkZUlKul8CuzBvyHU3k2KlKsQ==
X-Received: by 2002:a05:622a:4c18:b0:4d9:f929:1531 with SMTP id d75a77b69052e-4e6eace963bmr71897761cf.23.1759949906731;
        Wed, 08 Oct 2025 11:58:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bb53d91fsm166731966d6.23.2025.10.08.11.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 11:58:26 -0700 (PDT)
Date: Wed, 8 Oct 2025 14:58:24 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, corbet@lwn.net, muchun.song@linux.dev,
	osalvador@suse.de, akpm@linux-foundation.org, hannes@cmpxchg.org,
	laoar.shao@gmail.com, brauner@kernel.org, mclapinski@google.com,
	joel.granados@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Alexandru Moise <00moses.alexander00@gmail.com>,
	David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] Revert "mm, hugetlb: remove hugepages_treat_as_movable
 sysctl"
Message-ID: <aOa0UPnxJVGvqc8S@gourry-fedora-PF4VCD3F>
References: <20251007214412.3832340-1-gourry@gourry.net>
 <402170e6-c49f-4d28-a010-eb253fc2f923@redhat.com>
 <aOZyt-7sf5PFCdpb@gourry-fedora-PF4VCD3F>
 <f4d0e176-b1d4-47f0-be76-4bff3dd7339a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4d0e176-b1d4-47f0-be76-4bff3dd7339a@redhat.com>

On Wed, Oct 08, 2025 at 04:44:22PM +0200, David Hildenbrand wrote:
> On 08.10.25 16:18, Gregory Price wrote:
> > On Wed, Oct 08, 2025 at 10:58:23AM +0200, David Hildenbrand wrote:
> > > On 07.10.25 23:44, Gregory Price wrote:
> > > I mean, this is as ugly as it gets.
> > > 
> > > Can't we just let that old approach RIP where it belongs? :)
> > > 
> > 
> > Definitely - just found this previously existed and wanted to probe for
> > how offensive reintroducing it would be. Seems the answer is essentially
> > "lets do it a little differently".
> > 
> > > Something I could sympathize is is treaing gigantic pages that are actually
> > > migratable as movable.
> > > 
> > ...
> > > -       gfp |= hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
> > > +       gfp |= hugepage_migration_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
> > > 
> > > Assume you want to offline part of the ZONE_MOVABLE there might still be sufficient
> > > space to possibly allocate a 1 GiB area elsewhere and actually move the gigantic page.
> > > 
> > > IIRC, we do the same for memory offlining already.
> > > 
> > 
> > This is generally true of other page sizes as well, though, isn't it?
> > If the system is truly so pressured that it can't successfully move a
> > 2MB page - offline may still fail.  So allowing 1GB pages is only a risk
> > in the sense that they're harder to allocate new targets.
> 
> Right, but memory defragmentation works on pageblock level, so 2 MiB is much
> MUCH more reliable :)
> 

fwiw this works cleanly.  Just dropping this here, but should continue
the zone conversation.  I need to check, but does this actually allow
pinnable allocations?  I thought pinning kicked off migration.

================== test =======================

# echo 1 > /proc/sys/vm/movable_gigantic_pages
# echo 1 > /sys/devices/system/node/node0/hugepages/hugepages-1048576kB/nr_hugepages
# echo 1 > /sys/devices/system/node/node1/hugepages/hugepages-1048576kB/nr_hugepages
# ./huge
Allocating 1GB hugepage
Binding hugepage to NUMA node 1
Faulting page in
Resetting mbind policy to MPOL_DEFAULT (local policy)
Migrating
Migrated pages from node 1 to node 0, pages not moved: 0

================== patch  =======================

commit 395988dc319771db980dab3f95ed9ec8f0b74945
Author: Gregory Price <gourry@gourry.net>
Date:   Tue Oct 7 10:11:51 2025 -0700

    mm, hugetlb: introduce movable_gigantic_pages

    Signed-off-by: Gregory Price <gourry@gourry.net>

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 9bef46151d53..1535c9a964dc 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -54,6 +54,7 @@ Currently, these files are in /proc/sys/vm:
 - mmap_min_addr
 - mmap_rnd_bits
 - mmap_rnd_compat_bits
+- movable_gigantic_pages
 - nr_hugepages
 - nr_hugepages_mempolicy
 - nr_overcommit_hugepages
@@ -624,6 +625,22 @@ This value can be changed after boot using the
 /proc/sys/vm/mmap_rnd_compat_bits tunable


+movable_gigantic_pages
+======================
+
+This parameter controls whether gigantic pages may be allocated from
+ZONE_MOVABLE. If set to non-zero, gigantic hugepages can be allocated
+from ZONE_MOVABLE. ZONE_MOVABLE memory may be created via the kernel
+boot parameter `kernelcore` or via memory hotplug as discussed in
+Documentation/admin-guide/mm/memory-hotplug.rst.
+
+Support may depend on specific architecture.
+
+Note that using ZONE_MOVABLE gigantic pages may make features like
+memory hotremove more unreliable, as migrating gigantic pages is more
+difficult due to needing larger amounts of phyiscally contiguous memory.
+
+
 nr_hugepages
 ============

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 42f374e828a2..834061eb2ddd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -172,6 +172,7 @@ bool hugetlbfs_pagecache_present(struct hstate *h,

 struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio);

+extern int movable_gigantic_pages __read_mostly;
 extern int sysctl_hugetlb_shm_group;
 extern struct list_head huge_boot_pages[MAX_NUMNODES];

@@ -924,7 +925,7 @@ static inline bool hugepage_movable_supported(struct hstate *h)
        if (!hugepage_migration_supported(h))
                return false;

-       if (hstate_is_gigantic(h))
+       if (hstate_is_gigantic(h) && !movable_gigantic_pages)
                return false;
        return true;
 }
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a0d285d20992..3f8f3d6f2d60 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -54,6 +54,8 @@
 #include "hugetlb_cma.h"
 #include <linux/page-isolation.h>

+int movable_gigantic_pages;
+
 int hugetlb_max_hstate __read_mostly;
 unsigned int default_hstate_idx;
 struct hstate hstates[HUGE_MAX_HSTATE];
@@ -5199,6 +5201,13 @@ static const struct ctl_table hugetlb_table[] = {
                .mode           = 0644,
                .proc_handler   = hugetlb_overcommit_handler,
        },
+       {
+               .procname       = "movable_gigantic_pages",
+               .data           = &movable_gigantic_pages,
+               .maxlen         = sizeof(int),
+               .mode           = 0644,
+               .proc_handler   = proc_dointvec,
+       },
 };

 static void __init hugetlb_sysctl_init(void)


================== huge.c =======================
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <string.h>
#include <errno.h>
#include <sys/syscall.h>
#include <linux/mempolicy.h>
#include <stdint.h>
#include <time.h>

#ifndef MAP_HUGE_SHIFT
#define MAP_HUGE_SHIFT 26
#endif

#ifndef MAP_HUGE_1GB
#define MAP_HUGE_1GB (30 << MAP_HUGE_SHIFT)
#endif

static long mbind_syscall(void *addr, unsigned long len, int mode,
                          const unsigned long *nodemask, unsigned long maxnode, unsigned flags) {
    return syscall(__NR_mbind, addr, len, mode, nodemask, maxnode, flags);
}

static long migrate_pages_syscall(pid_t pid, unsigned long maxnode,
                                  const unsigned long *from, const unsigned long *to) {
    return syscall(__NR_migrate_pages, pid, maxnode, from, to);
}

int main() {
    size_t size = 1UL << 30; // 1GB
    int node_from = 1;
    int node_to = 0;

    printf("Allocating 1GB hugepage\n");
    void *addr = mmap(NULL, size, PROT_READ | PROT_WRITE,
                      MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB | MAP_HUGE_1GB, -1, 0);
    if (addr == MAP_FAILED) {
        perror("mmap hugepage");
        return 1;
    }
    printf("Binding hugepage to NUMA node %d\n", node_from);
    unsigned long nodemask = 1UL << node_from;
    if (mbind_syscall(addr, size, MPOL_BIND, &nodemask, sizeof(nodemask) * 8, 0) != 0) {
        perror("mbind");
        munmap(addr, size);
        return 1;
    }
    printf("Faulting page in\n");
    ((volatile char *)addr)[0] = 0;
    printf("Resetting mbind policy to MPOL_DEFAULT (local policy)\n");
    if (mbind_syscall(addr, size, MPOL_DEFAULT, NULL, 0, 0) != 0) {
        perror("mbind failed to reset");
        munmap(addr, size);
        return 1;
    }
    printf("Migrating\n");
    unsigned long from_mask = 1UL << node_from;
    unsigned long to_mask = 1UL << node_to;
    long ret = migrate_pages_syscall(0, sizeof(unsigned long) * 8, &from_mask, &to_mask);
    if (ret < 0) {
        perror("migrate_pages");
        munmap(addr, size);
        return 1;
    }
    printf("Migrated pages from node %d to node %d, pages not moved: %ld\n", node_from, node_to, ret);
    munmap(addr, size);
    return 0;
}

