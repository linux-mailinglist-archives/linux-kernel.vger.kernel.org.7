Return-Path: <linux-kernel+bounces-872757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1BEC11F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 00:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA95B4FBF3B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4B632E140;
	Mon, 27 Oct 2025 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uHT3XV84"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C05C272816
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607069; cv=none; b=tjAAsN4BL0tzMZryhhS6Nr6ZAmrG4ycEbz6qbR73bmUzl0DUoeGd9pudDUhzjdQHQeQ8K7sdHTUsESlNSuYKn+gNFJSsDxaZ8QFO/m6I3AP8bo6BUFcvp6zCfgruFnKDrXGrq0xFnknp80tVTTpovw0ARKeYGNTz2RRwWEBPN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607069; c=relaxed/simple;
	bh=2S8xMD20xJiFE5dD4XoW8mT1iMTyRXxTPjugts2sGC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n21l9/zlx7ESm51qRauI4ecAjuj/+plgcobqeBpvD7GH2vU5/c/YU6e2BR1gbRR2haOjH0lJ5M9sIBmA6GyXUuTPoly5wuORhQKc+5nBEESSyuR8Qf9tb/iCz27hO2zPivOXkxqIRJNG11TGJ3eXAGKTL02tvQH5BguXX1hFK0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uHT3XV84; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761607065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxeBk//0vfxmCDXu0Ua3XftjTjzPqFj9JEVDoYRQlLo=;
	b=uHT3XV84WSMhGH7cmFl+7kM0vWfbc7wXTQ/mEMDZ4Lb6zZ3mGMbFtS8jEAoLnrqSegg2W5
	v9TldZKy722Q4pqdAHezjhpWzEjt4+sVolqhBSb3fjC25cv6vC8BAeia7NVb4Cnr3x8B4b
	lGUOlrGJjO896IyjcThEmkbCJCeJC2U=
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
	Tejun Heo <tj@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 02/23] bpf: initial support for attaching struct ops to cgroups
Date: Mon, 27 Oct 2025 16:17:05 -0700
Message-ID: <20251027231727.472628-3-roman.gushchin@linux.dev>
In-Reply-To: <20251027231727.472628-1-roman.gushchin@linux.dev>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a struct ops is being attached and a bpf link is created,
allow to pass a cgroup fd using bpf attr, so that struct ops
can be attached to a cgroup instead of globally.

Attached struct ops doesn't hold a reference to the cgroup,
only preserves cgroup id.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/bpf.h         |  1 +
 kernel/bpf/bpf_struct_ops.c | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eae907218188..7205b813e25f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1849,6 +1849,7 @@ struct bpf_struct_ops_link {
 	struct bpf_link link;
 	struct bpf_map __rcu *map;
 	wait_queue_head_t wait_hup;
+	u64 cgroup_id;
 };
 
 struct bpf_link_primer {
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 45cc5ee19dc2..58664779a2b6 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -13,6 +13,7 @@
 #include <linux/btf_ids.h>
 #include <linux/rcupdate_wait.h>
 #include <linux/poll.h>
+#include <linux/cgroup.h>
 
 struct bpf_struct_ops_value {
 	struct bpf_struct_ops_common_value common;
@@ -1359,6 +1360,18 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 	}
 	bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS, &bpf_struct_ops_map_lops, NULL,
 		      attr->link_create.attach_type);
+#ifdef CONFIG_CGROUPS
+	if (attr->link_create.cgroup.relative_fd) {
+		struct cgroup *cgrp;
+
+		cgrp = cgroup_get_from_fd(attr->link_create.cgroup.relative_fd);
+		if (IS_ERR(cgrp))
+			return PTR_ERR(cgrp);
+
+		link->cgroup_id = cgroup_id(cgrp);
+		cgroup_put(cgrp);
+	}
+#endif /* CONFIG_CGROUPS */
 
 	err = bpf_link_prime(&link->link, &link_primer);
 	if (err)
-- 
2.51.0


