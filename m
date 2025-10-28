Return-Path: <linux-kernel+bounces-873329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C540C13B49
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05C655053D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386A92E7F11;
	Tue, 28 Oct 2025 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pTxfZJ3t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BBF2E7F08
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642290; cv=none; b=VxDBB/E/CTgY9ZEefwK3hV1I/i/IU0h1EDxDRG6aUlgc4RTyLcEbB/APgVU9VexIRf1/rqTewX57oZbfllFn8kPb+8cWeNfI9DTAZT1w+9M8rG1/vkbznS1+NqKLljTKkXpFZTX6YSeepcZHKqK9x95TDLFmBZ0v9Wpf2qTYSOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642290; c=relaxed/simple;
	bh=gJL/VQkEebJZeilLCE8uIPc2mNo+c91Tynj4Uuw7Jx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ThAmTYBHlIO8zhS7rvk4iGGOTNf+rePwAuqutkUR4VaQ1sAFLvhGyDUwwH08/PGroiWoMFfNg4YtdaOKVQ0QDunXSMHQfA1FixIewgikrFEO1OE36hDqwaeBwqRB57kT1XFU60dnsqi5mPPFVOq5+VJF2yo7m15GUAIxkNeEABw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pTxfZJ3t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S7UWf82546723
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kgjycyY05GqmtglQxd9XJy3hOTKLwLYP/qRgt/w4UOo=; b=pTxfZJ3t6EtY2/GJ
	F5v9qkUTzh1ABl/3z8zDmBdAFd0ezVjSMroliqwBzOB1HyYeDRFwwWngxNNKb6Ee
	eci0he05mEsQlxI0Z30R12H1sbVi5eXqmZn1LAEjKYLvMeIo0uBzly62/sWgSM3D
	Jxqc7RcnPdoFEWCqGarYmN/UCiU7gSCnSelgtIXCju/ygfgxPO0RJdVyppRuKzgI
	pylKX3bIwaz6dQfb1wHwhrce18+twMqsGwdJ3Q+mnGxl284WIag+ExVPaipwE8ap
	0hq7cVIiCvBhxGbHIxyAgtak4Cd8goUTCOJyhhFvDT0swxmSQwsDpMvPuvk8F9IL
	tlZOIA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a27s2kh1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:04:47 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87df3a8cab8so17141946d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761642287; x=1762247087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgjycyY05GqmtglQxd9XJy3hOTKLwLYP/qRgt/w4UOo=;
        b=oWrauAXNGsLa1rL6jFxl88xQeffMGTIEWsWA0awpaU4OdiCNfUUssoy0iT//VhkuFP
         f7r1ydn0QRegkTIoeEJLcdtpJ4mGTfOzfm/p7HKXMH8DCbZVzo1MyTGj0GZKeCWrW7ci
         FHaOUeGRvHhX/gf8U/25rFGfVGxA+pujuGrNIESPaPtqoF3kEwmVgCtESlK/ttiFEv+D
         MjeJLAadJPId7fhO7XD4blRyYV4I0eacSJC6Ad3ceEYMqH+Otf9JiXpy7GMeyxF3MFFx
         DGrCE+7YKVJtSggzO6DFWdeZ92AYKarLB30bDrMTpEof1XQrpnSBKA2k2NHWqgTd4Tnl
         rczQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9YE4VpsjQP0jKT61N6BgusYXHFYO1uGU3PRqgmwIP8fkgaavvcxOgfCieZs+dmcVFVKMj+hgrtSTRksc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzdZA9sEUChtseYbiKaEIF7iZWcMbFL/1d5R1LxDfoahQdVUfF
	S6DMh8RybKr4r77QjhIfwYAFz+Jsy6rz9WNRWeJ8pMmU55RxGCa2kfH1CcA7L4QaiAGGc0Y9EaG
	O8qrRDdTrvtecpcesd8JUHrZrDE+VUeO46hJqKnbTWRjV51jtywx7AtEF/sm/7leKi38=
X-Gm-Gg: ASbGncv/l2DLWc7xcfQWsd0nzZ/H+eNr4c2PwUJ/6eze33bYKCp/5N0XPXMouYG4SIs
	NFeCdeOLwyZODAc94ltcMvNNOu+bq9S5o9C0cPD5k8AU8bSYzL0Wr2iyYjerChXXk2NUkwc96V7
	+1OS2mREn4g4HsftHLiT/ltK5CV0uJwCK6qLMfc1G36XeQQL7WwBJ+MfsQffVnB20qp2M5YbLRp
	GEvU5muuA7D/Cl3bDA2fTKF/CcZS3KwCXUoMggAzfy+JZTSM26epsVaRZEMDexv0t9N5Mdc3Tz8
	4C2J4RMybdvuW8LE1z9WMIJOKRRulAoTovQ8R2wpzo+alCOkztJf3ek9nrbvFy6bqMWzICmE/Xx
	h++1p3PEfWR/df1d0ZXBnVpE8LxucBPxR3g5hdlmqdp3DOXwCJs/++aBz
