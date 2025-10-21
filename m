Return-Path: <linux-kernel+bounces-862537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF5FBF58DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EAF34FF695
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290502E6CAD;
	Tue, 21 Oct 2025 09:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g2B81IgZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD832E1F0A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039584; cv=none; b=HoK32y/jGO2nbNAE7HAnLAHHqAtXS4npxgTj8GXhbgonKhvyjW0fvBY04PVxHoHUkRGJA1oQ+I3d8H642LOF6K0xb0vVLwwUZsUqzbuuMSOv9c0qgxLgf+VuvqeOFAppDZ+7wnCRE1QpZDA9pEFxVREK2h1yJc2wJ0inNnxldNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039584; c=relaxed/simple;
	bh=qUlnpjeYW48Wr0PjJs/bMwTmBoj9q3r+LLsVNiIOhFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mqml7gm/fv06yBsxvatj9jr6lOqFdJlqBo//81T6bdrL6iq/LDb66OptvnA3IJJkr+uf6WT6yBRCZiVShaYI57QnUY3FBo7vg7psRMEc4ibseu8IooFOdZ3BgXXAQUJ1bB+1LcUWrF0GDWMtQlzS3/UrQPTWsmJOm+2b2/Btwdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g2B81IgZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L7xAYl029608
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DmNpI2PFyL7gAvTOOzSM1Wwvj+YScqMSXFzuum/gIZ8=; b=g2B81IgZh/Q4ypvS
	tu0gOiAtoB2AhpK7Z7/IYepjp2SHab5abSYxPcf+gDA+477l7APzSElt3ahXFz2X
	TS6T15ddTuSpc0tXoK4wHyo+uMtQVZ+w8ml1YvuwhrLWGqrZskq1JF90j9j8uFxM
	drOw0PxfGC9D3HPHeEcmRWjHtikGQkIRExboPQ5u1FQiaDtq+mDDhgHUzYO63wD2
	LVwpSLJfPo8GgfHqPN7dmFadBbDmFZEgH7urOpx1fw8WRLXsiH+vm2XXSV0b7ycw
	RpnCPHzXu23LCm5tnpoNvoOHK5nYj+3WPZJAL+y0bpo4Vr5yqU25hilynxVg7vDg
	wDB8Pw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49wswntk0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:39:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-88e452b04d5so176263585a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 02:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761039581; x=1761644381;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmNpI2PFyL7gAvTOOzSM1Wwvj+YScqMSXFzuum/gIZ8=;
        b=MotEunW8FcwTbJ8zP5blQP7oU8xV1xV7J+NWqUMHtdWAcQ5bqSWbEAmE1fU698HOpP
         Ks212dg0R9V9Bh4FDWYHfZ+8dlBpb1cR0X818ddYWF3SjD6Dfaujg6T5iaOZSdfbNuT8
         DmdwnBKeyPUWXXKu5GdpuK1YC2k5As2Kd/0KB9fhQfad3piX9+RuCSyfdZ4051mq7Bo3
         uo1I4x5athAyZzFWdxVmWKQPhil4LyfMjL5M13m736TH4voe3FwcWASsVp+RddpwykkD
         iZXaKgdfQLFziWwfGK96ZBMOuMix7cpfC2Y9Vr7JggUmd41qDtTAa4jdTw7B50yZaqva
         EBRA==
X-Forwarded-Encrypted: i=1; AJvYcCXjY0oV67LZX/kW4wg0byN6fm/FURNhaBGuwpNhQm0IoEuv6IX4XfYzhfr5SThyOWzP35Z++gPi1vEUCwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnG6Gq1+KVQ0iuPqiMHLrIPvaGSIFSKwFIk39mJMubp/SrGgi/
	O/KLTbvK1G+REOuHlPkyh0pTpvHACSiMXD6HfT/engUCLextCmolmDAujE4MJxQjWuBBEIBfh+w
	hZl9RLUhZwARmKk1JGccsqssEk7v6Zzp5HqAb23AC3LFM7sziH0XCb3rskRDxu4Mae8E=
X-Gm-Gg: ASbGncvUn6s09cfF5u73/8HCVQE/GdV/+uXnTbJVPrL3wbJq52pbDWFLHnoJZWrT8dF
	hKy+5vUDGzilm5wJ8ujRzG7kXHA/7kKsa5jOyRmxG0PD83c6tn+u+7xqWS3bd4KQPa2c8DhodrC
	jAzWqWNOKS4znRH6BWyUxtA5mSb9wQ2c9gRC0apBGLjYGYCEZ32n/Hc4Qb6J9sWcHTzIQVrOrli
	3rlwKiq3/svvcveoqOr/med5CO5QettJ7f5Exnv0PyXTLdn+Or7gpodfyFH3sV3j16SBXSwVk8j
	Fe1LlkWHviZGz/DHKAXeBWS+MiBM05fZqsc4U1Mj1novZ0EcfR5NWL65KoJacg41ctsu0jbxSiK
	B46UEwQJ9Gaos36IOC8ScesYY1wc4xQVmikJNqxsIMPweAZF5I8Cf8pga
