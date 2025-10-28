Return-Path: <linux-kernel+bounces-873382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B8CC13CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B9B5E1FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1CF3019C3;
	Tue, 28 Oct 2025 09:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CYSLdPWG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E473019A5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643529; cv=none; b=AvPZ8O/cOQ/Am3EWRZSOsltwRvCAisKYP5g7V+crKzDa/rLyb4Ajdb8WV8/gJRAtPIcSujvzJuMxi4AdW1dBsJiDmCJokV+5XphJskf9yD4JxrBzwVLLCSxSNST74bxQXRRszzDKrnVb+koktJumLXIKt+8wH3lgiWV5qqpsVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643529; c=relaxed/simple;
	bh=GWMNhDtLv/kDpAWcmDnXHJG+taWjdcCA7zBj1ocUvUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7I3Em1swiCMFxrCxxC0Q0CRI2rcAxc0+slNgIKzZ0B4cO5QMYtY58pzY3WG6KFlq7pYJBIL86sdeZdvhg4afwUb8afpQsC2HbFF7miihqFkvIgig3RrnIvd9CgtprsuACrTA45C6YUWSzBGKOBlpPbnIENuNY0ycWldgxRohX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CYSLdPWG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59S4otwx589647
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8SK5QLPQR+xhdHyxzgW1kiyNV5P22KYcA2/y/XH+b0s=; b=CYSLdPWGLRdpGvdt
	Fh/1/rEoA9+mGwiBBMbRYHydxOxKli5VyIcvcK/2DKAJ93n9ksPJoVgFEpsL0bDI
	VwzmyCTukdBWOm8cxTNe3FPQ0hNjRqB0T5CunEuiZhCWEm+qu2nupIOeCsoW8206
	s6yvfs1pKJcPkXGDquM0tel6h6AsZIEa0uXdU2sz+62qoGQP48XGfhaa8tSxCOul
	3hf20+ji0bjjNPZ20dFMP6itV4zYMFFYPsdWXCSEC2LndFzLMXfDJyRc1hLGCMXy
	DgsafTBAYHyoy6kSheajmKz+vtr8767LaNr4f/MDD4U7WhmRexo3W4SNpGIoI7qF
	cfXdRQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2q5u8s7c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:25:26 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87bb67409e1so12622666d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761643526; x=1762248326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8SK5QLPQR+xhdHyxzgW1kiyNV5P22KYcA2/y/XH+b0s=;
        b=NlUOFpmQ9Vv/6oa+kHKc95ezysKQrmGeRZPSEFhIvkGjdTG/9FPuil/fwX0c7EXKRh
         Mw4paIjt09WzTKCarDbT+Heq9joaBMOdFB9AGpVeXHto0hivyW8ocwmrfimrw9oqsVVE
         IweMhAQOw+KGhGiBmTXWQAGxBzGjS+94guCMDkgO3M2+nmRg098JwcyChD4FKLIuaXDe
         b8Fexw6cWTGlTYbiKuUA6xyuQdZpmuhQpfj9agxdVOeDunDKlaSWVjtac9avwdQn14qc
         WioBjuK67xf9cAbGTqiFpCK9Kq1r2AiLj4ixvJ0wbQvukzTGENQfboFAS1n0RQX48CNj
         l8IA==
X-Forwarded-Encrypted: i=1; AJvYcCVMqOKPteNbFuq4VwjyJF+PevSVoia3f5Abc2OtXhDXfgcTTQHjVnyJVkEl9XCpeSDI4hG2mYERWDCLvPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8+4Nu0Hx6jSI1iuC/KIZAaJv9jum4mUXqiNlqvh2Rf8y7+pMv
	nGnajlYfKvisDJW/njnyrxyYShVVaJW/jyB70RdMFmeXB1926AjRJwn6S5Dk5QHW4Kt9WKC0/Ni
	miZGTZovH6PrnPKPBlE+X/9DvpP2MME/r7k6KQ/rUme9FLzcsNKlfOv+itqZdVZmQOXc=
