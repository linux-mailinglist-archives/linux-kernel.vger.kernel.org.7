Return-Path: <linux-kernel+bounces-844082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0594CBC0F47
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D52214F4626
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E272D7DE0;
	Tue,  7 Oct 2025 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q5NCVgyw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE9D2D781F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831432; cv=none; b=lIRDBgm70u86TiJdvURoNgvBiNoStQ4mKpQTsPJXZTWN8/LXnr61Q/E4H2TeW7rxa7ixCc30TYa/QeZhHBzc1b50ZphTaeJbH9J3vc1N505qj52GzGfWDVyq99HX2HhZrT7jUyCn2gQkVek+Btkl6sxhNpwvqsS/e3jy/OuJXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831432; c=relaxed/simple;
	bh=deCSUNbIDe5KUDM9hMfp0pEEzG+kiG+b21ccg2slSwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foSb5Jp5XqLTZLouRX5udTVejZeKfCkpOKJ0GMYuF7hkfzinLtvnVM4dEL1YHbP1uNR4q0i3t1brNNOYuD33CcPt9zLisJc3Rc3lfw7PnfeRwWT0qK8uCJubB3jusZt/kKGDoYuF9fysp29WXFmcYYLwhA8VGkSV0eTTZsVfZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q5NCVgyw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59789YAT017906
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 10:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f/lg14/r475DGELb27M6yUVRo8Ql/TshF6yOFwLnhUg=; b=Q5NCVgywT30LklDy
	PsufD/x4ImyMgiRyRIF4Kje/tRkngmJcULOZWAUlRyqbVaB4EHwo7LuYha0cs6kb
	4WGJE2YBaIINdE9BC//R+CfAGNG0qPt9BQZPpriiYMKzpbWmIfGDroF5xXgo3q9F
	OQoVxmu9wT6N1f4PEodHIa/4ZL5rJykwzRHjIiZpG7QaCf+PKMX88UK8T/2sTj5u
	D2EIj21q9COYRf1sfT2ulpGin4SFh30KUJSWlzc+QtLouop3IggUNOJsqjiBPYcW
	JNfFU8bpPJrFTmQZh4T99TN02x39FvQx/k6SdgAoHioKEsKDp6dARtpai9j1WkH6
	hnSn8w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mnkpspnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:03:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4d8c35f814eso13718541cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759831427; x=1760436227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/lg14/r475DGELb27M6yUVRo8Ql/TshF6yOFwLnhUg=;
        b=uUFt8Vmvp3oDrYsPGroi/jXZSnEbXGPLAMzc27Cq2YULdiMydQTn1SL/WMObwwBGka
         PZtAwgJfkk3un02TbNnhzPPF7luTN2zhCLsamtYK5G5zfIPIyPvrXwtjJZIC5nzfFZtw
         Q9+pEI6zuKNAfUE81mnovn3xSSzzkF6LR0ULIzQex5fNqlNLKAqHBBIvlI+xrAFG7FaN
         ykP8PHUQxHKtWQiqPLeIMDO55jcHwJKgpbqcwQg4Sh+LY1iZ9owVhdU7lJEyaFNEC5k6
         FuQZHyAm4WoiZaa5I69zWOXcFNnAVffmH/zTVqgwqHBD6iZl++8DVDWOVq4AkecSTvAV
         cETw==
X-Forwarded-Encrypted: i=1; AJvYcCWarNGtAUQVnlLPUNv/ZiH4ymnh0WcWEh0vnNU8b0qTVr/lACdCjnJ5qu5c/Ovi8TEp6rTt/oQIgTeOPqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqzA10I70eQakw4ERZwk0jFbXW8Dyr2UL7ciHODiv1nSUwSxE7
	JruUyI8lwsWyPEDA0MLiDFSgJ1nP2USitYeFwqiFwxrIt1uzyMVKbcwlxzd3MjJiueS6Bkf6ajQ
	LWu2OsyVS0DBBBJ/AQEkzw7476WreYSFQ2/SVMdtMYqrQ2DnsQOVoINlxWe781QxprEI=
