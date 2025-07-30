Return-Path: <linux-kernel+bounces-750325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6538BB15A13
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03D4B3AEEF7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6449292917;
	Wed, 30 Jul 2025 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cfhLaWSM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE70290D9C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753862235; cv=none; b=ej5iK62CsRPF+fe9DHv8CtRJxyGlDzgRXqLDeImlEWNJ+V4pHih8JzQDjpebklu/0mN+wmyurdGvZkvLcsepHYzgjPKljkqXLReeW3wziICQC3pr+rkpHdAo6/zoxckpJ4tUHTbH5HIvlZbPY8219j/8U7pEQkrEpfxSP8NGlmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753862235; c=relaxed/simple;
	bh=z52KxAF+x/O97zHRKFQXAXRIscKfMnmx9oJ2kW0Bv68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9xmzpJm9N4+tHYccO1jc3UI+fl/Ts5sP93xthT8HhmqMhMmmW0Y7lnxsPh8Dj7NbkbsZB5Tz33XAbk8xjzkDxA6BPBqZKOqzO/cSI9gNMuip/9TZrfsz8k/dDHghCATqOLAnPROMixq7wZ8r3gw69SiIu8NY4XDk8laEImL+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cfhLaWSM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U5x8o7018829
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/d5OINw4fMoJHAcwLcaP255ojHaBfh12PcSlb1H4jtQ=; b=cfhLaWSMQ1qBlJ6E
	2d5EvDhTExK8gBvCqnM0aaaH2bdbrh90wcKTGccXX4kNHYKJtbi4woowU7ePd1+G
	eQ8f2MdXRaNTZ5THqTHeTovWsdHepZh6soP3mMMcw0DRPZLuBWe1866vBY3UrG+n
	dkS29QgYCHJUsegWgdJnmKp7VIn9lLCGAiej483Era9kFl0HfhqjXNihqQTC1d75
	LGOb1W4yz1DFgdceT8CXTLQ/6xMP9kMl2BM37J+3uUyr161xnqi3Ddd9NNT2h2lk
	oBpHaXw1uEatL9UUwtR+hpMe+nHlnvZtx5y+cB/oSfPRXcccyT4SuR9R90TPN2yD
	lpmnkw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q86326d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:57:12 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab7077ad49so13492271cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 00:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753862231; x=1754467031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/d5OINw4fMoJHAcwLcaP255ojHaBfh12PcSlb1H4jtQ=;
        b=kbUyhHI0QAHlYF4QcMzH9WyWFF6o3EN2eBTK/xk0eneDHmg7W1RH7criiyVNocaRoc
         NRgwnJclsHhhrzlbfTIP3O3/Jz0dcpSexp3GKAypM6gTUM96o6MzLbiqMR7+VLcM/h30
         ARztsxne6e86YcYC0JAMqNlOOD6UYguh3GHjIutFhSTlSS0n9ivUcYLbTnC3B/qs5EjT
         2YoLMw2gdl8wkZF7HJXrJ9MXqilowGEtd0BWVRnPdIZMheWXyZUxU5KTq/DCYxZt1bhR
         eOa3f3h1RMYxPbk/rs95DOm0v9bWvVzRL0SBQaFHEMo7wH3LDGcAdvHnLx14LdYfgRvF
         1FIg==
X-Forwarded-Encrypted: i=1; AJvYcCXFNfVGVLDLkEjlS8t4kgIu3isU5svuZDzycFmdR7fmgIlrlT/98/OEl5FUHF7pinBPusEL8GPPZvkO0eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0I2SIAXMSIGnLme2i5sTM4iGplbJpPRerUwx9yBl6jDFvdQa
	KR/hi2j4OmEpGg6GcMVeCYETORNOVQn9f9JiOW55N4TTdwKfucO2VRK1e9SKpJAQ9fCvUUTbqtR
	1yOd85WNtl+BqkzNV5PQETHulMHfp1uKEpC7a4fFpzu8xqE7v6OXIIUaEfG/zoKJLK2w=
