Return-Path: <linux-kernel+bounces-806216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67025B493BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F12F16544F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13A30DD39;
	Mon,  8 Sep 2025 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kr2tOBst"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0397235BE8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345954; cv=none; b=N1cXcLTy8U7Wotoq9JxdE2PkYzXW+nt8DYlHBD07fVJxLeKGoxjmUJyAW1zz0j9ZDOcZaZ9LTLWW2xqEUHX2rE7Nmjx7d0dOm9/omQiZNlt9kmb6lyBGOZRV7+gy2gZ8KzhliSkZxH1Ea1LXYvyrHs7VVHZn4I4TBFmDoW4RHMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345954; c=relaxed/simple;
	bh=hmxNwUU2zcaMmfH9+5ewG2jsk0T1GNdeIH4b++rXjvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MP7EIYYyp0jRcvBJPnR+XykKwwLFKqQ6VxW/QBZcqHDeUTGJRtwJn5TEWf8zrAKMik1ZyF5pGVCGJBONwMtfXxY1vaRiXP0+HltbAk5O8LeJvDxuWvTHX7CCixmB8Kz8Z6Ejf0Eow4K8LKc7FWpclNDC22LTrzG+LWq1ZpD6GGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kr2tOBst; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5888wZfV012276
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 15:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9ix8Lxn9DP2aA0chOL91fW2+iXcks/DUCOCWwGLcOgI=; b=Kr2tOBstZ6FlTNhO
	h+ImuNoASmfh+AhJM9R4LNr1x87C5DPsXFQIwrrXGYlGj9O9/ECKXyEg0g84gRev
	7L8F/8LVRbJuOUv591x2ewQLznBtxspvcp7r2Edaq9Z3xNBLvwhxkc0nupfHMCFW
	NZiLN+Zj2nhn+cqfK1/1+OFhXHokjCmM3a522MndM8IqbRJ2RZcSXwiOlFQmkPva
	VnV05oxNXhw157PBFwTgUbys/c7ixabSE8pE0GzmFLDlAxGyRByhgBvNFY+otpbW
	uuZGfw/DqxL6PyYQ4sSDtCybmI4OxX3CFcfyxZCixulNEAGa3stSv1+HAsRWJRuj
	hFsnpw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j561q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:39:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b5f92a6936so10035131cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757345950; x=1757950750;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ix8Lxn9DP2aA0chOL91fW2+iXcks/DUCOCWwGLcOgI=;
        b=iqXpVmShhXeY/5RFLK1KibQQRzc5xwrGpLW0omSrkpOFVt75uI6DNod9A6GOrsf2M4
         ew8PPfWr0j2BzUlfcaOzUbIfFaKvRtNoTjH9DWji3W/ksCn4puOdDCBubwjnpH5YjZYT
         nfj56BBfXBN2cC02Omlx1OHeCQeS8KN3+rLH8wLAVYRwsEMBDydG8jLZG6fDX6nPDlqV
         ON+mKKTs7MYyHepxWAPvxTFSH5yjn+WE5m3jGeascNsKMKU6dyMQcgBC6git9Xs1LUDi
         GUlemyWsjfsSDyHjaWtvpTvL+6sfTGju2NfPASZYhS7J+5DZI8UzmpYE0YzpeCAVzTBP
         L0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVULeuYFijv3QyTgXu7PFjaUjfiQ0n2EBEoo8PGCMkVKenvKQIU7kGOgRD6KfiEFSqnhDuvhy3h74qcg7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzcx2gUvyva/zamnvO5KKzEWrmvutsO9AGtccpal8qRLUEKbR
	rONZhl3M+MJoNZFGwql2CYclJGqIEYq/2ogdWGVW5uDVgzXelNsgygCsSn15Qms7UMIW2FU3RQO
	1iempIBMbvX1jFw7tN04Sj3c3cRMA7vMtyEL0f51SaxJKiqoWMyMz9Rzv+JuRqE4blX4=
