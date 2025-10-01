Return-Path: <linux-kernel+bounces-838605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 726D9BAFB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F178D1941FF9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226DE2877E2;
	Wed,  1 Oct 2025 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MdaUvYks"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F8F28726B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759308501; cv=none; b=FrPWB93nifoKpuRN0xGIi7GMitpaQ9yx9JTxyfeMn+tiHkdJAkh7TvNqZo6vHOYrY9wZShmpJF1jSWX67K4+TE/uj6bxdBpOzAVR8pBk+H8b9QUJ+G4yeNx6W8LreNVayTxi4So+BkaPPnyVt0kT8JA4r5vZZBMvo2cCw3o9cVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759308501; c=relaxed/simple;
	bh=cnYoKUY3HNF+KS4o9k4ts/NW154cLa0Rejq1ItDkND0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F4mX3ZMUnHkfj/iG8htlENnPfpLvyoShN8DeawhlKX7uZpHRT8bEa/2uGxjdMyd8z+msxN3BxoHA9np2fnYawOdzP5U2PLYDXNpT9b2Pc6ZULyy/MlsQyWksI8Brejb5FhqUAQh5bmID07F/dRCsV/9BPO8omfqwrzGWX5uRyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MdaUvYks; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKoq5F016883
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 08:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IvoGteqWZO/DNKSiamDYflNR1kJAs4QLzd699paRsik=; b=MdaUvYksRMISOUUn
	c3179kep1t8NM7nwGVHUdOxg1FRsaIpy+4ws06F1qSYZZfyTNxvqLIXK7ZdhXC4+
	PwzdJHTaaJgXdH/+SQhQuA2gK6ONlWLRVIHEXdDKHh7/76oabjgPtHRUUj414P4T
	F7cJqG8YKKH5IN4Z1KYfefBMFetVBW+lvwYeXtzwdy2zOerOKDrNf25PSf82ke5K
	9tqAZr6fOrtCl8zr1AE+OYm/2Elxadv61Z/8QofPFgckrjlyYrSyLB8wWt+Q5R7e
	mgN6FURL2QkKhgIr8ckY59OHwTXHB1OnWvoUpYH++p05DO1KUXBBWm0FCRO8zXkE
	b0rdtQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e93hkmc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:48:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dc37a99897so13895481cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759308496; x=1759913296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvoGteqWZO/DNKSiamDYflNR1kJAs4QLzd699paRsik=;
        b=UuGx4PNCMv8gtF4Goq/KRRfvXWq9HlVzGoMw08u05qV7uD50B5SkXJ5MWU35KhvGVC
         Ip8LWj20NahCNtI8Ur1L8lCQBgE7NR6W3NsiUDQ/JFndCWCS6dKdqE011uRDJ01483KK
         dh+24stanZgidStrJNDj66I7e7f9AEMWrJqBSFlh7oG2jZF/MZ22/COVdl8y5wQ7dF52
         pBv5DcNGzP9DwCNcH1Zw4dqBFPef1DvSP6wyHRoBwvgj6p+hr5TLqYaTBZ9bgsqHeeL8
         k0+WUxd8KxP7aYHsKZjp9iMqBXZffDk61/71gm8HH1csy5g9RbrnFrA605WMD62eIxRd
         RgwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKyPk5lg3yuk3E0ZJb7lEl7JnvtbkABqqmQbWouiOL7PaKFg25WGKwEvNZMVYMzq3kZO73B5wlD5o9hZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWfCN9/U68oK9GzK3Vy4i2P+xjOyB+jVMFHnq3SMZuk2jDM6Yr
	f/mkJxihc+XCGwabYlwyNe7vscwwpruDiouHGC8PntCa5Q6oqoa2G3TqfA/Cej+RsFEwQNwehS4
	VeLpXz6f9nyrcVinz15OqjyJNrSHOX1dwimVpw71KS+rGwIyx01u1z2bp/WVh+9e2QWM=
