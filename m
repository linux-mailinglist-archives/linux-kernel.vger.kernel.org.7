Return-Path: <linux-kernel+bounces-800755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D88B43BA0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B98F5801BE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D49F2EBB83;
	Thu,  4 Sep 2025 12:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KAocQBHd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C832EB5CE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988983; cv=none; b=txvL8tdXQFxOezLqql2vrmC6aJ8xuD+p4CYSydHZ14szi9A45MvAVMbq/sCiODDWjy51OfdhVx1ZjvulXgeCUNBblCnO4NKaIa1pWA0zMEdBY6DAzEBYbvm8tN8KywTxP63nJ7we/DTyBo0ltEsKBf9/tM4yiK45jBvV2DOmNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988983; c=relaxed/simple;
	bh=prRAN2SiSAb/u9+OvVy7joIO67ql8BGArockTzY/cnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPtvCGKY+zor8fzzVNeSttWB0moLEpfPTeCt8jvbzaR1RPpg+hBUczvpuSIKsR3C0lftTcWPZvUqhAq0Ok53chIWw+ppc4C4+1uqSTDyLfo7hfHAiPqkTS6G6J5RiECH6UuPzdrXmcHNgSlug/inJWWzpoEmha82N0g0SODl9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KAocQBHd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X8lF008117
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 12:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8MmD4u7VxkulDeDKbSghx2SZtMVKQSBEQjy2GAas2Xk=; b=KAocQBHdKoC0bMjx
	3LePPTQ6ynVfireF0lNP0G0tG8lCfhmYf8BYPJg4dViUSJcCAFS8bBudYXn69Tog
	pLl2Fjxuy3qXrRwWnnnSKR475Bs4w6c8lyGOAt8W8gxLedwAYBiic7/z3x/ntQs8
	OLVJgOoeb4ArqfSDKrFaDs9m8gLq5mwMXwsre45hJlb1w0Grc58HQuRTXgqqWUrQ
	zn1+ebex5KLaA/FFfeSGMLg5I2NxLNTruJf2syTc90AP+0uVlV7FsiD3SiJqMkka
	YOodrxh99zFwflk7Zw/QNCmDauegOOS0r9H/nFlRjxAi5cAHMxwwwv8+tiqcV7cU
	iRpu8A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjqd97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 12:29:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b331150323so2408211cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 05:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756988980; x=1757593780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8MmD4u7VxkulDeDKbSghx2SZtMVKQSBEQjy2GAas2Xk=;
        b=kP5BNVsRp1hnW7AToiO8ZlYt+gj1F8WsAe5U3FmqFsiNneXvH3Sp9ECEeTzc65rL5c
         6UijH6x7y8oIzRMuICViyWR+HKMNXxRkmi09os/LcldjOHe5+it53DXfSsCy3Pqq60kn
         huY4T8jCjCFvSFAC9s0dZ3Y4t7l0Q9XxQ/+VgYd90DmhJrATY2blwykGhdSL2fiD7U+8
         X5mLV/Nx+zCB6eR2Gd6jt58Pa7py0wBD8l4QSuAvhgaWr9iwp7gC84YMm8Rx/1D5xmsQ
         F5ijrPLI3dJOM5IWSMTBngSk2V2lIoAVHMvBtjX+UGcHNb2v0tqjk0+bEzZajHY5mwQR
         UHgA==
X-Forwarded-Encrypted: i=1; AJvYcCWukSP/QFqQYRECAs7Wynnvq5o/Gy4b3+0MYLJhgec5NZwxUsgNYgczi+jez4NLjGBuOKU1BqmD/OVqtbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfrrleQ3gYUdSQXUpD9clsTSqz79zzFsYMLCb1BGwKIZSwa3Vh
	wp+Qb7FE4o8iiwFh9GhWAXe3cF5Zg6pEzVTLlHS2rSVP3IBPzvlLCdfWkQbN7zgS8zgqZH9ETD0
	mu3YvqQoTu0zTRPkn2nRq/Wpru34alegQZb77/T+Kbc49Mp0/jtGWDbfGdZczAfq4k8I=
