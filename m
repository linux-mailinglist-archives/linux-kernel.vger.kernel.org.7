Return-Path: <linux-kernel+bounces-736426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C0FB09CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242501885127
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846FA2686A0;
	Fri, 18 Jul 2025 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T8z+NpFB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B0E2153D8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824168; cv=none; b=OsXcI3yJ/aqeP2AWfHnC0x3N1wUzbPzYm8IgPCoP+7gsf2Gufk7DvV8slkJcRMmfM9nhxy9nM1TuYgnvvTCXwMSVVqEUj4fclc7KOSCU72Q0v2oYVe2W8s5+qF58VjripnZOhGRd5Ki6D9PuttU+BVi7xFc+bvMVTZWGpzgKxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824168; c=relaxed/simple;
	bh=I5P8cOC/cZmmCkcoz5JwaL2PQjCsfydSQEjKuP23+Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PuVfSRNUZPtzuP1Rn22e5awMOs73Jlu1Gc5lqfBMVy9xPVKbQCsQz/gnLNlsx/5XqY8MzvxdiUgi6YCIcvHg41VKZkPOi5TUgYA0W6NeWLnC4mVFbW3IP5xzkzTk1zNmqHNJXtsxFJaZEoHfjF8hj2Z0h0xbvYLACHD4vQIQHCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T8z+NpFB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I6ZYW9020802;
	Fri, 18 Jul 2025 07:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r9dQ5Q7JCefUTSHZInGH03YQQxwqBszNYjeyT6i3LL4=; b=T8z+NpFBEKvAV16Q
	7Lf2gbTiqbiklKWXIkyYwevc/8RI6lGfqlYbGMR33GR/nO7Nj+r9Q93MgqFfA7SQ
	CMdOlMVe66CcM0GCa5FZ9xlG7PMLCD0f5Mv8Z2EziwSm/vGKfe0q9vs7vGn4HC7d
	zS3YS6I//rYZQrbC+bF43egkaabL16rMOx9PQyuI5i8zps/uB9SS7RsRD9vapNxR
	ydkFCwyYRDwx8iROe5sRXm8L9kTfdfXfDHViGCuQ47bDFnhZ7/Oet8o9CtLtKEKF
	V6K7uQjSSMjGCaPjtbecN7GuBWYUQCv0ZRX6vm2x7QgH7GDyrcFuRQbSou2QdV4V
	RwhBuw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpnn6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 07:35:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56I7ZwZN030076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 07:35:58 GMT
Received: from [10.219.56.246] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 18 Jul
 2025 00:35:56 -0700
Message-ID: <2bbdd0fa-58cf-41ad-a297-125987ff2fbc@quicinc.com>
Date: Fri, 18 Jul 2025 13:05:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tracing/perf: Prevent double unregister of perf
 probes
To: Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra
	<peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20250709-fix-double-perf-probe-unregister-v1-0-2b588b3c0140@quicinc.com>
 <20250709-fix-double-perf-probe-unregister-v1-1-2b588b3c0140@quicinc.com>
 <20250709102329.7a5430fd@batman.local.home>
 <db613bd2-c78e-44ea-9aad-9f99996731bc@quicinc.com>
 <20250709131854.5eccda2b@batman.local.home>
Content-Language: en-US
From: Aditya Chillara <quic_achillar@quicinc.com>
In-Reply-To: <20250709131854.5eccda2b@batman.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA1OCBTYWx0ZWRfX34w/yzIMXWgD
 tIsclsjkgbtOJfMIPvFvaNExJTHLdu5LKsTlt+yQ1+32jh68CiUR8bCCoPZXJG+FROD82r/2p7U
 48waEyg4ZZ+w2TokDQ5TINGoxDyO9vKgq92ERCvunAaevae+krB33c98gXnBY7ldT85DARmqxD7
 Au3C3j5nCfrzvu9lVwfBlMLlzVNAE3QftRPim2pCk4tGX2fyyuTzb3n5CD8Y9goVDLokejzINiA
 Ff7f4QSrlyq/QxXm8J+kzw2zHNiBmOvbciulkzJjTIAhIMA1q+Y/iK6ikHhuumv4gxFW1IjZ6qF
 CJvBI+mSKm3KbnhDqs+NLl4qDaAeh8GfNqI02YffdrTY20MR8Z7mF747N37tm6RFadggHpbd/hL
 dK7L4RmCHa9g+lMyDqNABs1qnL1dKkTd9IGgicortoKVDnBs/PuuiALq5A9U6GqhZhObvQ71
X-Proofpoint-GUID: 3ZK5NX1rewuOhJoYF0e3jY83exf3v6SZ
X-Proofpoint-ORIG-GUID: 3ZK5NX1rewuOhJoYF0e3jY83exf3v6SZ
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=6879f95f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8
 a=COk6AnOGAAAA:8 a=6SyrrP-pztncbQDmCR0A:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=932 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180058

[ Added Peter for 7ef5aa081f98 and kernel/events/core.c ]

On 7/9/2025 10:48 PM, Steven Rostedt wrote:
> On Wed, 9 Jul 2025 22:20:00 +0530
> Aditya Chillara <quic_achillar@quicinc.com> wrote:
> 
>> The exact problem was introduced by:
>> https://github.com/torvalds/linux/commit/7ef5aa081f989ecfecc1df02068a80aebbd3ec31
>> (perf/core: Simplify the perf_event_alloc() error path)
>> where __free_event was calling event->destroy() even though it would
>> have been called by perf_try_init_event in case it failed.
> 
> Then I rather have it trigger a WARN_ON() and disable that event
> permanently until reboot. It's a bug, no need to continue using the
> event when it's in an a bad state.

perf_trace_event_unreg is called only in event->destroy(), and this is
called in event free path; either after the event is removed from its
context, or before the event is installed in a context. I believe there
is no need to explicitly disable the perf event here because it must
have been disabled already. Please let me know if I'm missing anything.

Best Regards,
Aditya