X-Gm-Gg: ASbGncuE9LAVmB1wDm8zXOwWwIeTZjMqsewDZkVY8Pew+y5J3MLqn+mvfKZPlbmIqac
	otKCtalRUX5BEzUMnbFggHK8Iy0AtUP76NtYRKrEwe0xw+nyBtH9TIaPwsEYgQnmgLKJ7hVHuI7
	5xVgA/6G9AafY2Hf8y5qxS9APXCFBMVm5+tHPY71GdOwJS0vYdsFUuJ6Z9ASQR/7KXIk6tc9Lq4
	ZED9Mny8ng1YpWY8344uuY5TWW0yctN3EN1AkRJh6avFoKPSfingywrO+FHxGuaqBYt1uaz1lsO
	IdD/syGz76UMXI/EcQhY0VWNJWaUKYfOXcirtYxNtpVFdzuzOYC8wte1g0Gb0qhrOHE5YcOZ/0h
	5lqUZUlAbqMhU/08eXD7dYSAyplAUFACSYKgxOmGl/YbFtm7bAqlvgHlG
X-Received: by 2002:a05:6214:2521:b0:87c:2bf5:550e with SMTP id 6a1803df08f44-87ffb104bc4mr21876436d6.6.1761643526293;
        Tue, 28 Oct 2025 02:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi2+KT3Y8I/PL2gLm/2ohFliLpxgVh/WSkJ9F7uM911mGlAp973XdDMSrBXCrX0aCtRxDW6w==
X-Received: by 2002:a05:6214:2521:b0:87c:2bf5:550e with SMTP id 6a1803df08f44-87ffb104bc4mr21876316d6.6.1761643525878;
        Tue, 28 Oct 2025 02:25:25 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8535974asm1013525866b.25.2025.10.28.02.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:25:25 -0700 (PDT)
Message-ID: <d05fe82a-640f-4a09-9d83-39bb5aff179d@oss.qualcomm.com>
Date: Tue, 28 Oct 2025 10:25:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] arm64: dts: qcom: talos-evk: Add support for
 dual-channel LVDS panel
To: Sudarshan Shetty <tessolveupstream@gmail.com>, andersson@kernel.org,
        konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028061636.724667-1-tessolveupstream@gmail.com>
 <20251028061636.724667-2-tessolveupstream@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251028061636.724667-2-tessolveupstream@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDA3OSBTYWx0ZWRfX0FMxEqOfBTOu
 bhbn5JmLUfxpF43ETwSZSLlcsKH3lG5jQke7jJxwGkUrkFPLQlepiWiiT0lYLjFrYmR92LlIo88
 4+s8k7hQjhHnSfw7h+jIF5sAP87sTM2LyuNMjRFzAKneH5dckCYOCy/EFfgqjZbBlltcW58jvp2
 b9T2gXwPzg4ytYhhStO2rIsvmEu7o5zcoJtS59M0qLLqHczjUZOKlkuUPwfnsLVg4fPjFcuNNoD
 ilvWQ+rccoo5ZGiULD99ggPyc85yuXphoV7HnlvWvjHw3SGmaO+19oSu37tbeWyb8afOk0c6B1z
 sJjvT8q8vzzb3lHHVhXyzk7UmonioSaNaJW8UlndodD3jU1zpJqY18S6V1f/b1Q2jYPhFOLuHo2
 CobLxA3bOyHkERmTzhTy2LnoFVefmw==
X-Proofpoint-ORIG-GUID: 3pglsll2lynqnHgqOtZlHSg5E5qocNwy
X-Proofpoint-GUID: 3pglsll2lynqnHgqOtZlHSg5E5qocNwy
X-Authority-Analysis: v=2.4 cv=c9CmgB9l c=1 sm=1 tr=0 ts=69008c06 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=QuCLnqFj5nzKUXK4Y7gA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280079

On 10/28/25 7:16 AM, Sudarshan Shetty wrote:
> This patch introduces a new device tree for the QCS615 Talos
> EVK platform with dual-channel LVDS display support.
> 
> The new DTS file (`talos-evk-lvds.dts`) is based on the existing
> `talos-evk.dts` and extends it to enable a dual-channel LVDS display
> configuration using the TI SN65DSI84 DSI-to-LVDS bridge.
> 
> where channel-A carries odd pixel and channel-B carries even pixel
> on the QCS615 talos evk platform.
> 
> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> ---

[...]

> +	backlight: backlight {
> +		compatible = "gpio-backlight";
> +		gpios = <&tlmm 115 GPIO_ACTIVE_HIGH>;
> +		default-on;
> +	};
> +
> +	lcd0_pwm_en {

Use hyphens instead of underscores in node names

> +		compatible = "pwm-gpio";
> +		gpios = <&tlmm 59 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&lcd0_bklt_pwm>;

I think your intention was to use pwm-backlight and wire this node
up to that

Konrad

