Return-Path: <linux-kernel+bounces-838407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C93FBAF1B8
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 06:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85C01C3E62
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 04:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BE82D7DE6;
	Wed,  1 Oct 2025 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAkxomep"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02223C8C5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759294512; cv=none; b=igews0F7+BaJ00Q3iTu7Z0OHShVkMYfXn4G/zz/hKy7YLMdcaR0fu9L2y88wYEHwYAxi8RhOKQYm0kgxW8ii2Nf/O8gxYIrDJKUD7XddYP18PbPU5kCZufgInTzZiT9chwi51Tb99kMbZ/7Oc0hXvHLZgBJumPas5iM9hwJ5iIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759294512; c=relaxed/simple;
	bh=c8pxOvtyq/c0UIli9jPRzRJjB7VX9/+BBDpMmu+LVPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AevydxjtRmKE7UMX6bhO6o+i6B9ZRGJJd1JzqGDY3TVnTiOZK3KaHF4sJhQRQXe1jnxQQkDItJoJiJDwb9pttrUL4RTm4oOim6oFWkMI+K3/Ytsy9my7BtEQhj2pLK8L12XQr+Z+lkgIXmQ/qWPDjDmlqrBsGTLN/X6qr6lZfg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAkxomep; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78af9ebe337so57126b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 21:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759294510; x=1759899310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ri7WDt45zmQrzY579qfISU4VEl3xx5nuQVZaGHjeynE=;
        b=LAkxomepxKSJ+AD4srYlZjKraEM1bp1Cm9TqdymgVuSRd+kYI09PwBU5JNCNnc4qt4
         E3zpPhfM/Wf+UoCaqRB7ThbUDX+CG6NdajZmtnMeDye0MLkt38cHrNn9djkWgyw0uCUX
         25R9Q49yd/6BLk3y5/tKDhb8VRLIMAuMq5bCtxfdPHzQQ7GcnTyEawRiqhF51kX0zQYR
         fb8AJ3I1C2UQQu+kZCNDFQPI6XY5XQs/STiAXK4Y6NigFcUHqoZifj5b/z6dK/LuJmH6
         2y6tLKXPKDOCUrBNR5pwaQdKDkuFp1WBTUoLRn+SENt1hjrU5nyh1Nu5oRmp7i0j/Gby
         eb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759294510; x=1759899310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ri7WDt45zmQrzY579qfISU4VEl3xx5nuQVZaGHjeynE=;
        b=l/AfJpzZie1cMiB4Cy+Y1USRqo2M/QOyjVKRysMffERqaxfLfnZeD3edgmWqXPhTOw
         4JypWdHGl6E26MWpsnmrEXrzUD+4znINex5D4SdFYCfgXkdGHvYi1BSnjBhC8MXCUAU1
         5tWhOhqWGgibj0KfYz+okYOgMIn9jDR8JGDmtzxWlKkD8uPLm3TfQCi3ygD7A9kP0+Sg
         RYsKsN+SA4pYehRgBijRl/tTzcwpWwrM80jFw2wNbZe80Qn7lp9bUoW20efkmnbb9I/B
         I5ajJcrtJg5tXZaJD5AIcvhg3KVjE/Cnh3cytsbhJBSy7o7uuiAeFtG4JPxMmToz4fW6
         GPfQ==
X-Gm-Message-State: AOJu0YyMiBLNFq0qM9U3q3Q+x/2YPYbQf/Gsk/wfl2lIwElui+drvTjo
	jQSU8pVFa1qQb+XhnetLtq/QYwrfT4vGe9leQmkA30mwnGrgiXYo1orA
X-Gm-Gg: ASbGnctjTkMdmMDjkQevWecBeFN2JONy+Vb5NKI1hdtVGl5/eeEb3UhqhZiW9MsvjYp
	SyxkOaEWmlJI041nQSWolV7cAnK29uMmM9D+m6jEzMHtvauMUfW/uaIexGT1avoyrRNM/6LoL/4
	WVZPDWhkP3QuDLhtGsd/hntQkLaVzVgXYMiOrOMrfgM12rdn3FLLbj48hkaFwzvx8LCDMIQ0HUV
	xcfKsbYTCioLdcbw75nUD6Ciiq21Uve3jAWOyD7SAmPWt3dz4bsfac//MDGWmRPb/JLZCReFokh
	p04Rkum0M++PT8ZYr9yYGl5JA/fv73QwfhgGqKHdWMFuHRS0Is8XGhQqV1BGzjEqffwrtE4JsrR
	CTgkIlLSZA3asAwGNStimVdCKZfhiq87CFh3M4Lx2YBgmIiry3GBeNEXMzwltB3sRv5AUbhog2A
	==
X-Google-Smtp-Source: AGHT+IENg8JFMQAvrh08OsAp21v3nqidKkwtj7VlhXv2erEQYAsK9Mahy8m3QZfWW4FUYn06+OTIZQ==
X-Received: by 2002:a05:6a21:99a6:b0:2bd:2798:7ae7 with SMTP id adf61e73a8af0-321e3edc8cbmr3372698637.31.1759294510242;
        Tue, 30 Sep 2025 21:55:10 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.lan ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5f2c1b7608sm1011996a12.5.2025.09.30.21.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 21:55:09 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	mkoutny@suse.com,
	yosryahmed@google.com,
	hannes@cmpxchg.org,
	tj@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] memcg: introduce kfuncs for fetching memcg stats
