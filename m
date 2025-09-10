Return-Path: <linux-kernel+bounces-809945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD318B513C0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60C13B1C12
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1DE314B67;
	Wed, 10 Sep 2025 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KDKYBHeZ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F613128B6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757499648; cv=none; b=qNAWZxRGqDAEfkijUzluyMa6S8FCBPeDiABiNTtbbYgYaUP6MASfgmbp2rnIF0cYrvJp4uXZrwwWLStKkUOmAjevmNB1CiKkORTOnLqqHIr8OhqC2ZogYEZZRaPNasxKbxY0RVRD+muJmoER0FOFOboMtYm3cUjn+FOdjcxb2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757499648; c=relaxed/simple;
	bh=dPyTE0l1phm6v0Rl0DSEcOvngS19JHw4+Quv+kDqtxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jm45MGT6YXkXFLHy6PZdNouK8PZMGWlZoMaP/+42nkJe0SyQoGL732QMSP2rh7tZlP2O/M7Dpn3vPM/vS2d7SL7a4TCKaw4W/HEKa9Ib4lnK4K+9FyjWqbIOXV6P9CQJ6Q6x7nFuy2vgB5/2JREbYmwMbkuEM4AeVlfa1Z90P40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KDKYBHeZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AAFFqL021314
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i/d/gpEsTNH/PsmnaA/x5LfmNsy7Z1rG7KWqKHeh/ss=; b=KDKYBHeZXggbS5vp
	9kmDOmGy3Ztjl8sOsXSc+KactyCsBTXGYzO5gm6Buov/5PfZt400snyCKF4vUTBZ
	rM7fxhixCTPt14Sepj1El1/vikXTffE6Ta5/GoC2R04RSEN02rIdHPMeIk6xYeYq
	YPq2D7Scm4x6RbRj6BECJvj85IDImR9zbhlKgN8SpOvgxr4ZtKzpieARwVSEqKKl
	Vk8ofQvCATJFZRe47qaZdpOCr32t2ayUN7IK4eTz93WbzV0WCxlk1j+JueHDXVoV
	oVxzuyLYS6rqBFq/AmHwBdhsaQK2jF2o0VsS2Sw+pslUVy+5IwoCa78hlAoy07pG
	kUgjnw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8abcx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 10:20:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b5f76fe6f6so13250831cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757499645; x=1758104445;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i/d/gpEsTNH/PsmnaA/x5LfmNsy7Z1rG7KWqKHeh/ss=;
        b=DLQoW5RW+fLQ16nOiP4qgELB2lrqXVrWKaTfrafg7otWTnscUTorY1Hp/NNsDCsROL
         4Zj5c1JzZzGX2wKh/LC7QBOBgPcEVd4t+Cn7q/yzm/BBatc/D9cCGcwwcj3JIEcKdW/2
         Wr0oECP6Yl00f0eTuNUx9DdE4Gijmgfb9GSvE85eWpd5RlFiuVMFSU+KhHvyBarnrPkb
         /pqfpPGRHzdYZMluoVwLvrApsGA/Fb2BtlkTf/DtBk8lpkDQFe6mELJgkOdex0PCXASP
         61/2ie5iN68NMDKn7hznA5aeMxCtBChz9xPj2ystcUUKCv/KtWVOXgymrrTSI6dLhub0
         E4eg==
X-Forwarded-Encrypted: i=1; AJvYcCWa42hRr4MFnvyv9ojCwduuL7Jmz1E6qfalXmH0cJx5moSSCK7QA+jeMxw4qlG1d52D4h1uNcBH1RMctbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfdE16GP5BLpz2WG/ZXXSQ/gSAKfhX9HhmkOcb7fU4pjD0bwYK
	33R2oSMdDs+AlRe6xCMxhYke/zQ7ZZ0lAk2cRhl6pUe9hxw4Grj/EAKv9dfeYKiERy2799ACPIb
	3uDMOpD8vTFHf9D28qhFBfjselgPZPlC8FultC7flCiJpJuF5S7rN3XrBwZcbyewbruQ=
X-Gm-Gg: ASbGnctbq3lgNe+hLK1QFe997kbJGFbx5Ku25QrgSHIVOIeWGeImuadkB20bLiV+AOW
	1tBdp0hk9icpv9LkxlZZ049b0acS/KIYCGnXPHbjsHj4vhKnYE/gT4Cz55MrN2wkmEsYYCzt6i/
	S1spaRVSd5rusfY/CLmIjG8O7hXQqs83Q4zpi8BKo64v2BscadOSyau7XaHJnW4oLq3kb6sqYFc
	L+BJlmNVSmiPx/M2NREhNPFYbGlhI7ox7Yk0HEM8GH1x7rlmVi7GTrzS8CTb+QTADNNblUtO24t
	0vS5f4OcGvSdjXIhnO0sBaIGXh/vxdwF1VCoFJWms56sERY6wWpeewo5QM0GsX+DWXqZDFH8cam
	GGGwkkHI8biJruj4jbomG2g==
