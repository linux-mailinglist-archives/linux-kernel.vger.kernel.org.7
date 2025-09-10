Return-Path: <linux-kernel+bounces-810776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5128B51F3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712EB3AE8E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1526C3375CB;
	Wed, 10 Sep 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BEUC0MeJ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E65327A3C
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526261; cv=none; b=q1Sa/g8lguTTjTvu3PV9zH7/bGf/ScW5xGGEaZdT6hm9fTATIxKX+LxUmpO4B8eCiFeACdCesqGsaqIf5iCQgRiNcUhIZJE6Po9SlOKoXQd0Pl9tnPE86GaeLS0rRwVyF174Lp6kSAbJw/WA/TLMnZzTMDA2h1nX3y3f+wipNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526261; c=relaxed/simple;
	bh=vgMlY2ra9t7V8uWWcpZ0Vv3CfbgPT2HGVY0Xqmwsuac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/8LQm2Btj5efadH3gw6msnkcrPbK3PFN99IlvUBEWfhQYxs1WFyWW/3yDsK/pALmVJz9HuWSg7w8T4PGYYbnM02MFXsYXHBJiH0pAOV66exak8UM/Wnrt0kZWdAg6o7IEaCDNe6rhBVfDJBwFpushRlM3B+PL5dM96FkAuaZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BEUC0MeJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGGaBV017175;
	Wed, 10 Sep 2025 17:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lMJKgh/KF643GqIYg
	CQOVbvdBJxZyCPnOx61+dagYXc=; b=BEUC0MeJ0nFvKTwfy5GbdZ5eiG57XzFKN
	hTuqc647ot+GSiR5KTAvO5Rs0i/7KtHN0N1/ADBxPbVnQq1QD4rHQmwMaeL/lr/r
	pLGuCVdatF7VP7xpmAjPuSk/isf1nGa45fCV2EaCysSTIClLshSZg/9rOuxNO9MD
	HNZ+tHcdnuIqnGRmWuWW0biy2h1qee6CUiGY/NkkCmj6tNX7M6tdtFRtxNTmXSLG
	zI5EXfVSBu4ZFlP4iGUzl4YhTWCRqvNvaKZmpIQsCR6fJaYoGn3gFZ8d/oL7aUTt
	LOtdFaIq6TI2WB4Xr6k9JWcquQ55MUNvB9pZdbHjuAshkvsndoCWg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsycjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:43:53 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58AHdv3D029455;
	Wed, 10 Sep 2025 17:43:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsycjn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:43:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58AH4Bwj020469;
	Wed, 10 Sep 2025 17:43:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp11vh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:43:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AHhl4540698366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 17:43:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B783F20043;
	Wed, 10 Sep 2025 17:43:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D9962004B;
	Wed, 10 Sep 2025 17:43:41 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.208.171])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 17:43:41 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org
Cc: sshegde@linux.ibm.com, vschneid@redhat.com, iii@linux.ibm.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vineeth@bitbyteword.org, jgross@suse.com, pbonzini@redhat.com,
        seanjc@google.com
Subject: [RFC PATCH v3 02/10] cpumask: Introduce cpu_paravirt_mask
Date: Wed, 10 Sep 2025 23:12:02 +0530
Message-ID: <20250910174210.1969750-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910174210.1969750-1-sshegde@linux.ibm.com>
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX9jqu/uD/e0G2
 ePzqiV+mByMxttpJi5ckE1KOFhluAiK1FteRDm6X+Sy26LYGMx3eCKgdNscARk5bwgg6iuLOcvX
 gYrY1xKS/Rxakm7yhoDa++RD49f6fgfEf+/OHMuWhYCDPvraeLNjSbUQrUvU4SbDyZcNcw5l50/
 k0i6ca0HM0qecG+F+c4hE8KM10fsw++oZDCZSjVFZDTm+aLt9GoegZ667M4orLYg+ChPwKHowPB
 3OmsonPYCFD7OlCsuzWRhYvNpoCfOimyWpR67yuyfim3uaOSvQO34nwG319nIqOvwcB5v8+dcza
 AZ2vkvYWFfUKy4aVoG5c4q/kxGaynq3DWGhrkhiOKje+Mel8nGAf+ljR5loCExZd++HoMokIE8d
 ajYZPsuG
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c1b8d9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=PotXWsJoChvkt9Z01ZEA:9
X-Proofpoint-GUID: vu39Ah_510WohDhLnbovaoV074Xool9i
X-Proofpoint-ORIG-GUID: EQQWBq67qGEtxwIcnldKPL3eIonPERXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

This patch does
- Declare and Define cpu_paravirt_mask.
- Get/Set helpers for it.

It is not declared next to existing masks since that would cause too
many ifdefs. Still kept it in cpumask.h instead of sched.h
so any interested users can still see it when looking at other
cpumasks available.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 include/linux/cpumask.h | 15 +++++++++++++++
 kernel/sched/core.c     |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index ff8f41ab7ce6..afbc2ca5c1b7 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1270,6 +1270,21 @@ static __always_inline bool cpu_dying(unsigned int cpu)
 
 #endif /* NR_CPUS > 1 */
 
+/*
+ * All related wrappers kept together to avoid too many ifdefs
+ * See Documentation/scheduler/sched-arch.rst for details
+ */
+#ifdef CONFIG_PARAVIRT
+extern struct cpumask __cpu_paravirt_mask;
+#define cpu_paravirt_mask    ((const struct cpumask *)&__cpu_paravirt_mask)
+#define set_cpu_paravirt(cpu, paravirt) assign_cpu((cpu), &__cpu_paravirt_mask, (paravirt))
+
+static __always_inline bool cpu_paravirt(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_paravirt_mask);
+}
+#endif
+
 #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
 
 #if NR_CPUS <= BITS_PER_LONG
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index feb750aae71b..0f1e36bb5779 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10963,3 +10963,8 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx)
 		set_next_task(rq, ctx->p);
 }
 #endif /* CONFIG_SCHED_CLASS_EXT */
+
+#ifdef CONFIG_PARAVIRT
+struct cpumask __cpu_paravirt_mask __read_mostly;
+EXPORT_SYMBOL(__cpu_paravirt_mask);
+#endif
-- 
2.47.3


