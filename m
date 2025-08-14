Return-Path: <linux-kernel+bounces-768387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D2EB260A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F703AB4CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496FB2EAB86;
	Thu, 14 Aug 2025 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eWw0Gvyb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81441E9919
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162700; cv=none; b=b1C3hg3LgRCMcD2UdV+Y+ldobIIe8zfLJyljVZxzCUrpQEypn65QmfHAJglMJOatdcq+p0Daa12UXo+SenC8SuZW6zUpcPE9jTuvca/dLywmn6Qy+cgdw7X+ItLrOU3jQVTls+8HoD3jJZY9VoqSsR1jlnOhTlmhMuJsPEIX3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162700; c=relaxed/simple;
	bh=kk0YI5StxFttNwDA3oGkDubt9hnirRjZcrzk0IXAslM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dG6glZD93XwkAvfVCpaVFYiD2DK/BAPrirJq2jTLA3O9+pgyDDymPO+89PHqY9fgbJeGqZg/gydmpTZjXvO5QY6eOBChbH+ddexpn1hT/zfwobGMDpRu0SKsI785GQ4m22DRVElo60BfX0iU4yHO9yRU5PEVDhZXrXSFnu9Cp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eWw0Gvyb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57E8ngmq027429
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YlOPAbajSUn2z2Yifxmwpg2ez5fT2y1/JNo9XnxqhhY=; b=eWw0GvybcHWh/gIw
	aO79mFAkVMKjUUNRfDdPM1I5+w6JwkS0PwpLaQ+o4UZVRiry5ckSReNMKT2BUiwX
	LP+05XXRwQKjQxcc1ZBasaHSZMMXuuG9/LnLqCzwmdfe11gBWOhi+sO8JKbzEsz6
	fLW5AjeGRV/OA0F4JlQEO2LuSkcWGz4yMMcaGTiF09GgXkMtoekdkVHQswU8Fd4w
	AcLd4niQc/A6qWb9w6DekbIp6vDwhbmESQRhQiHCsZU7oUMk6nbnu7wId7H92JtY
	I/PXSLgtIIiVz88sy6WCiIyPiSZF5/fN+UODGBNE/RKFUXtNMYICEj62fUbWVyye
	A4LEvg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffhjtxe9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:11:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471a0e5a33so725427a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162696; x=1755767496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YlOPAbajSUn2z2Yifxmwpg2ez5fT2y1/JNo9XnxqhhY=;
        b=pDDZcbYDsosyrV3iU6T34I8DnX8BKtwcrWHYh6qMtMbLHoVMFqNCCfq4hzfUCMSRqA
         0rRUMm+tJ/p+5wANR61cT3DRksfl9he3M4EMbG11NWVw93TNB+9KXeREbb124yGEPH2j
         qcK+vuI3wYU7KsmVmbzuUoD9jUcIGyJrYqAEFCzPgGbrzaEqC6W5wa6Wqowukbxu5dS2
         K0MFWxZj1kkZnafGqJjfOQ7gbby11dzZnjDmYm+c0bTchUHO/RnnxHigQ8IIrY9S9qLR
         iEOysaMNU2vHhh5RxopQqe7fIcgta1sIUm0h65K+wyoK81FJyMw/PCJXpcf5CtQl+C03
         YiiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4gZVcJVHWIrYhufzoT/Bl23vJ6AXBytdOetmvZl9FgPrg8Eb2X4hWJODnF6KQ0s7dw4rPofdH3hkDcuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIrW1x60k9tyWJO2tr31Qjdp0OQ+u9xXlEoFMEny/rVcGtB/QM
	6Pag6IC1gHNXFFzQSJYnq1kREsJyFdgp1uNcWVcjdXfVBFMjopt9Ho1iFqHruBoq6D4jAyFfLMW
	7Sywraww7sl4OKO2IVBI8OaiY+yFU8DKBmZfbwicpv5i23DCfUWHNxjRSh6l1/Ta7Mvw=
