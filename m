Return-Path: <linux-kernel+bounces-872971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB8CC12BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA04587260
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BFB238D54;
	Tue, 28 Oct 2025 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3MhKR3F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCC7242D72
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761621012; cv=none; b=gAvZXY/ngUIZPDBArjFvk1lGNZZf5RMC4sLd+TTULNqV3kQ3e/PuPeHxH5/yyUPDu/5tVokygbQcwdpkCq6Q+djdEbFeJxY7qy9z35Q9YpbnpuL/keqHGY/Neal9U2YvnKhAZ+NMHIhNU8kvLcW6mMvIcLY668m9VXZxC2a4GOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761621012; c=relaxed/simple;
	bh=dNVDQAbho5sZiPSWq6KQBghularpiURV4efBWN5pKzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJpia/u1dKAG6Tad+UBDdqs2aDhIEZbqVk6W0cz6IN/GfF7rT13YX8d1F2sdNYAe/FpiRECpMHhY1qVKgs38wE+BxcFfokJ7KL63thCtPG/xvNjw8cZ+vyenCv7smcOLfjanAjVfLszdq+BftK0iXpNQrawS89okYT5+Ay9AKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3MhKR3F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761621009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8WR19ZGz2+uRagsLyH/16PxuPlbDWfbpOkIs9ZyrcI=;
	b=d3MhKR3FG+5VEe3pBt7UTkJlQ/4WiRZYXTSaeFEJruIXnoN+tZ/KMMWTC3Ij+Qza8G1/gA
	h98V0dJRyI9rty7RJKGSzBsaG8EhPubNXNK3iqv72ioIILfcriweRlSNnMSdhWtGPYnZ66
	7qF4DwoqIXIxn8ty2UJX8G9AMyavkNI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-300-8ksgbZnRO-WlzUfowka3Ww-1; Mon,
 27 Oct 2025 23:10:07 -0400
X-MC-Unique: 8ksgbZnRO-WlzUfowka3Ww-1
X-Mimecast-MFC-AGG-ID: 8ksgbZnRO-WlzUfowka3Ww_1761621000
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E267919539BC;
	Tue, 28 Oct 2025 03:09:59 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.84])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC6F618002AD;
	Tue, 28 Oct 2025 03:09:47 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Joel Granados <joel.granados@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCHv2 2/2] kernel/kexec: Stop all userspace deadline tasks
Date: Tue, 28 Oct 2025 11:09:14 +0800
Message-ID: <20251028030914.9520-3-piliu@redhat.com>
In-Reply-To: <20251028030914.9520-1-piliu@redhat.com>
References: <20251028030914.9520-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Now that the deadline bandwidth check has been skipped, there is nothing
to prevent CPUs from being unplugged. But as deadline tasks are crowded
onto the remaining CPUs, they may starve normal tasks, especially the
hotplug kthreads. As a result, the kexec process will hang indefinitely.

Send SIGSTOP to all userspace deadline tasks at the beginning of kexec
to allow other tasks to run as CPUs are unplugged.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 kernel/kexec_core.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 265de9d1ff5f5..090bb58797d12 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1132,6 +1132,18 @@ bool kexec_load_permitted(int kexec_image_type)
 	return true;
 }
 
+static void stop_user_deadline_tasks(void)
+{
+	struct task_struct *task;
+
+	rcu_read_lock();
+	for_each_process(task) {
+		if (task->policy == SCHED_DEADLINE && task->mm)
+			send_sig(SIGSTOP, task, 1);
+	}
+	rcu_read_unlock();
+}
+
 /*
  * Move into place and start executing a preloaded standalone
  * executable.  If nothing was preloaded return an error.
@@ -1190,6 +1202,11 @@ int kernel_kexec(void)
 		cpu_hotplug_disable();
 		kexec_in_progress = true;
 		cpu_hotplug_enable();
+		/*
+		 * As CPU hot-removal, the crowed deadline task may starve other
+		 * tasks. So stop them.
+		 */
+		stop_user_deadline_tasks();
 		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
 		syscore_shutdown();
-- 
2.49.0


