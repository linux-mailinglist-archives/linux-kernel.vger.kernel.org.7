Return-Path: <linux-kernel+bounces-885948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D12C3459C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51646465E8D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB452D6E73;
	Wed,  5 Nov 2025 07:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="KUTsAUSv"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4872C21E5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329003; cv=none; b=nqebWOhLy46dzFVf9cI4Srh+5esnA24Koa5I+4+/ux36JLY92efdIJsiy4OLDDsdv4uUMOLIV/dfSdONRZYqjTRkJCW3iUEg1W9KOYUJ+oPGMqNIw8gMuX4UnGd9NOtWWYF93IGQFlpxMCbO6aV2a8znjaNtSPt/OrCL5lFkSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329003; c=relaxed/simple;
	bh=d9ZQQw6oADUCSvtmaACwRX9dnlraJPsGIprhB01RZmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tqxiMSebAo2g8V49p21rXiHcF94RlCnQGWDPDxTHFpKU/yww6eYF2uyRtdFM2wdfnDC+Q4RgifMpFHsKvBWewESR4ZxZGfZzFZDZdwbbR87E1cEsDD3ZxdjUXJnPagcnffQFnhyZBKDlEBF43iaPS/ldETvyyyEEdyLIRlJ73Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=KUTsAUSv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-295ceaf8dacso30287955ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762329001; x=1762933801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h6ZDRkftaiRuIaXsVQnD3pYoLoBZQe+K8uOwtjlQzE0=;
        b=KUTsAUSvAybNmxW+w/6W047A16WFq8fql4aKH9Qq7WZxPqH/VA1BWPJRpYeIHKAr08
         oPqkxRktV3vi21CDWYS4drscHMV8x782omwy+ibmdS86nsmiW70ba6lwqh10HROMdfMJ
         oYUeMWW5iVm3c6IqcY6HIu7OaOs9EZHthKXW2DwSlpd/JNGY+Y/suVwAYTCUayYd8Mt1
         DKSBuTWwtj+GzEF9bm7XfSLocB4mMP4CW/O5JWGSxtnW6L8cuiSlKZD8vQ5OEtgwcm2L
         YVn9VsN1lop126W97GhLElBmFdrLF0Vn1g0th4SSglu5zwVvGssnzkzzJJIcp7IFm94N
         LUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762329001; x=1762933801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6ZDRkftaiRuIaXsVQnD3pYoLoBZQe+K8uOwtjlQzE0=;
        b=PAbJHBeU0ILiV4yQUFhDWBzUUT3zUumBqFNYs08TdpG72hp0rVep49WX5txik0wL+2
         YSQLXRCj4Dun5c2c4leBef5rJqrxlHSH01mIfrJ9CEL+EMb9vj+aooQCGof7jfclGAPH
         w5Yyk9Ylws3aKVc6ixoc830IPJ4llZH4yT10pRsI62h9oFLVmO/IvhjVjl+fxt0NlSYx
         YA2LuvzUA7daqVAKANrsY1kEw3wkMfwjUgbBoKCW6gbvHvYp39iYlYCwGIy0SIqKQCBr
         Rv6AiO+XNrw0M2U0LXdkESpyE4u7gTGLKo0CaA9y5EPFK4+6ybsJ2TNV3Y4ZpudtOvBN
         jgkg==
X-Forwarded-Encrypted: i=1; AJvYcCW4I1DnArmoh7P2Pv5kELv58dUZY/0p3zTeq7suYCKdqhjxG18LOdbSRc0LJGmZJQZkClMUjdROD6ezMAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycLj8I7hA8LSMPVzHsL2Ri+3sFjZlVA7MzeXX9j21oEOiYNw/Q
	XcOVePDohJInttaorrpuGq8LqQAeBbd0koEGPL3WlIBno1BY15oG+GLi8XUpQf3tp5A=
