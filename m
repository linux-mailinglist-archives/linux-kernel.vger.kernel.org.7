Return-Path: <linux-kernel+bounces-832388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E162B9F362
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534BA560857
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A91301718;
	Thu, 25 Sep 2025 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DqXm0jPx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A402FDC44
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802852; cv=none; b=iqjN4rWm4ta0D44g0kW7x8mq8pVri91KVdXVPbHPyr+qOYghjGZmeDEoMnR6YK7c9YBTZGdf+vH6Tp9XaP4/xJQ2GQCiG6Rc2+Mki978nm862DeIraeRiRPF/6v//igCS0StEcl/I/Ls/gkJE3EkfqojQzV7PfT53QUgD3ZlTc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802852; c=relaxed/simple;
	bh=UEgHkUZ6HhoDdgg1MlS4yGu3nLu+qwQjfmfqPdvPrvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwljvA2Bv+SFaBA6dbyH//tt6ppUNP8MxlIaPAX8k8nnGmHXt394eNZqVEAJgsId68hraYjOkx3gP2XPQDCeTqUSVUAp3h38asX20bYnKsrKJGi/lFv+dwhy6s7ykgvFbAkxByRYRQX4TuzJnDxFLI+XeKS8GPtnwKA9rB5RCFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DqXm0jPx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9X0g2021502
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JBa9WUH9blDwOYLAsQwNw9XJY5WIlBodkUOkl/iYaOY=; b=DqXm0jPx8bLW5b2J
	imDfibvt2AKxzjE0wTHNRDVT6GjE5Gy9IsEPaV7DFrAzcoHvLUi7QG6c72uAw+9g
	QZiPjea4esqkof+wWjQcaTKkXVyM4UZYREznVU7T/nBv/3kcwFhShCkKjmxje5XH
	nwvztwP49gQsxiDIAFD2EnqR8cvh6v9ir3cWxgEfFxw9PCAab6kFfRhxvJCdwkVW
	9OoZygW5indqKF3TIGU4+CVa4mKu+Rtr8sx3QYW24Ar2P3gGGEkUfuve0J4sQ7V1
	NeisBCr1B9LhcASWFicd6fd9YhTAI/wmOG7vVKXbPMsYU1/C2xJklN/UqADPasiH
	j3nn3w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budafm3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:20:49 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4c39b8cb20fso3155911cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758802849; x=1759407649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBa9WUH9blDwOYLAsQwNw9XJY5WIlBodkUOkl/iYaOY=;
        b=lSPEkqljLWLhohfK+0DV4M1TDy1e3DUyCf/5bgyOcxUt6uYjRPQjpbii8jkCcfMLei
         hSweooTNBwBbs+Krpi9hQmW0ZZvvPSQgQHI7mrR+zEVcw4Ywfhb/TT2h2PlVahpEvaBF
         +7F2cKcoiXEkEQFUaAf1TOkpPwOT1aW6S+NWAzl9kzQ81g+h95IkednumZl49m0e7N4e
         3DDmm7WjK0l6eq6WYn1PmzbJXiye8KUAKOV/870l2s2bB2VKBBT0ZEDSmw0ZzeUgxQFO
         st/xeD+dQexqGe/+L+MOtfj1sXMdvNe5uSWH8GL20lARcirwTXbuB/4JGo473CoA74pE
         wwRg==
X-Forwarded-Encrypted: i=1; AJvYcCX2GU9borB+XhDClK6ERS+S/8yP3caYYglxGbmoLLLQf0g+KB5oZ3GqT/I0sVN8VIs0vZRkUNNAoa1uozo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAIgoeD5Y5nSXZnQXLcqcykaOXGUf9z7Lh9/oWFtxrwfDeoRR8
	n91sfVytF3fFhgQxr3OLo8tJSR1pKYvGyB9MJr+Q7xw8GZNuy26Su14Tm8Ojc1EjPWt6vsukQ2/
	lghwVWVeWUSwYBnpUR7OvI5lcSBvxXNitddDOZ6q7u90ojcGyZHcKrdPGYbovZT9n/u4=
