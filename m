Return-Path: <linux-kernel+bounces-860907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B189CBF1449
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A24084F45E2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F0D30595A;
	Mon, 20 Oct 2025 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fe4jnNZN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C627462
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760963984; cv=none; b=e+IaTEa519StV2vw6z+m1/lG/9wJllUdo1O18R5jpOH3VRLGL+xzF34ghR6uBcMoJ1Y1FJ359ZXqkaMy0lnUHaeKKd3vrsG0+shYxX1uKt63Y00Nv5H9Xxzo714Y4skT9xj6poHczVXa+uLlgAqkIj/FnfgaqaP+oDMBdwTx9L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760963984; c=relaxed/simple;
	bh=r0LI5+rFfxj7D6qdrxS6AU8wGcUsrj5XfBe6LzH86mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3xJWrqAKF6dL47Z4uAfaB6uHQ6ofTzIfSS1KM1hKkQwgWTn8P3Q0hUNYpjFw6hCm00/hhVUKyNte+P2ZEZFiBl2uDDKTI3mcRO1/T2lEeTHGC+BPAkZwfr4+j/iiXJQ32MuhzIJx3YSFUI3cWX9NrSOOcZI/6YDHdKpCmNjsnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fe4jnNZN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBjLCE023394
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xyNWSoXfav/4VdYirXx6+KHz+a4mFdCsFqj3qAZPw9A=; b=fe4jnNZNruhywKrw
	5skvbewk0zPu1FKbGDfM2yNBEBcbIKy3+Df5UMy5VianGU3XlFOcdxJqnmBkl8Ea
	skU7FktlekvLCllqMbxFhVmTr+CKTedDe/TPxlJiNcFFCDf3/yAA3+ZUYRpQyIhQ
	ZecuuuOVqVHZBf8odfv6XJVBgWh3LXjjFV76qey0HJYQ3JRlyN9QBqQGlngK46xu
	DNy4iV+aJZfTQfpcMlWFole/5PUa96NNDykytKisX0emyqlZ2gKV3apcFi+3Vsj/
	Q3EOiXZwhzinQ0JVENnoTv2EL9PfKQ/VqsuIo5//4nhEQaWMYvW+KysUKyGEWZq9
	q7ZXzg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2gdvs39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:39:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c103b902dso18388876d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 05:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760963981; x=1761568781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyNWSoXfav/4VdYirXx6+KHz+a4mFdCsFqj3qAZPw9A=;
        b=iv6Q3YoR/Suu0G6gO0qHl+IgsuxH0TIfquLQ1g3BRex99UAXrquuQoPHnTALn9Uu8+
         pAP6/WinS3R3rYisvuVLve+bvIIvbw05J7O/Z13/88Sbq3os2GzUwkDRflKr8ef9RTqy
         MlPhwlteUjVwI59WURFgXQQ0V/Bg/8Jroe3khNVlcGmY335e5sDsfULMGHdtbMziXL5b
         pEPfK1JBgD0uYLOO/+GHf5YeOCJJa4HPFjTkMrcXSCFfq4OZi4yUZBC8JGb1exGVYvDE
         V3wM3UV1hNXIZubrJ10FJF+14uBzyXsjAFswZXBMAbW+U890VWJ+d24j5xVlPO7VRxfW
         SiLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxb23HmRp++cAiGyItvEAgd+Dfrw75FDM45I2mrizbnzAs6wYuXS51oRGx7SMp0/CVdaNsbFFVGT6krNw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb4yyL5uHiNf22KjoE1cvlPOXZfDDdOmHZ8u9x6RMrLyTVtSPa
	UxufHISpvYy4FXuqy1mR7CvvcFs+yZB8oRA9C/YHYH07sRDrCwbWN69ohblHiXccQshe3YF+KoH
	FKHL1nt3Q6J4Hu7QvdM7NksvHw1ooUP4Vc2pwHDljty/7x/RTwd8VWdPfV+krKz8e0vtHJZQ/jh
	c=
