Return-Path: <linux-kernel+bounces-871974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F4FC0EFBB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EBBF34E5FB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451C530CD8E;
	Mon, 27 Oct 2025 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9ROXPmE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE90830C637
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579267; cv=none; b=H0BZ491tjyi/a4T4waCh2JVqU304+L4v1G0iu87lN4nsJ5gXy3AI64YaH2KLpKfB0Snw/4/AG5Cz2VJrcWvoZEvAs0JIe1Yr6K1bC5YZt6r9mjBn+Hh0oWjLVQ8RxiSxJJ5oSGwmq1jZeSa8H08v4wr12f1yZKOert19VTBpsng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579267; c=relaxed/simple;
	bh=H4YFI6jMBxuTfma66yvWdpil+xS6qySRpqzaahtkstw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gs+4BMVRzL0ME4IecFl4/EahdhyWQ99O64qNGLCWOE/c3x0/hOvuufzzBvcD2ayA83iYl2g71fkN2i3USDzmzO/oTHQXMmbaFmGiFZP/8SHvtp2CiQeExDqnJykYLC0a5hWoNd+0+klXKu9oqQHu0QJwJEJDFwDtd6Xa5Yt5//g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9ROXPmE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761579265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dkdOfBoeQUK++FxdaoJ0VFHifIEmAE6q/udIJ/iSXRc=;
	b=f9ROXPmEfMaRzNTrp7DwA5VK8VLUv2174d0hyEJddYqWWM5bbbHF2THBj+mJEcvIiseDnH
	WCPuTDfDg7XxHydRrGztoFqXox6OC0VIGjfclAL8gWuwNr/lnyUCENhguImLRwkORqgxtp
	jZ/KIadvNQ7NNplA/mbRVh7FJ6kDc5g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-oP4RHh2zPC6ysJKkAhmKiw-1; Mon,
 27 Oct 2025 11:34:23 -0400
X-MC-Unique: oP4RHh2zPC6ysJKkAhmKiw-1
X-Mimecast-MFC-AGG-ID: oP4RHh2zPC6ysJKkAhmKiw_1761579262
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45ABB19560B2;
	Mon, 27 Oct 2025 15:34:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 130AA1955F1B;
	Mon, 27 Oct 2025 15:34:18 +0000 (UTC)
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
Subject: [PATCH v3 3/7] rtla/timerlat: Add example for BPF action program
Date: Mon, 27 Oct 2025 16:33:57 +0100
Message-ID: <20251027153401.1039217-4-tglozar@redhat.com>
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

Add an example BPF action program that prints the measured latency to
the tracefs buffer via bpf_printk().

A new Makefile target, "examples", is added to build the example. In
addition, "sample/" subfolder is renamed to "example".

If BPF skeleton support is unavailable or disabled, a warning will be
displayed when building the BPF action program example.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/Makefile                      |  9 ++++++++-
 tools/tracing/rtla/example/timerlat_bpf_action.c | 16 ++++++++++++++++
 .../rtla/{sample => example}/timerlat_load.py    |  0
 3 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 tools/tracing/rtla/example/timerlat_bpf_action.c
 rename tools/tracing/rtla/{sample => example}/timerlat_load.py (100%)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 746ccf2f5808..5f1529ce3693 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -73,9 +73,15 @@ src/timerlat.bpf.o: src/timerlat.bpf.c
 
 src/timerlat.skel.h: src/timerlat.bpf.o
 	$(QUIET_GENSKEL)$(SYSTEM_BPFTOOL) gen skeleton $< > $@
+
+example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
+	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o $@
 else
 src/timerlat.skel.h:
 	$(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h
+
+example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
+	$(Q)echo "BPF skeleton support is disabled, skipping example/timerlat_bpf_action.o"
 endif
 
 $(RTLA): $(RTLA_IN)
@@ -96,7 +102,8 @@ clean: doc_clean fixdep-clean
 	$(Q)find . -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
 	$(Q)rm -rf feature
-	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h
+	$(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat_bpf_action.o
 check: $(RTLA)
 	RTLA=$(RTLA) prove -o -f tests/
+examples: example/timerlat_bpf_action.o
 .PHONY: FORCE clean check
diff --git a/tools/tracing/rtla/example/timerlat_bpf_action.c b/tools/tracing/rtla/example/timerlat_bpf_action.c
new file mode 100644
index 000000000000..ac1be049a848
--- /dev/null
+++ b/tools/tracing/rtla/example/timerlat_bpf_action.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_tracing.h>
+
+char LICENSE[] SEC("license") = "GPL";
+
+struct trace_event_raw_timerlat_sample {
+	unsigned long long timer_latency;
+} __attribute__((preserve_access_index));
+
+SEC("tp/timerlat_action")
+int action_handler(struct trace_event_raw_timerlat_sample *tp_args)
+{
+	bpf_printk("Latency: %lld\n", tp_args->timer_latency);
+	return 0;
+}
diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/rtla/example/timerlat_load.py
similarity index 100%
rename from tools/tracing/rtla/sample/timerlat_load.py
rename to tools/tracing/rtla/example/timerlat_load.py
-- 
2.51.0