X-Gm-Gg: ASbGncsUOrBkXDx8nn/sBLweLsMNWhjkWXsvcgXnEt8HJbCafu+I05Rqas1E/hsCXuz
	3rlRWjQ5ziEeJrBosKDXWtsP0OoDjSOEicnxvDaguJk8FhkKMYgIx3Kwtlv7dyaw1+noVwFlnuL
	SX9JHaiALYERwez8YRZjF45+E2tNx7H7G7f4RJrhhiWaMo1LFWIPNE8uQH5/3xVxpjqgPcFpbjH
	AqiN9qpIh691f3XGvU+lI1Pyxdye0Uo2AATRroNFaNegembj+3IRWtq/WRapyOSvtb6aZqEIPb0
	e7C12+qMZmJEzo0sS9JS3r11lNa13MmN61xbPx1y0WJo/DoeXM5Zze6ZSoarb4voaSKEuEFCXLg
	Sq+50AxAIqk4CL51VcWiWm53KKcE=
X-Received: by 2002:a05:6a20:12cb:b0:23d:4777:49bd with SMTP id adf61e73a8af0-240bd23964dmr3285083637.21.1755162696312;
        Thu, 14 Aug 2025 02:11:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5rs4ptpFP+eE+aDbms6k70Iy3D9l8fxNcaggUmf3/3yois4BxDJjb+13OkBOz7Zojg5Z2kA==
X-Received: by 2002:a05:6a20:12cb:b0:23d:4777:49bd with SMTP id adf61e73a8af0-240bd23964dmr3285040637.21.1755162695865;
        Thu, 14 Aug 2025 02:11:35 -0700 (PDT)
Received: from [10.133.33.40] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbcef6sm34219011b3a.85.2025.08.14.02.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:11:35 -0700 (PDT)
Message-ID: <652c8f5d-ecd5-46ed-b7f5-9387ee11cce3@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 17:11:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Initial support for Qualcomm Hamoa IOT EVK board
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
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
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <63ecde5c-8234-4630-97e8-5806b9ff3eea@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NCBTYWx0ZWRfXyjF6QepTiSwm
 PZ2ztqsghAh6/zrnIRiXEffgL22i/Tp2SN+yFiFn85GZ9lFtuXjVw54/taiC95oW/S+FRAxw4Y3
 f0OOboPmWua5SHSqXK/CUnRAoJ9ZONx2WdImDW0ka0EwFF0nMqyE/Xu2XVJuH7M+Hg9m9RmHDN8
 D+ZX2212cuJo9K3Vv/15vXTnCBqqZzIPLkZ/j6qJOuuxucKUglL3u9EfUgoSYoikHwi27ZAQB1o
 ltM+p6KGNkEksLA9v7mQHwDUYNQm1HCv7l0w+O9xWTMrYINL1n2XnqlHmsC8OJwdc2LiZVxDCSU
 H/Wtm+UV35+GbiSgS8QeVi5e/ipGP62pMXCFgMVTfuH20zhkUctO7t7PDKApJXn5GqwpjD+NnqB
 HI1wIajG
X-Proofpoint-GUID: 9vNUmcpZ19tU4KXm3drX8RrbNt1T_paa
X-Authority-Analysis: v=2.4 cv=TJFFS0la c=1 sm=1 tr=0 ts=689da849 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=r9z8OYCOk6cqr7l9vhsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 9vNUmcpZ19tU4KXm3drX8RrbNt1T_paa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110074



