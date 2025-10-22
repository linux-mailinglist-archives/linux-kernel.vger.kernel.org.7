Return-Path: <linux-kernel+bounces-864908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E80DBFBCDF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A6CB1356EC1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5E633891A;
	Wed, 22 Oct 2025 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Emir2s6k"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916B34167A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135290; cv=none; b=gH23nGH1DbENqTcUvoh6YProidLp/n2032SWMDK59O58AwG3/3hENuYbk7yRV/4rDdZBFQc9s1Edsjq6et2wPQzVRjIQq2HwoLuS7aafaOuz4GfMzjU3+GSQY6tYPk7GxnxqKl8O24lceBHxDsrCECBr8WmBiIgBwJj/ucYwrIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135290; c=relaxed/simple;
	bh=pfS8U/j5Ny1hiXcolE4aHLqnuv2ch3BXbnGcgM7t6B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CR1s9WhjEVwYyhMPHxRE4FbKFNs42WCc6Px0nL+XVP08X5AIREHASBb6hHpK52EiU0Po2YJo9HJOVULoQvfMSXF//fyS7qnvq8UppYLQEgIDEsVXWxIT1jvp0mGSZ0sn3xThjSAKleNk6eAl9wId+eOLxQz9Gn8cRXDKAwiw4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Emir2s6k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761135287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ekimc72PCbpOA1x/tlS6SXdLF6ETf9qbbL3151vpaxg=;
	b=Emir2s6kDBNWk0o1OQ4izoaKLvicEhr8kWN7vsLTQIbJ30mHznN/67fruNTjdk8NrRxUUQ
	FtSqz+3LniPkklxS9sswEWzdbZXfpG5/GscK+nVxVNcJVGLOME5Uf7ug3ccxkdB3XtXuKp
	adVT78Na9CiY+rQ+MsDjDPVE285R840=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-d2iakW3GOnuSp_JrGPkW3A-1; Wed,
 22 Oct 2025 08:14:44 -0400
X-MC-Unique: d2iakW3GOnuSp_JrGPkW3A-1
X-Mimecast-MFC-AGG-ID: d2iakW3GOnuSp_JrGPkW3A_1761135282
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7125D1956089;
	Wed, 22 Oct 2025 12:14:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5BF521800590;
	Wed, 22 Oct 2025 12:14:31 +0000 (UTC)
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
	Joel Granados <joel.granados@kernel.org>
Subject: [RFC 3/3] kexec_core: Promote the kexec to DL task
Date: Wed, 22 Oct 2025 20:13:45 +0800
Message-ID: <20251022121345.23496-4-piliu@redhat.com>
In-Reply-To: <20251022121345.23496-1-piliu@redhat.com>
References: <20251022121345.23496-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The previous patch lifted the deadline bandwidth check during the kexec
process. As a result, DL tasks may be crowded onto the kexec CPU, which
may starve the kexec task. At this point, the kexec task is the only
task needed to make the reboot proceed, hence promoting it to a deadline
task prevents this starvation.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
To: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 kernel/kexec_core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 265de9d1ff5f5..0960bea1a8bab 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -41,6 +41,7 @@
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
 #include <linux/dma-map-ops.h>
+#include <uapi/linux/sched/types.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1183,6 +1184,20 @@ int kernel_kexec(void)
 	} else
 #endif
 	{
+		struct sched_attr attr = {
+			.size		= sizeof(struct sched_attr),
+			.sched_policy	= SCHED_DEADLINE,
+			.sched_nice	= 0,
+			.sched_priority	= 0,
+			/*
+			 * Fake (unused) bandwidth; workaround to "fix"
+			 * priority inheritance.
+			 */
+			.sched_runtime	= NSEC_PER_MSEC,
+			.sched_deadline = 10 * NSEC_PER_MSEC,
+			.sched_period	= 10 * NSEC_PER_MSEC,
+		};
+
 		/*
 		 * CPU hot-removal path refers to kexec_in_progress, it
 		 * requires a sync to ensure no in-flight hot-removing.
@@ -1202,6 +1217,13 @@ int kernel_kexec(void)
 		 */
 		cpu_hotplug_enable();
 		pr_notice("Starting new kernel\n");
+		/*
+		 * During hot-removing cpu, all DL tasks will be migrated to
+		 * this cpu.  To prevent this task from starving, promoting it
+		 * to DL task. And soon, local interrupt will be disabled in
+		 * machine_kexec().
+		 */
+		sched_setattr_nocheck(current, &attr);
 		machine_shutdown();
 	}
 
-- 
2.49.0


