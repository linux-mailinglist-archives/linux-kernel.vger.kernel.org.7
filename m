Return-Path: <linux-kernel+bounces-832214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77153B9EAA3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D067B7C27
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB922EA75D;
	Thu, 25 Sep 2025 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g9ucXa8H"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4072EA744
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796192; cv=none; b=WeuLbdI7GCYNOtGiJksLXqjVYax65KQ09xtvWg84K2ptLqc7bNchzYObmaioKoKrvTf387nHLoa4MmE4lgdJQadJWVEIsVVvmNZIIFjrPA3TIPbnqv5DDjX4mbagi6sBn8+uDJn9bIdPKBrI0Uam1wfrEi7diw8kRbJk8HeDuYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796192; c=relaxed/simple;
	bh=TOVIvii7Y+/fHksY8cfxpnbQC5EaoegawZX7SCCmyNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWSECK4ogQLbPAxgKKJyd/wJytSGUveMahcFapzstCoOkkfyzcHH+zq5SX4EexAsEJh6sSik8Kwz7jWRx0kKP0DVOWU0QoXIFDx+XdoFq+mN6VMvnS6kWol2Sir4dfn2JRRHrPgT68Isgdl9Gazgd+pea9FS35bLcmu8qu0XBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g9ucXa8H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9YPZB019923
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cINWb/EfZrcBMNf1EJaMOvrua9MemQAuZDGKwXABKpw=; b=g9ucXa8HnZw6bZ34
	sK5zT73mIIHQA3oqKyVJAZeoT3FLVm3LEItrDrAAkwOXQI8lOQw1LxNOHpfma9WT
	7ol4ls6Ujo3AwRQP4+N0k6sRb6zuwtKhCry1VWFPpj3/VyScJBLeifSqKgrLBxXP
	5iZeBP9ahXP/mhVKoEegf2p9owfI2yMsQOqqkGQFpEQStUMb0KtnjKWixzZBtYcU
	QrldhIG20eQhLC4XK8rtHOs2AfLXflktBSgURwyqvOgjURkjVrc1N2rWq9RRAfre
	0SLpfuqbvRmg9HSRISbT8i/pOd5ro10hB/cNVkhh5vhN+2vO2pe4JdPGq2W+DnlT
	0Im4iQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpe0ypu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:29:50 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7f4bca2f925so1947246d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796189; x=1759400989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cINWb/EfZrcBMNf1EJaMOvrua9MemQAuZDGKwXABKpw=;
        b=ThRkOZUv+YQ8zpAcAov98HzyH9x3eeM0eplH9uWbISCc7lEMyumvOKtc7Woob2sLB5
         c+jLTLdiBFNKif49JL0eh37S2ZOdClVTEYz78f1Z73qxE+xjWOc8mqYFC5Y4iCH9Ehus
         OXnEHuT4Uece4oAD8OZ8hyEshhihiNLfVzu+6YibbE86l0fvxmqryGaY6GLEbdq1jA6S
         5Zf+zadmSUnlfdfd6Paa/iDaYiKcchHK7vRIYl+rjeNWAnpzwYe6I61Xialz8l3WnMM/
         8eMKCpJDJs8TH7uW7HvWbsIwm2fWa7LC3Cyqlda4P7rFEbj9wgg/gjML91Adr/ppiIGf
         O3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWOuwcBOZpiXConpK/lYi9S9mfMFCusItiKGB2MeaLTpIL/zlxiIqL9Oug108S7u8qQQQLSY1lh9BBgO8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrA2D0SPaQG/F0kLa4zVj/CDnbtZJ2KZIJfMRRaR4ura1c0tM+
	uYI3aTkv1NFb3iQT8x1VupZmLSnYAdRI4+p4sXR1n3ITPP2YNx1Jj+zwnFug/VeIgcG+4yrVOOC
	U9y2BgdySbK9YIL+IzlVQe5MVS78ImPdEAnxPTj/S3UKQwDYT3jPEVdEHG5njl7eNK74=
