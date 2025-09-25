Return-Path: <linux-kernel+bounces-832309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4245FB9EE12
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21D9421B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E462D2F7443;
	Thu, 25 Sep 2025 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i5iBvZTa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8832EC560
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798939; cv=none; b=sdEVFfVNe//jb86vfOrnE/E11mFG6qR7jo01AcIij+vGovVqbx7h2h+Hc7FMfwLH0YelNnm/pp470lZi9gTYs1zInccJmpF7QsYs94BVvR7JmI5OI54YZrVt5LHW3QoYBFaXVGIjK2xLnpG5TDy3+JX0yclWh6xzs8OMhnUZB38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798939; c=relaxed/simple;
	bh=8k+FXLGT6BoFO4hPBZHvVkoC+FerIwEvPkkYVXLMk6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfEOnOktPU5CDl0DsKo6cZbN2pa8STWVRagvFRWTnxCkDqe8I4Ob4JTdmszCQP9TSF6XMPyeFl6L87tE30Ead6SF67yxu1MRVUzlx3MzmGmR89FkUvr/uKx1reV3XyIMJ9xvDBB5YLiQmIJMI3IYiFH7Wq807uS+Y4C3de9wn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i5iBvZTa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9gClq002400
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2yw0Z4BvPgurKhSsvw4sBg0VWbazwvxTj9AIPRCJyGE=; b=i5iBvZTaN0LGuaxo
	doG5w/3qr95jqoykLHJxiYV65mlO8W52EPSh6oLcaNehzu1SLXAU4TkDeUg1robx
	tKkWnr+UhDskDj3GafbzAGizlh/d7JBMo6ZiHAeDifFMk3vLhDOuDfL9+fpmjVFO
	3/jUC/cEbbGxMjaT8qk82hKUfYuq2lxUnKjBxaoFWLsznPXKU7GRCKBYRVHWdppe
	heNhCKRd/HGiJtbY2MUMpve7OItRcVnV1gDGQuL0OyywjFK76Lt05oGvUY7jXyld
	wWwvD6UFPJxNGUAWcOnU2dorlZIlV6Hnpr03bljpehjOw4oHu30GGtgWNsoIS31D
	6PcGLQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98quat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:15:36 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-7958a07a5fdso1112326d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758798935; x=1759403735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2yw0Z4BvPgurKhSsvw4sBg0VWbazwvxTj9AIPRCJyGE=;
        b=eJaQw0p69YYedXW1S4iYb5Nk3ApHAFVAdz/chNOutqNkiAa659YBWU5utz9U6G6NR+
         uxMmYzKtGUz6LuQbD1eUxAp+fGf6Z+u/IabRhBFps513XNqBQ+FCyq4PJ2cQjHnt7L+/
         470gWh2tnK7Y335d28FjPjvIHStm1gI4gUDeX9lBqHsgFjgYaL2nH8TF1HclOeSKcro+
         9FyRLUDVDS+UkARsRUjiog2PSEuRW104dQpP82rBlkyCTVYu6RRHqdXkFwfjUyh6GxHV
         GV2irKdwzzxG1ghAoDMQqkwl8kr5vzBytV0+1eIJH0MF9ZJRqk6XynrZ5UFntJKCyaHT
         kQtA==
X-Forwarded-Encrypted: i=1; AJvYcCV45k+am+aMm6+o+ZQRibfGZobRv6WjhvxIw6+2av+kLLaeghpP7Bjw3+Q/24rIRpyTVzYhiQZVSVERoAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5zlGX3RULg3sk78LOIo1TeJOgZhzBk55WwHLl5NZM/w1WNBrs
	qxZ3vStVvnf2Vjf4T3dCk0epzDVMIFqgk2jWhnRHsZ4MioYR/KjOc7NZD+saBUcJVRika0vPGMF
	U8nboMSYq2fNl9T+exK4/vv3jFvOBUleUqqvF3FVURs2UCXpBOMCm/G4NWFKwAH3RGXM=
