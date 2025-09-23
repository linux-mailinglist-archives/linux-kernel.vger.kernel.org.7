Return-Path: <linux-kernel+bounces-829367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63AFB96E45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8123A2A13
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB9B329F10;
	Tue, 23 Sep 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pOa8lpLr"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1823294FF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646782; cv=none; b=ku7TzjoLKOqBj5dv9PdCOniVxWgOGYVlLj5wdz2jE6hTfz+vSe9EZGq+cS53KuAwXs640Ulq7OZ737U4AXR8d+tbdqSpFiKgNwH4dJD1ecaGMqRkrYVLeAAQjCAOWM4gEjl13TvvgdcpCSJg/FF6QX8TimFgQmQqBP/eYx+ADCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646782; c=relaxed/simple;
	bh=0t1zFi9nttC26jmxoZL/rGyyeP3D5IhH0mSkl5ix+HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRVysmIk+46v/1AYGOOM0ox51tiKVmzU9hpN4NMmWqQGwCtH+2W0a/HiMZy/80co4atP2/XyrQdMgcCHU06bUA7CyP1gF93oUgTDdUuSLgGMHoUZaUwVVCDGh6kJwstKxJjxfUZaqsthv1+9+FR5i1m3KPDATxCr3k0p/NbloS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pOa8lpLr; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758646779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yv/EjLcVmv16kNK9RUEZeVdPoYyfddBCGEjLmOaBiI=;
	b=pOa8lpLrJmDGHdl9WZYLpEOYwVz42/M/WM2i/P45tt60440My084SxoRCTO18vVQvMtGSl
	whzl8kGPNr2Z3aDbzHxqjYOd8kJPMG+CXovdv/w+f9rCKJueRGHmz/pJ+TymBVhlb+s5yW
	3pWmHIBURbRyuQScuv2+oKwnte/YMko=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Add stacktrace map lookup_and_delete_elem test case
Date: Wed, 24 Sep 2025 00:58:49 +0800
Message-ID: <20250923165849.1524622-3-chen.dylane@linux.dev>
In-Reply-To: <20250923165849.1524622-1-chen.dylane@linux.dev>
References: <20250923165849.1524622-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add tests for stacktrace map lookup and delete:
1. use bpf_map_lookup_and_delete_elem to lookup and delete the target
   stack_id,
2. lookup the deleted stack_id again to double check.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/stacktrace_map.c | 11 ++++++++++-
 tools/testing/selftests/bpf/progs/stacktrace_map.c    |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
index 26a2bd25a6f..f06bfef0bc8 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
@@ -7,7 +7,8 @@ void test_stacktrace_map(void)
 	struct stacktrace_map *skel;
 	int stackid_hmap_fd, stackmap_fd, stack_amap_fd;
 	int err, stack_trace_len;
-	__u32 duration = 0;
+	__u32 stack_id, duration = 0;
+	__u64 val[PERF_MAX_STACK_DEPTH];
 
 	skel = stacktrace_map__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
@@ -54,6 +55,14 @@ void test_stacktrace_map(void)
 		  "err %d errno %d\n", err, errno))
 		goto out;
 
+	stack_id = skel->bss->stack_id;
+	err = bpf_map_lookup_and_delete_elem(stackmap_fd, &stack_id,  val);
+	if (!ASSERT_OK(err, "lookup and delete target stack_id"))
+		goto out;
+
+	err = bpf_map_lookup_elem(stackmap_fd, &stack_id, val);
+	if (!ASSERT_EQ(err, -ENOENT, "lookup deleted stack_id"))
+		goto out;
 out:
 	stacktrace_map__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/stacktrace_map.c b/tools/testing/selftests/bpf/progs/stacktrace_map.c
index 9090d561312..7abf702a6ce 100644
--- a/tools/testing/selftests/bpf/progs/stacktrace_map.c
+++ b/tools/testing/selftests/bpf/progs/stacktrace_map.c
@@ -44,6 +44,7 @@ struct sched_switch_args {
 };
 
 int control = 0;
+__u32 stack_id;
 SEC("tracepoint/sched/sched_switch")
 int oncpu(struct sched_switch_args *ctx)
 {
@@ -57,6 +58,7 @@ int oncpu(struct sched_switch_args *ctx)
 	/* The size of stackmap and stackid_hmap should be the same */
 	key = bpf_get_stackid(ctx, &stackmap, 0);
 	if ((int)key >= 0) {
+		stack_id = key;
 		bpf_map_update_elem(&stackid_hmap, &key, &val, 0);
 		stack_p = bpf_map_lookup_elem(&stack_amap, &key);
 		if (stack_p)
-- 
2.48.1


