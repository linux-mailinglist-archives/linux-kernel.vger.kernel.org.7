Return-Path: <linux-kernel+bounces-739962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B0EB0CD95
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1B41AA7D05
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF012459E0;
	Mon, 21 Jul 2025 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ks5HoZOO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC2724397A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139511; cv=none; b=Z2yYSiyT1M+zQ+XEwwltQpyrLYeb+n4Giv6JAp+eIeGiLnBNkemujB7kCEmVKcHFnjb1jeKfrxRZwF2DOz0Wg5aABZnJjfeRSilGhJ9LmweqcQC3w6j0xtPeHFHpXlsN594t/ibhC/AfK/aIZz1LLMjVAM7nigXqnFcjnqlkRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139511; c=relaxed/simple;
	bh=GlqbsapVmIYAHwpWzN9gdSDTX6C1n5xhWigMM3ZXM38=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=smJL7EK04iOd+1R+FwJkCK4cOsUsJIS78KR7hKnZNmIOfwbWLlVd4i9D2nTpzRtUUmInqYTKcQAgJKkM0khSPR64F+uLNPXaPElvHBhU5eTCZbS8+GjfhkJ11+HdXNNtw+48IZmauzEWgZ1hyNTV+OCdLJpzz0X3rISLLtEFjwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ks5HoZOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B174C4CEF7;
	Mon, 21 Jul 2025 23:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753139511;
	bh=GlqbsapVmIYAHwpWzN9gdSDTX6C1n5xhWigMM3ZXM38=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Ks5HoZOOnx6dI/4yHF22jZcuXLe7MzKqu9smNXpWtqbpFwc0Q14pj4dW6kXtE4i/S
	 ThID+u/JAg4NW6EWmuFSiytfNuOTJkAOz0sfQRtEUh16OeAHChZo3pT7l/IGiZmaU2
	 S0tWeG/PwLLAPWU9zJ/Av0tdbI0iDOyivb7ToqyepBK0ULO7Bkuxqc46POOjL+F3sL
	 6LrdwhY3x4lQqlBQVMVQR6U/jPx69y/Ze0a0Ua7MnoblSqcns0ogUF54Ei/Q0WSSFj
	 +b52uTovVqnE5WJMIK6fFfig8/61TUensbY+1P2uyQUguaQ5Anc81Wq5Uk8VkPi+Z2
	 k1ujRY3GwOJ2A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1udzgE-00000009vIO-3Fiw;
	Mon, 21 Jul 2025 19:12:22 -0400
Message-ID: <20250721231222.629918665@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 21 Jul 2025 19:12:07 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Luis Goncalves <lgoncalv@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Chang Yin <cyin@redhat.com>,
 Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 3/9] rtla/timerlat_bpf: Allow resuming tracing
References: <20250721231204.100737734@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

Currently, rtla-timerlat BPF program uses a global variable stored in a
.bss section to store whether tracing has been stopped.

Move the information to a separate map, so that it is easily writable
from userspace, and add a function that clears the value, resuming
tracing after it has been stopped.

Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Chang Yin <cyin@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>
Cc: Crystal Wood <crwood@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/20250626123405.1496931-4-tglozar@redhat.com
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/timerlat.bpf.c | 13 +++++++++----
 tools/tracing/rtla/src/timerlat_bpf.c | 13 +++++++++++++
 tools/tracing/rtla/src/timerlat_bpf.h |  3 +++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat.bpf.c b/tools/tracing/rtla/src/timerlat.bpf.c
index 96196d46e170..084cd10c21fc 100644
--- a/tools/tracing/rtla/src/timerlat.bpf.c
+++ b/tools/tracing/rtla/src/timerlat.bpf.c
@@ -28,6 +28,13 @@ struct {
 	__type(value, unsigned long long);
 } summary_irq SEC(".maps"), summary_thread SEC(".maps"), summary_user SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, unsigned int);
+	__type(value, unsigned long long);
+} stop_tracing SEC(".maps");
+
 struct {
 	__uint(type, BPF_MAP_TYPE_RINGBUF);
 	__uint(max_entries, 1);
@@ -41,8 +48,6 @@ const volatile int irq_threshold;
 const volatile int thread_threshold;
 const volatile bool aa_only;
 
-int stop_tracing;
-
 nosubprog unsigned long long map_get(void *map,
 				     unsigned int key)
 {
@@ -109,7 +114,7 @@ nosubprog void set_stop_tracing(void)
 	int value = 0;
 
 	/* Suppress further sample processing */
-	stop_tracing = 1;
+	map_set(&stop_tracing, 0, 1);
 
 	/* Signal to userspace */
 	bpf_ringbuf_output(&signal_stop_tracing, &value, sizeof(value), 0);
@@ -121,7 +126,7 @@ int handle_timerlat_sample(struct trace_event_raw_timerlat_sample *tp_args)
 	unsigned long long latency, latency_us;
 	int bucket;
 
-	if (stop_tracing)
+	if (map_get(&stop_tracing, 0))
 		return 0;
 
 	latency = tp_args->timer_latency / output_divisor;
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index 0bc44ce5d69b..1666215dd687 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -106,6 +106,19 @@ int timerlat_bpf_wait(int timeout)
 	return retval;
 }
 
+/*
+ * timerlat_bpf_restart_tracing - restart stopped tracing
+ */
+int timerlat_bpf_restart_tracing(void)
+{
+	unsigned int key = 0;
+	unsigned long long value = 0;
+
+	return bpf_map__update_elem(bpf->maps.stop_tracing,
+				    &key, sizeof(key),
+				    &value, sizeof(value), BPF_ANY);
+}
+
 static int get_value(struct bpf_map *map_irq,
 		     struct bpf_map *map_thread,
 		     struct bpf_map *map_user,
diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
index f1b54dbddb0e..118487436d30 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.h
+++ b/tools/tracing/rtla/src/timerlat_bpf.h
@@ -18,6 +18,7 @@ int timerlat_bpf_attach(void);
 void timerlat_bpf_detach(void);
 void timerlat_bpf_destroy(void);
 int timerlat_bpf_wait(int timeout);
+int timerlat_bpf_restart_tracing(void);
 int timerlat_bpf_get_hist_value(int key,
 				long long *value_irq,
 				long long *value_thread,
@@ -28,6 +29,7 @@ int timerlat_bpf_get_summary_value(enum summary_field key,
 				   long long *value_thread,
 				   long long *value_user,
 				   int cpus);
+
 static inline int have_libbpf_support(void) { return 1; }
 #else
 static inline int timerlat_bpf_init(struct timerlat_params *params)
@@ -38,6 +40,7 @@ static inline int timerlat_bpf_attach(void) { return -1; }
 static inline void timerlat_bpf_detach(void) { };
 static inline void timerlat_bpf_destroy(void) { };
 static inline int timerlat_bpf_wait(int timeout) { return -1; }
+static inline int timerlat_bpf_restart_tracing(void) { return -1; };
 static inline int timerlat_bpf_get_hist_value(int key,
 					      long long *value_irq,
 					      long long *value_thread,
-- 
2.47.2



