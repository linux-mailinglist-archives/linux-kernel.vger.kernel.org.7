Return-Path: <linux-kernel+bounces-726789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DEAB01142
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A9D5C0124
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88DE18DB26;
	Fri, 11 Jul 2025 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="USpFUAKU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3AF4A0A;
	Fri, 11 Jul 2025 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752201245; cv=none; b=Fp6E35ls+zOoI8xk4iwmISdBEm0VLZw3rWW+DUnE/xNWgem4VQWXGa6EaCBerwF4qct2P0lcusigczy83s3NnUND6j3z8aMb9pq0kwxfk+0sjQ66fmdRCWK61byf9eAnKbG2mS+hjS9s2LG0dXjzKEfjJoxspZ0Byrm3ye3HnfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752201245; c=relaxed/simple;
	bh=KvUVfXT13s1CIpLtx2rXN7lHbPJYc+jNnM7XY+E2DXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SKb2bhYuO3abaSpjVZ/t87RHsrp2VPuK3+srA5Oa+ny7IUgSxRwNgNB/0QB47bHgkyyVWY9FaF/4bPYVudk+FlAo3S2BIzObMZGFdD3by4+bhIVuwi3nAkc30DFq4dzPnk0l1vMjNOnCwdt1kynMmcemoWJbFVg4UdrKkXWidXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=USpFUAKU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1Xisv003833;
	Fri, 11 Jul 2025 02:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	41rFHfCgHRhlOOHf+cNsdjLu5b5W0PJYTOYx9AMOy/I=; b=USpFUAKUCdDva4GK
	1o06w36hbMpiSpVzEGXCzvV4rU8kF1/8QdLrfvpaSYGeQMefDEafEuu9Xm9v/Hat
	DoFzOAM53OP0SJT9TaRHavbfFtRuQef1kZqKBI+5ybGeAkITXh7TyjP+lrpi0AYo
	8WJzqMiYsaVesrQpNaz3/GinoXrZiPiVb1gU2awsFCbTqjX0WoVbw5B2S8KDRZJG
	QbftcCs0XoxtnBkI1rdiFOqYQ6AruNdFrY9S8HgICFVmK5TpUdV9hDSfNZroUWdO
	Wbmc+uT44shZ6wN84E0XeOc3B2SVZLlCs4HtvqC4jYr1GHpV4PQ1mncIvSLqfidm
	Gb5OGg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2bj7xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 02:33:55 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56B2XshU019233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 02:33:54 GMT
Received: from [10.239.29.49] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 10 Jul
 2025 19:33:50 -0700
Message-ID: <170ed625-ca3a-49ef-95bb-158d666be909@quicinc.com>
Date: Fri, 11 Jul 2025 10:33:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] misc: fastrpc: add support for gdsp remoteproc
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, <srini@kernel.org>,
        <amahesh@qti.qualcomm.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC: <quic_kuiw@quicinc.com>, <ekansh.gupta@oss.qualcomm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20250709054728.1272480-1-quic_lxu5@quicinc.com>
 <20250709054728.1272480-5-quic_lxu5@quicinc.com>
 <2dfb6c0a-df7b-4039-9a65-0f1036752bbe@quicinc.com>
 <075e59d0-569c-429f-ba14-c2e59e2f63a2@oss.qualcomm.com>
Content-Language: en-US
From: Ling Xu <quic_lxu5@quicinc.com>
In-Reply-To: <075e59d0-569c-429f-ba14-c2e59e2f63a2@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAxNiBTYWx0ZWRfX5TuJ90wyKShd
 iXyj+yt/DvtxFF8xxiSXCuNBhzHhi8Wq29dt6Nr1VRBJNPQ2M8XN56syh4111XjjfiH4fdMLBx2
 9PFZ7/jlKKDVfXAAFiHTJGbVcQc+BWseCOOAzKIVuA9pObiqgfcfeY2+z/wUOQ0S+Z1PmPptW6o
 LTrv2b8zi7QVsCg0pZhHetWWfV8Z6RMUr4770faF5J+otab07bcj9RZUHZhH3ObQcIva9CZ9Os9
 6l2KgvTOn34bC4SIFZcrkB/XxRTk9QK1GI54w92rBZ3Dbb9aAoZWd7Lz/Ovn7U+TNT2j0UWyhsx
 Bd9mL+L02WvBjqGolUYlhE/RQngkTs8x5JEZidRlAYXJak/2VdED+p2VH5+hCaHZKR9LR1qOf0q
 Vpuy1W6AvE3c+L4G6Atav95ALviX5EO+zTZKwWrk4H3TrSaHRsOKuALjxGGy+7g6OjODWvBF