X-Gm-Gg: ASbGncuKJVinlAFHVV9l9ONnqQoLzjDL79Ui810B/WJPlL9xg8nBut/8G51+1BRdRZB
	VJD8TAy7vGq+NHA8ELycXL452gEdNamz6bNotHAV4YSMbss9JM7ydCjfAaPFnqI4qL29ZvKPu+W
	Ceq280LHyy6CaSYL+zs+Xh6/B13rPGVFPLlOEVM/IbjokQbaQ7KKSlx1qWIzrozJtZE12Otegu4
	FN7cyK7uOKmT6omDYBf74NnIdA7QVOVjXe+a11QPcPrUKOVJJyNo+Z/o/KI76fHTTZsWRU5JMji
	ISVT7H3araq4JnRsGzkfVGsCg7JkicjXda+7KH5+SgXz7DSa1MSdDPRMoQQTUWrizOr7vMchjHn
	myZzOf6eW6LDi0bboB+G/mwTqa1E=
X-Received: by 2002:ac8:5aca:0:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4e576a98c02mr133841581cf.7.1759831427306;
        Tue, 07 Oct 2025 03:03:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhzCL5QidiG6adlmbwtbxC1CmvVbnE5VzUbfzHUGrlHgHy+0vWMRsnW7JAlRR88W32mvagWA==
X-Received: by 2002:ac8:5aca:0:b0:4d0:3985:e425 with SMTP id d75a77b69052e-4e576a98c02mr133841321cf.7.1759831426898;
        Tue, 07 Oct 2025 03:03:46 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869c4f314sm1340878266b.69.2025.10.07.03.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:03:46 -0700 (PDT)
Message-ID: <99bfa340-2164-4df8-9953-e65f9cee7709@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 12:03:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ARM: dts: qcom: msm8974pro-htc-m8: add NFC support
To: alex@me.ssier.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Luca Weiss <luca@lucaweiss.eu>, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251007-m8-dts-additions-v1-0-53d7ab3594e7@me.ssier.org>
 <20251007-m8-dts-additions-v1-2-53d7ab3594e7@me.ssier.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251007-m8-dts-additions-v1-2-53d7ab3594e7@me.ssier.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Oq4wbDMXxAApp9H4VLXFvkdfDnqAiUFC
X-Proofpoint-ORIG-GUID: Oq4wbDMXxAApp9H4VLXFvkdfDnqAiUFC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE2OCBTYWx0ZWRfX9L1shjUuvqcL
 ei7QbxhMos60eG+OMx6V3hxUHL9ziF0H8sW27aV+8lACvXwGXwK18yeL85dTq1e37LrYnC1EbWy
 1addrmL7EVUKRYLVRkHkMLmcowoVXFEobQlTskGq9MUUDbYR2tIyOS26XHwZVSGvuj2wCC1mLMf
 5LxhNMtgNIke48jVxz7RX12tdzVEmY0fCDPNa9YXyRgkSqs6UyODx/p+v6v0EmiSLLOQWiV1A9s
 hD3PdrG/GBf4fSqxzkNCJYaQr6hYzPp0RfV5La2Y3BPcQl7Xi8Q0vOYDjeCI2gAPS8/B0W+PkdB
 xHQcFOqZ+fkWJHb6pOPDeRcX7BPNnI9Kjnb/2jFfN467TNEFc1jnyzvMqd8lECpH9o8kqyxbjlG
 yhlGclK7dnQ/hUti9jtR6xlK1XnukA==
X-Authority-Analysis: v=2.4 cv=BuCQAIX5 c=1 sm=1 tr=0 ts=68e4e584 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=8poMKPHdAAAA:8 a=2dNuJvzwNQBdB-WvFZIA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=fyZPtLC9JlAwSkJ5-iUD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060168

On 10/7/25 7:55 AM, Alexandre Messier via B4 Relay wrote:
> From: Alexandre Messier <alex@me.ssier.org>
> 
> Add the NFC chip used in the HTC One M8 to its device tree.
> 
> Signed-off-by: Alexandre Messier <alex@me.ssier.org>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts
> index 9c3859069aba..4026d6fedfbe 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts
> @@ -65,6 +65,22 @@ vreg_vph_pwr: vreg-vph-pwr {
>  	};
>  };
>  
> +&blsp1_i2c3 {
> +	clock-frequency = <384000>;

This is not a valid I2C frequency

Konrad

