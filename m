Return-Path: <linux-kernel+bounces-724348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D11AFF1AF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D2B8189F5B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC31123FC5F;
	Wed,  9 Jul 2025 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TDW93xVB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF94721FF4B
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088757; cv=none; b=O0c3Glm9MQS498IUXjB6b/HiWqXkSKCfse/YYBo6yBjqI3p/krYpva6WEn31UP2kWEfKRgb+qGwGKYCVOzhfbw1N4gp0BruJwiZS/b1/raJrIcxKtae4LBb+de7FuGsnIQOBc/TlE0uJYxuEFBWwBA+Q2veb9GNwBxXF9Ng18Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088757; c=relaxed/simple;
	bh=u3/vvirTVUUq+Hl+b+9fwIo7UB4jJGzLNte8TeeFHxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CfWNdCibm6WMjRN4e5XPo8xfYODY3Fkeb+QzKDFo4erVttMZ7Eax15Q0HoHYheABx+ulElXmDiMDaF2LSBRGScpAiCFaEU7/YYDTLLWMY+sbWWRJbCaO0sTFAtc1M/mXJb5fyHR7VofWQk0sKLGGMcNhMDUVdjDjnJVyUNyz9O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TDW93xVB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569Cp0AJ031183
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 19:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pfQKjOtH68DSBNR+Uk2pyki9PruLqbnrYQSvyOAaahk=; b=TDW93xVBktf1jFKF
	W8U1+rkdZxkR/FU+QXL225L453FnU4yfiZNzIVS7q26JV5wU1K94PFXXq75zrxWN
	2ZV7PjunDv40buHAfF7EfxLHpcNQTE/K/ruqFeA4D14q0cXEaOXUnPChHuHwxWJG
	FAl8k/OO5pE61oa4Ml8xcQgDjpwEui6jvTUvh/BSVhG4vbxilHe7mg8eaUt7WGbM
	TU6ArIQzEsdcAliijMeGZ5UMkuyjU+zDVS+JJNn5ZpUAD0Eo+KR2gJsSyYulBwQj
	wjJPk9K3kGh/xB9RgjkTc+zrXrnTfEgPqVOUgMkVij3xKOOQuE4ANANY9lp5EYr6
	z1lVUQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcg26tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 19:19:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d0979e6263so266785a.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 12:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752088753; x=1752693553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfQKjOtH68DSBNR+Uk2pyki9PruLqbnrYQSvyOAaahk=;
        b=S29+pxIbG3xKOnLRJAerOP1LQUE6PhHo5WCW5m/7xUyLccEr3gs0QmjdatR3Q7kc4p
         nnrDuwFCjTTm2UEQVp1pBcoOCDl9Lh+2HAZK/VfZ7EBUDGVNgNVReTGkaz3k8DgQSRNM
         emQ9MV5GHz0LcdygwrNudnEatP3owHfw016AtIC+QiqzG6NjkxEE+BxbeJV5uxrzi7HO
         qgPb/xLfg9FDEasc1tcNUa8Rit3+BWt614my3DEufmX2K+x+Do/1undZPTUnBVahmqXj
         zfJu25nK8YCiFc2aa9+v01NZh42XQgf92zEqJOsHTwrZPAOZ2PiSBJpoYTV3dOyj9ity
         locA==
X-Forwarded-Encrypted: i=1; AJvYcCV4vE2TsBZ5VaN0GJjsljw2pw7RvbL2PTsbbcSWOA9RfGfr7yTLxaP3ykWv8rLAaoY+lxAon8XtcPq0rNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcgsHgtXfT8Kq4w5wid/2WXuMJywnAMazRExWAIlldH6DZLH0k
	ASbc1ZDroUXgGBWB65twiXzX2g4HeN3yRLhpJTeCNgCJifeXOfR+obBMDi3YBWV9H8Bm3PrFoZf
	6apeWPPTE2nTsJgO4FIncTw6PkpyV24w+gvcOueDLuXANi0PJ41IWh6NGD5w4F5sV6XM=
X-Gm-Gg: ASbGncvmqmWjpSAa32/T7pJ7s1Y9gbJMpILL4i1g1D1WivHAi2Jj18o7VMmtB8YNB+C
	ah+v+NsJKcFOl50H03LNUH4EkXbKkWjcAjRaDgp1IDv76jWsKEg9JiRj+m74aKi6bhqR4xokK0q
	axIGCkdhcV16KaWNTnHzDoVDIylJZRNiwho/X27qPzer8NY1RyAzE+AwRQmcMGHGLM8Ky/fdC0m
	JHMbxfeyUX8/s2MTJmLIKElL/qZnaMFJu7HL6vOetMfrlZJm+H8C0/pmUHRMt4sF2Zbwu2+QuDc
	XJoHwEDUVXH3xhIQUBJ7CWq1gPzd2dNSfhjUbMdKq9Xlu57pAd1S7JfGYUMPk5dBxJ8+YCNJd5J
	lL3g=
X-Received: by 2002:a05:620a:c4c:b0:7d5:d01f:602 with SMTP id af79cd13be357-7db7d78e468mr216922585a.14.1752088753152;
        Wed, 09 Jul 2025 12:19:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcregrlw/J8rloCEh4HZgcfMxUlAlzdGycBiRw/6NNEExrP1Y0htAK4nXMstyn/N9Sgxli/g==