X-Gm-Gg: ASbGncshEF8+kM4idA+us04TuzlIg/JfI7MGTF2Xwj40i2apgv5YQ7Evd5kY6BhXnEL
	SoPZ4DVBFIT4KpcMiGri5cIO+Q0w8BJnCWEHtNDjkLePL3ZTgzIFeetRlXqEc3xgonax0VczrCq
	5ucuJ1XUHXOuya0PQ5OG8kXMvUTo41Gu17iyQiUx9gNDoOQRtQDMKGaaNMARKdgcyXNB/fo1RmP
	n/PkDGYDsv11aYzKKTcLn4MbTrecU2ZGM2KvgwisDrStb/lOSSjUoU7gFMMRdJL0rqahHtB06JA
	rDW3vzqbMwmavasc5b/i1FIAad/I9nVI5MKTqkH3N2wBcYSQ1qoBWYZ6AQuQrN5EAHJcb1w+09v
	0Mbft3Kl7DPC6vUJMYjf+6g==
X-Received: by 2002:ad4:4ea1:0:b0:783:fd50:70d1 with SMTP id 6a1803df08f44-7fc4bd855a0mr28410456d6.7.1758796189134;
        Thu, 25 Sep 2025 03:29:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfUZ1axDjavEiotUBgfUS5+hpdRhC2E54662lQVRJPJyv56Bjey2md5A38GS1xCzUTKL5AXA==
X-Received: by 2002:ad4:4ea1:0:b0:783:fd50:70d1 with SMTP id 6a1803df08f44-7fc4bd855a0mr28410116d6.7.1758796188555;
        Thu, 25 Sep 2025 03:29:48 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae2ff1sm988287a12.26.2025.09.25.03.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:29:47 -0700 (PDT)
Message-ID: <fec06b27-637a-4923-b07d-1f0a1fdf4922@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:29:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] arm64: dts: qcom: glymur: Enable pdp0 mailbox
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-6-24b601bbecc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-6-24b601bbecc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7YJol4NwrgQQhyZKvDy5ewyQXYu7fc1R
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d5199e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VX93quCIRNpU5PVMXlIA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 7YJol4NwrgQQhyZKvDy5ewyQXYu7fc1R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX735xqfs1v5sz
 PAY4VKSORU1O8vINL5pTzkAwEKo2YKcQ7vpgNlIhPkwpe6UHsAZxjlGek4b7CZzq7BLOiq49Ckg
 Z0RwVzsXtx/Bj37Plg65opgX+cZsAvvRWX2Gs2p+CScodQVUmn4qeu6RJMsxzLaxUyatKdZbFCN
 8/2R/u6QLNeHRlq7WmMvo/hbph0WyyAylUlHIuxCchxbKfrAtSPzu0oWN0bBItciaBOTTHbvhUy
 wgd+P9qZIyvJuJC+pafob7DIjrAcifzVWo0srep8SrEDI1rXtF46wV30hHrCi1HkfDNlpMrbZw1
 n5tVt09sPgN/+ckiL8UgQEX2xHhqpYi025ZAdk1Qh73T1LE5mGloUNMvYMgZFjkh8gii4EBvSqC
 +IffOJAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

On 9/25/25 8:32 AM, Pankaj Patil wrote:
> From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> 
> Enable pdp0 mailbox node on Glymur SoCs.
> 
> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index 66a548400c720474cde8a8b82ee686be507a795f..ae013c64e096b7c90c0aa4cfc50f078a85518acb 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -4065,6 +4065,14 @@ watchdog@17600000 {
>  			interrupts = <GIC_SPI 0 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
> +		pdp0_mbox: mailbox@17610000 {
> +			compatible = "qcom,glymur-cpucp-mbox", "qcom,x1e80100-cpucp-mbox";
> +			reg = <0 0x17610000 0 0x8000>, <0 0x19980000 0 0x8000>;

1 a line, please

> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;

I see this has 3 channels, with 3 separate IRQs (but one pair of address
spaces) - should we extend this description?

> +			#mbox-cells = <1>;
> +			qcom,rx-chans = <0x7>;

This further seems to confirm what I found (BIT(0) | BIT(1) | BIT(2) == 0x7)
however this property doesn't exist upstream..

Konrad

