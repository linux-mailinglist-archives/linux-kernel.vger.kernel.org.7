Return-Path: <linux-kernel+bounces-838586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B25BAFA36
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95F3B1C1649
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AF827B4E4;
	Wed,  1 Oct 2025 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TnHvYfIu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728D627F01B
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307456; cv=none; b=IW8I/37L9YiKuL9eoWzkHC7R8hrVG8sp2YJZuxemn+uIo872689S6rPxpxct4SXg/bX5F0bJHq/xTcOTM4Dl7dE6HlMuqEqVS/VEJxkvAszi/oUjSw3VJ8rVStgSjZQUDtdYttUanTntAGHOnCxKj/Xahk9ZNM64zbL/4ajCNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307456; c=relaxed/simple;
	bh=GT0LRKWWLolOUjYL+JFNIRty+gSBWR7OB009rRCYzxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+jpDKNMq2R62x7p+9rNlWLP+shcq4el4DpVcJ4r+WNWqICGHjepMB94Pmkmy1Hau8QXc8dFApbuFMwApXn9iDVGbd+Wro6innptnEdN0eBKmZMSH4KqdHgsq9EE4hBDBo1Q3CdBL+eHFSLISFtzb8FzDzMufyDj0nOwcpVNBcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TnHvYfIu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UKpXH9027376
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 08:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Cjzm3emaoXKpMvDV9sAM1BbWQ575XrXlSZCnkzdhJSQ=; b=TnHvYfIuBM1/HTJz
	8Htws6ocSLKvpEojwbVzmqEr/JXECJzUOe3ZnsVGtsBIk8PRy6zkJZsWMqtGQMdI
	ikgHwZ8WTojLkgIKvkOBmhAhwOkb7DXXqwRak1CoqJtlI+72Crq3MSCO08EZffQy
	KTS2GcgAOPv+JTpu2JUFfEmC6zKLpSJuCLsguo/1q1Nsrv3IWmiCnHFvq2BT0Ypx
	Ps/VsW4qnsXFg9+0RyGtgOhrPUjsyvGXJTXxr6qQaUTwP/ko2lf56/QooglDDm+a
	djwZO3RNZtpTXbanB4aFe8GvP+QLH0c67uG6l29ysOYjbvD74z9O26YY2xn2wu7M
	gZTnlQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851kv4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:30:54 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7abea94d621so11314086d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307452; x=1759912252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cjzm3emaoXKpMvDV9sAM1BbWQ575XrXlSZCnkzdhJSQ=;
        b=Sw/qOY7olX9QoQ5npsh1Bh2m839837rm8nsRT2qaI1anbwSY0FsJeb+vRGyHllLW84
         NAiA1Oc2Z6+VM9WdBbjFuHmIwk8LN+L/2RZry8HpABiJGNzY/Jzrl/PYFT8bT/iqVLDG
         21WxSukZpr86kx3apdroeDVAnYJDlupSk12zHVFcriM7MvMumeCa8NDTMsXqkFla8UAB
         8xsXoHRrs/Ghwvhsf2MXbZ5Hp3J/iYKZvO9XTFdZILr4gaTaAJ4sqaKJz+MqsvjPCdZj
         OJ8xh71WCZhZ7FfAS8XE/sQBYfqjwZ7baMeECifQ7Ih6PO0NdHUVIzBuPmS6Qb5INZQ2
         0Hxg==
X-Forwarded-Encrypted: i=1; AJvYcCXs6ZXTXVfCLJcIyaKUs0Y3BjVBKjAGLkFFbxu3f2BNNTNPcL6i0EzHoqieGso8XKZ/zeIZ6hsQFfW4Iq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVlfp7Fdy6RawjdeMdUAWuwFGv8yEqRZwa4y/ZpzOnUKdacLSS
	tCWfA1scrszD/eTMakHAB7jRaDrjSRp4iSli+iw0SIlFEGs48Eqi+jABiLOniV96SQfXmIah128
	RAGIOokwu2h/UoZ6tacgZHQXKzJp8FRDWAu53SxGjrzhsrEx5JbX1wY5VZgrkoSycNUx3xewhjE
	4=
