Return-Path: <linux-kernel+bounces-860040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C726BEF2FA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244A73E25EC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE7D2BD5B4;
	Mon, 20 Oct 2025 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bxEBhXs/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5C29ACC3
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760930598; cv=none; b=ABukza8zuZpQNRM8xoctc87H+Lxf8rO9HUANqUWsD2KUhoWVFJrhddSkv9+TgAkGtIb6JkphRMo7OXO6Od1k8sTBsC4rk0gH5dKgOqkeV2fD++P/HDY2GAEV9/hi9qhPJwAQldnJ0wMDj/Y2hngdm5WISyvovM9qSppCeVAqYdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760930598; c=relaxed/simple;
	bh=al8+YONBhG2K0jRHRVifybv1Z6NPQiebH5U+vVbxWbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueBDxBqOjfRxXu/m6gvvInofpU0k3sD/rjTiItdNZkMLwplktw6mwL4AzpetJHraVs/1y8rsfeXAxAH7mCFXRRunm9DXQkRg542WLE4CfJL+qJhKuV9XVCytir54vae0U2OUhdIvRAODsPq+S/BIUHlYe710Aqu4IezqRvbUuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bxEBhXs/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JNBqB7024329
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5vxEAGKk22m0X7ILOt+O5zdpKy7zzuPx9aZvAOYq5kA=; b=bxEBhXs/KAZ/nfcC
	Bu/59yVu7eWeUmwbn7lSAq39SGPWOnPb15b2C5Z7ogBJUh9ZJyD0aH39CchxPCTL
	6XJY9HbimNwrnCqHDQ0/tIq52pifKRF6chyqwVSwYgJvw1+nS2FiBomWCxvWcc+R
	FfeD3vAPgF2h0987cBn3md7YBhs37y1mADD0Asx9JGfBaF+qItvCqmZhUStyt1W8
	qpnA697jOYr4l+5QCSjYGGqfUl4bDm+zGYkb+c89haOeRAOpXcSkuCs15W6Ro0UE
	PQIm6qMEhpbBWKFVffU2XUSpuNqLuorsd8uXstuO5sqTghD/Ewz3IzP0dw1oOEik
	vFiZTg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42k3d1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:23:16 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-33bcb779733so3135761a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760930595; x=1761535395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vxEAGKk22m0X7ILOt+O5zdpKy7zzuPx9aZvAOYq5kA=;
        b=FMVRE4jRJDLnfNQyWCdjT+53Dh4nd4UnEU7ZJVFIVoyE8az8ckn3sl/RFZ67hxaLAW
         Vnq9AHz1dCxfHfJLRMvgZwzi+kQzhrYO4na97k1G470V1+DYq/jyuvMgJf8/P2vgEgDJ
         aNQZaPGGC7N56XNNztdIVXVM6HN1VHYTUE5sHjO08BOKHlPt3Qrnx51JsGf0X/9z8sdG
         jtwvsJYcIG8ww0pupnC2ykQpLMURGLRlJaXIHKb2Eo+aSjFvrZ2BA/iwGs5zFIAvhRV/
         mgnFU5ls0mPNWE+0abpFDU01lcCruCHQ9TwmqScU9EOBqJyzR/t+6BT1lfhhV5Oyd/Ko
         kZYg==
X-Forwarded-Encrypted: i=1; AJvYcCUlS/FuDSUPgim5yhLB7BprRMonKMmBprx1u1hWdUChKrHNdpZytOhgbMEYNS+8dW51lc7PpRp/Wis1MoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhH7y6NURkCy8LAPBW4Yr72sen6PwG4RKjrLM0IXzZ0mPxjOuO
	tHShqveJxY8D2bJ6fu9S03FJMdPbBWh7w5Xw8Wnwg1p//A5I/oeV1FSbIBxwnh7qn12rgqRr5VQ
	NnWekrFuPeBAUEVYMVLG/2Xzk6xtO5Uj84ZTcKm0Pcw2lw/cUJYiNO7ld3gxYSjGPXnQ=
