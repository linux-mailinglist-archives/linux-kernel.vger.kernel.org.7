Return-Path: <linux-kernel+bounces-721740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F816AFCD74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E8B7B5EF1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F812DEA87;
	Tue,  8 Jul 2025 14:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eJMTJ1mr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788242DEA82
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984398; cv=none; b=rIp8EAN5nkA8Ho6wRwMnPnRTw0iNZML+7sVVKzsAh7KaDbT14B+Bj2jry7oROOCa2WbfjWm/scJiUO6O+46YnSfE/NAVTVASehkZ0Oufey+1PicIBojH9V2l1LrP+rKmXOI8sSI+ve5eeJ5jjadY1J6qXFSxdA9tCZvZa/ep+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984398; c=relaxed/simple;
	bh=HkLphNqugzPNkULwlET2cC5FiOAU7AKlDuc+7g5S06I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AI2fHiLizhrLTXGil4lHTmQ11BrEWjRw0MHJNIKdtr7L+N0/69zXBOzLPj0qhii1IvG/0tChzx0w5nyXw8kKxPsHLvzFvJjGrZbZIOdfxfQ8JGd5Pxzp0gRGTCHNbJB7DaPcZG/jIzswQAt5k80Fy6tx0FNFFU4/26tnKA3DzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eJMTJ1mr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAOoj001152
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 14:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BanEk2RHzaJeEV6ZyoootTk25UM5XmLdjVm0P5oXSIU=; b=eJMTJ1mr/+My54oQ
	vfYUTAx7Rw3nTNQ2FyBUe9fRnUVhHXViAQbaevHx2oD1eyLr4/JqiP8N75CI03WH
	yB5GIjmaLZOsjusrWg4KSJFi79SWfz/SgEQq5zbu0Zbxi/FVP2NM+YBNClLSQWoH
	PJXyaJCSXjG9Q+nMHuMZji12K7FN2lyS+x/V+73Cwa+GFxdksj4jBco2L3/ZVhYr
	vANXk+srJXm6msOTz+jKr2FO3QJpoYLIFcr1IV1hmVmRyosPR8eWJUgaUAtRw7Al
	0aQJXIlPUjZ7sP3aFbUp4IVGf9t7OJasP7MjTT+SmOiHuBCBVKl1nR+lo4f2xP4p
	pWn6Tg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psdqxwe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 14:19:55 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d2038aae69so21231185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984394; x=1752589194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BanEk2RHzaJeEV6ZyoootTk25UM5XmLdjVm0P5oXSIU=;
        b=NxzQczGbl1uGBNfH5VRWSda93/YMJVSdZu2lC8OGTeiXuNsclTgVBtTAstSGCryxgX
         5aIVvBuRucZnWPhm8Epsk8+aPPkeS89TQdDGRboZYPzhdyApQU6bUuGApGq9yA+7g8tu
         Qa3Uht3bE0FFe0IIKEk7UmGZ1L0R8J1/K6pe0LUtrApz3uY45MXtITubXOoHMUa967am
         TFubQ3a0hkHqNNbCgbHjgPLHHxKT03YafbleqtpHs2iXh8TyOjNKt87CNCKNZXwdFgJZ
         BcJCcrFKWJWG7SICY6aRMq283ezYyKL/JC3AMzQV147Ob6xzALJlujMEJNM/9o79GGQD
         AvfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP1r1yxguUqtc7aXv3lPDaef5Vc/b359O0Jjt9liNxVi+1/NYiQ1EwENY2hVMGvDszmccgJhfiftrk5+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/8FhFM8NH0eYrwnwQ22vMTp9+k69IcSNVHcQExlZwHaFGesb
	oru7fSWAirUeSaoii2K4n7PIZvaZL1eBb7HKinIrMy0rDoJaDnsQp5JTLBfqMlAtNRHZPjZCqX3
	Opwu6UubxwtKs/Yvws1rIANBTYSEd044Ry1hciolYr5bQsb0rLSoxx+XAzmSkEmDdNms=
