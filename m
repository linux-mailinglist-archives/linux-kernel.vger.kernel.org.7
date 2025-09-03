Return-Path: <linux-kernel+bounces-798928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 348D5B424C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5751BC346B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4564833CE8E;
	Wed,  3 Sep 2025 15:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F2ny0UHt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0479340D85
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912477; cv=none; b=J/0jr2bng4fRWWYzY9uMV9teV3xSt9uM4u875DUStcuIxaZs0NTWGSlOGNZc95lR8pwPhi1noh2AuNsrn3ctYkg1Syr5RNTOImrK2WCzED65g6FYoNo1ORfHO/6cBpsvHDZlgtXH0vDz3V4SA0snI5wwmIFNz0SKzJHkitfn7u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912477; c=relaxed/simple;
	bh=AmE3vN+qmvFJO55R8itzAjaA4PSPcgcddXsqYpwHxSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WmUHdn7Stw/NZCjXrnU1dWNaTwIr6mxZvib97/hemSe7Yq3OgqLz5JiZNmdAs6r/kvPeMgh3ZBQLnU9uVJNEjtXGp6nI5ZHkDQSQQC7qRVcgzxpsXKVLVN+U3F5/KiWZwo7N8zZL4cUuQoNaLnof/Xd7AgTR5mjoTW7CzY3Ugyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F2ny0UHt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DxM3p030304
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 15:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h4UktVIdm2c0x5SK3djoEMrvw4KVq2MmQq9SrdZVv5U=; b=F2ny0UHtZ4m8BKGP
	Xig1qKmRBm55LMfbgSdQU/9ufvvoqSL0dGVnZ+R69YKJsqnXPEr8wIFa17M/jUsT
	JYAcCik2Pqry6a8U7R3E+91GsDM1zuDt+6Z+iYeGVq60+1L8gAddxIrU5nMjMgf1
	KXiLc9MWmawjJFHpSqVdfJdYBEs9Bqzp6DL5Zwcmot388PPS6+6b2TZCG/yacbix
	K0Ke21bWkicUeZwFCzW5KusAfkdrrJUnXe/mjCPBDGB7DgMPGrVQD+LUcMiaU3/Y
	S4jdzdfMIr8MLQrCakVOYxvlSJmP9tafv0sOjPte4oPLP33bzWIzkrH7FQj9UsWx
	2fyPsQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpca7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 15:14:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b31f744865so14051cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912474; x=1757517274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4UktVIdm2c0x5SK3djoEMrvw4KVq2MmQq9SrdZVv5U=;
        b=Ansjst6m96DE+kMVpV94XEvmZabD+PKJhd6jwXSzYLioEE1qETwnCM4dRnFK37+8IV
         Y/hSSdO/dKllSu8WKIa8Hx7aY8k4WgjADbXUww04yJ21GmJLU9quA7EgEkdfHg2TJ9qb
         7MDsC9jQWCvWMGv48f6Tv5NSIDWB4lPkbsTrfU1hX1GH3A4o6WILifMmsHuHvAGCR+mU
         leppM93QtwV7dU4Ei5k9CFTjym3jWfKWrdspRpimL9H9jTuQGjW6cLxAuegtI7Ct61tc
         cV7kI9sHTW273BEtmYTAI/6OvUL02Zbui/eNtkSRlLNnxkuZfH9bROXzUHh/+n80sIaW
         Tg4w==
X-Forwarded-Encrypted: i=1; AJvYcCXU7sdq9/ktYH8kwUDJ/Cggf7G6oKtTnU3UvMEWMjhp2HY5WPPwyOcFf6GJsXlQsrYK+6wzwCgqMNlvQYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4glQai10d5qmthtS4XFn7HJa8VrRC5QVvXxhp6oY9vzWkdxkN
	pULFJWsn3F/btVKloOXC2RDcvFdLFl5z+ivv5y+SQfFZqEJ2/pRSHRhOOTdYUymqseHLzQ9XN6C
	DWKtbq6OePjL5Jvn7RWQpwUQl+7bfekhxmy/Y6dIFBk0DQ+/Ya+5ISsaJAFu9mtXJR90=
X-Gm-Gg: ASbGnctTqN0QIaRweKy4ipjwXJpsFVXMJVbfHDcvymuAjINsnUlgQAvkcCvsKmDqDCO
	hLBqqIaXbbVeqIE4ONxE7zA8aP2w9BiMBPiCkmCqLtaBSrFU8D4ybCrk8anD172yJ5252/IYEBd
	hxWq25HjXSr5FwTr38tHzgB1sQDC6D9uRpEnj6skp64MKkIzSx1EylWk8i+Om85yZ/AeuOLxyWK
	/444sTJGdiWp+86GjnvQLBV21VTf4LX8CvDH1pFVUnjymtaGXrcO1YSKyLHARQd9lAyuyXpcoCR
	bj/JrfHqYFW7xaE1/OJHNHNvQyWT2JpMV1sWgRIcUtJMWCL+8g0VTXOrf4hWnRLXfruDuGCGSLg
	TCJNB723cG17c+lJsJfIykQ==