X-Gm-Gg: ASbGnctLJnc7GzdfRd5jstuoIAdOVo7VOYJNGoDvaPpYXXlZEC92jPKjqO2zffJLx1a
	SStkqCv9e+vQkZWqVm94z4ArGFHiAUFNxC7osasG1etO/6ctMIziBrozPKPahyO4oosUctf3mUx
	DTSNymRBjv8wlBpygSGZlZ5fmRoYIqXYvAkX6iUmXGaBI/pZPSlFPta2NmhrWIdYJJ6ilMvdeIi
	rgQ5T9fliRgiRZoxx4DJRpfM/SdGDM1yTEYURXnEVUYh6XlXfu+qf1OPXjwXpPIpJGeidD7qwRV
	wuwpw7IzGxyphUr16KPpHiIy9A112iBPmZ0TaT8X2GH7YRyzVrz3ZeXtkKASDaGGpK/Vac/b8eo
	fLARBE84oJrGgNwBr7bKlJg==
X-Received: by 2002:a05:622a:608:b0:4b7:9ae7:4cdd with SMTP id d75a77b69052e-4da4b6160cbmr23991531cf.8.1758802848344;
        Thu, 25 Sep 2025 05:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEye28teigye8FN0oa/ZIC5riqFjgrGEHnB3Orw1Yd88iMLUXY+KIieWa9yV7NHkzBr8FWFwQ==
X-Received: by 2002:a05:622a:608:b0:4b7:9ae7:4cdd with SMTP id d75a77b69052e-4da4b6160cbmr23991201cf.8.1758802847897;
        Thu, 25 Sep 2025 05:20:47 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d1643sm155282366b.22.2025.09.25.05.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 05:20:47 -0700 (PDT)
Message-ID: <85ba017c-3ed5-4fb3-ab6e-a64135a15a85@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 14:20:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/20] arm64: dts: qcom: Add PMH0101 pmic dtsi
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-9-3fdbc4b9e1b1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250924-knp-dts-v1-9-3fdbc4b9e1b1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: F4-xd3RQXW5B_R1UoYeEgeBHbjQxVmuK
X-Proofpoint-ORIG-GUID: F4-xd3RQXW5B_R1UoYeEgeBHbjQxVmuK
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d533a1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=sMJJNNXJM2iMDzM3yLcA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX5xzb/WbjvEyo
 gEg8i6OrWINLP4Elmcendkwtw2nbtq7qEnE9ydbz9DQOjSC3LDCtoGt+FPDgrNkvExooiIGTfW/
 c3HvObPqQ2gbery+g4N5SbMDzt1PpOw/ohRFs6tLxhO5aeI07CorrrUJFHNLzr2odaCQ2WAuCiJ
 pjc+Q01l6IAlqzwW/NYFvMcBagM1FudVXX7mYadKjUYY3wiVYAnsVmL/ia1Xq8j49Prnb28TemH
 4edREtkwUhtgAnFJOm1hDjDgGMs/2bNyfscLFaaoEix9/Ls6frarRlrbR+RGBUKVfTzxRGvCj5d
 KzCfvl4ZChRVtAYvHMVA5iJ6Z8xq+wDnyupji7vA4QDwctC/K0e7AhpxOLacfSjXVuFy8FtSamJ
 P5FpHwsH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

On 9/25/25 2:17 AM, Jingyi Wang wrote:
> From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> 
> Add base DTS file for PMH0101 including temp-alarm, GPIO,
> PWM and flash nodes.
> 
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/pmh0101.dtsi | 45 +++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmh0101.dtsi b/arch/arm64/boot/dts/qcom/pmh0101.dtsi
> new file mode 100644
> index 000000000000..831c79305f7a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pmh0101.dtsi
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus0 {
> +	pmic@1 {
> +		compatible = "qcom,pmh0101", "qcom,spmi-pmic";
> +		reg = <0x1 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmh0101_temp_alarm: temp-alarm@a00 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0xa00>;
> +			interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +
> +		pmh0101_gpios: gpio@8800 {
> +			compatible = "qcom,pmh0101-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmh0101_gpios 0 0 18>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		pmh0101_flash: led-controller@ee00 {
> +			compatible = "qcom,pmh0101-flash-led", "qcom,spmi-flash-led";
> +			reg = <0xee00>;
> +			status = "disabled";
> +		};
> +
> +		pmh0101_pwm: pwm {
> +			compatible = "qcom,pmh0101-pwm", "qcom,pm8350c-pwm";
> +			#pwm-cells = <2>;
> +			status = "disabled";
> +		};

Any reason for these to be disabled?

Konrad

