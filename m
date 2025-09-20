Return-Path: <linux-kernel+bounces-825448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F16A9B8BD27
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71273B1928
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363231D63FB;
	Sat, 20 Sep 2025 01:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWOaojby"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2255F7082D
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758333335; cv=none; b=gFaczk8LW356W7HEc2LOrzrDNRQeURAHGzVURcC+cpKd8+aeuB680et1fp1mfPjWhO6mpGtclh6zV4TFoqhBm8mywj8jJ2WcuyE1ss/l5c+sSEAgaRSm5413g04Qk12zsVvGzOvUj84xSW4HtLDt5kpWQiSwF3bVs2VMPTkdjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758333335; c=relaxed/simple;
	bh=3Wpmd2pdKwpAIQ8Fo6W0c3bK8qq11E3CF5Ra/QSvfWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bFkIIbk8RxUIjE3vZvIud08kXYncFBeTVMndYXZ+PMpC95YGQZoY7ID1wfyUu0NBGUjx50qdMFpzg+Ps/876lI5daBXXY5Bev/dAu3MmpJDoWjedVvCXtNcgNkAbUAe0AV+pD62F6x24mkIz2NseUAQsifYiH13YuPkzKE8cVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWOaojby; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-26a0a694ea8so12598915ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 18:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758333333; x=1758938133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fjulk5rkVmPsHCmF0s197yqYrmBn9b23fz8QlbmEMHI=;
        b=bWOaojbyAIwHnzGDs1wSzj9F+xN5d2xY8UZLBuFHBMp+VeWsAxiCjueR9sjS7YsARO
         +jIqZO2cz2/qSnzzI6f3waw02rKWPjnhXsh3sODgBWgM+NYONBn5PkzRbDbRt2dJD/ST
         HDxDtS0qGDmw5c07cjBVTTn+wqVkQQRtRoNkemI4pAiZjJdh14sW7lqvuKXbjNjMGSZQ
         XoqFOD67+Zk5H5scTRMcMrTXhjU1eF0/p6FdATgpF8z5uREByQxDmRnwpIkQl7odTcND
         YINFu4EjsJEwFtIArFsAECAA+y5ncpnPFAr2pfWhye4DgUKNcuqvcW0HMd/9LqyJ/qBM
         BcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758333333; x=1758938133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjulk5rkVmPsHCmF0s197yqYrmBn9b23fz8QlbmEMHI=;
        b=SkgvOqu62CZgs4Mb87MNcqyYWOvgXKDHxTs9dCxH5FPpbo8S0jdLGSRLWlpjkE4brZ
         IgyULwU2nmFk8xakEYdQHhSCp4P1TxWdJKtK/qU19LX0D7KLPjJ6ajmRLSZCNyM5ae1J
         KbltHt1FdO512bE6JT92zwWnqZVccN2MsqRfkNP2H8hDv0hQZvxdMicXMChaXG6JZ6Tq
         4VntdeQNYkpAfWcaH3i7qVolwYNAOyGoqQ0FHkGl2ilI71fGclwV8Mr+2D3zwDw11Afc
         EgCald8oaqNHGmgGGE/+LeX6j6Hd4P03RDM/1rq39ttrzvmcAKaGQMs4Vbk5V+AW0Yvv
         3DaA==
X-Gm-Message-State: AOJu0YyyS2TjMgInNbXJ8ksz2WD7rkbOzMlCaw5yqMUUvmS6YWd2HlUd
	nQtvNocwJ4Fr28cpSzIJN3buKzvGB/LTNitr3EtfjOb1ATULNri7tzBj
X-Gm-Gg: ASbGncurS4DlkUqNJYy/A8/dx1Kvmaarqc9M6n9NnBvZ+JgU6mprqK0tRNrnEMfk8pi
	kqJ0MBTQaZPWbzeOvhWkI8u8t4JXZ9YQo5NC/DsqE5nK80afXGjeh3GCWU2Obg/1z2oxm9bx0F2
	xtTzAOsAbwFprjkzDNbb3yd3O/3Fr7CGUYOeDfvwfxaDYq8D1Qrfioqv2svc+R4n5j46ikfSW9O
	ei1/IuoHOxNDJU2WL5VZVcpdh5ABcxdnfFvDCxyixNiqDcaa7IMqXSr2VC7D5gQiBBGEdKDEwUq
	ZXJ4JXBDrY47ME+71gaGvk+A/iTrHmXfCeOX0Cr3Jqw/mQDqOcp0svEvcEIGdHAEBBU3Xuz9cS0
	hRVTFLdginRyS3HQN7TeeairMA77Czq+alByTyf8bbKL9dWMTwA==
