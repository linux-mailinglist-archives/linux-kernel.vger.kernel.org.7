Return-Path: <linux-kernel+bounces-786508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C96DB35ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC79C1B6651B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55C129B8D3;
	Tue, 26 Aug 2025 11:08:51 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC261CD208
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206531; cv=none; b=tt0c1vASXmwkn8iGF3sVtq7oeHeZb/RPhzW1eYkwg6E51l1YWD2ZD0pdSzZkda8Tf01rPNL9RGMfgJbwOKKe+r1P7xhmav3f7ehKop3yUIxe8og8QMcJ/kC+6/I4mU/4O9v9ZFR4Orma55xTkJXtYGdNdeiIwMGHKX23vLZ/DDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206531; c=relaxed/simple;
	bh=puR3Q5FpsCoJW0ydNv1g/XPxcTcRZxqkXQRdgqRnf5g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cneQHThAcJF9FNRN0W1OacuETrAqUPE8BOYVKnJrmzc2wqxayTqBhSts05qFp7SaawPN1OIlNpSlN+0mJk9D7ESI6HzmYzFGEoo57SjgC2GnTmkhzhfMKGPsVd3Zz8AY8mLS4fY5CCq2KsbN09yNYMB8DOd3+f+PjNdvRjTzqrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 06474464826d11f0b29709d653e92f7d-20250826
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ea2c325f-8204-4467-ac90-7ccd97c4b1ac,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:263e34cb3ead996cb463b486a99cd807,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 06474464826d11f0b29709d653e92f7d-20250826
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <cuiguoqi@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 26262188; Tue, 26 Aug 2025 19:08:41 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 7234EE008FAB;
	Tue, 26 Aug 2025 19:08:41 +0800 (CST)
X-ns-mid: postfix-68AD95B9-303499565
Received: from localhost.localdomain (unknown [10.41.103.97])
	by mail.kylinos.cn (NSMail) with ESMTPA id 85003E008FAA;
	Tue, 26 Aug 2025 19:08:37 +0800 (CST)
From: cuiguoqi <cuiguoqi@kylinos.cn>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	guoqi0226@163.com,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	cuiguoqi <cuiguoqi@kylinos.cn>
Subject: [PATCH] sched: Fix race in rt_mutex_pre_schedule by removing non-atomic fetch_and_set
Date: Tue, 26 Aug 2025 19:08:33 +0800
Message-Id: <20250826110833.3274209-1-cuiguoqi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

During Wound/Wait testing on PREEMPT_RT, a WARNING was hit:

  WARNING: CPU: 0 PID: 0 at kernel/sched/core.c:7085 rt_mutex_pre_schedul=
e+0xa8/0x108
  Call trace:
   rt_mutex_pre_schedule+0xa8/0x108
   __ww_rt_mutex_lock+0x1d4/0x300
   ww_mutex_lock+0x1c/0x30

The issue stems from the non-atomic `fetch_and_set` macro:
    #define fetch_and_set(x, v) ({ int _x =3D (x); (x) =3D (v); _x; })

It lacks atomicity and memory ordering, leading to race conditions under
preemption or interrupts, where `current->sched_rt_mutex` may be corrupte=
d.

Since this flag is only used for lockdep assertions and accessed per-task=
,
replace the unsafe macro with direct assignment and explicit state checks=
:

- In rt_mutex_pre_schedule(): assert is 0 before setting to 1.
- In rt_mutex_post_schedule(): assert is 1 before clearing to 0.

This fixes the false-positive warning without needing atomic operations.

Signed-off-by: cuiguoqi <cuiguoqi@kylinos.cn>
---
 kernel/sched/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e89a6eeadba..fb4c446e46f7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7078,11 +7078,11 @@ const struct sched_class *__setscheduler_class(st=
ruct task_struct *p, int prio)
  * name such that if someone were to implement this function we get to c=
ompare
  * notes.
  */
-#define fetch_and_set(x, v) ({ int _x =3D (x); (x) =3D (v); _x; })
=20
 void rt_mutex_pre_schedule(void)
 {
-	lockdep_assert(!fetch_and_set(current->sched_rt_mutex, 1));
+	lockdep_assert(!current->sched_rt_mutex);
+	current->sched_rt_mutex =3D 1;
 	sched_submit_work(current);
 }
=20
@@ -7095,7 +7095,9 @@ void rt_mutex_schedule(void)
 void rt_mutex_post_schedule(void)
 {
 	sched_update_worker(current);
-	lockdep_assert(fetch_and_set(current->sched_rt_mutex, 0));
+	lockdep_assert(current->sched_rt_mutex);
+	current->sched_rt_mutex =3D 0;
+
 }
=20
 /*
--=20
2.25.1


