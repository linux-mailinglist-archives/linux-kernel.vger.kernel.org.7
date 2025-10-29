Return-Path: <linux-kernel+bounces-875503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1007C191C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044A31C82A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A1C320A29;
	Wed, 29 Oct 2025 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KsdaLCM5"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6474320397
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726744; cv=none; b=I6nuplwEO9AQHbbqjGGVPrH6qQIg6oDWAkAJXSCv1PrAp8gNmxVDJDYBMzhkvlZTm2TxiyC3FzOoZ4ySVRaILkJeAhQo6SId03Vbb6trsH4tTHTqS1phyg9IrVRjr5g+4p0UeBZZHkqPrzjnqfLnb5yX1Lto6i2A6GHEXa1+SK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726744; c=relaxed/simple;
	bh=O2DhHi0ptwbSVSR8x6OaR8Md+A+99JbmhIOx8wzS1ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPVQ2qTE3faFDZAWhTxLQw7EKSt+zMp+KP3oDhtoqjRUxrc19CmSdJ6g5XjpxsqdeSo2ZckCze4XOBOgR49uJe0TjzCbsVc7CydcJQs4B9q1VgL1+YkjZl7nHu30gd0YPl0XvAZtwncDOot3msb6+st/OfxeJOeankBNY9sHpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KsdaLCM5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SJm6n2026005;
	Wed, 29 Oct 2025 08:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=pcYe2x8DT/tGgf4n9Cort
	N+xYljcd0lxE4REci07ITE=; b=KsdaLCM51Ferlo/ciO4mzC1XY9vaj7Xo7QTJM
	jdvuw69S8Lhv6Zz8EA5Mym5+P6q+iHRidHEuNBOxGBXarIvjSSGEXQFrp4mzD6eI
	dTsxftYbiKfpeoSP4LQeg2nWT0r9BMuewq58HFcZwn1AcVLXVzOSf3mZzk85BNtZ
	a0ZdIUHMS6hK9CB5eJxUnaiKDDdcBzhHPQ9Hpd/4CTHntz1tOrBUcAQBXBOSSQo3
	1TQQWW69vCbg+TIbJpgZ7nkVYSCEtyl0AONpY74n061BM0NSVIPzQvVQmzDdy9Ae
	L+fx2un69kSvM1iCUExrNUORkWA0CBB3HpxbNARD67xk4wrgw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aaj567-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 08:31:50 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59T7sNtu010317;
	Wed, 29 Oct 2025 08:31:49 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34aaj561-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 08:31:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59T5IPpv018742;
	Wed, 29 Oct 2025 08:31:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xwacnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 08:31:48 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59T8VjSg56099326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 08:31:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 693F62004E;
	Wed, 29 Oct 2025 08:31:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F3FD2004B;
	Wed, 29 Oct 2025 08:31:42 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 29 Oct 2025 08:31:42 +0000 (GMT)
Date: Wed, 29 Oct 2025 14:01:41 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ben Segall <bsegall@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v2 2/2] powerpc/smp: Disable steal from updating CPU
 capacity
Message-ID: <aQHQ7UyaK849BKV8@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20251029060757.2007601-1-srikar@linux.ibm.com>
 <20251029060757.2007601-2-srikar@linux.ibm.com>
 <CAKfTPtDW9rApEm+4qSrEpRDMA+68BnVOgegKUZUa5S-gKnR--A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAKfTPtDW9rApEm+4qSrEpRDMA+68BnVOgegKUZUa5S-gKnR--A@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ALkgKXG8 c=1 sm=1 tr=0 ts=6901d0f6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=21twpG0sl3GGVZ_TIPYA:9 a=wPNLvfGTeEIA:10
 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: jaZfFzRzmqqJ-6cdbHxy6uQrcXEuwj-1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfX7hXNrhbXzoIB
 CyevJmXbqWZeZcEy8nSeWFJnttg98cDAHd7bQvNVMNlTK1VLt9foi8BNkpHJG4Xze707Jpx8hIP
 /BkxRHf5fL7SKhggwvyoT+8cjMGieNlFYRVxxbTXSQACKFX6h5a7aCoFZmUKbMXAxpJVubr0U0i
 //fNI+i41NIW8cwOc+g0vDQRuWc/mmhQlDQuX6hjnTU9KYWbJfboeG0quC90qIGfknP365p4SQ+
 Ck7Aa1GYDsuTqcSptQGXZiHR/PSXs9JX7OPYc/ZCWmJ+orijyhE8yRwsei/cWtwPXFMeyyW6v0w
 J22Cu6XcOrDsOVqQQijNnlOMbtbZi/nCbGtSBPx+YNrPsE3TWBQYbfxAljBXvai15jNc+34s8FU
 q9w5KHQT3WBs4NNR87rJYcblFCVj0Q==
X-Proofpoint-GUID: nCkGOWEaup4KAZ-mPVtgTH8D1sDl85r8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166

* Vincent Guittot <vincent.guittot@linaro.org> [2025-10-29 08:43:34]:

> Hi Srikar,
> 
> On Wed, 29 Oct 2025 at 07:09, Srikar Dronamraju <srikar@linux.ibm.com> wrote:
> >
> > In a shared LPAR with SMT enabled, it has been observed that when a CPU
> > experiences steal time, it can trigger task migrations between sibling
> > CPUs. The idle CPU pulls a runnable task from its sibling that is
> > impacted by steal, making the previously busy CPU go idle. This reversal
> 
> IIUC, the migration is triggered by the reduced capacity case when
> there is 1 task on the CPU

Thanks Vincent for taking a look at the change.

Yes, Lets assume we have 3 threads running on 6 vCPUs backed by 2 Physical
cores. So only 3 vCPUs (0,1,2) would be busy and other 3 (3,4,5) will be
idle. The vCPUs that are busy will start seeing steal time of around 33%
because they cant run completely on the Physical CPU. Without the change,
they will start seeing their capacity decrease. While the idle vCPUs(3,4,5)
ones will have their capacity intact. So when the scheduler switches the 3
tasks to the idle vCPUs, the newer busy vCPUs (3,4,5) will start seeing steal
and hence see their CPU capacity drops while the newer idle vCPUs (0,1,2)
will see their capacity increase since their steal time reduces. Hence the
tasks will be migrated again.

> 
> > can repeat continuously, resulting in ping-pong behavior between SMT
> > siblings.
> 
> Does it mean that the vCPU generates its own steal time or is it
> because other vcpus are already running on the other CPU and they
> starts to steal time on the sibling vCPU

There are other vCPUs running and sharing the same Physical CPU, and hence
these vCPUs are seeing steal time.

> 
> >
> > To avoid migrations solely triggered by steal time, disable steal from
> > updating CPU capacity when running in shared processor mode.
> 
> You are disabling the steal time accounting only for your arch. Does
> it mean that only powerpc are impacted by this effect ?

On PowerVM, the hypervisor schedules at a core granularity. So in the above
scenario, if we assume SMT to be 2, then we have 3 vCores and 1 Physical
core. So even if 2 threads are running, they would be scheduled on 2 vCores
and hence we would start seeing 50% steal. So this steal accounting is more
predominant on Shared LPARs running on PowerVM.

However we can use this same mechanism on other architectures too since the 
framework is arch independent.

Does this clarify?

-- 
Thanks and Regards
Srikar Dronamraju

