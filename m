Return-Path: <linux-kernel+bounces-796145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9ECB3FC70
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F9E1B24F74
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC43B283137;
	Tue,  2 Sep 2025 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TLwH6srf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151B281371
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808940; cv=none; b=fHV1gcjyxCKpgf4zqBDJruII9nwW0jKUwtkE3B5ET5T/zXhsnoOuxEfNjj4zzDGteI3XoqY70YCC3HJxsvfyomSJXRL/11/zJWTw+iskNtv45QDl3WLWklB0bTKyM8/KnRWqQL5xWjIdXOrV0vPWMsXQDxgBIJCtouiGY/HQSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808940; c=relaxed/simple;
	bh=L82M7dFiH3/Cpk0L5yw06355VRt0Tec0z0oLTrV9hyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cT3e72dbLE/+XwOIGf+WaaskGrLpLmI1W7Fz7u22qtoV5OiRTVxloT/gf3FUnf+RcpCH2Io3G180IGMu9mRD/g+HtUX9oHb0jc6Uwv4hCvOSdzWZqgMp8Pwt9YGzFPsklALI/BkHo5iFCPTuZLbzmture2iQ+3hGbN2/imgU9N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TLwH6srf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Romr029965
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 10:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XLwV4MTrk2CPBgYEOsRH/mqT9xEEUCBdYMAW2O+ZTN4=; b=TLwH6srfdadgZ2V4
	argbbAp+p1vQ0nAqyQRJdbIhIdZJPDaJO+VFZ5MHkH7Xj5hEloe0Cu1n8ftNsrik
	cWsIwSzZfU6jCIPbR4rMGfRjyqS054I+rMHLPb+eP1CDqHeN47LP81N729CMl0J8
	bfoynS5H4jXVNgI1hh7LWnW+SAklqGNxoOs9tNvsV9gdSZo+lhQ7KIC6WVwjezDa
	x7B5ocKx6ZTSAzWXDZBU1MmjxgpsFIKxJHE8bM+PqFoNFGwCXHG0QnvaQFlhxP2n
	XDSVGQfu0vsq+Vv06zqMjTo4iHXlYvSB5zH+aZQZ6eo0j3W48IoxG7dHZHOd95uF
	CgIVgw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy39kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 10:28:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b3387c826eso6991521cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 03:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756808937; x=1757413737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLwV4MTrk2CPBgYEOsRH/mqT9xEEUCBdYMAW2O+ZTN4=;
        b=g1WxzGSGaf7dsWxPJN9KyS5SqwkClDkxbxVmREHix39hPurC1JYk8+xnG0+hMqZOP2
         FyoFzvAgmYak2qlknXnK9yVkb34E8k+qpd5ZertGAaQCtm9cpCZXRg7pBWrARnF4ZQz0
         a5+tOG03/Cf0rCEaTXkLC1MiI+xCtnEuIoS2vOS+dX+UFA/b01XGWUFZIK/CEjNElvm1
         wY0zn6IjS8FhTw/2ej2MAcq68aBltHg3zqhStDDLmDEYnn0K4JSP2yljTLg2RwSlqLqH
         49fnPUggNow4L6iWYGklE3mscJ6BZmnXnfPncIH5uxzCUhhEdVzzbEQTX2dWAVEPxalu
         CQaw==
X-Forwarded-Encrypted: i=1; AJvYcCWOnTrbgxR1rSoGkaDEF/y2Gdsj8oxCaXg35xfuAfZAZP1KMjOdT3AiMgPSb4XZ+9jml54dfDxTGcPWtHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBpjZqvO+eZOLlx/lrmsUjuTzArXgw+4/nCsdXquaViwACSJ46
	eB0xl/T1zMTWKtpeaFbkcc7RlgkNBu4GLsJmtl9xRYiUHwAABjcRd3mR7TQuLU7wIMz0g76AlXk
	IEZ8hU7tJ6oE+r2sufDwARh9u0yi6t+fQJ6m1ZMw2NIpqWn5Up8afNrdAweKllu2haOw=
