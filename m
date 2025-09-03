Return-Path: <linux-kernel+bounces-798718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6BAB421E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AB41894A89
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CE830ACE0;
	Wed,  3 Sep 2025 13:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C7fAWz/r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A23093AA
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756906606; cv=none; b=L9ENcHqUW2v1Go+IK8M1L1so/RBkP44A9g4EY8PX4exNYRnnvHvAtHO01JVlJgqsg7cgjy9YB9iYpUjZoVat/o7dV4bMKVHm9iQebuXIUMTzu3+gUZhk/BYXn+lOxUsx3SSj9Ub0WScw1Daj4WUOVA0Uhxuz1OB2WO8J2LywL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756906606; c=relaxed/simple;
	bh=hNsS2uc9yOMQ2NSuhnYTKcplUu66M1ylThnjBJY/bbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYcaAzuubJiOYrilYMHR05UJpvmGnaaaY2gdEw2Zn5Tk3PfBVtnm+c40XIn43DBa0k7j1KfUJEFBAYFmHBcr8hBko4rsop31R3Cjh+hzbXNAJ2FkVQzw+KUKQPZmfcRmUGaWtn0WDn0GFolQ+sJCTizCpVQnryhaeUjVxoWfgUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C7fAWz/r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF2v9005150
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 13:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lN8gdknZMrOiQok/7MvQU3sHMt/V6D5KvcciwLonHIE=; b=C7fAWz/rbvK32/ph
	nAkHjns/kz0KodePUhe9V5KmdHJ5AEnJnJyqRlkMQpyXEMZ6OS1uP0tb9jcmByBh
	iv4TAlYU1/i3LW8nUal8SkvnEvJK7aqhA4umZZ4DYWdO5/3Kc+fEC0E+sx1pzLwR
	sIGqboGIVun+G4ER13ZhrKdVqZlcuiBEAmbcRPzm1LW8bJ2pOAxmTq910/s1TnOx
	Rqmdv3ezfaWdGo2bHT1yPXUm62Qfbo3KbJ1AUFA/enB/5xmPOJje+njoYDPF3W+D
	D6dCkoOwRbBB2GWqs/KbMQFGvodjMJnFxcAjycmVk72zQB0N4JXjyJb0TXI1yAKa
	bz6OMw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s3x08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 13:36:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b2967fd196so19706851cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 06:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756906603; x=1757511403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lN8gdknZMrOiQok/7MvQU3sHMt/V6D5KvcciwLonHIE=;
        b=Q0urmy2K76HluM6E307clNPawdTeTbu+25mqFDu7uKf4iTVNEU7TZGLCsrbI5C5T+x
         CC77VfvCtbN+WBajgXUUghHb96F9Is8P9vPmDr1+aq0qNaOt+L0bGXWsrR7uqe9YSbQf
         rPE6akFT9k6EyQj8WhiEQ+jEM4eaYfgojx0LCnM+38wAjUTFYCm+U+viRqNrzxtZ4jLi
         Ub5JgtV10O3dAcfpGsVgqoRXSZQHb6OPUcOTrQvrqb2Y0z9N6OnY513dBNYwMvEDHTCq
         iBgJhnVB+CJfp6+U1rjHZPbcFz83nz7BcPQBndMIvTIDSqAVdf1DmOr/NUJpIoDLNKxJ
         mtMA==
X-Forwarded-Encrypted: i=1; AJvYcCV48Spmswu1RuTJq3pTaLOp8G/w3xhrfvsMlDKBzRpnRDyXksQNI1lOo1cp2FeN64CUH/xopSTWE0RvDv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTieJZLuLDrHJhl3txg7zOepNQ3THCYIOGDhUacaabG+Ryj+ps
	P8dwrXVougS4SxOcQUe9HL7j+6cAhKCLnortkTbzxobXFh0pA9oa7WHe3g4ue+NEquyJDEQlGTs
	6/RaC7y7vz8a5kbvewl0FFFt1OoNgBP6StUUlrK5QQCE3wip9Tf2BFTg+GYHEzwZRM4o=
X-Gm-Gg: ASbGnctWf79eLbhK3KgJMeUyp8y1x1eOGeng2rQTc1nvXSfcm7xlHcxIgnxJtPKmeO1
	2azaVz3mT+V59hFbFi3yJcLhfJvJcBMpYFxcDYoytG9v9R1IayT2X4EcEzUs7ohyRnkvYpsjXNQ
	v85r7EBll2srDPKO4iVmQgNCqEkFHGzs6K5O0INo83n4boawD1MF2gKuLHIyo14mhtdwBh9+btb
	tOKFlWsg7efB2hPP3EhY+M2W701rz9RQU2J8iywK/erUATxd7G1RC6SikLf3ExMg/V4If8EYrMh
	t788xicgNmtevCwUMnv9HPriVROezZzJfsUkXfvMMS2jGYIvJX7Ro79YwBOu5aVuc9Nrc6Ylbw4
	a8RESFGWo0nCNIaVZypFaXw==
