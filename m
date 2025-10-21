Return-Path: <linux-kernel+bounces-862528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459ACBF5886
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1723A388B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147852E88AB;
	Tue, 21 Oct 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ezzQ1Pkw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9782E88B0
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039321; cv=none; b=oxdNK/rtOImzVmwTHrrfQ4MzkWbn163N+Brb18MyWbgNwD3TXUGtvlyVPZDVHsHjoTUQm3/EzwApz6ZOlZAMn9vHzCBvC7t8No4+/YNbj2kTpDZjpxu24QsgxJcMYXFTiqhbQN3JMJNEapBfgNyoCFV8gZrrwOsjFh0Q5zqM0II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039321; c=relaxed/simple;
	bh=AaJ8fp8tD3uibzHr7wVOW+DfGy3v96VNlL7Ey35m/Sk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ul/qJJo1gOro0trEvrB2n7jPY1t2u4l4aqFJYlM81+1W0GW8o/y6s3UkNdtpp7W57lysVJ/8x5DSJIEYc4K9xj2NNEVJU8iLVRphMo3F+xTR+65QV2oQizC1QMPk13H+cOGUq2aTBUoUUbjr2+p11opBHu24ZJUYQ9bHkNF2rL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ezzQ1Pkw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8MvJa028023
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/YvikoKhdG+EgPtj7A70Jfd6SrCl1GIf+IjJo8+hT4c=; b=ezzQ1PkwbVRr2UmK
	gBpz6BMBpkl+BNnWG8v1tVSip4TwNtoXbqQdpFAXeEfeLUtt040PqSAAdBz+kF+J
	6un4d7eX8W5CEHWjfTsnJsy++zcWgddIxb8+qyEjm0y9SOWbk+jWh2bVUQTUhZKj
	4pvm8ArfaUNdoLaajOj+Hb5uZLwi51bWWYP6hVGIFYTXKfJZzyuDkYfVk3bObrGf
	OwDjL2sYstar9Jc3ZCSe2nclovafoWmrNIzwyjdrsFN2reWuykF1qoLK7UGkfYdI
	O7eVwz/IBZBrWjGHgf1QZ9SM2IZUpSNfN7fQCiDoMpimdR3GPSSN6j8wi+SReNVh
	7atp7Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j078b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:35:18 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8906754b823so190401785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039311; x=1761644111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YvikoKhdG+EgPtj7A70Jfd6SrCl1GIf+IjJo8+hT4c=;
        b=Gwjj71dDJQEvb22+VKuPksqAFnoaX6Bvkd71MBRiKQCdrUZXpekKwerLZUVOloSxMG
         F5/OtpB4k2+QMelPHoWaLjTrHlZnvEzmPvqvhRnovT1qJ1xUnJWE6Gy6IK6GMgbM8ijl
         6GXQtdqqT3QZQ9fuYHJGWqLhARQxHSP5w5D3uyzpPs3OsWtZwpFP6pJ7D+ayXj+OtS9N
         CO3hyS+JvxtReP9SMRSBwtCuNXq/zS4H4cnuyGO2EMLUVwYkamF5qeyeR6yx18kvlRi7
         PnK9qMipPP0vuaWrw4RW5tPyvh8PtMJ9Cag3CqpaO4AU5daKtUp+TZacdOph84o1tpBs
         Or0A==
X-Forwarded-Encrypted: i=1; AJvYcCUJXG/qb8DaxZqNDIr8R4KYMUS62f4A+ehMzPEIjTWoQ4gNcFPpO+PfEzUOdYhcKPlfOgXUJPTgqBVyCOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf7h4SZZy8Ks5GDCbOSHzluT6tS6We2St0Rz9mfnSFg/efUUBf
	u/OY3Twbp0Zfo/YRVuRwHfLaBGYW1QDs+am6cjWZbRF0q3vbty1NNYMysFswZUSBHDPu/+93heo
	VphVQLSpPER+o42I715o1HTPUAihgh7XDWJg20W6ACX7al3+yPlEykUDkwYOtLWAkxjA=
X-Gm-Gg: ASbGncskaKQrnxzIKBV/iP1WyyTpGEI6+KZO+mBr/wftsCr5s9Bl9+XaiA9VKuToGf4
	OjyeCbe0kWckY3fXUKix+F3oRp9Y+J667HBrz84HGjlrK0+RVuqh+N0h2A0QF3ODkAqsNP5bi2X
	gntj0c0UMJZWA8uZx+my3Mx93/SR7Lfs5CW4zJqeutT+DXKLEwdC3evW0uKE8ifsqpkMsFVuymM
	BohZz40H5/BCApF5REz5TY1EEa0qlP+rOXGSGxkjLkFFEn6yhLDC7csADs9iPyDmtR/7+ivfdvK
	XkQZDrxGoZNC8QQSPTJVUJvyjj3uOueLJWPVBsC8Xx3sdZ4yVp33BRW3nng5uegG0OgyaOsKIMe
	FFV6+COUyXDFKaG9Qr0M4xN3obe/HF/F5N5IpaYxuhaOKQ3uIwsb4UqmN
