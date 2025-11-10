Return-Path: <linux-kernel+bounces-892568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C41C455EF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16F44346EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D602F5328;
	Mon, 10 Nov 2025 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VdZVHnZm"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544DE2F7440
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763205; cv=none; b=AEz9VJxFQvmcHfXakv9mMNHms7MR1e4DV2b7x+pEFvTvXX+JHFXd9ytHhAOyX++XKysHCxioXzEksli7RCfv98SSxyFQOogcVE7HwjNC14Pr6pxkWj43BHx95oaUHHV1wVGLfUvZJFCbkmgoL2PNIjQwd2BRbrtBlUR1bQO74ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763205; c=relaxed/simple;
	bh=dfbTx6IwXH+Odzj5dk4gS46iYnZWgtfnxPivmSpgW98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4PtVUhhRsHzHInbmEaQmEHNXyTENrHWp+MfiI/0K8jWMz4CYJbAaby5hKkM4DsoolE4YdsYTrHutIiSuSBGM/7Pjhkn2qXBSRB5/qOPi83j8euL9L/Rv/J9+B/p6ZVVvF0NY4IYUNQoQUkVFlqlJnCUZqMOeDMQFKFpvPAAn+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VdZVHnZm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9Ks8uI031322;
	Mon, 10 Nov 2025 08:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zwaa+q
	J4xBHGRBAFnMUqnZPxIqhYhRpPVoB+jITYZwg=; b=VdZVHnZmnsWgTeiC0T2hzt
	TACsgMfToImfeNvuVE2L77Vz6x7YWewA/KDWegkewIh5qhMAaDJCrKAdPoH6TsNY
	1hXmIoAi+7B257QlKDDcVkoiPQsNC6+uT2LtDlBZ+oofOoHbHtULfHfO04kY76Gm
	IGwHmDysuevkE/DMnEgrzm9foz9Awmo5+gckxqIbYefZiB7y/kOUZbzoG5zhwkTQ
	HOXv8cOou+CaiB0n2ZOZzp1M6M2vRqb1lSGYJDQcoUfqUkfLxgOPbgD74U2ZHJgl
	WZ0sd6qcksmI13UBEWax6oFXTwCF8o9KT5eeo4tSQaZwmXCDgbw3EEYrecMSpwww
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk7y6ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 08:26:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA4fn4B014841;
	Mon, 10 Nov 2025 08:26:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aahpjvjdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 08:26:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AA8QJvO28508510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 08:26:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE8732004E;
	Mon, 10 Nov 2025 08:26:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5431120040;
	Mon, 10 Nov 2025 08:26:18 +0000 (GMT)
Received: from [9.109.215.252] (unknown [9.109.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 08:26:18 +0000 (GMT)
Message-ID: <07f7ad68-a591-4cc3-8381-3cfad0bd9c91@linux.ibm.com>
Date: Mon, 10 Nov 2025 13:55:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] sched/deadline: minor code cleanups
To: Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, nico@fluxnic.net
References: <20251014100342.978936-1-sshegde@linux.ibm.com>
 <aO9eTCDQDqDDbj0B@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aO9eTCDQDqDDbj0B@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX5J1oN6PJC+q4
 i5eVLkhjMMT0SzENpqA08zIRCThb6stvr3EgC3gxcI/cHZzwym3jRpYPCKJezDKKEQ3jBPherqj
 kSZzvjIoiIU5mojT193QlDlgl5caPJGe3JGrc9P8XyoKgtFCXs02ja7z6rZX9SBPSRqmUd7jR9Z
 mhG+Yic0lCnIoHlqWlXkRJ81cwxYLYY9295PdY/3hTHukpU51qmycc5UDVHEL8L0qtDZIROA/iu
 R24TphkPbN9AfgkSUJgWfnJTAhHJAE51KUF5e/jTwYThMvPtnp7ASOsASV4oNlcyOxKCiSU7KdH
 oq84hGezdaHw6wK/n0DdSpBVV+WRg6hT6ll/oCzeSnw6lJZhhjmNe87ykgpZCUO5H2iiwqxgcGd
 MZBsJ7HvDdkTfEQUVu/pRibAwuPo2g==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=6911a1af cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=_K7J4x4Q7_1TOLymXqUA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: ROjr67pqDIS7ySnS8_qiOH6jwGEaLFw-
X-Proofpoint-GUID: ROjr67pqDIS7ySnS8_qiOH6jwGEaLFw-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022


Gentle Ping.

On 10/15/25 2:11 PM, Juri Lelli wrote:
> Hello,
> 
> On 14/10/25 15:33, Shrikanth Hegde wrote:
>> While trying to understand the dl_server changes, noticed these minor
>> code optimizations/cleanups possible.
>>
>> Let me know if these should be squashed into one patch. Kept is separate
>> as of now.
>>
>> No change in functionality. Could save a few cycles.
>>
>> Shrikanth Hegde (2):
>>    sched/deadline: minor code cleanups
>>    sched/deadline: Use cpumask_weight_and in dl_bw_cpus
> 
> For the series (I would keep the fixes separate)
> 
> Acked-by: Juri Lelli <juri.lelli@redhat.com>
> 

Thanks Juri.

> Thanks,
> Juri
> 

Hi Peter, Ingo,

Do you have any comments on this?
Should I resend collecting the tag? It applies on v6.18-rc4

