Return-Path: <linux-kernel+bounces-789253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D363B392CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008796864D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 05:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063E6266584;
	Thu, 28 Aug 2025 05:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J376A0hj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E78260585
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756357947; cv=none; b=t9DKbs8smg9W9pSe9/lUGoU/F7UWKlNVN1GCJEHXleryBKZ4kAwNDaihiGT8YJ/+V1IHa3fTjywIw2NuVnIeo7O4YP2q6Ct3ooUqbvMn8UTAKcEeIu3M4XXXHk+QUc8Dwq0cHtP0oiGfBCccuIsvS7ecKfUSdIh4XmmrlI2e9co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756357947; c=relaxed/simple;
	bh=clAMrz6KLy6NUqRmVn9yJ6X0kICZUVETZorxJPhYsiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V/DWXKE6wY824yPk5MzjpcL5roli1E6cGe/MDDnHPBmi1eNpv4iCzP7Xm+TJVU0qNBA8Rfe7oWV5FngP6napetrBgzWfWhYwgrm+TZPq3hSsOopBIjWXNmZMepLjhOY0k0CMLh0YTsH41Z4LHPXd+G8JGKnLbFH0gyC7nscRRAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J376A0hj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RNQPPm004962
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	usCl6mH6TNDrCxedB4k41lYzPFlB63q5zEaGSKGtmmE=; b=J376A0hjMF+USnNY
	+Cyg1BTQ5zLKQ/NTOVCzyaC79PdE0+gHhv4fOKrlCf289/kFLzatyOAtJ/3BQa2L
	j6SQrl9/39KpMtUJkgafiE0hzciUA6KOBlbaFUC2ZLzNY+J4fPIt/WWKxmkh9+Xy
	1IQBFr22A4P3JUtQ20gg8rRbKO3VVZ2HZjCslQCp/tzzPHTp4XWRSl8gIEdFfyTQ
	U0+TuRMUQqkABI5+jaqGq7QC6N85g6iIdOApGOPAvRp/t89IVtG/kJH3H/G3v2Fq
	5883I1mUUSfV5F1bLUaJz7zmTlUROiBzws7gSuj8FUatn47aO49mLQByCrSR+szj
	tM17TA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tbpggqkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:12:23 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b49da7c3ff6so342499a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756357943; x=1756962743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usCl6mH6TNDrCxedB4k41lYzPFlB63q5zEaGSKGtmmE=;
        b=DOb6t2qtRCJCTk2RnHAuTOoqCdbrvPqKv3nogG82c4qvsFPyKm7/EzYLHEAT1m0eMu
         M1v0OSRDS/xfZw5wNDBGbF0gdCk6wAhjhFNgzZ2EyNlgUtnSzYfsWOLdNn7GBi50NwdK
         DZ1+LG7vFjcdnmVVG6d4nXqDnDbTrmKE0KmHau1FTOT4yvcIHdQjN9DygVU1sqxTm/Ox
         w+zFVcXSnyWEMxIE1Ub2fg2XXvBAUkTD/HvETEL6rlW+L9n79pDRGaEJ2q9vMU9GhEuE
         sx/Ce7VESQ+PXrO5srvgdY+fW8Fafh14s6GWYzG3XvgcLvm1ngIloHvcsgN8kdYFXKt7
         loRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYO4WNupUFmb0Xtx3tvjO3HK/zPko9WdB/JPeWj1A6VKS4DDyiJtOsaVjGtNDJ9Bznsonyte3IgPQZ3AU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytx1BGtWCVBjN5TRBm7xQjU6P7WFlfgou5hcfxa35obuyeofqF
	mSeLc8g5h1LlmGVMT1Ha14KSVHhm6OdkvSAT/KsIim7rOubhC7hADEJAEtb/+iD8biIVTiCDjeC
	H4+9ujEEJ5hQCdKO6nd0i5+4mlSN6Qout11aAZr5xL72AP8aszy3GCfoNhyjeREjyjYA=
