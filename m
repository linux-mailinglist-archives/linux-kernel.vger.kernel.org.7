Return-Path: <linux-kernel+bounces-732303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4CCB064DE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 19:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE43618856B4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EC927E052;
	Tue, 15 Jul 2025 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OqP4yE++"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E119F464
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599090; cv=none; b=VvD8hNCutT9B7gio8fgLoN2JFo66XQQMraYmnN0p0MpIwrasn+qYC8xmUryt8crYp3AMj+tuCja4VLfaEmStMWSnaJe0VWoSP9eyMLkJ3s3OnITFxcx8W3Lxip+mDtPuhkh5fUnuU4iIsJbi+FhlSatgVlBo8+2l4PZtxlKhRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599090; c=relaxed/simple;
	bh=3qxGmktSsRF9vQ4LgohfW7cp1sf34H7E1Kn75jahbFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3Gz+doivepkStXc0TUBLVm/11qsz5tBH+q9cgXSH+7Bk2pqxVJ1/dufQEC83Zhwcieg9tToatFk+weHkIo2/lgv3Tnm0x2Rnz0vOqHuS4Y4aTm4OMmOQznHTOozUj0Y+QwGrRDCuUMvf+jXalyfjV0iyu84gAaHDQ6OT4PYp3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OqP4yE++; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FFHFoa027589;
	Tue, 15 Jul 2025 17:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nOl7ms
	D1HBeiHfswOOmm368DWRfTbx9x2nCdJCDdHY8=; b=OqP4yE++Uji7Zvw5JgLpqI
	bBKyRYa6csKltR9P3HHWU8GIiecpnLuboM4vmiRddvS2B26wYNqu5TJ8sweAoIMv
	tOEtGwtO64rTHdgMGREzX0hrOTrX2/sxOBY9jhJBki01UI59PerQNX5sh2SL4kqP
	3QCQlYOhgC73kF5B6z9GTvGf6cIOMgvjspgp+FrmMAyGWHk4pbwW0XXjBOKgQLHC
	2487pvziU9xGQ/o+P3grMvXHKusu/JzE4kDPd7gd2n753bjHTSHPDYWQgeXEMpps
	S5G6ULUcTGdotK9Q6lQqcpZzQmnZIgDetuc031yDkMRXWNo57OldMZ/53WHiN+Lg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vdfmkek2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 17:04:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56FG8Oul031985;
	Tue, 15 Jul 2025 17:04:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v21u3nhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 17:04:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56FH4SwU46465514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 17:04:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BADA20040;
	Tue, 15 Jul 2025 17:04:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC0FD20043;
	Tue, 15 Jul 2025 17:04:25 +0000 (GMT)
Received: from [9.124.217.184] (unknown [9.124.217.184])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Jul 2025 17:04:25 +0000 (GMT)
Message-ID: <88edcfdf-2253-4563-a895-6e8bb1625800@linux.ibm.com>
Date: Tue, 15 Jul 2025 22:34:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] futex: Use RCU-based per-CPU reference counting
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Valentin Schneider <vschneid@redhat.com>,
        Waiman Long <longman@redhat.com>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
 <e0f58203-22ef-44c0-9f7b-b15c6007249b@linux.ibm.com>
 <20250715163134.pM1J2XO9@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250715163134.pM1J2XO9@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yTPuAkgSrMYMKJKd42BTTAfL7UusYFob
X-Authority-Analysis: v=2.4 cv=JOI7s9Kb c=1 sm=1 tr=0 ts=68768a1e cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=eVKed6vL87oTk6cZQCQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yTPuAkgSrMYMKJKd42BTTAfL7UusYFob
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1NCBTYWx0ZWRfX418sdu+gHd3i YPYEXmAT1d1gAYgCwN+zpSWwF7PP7WDsH+Ri+fCJAqEzpUHPIjuwK3byQWXwZdNK8ZcZ/NZW5M/ UOQ+HBoJfXLGkOrwFTtqvgfdd7yOY4Ql3X6GeRL+WN0ZQ/E7KPLZi9jfVu5xJvPyNzFW3K69KLv
 E77xjIPsRE8/OAMi1oDx+QRfMeOM+8Z0jv6ZuNF5ajLRnEbOlkUOJLiOqKdYyLc5g++R/9Sf8UF kKq7SG8iLozbn3nLaSxtX87zj5eFS2NtREH1i2eV8OWP5vY2dyPaV0sl8rCwN46c8te3mslFTG+ C5o896a+ah7LrkQygE28Phx/Pw22B+0pnyY288s2oGaQvQZ5FKYeOv8Z9SIJRQKss0Th92pvRiY
 mr2DPkpU7g7s1Ko3DixG43qBqG9X4w0YXbGV+5oZxo9fTGy4ov9ftCbOZ4KfkTZTgWrIodYG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=800 malwarescore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150154



On 7/15/25 22:01, Sebastian Andrzej Siewior wrote:
> On 2025-07-15 21:29:34 [+0530], Shrikanth Hegde wrote:
>> Hi. Sorry for not stumble upon this earlier. Saw these now.
>>
>> Since perf bench had shown a significant regression last time around, and
>> for which immutable option was added, gave perf futex a try again.
>>
>> Below are the results: Ran on 5 core LPAR(VM) on power. perf was compiled from tools/perf.
> Thank you.
> 
> If you use perf-bench with -b then the buckets are applied
> "immediately". It mostly works also with auto scaling. The problem is
> that perf creates the threads and immediately after it starts the test.
> While the RCU kicks in shortly after there is no transition happening
> until after all the test completes/ the threads terminate. The reason is
> that several private-hash references are in use because a some threads
> are always in the futex() syscall.
> 
> It would require something like commit
>      a255b78d14324 ("selftests/futex: Adapt the private hash test to RCU related changes")
> 
> to have this transition before the test starts.
> Your schbench seems not affected?

Yes. schbench shows similar number.

> 
> If you use -b, is it better than or equal compared to the immutable
> option? This isn't quite clear.
> n


I did try again by going to baseline, removed BROKEN and ran below. Which gives us immutable numbers.
./perf bench futex hash -Ib512
Averaged 1536035 operations/sec (+- 0.11%), total secs = 10
Futex hashing: 512 hash buckets (immutable)

So, with -b 512 option, it is around 8-10% less compared to immutable.