X-Proofpoint-ORIG-GUID: OHDNXzum-nuG6eQgjmLLvDbAtU2p8uRi
X-Proofpoint-GUID: OHDNXzum-nuG6eQgjmLLvDbAtU2p8uRi
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=68707813 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=PanXxo5gIGnb8EET3dMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507110016

在 7/10/2025 3:19 AM, Konrad Dybcio 写道:
> On 7/9/25 7:52 AM, Ling Xu wrote:
>> 在 7/9/2025 1:47 PM, Ling Xu 写道:
>>> The fastrpc driver has support for 5 types of remoteprocs. There are
>>> some products which support GDSP remoteprocs. GDSP is General Purpose
>>> DSP where tasks can be offloaded. This patch extends the driver to
>>> support GDSP remoteprocs.
>>>
>>
>> sorry, please ignore this patch.
>> I haven't change commit message here.
>> "Extend the driver to support GDSP remoteprocs."
> 
> How about this instead:
> 
> Some platforms (like SMabcd) feature one or more GPDSPs (General
> Purpose DSPs). Similar to other kinds of Hexagon DSPs, they provide a
> FastRPC implementation, allowing code execution in both signed and
> unsigned protection domains.
> 
> Extend the checks to allow domain names starting with "gdsp"
> (possibly followed by an index).
> 
Thanks very much.
I will update in next patch.
> Konrad
> 
>>
>>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>>> ---
>>>  drivers/misc/fastrpc.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>>> index 85b6eb16b616..d05969de406e 100644
>>> --- a/drivers/misc/fastrpc.c
>>> +++ b/drivers/misc/fastrpc.c
>>> @@ -27,6 +27,7 @@
>>>  #define MDSP_DOMAIN_ID (1)
>>>  #define SDSP_DOMAIN_ID (2)
>>>  #define CDSP_DOMAIN_ID (3)
>>> +#define GDSP_DOMAIN_ID (4)
>>>  #define FASTRPC_MAX_SESSIONS	14
>>>  #define FASTRPC_MAX_VMIDS	16
>>>  #define FASTRPC_ALIGN		128
>>> @@ -2249,6 +2250,8 @@ static int fastrpc_get_domain_id(const char *domain)
>>>  		return MDSP_DOMAIN_ID;
>>>  	else if (!strncmp(domain, "sdsp", 4))
>>>  		return SDSP_DOMAIN_ID;
>>> +	else if (!strncmp(domain, "gdsp", 4))
>>> +		return GDSP_DOMAIN_ID;
>>>  
>>>  	return -EINVAL;
>>>  }
>>> @@ -2323,13 +2326,14 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>>  	case ADSP_DOMAIN_ID:
>>>  	case MDSP_DOMAIN_ID:
>>>  	case SDSP_DOMAIN_ID:
>>> -		/* Unsigned PD offloading is only supported on CDSP */
>>> +		/* Unsigned PD offloading is only supported on CDSP and GDSP */
>>>  		data->unsigned_support = false;
>>>  		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
>>>  		if (err)
>>>  			goto err_free_data;
>>>  		break;
>>>  	case CDSP_DOMAIN_ID:
>>> +	case GDSP_DOMAIN_ID:
>>>  		data->unsigned_support = true;
>>>  		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
>>>  		err = fastrpc_device_register(rdev, data, true, domain);
>>

-- 
Thx and BRs,
Ling Xu


