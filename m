Return-Path: <linux-kernel+bounces-852315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1136ABD8A67
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1808352557
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35751308F15;
	Tue, 14 Oct 2025 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f+7/nXro"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDBF308F07
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436252; cv=none; b=gZdbdELI0plwc1jA/XsJLn2+JjLan7Mi3KApM5IOxqrlkNrmAn19Bdmh/cXjErkIPCy1CVWgYDruJWY01741oXFPkYlWl0J23XAZx3Ot3dBd0b/UCxbCh7rCiFq/AYAwvIqoVaPoySSlVBlW4kiToAwsQyl7QKr+vJsPS0C9RbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436252; c=relaxed/simple;
	bh=TaNNBem8lAAJYlvRqvJ2jIEW3gXOr5ZLxGKqeV/GRng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=an3Z7sI5OLC1HCMWVPFc31LeOunfAAClxWZ8cTB5jm+gDOBep/SFLB/6MzVHejF9cCE204SN7mk5ixwp21oCYoHv+hhff/Q0lEGJ2+4RvpgIk2zLOq30u92dXHKg2wSyVp6zP2FjEINhJb9QRF8hibDeRCCjnVU9rcMuovfhtcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f+7/nXro; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E6mZEQ019492;
	Tue, 14 Oct 2025 10:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I+WQW1GSQNgbpbror
	P5+qHFDG8Q7taSv6piEER6deqA=; b=f+7/nXroMsxUzGIQw2F0lDi8gthIfwTAs
	0QIlOIzstu+WVHvzlrH1XJ6/EkM4gptTotYF2lOTgzsGyGP6trgi2lLU8gD9BWAk
	QQnvbdKFhEGXMjECcSF2Du/p0ktpo0uXutBct2o2VHY+r6D38Kyr0PZ3jvFs265J
	70LrIcWskzFOk91YKqpW7Man1+vxfeG1oabQaJjYujd3mRLl1YRgkHqWP9IGVZ25
	x9f2CfDuuhYjTNcFCukvDNhfDRaYt619dLvjkO20qhU5LR+elf96BwTsx+Rrxd5e
	aQtqOpPVfq//RJUYRYMWQ89vLpSha0+5R+nSZhMsSE4dxsWz2G3ZQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8nx1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 10:04:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59E7hO1U016759;
	Tue, 14 Oct 2025 10:03:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jt7gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 10:03:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59EA3vK755706052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 10:03:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89568200AF;
	Tue, 14 Oct 2025 10:03:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 574FC200AE;
	Tue, 14 Oct 2025 10:03:55 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.23.219])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Oct 2025 10:03:55 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, nico@fluxnic.net
Subject: [PATCH 2/2] sched/deadline: Use cpumask_weight_and in dl_bw_cpus
Date: Tue, 14 Oct 2025 15:33:42 +0530
Message-ID: <20251014100342.978936-3-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: q77bM1OCIjOr_oKG7to9xgO2Apc85Tz9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfXwGhp74IVXVc4
 KvwHJn5Ie87hEIWfgFdmcN4sztGDxU4mvH1T88nTiwiGRpwFIXj0U7FVXZ3M0HW8jH4JMZFg97n
 BcH4i60V9kGIr3pCYA7f+5LKCmx9l0Ux349+2IJZ3liuUEldkoButrrO5Teod0SkOsUK1x5eaPu
 Ij+dE1v6Aoy17UdCwhfxxAwrFmGqJ/zF9osf3tB3tId7Ct3zk3Pb7m2+j8OoUBMOFQox3LZOLl1
 ev2l0hUUSnL00s/mHdgxPuS9HyssCLKf9NUTMb/Upw+ffaiLWK+66+8xXjmJVk9bUGMiGRSMpAj
 C3bGap8a4C1qj3oq48ydd8RnCjyj9h+do8XTkGC/wAPJKu2KszD0MvaUlLqeVQDd34YnrqPdJdH
 FM5VeVuKCH6lkZlEt4uugzhVdCV8tQ==
X-Proofpoint-GUID: q77bM1OCIjOr_oKG7to9xgO2Apc85Tz9
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68ee2010 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=9W2h6_F03xQMxq1xaaIA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011

- cpumask_subset(a,b) -> cpumask_weight(a) should be same as 
cpumask_weight_and(a,b)

- for_each_cpu_and(a,b) to count cpus could be replaced by
cpumask_weight_and(a,b)

No Functional Change. It could save a few cycles since cpumask_weight_and 
would be more efficient. Plus one less stack variable. 

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/deadline.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 8b7c4ee41fd8..a18f64b2e47c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -125,20 +125,11 @@ static inline struct dl_bw *dl_bw_of(int i)
 static inline int dl_bw_cpus(int i)
 {
 	struct root_domain *rd = cpu_rq(i)->rd;
-	int cpus;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
 			 "sched RCU must be held");
 
-	if (cpumask_subset(rd->span, cpu_active_mask))
-		return cpumask_weight(rd->span);
-
-	cpus = 0;
-
-	for_each_cpu_and(i, rd->span, cpu_active_mask)
-		cpus++;
-
-	return cpus;
+	return cpumask_weight_and(rd->span, cpu_active_mask);
 }
 
 static inline unsigned long __dl_bw_capacity(const struct cpumask *mask)
-- 
2.47.3