X-Received: by 2002:ac8:5d91:0:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4ea1167d71cmr16325941cf.1.1761039311562;
        Tue, 21 Oct 2025 02:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD6BFi9dlOuGV6sEzxgWqB8Wo4UIpA+DWPkZXM1aQT8aB8phcyP0h2MBQrdSQJclIihwxLqA==
X-Received: by 2002:ac8:5d91:0:b0:4b5:a0fb:59a4 with SMTP id d75a77b69052e-4ea1167d71cmr16325201cf.1.1761039308426;
        Tue, 21 Oct 2025 02:35:08 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebc4d552sm1039408666b.80.2025.10.21.02.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:35:07 -0700 (PDT)
Message-ID: <344f0f72-27c5-4b88-99ee-f71065cc3a5f@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 11:35:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] soc: qcom: smp2p: Add irqchip state support
To: Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Lew <chris.lew@oss.qualcomm.com>
References: <20250923-smp2p-v1-0-2c045af73dac@oss.qualcomm.com>
 <20250923-smp2p-v1-1-2c045af73dac@oss.qualcomm.com>
 <15c56c70-928a-4939-86a2-e7b81f1596a6@oss.qualcomm.com>
 <c239bce2-4bef-4085-8a74-c6d7c863febf@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <c239bce2-4bef-4085-8a74-c6d7c863febf@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX+KlqSWr6hkaU
 HQNUv46o49rMe+9xeF1nl2BUf5T3YvyqofBTKgk4V+oQIeIR4/hVgAn1VM7X7gs510Vr/Rg1/Zq
 wVOOhbi7EVs14j9i0iV9PVYQyBPF8pJr+xgOnphlYTx82txZlYF6pY0r3GK2MgILEaCdSm/948r
 Tm+y58d2WfOWPaQQcz+FdT+nIPPSnsgAlNA1zJy8evZoMY+R+TC1wj5ocMf3M3XY7ib50E5YBmU
 svxXQSiz2qSf45PrhB05EPidL+F7oM4nZRt/7xpH/+CmzOR8vu+rvrluEKZJmvhXgGkh4WaKKCz
 xHWdeiW23F0QdPmFPaJNqkzggt4XWkaaEbbbLVreV2noJQM6YNIzB0ia/+PVoDugljbPdmQbSvE
 uTQz6iCPUJlBQ9wCZSzf87LU80KLyw==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f753d6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=CnSXRHQeWs9gKxsjiQAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: t0YwP0zvR2wLRi_v3oH2IioVoSICYzuU
X-Proofpoint-ORIG-GUID: t0YwP0zvR2wLRi_v3oH2IioVoSICYzuU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

On 10/21/25 10:12 AM, Deepak Kumar Singh wrote:
> 
> 
> On 9/24/2025 8:20 PM, Konrad Dybcio wrote:
>> On 9/24/25 6:18 AM, Jingyi Wang wrote:
>>> From: Chris Lew <chris.lew@oss.qualcomm.com>
>>>
>>> A remoteproc booted during earlier boot stages such as UEFI or the
>>> bootloader, may need to be attached to without restarting the remoteproc
>>> hardware. To do this the remoteproc will need to check the ready and
>>> handover states in smp2p without an interrupt notification.
>>>
>>> Add support for the .irq_get_irqchip_state callback so remoteproc can
>>> read the current state of the fatal, ready and handover bits.
>>>
>>> Signed-off-by: Chris Lew <chris.lew@oss.qualcomm.com>
>>> Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>> ---
>>>   drivers/soc/qcom/smp2p.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 55 insertions(+)
>>>
>>> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
>>> index cb515c2340c1..e2cfd9ec8875 100644
>>> --- a/drivers/soc/qcom/smp2p.c
>>> +++ b/drivers/soc/qcom/smp2p.c
>>> @@ -222,6 +222,39 @@ static void qcom_smp2p_negotiate(struct qcom_smp2p *smp2p)
>>>       }
>>>   }
>>>   +static void qcom_smp2p_start_in(struct qcom_smp2p *smp2p)
>>> +{
>>> +    unsigned int smem_id = smp2p->smem_items[SMP2P_INBOUND];
>>> +    unsigned int pid = smp2p->remote_pid;
>>> +    char buf[SMP2P_MAX_ENTRY_NAME];
>>> +    struct smp2p_smem_item *in;
>>> +    struct smp2p_entry *entry;
>>> +    size_t size;
>>> +    int i;
>>> +
>>> +    in = qcom_smem_get(pid, smem_id, &size);
>>> +    if (IS_ERR(in))
>>> +        return;
>>> +
>>> +    smp2p->in = in;
>>> +
>>> +    /* Check if version is initialized and set to v2 */
>>> +    if (in->version == 0)
>>> +        return;
>>
>> This doesn't seem to be fully in line with the comment
>>
>> Konrad
>>
> Hi Konard,
> 
> Can you please elaborate more on this?
> in->version == 0 means remote has not initialized the version yet, so no need of enumerating entries. For other case i.e in->version == 1 or 2, in entries added by early booted remote has to be enumerated.

It's not at all obvious that 0 is supposed to mean "uninitialized"

Please #define it

Konrad