X-Gm-Gg: ASbGnctkzPxMknJesTMUvtvg2PgHKvPQdBx2xPSZDpr1XJX4GlkVOFUlvwpahhAg68k
	q8Z40MTPF95VNLZZ+uCPuPpwicQqR44VXqa8zbxHhP1ldepVgbxy6HZfV00wh2c6rmenbMwQFVG
	vEfls/gMhRenQ0j1g05VB7E9jj9Qg6z5PPHQsKOiKiLrKJe969+7oQJDIwiXiEGxS8/YH0Mscnx
	BPIztSq1qL1egZV1ZxMCuIVwo0qf0WlrX67pANN0D1GCrTKhioeG4+NZle26CCgExlNX229pqN5
	AspG5cvz5TqTLCGoOi0W3ZD28TDKiRRBCycVGqfK8ZNpmlFvn2FIcLOipBB8Qs8G6YwauIV10lj
	1cnyEO/H1HqSOuPciI6kXSQ==
X-Received: by 2002:a05:622a:608:b0:4b7:9ae7:4cdd with SMTP id d75a77b69052e-4da4b6160cbmr22397451cf.8.1758798935173;
        Thu, 25 Sep 2025 04:15:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8hrH/MRJg7g0i1dNASH8E6X0SfTuOmlXLe0AeUEuIEiHICNaqbckoT8V00+CjXJXuXcjQWA==
X-Received: by 2002:a05:622a:608:b0:4b7:9ae7:4cdd with SMTP id d75a77b69052e-4da4b6160cbmr22397161cf.8.1758798934592;
        Thu, 25 Sep 2025 04:15:34 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f694fsm147987966b.68.2025.09.25.04.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:15:34 -0700 (PDT)
Message-ID: <86492536-c14d-422c-add1-a6c60a7cb2e0@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:15:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/24] arm64: dts: qcom: glymur: Enable tsens and thermal
 zone nodes
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-21-24b601bbecc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-21-24b601bbecc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6G5wvzLjYAo-Qbc6SfOK6rc50d--bm67
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX/xZTpfqjeXL1
 9Rusd1q3+KHWm0xBjG5+vXAnR9+BC1xcrAOParsofWwsEqI6WDKdjPfzjYTEBteXwQKFL20xq20
 oYm2k1n8Q3aewd7On7uGW3ZuOmSOO9brJ6fdejaqGtLVFEXuYfUeq3jmqzOddb9hFFHOAQYEDBY
 aBl5YFj0T+VEqRtMcvn7xYp5hYxS2MBKLiN7Od3//TxHfI0gF7uUApZfHqt81OVdTi0ehee+TD1
 XlR7ucOj3sgum5+aEkqZX/NJmo3OlDg7uI19uO19PY/PRA5TKtbvGy/e5b+lsal5W/xxYIMy6Oq
 0zl9d6b734W8itsC5hsRBiQLlikkQalOvsIm79yopBiAJcKr4WfxObim7cb4Lcm8PP3RYkFpem7
 sF/eFz9t