X-Received: by 2002:a05:622a:1a04:b0:4b4:95d0:ffd3 with SMTP id d75a77b69052e-4b495d11860mr13068631cf.1.1756912473904;
        Wed, 03 Sep 2025 08:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3ugZbdxH7Mywin5NR6XHzSclz/+UkkqzuW+1UkBm9a3K2qRCxgaknMn8ihcTkzrrBdvAapg==
X-Received: by 2002:a05:622a:1a04:b0:4b4:95d0:ffd3 with SMTP id d75a77b69052e-4b495d11860mr13068051cf.1.1756912473181;
        Wed, 03 Sep 2025 08:14:33 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040a410817sm1034669266b.101.2025.09.03.08.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 08:14:32 -0700 (PDT)
Message-ID: <c3de911c-e80a-429d-8a5c-c693546d4abf@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 17:14:29 +0200
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
 <f169be5a-faa5-4824-861e-27bd2083b9cf@oss.qualcomm.com>
 <t5pxum74q3fwf6wgcbaeaginjvtjfn357pkfswvafsggtmvxfv@jl5qjfhpmmow>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <t5pxum74q3fwf6wgcbaeaginjvtjfn357pkfswvafsggtmvxfv@jl5qjfhpmmow>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XY1Vm_AF3NJF8WLERFrUzHSiHDtk5Wpv
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b85b5b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=dNECfGFYMPGvbPEIsa0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: XY1Vm_AF3NJF8WLERFrUzHSiHDtk5Wpv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfXyFswnaSipHU2
 BEJ99FDG7QK0DXiJ3U6QCVzDKK6zZWMxv29b8lt8peYK7OjVziUnIcLfuR+SwrGf14f8Gwd6nf9
 V6leNmHqsE8hDG0iQguhF4yfYa2G7S8kRY6ms9kdOmk0MTPjenVRi6VG+oKnYYFZsMxq8jpTEhZ
 uFwJ86c5uhSck5VoW2M054+cA4KuoTWK1Vb4ganxtA0MW7YQmpXUXuIrOnO/UYXzxpKLYARPc6N
 sFd8l/E6XU0BNjWKDOOmtpYCWvyul90LivdwuozB2sIoWAkFaqv+dGb9emCcwIOihjUNHU4UEiO
 X4ZYPWd4u7jRwQi+bLiTt7edxoQ40veu3EovyfytBdx+Waqkd4WTDPUadkja++BzMKh2z0KjjNi
 kkQB5Upy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On 9/3/25 4:00 PM, Dmitry Baryshkov wrote:
> On Wed, Sep 03, 2025 at 03:36:34PM +0200, Konrad Dybcio wrote:
>> On 9/3/25 2:39 PM, Dmitry Baryshkov wrote:
>>> On Wed, Sep 03, 2025 at 02:26:30PM +0200, Konrad Dybcio wrote:
>>>> On 8/21/25 8:55 PM, Akhil P Oommen wrote:
>>>>> From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
>>>>>
>>>>> Add gpu and gmu nodes for sa8775p chipset. As of now all
>>>>> SKUs have the same GPU fmax, so there is no requirement of
>>>>> speed bin support.
>>>>>
>>>>> Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
>>>>> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/lemans.dtsi | 116 +++++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 116 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>> index 8ceb59742a9fc6562b2c38731ddabe3a549f7f35..8eac8d4719db9230105ad93ac22287850b6b007c 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
>>>>> @@ -1097,6 +1097,18 @@ ipcc: mailbox@408000 {
>>>>>  			#mbox-cells = <2>;
>>>>>  		};
>>>>>  
>>>>> +		qfprom: efuse@784000 {
>>>>> +			compatible = "qcom,sa8775p-qfprom", "qcom,qfprom";
>>>>> +			reg = <0x0 0x00784000 0x0 0x2410>;
>>>>
>>>> len = 0x3000
>>>>
>>>> [...]
>>>>
>>>>> +		gmu: gmu@3d6a000 {
>>>>> +			compatible = "qcom,adreno-gmu-663.0", "qcom,adreno-gmu";
>>>>> +			reg = <0x0 0x03d6a000 0x0 0x34000>,
>>>>
>>>> This bleeds into GPU_CC, len should be 0x26000
>>>
>>> gpucc is in the middle of GMU, see other platforms.
>>
>> This is not the case here
> 
> Why? I think GPU CC is a part of the GMU by design: GMU accesses GPU CC
> registers directly from the firmware.

Correct, however this is only a similarly sounding argument - the DT
describes the hardware from the main Arm cluster POV. The GMU Cortex-M
core has its own address map etc.

Konrad

