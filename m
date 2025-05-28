Return-Path: <linux-kernel+bounces-665076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1244BAC6403
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 10:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315F1188C78A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 08:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357042749EA;
	Wed, 28 May 2025 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7aVYc1S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968FF2749C8
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419915; cv=none; b=R8LQcYN9XRBs75yYvtBwKz830KToArEjOcc3UwwJhkuy+7skM6CinC5jX3SIpmHc5OSO29SUjddXzTpLXRKK96U01ks83+RALMCPB4J2fC6ZEm37xcO1rXYOHRs1BcUMmuX/AUHM3Oyj6KmK4KlIYJ19+DAnxK4QbGO2zk/k3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419915; c=relaxed/simple;
	bh=kE4OMaYgnKgLZviVYjit63KeaW99OsI+UKX2oXISfuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbIbt1vBE/YI5pgJ7jDy7BxzNzpc6Hyb59KTGoBqNrbUKKwHwjmpjdA9QUlmDENA1KEL0phTeAUswxvuby0T6mmRMgtZN0FhJvEMruqqhik1B7IiLeCnfEnXfFsGJLhZg/C4Ni3rzEiz7Xvn6VIEcCHazm6MhK6RRO3JjBkQ6jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7aVYc1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7001DC4CEE7;
	Wed, 28 May 2025 08:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748419915;
	bh=kE4OMaYgnKgLZviVYjit63KeaW99OsI+UKX2oXISfuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7aVYc1SlQQlVCzn0R6QoHIpn0mYS62sE1dlMWXr+rAcZ1reIi9iv3nv6INHYyhBt
	 dEiHsof6tSTOsduxzqYZNUhkBPGnZMd5zqJRGKBB+pxmvUOdfLdMmeHWkoVD3rx3DT
	 jfxiyJqqm4+zD2mQ44iSsaaBBoWSFc8HgGprpzIhDUm8AALsJr2x4DA33gy5kXCks4
	 Xh+9VUdzQDLn7nECx5IJcJWfTaEd2q4dPWG4gTqzor7RZz49A4aOzyQT5nmUHM0Coi
	 miIXEbGTEECUIm5Q0DFbKsVq5Et253dA9zlnMGmGAwM2BAWD9qgaiyVo7zyZcqmr61
	 8Yi5z7igAwMGQ==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 36/43] sched/smp: Use the SMP version of cpu_of()
Date: Wed, 28 May 2025 10:09:17 +0200
Message-ID: <20250528080924.2273858-37-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250528080924.2273858-1-mingo@kernel.org>
References: <20250528080924.2273858-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the scheduler by making formerly SMP-only primitives and data
structures unconditional.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/sched.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7c67e1ccc0ae..19808e09bd94 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1293,11 +1293,7 @@ static inline struct rq *rq_of(struct cfs_rq *cfs_rq)
 
 static inline int cpu_of(struct rq *rq)
 {
-#ifdef CONFIG_SMP
 	return rq->cpu;
-#else
-	return 0;
-#endif
 }
 
 #define MDF_PUSH		0x01
-- 
2.45.2