X-Gm-Gg: ASbGnctUTdIuxbmz1m/SruSWM989ujkp+cbRm5MbOPD+sR1/33oTubAyt2NubZYL+qy
	sJzvJvjYoUFCSEtNSKFaCm3DMcZ5suvXT+MynjQu6fl5166OwrC/jp5yojTKSIG5zmhlEk6NHp7
	ABcQQg3omjZG1VmBeA9uAsnfBSxtN4SpTo0jbruzMzK8cIomZ0dju2irkAf0dVKdiC5RI5dMJJA
	dvAxU5xFm7de8C3PXKCjA01QGBcELzUEc9/H6sbPQYpYfee0wECa/TRQqzLLQGrV6ySWbnRLVkL
	+DlhaOguNQVAY0J5B3Y+cU1lIOOsqAE0j1Hqa8uDapwn8DVdtaEYMtNcIieQYq5a1F85fSHzDQV
	sW71Y9YeckI2GwhyuNKZnJQ==
X-Received: by 2002:a05:622a:19a7:b0:4b4:9070:f27e with SMTP id d75a77b69052e-4b5f826059cmr55448781cf.0.1757345949541;
        Mon, 08 Sep 2025 08:39:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSjAuw3MqqByPMWEwcaVGXJrt8t0L5vdGx6BjurjDCr+ZzKHljYEOvuS1tfcYm8a1jnOKGwQ==
X-Received: by 2002:a05:622a:19a7:b0:4b4:9070:f27e with SMTP id d75a77b69052e-4b5f826059cmr55448481cf.0.1757345948792;
        Mon, 08 Sep 2025 08:39:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0423ed35e4sm1961096966b.25.2025.09.08.08.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 08:39:08 -0700 (PDT)
Message-ID: <5bbe77f0-185f-4905-8097-8769f0d5f518@oss.qualcomm.com>
Date: Mon, 8 Sep 2025 17:39:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] arm64: dts: qcom: sa8775p: Add gpu and gmu nodes
To: rob.clark@oss.qualcomm.com, Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
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
        Dmitry Baryshkov <lumag@kernel.org>,
        Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
References: <20250822-a663-gpu-support-v4-0-97d26bb2144e@oss.qualcomm.com>
 <20250822-a663-gpu-support-v4-3-97d26bb2144e@oss.qualcomm.com>
 <f11b778d-eba1-4712-81c7-b83f2cb38b46@oss.qualcomm.com>
 <exkrgx6rdotfrrsnklsd7zk4ydehsk5vaoevibpqisyq2dwbd4@sa4kgnuexlna>
 <f169be5a-faa5-4824-861e-27bd2083b9cf@oss.qualcomm.com>
 <t5pxum74q3fwf6wgcbaeaginjvtjfn357pkfswvafsggtmvxfv@jl5qjfhpmmow>
 <c3de911c-e80a-429d-8a5c-c693546d4abf@oss.qualcomm.com>
 <14b5db9f-8b31-4baa-a03d-12112425fbbe@oss.qualcomm.com>
 <CACSVV02h8AUX8WtEuu5w-g2XnfBkfozHQQ15zGK6+LVX_w=d1g@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CACSVV02h8AUX8WtEuu5w-g2XnfBkfozHQQ15zGK6+LVX_w=d1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX3dSr340dQeuy
 1Xnu3WaPwzsvzo/KHdBWHQBejYjK/OwkGsokHBbmt3ky/21macZITAZpK/7XbuW12jL3Oo8fWCu
 sM+JsYZ9HUZj2qDBxo3XHowxveU8hdvdSKlG0aMXUudGzvBXGeqI1q2aaomCEYENPk4Uprhi09+
 67hQfrxQe5KCKfVR9BO97/sfdpmNsT3u9lYoLavGiCcn7qmn7KD5AwUDmrUZ24ghzzrKvdjL+c4
 vRUAgA/2HDW21AZpKGR8j9kj44x8Lz6GiWOXSsHL7Zb6OkFZ732WTgOmKwA867O4HrLloZt+0pV
 lds/3YtDM8zdnNVLrTNefT7fsWn2UUaUA9AoQZQ2xTHCSKO2iG/HmvKBOB9M8xyW4oWg0OjQDBX
 nkvTuCRa
