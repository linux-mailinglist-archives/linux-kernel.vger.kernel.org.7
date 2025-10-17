Return-Path: <linux-kernel+bounces-858222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C048CBE952D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8DC84E8E08
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFFB336EE9;
	Fri, 17 Oct 2025 14:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwwn5hFQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0412D8795
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712450; cv=none; b=S699t4cMnidBgddab9vZDo/Y45JA3iAJ/oz0ItQP/FvLGefMe/xVTWAEfEy+DdUmhmmcbhZMbnemc7n+LOGj4q8/s9ITscvWZ6VETGFl3ieCo30ZBCETOmq2T9+7I4WDbdxGWbDGbuFntm7w1Dvqsfge1IxQbwno5IfEx4OejkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712450; c=relaxed/simple;
	bh=Srk+Fr4TqyjLD7nJUa5pnoyjK2m8oW4zuu6Kvh8HhdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWLS0fawxSEtxM4sOcCXafvQ4p6qyrCaKNSQryUMMbw73l5T9/d9wKQyLXfU+n9w07fT2o6/ubyWQNoBKwoHx4E4zkd583YIKtllarPUiXSiiiZSJlDcbTVSQNtaBFqK7xe/Jv7OuYO0sv7F4IPS178EE7DHbzxzxk1tPjONwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hwwn5hFQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760712447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+g39942jtLGJd3OsDmw3XB6JSqklKuGB9oYb6LS2jo=;
	b=hwwn5hFQy6puOGuxkvIhyIuq9et7Yja0Pvu8lPQ2rxj998ZGqdq1ToT+4vr6a1qzo4zGxC
	w7z1bOcpzBKuKoiFtlEO0o22K2H6ffhGo/SlTpwx8p3Pu2Ih9wOZ9hUuMlKRxbEwuSya/X
	4TFfMeKfrTLa4D64nsrrD3oAY1YgkPQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-v_DwCMsAPQeD3eKnXiuP3w-1; Fri,
 17 Oct 2025 10:47:22 -0400
X-MC-Unique: v_DwCMsAPQeD3eKnXiuP3w-1
X-Mimecast-MFC-AGG-ID: v_DwCMsAPQeD3eKnXiuP3w_1760712441
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1CBB1954210;
	Fri, 17 Oct 2025 14:47:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.24])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D5601800452;
	Fri, 17 Oct 2025 14:47:18 +0000 (UTC)
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
Subject: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
Date: Fri, 17 Oct 2025 16:46:49 +0200
Message-ID: <20251017144650.663238-4-tglozar@redhat.com>
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

Add an example BPF action program that prints the measured latency to
the tracefs buffer via bpf_printk().

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/sample/timerlat_bpf_action.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 tools/tracing/rtla/sample/timerlat_bpf_action.c

diff --git a/tools/tracing/rtla/sample/timerlat_bpf_action.c b/tools/tracing/rtla/sample/timerlat_bpf_action.c
new file mode 100644
index 000000000000..ac1be049a848
--- /dev/null
+++ b/tools/tracing/rtla/sample/timerlat_bpf_action.c
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
-- 
2.51.0