X-Google-Smtp-Source: AGHT+IEqKGJPoW86tnt6KcghAvRYsQaWkRv8qKjw6X1da8Q99Cv4KwISiNa+ACkgZO5GF1seBRX8tQ==
X-Received: by 2002:a17:903:2284:b0:269:9adf:839 with SMTP id d9443c01a7336-269ba427cb8mr69731025ad.19.1758333333376;
        Fri, 19 Sep 2025 18:55:33 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33047220cfesm4596925a91.2.2025.09.19.18.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 18:55:32 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	mkoutny@suse.com,
	yosryahmed@google.com,
	hannes@cmpxchg.org,
	tj@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH] memcg: introduce kfuncs for fetching memcg stats
Date: Fri, 19 Sep 2025 18:55:26 -0700
Message-ID: <20250920015526.246554-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel has to perform a significant amount of the work when a user mode
program reads the memory.stat file of a cgroup. Aside from flushing stats,
there is overhead in the string formatting that is done for each stat. Some
perf data is shown below from a program that reads memory.stat 1M times:

26.75%  a.out [kernel.kallsyms] [k] vsnprintf
19.88%  a.out [kernel.kallsyms] [k] format_decode
12.11%  a.out [kernel.kallsyms] [k] number
11.72%  a.out [kernel.kallsyms] [k] string
 8.46%  a.out [kernel.kallsyms] [k] strlen
 4.22%  a.out [kernel.kallsyms] [k] seq_buf_printf
 2.79%  a.out [kernel.kallsyms] [k] memory_stat_format
 1.49%  a.out [kernel.kallsyms] [k] put_dec_trunc8
 1.45%  a.out [kernel.kallsyms] [k] widen_string
 1.01%  a.out [kernel.kallsyms] [k] memcpy_orig

As an alternative to reading memory.stat, introduce new kfuncs to allow
fetching specific memcg stats from within bpf iter/cgroup-based programs.
Reading stats in this manner avoids the overhead of the string formatting
shown above.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 mm/memcontrol.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..aa22dc6f47ee 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -870,6 +870,73 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 }
 #endif
 
+static inline struct mem_cgroup *mem_cgroup_from_cgroup(struct cgroup *cgrp)
+{
+	return cgrp ? mem_cgroup_from_css(cgrp->subsys[memory_cgrp_id]) : NULL;
+}
+
+__bpf_kfunc static void cgroup_flush_memcg_stats(struct cgroup *cgrp)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_cgroup(cgrp);
+
+	if (!memcg)
+		return;
+
+	mem_cgroup_flush_stats(memcg);
+}
+
+__bpf_kfunc static unsigned long node_stat_fetch(struct cgroup *cgrp,
+		enum node_stat_item item)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_cgroup(cgrp);
+
+	if (!memcg)
+		return 0;
+
+	return memcg_page_state_output(memcg, item);
+}
+
+__bpf_kfunc static unsigned long memcg_stat_fetch(struct cgroup *cgrp,
+		enum memcg_stat_item item)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_cgroup(cgrp);
+
+	if (!memcg)
+		return 0;
+
+	return memcg_page_state_output(memcg, item);
+}
+
+__bpf_kfunc static unsigned long vm_event_fetch(struct cgroup *cgrp,
+		enum vm_event_item item)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_cgroup(cgrp);
+
+	if (!memcg)
+		return 0;
+
+	return memcg_events(memcg, item);
+}
+
+BTF_KFUNCS_START(bpf_memcontrol_kfunc_ids)
+BTF_ID_FLAGS(func, cgroup_flush_memcg_stats)
+BTF_ID_FLAGS(func, node_stat_fetch)
+BTF_ID_FLAGS(func, memcg_stat_fetch)
+BTF_ID_FLAGS(func, vm_event_fetch)
+BTF_KFUNCS_END(bpf_memcontrol_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_memcontrol_kfunc_ids,
+};
+
+static int __init bpf_memcontrol_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					 &bpf_memcontrol_kfunc_set);
+}
+late_initcall(bpf_memcontrol_kfunc_init);
+
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
 {
 	/*
-- 
2.47.3


