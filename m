Return-Path: <linux-kernel+bounces-871872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE8CC0EAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB0D406DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6AE2C08B2;
	Mon, 27 Oct 2025 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVBlDJAw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79757296BB6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576531; cv=none; b=jjZiClN4FNDu+h5ceaT2JUWlxOYVs5cDEau0n62llFKM+Fo8yMp8t5nT3j9Js2UTbXwC5mOO5+5Qi1wNEwkvCGFp/yqGWStlkh5nGRU7HvkMN4gb0UPz6ESMBAAt18XJyh31Ta391ynMNVem+BiMYJnezAIBr6BcCFUTMFU22Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576531; c=relaxed/simple;
	bh=rGu5A3OU4ZSpORG0UAOqi+ojq3qcrJOfyOMyESOti20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yp/q8fPUZuzDd6O/YjOJ1c35ufXE5vA3beYZRCHwPrdkEcHS746emyLuhMLc85krqJOCUxgf5WIpdK6E/svvcUP/i+GJ9l8ilp+DWaWMowWMnG7p01rhFCy2MA1woHPrBWKnIHKFDKLru35X+kehkChAkR1GNbdpA7+uT5XKa7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BVBlDJAw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761576527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mb0dB1veQuyN7Er4i7PkFCiU6cwrLRWf+Zv8v4WzqA0=;
	b=BVBlDJAwP8lNAvVzPywp0uJXnUx4+4uc1GpU1Wer/oNbddm2MQZdkCDE0qvY/hWDewn2TI
	MFLLbLYXQqBN00w+v19b3BAyLPFygmlgdPuvEjhSSaJVO1heXfZuSIT2671m6jqOnuBpMr
	j01qeER7egUOWtOWyXMOYgEu+6HbwSo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-1tFd7PKDNhCpee1abHuv5Q-1; Mon,
 27 Oct 2025 10:48:44 -0400
X-MC-Unique: 1tFd7PKDNhCpee1abHuv5Q-1
X-Mimecast-MFC-AGG-ID: 1tFd7PKDNhCpee1abHuv5Q_1761576523
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F188A18089A5;
	Mon, 27 Oct 2025 14:48:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0BD3E19540EB;
	Mon, 27 Oct 2025 14:48:39 +0000 (UTC)
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
Subject: [PATCH v2 1/7] rtla/timerlat: Support tail call from BPF program
Date: Mon, 27 Oct 2025 15:48:13 +0100
Message-ID: <20251027144819.1034041-2-tglozar@redhat.com>
In-Reply-To: <20251027144819.1034041-1-tglozar@redhat.com>
References: <20251027144819.1034041-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add a map to the rtla-timerlat BPF program that holds a file descriptor
of another BPF program, to be executed on threshold overflow.

timerlat_bpf_set_action() is added as an interface to set the program.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat.bpf.c | 23 ++++++++++++++++++++---
 tools/tracing/rtla/src/timerlat_bpf.c | 13 +++++++++++++
 tools/tracing/rtla/src/timerlat_bpf.h |  1 +
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat.bpf.c b/tools/tracing/rtla/src/timerlat.bpf.c
index 084cd10c21fc..19ccd9abf8d4 100644
--- a/tools/tracing/rtla/src/timerlat.bpf.c
+++ b/tools/tracing/rtla/src/timerlat.bpf.c
@@ -40,6 +40,17 @@ struct {
 	__uint(max_entries, 1);
 } signal_stop_tracing SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(key_size, sizeof(unsigned int));
+	__uint(max_entries, 1);
+	__array(values, unsigned int (void *));
+} bpf_action SEC(".maps") = {
+	.values = {
+		[0] = 0
+	},
+};
+
 /* Params to be set by rtla */
 const volatile int bucket_size = 1;
 const volatile int output_divisor = 1000;
@@ -109,7 +120,7 @@ nosubprog void update_summary(void *map,
 	map_set(map, SUMMARY_SUM, map_get(map, SUMMARY_SUM) + latency);
 }
 
-nosubprog void set_stop_tracing(void)
+nosubprog void set_stop_tracing(struct trace_event_raw_timerlat_sample *tp_args)
 {
 	int value = 0;
 
@@ -118,6 +129,12 @@ nosubprog void set_stop_tracing(void)
 
 	/* Signal to userspace */
 	bpf_ringbuf_output(&signal_stop_tracing, &value, sizeof(value), 0);
+
+	/*
+	 * Call into BPF action program, if attached.
+	 * Otherwise, just silently fail.
+	 */
+	bpf_tail_call(tp_args, &bpf_action, 0);
 }
 
 SEC("tp/osnoise/timerlat_sample")
@@ -138,13 +155,13 @@ int handle_timerlat_sample(struct trace_event_raw_timerlat_sample *tp_args)
 		update_summary(&summary_irq, latency, bucket);
 
 		if (irq_threshold != 0 && latency_us >= irq_threshold)
-			set_stop_tracing();
+			set_stop_tracing(tp_args);
 	} else if (tp_args->context == 1) {
 		update_main_hist(&hist_thread, bucket);
 		update_summary(&summary_thread, latency, bucket);
 
 		if (thread_threshold != 0 && latency_us >= thread_threshold)
-			set_stop_tracing();
+			set_stop_tracing(tp_args);
 	} else {
 		update_main_hist(&hist_user, bucket);
 		update_summary(&summary_user, latency, bucket);
diff --git a/tools/tracing/rtla/src/timerlat_bpf.c b/tools/tracing/rtla/src/timerlat_bpf.c
index e97d16646bcd..1d619e502c65 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.c
+++ b/tools/tracing/rtla/src/timerlat_bpf.c
@@ -59,6 +59,19 @@ int timerlat_bpf_init(struct timerlat_params *params)
 	return 0;
 }
 
+/*
+ * timerlat_bpf_set_action - set action on threshold executed on BPF side
+ */
+static int timerlat_bpf_set_action(struct bpf_program *prog)
+{
+	unsigned int key = 0, value = bpf_program__fd(prog);
+
+	return bpf_map__update_elem(bpf->maps.bpf_action,
+				    &key, sizeof(key),
+				    &value, sizeof(value),
+				    BPF_ANY);
+}
+
 /*
  * timerlat_bpf_attach - attach BPF program to collect timerlat data
  */
diff --git a/tools/tracing/rtla/src/timerlat_bpf.h b/tools/tracing/rtla/src/timerlat_bpf.h
index 118487436d30..b5009092c7a3 100644
--- a/tools/tracing/rtla/src/timerlat_bpf.h
+++ b/tools/tracing/rtla/src/timerlat_bpf.h
@@ -12,6 +12,7 @@ enum summary_field {
 };
 
 #ifndef __bpf__
+#include <bpf/libbpf.h>
 #ifdef HAVE_BPF_SKEL
 int timerlat_bpf_init(struct timerlat_params *params);
 int timerlat_bpf_attach(void);
-- 
2.51.0


