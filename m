Return-Path: <linux-kernel+bounces-810774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D33B51F42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA627B3680
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D69335BAC;
	Wed, 10 Sep 2025 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zz2v+say"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DF13148A9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526260; cv=none; b=sSuQ/ebSTS3m827VXJ2mRTRhHA+R01T2U3lQ74zM6EXvYg+8Yqd9dCfnJU0B4aAsNjUv08sfhUpSmlFCFcTQ5c4seoh4WU/xfChoATAKW14nnX/oS2M/wOceOm1FpkPiorp1SHuzlEM6KyMP4+RjeEg1LHndo4/u9Ml/YOJrGpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526260; c=relaxed/simple;
	bh=eqdgaxp6Yj98s13rp4HJdzhwpRWVTxlAvH/FqZcmpIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GENRYmFr3NIv+C+pWwcNeZeXT+qIdtiEncF7Hrj80UF9aNieHvmV6zBaosrtiZoPlQ+jWQ1fboCEM4/HpCK3NGliXqIJxizuY7JmGYnQUsH8LAxN91ZEdMhOzzPFI0l7w+hpm11zfyiu8oG26HYnVPl2nAHYw1Qm2c4XGxItISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zz2v+say; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AFKl9u024098;
	Wed, 10 Sep 2025 17:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=peXeLJXWxKrxaOZS7
	BY2ZPsxENkfrJuyzcVdcfLDXwc=; b=Zz2v+say3q5YM7xEXzhOoAbYdGAZZEC+1
	RmH9tG1PL/UE0bzvM252uSt39i2WI91Ppkwl9Ynn+14eWPRA/JyCjXUO42TkUGCE
	ZwuT1uG8BwYLuoe+Zqh+NeHn2Tt+wD0BGZytZXOt/6Vh24pxE4F2FinlNu2vglQ8
	MuroLPPR+Tott3/axlBfK9y63A4zCc88BaMR4O2fHtd/SA9mTXi4hRRWxrm02zO4
	yvr+UNGWW5kxSjDPUzxIk9K/VPdkWLDO6zEzbhvhrEhOwiqYD2qyZwgiVJPLrnlp
	iQlcUExruYkCZde9xlrqpRkTDyGeLZT8icVRkKhBC+C3ds+U6DXyQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acr7g15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:44:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58AHi5EO025532;
	Wed, 10 Sep 2025 17:44:05 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acr7g12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:44:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58AG0at4011446;
	Wed, 10 Sep 2025 17:44:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9uj02m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:44:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AHi1hp51052910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 17:44:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0C862004D;
	Wed, 10 Sep 2025 17:44:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D09DF20040;
	Wed, 10 Sep 2025 17:43:54 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.208.171])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 17:43:54 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org
Cc: sshegde@linux.ibm.com, vschneid@redhat.com, iii@linux.ibm.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vineeth@bitbyteword.org, jgross@suse.com, pbonzini@redhat.com,
        seanjc@google.com
Subject: [RFC PATCH v3 04/10] sched/core: Dont allow to use CPU marked as paravirt
Date: Wed, 10 Sep 2025 23:12:04 +0530
Message-ID: <20250910174210.1969750-5-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: OBLXkql8hx1WhZzBKbV5CV2vi8mOdkie
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68c1b8e6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=uXBPIk7YWzXHA4pK:21 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8
 a=P8M16rivtmrVeddd8boA:9
X-Proofpoint-ORIG-GUID: v1625mvTieLv0K7jrC5ulkCE9e2nrFd_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX4tA+a7oT5KZT
 A/mrIFeUY6v8Wd8HBOCxxRktr2qgNDKTFJfaIzYseNbf834EiCUCMDHDeNsqeMXUMRgnZfa7qiE
 SOFHOZsI3OtvGqSuLUzBlxswNjO3JxhlAeGiylLTrCtK5R5T0hrNuQlvBiwaZePDNPCvBaRydQH
 bRPz/jFuO2GVOSeJHJUSfam/T4kC6DxCA/P4X1I0A09lxgopOHKHIjZ/StxmISY1FiHezmitA0K
 lEyK3H3a/QqtcZLBhRUCeQ7tOzHccV2ucMPiLM2Nxm6v+I2WN+ktDVHymbJovCIJLPm3zP58L+k
 EooVQmnB2U3KTKYs5maUTfGAJPxyKN1FwHgXz5Q0G/6MmxnTmfVh9YeGfDC6xZjltY5tZOBgPet
 FOqPne/s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

Don't allow a paravirt CPU to be used while looking for a CPU to use.

Push task mechanism uses stopper thread which going to call
select_fallback_rq and use this mechanism to avoid picking a paravirt CPU.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8a84e4691c8..279b0dd72b5e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2462,8 +2462,13 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 		return cpu_online(cpu);
 
 	/* Non kernel threads are not allowed during either online or offline. */
-	if (!(p->flags & PF_KTHREAD))
-		return cpu_active(cpu);
+	if (!(p->flags & PF_KTHREAD)) {
+		/* A user thread shouldn't be allowed on a paravirt cpu */
+		if (is_cpu_paravirt(cpu))
+			return false;
+		else
+			return cpu_active(cpu);
+	}
 
 	/* KTHREAD_IS_PER_CPU is always allowed. */
 	if (kthread_is_per_cpu(p))
@@ -2473,6 +2478,10 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 	if (cpu_dying(cpu))
 		return false;
 
+	/* Non percpu kthreads should stay away from paravirt cpu*/
+	if (is_cpu_paravirt(cpu))
+		return false;
+
 	/* But are allowed during online. */
 	return cpu_online(cpu);
 }
-- 
2.47.3


