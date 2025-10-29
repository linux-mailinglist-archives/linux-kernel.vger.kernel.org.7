Return-Path: <linux-kernel+bounces-876902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90431C1CB06
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEF844E1E84
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA12E7BA2;
	Wed, 29 Oct 2025 18:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="De52S7tY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8D92F83A7
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761195; cv=none; b=ij5FszUsqQRSNB+mVv9T0zmLDoN+Ft8UILEaDIAhLN2CxCzEGEAJe44rrkFrWmU1EGl3+YiI9mcLKFgeKJN+xmE+fDDgjSZSqOMTJYrvLejRLqrvlbZBRpvMnf7NTKaOkRISf/LhRsFGC6YvW3Ac+SdcQdyzxgmFyIcuT1smKCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761195; c=relaxed/simple;
	bh=jAwR0FEppp70EDS/Twsw9Vf9H35YJ1O5nYY1Nk8dhxg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F92BWoyUXwlQy7MMHiv2V3pKE9SxR+TfhoZKQ00X2ASw9hLuIykcxCe0AIMnkC4sBOx/UX0ZlWA5aunlEtj3mAep7WC1M0BkPKDbvf+g0ILJPcGKCE4G581f8Ao5B89dgWdsAX0YQu6so3OuhdjF/azSuZmeQ4pB/IeqCXGnFIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=De52S7tY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761761192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wumwQhKDr4iir+pQkfkb9IFCpsaAZD5YzM/xo1tfMww=;
	b=De52S7tYmgZb9O+MX31d2ly6Auji0yZpOXEB9f3JilyUfpuRGyRmSsml5IWDbEdBtKkHeT
	TgWpx5DQ0+5jAiSmH1CgZ+lfpPQlvDJYuZ5SY/GJ0B5ryBpjQpyzFNnaCptBIVA11S/i/Z
	egQwU9nI2mI+BFVYs505kIbFmUjKGIs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-ykqEynArOoiIBZUT7czK4w-1; Wed,
 29 Oct 2025 14:06:27 -0400
X-MC-Unique: ykqEynArOoiIBZUT7czK4w-1
X-Mimecast-MFC-AGG-ID: ykqEynArOoiIBZUT7czK4w_1761761186
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4DAC19560BE;
	Wed, 29 Oct 2025 18:06:26 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.6])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78CCE19540E9;
	Wed, 29 Oct 2025 18:06:26 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id AAAE6400E5DC8; Wed, 29 Oct 2025 15:00:56 -0300 (-03)
Date: Wed, 29 Oct 2025 15:00:56 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] sched/idle: disable tick in idle=poll idle entry
Message-ID: <aQJWWIDMMUxqDxnR@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


Commit a5183862e76fdc25f36b39c2489b816a5c66e2e5 
("tick/nohz: Conditionally restart tick on idle exit") allows
a nohz_full CPU to enter idle and return from it with the 
scheduler tick disabled (since the tick might be undesired noise).

The idle=poll case still unconditionally restarts the tick when entering
idle.

To reduce the noise for that case as well, stop the tick when entering
idle, for the idle=poll case.

Change tick_nohz_full_kick_cpu to set NEED_RESCHED bit, to handle the
case where a new timer is added from an interrupt. This breaks out of
cpu_idle_poll and rearms the timer if necessary.

---

v2: Handle the case where a new timer is added from an interrupt (Frederic Weisbecker)

 include/linux/sched.h    |    2 ++
 kernel/sched/core.c      |   10 ++++++++++
 kernel/sched/idle.c      |    2 +-
 kernel/time/tick-sched.c |    1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index cbb7340c5866..1f6938dc20cd 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2428,4 +2428,6 @@ extern void migrate_enable(void);
 
 DEFINE_LOCK_GUARD_0(migrate, migrate_disable(), migrate_enable())
 
+void set_tif_resched_if_polling(int cpu);
+
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f1ebf67b48e2..f0b84600084b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -988,6 +988,11 @@ static bool set_nr_if_polling(struct task_struct *p)
 	return true;
 }
 
+void set_tif_resched_if_polling(int cpu)
+{
+	set_nr_if_polling(cpu_rq(cpu)->idle);
+}
+
 #else
 static inline bool set_nr_and_not_polling(struct thread_info *ti, int tif)
 {
@@ -999,6 +1004,11 @@ static inline bool set_nr_if_polling(struct task_struct *p)
 {
 	return false;
 }
+
+void set_tif_resched_if_polling(int cpu)
+{
+	set_tsk_need_resched(cpu_rq(cpu)->idle);
+}
 #endif
 
 static bool __wake_q_add(struct wake_q_head *head, struct task_struct *task)
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c39b089d4f09..428c2d1cbd1b 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -324,7 +324,7 @@ static void do_idle(void)
 		 * idle as we know that the IPI is going to arrive right away.
 		 */
 		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
-			tick_nohz_idle_restart_tick();
+			tick_nohz_idle_stop_tick();
 			cpu_idle_poll();
 		} else {
 			cpuidle_idle_call();
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c527b421c865..efc3653999dc 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -408,6 +408,7 @@ void tick_nohz_full_kick_cpu(int cpu)
 	if (!tick_nohz_full_cpu(cpu))
 		return;
 
+	set_tif_resched_if_polling(cpu);
 	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
 }
 


