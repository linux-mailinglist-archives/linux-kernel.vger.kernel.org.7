Return-Path: <linux-kernel+bounces-769863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBAAB27493
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 03:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722261CC415E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBE418E02A;
	Fri, 15 Aug 2025 01:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QqBUmt/7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F0C1114
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220025; cv=none; b=tino++I8Gtvc/wsCDvo5V+ekFGp5Vj7Y5rXAUsSmoi4N6lypo2WrFSgC4xofYLG0+sRxnJNS2ydWHRmPV8iGr2B8hTx3IMhMeuhfWxc8O6oNiB7+L1NtP1mao+IJJjilXouYnX7OHwVPprWnGWd5YcaUHaO9VS8KHyMxNNWgB2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220025; c=relaxed/simple;
	bh=E3W5yNIhlkaRbvT37seZFqLZe5Ju1m39nqAxDnNKIQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D51ahUHZjIG8JSrDbNEelwNP9xiJZgDXdRKI+V27kqDHdNoEW0obUXJE7mWhVr5aFl53Hs7m72CCC62wbQJkG5PVGoogdC7+nwlPwoWucQiVhS6/68JQ0O1ZEmjEH5A7T4ZsL3cEilXZjlPAHl9s3kwxZqxZZlB1DQLNVtIUqWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QqBUmt/7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EHVYYA030070
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fDTemP53sqqVbxhSCn8l+KTq6D2kUe+G1EUg/hQ0gAk=; b=QqBUmt/7cLOd7nTz
	dSUB6NSleCR7EmG+rTat2h5+TlXarmHeUHP4g3rTNrj0la0EdNw4BmACb08nIf+c
	oU6qYPJUNc/kVKKBjkvufi4gp/UsiVuY6s0MW0M8QdhuOm1DSgy5RAixu0a3EVoz
	1odggMjy3enO8HR5Zikzugq+XHHdz/rRwxFfpIYpoTH+2OdZ95yhimHVTPqnOBGb
	eZIoS32DRLccLlawNU8Xz9kbWMIRFlan4la5zHBSqJz/+64hZP0Ln+CpYZudc8Eo
	gYiUcFNzBFhRdMoZjyc8+3JZHQ77Gx5EKDgRoDul/hEUUPA/J2SSmk+A3PG40N8L
	UPyv5A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fm3vvewu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 01:07:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244581ce13aso27031675ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 18:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220021; x=1755824821;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDTemP53sqqVbxhSCn8l+KTq6D2kUe+G1EUg/hQ0gAk=;
        b=p+cSsBAiu5lAiKXR2ekT7Sb2FigMN2jJvfIpdwwCh6DDBhI4jAnl1uofDYkSgMgLDH
         xdIYJ6hrhFAv/mdXlp6tRkT/jvQ9IWmw5Wq0PFK50pa3oVdQioOvtVqio3Eja0GcT5r3
         P+GGpoH/aQTcdEzJqiFfzyWTkPs+J6bHrnu6y4h4G2r0N8rnxWnzNxp/C0jl+bhM5G+D
         bBNuGDQi7l5m3i0hXVYj5mGTVIb2DnLFJ2DHrriaV8gUWq9GCrUPWafrxeca9Q1Lrn/7
         4YfxrnhyYhKFG5Ords4j4XEK0y65tvTTIcG1HjLDOMNdjxFx5uJvvEsOQeFYbHuY4wpR
         xRWg==
X-Forwarded-Encrypted: i=1; AJvYcCU6mrcXM/KHc+T52owwE/GDfJzEoXFlzeqhsb9YwdmJ9EO6xUU0OOhKaMcMtS0pyzvaElxLzyqa+eTGQwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjrR9GbBKL65aTLnj/Z4RZojynD4zH3Al1HXdKx+Vhh0G+E9Lh
	fXBbUFuKKWWWE6bkmDKWxurFIM1fUAWc3WYeZNBXU8xekLCU1m2Lqt00mPU1XAwUtk2QV/4Owpj
	JDho5SCa1MUdDLTd0BDU2zU/51obf38oyF+hpTmB0F8q2Wio9VXGL306kvPYwYuFkF7Q=
X-Gm-Gg: ASbGnct68csjZMv+pre7OATtaXYcDm/DC0gnzzW5vFvhA94+sbo9ttPW7bXRPxBdeJ5
	66iHl37/VZco28oF328guFqpdISbsTGeeK0y3AQ3WfidktMcKKYjZoRDWV5r+qGq1BXgTb6eE7u
	XsZhVR5nIsL5Gof7XXyMprqLCSWENuDY9DeRd5p8HPFZuguqExacOU5wjroY4FBt1CZB6nRxh4s
	wk8j+RWUSx0BehYanzScn4NPUu9dJeJY+HtA6gerxf3ikJAMzzCg3f362Atnmsie9xaBKKGNh+1
	fm59dVPDE4KmwWxEOWaiI1pq9lhDHGzTnkoq8Eyn5iUc45cPJj0YYwRpvg+/GhYerN+apz/r65c
	N5TdZokoJn9FP/O/efsyxzSUVrdI=
