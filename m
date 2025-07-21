Return-Path: <linux-kernel+bounces-738890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235E0B0BEBF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 198323B80B0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A02C288C01;
	Mon, 21 Jul 2025 08:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fs3Df2xG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4E287261
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086243; cv=none; b=eUzfdjboTmIxBV+PWUA9iZOBJOtDY5gjHBHQXLG7n+uIZa7KoUSASyR3/N3ulYyi8xbhn3LuQUbuVrBpQ6y5kH/vQ+5a9o+Q215Ua3KlCyb4Hz6KH07Z7WwbIpQaBfvm4zbJxDtO5n59IY1hFdtRODN4IOeQPi4mPHz4wac/ulA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086243; c=relaxed/simple;
	bh=S8XSph4CGykRKWV6LO1+fNjRMKNd3X9hGx0nmuXeG/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwYr83X5G4ufgjWhIONP/BFmkutxvPymz78ehmrmvWz/1JfAbIdu9aIezTw694iIpfphg6lyveZAss60v/hUnQcwzbcKAKf1wNKKnqYAcchLSYW8xiVt4LEKyVPMnNtelZXeV2+6GVt3lEZjh40K7f0VDBzz76Nda0zEKuj7BUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fs3Df2xG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753086241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpmW1LQ0RcFZxBKVUzlR69nCzAqnrlY/23ap2mvVnY8=;
	b=fs3Df2xGkNIOPAmfholFdtYrWzoo2ZntX5AAr4l0jc+/7sNBwtkK9siokGGdaN0v9wbVEJ
	x4szkdQgbhF17yUrrHj5PJ7uK8YgCYqrjavQC18VAuut407j8n1Ojy5dbeaivdfaZtlCR6
	Ai3QLH+hF83G8DXghE3yoCq/7UfgWeE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-pM8D02DRNgi2Cfx-wJ7Ahw-1; Mon,
 21 Jul 2025 04:23:59 -0400
X-MC-Unique: pM8D02DRNgi2Cfx-wJ7Ahw-1
X-Mimecast-MFC-AGG-ID: pM8D02DRNgi2Cfx-wJ7Ahw_1753086238
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 795161800878;
	Mon, 21 Jul 2025 08:23:58 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E5CC019560AD;
	Mon, 21 Jul 2025 08:23:53 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v4 03/14] rv: Add da_handle_start_run_event_ to per-task monitors
Date: Mon, 21 Jul 2025 10:23:13 +0200
Message-ID: <20250721082325.71554-4-gmonaco@redhat.com>
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

The RV da_monitor API allows to start monitors in two ways:
da_handle_start_event_NAME and da_handle_start_run_event_NAME.
The former is used when the event is followed by the initial state of
the module, so we ignore the event but we know the monitor is in the
initial state and can start monitoring, the latter can be used if the
event can only occur in the initial state, so we do handle the event as
if the monitor was in the initial state.
This latter API is defined for implicit monitors but not per-task ones.

Define da_handle_start_run_event_NAME macro also for per-task monitors.

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 15f9ed4e4bb69..ed3c34fe18d61 100644
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
2.50.1


