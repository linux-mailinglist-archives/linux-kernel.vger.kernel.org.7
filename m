Return-Path: <linux-kernel+bounces-898903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 146EEC564C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1615C4E87A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F025733121A;
	Thu, 13 Nov 2025 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LolwtAlj"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078F3271EB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022450; cv=none; b=Ccnfi/FkAl3cjewFXuj233kR+7I9dMOJiHhn65e+c8F5JJ7Tf2HvnKEH3ztkmhEGsTALii7yLikzr1M4+6CgkUovZkieYhcOUQAQ3Skl2b4EKPDEsXN957hAn0qpyv8bEBrEc7n6fswvPZSzWOMLR3gF4pIi6iRHCz93TYk+kpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022450; c=relaxed/simple;
	bh=PuG34t9+j6zB0f3y1tpIvRmHaccqNJnOTVY9kYs5cu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzRooHzaJ74ke5843yHHy5xpbhAmrTgkoHXBwQCR0pPA/55KPCkxpv0TiIenRdqyXJTJNC4ySyxN1prbBvU+kpkpuxp4ipxLF/BzoPVITkWG00MI+vsoSVg6+RxLUGYEtYpVlDMLFXO6DCmzuQZowLJSo/b2r2x1kKkomshBp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LolwtAlj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1rG1i000345;
	Thu, 13 Nov 2025 08:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9fOcWR
	aeGQMUxKokZXHhd3mPxuTy97rpeFzP3qFf75Q=; b=LolwtAljOe+f1Opa+jNiUi
	e23eALtnyt5bfHFQRhB944ziQyTL9cx/SSRvinq2sIx5INpRZLLAmw2eOKHVGM7N
	383jsl39/Kk5AKTu0EVS//ERizIHMn9i7MlNY7xaTfC19M0xhmAfruzy8Gccw5mn
	Hzyq2rjEw8KTyi/rYoojCDJKY2sSl/nfuOs/9f1m+HiYDba3/yAGBQ8EbOQGHlVj
	QOSw62wX+762ZW9wyPh1kpnlmQ1s/sc6182sfokdwwGglv/BlxbNJLbKvIgxNct/
	fJiAjrsEvVLVdcMDykdIa/9Y4fZNqAYVKuHZIstGXMdHKmzZEYYGsRGnPiamxdiw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgx59gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 08:27:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD4ocu8011605;
	Thu, 13 Nov 2025 08:27:09 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1mg5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 08:27:09 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AD8R9Hl30278266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 08:27:09 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A11B58068;
	Thu, 13 Nov 2025 08:27:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EA3558052;
	Thu, 13 Nov 2025 08:27:06 +0000 (GMT)
Received: from [9.98.110.226] (unknown [9.98.110.226])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 08:27:06 +0000 (GMT)
Message-ID: <2841a37f-a6d2-44dc-9578-b40804e960d0@linux.ibm.com>
Date: Thu, 13 Nov 2025 13:56:13 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/fair: Reimplement NEXT_BUDDY to align with
 EEVDF goals
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>, Chris Mason <clm@meta.com>,
        linux-kernel@vger.kernel.org,
        Madadi Vineeth Reddy <vineethr@linux.ibm.com>
References: <20251112122521.1331238-1-mgorman@techsingularity.net>
 <20251112122521.1331238-3-mgorman@techsingularity.net>
 <20251112144823.GE3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
In-Reply-To: <20251112144823.GE3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DhursG3foKX_uf7bIRw6YdPsaEK98Gwd
X-Proofpoint-ORIG-GUID: DhursG3foKX_uf7bIRw6YdPsaEK98Gwd
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=6915965e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=12gGZJXDivS0f4jQg_wA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX6Ov48NrvoCe9
 jC1pppHDrxSrUGnG9DPwQkiIIU2qVKkrn+I96rd3bB5koQWErxdXV9RbFNAIB9GmPuBOve/6pDx
 Xha9O6UMfMFCjgm0KVrSB19cKGUZ51moN/lDoALTBupN/nh3oOprZax5PJb5FL5k3bm9dXqzojI
 xe9jINGYsXhHf1HCIh87VxOrVsbJRHPbv8g7ciQT1372jW1TGcl0pkG3jvzX37C0eZ/ftfHTVBm
 Ly8lHY0I5Be3CrVsQwkiRP6G5ZilpvsnRV83aWGVUwS5VFldCy0N84E0jbUwecvAvNw9CDQ588L
 poxn0/OiTShEmAwi8n9GLApOLcVjgTE6BZcpBR8KvNx0Vz310S+VEIU8L9fTVqBvgnwk5HJJ1o1
 n2gmNhJLx2cufQKpiBCzspyKFPScMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

Hi Peter,

On 12/11/25 20:18, Peter Zijlstra wrote:
> On Wed, Nov 12, 2025 at 12:25:21PM +0000, Mel Gorman wrote:
> 
>> +	/* Prefer picking wakee soon if appropriate. */
>> +	if (sched_feat(NEXT_BUDDY) &&
>> +	    set_preempt_buddy(cfs_rq, wake_flags, pse, se)) {
>> +
>> +		/*
>> +		 * Decide whether to obey WF_SYNC hint for a new buddy. Old
>> +		 * buddies are ignored as they may not be relevant to the
>> +		 * waker and less likely to be cache hot.
>> +		 */
>> +		if (wake_flags & WF_SYNC)
>> +			preempt_action = preempt_sync(rq, wake_flags, pse, se);
>> +	}
> 
> Why only do preempt_sync() when NEXT_BUDDY? Nothing there seems to
> depend on buddies.


IIUC, calling preempt_sync() Without NEXT_BUDDY would force a reschedule after the threshold,
but no buddy would be set. This means pick_eevdf() would run with normal EEVDF deadline selection,
potentially picking a different task instead of the wakee.The forced reschedule would accomplish
nothing for the wakees.

That said, I see your point that the WF_SYNC threshold check could still reduce context switch
overhead even without guaranteeing wakee selection.

Thanks,
Madadi Vineeth Reddy

