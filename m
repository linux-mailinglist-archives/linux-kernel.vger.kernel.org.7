Return-Path: <linux-kernel+bounces-838657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C17BAFD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DCF67A6D11
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199D62D7DFF;
	Wed,  1 Oct 2025 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RCGJqzEz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188BD280A51
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759310401; cv=none; b=pWm1NDvZs+PuNdJhR4725fpOC0Fx0JHKnHd4I8ugaS3fAWGwh8C0RYCVzpamsmNnrsSIbLifNGkmEaauAgKhkNk9Yc6eMVz1brqrms7XKy/iG9cyd3DLJDGCc0rGCYLtvB9llG5xURMVH6NGAILxP6x0+v5CBRi6/mrB97EHTUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759310401; c=relaxed/simple;
	bh=xUbLsE7+b/6DcdaGkzKeBsXAunvj6ceqqBajwg4A+rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8h4+2BnX0S8XUT3m/LTgpyiqKVfkl+bS9hlz94QoSNEZN5GJol3+9c3wmJPiblwRk4ULWOfmPwox0Qe+0luFQ9mVG+YlD0RgN565JRsDWla/Nt+ciff8KZWEfQlKhM25sRoRdK4ZOTI/80jLEUuyMBqzEMnS5DjJJMylzbomis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RCGJqzEz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ULmapR030546
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gob+/+Jnh7/czqlbfOovpHjo691+sHroBwNdrWojy3I=; b=RCGJqzEzeu85fd7H
	KV9qLaSeXcnjfhEnYnUK9uEeUfhGlzTOnarssIYO+/NDP3AAP7C0H3bqg4tNztNY
	jOkcabBH1GY+MDdvSOESGPZG7gYXelBjGTduG/Wr857T3ukUFf+7WALKN6omK1TH
	LvLIxiJFfLn7dqOre2TDnONai3Ly2+vvMeugpT7o8uUBiwz4F26h4GKozicJyVlw
	ZHj5UdeqWXM656p77+u0vflVwu2BHevXKYu0m/zR5SoDzrdstBlKn0Q372QlEcMX
	QMPxiJ3+78mLD1q6pfFqilGi0JvHUGUUua35noTmN/8IOmZVMDFcbok+2lYbOp5B
	nZ4W+g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdkr8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:19:59 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4dd729008d7so6607991cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759310398; x=1759915198;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gob+/+Jnh7/czqlbfOovpHjo691+sHroBwNdrWojy3I=;
        b=Dg+o1Cphhj/3/jfjJODT14DlT1Tcs1b18VtMDfoGbCJ9xNps0nJBHvfU9HWnZI8pNO
         qvxA3Es5rufPBxbOJzmwIx5am7Ym4fPIw3T0EMRQ/vbk5P05mnj7tJi+RVhNnA2UmNtZ
         +RmQvLaEYb+hOfad6lxXspQLEpa5YPMUDHPU4sW3nKXJZuJtdK242rgnnYRk5tahbqaU
         9YagpsFp5Bfq92KW1waLfiSfA2AG/PzY+pCG2JFQgDZHjuHUMR4oysaSQUGeLi9x8rL7
         7ke35t2OJHf+OlcLhHUVrBYoXK3XOR9lY9SWNjRCsauL+nEOsRHkriSAOQrQVtPPusrw
         Sgnw==
X-Forwarded-Encrypted: i=1; AJvYcCWFnOE7hkUpNA5SonIIWPp8sXneanF6bTx8epcRROSlzv1t7kPWXFLBvPgPnTutXghXSHWm//Ulo1hCVeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo7gHZAIVfs5bChCJSJH+vlzOvDpjzmlVcxJAqVB1ljyPBorkH
	f1xCJgifz3cIaIT2Zq5e1n6S7dBSnRfZ6+JAebHEZA5hbo5/CN3kvuP6U/WdnkOOnPOJcBU9wWX
	HwJuliXgsl9wWzmfDKAbkpPqnJ/yKFzGgMfH6MOq9DKH9L/I2M7I+zj+c9QROB2rzcDNffIMG3e
	Q=