X-Gm-Gg: ASbGncvLpRx0oeYGU1PhCSh7JW3yPamT5YQ6rN9wEuKASU6rfy8u7W93d5+1ERpo4x0
	Nvi3lNfmglC5Ag13p9JMrbhzRmVgdo0iLbCL6Qr3R7ex6TR4fH3oGiLVEMuxa6S6eb3JaWMu6Ck
	q3AFg99/liCfy7r6ASvVgmqtXFRICO99hZfPCJcVW7lXztgFnnUJE4yehodeHNYGMQKkYodin8a
	JbAbDmJSi21vk0BPFMVOfByqgWNqofKUtYEL5oVb9TTCUPb59wCEpJDiKmFbgLKVw4Dj5nSRBme
	O9Ms8u8o+oVkdw1dvbkpgdO/whav2dBK4qQD9mlGGsy7GmhpaVF5DH4LWZnWKYw1v791rkTcnwh
	IKJnSzx4k+UeUV2stb/fl8Q==
X-Received: by 2002:a05:622a:164d:b0:4b3:d90:7b6f with SMTP id d75a77b69052e-4b313e6f3aamr102448531cf.6.1756808936704;
        Tue, 02 Sep 2025 03:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRfEclWp9+H13vGsDsxjPzHN/XU4Rv6g22xQOuu2R9ylSi4hDyLKWJOeJWbCxzsepW4L+3KA==
X-Received: by 2002:a05:622a:164d:b0:4b3:d90:7b6f with SMTP id d75a77b69052e-4b313e6f3aamr102448371cf.6.1756808936191;
        Tue, 02 Sep 2025 03:28:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0428f88a61sm491858966b.70.2025.09.02.03.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 03:28:55 -0700 (PDT)
Message-ID: <c79a4131-bc24-456b-a071-85ca4b17fd28@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 12:28:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: x1e80100-t14s: add EC
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250831-thinkpad-t14s-ec-v1-0-6e06a07afe0f@collabora.com>
 <20250831-thinkpad-t14s-ec-v1-3-6e06a07afe0f@collabora.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250831-thinkpad-t14s-ec-v1-3-6e06a07afe0f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b6c6e9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=BYuMXoiSC8B881HoM0MA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: S6Fa-TmZwNHkdeNUWFL0vKpmkYplvSXx
X-Proofpoint-ORIG-GUID: S6Fa-TmZwNHkdeNUWFL0vKpmkYplvSXx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX7EXStH6UCwxQ
 7QXzT02ZFzil6vayFvRIE5Cc7oJO9Vbx2u5/mcFim3EhQPMUcHTTCFwSHl1yYXMug4mTvQHaenp
 vw8CgFZZ6H7CsCtu8VANPKCS355GchmBrOCzCY9Zb5gzSgOoUECr+CnDEAZaDvlNDv810bEps9/
 ZimT5oW5ARq3PsU6d1twAtYKEhVR2wrtTT25eKd0E2mdoo2SBEa/CX3Zfpp4sBnbTbbzKHPmoeU
 G5hZIWCvdXBLnLWUNyOPz2YAtR7ytGxoUeTusI2dL235YgVzuK4o1ooFd0nOrc92KzB6cpxsPKZ
 SrazoiEvy7fg5gCEreeK7MBv42nUA/n4ALY2Yo0xWgCV1FuTVGjKqeDe3nNzt67rTVqI8fmSBeN
 dlQDN5P4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On 8/31/25 11:28 PM, Sebastian Reichel wrote:
> Describe ThinkPad Embedded Controller in the T14s device tree,
> which adds LED and special key support.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>  .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> index ac1dddf27da30e6a9f7e1d1ecbd5192bf2d0671e..7a9ec0c33b3ca847c5496e3ec145c70ccb7a3fe3 100644
> --- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
> @@ -887,6 +887,23 @@ eusb6_repeater: redriver@4f {
>  	};
>  };
>  
> +&i2c6 {
> +	clock-frequency = <400000>;
> +	status = "okay";

a newline before 'status' is common practice> +
> +	ec@28 {

embedded-controller@

> +		compatible = "lenovo,thinkpad-t14s-ec";
> +		reg = <0x28>;
> +
> +		interrupts-extended = <&tlmm 66 IRQ_TYPE_LEVEL_LOW>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ec_int_n_default>;

property-n
property-names

in this order, please

Konrad


