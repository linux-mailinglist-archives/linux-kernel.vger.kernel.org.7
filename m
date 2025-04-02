Return-Path: <linux-kernel+bounces-584596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA86A7890B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 09:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01D03A7444
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 07:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F60233714;
	Wed,  2 Apr 2025 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tIArEPdS"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D7B1F5FD
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579869; cv=none; b=c5RdV8/2SnyHHajSonyhopwEnGF/VA/aKKCXLiYP3apjJ/gu5arIR/zrUKb4WbXLg1eQ2A694/OjPMH7w8K6LiKtzqeLFONHtb8EaQ53Vssg4torUxQIeJU8OSzP8fpT399QjXGLH2YFJw331edyX/bQEm8jRI4XlBcmzb6ulz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579869; c=relaxed/simple;
	bh=yjZZzDbFLgRCER335g45rHCkxAKw5okUXIMJri+Kffs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPxRn0uOBs/YHkn4YZdf934H4X7q+anKUzsrvVRe7R8JJUDindslMDi+AuyFqG2iSx8Q0Z5nXK/CrMffvXC6onU4mZag1Ot5GcuRSdG00ahpWJmSCWA0HlN50A6kjnzXIVhfmTdCF11m2YQoNSYewHV5vHwYsNwnyhf4iju9eW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tIArEPdS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531NDik6030354;
	Wed, 2 Apr 2025 07:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=exQLhMyg9qLptoM0qd7l3TQfUiHvZ6in9+giMllRWIQ=; b=tIArEPdSR4/p
	TOSU5exMpxX+iVuTzGk6OjWQ0mLySQwvrjveFS/pYs6wK/k5367vCcPIDS3Z1juS
	Xt8VVFzwIv/wTht7rYzX1Lq9kUQVq6W+C4asnrLuvE/AHZoXz8E81vevDgWyNf3h
	+/zO0q/lSL9BgTHkTraTJCQzjRlqooc6mbi20rNNztbU+updCzwOOBPNSO37lgMs
	oAphWmQPHORQoPri/8+e+H78iZI7s183269YnsG7cjYpzYLxxYrQ7t+qr1bvQyUd
	x5nE1dyJ5ez6ZBQcDjc1LWQoW/HHZRPmC+4JGeuY9zmBsrXvhfIyVHiFm9ZN9xpp
	n6exZC/7dA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45rmax3k4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 07:43:49 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5327aqFD029555;
	Wed, 2 Apr 2025 07:43:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45rmax3k4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 07:43:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5323XGlI005210;
	Wed, 2 Apr 2025 07:43:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pujyxvca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 07:43:48 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5327hicx28901764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Apr 2025 07:43:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4137E20043;
	Wed,  2 Apr 2025 07:43:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 981B520040;
	Wed,  2 Apr 2025 07:43:41 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Apr 2025 07:43:41 +0000 (GMT)
Date: Wed, 2 Apr 2025 13:13:40 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosry.ahmed@linux.dev>,
        Tamir Duberstein <tamird@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc/defconfigs: Set HZ=1000 on ppc64 and powernv
 defconfigs
Message-ID: <Z-zqrE-8YQVHDyFS@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20250330074734.16679-1-vineethr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250330074734.16679-1-vineethr@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hdZSBzQdGfFgFP7umnSi1s2PSOrMTdc_
X-Proofpoint-ORIG-GUID: luMiqcKl4tJtqmQ67hpumliGVgpaNFzL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_02,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504020043

* Madadi Vineeth Reddy <vineethr@linux.ibm.com> [2025-03-30 13:17:34]:

> Commit 030bdc3fd080 ("powerpc/defconfigs: Set HZ=100 on pseries and ppc64
> defconfigs") lowered CONFIG_HZ from 250 to 100, citing reduced need for a
> higher tick rate due to high-resolution timers and concerns about timer
> interrupt overhead and cascading effects in the timer wheel.
> 
> However, improvements have been made to the timer wheel algorithm since
> then, particularly in eliminating cascading effects at the cost of minor
> timekeeping inaccuracies. More details are available here
> https://lwn.net/Articles/646950/. This removes the original concern about
> cascading, and the reliance on high-resolution timers is not applicable
> to the scheduler, which still depends on periodic ticks set by CONFIG_HZ.
> 
> With the introduction of the EEVDF scheduler, users can specify custom
> slices for workloads. The default base_slice is 3ms, but with CONFIG_HZ=100
> (10ms tick interval), base_slice is ineffective. Workloads like stress-ng
> that do not voluntarily yield the CPU run for ~10ms before switching out.
> Additionally, setting a custom slice below 3ms (e.g., 2ms) should lower
> task latency, but this effect is lost due to the coarse 10ms tick.
> 
> By increasing CONFIG_HZ to 1000 (1ms tick), base_slice is properly honored,
> and user-defined slices work as expected. Benchmark results support this
> change:
> 
> Latency improvements in schbench with EEVDF under stress-ng-induced noise:
> 
> Scheduler       CONFIG_HZ  Custom Slice  99th Percentile Latency (µs)
> --------------------------------------------------------------------
> EEVDF           1000       No            0.30x
> EEVDF           1000       2 ms          0.29x
> EEVDF (default) 100        No            1.00x
> 
> Switching to HZ=1000 reduces the 99th percentile latency in schbench by
> ~70%. This improvement occurs because, with HZ=1000, stress-ng tasks run
> for ~3ms before yielding, compared to ~10ms with HZ=100. As a result,
> schbench gets CPU time sooner, reducing its latency.
> 
> Daytrader Performance:
> 
> Daytrader results show minor variation within standard deviation,
> indicating no significant regression.
> 
> Workload (Users/Instances)  Throughput 1000HZ vs 100HZ (Std Dev%)
> --------------------------------------------------------------------------
> 30 u, 1 i                   +3.01% (1.62%)
> 60 u, 1 i                   +1.46% (2.69%)
> 90 u, 1 i                   –1.33% (3.09%)
> 30 u, 2 i                   -1.20% (1.71%)
> 30 u, 3 i                   –0.07% (1.33%)
> 
> Avg. Response Time: No Change (=)
> 
> pgbench select queries:
> 
> Metric                         1000HZ vs 100HZ (Std Dev%)
> ------------------------------------------------------------------
> Average TPS Change             +2.16% (1.27%)
> Average Latency Change         –2.21% (1.21%)
> 
> Average TPS: Higher the better
> Average Latency: Lower the better
> 
> pgbench shows both throughput and latency improvements beyond standard
> deviation.
> 
> Given these results and the improvements in timer wheel implementation,
> increasing CONFIG_HZ to 1000 ensures that powerpc benefits from EEVDF’s
> base_slice and allows fine-tuned scheduling for latency-sensitive
> workloads.
> 
> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>

Good work Vineeth,

As pointed by you, the base slice is 3ms and having base slice as a multiple
of tick will help.  The numbers also support this change.

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju

