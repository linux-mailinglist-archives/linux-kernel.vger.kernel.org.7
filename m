Return-Path: <linux-kernel+bounces-864906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E05BFBCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0F81A04BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297434167A;
	Wed, 22 Oct 2025 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTbpQ1dt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107DE3431F0
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135268; cv=none; b=EHTYRWs+AOkkS61afXLpu5DC/R2b+67SmXkq/mP0D4hnqTWdaufUtGWCZ8YoRgeVga9wIJtVp415Q6bKuNn77lcHWRVrWFkhBUvBQrQqtVWAH3FKmNJUWujhrWHf5zI3xvVCAz/uxCjqLmyM/WMtaFHDDlA/djdnOWjvavQohjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135268; c=relaxed/simple;
	bh=QrL7OONpmTtsZljTHd0Qyo5LOvQrGKEBSY3RO5pbFfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+rEvT45sIhi3+BGtm2PRsc8CpopcNytecilUZI2QUAhh240yTRRwhoJNkhQ6vYju96bEm+RkHmVwm4YRsf4N/+jS1kCwdmYSi6sUSZYhuUw3HBY7aXfFTL/OudM6dbg/lk8knJ01wDl2UgRocTx0TFzsH/yyW9V/W2tkqMUE9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTbpQ1dt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761135266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efuKFpXatQa3caS7HeNgDN4jbZUJUL46OQhq/PHK3n4=;
	b=OTbpQ1dtmXEkzjGqj6nudJqZt09aGnOdw9vApPnAOKscazEeWg3/pdR1MGx57gAfqO4bWC
	r5V/oR9JGOzGFb8ehhfYVl+8RGBqXEzo6vLPuuZKke+gD8qC8DmcH/zwpqgeb4gvJ2P1vc
	07/ivkAT2GLwywjB82+mQ04ep2J67hw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-VE1wR571MBqjaxw4FgCZSw-1; Wed,
 22 Oct 2025 08:14:22 -0400
X-MC-Unique: VE1wR571MBqjaxw4FgCZSw-1
X-Mimecast-MFC-AGG-ID: VE1wR571MBqjaxw4FgCZSw_1761135261
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 743361956094;
	Wed, 22 Oct 2025 12:14:20 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A1F3D180035A;
	Wed, 22 Oct 2025 12:14:09 +0000 (UTC)
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
Subject: [RFC 1/3] sched/deadline: Skip the deadline bandwidth check if kexec_in_progress
Date: Wed, 22 Oct 2025 20:13:43 +0800
Message-ID: <20251022121345.23496-2-piliu@redhat.com>
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

During discussion of the scheduler deadline bug [1], Pierre Gondois
pointed out a potential issue during kexec: as CPUs are unplugged, the
available DL bandwidth of the root domain gradually decreases. At some
point, insufficient bandwidth triggers an overflow detection, causing
CPU hot-removal to fail and kexec to hang.

This can be reproduced by:
  chrt -d -T 1000000 -P 1000000 0 yes > /dev/null &
  kexec -e

This patch skips the DL bandwidth check if kexec is in progress.

[1]: https://lore.kernel.org/all/20250929133602.32462-1-piliu@redhat.com/

Reported-by: Pierre Gondois <pierre.gondois@arm.com>
Closes: https://lore.kernel.org/all/3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com/
Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Joel Granados <joel.granados@kernel.org>
To: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 kernel/kexec_core.c     | 6 ++++++
 kernel/sched/deadline.c | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 31203f0bacafa..265de9d1ff5f5 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1183,7 +1183,13 @@ int kernel_kexec(void)
 	} else
 #endif
 	{
+		/*
+		 * CPU hot-removal path refers to kexec_in_progress, it
+		 * requires a sync to ensure no in-flight hot-removing.
+		 */
+		cpu_hotplug_disable();
 		kexec_in_progress = true;
+		cpu_hotplug_enable();
 		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
 		syscore_shutdown();
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index a3a43baf4314e..cc864cc348b2c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -18,6 +18,7 @@
 
 #include <linux/cpuset.h>
 #include <linux/sched/clock.h>
+#include <linux/kexec.h>
 #include <uapi/linux/sched/types.h>
 #include "sched.h"
 #include "pelt.h"
@@ -3502,6 +3503,12 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 
 int dl_bw_deactivate(int cpu)
 {
+	/*
+	 * The system is shutting down and cannot roll back.  There is no point
+	 * in keeping track of bandwidth, which may fail hotplug.
+	 */
+	if (unlikely(kexec_in_progress))
+		return 0;
 	return dl_bw_manage(dl_bw_req_deactivate, cpu, 0);
 }
 
-- 
2.49.0