X-Received: by 2002:a05:620a:c4c:b0:7d5:d01f:602 with SMTP id af79cd13be357-7db7d78e468mr216920885a.14.1752088752693;
        Wed, 09 Jul 2025 12:19:12 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb0c8909sm9334303a12.45.2025.07.09.12.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 12:19:12 -0700 (PDT)
Message-ID: <075e59d0-569c-429f-ba14-c2e59e2f63a2@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 21:19:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] misc: fastrpc: add support for gdsp remoteproc
To: Ling Xu <quic_lxu5@quicinc.com>, srini@kernel.org,
        amahesh@qti.qualcomm.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc: quic_kuiw@quicinc.com, ekansh.gupta@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250709054728.1272480-1-quic_lxu5@quicinc.com>
 <20250709054728.1272480-5-quic_lxu5@quicinc.com>
 <2dfb6c0a-df7b-4039-9a65-0f1036752bbe@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2dfb6c0a-df7b-4039-9a65-0f1036752bbe@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=686ec0b2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=TB6GD4yhWxgz3a-1klEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: W1W7bw2i5IwvnHjUXhs47vCDBtDQmbCV
X-Proofpoint-GUID: W1W7bw2i5IwvnHjUXhs47vCDBtDQmbCV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE3MyBTYWx0ZWRfX8Nt3ch4ocCfp
 1xODu70W1GesgLT5Jb87L92LtRuOuDkBjhR+ZtuRe4CZFbmdobEC04dHgHby+/1uIOpCZCgnVCg
 k0SBBUHnM7l5DP8wWNtXeuBjFNyNsQ08iUTB99m2yB5wFJrB3BWtJvX84e1Eq55uD6ABFWI6aZa
 wZjkUhk782vAr7q1UTL+H20cGfOsugAE6ltoNx52BJSz1JP/BDKqrc/LaLPIoeuRuRJ96A7GNKv
 LTvkmzuFiPMfhYcV07aTOZZslgTiwBYyolKMuLVbvizIbCGJpczp/i9iBuVogN+N5/+aMM+q8pX
 hVNnsX6ljFSDYLbVbkM8sP4nJ80G0MNeHgCgHyGoqHf2VPNbQQ4GmTk7xklXqkCILTctmuenvfy
 QN1VyWEEpQarFPvMIkk5Mol5/+2kJ3hqFZC5I6164s600ya8UHZ0fVv7udRBsTCslK4Swywg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090173

On 7/9/25 7:52 AM, Ling Xu wrote:
> 在 7/9/2025 1:47 PM, Ling Xu 写道:
>> The fastrpc driver has support for 5 types of remoteprocs. There are
>> some products which support GDSP remoteprocs. GDSP is General Purpose
>> DSP where tasks can be offloaded. This patch extends the driver to
>> support GDSP remoteprocs.
>>
> 
> sorry, please ignore this patch.
> I haven't change commit message here.
> "Extend the driver to support GDSP remoteprocs."

How about this instead:

Some platforms (like SMabcd) feature one or more GPDSPs (General
Purpose DSPs). Similar to other kinds of Hexagon DSPs, they provide a
FastRPC implementation, allowing code execution in both signed and
unsigned protection domains.

Extend the checks to allow domain names starting with "gdsp"
(possibly followed by an index).

Konrad

> 
>> Signed-off-by: Ling Xu <quic_lxu5@quicinc.com>
>> ---
>>  drivers/misc/fastrpc.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
>> index 85b6eb16b616..d05969de406e 100644
>> --- a/drivers/misc/fastrpc.c
>> +++ b/drivers/misc/fastrpc.c
>> @@ -27,6 +27,7 @@
>>  #define MDSP_DOMAIN_ID (1)
>>  #define SDSP_DOMAIN_ID (2)
>>  #define CDSP_DOMAIN_ID (3)
>> +#define GDSP_DOMAIN_ID (4)
>>  #define FASTRPC_MAX_SESSIONS	14
>>  #define FASTRPC_MAX_VMIDS	16
>>  #define FASTRPC_ALIGN		128
>> @@ -2249,6 +2250,8 @@ static int fastrpc_get_domain_id(const char *domain)
>>  		return MDSP_DOMAIN_ID;
>>  	else if (!strncmp(domain, "sdsp", 4))
>>  		return SDSP_DOMAIN_ID;
>> +	else if (!strncmp(domain, "gdsp", 4))
>> +		return GDSP_DOMAIN_ID;
>>  
>>  	return -EINVAL;
>>  }
>> @@ -2323,13 +2326,14 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>>  	case ADSP_DOMAIN_ID:
>>  	case MDSP_DOMAIN_ID:
>>  	case SDSP_DOMAIN_ID:
>> -		/* Unsigned PD offloading is only supported on CDSP */
>> +		/* Unsigned PD offloading is only supported on CDSP and GDSP */
>>  		data->unsigned_support = false;
>>  		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
>>  		if (err)
>>  			goto err_free_data;
>>  		break;
>>  	case CDSP_DOMAIN_ID:
>> +	case GDSP_DOMAIN_ID:
>>  		data->unsigned_support = true;
>>  		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
>>  		err = fastrpc_device_register(rdev, data, true, domain);
> 

