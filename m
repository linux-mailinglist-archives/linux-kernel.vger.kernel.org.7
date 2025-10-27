Return-Path: <linux-kernel+bounces-872774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A49B4C11FE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F0C84FEFAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE0330B36;
	Mon, 27 Oct 2025 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gB4ypSMQ"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2500732E68C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607355; cv=none; b=SiZI16dxz7PkLQoKnwYpFew+HVmTYApn0chu1hh8Z9Z7o771kzwz/hPftNs/jzklJR1qrMAOeA52YD5xNkZQYif58GB69eMWXgNrjvNr4526Auzv7FCiTu7ZNLTbLIBf/i/ENMV5mKO9/gVa6+NofkIW/eFKWjvtEetMPJPs5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607355; c=relaxed/simple;
	bh=rvBnlpSPPGg1WSwfWe+3xqHeiki+o6krSuToPEsBGSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iqm70wfYmUN2WqUpD0JQMC1j2XdEcjWCwJuwLpy1azgAO0qcPyky3H9tzQdyPLeNm2CBQdgsb+Crpm2aNZkUfxxHQ/MuQ50uzA0dtFSubiS9lw2ETsZdHkNdG5/bYsv0h9vWmbt1K+CzelQjVyGu1KNAPWPzVMSIcPGdoiZT1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gB4ypSMQ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o7ByHM6pY3dwFpR4UtrzDg2GMclAcsB3OodRq+P8j4Q=;
	b=gB4ypSMQDUypAYKV6HJ2XH2WemmIfiZB0UwMhQh9wTXb8BbGcyiiR1K9n9hpLOKXNWEkwP
	nhyxWRKMYpek8xquzwYKQrw/M7A8GEGbUtzSP7j/uuts8Rz78K6a8p5MdvlijJYhcsgACc
	Mix3hlPaeGpHRHuDTGBqMGLQcM0R6kg=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 11/23] mm: introduce BPF kfunc to access memory events
Date: Mon, 27 Oct 2025 16:21:54 -0700
Message-ID: <20251027232206.473085-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: JP Kobryn <inwardvessel@gmail.com>

Introduce BPF kfunc to access memory events, e.g.:
MEMCG_LOW, MEMCG_MAX, MEMCG_OOM, MEMCG_OOM_KILL etc.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 mm/bpf_memcontrol.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/bpf_memcontrol.c b/mm/bpf_memcontrol.c
index 387255b8ab88..458ad022b036 100644
--- a/mm/bpf_memcontrol.c
+++ b/mm/bpf_memcontrol.c
@@ -99,6 +99,23 @@ __bpf_kfunc unsigned long bpf_mem_cgroup_usage(struct mem_cgroup *memcg)
 	return page_counter_read(&memcg->memory);
 }
 
+/**
+ * bpf_mem_cgroup_events - Read memory cgroup's page state counter
+ * bpf_mem_cgroup_memory_events - Read memory cgroup's memory event value
+ * @memcg: memory cgroup
+ * @event: memory event id
+ *
+ * Returns current memory event count.
+ */
+__bpf_kfunc unsigned long bpf_mem_cgroup_memory_events(struct mem_cgroup *memcg,
+						enum memcg_memory_event event)
+{
+	if (event >= MEMCG_NR_MEMORY_EVENTS)
+		return (unsigned long)-1;
+
+	return atomic_long_read(&memcg->memory_events[event]);
+}
+
 /**
  * bpf_mem_cgroup_page_state - Read memory cgroup's page state counter
  * @memcg: memory cgroup
@@ -133,6 +150,7 @@ BTF_ID_FLAGS(func, bpf_get_mem_cgroup, KF_ACQUIRE | KF_RET_NULL | KF_RCU)
 BTF_ID_FLAGS(func, bpf_put_mem_cgroup, KF_RELEASE)
 
 BTF_ID_FLAGS(func, bpf_mem_cgroup_vm_events, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_mem_cgroup_memory_events, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_mem_cgroup_usage, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_mem_cgroup_page_state, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_mem_cgroup_flush_stats, KF_TRUSTED_ARGS | KF_SLEEPABLE)
-- 
2.51.0


