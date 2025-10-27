Return-Path: <linux-kernel+bounces-871879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBDCC0EA08
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 668D14FD7F4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844A32D2483;
	Mon, 27 Oct 2025 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hf2bfNRR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4982D12EB
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576554; cv=none; b=LHozIQoX1y58cRtOiwBwcq8dik+yoYBT1DgSsbQlXb92qNf1UEE3xpyUOXdgxGvYlZFsp/3xQ7WFoSMfVrIjrKAN8YesJ28NdNmpooYsqmzwDV50TFI/G6B3jtlKKc+ip8MU9UdASLajD0OzKBKAYGeK+u670IWaLT1CdIpLymo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576554; c=relaxed/simple;
	bh=89ucxqi8UIsE4Lu6FVkMFUShD/uliEoam2sKnl0i6sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQlnYX+rN9eWQ9vjraqBdxcxtyluMFyDKagdYykyykrc5jsq1UrF0SC/dBlXi7uQwobFYI9dsLXiUjIutsxlvJlZpvrVT8PkzDpV7RTRqhyB71BqpFDXRRbTmAGhyE6YZ0zTSb5ytL6a0Ur6FRs5+RR4JVwdoC7ro9xhkBreox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hf2bfNRR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761576552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CRXrGVKrG927a4Z2bRgFJY9SvFsbOnohlu9r+MEylo=;
	b=hf2bfNRRpcVZeDWlt12bxAFkEEjoUAUiI5Z0M9Im+3Z3xJnKyE/R8D2b1NaCXei/wKbAHb
	eSIlI95MZsPEhfd3zb0VZz5Pr93xvnyg/ZO0pXSzZx+J2uxoAsSd9P/msGrXA/Y1aC4/xK
	CsooKO860wxz/ekIBF0YTfj6di16JIw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-J5WOj1J2Pt-xZZAcuuQ6xQ-1; Mon,
 27 Oct 2025 10:49:05 -0400
X-MC-Unique: J5WOj1J2Pt-xZZAcuuQ6xQ-1
X-Mimecast-MFC-AGG-ID: J5WOj1J2Pt-xZZAcuuQ6xQ_1761576544
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 731F319560AE;
	Mon, 27 Oct 2025 14:49:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 894AC1955F1B;
	Mon, 27 Oct 2025 14:49:01 +0000 (UTC)
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
Subject: [PATCH v2 7/7] Documentation/rtla: Document --bpf-action option
Date: Mon, 27 Oct 2025 15:48:19 +0100
Message-ID: <20251027144819.1034041-8-tglozar@redhat.com>
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

Add new option --bpf-action into common_timerlat_options.txt, including
the format in which it takes the BPF program, and a reference to an
example.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 .../tools/rtla/common_timerlat_options.rst    | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index c6046fcf52dc..7e08a27e87fe 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -65,3 +65,23 @@
         Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
         task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
         See linux/tools/rtla/example/timerlat_load.py for an example of user-load code.
+
+**--bpf-action** *bpf-program*
+
+        Loads a BPF program from an ELF file and executes it when a latency threshold is exceeded.
+
+        The BPF program must be a valid ELF file loadable with libbpf. The program must contain
+        a function named ``action_handler``, declared with ``SEC("tp/timerlat_action")`` or
+        a different section name beginning with "tp/". This tells libbpf that the program type is
+        BPF_PROG_TYPE_TRACEPOINT, without it, the program will not be loaded properly.
+
+        The program receives a ``struct trace_event_raw_timerlat_sample`` parameter
+        containing timerlat sample data.
+
+        An example is provided in ``tools/tracing/rtla/example/timerlat_bpf_action.c``.
+        This example demonstrates how to create a BPF program that prints latency information using
+        bpf_trace_printk() when a threshold is exceeded.
+
+        **Note**: BPF actions require BPF support to be available. If BPF is not available
+        or disabled, the tool will fall back to tracefs mode and BPF actions will not be
+        supported.
-- 
2.51.0