X-Gm-Gg: ASbGncuunkJ8wUPipAs9Ix757S/JpEUTAKnuvOrvS/hGScHFQqOsUh1QcPWudMyCoUM
	VocUN1CSutXI6KloaNBf65q1dy4h0ZnfLGri3LhtZ0yRP109r1vfU8pxXnrAmO6ZKk0NuywXpkT
	/vLillyQTUW2EqEa5G4aecMj4MSBIuSnWapO6JFLp4BQ6i4y2tcatCtejyRsLn02b5uBs4wS1OX
	tbJ/zTM8/BMH6r4dHexO/OA0FBc3MjBAQjKIbigbDF8tIcFZw+StkdQ6sMoIwnnmbrwTAA1bgWb
	KHMvXi6F0xz+reH1jv2AqRs4SZoeavWrSlqT8GtNMMsAev4QOZH9CRjC9A+ivjvRsRek1BDce9B
	nHFHR8amNvZa7e4MEUQKlu6UgK+jf76QrP4Q=
X-Received: by 2002:a05:6a20:939e:b0:21a:e751:e048 with SMTP id adf61e73a8af0-24340d7bb9emr31194780637.35.1756357942466;
        Wed, 27 Aug 2025 22:12:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh2Imy//naH19O30FjkWLd+lhOsGWdcbs2fB+COXPig7IKKsbqvmFGL0Zqk34EsrYRm2Ayxg==
X-Received: by 2002:a05:6a20:939e:b0:21a:e751:e048 with SMTP id adf61e73a8af0-24340d7bb9emr31194743637.35.1756357942007;
        Wed, 27 Aug 2025 22:12:22 -0700 (PDT)
Received: from [10.249.30.180] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb7b5ca9sm13008126a12.0.2025.08.27.22.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 22:12:21 -0700 (PDT)
Message-ID: <4913e937-3892-42ac-8145-cc9c2364242c@oss.qualcomm.com>
Date: Thu, 28 Aug 2025 13:12:14 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: Add display support for QCS615
 RIDE board
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiangxu.yin@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        Li Liu <li.liu@oss.qualcomm.com>
References: <20250827-add-display-support-for-qcs615-platform-v7-0-917c3de8f9ca@oss.qualcomm.com>
 <20250827-add-display-support-for-qcs615-platform-v7-2-917c3de8f9ca@oss.qualcomm.com>
 <yutyrfb73wbxlweoq3mc6ezyqr56snzmznw3k6mcbc56fpfayg@3h5jwymlo3ol>
 <0c2a4877-d63b-4650-b7d4-a06a2730c73c@oss.qualcomm.com>
 <zoogyjua4l6e2bgsvxx7w26n6v2hwnp2pvkizzzsds3c6cgaag@2bvqdl2z5ds6>
Content-Language: en-US
From: Fange Zhang <fange.zhang@oss.qualcomm.com>
In-Reply-To: <zoogyjua4l6e2bgsvxx7w26n6v2hwnp2pvkizzzsds3c6cgaag@2bvqdl2z5ds6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rjUjCfKY5lD2EMejn-vj3YBxsar-1RTy
X-Proofpoint-ORIG-GUID: rjUjCfKY5lD2EMejn-vj3YBxsar-1RTy
X-Authority-Analysis: v=2.4 cv=G7gcE8k5 c=1 sm=1 tr=0 ts=68afe537 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=V-We5vXZukcDR5633V4A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDE5OSBTYWx0ZWRfX9BZdI+v9lqLe
 pKgvccy7fzH4FkwBaWiz9O+S60dPvELkIM5KOdJuFYbFQgqOrr8xWSyDrhHYseCU2DqP7as2iRU
 hD5IDgXMVsAmhvTn66v841RkQXSaXSep9oj3aEOzbPG1sNGMlde5fwAFMXJlUXrY4pyvJSYwpgc
 r6NgmvOuaHSXz0oCAeij8J/MTUxvrmvx41PhjLc4GgEwZMuD8i7/f5n8/fb/pZtaftQ7CPj6fen
 ZBpdkTsLvqc6QmKgyNURHf5HSr6Jwsr6mmaKMMWRCYIQVFAbs8LYVQzePlFyMA63hMlEu9/hFZs
 PPYEh7S6HDmSjIu4/B9T8snbwHLpP9RF+aUgVC9PSN3+uXpUG58bPU7PWGRwPnV03u1KSd9Hejt
 bXgea28R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_01,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508270199



