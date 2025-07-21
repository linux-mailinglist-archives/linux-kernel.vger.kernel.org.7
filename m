Return-Path: <linux-kernel+bounces-739794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A770AB0CB0C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B863E5456B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC322FE10;
	Mon, 21 Jul 2025 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NhobCdjH"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38DA1F418E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 19:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753126652; cv=none; b=M2hJJWsTrIcDkCCBnOO/K4Ln5wv99Gcl0Vj1gYFEefWScO/tw2g7B41Rxoab29BYcrtS40U0xvxkAnOCw/HpqpRn2N9xt5ka0x5Df/y33zTBo9jH33XDjPc6yL/i/Q/je9Psu1C/954BYDkFfBtByG17ZFfOJoCbHcMNER1R5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753126652; c=relaxed/simple;
	bh=fXKxtn/aSh3rKnt6u5UkOfJxz2a3BArVpWweUcEDLgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6SIoItWpSmaTNAOYGU0X3FN068fXP77EU4kj+z4I6CCNmYm9gIylVrtXVYLL8zoSwHVUbtsU1Qbd6gablR3Vjwps3PzxQsTWRM8kc7V6CM2bT3oBFdJlB4ogVotw/2fgPUKEmDLql2XCmAeTtzNTn7qP+4i6k5AtbWTmboeN5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NhobCdjH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LD0IMw031219;
	Mon, 21 Jul 2025 19:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CiwYbi
	spmNtUu13BflFhs/FLaYu2PLHQYtEYwhxmPUc=; b=NhobCdjHxN1mKfx0Ngs1YT
	MESPknVp6763hLIzmvAPzDG2ij8Mh/29DepxmtnzXpTMcPaFD59fNtoRgFLmQweY
	0GeB69Kp3UA/l+UHKNDLCZruyMSzFmyyaIfwGsBELiyoAbR1QyE8NFB8Kn1tCZTF
	ldzgkNUyyAxBLYP8rZTNm/1XA/xLmFqCA4EvWhmgeO9vp4/QyJc97VOOVEcdW5sT
	BOPrAzgzWJxU5HSI74GsaaKZ4CjpWGqfBhdfLHSi/ARUIAUwZbHpHqOY+mu7k9Sl
	HfLXMg/Oi4L6R+eaJN731oqWb/tY4r/hYsQ9U974QclnXnA8NYRbS3dTnuvwk7IQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqthkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 19:37:16 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56LJagKe004966;
	Mon, 21 Jul 2025 19:37:15 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqthkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 19:37:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56LFqboI025138;
	Mon, 21 Jul 2025 19:37:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptfup1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Jul 2025 19:37:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56LJbDbR54460744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 19:37:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 359FF20043;
	Mon, 21 Jul 2025 19:37:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D071520040;
	Mon, 21 Jul 2025 19:37:10 +0000 (GMT)
Received: from [9.39.18.215] (unknown [9.39.18.215])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Jul 2025 19:37:10 +0000 (GMT)
Message-ID: <cc582ddb-2f16-4c0b-be27-b9a1dedb646a@linux.ibm.com>
Date: Tue, 22 Jul 2025 01:07:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] sched: Address schbench regression
To: Peter Zijlstra <peterz@infradead.org>, clm@meta.com
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com
References: <20250702114924.091581796@infradead.org>
 <132949bc-f901-40e6-a34c-d1d67d03d8b6@linux.ibm.com>
 <6e274729-af12-4e0f-9e67-5f2d5b099e99@linux.ibm.com>
 <20250708190201.GE477119@noisy.programming.kicks-ass.net>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250708190201.GE477119@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 79GYl9vTeoUMMV_cHdbL7bBnEnTU3GGV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE3MCBTYWx0ZWRfX2/TPpexSfZVN
 u7fB9GYGhCeIMZctwBOMZYn5qRbqVGr+IPaR3FFoWzdGec1ZEWCsRMRsmv8GVyEnoLYVNWBaDku
 P0kyIxLkbq5wVpEIS6by8hVktU9qgBBno4J7fAKXDiyXDkOzrKVs31FMLfvongJV/Vr4DhdGxe5
 KsD8u86xbOmOAU/3kfyZG+4s+48nP9+TBSdaF4nkS4BWwb5wpBbG1mOOrEFh0I3Pv/lnLVyq5B9
 REL9vUw1Z3s4srfnsaToivAmEs2Wb1T4bns6nrkrvsD5WXGlEop2VHM7paTcDLk5fTbsbJ0xS4C
 V7GZTNsAg6n98Ng35mqnHAWjYbHQdusVXklSeLIKxDaERxk4f/GtOG/qrCpJBcx/0cREo3zJqr1
 UP/Nyd2uxyvNi9ZWrgfPptahWgnpzSZVVAbVkYyb1cJs8ynAQCLudYhCCWwa8eSKqbARK7zB
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=687e96ec cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=r6rNkULCFl-4_LuMYwIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Gsegn909I9XXRI-I00BJbAbScbcfD3dv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_05,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=979 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210170



On 7/9/25 00:32, Peter Zijlstra wrote:
> On Mon, Jul 07, 2025 at 11:49:17PM +0530, Shrikanth Hegde wrote:
> 
>> Git bisect points to
>> # first bad commit: [dc968ba0544889883d0912360dd72d90f674c140] sched: Add ttwu_queue support for delayed tasks
> 
> Moo.. Are IPIs particularly expensive on your platform?
> 
>
It seems like the cost of IPIs is likely hurting here.

IPI latency really depends on whether CPU was busy, shallow idle state or deep idle state.
When it is in deep idle state numbers show close to 5-8us on average on this small system.
When system is busy, (could be doing another schbench thread) is around 1-2us.

Measured the time it took for taking the remote rq lock in baseline, that is around 1-1.5us only.
Also, here LLC is small core.(SMT4 core). So quite often the series would choose to send IPI.


Did one more experiment, pin worker and message thread such that it always sends IPI.

NO_TTWU_QUEUE_DELAYED

./schbench -L -m 4 -M auto -t 64 -n 0 -r 5 -i 5
average rps: 1549224.72
./schbench -L -m 4 -M 0-3 -W 4-39 -t 64 -n 0 -r 5 -i 5
average rps: 1560839.00

TTWU_QUEUE_DELAYED

./schbench -L -m 4 -M auto -t 64 -n 0 -r 5 -i 5             << IPI could be sent quite often ***
average rps: 959522.31
./schbench -L -m 4 -M 0-3 -W 4-39 -t 64 -n 0 -r 5 -i 5      << IPI are always sent. (M,W) don't share cache.
average rps: 470865.00                                      << rps goes even lower


=================================

*** issues/observations in schbench.

Chris,

When one does -W auto or -M auto i think code is meant to run, n message threads on first n CPUs and worker threads
on remaining CPUs?
I don't see that happening.  above behavior can be achieved only with -M <cpus> -W <cpus>

         int i = 0;
         CPU_ZERO(m_cpus);
         for (int i = 0; i < m_threads; ++i) {
                 CPU_SET(i, m_cpus);
                 CPU_CLR(i, w_cpus);
         }
         for (; i < CPU_SETSIZE; i++) {             << here i refers to the one in scope. which is 0. Hence w_cpus is set for all cpus.
                                                       And hence workers end up running on all CPUs even with -W auto
                 CPU_SET(i, w_cpus);
         }


Another issue, is that if CPU0 if offline, then auto pinning fails. Maybe no one cares about that case?