X-Received: by 2002:a05:622a:4506:b0:4b3:4590:ab74 with SMTP id d75a77b69052e-4b34590ba5bmr55007031cf.13.1756906603121;
        Wed, 03 Sep 2025 06:36:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErXOAvUamYTNZwdXsoIgSgCVJyJNUAEhsmG6GIw8r9rMGaKeXaF6CVWYD77CBPNPOt2y9/Dg==
X-Received: by 2002:a05:622a:4506:b0:4b3:4590:ab74 with SMTP id d75a77b69052e-4b34590ba5bmr55006561cf.13.1756906602636;
        Wed, 03 Sep 2025 06:36:42 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0423ed35e4sm805734266b.25.2025.09.03.06.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 06:36:42 -0700 (PDT)
Message-ID: <f169be5a-faa5-4824-861e-27bd2083b9cf@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 15:36:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] arm64: dts: qcom: sa8775p: Add gpu and gmu nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
References: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
 <20250822-a663-gpu-support-v4-3-97d26bb2144e@oss.qualcomm.com>
 <f11b778d-eba1-4712-81c7-b83f2cb38b46@oss.qualcomm.com>
 <exkrgx6rdotfrrsnklsd7zk4ydehsk5vaoevibpqisyq2dwbd4@sa4kgnuexlna>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <exkrgx6rdotfrrsnklsd7zk4ydehsk5vaoevibpqisyq2dwbd4@sa4kgnuexlna>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfXxaNfkHV0qJsK
 RBkw3S0YmgttYu03UI3Ryj5qGhoqSUEYvCIFh52KmWkyx6+8v/Uo9jtma2L925/A/vvFuH1plMy
 fpFjfd4vGr//zscCpEkAspjkE4x2tt64aHUJaLfC4FTOvg1h59VKXxpomiJLxOhCoPrvmWZjDiq
 iBmISbXo2oWn0VagNJHxW4mEJaoGdVLMztOw7djCnw0x6Lpv5UFNsIuZ22n/d7usX/aYYdY8Mf+
 SRxSXjN2XP3n+QEFALsBAgvlJbd8sW+56IvXY1ZO0EPrvu520lL5/ckLYDdfiEjiPV3+N/yRuNa
 UwnQ37lZtM01lo8GC+XB5d5DOHdwkd0U4pTjMnW8zzA+5l2WLGGdsiGf9jVZOrqaUZJLRJaVLju
 23lPJgLf
X-Proofpoint-GUID: _d9HLVmrvPU_AOdR2BHQhCspg5W_TzvI
X-Proofpoint-ORIG-GUID: _d9HLVmrvPU_AOdR2BHQhCspg5W_TzvI
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b8446c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=azIdKaGB62pXRnNptYYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 9/3/25 2:39 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 03, 2025 at 02:26:30PM +0200, Konrad Dybcio wrote:
>> On 8/21/25 8:55 PM, Akhil P Oommen wrote:
>>> From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
>>>
>>> Add gpu and gmu nodes for sa8775p chipset. As of now all
>>> SKUs have the same GPU fmax, so there is no requirement of
>>> speed bin support.
>>>
>>> Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>> ---
>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 116 +++++++++++++++++++++++++++++++++++
>>>  1 file changed, 116 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>> index 8ceb59742a9fc6562b2c38731ddabe3a549f7f35..8eac8d4719db9230105ad93ac22287850b6b007c 100644
>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>> @@ -1097,6 +1097,18 @@ ipcc: mailbox@408000 {
>>>  			#mbox-cells = <2>;
>>>  		};
>>>  
>>> +		qfprom: efuse@784000 {
>>> +			compatible = "qcom,sa8775p-qfprom", "qcom,qfprom";
>>> +			reg = <0x0 0x00784000 0x0 0x2410>;
>>
>> len = 0x3000
>>
>> [...]
>>
>>> +		gmu: gmu@3d6a000 {
>>> +			compatible = "qcom,adreno-gmu-663.0", "qcom,adreno-gmu";
>>> +			reg = <0x0 0x03d6a000 0x0 0x34000>,
>>
>> This bleeds into GPU_CC, len should be 0x26000
> 
> gpucc is in the middle of GMU, see other platforms.

This is not the case here

Konrad