X-Gm-Gg: ASbGnctf38OCvSOuMKGKfmYZ58cwL7MHgQrWa6Ige8sx//ZRIeDwzznqJMTcqikIbwq
	4NFotQ7R7q9DlaTC718AIjX+T3FosjSev4CnIEKBFIhhsI9IoWCy0o9s/jiLoy7pif/mRMGZuRd
	Gkwh+/+CgmulLS/EIDRMm+V7q1/Hci+Z1KDFRMJXl8ACcUaWRDP9dzvOZlkwnJSkwwuRlWWNDtR
	Lnj3WkXIaONt+DQjK2kXl79T+o2O7FnnUM6EuwJo/VkbRglKpgXXLF99rn8NolKUoZ0GZCKQa88
	V3D9vQcbeRnMc+379PZAIqlc69ZOXuWqSeqkCBOw2EkTwwmv0cnaGlkgMeIIBEKhQ8D/F5EDQFO
	pGOE=
X-Received: by 2002:a05:620a:28c9:b0:7d3:e939:5293 with SMTP id af79cd13be357-7d5ddc718a8mr785765585a.9.1751984394277;
        Tue, 08 Jul 2025 07:19:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv2ihPdU/PuYCUkAU8M6E+45LpiasyPqOUyBb92phaclqN6A134RMBPMQfpFuf+R7oVhVQRA==
X-Received: by 2002:a05:620a:28c9:b0:7d3:e939:5293 with SMTP id af79cd13be357-7d5ddc718a8mr785762985a.9.1751984393614;
        Tue, 08 Jul 2025 07:19:53 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b04d3bsm884795266b.126.2025.07.08.07.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:19:53 -0700 (PDT)
Message-ID: <bdb5e19c-dbab-4ea3-9a6d-a4ac795fb43a@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 16:19:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] arm64: dts: qcom: ipq6018: Add the IMEM node
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250708-imem-v2-0-692eb92b228e@oss.qualcomm.com>
 <20250708-imem-v2-3-692eb92b228e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250708-imem-v2-3-692eb92b228e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ffSty1QF c=1 sm=1 tr=0 ts=686d290b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=o4o9nyK-Q1O9M6IKefoA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: ps94eyql0btaQJ0nv5VQeH5WAD7eRkRV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDExOSBTYWx0ZWRfX2aS3yXvL73t+
 pGkqXp3KLD71D7VMJBsqMmAtq+x2v264A1kR5Sn2TW620VNI1yjngDfTLhE1JK6ELmPyK0R0Nt6
 4YZ7VN9MFJvKw/69Mn61XNICoSYkku5TZRuTufKNNOQCvxFKG3KrORekHo9ZYgcjww0SBpNkQhX
 8MqeFzapiexlMQ/Qj1lWkB2Y/UqFaxX+q0+bSZ+IKT9C8jsBkZhJx0qICTU62eejGmvuocLwYjb
 ynG9+vC1QkoOxE/+klZGxaOlMocFA3u7n+2LTnMVKrRTi8pvnjAMViWm0ZBzNTyQ8nWvp3NQ2ui
 ZK9w40b8seL8I/KB4K+c+YhalP9IJ2LvAcZhYy27xZQu85t7RTj16rbAGeStm2KQ52WLUbOeprf
 4xqiXYpY/tr5nEESHBTEgCMWFKQZfSL/JjepoWQoEy3ZoTTvCkb/DD65UFVmlZNPdeDPsaXy
X-Proofpoint-GUID: ps94eyql0btaQJ0nv5VQeH5WAD7eRkRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=847 mlxscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080119

On 7/8/25 7:39 AM, Kathiravan Thirumoorthy wrote:
> Add the IMEM node to the device tree to extract debugging information
> like system restart reason, which is populated via IMEM. Define the
> IMEM region to enable this functionality.
> 
> As described, overall IMEM region is 32KB but only initial 4KB is
> accessible by all masters in the SoC.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
> Changes in v2:
> - Rounded off the size to 0x8000 (Konrad)
> - Represent the reg's address space in hexadecimal format (Krzysztof)
> ---
> In 'ranges' property 0 is used instead of 0x0 to align with the existing
> format.
> ---
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index bfe59b0208415902c69fd0c0c7565d97997d4207..3b9e40045906b26b94e2d2510b0570d3eaf084ce 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -659,6 +659,15 @@ qpic_nand: nand-controller@79b0000 {
>  			status = "disabled";
>  		};
>  
> +		sram@8600000 {
> +			compatible = "qcom,ipq6018-imem", "syscon", "simple-mfd";
> +			reg = <0x0 0x08600000 0x0 0x8000>;
> +			ranges = <0 0 0x08600000 0x8000>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};

On this platform, shouldn't it be 0x6860_0000?

Konrad

