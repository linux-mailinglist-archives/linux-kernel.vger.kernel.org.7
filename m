Return-Path: <linux-kernel+bounces-724154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C11B4AFEF39
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F011C85DEB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87615221561;
	Wed,  9 Jul 2025 16:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RuQ22Xqe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D688220F4B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752079903; cv=none; b=L3yq/M2DcVueIUJEfvnRIR0HqbE8pAuxwC3+QFrzmeKFGNCorEjki/KkQFQOcvvNDFtuVlD1RHNjIIl8xV3Y5fCCc8TWJxl+x1sDBhA7NaxoQzH7o5xnVgbPoVkThDQpCnLQI76erabLeDlNgFLz1n4BEhrwA/pOtok/sg0RtZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752079903; c=relaxed/simple;
	bh=zD62020o2giJIAiFBQYA4kY4tPzWX73gbV0UzfVeA70=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OlxvxCkk4K0smjsGsC4iDW5TKPZFQvdH8/TZIUmbiwh8ATX/nHmN52e3rcrcFPcAqscP+8pQDPTaaNhMoFOYoMsucBD1dFbps8zVbnIZ8WvNzju2Zy8lPNVgChF5hbKCD1mDN+Ytc0q9Ky7eoqBPGW80+avP1OhKkge7lNBtoqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RuQ22Xqe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569Collb030248;
	Wed, 9 Jul 2025 16:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p1rigS2ewfj6IDNdn8QEwPHsBGG2anuCS8EwTt8dK7s=; b=RuQ22XqeAJjIibNY
	PxNLxthgWWE75R7WVxZM9a+pJk/Y9lNLF2U9A/Gp0gmhtyGhYaMGvYXZS9wFyXG7
	QFaa2YFI97Mb6I2ScLU9c1P9b9KfQlrFy6M2VaNdEIEc6nI0XltDaWSFv9+GiKrM
	RbKAgQ0fb8maGN6AK6LAwJVaVSPbGCx0+xhyOdyBrAxTkmcVKwXyp6TsIhPWHTLS
	iw3JKMKRETM+WsPcFgQfY3N5icWIk9McoG9CJ67ixVIK1Tba8dd3m9lU/4DPyoFM
	L14g2+62U0LKkAVRpFkaXzEH1ohQoDiaVWgI0M4HfV5V9umsEmW7uulrT/DWE60+
	DDBMFA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcg1swg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 16:51:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 569GpaUc009076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Jul 2025 16:51:37 GMT
Received: from [10.110.22.217] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 9 Jul
 2025 09:51:34 -0700
Message-ID: <db613bd2-c78e-44ea-9aad-9f99996731bc@quicinc.com>
Date: Wed, 9 Jul 2025 22:20:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tracing/perf: Prevent double unregister of perf
 probes
To: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20250709-fix-double-perf-probe-unregister-v1-0-2b588b3c0140@quicinc.com>
 <20250709-fix-double-perf-probe-unregister-v1-1-2b588b3c0140@quicinc.com>
 <20250709102329.7a5430fd@batman.local.home>
Content-Language: en-US
From: Aditya Chillara <quic_achillar@quicinc.com>
In-Reply-To: <20250709102329.7a5430fd@batman.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=686e9e19 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8
 a=COk6AnOGAAAA:8 a=ltRmxQgG5UMMqmTGT24A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: vKba5pJhp7onEatI8zj7VVPK9k5303PL
X-Proofpoint-GUID: vKba5pJhp7onEatI8zj7VVPK9k5303PL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE1MiBTYWx0ZWRfX4j4DH4bcSH9R
 hWYkDMdm/ncGM1SDabolJpuZFMEVOwsYiVhk2Cmbjd3SRSF5qeYaUcSeh7H36T89HHcEJPpHwuq
 T8sORyqXtelMX//b5whLfdwFe00n51CVaYaUOBxX2/KY5fc/yg10frGQUPt2KLjDXMCZkZrhPQl
 3rhNfNo9q2umZzUQvnv014cdJblE3RMBcccZ8UXGDByKBSj+S80KYsQPniV0Z8FGyVoa8liQpbj
 1ZA2VOeHW2BxrY8MiCiMI+FfiSMh4ACYRxwcEkHY7a2dTpR/W3au53N/BwJ+z+feMxxmQJZWli+
 HvfJWc7yETUgDdqKGsrpIaAWT8MO8j8B2rHZPHjlHdYkYPZGeO3Y4tA/diDeBfonfetGhPA36J3
 O16fjYkkb1J6r/BSfXmLFl7tRCVJzATwTFNqpnm9DKYJnpLIwHCmJBPRbHyiHcR0gjfFmp4q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090152

On 7/9/2025 7:53 PM, Steven Rostedt wrote:
> On Wed, 9 Jul 2025 11:11:09 +0530
> Aditya Chillara <quic_achillar@quicinc.com> wrote:
> 
>> Double perf_trace_event_unreg is allowed causing perf_refcount to go
>> negative. total_ref_count also goes negative because the return value
>> of tracepoint_probe_unregister is ignored.
>>
>> Once total_ref_count is negative, the next call to perf_trace_event_reg
>> will register perf_probe but will not allocate perf_trace_buf and sets
>> it to NULL instead.
>>
>> The subsequent trace_##call() will mem abort in perf_trace_buf_alloc
>> because memset will be called on the NULL perf_trace_buf.
>>
>> Gracefully handle the error in perf_trace_event_unreg to prevent
>> double unregister.
>>
>> Signed-off-by: Aditya Chillara <quic_achillar@quicinc.com>
>> ---
>>  kernel/trace/trace_event_perf.c | 8 ++++++--
>>  kernel/trace/trace_events.c     | 3 +--
>>  2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
>> index 61e3a2620fa3c9417ac23cf5a18aeb86e7393dcc..247db88accd88eb0acf3692ea593d576519ce8b1 100644
>> --- a/kernel/trace/trace_event_perf.c
>> +++ b/kernel/trace/trace_event_perf.c
>> @@ -154,12 +154,16 @@ static int perf_trace_event_reg(struct trace_event_call *tp_event,
>>  static void perf_trace_event_unreg(struct perf_event *p_event)
>>  {
>>  	struct trace_event_call *tp_event = p_event->tp_event;
>> -	int i;
>> +	int i, ret;
>>  
>>  	if (--tp_event->perf_refcount > 0)
>>  		return;
>>  
>> -	tp_event->class->reg(tp_event, TRACE_REG_PERF_UNREGISTER, NULL);
>> +	ret = tp_event->class->reg(tp_event, TRACE_REG_PERF_UNREGISTER, NULL);
> 
> The only time unreg() fails is when it doesn't find a tracepoint to
> unregister.
> 
> There should be no reason to check the return value of unregister if
> you have your accounting correct. Thus I think you are fixing a symptom
> of a bug elsewhere.

The exact problem was introduced by:
https://github.com/torvalds/linux/commit/7ef5aa081f989ecfecc1df02068a80aebbd3ec31
(perf/core: Simplify the perf_event_alloc() error path)
where __free_event was calling event->destroy() even though it would
have been called by perf_try_init_event in case it failed.

This was fixed by:
https://github.com/torvalds/linux/commit/da02f54e81db2f7bf6af9d1d0cfc5b41ec6d0dcb
(perf/core: Clean up perf_try_init_event())

This patch prevents from crashing even if that happens, and there
will be a warning anyway to notice the double unregister.

> 
> -- Steve
> 
> 
>> +	if (ret) {
>> +		++tp_event->perf_refcount;
>> +		return;
>> +	}
>>  

Best Regards,
Aditya