X-Received: by 2002:a17:902:ced0:b0:240:a889:554d with SMTP id d9443c01a7336-2446d99d42emr3600095ad.45.1755220020967;
        Thu, 14 Aug 2025 18:07:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoRXWzdGiF1XsdVWPHqQWYLwIu/sVwT0LWw97cxh/M0gcCmu5vNZ2VC719kSjTBipHI5cloQ==
X-Received: by 2002:a17:902:ced0:b0:240:a889:554d with SMTP id d9443c01a7336-2446d99d42emr3599685ad.45.1755220020441;
        Thu, 14 Aug 2025 18:07:00 -0700 (PDT)
Received: from [10.133.33.40] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4384baf139sm12438271a12.36.2025.08.14.18.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 18:07:00 -0700 (PDT)
Message-ID: <81ed09ed-67e8-438d-b057-28a21d8cf70c@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 09:06:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Initial support for Qualcomm Hamoa IOT EVK board
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Yingying Tang <quic_yintang@quicinc.com>,
        Shuai Zhang <quic_shuaz@quicinc.com>,
        Yongxing Mou <quic_yongmou@quicinc.com>
References: <20250814-hamoa_initial-v5-0-817a9c6e8d47@oss.qualcomm.com>
 <5reeryefhw7burzf2lymhg5wivaq2n4gq5hszvfp57dergvpyx@qehaf334gdrn>
 <7e5d39e0-115e-40be-b44f-0195a4827a0c@oss.qualcomm.com>
 <63ecde5c-8234-4630-97e8-5806b9ff3eea@kernel.org>
 <a56b3e85-0d42-4945-8b6b-dcff20c7b104@oss.qualcomm.com>
 <nruypjmek7f76m5nbv6vs63koscrwcqknswfm67rkcjtqxpwhe@3ijzkbbaxj2p>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <nruypjmek7f76m5nbv6vs63koscrwcqknswfm67rkcjtqxpwhe@3ijzkbbaxj2p>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwNyBTYWx0ZWRfX/P1nHXY/EcAq
 +i6hGsWt+jyN1ogBVk2U9mA0pv1RK3VaV039RJk3ghkb8PrYv6/PqTZxWLixkf4o9aPifm9nFRG
 1FcWrY+hXl+2ARDd1qeaxn/U03spJwLJeopANP7V2hy2ZAOMd2xnVRcw5pJOmx24usWi0WhotYD
 Mze//hCvP0yFbcu0AeAQOVb/P9KhYOIV1cDLMzhc+T/sQbRzkmeeHJfEluozptL4hN16rgfcLDy
 g/zvAvetM2+wti0GbRmiXMhQrrf3rq9+OQNaumdqI84aS8oySe2xYLI5U47H/F5DtHP2+nlLmS4
 I7GKQ44ZOfl51/KFL7ljOR15BMmTka0RjxbcfKhc7UW32GeHb6MailPgOZGhP2RZy80ONWils1t
 ikV6HLcV
X-Proofpoint-GUID: _76W8u48Ie6aAIgAVqhgdKTfhb18SKhN
X-Authority-Analysis: v=2.4 cv=A+1sP7WG c=1 sm=1 tr=0 ts=689e8836 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=FDvvkfF-Sd8HMvbO3OkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: _76W8u48Ie6aAIgAVqhgdKTfhb18SKhN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110107



