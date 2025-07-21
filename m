Return-Path: <linux-kernel+bounces-738895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 962CAB0BEC6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CB93B9E20
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01778289810;
	Mon, 21 Jul 2025 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MpXmTkjh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0F1283FE1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086269; cv=none; b=uIEdkTMvcuKjmo6h0hJeH+Zlu3frLi8wUZG9/OTDMpiEUCn88ZAAfTmDqT9TLfVYDQ+ABLPRVRsz/9M0rQinXUIyVL2W8zGkEtEX4XiccotW+AhMXHay/VfjZ/vAlnptUI3cI0NQk/h77MXKqZ1koXdqGe6jWtWJk1lpLAdmDp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086269; c=relaxed/simple;
	bh=y4TgCp34WY+f/i8jMEMw3OkzjLL8LNPtpzX2tJK6wW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMoWt7YkidCSkFIziM2prsCawwmwBwebPztrXGnzcvkg+iJClTuuCULDUQWTzBIBG2fAJ7LYRyAy9tQTNLV9N45zVsNlb2HSG7H/TuMYgNOuKXbaKlm1Z1ZXbMkzirGh4qwU3ilpJ+uxtsrPDC/DkldCN4K07tclo8QZ997Yuio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MpXmTkjh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753086266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SCCNZS0XFGLYyALmbzWdTfN//HN2C0O2fWy84mR83pU=;
	b=MpXmTkjh6XeyJbXjUfG1pdfBj3/yEXMy8KIDKu/HwQZ+5oh2SUVJqQNwk2o3j1SWJT1Eb1
	RbPDsNcK4IFIbCTpKG9TQfa7FgOC3pQdaUYS3Mk46JBMbqS68kGbvYib+YyHtKD+trWyzQ
	KO9mJsSZnuGM4SldTYsw6H5c4FQTqdI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-ZCEGr_PSPWKWJnLZHTBTlg-1; Mon,
 21 Jul 2025 04:24:25 -0400
X-MC-Unique: ZCEGr_PSPWKWJnLZHTBTlg-1
X-Mimecast-MFC-AGG-ID: ZCEGr_PSPWKWJnLZHTBTlg_1753086264
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D951318001C6;
	Mon, 21 Jul 2025 08:24:23 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7019D195608D;
	Mon, 21 Jul 2025 08:24:19 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v4 07/14] rv: Adjust monitor dependencies
Date: Mon, 21 Jul 2025 10:23:17 +0200
Message-ID: <20250721082325.71554-8-gmonaco@redhat.com>
In-Reply-To: <20250721082325.71554-1-gmonaco@redhat.com>
References: <20250721082325.71554-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

RV monitors relying on the preemptirqs tracepoints are set as dependent
on PREEMPT_TRACER and IRQSOFF_TRACER. In fact, those configurations do
enable the tracepoints but are not the minimal configurations enabling
them, which are TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS (not selectable
manually).

Set TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS as dependencies for
monitors.

Fixes: fbe6c09b7eb4 ("rv: Add scpd, snep and sncid per-cpu monitors")
Acked-by: Nam Cao <namcao@linutronix.de>
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


