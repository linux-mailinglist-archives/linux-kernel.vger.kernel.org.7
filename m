Return-Path: <linux-kernel+bounces-720346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3119AFBA8F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B116425E3E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2102620FC;
	Mon,  7 Jul 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F10FRsje"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51368263F5B
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912400; cv=none; b=DqeEk3bGJQ4asFAvPlMMhF75dZyFHMWuQp/fg1dR9Y9wx5MZu4S7SPn02tqHJtjiSixHaf1n0k3T6KEqQQqILd+H7NMd8HCJfunvdVUAC9GIvRKnx96ZFksmdN6iagUF/+CM6nUzRDO/3N1st/VYXSDNg42RyhnNj7CYb4BoNu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912400; c=relaxed/simple;
	bh=k/PpaQCQEs535ejcs5LuYTb+O05KIU+/STEu0fqWQOM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Q8MLI2d/2vK1uWCJ0Ip6hx254y7vF7dxfe3TgDdZWexUfpepiu9bCh0TByDWdJWs/xBPYuHaWQrWREd4Rb5cKdrNU6uEW1BktRBM7ivLrXdEdL6S0NhN892e6PrHGxK9S4IYX1T4JbbPfZpDS89raHXxvUnomzet3ac6UJ6FQNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F10FRsje; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567Cqb8D028461;
	Mon, 7 Jul 2025 18:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U+nR3D
	FbjxLMuHvddfXWk3B7gtnjaSRA8vlM0F+APMM=; b=F10FRsjewtEWG9xY7uFTle
	sgDbdWEggyqwzm+DllaKxk1Av/wmJjU32YKFK3/zPOX5SEfM8DFJmVjqP0hoXBmX
	XI05JtF+XBPUHTCkZIJf9x2ExNOjM1d77aZCJz2Gv9PYW0AUBz+QCmclJOJ4yTcG
	HKXlg7K1vA4nofdVwkMWn0ZHhEcR8Gg7tdsSxNLRgTBsTR3T8SRjyeXymboDYl2H
	z4MZOfclp3foAVIc9chUiEdGm98k9coUxtLhpfAvZYrAo6/PmoBktYPV4hALje0O
	iVtQLCgnf1MPptZsdvqPUdBWvN2ViwaKrqZSVrSS2YeZCSqgUOjsZ8o0UusKcPEQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur6ubq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 18:19:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 567IJ843019412;
	Mon, 7 Jul 2025 18:19:23 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47pur6ubq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 18:19:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 567I1F2e024353;
	Mon, 7 Jul 2025 18:19:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qh3270wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Jul 2025 18:19:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 567IJKbt46006586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Jul 2025 18:19:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF1C62004B;
	Mon,  7 Jul 2025 18:19:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A02B920040;
	Mon,  7 Jul 2025 18:19:18 +0000 (GMT)
