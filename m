Return-Path: <linux-kernel+bounces-731311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE062B05281
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE7D3BA235
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939B326FDA3;
	Tue, 15 Jul 2025 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EV+84lP7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F41926F45D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563732; cv=none; b=ZBdta7YqhKYmBSIvVw6l7U9q1fTXsA2HDxlLSXHxmhIuc8Z3SdoO2JE9YlfaQ5lZ59783oNBVgfO5LcrQHjbHqTvIlwClJOgl1r5Z0xRKdgcMpa0rd4WHE2NvqFTtmd2mlcwY4gZoX14S56k6h+hlBqopi2GBuOaGBL4rTr6LF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563732; c=relaxed/simple;
	bh=RwlkD+tCr0Pi85Lu3wroUbdADaE/C2Fff3qQjm2XHJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k5T9POomvK5vQYH/IfikPcZZSDrTWtSneAC1XOJzaidlRX/8DXMim6Cb5XA++5/THxtNSWE0X4nLuwZuT6dIwiBGHh5UwXoGjRWOnpJ7Hpc5Jm6L/4cZfuGh3Jk5hFYhzFPOq7I+QOc7NyUWVM0ayDBuodTsmKI02oGGTTlay/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EV+84lP7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752563729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMxLsVrAcLLK8IOUnW/ApzI7FRvl178+1OyVLrr+mv0=;
	b=EV+84lP7zpT0NOKd8Gwl3PwzIUrSwhA//zNKpvts4Lx0v9/DLfifi1N3M4IHbfilyGVwKh
	aZySSAuwuGlTPm8opqqlR1Kk3cZG8GJfJWoWKRxnHcKq6ujaQ341+obKr5NxdCnCLI5FOw
	qaQxgYEoaTp7Rqxl75hjqv3bupXwDjE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-dBvogFN8P0uO-1bfoB1n8A-1; Tue,
 15 Jul 2025 03:15:25 -0400
X-MC-Unique: dBvogFN8P0uO-1bfoB1n8A-1
X-Mimecast-MFC-AGG-ID: dBvogFN8P0uO-1bfoB1n8A_1752563724
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42A2119560AA;
	Tue, 15 Jul 2025 07:15:24 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.115])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60EA7180035E;
	Tue, 15 Jul 2025 07:15:19 +0000 (UTC)
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
Subject: [PATCH v3 05/17] rv: Return init error when registering monitors
Date: Tue, 15 Jul 2025 09:14:22 +0200
Message-ID: <20250715071434.22508-6-gmonaco@redhat.com>
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

Monitors generated with dot2k have their registration function (the one
called during monitor initialisation) return always 0, even if the
registration failed on RV side.
This can hide potential errors.

Return the value returned by the RV register function.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/monitors/sched/sched.c | 3 +--
 kernel/trace/rv/monitors/sco/sco.c     | 3 +--
 kernel/trace/rv/monitors/scpd/scpd.c   | 3 +--
 kernel/trace/rv/monitors/sncid/sncid.c | 3 +--
 kernel/trace/rv/monitors/snep/snep.c   | 3 +--
 kernel/trace/rv/monitors/snroc/snroc.c | 3 +--
 kernel/trace/rv/monitors/tss/tss.c     | 3 +--
 kernel/trace/rv/monitors/wip/wip.c     | 3 +--
 kernel/trace/rv/monitors/wwnr/wwnr.c   | 3 +--
 9 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/rv/monitors/sched/sched.c b/kernel/trace/rv/monitors/sched/sched.c