On 8/28/2025 12:41 PM, Dmitry Baryshkov wrote:
> On Thu, Aug 28, 2025 at 10:57:41AM +0800, Fange Zhang wrote:
>>
>>
>> On 8/28/2025 4:01 AM, Dmitry Baryshkov wrote:
>>> On Wed, Aug 27, 2025 at 09:08:39PM +0800, Fange Zhang wrote:
>>>> From: Li Liu <li.liu@oss.qualcomm.com>
>>>>
>>>> Add display MDSS and DSI configuration for QCS615 RIDE board.
>>>> QCS615 has a DP port, and DP support will be added in a later patch.
>>>>
>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>> Signed-off-by: Li Liu <li.liu@oss.qualcomm.com>
>>>> Signed-off-by: Fange Zhang <fange.zhang@oss.qualcomm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/qcs615-ride.dts | 150 +++++++++++++++++++++++++++++++
>>>>    1 file changed, 150 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>>>> index e663343df75d59481786192cde647017a83c4191..f6e0c82cf85459d8989332497ded8b6ea3670c76 100644
>>>> --- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
>>>> @@ -39,6 +39,76 @@ xo_board_clk: xo-board-clk {
>>>>    		};
>>>>    	};
>>>> +	dp-dsi0-connector {
>>>> +		compatible = "dp-connector";
>>>> +		label = "DSI0";
>>>> +		type = "mini";
>>>> +
>>>> +		port {
>>>> +			dp_dsi0_connector_in: endpoint {
>>>> +				remote-endpoint = <&dsi2dp_bridge_out>;
>>>> +			};
>>>> +		};
>>>> +	};
>>>> +
>>>> +	vreg_12p0: vreg-12p0-regulator {
>>>
>>> I should be more carefull when doing reviews. I thought that it was
>>> pointed out already and didn't some of the obvious things...
>>>
>>> First of all, the nodes are sorted. By the name, not by the label.
>>> Second, there are already regulators in this file. Why are the new nodes
>>> not following the existing pattern and why are they not placed at a
>>> proper place?
>>
>> Initially, we referred to https://patchwork.kernel.org/project/linux-arm-msm/patch/20250604071851.1438612-3-quic_amakhija@quicinc.com/
>> as a reference, but its node ordering seems a bit unconventional.
>>
>> Would this revised ordering be acceptable?
>>
>> ...
>> + dp-dsi0-connector
>>
>> vreg_conn_1p8: regulator-conn-1p8
>> vreg_conn_pa: regulator-conn-pa
>> regulator-usb2-vbus
> 
> So... Existing regulator nodes have the name of 'regulator-foo-bar'.
> 
>>
>> + vreg_12p0: vreg-12p0-regulator
>> + vreg_1p0: vreg-1p0-regulator
>> + vreg_1p8: vreg-1p8-regulator
>> + vreg_3p0: vreg-3p0-regulator
>> + vreg_5p0: vreg-5p0-regulator
> 
> While yours use 'vreg-baz-regulator'. Why? Don't blindly c&p data from
> other platforms.

Got it, The revised format will be:

+ vreg_12p0: regulator-vreg-12p0
+ vreg_1p0: regulator-vreg-1p0
+ vreg_1p8: regulator-vreg-1p8
+ vreg_3p0: regulator-vreg-3p0
+ vreg_5p0: regulator-vreg-5p0

Let me know if you have any further suggestions.

Thanks,
Fange

> 
>> wcn6855-pmu
>> ...
>>
>>>
>>>
>>> [.... skipped all defined regulators ...]
>>>
>>>> +	};
>>>> +
>>>>    	vreg_conn_1p8: regulator-conn-1p8 {
>>>
>>> Tadam! It's even a part of the patch.
>>>
>>>>    		compatible = "regulator-fixed";
>>>>    		regulator-name = "vreg_conn_1p8";
>>>
>>
> 


