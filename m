Return-Path: <linux-kernel+bounces-824668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9C2B89D39
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E21B564415
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F010315D5D;
	Fri, 19 Sep 2025 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vs2Exlkk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C963148B0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758291059; cv=none; b=i8wgUeeNhNzu4E8GgssUk4C3CUQ14ZNIx5aWX5FV4KCM5kOUG5nqhwMuQCdO7I4kM7IuWg3jhaL08YWuW2J1SIpOaFKpAkYWh4u89WrjkBV0ZfWBfh63xxMHodQ+rkEAG9r8OxJUAQVIABdVTDjQrd5g82HwRFTRuyo4WDOxcNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758291059; c=relaxed/simple;
	bh=UaqEeqUjhitCDEf7OGdAz7kL1+DSMklTo2/SPnymYuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5eEDKMQVdhS2OQb6NRrnDEoT49AJp43qfEiOCr5u6xR1yvWVXB+tPEfAr7eXhKBcKPmN9pe+SSzfHERneFPrfXdyF0RL2LG4XInTf1TzB66oP3pt5gwDThSjbwUfpW6sDRuv4nS1HEaMN2ZjMakFlY9Y3tvN/4h6PdBPD8MWMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vs2Exlkk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758291055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PtWmA8tkZkaIta3To900fr4As/wmX2PmmfiiaxKrTIE=;
	b=Vs2ExlkkQ+r9uOU9gMxqWi6AqLOfo6bBuu+cBwImcXI1KLnV6LLaZi3RZZ6/WuVebKkpkF
	3Ykq+BA3nhqW1XfFuQrxD/3+uSsQDUFmCj+lb6VFn6h6ib2oIPpdFuHm1G+TDbV3mVNNkK
	PyHDeVkFTbCZqJDAbMDrNBiVOOR55BM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-oMLYolwrOWycuEj4qvSh0w-1; Fri,
 19 Sep 2025 10:10:54 -0400
X-MC-Unique: oMLYolwrOWycuEj4qvSh0w-1
X-Mimecast-MFC-AGG-ID: oMLYolwrOWycuEj4qvSh0w_1758291053
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 508F519560AF;
	Fri, 19 Sep 2025 14:10:53 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.224.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D1F6F1956045;
	Fri, 19 Sep 2025 14:10:48 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v2 08/20] verification/dot2c: Remove superfluous enum assignment and add last comma
Date: Fri, 19 Sep 2025 16:09:42 +0200
Message-ID: <20250919140954.104920-9-gmonaco@redhat.com>
In-Reply-To: <20250919140954.104920-1-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The header files generated by dot2c currently create enums for states
and events assigning the first element to 0. This is superfluous as it
happens automatically if no value is specified.
Also it doesn't add a comma to the last enum elements, which slightly
complicates the diff if states or events are added.

Remove the assignment to 0 and add a comma to last elements, this
simplifies the logic for the code generator.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/nrp/nrp.h      | 20 +++++++-------
 kernel/trace/rv/monitors/opid/opid.h    | 22 +++++++--------
 kernel/trace/rv/monitors/sco/sco.h      | 12 ++++-----
 kernel/trace/rv/monitors/scpd/scpd.h    | 12 ++++-----
 kernel/trace/rv/monitors/snep/snep.h    | 16 +++++------
 kernel/trace/rv/monitors/snroc/snroc.h  | 12 ++++-----
 kernel/trace/rv/monitors/sssw/sssw.h    | 20 +++++++-------
 kernel/trace/rv/monitors/sts/sts.h      | 26 +++++++++---------
 kernel/trace/rv/monitors/wip/wip.h      | 12 ++++-----
 kernel/trace/rv/monitors/wwnr/wwnr.h    | 12 ++++-----
 tools/verification/rvgen/rvgen/dot2c.py | 36 +++++++++----------------
 11 files changed, 94 insertions(+), 106 deletions(-)

