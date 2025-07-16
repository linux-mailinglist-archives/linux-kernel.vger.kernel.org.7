Return-Path: <linux-kernel+bounces-733293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6518B072CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590521882F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952372F2C6B;
	Wed, 16 Jul 2025 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lQpTNV0L"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C5C1D5CED
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660692; cv=none; b=ZsN72IreA4hcDo5Wdce8EEzw5XkmyOfLCUF6E+1BBqxKtEYHP4zQdiNgUPEujTyxgq7nnmTiv5kTWNi/Xo8RxaNz7AFeXfw/YAvLQcnLElaAEZEJj+D27d3PspL+bfYJWAS6t/nMlg2v0N/XcCWgAlwstWzAoJm/YByuq+7UYTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660692; c=relaxed/simple;
	bh=0k8sIBC2eJaqsXE9Vm0H5ySguhM1Ecpxm4KlMor9gWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BN/InvQiIaQRhavPpZ2x0jAQ0UvryUdjK4iHhetBpRX8IiZO5jpAQHlyBgFBK/Y38Ren0aTlzJq/u18qhRrN6LeH5k/NLY2KPTXF6pJB0nxw+7x+O505eS+8Yg+P+EJy4yzCbpN5OS3dqTim5KeZHZ8u02JADVd43ZjeL1KI1m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lQpTNV0L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G7YUhg022357;
	Wed, 16 Jul 2025 10:10:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Jcbuww0Va+k2vq1pry8cOViN1poGtKzkSjZo/Hirn
	JA=; b=lQpTNV0Lw4FMtcf1W58ihMsnSYzgdQk46cfxQRx5vO9tcm70Z3OoL26YM
	BD5Oyj1YppQpFxH39uOJn5Y2GLQ2f6+Fqx4SxxP8edq4Bfxhr5ME22ymd5P6RcvZ
	AoDZDJbRzFNhXxaCSHPpEE3I5fQ/t8ykh5ym0x1nIir9SPYJZOeArSnDUp4LsIN+
	wAD0p0xOMYMwCuU4uW4w8uBUY4cp2z4B7csFFecScOxKv07HKYNrbQiEYqSpVvwM
	Zz5HYW5KgQgYV8boxfEPpFqXsx9oPLaR2KpbHtq1k/2vyiU/amlrRa2RXseVuDbk
	hNIwJWGcWWf7yljOlr5S+faQke8Hw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vdfmqatw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 10:10:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56G7J2cR008909;
	Wed, 16 Jul 2025 10:10:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmpsb0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 10:10:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56GAAV1E36372806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 10:10:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66D702047D;
	Wed, 16 Jul 2025 09:48:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 227FE2047B;
	Wed, 16 Jul 2025 09:48:12 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.218.143])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Jul 2025 09:48:11 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        maddy@linux.ibm.com, will@kernel.org
Cc: sshegde@linux.ibm.com, mark.rutland@arm.com, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/1] powerpc, arm64: move preempt dynamic key into kernel/sched
Date: Wed, 16 Jul 2025 15:17:44 +0530
Message-ID: <20250716094745.2232041-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4ZzsJPwZ79ZXwGaz41k8LXOnSjIdcWG5
X-Authority-Analysis: v=2.4 cv=JOI7s9Kb c=1 sm=1 tr=0 ts=68777a9d cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=cMfPdojDCaELe1LC6y0A:9
X-Proofpoint-ORIG-GUID: 4ZzsJPwZ79ZXwGaz41k8LXOnSjIdcWG5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA4NyBTYWx0ZWRfXxseXy56oR2xP Ro5dB+r0rxy6hYoJw5vnymvDbhknESe6PeXTUWvp5DHBC2N563erNLiWIYixLA3LaehqZt3/+ED hAQ7hEZ4UX468X9HAWGmWPzdWLM4gkfUL6mRJIAPAZUkbo2TKx6dpl76vcHgvlTUWEiRZBq35CL
 GvHm/f42MeaiRtNfRzXpOepIZQLAzrfbZNQgdttGbNlp4jn+mrVRA9tSL1XlW2zdvYbS7HDPuj4 4pBBHoab1RGdBYvz4V9qEQ/uDUzsOdvSfnz67VcMBEP/j4q9H38tZqR9KddjrzVERTSep1QvAC+ TbTaq3+AkUeRT5zgls5HKb2XA9yXqu4UAY+devH9hq85brqcPoyYX7wwl7E2Qv5HSVvIR9K1DqP
 OatUde+g3/sEVKxI0FCcoDIuJT0rTp3/ZAyN9ytpthvPrVCDvqRaJAW5rZ5nvO4i5xRHNdES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=568 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160087

Current usage of preempt dynamic key is not specific to architecture and
can be moved into sched/core instead. Most of the code around it looks
similar. (same code for powerpc, arm64). 

Since preemption is more associated with scheduler rather than
entry/exit, it is probably better it should be moved. 

This is tested on powerVM PREEMPT_DYNAMIC=y/n and on arm64 by Mark

v1->v2:
- Rebase to 6.16-rc6
- Collected the tags

Ingo, Peter, 
Can this go via tip sched tree? 

Both arm64, powerpc have acked the changes and been tested. 

Shrikanth Hegde (1):
  sched: preempt: Move dynamic keys into kernel/sched

 arch/arm64/include/asm/preempt.h   |  1 -
 arch/arm64/kernel/entry-common.c   |  8 --------
 arch/powerpc/include/asm/preempt.h | 16 ----------------
 arch/powerpc/kernel/interrupt.c    |  4 ----
 include/linux/irq-entry-common.h   |  1 -
 include/linux/sched.h              |  8 ++++++++
 kernel/entry/common.c              |  1 -
 kernel/sched/core.c                |  4 ++++
 8 files changed, 12 insertions(+), 31 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/preempt.h

-- 
2.43.0