X-Gm-Gg: ASbGncsKXp0lcqf6+4SO2DHTbAKRHwuJXaJPMMWuL8I4XaX556aIs7mXjBa2mKERyMj
	UMrgEAc9fU+IKIY2RZIdfXIKPm/eYl46H7OXC8umjVpY6U8ZXfTxaln58w2aA8LOrv0EzLI6jus
	buxw1UOTrh3TN5We+Ult9tQD/QCMEUAzTqGVvpzKAiuQV74+ei8mfFQTjDqW4RSK5E3iL55yBSU
	iPtqASuylHnfxY9SqjZh+/7ngz06hvL1bL2pmwX/MTc3OuupzyeLF0ijLB2dOwdKE5EcImfzs+G
	cBBjVJdn9Vwe0rbOHfSNCC8Xo/TBebYGWlCVKGJPIpwFEL3sbYuExXSbx93Q0yEQSM+YBDQptAU
	H7bC05HkOPR1lPiDOnQ==
X-Received: by 2002:a05:620a:2546:b0:7e6:3c48:408e with SMTP id af79cd13be357-7e66eec65e9mr183086485a.0.1753862231173;
        Wed, 30 Jul 2025 00:57:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTh6KlTg3RtXH/aC2W37tAq3ilcec3EinBeFv9QXPB8EzzWwkhtulFrBTpAUaqxGi2vde4Lw==
X-Received: by 2002:a05:620a:2546:b0:7e6:3c48:408e with SMTP id af79cd13be357-7e66eec65e9mr183085485a.0.1753862230722;
        Wed, 30 Jul 2025 00:57:10 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af6358a1aa1sm696596666b.36.2025.07.30.00.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 00:57:10 -0700 (PDT)
Message-ID: <0919ba36-27e5-43c7-bf03-46991704974a@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 09:57:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8550: Flatten the USB nodes
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250729-topic-sm8x50-usb-flatten-v1-0-4be74a629136@linaro.org>
 <20250729-topic-sm8x50-usb-flatten-v1-1-4be74a629136@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250729-topic-sm8x50-usb-flatten-v1-1-4be74a629136@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA1NCBTYWx0ZWRfX5qOqFc4tSFU2
 7Wm9B5nXe7tdwspRZWX2XwL6oh+p+pWp8HDPuPd0mHs2N6pSVfuQ2z00QB17lh+oGcgR3spmoln
 wyWENHVHC891xl6aqWmBccLDeNKrbiAeqTZ2jsGz/H3cFl2kNBPo89XAnfL6Dl+o2vrVVuluLmQ
 0iFk8wssDBMOROoW7pM1rYt7CtfR0txCV9kVKY+TqdsDDVFWRM3vSgL+/tG4PHn/95+DFF3noPm
 d96Fbj2ABMrHzfZWpf/kS5d4/JVRHgFHWa4bEq2wRddC92usSflp+tmUe0p9Phk5S0nFINaZBLx
 EdsCd1DuyvYzYpaIM71lb4HJF5QtUuEKrFCHix8wPrI4yPIhunSD4quI7WgfE9+mV25VAYxbqu5
 bZSp4HHodUoGe+JoqHUrrw7DgfhSsTW2AhEYdpsj8l+4x0mjOvWkf7bgDXxNXxOc+91rr1KU
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=6889d058 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8 a=cHqI4RTSPJW5vXGIaXYA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: _heaX-YeFJBKPbTb9OzIu7UzmjFhzrPJ
X-Proofpoint-GUID: _heaX-YeFJBKPbTb9OzIu7UzmjFhzrPJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_03,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507300054

On 7/29/25 4:58 PM, Neil Armstrong wrote:
> Transition the USB controllers found in the SM8550 SoC to the newly
> introduced, flattened representation of the Qualcomm USB block, i.e.
> qcom,snps-dwc3, to show the end result.
> 
> The reg and interrupts properties from the usb child node are merged
> with their counterpart in the outer node, remaining properties and child
> nodes are simply moved.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 84 ++++++++++++++++++------------------
>  1 file changed, 42 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 45713d46f3c52487d2638b7ab194c111f58679ce..1e67b1cbdbfd1ac5478af23bf45ba45bb756ef29 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -4084,12 +4084,11 @@ usb_dp_qmpphy_dp_in: endpoint {
>  			};
>  		};
>  
> -		usb_1: usb@a6f8800 {
> -			compatible = "qcom,sm8550-dwc3", "qcom,dwc3";
> -			reg = <0x0 0x0a6f8800 0x0 0x400>;
> -			#address-cells = <2>;
> -			#size-cells = <2>;
> -			ranges;
> +		usb_1: usb@a600000 {
> +			compatible = "qcom,sm8550-dwc3", "qcom,snps-dwc3";
> +			reg = <0x0 0x0a600000 0x0 0x10000>;

sz = 0xfc_100

Konrad

