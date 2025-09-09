Return-Path: <linux-kernel+bounces-807555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75025B4A621
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4A94E62D9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D287F275AFB;
	Tue,  9 Sep 2025 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fu32bpPb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5652749C8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408173; cv=none; b=bQJnHXxsMgcIDH+biGsObNaejZ3yPvtT7DkAqGVFhFxq8VtVSdV92iNg1wrbI8f1fTUbVI4ogemFmvLQA9HKRmZbGN8Lg7OHMWndE5N3iH9xVMyFoxZgk6xOonK19oz4myDhQU+W1I6bcPl7p0bwjKNbIHonPByKu18P4J19+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408173; c=relaxed/simple;
	bh=HEr1BW2CyFXSjAp5IHF1LeICiVM9EMNs83h9onsJJ40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvAwCW911nOoFy8/1UCMyZd48Buvdjxytq/Fzz6AOHw3sEHuonAdZ6ZqxQlIcQf+rNjt3SWhnL/08apzNbKjVAJzwqo9codg5b0Nn6BPEK2Ok+baj0Nq1fjtv38UGeuOz5/zhV4u4qoyqIxINejbkrGNOsY9ISs0M/GpWdbri0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fu32bpPb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5896Sje9023508
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 08:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FCzw1uK2cApp7VoxRq8nIM7edWjezcrHv5GLBEAENTI=; b=Fu32bpPb1qDD0kt5
	7KNTHaBpEDpvqtdQSdELmxstGrZAtUyZNJxX3hkfEWNyIEIWzIH/juJl5u3USICt
	ExqQRugwoY5MVbHLHvtTjU7IcDEaaLUO3/UirbkK4WmYCN1xnSde/ZJpwHYe0fQu
	bUnkPNFHOcrAkpVC7/B3PFXoJlLsMK1RzYDg44iw3mwD66xj2NFNQBnrErwtybYk
	pNzUeswF1no8kEZ7j8LMikCCW/Nd8sOyg3kMN5PtWnWvxK72QsulfyV3QJcYkZAL
	ykkGOw3tZ0yHqzeTjIRUSXVF69qucFr7CwI34MN4tljVfEhjIxhLxaLet93jlUCL
	lw0a1w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8fm8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 08:56:10 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-74910ab069bso3440906d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 01:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757408170; x=1758012970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCzw1uK2cApp7VoxRq8nIM7edWjezcrHv5GLBEAENTI=;
        b=HxF2Ot1ej+Mka4vJDKVNnZqo53zgE4uRMpuurQ94W0MgBjn7L7Z9R+4Bi4NfHG8GA3
         qCcKTMnxy2DdegcEsICWLda5Ncq6jNE8qkpfx71ZDjb+rTlFRsLjJPcF9oypNVBe3Sro
         +9XAHmFCLN2iL4OsOKY7KKNvG0p6h9x/jno2Bxk3VLUINxrSmnobZcorY4394uO92i84
         r+qNPESLyVqfahdho5Q4i45eKleev4jvTXcuRLu182KXWICKs/yjKolvkNAtRTZSlXj+
         /4xTnX30Eoc0VQcPmfRAHjf8TylCVFhl8fTTm9tBm5xlF/7qFSmTVpV/JYMlnCA99QaS
         vfrw==
X-Forwarded-Encrypted: i=1; AJvYcCUJSrQa2NjeQbD/Iro256bnRpA2F5LPSJSgf4RwM2FZOM5nnLIFrHuNhytJdatXuXmbQwci7gPdenmfDHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5THOOsyitywKpEoyHnDLtqvTFa7IKsI+d8qptWcwgiCBy3lMQ
	BFkyn5768haW9Rht+FwkCgmwEWOYuba1veDHaazLDbiaJ3XQ0UaT9wtTqoaU4JLnGedQCp9TwX9
	U6jEc32SuGf6OQ9xtTw7lTsULLlEXDvAtuFpjNyNICtu5m2Bp+srHTlgvbA4291vJzpo=
X-Gm-Gg: ASbGnctiaxHNkxA/GWVTKC3PCnvL+9IQlQa8BdDo73PFGjBnTJ6pCy0HN21ZFPRfTmV
	nX+GBRl1G6MCEr0sTJ6GuFFpu/EKM/veG21k6h0h4S5wIDl7SLp/p4Y4YWw/MKQSwmpmVzf/BJU
	nbRdvRf8yaAMw42DEzyVb0Dcq2Gw5ILtIwiteZUPJojjNczHssZM4aGT0/d2iwmDKRL+GtGW7yQ
	K/XwuNJ0c7RR4NTSwN4zJ+/pSxbHURc02ojyvFvTqE1B0hYNg1HFh3XzUSBGZ8mQH1z1R9l1s+G
	dulemlhLA1StgbByL4ptwCHBhNSUQ/2x0h2HwMBClLOHLTUHj8xmFKc4EoozyU2ZnMBIbv6Wpav
	P7L2F8mK05PvxaA6E7z8FpQ==
