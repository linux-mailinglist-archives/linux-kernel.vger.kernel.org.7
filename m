Return-Path: <linux-kernel+bounces-869394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1512C07C63
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CFF13AF07B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD3934886E;
	Fri, 24 Oct 2025 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvTbg3Jj"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3243101CD
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330963; cv=none; b=X/dLt3wGIKU8VCGtQAM8iSPdJUFcDbRtfon7Gs9msY51Y8QfgpkeOIKh+CYaX2l1mqJ4uB9v2zfoOF0UXx/eoxAl562/4Rqx7q3CHxovAKI0X0/Y1b87HcsVDwYFVxQ81C/s7sc0N+Bo9h1nvj8478M7notMUzlgf7/o/XyOFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330963; c=relaxed/simple;
	bh=e082r4kTfLA0aLgFTCWcX+NL5EgNNmKTh51Ro59hkR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tO8KtbQ9EWhmnFlzMm4aFzgKMpE62LbbmLXLwsmMbGVowJu7TOhjEkVod45bwWhP991c2thfxunqLcX58jeMVUrH6qnu74iP4LdIJmNpwEY7BFaeYgrfjnjJqODioblTArQd+IS7cLVSLk4djUZcaGXfJJW96BBvJxTf25oVvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvTbg3Jj; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d3540a43fso24828085ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761330961; x=1761935761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw14jVuf7BqeO+cDKjQTg5GGuEVAt7PwD+gUI7IAUIA=;
        b=ZvTbg3JjuXHrseS7A8JtFy+f2+lGP0o/jbK1hsn7H3Vf0ZOAwgYTV3+mx7I76ML8oX
         rZ2WtcTq59dOKyW7+DVn9+AX/smhr/6Vh1fIW+6PM3wusl/FONZLXBDr3Wqg8k8mTfHZ
         SSdZk6Ac0CbUKiRST6geJikFcMwUvJqpyLqIcgvYEageuF2Fceffqo5qon+YVEYm0aCz
         1p1BEAeNJ82LbbiP8QFOeZJs01IQg3qWMQNo7O8Hmv+YfGDhBYFviy92Fc6YyUVKSRy+
         oXEHJAmpzKB6rdydirZYH4H35CbvxcgLglzjjMc+xVFrKI84s2TZwb6gTChQD25ECUG/
         aVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761330961; x=1761935761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xw14jVuf7BqeO+cDKjQTg5GGuEVAt7PwD+gUI7IAUIA=;
        b=BP8cBZIsuv0b9Rw5nsOhKmeNXPDuA2W1AIxOxWnCbu4SJKuNjA0nX89EyYlfz2EOV/
         oXSgUXOv2tyWP8LsSYhfs1GZa7Xd40HtCIE3VCLJkezXTE3+CilSu/OWc15TjARCorOA
         navtXA15MW9bYYrbtVLDDUxXTstpqqXVnkk9FXrmgWfzX+FBqVnt4K4G3NVVame2CG/n
         cNoQ+z7ot3B2a5egYeYdmHvc65m/B1ZOwFMKAZTBPd9hWLkn2ARYoq9Eomr4WOZud04e
         eH5RYJsi69GVnDOwTnEJXa/ZqiklMofezzWvUxDdTLPoAflwQNNIzi/WCdUZKGLYlB7k
         ATNw==
X-Forwarded-Encrypted: i=1; AJvYcCVeAjovuf5CLyKWrrsX8/oigQ/plQI94oLu5yTUTH1SicTpTVKcgdkG4W3J/m93LjwP/KshfejjYI4gZ3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2HxOEnYf+Tptr00D8BBr8QaApVzTglvQm7ZZpbtdkbUpzDmDL
	98XZP9+Z7tQucgSg7prAvhrEH0s65yKIq7390xmCS9sQCJnEeBNXk7+Q
