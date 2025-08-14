Return-Path: <linux-kernel+bounces-769135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D0DB26A7D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 17:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D6D54E5DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49C0222562;
	Thu, 14 Aug 2025 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fxspNEqF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170721C9F4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184138; cv=none; b=jlpz2uJmooBwdamcy2wl8YozNXdEcDtUVSeVF9ofrSSWsNXAeiDE90lfMDXgHruf8fxI1OICjLfgMN+3qZExW2Em/usV2Ws/ObN+Q9gYOtCvFPImtz9MKZv/TqhL/p3jIrn1VHHrB5V0Hw+TjcJBVCGN70C0uBjiA/h1Gl8NdaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184138; c=relaxed/simple;
	bh=TQ+yq4R5SsUlFYq2LKwIsgtXhQ8BHRVmJ5Fa3o26TkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQmN98cDg8GwkmE2H2KVsS38tUk3fBBBDjZFIxnFRNaftmX1e7aV70cxkkkjMBQNgB0pLdfoVAOTJqNnq4Stw4AqsVjSQ3Tw5xoRcInJgyeVxUIqieSBgKFWiJYz2hJMgIUdHMc8B65lQkJQKS6cyISxK4CK8bnNp7y2c61R8R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fxspNEqF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755184135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFx756cjjS5MiQCtuQPJDvDAXhbdcRmOEdC2k9EimRA=;
	b=fxspNEqFwJhz5rjtugLEH+KrIIQXLn/EIyeS8e3stvQ+OKqL5XJ4RBiC/+hJ19gQmQwpAc
	WjBzZjdYZBM/0qL2Wp8hdCvat82OjdVRPzK/JYJCuZjxzuYkuBWkbcFLSu2HVUlEU8SBrH
	nWGqw5Jqb0paeyTYS6UalLu5JsK2lfs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-i4dlrAafNsSNcnKSDkG5IA-1; Thu,
 14 Aug 2025 11:08:53 -0400
X-MC-Unique: i4dlrAafNsSNcnKSDkG5IA-1
X-Mimecast-MFC-AGG-ID: i4dlrAafNsSNcnKSDkG5IA_1755184132
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B0A81800EEF;
	Thu, 14 Aug 2025 15:08:44 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.52])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50595180047F;
	Thu, 14 Aug 2025 15:08:39 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [RFC PATCH 03/17] Documentation/rv: Adapt documentation after da_monitor refactoring
Date: Thu, 14 Aug 2025 17:07:55 +0200
Message-ID: <20250814150809.140739-4-gmonaco@redhat.com>
In-Reply-To: <20250814150809.140739-1-gmonaco@redhat.com>
References: <20250814150809.140739-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 Documentation/trace/rv/monitor_synthesis.rst | 44 ++++++++++----------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/Documentation/trace/rv/monitor_synthesis.rst b/Documentation/trace/rv/monitor_synthesis.rst
index ac808a7554f5..ce0c1a5104d4 100644
--- a/Documentation/trace/rv/monitor_synthesis.rst
+++ b/Documentation/trace/rv/monitor_synthesis.rst
@@ -100,54 +100,52 @@ rv/da_monitor.h
 
 This initial implementation presents three different types of monitor instances:
 
-- ``#define DECLARE_DA_MON_GLOBAL(name, type)``
-- ``#define DECLARE_DA_MON_PER_CPU(name, type)``
-- ``#define DECLARE_DA_MON_PER_TASK(name, type)``
+- ``#define RV_MON_TYPE RV_MON_GLOBAL``
+- ``#define RV_MON_TYPE RV_MON_PER_CPU``
+- ``#define RV_MON_TYPE RV_MON_PER_TASK``
 
-The first declares the functions for a global deterministic automata monitor,
-the second for monitors with per-cpu instances, and the third with per-task
-instances.
+The first sets up functions declaration for a global deterministic automata
+monitor, the second for monitors with per-cpu instances, and the third with
+per-task instances.
 
-In all cases, the 'name' argument is a string that identifies the monitor, and
-the 'type' argument is the data type used by rvgen on the representation of
-the model in C.
+In all cases, the C file must include the $(MODEL_NAME).h file (generated by
+`rvgen`), for example, to define the per-cpu 'wip' monitor, the `wip.c` source
+file must include::
 
-For example, the wip model with two states and three events can be
-stored in an 'unsigned char' type. Considering that the preemption control
-is a per-cpu behavior, the monitor declaration in the 'wip.c' file is::
-
-  DECLARE_DA_MON_PER_CPU(wip, unsigned char);
+  #define RV_MON_TYPE RV_MON_PER_CPU
+  #include "wip.h"
+  #include <rv/da_monitor.h>
 
 The monitor is executed by sending events to be processed via the functions
 presented below::
 
-  da_handle_event_$(MONITOR_NAME)($(event from event enum));
-  da_handle_start_event_$(MONITOR_NAME)($(event from event enum));
-  da_handle_start_run_event_$(MONITOR_NAME)($(event from event enum));
+  da_handle_event($(event from event enum));
+  da_handle_start_event($(event from event enum));
+  da_handle_start_run_event($(event from event enum));
 
-The function ``da_handle_event_$(MONITOR_NAME)()`` is the regular case where
+The function ``da_handle_event()`` is the regular case where
 the event will be processed if the monitor is processing events.
 
 When a monitor is enabled, it is placed in the initial state of the automata.
 However, the monitor does not know if the system is in the *initial state*.
 
-The ``da_handle_start_event_$(MONITOR_NAME)()`` function is used to notify the
+The ``da_handle_start_event()`` function is used to notify the
 monitor that the system is returning to the initial state, so the monitor can
 start monitoring the next event.
 
-The ``da_handle_start_run_event_$(MONITOR_NAME)()`` function is used to notify
+The ``da_handle_start_run_event()`` function is used to notify
 the monitor that the system is known to be in the initial state, so the
 monitor can start monitoring and monitor the current event.
 
 Using the wip model as example, the events "preempt_disable" and
 "sched_waking" should be sent to monitor, respectively, via [2]::
 
-  da_handle_event_wip(preempt_disable_wip);
-  da_handle_event_wip(sched_waking_wip);
+  da_handle_event(preempt_disable_wip);
+  da_handle_event(sched_waking_wip);
 
 While the event "preempt_enabled" will use::
 
-  da_handle_start_event_wip(preempt_enable_wip);
+  da_handle_start_event(preempt_enable_wip);
 
 To notify the monitor that the system will be returning to the initial state,
 so the system and the monitor should be in sync.
-- 
2.50.1