X-Gm-Gg: ASbGncuUvRIsodrW3FJeod12VkEWt6eGvbbMlfn+1WbNpolf9LH/D8HXYOzQhYmCxiu
	1Q1mQ88T7YU3XFEa/fL91qFb8EuOMSgN1lP4DUW7QKEg5gx+sB63Lxkn7kkI680UDCUlNaoYgMx
	mI1kGcqrXDPEWIJfB3Higsenli5ne4ky+FgfuXveT6Q5b3ZdOyxzBa0MQPVdmTvBUxvqdPdgHaE
	BRQd5orRbDSo7MO6YUl6vFlk2pTUtkVJJTByuc6BgdOwmvzWQjcL+pY0/3G0aJI9YE64Sc0SquN
	Wp4xprGGhsRea+KEMArarSldaggeQ59F9Nw5r7FbI6XRJmNUHV/xGsLpen/sOTNoqev+IhC89ZX
	9pAWGKEQhvo0OWEyCQKTjnw==
X-Received: by 2002:ac8:7c55:0:b0:4b2:d981:9d4a with SMTP id d75a77b69052e-4b30e932ab7mr175134561cf.6.1756988980345;
        Thu, 04 Sep 2025 05:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTfxzsYnZYb0m5gz1tPNelxJIih7NJHAZeds3PRFC3JhLe9jDQapqBbetmcr0xmuOXgNFQcw==
X-Received: by 2002:ac8:7c55:0:b0:4b2:d981:9d4a with SMTP id d75a77b69052e-4b30e932ab7mr175134161cf.6.1756988979595;
        Thu, 04 Sep 2025 05:29:39 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b045e576edbsm537149666b.75.2025.09.04.05.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 05:29:39 -0700 (PDT)
Message-ID: <cf6b7766-0c67-42fd-a67e-ce349688d9a1@oss.qualcomm.com>
Date: Thu, 4 Sep 2025 14:29:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 7/8] arm64: dts: qcom: qcm6490-idp: Add WSA8830
 speakers and WCD9370 headset codec
To: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com,
        Prasad Kumpatla <quic_pkumpatl@quicinc.com>
References: <20250903151337.1037246-1-mohammad.rafi.shaik@oss.qualcomm.com>
 <20250903151337.1037246-8-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903151337.1037246-8-mohammad.rafi.shaik@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b98635 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=q1CUbaEDzoJ2oNbkCL4A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: TYFz6l3NoQXDuzFgHKRGGDBiwb81HPr1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfXwi7zzZEzeyf0
 MnCDhm8VgeW92yb9WTVRNGxS9Y/IsFrf7sSxjMV8f/X2auQoAk6oGff1gNhuLkC+K9aV8MRg/Tq
 xtfu70g2A97Xubs5y8w3dvh9kLb1+g6eYJMTorxurw1lZyQScuR35EUfmSAQeSuENpZVSqoJHP7
 WPAMKhtbZO8RNKGhioX7/CRfl5se+Fk2/Lbkd1zk1gAHJyPVTJ4siTh0fmCq6N6CXRPASLLqcwF
 8ZjVGnXQOtCw00CJj6A0cNCIdNPz5pjIAyUNUO079tEkKldzoXlfkCfuYC2TtBqg0CbNGcFKjTi
 PXbs9RIE6FVTK5xG9ro2Wa+CVOXzhIjQibw18kFXIqWUbkd9NVVS9Xy8NXDdv9ATCiqQu3mRHmS
 H0oeFPOr
X-Proofpoint-ORIG-GUID: TYFz6l3NoQXDuzFgHKRGGDBiwb81HPr1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

On 9/3/25 5:13 PM, Mohammad Rafi Shaik wrote:
> Add nodes for WSA8830 speakers and WCD9370 headset codec
> on qcm6490-idp board and enable lpass macros along with
> audio support pin controls.
> 
> Co-developed-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 123 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi     |  12 +++
>  2 files changed, 135 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> index 8ed6e28b0c29..379ee346a33a 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -18,6 +18,7 @@
>  #include "pm7325.dtsi"
>  #include "pm8350c.dtsi"
>  #include "pmk8350.dtsi"
> +#include "qcs6490-audioreach.dtsi"
>  
>  /delete-node/ &ipa_fw_mem;
>  /delete-node/ &rmtfs_mem;
> @@ -169,6 +170,30 @@ vph_pwr: vph-pwr-regulator {
>  		regulator-min-microvolt = <3700000>;
>  		regulator-max-microvolt = <3700000>;
>  	};
> +
> +	wcd9370: audio-codec-0 {

nit: the trailing -0 is unnecessary, as there's only one codec

Konrad