X-Received: by 2002:a05:6214:2681:b0:876:2e1a:e77b with SMTP id 6a1803df08f44-87ffb15347cmr19874816d6.7.1761642287138;
        Tue, 28 Oct 2025 02:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGQpFCfAyIuLZ3osfOfScjn4ZNf/jIirr/F3GlO3TYl9NHKnRmcgJmbEit6T1kcw8HvVBZjA==
X-Received: by 2002:a05:6214:2681:b0:876:2e1a:e77b with SMTP id 6a1803df08f44-87ffb15347cmr19874636d6.7.1761642286662;
        Tue, 28 Oct 2025 02:04:46 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853e5138sm1036189366b.44.2025.10.28.02.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:04:46 -0700 (PDT)
Message-ID: <918fc9d3-2cd5-4442-8bc6-b930596d95c1@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 10:04:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: soc: qcom: qcom,pmic-glink: Add
 Kaanapali and Glymur compatibles
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251027212250.3847537-1-anjelique.melendez@oss.qualcomm.com>
 <20251027212250.3847537-2-anjelique.melendez@oss.qualcomm.com>
 <20251028-private-chirpy-earthworm-6fccfe@kuoka>
 <4cb41e69-fb32-4331-a989-529b5af0081c@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <4cb41e69-fb32-4331-a989-529b5af0081c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5XcA7He-JWZbJ5Ky2zBcNtpo_FYVNI-C
X-Proofpoint-GUID: 5XcA7He-JWZbJ5Ky2zBcNtpo_FYVNI-C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA3NiBTYWx0ZWRfX16IZ0PMnwSg1
 wfmq1qhHFb/H1vcux1aqQbfzlP42wQ5aO2pGmBbiSW9DT6+LLB5C2eVcYUW7CuiGDTJ89rOkPnk
 sdbial7RGLgserBt9UrcBSEOBCAh+1g1EnPZfnBkSb9H7WsG5wPe5q9V/kfcbJxtbnQZzGIvXDa
 LknB80WdBF0D80LBDxsFQLqfKPCAUkBaZ2BkVt/leQTn1h4isMWTIROijqz4R5L1trMDhUGQh7u
 B1MdfWzWh7GP1PhDNQovll+AczAJa8aAEgPw20zvuerZH7cc8W85aZx4V7PU7zwJsJt18Z4z4wE
 CKWCb0URSm0jNEJ+xuKT/bkRbCtT7Kbc2yYs1WK6EUXZ82jFHn4sXcTvgsXJ20sjyn0FNhcWTlL
 5GM/9O/lyWApOlqi+K0C8IcZjWCxiw==
X-Authority-Analysis: v=2.4 cv=R60O2NRX c=1 sm=1 tr=0 ts=6900872f cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=PDJlN-RuetHZVnMxc_UA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510280076

On 10/28/25 9:36 AM, Krzysztof Kozlowski wrote:
> On 28/10/2025 09:29, Krzysztof Kozlowski wrote:
>> On Mon, Oct 27, 2025 at 02:22:49PM -0700, Anjelique Melendez wrote:
>>> Document the Kaanapali and Glymur compatibles used to describe the PMIC
>>> glink on each platform.
>>> Kaanapali will have the same battery supply properties as sm8550 platforms
>>> so define qcom,sm8550-pmic-glink as fallback for Kaanapali.
>>> Glymur will have the same battery supply properties as x1e80100 platforms
>>> so define qcom,x1e80100-pmic-glink as fallback for Glymur.
>>
>> What does it mean "battery supply properties"? Binding does not define
>> them, so both paragraphs do not help me understanding the logic behind
>> such choice at all.
>>
>> What are you describing in this binding? Battery properties? No, battery
>> properties go to the monitored-battery, right? So maybe you describe SW
>> interface...
> 
> Or maybe you describe the device that it is different? >

Certain versions of the pmic-glink stack expose services (such as battmgr)
which support different features (e.g. 8550 exposes state of health and
charge control, x1e exposes charge control, 8280 exposes neither)

There seems to be a similar situation here

>>>
>>> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
>>> ---
>>>  .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml      | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>> index 7085bf88afab..c57022109419 100644
>>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
>>> @@ -37,12 +37,19 @@ properties:
>>>            - const: qcom,pmic-glink
>>>        - items:
>>>            - enum:
>>> +              - qcom,kaanapali-pmic-glink
>>>                - qcom,milos-pmic-glink
>>>                - qcom,sm8650-pmic-glink
>>>                - qcom,sm8750-pmic-glink
>>
>> Why qcom,kaanapali-pmic-glink is not compatible with
>> qcom,sm8750-pmic-glink? If Glymur is compatible with previous
>> generation, I would expect that here too.
> 
> And again to re-iterate:
> 
> If X1E is compatible with SM8550 AND:
> SM8750 is compatible with SM8550 THEN
> WHY Glymur is compatible with previous generation but Kaanapali is not
> compatible with previous generation?

The announcement date does not directly correlate to 'generation'

Konrad

