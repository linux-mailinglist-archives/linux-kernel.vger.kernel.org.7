Return-Path: <linux-kernel+bounces-703289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CAFAE8E39
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 21:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6110D1C26954
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E842D2BD01A;
	Wed, 25 Jun 2025 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZSFCpL+O"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B52DECD0
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878743; cv=none; b=a3tdPzk8s7LdaZmlfAIQQdSwfRNnMFdCJkBEQrq0Gh8LRwgPXrOGEnJamVZ+ZRMF/SzakdghSLeoa7cPiBz3kC4ivA6vbnVgXpCoDnP/8jEOtANferbFJ4xYAF/UxtkTIxz7dUUaQ3qMzkDvXP7ri2Noet5o203DBsuMiw+WlMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878743; c=relaxed/simple;
	bh=LvBlwhLtCj0gRMkYeBZJBv2U2Ngnp/Hfcw9iSEo6wn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkMK2D/wdW6gaNnTGU6bL/JAGjCPX9iPn6EzkNQPx7EGavPGWEMdhox+mq6zFdWf0I7mi3g5DbeSZPnLAGo32M+gJ7+09L8nsTLgZVXqWWTBiTZRvcWfv44408PrwDWWrRgfmBMnqBK8yIVR6bzNIyxouj+huU17G97xuED1uWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZSFCpL+O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PErWHE001710;
	Wed, 25 Jun 2025 19:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/GevdFafxZDniLwlH
	nCARb10pjrPzgSvfvkI8K5DQQE=; b=ZSFCpL+O3NB8TlPWvYaiExFzSXRvL/GOu
	XQXCRIVUAFMfyZBP9VMTCpSs1euCb4jrOvL+q7jGpOAVvJ0bvcmQBWbClzDFWDWC
	imX3jE34SkJwnaja//LyT/24beKLuc5OecupdJZplqp796aK1eBlYvqugC27s87C
	OwSJf65eKW95uFrTVmIOeaDpvZlJDqOenIDXimj0iHz8Xk7IGLrdKGqwdPkauw+Z
	cvafN3bsHYQe0i1xRNG4/Sp1oi5TkQQzIftiJ5Wfi5pqQCVR97iLrk5m6dTzADcu
	VTtC2Xp0Jb0BnxOEhrACO0qe5Y6qPHm1RwWD8Oq72FCThTYH79p0Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jhhdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 19:11:46 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55PJBjC1023187;
	Wed, 25 Jun 2025 19:11:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jhhdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 19:11:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55PGctD6006400;
	Wed, 25 Jun 2025 19:11:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82paxvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 19:11:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55PJBeE129622794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 19:11:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E4E32004B;
	Wed, 25 Jun 2025 19:11:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ED8D20040;
	Wed, 25 Jun 2025 19:11:36 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.209.143])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Jun 2025 19:11:36 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com
Cc: sshegde@linux.ibm.com, vschneid@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, kprateek.nayak@amd.com, huschle@linux.ibm.com,
        srikar@linux.ibm.com, linux-kernel@vger.kernel.org,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        gregkh@linuxfoundation.org
Subject: [RFC v2 3/9] sched/core: Dont allow to use CPU marked as avoid
Date: Thu, 26 Jun 2025 00:41:02 +0530
Message-ID: <20250625191108.1646208-4-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250625191108.1646208-1-sshegde@linux.ibm.com>
References: <20250625191108.1646208-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0MSBTYWx0ZWRfX+9zz7S7zt8OY PYmAGu7oleBftnpgl1i7AurTlVXy4W11lCiBLWFo4ew7+cfj1xO3Joh6hRn2rbHGLFHnKbJNDnc PjPrCoVS6Ueld9p8q5Fsd5tfAQWquCxXxdR6j/t8Wo7sEg5BcgSKUN1jfUBT1RAP4fFhICUz0Mt
 8vlp4s4v7aAawsUWCtXPwawSHIaDlp7SZ6obR0XFW4qr7HoiFjw1zkvXjHGPq6ytbGDFyd9m8wH 51yDEzPbLRnec8b7fLx11eYKExYftxo/JB2i4OeOaZw4uzGV6g7LPGOjMuRkXn7jC2n0P3zKgth 1E02DARsEsT48RZ3+Of52BLmvNidixjbt8mGRXePvCYwcyVEYnnJqycJyK0mdUqFBzEryr/X512
 So+b4R9aFjCaFNGY2VcfEiNYkRK7TBYjMgfLUaCfjb3++VgH2pJUrqUKIIEf0Blhg8XU8Usg
X-Proofpoint-GUID: MRni0sA2uOHcIMTzZDYYwKh2R39SA0EW
X-Proofpoint-ORIG-GUID: DY4JTPV7yGNFAd5UB6MhFXIPQqQUPWgt
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685c49f2 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=uXBPIk7YWzXHA4pK:21 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=9VCDzUkOGS52xXVBuocA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=656 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250141

Don't allow the CPU marked as avoid. This is used when task is pushed out
of a CPU marked as avoid in select_fallback_rq

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0e3a00e2a2cc..13e44d7a0b90 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2437,6 +2437,10 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 	if (cpu_dying(cpu))
 		return false;
 
+	/* CPU marked as avoid, shouldn't chosen to run any task*/
+	if (cpu_avoid(cpu))
+		return false;
+
 	/* But are allowed during online. */
 	return cpu_online(cpu);
 }
-- 
2.43.0


