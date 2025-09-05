Return-Path: <linux-kernel+bounces-802598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825C8B45465
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469095A44A6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F432D59F7;
	Fri,  5 Sep 2025 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iDWdCbR5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39B2D46AB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067624; cv=none; b=K+v4hseklyWh0mJjlujeEfPMZV+oufVk2OW5ivK/S/0GPgUcGuh5iw++2Dh4dwPT2jNjHSJswaKlY41db2sKnFxV11Blv9NcGLvyl19Dh8e0Ob5YJU8ZbCLJZ6ck2ZszhlXjzUic7jEzoywqUF10POLtOEMSvMlCWJaMUiz1N4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067624; c=relaxed/simple;
	bh=NhL39okvE1UQ0JDbrGcrVCu7unTeSnVwrFd1RwYqZM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibQjMrLE00Sz921HjfrRLxZWlI53S4Tj+7NxiX+6sjgm2hkTRn9Ot8NXrTYVp2YUd8TSPcy3mxG0+XiF+bmKAknidFul4LUbRVIkbgaGzQd4d7K8AM7+Zdbv1ZDmZ93BGgk7PXItIA0FqAKl+xpiP63dDG4d4B+lpw+/vKc63vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iDWdCbR5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857KOS3012118
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 10:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kTOVAGfJmHAMbslcDUKw3QbQxdL6mIKaKsV42CZz9as=; b=iDWdCbR5bU2UWlLU
	y4vO0uzK/G082CYybYH9KBDzkgIiLLuDfn9q4i8gWqER57Y7OtZW00rEBUuV6zl6
	Om4lUxRVewiEAxwZcqBC/hI6b6LtQgKMb416nUV1GcdIVpDXhAYBjI92I0IsjrEH
	ZBqtY176u1be2bt5W7cnnS40jG5Fh4SAJgBtc7bu/7TtEwiOVF6JHtASmiEXYg/j
	3ECvhkR55a5XHDPKKs7zB2jpTRjsUpNn5sl1hKCctVkD5/KuWPT9bIcKyZGj/zXG
	R9N/qQJ5yquVKJBOwkqppq+Cpdw1sCokN8AaSlwshVaOJa+bZaseMXoRtfbgV9g+
	FWlV6g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48xmxj74bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 10:20:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b33e296278so4285921cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757067621; x=1757672421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTOVAGfJmHAMbslcDUKw3QbQxdL6mIKaKsV42CZz9as=;
        b=U2DmzGu06o8FsMBGu5alO272OJtcdam1fs0t3FlS/K8s6Z3EHgHIzXnHny8acok4QY
         jOEdWxyXmFpxUvIFXs9tqfPwRNmk8tnCzYkADdy8x6JGtp/CORLmJ3a92zoZLwVQbsFN
         +OlGDvaFAHK0+edsFZ/aL/BZwUQHChEh8+novCnwQG1WOP20nuO1c13U58UmlG0Mchiw
         geUSc8xoLnuNP7mcoPdkl4IZPWosvl/pR9VLsiu80M15725PVzH3nrRtGlDbNO/kmCuV
         czb/N93YIQJ0SDxoasZ8+HzlfYamf6jfygPzpNl+fZtBTAwMEtfX5qtNuVlfgXj6X7Y9
         +3DA==
X-Forwarded-Encrypted: i=1; AJvYcCUbxAMEmSP3X0j4mZ52BNWJxL1SIaZo5Vu+Lk56fDTuknkd2NWBQ2060l/pRJYnRNpOO9C+fTb1aci+de8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzx7il8IgN6ITAdlTb/qmi0Ur5ZPz8XLGY6EuQUZvOE4cc+lp
	ByPpMKdcjn+2XE+IHrT3ztNamiy6cb55YvxtUrTMk3By3581YovprDcqzqp1Fvx/DSY1Y1dhgl2
	ALpWXLVh0s26JaIH7cjPgyJt75leI49F/M/1YjO4RF0fYmK6Y9cOcFB321UxS5EYp+es=