X-Gm-Gg: ASbGncsIRvz+vo9fAPLNbgDfu5qlk5AjEoSYfqJBaA59HyBAqnfGBTqiyufrtQXrIaQ
	WHZi7MBgoYrhKR5tNa+l4izbq+HAFgJO9fY4qD7w+If1I/OfrwTbT9FbiG3uX07wF8PrV7fKjTV
	Fq9S/LYKOi0yruXLnHWWcBWw+aMbSKRO3TxARlryyCRljWMQ8en5tJ2hlRb18LR/eqBSlvDcl7M
	DTNT3L04rY5qtX/aRpBjFxRcvKsZ4SutF9HladhxnSuILROG9tnjgSVeiPEfBF/trQiDWORpIAY
	zlWR/u0w8R7CZt8SEQK53UWdjj0BBczR0tM4AKS79Hi4lUkIFKie7fPcONJluBsOLwoFDzBz+zw
	0NjGHolIEGE9VKtxZFC5X/d5wTd5aeVa3aA1s9MG1kVZyakU7emevK465tUzx0p12ERMx/A==
X-Received: by 2002:a17:90b:39cd:b0:332:3515:3049 with SMTP id 98e67ed59e1d1-33bcf85acb9mr17403128a91.4.1760930595345;
        Sun, 19 Oct 2025 20:23:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES39tE/Di3MmwGwTYwN/xeXnDCJXXVgvh9xe8MLyTfqwPZoTQnofwIPkkLhV47dTPyhpVL/g==
X-Received: by 2002:a17:90b:39cd:b0:332:3515:3049 with SMTP id 98e67ed59e1d1-33bcf85acb9mr17403084a91.4.1760930594773;
        Sun, 19 Oct 2025 20:23:14 -0700 (PDT)
Received: from [10.133.33.77] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5df5c288sm6593924a91.15.2025.10.19.20.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 20:23:14 -0700 (PDT)
Message-ID: <2c0011d3-a692-457c-9ac0-a445fc82df37@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 11:23:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: qcom: camss: Enable setting the rate to
 camnoc_rt_axi clock
To: Bryan O'Donoghue <bod@kernel.org>,
        Vijay Kumar Tumati <vijay.tumati@oss.qualcomm.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Robert Foss <rfoss@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20251014-add-new-clock-in-vfe-matching-list-v1-1-0d965ccc8a3a@oss.qualcomm.com>
 <9984bc23-05ef-4d46-aeb8-feb0a18e5762@kernel.org>
 <bc0caeb8-c99b-4bef-a69e-5ce433e6b890@oss.qualcomm.com>
 <c4fd6bfc-cc9a-4f37-99b3-f36466691a1e@linaro.org>
 <CAFEp6-2=GJL-gc+PSyAL4=prp_sXdZJS=Ewg5nP2kcp_Gu85Fw@mail.gmail.com>
 <33513b43-f6d1-4c76-887b-39611a75e1f4@kernel.org>
 <WnfCknsSyJK68PQZkE2q7COZHRpsLOFlr3dcbwiVR6SBWtF9iRQ4MGzp_9q31O0kyhZwoncQWfHjJQvpz7nyfw==@protonmail.internalid>
 <ab43c5c9-edc5-459e-8ef7-2aa8bec559c0@oss.qualcomm.com>
 <0e6e1b8a-d9ae-42d1-b1ad-4314e0d76ab7@kernel.org>
Content-Language: en-US
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
In-Reply-To: <0e6e1b8a-d9ae-42d1-b1ad-4314e0d76ab7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: C_imKmHb9XoCXhjac9lc8SAeNEF9Fc02
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX41MAwrynFpnK
 ROqoVPxCMmH2H2MPnXy3pa+UqspRv4yabaR04DOM6KtN3VMF09uxpeyzTW6LZf/kZnYw6FBaP91
 s9fHIPpqSv1djcTt0O0V5+ztuaGDJv45mWSIPSKp/nSG2/G4zF8CnT8ddYV/PWF8rLo1bFy95lg
 z7BJMt1WZZkReYwyPwsHzG0YByanaWK3oDETY0iFv0TTvLuDw2iW/XsRuu2IOt2JGDAZHXPtLgi
 zyoS2oyBgVh48prAI6Zcjhoh/F03wNC6VIHBPtrkZJ2mOPZt3qecnzE23GxeQar/SjdZqiC1G2J
 6ZxJaRg0/Ja204OMZC2a4VWvDzdeePCS5ICukgAUmuElXHDpxsajXaEP6R5BhP/n3TjzZfye8n8
 mG91d4MEhyk9FXH2xmsvnt6daskgEg==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f5ab24 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KDWtGc0jIIkTB6t2Zz4A:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: C_imKmHb9XoCXhjac9lc8SAeNEF9Fc02
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

