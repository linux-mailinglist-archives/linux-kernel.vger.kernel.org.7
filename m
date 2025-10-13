Return-Path: <linux-kernel+bounces-850929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A81BD4DEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD35475B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B377F311C38;
	Mon, 13 Oct 2025 15:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="mWej291H"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D030DD19
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369989; cv=none; b=uSZ27SgkbSigx2b4GpPFLZtYNOEQ03VmIel2olv+01xLEPWZx+lSmNxuGDE67PjPXZNxdVfYqLmNgIJgu6YLVBkbidC3BTiQYIzWJiqR/Xz0r2O4snS5hFP1xtkjjjbdhlC9OryxBarDaCMiHe4z9EG9y51NaSrQZN5FRh3i/lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369989; c=relaxed/simple;
	bh=YwUQEWuGDbfNmBNRNmuhWkQfNTtxPU2EfJRzUJtttGY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YOwjpftlUPpH7u9LuN5cK1apFjxYVp9GNViANqKI6UTz7BB065YkIMlMohAGbN5Q4uMJKdVv5UIMfmTYOcv8/bA6THzYElvDB73XwYZPM25c3PPkqKQHEZoI8CmbTZtWflrz7GAI2oe8UqsIM3Iov6lM5zUA4SZlKtuzr6ZmfgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=mWej291H; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DEtCTk027980;
	Mon, 13 Oct 2025 15:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=uIjqjo58kep0pU2OkAzHPvf81jMItmoD1vePu
	ap55W0=; b=mWej291Ho40lbgK/RTvW0phvJJpEWcGqRas2pG24/Cbu4RlpJxEIU
	DKjk6zvoxtrgJFXF+zaDHS5fRCrUiPlVWK61hKm/q5kCqrStgWA8gY3CZlrG8CAN
	kZwpudGfyRERXbI97ihsSbaBzI9/Q1K/G/xIZzpAxIHNkXCH/XUJ0JpqKP3g5KhU
	s3q4kQaZNaDa6tZX8dFEMUSnz8Ws53YE7KqD6wnUBXweCNbLXLSg79d9uDtIT5jx
	B+qcfR7OAX9xpF4bq8AaPQ5T+zOCaRPX0KUBNMI0E4AVAXVqflSM/BIVbAXbznsT
	lfI797I/jevgebK7hi0Ap3HHr2/WBwj0Q==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 49s3ky04qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 15:10:01 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 31381805E31;
	Mon, 13 Oct 2025 15:10:01 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id B254A808B81;
	Mon, 13 Oct 2025 15:10:00 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 200934)
	id DB65E302F474C; Mon, 13 Oct 2025 10:09:59 -0500 (CDT)
From: Steve Wahl <steve.wahl@hpe.com>
To: Steve Wahl <steve.wahl@hpe.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH] tick/sched: Use trylock for jiffies updates by non-timekeeper CPUs
Date: Mon, 13 Oct 2025 10:09:59 -0500
Message-Id: <20251013150959.298288-1-steve.wahl@hpe.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -m10UOhHm_hUTcXe_CzEHuKA2OwMkXAJ
X-Proofpoint-ORIG-GUID: -m10UOhHm_hUTcXe_CzEHuKA2OwMkXAJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA2NiBTYWx0ZWRfX6naXhFXN2WS2
 vZPoC/BwxN3NvdsdHZV9qkPCjMWkr1er/B89UBwmN3lwNduAGOGC2qrzCq3HKXXVqrPCn2uGKNF
 COPXVJigX8jCzjwhvtwWBVNYCO+i7yJ0UpX7d1u83LujUfLzfI1AEHuQJMj+GYTNW0/JFAs/pZg
 4DZ7CdvapZ34jRBcVumfl47wmlUhFIreJLLCSNEPDQMW5QeGc5TxjaaVDmQgJeS/wt8RPPrG69w
 1csuRWFhV+IMJpip33AlCVwXH7IC4ZGWMZAxAyrPJ37teiYwVJ2LM552bAezHKke7dMeNzZwj/L
 WCMSS8DHJFDnVQ2ZkVbxltD5cU6j4ZGHnUatloWL3RQRHot/ILv5cvn5y55PyhhPL0W+PUSCXe8
 I85r/13c5C0REXy2I6oYb9jq6ymsow==
