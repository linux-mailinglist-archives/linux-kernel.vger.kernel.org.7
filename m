Return-Path: <linux-kernel+bounces-731310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D8DB05280
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D301AA7E63
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5816026FA5A;
	Tue, 15 Jul 2025 07:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vbmunhsd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A2526F45D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563724; cv=none; b=MqpBQtFFVYhpBSnHfp6K/AwCUy3dCvbctdlyDVu+z+edsA9MBcBPqw3qvvM5z3jTxgox6eA5R0url6geey363z+xNGd5DphjIA8af1Zc8ZI0bJmqZmlSjHAwyR3/uOzrF92I8W/rLeo83ZsqRxcFQn/yWYX2FIvBHlxZ30SzTR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563724; c=relaxed/simple;
	bh=Ct2zo29AGQQ0cZ+MGXfRxxB80H8w/8b84QqJcZYh/f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyimcgKJ1L7H0P84hVLUm7/BkFRJQAaZt8JCw73aPNPjI3LGxCD77EG0lFCGfZCZrveBE4JrlM+rBTwh4CMZOy4RDxoJjiihT0lY0FLRhRpY0a7NiiPrJCFX7TEwLygdnRY4MYbJmEWP0qp7b9E8+rpm7ToNETO7zXgoX0Ud3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vbmunhsd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752563722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GiBIPi6oljTwNx1ZK0eI6nNNT8PvIKNjPDsOzG64Tqk=;
	b=Vbmunhsd0nImhV6la28Au5OfqVrpVNyPWy+20n2UzyCDCRN4P9nxaLcHh/tiIdgj65PuXK
	vHXQSHCn1d6J0N7hhYmH0JrrXxE69DDJFmSYcVF9NxIfel0m2EBt4t2lmuqRsJEb0S7bPv
	o5/kocDrmmRic/uaRcyAzpuFojtLPLE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-PDFf0_tPOyap16zSZrEbwA-1; Tue,
 15 Jul 2025 03:15:18 -0400
X-MC-Unique: PDFf0_tPOyap16zSZrEbwA-1
X-Mimecast-MFC-AGG-ID: PDFf0_tPOyap16zSZrEbwA_1752563717
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD81E1808993;
	Tue, 15 Jul 2025 07:15:17 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7B92318046C9;
	Tue, 15 Jul 2025 07:15:12 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 04/17] rv: Remove trailing whitespace from tracepoint string
Date: Tue, 15 Jul 2025 09:14:21 +0200
Message-ID: <20250715071434.22508-5-gmonaco@redhat.com>
In-Reply-To: <20250715071434.22508-1-gmonaco@redhat.com>
References: <20250715071434.22508-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

RV event tracepoints print a line with the format:
    "event_xyz: S0 x event -> S1 "
    "event_xyz: S1 x event -> S0 (final)"

While printing an event leading to a non-final state, the line
has a trailing white space (visible above before the closing ").

Adapt the format string not to print the trailing whitespace if we are
not printing "(final)".

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/rv_trace.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index b6f3104984664..17ba07329b670 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -29,11 +29,11 @@ DECLARE_EVENT_CLASS(event_da_monitor,
 		__entry->final_state		= final_state;
 	),
 
-	TP_printk("%s x %s -> %s %s",
+	TP_printk("%s x %s -> %s%s",
 		__entry->state,
 		__entry->event,
 		__entry->next_state,
-		__entry->final_state ? "(final)" : "")
+		__entry->final_state ? " (final)" : "")
 );
 
 DECLARE_EVENT_CLASS(error_da_monitor,
@@ -90,12 +90,12 @@ DECLARE_EVENT_CLASS(event_da_monitor_id,
 		__entry->final_state		= final_state;
 	),
 
-	TP_printk("%d: %s x %s -> %s %s",
+	TP_printk("%d: %s x %s -> %s%s",
 		__entry->id,
 		__entry->state,
 		__entry->event,
 		__entry->next_state,
-		__entry->final_state ? "(final)" : "")
+		__entry->final_state ? " (final)" : "")
 );
 
 DECLARE_EVENT_CLASS(error_da_monitor_id,
-- 
2.50.1


