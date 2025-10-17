Return-Path: <linux-kernel+bounces-858223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9926BE9530
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDBD3A5641
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F08D336EF3;
	Fri, 17 Oct 2025 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEV2F0HU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A07132C930
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712450; cv=none; b=RhRAf/fifHl+sR/UpWfbH/F59MEuJKkNfllAJO4sTDcaetGqAxnLoEdAqujRZeokTp7UKE51YNZzNxmLDQ6Mueg8xcBe4Cg3u3zhKv6kwzpLXCHqAjCn3i0ZdQCnxJknw6+ICFQymbhX/hk+rpMsyCnPCMrgwjbR0Wt7M6O/Dq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712450; c=relaxed/simple;
	bh=NwrBGbwiurA2rZyhLXqF+CXHY6SUzDcJCl6Zcy5y4pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgoDnpDc4MwgSWlsHJkeQrgeeiWkISG2WTHJhwV0vdGaWNf9OkkUKPNQm2eHhsJNGq8pzMZ74klowqXOQr7/9rsQUtR/TyaKPYBj885n0so/HdsENuQXrGB3iuXyugbHYO8ggb1O9oQ5rfcegMkrIHqpwbuCTTsStABUY9pxZL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WEV2F0HU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760712448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0PTwm4egHkSEItopN4T5WsSS2MglJFP6Z4suby+DafY=;
	b=WEV2F0HUxlgJNogondJ5BJSvcnL/xmhYPlrYrrQAlJAPmjMPF1fw7b03vGe9kzxGhkJr6g
	0rw7G7jAT+fceItmW1GlOKG4vdI/C1iQvlZ8xu6Ujo1XFGMsgFZcIYoOsLx+qfS5XwZCZZ
	EjtWQBVMvW6NZ/B+GIcnHQxMWRzklis=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-Nq-NJnGhNa6jIMjQaMxiiQ-1; Fri,
 17 Oct 2025 10:47:26 -0400
X-MC-Unique: Nq-NJnGhNa6jIMjQaMxiiQ-1
X-Mimecast-MFC-AGG-ID: Nq-NJnGhNa6jIMjQaMxiiQ_1760712445
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42E451956054;
	Fri, 17 Oct 2025 14:47:25 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 665C31800452;
	Fri, 17 Oct 2025 14:47:21 +0000 (UTC)
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
Subject: [PATCH 4/4] Documentation/rtla: Document --bpf-action option
Date: Fri, 17 Oct 2025 16:46:50 +0200
Message-ID: <20251017144650.663238-5-tglozar@redhat.com>
In-Reply-To: <20251017144650.663238-1-tglozar@redhat.com>
References: <20251017144650.663238-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add new option --bpf-action into common_timerlat_options.txt, including
the format in which it takes the BPF program, and a reference to an
example.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 .../tools/rtla/common_timerlat_options.rst     | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index 1f5d024b53aa..1b7293ebc897 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -65,3 +65,21 @@
         Set timerlat to run without workload, waiting for the user to dispatch a per-cpu
         task that waits for a new period on the tracing/osnoise/per_cpu/cpu$ID/timerlat_fd.
         See linux/tools/rtla/sample/timerlat_load.py for an example of user-load code.
+
+**--bpf-action** *bpf-program*
+
+        Loads a BPF program from an ELF file and executes it when a latency threshold is exceeded.
+
+        The BPF program must be a valid ELF file loadable with libbpf. The program must contain
+        a function named ``action_handler``, declared with ``SEC("tp/timerlat_action")`` for libbpf
+        to correctly detect the program type.
+
+        The program receives a ``struct trace_event_raw_timerlat_sample`` parameter
+        containing timerlat sample data.
+
+        A sample BPF action program is provided in ``tools/tracing/rtla/sample/timerlat_bpf_action.c``.
+        This example demonstrates how to create a BPF program that prints latency information when
+        thresholds are exceeded.
+
+        **Note**: BPF actions require BPF support to be available. If BPF is not available or disabled,
+        the tool will fall back to tracefs mode and BPF actions will not be supported.
-- 
2.51.0


