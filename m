Return-Path: <linux-kernel+bounces-882617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCB3C2AEA6
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79CCC4E34BA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2052FBE1F;
	Mon,  3 Nov 2025 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SKcrobyu"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFDB2EACE2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164420; cv=none; b=ngnsmIgHC/Slr/OtcuRofrOUbsthO17u2xoTQc/6HtyXEGNQJ6my9pCDYNnb5gXYGaTnUG9i621GJ4YInTL/hqoWzyMgLLoF1uDVVSVMWIoVBIxwh2kK1iMjL4GU7sP2LrMWq+dsw6PhlEYtbJsK0NaE6nlh5Sw0kryvsaeSFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164420; c=relaxed/simple;
	bh=KxSmj2EVSAtKWRzCuZMY9w7YcJHWBV20IN/fuyz86/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzfB7oushmRXSWKX0wZT+R1TVdN2yvuxX4Van4r7ZAO+7fNIC75YR1g3p9Mm2sJtn6YV+tw0BBaSHPx4CkXiMGie0zLZsJn8o+EwdgCEuwmpq4GHHIYbf9NevIwcwJzTDcOZQqs9fU0sX7FCfKLzKM1fmZ8QlyuRPWo2U0mj0Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SKcrobyu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A367XJ5028475;
	Mon, 3 Nov 2025 10:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cHq97x
	9nqrg2FOY00JbF4hLf0LMQp5q16cfMuYJ/avQ=; b=SKcrobyuR50xxqVS/NPYXA
	XZwY2/9/lfGH1qTlCpUmcsLyQd9kGLYIaoz4tL4k8hOThJmFhoKtQH5iQPfmqQgp
	SMYTyaRfdHC1DqZjuyZfJ6Y7fnVMXMJkTsZkg2sTMQmzUb5D7cmtCQ2NWUKPx9kh
	zgKLWFW9Xp1RcSnPvEe0hNu/v9ZBuqbbA03MH/JkGc6w9z1NiK/LO1b6VFXbCRG5
	6jpdIQvWtpchZ5c0yE1bNRFvWoZrg7U/go4d0HaHAcjbSzjE0D4qd536jTSf/jH+
	Ug8HSqG0/cWr+QaWXXrafLoUxfELHU/fuYbDh8r70cQOP4nsPGymDQEAyA6+QixQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a58mkp05s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 10:06:42 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A3A6fDN027263;
	Mon, 3 Nov 2025 10:06:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a58mkp05p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 10:06:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A370Pvu027394;
	Mon, 3 Nov 2025 10:06:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwy5661-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 10:06:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A3A6dXi44106008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Nov 2025 10:06:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BFEF2006B;
	Mon,  3 Nov 2025 10:06:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5432220067;
	Mon,  3 Nov 2025 10:06:36 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Nov 2025 10:06:36 +0000 (GMT)
Message-ID: <4cdfd743-3cfd-4317-8e24-0f94e6fa8d39@linux.ibm.com>
Date: Mon, 3 Nov 2025 15:36:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V3 09/20] cpumask: Cache num_possible_cpus()
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Gabriele Monaco <gmonaco@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Florian Weimer <fweimer@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
        Yury Norov <yury.norov@gmail.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.846126176@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20251029124515.846126176@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RAj9FLlEYj6zGVxyJnYTp4QnQkVLchNh
X-Proofpoint-GUID: SM1E8uFQHBH1lg8gRcNgmTX-X9lKS9wy
X-Authority-Analysis: v=2.4 cv=SqidKfO0 c=1 sm=1 tr=0 ts=69087eb2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=N3jB7X-fAV_4ZEbNhA4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwOSBTYWx0ZWRfX4+xAcH8HV1Id
 eDPnEZ09WKw1vClmzWiIpWRat9m1icfgQf6y0SGk5tuUcodF8roArwnygrhoJ7/Jf3WUe9etGfR
 cu0Zvr76BCJlSgCg+OzPqtz4hLMOau7yI/4o8CinPnYL1kwP0YvGHNc/eTOf3RlQeMOEH3ewB4c
 uFhRfi+LvibImL3B1B9IqbXavIXGFr1eg4cWCU6qsivM9UY0YCpddYrWMDLzkdpZeJMrVMmiVb4
 vND70F0s1PHRsk6WI4v8j4OuK/UIcQgCIzviITALHCNSagwOAVOETA4wXH6+ok91OtZqY1HlpcA
 ut/NUFElvdb1qIaZjHYNSSra+bfQyQohNVnjrhqJgLw5uA+c04TNAf+jZdRN6/bmlRgt1Mmm1pu
 j0t5o0WiaiIcspB7wrVsTbJi/kPpdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010009



On 10/29/25 6:39 PM, Thomas Gleixner wrote:
> Reevaluating num_possible_cpus() over and over does not make sense. That
> becomes a constant after init as cpu_possible_mask is marked ro_after_init.
> 
> Cache the value during initialization and provide that for consumption.
> 

Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>


Observation:
I see below usage which could be improved too?
kernel/irq/affinity.c:		set_vecs = cpumask_weight(cpu_possible_mask);
lib/tests/cpumask_kunit.c:	KUNIT_EXPECT_EQ_MSG(test, nr_cpu_ids, cpumask_weight(cpu_possible_mask),

Specially irq_calc_affinity_vectors, it seems to take cpus_read_lock, but I don't think
that lock is protecting possible cpus. possible cpus can't change after boot. No?

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Yury Norov <yury.norov@gmail.com>
> ---

