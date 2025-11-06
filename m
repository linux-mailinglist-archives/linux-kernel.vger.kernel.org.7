Return-Path: <linux-kernel+bounces-887598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B9EC38AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4F464EC5F1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC220E023;
	Thu,  6 Nov 2025 01:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dzy7c9qd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZCp9FJE6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426F41F7586
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391709; cv=none; b=Hekmx+krqxjMZxe9e8giijyiu2a4eG28DQc1HmSaEi3xTmQJlyd9Jlwby2brNqPm4y7qpNfSHvN1mWTJiYzb+00/eEdAKYDaogvIYBvlEYWzDyDEpbW34kRChbaf+dQYPP4QhxLoRIPORWmrnmEB7L0YKfT+46briul6N3O7kto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391709; c=relaxed/simple;
	bh=YHQ2Z8cvuptFnDiVEnJIENka4AntZF+cyo3DYJvNBDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyCuiO/prFrBjADJ8IxjjLWFDDmx1rft86tIrXO4GpO6hymy42GbyypMmGa/8xNJManpAy2zxw9w8McBYgWBT/tHmGzVFbU9eP1BCe4TEUFTFh0GWXEd3sdc9hl/8E5HgNXWd72yXeABXuIpEbC9GLkmfYhZzCBltFlnl4vFzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dzy7c9qd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZCp9FJE6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A60I6ie2326626
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 01:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Y78qYNjDrbqNCW1Q25hl9wSuOKQlC4UcToVsEV3+Gk=; b=dzy7c9qdMtRhmsDH
	BwSy5I8lgO7vOVuAvB1ACzB01Zkt6zYcR3kFIUr5mzSCRxNVhG75xC1H0ptv7lwG
	jy1PZZwn5q4rAAvdgl8xl5wa12kGqVqa7LYOjHPL3kFWg5MmcjJZ93POeVn/eHCb
	P85Hkr/vcnmHCf20bNM55XiabpQ2oi3p71Oyy2hfz921Fvl8pC0jcaaTYls2pBVd
	fgPrqxcYSaNdrRiwU0IB+WvKl4yJeJKP8rE/iB2jsEV+ODOTgG+J2+NPmpcsfRWk
	T6WOq+uyYEGydBTP8C07964aWAvD6zCnrzL8nKJzu/r9VAYYG291wIHFAuPtH8Ht
	6hcfdQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h0v042q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:15:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-295093f614cso6269585ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762391705; x=1762996505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Y78qYNjDrbqNCW1Q25hl9wSuOKQlC4UcToVsEV3+Gk=;
        b=ZCp9FJE6Umi+Or7s6436K/HietvDmVUbkTpZV91KtuLy59lO9tWjIa9Sxb3IBMg80A
         IscnteiSV0MoEJULkpyi1EUiAGYazUSLlM1Ky0nkTjpbR1lMbsYGUSWfbv6PLQX0pqz+
         ui0w5RTSzgk2L50l0sR4gF3Oqypw/F/bEGyB7EPRBnZwVKtf11ej66SfXJWaCD+3zh4p
         SioNWhWErLH/+9J2fC/L4lg5oLXyVEeHf2qsffX+h5px7B74Pgn6C4vKHyIrwkDHidoU
         k6MHTW0ZbTQSUQEe6s7hnYLgmXBb2EqH7t9qogwZjS5X5A4xAvxHu+MWjPLjsx7h9f8y
         84PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762391705; x=1762996505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Y78qYNjDrbqNCW1Q25hl9wSuOKQlC4UcToVsEV3+Gk=;
        b=KT/vkP5jsYyRi/BTHS1nt88TNyjuflu0NO1NIVtQXnej0WM6nVpTT5VNUlE8GVFaCJ
         0Q5uQ3UcafhEo0vZH18IEcKw+X9H0iRAqMk/o9I1Z31MSv+KTQCn2vHadqSGQbCiaQpj
         wzN2j0VhsKwAV2eI+ae/vvCOGIFFE9mIwFfPMGnTCEp6MF9HCJ9CwVxSliRTeNYr9Yo1
         WBbS96JbZUvyjAqGrbwIhugq9+HMtdpJajRwbqRhUm4L7BWrGrtxl2mpztWLGZVsq6Ha
         yY8twfDHg/1lBElBjyQAX+3Kputc/UhNsJalL6jj7y4O/7hz9sSNtk9dDDqMZZfPy/NQ
         5Pgg==
X-Forwarded-Encrypted: i=1; AJvYcCUL2lRQdGzvyOjAKLp9WL+kPdbEbLu+MOPO017NUuAq8MKC9tTmC3rHN8nKz9IlnYfpjDUS8A9SMWY5yE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzI1beynYRQkLC9HVlO0zjaWHN/+WUvHoEmyozGxr6eXVMq1Kp
	4YeHj8HsHUVh5dmGGI8X/7VuAMjD2T0QCPTGwPxllsRni8jY8Tp97Mo7oMgFxm5/Fp+YcMATz9v
	eWdCp9eUUGrQqZXF6Jc7sg+e1vn6RNQUWcdNaIy1fZm0oYpZu4KA2Ph0y7jGP9pTRzoU=