X-Gm-Gg: ASbGncuaeXQHukhGhmBHSY8G9x7/8uJ465RTM2HZkANg94yIr6zqgYxxl6zPC1QSkKT
	KNwWRoXaHFLHR9J8Vsqp3I6xToLenx9I/GlHnmo4woGQJsMg4QfMHPqfb8FeYREMCcKNvsHpOes
	dD2McPUYBUXij6qVjqs50LzqxwdvV48Y34tM/8UhMrDnQRinFtWYNRagaVQNnaMAhg/jmTOMsps
	FPgslyyz68Nq8LMXvqXdZEuDaeuxAhInp4uj64ec1l5TiJ6gpuY0C+njbVH9yo7B6Y5X+I5mazl
	0uzhqkJGMZAx+1BR17yXumyYDj/ZCu2y++BG7qaRDpxxT4HJJncJ+NuEnc/ITa8BSwXcNYGWfUt
	rvaaHHE68rQTkbkHCIfLXNFVx1BqwoTXURFP3x/RQh9an2FJB98RJtBDeABqyIdyJOryf6b4Rn+
	mQedZt9893kmsmlg2L4XwZw8ta
X-Google-Smtp-Source: AGHT+IHKjbv/6sAUPJqMP9Dl0+FTFfNEli/mX7VCSD5WGbBzuqeNeE5PeGE+njoNMn23lIVIEk6Frg==
X-Received: by 2002:a17:902:ef49:b0:295:4620:3e18 with SMTP id d9443c01a7336-2962ad2b255mr39869055ad.24.1762328999123;
        Tue, 04 Nov 2025 23:49:59 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd6a10f8fsm5295564b3a.68.2025.11.04.23.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:49:58 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	joel.granados@kernel.org,
	jack@suse.cz,
	laoar.shao@gmail.com,
	mclapinski@google.com,
	kyle.meyer@hpe.com,
	corbet@lwn.net,
	lance.yang@linux.dev,
	leon.huangfu@shopee.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: [PATCH mm-new v2] mm/memcontrol: Flush stats when write stat file
Date: Wed,  5 Nov 2025 15:49:16 +0800
Message-ID: <20251105074917.94531-1-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On high-core count systems, memory cgroup statistics can become stale
due to per-CPU caching and deferred aggregation. Monitoring tools and
management applications sometimes need guaranteed up-to-date statistics
at specific points in time to make accurate decisions.

This patch adds write handlers to both memory.stat and memory.numa_stat
files to allow userspace to explicitly force an immediate flush of
memory statistics. When "1" is written to either file, it triggers
__mem_cgroup_flush_stats(memcg, true), which unconditionally flushes
all pending statistics for the cgroup and its descendants.

The write operation validates the input and only accepts the value "1",
returning -EINVAL for any other input.

Usage example:
  # Force immediate flush before reading critical statistics
  echo 1 > /sys/fs/cgroup/mygroup/memory.stat
  cat /sys/fs/cgroup/mygroup/memory.stat

This provides several benefits:

1. On-demand accuracy: Tools can flush only when needed, avoiding
   continuous overhead

2. Targeted flushing: Allows flushing specific cgroups when precision
   is required for particular workloads

3. Integration flexibility: Monitoring scripts can decide when to pay
   the flush cost based on their specific accuracy requirements

The implementation is shared between cgroup v1 and v2 interfaces,
with memory_stat_write() providing the common validation and flush
logic. Both memory.stat and memory.numa_stat use the same write
handler since they both benefit from forcing accurate statistics.

Documentation is updated to reflect that these files are now read-write
instead of read-only, with clear explanation of the write behavior.

Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
---
v1 -> v2:
  - Flush stats when write the file (per Michal).
  - https://lore.kernel.org/linux-mm/20251104031908.77313-1-leon.huangfu@shopee.com/

 Documentation/admin-guide/cgroup-v2.rst | 31 +++++++++++++++++--------
 mm/memcontrol-v1.c                      |  2 ++
 mm/memcontrol-v1.h                      |  1 +
 mm/memcontrol.c                         | 13 +++++++++++
 4 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3345961c30ac..2a4a81d2cc2f 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1337,7 +1337,7 @@ PAGE_SIZE multiple when read back.
 	cgroup is within its effective low boundary, the cgroup's
 	memory won't be reclaimed unless there is no reclaimable
 	memory available in unprotected cgroups.
