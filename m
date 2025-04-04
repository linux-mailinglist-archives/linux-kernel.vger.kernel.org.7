Return-Path: <linux-kernel+bounces-588464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 820EBA7B928
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 10:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA0A173B72
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731FD1A08CA;
	Fri,  4 Apr 2025 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlQB/NEP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EC51A0728
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743756372; cv=none; b=NVdIZtGv/g9P42+XfdzOvUtynUS87kK0yrkMxPO0JfO1pEdh3y9gduK0WBgKw2cWRAp0yJZONcFHeson0zeWc28PTJo9l6StzvlZP1AWKP/bQ+jvWuYd6IRcanU9dvNdBtq7ywhPFvUw/oJ+Yg+8qyYLEQcR1eXXq5LycW0YcmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743756372; c=relaxed/simple;
	bh=eJnl1IDXPMHE4BFMxSE9HokWMN2YU1QZDL/2eg5jclo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B5YWvTU4aNtVjKcYO0jPV8Q5bBgT8T/zQ1WxxNHGfcy/oTpObaIb/CRNXCgYIPHVJf9XMqByR7mkchnB5/yDRcyOALKNNShRRievalfEcelG5v/5thnfAwpkk+3paeFoLn0j6ve26eNNzecyfVzWS8Hdp7x687y+EL0buexvDAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlQB/NEP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743756368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBMs/wyhUSkjsE/bwHu1RCObYE8GV6mTJWFwAwDI6HQ=;
	b=QlQB/NEPYPFlRrv0D9eRM2L+tDtRHqbIenf7TzYCMGoNEV+It7ywLABi6+LNjfFD8wnO/9
	UpnxDRkpbFIoxX8zZZLFfvEvMvT7lUjtMk4BVMoa7u21CGNDXY7CTbkyAVhBMYvCia+uZ6
	bDLdbmt98+oLWL/DNfU+Umiux3fK4UU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-yhMd20nnOtOOoQOSTQAiaQ-1; Fri,
 04 Apr 2025 04:46:06 -0400
X-MC-Unique: yhMd20nnOtOOoQOSTQAiaQ-1
X-Mimecast-MFC-AGG-ID: yhMd20nnOtOOoQOSTQAiaQ_1743756365
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9DB5B1956080;
	Fri,  4 Apr 2025 08:46:05 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.143])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 24BA6180A803;
	Fri,  4 Apr 2025 08:46:02 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>
Subject: [RFC PATCH 3/9] rv: Add da_handle_start_run_event_ to per-task monitors
Date: Fri,  4 Apr 2025 10:45:16 +0200
Message-ID: <20250404084512.98552-14-gmonaco@redhat.com>
In-Reply-To: <20250404084512.98552-11-gmonaco@redhat.com>
References: <20250404084512.98552-11-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The RV da_monitor API allows to start monitors in two ways:
da_handle_start_event_NAME and da_handle_start_run_event_NAME.
The former is used when the event is followed by the initial state of
the module, so we ignore the event but we know the monitor is in the
initial state and can start monitoring, the latter can be used if the
event can only occur in the initial state, so we do handle the event as
if the monitor was in the initial state.
This latter API is defined for implicit monitors but not per-task ones.

Define da_handle_start_run_event_NAME macro also for per-task monitors.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/rv/da_monitor.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 510c88bfabd43..215c3eb770ccc 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -512,6 +512,30 @@ da_handle_start_event_##name(struct task_struct *tsk, enum events_##name event)
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
2.49.0