On 10/17/2025 7:41 PM, Bryan O'Donoghue wrote:
> On 16/10/2025 21:53, Vijay Kumar Tumati wrote:
>>
>> On 10/16/2025 8:31 AM, Bryan O'Donoghue wrote:
>>> On 16/10/2025 13:22, Loic Poulain wrote:
>>>>> I'm - perhaps naively - assuming this clock really is required ... and
>>>>> that both will be needed concurrently.
>>>> AFAIU, the NRT clock is not in use for the capture part, and only
>>>> required for the offline processing engine (IPE, OPE), which will
>>>> likely be described as a separated node.
>>>
>>> Maybe yeah though we already have bindings.
>>>
>>> @Hangxiang I thought we had discussed this clock was required for your
>>> setup.
>>>
>>> Can you confirm with a test and then
>>>
>>> 1. Repost with my RB - I assume you included this on purpose
>>> 2. Respond that you can live without it.
>>>
>>> ---
>>> bod
>>>
>> @Bryan and others, sorry, I am just trying to understand the exact ask
>> here. Just to add a bit more detail here, On certain architectures,
>> there is one CAMNOC module that connects all of the camera modules (RT
>> and NRT) to MMNOC. In these, there is one 'camnoc_axi' clock that needs
>> to be enabled for it's operation. However, on the newer architectures,
>> this single CAMNOC is split into two, one for RT modules (TFEs and IFE
>> Lites) and the other for NRT (IPE and OFE). So, on a given architecture,
>> we either require 'camnoc_axi' or 'camnoc_rt_axi' for RT operation, not
>> both. And yes, one of them is a must. As you know, adding the support
>> for the newer clock in "vfe_match_clock_names" will only enable the
>> newer chip sets to define this in it's resource information and set the
>> rate to it based on the pixel clock. In kaanapali vfe resources, we do
>> not give the 'camnoc_axi_clk'. Hopefully we are all on the same page
>> now, is it the suggestion to use 'camnoc_axi_clk' name for
>> CAM_CC_CAMNOC_RT_AXI_CLK ? We thought it would be clearer to use the
>> name the matches the exact clock. Please advise and thank you.
> 
> The ask is to make sure this clock is needed @ the same time as the 
> other camnoc clock.
> 
> If so then update the commit log on v2 to address the concerns given 
> that it may not be necessary.
> 
> If not then just pining back to this patch "we checked and its not 
> needed" will do.
> 
> ---
> bod

@Bryan, I test two scenarios individually that also consider @Vladimir's 
concern. I confirm this clock rate setting is necessary.
1. Remove 'camnoc_rt_axi' from the vfe clock matching function.
2. Remove 'camnoc_nrt_axi' from the vfe clock resources in camss.c.
Both of them block the image buffer write operation. More clearly, we 
will stuck at the stage when all buffers acquired but CAMSS takes no action.

I agree with @Vijay to keep 'camnoc_rt_axi' to distinguish between the 
new one and 'camnoc_axi'. The disagreement concerns how to standardize 
the camnoc clock name or how to differentiate between RT and NRT clock 
names if a new RT clock name is introduced. Other chips like sm8550, 
sm8775p depend on 'camnoc_axi'. Meanwhile, 'camnoc_rt_axi' and 
'camnoc_nrt_axi' are both necessary for QCM2290 and X1E80100. But chips 
like QCM2290 and X1E80100 may not need to set the clock rate but 
Kaanapali needs. @Vladimir

We now prefer to add 'camnoc_rt_axi' (Right?). Maybe its better to add 
comment lines to remove the ambiguity whether 'camnoc_axi' denotes to RT 
or NRT. Please advise and correct me. Willing to receive feedback and 
suggestions. Thanks you for all.

---
Hangxiang

