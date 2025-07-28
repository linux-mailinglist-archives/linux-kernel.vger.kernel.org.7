Return-Path: <linux-kernel+bounces-747788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6954EB1383D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3C51883304
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC9E1B0F1E;
	Mon, 28 Jul 2025 09:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FLO3QIYy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26B221269
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695913; cv=none; b=hX39pxp2oj0e0KCOhCgvq0jbSxBAl64DwcLCex06yx/HqwcPqxfO3Zcsq3pSSHsZwCm/itmbeGq5Auj1YTvhgol0ZfLpGHgQvwk/kgZqICS8Erd93tZRnNgP75PPP/k961ydM2Lh1jSE1cfHbTnZgIB/NPtDLHnVUVAYHQnZ270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695913; c=relaxed/simple;
	bh=JdaL5fDOfWMk0NR5nw8RJbwdOOa9HglJSi+7QL44of8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a5PROUfwwW92FwbDOzjuPZtevc9n8lJc2GOnl6rCsmnGLEMp1txjfUHfVlMPpGMhrIGUD/69/SehQ47FbrtyGiuVDMYTK37REWy1Syd9ElD8683Nf3ZEmW4IfLIVArqZOQOVmo0amb1030jk8WKouAmsmzlz1YZ2/Sp/+hgW83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FLO3QIYy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56S4rdaa016873;
	Mon, 28 Jul 2025 09:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ShaTUz5fInwjcfQY2YZMYtXOqUoerHUTKUPGtP10L2o=; b=FLO3QIYyFPjavYxa
	9HPKHXl8dxtlcZoVnjf7RN4n2x0UDZ4EjwdWFZsNBZ461XPf1NHlChu2IqywcT9k
	MjWkfJjWHu9DnGC8gHtnPECcG8JT3qCDwc+tS9YP5nuJPOMJFH/82+FFDwhvxgJN
	g3rs4dWG/3ND0VF8GUtSxlrQOferPpbPfltumgV+u+jLRdET86xP8Zr2mFQnWNur
	wA4Guk+rbMztW6s32CXZqgLxdJ/bf+JK/5moPXky1h8G3GdomPQls6qw6Gv6f5uF
	lmXFHNWN0i0vA7SSYSEeuKrzN29Rir3/tKahLtCMx0NS17sGR7OWWTq9b559LmYQ
	Gd3uzg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbkv1w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 09:44:50 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56S9inuB002718
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Jul 2025 09:44:49 GMT
Received: from [10.239.133.66] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 28 Jul
 2025 02:44:46 -0700
Message-ID: <87a7d1d0-4b13-4f0f-afd6-58cb3a040ada@quicinc.com>
Date: Mon, 28 Jul 2025 17:44:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: Combine ENQUEUE_MIGRATED check in activate_task()
To: K Prateek Nayak <kprateek.nayak@amd.com>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>
References: <20250724121258.1826487-1-quic_zhonhan@quicinc.com>
 <c7f2c6cd-e8d9-4dcc-9d1a-0a8b73769942@amd.com>
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
In-Reply-To: <c7f2c6cd-e8d9-4dcc-9d1a-0a8b73769942@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=68874692 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=Odld6-NpYCXSIetDn7MA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA3MSBTYWx0ZWRfX8NQDSKtTd7KV
 Fc+FNV94W7Ywqu8yGe6XWhlEdlrN7bDQKPvZ1lrWxStfr/Pr3nhDAy9fH8JJ5b+Sm8OOTmZfhjS
 SC5k7mKOIZirQ6gz/A8/3hzq0ECYJvMrSBYc1Dr3GovP1HqjZr61afnSi0iyQi7LgkYZYvLOT9h
 /FPUxOc0euHYPxRP5lE4jK0wb0mu3Et1GWig2cJojKnYQcKH0UHfh8jZXzjd1nf2x9QmlVJb2Tk
 +9aDS9RHTgwsIk1yrIbnBW5c82q5WF6OtgL5pEREts2HWtid4uBuo7d1SGXcsZUn+YXLhONH6zS
 yamzyuKvRzk4pgAHgeryZxm80u0338Ni97gWJbt1IsIPTcvhPk2AP4mFYjz/rp+eYX1rqFYAjTK
 qgIhYP+huPzgsKJJ9mkJVzB/5t+NORPxtyPRxqP3PudXqu6V1LYHZBmOyk0SahfJM2apBA3F
X-Proofpoint-ORIG-GUID: 7a4FU8pPD2yiRrlEK6Q7q0TsvpF4yaSH
X-Proofpoint-GUID: 7a4FU8pPD2yiRrlEK6Q7q0TsvpF4yaSH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280071

On 7/25/2025 3:14 PM, K Prateek Nayak wrote:
> Hello Zhongqiu,
> 
> On 7/24/2025 5:42 PM, Zhongqiu Han wrote:
>> Combine the task_on_rq_migrating() check and the sched_mm_cid_migrate_to()
>> invocation into a single conditional block. This removes a redundant flag
>> check and slightly reduces the instruction count in a hot path.
>>
>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
>> ---
>> - This is a slight optimization and code cleanup, please let me know if you'd prefer to keep the current structure.
>> - Thanks
>>
>>   kernel/sched/core.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 2343f5691c54..d6063cf503ee 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2118,10 +2118,10 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>>   
>>   void activate_task(struct rq *rq, struct task_struct *p, int flags)
>>   {
>> -	if (task_on_rq_migrating(p))
>> +	if (task_on_rq_migrating(p)) {
>>   		flags |= ENQUEUE_MIGRATED;
>> -	if (flags & ENQUEUE_MIGRATED)
> 
> I think "ENQUEUE_MIGRATED" can be individually set without
> task_on_rq_migrating() in the wakeup path via ttwu_do_activate().
> 
> In that case "p->on_rq", goes from "0" to "TASK_ON_RQ_QUEUED" directly
> without going through an intermediate "TASK_ON_RQ_MIGRATING" but
> "ENQUEUE_MIGRATED" will be set if "p->task_cpu" was changed during
> wakeup.
> 
Hi Prateek

You're right. Thanks for the nice review~



-- 
Thx and BRs,
Zhongqiu Han