X-Gm-Gg: ASbGncsgJohNV0/2/drvLLsMmN3W1M90zss/LlHCrepk3BcC3Q+fFMjjxoSpr22Ycec
	RvyiEzP6bEBrWcL6PnCt7u+xGsWHr3Dyt1YvmaoGBTG/IUh6qfeaY9S/h4nzZPSBCQJVbEH6DZO
	zlsEBW4Av/lOYOHUWpjnW84FCcRJXWZqfQp16K0KArXEron3ItYYLWXuaalCaSkmZKjw9QkxiSF
	rvW/ZzukM3OXFfgEXa9w9AJqKeQY6jDTOO1sPCRf/ESGEsSAFtmoFt5iouZeWpGk5BUNw+XsTLk
	9w+A698eUwPhu0kcx8Hwa8AhVzureYBvFjHuCfJXGOf+A/y++wuXeJx/kpWRlMuVEcxC05T/8pF
	YMca3JKoOL9bEfzEXeIosxAxm5os=
X-Received: by 2002:a05:6214:20e7:b0:7f0:787a:46c0 with SMTP id 6a1803df08f44-873a60f8fccmr24664376d6.4.1759307452408;
        Wed, 01 Oct 2025 01:30:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG822gD7rUPMNB4okaH11eXrfFzHLQWvCQu6RuTPp8JaGF3dxaajwDtHeT2MS7SE5K8lJJWuw==
X-Received: by 2002:a05:6214:20e7:b0:7f0:787a:46c0 with SMTP id 6a1803df08f44-873a60f8fccmr24664086d6.4.1759307451860;
        Wed, 01 Oct 2025 01:30:51 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a364ffa4sm11234059a12.17.2025.10.01.01.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:30:51 -0700 (PDT)
Message-ID: <ac1c0d1a-36a9-4542-b879-06c017f7f2c4@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 10:30:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: qcom: qcm6490-fairphone-fp5: Add
 VTOF_LDO_2P8 regulator
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250930-sc7280-dts-misc-v1-0-5a45923ef705@fairphone.com>
 <20250930-sc7280-dts-misc-v1-2-5a45923ef705@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250930-sc7280-dts-misc-v1-2-5a45923ef705@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68dce6be cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=6H0WHjuAAAAA:8 a=_C6b-tzP-owvyH6gxLwA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX26oNEIKHjz9q
 E/ZRYfG/p67mIED+Jzcn9IBDbOiO6zxEWdqVvDEwpt1i51DivH8mAXsUdn8pOKIgTSvdDFuRLAq
 qcblvFWH0yT5GYMQljo/ufe9N8VlX6K8T1TqRJQ87djmlS488qDQsMRXH0JfjoawMlgLgAarc/N
 JAoWFEE50Z4n7p+AGYSTy/7TuO9AaHrXJSubEUOW81PJY0pqMD5sgHxEbIjKyeMJKlmb84MkEwd
 /lw7OIpknYdD99WbHru0l5f3ILf8PLdD1l+wll7j3z7Fl/a17R92hTnsz6UyR6Q10jdQTzfms5o
 gO7LSWn8OVZIlw+1P9ivmjv25gB7wRgGzS+c/OVpzsBxaXQaISVrbLaxQIzjQ9Vj11OeQWD5PXm
 1aXTky2isli8tLJHM5xQvwSvkapAaA==
X-Proofpoint-ORIG-GUID: akUuzyfLSfPmI1Gkdh5-pLXl75b8sKDS
X-Proofpoint-GUID: akUuzyfLSfPmI1Gkdh5-pLXl75b8sKDS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032

On 9/30/25 3:57 PM, Luca Weiss wrote:
> Describe yet another regulator-fixed on this board, powering the ToF
> sensor.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> index 36d5750584831d66b4c2faf6042e4cbb3274eca7..0a64e5721e092d1f3e4bb7329335704eee567761 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -195,6 +195,19 @@ vreg_usb_redrive_1v8: regulator-usb-redrive-1v8 {
>  		pinctrl-names = "default";
>  	};
>  
> +	vreg_vtof_ldo_2p8: regulator-vtof-ldo-2p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VTOF_LDO_2P8";
> +		regulator-min-microvolt = <2800000>;
> +		regulator-max-microvolt = <2800000>;
> +		regulator-enable-ramp-delay = <233>;
> +
> +		gpio = <&tlmm 141 GPIO_ACTIVE_HIGH>;

You may want to define the pincfg/mux config for this gpio too

Konrad

