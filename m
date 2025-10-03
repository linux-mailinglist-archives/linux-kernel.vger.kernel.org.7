Return-Path: <linux-kernel+bounces-841315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67434BB703F
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CEFB3A81E4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A682F0C59;
	Fri,  3 Oct 2025 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k50yKbuQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C75B72631
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498077; cv=none; b=DsENfDDdwD2VA+18p0p8uczTcqXrQIKRE2Cj4ic52z6VoM5gcoYZ2aGbMZQAFMbR5NeegHi6OTVloDYFUySRgtdqQQgPa31X6PGJN5SVUUZAnkReF5LyEMu51PMnEDe9yUA0UN4LoRU5Pe/wM38MSulsUqm/2h6CFW2JfPvIH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498077; c=relaxed/simple;
	bh=CPQt6G3cRcdkpJT2t7f4bgnXAnncd4uU++8a5gjFflo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKwhpuRFNxfxfV2gZ7eCaniE/2bdMrib9sNT8eRwewIzsCj6uyCjW/1kS1Qf+HOtGBpfFsrN283Wlo1mVhSSoc50v37NJXpG+qrPcv6bRWTF6eIPWpVOAa6JeyXT7kFzxTbrNuBv3lGurZjQzjxazXiLVkiA77DJE8p2GhDU+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k50yKbuQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593BIG74025234
	for <linux-kernel@vger.kernel.org>; Fri, 3 Oct 2025 13:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	abZcAT0FJVtX6eklnxdubzS8SY/WAiVnDQQ4d4O2Svo=; b=k50yKbuQQ6Mlk6uA
	mURXusV6uH6zC1NcDgVbgW3xALDhecuEhyvJOGdNtjWUGXaCh64xBZaEr4DRu9hd
	vp2a1ZkhhctM+xxud8ufWMGKJcf5136IdMaM+9nj1G7mIFWCs1gAJBiLpI/e6EUD
	cg3/sU9pEo6HmfcSCgpZ7sP+HBPv5b7pHKbHmQxKqcUpHlvp/CnWcAyHQ11mqHaK
	+6KdDE/KZvRUPpH06roJ2HLmTdknje5N2ILFa5FxBeet9oBs8K9IS+VQgCHcnvgv
	m89NGh4567wgawBdn0MJeaBu8+t131msbQade8TUVcZpx+MF3A6v8zjmGMyfRYHS
	HlxgXw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e9782pyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:27:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4deb3bf6b2dso6334401cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498073; x=1760102873;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abZcAT0FJVtX6eklnxdubzS8SY/WAiVnDQQ4d4O2Svo=;
        b=fsk3nqeqyvbNGrpe4muF18W4X6GoC+zWBr6uXOVYmSdGtsP+Sy9p2QCa/RDdfg4b1Z
         kGXP1kb9OITkE3HHOdt3sdLvLg4vGZcBXFPaQQ8UD+kL8QkoglxQWIi69lh970qEzNy+
         FY0Pz0T36Rp5G24k0uMm/T3g10UVlHabT46hkl7PeSKRON2V7hVmJ6kIUhuh+BkENozL
         kRvYD6LUT8nzutvRGpvvhrVGgsEEJGWXVb1rvxcnK4COuCdskuncKP0I965PRn9qbenG
         OFZ92JP5ZZ+6lrevrxfnuh0CGmpa0bC5e/s8pUtaewzJmqJUJoECQrMiauiGmIBdLq4x
         bsfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKP5oGrLvO+jORWbPSAEyYZMoIF2CNnhoXWwABwE6sIvmfv/uQN9VP6U7m9rndfD2ZMTutCYR+W6Hl2wE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtKus+Mw79l3ek7/iGL3Ohc83yy/ih1x58iQuDHToaB5dQMQM
	RZrgh2iqeWIaBJ3eR+isSLS8TmuOK/Pd4Hie7FzTd2RHrdMVWlr1Cjj5mWRHADnm4xu9WfNIyWj
	BpMGMZYV6s3Ko0ipePni4JPQZ2gj2/BtTwGrG6hMsG7cTIgnvlQ/rJpUFehy9hqXwv7IuZADJgR
	s=