diff --git a/kernel/trace/rv/monitors/nrp/nrp.h b/kernel/trace/rv/monitors/nrp/nrp.h
index c2ec83da2124..3270d4c0139f 100644
--- a/kernel/trace/rv/monitors/nrp/nrp.h
+++ b/kernel/trace/rv/monitors/nrp/nrp.h
@@ -8,21 +8,21 @@
 #define MONITOR_NAME nrp
 
 enum states_nrp {
-	preempt_irq_nrp = 0,
+	preempt_irq_nrp,
 	any_thread_running_nrp,
 	nested_preempt_nrp,
 	rescheduling_nrp,
-	state_max_nrp
+	state_max_nrp,
 };
 
 #define INVALID_STATE state_max_nrp
 
 enum events_nrp {
-	irq_entry_nrp = 0,
+	irq_entry_nrp,
 	sched_need_resched_nrp,
 	schedule_entry_nrp,
 	schedule_entry_preempt_nrp,
-	event_max_nrp
+	event_max_nrp,
 };
 
 struct automaton_nrp {
@@ -38,38 +38,38 @@ static const struct automaton_nrp automaton_nrp = {
 		"preempt_irq",
 		"any_thread_running",
 		"nested_preempt",
-		"rescheduling"
+		"rescheduling",
 	},
 	.event_names = {
 		"irq_entry",
 		"sched_need_resched",
 		"schedule_entry",
-		"schedule_entry_preempt"
+		"schedule_entry_preempt",
 	},
 	.function = {
 		{
 			preempt_irq_nrp,
 			preempt_irq_nrp,
 			nested_preempt_nrp,
-			nested_preempt_nrp
+			nested_preempt_nrp,
 		},
 		{
 			any_thread_running_nrp,
 			rescheduling_nrp,
 			any_thread_running_nrp,
-			INVALID_STATE
+			INVALID_STATE,
 		},
 		{
 			nested_preempt_nrp,
 			preempt_irq_nrp,
 			any_thread_running_nrp,
-			any_thread_running_nrp
+			any_thread_running_nrp,
 		},
 		{
 			preempt_irq_nrp,
 			rescheduling_nrp,
 			any_thread_running_nrp,
-			any_thread_running_nrp
+			any_thread_running_nrp,
 		},
 	},
 	.initial_state = preempt_irq_nrp,
diff --git a/kernel/trace/rv/monitors/opid/opid.h b/kernel/trace/rv/monitors/opid/opid.h
index 5014f1b85ecf..092992514970 100644
--- a/kernel/trace/rv/monitors/opid/opid.h
+++ b/kernel/trace/rv/monitors/opid/opid.h
@@ -8,25 +8,25 @@
 #define MONITOR_NAME opid
 
 enum states_opid {
-	disabled_opid = 0,
+	disabled_opid,
 	enabled_opid,
 	in_irq_opid,
 	irq_disabled_opid,
 	preempt_disabled_opid,
-	state_max_opid
+	state_max_opid,
 };
 
 #define INVALID_STATE state_max_opid
 
 enum events_opid {
-	irq_disable_opid = 0,
+	irq_disable_opid,
 	irq_enable_opid,
 	irq_entry_opid,
 	preempt_disable_opid,
 	preempt_enable_opid,
 	sched_need_resched_opid,
 	sched_waking_opid,
-	event_max_opid
+	event_max_opid,
 };
 
 struct automaton_opid {
@@ -43,7 +43,7 @@ static const struct automaton_opid automaton_opid = {
 		"enabled",
 		"in_irq",
 		"irq_disabled",
-		"preempt_disabled"
+		"preempt_disabled",
 	},
 	.event_names = {
 		"irq_disable",
@@ -52,7 +52,7 @@ static const struct automaton_opid automaton_opid = {
 		"preempt_disable",
 		"preempt_enable",
 		"sched_need_resched",
-		"sched_waking"
+		"sched_waking",
 	},
 	.function = {
 		{
@@ -62,7 +62,7 @@ static const struct automaton_opid automaton_opid = {
 			INVALID_STATE,
 			irq_disabled_opid,
 			disabled_opid,
-			disabled_opid
+			disabled_opid,
 		},
 		{
 			irq_disabled_opid,
@@ -71,7 +71,7 @@ static const struct automaton_opid automaton_opid = {
 			preempt_disabled_opid,
 			enabled_opid,
 			INVALID_STATE,
-			INVALID_STATE
+			INVALID_STATE,
 		},
 		{
 			INVALID_STATE,
@@ -80,7 +80,7 @@ static const struct automaton_opid automaton_opid = {
 			INVALID_STATE,
 			INVALID_STATE,
 			in_irq_opid,
-			in_irq_opid
+			in_irq_opid,
 		},
 		{
 			INVALID_STATE,
@@ -89,7 +89,7 @@ static const struct automaton_opid automaton_opid = {
 			disabled_opid,
 			INVALID_STATE,
 			irq_disabled_opid,
-			INVALID_STATE
+			INVALID_STATE,
 		},
 		{
 			disabled_opid,
@@ -98,7 +98,7 @@ static const struct automaton_opid automaton_opid = {
 			INVALID_STATE,
 			enabled_opid,
 			INVALID_STATE,
-			INVALID_STATE
+			INVALID_STATE,
 		},
 	},
 	.initial_state = disabled_opid,
diff --git a/kernel/trace/rv/monitors/sco/sco.h b/kernel/trace/rv/monitors/sco/sco.h
index 06b1c420ce54..bac3beb51e72 100644
--- a/kernel/trace/rv/monitors/sco/sco.h
+++ b/kernel/trace/rv/monitors/sco/sco.h
@@ -8,18 +8,18 @@
 #define MONITOR_NAME sco
 
 enum states_sco {
-	thread_context_sco = 0,
+	thread_context_sco,
 	scheduling_context_sco,
-	state_max_sco
+	state_max_sco,
 };
 
 #define INVALID_STATE state_max_sco
 
 enum events_sco {
-	sched_set_state_sco = 0,
+	sched_set_state_sco,
 	schedule_entry_sco,
 	schedule_exit_sco,
-	event_max_sco
+	event_max_sco,
 };
 
 struct automaton_sco {
@@ -33,12 +33,12 @@ struct automaton_sco {
 static const struct automaton_sco automaton_sco = {
 	.state_names = {
 		"thread_context",
-		"scheduling_context"
+		"scheduling_context",
 	},
 	.event_names = {
 		"sched_set_state",
 		"schedule_entry",
-		"schedule_exit"
+		"schedule_exit",
 	},
 	.function = {
 		{     thread_context_sco, scheduling_context_sco,          INVALID_STATE },
diff --git a/kernel/trace/rv/monitors/scpd/scpd.h b/kernel/trace/rv/monitors/scpd/scpd.h
index 4a725a68085a..d6329da2671b 100644
--- a/kernel/trace/rv/monitors/scpd/scpd.h
+++ b/kernel/trace/rv/monitors/scpd/scpd.h
@@ -8,19 +8,19 @@
 #define MONITOR_NAME scpd
 
 enum states_scpd {
-	cant_sched_scpd = 0,
+	cant_sched_scpd,
 	can_sched_scpd,
-	state_max_scpd
+	state_max_scpd,
 };
 
 #define INVALID_STATE state_max_scpd
 
 enum events_scpd {
-	preempt_disable_scpd = 0,
+	preempt_disable_scpd,
 	preempt_enable_scpd,
 	schedule_entry_scpd,
 	schedule_exit_scpd,
-	event_max_scpd
+	event_max_scpd,
 };
 
 struct automaton_scpd {
@@ -34,13 +34,13 @@ struct automaton_scpd {
 static const struct automaton_scpd automaton_scpd = {
 	.state_names = {
 		"cant_sched",
-		"can_sched"
+		"can_sched",
 	},
 	.event_names = {
 		"preempt_disable",
 		"preempt_enable",
 		"schedule_entry",
-		"schedule_exit"
+		"schedule_exit",
 	},
 	.function = {
 		{     can_sched_scpd,     INVALID_STATE,     INVALID_STATE,     INVALID_STATE },
diff --git a/kernel/trace/rv/monitors/snep/snep.h b/kernel/trace/rv/monitors/snep/snep.h
index 753080dc5fa1..357520a5b3d1 100644
--- a/kernel/trace/rv/monitors/snep/snep.h
+++ b/kernel/trace/rv/monitors/snep/snep.h
@@ -8,19 +8,19 @@
 #define MONITOR_NAME snep
 
 enum states_snep {
-	non_scheduling_context_snep = 0,
+	non_scheduling_context_snep,
 	scheduling_contex_snep,
-	state_max_snep
+	state_max_snep,
 };
 
 #define INVALID_STATE state_max_snep
 
 enum events_snep {
-	preempt_disable_snep = 0,
+	preempt_disable_snep,
 	preempt_enable_snep,
 	schedule_entry_snep,
 	schedule_exit_snep,
-	event_max_snep
+	event_max_snep,
 };
 
 struct automaton_snep {
@@ -34,26 +34,26 @@ struct automaton_snep {
 static const struct automaton_snep automaton_snep = {
 	.state_names = {
 		"non_scheduling_context",
-		"scheduling_contex"
+		"scheduling_contex",
 	},
 	.event_names = {
 		"preempt_disable",
 		"preempt_enable",
 		"schedule_entry",
-		"schedule_exit"
+		"schedule_exit",
 	},
 	.function = {
 		{
 			non_scheduling_context_snep,
 			non_scheduling_context_snep,
 			scheduling_contex_snep,
-			INVALID_STATE
+			INVALID_STATE,
 		},
 		{
 			INVALID_STATE,
 			INVALID_STATE,
 			INVALID_STATE,
-			non_scheduling_context_snep
+			non_scheduling_context_snep,
 		},
 	},
 	.initial_state = non_scheduling_context_snep,
diff --git a/kernel/trace/rv/monitors/snroc/snroc.h b/kernel/trace/rv/monitors/snroc/snroc.h
index ada5ee08bdab..88b7328ad31a 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.h
+++ b/kernel/trace/rv/monitors/snroc/snroc.h
@@ -8,18 +8,18 @@
 #define MONITOR_NAME snroc
 
 enum states_snroc {
-	other_context_snroc = 0,
+	other_context_snroc,
 	own_context_snroc,
-	state_max_snroc
+	state_max_snroc,
 };
 
 #define INVALID_STATE state_max_snroc
 
 enum events_snroc {
-	sched_set_state_snroc = 0,
+	sched_set_state_snroc,
 	sched_switch_in_snroc,
 	sched_switch_out_snroc,
-	event_max_snroc
+	event_max_snroc,
 };
 
 struct automaton_snroc {
@@ -33,12 +33,12 @@ struct automaton_snroc {
 static const struct automaton_snroc automaton_snroc = {
 	.state_names = {
 		"other_context",
-		"own_context"
+		"own_context",
 	},
 	.event_names = {
 		"sched_set_state",
 		"sched_switch_in",
-		"sched_switch_out"
+		"sched_switch_out",
 	},
 	.function = {
 		{      INVALID_STATE,  own_context_snroc,       INVALID_STATE },
diff --git a/kernel/trace/rv/monitors/sssw/sssw.h b/kernel/trace/rv/monitors/sssw/sssw.h
index 8409eaadc7e0..1a4b806061c3 100644
--- a/kernel/trace/rv/monitors/sssw/sssw.h
+++ b/kernel/trace/rv/monitors/sssw/sssw.h
@@ -8,17 +8,17 @@
 #define MONITOR_NAME sssw
 
 enum states_sssw {
-	runnable_sssw = 0,
+	runnable_sssw,
 	signal_wakeup_sssw,
 	sleepable_sssw,
 	sleeping_sssw,
-	state_max_sssw
+	state_max_sssw,
 };
 
 #define INVALID_STATE state_max_sssw
 
 enum events_sssw {
-	sched_set_state_runnable_sssw = 0,
+	sched_set_state_runnable_sssw,
 	sched_set_state_sleepable_sssw,
 	sched_switch_blocking_sssw,
 	sched_switch_in_sssw,
@@ -27,7 +27,7 @@ enum events_sssw {
 	sched_switch_yield_sssw,
 	sched_wakeup_sssw,
 	signal_deliver_sssw,
-	event_max_sssw
+	event_max_sssw,
 };
 
 struct automaton_sssw {
@@ -43,7 +43,7 @@ static const struct automaton_sssw automaton_sssw = {
 		"runnable",
 		"signal_wakeup",
 		"sleepable",
-		"sleeping"
+		"sleeping",
 	},
 	.event_names = {
 		"sched_set_state_runnable",
@@ -54,7 +54,7 @@ static const struct automaton_sssw automaton_sssw = {
 		"sched_switch_suspend",
 		"sched_switch_yield",
 		"sched_wakeup",
-		"signal_deliver"
+		"signal_deliver",
 	},
 	.function = {
 		{
@@ -66,7 +66,7 @@ static const struct automaton_sssw automaton_sssw = {
 			INVALID_STATE,
 			runnable_sssw,
 			runnable_sssw,
-			runnable_sssw
+			runnable_sssw,
 		},
 		{
 			INVALID_STATE,
@@ -77,7 +77,7 @@ static const struct automaton_sssw automaton_sssw = {
 			INVALID_STATE,
 			signal_wakeup_sssw,
 			signal_wakeup_sssw,
-			runnable_sssw
+			runnable_sssw,
 		},
 		{
 			runnable_sssw,
@@ -88,7 +88,7 @@ static const struct automaton_sssw automaton_sssw = {
 			sleeping_sssw,
 			signal_wakeup_sssw,
 			runnable_sssw,
-			sleepable_sssw
+			sleepable_sssw,
 		},
 		{
 			INVALID_STATE,
@@ -99,7 +99,7 @@ static const struct automaton_sssw automaton_sssw = {
 			INVALID_STATE,
 			INVALID_STATE,
 			runnable_sssw,
-			INVALID_STATE
+			INVALID_STATE,
 		},
 	},
 	.initial_state = runnable_sssw,
diff --git a/kernel/trace/rv/monitors/sts/sts.h b/kernel/trace/rv/monitors/sts/sts.h
index 3779d7f99404..6f7b2d9d72e6 100644
--- a/kernel/trace/rv/monitors/sts/sts.h
+++ b/kernel/trace/rv/monitors/sts/sts.h
@@ -8,26 +8,26 @@
 #define MONITOR_NAME sts
 
 enum states_sts {
-	can_sched_sts = 0,
+	can_sched_sts,
 	cant_sched_sts,
 	disable_to_switch_sts,
 	enable_to_exit_sts,
 	in_irq_sts,
 	scheduling_sts,
 	switching_sts,
-	state_max_sts
+	state_max_sts,
 };
 
 #define INVALID_STATE state_max_sts
 
 enum events_sts {
-	irq_disable_sts = 0,
+	irq_disable_sts,
 	irq_enable_sts,
 	irq_entry_sts,
 	sched_switch_sts,
 	schedule_entry_sts,
 	schedule_exit_sts,
-	event_max_sts
+	event_max_sts,
 };
 
 struct automaton_sts {
@@ -46,7 +46,7 @@ static const struct automaton_sts automaton_sts = {
 		"enable_to_exit",
 		"in_irq",
 		"scheduling",
-		"switching"
+		"switching",
 	},
 	.event_names = {
 		"irq_disable",
@@ -54,7 +54,7 @@ static const struct automaton_sts automaton_sts = {
 		"irq_entry",
 		"sched_switch",
 		"schedule_entry",
-		"schedule_exit"
+		"schedule_exit",
 	},
 	.function = {
 		{
@@ -63,7 +63,7 @@ static const struct automaton_sts automaton_sts = {
 			INVALID_STATE,
 			INVALID_STATE,
 			scheduling_sts,
-			INVALID_STATE
+			INVALID_STATE,
 		},
 		{
 			INVALID_STATE,
@@ -71,7 +71,7 @@ static const struct automaton_sts automaton_sts = {
 			cant_sched_sts,
 			INVALID_STATE,
 			INVALID_STATE,
-			INVALID_STATE
+			INVALID_STATE,
 		},
 		{
 			INVALID_STATE,
@@ -79,7 +79,7 @@ static const struct automaton_sts automaton_sts = {
 			in_irq_sts,
 			switching_sts,
 			INVALID_STATE,
-			INVALID_STATE
+			INVALID_STATE,
 		},
 		{
 			enable_to_exit_sts,
@@ -87,7 +87,7 @@ static const struct automaton_sts automaton_sts = {
 			enable_to_exit_sts,
 			INVALID_STATE,
 			INVALID_STATE,
-			can_sched_sts
+			can_sched_sts,
 		},
 		{
 			INVALID_STATE,
@@ -95,7 +95,7 @@ static const struct automaton_sts automaton_sts = {
 			in_irq_sts,
 			INVALID_STATE,
 			INVALID_STATE,
-			INVALID_STATE
+			INVALID_STATE,
 		},
 		{
 			disable_to_switch_sts,
@@ -103,7 +103,7 @@ static const struct automaton_sts automaton_sts = {
 			INVALID_STATE,
 			INVALID_STATE,
 			INVALID_STATE,
-			INVALID_STATE
+			INVALID_STATE,
 		},
 		{
 			INVALID_STATE,
@@ -111,7 +111,7 @@ static const struct automaton_sts automaton_sts = {
 			INVALID_STATE,
 			INVALID_STATE,
 			INVALID_STATE,
-			INVALID_STATE
+			INVALID_STATE,
 		},
 	},
 	.initial_state = can_sched_sts,
diff --git a/kernel/trace/rv/monitors/wip/wip.h b/kernel/trace/rv/monitors/wip/wip.h
index cfdc52975354..b4c3eea94c86 100644
--- a/kernel/trace/rv/monitors/wip/wip.h
+++ b/kernel/trace/rv/monitors/wip/wip.h
@@ -8,18 +8,18 @@
 #define MONITOR_NAME wip
 
 enum states_wip {
-	preemptive_wip = 0,
+	preemptive_wip,
 	non_preemptive_wip,
-	state_max_wip
+	state_max_wip,
 };
 
 #define INVALID_STATE state_max_wip
 
 enum events_wip {
-	preempt_disable_wip = 0,
+	preempt_disable_wip,
 	preempt_enable_wip,
 	sched_waking_wip,
-	event_max_wip
+	event_max_wip,
 };
 
 struct automaton_wip {
@@ -33,12 +33,12 @@ struct automaton_wip {
 static const struct automaton_wip automaton_wip = {
 	.state_names = {
 		"preemptive",
-		"non_preemptive"
+		"non_preemptive",
 	},
 	.event_names = {
 		"preempt_disable",
 		"preempt_enable",
-		"sched_waking"
+		"sched_waking",
 	},
 	.function = {
 		{ non_preemptive_wip,      INVALID_STATE,      INVALID_STATE },
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.h b/kernel/trace/rv/monitors/wwnr/wwnr.h
index 85d12e42a955..a28006512c9b 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.h
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.h
@@ -8,18 +8,18 @@
 #define MONITOR_NAME wwnr
 
 enum states_wwnr {
-	not_running_wwnr = 0,
+	not_running_wwnr,
 	running_wwnr,
-	state_max_wwnr
+	state_max_wwnr,
 };
 
 #define INVALID_STATE state_max_wwnr
 
 enum events_wwnr {
-	switch_in_wwnr = 0,
+	switch_in_wwnr,
 	switch_out_wwnr,
 	wakeup_wwnr,
-	event_max_wwnr
+	event_max_wwnr,
 };
 
 struct automaton_wwnr {
@@ -33,12 +33,12 @@ struct automaton_wwnr {
 static const struct automaton_wwnr automaton_wwnr = {
 	.state_names = {
 		"not_running",
-		"running"
+		"running",
 	},
 	.event_names = {
 		"switch_in",
 		"switch_out",
-		"wakeup"
+		"wakeup",
 	},
 	.function = {
 		{       running_wwnr,      INVALID_STATE,   not_running_wwnr },
diff --git a/tools/verification/rvgen/rvgen/dot2c.py b/tools/verification/rvgen/rvgen/dot2c.py
index 24894411c3cd..06a26bf15a7e 100644
--- a/tools/verification/rvgen/rvgen/dot2c.py
+++ b/tools/verification/rvgen/rvgen/dot2c.py
@@ -28,11 +28,11 @@ class Dot2c(Automata):
 
     def __get_enum_states_content(self) -> list[str]:
         buff = []
-        buff.append("\t%s%s = 0," % (self.initial_state, self.enum_suffix))
+        buff.append("\t%s%s," % (self.initial_state, self.enum_suffix))
         for state in self.states:
             if state != self.initial_state:
                 buff.append("\t%s%s," % (state, self.enum_suffix))
-        buff.append("\tstate_max%s" % (self.enum_suffix))
+        buff.append("\tstate_max%s," % (self.enum_suffix))
 
         return buff
 
@@ -46,15 +46,10 @@ class Dot2c(Automata):
 
     def __get_enum_events_content(self) -> list[str]:
         buff = []
-        first = True
         for event in self.events:
-            if first:
-                buff.append("\t%s%s = 0," % (event, self.enum_suffix))
-                first = False
-            else:
-                buff.append("\t%s%s," % (event, self.enum_suffix))
+            buff.append("\t%s%s," % (event, self.enum_suffix))
 
-        buff.append("\tevent_max%s" % self.enum_suffix)
+        buff.append("\tevent_max%s," % self.enum_suffix)
 
         return buff
 
@@ -97,18 +92,11 @@ class Dot2c(Automata):
         buff.append("static const struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
         return buff
 
-    def __get_string_vector_per_line_content(self, buff: list[str]) -> str:
-        first = True
-        string = ""
-        for entry in buff:
-            if first:
-                string = string + "\t\t\"" + entry
-                first = False;
-            else:
-                string = string + "\",\n\t\t\"" + entry
-        string = string + "\""
-
-        return string
+    def __get_string_vector_per_line_content(self, entries: list[str]) -> str:
+        buff = []
+        for entry in entries:
+            buff.append(f"\t\t\"{entry}\",")
+        return "\n".join(buff)
 
     def format_aut_init_events_string(self) -> list[str]:
         buff = []
@@ -152,7 +140,7 @@ class Dot2c(Automata):
                 if y != nr_events-1:
                     line += ",\n" if linetoolong else ", "
                 else:
-                    line += "\n\t\t}," if linetoolong else " },"
+                    line += ",\n\t\t}," if linetoolong else " },"
             buff.append(line)
 
         return '\n'.join(buff)
@@ -179,12 +167,12 @@ class Dot2c(Automata):
         line = ""
         first = True
         for state in self.states:
-            if first == False:
+            if not first:
                 line = line + ', '
             else:
                 first = False
 
-            if self.final_states.__contains__(state):
+            if state in self.final_states:
                 line = line + '1'
             else:
                 line = line + '0'
-- 
2.51.0