X-Gm-Gg: ASbGnctBH9uSWjV4domk7xjJT0elvHp3F47J4vnYFjE6vM4e0q9KoFkaHtJRQqlvigg
	sfFxpx3HBMFzAXAfTE3g1SXO9hq7Y9l7Ix1AdpfC5vP+SpaFP4MqNf9nUjMhHlwv6RUewlrzZKx
	aQSUNogKF4YAvIksC7Vs274OoVdsP0PaH7jARfBUN3ShlGkIqrn5sjDg61ef0214leKyjVHwD8A
	hWc4le5K7NKpgyAv6x2LHQvt0nvzV8dsE6EgGwbtRTQPM9v+X6PC/G76wIPfL03T8AXYiRDV0o3
	zDacCoNGi9E+S2UVWkVJWBcEob3hTYxOCXk3YH5nurYsX42aPz0JIiFA7mGBs0qdMmwxJxxVEqx
	l+h7PlMH2ln4NAkihEX+AoEpXd9A=
X-Received: by 2002:ac8:7d0c:0:b0:4e2:f1b3:346a with SMTP id d75a77b69052e-4e41e256f17mr21153341cf.10.1759310397736;
        Wed, 01 Oct 2025 02:19:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKJoQUQsWf73fTXk+gDvPvLLj3Y/I7IdgSFwb6X+1+mfUxdCGvdvgd1iqFUC8eGAWzUp8e/Q==
X-Received: by 2002:ac8:7d0c:0:b0:4e2:f1b3:346a with SMTP id d75a77b69052e-4e41e256f17mr21152961cf.10.1759310397254;
        Wed, 01 Oct 2025 02:19:57 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3f7b67b883sm553368166b.79.2025.10.01.02.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:19:56 -0700 (PDT)
Message-ID: <7ef97ace-e46a-44cd-b632-eb7b699c20c2@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 11:19:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: sm8250-samsung-common: correct
 reserved pins
To: =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250928045817.37384-1-ghatto404@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250928045817.37384-1-ghatto404@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LKDrWpxEh4b1_mik0D9XFmLqw8qrJxQj
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68dcf23f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=3bGHI0pndnSrP7k9S98A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: LKDrWpxEh4b1_mik0D9XFmLqw8qrJxQj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfXyMRWCDyKf0iY
 ObgO+VfTKxlCDQd3neJ0bYwyt5gXaj5IivhXr/LQdORPS0q1NSYzKYJKLoawwFQk87VqZ1AmmL6
 sbrN6kUSAnSlJLDi29Xxv2nfKLVZ2rzOadA9zFjubYRkFiHf7NAh6oPCYwExTOUMHZmj76Kf5wO
 4mvkmS4l3/RNyBuYEG09Yj8FHdcNVgwYtEDVipaEovk6pNrndaeLDyrDzqZKE/niHEHTKltGhhJ
 zYV7Q6SmtQKZSDU5H80+3p2nnWuS9fhXHO7IH1I7hGXbTQmgH2F7+usOiB0k9Nq9v8NmCMRuq8t
 WCUstMQ1B9D4gyhADmeNax5kyFXtJ7IE/xJQ2P0KYhr1U+EG6QDSf+udfGMxfBOpwBnukrkQfB1
 pOrpQzgc2ABYB6/YAqcfuu5OGz2Nrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036

On 9/28/25 6:58 AM, Eric Gonçalves wrote:
> The S20 series has additional reserved pins for the fingerprint sensor,
> GPIO 20-23. Correct it by adding them into gpio-reserved-ranges.
> 
> Fixes: 6657fe9e9f23 ("arm64: dts: qcom: add initial support for Samsung Galaxy S20 FE")
> Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
> ---
> Changes in v3:
> - Actually fixed <40 4> indentation
> Sorry, I still had my editor on 4 spaces a tab
> 
> Changes in v2:
> - "Fixed" the formatting of the <40 4> line
> - Added Fixes tag
> ---
>  arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
> index 96662bf9e527..7696b147e7da 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
> @@ -159,7 +159,8 @@ &pon_resin {
>  };
>  
>  &tlmm {
> -	gpio-reserved-ranges = <40 4>; /* I2C (Unused) */
> +	gpio-reserved-ranges = <20 4>, /* SPI (fingerprint scanner) */
> +			       <40 4>, /* Unused */

the above ',' should be a ';'

Konrad