X-Gm-Gg: ASbGncv41C2BXzuVtQRlnIkXTcehi764gzxcViQYFwRkyaFkR8XRMfZBmSCr/txYyTr
	aZdUuoQj6BTy351Xew1jjEd3aooBRNKqD29Y0NgIqq+xWWw9feq8u9yZojdTocu65UFFzZFEB9f
	hM6B6DNg1zrC0MPlyvLQy5/IPRo0/D9kB8X06GoJJ+zliTVxaPydbc3Ffz+h+Bo3dT9a9FDdoy6
	Q/vGcucyIacsKE0N5SHte2ZMM7/90fA0SZfbnTITGsB0zrlISURdLammc+MiQChk2ED4Mp51kNg
	no2nP2X44D20D08vMdtPOYhpNky4lNb50Cz+1cs92PCEgoh2ciUEn/K9piUj9byKtWSm225R3Vd
	/6yXZkN6MgzPz+8TL/MfOcf399HE=
X-Received: by 2002:a05:622a:2cf:b0:4b3:4590:ab6d with SMTP id d75a77b69052e-4e576a6337fmr26891441cf.7.1759498073251;
        Fri, 03 Oct 2025 06:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFB/AZh196wclx2ASlNPW2OGy1r4BomVRsOSsm1WT3mqwyaw999VPI6Bpkg0sVz8dKYmtaE+Q==
X-Received: by 2002:a05:622a:2cf:b0:4b3:4590:ab6d with SMTP id d75a77b69052e-4e576a6337fmr26890791cf.7.1759498072381;
        Fri, 03 Oct 2025 06:27:52 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa035sm434817766b.15.2025.10.03.06.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 06:27:51 -0700 (PDT)
Message-ID: <ee0adfa3-f042-4d2a-adf0-2c5d84d79cd8@oss.qualcomm.com>
Date: Fri, 3 Oct 2025 15:27:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: lemans-evk: Add OTG support for primary
 USB controller
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251002172946.589061-1-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251002172946.589061-1-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QYeOQdjyzhcokxIq7qtQTjqkb3Z-k74S
X-Proofpoint-ORIG-GUID: QYeOQdjyzhcokxIq7qtQTjqkb3Z-k74S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MyBTYWx0ZWRfX+i5GdEASPrft
 DQLENBrLX8Cb0yQ8VP2yl83YR4g/QbPDS63fhSrtMq7/BqarfdIhnD2y38DSE4qsa5MXLV3VFIM
 Y4vk6NXjWUFYBe8KOIKPPJCVBhtxJYz26iuQQ/UnknG0fvFNMuTjHneO6aup9o6gnbx15PG6Wpz
 5KZHLWp5gGxhN+NM5xad1gObyifoe/ZMhasresD2BBW8A48+aG+Ju2z4kLL5KUlxrQrmm0qLW+1
 3iWvSk5Hqqw+zHkumXfNuoXFRO9mf84NEn1p6TcwVSrQ66Z2StH3eswTdNKLo6IyV6mVG/EfJbJ
 bFYlj5oksW5pyL69eb2lawdzf+/x5TCQNWvxilzc5bdf461cXuMuIJhbdHyLLt91ScoaSZXiinZ
 jnH2snncAhyD8vF1hBg9oGBaMZDs8A==
X-Authority-Analysis: v=2.4 cv=Sf36t/Ru c=1 sm=1 tr=0 ts=68dfcf5a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=VtSu26V_DIzdLs-5mXgA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_04,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270043

On 10/2/25 7:29 PM, Krishna Kurapati wrote:
> Enable OTG support for primary USB controller on EVK Platform. Add
> HD3SS3220 Type-C port controller present between Type-C port and SoC
> that provides role switch notifications to controller.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
> Link to driver and binding changes:
> https://lore.kernel.org/all/20251002172539.586538-1-krishna.kurapati@oss.qualcomm.com/
> 
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 122 +++++++++++++++++++++++-
>  1 file changed, 121 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index c7dc9b8f4457..0b6d8d2d19d6 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -37,6 +37,32 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	connector0 {
> +		compatible = "usb-c-connector";
> +		label = "USB0-Type-C";

Are there other, non-type-C ports labeled USB0 onboard?

> +		data-role = "dual";

power-role = "xxx"

[...]

> +	vbus_supply_regulator_0: vbus-supply-regulator-0 {

the suffix suggests there are going to be more - is that the case?

[...]

>  &usb_0 {
> -	dr_mode = "peripheral";
> +	dr_mode = "otg";

otg is default, you can probably drop it

Konrad