X-Authority-Analysis: v=2.4 cv=D5xK6/Rj c=1 sm=1 tr=0 ts=68ed1649 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=x6icFKpwvdMA:10 a=MvuuwTCpAAAA:8 a=H5T9noDTSo1JzFdqmQ4A:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130066

On large NUMA systems, while running a test program that saturates the
inter-proccesor and inter-NUMA links, acquiring the jiffies_lock can
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

To avoid this, in tick_sched_do_timer() have cpus that are not the
official timekeeper only try for the lock, and if it is held by
another CPU, leave the updating of jiffies to the lock holder.  If the
update is not yet guaranteed complete, do not reset
ts->stalled_jiffies, so the check for stalled jiffies continues on the
next tick.

With this change, manually interrupting the test I find at most one
cpu in the tick_do_update_jiffies64 function.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 kernel/time/tick-sched.c | 46 ++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index c527b421c865..706d4e235989 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -54,7 +54,7 @@ static ktime_t last_jiffies_update;
 /*
  * Must be called with interrupts disabled !
  */
-static void tick_do_update_jiffies64(ktime_t now)
+static bool _tick_do_update_jiffies64(ktime_t now, bool trylock)
 {
 	unsigned long ticks = 1;
 	ktime_t delta, nextp;
@@ -70,7 +70,7 @@ static void tick_do_update_jiffies64(ktime_t now)
 	 */
 	if (IS_ENABLED(CONFIG_64BIT)) {
 		if (ktime_before(now, smp_load_acquire(&tick_next_period)))
-			return;
+			return true;
 	} else {
 		unsigned int seq;
 
@@ -84,18 +84,24 @@ static void tick_do_update_jiffies64(ktime_t now)
 		} while (read_seqcount_retry(&jiffies_seq, seq));
 
 		if (ktime_before(now, nextp))
-			return;
+			return true;
 	}
 
 	/* Quick check failed, i.e. update is required. */
-	raw_spin_lock(&jiffies_lock);
+	if (trylock) {
+		/* The cpu holding the lock will do the update. */
+		if (!raw_spin_trylock(&jiffies_lock))
+			return false;
+	} else {
+		raw_spin_lock(&jiffies_lock);
+	}
 	/*
 	 * Re-evaluate with the lock held. Another CPU might have done the
 	 * update already.
 	 */
 	if (ktime_before(now, tick_next_period)) {
 		raw_spin_unlock(&jiffies_lock);
-		return;
+		return true;
 	}
 
 	write_seqcount_begin(&jiffies_seq);
@@ -147,6 +153,27 @@ static void tick_do_update_jiffies64(ktime_t now)
 
 	raw_spin_unlock(&jiffies_lock);
 	update_wall_time();
+	return true;
+}
+
+/*
+ * Obtains the lock and does not return until update is complete.
+ * Must be called with interrupts disabled.
+ */
+static void tick_do_update_jiffies64(ktime_t now)
+{
+	_tick_do_update_jiffies64(now, false);
+}
+
+/*
+ * This will return early if another cpu holds the lock.  On return,
+ * the update is in progress but may not have completed yet.
+ * Must be called with interrupts disabled.
+ * Returns false if update might not yet be completed.
+ */
+static bool tick_attempt_update_jiffies64(ktime_t now)
+{
+	return _tick_do_update_jiffies64(now, true);
 }
 
 /*
@@ -239,10 +266,11 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 		ts->stalled_jiffies = 0;
 		ts->last_tick_jiffies = READ_ONCE(jiffies);
 	} else {
-		if (++ts->stalled_jiffies == MAX_STALLED_JIFFIES) {
-			tick_do_update_jiffies64(now);
-			ts->stalled_jiffies = 0;
-			ts->last_tick_jiffies = READ_ONCE(jiffies);
+		if (++ts->stalled_jiffies >= MAX_STALLED_JIFFIES) {
+			if (tick_attempt_update_jiffies64(now)) {
+				ts->stalled_jiffies = 0;
+				ts->last_tick_jiffies = READ_ONCE(jiffies);
+			}
 		}
 	}
 
-- 
2.26.2