X-Proofpoint-ORIG-GUID: JeMu148q03rwadKMBAvS3DGZjzEe2XEG
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68bef89e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=KKAkSRfTAAAA:8 a=am1a1fgwjgo6KoPeU6gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: JeMu148q03rwadKMBAvS3DGZjzEe2XEG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

On 9/7/25 1:02 AM, Rob Clark wrote:
> On Sat, Sep 6, 2025 at 1:56 PM Akhil P Oommen <akhilpo@oss.qualcomm.com> wrote:
>>
>> On 9/3/2025 8:44 PM, Konrad Dybcio wrote:
>>> On 9/3/25 4:00 PM, Dmitry Baryshkov wrote:
>>>> On Wed, Sep 03, 2025 at 03:36:34PM +0200, Konrad Dybcio wrote:
>>>>> On 9/3/25 2:39 PM, Dmitry Baryshkov wrote:
>>>>>> On Wed, Sep 03, 2025 at 02:26:30PM +0200, Konrad Dybcio wrote:
>>>>>>> On 8/21/25 8:55 PM, Akhil P Oommen wrote:
>>>>>>>> From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
>>>>>>>>
>>>>>>>> Add gpu and gmu nodes for sa8775p chipset. As of now all
>>>>>>>> SKUs have the same GPU fmax, so there is no requirement of
>>>>>>>> speed bin support.
>>>>>>>>
>>>>>>>> Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
>>>>>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>>>> ---
>>>>>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 116 +++++++++++++++++++++++++++++++++++
>>>>>>>>  1 file changed, 116 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>>> index 8ceb59742a9fc6562b2c38731ddabe3a549f7f35..8eac8d4719db9230105ad93ac22287850b6b007c 100644
>>>>>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>>>>> @@ -1097,6 +1097,18 @@ ipcc: mailbox@408000 {
>>>>>>>>                          #mbox-cells = <2>;
>>>>>>>>                  };
>>>>>>>>
>>>>>>>> +                qfprom: efuse@784000 {
>>>>>>>> +                        compatible = "qcom,sa8775p-qfprom", "qcom,qfprom";
>>>>>>>> +                        reg = <0x0 0x00784000 0x0 0x2410>;
>>>>>>>
>>>>>>> len = 0x3000
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>> +                gmu: gmu@3d6a000 {
>>>>>>>> +                        compatible = "qcom,adreno-gmu-663.0", "qcom,adreno-gmu";
>>>>>>>> +                        reg = <0x0 0x03d6a000 0x0 0x34000>,
>>>>>>>
>>>>>>> This bleeds into GPU_CC, len should be 0x26000
>>>>>>
>>>>>> gpucc is in the middle of GMU, see other platforms.
>>>>>
>>>>> This is not the case here
>>>>
>>>> Why? I think GPU CC is a part of the GMU by design: GMU accesses GPU CC
>>>> registers directly from the firmware.
>>>
>>> Correct, however this is only a similarly sounding argument - the DT
>>> describes the hardware from the main Arm cluster POV. The GMU Cortex-M
>>> core has its own address map etc.
> 
> but the firmware is part of how the hardware appears to the main arm cluster
> 
>> We have been keeping GPUCC region in the GMU's reg range in all chipsets
>> for the purpose of coredump.
>>
>> Can we leave this as is until we have a mechanism to dump these into gpu
>> coredump (via gpucc driver??)? I recall you proposed something similar
>> sometime back.
> 
> IMO we should keep this in the GMU range.. if in the future we have
> some other mechanism to dump gpucc state, then for future platforms we
> can start using that (ie. new dt but old kernel should be a thing we
> at least pretend to try to keep working), but for current/past
> platforms we should stick with keeping this in the GMU's range

Eh, right, sorry, we discussed this with I think x1e, let's keep it
as-is until more infra is in place

Konrad

