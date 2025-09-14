Return-Path: <linux-kernel+bounces-815536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A4CB567DA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61229189DC56
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A374239086;
	Sun, 14 Sep 2025 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNdEQwM/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7321DF99C
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757848245; cv=none; b=YKhjVv+7iD0xfOy2tBK80So8Ngf+nzrcKLJUI9OLCQCqlZOO3qE99YX+ZtdgoYRVnIxgTJ9wLNCCUF3WETTR3jjCdKyt4/An6VO5hparZ9qPIpZptBJidr4L401Vg404VEKa8j1gtX2OTo4RsRPboNWzi6MJxqrJa+8nEtjuiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757848245; c=relaxed/simple;
	bh=dbX8W8Q5r2e72/1ZnC01YbJGzfiuQmxjVGW9+UZ0SC0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ozYY3+RD9uRINDbtbEq8mJRqT4zRZ2PdTWupU0n9oz8YTjawFldhLzQoiO6qz0V8fX+FNK6U06Acuu9L4qZxV1umIX77PraXTC0xBbxvrsglSKPDho3Njc/dfIxqEbGzLq5O2OVMCgUPQDwQeoLuZFNpoXE+7i3gsXg+yAM7wco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNdEQwM/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757848243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=J03Vf1QZRLxmIqPY7ceh1wswPEAfBZ2Jk1Fje+LP2Bg=;
	b=TNdEQwM/2uMAJMSV2i3uAUwGHig0osup4tV6ZRNSLCiRSf46RVRLJXDJvVAPwSC6WoSo4J
	k6SYAUOf9Oh6Hk9iGsReQDeR66Oh58w6KbqJFvbYOq1UPsKNduYkENKpH47ne2F0+O/ymU
	AaRnkTWcX7k9cHqcPWeLLj6d2dd5W5M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-GdNrTbS-MMy06eF_t1TxWQ-1; Sun,
 14 Sep 2025 07:10:37 -0400
X-MC-Unique: GdNrTbS-MMy06eF_t1TxWQ-1
X-Mimecast-MFC-AGG-ID: GdNrTbS-MMy06eF_t1TxWQ_1757848236
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E44271956053;
	Sun, 14 Sep 2025 11:10:35 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id D7C0C300021A;
	Sun, 14 Sep 2025 11:10:33 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 14 Sep 2025 13:09:11 +0200 (CEST)
Date: Sun, 14 Sep 2025 13:09:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fix the wrong comment on task_lock() nesting with
 tasklist_lock
Message-ID: <20250914110908.GA18769@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The ancient comment above task_lock() states that it can be nested outside
of read_lock(&tasklist_lock), but this is no longer true:

  CPU_0			CPU_1			CPU_2

  task_lock()		read_lock(tasklist)
  						write_lock_irq(tasklist)
  read_lock(tasklist)	task_lock()

Unless CPU_0 calls read_lock() in IRQ context, queued_read_lock_slowpath()
won't get the lock immediately, it will spin waiting for the pending writer
on CPU_2, resulting in a deadlock.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 include/linux/sched/task.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ea41795a352b..8ff98b18b24b 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -210,9 +210,8 @@ static inline struct vm_struct *task_stack_vm_area(const struct task_struct *t)
  * pins the final release of task.io_context.  Also protects ->cpuset and
  * ->cgroup.subsys[]. And ->vfork_done. And ->sysvshm.shm_clist.
  *
- * Nests both inside and outside of read_lock(&tasklist_lock).
- * It must not be nested with write_lock_irq(&tasklist_lock),
- * neither inside nor outside.
+ * Nests inside of read_lock(&tasklist_lock). It must not be nested with
+ * write_lock_irq(&tasklist_lock), neither inside nor outside.
  */
 static inline void task_lock(struct task_struct *p)
 {
-- 
2.25.1.362.g51ebf55