Date: Tue, 30 Sep 2025 21:54:56 -0700
Message-ID: <20251001045456.313750-1-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reading cgroup memory.stat files there is significant work the kernel
has to perform in string formatting the numeric data to text. Once a user
mode program gets this text further work has to be done, converting the
text back to numeric data. This work can be expensive for programs that
periodically sample this data over a large enough fleet.

As an alternative to reading memory.stat, introduce new kfuncs to allow
fetching specific memcg stats from within bpf cgroup iterator programs.
This approach eliminates the conversion work done by both the kernel and
user mode programs. Previously a program could open memory.stat and
repeatedly read from the associated file descriptor (while seeking back to
zero before each subsequent read). That action can now be replaced by
setting up a link to the bpf program once in advance and then reusing it to
invoke the cgroup iterator program each time a read is desired. An example
program can be found here [0].

There is a significant perf benefit when using this approach. In terms of
elapsed time, the kfuncs allow a bpf cgroup iterator program to outperform
the traditional file reading method, saving almost 80% of the time spent in
kernel.

control: elapsed time
real    0m14.421s
user    0m0.183s
sys     0m14.184s

experiment: elapsed time
real    0m3.250s
user    0m0.225s
sys     0m2.916s

control: perf data
22.24% a.out [kernel.kallsyms] [k] vsnprintf
17.35% a.out [kernel.kallsyms] [k] format_decode
12.60% a.out [kernel.kallsyms] [k] string
12.12% a.out [kernel.kallsyms] [k] number
 8.06% a.out [kernel.kallsyms] [k] strlen
 5.21% a.out [kernel.kallsyms] [k] memcpy_orig
 4.26% a.out [kernel.kallsyms] [k] seq_buf_printf
 4.19% a.out [kernel.kallsyms] [k] memory_stat_format
 2.53% a.out [kernel.kallsyms] [k] widen_string
 1.62% a.out [kernel.kallsyms] [k] put_dec_trunc8
 0.99% a.out [kernel.kallsyms] [k] put_dec_full8
 0.72% a.out [kernel.kallsyms] [k] put_dec
 0.70% a.out [kernel.kallsyms] [k] memcpy
 0.60% a.out [kernel.kallsyms] [k] mutex_lock
 0.59% a.out [kernel.kallsyms] [k] entry_SYSCALL_64

experiment: perf data
8.17% memcgstat bpf_prog_c6d320d8e5cfb560_query [k] bpf_prog_c6d320d8e5cfb560_query
8.03% memcgstat [kernel.kallsyms] [k] memcg_node_stat_fetch
5.21% memcgstat [kernel.kallsyms] [k] __memcg_slab_post_alloc_hook
3.87% memcgstat [kernel.kallsyms] [k] _raw_spin_lock
3.01% memcgstat [kernel.kallsyms] [k] entry_SYSRETQ_unsafe_stack
2.49% memcgstat [kernel.kallsyms] [k] memcg_vm_event_fetch
2.47% memcgstat [kernel.kallsyms] [k] __memcg_slab_free_hook
2.34% memcgstat [kernel.kallsyms] [k] kmem_cache_free
2.32% memcgstat [kernel.kallsyms] [k] entry_SYSCALL_64
1.92% memcgstat [kernel.kallsyms] [k] mutex_lock

The overhead of string formatting and text conversion on the control side
is eliminated on the experimental side since the values are read directly
through shared memory with the bpf program. The kfunc/bpf approach also
provides flexibility in how this numeric data could be delivered to a user
mode program. It is possible to use a struct for example, with select
memory stat fields instead of an array. This opens up opportunities for
custom serialization as well since it is totally up to the bpf programmer
on how to lay out the data.

The patch also includes a kfunc for flushing stats. This is not required
for fetching stats, since the kernel periodically flushes memcg stats every
2s. It is up to the programmer if they want the very latest stats or not.

[0] https://gist.github.com/inwardvessel/416d629d6930e22954edb094b4e23347
    https://gist.github.com/inwardvessel/28e0a9c8bf51ba07fa8516bceeb25669
    https://gist.github.com/inwardvessel/b05e1b9ea0f766f4ad78dad178c49703

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 mm/memcontrol.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..aa8cbf883d71 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -870,6 +870,73 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 }
 #endif
 
+static inline struct mem_cgroup *memcg_from_cgroup(struct cgroup *cgrp)
+{
+	return cgrp ? mem_cgroup_from_css(cgrp->subsys[memory_cgrp_id]) : NULL;
+}
+
+__bpf_kfunc static void memcg_flush_stats(struct cgroup *cgrp)
+{
+	struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
+
+	if (!memcg)
+		return;
+
+	mem_cgroup_flush_stats(memcg);
+}
+
+__bpf_kfunc static unsigned long memcg_node_stat_fetch(struct cgroup *cgrp,
+		enum node_stat_item item)
+{
+	struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
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
+	struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
+
+	if (!memcg)
+		return 0;
+
+	return memcg_page_state_output(memcg, item);
+}
+
+__bpf_kfunc static unsigned long memcg_vm_event_fetch(struct cgroup *cgrp,
+		enum vm_event_item item)
+{
+	struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
+
+	if (!memcg)
+		return 0;
+
+	return memcg_events(memcg, item);
+}
+
+BTF_KFUNCS_START(bpf_memcontrol_kfunc_ids)
+BTF_ID_FLAGS(func, memcg_flush_stats)
+BTF_ID_FLAGS(func, memcg_node_stat_fetch)
+BTF_ID_FLAGS(func, memcg_stat_fetch)
+BTF_ID_FLAGS(func, memcg_vm_event_fetch)
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


