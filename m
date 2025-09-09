Return-Path: <linux-kernel+bounces-808647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E2BB502C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C60DD360DB0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EF22DCF6B;
	Tue,  9 Sep 2025 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iB/1DIwD"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677AE274B29
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435630; cv=none; b=C3m+QuQj0rm7p9sf6XkTNBh40tr1tUaDkzysapwsJ+3V4s0C5jMDnhn12/avEJdOIPhJkWgwD/Up+H2Dn+m9OFfj3VqDoehZlroxXZdhICnO3Br/yvMYKBlHu2ymSFlVLVAKG6lFtw4GIFh4GEFHugz6U5wYPZTmW6trga+Qvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435630; c=relaxed/simple;
	bh=WFdnUqV4hxxpkPOjvjzf5tq25E07YEPwR7vxyUNJK0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXlyHWWJIyLGRHmbam8IFYLH6HFbdZNOJb2mtaJRQwBVWcrys5LESe4g/Q/dbL3wJxqML2fM9sSRvXyhsXKM7n8yiFI77U/OEy67xgh7YDvBsVpZYW9IrcAznH/Qa8SarnmZYb5tlG/fRQiegz02nko+hDwYnq/HPbuDawWe2+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iB/1DIwD; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757435616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Al0hvK+RUU6ek3CWk5iv4s8AREKcqh06zDhA8knnZdg=;
	b=iB/1DIwDKMXqbvO+/XekJUPu0XZM/s+VJL8ItzWLB/SH672cI+SuYi7DXX7rd1Iln9/Eri
	swSgq+ooyM+sQY7tNkXsX9thm9rUoziX0johgNM3ZJwkwt8fxvtg0g073w3+ksZ8NtlF2V
	eSQnUpOHakTXrRSWVYdR7alx13aBF7M=
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add stacktrace map lookup_and_delete_elem test case
Date: Wed, 10 Sep 2025 00:32:22 +0800
Message-ID: <20250909163223.864120-2-chen.dylane@linux.dev>
In-Reply-To: <20250909163223.864120-1-chen.dylane@linux.dev>
References: <20250909163223.864120-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

...
test_stacktrace_map:PASS:compare_stack_ips stackmap vs. stack_amap 0 nsec
test_stacktrace_map:PASS:stack_key_map lookup 0 nsec
test_stacktrace_map:PASS:stackmap lookup and detele 0 nsec
test_stacktrace_map:PASS:stackmap lookup deleted stack_id 0 nsec
 #397     stacktrace_map:OK
...

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../selftests/bpf/prog_tests/stacktrace_map.c | 22 ++++++++++++++++++-
 .../selftests/bpf/progs/test_stacktrace_map.c |  8 +++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
index 84a7e405e91..7d38afe5cfc 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
@@ -3,7 +3,7 @@
 
 void test_stacktrace_map(void)
 {
-	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
+	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd, stack_key_map_fd;
 	const char *prog_name = "oncpu";
 	int err, prog_fd, stack_trace_len;
 	const char *file = "./test_stacktrace_map.bpf.o";
@@ -11,6 +11,9 @@ void test_stacktrace_map(void)
 	struct bpf_program *prog;
 	struct bpf_object *obj;
 	struct bpf_link *link;
+	__u32 stack_id;
+	char val_buf[PERF_MAX_STACK_DEPTH *
+		sizeof(struct bpf_stack_build_id)];
 
 	err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
 	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
@@ -41,6 +44,10 @@ void test_stacktrace_map(void)
 	if (CHECK_FAIL(stack_amap_fd < 0))
 		goto disable_pmu;
 
+	stack_key_map_fd = bpf_find_map(__func__, obj, "stack_key_map");
+	if (CHECK_FAIL(stack_key_map_fd < 0))
+		goto disable_pmu;
+
 	/* give some time for bpf program run */
 	sleep(1);
 
@@ -68,6 +75,19 @@ void test_stacktrace_map(void)
 		  "err %d errno %d\n", err, errno))
 		goto disable_pmu;
 
+	err = bpf_map_lookup_elem(stack_key_map_fd, &key, &stack_id);
+	if (CHECK(err, "stack_key_map lookup", "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	err = bpf_map_lookup_and_delete_elem(stackmap_fd, &stack_id, &val_buf);
+	if (CHECK(err, "stackmap lookup and delete",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	err = bpf_map_lookup_elem(stackmap_fd, &stack_id, &val_buf);
+	CHECK((!err || errno != ENOENT), "stackmap lookup deleted stack_id",
+	      "err %d errno %d\n", err, errno);
+
 disable_pmu:
 	bpf_link__destroy(link);
 close_prog:
diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
index 47568007b66..3bede76c151 100644
--- a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
+++ b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
@@ -38,6 +38,13 @@ struct {
 	__type(value, stack_trace_t);
 } stack_amap SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} stack_key_map SEC(".maps");
+
 /* taken from /sys/kernel/tracing/events/sched/sched_switch/format */
 struct sched_switch_args {
 	unsigned long long pad;
@@ -64,6 +71,7 @@ int oncpu(struct sched_switch_args *ctx)
 	/* The size of stackmap and stackid_hmap should be the same */
 	key = bpf_get_stackid(ctx, &stackmap, 0);
 	if ((int)key >= 0) {
+		bpf_map_update_elem(&stack_key_map, &val, &key, 0);
 		bpf_map_update_elem(&stackid_hmap, &key, &val, 0);
 		stack_p = bpf_map_lookup_elem(&stack_amap, &key);
 		if (stack_p)
-- 
2.48.1