X-Gm-Gg: ASbGncvv3jOphTnvHoYQaHUGgXoBpb6WCDlCE1OZsySzeJ78riFAsCv5luggPhm9dXF
	1dbLIRL8E/mFFfGTcQ6Lgwv79mpb7Ahpi2EpUB3UkH4u4Hz3C2QOrJ9UFb5yuejH7SCb28bH6hf
	bwaLqgl4ZyUQ/sUzE4fC+RejhQyoQwKo2N+jKU6rfZL9h/cdqypWlwsPdsBho3tuAlnX6SlrYDF
	1KfKLh7pdNe6XPNIO+erl8P6UFbCtWoBmdJ+plTamuaQBT3DfywdY+tRwHbaG7YE6BWvttNzV4F
	KCvPD2X7q8MhHjgR+eUjJDGVar9aLqX/XvNe7bFNZBj8kScr3zjl7vrDCkX2+CYYN5fUSHnnq68
	qFjLCJK7zxOkdhvXp/fz0xOkxz4+V+dvUTxd9x65YyDGsk104IVpnkEnVvSfcZ079
X-Received: by 2002:a17:902:d4cc:b0:295:6117:c597 with SMTP id d9443c01a7336-2965084026amr18676235ad.5.1762391704327;
        Wed, 05 Nov 2025 17:15:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMt8SljTKnN1uEPM9OZaqaoc8Hpel0dHroueOM1vIorT5unBLPbz6+6oK37/HktIzT5D59nQ==
X-Received: by 2002:a17:902:d4cc:b0:295:6117:c597 with SMTP id d9443c01a7336-2965084026amr18675675ad.5.1762391703682;
        Wed, 05 Nov 2025 17:15:03 -0800 (PST)
Received: from [10.133.33.139] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d08afb02sm323024a91.0.2025.11.05.17.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 17:15:03 -0800 (PST)
Message-ID: <f9dd8e69-d95f-4052-9604-aabe4f44c6c5@oss.qualcomm.com>
Date: Thu, 6 Nov 2025 09:14:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: hamoa: enable ETR and CTCU devices
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251104-enable-etr-and-ctcu-for-hamoa-v1-0-af552cfb902c@oss.qualcomm.com>
 <20251104-enable-etr-and-ctcu-for-hamoa-v1-2-af552cfb902c@oss.qualcomm.com>
 <25b7abfe-1881-41e5-914b-ee16ce63ed3e@oss.qualcomm.com>
 <8a7dd1b4-505a-4507-8cc1-75d955c706eb@oss.qualcomm.com>
 <7affc5e7-14b9-4959-9943-40e416f64d92@oss.qualcomm.com>
 <a1694c50-47a5-4f5c-abb1-6fec7a490e7a@kernel.org>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <a1694c50-47a5-4f5c-abb1-6fec7a490e7a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: azTSbPp6WylPZZwwtDIgPSYZ23LrtNcI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAwOCBTYWx0ZWRfX+gcD3Aiqun2g
 N1D/GCpaC4CpZTV00fCDS+hWXBSn0ZwLM+OYT/X8rTKiWGyOo4yYOSd7ky/JeJl7HYeBeCxOQr6
 jGFkzSnGQDIf6WENwzYeOoVM6zw1LZ7J4RblXBa8oIOWn+g1z/WG5NmEYlJRKYK8itBm7GaGoo7
 76JeuF6lsfpsuuVleYWrGL6VQ1NcNYgkKGD8n+tOWYq4FQ9rEnuKaW9Zul7MNXKdWsXI+cIaV/y
 NV1M1aN8RDmNNxjrjRT6Xc06Wk5Fgn2sD22qKLWuI6hm71Pk63fWSd5u+GKmunddMgIriQh/q6S
 LwTNPP33xQ+bPJli8F4kAu0OT6yFOIO7tRA2Q1aeAfw/gbIjJt4ZC/HyHgejXdlLTQ2AhHUiAd1
 QgxyA0oVRKXpcVpsCK5LfESPPfIeuw==
X-Proofpoint-GUID: azTSbPp6WylPZZwwtDIgPSYZ23LrtNcI
X-Authority-Analysis: v=2.4 cv=PoyergM3 c=1 sm=1 tr=0 ts=690bf69a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=z7gAgxDoRBdO-O0LFwoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060008



On 11/5/2025 5:17 PM, Krzysztof Kozlowski wrote:
> On 05/11/2025 10:09, Konrad Dybcio wrote:
>> On 11/5/25 2:14 AM, Jie Gan wrote:
>>>
>>>
>>> On 11/4/2025 8:47 PM, Konrad Dybcio wrote:
>>>> On 11/4/25 9:10 AM, Jie Gan wrote:
>>>>> Embedded Trace Router(ETR) is working as a DDR memory sink to collect
>>>>> tracing data from source device.
>>>>>
>>>>> The CTCU serves as the control unit for the ETR device, managing its
>>>>> behavior to determine how trace data is collected.
>>>>>
>>>>> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/qcom/hamoa.dtsi | 160 +++++++++++++++++++++++++++++++++++-
>>>>>    1 file changed, 159 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
>>>>> index a17900eacb20..ca4a473614ee 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
>>>>> @@ -6713,6 +6713,35 @@ data-pins {
>>>>>                };
>>>>>            };
>>>>>    +        ctcu@10001000 {
>>>>> +            compatible = "qcom,hamoa-ctcu","qcom,sa8775p-ctcu";
>>>>
>>>> Missing space between after the comma
>>>>
>>>> no issues otherwise
>>>
>>> sorry for the mistake. Do I need send a new version to fix it?
>>
>> I think you do since Krzysztof made some comments
> 
> 
> Not a technical ones, but about the process.

will send a new version to address all comments.

Thanks,
Jie

> 
> Best regards,
> Krzysztof


