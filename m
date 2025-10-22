Return-Path: <linux-kernel+bounces-864904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C562ABFBCF1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4F25E35C3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634F233891A;
	Wed, 22 Oct 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i10mBIiG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298213126BA
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135258; cv=none; b=keq5p8ejFPRkiA3UnoxIfgkfsO4xcSeGzSHwYfLxISmYYgsp+2ceDRsm/y6FMOrJEj4KemRIpbu1/Cf5XdCW3NtcK+u5A5vs8lD6jDUTU9IM6WGLYDl/6CrRqgmlaCpd/xNL+9RM1Ku6ADmxQJ5DOaFlJ+o6NpeWbI6uxF1NFB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135258; c=relaxed/simple;
	bh=M6Cy9bildkiWGq5rkoZlfcH2qUgUqsO6yUFEZGd5SWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sKK3vQCvtYZOlp3WmO4qP7ShmVdknA4dwPWrtLw0aWqM/mLGsiDoHFhiFRRxCeNBsrXfj/l/kZnY7lR4ZxrU6MtcuVsK+yJS1oMMGNQtnFpIrL1NQOGwruFnvWfuaREGGVpq7NlTby4QMsn2qa/TvhoAY4y4aTyyTrWKtaVmAu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i10mBIiG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761135255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zvReUmFuOQX/SJC9oEYeW8Gu66yrEnKENSYxIaDF4ho=;
	b=i10mBIiGXcWlWI55vWbM+7AvLAzHzXweP2ecmrmzPsFcLcVl7hdMhrlHYw8k+wZonNwwSw
	YX6hpxwY2z+IWXmjSoSV7kW+LjiHCtw+jzUBS61XMPu9XJPJxu7G7KoAc00zqemlR3YFDp
	fQvN5JjCwD5oVpDcoG7ie9CIMgBSeic=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-2ZqrSGLPNYaIcltsT0sPlA-1; Wed,
 22 Oct 2025 08:14:12 -0400
X-MC-Unique: 2ZqrSGLPNYaIcltsT0sPlA-1
X-Mimecast-MFC-AGG-ID: 2ZqrSGLPNYaIcltsT0sPlA_1761135250
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E79F11800345;
	Wed, 22 Oct 2025 12:14:08 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DD324180057E;
	Wed, 22 Oct 2025 12:13:59 +0000 (UTC)
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
Subject: [RFC 0/3] kexec: Force kexec to proceed under heavy deadline load
Date: Wed, 22 Oct 2025 20:13:42 +0800
Message-ID: <20251022121345.23496-1-piliu@redhat.com>
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
CPU hot-removal to fail and kexec to hang.[2]
    
I reproduced it on a system with 160 cpus with the following command
  seq 10 | xargs -I{} -P10 sh -c 'chrt -d -T 1000000 -P 1000000 0 yes > /dev/null &'
  kexec -e

The system hang during the kexec process.
 
This series skips the DL bandwidth check, migrates the task from dying
CPU directly to the kexec CPU, and promotes the kexec to DL task. By
this way, the heavy deadline load will not starve the CPU hot-removal
kthread so that kexec task can move on.

In contrast to this series, an alternative aggressive approach is to
send SIGKILL to all DL tasks at the beginning of the kexec process.
Let us discuss how to resolve this issue.


[1]: https://lore.kernel.org/all/20250929133602.32462-1-piliu@redhat.com/
[2]: https://lore.kernel.org/all/3408aca5-e6c9-434a-9950-82e9147fcbba@arm.com/

Pingfan Liu (3):
  sched/deadline: Skip the deadline bandwidth check if kexec_in_progress
  kernel/cpu: Mark nonboot cpus as inactive when shutting down nonboot
    cpus
  kexec_core: Promote the kexec to DL task

 kernel/cpu.c            | 10 ++++++++++
 kernel/kexec_core.c     | 28 ++++++++++++++++++++++++++++
 kernel/sched/deadline.c |  7 +++++++
 3 files changed, 45 insertions(+)

-- 
2.49.0


