Return-Path: <linux-kernel+bounces-731314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B81B05288
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC903B6C23
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09562737FB;
	Tue, 15 Jul 2025 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6TbYrtT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F4272800
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563744; cv=none; b=LAg5TBTVK20q6TqZO24wYgQKqB1wQct89xA94EnqisszPO9JsqQRBkubUid6WhFXjTa0s+B/U2oQMBgwt+PzbkncIlEgv5kcil+//txCcemihfamHH9Y/TdDvWRpI8tWZLnN/Xsb0gXvqBG7PaiFpKt3KtxNxjeQXa1EeXDD6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563744; c=relaxed/simple;
	bh=SUx2iyawF2HdWYKA/0JO4rOajNFucjnKE5aUN6ggh04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaQ4fx889ArnJKjMyrHCdRIMp7euGbbwiZWGB64Li6S030UR92OZf91vMW2bqVge1W5q1jlD/hXOXEPy3qRmyKpIW90oFWZdqywKoEBO3MUK0R6gWejAMFqSshtxTSEugl/tliN8vjjYVpt8Fvpvg9dn7l22gpJPcexsXmBKdLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6TbYrtT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752563741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LKWt6w3VXsi30diFBv6tCLC7Y1FPhJZJvvi5v9FWQ5c=;
	b=h6TbYrtTjJRPQeO5WdjJGBiH3LDI8lldCFZptZyMO8CS68A9fIpiep+Gs42DQ4MKNB7MJB
	AdzcrlFAFxO34a16Lu1yWgm3Vn0rc0gjxfFFV9ZHPbOCbyDjFkIkdJcH6nrfCGNqRNQcdz
	rILSfmUjLx2XB8tt+7pIpOu6YOm8ZiU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-inW1JskwPt-ti5JcGtggDw-1; Tue,
 15 Jul 2025 03:15:36 -0400
X-MC-Unique: inW1JskwPt-ti5JcGtggDw-1
X-Mimecast-MFC-AGG-ID: inW1JskwPt-ti5JcGtggDw_1752563735
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF093195608F;
	Tue, 15 Jul 2025 07:15:35 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B78218046C6;
	Tue, 15 Jul 2025 07:15:30 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v3 07/17] rv: Adjust monitor dependencies
Date: Tue, 15 Jul 2025 09:14:24 +0200
Message-ID: <20250715071434.22508-8-gmonaco@redhat.com>
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

RV monitors relying on the preemptirqs tracepoints are set as dependent
on PREEMPT_TRACER and IRQSOFF_TRACER. In fact, those configurations do
enable the tracepoints but are not the minimal configurations enabling
them, which are TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS (not selectable
manually).

Set TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS as dependencies for
monitors.

Fixes: fbe6c09b7eb4 ("rv: Add scpd, snep and sncid per-cpu monitors")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/scpd/Kconfig  | 2 +-
 kernel/trace/rv/monitors/sncid/Kconfig | 2 +-
 kernel/trace/rv/monitors/snep/Kconfig  | 2 +-
 kernel/trace/rv/monitors/wip/Kconfig   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/monitors/scpd/Kconfig b/kernel/trace/rv/monitors/scpd/Kconfig
index b9114fbf680f9..682d0416188b3 100644
--- a/kernel/trace/rv/monitors/scpd/Kconfig
+++ b/kernel/trace/rv/monitors/scpd/Kconfig
@@ -2,7 +2,7 @@
 #
 config RV_MON_SCPD
 	depends on RV
-	depends on PREEMPT_TRACER
+	depends on TRACE_PREEMPT_TOGGLE
 	depends on RV_MON_SCHED
 	default y
 	select DA_MON_EVENTS_IMPLICIT
diff --git a/kernel/trace/rv/monitors/sncid/Kconfig b/kernel/trace/rv/monitors/sncid/Kconfig
index 76bcfef4fd103..3a5639feaaaf6 100644
--- a/kernel/trace/rv/monitors/sncid/Kconfig
+++ b/kernel/trace/rv/monitors/sncid/Kconfig
@@ -2,7 +2,7 @@
 #
 config RV_MON_SNCID
 	depends on RV
-	depends on IRQSOFF_TRACER
+	depends on TRACE_IRQFLAGS
 	depends on RV_MON_SCHED
 	default y
 	select DA_MON_EVENTS_IMPLICIT
diff --git a/kernel/trace/rv/monitors/snep/Kconfig b/kernel/trace/rv/monitors/snep/Kconfig
index 77527f9712325..7dd54f434ff75 100644
--- a/kernel/trace/rv/monitors/snep/Kconfig
+++ b/kernel/trace/rv/monitors/snep/Kconfig
@@ -2,7 +2,7 @@
 #
 config RV_MON_SNEP
 	depends on RV
-	depends on PREEMPT_TRACER
+	depends on TRACE_PREEMPT_TOGGLE
 	depends on RV_MON_SCHED
 	default y
 	select DA_MON_EVENTS_IMPLICIT
diff --git a/kernel/trace/rv/monitors/wip/Kconfig b/kernel/trace/rv/monitors/wip/Kconfig
index e464b9294865b..87a26195792b4 100644
--- a/kernel/trace/rv/monitors/wip/Kconfig
+++ b/kernel/trace/rv/monitors/wip/Kconfig
@@ -2,7 +2,7 @@
 #
 config RV_MON_WIP
 	depends on RV
-	depends on PREEMPT_TRACER
+	depends on TRACE_PREEMPT_TOGGLE
 	select DA_MON_EVENTS_IMPLICIT
 	bool "wip monitor"
 	help
-- 
2.50.1


