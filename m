Return-Path: <linux-kernel+bounces-724133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63583AFEF01
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B011C409B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C2321D599;
	Wed,  9 Jul 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UeUjtbKj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC8C5695
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079635; cv=none; b=lREppRQpZdTFnvD+gzBBRFaBq0P7SdTymlJOnUMlSp1LWAUtcm8+rIhYEb6nnajs72VF9ud0iQSMA2VFpSKoyWUmhNaBsO+ZJrXsasfhzA9YRU12JqNAagecwTa9mqawPS7PgClQYWosf1obPw5J+Mciqlq0bLDwYTjA+T2ikJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079635; c=relaxed/simple;
	bh=CVQHZKEmgZo7IUZApUGS2SME564ZbNSxqe7NGTqCD1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEGaRy55NEH0z8mTNXzlkAMKpVzfORF9Pnucb7Fzk4GwWtd5WrRkt2zD5YlCAXNwuTP+FFGHAWBY+GstHLEi7dm09fjCVq+ofLNyuagvipVqNlWx4ovN+BaXQGqdAjeTlhLlfzTGPvNFbEsmmOFwkKcfbC0671CyH9eR2uQDDDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UeUjtbKj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569DuiYR018414;
	Wed, 9 Jul 2025 16:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y0Oxo/
	hK2K2nINnLnmt0ishLWRn1k6wjlHdZ+W1QE00=; b=UeUjtbKjwoffd/7O73e9Zd
	zJNAfVeHYuI6/Hv9VHrlTMVkhQ0PgJbUaH0ZrnywDnLe0JYbZhomaqz17aSG+MMu
	kYDOSH/R5WBXI7WwgksACQktlMbZQ96wXAQ0h3xGjms0Z9hBcEwq4q19K8f/aS6I
	zaRc6OWRlVHR9YLIKIHG5OftGwWv24zEoqQDHSSVXJsOrx9a2vxCCAxQKnLNiRyM
	hVtVs+KP8sQ2Diw8VZeapxXYBQ0o2o/50qLioJXYN2L3ty6dqvpl8q/9krDZXhV1
	AT4o2rFQR9OLj+YMdj3uaGd6Gg5OtQ4LmBtZIlH4sumLBxAltGMtdfZIewOpEdHQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss7kbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 16:46:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 569GgSSi023422;
	Wed, 9 Jul 2025 16:46:59 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47puss7k9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 16:46:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 569Fho4X003362;
	Wed, 9 Jul 2025 16:46:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmh087-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 16:46:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 569GkItd45482478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Jul 2025 16:46:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 522ED20043;
	Wed,  9 Jul 2025 16:46:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C069420040;
	Wed,  9 Jul 2025 16:46:15 +0000 (GMT)
Received: from [9.39.28.192] (unknown [9.39.28.192])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Jul 2025 16:46:15 +0000 (GMT)
Message-ID: <d5cb15bd-1096-45a8-9da6-a37ff490714c@linux.ibm.com>
Date: Wed, 9 Jul 2025 22:16:14 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] sched: Address schbench regression
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, clm@meta.com,
        Madhavan Srinivasan <maddy@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Vaj3PEp9 c=1 sm=1 tr=0 ts=686e9d03 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=q0ykA1uNpUhDFEWkyIsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zIVBReXMJ1BiUSFTXrLiEzP164JkLQUo
X-Proofpoint-ORIG-GUID: 631Cs8HRQWiyb5-bD_GoiWs0x-jmOU2_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE1MiBTYWx0ZWRfX9kPlOcyAyczN LV/JlK8VevlERsoZMdNUVZgkiiefIAyqeN7hDFNLw4qKx5d4BVaWdsZD4hUiCrzVJls9N9FY2sx VsonLNJzVrTE9kFxofV6nF9nRnkfLQpN2VIqdZZB5Nq0g2J6KMEXfrAT3PX9OpbNw7hQFsW+jie
 XynZdN/3JlFagrAfNVm7BxuwGO8gMmSCPGTzv2HPCiLGT8M5K3pTQEpsWXopJIy6t7UrJ6SlDQd lYBXV25t3Bh9KjHjM2ufM3iQ+NA0H8QhOBZaYaDMgY2qDEsKjufIKQ8+WmF57GjNFXa+49YK401 APGasbCOLrE22OdjWtLk8Yp8XNIEiQkyWkKeXyD+OtlAHdxGl93p44eDe2dqjLKy3O4wAwm4WrX
 fSzvptrQsyspvhmVG48f79rHizDeVVVRZVDh4yoW7D+GzX/aR43CqOS3IJ8nXn0FkUYxykaj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090152



On 7/9/25 00:32, Peter Zijlstra wrote:
> On Mon, Jul 07, 2025 at 11:49:17PM +0530, Shrikanth Hegde wrote:
> 
>> Git bisect points to
>> # first bad commit: [dc968ba0544889883d0912360dd72d90f674c140] sched: Add ttwu_queue support for delayed tasks
> 
> Moo.. Are IPIs particularly expensive on your platform?
> 
> The 5 cores makes me think this is a partition of sorts, but IIRC the
> power LPAR stuff was fixed physical, so routing interrupts shouldn't be
> much more expensive vs native hardware.
> 

Yes, we call it as dedicated LPAR. (Hypervisor optimises such that overhead is minimal,
i think that i true for interrupts too).


Some more variations of testing and numbers:

The system had some configs which i had messed up such as CONFIG_SCHED_SMT=n. I copied the default
distro config back and ran the benchmark again. Slightly better numbers compared to earlier.
Still a major regression. Collected mpstat numbers. It shows much less percentage compared to
earlier.

--------------------------------------------------------------------------
base: 8784fb5fa2e0 (tip/master)

Wakeup Latencies percentiles (usec) runtime 30 (s) (41567569 total samples)
           50.0th: 11         (10767158 samples)
           90.0th: 22         (16782627 samples)
         * 99.0th: 36         (3347363 samples)
           99.9th: 52         (344977 samples)
           min=1, max=731
RPS percentiles (requests) runtime 30 (s) (31 total samples)
           20.0th: 1443840    (31 samples)
         * 50.0th: 1443840    (0 samples)
           90.0th: 1443840    (0 samples)
           min=1433480, max=1444037
average rps: 1442889.23

CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
all    3.24    0.00   11.39    0.00   37.30    0.00    0.00    0.00    0.00   48.07
all    2.59    0.00   11.56    0.00   37.62    0.00    0.00    0.00    0.00   48.23



base + clm's patch + series:
Wakeup Latencies percentiles (usec) runtime 30 (s) (27166787 total samples)
           50.0th: 57         (8242048 samples)
           90.0th: 120        (10677365 samples)
         * 99.0th: 182        (2435082 samples)
           99.9th: 262        (241664 samples)
           min=1, max=89984
RPS percentiles (requests) runtime 30 (s) (31 total samples)
           20.0th: 896000     (8 samples)
         * 50.0th: 902144     (10 samples)
           90.0th: 928768     (10 samples)
           min=881548, max=971101
average rps: 907530.10                                               <<< close to 40% drop in RPS.

CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
all    1.95    0.00    7.67    0.00   14.84    0.00    0.00    0.00    0.00   75.55
all    1.61    0.00    7.91    0.00   13.53    0.05    0.00    0.00    0.00   76.90

-----------------------------------------------------------------------------

- To be sure, I tried on another system. That system had 30 cores.

base:
Wakeup Latencies percentiles (usec) runtime 30 (s) (40339785 total samples)
           50.0th: 12         (12585268 samples)
           90.0th: 24         (15194626 samples)
         * 99.0th: 44         (3206872 samples)
           99.9th: 59         (320508 samples)
           min=1, max=1049
RPS percentiles (requests) runtime 30 (s) (31 total samples)
           20.0th: 1320960    (14 samples)
         * 50.0th: 1333248    (2 samples)
           90.0th: 1386496    (12 samples)
           min=1309615, max=1414281

base + clm's patch + series:
Wakeup Latencies percentiles (usec) runtime 30 (s) (34318584 total samples)
           50.0th: 23         (10486283 samples)
           90.0th: 64         (13436248 samples)
         * 99.0th: 122        (3039318 samples)
           99.9th: 166        (306231 samples)
           min=1, max=7255
RPS percentiles (requests) runtime 30 (s) (31 total samples)
           20.0th: 1006592    (8 samples)
         * 50.0th: 1239040    (9 samples)
           90.0th: 1259520    (11 samples)
           min=852462, max=1268841
average rps: 1144229.23                                             << close 10-15% drop in RPS


- Then I resized that 30 core LPAR into a 5 core LPAR to see if the issue pops up in a smaller
config. It did. I see similar regression of 40-50% drop in RPS.

- Then I made it as 6 core system. To see if this is due to any ping pong because of odd numbers.
Numbers are similar to 5 core case.

- Maybe regressions is higher in smaller configurations.

