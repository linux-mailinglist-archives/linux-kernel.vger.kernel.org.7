Return-Path: <linux-kernel+bounces-865613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A7FBFD95A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6891A1A0619F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C972C0287;
	Wed, 22 Oct 2025 17:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nyuqzZcl"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8905B29D266
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154162; cv=none; b=RPY6o1wcohKIHcL8GeSlyO/SblokjuiIvXA0fNpbV5hFcNuCOCrzW1aWnPCsQghsbqxB6T4hFExm6sWHj52WYZHfD2ddD3pLUZ3cH/wTp5b4T0kqKj/Q4TgQFHfFJWVwXh0t987GYd0QH0xa2cQN5mE1d1jX8NC47upHYaqbGl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154162; c=relaxed/simple;
	bh=dyHSc0Hkf9JlF3396d47TnH/fkxgN2mhFcVau1LyB5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROndtAHUnlad9FXF+gKdRHablXoM17wmcNnvmVMTRWhSG8mFaTzI78yNi1g0Kxoanq2hM57OYDVsySy55IF3+QjhE4u3gxwon80X6aGT+is27bJaRMda6MwM8FUMjIGEsbNPybfUKWiUr/sr3OKC29w9fIqwIoVo2XBNHtNzFKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nyuqzZcl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MAdlTG032689
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eyyrDYcjKGK47utngRF8H7m2HMSV90kJe50AtFvZfng=; b=nyuqzZclj/rzhlYp
	9CDYcsBf0gkB/79RfOhqhHwmoXl+sK4NKr6tPNnat7sLjhml+nCLYxVhgyaCtFu8
	HoV4sSioPH7UHAlaVUfRS6LFExuGVgKXHyM6isdv8S8kH9PpESGN+fan4RDNjnx0
	onYJKqd1OYHC8aGkV12DbP7dFqRxKPLI4eFTCY0LjzRm1KXCxbpt8ZVZyg0KcyA+
	I0WFYwKEVR9CQB0nEQdT7U5s1wzNfdWKyF4lz9Guakoe5c151DpJTa0Vyn4vBc3Q
	pOTDgo82yNVHXxuKwrZVf2pK1XRMco5RSMc4UgWO0O0fLP4UohT6LVktWK3JISvB
	XotrHA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42kdbce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:29:18 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87df3a8cab8so5479896d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154157; x=1761758957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eyyrDYcjKGK47utngRF8H7m2HMSV90kJe50AtFvZfng=;
        b=sNZ5gJb9DdJEK+9yScsY6Dgcz8owCGLhGL3/vPfbUrjytWjvu8UfoAbHidYckVe7Y0
         aCdX3ZCuUveI45s+naqvCsDP0SWjYAgeqmPY25TkgycxVQ46YH9mbuGXYGmVziKLXd8r
         04Eaneg3e68jyPOcCK1IePfc3h9gzHXBzRT2f8pB0DmrpAZP4jjliO1IPRA7LvmhcYk5
         POMAUFg3V/NNf60T0DQhvZUjBjTYUrdObdsGUh0ieSDLrlbPqohF8oViU9kxKlVtWFTz
         XAE3Bnni77Qft2CC68GKC/b6R3+vY8rGhNeaGgTX0DtDmyw/OoPbX+k4ul6l74ZfjozX
         FfsA==
X-Forwarded-Encrypted: i=1; AJvYcCWl7K+1GE7CTpXh5a9XgynHA+NKi9l6FTp/uUKoCXrnicn6/2xA57XiF3t3boXfk5YTxJwxcICySglNrq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzY/JsqnjdX9j00WxEEtG0eUUYYl72iRkrg3/MyOfBsMAy+kcV
	a9nDVby93zQXXIgM7N6hout4za4rnZ8Nq5q8WKWDp0TA7J5hqsoPLVa8qF1AjMjBOBWSQKlzLf8
	jUnSDMYnszrMo6T5ptGmuK3X4Yg3Wp+O9FR/RHiQrYkoI1qEo6G6PKcDFJb1D1o5XTSM=
