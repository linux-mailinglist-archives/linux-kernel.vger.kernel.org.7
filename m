Return-Path: <linux-kernel+bounces-748597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C656FB1437B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC344E2FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D226D22F76F;
	Mon, 28 Jul 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skVBZXub"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3533921CA00
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735786; cv=none; b=gOlItAAsqusRP2j07/jBT8G9McgwffykydtLCHll6Gl8XTslq6G/VJsF/CUvsfXn0y72NbAoZ39T9c79S5T0J6pKZfqI9v/cpYwJqdaz7/OMYxfSOnNbQeJVWdmVpZ1ipZ3BCOOu36H+S37xEiadJD9B78XLiYtdGlLpkmWzSWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735786; c=relaxed/simple;
	bh=CZ8NU2b5BJTwvMm3Ohi9pTiahzYRLV29sPFfQFmKRNk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pOhmvihIOBd0duJ9+zPVoPdX/sUjbAH2wk9Kx8/oCnCe3EqMtmsQIA6S213m0g6bjhR/Ugpz3YAvK48MTAJe2f7OfGQBQ8yYzY3ICY0Rvg4wP8Kys12BSYfnmlBi3rfFRx77jbTz5ebA+VL2lFJ4FKgd+W4tmqKfV+BBN0Ypi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skVBZXub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFA0C4CEF8;
	Mon, 28 Jul 2025 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753735785;
	bh=CZ8NU2b5BJTwvMm3Ohi9pTiahzYRLV29sPFfQFmKRNk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=skVBZXubxxPVRjoollTysa9t9yZ3uNlyvDZ69oZzCMNpovQQjmMHDlKItsfBpWjft
	 XKDIvLdmQMj+wAmKboe7261lwgT6XrR5Z/T1n4yIUM3fmzJvRG7hGbuGCQlfx4GJbO
	 n6A8miCLKFBgIuIp08A3koTDU+aS21ff6DhsfVUEMxjvfwm5t5b7izI0Evmn1g+Bi9
	 CiH6j8mCUzrQY61chUjSkj8WzEZKj3fJmiCZWJw8q8FVLtbrYaz7I8VSdBpnMqoAUu
	 m6/nYi+Y94/zxEAEa/Yw/uAgY+iUkyD3BtY7BKonYSe+oflwLM5lDdQ+/7eGglkk+J
	 Ii/RPCBa7uoew==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugUnG-000000042vJ-1gxk;
	Mon, 28 Jul 2025 16:49:58 -0400
Message-ID: <20250728204958.267161508@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 28 Jul 2025 16:49:37 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <jlelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Nam Cao <namcao@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 03/11] rv: Add da_handle_start_run_event_ to per-task monitors
References: <20250728204934.281385756@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

The RV da_monitor API allows to start monitors in two ways:
da_handle_start_event_NAME and da_handle_start_run_event_NAME.
The former is used when the event is followed by the initial state of
the module, so we ignore the event but we know the monitor is in the
initial state and can start monitoring, the latter can be used if the
event can only occur in the initial state, so we do handle the event as
if the monitor was in the initial state.
This latter API is defined for implicit monitors but not per-task ones.

Define da_handle_start_run_event_NAME macro also for per-task monitors.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Link: https://lore.kernel.org/20250728135022.255578-2-gmonaco@redhat.com
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/rv/da_monitor.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 15f9ed4e4bb6..ed3c34fe18d6 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -487,6 +487,30 @@ da_handle_start_event_##name(struct task_struct *tsk, enum events_##name event)
 	__da_handle_event_##name(da_mon, tsk, event);						\
 												\
 	return 1;										\
+}												\
+												\
+/*												\
+ * da_handle_start_run_event_##name - start monitoring and handle event				\
+ *												\
+ * This function is used to notify the monitor that the system is in the			\
+ * initial state, so the monitor can start monitoring and handling event.			\
+ */												\
+static inline bool										\
+da_handle_start_run_event_##name(struct task_struct *tsk, enum events_##name event)		\
+{												\
+	struct da_monitor *da_mon;								\
+												\
+	if (!da_monitor_enabled_##name())							\
+		return 0;									\
+												\
+	da_mon = da_get_monitor_##name(tsk);							\
+												\
+	if (unlikely(!da_monitoring_##name(da_mon)))						\
+		da_monitor_start_##name(da_mon);						\
+												\
+	__da_handle_event_##name(da_mon, tsk, event);						\
+												\
+	return 1;										\
 }
 
 /*
-- 
2.47.2



