Return-Path: <linux-kernel+bounces-742051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 047F7B0EC6D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D02A7AAB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CD427816E;
	Wed, 23 Jul 2025 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JhTm37q7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE4277C8A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257204; cv=none; b=Qp81xsrL5j/+903KlrU06FfTHxy1S2SEsc81Onwm7wEGmhK66KRRZeAxpAzQrBAD7X99QVnNGrIKMJSyo2/TIMvdyavcQoR/cXAXDFib486G78BaU6SIeXunN2FgrBhgN4P2G8MYSfJdTqYYPK0b8BYkWdGrfjGYPXtvknOOwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257204; c=relaxed/simple;
	bh=6AUA4zDaiameTtBfRmj4nc7+J78zCgRFdcNELO3I5L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npuZker6k8c6x5fQ7oy89uVOUGPc4B7D1TK4xsRKuHGx2VIPwabazl8NEtpXvTAVdz7/wdVjrPpqjHPZ8NG5Jz8iJ5T4LWbmQhjEVYEphqASEuANTgm6kc8lJaL1m475hubi9o0/e+B/LsH73ybj73jG7bM4rIFY7T3LtL3im90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JhTm37q7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MMNt0s019472
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:53:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bdlbcmtJz0mVZF6c4pr1ox58V6mA0vz53UAjtEAd3i8=; b=JhTm37q7O2eNlk9u
	JwsS8zXMc4j+IiZMPeij+rzQCfbmmouDUpZdPzdnO80jwlI8Sz1VSK3mbsbamv/m
	GNom75E/ilxx7TVmpwFCEZ5jX1rw6sX3DLNb1Frx1AeBzXQ9HOjLmrAx7FHPEQ8A
	HCXyST7uITCmDS33KMRN1cD6dtV274NDGxKJxXhyC95svO3w+vzAVWk9qCLuu4d1
	CTRXHUvwJM/X8sEU2/ITclMaKgOqHwwIbx0Mg3v8rOldgs8yZIiXyKYn5RxrSzd8
	Tl2T2bOVkWbaBXLQiCGhT2RCtZ1kSOFmXp2nU+SzqcIR+OyYJCam1OJL9DvLZbRI
	X2oxdA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481qh6pgpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:53:21 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b3f321dc6abso3611373a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 00:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753257200; x=1753862000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bdlbcmtJz0mVZF6c4pr1ox58V6mA0vz53UAjtEAd3i8=;
        b=Z5F9zvQQTceGVutifJs0kZnhKRsvCvyiwRNlwTE3tYXcHFzFkajhvpjEqHugXSmM7G
         w+9++6oUbop68O055XHiyffEEI1mIU4gKmtePzOghAwqvwuwrFd8H1ETTWU0mlvAUiNW
         tF9MaGJgLpLji+aTfx5MY5XOfpJLqiaizx09NJ/zrQtMKwuzlCRjw53kkYUyAmKb8s7c
         3zSuJimDZiWdkYk5+zQtnMYAsAx7fg6XM/5iY+8sxVRzkvOIO7mZRRvuM32MYQmr6h3j
         javONAsHeNUi5CZCAt88ZUD5KC/XCxuxy1DfQrKNbv/TvvlCy/NyqKEZeNq64dP+IMXf
         O89g==
X-Forwarded-Encrypted: i=1; AJvYcCUz75jAankGSrsEWQ3YAqMVO7Ktzr7oVl0QoqQNEbCQ0n2xDHyQGFGzzLAl6k6tZOryU5CuzPMFwRiDNGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KLvzWsKM5cq7QQk1B8T9OzlHnngfQhm3edUM7UiEUSV90U+9
	u+TAxUdQUnyvnGs/Iji5JwbEm4q/GlpHcxO3a4SnEzHF//xAADhreqDggW8eFraTS6RRCyNZW4O
	cKbt/t/t5ItXqqLBVkAfF9o+IDP/fYP2o/0/HMehFwHGPlzIbcI9wYcEGYlZYfeWe+Ww=
X-Gm-Gg: ASbGncsZ2Z3g6pAjtzpnTimvyugarpoXiI0llRUms27daI6XYHLY+spfoxd1qRwxWjq
	hcecU9TXSjDS2MF/weL/PKSKU4CxDYFLisaL2FIA1FCtygWMgPZYq/W1Gi4FGv9EbeNCG6MepEe
	8Iqu8XXB7hChNDqDfHyhs8skSvlGCnaP6WMeyb3sjb0D2fgyx3luPvvuLPBCSdKMNNej2oJ2VqZ
	bkTATkI5gTtlO8+mfp9B3+53uhXdu5VgKDwdaFQI3r7ryXrc/z+EosgHVa/yLh/51GbIsBxwvOP
	8gYmOFdAI4RpVT0LQxEOlHb19yWCC/54pNUhSHvdy6VpU4lOUTBSV4BVc5BYA+zYwaZkSWEbQaq
	l9Br6h0ZQhQ1iwWvCVYtTWYUHBxU=
X-Received: by 2002:a05:6a20:430a:b0:21a:ecf5:ea71 with SMTP id adf61e73a8af0-23d4904017fmr3704500637.15.1753257200299;
        Wed, 23 Jul 2025 00:53:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXv4m6IG8934XcRiMWuyLGd/m78qxsh/7ZdcHnT+rokiIcxXq6zawIQJAfrmzCzRVYOl2RwQ==
