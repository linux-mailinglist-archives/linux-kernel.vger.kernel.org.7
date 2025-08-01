Return-Path: <linux-kernel+bounces-753447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD5AB18328
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE367B8D6D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9A0265CCB;
	Fri,  1 Aug 2025 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oUHuZ0Rz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E19248871
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754057026; cv=none; b=LGGi+PtjsprWmkMsjlR1Jz7L7K7z63Y3AsNt69EtXlHZ7/Zi6XDiGQWM4yLnnVpc2Hi2lY1DloYEkK0V5o21vVYdY92ziLWsM2x/5uuLPwpCEai16NKf3qe6jDsT8s/WKjSLktg9Htk5g07wCoUDZ1h8Ollsy9qmsPT5vi1heo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754057026; c=relaxed/simple;
	bh=H0ySXzvDbuoWs7r8TGqzxLl3oxORf/aA9p6f3Jf4ccU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGHS+7/PbRYFKhLhaC0Rt/kjXBTgvL9jLvu3Gz98fQArOxyvANO/Bu91S6xsuiQGeT88rSWNEnjc9GF1azB8ICd6xhTRqTv6qTaZ6LNwjwY3G3WKB91v4lIjQPZoZvxwFSAudEmN5VKY7abiwoUCmo7S1ngaktEcshSLlCjced4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oUHuZ0Rz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5718v3aB006881
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 14:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ku4N4bPFyWj4gyqNPk2SoqswYtjh+OxCezwK2kazDYI=; b=oUHuZ0Rz4u//HTxw
	r4wqWkXnzLwbX7kbEO6hUaGP3GUbbfWS/MKTVZV9puSfAKQjR8fySBYonmFkXrMa
	6RSNw3vERBBYFVlQG2+AMHUWo+ZrWkw69sCJOzbheaOrGyXliINiIK4Drm5pU7AA
	tJf2klSUKTcS0Crs3dacU6XtuJZGX0tJroP6YlJzzQdNLKFADC2cnfd9HjnWGKme
	hhzfKpmHULqbE755maFP0gTHbPwH6DV1ZDwjvclDdz6JaCDK+o99qo8wbRs6HqqA
	wDhDuhydRg7dywZ4GEKhG27z2WBFrZfWZ5cru8VIJmCONueEQ7xgG76NZXnaalzR
	DRT5Dg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcrm8rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 14:03:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4af04ff1dacso1522811cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 07:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754057022; x=1754661822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ku4N4bPFyWj4gyqNPk2SoqswYtjh+OxCezwK2kazDYI=;
        b=fSY1yv7ewh0FN3EbfMxByQy2xsVI+uDj8h/3AUpBV3233dkzYNUkV/wSAbaFCKdwfL
         d7TASYEewCGe0sdr24RsrR3REb3gQM5Vn8omkhWfF4L3+6BjwrThpy49+FeHw+dZ7J5U
         vLKqiE/W60a2wjcYcfF/vwjBUsLOnBtpbZBF7Jh1EWSa3OgMLAm18c2OQDeQJy2GlmoB
         nEq3hNONBu2X5ufOpMJCQhxrG7b+jMuj61xIR1/EfNjPUYY0z0pjMZRUlseBEB1Mk1ak
         68om2zokp596QRO0xIUGWrIPBI6gwCo64QTYAqjw2BtE/pKXjeUHs/OBPvvZr52HSFCd
         Py3g==
X-Forwarded-Encrypted: i=1; AJvYcCX5pN9IM7NgGhKU3duGkRzi5CjhRMfb9+m66P2wetaj62f8IoDtT1Nryrsy3j5th1JeeHzIOXB6+A7SfgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaeeTMJlMmT88SQyH0X051F5g8k62AGDLQ5w6fnr7BAGsVPjvH
	xIaP6Fv1xnTbD+Z8JXBFHHkz7g6z2N8YYfeOo2SmveY25lGvp5kU03JdMjTmoTs8jFbxLGFwx7M
	CxNK3btqtdzFXBVcwJMq8TNW+6fYWwqJMPMhcqTNR1LIhF0c1yttLtDhkmuhv6GMw0QQ=
