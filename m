Return-Path: <linux-kernel+bounces-871054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB437C0C552
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52AB44EF03E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3082EB856;
	Mon, 27 Oct 2025 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aHoznKfo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAE82E8B8A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554206; cv=none; b=Pv5FAt4RkR0h3S31ymNm/fmvlUcaRY5kzUWio9r4otS052LR5lFdtvs3//R4QBTcdfnRZG4K3rqRvZpBwffaho0mKpB9rTgY18kIl7OBh61DXKbeX/iHtBeo8NkKDg0cflf1jRHMcQb2+rh5GXr3v2taluSXnICAF0fU/cdJBto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554206; c=relaxed/simple;
	bh=r0uthwun3uYanqM5VA6Ncp5m/vK3sbk/57/hXner8c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIA6EkQqDqiTqODhuDs95HKXvmFHHrvR1zfZpNCyr2a7O+DAAA5wsWp3VyrXq7klfSA/+kz2SiTPL/xd1eGl6pcgQvyFjPbE7Z+YKw/MTUda5PSPXgDDbtvLeK9yMYAozV3q210d65QtKgyuwWk3QHiASpQ3jiTpRZmDuojCnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aHoznKfo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R84e6n2232090
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GGmrTyCU42ZrdU0m3fMjn1h4iKQkzqG+z7CEE0xZp18=; b=aHoznKfoepIGO6fh
	7JqeC4aO7K2Pg0+CFVldon6EmYYvGQjptvN7eFQf33zE6jlfYK5LI+uTGe1u+r2X
	99oOy2HubxsYi2hS1fLwMNiY5TMWNF6cIQfh0HJxZvz0kSK69t9ajjlFZnIORuLC
	JcXIiZYLJci5KRcV3bl2lg7d4VzXqRHfEDYxOD2UuMmUQJrcB53J4pCJyy9W7knd
	7MZPCcnSUNu4fYDMJ0zz14p47di6rRSf8/3AFl0UpIiAMwBIpWVYixtiXncRxZLW
	kTbHacxxYWQ/70mXd9A1hHbl2H5zBlZIH+oeYxyekwmg5eD9iKsS7ZFGXY2QH27F
	GWmN9g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a24wn82xc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:36:43 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c28cecb4cso18445486d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554203; x=1762159003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GGmrTyCU42ZrdU0m3fMjn1h4iKQkzqG+z7CEE0xZp18=;
        b=Pp2TR/59Fs9mYzu0caRnBm5Sdz0vHHw8GnsCU84T5m86BYHW3SxPJm/SWJvJzmDstj
         4SKfWxspPW7EW9PXFaeJuE0Oqbtue/bEHe1T0Zk+ULWnw6iBq9Eg7AnoXwlRRRVR7s1w
         NglZOWhp7ztRPtkNb0/u9Hp/RJWgXCrlufGb6GqfDt/3aCB7z5YaV8/iBOWoRkyomNj9
         1NuCUaoyse7C/tTjRvT7UoVSK3tsJqyPe7OtJOvs8uNIDsMy2o/w8Xs4gqRYpe45FXYM
         Y/3Q6NsHMzXNgzLWO6jhOdiBHh4bSzTzT130kib5p4wzZAIcQo+0ixg35Bp0hpFfKnhP
         Qagg==
X-Forwarded-Encrypted: i=1; AJvYcCVCgsPdMWtcVh8YtvFbKjqvUDnRtDtlya2ZCOE4OMP3nHGURz4B4xGDCTPOWMpWMzeacH4jtvKXWTC5cl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAXmoqJVVzzwtMK2My6q3uJdWyYR/NudV2NpaYFRp0RNkDDlB+
	wr6NhF957UhavmGp9bN/ON5SeMievBKGKF7f9UqE9pl1/x5ykHrgKl0J+DEPjZRFYa5gvk9wkUc
	CqbJtgp5DxUBeCue5syfJTbvj0sLZhDFALQBlV1NMkfI5jM9ogbeJxzHbP5Iv7mPy4SA=
X-Gm-Gg: ASbGnctnyaA5TmZ8QLfP6at/DlDHqguzTn4bCtIcuZlwqv6xk6RnC8kciADVE4hBwyB
	ClPn2hOTTxWqvNQpa0Kls3a45Y7lar+DlWiHcgb6MUtj9OFt4A3v4y5ly708Vgzmv7s4mnnqhdh
	460dMqi+7pr4AZLoIb58nMfQEcJ6647rQmWcZHVdm9yDJRlwXuUu9pweb75x3cGEuVuhJy8V1IO
	SJX1CtXDT/H/QNoI6TMVVO/vYBzZB4vIA1Vni2TJqYaCKqojuosZbvE3hBY2EtJ3fCo67bfpF4S
	g2GVgUYPrEjHg/zU2oxFzIuSO23edvUD4fFl1T1MSpcT5lDtWb+JzCe7Pkji0+LLJ4/ZUiW77zJ
	r2nvgK5d/BnFu2oAZDB1gd4IKt5hCmplsw+Oow2Oye2DEwgLa2GB1k8KJ
