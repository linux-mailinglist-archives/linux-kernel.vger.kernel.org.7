Return-Path: <linux-kernel+bounces-864907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BCEBFBCF5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02575E4875
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51899340D87;
	Wed, 22 Oct 2025 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxSWkvk0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3FB28B7D7
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135280; cv=none; b=K/3apTdHgQvQtMdNfhotgWtFgmy/RdLOkQsTGoiC0/xtTETjmq1Tgts+SR0uylnGxy2vyvaiiQUn2KjdjSke5M7M57Ort55r/f5tvvRuQbvvIWULTaIZ/XfkodhJ+g50yCg+B1/mUniqOtAuLHX/U9+Fovb7bMKiPQzbVay4O+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135280; c=relaxed/simple;
	bh=x2as0rITwGwnqzpM+DDHJ134ScOAHVCmgUim9nHInaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gFhVzP4ysng2OvnIlwm27Gauu0HxA7sKPT4jscfDUCewvbCDF6JgqgcKS68kOgbmPhV7O9vdJtnUia4HYl4cW175qddGVrt9Jzyd/zsoz+oIINAaJiIIWnZ2wDAQMyGOcQ3+05OwKkRfiBIMUUvqajl4BZweAwr7vindLUXA0jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IxSWkvk0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761135278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luI49aJWaaO/LQ54EBxZk4WAfdvW9kwQCGC0aaaZi3A=;
	b=IxSWkvk080KgZH4krs3uihAUuvIyLk+puduNc3/ZIVhV5sun/u+/1zCQUgYoN8UmcsFPdL
	SY0ENvvWk0fujE0hfKsZg8v4dPUxHEDp6aQc8Qwa9e7jidahiD8a8NwQObimVu9i3JsHkk
	m2UmjEv1fb32rh6obX2p54jFUleBgHk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-FQa_G7grMAKwqXKMAP421Q-1; Wed,
 22 Oct 2025 08:14:34 -0400
X-MC-Unique: FQa_G7grMAKwqXKMAP421Q-1
X-Mimecast-MFC-AGG-ID: FQa_G7grMAKwqXKMAP421Q_1761135272
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C01019539AB;
	Wed, 22 Oct 2025 12:14:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C2FEA180035A;
	Wed, 22 Oct 2025 12:14:20 +0000 (UTC)
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
Subject: [RFC 2/3] kernel/cpu: Mark nonboot cpus as inactive when shutting down nonboot cpus
Date: Wed, 22 Oct 2025 20:13:44 +0800
Message-ID: <20251022121345.23496-3-piliu@redhat.com>
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
process, which raises a potential issue: as the number of online CPUs
decreases, DL tasks may be crowded onto a few CPUs, which may starve the
CPU hotplug kthread. As a result, the hot-removal cannot proceed in
practice.  On the other hand, as CPUs are offlined one by one, all tasks
will eventually be migrated to the kexec CPU.

Therefore, this patch marks all other CPUs as inactive to signal the
scheduler to migrate tasks to the kexec CPU during hot-removal.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 kernel/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index db9f6c539b28c..76aa0f784602b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1546,6 +1546,16 @@ void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
 	if (!cpu_online(primary_cpu))
 		primary_cpu = cpumask_first(cpu_online_mask);
 
+	/*
+	 * Mark all other CPUs as inactive so the scheduler won't select them as
+	 * migration targets.
+	 */
+	for_each_online_cpu(cpu) {
+		if (cpu == primary_cpu)
+			continue;
+		set_cpu_active(cpu, false);
+	}
+
 	for_each_online_cpu(cpu) {
 		if (cpu == primary_cpu)
 			continue;
-- 
2.49.0