X-Gm-Gg: ASbGncvHvC+GSPs+axhmXBP4sO3ITtQePahUJwMnpUzLemghGaFZSzaQWD+5rAwU9N4
	YWZ0XBtkDRRJpe16X2RMFApoIfoOvXNC4ESUsOwhGM1CMldHCCmZSWNTLtatxo29YH+8sPH1t8S
	9jeZJWuPJrO2y7NjWpAZShjkhgwFC1G9AiSJXk5PYyfETtbulrwQzEO4w7Kd6Hk7vBj6BLrXazO
	kIKm1L86v/tmFBYIOpG/2kBH5YsXfoikQL3Gz1I4pqgFI+c9TRhxLlt/m/1ZxrCdTitvGbQPHE7
	XnKvFrOkz1gHpwQ2h0k4fxVnGFsIIxjlMmxCU1RtMnIAaI3hu0mIslAaGnUv1IjqRVmoV4CvgTy
	pGfyUHuSPCDLC4B5Ot2dTiza8ULA=
X-Received: by 2002:a05:622a:1905:b0:4d9:7eeb:3f76 with SMTP id d75a77b69052e-4e41dc85fa8mr23565671cf.8.1759308496463;
        Wed, 01 Oct 2025 01:48:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA7X+FvOsVCp/d2YehDsp16CTMKaYRaFciuDgavARc4hbhk88e8MW3DkaRiSisxhPZklkGeA==
X-Received: by 2002:a05:622a:1905:b0:4d9:7eeb:3f76 with SMTP id d75a77b69052e-4e41dc85fa8mr23565481cf.8.1759308495920;
        Wed, 01 Oct 2025 01:48:15 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b401d3d4124sm517238866b.75.2025.10.01.01.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:48:15 -0700 (PDT)
Message-ID: <425af7b2-2195-4a18-b14a-7b2871563b12@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 10:48:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8250-samsung-common: correct
 reserved pins
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250928044533.34798-1-ghatto404@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250928044533.34798-1-ghatto404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDA0MSBTYWx0ZWRfX0CF8UamFuqWv
 QQA7lYkY4AMpJkBU3Y0dx9FxxHCeXn6PkL9dD/zF1jKp5NNdZH+0Go4Oo6QTLtHoSJFF5fKuenp
 STRA2bnH+Ndfqvc4KflM+T6NB+L0yE7JZ6UDGDOcfyIXHH5LC8Ki1FSeKj7S/8fh4qjUBJV13UI
 fTnvF1RHFBxlLsvrN/4lis05zFjg9T2S0+B97Aa40qYo98/zFzSa9J0xowp+WaSZURkKdb++/kF
 srb+IDUBsnZsqJlX32QSTM6WmnfbBDQTLeE3bjbB3oibF00GKlwkhyqTMwrSygaDhy5v+bX8c5j
 V8PYkzH8c+8UmAb14EcJswJYxTWCGSU8hbkgiBKalMHsSpniN1ASiM870tuylF/wBqRVgyWa72u
 TnKts0x4UbUQ06uMPPTn1/mwWzD0cw==
X-Proofpoint-GUID: cga3Ncvc9rsLtRCGJgls9ZkFwT7zjYpt
X-Proofpoint-ORIG-GUID: cga3Ncvc9rsLtRCGJgls9ZkFwT7zjYpt
X-Authority-Analysis: v=2.4 cv=Rfydyltv c=1 sm=1 tr=0 ts=68dcead2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=wVdH400FnCx9Ju2W5JsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270041

On 9/28/25 6:45 AM, Eric Gonçalves wrote:
> The S20 series has additional reserved pins for the fingerprint sensor,
> GPIO 20-23. Correct it by adding them into gpio-reserved-ranges.
> 
> Fixes: 6657fe9e9f23 ("arm64: dts: qcom: add initial support for Samsung Galaxy S20 FE")
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---
> Changes in v2:
> - Fixed the formatting of the <40 4> line
> - Added Fixes tag
> ---
>  arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
> index 96662bf9e527..a87e3d23e3e2 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
> @@ -159,7 +159,8 @@ &pon_resin {
>  };
>  
>  &tlmm {
> -	gpio-reserved-ranges = <40 4>; /* I2C (Unused) */
> +	gpio-reserved-ranges = <20 4>, /* SPI (fingerprint scanner) */
> +					       <40 4>, /* Unused */

Please set your tab width to 8 :)

Konrad

