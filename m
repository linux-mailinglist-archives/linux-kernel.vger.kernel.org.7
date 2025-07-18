Return-Path: <linux-kernel+bounces-736500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86592B09DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9910D16B619
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECFC2192F5;
	Fri, 18 Jul 2025 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HMJ8Kg0B"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC9E213E66
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752826763; cv=none; b=RchNfOcB/fXvBim2apo7ElsiTfgSo1+TZC9X+ilrVFst8dY48FJBv/QB8C0l5PMbrPiVhF+RJfL6UpgLFdjkq7C8QWstKqaOvPE0X3P/o2UzsR7czKsr+q1IWT3NaAbHhG1yTNyQNzXmzoYXhR/MTt0dTV3nKGPjpWs/afRslVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752826763; c=relaxed/simple;
	bh=XWvY52CVwf1xQnIwZCHBnCJOrwWQH/s3xvPNq+F5WG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOWWGmuUq7/5JM5L0UQYKDLHDmJErZxyEimhW32EkwXMGTXW68rZCcHAJE3iknPk7rG4NoiENtJEWHAcK4OoS3lGZ9zV1vfAOeLBmghV3/lrfPMcDDQqZ4q8iPR54k47fnOphf651AXMPiQBkTk1JhSdDwLetQ9vb8PEEn/zUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HMJ8Kg0B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I6v60E000567
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	07T0KmjW1ma5az0RrByHzd3wpVHJTSp1Xnwq7/Vgc8U=; b=HMJ8Kg0BV0P18qXw
	ZXrjRQBn9IKbMFAHbEeM23wQK9xv4qxO2P+s3HJWfNOmqOcu02bOc2kjuXOtWHhX
	k23dsbfB8qnP73x8Tauf9nyQ8kFbJruscnEPCWyFCt2Y/Rv2A6yiT0urJAOKMoUU
	5KoFgHB+B9Gwj/ezrL1InUDUVBUHB7cS1iOcNFsqTlb1CqEmpHGJPfqB0zMY2lbh
	wMRefHxk2io6Fm7MhHOGu1CuXDRaE63cfIWKL1rJKsnK0Kk7LehHaT3TyV0WbfBe
	4JxqXrGhEJaANGlduDAvY9UL9OH/3zKUkUrLUWBAdyPCuJNiDFMK8blkmGKSr6Hy
	WNI1/Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drwry8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:19:21 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b3184712fd8so1251154a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752826760; x=1753431560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07T0KmjW1ma5az0RrByHzd3wpVHJTSp1Xnwq7/Vgc8U=;
        b=LbvVvK7+l7Q1nyWKUQ67PFuTFKGqzGTGOClpvx05FcWcDQc/jQfGQlXX4YkXZ7M2DF
         nuWTLVMxdnZ+p+ZkzxAKbljlq4fG3YV/TNRs2E8ypv86/GIEVEbqkAwI/XotZEvgBBSm
         Vk4Kr6q3IZdnEEGxkRTpftDNahvGUSts47R55tubcqacxhqyrodXhE2lamxWwuxTEiZj
         kd5WOIMbmcJ/UADIIF9Fg6mYtvVdIe3m4iJa+5tOaehym0RZCXSH+WRY4XKKFsnOl0Gn
         Yq11+f9tOI/FmABJF6BJIVqPT5QX42l/4iDB4ImrzLlc5yf7CS169DG0AcqTsyTPTezP
         0SUg==
X-Forwarded-Encrypted: i=1; AJvYcCVfyRNDziBr+08EBlg+KIIkn5XLYNvYG57JzwAtLaV+WJjyuGa8rhOcCeJI852k8uBIAgvYN/JCjUDhqW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydYe3216qtfXFrGtFMTCmAmD81DPHJaTB8BC2GBYVuxgNYrmCR
	1Edx6WdyBxZhrz2m6lVbToGy4XQRELhe8isqIBNk6sDolUOcFuhzlLtTaQ/XoeP45BrKTqr3JFW
	yJ1pGT54g+JsaKIwQHzmhGeMpAzuk1/wDgE8J33nQoPBbL9KZTVYOpxs/b6bLinsZtXA=
X-Gm-Gg: ASbGncvA1MzVeWN7olur2cCrguQ1oBAKpKNIYqgU6VS4qdXJ909P6GZoQ/mqLhLXtPY
	K4u69jAtXVDVXAtbrvUeaHcnjkrYVKIAQ11lYlNDerCESyY1shwATgk1R/syFB9UJUrDGBJFuRU
	Ydry7x9V+UW3ttMkrtYZ3r6NGWpt6yrc7TarzzoIFB26fntzWWVqf8kuz0dMXPXOMsPYEAXOinI
	zTgBjuJQN9KIxkPj6wzvnLGdVwDl9czkF/1HlTNrVubipYBGkyMJ0nhOfHsqd4RuDkDlEgfzpi0
	s+CpxK4ndN2QX1rEGnGnGYx3GHuk+cXqLivOfnl/+5sS7pSYY+05qO80wihPxeeL6M9uE224Uj0
	v2i9lZ+JAGaGCO7CPGSrzixik4m8=
X-Received: by 2002:a17:902:da8b:b0:238:2990:6382 with SMTP id d9443c01a7336-23e25522cd7mr157638835ad.0.1752826760173;
        Fri, 18 Jul 2025 01:19:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZQCexBLGFLAqxaA0VFA7cuUVspf4kCkrT1kVFuR2ya3XjqZ8hVZ8VVU9src318OO+G8WEIQ==
