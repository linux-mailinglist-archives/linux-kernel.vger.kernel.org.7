Return-Path: <linux-kernel+bounces-871972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E725C0F003
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA2BD4F69F6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762D030C619;
	Mon, 27 Oct 2025 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i8po8+ZD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B630C60A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579263; cv=none; b=eROpC76R53BLgTCztyktPR0yJTGzsXeMMpXDK/9Job3Zphm8APYsv0CWZbUyhhqviRIuIl/pv/nWEgmRNtnx+lRLne+PrBmxzutffVfkvUiGQrpwFE/UZLe4Q0d3vNbQ3qk3mB1Izn7x/xGkganZ5M2GP3/f5evZTsFQsYfZnT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579263; c=relaxed/simple;
	bh=rGu5A3OU4ZSpORG0UAOqi+ojq3qcrJOfyOMyESOti20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGAIssFmPgtaIMUcI4it7LE8KsGKjlMbMzNs8Hk5lAYBIolPEU9tWlMOUF8g+TPVg3jDXpjpzydXlcRQaLfgRGTlf6wO0B9FO/RzqJMaj9yEOZNQm90xJzwZVqPz2BxtVT1cfo2zYplOj2WCMu9W5w9HI8AMVZu5Efh2L9X0zIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i8po8+ZD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761579261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mb0dB1veQuyN7Er4i7PkFCiU6cwrLRWf+Zv8v4WzqA0=;
	b=i8po8+ZDe534OLeD43ij/QbMTzhTRJgNbOZKEzX79ck2OVthbbz+Fkll3QsyDIwcEzpPcw
	V+G0qRlvq1mJS/TUiIY/v++rtb0rN2FS7x6P3esc0EFtPQIM9VQQbIqUU874l26aOlsU56
	Zq3/LCxvYEtUidtsszlS9344W9IcQTw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-vi5hkl8oMqCGWrodI2R52g-1; Mon,
 27 Oct 2025 11:34:17 -0400
X-MC-Unique: vi5hkl8oMqCGWrodI2R52g-1
X-Mimecast-MFC-AGG-ID: vi5hkl8oMqCGWrodI2R52g_1761579255
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC93C19540E7;
	Mon, 27 Oct 2025 15:34:14 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF7EA195398C;
	Mon, 27 Oct 2025 15:34:11 +0000 (UTC)
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
Subject: [PATCH v3 1/7] rtla/timerlat: Support tail call from BPF program
Date: Mon, 27 Oct 2025 16:33:55 +0100
Message-ID: <20251027153401.1039217-2-tglozar@redhat.com>
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


