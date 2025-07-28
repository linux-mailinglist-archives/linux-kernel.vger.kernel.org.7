Return-Path: <linux-kernel+bounces-748056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92355B13C04
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D4217E655
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7F426D4EF;
	Mon, 28 Jul 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0ZQnP4w"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79D426D4DD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710651; cv=none; b=aZwwlp0coC2z3EVX3ysACDMytcbBAo1DZultUbYnIy/azne6wY6vvqRiboy/6EukGPwKuR13asQ1nEBQqHWPLuMZOmFfb4ii1kXnZIz00b7ttBQaS482UqYKsPX9Sn1L1koGuJ4It58eeDpwwCxIFkhTrpNnoVe2RtK37EvEwAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710651; c=relaxed/simple;
	bh=20BgeqDPx8BAFYoFrXp2HwYCm5oZitMEJSlofFT4BOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnyvhGIFbSAEuLxouQipO+3UT64q6sppsnZIpnnn9siaFQLaHjBLf7FUvByEj+KfUT3U4OBM3BJIL3zjOZFj4imibhrKCLeqmjX1jfopUOndB60gKmaVbWESnGXAv604zUegwI2MMZr2HwNcnXP89XoLOhZwqRTyxBDVvo4Fdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0ZQnP4w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753710648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aZSv6n/CJXft3fuH1gNZl5C0jDY0lVCodh+byC3xkS8=;
	b=Z0ZQnP4wiW9TPH0NI453c7Z8os/KbfQo8hZbdNQBldmERuP6VnPeZVgfg3ds0KqH89wqLO
	wrk80EUvXq8SQ++S/9jQbnlg2qLWIY9Qy/uy4dzeiXxcpa8J0PJk99WdAXqxvOGToGptUC
	hbGwRg7KiQQOzqzuw1I2/88yMDWIelU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-m2H2LPC3M1eNt6_Y6Y9RSg-1; Mon,
 28 Jul 2025 09:50:46 -0400
X-MC-Unique: m2H2LPC3M1eNt6_Y6Y9RSg-1
X-Mimecast-MFC-AGG-ID: m2H2LPC3M1eNt6_Y6Y9RSg_1753710645
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1873D19560B2;
	Mon, 28 Jul 2025 13:50:45 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.215])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A92EE1800285;
	Mon, 28 Jul 2025 13:50:39 +0000 (UTC)
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
Subject: [PATCH v5 1/9] rv: Add da_handle_start_run_event_ to per-task monitors
Date: Mon, 28 Jul 2025 15:50:13 +0200
Message-ID: <20250728135022.255578-2-gmonaco@redhat.com>
In-Reply-To: <20250728135022.255578-1-gmonaco@redhat.com>
References: <20250728135022.255578-1-gmonaco@redhat.com>
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

Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
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
2.50.1


