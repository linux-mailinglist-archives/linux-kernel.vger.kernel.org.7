Return-Path: <linux-kernel+bounces-704449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0417FAE9D9F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 14:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5916E4A246F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 12:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8B92E3375;
	Thu, 26 Jun 2025 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9CPucYu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F90D2DFF0D
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 12:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750941380; cv=none; b=bgujWDvklvNwmYXri4P0zTMVIL4RPVQ+39hVP2EspG+o9WYPGFkpofvi1xKy/6R2phr7izUaHw+84NpoAZhv2HWiayoHS/yrI4TYj3S4J8vkuaRljLsCeUharCj2rl1TkgyWwSqm/kF8sluVUU/EZW0bUPMgiSeAdavHSFkONTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750941380; c=relaxed/simple;
	bh=cOpwCH8DVaBtcRF0XPiHH/CxI5nZlNIp5nt3wZOKeWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tc1GCIWopzUU+2gEtESe1d5wHCib/B9F/4ktZ2MfSzSiabu0bCxnr4BTzxV/6uPZ5J8s2Lptk/PUjvpEJnofucpl4VzBENvro36eQvcn8TaifeOvZfH43vmPpovgudNFWupwiK4JRCB0zgeosOa9V48kzb9RjCmJDmD5d4ceAkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9CPucYu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750941377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wnuRWICz/3L1A5kr+hgYjZ7aQO+C6vPwfPXybDrYEg=;
	b=H9CPucYulMPrbxDTFima73+/Qs+YqmF7y8UVEAzh/p6AyU9mwPTnqPhEEqvnwJ/uwalqsN
	S8EFASm+5PqAz55BFOqZJd/ps7rzf55ClJYk0PODU/fOmKt0Mhyb0tEM+qWA28fN9mmCFP
	+0e6bXVtpvTC04c2YFcQtet3D+Gndpc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-pd2-vGxGP-6TCkJ4sGP65A-1; Thu,
 26 Jun 2025 08:36:16 -0400
X-MC-Unique: pd2-vGxGP-6TCkJ4sGP65A-1
X-Mimecast-MFC-AGG-ID: pd2-vGxGP-6TCkJ4sGP65A_1750941375
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B52B1955EC3;
	Thu, 26 Jun 2025 12:36:15 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.241])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 683A9180045B;
	Thu, 26 Jun 2025 12:36:12 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chang Yin <cyin@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 3/9] rtla/timerlat_bpf: Allow resuming tracing
Date: Thu, 26 Jun 2025 14:33:59 +0200
Message-ID: <20250626123405.1496931-4-tglozar@redhat.com>
In-Reply-To: <20250626123405.1496931-1-tglozar@redhat.com>
References: <20250626123405.1496931-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently, rtla-timerlat BPF program uses a global variable stored in a
.bss section to store whether tracing has been stopped.

Move the information to a separate map, so that it is easily writable
from userspace, and add a function that clears the value, resuming
tracing after it has been stopped.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
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
2.49.0