X-Gm-Gg: ASbGncvJvu0SNnCTwl2d5kW7ncdLxvrMg0m1m2ZPTmddK0pA9dAg4vxgfh71NGBTh01
	kn7WzJyNlI/3tEofLGIh6O4QQpPeGReGhn1f7AKEd45I8VSwraBjOQLsagaLOWaYinwRTUVlt8b
	64vVkIhTPkQSRfYkCSJG/NSV7OvBM3LgdUmhQPg1Oz+xJUg085cDpTlWkVoheuJsQAayc4hEE14
	AbtTBbwOyih1XnpPM3pluI5YHUcNPSBhmXHxd77GR35QfZSESm59dvWxUrMD2rCxww2kSuVE2Y5
	Zp3+76UGdIAasF5ZdoWhqAqdaBN4tyd2ynHk41LyH2Y4DY4vYdDfhpQISnErN1Zh3Pt578NpX3B
	RgXFaegFLT2gPluvqWU2eWw==
X-Received: by 2002:a05:622a:1483:b0:4b4:8e4d:6671 with SMTP id d75a77b69052e-4b48e4d6f04mr83378771cf.13.1757067620974;
        Fri, 05 Sep 2025 03:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO6Dw5E5OGVqQHPhLnTT6piTScFBZOcK2M8RO2gr8kQRnOFlQeerKrV8G2BH+P30VO7Bu8Lg==
X-Received: by 2002:a05:622a:1483:b0:4b4:8e4d:6671 with SMTP id d75a77b69052e-4b48e4d6f04mr83378341cf.13.1757067620108;
        Fri, 05 Sep 2025 03:20:20 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b047373b000sm497098966b.68.2025.09.05.03.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 03:20:19 -0700 (PDT)
Message-ID: <e480ab16-bf98-4a3e-a7e1-67776a598201@oss.qualcomm.com>
Date: Fri, 5 Sep 2025 12:20:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: leds: add generic LED consumer
 documentation
To: Aleksandrs Vinarskis <alex@vinarskis.com>,
        Hans de Goede <hansg@kernel.org>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Daniel Thompson <danielt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus
 <sakari.ailus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250905-leds-v2-0-ed8f66f56da8@vinarskis.com>
 <20250905-leds-v2-1-ed8f66f56da8@vinarskis.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250905-leds-v2-1-ed8f66f56da8@vinarskis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDExNyBTYWx0ZWRfX897pFQGb+i4Y
 7XqFH6oiMDC1Cn1vEBDyisXsdm/4Nq5dPxgphkBbbCgqVyPAY76JNsKb/YDrW9QD9sZLlu2TALE
 xGfgHAon6G5FtxGPRGSUEGqxR+I0+30P6Kj/Qe5n7CZNOIUn+UK9Z8h4goJ3tt//yoNchCK9PZ5
 IgZSlLIjIEthh644KRALzSI8Mh0nWP5yb6zojbpEXNjt6yZi8Jlr5Ql7n7YRUX+FmMG5u0rc/zr
 GfDlLhpBqeLJn3/ThlsUQuYc5hXqB2gBuTJ4eWxpX84ZtAz77tCH1uIEm7zEgGDlG5EkJlHFV3S
 fkRJdcJzvKFqIMmoAkmECx/y/zIhdffaStUf1aWSNQRslF1ijBoqixMylAQNUxUOPcxD7KOhBEn
 iA1p3Rde
X-Authority-Analysis: v=2.4 cv=a5cw9VSF c=1 sm=1 tr=0 ts=68bab966 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=I76Qk8w-AAAA:8 a=2ng2SV8iM2HKWhXzYmMA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=vUPM0Wvl0xcrLs4nqPIT:22
X-Proofpoint-GUID: a7PkrMXN6L-O0--v3RMzIDTIlH1j8VNh
X-Proofpoint-ORIG-GUID: a7PkrMXN6L-O0--v3RMzIDTIlH1j8VNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_03,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509030117

On 9/5/25 9:59 AM, Aleksandrs Vinarskis wrote:
> Introduce common generic led consumer binding, where consumer defines
> led(s) by phandle, as opposed to trigger-source binding where the
> trigger source is defined in led itself.
> 
> Add already used in some schemas 'leds' parameter which expects
> phandle-array. Additionally, introduce 'led-names' which could be used
> by consumers to map LED devices to their respective functions.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex@vinarskis.com>
> ---

[...]

> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      camera@36 {
> +        compatible = "ovti,ov02c10";
> +        reg = <0x36>;
> +
> +        reset-gpios = <&tlmm 237 GPIO_ACTIVE_LOW>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&cam_rgb_default>;
> +
> +        led-names = "privacy-led";
> +        leds = <&privacy_led>;

property
property-names

is a common pattern

I know this is just an example, but people will copypaste it

Konrad

