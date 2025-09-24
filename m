Return-Path: <linux-kernel+bounces-831182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D18B9BCB8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA694C28CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C1322522;
	Wed, 24 Sep 2025 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q0hRJXFS"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EFD322521
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758744197; cv=none; b=Q6vuRN5aFw8qJZtYK5pG3WcnIotkoKg1d6UH+h5TZBOiypnNBKHqVSS/jGXU4sNXp0QGf69fCFb7907ri3pu5u5UzhBQCt17JEfzwZ13wkc1NlhsxDgaIBnYAHMpSd9Yx6/oLR6w7j4KmT9o52ahFKfUiWEXO4Wp+RWxe66vU1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758744197; c=relaxed/simple;
	bh=bREKUR0MwuRWhpb+5Fs1RjeNmPQn2N073z1LfLzqQqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfccdxbRQD2GFU618nLHQ8jen+MzcsG4mGoOvHFR4j0/WQlYI3AeUHmg2ZYxjnhY1uRML9+4yIEzRiychJSd5bqw8sMjMp0ppY2/nZiFf/8+4tnBd+q09lUorRz+mc92CcyMkfYZQmcN5zv4YADgFUKArJY+o9HpmXgT/FGye8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q0hRJXFS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OJEkO4028147;
	Wed, 24 Sep 2025 20:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Brbk6k
	DVGPykmfRasSm0WybkIso796nX6cWponafe8I=; b=Q0hRJXFSSZY0DkDxD/cH89
	Uvky3BEsYNhk1ejtsbTNFwCpLfTOoy0pQyowTbNlUJkuVLVgn34N9dvp+3Dp7gRO
	Me3xzc6q8/7PB0vZlZjOkRs2eKDBEqTX3BqmjXzu/xwoJ12KllUcfpi+QpARRw0k
	p6T6rrtHIwz5zeYrlvyefm1l0tNxCYoXfiqbAYmRMXcHQDYDzlGiKbSZnThP1bdw
	YbxIXGJICjvbEpjz/I9rWN81yf8uY7HSY1f6Yre8spjNP3LyGf52nC/ySqBPbIEk
	B2BnVgXyIY8G/3oJGN1uCb6/2+x0Cijp+h+2vpf1v8mJvqbedd9eJkgU1oeECIMw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkh2v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 20:02:53 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58OJvfEc009599;
	Wed, 24 Sep 2025 20:02:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpkh2uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 20:02:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58OHaUf8013638;
	Wed, 24 Sep 2025 20:02:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a8tjj67m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 20:02:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58OK2jMB39584132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 20:02:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73B5E20040;
	Wed, 24 Sep 2025 20:02:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BD4520043;
	Wed, 24 Sep 2025 20:02:38 +0000 (GMT)
Received: from [9.61.52.22] (unknown [9.61.52.22])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Sep 2025 20:02:38 +0000 (GMT)
Message-ID: <f9546172-95e7-498d-9fca-18ff142f0bbb@linux.ibm.com>
Date: Thu, 25 Sep 2025 01:32:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 18/19] sched/fair: Optimize global "nohz.nr_cpus"
 tracking
To: K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20250904041516.3046-1-kprateek.nayak@amd.com>
 <20250904041516.3046-19-kprateek.nayak@amd.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20250904041516.3046-19-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L50dQ/T8 c=1 sm=1 tr=0 ts=68d44e6d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=HYlcYiSgWUv9ucaH2pkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMCBTYWx0ZWRfX80lij9bkE1UM
 84mEsIg6wypSkoopwDlB1pQOyKJz4pBym76ETivsBuZ0TcgRmOBLGtSr9HZwEHduXD0tRsjTYRO
 ZAgiLhVqrUofJ5vpCSnxnypoy03nASht4YXScC3pbP5NXRtdBux3IQzt/hF9uuAUK0i5bJy4f4U
 v1QRnr23TGuIbwqe3tkuYWQO/szcgqtB0pGWiOeVmr6gJZtJom7zUAafCgmeIFTAVeQpFxNQ5Wa
 LJnTXL9pKp6OSi5Cwu+cNGAbKm5utLOBPxZDRqKNWcYK3iQ5xdVhTXeGtFeN7oYz9bvzH5H78DA
 NQIzjKt3lIFQYgL8JCQN7ehwx7ZbCbD0okOfLsMvsmGH/3h+5WXqlcKXqfXO7xhncVdROA3bYWK
 t+XBSl2E
X-Proofpoint-ORIG-GUID: l9ANQLiJaHgh1lA520J1kzakBJOGkXvB
X-Proofpoint-GUID: HkqojI_cRzifo5pg4uIRXFMgOISteN8m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_06,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200010



On 9/4/25 9:45 AM, K Prateek Nayak wrote:
> Optimize "nohz.nr_cpus" by tracking number of "sd_nohz->shared" with
> non-zero "nr_idle_cpus" count via "nohz.nr_doms" and only updating at
> the boundary of "sd_nohz->shared->nr_idle_cpus" going from 0 -> 1 and
> back from 1 -> 0.
> 
> This also introduces a chance of double accounting when a nohz idle
> entry or the tick races with hotplug or cpuset as described in
> __nohz_exit_idle_tracking().
> 
> __nohz_exit_idle_tracking() called when the sched_domain_shared nodes
> tracking idle CPUs are freed is used to correct any potential double
> accounting which can unnecessarily trigger nohz idle balances even when
> all the CPUs have tick enabled.
> 
Is it possible to get rid of this nr_cpus or nr_doms altogether?

The reason being, with current code, one updates the nohz.idle_cpus_mask and
then inc/dec nr_cpus.

The only use it to decide to do periodic idle balancing or not.
If instead, could use cpumask_empty(nohz.idle_cpus_mask) check no?
It may not be every tick accurate, but that may be ok.

I haven't gone through your series in detail yet, but similar thing is doable,
check if the list is empty or not.

