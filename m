Return-Path: <linux-kernel+bounces-841003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CF1BB5F06
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 07:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D6D19E7914
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 05:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34F71E8332;
	Fri,  3 Oct 2025 05:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OuJpRqpm"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9399B19D880
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 05:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759469024; cv=none; b=Abidnc90H8mr+moGn9gcPOq7VinVnBaB1LDMcCLpha/Z42RiJtee6bgIwX96hCqXdDA91cnsKm3O8PK9tPt+IifaXUFOxFS2qEpnT+3J9L4SJ5OtlyUR6wt2DBzMQY6pXuY0G78v5PE4rX7sVyWuZ+kYzD9whX9aG/8HY7fA/3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759469024; c=relaxed/simple;
	bh=JQ1ILdEJfTeOvk1t9z7Uzk8Mjvtb1aObDW+FEHuIPI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ox1kPkmNnURU51deqw7490N9Jak99j0zqJwK1TAMTkpJ957QxH7sla7FKzv2xncrVEpNvso+ZIOlC7FonqoNrgNW/8T1irVbTeeXrhVtN+mJCXxA25fM/5luHHBsrt0WH+AX5TbC7RJ/+gasiFs6uuptMPvFJuJG+U+Jv/V21lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OuJpRqpm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5931e8RM008419;
	Fri, 3 Oct 2025 05:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3jDVaH
	BcShvY1tW6+8gkQDFf9bSoUtDAkccMTj+ss0Q=; b=OuJpRqpmpCriuEFGI8K+D3
	H1EfcXqRlrTzCL+f6AX0ejygv6SFkiufpJM0N7LlM3jPNGoMy5R1fetXJyZ5EbjH
	FH6btMe0z+9FeUTgKF0Rxa7F4bQ5BPQgZu9FXXLmFmczMzCRyCPkviP7mJuvFRSe
	jgzMPxxlT6tinuZNoLRhpMWtf6fnwvPOO7nCiOTbWau8DU0eonRAWq5QqlaWWhdB
	umC0lJjQoJcUU8Zq01Y2FGePfEZ+WOu8jUBAwWa0PmojNyyk1dsWTmAPBgqrrvI+
	xGUZ/LDoOtUdOe/oRVOnz6IA56FgKHwvuCoD8LP/8+K5Ge/Wo/rAWQnYtZIpYleQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7kusnj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Oct 2025 05:23:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5930lllw007321;
	Fri, 3 Oct 2025 05:23:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eurk9eb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Oct 2025 05:23:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5935NSta60031304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Oct 2025 05:23:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B39EB2004B;
	Fri,  3 Oct 2025 05:23:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A29DE20043;
	Fri,  3 Oct 2025 05:23:25 +0000 (GMT)
Received: from [9.39.17.250] (unknown [9.39.17.250])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  3 Oct 2025 05:23:25 +0000 (GMT)
Message-ID: <204e1921-f3e3-41cf-bae7-36884f50503b@linux.ibm.com>
Date: Fri, 3 Oct 2025 10:53:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] sched/fair: Skip sched_balance_running cmpxchg
 when balance is not due
To: Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Chen Yu <yu.c.chen@intel.com>,
        Doug Nelson <doug.nelson@intel.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>
References: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <e27d5dcb724fe46acc24ff44670bc4bb5be21d98.1759445926.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=68df5dd4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=oVqUVcJZufWzTc19_WoA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: pfYib3NatHxl-F17ho2uFpBmiBLV4iPl
X-Proofpoint-ORIG-GUID: pfYib3NatHxl-F17ho2uFpBmiBLV4iPl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfX/Zq+Cr600UEX
 gswkhnoCWH5sgXhIA5GmQdRAm7j/CVSdk8E8o5d3OnpMMcl0aH86UXhZkx6YDppNjYUX4Tg+zMT
 vL4rGGytSYeuD5xcg6eqDGdbUGRQgo9uDjRLSUJblDdAUYLtIMypjA7W+E6d3C0nGtN0KOCaotW
 l9lU/a5UWkKEm/i2xKN1XBmcLTy5pkenfsdlAt5iCHH2U3q1sarWpbipZhyomxFC8NfAzqgpdo2
 63iSFy/sYvEgAkpvLr7sM5+XFm6IMSFHm0xzEJ9WoIS4OiOeIkew+4pZtk8LolVqOZ3OiAQ1CI8
 /prHJOOO4dpdUJjmvGsmBvLExLmb9ozitOBiE0iU/ZDN9Te5JitvJti3qvIWFiNVABIH421OwVG
 j6KLFayHCKWLj2QD+i6516KczwLLmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_01,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025



On 10/3/25 4:30 AM, Tim Chen wrote:
> Repost comments:
> 
> There have been past discussions about avoiding serialization in load
> balancing, but no objections were raised to this patch itself during
> its last posting:
> https://lore.kernel.org/lkml/20250416035823.1846307-1-tim.c.chen@linux.intel.com/
> 
> Vincent and Chen Yu have already provided their Reviewed-by tags.
> 
> We recently encountered this issue again on a 2-socket, 240-core
> Clearwater Forest server running SPECjbb. In this case, 14% of CPU
> cycles were wasted on unnecessary acquisitions of
> sched_balance_running. This reinforces the need for the change, and we
> hope it can be merged.
> 
> Tim
> 
> ---
> 
> During load balancing, balancing at the LLC level and above must be
> serialized. The scheduler currently checks the atomic
> `sched_balance_running` flag before verifying whether a balance is
> actually due. This causes high contention, as multiple CPUs may attempt
> to acquire the flag concurrently.
> 
> On a 2-socket Granite Rapids system with sub-NUMA clustering enabled
> and running OLTP workloads, 7.6% of CPU cycles were spent on cmpxchg
> operations for `sched_balance_running`. In most cases, the attempt
> aborts immediately after acquisition because the load balance time is
> not yet due.
> 
> Fix this by checking whether a balance is due *before* trying to
> acquire `sched_balance_running`. This avoids many wasted acquisitions
> and reduces the cmpxchg overhead in `sched_balance_domain()` from 7.6%
> to 0.05%. As a result, OLTP throughput improves by 11%.
> 
> Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---

Hi Tim.

Fine by me. unnecessary atomic operations do hurt on large systems.
The further optimization that i pointed out can come in later i guess.
That would help only further. this should be good to begin with.

With that.
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>