X-Gm-Gg: ASbGnctMBxAnk28ywheqvbhChrubmVZRKoPaBn8C5HLjp/6dVy85twxdFE3N7tAlVro
	sUSW2Xj9Y2Ahzhbm1+tJa1WzfqiqZ1kR5GZnMdZmOlBHHgUv3nq3sT5BhkKe2xGfOCfL8Pf9PzL
	i5jR5M52nbpljvzblCgiycR3ClyZbIP0mGoqiUhZPCD0bKEUa35fQbnJIOIB9KOw17Tq02K5YdU
	ydg9BwR+o+KyF2a17nIP8lrZ2UL2XzrSrfznLRUEb/PaUaemBfvr0Z9TC4Y3mCisQqPWI4QM20e
	Fb3h/eBN5IJloVtw1zl4E/+V4MlBiL5ZpftAf25wKdKcbPl6EdhSpna8T8BA38vvZhIRPkCJsiA
	fZmlGNXEGMHu7vzTm0IhbbY7xpYVE3H1SyOBV/vzVp7IEamFigMCdmWSe
X-Received: by 2002:a05:622a:148b:b0:4b3:4590:ab6d with SMTP id d75a77b69052e-4ea11710be3mr66600561cf.7.1761154157216;
        Wed, 22 Oct 2025 10:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJw8MHnQwZbTuwNgN0otjEnj4HLV0d9qerQIspFAPXfhpawKwe+bMV3LTIHDxza9e5f9p0Ig==
X-Received: by 2002:a05:622a:148b:b0:4b3:4590:ab6d with SMTP id d75a77b69052e-4ea11710be3mr66600041cf.7.1761154156496;
        Wed, 22 Oct 2025 10:29:16 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da25d4sm1382273266b.9.2025.10.22.10.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 10:29:16 -0700 (PDT)
Message-ID: <c1d09672-e8a4-473a-88dd-fc91e81aea52@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 19:29:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Add cam
 actuator
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20251009-ak7377-driver-v1-0-29e4f6e16ed3@fairphone.com>
 <20251009-ak7377-driver-v1-3-29e4f6e16ed3@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251009-ak7377-driver-v1-3-29e4f6e16ed3@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TM5SltULorlEXQR9YoS7ROM6ybfUsPsI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfX5ThUQVP+ohsy
 AvAnz4YpAF42Tzb9okKOa3lJUslh8U2htmcSalnT447eSx2L2Re3VErpfXrnL3/GzGVjVlxScf4
 3AAUhgkyzncsUkiG8gOCn92Piuil9X/At09dSGFZgAxmfUEz4IxF9GMIgim5foUo8t6rly/xr6/
 Vb9Q/s6fpNUTzMf2Nms0j3w4ahLPnUVqHAzW8ZMwUCntiqu5hEwwKRMhl4V9YUpnb765OD3/4SV
 PhzV9GJd+s4J5CI/To6VMO6CHTuWf7IvZJn69CfsPaAb4YUxGzE9Mh/C1tdLqbtUJnfbiMiJmSc
 L+PicyKtYogBKShJ1g+7QrY6woIi6VZxRJ6ASNv24MIbEjTaioD8OXdQtpGoRzPNhZFsPcgmvzX
 1LcohPmZxaZ+gMpASZS6OvCLWqyiAQ==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68f9146e cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6H0WHjuAAAAA:8 a=AbxdTx203xjBR5gTc4sA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-ORIG-GUID: TM5SltULorlEXQR9YoS7ROM6ybfUsPsI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

On 10/9/25 2:23 PM, Griffin Kroah-Hartman wrote:
> Add a node for Asahi Kasei AK7377 actuator, used for focus of the main
> back camera sensor.
> 
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> index e115b6a52b299ef663ccfb614785f8f89091f39d..49654f0f914fbe18080d2f55bb6877c8ab7baf0e 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
> @@ -616,6 +616,13 @@ &cci0 {
>  };
>  
>  &cci0_i2c0 {
> +	camera_imx800_ak7377: actuator@c {
> +		compatible = "asahi-kasei,ak7377";
> +		reg = <0x0c>;
> +		vdd-supply = <&vreg_l7p>;
> +		vio-supply = <&vreg_l7p>;

The dt-bindings suggest vdd is 2.8 V and vio is 1.8 V (at least
on AK7375, although this isn't stated explicitly..)

L7P on FP5 is 2.7 V (default) - 3.0 V (which you should probably
tighten to the actual operating value), please double-check this

Konrad