X-Received: by 2002:a17:902:da8b:b0:238:2990:6382 with SMTP id d9443c01a7336-23e25522cd7mr157638525ad.0.1752826759763;
        Fri, 18 Jul 2025 01:19:19 -0700 (PDT)
Received: from [10.133.33.15] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3f2dbd9sm787397a91.32.2025.07.18.01.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 01:19:19 -0700 (PDT)
Message-ID: <4363f117-cc25-4904-84cf-4b3779797223@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 16:19:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: Add base HAMOA-IOT-EVK board
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716-hamoa_initial-v1-0-f6f5d0f9a163@oss.qualcomm.com>
 <20250716-hamoa_initial-v1-4-f6f5d0f9a163@oss.qualcomm.com>
 <aHkm4qjgSaklHGp0@linaro.org>
Content-Language: en-US
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
In-Reply-To: <aHkm4qjgSaklHGp0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Ai4fQ6uLLNcszqIGi14qWU8sreLWwD5M
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=687a0389 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=cEA0-WaZvo1qFZeNYSsA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: Ai4fQ6uLLNcszqIGi14qWU8sreLWwD5M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA2NCBTYWx0ZWRfX3Bot8EPqmTlB
 vnshRN/x9oTCanmKe9fGNf8fvNATYvQpGQfr9kY4gQUe2KMHFwfn/bJc+Zmwf8n4UbPEelMtN+f
 xK7v79fwA1ftPJsDrQhJD7fHfKq/tX1PpfWQwutkt5KqZXBAlVWtrLfzQNdPqqj/aiEmruJ0jOL
 TuGP1I/e+/Af6sDhzUOwvv0lwFOp6vx3LFTMtZQMrmsQVyp3tHW/U9omvAiVc1jE38Ff7CwZcdo
 ib5jwyKfT72N+mzpK073UA8AXAutozAw0wpTQsAJ0b2YB/lj6ekrEHWd4N7KUYLG5gQr6WwM1FY
 x8hNLAZQSFddr2WEECPzBTYq3Gg/PYNB4nnWgBlltSjN+nZuBJHcoqaGv4COD8qUaNhJgiuLfSz
 q2zuEHbsh8p+APBAopo0t5sQ8eybQv0zI4dAoLcMfQMeB5u6WFyScM4PmgxXdpNYn44AVtr8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507180064



On 2025-07-18 00:37, Stephan Gerhold wrote:
> On Wed, Jul 16, 2025 at 05:08:42PM +0800, Yijie Yang wrote:
>> The HAMOA-IOT-EVK is an evaluation platform for IoT products, composed of
>> the Hamoa IoT SoM and a carrier board. Together, they form a complete
>> embedded system capable of booting to UART.
>>
>> This change enables and overlays the following peripherals on the carrier
>> board:
>> - UART
>> - On-board regulators
>> - USB Type-C mux
>> - Pinctrl
>> - Embedded USB (EUSB) repeaters
>> - NVMe
>> - pmic-glink
>>
>> Written with contributions from Shuai Zhang (added Bluetooth).
>>
>> Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile          |   1 +
>>   arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 835 +++++++++++++++++++++++++++++
>>   2 files changed, 836 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 4bfa926b6a0850c3c459bcba28129c559d50a7cf..c5994b75d3e56e74ffb64b2389ee1bcc086f3065 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8039-t2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= hamoa-iot-evk.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-tplink-archer-ax55-v1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp441.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..843f39c9d59286a9303a545411b2518d7649a059
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
>> [...]
>> +	vreg_wcn_3p3: regulator-wcn-3p3 {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "VREG_WCN_3P3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +
>> +		gpio = <&tlmm 214 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +
>> +		pinctrl-0 = <&wcn_sw_en>;
>> +		pinctrl-names = "default";
>> +
>> +		regulator-boot-on;
>> +	};
>> +
>> +	/*
>> +	 * TODO: These two regulators are actually part of the removable M.2
>> +	 * card and not the CRD mainboard. Need to describe this differently.
>> +	 * Functionally it works correctly, because all we need to do is to
>> +	 * turn on the actual 3.3V supply above.
>> +	 */
>> +	vreg_wcn_0p95: regulator-wcn-0p95 {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "VREG_WCN_0P95";
>> +		regulator-min-microvolt = <950000>;
>> +		regulator-max-microvolt = <950000>;
>> +
>> +		vin-supply = <&vreg_wcn_3p3>;
>> +	};
>> +
>> +	vreg_wcn_1p9: regulator-wcn-1p9 {
>> +		compatible = "regulator-fixed";
>> +
>> +		regulator-name = "VREG_WCN_1P9";
>> +		regulator-min-microvolt = <1900000>;
>> +		regulator-max-microvolt = <1900000>;
>> +
>> +		vin-supply = <&vreg_wcn_3p3>;
>> +	};
> 
> Like the TODO comment already says, regulators located on a M.2 card
> shouldn't be described as part of the device DT. We need a proper
> solution for modelling the M.2 slots together with the standard power
> supplies (3.3V and 1.8V) and hook this up to the pwrseq subsystem. This
> is also the reason why the CRD does not have Bluetooth enabled upstream
> yet, this needs to be solved first.
> 
> As far as I know, there is no one actively working on addressing this at
> the moment. Perhaps you can assign someone at QC to work on solving this
> upstream.

This power section is now managed by UEFI, rendering these regulator 
nodes unnecessary. Therefore, I will remove them in the next version.

> 
> Thanks,
> Stephan

-- 
Best Regards,
Yijie


