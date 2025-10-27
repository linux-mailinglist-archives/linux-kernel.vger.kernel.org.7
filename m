Return-Path: <linux-kernel+bounces-871975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4D7C0F009
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9388D402E32
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3A630BBBF;
	Mon, 27 Oct 2025 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KA7FsxZb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE9E30DD3B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579270; cv=none; b=uFvT2WWLWkGSNv4/F7bN9LjjfMACBZkz1UhbSJYsXU+A03YUNd/pUexEo4Gm2y4PU7TXP5lYtQ4nFum7NKuL8vs1LQAY0vXsh5g00znPb2Bi70gBT4hcdSpYres4CnlPvtkDVPJlBc/EvSwn5Hn667ejwHINI5pSZm9rb8YqEqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579270; c=relaxed/simple;
	bh=2oQSV9XgUGkg6jQHRe1t9svN3YE2EGz+HNiqFyAIsag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUyzp/cqkQVYuhghl9Pf2tOY7QJWdr49s5QtRCxZ18x1gxe7hxpa1W0gU2jRvbdTvju9UzZc1qThBtBb2R++aP3aUV+r4domIB0ZmlOqrLKeuEvbJmlKm1RHH5srWZqbWohLJQB8/Kr7yYRcWi9XdNFlKElF9WBbWBT/wLa3mCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KA7FsxZb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761579268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/iHIiffeDazbY91Xe6Oc1ltPdWNmNo+bcnVBjuCQOQ=;
	b=KA7FsxZbUW7wpMa4Mq2iHl09WkxGhzwYPuo0ncnEeDlhTRnxuZyBSQd2RjhlTBkAjGfR24
	rCQe8WojQsTACvc03yJlI9X9vT2gWEcUpDJGRmxyk27ZshOvcaNDDDlDB+TBoKKE9b+vZQ
	9U7S2NIAFjuLPd+oHwS/q89dqvEa5e8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-JT-FdNv1My2H-oWw3gXg2g-1; Mon,
 27 Oct 2025 11:34:26 -0400
X-MC-Unique: JT-FdNv1My2H-oWw3gXg2g-1
X-Mimecast-MFC-AGG-ID: JT-FdNv1My2H-oWw3gXg2g_1761579266
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1CBE18001D6;
	Mon, 27 Oct 2025 15:34:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B51AF1955F1B;
	Mon, 27 Oct 2025 15:34:22 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v3 4/7] rtla/tests: Test BPF action program
Date: Mon, 27 Oct 2025 16:33:58 +0100
Message-ID: <20251027153401.1039217-5-tglozar@redhat.com>
In-Reply-To: <20251027153401.1039217-1-tglozar@redhat.com>
References: <20251027153401.1039217-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add a test that implements a BPF program writing to a test map, which
is attached to RTLA via --bpf-action to be executed on theshold
overflow.

A combination of --on-threshold shell with bpftool (which is always
present if BPF support is enabled) is used to check whether the BPF
program has executed successfully.

Suggested-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/Makefile                   | 10 ++++++--
 tools/tracing/rtla/tests/bpf/bpf_action_map.c | 25 +++++++++++++++++++
 tools/tracing/rtla/tests/timerlat.t           | 15 +++++++++++
 3 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 tools/tracing/rtla/tests/bpf/bpf_action_map.c

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 5f1529ce3693..aef814b639b7 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -76,12 +76,18 @@ src/timerlat.skel.h: src/timerlat.bpf.o
 
 example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
 	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
+
+tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
+	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
 else
 src/timerlat.skel.h:
 	$(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h
 
 example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
 	$(Q)echo "BPF skeleton support is disabled, skipping example/timerlat_bpf_action.o"
+
+tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
+	$(Q)echo "BPF skeleton support is disabled, skipping tests/bpf/bpf_action_map.o"
 endif
 
 $(RTLA): $(RTLA_IN)
@@ -103,7 +109,7 @@ clean: doc_clean fixdep-clean
 	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
 	$(Q)rm -rf feature
 	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat_bpf_action.o
-check: $(RTLA)
-	RTLA=$(RTLA) prove -o -f tests/
+check: $(RTLA) tests/bpf/bpf_action_map.o
+	RTLA=$(RTLA) BPFTOOL=$(SYSTEM_BPFTOOL) prove -o -f tests/
 examples: example/timerlat_bpf_action.o
 .PHONY: FORCE clean check
diff --git a/tools/tracing/rtla/tests/bpf/bpf_action_map.c b/tools/tracing/rtla/tests/bpf/bpf_action_map.c
new file mode 100644
index 000000000000..1686e0b858e6
--- /dev/null
+++ b/tools/tracing/rtla/tests/bpf/bpf_action_map.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_tracing.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, unsigned int);
+	__type(value, unsigned long long);
+} rtla_test_map SEC(".maps");
+
+struct trace_event_raw_timerlat_sample;
+
+SEC("tp/timerlat_action")
+int action_handler(struct trace_event_raw_timerlat_sample *tp_args)
+{
+	unsigned int key = 0;
+	unsigned long long value = 42;
+
+	bpf_map_update_elem(&rtla_test_map, &key, &value, BPF_ANY);
+
+	return 0;
+}
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index b5d1e7260a9b..89e28cc6df82 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -67,6 +67,21 @@ check "hist with trace output at end" \
 	"timerlat hist -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
 check "top with trace output at end" \
 	"timerlat top -d 1s --on-end trace" 0 "^  Saving trace to timerlat_trace.txt$"
+
+# BPF action program tests
+if [ "$option" -eq 0 ]
+then
+	# Test BPF action program properly in BPF mode
+	[ -z "$BPFTOOL" ] && BPFTOOL=bpftool
+	check "hist with BPF action program (BPF mode)" \
+		"timerlat hist -T 2 --bpf-action tests/bpf/bpf_action_map.o --on-threshold shell,command='$BPFTOOL map dump name rtla_test_map'" \
+		2 '"value": 42'
+else
+	# Test BPF action program failure in non-BPF mode
+	check "hist with BPF action program (non-BPF mode)" \
+		"timerlat hist -T 2 --bpf-action tests/bpf/bpf_action_map.o" \
+		1 "BPF actions are not supported in tracefs-only mode"
+fi
 done
 
 test_end
-- 
2.51.0