X-Proofpoint-ORIG-GUID: 6G5wvzLjYAo-Qbc6SfOK6rc50d--bm67
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d52458 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=yUpuV9ZZFvg7IC1Tjx0A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On 9/25/25 8:32 AM, Pankaj Patil wrote:
> From: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> 
> Add tsens and thermal zones nodes for Glymur SoC.
> 
> Signed-off-by: Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur.dtsi | 1998 ++++++++++++++++++++++++++++++++++
>  1 file changed, 1998 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index 17a07d33b9396dba00e61a3b4260fa1a535600f2..986dc385200029071136068ab79ff8dd66d5284a 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -2790,6 +2790,134 @@ pdc: interrupt-controller@b220000 {
>  			interrupt-controller;
>  		};
>  
> +		tsens0: thermal-sensor@c22c000 {
> +			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c22c000 0 0x1000>, /* TM */
> +			      <0 0x0c222000 0 0x1000>; /* SROT */

These comments are not useful

I noticed that some patches use reg = <0x0, while others use reg = <0

please unify them for the former

> +
> +			interrupts = <GIC_SPI 771 IRQ_TYPE_LEVEL_HIGH>,

pdc 26

> +				     <GIC_SPI 861 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-names = "uplow",
> +					  "critical";
> +
> +			#qcom,sensors = <13>;
> +
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens1: thermal-sensor@c22d000 {
> +			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c22d000 0 0x1000>, /* TM */
> +			      <0 0x0c223000 0 0x1000>; /* SROT */
> +
> +			interrupts = <GIC_SPI 772 IRQ_TYPE_LEVEL_HIGH>,

pdc 27

> +				     <GIC_SPI 862 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-names = "uplow",
> +					  "critical";
> +
> +			#qcom,sensors = <9>;
> +
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens2: thermal-sensor@c22e000 {
> +			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c22e000 0 0x1000>, /* TM */
> +			      <0 0x0c224000 0 0x1000>; /* SROT */
> +
> +			interrupts = <GIC_SPI 773 IRQ_TYPE_LEVEL_HIGH>,

pdc 28

> +				     <GIC_SPI 863 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-names = "uplow",
> +					  "critical";
> +
> +			#qcom,sensors = <13>;
> +
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens3: thermal-sensor@c22f000 {
> +			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c22f000 0 0x1000>, /* TM */
> +			      <0 0x0c225000 0 0x1000>; /* SROT */
> +
> +			interrupts = <GIC_SPI 774 IRQ_TYPE_LEVEL_HIGH>,

pdc 29

> +				     <GIC_SPI 864 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-names = "uplow",
> +					  "critical";
> +
> +			#qcom,sensors = <8>;
> +
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens4: thermal-sensor@c230000 {
> +			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c230000 0 0x1000>, /* TM */
> +			      <0 0x0c226000 0 0x1000>; /* SROT */
> +
> +			interrupts = <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH>,

pdc 46

> +				     <GIC_SPI 865 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-names = "uplow",
> +					  "critical";
> +
> +			#qcom,sensors = <13>;
> +
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens5: thermal-sensor@c231000 {
> +			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c231000 0 0x1000>, /* TM */
> +			      <0 0x0c227000 0 0x1000>; /* SROT */
> +
> +			interrupts = <GIC_SPI 619 IRQ_TYPE_LEVEL_HIGH>,

pdc 108

> +				     <GIC_SPI 814 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-names = "uplow",
> +					  "critical";
> +
> +			#qcom,sensors = <8>;
> +
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens6: thermal-sensor@c232000 {
> +			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c232000 0 0x1000>, /* TM */
> +			      <0 0x0c228000 0 0x1000>; /* SROT */
> +
> +			interrupts = <GIC_SPI 620 IRQ_TYPE_LEVEL_HIGH>,

pdc 109

> +				     <GIC_SPI 815 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-names = "uplow",
> +					  "critical";
> +
> +			#qcom,sensors = <13>;
> +
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens7: thermal-sensor@c233000 {
> +			compatible = "qcom,glymur-tsens", "qcom,tsens-v2";
> +			reg = <0 0x0c233000 0 0x1000>, /* TM */
> +			      <0 0x0c229000 0 0x1000>; /* SROT */
> +
> +			interrupts = <GIC_SPI 621 IRQ_TYPE_LEVEL_HIGH>,

pdc 110

> +				     <GIC_SPI 816 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			interrupt-names = "uplow",
> +					  "critical";
> +
> +			#qcom,sensors = <15>;
> +
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		aoss_qmp: power-management@c300000 {
>  			compatible = "qcom,glymur-aoss-qmp", "qcom,aoss-qmp";
>  			reg = <0 0x0c300000 0 0x400>;
> @@ -4611,4 +4739,1874 @@ timer {
>  			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
>  			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
>  	};
> +
> +	thermal_zones: thermal-zones {
> +		aoss-0-thermal {
> +		thermal-sensors = <&tsens0 0>;

You need one more \t here

> +			trips {
> +				trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <5000>;
> +					type = "hot";
> +				};
> +				aoss-0-critical {

Please keep a \n between subnodes and between the last property and
following subnodes


> +					temperature = <110000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +		};
> +
> +		cpu-0-0-0-thermal {
> +			thermal-sensors = <&tsens0 1>;
> +
> +			trips {
> +				trip-point0 {
> +					temperature = <90000>;
> +					hysteresis = <5000>;
> +					type = "passive";
> +				};
> +
> +				trip-point1 {
> +					temperature = <95000>;
> +					hysteresis = <5000>;
> +					type = "passive";
> +				};

See:

06eadce93697 ("arm64: dts: qcom: x1e80100: Drop unused passive thermal trip points for CPU")

It also only makes sense to keep "hot" trips for devices where we
can actually apply some cooling (e.g. the GPU)

Konrad