index 905e03c3c934d..d04db4b543f96 100644
--- a/kernel/trace/rv/monitors/sched/sched.c
+++ b/kernel/trace/rv/monitors/sched/sched.c
@@ -21,8 +21,7 @@ struct rv_monitor rv_sched = {
 
 static int __init register_sched(void)
 {
-	rv_register_monitor(&rv_sched, NULL);
-	return 0;
+	return rv_register_monitor(&rv_sched, NULL);
 }
 
 static void __exit unregister_sched(void)
diff --git a/kernel/trace/rv/monitors/sco/sco.c b/kernel/trace/rv/monitors/sco/sco.c
index 4cff59220bfc7..66f4639d46ac4 100644
--- a/kernel/trace/rv/monitors/sco/sco.c
+++ b/kernel/trace/rv/monitors/sco/sco.c
@@ -71,8 +71,7 @@ static struct rv_monitor rv_sco = {
 
 static int __init register_sco(void)
 {
-	rv_register_monitor(&rv_sco, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_sco, &rv_sched);
 }
 
 static void __exit unregister_sco(void)
diff --git a/kernel/trace/rv/monitors/scpd/scpd.c b/kernel/trace/rv/monitors/scpd/scpd.c
index cbdd6a5f8d7fd..299703cd72b06 100644
--- a/kernel/trace/rv/monitors/scpd/scpd.c
+++ b/kernel/trace/rv/monitors/scpd/scpd.c
@@ -79,8 +79,7 @@ static struct rv_monitor rv_scpd = {
 
 static int __init register_scpd(void)
 {
-	rv_register_monitor(&rv_scpd, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_scpd, &rv_sched);
 }
 
 static void __exit unregister_scpd(void)
diff --git a/kernel/trace/rv/monitors/sncid/sncid.c b/kernel/trace/rv/monitors/sncid/sncid.c
index f5037cd6214c2..3e1ee715a0fbf 100644
--- a/kernel/trace/rv/monitors/sncid/sncid.c
+++ b/kernel/trace/rv/monitors/sncid/sncid.c
@@ -79,8 +79,7 @@ static struct rv_monitor rv_sncid = {
 
 static int __init register_sncid(void)
 {
-	rv_register_monitor(&rv_sncid, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_sncid, &rv_sched);
 }
 
 static void __exit unregister_sncid(void)
diff --git a/kernel/trace/rv/monitors/snep/snep.c b/kernel/trace/rv/monitors/snep/snep.c
index 0076ba6d7ea44..2adc3108d60c9 100644
--- a/kernel/trace/rv/monitors/snep/snep.c
+++ b/kernel/trace/rv/monitors/snep/snep.c
@@ -79,8 +79,7 @@ static struct rv_monitor rv_snep = {
 
 static int __init register_snep(void)
 {
-	rv_register_monitor(&rv_snep, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_snep, &rv_sched);
 }
 
 static void __exit unregister_snep(void)
diff --git a/kernel/trace/rv/monitors/snroc/snroc.c b/kernel/trace/rv/monitors/snroc/snroc.c
index bb1f60d552960..540e686e699f4 100644
--- a/kernel/trace/rv/monitors/snroc/snroc.c
+++ b/kernel/trace/rv/monitors/snroc/snroc.c
@@ -68,8 +68,7 @@ static struct rv_monitor rv_snroc = {
 
 static int __init register_snroc(void)
 {
-	rv_register_monitor(&rv_snroc, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_snroc, &rv_sched);
 }
 
 static void __exit unregister_snroc(void)
diff --git a/kernel/trace/rv/monitors/tss/tss.c b/kernel/trace/rv/monitors/tss/tss.c
index 542787e6524fc..0452fcd9edcfe 100644
--- a/kernel/trace/rv/monitors/tss/tss.c
+++ b/kernel/trace/rv/monitors/tss/tss.c
@@ -74,8 +74,7 @@ static struct rv_monitor rv_tss = {
 
 static int __init register_tss(void)
 {
-	rv_register_monitor(&rv_tss, &rv_sched);
-	return 0;
+	return rv_register_monitor(&rv_tss, &rv_sched);
 }
 
 static void __exit unregister_tss(void)
diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/wip/wip.c
index ed758fec8608f..4b4e99615a11f 100644
--- a/kernel/trace/rv/monitors/wip/wip.c
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -71,8 +71,7 @@ static struct rv_monitor rv_wip = {
 
 static int __init register_wip(void)
 {
-	rv_register_monitor(&rv_wip, NULL);
-	return 0;
+	return rv_register_monitor(&rv_wip, NULL);
 }
 
 static void __exit unregister_wip(void)
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
index 172f31c4b0f34..4145bea2729e1 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.c
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
@@ -70,8 +70,7 @@ static struct rv_monitor rv_wwnr = {
 
 static int __init register_wwnr(void)
 {
-	rv_register_monitor(&rv_wwnr, NULL);
-	return 0;
+	return rv_register_monitor(&rv_wwnr, NULL);
 }
 
 static void __exit unregister_wwnr(void)
-- 
2.50.1