X-Received: by 2002:ac8:5a04:0:b0:4e8:9f31:dec with SMTP id d75a77b69052e-4ea117b10dbmr21342671cf.13.1761039580526;
        Tue, 21 Oct 2025 02:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6rNwhsDdnBGCRZf83g90l4+BAxf1E5QIzKJUMVkc4BEhDy4Fy39CzzVNB7EJBurhJpiJYeA==
X-Received: by 2002:ac8:5a04:0:b0:4e8:9f31:dec with SMTP id d75a77b69052e-4ea117b10dbmr21342511cf.13.1761039579999;
        Tue, 21 Oct 2025 02:39:39 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526490sm1027264566b.65.2025.10.21.02.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:39:39 -0700 (PDT)
Message-ID: <15617371-0b20-4326-8e08-2c20b3d3c767@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 11:39:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: qcom: smp2p: Add support for smp2p v2
To: Deepak Kumar Singh <quic_deesin@quicinc.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Lew <chris.lew@oss.qualcomm.com>
References: <20250923-smp2p-v1-0-2c045af73dac@oss.qualcomm.com>
 <20250923-smp2p-v1-2-2c045af73dac@oss.qualcomm.com>
 <bb25208e-a6a6-4a81-9dd5-5c5eb1cf16b4@oss.qualcomm.com>
 <ff382661-4d05-4f9a-8b9e-55fa9932a22a@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ff382661-4d05-4f9a-8b9e-55fa9932a22a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tocsu3j8aNEJtJmbMPl8L-36Bg6i_Fg6
X-Authority-Analysis: v=2.4 cv=Maxhep/f c=1 sm=1 tr=0 ts=68f754dd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=kMNSRdB3-21TAvZhXxQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: tocsu3j8aNEJtJmbMPl8L-36Bg6i_Fg6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIwMDE0OCBTYWx0ZWRfXw5klxpNkN7t3
 6uZJHpjdtqu5OAGDupCu6hcxvFeAlJgVAPweeC98FiBW43FOv2VENK9Lm689oHN1Acyb1OY5br+
 O4X9ARFTKV7KMUNfbTxz57/+yuNcoECSggQOpsjVfYiG/o9LtyuWCYNQJfeRjxWOZKcYX8Ibwe/
 1SDJ/s2OSI3v5OhymKz1mGrpThaZUOG66qFTRK4fp+s/AqCB4o2hSfTpQxdjW3R4+Pf7nvfmin1
 hZH4o+HehrT0sz3hJ2T261au9aM8udnFxEW8+ckoimCOhcPSUfSLtpieil/Dp05x4bqI+y9zgHP
 3eR1x1IScQZtgvd9lS5XxSUxVlP6ngjllsuFAXiWcYtnSyBygb1++6aQsY4sdRoUA87zCtz8FOK
 +lh83maNimQJZ7NCRADC+n72sGWVNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510200148

On 10/21/25 10:23 AM, Deepak Kumar Singh wrote:
> 
> 
> On 9/24/2025 8:27 PM, Konrad Dybcio wrote:
>> On 9/24/25 6:18 AM, Jingyi Wang wrote:
>>> From: Chris Lew <chris.lew@oss.qualcomm.com>
>>>
>>> Some remoteproc need smp2p v2 support, mirror the version written by the
>>> remote if the remote supports v2. This is needed if the remote does not
>>> have backwards compatibility with v1. And reset entry last value on SSR for
>>> smp2p v2.
>>>
>>> Signed-off-by: Chris Lew <chris.lew@oss.qualcomm.com>
>>> Co-developed-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>>> ---
>>
>> [...]
>>
>>> +static int qcom_smp2p_in_version(struct qcom_smp2p *smp2p)
>>> +{
>>> +    unsigned int smem_id = smp2p->smem_items[SMP2P_INBOUND];
>>> +    unsigned int pid = smp2p->remote_pid;
>>> +    struct smp2p_smem_item *in;
>>> +    size_t size;
>>> +
>>> +    in = qcom_smem_get(pid, smem_id, &size);
>>> +    if (IS_ERR(in))
>>> +        return 0;
>>> +
>>> +    return in->version;
>>
>> are in and out versions supposed to be out of sync in case of
>> error?
>>
> I think that should be ok. If we return error smp2p connection will be completely broken. With default version 1 partial features can be supported even if remote is using version 2. Some features like smp2p connection after subsystem restart may be affected by this.>> +}

Perhaps a different question is in order.. do we ever expect smem_get to
fail under normal conditions?

[...]

>>>       /*
>>>        * Make sure the rest of the header is written before we validate the
>>>        * item by writing a valid version number.
>>>        */
>>>       wmb();
>>> -    out->version = 1;
>>> +    out->version = (in_version) ? in_version : 1;
>>
>> = in_version ?: 1
>>
>> Konrad
>>
> We want to assign in_version when value is 1/2 and 1 if value is 0 i.e. error case.

That's what this syntax does, with less characters

Konrad