On 2025-08-14 17:05, Krzysztof Kozlowski wrote:
> On 14/08/2025 10:54, Yijie Yang wrote:
>>
>>
>> On 2025-08-14 16:24, Dmitry Baryshkov wrote:
>>> On Thu, Aug 14, 2025 at 03:27:27PM +0800, Yijie Yang wrote:
>>>> Introduce the device tree, DT bindings, and driver modifications required
>>>> to bring up the HAMOA-IOT-EVK evaluation board—based on the X1E80100 SoC—to
>>>> a UART shell.
>>>> This patch set focuses on two key hardware components: the HAMOA-IOT-SOM
>>>> and the HAMOA-IOT-EVK carrier board.
>>>> The HAMOA-IOT-SOM is a compact System on Module that integrates the SoC,
>>>> GPIOs, and PMICs. It is designed to be modular and can be paired with
>>>> various carrier boards to support different use cases.
>>>> The HAMOA-IOT-EVK is one such carrier board, designed for IoT scenarios.
>>>> It provides essential peripherals such as UART, on-board PMICs, and
>>>> USB-related components.
>>>> Together, these components form a flexible and scalable platform, and this
>>>> patch set enables their initial bring-up through proper device tree
>>>> configuration and driver support.
>>>>
>>>> Qualcomm SoCs often have multiple product variants, each identified by a
>>>> different SoC ID. For instance, the x1e80100 SoC has closely related
>>>> variants such as x1e78100 and x1e001de. This diversity in SoC identifiers
>>>> can lead to confusion and unnecessary maintenance complexity in the device
>>>> tree and related subsystems.
>>>> To address this, code names offer a more consistent and project-agnostic
>>>> way to represent SoC families. They tend to remain stable across
>>>> development efforts.
>>>> This patch series introduces "hamoa" as the codename for the x1e80100 SoC.
>>>> Going forward, all x1e80100-related variants—including x1e81000 and others
>>>> in the same family—will be represented under the "hamoa" designation in the
>>>> device tree.
>>>> This improves readability, streamlines future maintenance, and aligns with
>>>> common naming practices across Qualcomm-based platforms.
>>>>
>>>> Features added and enabled:
>>>> - UART
>>>> - On-board regulators
>>>> - Regulators on the SOM
>>>> - PMIC GLINK
>>>> - USB0 through USB6 and their PHYs
>>>> - Embedded USB (eUSB) repeaters
>>>> - USB Type-C mux
>>>> - PCIe6a and its PHY
>>>> - PCIe4 and its PHY
>>>> - Reserved memory regions
>>>> - Pinctrl
>>>> - NVMe
>>>> - ADSP, CDSP
>>>> - WLAN, Bluetooth (M.2 interface)
>>>> - USB DisplayPort
>>>>
>>>> DTS Dependency:
>>>> https://lore.kernel.org/all/20250724-move-edp-endpoints-v1-3-6ca569812838@oss.qualcomm.com/
>>>>
>>>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>>>> ---
>>>> To: Bjorn Andersson <andersson@kernel.org>
>>>> To: Konrad Dybcio <konradybcio@kernel.org>
>>>> To: Rob Herring <robh@kernel.org>
>>>> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
>>>> To: Conor Dooley <conor+dt@kernel.org>
>>>> Cc: linux-arm-msm@vger.kernel.org
>>>> Cc: devicetree@vger.kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>>
>>>> ---
>>>> Changes in v5:
>>>> - Update base commit.
>>>> - Drop an already merged patch:
>>>> https://lore.kernel.org/all/20250804-hamoa_initial-v4-2-19edbb28677b@oss.qualcomm.com/
>>>> - Link to v4: https://lore.kernel.org/r/20250804-hamoa_initial-v4-0-19edbb28677b@oss.qualcomm.com
>>>
>>> Please keep full changelog rather than trimming previous iterations.
>>
>> Sure, I will restore them.
>>
>>>
>>> Also, is there a reason why you didn't pick up audio and display chunks
>>> as it was requested on the corresponding reviews?
>>
>> Display-related changes have been merged into '[PATCH v5 3/3] arm64:
>> dts: qcom: Add base HAMOA-IOT-EVK board' and are already present there.
>>
>> Audio support is still under debugging due to unresolved issues, and
>> it's unclear when it will be ready. Would it be acceptable to proceed
>> without it for now?
> Audio was sent to the lists, so this is confusing. What was the point of
> that posting? It clearly said:
> 
> "Basic test is good in Hamoa-IOT-EVK board."
> 
> So was that true or not?

True.

> 
> Best regards,
> Krzysztof

-- 
Best Regards,
Yijie