Received: from [9.39.27.83] (unknown [9.39.27.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Jul 2025 18:19:18 +0000 (GMT)
Message-ID: <6e274729-af12-4e0f-9e67-5f2d5b099e99@linux.ibm.com>
Date: Mon, 7 Jul 2025 23:49:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] sched: Address schbench regression
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, clm@meta.com
References: <20250702114924.091581796@infradead.org>
 <132949bc-f901-40e6-a34c-d1d67d03d8b6@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <132949bc-f901-40e6-a34c-d1d67d03d8b6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDExOSBTYWx0ZWRfX8Qc1spvMgS0P tV+oiqif3D6tofA8tkf2BXAFUNpoQBJZQ+gJH3CtyPzZcIVjHCfPH5eiTKh1h5JxC+N2V5zyDkr akpiajZPe7KTQ4XyDEUqeAUXK1WjZgRriQ2QIih39qxy4C7eVZ1HNmS5+FrGs7aGSBBI1iQl6ux
 drGUUSzrPCBdWlXJSB4HsmDgrsxKMxavdBbCRHYMreBXsFQCbrPLWgtYfR9TpZdlzt0zSJxkV4/ 0EyeOHNpZ2Nx/7bFMJRBtJMafbSvmn1Kx4pg1AeVeYSsT5DoBNiOF1eiQKM0uAYURjqSA8vT8cs bcd2TITYbcb+BynKEDoZJKm8MYJQMaWI4vm7ahCA6cIJBagHaLS2J9s/oTTsnxKS9oyVD7knbtY
 LFOEdHu4A2WFW6/ALPcRY41bnEJLotrEZ2RLIbKjLYBFC/HRaPTbhuMG/a3ZqZiVNiPHUFCe
X-Proofpoint-GUID: fIJ36tKNIsh3ktdaB2HcY3cJkncCQ1Qu
X-Proofpoint-ORIG-GUID: sDt5DwP3TwtXWSfY_TBm_s2x285IOgns
X-Authority-Analysis: v=2.4 cv=W/M4VQWk c=1 sm=1 tr=0 ts=686c0fac cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=ijCQEoXl7D5pwIERQb8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=592 bulkscore=0 impostorscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507070119



On 7/7/25 14:35, Shrikanth Hegde wrote:
> 
> 
> On 7/2/25 17:19, Peter Zijlstra wrote:
>> Hi!
>>
>> Previous version:
>>
>>    https://lkml.kernel.org/r/20250520094538.086709102@infradead.org
>>
>>
>> Changes:
>>   - keep dl_server_stop(), just remove the 'normal' usage of it (juril)
>>   - have the sched_delayed wake list IPIs do select_task_rq() (vingu)
>>   - fixed lockdep splat (dietmar)
>>   - added a few preperatory patches
>>
>>
>> Patches apply on top of tip/master (which includes the disabling of 
>> private futex)
>> and clm's newidle balance patch (which I'm awaiting vingu's ack on).
>>
>> Performance is similar to the last version; as tested on my SPR on 
>> v6.15 base:
>>
> 
> 
> Hi Peter,
> Gave this a spin on a machine with 5 cores (SMT8) PowerPC system.
> 
> I see significant regression in schbench. let me know if i have to test 
> different
> number of threads based on the system size.
> Will go through the series and will try a bisect meanwhile.
> 
> 

Used "./schbench -L -m 4 -M auto -t 64 -n 0 -t 60 -i 60" for git bisect.
Also kept HZ=1000


Git bisect points to
# first bad commit: [dc968ba0544889883d0912360dd72d90f674c140] sched: Add ttwu_queue support for delayed tasks

Note:
at commit: "sched: Change ttwu_runnable() vs sched_delayed" there is a small regression.

-------------------------------------
Numbers at different commits:
-------------------------------------
commit 8784fb5fa2e0042fe3b1632d4876e1037b695f56      <<<< baseline
Merge: 11119b0b378a 94b59d5f567a
Author: Borislav Petkov (AMD) <bp@alien8.de>
Date:   Sat Jul 5 19:24:35 2025 +0200

     Merge irq/drivers into tip/master

Wakeup Latencies percentiles (usec) runtime 30 (s) (39778894 total samples)
           50.0th: 14         (11798914 samples)
           90.0th: 27         (15931329 samples)
         * 99.0th: 42         (3032865 samples)
           99.9th: 64         (346598 samples)

RPS percentiles (requests) runtime 30 (s) (31 total samples)
           20.0th: 1394688    (18 samples)
         * 50.0th: 1394688    (0 samples)
           90.0th: 1398784    (11 samples)

--------------------------------------

commit 88ca74dd6fe5d5b03647afb4698238e4bec3da39 (HEAD)       <<< Still good commit
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Jul 2 13:49:34 2025 +0200

     sched: Use lock guard in sched_ttwu_pending()

Wakeup Latencies percentiles (usec) runtime 30 (s) (40132792 total samples)
           50.0th: 14         (11986044 samples)
           90.0th: 27         (15143836 samples)
         * 99.0th: 46         (3267133 samples)
           99.9th: 72         (333940 samples)
RPS percentiles (requests) runtime 30 (s) (31 total samples)
           20.0th: 1402880    (23 samples)
         * 50.0th: 1402880    (0 samples)
           90.0th: 1406976    (8 samples)

-----------------------------------------------------------------

commit 755d11feca4544b4bc6933dcdef29c41585fa747        <<< There is a small regression.
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Jul 2 13:49:35 2025 +0200

     sched: Change ttwu_runnable() vs sched_delayed

Wakeup Latencies percentiles (usec) runtime 30 (s) (39308991 total samples)
           50.0th: 18         (12991812 samples)
           90.0th: 34         (14381736 samples)
         * 99.0th: 56         (3399332 samples)
           99.9th: 84         (342508 samples)

RPS percentiles (requests) runtime 30 (s) (31 total samples)
           20.0th: 1353728    (21 samples)
         * 50.0th: 1353728    (0 samples)
           90.0th: 1357824    (10 samples)

-----------------------------------------------------------

commit dc968ba0544889883d0912360dd72d90f674c140              <<<< Major regression
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Jul 2 13:49:36 2025 +0200

     sched: Add ttwu_queue support for delayed tasks

Wakeup Latencies percentiles (usec) runtime 30 (s) (19818598 total samples)
           50.0th: 111        (5891601 samples)
           90.0th: 214        (7947099 samples)
         * 99.0th: 283        (1749294 samples)
           99.9th: 329        (177336 samples)

RPS percentiles (requests) runtime 30 (s) (31 total samples)
           20.0th: 654336     (7 samples)
         * 50.0th: 660480     (11 samples)
           90.0th: 666624     (11 samples)
  