X-Received: by 2002:a05:6214:1ccd:b0:87d:c7db:7897 with SMTP id 6a1803df08f44-87de70be59fmr193273336d6.2.1761554202998;
        Mon, 27 Oct 2025 01:36:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBxZSlLSLq628XOcOmQkPcgLeRYWLr0nk7UrCJ/G25yRVawT6YRbJyjiyHjcmiuuMvBfY5Jg==
X-Received: by 2002:a05:6214:1ccd:b0:87d:c7db:7897 with SMTP id 6a1803df08f44-87de70be59fmr193273206d6.2.1761554202473;
        Mon, 27 Oct 2025 01:36:42 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85ba3798sm693504966b.39.2025.10.27.01.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 01:36:42 -0700 (PDT)
Message-ID: <e83730a4-f270-47e6-9bea-336c142eed11@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 09:36:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: lemans-evk: Add OTG support for
 primary USB controller
To: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251024182138.2744861-1-krishna.kurapati@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251024182138.2744861-1-krishna.kurapati@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=XIY9iAhE c=1 sm=1 tr=0 ts=68ff2f1b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=asFFNcRf_TYdFNsIYgAA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: eeT0Y6RpZAjFrVqU5700YHdNgTPAsCFK
X-Proofpoint-ORIG-GUID: eeT0Y6RpZAjFrVqU5700YHdNgTPAsCFK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA3OCBTYWx0ZWRfX9hNC3D5KTlrd
 mcwTBekgyNTht6szarQWpZmt986o9zAklVixQA2yBvHgRfToMLNr3KkYmqOOKYNqdWP1+gzv6z8
 tUvKbq/93WJJxbWS43/eIfQn44VbOpRpz1E48IgUm0zXQaLTqYpveh9oN5fHI3LFLLA2ty250f+
 mQrh8bCYxZWo5uoAVW99LUBaUQw5VqKXHi5FeDD630vaPEhamgdIaG/tqJeKK/8EPEO9EiuF7Hy
 5dQN87MPwyO7ncXsWcZbNzuQBpewLcjIFdE10LA4P7G36UfnUzQic6aXMa3I68OkUI0rNsTdzBN
 W4wPhefNNjWaGn9uFgcOe1SgMFV4/jNq/MBPMdtj7BuqNUDSJ2QM3i9dHyCaxjPFSBzAY3GuRjI
 aXz23JeAfqYhLCtziftxpT7EqGxwEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510020000
 definitions=main-2510270078

On 10/24/25 8:21 PM, Krishna Kurapati wrote:
> Enable OTG support for primary USB controller on EVK Platform. Add
> HD3SS3220 Type-C port controller present between Type-C port and SoC
> that provides role switch notifications to controller.
> 
> Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
> ---
> Changes in v3:
> - Moved "usb-role-switch" to lemans dtsi file
> - Moved vbus supply to connector node
> 
> Link to v3 bindings and driver support:
> https://lore.kernel.org/all/20251024181832.2744502-1-krishna.kurapati@oss.qualcomm.com/
> 
> Link to v2:
> https://lore.kernel.org/all/20251008180036.1770735-1-krishna.kurapati@oss.qualcomm.com/
> 
>  arch/arm64/boot/dts/qcom/lemans-evk.dts | 122 +++++++++++++++++++++++-
>  arch/arm64/boot/dts/qcom/lemans.dtsi    |   1 +
>  2 files changed, 121 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> index c7dc9b8f4457..2baad2612b16 100644
> --- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
> +++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
> @@ -37,6 +37,35 @@ chosen {
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> +	connector0 {

"connector-0"

[...]

> +	vbus_supply_regulator_0: vbus-supply-regulator-0 {

Other regulators (as can be seen in the diff context below) are
named regulator-xyz-abc, please follow

> +		compatible = "regulator-fixed";
> +		regulator-name = "vbus_supply_0";
> +		gpio = <&expander1 2 GPIO_ACTIVE_HIGH>;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		enable-active-high;
> +	};
> +
>  	vmmc_sdc: regulator-vmmc-sdc {
>  		compatible = "regulator-fixed";

[...]

>  &usb_0 {
> -	dr_mode = "peripheral";
> -
>  	status = "okay";
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		port@0 {
> +			reg = <0>;
> +
> +			usb3_hs_ep: endpoint {

Please define these ports in the SoC DTSI and plumb them through &labels
in this one

Konrad