X-Received: by 2002:a05:6214:2601:b0:70d:fce4:1103 with SMTP id 6a1803df08f44-73923522d01mr76507166d6.2.1757408168988;
        Tue, 09 Sep 2025 01:56:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFomYED4Eza1A+e/BtNTXXoKFDMJfCxthpkjrk2o70p/W1ZuHNFlj0kbfmL3qCOaJ0P4xf/8Q==
X-Received: by 2002:a05:6214:2601:b0:70d:fce4:1103 with SMTP id 6a1803df08f44-73923522d01mr76506916d6.2.1757408168393;
        Tue, 09 Sep 2025 01:56:08 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c0123f3ffsm809455a12.27.2025.09.09.01.56.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 01:56:07 -0700 (PDT)
Message-ID: <67de95ac-38d4-452f-8285-c2da89aa725b@oss.qualcomm.com>
Date: Tue, 9 Sep 2025 10:56:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] arm64: dts: qcom: x1e80100-crd: Add charge limit
 nvmem
To: fenglin.wu@oss.qualcomm.com, Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@oss.qualcomm.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
References: <20250826-qcom_battmgr_update-v3-0-74ea410ef146@oss.qualcomm.com>
 <20250826-qcom_battmgr_update-v3-8-74ea410ef146@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250826-qcom_battmgr_update-v3-8-74ea410ef146@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfXz4YSzBONthGv
 WzDGptggQcg8fONpTNXTVH+DkJE32B85zZBbPHcIQ+CDN4DgnYrpnYqhVR0TIKhqRjXR9H2PO2R
 7ZQ0mrP/jIfWFURnQQYTbmXQ/BKV9dQxMuBhNsrJBMXRnuvggD2nT8vHVSzCPomDnTp061pgwfb
 Srp8KJesUHdFdbembQq6pxzDstgxrPqu+Z0afMOjfC142BeBAZa0xypfYw8E7WmQclVUvLaNAQ3
 nqgPNR7j2IkLrO0fc8j3tbSctb3qA71x99Nf98IGXGLStOLA8l/1+lcva3h4TmWn0OmqTqODOGr
 K1HDkoZJ3lrZNfOsLxJnoUuXBGTryJjuGW/WIKe6OnmvqEE4EpEK4/99oQIbcbB+CFN8uDRZdXX
 0gk4VHka
X-Proofpoint-ORIG-GUID: WbTFDlvGVh-aaBDZvupJ6aYF3XgL6LWe
X-Proofpoint-GUID: WbTFDlvGVh-aaBDZvupJ6aYF3XgL6LWe
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68bfebaa cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=B-3kHGih9VurzyBn-70A:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

On 8/26/25 9:18 AM, Fenglin Wu via B4 Relay wrote:
> From: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> 
> Add nvmem cells for getting charge control thresholds if they have
> been set previously.
> 
> Signed-off-by: Fenglin Wu <fenglin.wu@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/x1-crd.dtsi         |  2 ++
>  arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi | 20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> index c9f0d505267081af66b0973fe6c1e33832a2c86b..8c3d30dd936ef9b12867971f5f237dd12484072d 100644
> --- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
> @@ -82,6 +82,8 @@ pmic-glink {
>  				    <&tlmm 123 GPIO_ACTIVE_HIGH>,
>  				    <&tlmm 125 GPIO_ACTIVE_HIGH>;
>  
> +		nvmem-cells = <&charge_limit_en>, <&charge_limit_end>, <&charge_limit_delta>;
> +		nvmem-cell-names = "charge_limit_en", "charge_limit_end", "charge_limit_delta";

1 a line would be preferred, and we try to keep a newline between
the last property and the following subnodes (i.e. before the
comment in this case), please adjust accordingly.


>  		/* Left-side rear port */
>  		connector@0 {
>  			compatible = "usb-c-connector";
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
> index c02fd4d15c9649c222caaafa5ed2c777a10fb4f5..abf7afe5127d7b8b572513234e00009ce837837d 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-pmics.dtsi
> @@ -239,6 +239,26 @@ reboot_reason: reboot-reason@48 {
>  			};
>  		};
>  
> +		pmk8550_sdam_15: nvram@7e00 {
> +			compatible = "qcom,spmi-sdam";
> +			reg = <0x7e00>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x7e00 0x100>;
> +
> +			charge_limit_en: charge-limit-en@73 {
> +				reg = <0x73 0x1>;
> +			};
> +
> +			charge_limit_end: charge-limit-end@75 {
> +				reg = <0x75 0x1>;
> +			};
> +
> +			charge_limit_delta: charge-limit-delta@75 {
> +				reg = <0x76 0x1>;
> +			};

These addresses look in line with the SDAM assignment document.

Konrad