X-Received: by 2002:a05:622a:2d0d:b0:4b6:2de0:10d3 with SMTP id d75a77b69052e-4b62de01819mr3370461cf.10.1757499644959;
        Wed, 10 Sep 2025 03:20:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn0gApGINKlGbJZ+b48iUyZqmQ9MAUTg97FcSCgm10scqcmE42igYJtWIFBYJDs8y0ApXJzQ==
X-Received: by 2002:a05:622a:2d0d:b0:4b6:2de0:10d3 with SMTP id d75a77b69052e-4b62de01819mr3370171cf.10.1757499644207;
        Wed, 10 Sep 2025 03:20:44 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b078334d74bsm143041766b.57.2025.09.10.03.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 03:20:43 -0700 (PDT)
Message-ID: <136ad3f0-c4a9-47dc-9c62-682a830da823@oss.qualcomm.com>
Date: Wed, 10 Sep 2025 12:20:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: qcom,sm8250: Add QCS8300 sound
 card
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com
References: <20250905142647.2566951-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250905142647.2566951-2-mohammad.rafi.shaik@oss.qualcomm.com>
 <43090acb-ea36-4015-b14f-78d44d789d42@kernel.org>
 <a9507045-b900-49ee-8841-0f8fd30816ba@kernel.org>
 <abc66798-dc91-4860-b0b4-de39a58b5745@oss.qualcomm.com>
 <a8dcffa4-c578-46d7-8fdf-cd4f5a29a2a6@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a8dcffa4-c578-46d7-8fdf-cd4f5a29a2a6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68c150fe cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=-LPFx5p5mU8rmwG2qkYA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: FYdlzNWIBqAH1EDbT0jiKFhPmxSpErVG
X-Proofpoint-ORIG-GUID: FYdlzNWIBqAH1EDbT0jiKFhPmxSpErVG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfX2wQwrEjA4Vxr
 T3V1G91D8b1DjU3rATO5g4Y0M4EAatiik77Z/HFVHn0dVeqq2HZSOBgcVQec5gFQDSGhwRUFN96
 H1hiRvPY2mFMO2epDOWawHraC/U8u1YTmq1viC9tA7GTHBsZd+nS3+dMA8zNe4iTfmrLf8AIKTd
 IBqfUz/QHepeFq5GAAepphpNRC5fuHyRrW+Sp5Vwls4RaVUbJd19TWNrfxg0GLsTy0DveY2CaZ9
 fWXps+VExnaDk56YTdXpJj0iWBIbU9vIoxtMnebDb82SX6CVrzYCYy218thK8j6d8I5CaUr2EHv
 2IlqecQlQyH8p59jnSx3LOSIQMQWjS/Q+4OpbCnpZ9NzxLe2W7+ckmkqKh9xiPNQ5IjASjf4CFa
 MQv86Ehn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

On 9/10/25 11:43 AM, 'Krzysztof Kozlowski' via kernel wrote:
> On 10/09/2025 10:05, Mohammad Rafi Shaik wrote:
>>
>>
>> On 9/10/2025 1:09 PM, Krzysztof Kozlowski wrote:
>>> On 10/09/2025 09:26, Krzysztof Kozlowski wrote:
>>>>> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>>>>> index 8ac91625dce5..eebf80c1d79a 100644
>>>>> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>>>>> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>>>>> @@ -35,6 +35,7 @@ properties:
>>>>>             - qcom,qcm6490-idp-sndcard
>>>>>             - qcom,qcs6490-rb3gen2-sndcard
>>>>>             - qcom,qcs8275-sndcard
>>>>
>>>> So what is the point of this compatible? There is no user of it and I
>>>> think you added QCS8275 for this case exactly...
>>>>
>>>> Shall I start reverting commits from Qualcomm because you post patches
>>>> "just in case" and turns out they are completely not needed? No single
>>>> user of such code?
>>>
>>>
>>> @Mark,
>>>
>>> In case it wasn't obvious, please do not merge the patch till we get
>>> some clarification. For sure it is wrong one way or another: either
>>> incomplete or just duplicated.
>>>
>>
>> The device tree currently uses qcs8275 as the sound compatible, and
>> the corresponding Device tree changes have already been applied and merged.
>>
>> Reverting this now would break the ABI.
> 
> If reverting would break ABI then:
> 
>>
>> A new device tree patch with qcs8300 is currently under review:
>>
>> https://lore.kernel.org/linux-arm-msm/20250910044512.1369640-1-mohammad.rafi.shaik@oss.qualcomm.com/
> 
> This is ABI break thus NAK.
> 
>>
>> Once the machine driver and device tree patch with qcs8300 are accepted 
>> and merged,
>>
>> I will promptly submit a cleanup patch to remove of discontinued 
>> compatibles from the machine driver.
> 
> So this is the same hardware? Then no, we do not rename compatibles.

The QCS8275 compatible snuck in before we concluded the pathway of
renaming the SoC to reflect its actual name..

In this case, I think we'll just have to eat the cost and go with the
existing compatible, because it's simply cosmetic.

That said.. I'm a little confused why we're accepting SoC-compatibles
as well as board-compatibles for soundcards (e.g. rb2, rb3gen2,
6940idp) in parallel.. is it with an intention that the SoC one is
present in reference designs and therefore will be common?

Konrad

