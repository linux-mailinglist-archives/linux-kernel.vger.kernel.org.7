Return-Path: <linux-kernel+bounces-749825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A831B1534B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 918E1548319
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6720124DD13;
	Tue, 29 Jul 2025 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BE1XWnnN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E02459F6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753816367; cv=none; b=KVJ9KVCgNdtf8jN2GXL5STmbBDwhUy2xSmPEZr8FcjY0mTWV2QoWvtmevPgE+tV8XUCoGyPtWpfpv+EQ5yEDGYFIu7Pcrdv7LBxyEcNKxAtJlMl/FcjDrZoaaT4jRvSUXm8eKZyP+gV1H8rvW/ULLV9j1yCOiLUSoO1uba/6tus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753816367; c=relaxed/simple;
	bh=nWkyEoWD+O65DryR7okkAH8RyZiQFLpO7VvrA6VDbwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QltBXOTJZ2HBgQh6FfuvQz5b75cPR+CbH0XrAodjgAq1SQArMLaBkm6EzPjmj24mDTLqoEFqz6Zlg1/hFta9VhHNDAZAl0wSem5l/6jiVaX62nSlScnklkdMhoYSrhSzOGyDtNmKJJ5D1BByu68G/7G97lZTwO/i8EqgF/c9Pdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BE1XWnnN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753816364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=19MkkSvnHFzhz62Bahyu/jI4NnaLyRThc1mJfHz8ZyM=;
	b=BE1XWnnNFzMgjZ6XRzJeqROqkTp9BpygvjleLqp0+le4DeD1735B/Iv7YTfZDX7ZrL5Kxk
	RORzjv2/O6CAMZEDLwKZNN3w0EhTMrjfSdhUb+VBto/9EvIAMBVtzjhbPlJpPfrO/CoLxA
	/Ci3+sPDnLrjceSATgizA9uxwe3CMpY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-ufQHmRjPMzuHW5ZQYlwb2g-1; Tue,
 29 Jul 2025 15:12:41 -0400
X-MC-Unique: ufQHmRjPMzuHW5ZQYlwb2g-1
X-Mimecast-MFC-AGG-ID: ufQHmRjPMzuHW5ZQYlwb2g_1753816360
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F5E21800165;
	Tue, 29 Jul 2025 19:12:40 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B005719560A2;
	Tue, 29 Jul 2025 19:12:38 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cpu: Remove obsolete comment from takedown_cpu()
Date: Tue, 29 Jul 2025 15:12:32 -0400
Message-ID: <20250729191232.664931-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

takedown_cpu() has a comment about "all preempt/rcu users must observe
!cpu_active()" which is kind of meaningless in this function. This
comment was originally introduced by commit 6acce3ef8452 ("sched: Remove
get_online_cpus() usage") when _cpu_down() was setting cpu_active_mask
and synchronize_rcu()/synchronize_sched() were added after that.

Later commit 40190a78f85f ("sched/hotplug: Convert cpu_[in]active
notifiers to state machine") added a new CPUHP_AP_ACTIVE hotplug
state to set/clear cpu_active_mask. The following commit b2454caa8977
("sched/hotplug: Move sync_rcu to be with set_cpu_active(false)")
move the synchronize_*() calls to sched_cpu_deactivate() associated
with the new hotplug state, but left the comment behind.

Remove this comment as it is no longer relevant in takedown_cpu().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index a59e009e0be4..2addcba38c1a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1308,9 +1308,6 @@ static int takedown_cpu(unsigned int cpu)
 	 */
 	irq_lock_sparse();
 
-	/*
-	 * So now all preempt/rcu users must observe !cpu_active().
-	 */
 	err = stop_machine_cpuslocked(take_cpu_down, NULL, cpumask_of(cpu));
 	if (err) {
 		/* CPU refused to die */
-- 
2.50.0


