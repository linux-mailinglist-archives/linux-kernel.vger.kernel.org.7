Return-Path: <linux-kernel+bounces-852314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445B8BD8ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F8D580276
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01473090CD;
	Tue, 14 Oct 2025 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JGbhxnBc"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518C3081A9
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436252; cv=none; b=MChyKu2iEBI65gAshi1e18iqpuqmuy2jup+d0up8PPm3rJs2gqmaHBa7/9GjHVJetHawPc213G7c9wMmYMR1MCTV3dcRIJP/DWd0ZX32MlxyMrgXf5bis2E1eX3AebDJVvyC4/3SHa5eM5uBya9KFDOn32AKW3MjKHJn0bPVM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436252; c=relaxed/simple;
	bh=x3osz9T7Ry9e/+ujN3CQGUWgqiYA8ERsgkB2xZFmOK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLKhLQ7P2NIlAauhRRGvNimxstD2hHRyXkyAD2J6dkQfXI9PwIgpN3is+xw3RN4JBsflKIwxuBy3E6YHwx6X8ULGb5r1V06pqJbAr9l92x0XcL1157OX96t9w9LWCZ1REy4na/ydUxjnXPoBTYwyI70C1TVOJyDc+Uz70Uf07oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JGbhxnBc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DKDRB8004549;
	Tue, 14 Oct 2025 10:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rcN7cUJVpBuLrcWOt
	oWlWD4VoUnmHOETOboRqJctBxI=; b=JGbhxnBcfgkwiYqumJFXTziCKgbpVt1AW
	wq/6bXYJGVEuVsTX0kejxM6G9szztd3YE27XQvcAuG7vZSec4psc0wQtXYB8dx76
	OEugqLSxg2cAMF/KFOezmsHW9uTcEdq4iaZVTB4M141b+EGZFD6VGUULVrz0Wt1Q
	BVx57iXkns1Tl+u7cPn5KpkWj7IN/8WbeHXDrW8Ni/KuGj7ayrClrg/T15H2YqEp
	ACrFT9mgmXtkwsDD9DbvbDiaHKF1kATnumk8d1ztjIgEeVerz149Yy6RdZf8HGWJ
	cpYkw2xySra8KWOsUyChpbZ27qiHgA6ltYWpcpd2pBgL43sURxcIw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp7rr1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 10:03:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87xC9018359;
	Tue, 14 Oct 2025 10:03:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49s3rf3wjx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 10:03:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59EA3tqI17564046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 10:03:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F33BC200AE;
	Tue, 14 Oct 2025 10:03:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B4CE2200AD;
	Tue, 14 Oct 2025 10:03:52 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.23.219])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Oct 2025 10:03:52 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, nico@fluxnic.net
Subject: [PATCH 1/2] sched/deadline: minor code cleanups
Date: Tue, 14 Oct 2025 15:33:41 +0530
Message-ID: <20251014100342.978936-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014100342.978936-1-sshegde@linux.ibm.com>
References: <20251014100342.978936-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rZeAWOOcYXcOrA3pkeHbmTwPLGXrnuHX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX8pwg9H12iuWZ
 iXbBOtbG+XzohCtRT6Wc+ehEJZvnUNofCuhtDcZWXUDHg3CBd/GwtaOOU2uHPcQBhxhR8wP5q//
 y2ZHHfMazFWBeQKm0B0CiLH9KuRh0ZIK7gn+L1k0xSuQIO2s3y8A57/MpTskvLp12s5XcbzH/nE
 188wxvpqE83ril6qDdc4+CTmZ6E3mDQiLSEA5ptR/l2vP95e98mzYZbeWfZHI2sk/QCVsGlXjtA
 qsZT66KnOHPhfrpynvX81/qZBRaFiVcMK4uZf6Og2rfZunFNQVTCXfAYx1f1IjIi+4y2mprBlg/
 MAa/PJwqiIh7BXS4pvCQJrDLsbK861nANTUfx3Plxb7A2rs4MMty+kYcoGbpCungAmgTxL+iXpm
 YD1HNfKBwGXi9Wx0t/t3YzgIcHgJtw==
X-Proofpoint-GUID: rZeAWOOcYXcOrA3pkeHbmTwPLGXrnuHX
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68ee200d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=uUWqLOjUxzJTsSO82_sA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084

- In dl_server_timer, there is same dl_runtime check above. So
this check is duplicate. This could save a few cycles.

- In select_task_rq_dl, there is only one goto statement, there is
no need for it. 

No functional changes.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/deadline.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7b7671060bf9..8b7c4ee41fd8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1166,9 +1166,6 @@ static enum hrtimer_restart dl_server_timer(struct hrtimer *timer, struct sched_
 		sched_clock_tick();
 		update_rq_clock(rq);
 
-		if (!dl_se->dl_runtime)
-			return HRTIMER_NORESTART;
-
 		if (dl_se->dl_defer_armed) {
 			/*
 			 * First check if the server could consume runtime in background.
@@ -2173,7 +2170,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 	struct rq *rq;
 
 	if (!(flags & WF_TTWU))
-		goto out;
+		return cpu;
 
 	rq = cpu_rq(cpu);
 
@@ -2211,7 +2208,6 @@ select_task_rq_dl(struct task_struct *p, int cpu, int flags)
 	}
 	rcu_read_unlock();
 
-out:
 	return cpu;
 }
 
-- 
2.47.3