On 2025-08-14 19:27, Dmitry Baryshkov wrote:
> On Thu, Aug 14, 2025 at 05:28:01PM +0800, Yijie Yang wrote:
>>
>>
>> On 2025-08-14 17:05, Krzysztof Kozlowski wrote:
>>> On 14/08/2025 10:54, Yijie Yang wrote:
>>>>
>>>>
>>>> On 2025-08-14 16:24, Dmitry Baryshkov wrote:
>>>>> On Thu, Aug 14, 2025 at 03:27:27PM +0800, Yijie Yang wrote:
>>>>>> Introduce the device tree, DT bindings, and driver modifications required
>>>>>> to bring up the HAMOA-IOT-EVK evaluation board—based on the X1E80100 SoC—to
>>>>>> a UART shell.
>>>>>> This patch set focuses on two key hardware components: the HAMOA-IOT-SOM
>>>>>> and the HAMOA-IOT-EVK carrier board.
>>>>>> The HAMOA-IOT-SOM is a compact System on Module that integrates the SoC,
>>>>>> GPIOs, and PMICs. It is designed to be modular and can be paired with
>>>>>> various carrier boards to support different use cases.
>>>>>> The HAMOA-IOT-EVK is one such carrier board, designed for IoT scenarios.
>>>>>> It provides essential peripherals such as UART, on-board PMICs, and
>>>>>> USB-related components.
>>>>>> Together, these components form a flexible and scalable platform, and this
>>>>>> patch set enables their initial bring-up through proper device tree
>>>>>> configuration and driver support.
>>>>>>
>>>>>> Qualcomm SoCs often have multiple product variants, each identified by a
>>>>>> different SoC ID. For instance, the x1e80100 SoC has closely related
>>>>>> variants such as x1e78100 and x1e001de. This diversity in SoC identifiers
>>>>>> can lead to confusion and unnecessary maintenance complexity in the device
>>>>>> tree and related subsystems.
>>>>>> To address this, code names offer a more consistent and project-agnostic
>>>>>> way to represent SoC families. They tend to remain stable across
>>>>>> development efforts.
>>>>>> This patch series introduces "hamoa" as the codename for the x1e80100 SoC.
>>>>>> Going forward, all x1e80100-related variants—including x1e81000 and others
>>>>>> in the same family—will be represented under the "hamoa" designation in the
>>>>>> device tree.
>>>>>> This improves readability, streamlines future maintenance, and aligns with
>>>>>> common naming practices across Qualcomm-based platforms.
>>>>>>
>>>>>> Features added and enabled:
>>>>>> - UART
>>>>>> - On-board regulators
>>>>>> - Regulators on the SOM
>>>>>> - PMIC GLINK
>>>>>> - USB0 through USB6 and their PHYs
>>>>>> - Embedded USB (eUSB) repeaters
>>>>>> - USB Type-C mux
>>>>>> - PCIe6a and its PHY
>>>>>> - PCIe4 and its PHY
>>>>>> - Reserved memory regions
>>>>>> - Pinctrl
>>>>>> - NVMe
>>>>>> - ADSP, CDSP
>>>>>> - WLAN, Bluetooth (M.2 interface)
>>>>>> - USB DisplayPort
>>>>>>
>>>>>> DTS Dependency:
>>>>>> https://lore.kernel.org/all/20250724-move-edp-endpoints-v1-3-6ca569812838@oss.qualcomm.com/
>>>>>>
>>>>>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>>>>>> ---
>>>>>> To: Bjorn Andersson <andersson@kernel.org>
>>>>>> To: Konrad Dybcio <konradybcio@kernel.org>
>>>>>> To: Rob Herring <robh@kernel.org>
>>>>>> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
>>>>>> To: Conor Dooley <conor+dt@kernel.org>
>>>>>> Cc: linux-arm-msm@vger.kernel.org
>>>>>> Cc: devicetree@vger.kernel.org
>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>>
>>>>>> ---
>>>>>> Changes in v5:
>>>>>> - Update base commit.
>>>>>> - Drop an already merged patch:
>>>>>> https://lore.kernel.org/all/20250804-hamoa_initial-v4-2-19edbb28677b@oss.qualcomm.com/
>>>>>> - Link to v4: https://lore.kernel.org/r/20250804-hamoa_initial-v4-0-19edbb28677b@oss.qualcomm.com
>>>>>
>>>>> Please keep full changelog rather than trimming previous iterations.
>>>>
>>>> Sure, I will restore them.
>>>>
>>>>>
>>>>> Also, is there a reason why you didn't pick up audio and display chunks
>>>>> as it was requested on the corresponding reviews?
>>>>
>>>> Display-related changes have been merged into '[PATCH v5 3/3] arm64:
>>>> dts: qcom: Add base HAMOA-IOT-EVK board' and are already present there.
>>>>
>>>> Audio support is still under debugging due to unresolved issues, and
>>>> it's unclear when it will be ready. Would it be acceptable to proceed
>>>> without it for now?
>>> Audio was sent to the lists, so this is confusing. What was the point of
>>> that posting? It clearly said:
>>>
>>> "Basic test is good in Hamoa-IOT-EVK board."
>>
>> Additional issues with audio were discovered during further testing, and
>> the current audio series on the list is not suitable to be merged into
>> this series at this time.
> 
> What if the maintainer had picked up that series, with the issues?
> If you uncover an issue, please respond to the patchset, descring that
> it should not be merged (together with the reason and the description of
> a problem).

OK, I will inform the author of the audio to do so.

> 
>>
>>>
>>> So was that true or not?
>>>
>>> Best regards,
>>> Krzysztof
>>
>> -- 
>> Best Regards,
>> Yijie
>>
> 

-- 
Best Regards,
Yijie


