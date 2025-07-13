Return-Path: <linux-kernel+bounces-728898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7223AB02E9D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 06:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFB217AA7F3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 04:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1026117C224;
	Sun, 13 Jul 2025 04:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oIblAkQU"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC43139D
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 04:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752382270; cv=none; b=aRNdrGwfJDD9tvE4nJSFyGlrK4u9wZ+0f4/Vv4nVRsrZQCSrMa2QfY18jjGm77BumSigzTv7xY5WSFwfo8spB5HGVQGLWQGryBBOL9R8YTrbFJhjfwRFyjXM4O2xIE9oS27eWfjdWo+Q0VykvWHc1rJbS+oyPgYb6AJUxEHqdgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752382270; c=relaxed/simple;
	bh=0DH++y7qfqKW3YYHvOQGAHrBFFFcsimAz3rQ+j6b+l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iXPuGGDSHHjp470x1hmWScZAlN/cP4qAEvHDNKPP6Yc2Xwr2J7hmXspLkPcbBQoo4CcR1l6VfLDwEvr18yGi2QF/yeXpwJrmL1Xto1o6/2u8Zolgbe/apOuZ+OWoRO8HgPR/0N2/XBQJJjmNRry8TyGDvCtwWcTodGQ93il3Pgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oIblAkQU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56D3lKHd001746;
	Sun, 13 Jul 2025 04:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dhVnn9
	oBQOlvVq1kk6qTWJFdDnYAyts4LCi2yUiUKEE=; b=oIblAkQU6ToqN0WUEt+A5X
	/pIeB9f0kW65XcJPOeCDnyatJQewfof8YfosZr02ntbnDw3ov0A668KFA1BwR7vg
	rEvCawvBffmgImGePQclGxKty42egtoTbew3Fxq1FLonKHzb8LHUJKRp7vfp/0i+
	2AzbxSTJ08vuTy9lXdOzQuNZmCqV9pimGUYsgIfytQQJmi6D40n5YsaMEtPr+kpr
	0ex4vGmCrGJHK2zZ4sM6Gqkf+HMI27qSY1mT4VDtwaIC93rK77y46BSw0Ze8T0Ti
	bBd7S38TuiyUPmCY5Dyj47oA35+vnnlniOrA5mAZ6iH6jm1PEmzcLNgIUOCrLW1g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tkwa3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 04:50:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56D1rY6P008988;
	Sun, 13 Jul 2025 04:50:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hm8emn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Jul 2025 04:50:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56D4oTMd51708184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 13 Jul 2025 04:50:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26F4920043;
	Sun, 13 Jul 2025 04:50:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E17820040;
	Sun, 13 Jul 2025 04:50:26 +0000 (GMT)
Received: from [9.124.216.30] (unknown [9.124.216.30])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 13 Jul 2025 04:50:25 +0000 (GMT)
Message-ID: <3de6a9db-a122-420d-a845-2087136a0d6c@linux.ibm.com>
Date: Sun, 13 Jul 2025 10:20:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched: preempt: Move dynamic keys into kernel/sched
To: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, maddy@linux.ibm.com
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, bigeasy@linutronix.de,
        vschneid@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250610075344.1379597-1-sshegde@linux.ibm.com>
 <20250610075344.1379597-2-sshegde@linux.ibm.com>
 <aFBIPxOGbWfTCWLm@J2N7QTR9R3>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <aFBIPxOGbWfTCWLm@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68733b17 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=7CQSdrXTAAAA:8 a=4h1QD_Op0GHrj0-FCVcA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: skcW1Oe02RnZYG-SKJ1KYpXU51jS84kk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEzMDAyNiBTYWx0ZWRfXwrfTMly69tXK uvZUPlOwIZIWBb/7OLnKcJ0518rgZEB44HexOIlE/uNGm25iwK4hU9rTr0dO2Re6rxND8tndjCM y06JtwSpz2xJwQaZRZC10+VaOGTZ46U7hd9iX8MuFwCG/kz6g4KfvJzjz2cd6i1ndXOmCUNX6X+
 EUAefFzdyoW+gifKce1c4iLDv6hTAA1tUb3lQ/5rqybzWtORbwrQFwFV6of9VxAArX3VDenZ8RQ gGjTbZpQVZtCUFjC0yadlBDx02jPsGDhJiGGjNM+HQkxT3px01seye+jZmsP+kJoUMR32pbv711 5giQoYiu/qS3OoCbv48htI9O8QbDnie+q1eBMU5pCi02Zx4c5KssGjRCzymTVoS4oZK8wDPnTvh
 sVARekjjEIJot2r3HwpIFmGZ+DZ8E0CiYvGUMwx69H0IcR7YORtsYUsA7BzXUTVh/3xU0G13
X-Proofpoint-ORIG-GUID: skcW1Oe02RnZYG-SKJ1KYpXU51jS84kk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-13_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507130026


> On Tue, Jun 10, 2025 at 01:23:44PM +0530, Shrikanth Hegde wrote:
>> Dynamic preemption can be static key or static call based.
>> Static key is used to check kernel preemption depending on
>> the current preemption model. i.e enable for lazy, full.
>>
>> Code is spread currently across entry/common.c, arm64 and latest being
>> powerpc. There is little arch specific to it. For example, arm64,
>> powerpc does the same thing. It is better to move it into kernel/sched
>> since preemption is more closely associated with scheduler.
>>
>> Plus, Any new arch that wants dynamic preemption enabled need to have
>> only HAVE_PREEMPT_DYNAMIC_KEY.
>>
>> This is more of code movement. No functional change.
>>
>> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> 
> I've tested this on arm64 atop v6.16-rc2, building and booting defconfig
> and defconfig + PREEMPT_DYNAMIC=y.
> 

Hi Mark. Thanks for testing it. Sorry for delayed response.

> It builds cleanly, boots fine, and I think this is obviously correct
> given it's just moving things around, so FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Catalin, Will, are you happy with this?
>

Thank you will for the tags.


> I assume this would go via the tip tree?
> 

Maddy, are you okay with this?

I would request it to go via tip tree.

