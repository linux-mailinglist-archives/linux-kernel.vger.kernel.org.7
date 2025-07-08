Return-Path: <linux-kernel+bounces-721745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E71AFCD5B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313AD1BC6C81
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A722E03E5;
	Tue,  8 Jul 2025 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7vnmTb4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E5A2DAFCC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984463; cv=none; b=tcP68YtpR/FYh5COvwQH6OGSoCBzxha+SvmO0QqrLrcVDzuRdAYvzv5DdWsG+6AN6quVP8QArSWtcd5GRdtl8BjJfxNBtfNY6IG/fLYGazyJxPMlsJRjpImKZqexZoSlRrQAKUJJzJ0+/ubNW8LFpPMP1BHCXZXLN5J4YLElVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984463; c=relaxed/simple;
	bh=UdrZJoGx1gbvV746qi6yFw9n+td+bMzxcJXiUXY2RSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UOT5ICrZNAb5C0+WLOyY+MXY5jT+QFWaC9F19ViMNGi7D4OF1cTDG/+an+z9rAnrST4qgAwb/5hFeyO77+m4A1avET4f4JN+9Vw+ILcasOJqNH07JyMcWaK1bYGm3TgeiGA8ow4nkctdqLlzuO8JJYlVllcxUJM+4OISaWsDwHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7vnmTb4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751984459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/QonvgsOMvDknFcD7XS1RQRFmAoKmHpzQki8o2rHkaE=;
	b=U7vnmTb4znBSk0ugdiPWm6aS5mlOFXRYp5ESKmQFjM4B3GBde+VqNwOepOpxGLjoehzl5F
	ZfAw0zgYrinSSosfxl+RCH8YjUw/4+oXPGwaYRxZ7TMpuRjlb111k97wgDvRFFpRd60KQB
	qAmy/LbHx/Xb+XCUNVw3Q2Y5+Wvi+wQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-V0XmifWvOW-iakW3i94eDQ-1; Tue,
 08 Jul 2025 10:20:57 -0400
X-MC-Unique: V0XmifWvOW-iakW3i94eDQ-1
X-Mimecast-MFC-AGG-ID: V0XmifWvOW-iakW3i94eDQ_1751984456
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DD091193F060;
	Tue,  8 Jul 2025 14:20:55 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.64.21])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2CEC19560AB;
	Tue,  8 Jul 2025 14:20:53 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Jeffery <djeffery@redhat.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH] kernel/async: streamline cookie synchronization
Date: Tue,  8 Jul 2025 10:15:35 -0400
Message-ID: <20250708141947.5932-1-djeffery@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

To prevent a thundering herd effect, implement a custom wake function for
the async subsystem which will only wake waiters which have all their
dependencies completed.

The async subsystem currently wakes all waiters on async_done when an async
task completes. When there are many tasks trying to synchronize on differnt
async values, this can create a thundering herd problem when an async task
wakes up all waiters, most of whom go back to waiting after causing
lock contention and wasting CPU.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---

This was originally submitted with a patch series for async shutdown as
the async shutdown patches could cause enough waiters to make the thundering
herd effect noticeable. The patch is being resubmitted separately as it
is its own issue and not part of the device shutdown code.

 kernel/async.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/kernel/async.c b/kernel/async.c
index 4c3e6a44595f..ae327f29bac9 100644
--- a/kernel/async.c
+++ b/kernel/async.c
@@ -76,6 +76,12 @@ struct async_entry {
 	struct async_domain	*domain;
 };
 
+struct async_wait_entry {
+	wait_queue_entry_t wait;
+	async_cookie_t cookie;
+	struct async_domain *domain;
+};
+
 static DECLARE_WAIT_QUEUE_HEAD(async_done);
 
 static atomic_t entry_count;
@@ -298,6 +304,24 @@ void async_synchronize_full_domain(struct async_domain *domain)
 }
 EXPORT_SYMBOL_GPL(async_synchronize_full_domain);
 
+/**
+ * async_domain_wake_function - wait function for cooking synchronization
+ *
+ * Custom wait function for async_synchronize_cookie_domain to check cookie
+ * value.  This prevents waking up waiting threads unnecessarily.
+ */
+static int async_domain_wake_function(struct wait_queue_entry *wait,
+				      unsigned int mode, int sync, void *key)
+{
+	struct async_wait_entry *await =
+		container_of(wait, struct async_wait_entry, wait);
+
+	if (lowest_in_progress(await->domain) < await->cookie)
+		return 0;
+
+	return autoremove_wake_function(wait, mode, sync, key);
+}
+
 /**
  * async_synchronize_cookie_domain - synchronize asynchronous function calls within a certain domain with cookie checkpointing
  * @cookie: async_cookie_t to use as checkpoint
@@ -310,11 +334,27 @@ EXPORT_SYMBOL_GPL(async_synchronize_full_domain);
 void async_synchronize_cookie_domain(async_cookie_t cookie, struct async_domain *domain)
 {
 	ktime_t starttime;
+	struct async_wait_entry await = {
+		.cookie = cookie,
+		.domain = domain,
+		.wait = {
+			.func = async_domain_wake_function,
+			.private = current,
+			.flags = 0,
+			.entry = LIST_HEAD_INIT(await.wait.entry),
+		}};
 
 	pr_debug("async_waiting @ %i\n", task_pid_nr(current));
 	starttime = ktime_get();
 
-	wait_event(async_done, lowest_in_progress(domain) >= cookie);
+	for (;;) {
+		prepare_to_wait(&async_done, &await.wait, TASK_UNINTERRUPTIBLE);
+
+		if (lowest_in_progress(domain) >= cookie)
+			break;
+		schedule();
+	}
+	finish_wait(&async_done, &await.wait);
 
 	pr_debug("async_continuing @ %i after %lli usec\n", task_pid_nr(current),
 		 microseconds_since(starttime));
-- 
2.39.3


