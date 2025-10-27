Return-Path: <linux-kernel+bounces-872391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CA28FC109A6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 387015025BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E176F32BF5B;
	Mon, 27 Oct 2025 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="P0kbgBKf"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD2631B83D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591789; cv=none; b=IxFBaYdzbuXbCv4+Le6gglS6iIPSzXqoVScxtFQ69wNr2wpKvQWuaUj9JOAkbm/fv5M5C3Lhl37c3pFKNOPmPFansI/Gv9oeDyIvpqyIkERDYhGcI55Fht8gTNdYE25Gep6P87zr8fblXGGBw+dU8flTehFHmruIbYtUpt/ytds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591789; c=relaxed/simple;
	bh=OChS1yQ4u0k5LclnsJPoDrmaQ2zh8Gp5RmyL4C4TTlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKkxNCUeqsPA/ysZUx1nvzswy9F1Bv20pluURm7Y1Prkf2upgbhF4vePXtSA9Mt48yQxhCxFb2CiFT6y55bmZbkYCYhr06wGbwDotRHm59Ei+Hwd7ksBt3eX7XJ9CHPhIj4gQmYD0zGl2EMK0JmPSlp3sFuYHFt/JM6OhsrYy2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=P0kbgBKf; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RFtcYP013619;
	Mon, 27 Oct 2025 18:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=CWgcediJehN1gwQDrdrCCCeMmHOQ4RI7DrOUq
	t1LmIw=; b=P0kbgBKf5LRx+Ct1DmLEORmEwfWs5a5sVV27UEKVHPL1BzXbj1nT3
	Yl+5dXCjXkeHrEfLUH53JL8D6XwsO6ztuSvPG17suSKaSb9ulGPwJluNYa44dhR5
	R3CIEl7/536dC3jZVww9G+nTChvxkCPAFbj94h6Lu3l3AtnphhoEJjKZQdSjbKdS
	tU1zwrmZvUCL3TIWqNEJV1jur/TQFYX7XfTck+GYgIPnZe0MfSTmhJEbDT9GlCa2
	9OmSseyKAdqW2z0q5FBQ7pdM87mgz229xKs8qHX5O6foUUqFCV7qKh1Biw1CVHnR
	OM7ybvmBXmYH0vPv1h3U6XKqya1heK3Jg==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4a0pnt1jfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 18:34:58 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 9CE3E12EA5;
	Mon, 27 Oct 2025 18:34:57 +0000 (UTC)
Received: from elk.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 484FF801716;
	Mon, 27 Oct 2025 18:34:57 +0000 (UTC)
Received: by elk.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id B7EF33B405; Mon, 27 Oct 2025 13:34:56 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH v2] tick/sched: Limit non-timekeeper CPUs calling jiffies update
Date: Mon, 27 Oct 2025 13:34:56 -0500
Message-ID: <20251027183456.343407-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fI80HJae c=1 sm=1 tr=0 ts=68ffbb52 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8
 a=Os7hGrvuvey4aUMrImIA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAyOCBTYWx0ZWRfXxTlx/yvRT67A
 hqUE5LM7dX3cGuG9Wla+gPXkfON1sh7Shc71eHhUdEufbYvcNbA61HaEsmg/P7Ydtc3NQ5Z1NKr
 GmUDIASMUfUaKfn+yxUgELd/bBTsjq1ojfMOHBtpL/lxMnZJ4ZbK7MGHGW79zFPRBT/3XH0Hv/s
 UcxZolQX2HbkC9RB9QWOT9+50z/cmaQGTuhENW1VBPUTpQxvCmczCmKb641tIHcMWQvZ/aaiPwe
 RlAyGEXDTbYDSWBXEIW9A6fzP8m/L9y3AwTPHpMlyRDRoBpJeu9LzefBGzbqdbnYrFok4OCtFle
 XNT5hEENR2xsB5qZmC9IC3+k0oGtIJNIQJ2ijs1/XrQ6yrpsKfJXjhFTX4/gj9jGmE1YR3k1HvL
 My4EcevVQ0O7OPouYAra7feHRzvHBQ==
X-Proofpoint-GUID: u0XFCHfJQFdECsa_TCdjnWk56SIJQduv
X-Proofpoint-ORIG-GUID: u0XFCHfJQFdECsa_TCdjnWk56SIJQduv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510250028

On large NUMA systems, while running a test program that saturates the
inter-processor and inter-NUMA links, acquiring the jiffies_lock can
be very expensive.  If the cpu designated to do jiffies updates
(tick_do_timer_cpu) gets delayed and other cpus decide to do the
jiffies update themselves, a large number of them decide to do so at
the same time.  The inexpensive check against tick_next_period is far
quicker than actually acquiring the lock, so most of these get in line
to obtain the lock.  If obtaining the lock is slow enough, this
spirals into the vast majority of CPUs continuously being stuck
waiting for this lock, just to obtain it and find out that time has
already been updated by another cpu. For example, on one random entry
to kdb by manually-injected NMI, I saw 2912 of 3840 cpus stuck here.

To avoid this, allow only one non-timekeeper CPU to call
tick_do_update_jiffies64() at any given time, resetting ts->stalled
jiffies only if the jiffies update function is actually called.

With this change, manually interrupting the test I find at most two
CPUs in the tick_do_update_jiffies64 function (the timekeeper and one
other).

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---

v2: Rewritten to use an atomic to gate non-timekeeping cpus calling the
    jiffies update, as suggested by tglx. Title of patch has changed
    since trylock is no longer used.

v1 discussion: https://lore.kernel.org/all/20251013150959.298288-1-steve.wahl@hpe.com/

 kernel/time/tick-sched.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c527b421c865..3ff3eb1f90d0 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -201,6 +201,27 @@ static inline void tick_sched_flag_clear(struct tick_sched *ts,
 	ts->flags &= ~flag;
 }
 
+/*
+ * Allow only one non-timekeeper CPU at a time update jiffies from
+ * the timer tick.
+ *
+ * Returns true if update was run.
+ */
+static bool tick_limited_update_jiffies64(struct tick_sched *ts, ktime_t now)
+{
+	static atomic_t in_progress;
+	int inp;
+
+	inp = atomic_read(&in_progress);
+	if (inp || !atomic_try_cmpxchg(&in_progress, &inp, 1))
+		return false;
+
+	if (ts->last_tick_jiffies == jiffies)
+		tick_do_update_jiffies64(now);
+	atomic_set(&in_progress, 0);
+	return true;
+}
+
 #define MAX_STALLED_JIFFIES 5
 
 static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
@@ -239,10 +260,11 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 		ts->stalled_jiffies = 0;
 		ts->last_tick_jiffies = READ_ONCE(jiffies);
 	} else {
-		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
-			tick_do_update_jiffies64(now);
-			ts->stalled_jiffies = 0;
-			ts->last_tick_jiffies = READ_ONCE(jiffies);
+		if (++ts->stalled_jiffies >= MAX_STALLED_JIFFIES) {
+			if (tick_limited_update_jiffies64(ts, now)) {
+				ts->stalled_jiffies = 0;
+				ts->last_tick_jiffies = READ_ONCE(jiffies);
+			}
 		}
 	}
 
-- 
2.43.0


