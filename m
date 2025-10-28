Return-Path: <linux-kernel+bounces-872970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6665C12B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA47D5816EB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B87242D72;
	Tue, 28 Oct 2025 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aa2d5flj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35611238D54
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761620997; cv=none; b=A+iJzh0cj3YncUz8QZH4TegPuj3bMvnPeEt/ei23K+hSA5EIVxM+wjxIktVpeeQlh4r/6RBzW4TcBz7RpalvrJ0BcPPsMhsoZ0rUQxDmh0c6I7w6LSro2Kgdotru9E6EtGfumaElMlrfXMdlqkkRQNSKvOOjp9kNFQwEvT4ivsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761620997; c=relaxed/simple;
	bh=N+JrtmaXq5IabZVvDcXwEHfgJ3+FmtLPA0ykG5De14I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bhl2lGZ1U3cbsAO1+Y2+qbuyPEZEzzxoM7J2b1aMsWR+zvrBE6E3j+BtCZ2vdmkX6GzyjpnBWUwLw9iVQpMbDH5w8Rtdt+c/6teecRfMGanId3mDTNmMd4hA/U0+cAX/hENtEDXYJQrGbTnjxK4WhQ3zz4yzcjF4mGpQ6SjqNYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aa2d5flj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761620994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zb7uctCA+8DACYb+CzN2IamRFlY2/R42eag8ZUqBA0k=;
	b=aa2d5flj/PS84cpra7RzZY2aCB9yugoUSHEJcsSdRCyNmenNTNNZ1j61Zl3nCOAOC5FKsj
	qHXxVZ9QogA4I6UswA1IYXQTALMXFJDlMJUSZOfIJ5bIp5dKw7c4REJFNSnRBJLIJRj6Ol
	BBIjm6Ucfew1szEE0gZw4uC5DuJhOOc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-mhCbpsDbPXmrAnz5ukEPgQ-1; Mon,
 27 Oct 2025 23:09:49 -0400
X-MC-Unique: mhCbpsDbPXmrAnz5ukEPgQ-1
X-Mimecast-MFC-AGG-ID: mhCbpsDbPXmrAnz5ukEPgQ_1761620988
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0E66B196F754;
	Tue, 28 Oct 2025 03:09:47 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.84])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 504931800298;
	Tue, 28 Oct 2025 03:09:37 +0000 (UTC)
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
Subject: [PATCHv2 1/2] sched/deadline: Skip the deadline bandwidth check if kexec_in_progress
Date: Tue, 28 Oct 2025 11:09:13 +0800
Message-ID: <20251028030914.9520-2-piliu@redhat.com>
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

During discussion of the scheduler deadline bug [1], Pierre Gondois
pointed out a potential issue during kexec: as CPUs are unplugged, the
available DL bandwidth of the root domain gradually decreases. At some
point, insufficient bandwidth triggers an overflow detection, causing
CPU hot-removal to fail and kexec to hang [2].

This can be reproduced by:
  chrt -d -T 1000000 -P 1000000 0 yes > /dev/null &
  kexec -e

Meeting deadline bandwidth requirements is unnecessary during the kexec
process. Skip DL bandwidth validation to allow kexec to proceed smoothly.

[1]: https://lore.kernel.org/all/20250929133602.32462-1-piliu@redhat.com/
[2]: https://lore.kernel.org/all/3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com/

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
index 72c1f72463c75..9db6f26b6cc81 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -18,6 +18,7 @@
 
 #include <linux/cpuset.h>
 #include <linux/sched/clock.h>
+#include <linux/kexec.h>
 #include <uapi/linux/sched/types.h>
 #include "sched.h"
 #include "pelt.h"
@@ -3484,6 +3485,12 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 
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