X-Received: by 2002:a05:6a20:430a:b0:21a:ecf5:ea71 with SMTP id adf61e73a8af0-23d4904017fmr3704467637.15.1753257199847;
        Wed, 23 Jul 2025 00:53:19 -0700 (PDT)
Received: from [10.133.33.46] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe8d550sm8349944a12.24.2025.07.23.00.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 00:53:19 -0700 (PDT)
Message-ID: <39deebf4-79cd-42a0-b49e-01d556e6d1e3@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 15:53:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: qcom: Add HAMOA-IOT-SOM platform
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
 <20250716-hamoa_initial-v1-3-f6f5d0f9a163@oss.qualcomm.com>
 <aHkhcUVBnrwadKfa@linaro.org>
 <3a381014-cfe4-4b3c-a3c7-df688c1e87cc@oss.qualcomm.com>
 <aHlZu51tYDSsyFTh@linaro.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <aHlZu51tYDSsyFTh@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CZ4I5Krl c=1 sm=1 tr=0 ts=688094f1 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=ErcKch8FPRIGc_MFKVoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: HGq_3ABGxxQc3X-W49tDQBFqt7yOz3F2
X-Proofpoint-GUID: HGq_3ABGxxQc3X-W49tDQBFqt7yOz3F2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA2NiBTYWx0ZWRfXxYFvHuYWHWar
 ed3qzywZ+bNGzeOsahZSFi+JlJO0W+fpar6Y/BOehWnWuMahaQnw1e0aom4E/PrLC+4/gV+9/Wh
 rW2t8/H2SLHJ3aRTzFPLgDDh3gRfS2/WGlNqctHlei6A/mI4VdEZTkHAgfZtukMWkwe1sp3cN0f
 rz9lD8AbtArxVFGCFpnPpcfQXmJkyqVReMqE+CbPxeDa3poIFpgkuGzOyyMpEFt59mEE9OStu4q
 3gaaxosPgB2TgtJuecL9KgP5OvHTZ2m2ZvzVDAVNQD7LoG5vHIP95pJMU3sumPNKnF9gge1RYoX
 SdtxDWUuIW4j7RXtQi8rpZUyXBsLNaTFXH2SoMFu7mk/FNrDrciXsk8HuPwKNsYJOMFkTw7HLPI
 CRam3fsIW5NWdTNYP5t+FjG5ts4IGL7vyVG1UZ6s5UtExYZTZ48LzF1xLyQbqitmJmVQkZQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230066



On 2025-07-18 04:14, Stephan Gerhold wrote:
> On Thu, Jul 17, 2025 at 10:10:05PM +0200, Konrad Dybcio wrote:
>> On 7/17/25 6:14 PM, Stephan Gerhold wrote:
>>> On Wed, Jul 16, 2025 at 05:08:41PM +0800, Yijie Yang wrote:
>>>> The HAMOA-IOT-SOM is a compact computing module that integrates a System
>>>> on Chip (SoC) — specifically the x1e80100 — along with essential
>>>> components optimized for IoT applications. It is designed to be mounted on
>>>> carrier boards, enabling the development of complete embedded systems.
>>>>
>>>> This change enables and overlays the following components:
>>>> - Regulators on the SOM
>>>> - Reserved memory regions
>>>> - PCIe6a and its PHY
>>>> - PCIe4 and its PHY
>>>> - USB0 through USB6 and their PHYs
>>>> - ADSP, CDSP
>>>> - WLAN, Bluetooth (M.2 interface)
>>
>> [...]
>>
>>>> +&usb_mp_hsphy0 {
>>>> +	vdd-supply = <&vreg_l2e_0p8>;
>>>> +	vdda12-supply = <&vreg_l3e_1p2>;
>>>> +
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&usb_mp_hsphy1 {
>>>> +	vdd-supply = <&vreg_l2e_0p8>;
>>>> +	vdda12-supply = <&vreg_l3e_1p2>;
>>>> +
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&usb_mp_qmpphy0 {
>>>> +	vdda-phy-supply = <&vreg_l3e_1p2>;
>>>> +	vdda-pll-supply = <&vreg_l3c_0p8>;
>>>> +
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&usb_mp_qmpphy1 {
>>>> +	vdda-phy-supply = <&vreg_l3e_1p2>;
>>>> +	vdda-pll-supply = <&vreg_l3c_0p8>;
>>>> +
>>>> +	status = "okay";
>>>> +};
>>>>
>>>
>>> Assuming the USB ports are located on the carrier board and not the
>>> SoM(?):
>>>
>>> Are carrier boards required to make use of all these USB
>>> ports/interfaces? In my experience it's not unusual that embedded
>>> carrier boards use only the functionality that they need. Maybe this
>>> should just set the common properties and enabling individual ports for
>>> PCIe and USB should be up to the carrier boards.
>>
>> The PHYs are on the SoC and if the kernel is told they're "disabled",
>> they may possibly be left dangling from the bootloader
>>
> 
> How is this different from any of the laptops we have upstream? If we're
> worried about firmware keeping unused PHYs on, then we should probably
> enable all the PHY nodes by default in the SoC .dtsi?

Per my understanding, the SoM may be used with various types of 
firmware, some of which might fully initialize all USB PHYs. In 
contrast, laptop platforms typically rely on fixed firmware that only 
initializes what's necessary for boot.

> 
> Thanks,
> Stephan

-- 
Best Regards,
Yijie