X-Gm-Gg: ASbGncupvIfIa5vLEBFihDzQFg+2ls/i0W34y/zCMCzWAdcReGoaoln5NzagpSomSMh
	uMGirdAtHotzFR4S9o2UfruozFN25BkZEuWK9lcrJxnsaNSZEjWpTjWt5idz9OF8N4Xy6WKuzUL
	3YbKmixE6/IZcgtXIpNWZlmKlyDOj0xBNcFh5zqY1RqsBvNkJwnPdIY/eu4t3Es7UTv2xb6b8tI
	fIl1biL63nBUiroeukrKjmmaPxF/HIMIsZfOdeWI21sXSjp7KnYTipBTmmRvPHNzU1bUoPihVoU
	4U9a/uHKLU4BGY2rxkBsoar3LHovFTd40IXh+bCxeRCmPC+8ITSZl0qWYwxf7aEVM/zowQP9EZS
	PBuF8oEnV5Lu4skdQpw==
X-Received: by 2002:a05:622a:58f:b0:4ab:7633:c58e with SMTP id d75a77b69052e-4aedd5400d5mr81763181cf.2.1754057022089;
        Fri, 01 Aug 2025 07:03:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZJqOtBrMXyVVQfE+UWYMn4cGgzAWWjRieoBwwyqh9DqIDo0ajPxhm1mGSkLgOOIHkgPsdxQ==
X-Received: by 2002:a05:622a:58f:b0:4ab:7633:c58e with SMTP id d75a77b69052e-4aedd5400d5mr81762661cf.2.1754057021467;
        Fri, 01 Aug 2025 07:03:41 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a241bdfsm293472866b.131.2025.08.01.07.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 07:03:40 -0700 (PDT)
Message-ID: <445317ce-fe20-454c-a564-288372772b74@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 16:03:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable USB
 audio offload support
To: Luca Weiss <luca.weiss@fairphone.com>, cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250801-fp5-usb-audio-offload-v1-0-240fc213d3d3@fairphone.com>
 <20250801-fp5-usb-audio-offload-v1-2-240fc213d3d3@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250801-fp5-usb-audio-offload-v1-2-240fc213d3d3@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwNSBTYWx0ZWRfX8nJek3PUW5gZ
 uPg1ksH+2QNW/OoNCe4+kpFWR9or/pTzjACft/Bxsa40UW6My1l/nipHEJT/KiiuJime8XnhnG+
 lCtbTpjuibpYHXJPwo06T5DOfNnjwPSwbfu3hlojHcbc6jSLRgKt3BM235EpOjXJljtznIHSmsg
 /yjDZB2lGKa4sd5kBg3wBnp/Kbd2qPQVVBK2scrRj8FQjLeeKUEBNJiHdmtIih2JQWaCsYOwKTz
 lm4Ja0MX883teSdHkDqhk0o4ZFUP4waAHNy2FZzXE2j6DcY/hYACcx4DcUHiKN6xhEWG0LhoP9Y
 dMPaGTJsArXI8txMD8/kkf+SJ5TMuEMzhv/OGkxfL98iQ4ACoKvlL7gXs23+qZEK9+eywqChFoS
 TKy3ykw7aIwfPmNwMS/c/mjfhq3VWuhiBLNGGg2ggf0f9PBvBFIOfqHFdvCoVnLDjoQozjtT
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688cc93f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8
 a=fLAofa3itH1hiLrtIDoA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: ZCSbk9SC_TZbc7tVEu7kTGHgZTXEYdRi
X-Proofpoint-ORIG-GUID: ZCSbk9SC_TZbc7tVEu7kTGHgZTXEYdRi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010105

On 8/1/25 3:51 PM, Luca Weiss wrote:
> Enable USB audio offloading which allows to play audio via a USB-C
> headset with lower power consumption and enabling some other features.
> 
> This can be used like the following:
> 
>   $ amixer -c0 cset name='USB_RX Audio Mixer MultiMedia1' On
>   $ aplay --device=plughw:0,0 test.wav
> 
> Compared to regular playback to the USB sound card no xhci-hcd
> interrupts appear during playback, instead the ADSP will be handling the
> USB transfers.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> index e115b6a52b299ef663ccfb614785f8f89091f39d..d30912f952db271aa4fbc2570ca04b771ffef3ca 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -1176,6 +1176,22 @@ platform {
>  			sound-dai = <&q6routing>;
>  		};
>  	};
> +
> +	usb-dai-link {
> +		link-name = "USB Playback";
> +
> +		codec {
> +			sound-dai = <&q6usbdai USB_RX>;
> +		};
> +
> +		cpu {
> +			sound-dai = <&q6afedai USB_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};

Because this is SoC component <-> SoC component mapping, this could live
in the SoC dtsi.. but then 7280 is a glorious mess with the firmware
flavors, so I suppose it should stay here..

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

