Return-Path: <linux-kernel+bounces-728162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD79AB02409
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7C61CC5428
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1538B2F2C79;
	Fri, 11 Jul 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pQdIpoRa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0473C1ADC7E
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259252; cv=none; b=tS3MOKl7QQ7pDvPQRwLN7PMD1ZnkhRHEKdeiBHe9izDWFBunAy0dVrEUqUY3npl2iHj67xT7dptHkVO9yiUm6Vo8pMwbQ8rdlPGskvys3pQt6qpu0PNlNX9wAOomRzOAnRxtvUGHE64YnzbusC7IQfy0VVkTuKQWQD7NOIxxD0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259252; c=relaxed/simple;
	bh=7qM19moXBFLwh1UWakDLt4rVgduUMKIuptCr+mdAR5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fObZy6cNxGTl+rFigsSEyd6qBUEEKR9l41liq26Ee+pckQzGo2CehDpA7EfA93abfj9cBdhTvw1RoJGGqTDCMHyDYjPkkQO4oKubgy4qv0PO3P4ERIFs8PFbXmUvomVhPSoHjo8iEGBL/9iEZ3CxDvgzVvm6puuPt9FhOGdLt0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pQdIpoRa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAkHUA031126;
	Fri, 11 Jul 2025 18:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7qM19moXBFLwh1UWakDLt4rVgduUMKIuptCr+mdAR5E=; b=pQdIpoRaUsn3Gf+9
	zgNq0taweD0g7vU1qvLBDxnZUcnXMUV0NJSpaU2Y6CNroR6aHIJ6+XBLG/QXl1LV
	vvT6C5YQJ2OdFfff8BO+KqsCu3Ro6fijpf3Qtxqie3iSLO7PD+DQfZ9QAEac6dGi
	AvjY6kawC9aQPFFjBy2H8o04AbgCks8PBAt8pCUrIPdWnvfvnDmygQDm5fi7jBGT
	TplGUVrY9yMHuNIqBEbfqzBlLU31trcf/t49yEMrsUU5s65E8tu1d+PDXQRAPH4r
	lfZ8gjHF8dEM3BeOR6nATLvJzFyf9LdjGTEFyg/RL/DozDTjh5ieLIR6voJeqtsJ
	Fq6uHA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47u15as9ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 18:40:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56BIekmN014946
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 18:40:46 GMT
Received: from [10.110.63.141] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 11 Jul
 2025 11:40:45 -0700
Message-ID: <0e35ed72-d231-4294-9272-8439c249c8b5@quicinc.com>
Date: Sat, 12 Jul 2025 00:10:33 +0530
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
 <db613bd2-c78e-44ea-9aad-9f99996731bc@quicinc.com>
 <20250709131854.5eccda2b@batman.local.home>
Content-Language: en-US
From: Aditya Chillara <quic_achillar@quicinc.com>
In-Reply-To: <20250709131854.5eccda2b@batman.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: seXB4U2-MQYTDzrexsMBs4_NjwhfyoOc
X-Proofpoint-ORIG-GUID: seXB4U2-MQYTDzrexsMBs4_NjwhfyoOc
X-Authority-Analysis: v=2.4 cv=RtzFLDmK c=1 sm=1 tr=0 ts=68715aaf cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=NEAV23lmAAAA:8
 a=FXfphgXLjaAvwqFekLEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEzOCBTYWx0ZWRfXx4wE+ZIn2F7T
 gQpfHsGGzeYmCWrLUzBcKPJ3uhtfGPPeKCWrER+c4u4QudT4RTOlA+G9/MPELgrxgH4u5O3NrXf
 aUHm2reIvrOJ7K08ENl854gc6r98wS8Xmkbh6qLBacoW7lRJbfwK+C7FVHC02u4THyFfx6ejsM5
 N5voLPpxtqoVEmPOqkVT4SXobMBdbqhKEPiYACj+l3sYHWYB8EKarE6/bU3ggbmPUka5R04176T
 V3IS5BeBDmv4CNS6jysJItYoCWMBELOXjMauTU+Eaewvfb+2TjhNOfPLijRmDJEg4e99IVvHgcf
 JkN2bAZ3TgD9jby0r8ZI6rEtLsAPq5SES9E+GceMyqJTNKxnURbVdU/vPkBE0mEB+vLkHViu7Nn
 cLzY2W4gFO6t2IGtJzmMJqP4NgLgD1z094N7zHkRLdx9Y4YjQSI+c8HlAP9ggr6YH+1rzKZe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=789 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110138

On 7/9/2025 10:48 PM, Steven Rostedt wrote:
>> The exact problem was introduced by:
>> https://github.com/torvalds/linux/commit/7ef5aa081f989ecfecc1df02068a80aebbd3ec31
>> (perf/core: Simplify the perf_event_alloc() error path)
>> where __free_event was calling event->destroy() even though it would
>> have been called by perf_try_init_event in case it failed.
> Then I rather have it trigger a WARN_ON() and disable that event
> permanently until reboot. It's a bug, no need to continue using the
> event when it's in an a bad state.

Acknowledged, will update in v3.

Best Regards,
Aditya


