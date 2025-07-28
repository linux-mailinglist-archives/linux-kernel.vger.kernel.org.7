Return-Path: <linux-kernel+bounces-748599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364C1B1437D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C1217F043
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4992309BD;
	Mon, 28 Jul 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqUEkT3h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F1F225390
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735786; cv=none; b=nWWyZ4vS2hpZyqDoFO5qEJyYdhJnQX4HTfzRB8I2f8OXxQi/BH82fABSDY+SgXduNSfPC6IP7KRMPJtokHgoeoTa62P5vPWVoiU/TqaJd88tOkH3UXvLmmfUQ7GJKTrs0uF0LxsoCeGgJd9AEVwqTU1nvpirkD/TJArfi7A1Dco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735786; c=relaxed/simple;
	bh=ZoZCZAaJhfgRL7NP5HYJOF2Pkwdg1aDsh+deeurCy4c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jM9EMAgffTG1I4JTErIjHwGMi4MNVuOO945Pc2s1EMwSN9YqCdufUTyfxztra8WkEC6N9uVR9MU53Uszz+v6r708PhNVJLJ4Iuag1miN7hLuaSS5IJlZ1/uMmKgyKdm3W0sA10RJapGz4TVHhzj7k1mXcUr1HmNlS2JxB9FskUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqUEkT3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C188C4CEE7;
	Mon, 28 Jul 2025 20:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753735786;
	bh=ZoZCZAaJhfgRL7NP5HYJOF2Pkwdg1aDsh+deeurCy4c=;
	h=Date:From:To:Cc:Subject:References:From;
	b=GqUEkT3h5dv60F/Pscrd2cKrQAtHU3O5Dr8ZXKATGLMDdBsOJx3dKIzfm9YrIaRdZ
	 vQWYCHZiUiKfTPyM5TPO2wuo+/ENHwGOR3F1TOaB45iNesQxILfzWfcEKhR70+RXo3
	 vjfGHLOnnWP4tZwwSHjIVT2pD98JZKgRKglCv25D1tcRpe8ZyTt4mdDtuzZp55PgDB
	 D9xKctzBlIWna7uzb+4UqT1INOPupU+QwNkHC+RVj/5woJzskr/xaIkZsL5LRHx0Lw
	 YNN7N/uZRayyxAQnwQ2GbVHerSdNt3831dacE5cuiH2uIeqpVpK+GrBgotSNeYCkcl
	 VhqfPTI3ypSwQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugUnG-000000042wm-3mCg;
	Mon, 28 Jul 2025 16:49:58 -0400
Message-ID: <20250728204958.754817582@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 28 Jul 2025 16:49:40 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <jlelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Nam Cao <namcao@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 06/11] rv: Adjust monitor dependencies
References: <20250728204934.281385756@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

RV monitors relying on the preemptirqs tracepoints are set as dependent
on PREEMPT_TRACER and IRQSOFF_TRACER. In fact, those configurations do
enable the tracepoints but are not the minimal configurations enabling
them, which are TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS (not selectable
manually).

Set TRACE_PREEMPT_TOGGLE and TRACE_IRQFLAGS as dependencies for
monitors.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Link: https://lore.kernel.org/20250728135022.255578-5-gmonaco@redhat.com
Fixes: fbe6c09b7eb4 ("rv: Add scpd, snep and sncid per-cpu monitors")
Acked-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/monitors/scpd/Kconfig  | 2 +-
 kernel/trace/rv/monitors/sncid/Kconfig | 2 +-
 kernel/trace/rv/monitors/snep/Kconfig  | 2 +-
 kernel/trace/rv/monitors/wip/Kconfig   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/monitors/scpd/Kconfig b/kernel/trace/rv/monitors/scpd/Kconfig
index b9114fbf680f..682d0416188b 100644
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
index 76bcfef4fd10..3a5639feaaaf 100644
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
index 77527f971232..7dd54f434ff7 100644
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
index e464b9294865..87a26195792b 100644
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
2.47.2