X-Gm-Gg: ASbGncvAMZYGvR83PIQH9grd33cxHxSWx44COWwlkKE52V4iVhKwijgEmD7Qcb0x4Hl
	CI7oGD8fvUC8AmUzrxGbj7Jp04dX8YqZR0OelWYE/9teMbP9pbqx9Qq73auJ0KuvF9KEYIf41sz
	aHXykUV8JV2iuF2ZMudx1sGhPqY0Fp53ZQpw5j9hGYsiB/GyKJpPVp06Woekl+lxFKHAXK6+kvU
	/xdarj0usaegZCLAhbwT4JAhJzvb8yLqoNNibzlTnxLicS4Zp0+tAaBINO8Fy//fLA0FcBUFpmW
	CQLbq5NzElVH6Sd5KqX1JK4/97bcEbk/LCGtW4FVEpqAFZmOUOORii4ojPT/wO20E/VRUBGvcb6
	hLvybpVb41uJWPmb8Wv+mMI7/H9xMQ0EnqqVYLawlc7pPcUYUGUNO1HX9x4xCmU46TmW/nkM9wb
	jAmCKm0p9pcMY/ReE4Q62ljGTg4D3pU6Q=
X-Google-Smtp-Source: AGHT+IHx41IImbCDHn2Jdh7zMNuF3nPpqYLXXAVHuVL/C8w986MehdGPWmZ5hrXWnJ9gl1uAvj5v1w==
X-Received: by 2002:a17:903:18c:b0:294:66ad:113e with SMTP id d9443c01a7336-29466ad11e3mr111410385ad.47.1761330960942;
        Fri, 24 Oct 2025 11:36:00 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e2579e2sm62725945ad.111.2025.10.24.11.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:36:00 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	riel@surriel.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	segher@kernel.crashing.org,
	ryan.roberts@arm.com,
	max.kellermann@ionos.com,
	urezki@gmail.com,
	nysal@linux.ibm.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 2/3] Provide and use an always inline version of finish_task_switch
Date: Sat, 25 Oct 2025 02:35:40 +0800
Message-ID: <20251024183541.68955-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024182628.68921-1-qq570070308@gmail.com>
References: <20251024182628.68921-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

finish_task_switch is called during context switching,
inlining it can bring some performance benefits.

Add an always inline version `finish_task_switch_ainline` to be called
during context switching, and keep the original version for being called
elsewhere, so as to take into account the size impact.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
---
 kernel/sched/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1842285eac1e..6cb3f57c4d35 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5069,21 +5069,21 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
  * Note that we may have delayed dropping an mm in context_switch(). If
  * so, we finish that here outside of the runqueue lock. (Doing it
  * with the lock held can cause deadlocks; see schedule() for
  * details.)
  *
  * The context switch have flipped the stack from under us and restored the
  * local variables which were saved when this task called schedule() in the
  * past. 'prev == current' is still correct but we need to recalculate this_rq
  * because prev may have moved to another CPU.
  */
-static struct rq *finish_task_switch(struct task_struct *prev)
+static __always_inline struct rq *finish_task_switch_ainline(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
 	struct mm_struct *mm = rq->prev_mm;
 	unsigned int prev_state;
 
 	/*
 	 * The previous task will have left us with a preempt_count of 2
 	 * because it left us after:
 	 *
@@ -5153,20 +5153,25 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 
 		/* Task is done with its stack. */
 		put_task_stack(prev);
 
 		put_task_struct_rcu_user(prev);
 	}
 
 	return rq;
 }
 
+static struct rq *finish_task_switch(struct task_struct *prev)
+{
+	return finish_task_switch_ainline(prev);
+}
+
 /**
  * schedule_tail - first thing a freshly forked thread must call.
  * @prev: the thread we just switched away from.
  */
 asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	/*
 	 * New tasks start with FORK_PREEMPT_COUNT, see there and
 	 * finish_task_switch() for details.
@@ -5247,21 +5252,21 @@ context_switch(struct rq *rq, struct task_struct *prev,
 
 	/* switch_mm_cid() requires the memory barriers above. */
 	switch_mm_cid(rq, prev, next);
 
 	prepare_lock_switch(rq, next, rf);
 
 	/* Here we just switch the register state and the stack. */
 	switch_to(prev, next, prev);
 	barrier();
 
-	return finish_task_switch(prev);
+	return finish_task_switch_ainline(prev);
 }
 
 /*
  * nr_running and nr_context_switches:
  *
  * externally visible scheduler statistics: current number of runnable
  * threads, total number of context switches performed since bootup.
  */
 unsigned int nr_running(void)
 {
-- 
2.51.0