X-Gm-Gg: ASbGncvMxhLw1KxNp+yYOERqCmWdtIwF0Y8vsO3AsqTmO0F4vbbsljkeVmbB889pmZr
	6u2vrjshZb9ncgIdwC2cLJIrF440P1rA83uo6wOCdg8OcgyxflhXLQDvL2NTN8njWBf0TSOJvN/
	xVpi9QJU19r4ObZDWyK5rNFD5aiCJJobNzZ3dq6Jnq19nY5Xxu7zIxouvOP+REvs0uqTg0uokyR
	43YCua3MWDSbIqMgVQjm62G4FEij6KkfD2vDwvEOnjaSMb8xNh4b+VAC8hK4u8FLdZL/JK/im42
	IbMq5pFov2FCMsBTPPax+O+rB5qyxL0IlPUFCNjapDTS3K3wAl3z2uJRKnF3Zbx0A5p0TkB99O2
	wiS9jy/w434rQT0Ij0bAnK4cz4mYvISoMVgBrFNdMjJjorK/83O1xQoKO
X-Received: by 2002:ac8:574d:0:b0:4d1:7b86:3618 with SMTP id d75a77b69052e-4e89d1fa0cemr128679501cf.3.1760963980888;
        Mon, 20 Oct 2025 05:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/If/fFIJQ3q6nPyTQg9KjwZgT9ia5w0Iepq3jOLMuoIfrodQuufPhmYoIi6icQqulsQhUJg==
X-Received: by 2002:ac8:574d:0:b0:4d1:7b86:3618 with SMTP id d75a77b69052e-4e89d1fa0cemr128679171cf.3.1760963980277;
        Mon, 20 Oct 2025 05:39:40 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb6298e1sm768532966b.66.2025.10.20.05.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 05:39:39 -0700 (PDT)
Message-ID: <dab30485-498e-4cae-93eb-b2f40f928465@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 14:39:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sdm630/660: Add CDSP-related nodes
To: Nickolay Goppen <setotau@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
References: <20251019-qcom-sdm660-cdsp-adsp-dts-v1-0-9ab5f2865a6e@mainlining.org>
 <20251019-qcom-sdm660-cdsp-adsp-dts-v1-1-9ab5f2865a6e@mainlining.org>
 <c605434b-b0f4-4a9a-8b28-cf1c77d5f20f@oss.qualcomm.com>
 <35c670f1-6de6-4f78-a452-fcffc57ec93c@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <35c670f1-6de6-4f78-a452-fcffc57ec93c@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfXxgE+9Oy8LEmz
 hxNPnFVaQCwOuuykfWsRAOerw3fx9um7L25PL6j2dFw9NEl/ANwb22DXcU9jNaJbqnwxSWWAEA9
 ib76iRs7gG8lwe2aUgOny+/+S8I6UEoA1E5sBBoNFCl53eE96T/WZib/wF0vAXQunxPIuJnD/Xp
 czCxVPo9etp8X5bCdxxkmwGjy2ddfn8mCVb17pMpi14LOv9Ca8Y7RSE2QTLSUxZNp2T3wKFkGqk
 1WqHyeMqoz7JYD5o3iz/6vm/N1hAyGtocViA5OyNdhigipajEkr4tONwXm8pTzpw/Vq1JdYORUG
 D035oX+AUlv3ug5FrtAndHDgZUgHSDtlvcfP/upcHZQrSg2GnUhtbA8W9aNlVtE81cHXUZ1cVL4
 8zYz///JBLQuabto4ahfY7N1T3s57A==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f62d8d cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=WWYcvNe4FWpTLsP_R2gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: _AvKBrIrWOYfhRjPQKyivo5jN0Jd0cLB
X-Proofpoint-ORIG-GUID: _AvKBrIrWOYfhRjPQKyivo5jN0Jd0cLB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

On 10/20/25 2:38 PM, Nickolay Goppen wrote:
> 
> 20.10.2025 15:27, Konrad Dybcio пишет:
>> On 10/19/25 6:27 PM, Nickolay Goppen wrote:
>>> In order to enable CDSP support for SDM660 SoC:
>>>   * add shared memory p2p nodes for CDSP
>>>   * add CDSP-specific smmu node
>>>   * add CDSP peripheral image loader node
> [...]
>>>           ranges = <0 0 0 0xffffffff>;
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm636.dtsi b/arch/arm64/boot/dts/qcom/sdm636.dtsi
>>> index ae15d81fa3f9..41e4e97f7747 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm636.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm636.dtsi
>>> @@ -16,6 +16,20 @@
>>>    * be addressed when the aforementioned
>>>    * peripherals will be enabled upstream.
>>>    */
>> You can now remove the above comment ("Turing IP" is CDSP)
>>
> Remove the whole comment?

Yeah since it's addressed now

Konrad

