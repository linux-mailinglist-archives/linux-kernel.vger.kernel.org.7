Return-Path: <linux-kernel+bounces-765409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 424F2B23349
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1F71A238BE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED932DFA3E;
	Tue, 12 Aug 2025 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UsGNFw9D"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445252FA0F9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022913; cv=none; b=OUmVb7lXjP0cATupHGCxf+r1V3jnmDamSJWHf+K+7OfhKMG9IrsZnzfsPpY1pOLvBlGOeKbhO5YqnwqR+pBiNva0cOvEuxz4G2VefuST180bPYWNmD40J3YakockHyT9yES5/mnujfkIPDn6gPKKfyBJGXz10NLqGDAhxImbDpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022913; c=relaxed/simple;
	bh=K9tpoL5adIqtnZpXwWu+5W81l2VWsI03IA9jighcrGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dLUV7kcWteUL4pp6Pu/ah13yX1EVO5CU5kMnT/CzwgWoiwmJUc+acNqPN73rP0YgzraQQz/3RHAc+//Xof7JzqMd3Pv85Y1AxqV28O1vs6iTL0uyF76UHGYap8rNARfsP3VSwMigYtKeG3TtZwQZWvs1yBuV7cd0WCXotNHbPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UsGNFw9D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CCCoLP023786;
	Tue, 12 Aug 2025 18:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BhnJXJ
	E+d2mDNDDlQFrlbM73+vFIf5rSe9uOzme4lvs=; b=UsGNFw9DsNDJfFhoDkffq/
	X7HjIfVxQ7WRU3NmhCCJiSZsiEMVp42I7+KydiE+f3z/ltSDEo7vE/1UvutdF2U1
	pOILs5277q1BfJjHpn3XrQxQvqc9eC5XGvG6EZ0lSF4d1c9LyFwIJqUROcXPhV66
	DHU1TcFEaSgP4Uxe4vTTSwxlAtlDtGaTixDIx4mV/XrMnlALCFWokSMxUN59NXvd
	p078z7oGJlhFjD0/Rz8tXMYZrg2ujmbXNIA/B2lbfIrRONyOq+AszVILxqvBvLpe
	GjyWeXPJjlDp/2GqVnwWhHUYGFmvg5FO9T9ccj+0kjGYD+FENVdkQs0FLWyD9swA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48duru854w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 18:21:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57CFdDio017612;
	Tue, 12 Aug 2025 18:21:17 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3kd5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 18:21:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57CILDRj53412110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 18:21:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2679620043;
	Tue, 12 Aug 2025 18:21:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07D4E20040;
	Tue, 12 Aug 2025 18:21:11 +0000 (GMT)
Received: from [9.39.29.151] (unknown [9.39.29.151])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Aug 2025 18:21:10 +0000 (GMT)
Message-ID: <7c70fac4-3cc7-4bf1-a3f1-aa1c61f67425@linux.ibm.com>
Date: Tue, 12 Aug 2025 23:51:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] sched: preempt: Move dynamic keys into
 kernel/sched
To: mingo@redhat.com, peterz@infradead.org
Cc: mark.rutland@arm.com, bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, venkat88@linux.ibm.com,
        tglx@linutronix.de, maddy@linux.ibm.com, will@kernel.org
References: <20250716094745.2232041-1-sshegde@linux.ibm.com>
 <20250716094745.2232041-2-sshegde@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250716094745.2232041-2-sshegde@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: haSnYq1kEpJqLZg92sejXHgMCJiOT0xe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE3NiBTYWx0ZWRfX2uUAJz+sPSMt
 fzHrOb3+ZPGeateZtJF+Rn1YzjqF4st42vzyk59+7uBs+hxuTrRcxv3bE/Ae+ZpUK79eUkfVomS
 rpoRY02k/6a9HDeXaSlF0HNI5wEvaSyDbBhl9rbL1W0q6aYa3DF8JbG3gtk6M7PMh0W9NYqOCHK
 rzGSUkZvysZ+0m+9vQJfyKPrNl+CdO21VKcB1antFsN8iZU1tAQEd/eDizUVMh0qrFDNPQuEdLV
 szNaG5gyhhKXuLx639vevO0JABMaAmSdqSQjbnMVFwGHSEtvhtFUfzZ8Kbkt5dN7YJYg5HozPVJ
 4E3q8XI9zew7V1Yat7WxnRWvLxNGPsmy0i89/9Qdohf+hcMsxZgU8VotHxbeH/k0dnPZgQVFh33
 SdctTqgYbVgYI80EYWQJvrnAxiX4yumyKNLQHZke20CONR0UyLT6FU9hxrg+XLCaNB8MBei6
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=689b861d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=a-Bos3NDH3Xla9YzJLIA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: haSnYq1kEpJqLZg92sejXHgMCJiOT0xe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxlogscore=876 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120176



On 7/16/25 15:17, Shrikanth Hegde wrote:
> Dynamic preemption can be static key or static call based.
> Static key is used to check kernel preemption depending on
> the current preemption model. i.e enable for lazy, full.
> 
> Code is currently spread across entry/common.c, arm64 and latest being
> powerpc. There is little arch specific to it. arm64, powerpc have the
> same code. It is better to move it into kernel/sched since preemption
> is more closely associated with scheduler.
> 
> Plus, Any new arch that wants dynamic preemption enabled need to have
> only HAVE_PREEMPT_DYNAMIC_KEY.
> 
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Will Deacon <will@kernel.org>
> Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> ---
>   arch/arm64/include/asm/preempt.h   |  1 -
>   arch/arm64/kernel/entry-common.c   |  8 --------
>   arch/powerpc/include/asm/preempt.h | 16 ----------------
>   arch/powerpc/kernel/interrupt.c    |  4 ----
>   include/linux/irq-entry-common.h   |  1 -
>   include/linux/sched.h              |  8 ++++++++
>   kernel/entry/common.c              |  1 -
>   kernel/sched/core.c                |  4 ++++
>   8 files changed, 12 insertions(+), 31 deletions(-)
>   delete mode 100644 arch/powerpc/include/asm/preempt.h
> 

Hi Ingo, Peter.

Does this change makes sense? Are there any further concerns that you see?
Also can it go via tip tree?

Patch applies on 6.17-rc1 (at commit ca76508b9352e8c770b58213cc6c4700e459b7c2)