-	Above the effective low	boundary (or
+	Above the effective low	boundary (or
 	effective min boundary if it is higher), pages are reclaimed
 	proportionally to the overage, reducing reclaim pressure for
 	smaller overages.
@@ -1525,11 +1525,17 @@ The following nested keys are defined.
 	generated on this file reflects only the local events.

   memory.stat
-	A read-only flat-keyed file which exists on non-root cgroups.
+	A read-write flat-keyed file which exists on non-root cgroups.

-	This breaks down the cgroup's memory footprint into different
-	types of memory, type-specific details, and other information
-	on the state and past events of the memory management system.
+	Reading this file breaks down the cgroup's memory footprint into
+	different types of memory, type-specific details, and other
+	information on the state and past events of the memory management
+	system.
+
+	Writing the value "1" to this file forces an immediate flush of
+	memory statistics for this cgroup and its descendants, improving
+	the accuracy of subsequent reads. Any other value will result in
+	an error.

 	All memory amounts are in bytes.

@@ -1786,11 +1792,16 @@ The following nested keys are defined.
 		cgroup is mounted with the memory_hugetlb_accounting option).

   memory.numa_stat
-	A read-only nested-keyed file which exists on non-root cgroups.
+	A read-write nested-keyed file which exists on non-root cgroups.
+
+	Reading this file breaks down the cgroup's memory footprint into
+	different types of memory, type-specific details, and other
+	information per node on the state of the memory management system.

-	This breaks down the cgroup's memory footprint into different
-	types of memory, type-specific details, and other information
-	per node on the state of the memory management system.
+	Writing the value "1" to this file forces an immediate flush of
+	memory statistics for this cgroup and its descendants, improving
+	the accuracy of subsequent reads. Any other value will result in
+	an error.

 	This is useful for providing visibility into the NUMA locality
 	information within an memcg since the pages are allowed to be
@@ -2173,7 +2184,7 @@ of the two is enforced.

 cgroup writeback requires explicit support from the underlying
 filesystem.  Currently, cgroup writeback is implemented on ext2, ext4,
-btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are
+btrfs, f2fs, and xfs.  On other filesystems, all writeback IOs are
 attributed to the root cgroup.

 There are inherent differences in memory and writeback management
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 6eed14bff742..8cab6b52424b 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -2040,6 +2040,7 @@ struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "stat",
 		.seq_show = memory_stat_show,
+		.write_u64 = memory_stat_write,
 	},
 	{
 		.name = "force_empty",
@@ -2078,6 +2079,7 @@ struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "numa_stat",
 		.seq_show = memcg_numa_stat_show,
+		.write_u64 = memory_stat_write,
 	},
 #endif
 	{
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 6358464bb416..1c92d58330aa 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -29,6 +29,7 @@ void drain_all_stock(struct mem_cgroup *root_memcg);
 unsigned long memcg_events(struct mem_cgroup *memcg, int event);
 unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 int memory_stat_show(struct seq_file *m, void *v);
+int memory_stat_write(struct cgroup_subsys_state *css, struct cftype *cft, u64 val);

 void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
 struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c34029e92bab..d6a5d872fbcb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4531,6 +4531,17 @@ int memory_stat_show(struct seq_file *m, void *v)
 	return 0;
 }

+int memory_stat_write(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
+{
+	if (val != 1)
+		return -EINVAL;
+
+	if (css)
+		css_rstat_flush(css);
+
+	return 0;
+}
+
 #ifdef CONFIG_NUMA
 static inline unsigned long lruvec_page_state_output(struct lruvec *lruvec,
 						     int item)
@@ -4666,11 +4677,13 @@ static struct cftype memory_files[] = {
 	{
 		.name = "stat",
 		.seq_show = memory_stat_show,
+		.write_u64 = memory_stat_write,
 	},
 #ifdef CONFIG_NUMA
 	{
 		.name = "numa_stat",
 		.seq_show = memory_numa_stat_show,
+		.write_u64 = memory_stat_write,
 	},
 #endif
 	{
--
2.51.2


