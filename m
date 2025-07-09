Return-Path: <linux-kernel+bounces-724203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CFAAFEFED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0E14A768F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827CB22C339;
	Wed,  9 Jul 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nEwYBsQe"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E722A4E5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752082429; cv=none; b=FsI8JLHu6mzTWx7/lcJuF8e2XZCIDIUR+zxR22rJIyoavwks5PkMq9CYN5QmVlveqxemSlJFySIcwsXcSoyXhByf81MTDTxZoCbq5dErRr4jpvm8x13YT6YgtV8mpUqKQ9JiWqmLiiV16HkBKvklhRDs8nvdJ/qd6r4hUO3rO9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752082429; c=relaxed/simple;
	bh=WwkYMB2zZ9yX2Tkk8lFoELVwvL+EOjMVlpZO+CYoShk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3Mjx8qKr6H0Kc3L1EPtC7D5JiNM7ZhywxdblutU+fqqI44sZGxpbcOa1h5uotyfoN28taAFh4x8nwrQdarmugCsNH7ewNBFM0jVSBVVGOX2eJSYVDVepGvoD38hecpBmEG27nF3y2c1fZYf6C8MT9PnCSPFS1OglL0oaJvzHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nEwYBsQe; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569HHSph009009;
	Wed, 9 Jul 2025 17:33:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=sALiUtyxcN1wQ6o0j5MGblPljhcbJ
	5JqrksgOESEDdQ=; b=nEwYBsQemlKDVkvKXCyPD4BZWAtEdbzIVA5TDBT69wlbT
	32MYfGTlJxLCEnctXFEM5NROVBenQAwhO4qIXdLr2cVjD07IHnlnbW6+ynBsj9ae
	40vyJUJ6Zb3GocBCCoBwx6B3kHKEnwghDjTL9ZhYOJG/Sr1vmVRiYXZk2e1p1wk3
	uaQsSFThOr6tHn0aYp4GgqCABv9/3C7yKOYREuYgTjbAAK9TQQhaKOB0g1F4Ryeo
	3r6Gb9+xA93EcopKi9rKb2fikP06okFp8drYNCIdG6PFpVmmKkMgh7cfhkcg4cbw
	Ml9la/B5+6qRP+VYINn4BKEAaN8MvPDulV87xEfGA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47svpf01gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 17:33:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569GlmDw014243;
	Wed, 9 Jul 2025 17:33:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgc1axp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 17:33:29 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 569HUHNT035887;
	Wed, 9 Jul 2025 17:33:28 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ptgc1awu-1;
	Wed, 09 Jul 2025 17:33:28 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, aruna.ramakrishna@oracle.com
Subject: [PATCH RESEND] sched: Change nr_uninterruptible type to unsigned long
Date: Wed,  9 Jul 2025 17:33:28 +0000
Message-ID: <20250709173328.606794-1-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090158
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE1OCBTYWx0ZWRfXzWP0YrJCf4RW GIy2MUdBkuggPL04QEoOYkgm50rz+qOkO+eE+zSvXkT5ukg4GytbkJBEPv9+ZwUCH5J1XADG0+f 7cQ7ENNfgK0EUmQx3NHSrOfSEmJo4whoDswB5kJqUgNngk4ydl6relFd9iZZn8Py6ZvKkpTwP2M
 Tdu3sX6ckpDOGD6m2Zw5XZOGsI4b6nDvdI1tzvbaXL6anbdpbE8vs2SPaq/0PtEPBC37BE7IJTV vE0nEynFD1Pqbatko1BA5bAASZlVy8OB3coRZ6BakCL6WhVDcEZWOYRMHTNw5YDnmuH4V+EyBfG vMK0Amh0V1WgFgPM7KoOUNHS9L+yvVBAUfx+OMVE4yA+8QRw2R1qEhx+s5bjtwzO3r6kXFCdmxz
 YIimJ6fK7M3ieR2LW48kixCZzUixJBSWbLNKe8l5qTQSZaG3Bxmfg3VVa2l8TpHRKsfs90S/
X-Authority-Analysis: v=2.4 cv=IOcCChvG c=1 sm=1 tr=0 ts=686ea7ea b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=3hMAoP2lnyBJ8C0jIBMA:9 cc=ntf awl=host:13565
X-Proofpoint-ORIG-GUID: G8ec7aAqkYG29Tv5sE0BLCjWG0if23u4
X-Proofpoint-GUID: G8ec7aAqkYG29Tv5sE0BLCjWG0if23u4

The commit e6fe3f422be1 ("sched: Make multiple runqueue task counters
32-bit") changed nr_uninterruptible to an unsigned int. But the
nr_uninterruptible values for each of the CPU runqueues can grow to
large numbers, sometimes exceeding INT_MAX. This is valid, if, over
time, a large number of tasks are migrated off of one CPU after going
into an uninterruptible state. Only the sum of all nr_interruptible
values across all CPUs yields the correct result, as explained in a
comment in kernel/sched/loadavg.c.

Change the type of nr_uninterruptible back to unsigned long to prevent
overflows, and thus the miscalculation of load average.

Fixes: e6fe3f422be1 ("sched: Make multiple runqueue task counters 32-bit")

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 kernel/sched/loadavg.c | 2 +-
 kernel/sched/sched.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/loadavg.c b/kernel/sched/loadavg.c
index c48900b856a2..52ca8e268cfc 100644
--- a/kernel/sched/loadavg.c
+++ b/kernel/sched/loadavg.c
@@ -80,7 +80,7 @@ long calc_load_fold_active(struct rq *this_rq, long adjust)
 	long nr_active, delta = 0;
 
 	nr_active = this_rq->nr_running - adjust;
-	nr_active += (int)this_rq->nr_uninterruptible;
+	nr_active += (long)this_rq->nr_uninterruptible;
 
 	if (nr_active != this_rq->calc_load_active) {
 		delta = nr_active - this_rq->calc_load_active;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 475bb5998295..83e3aa917142 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1149,7 +1149,7 @@ struct rq {
 	 * one CPU and if it got migrated afterwards it may decrease
 	 * it on another CPU. Always updated under the runqueue lock:
 	 */
-	unsigned int		nr_uninterruptible;
+	unsigned long 		nr_uninterruptible;
 
 	union {
 		struct task_struct __rcu *donor; /* Scheduler context */

base-commit: 86731a2a651e58953fc949573895f2fa6d456841
prerequisite-patch-id: dd6db7012c5094dec89e689ba56fd3551d2b4a40
-- 
2.43.5


