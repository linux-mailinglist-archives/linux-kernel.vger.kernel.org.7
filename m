Return-Path: <linux-kernel+bounces-832296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1D4B9ED7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09A81B2315E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BCD2F5A33;
	Thu, 25 Sep 2025 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BoO05sa/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF81D63D3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758798044; cv=none; b=d0M3AttF2lhLQ30MrqRjBqyj5UuDqdCgUljZA55X4S1Uo75Oc5tNHUsLDXe0xOcKyzCVeRsqY2GE/5rfUX7BemJpWwkQZQ282sc1qHdjr9iyk7PqQ8fljserpDzDlCP22adcWZXEqTm5tOiweZy1vdwcbWF3rFlNKinfAXgoQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758798044; c=relaxed/simple;
	bh=C7yv9vmaySIkzOsYJRsjKstA4ZBNeuwL+lps66HoOgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qf53IsnxcbksaCXPHennDYVrK0IH2oGrGiCefaZP/9UBAqM/996SWHs5PtY3Vky8uCVj92WHtc+rlMqANrEQQzP5rHAedQKljbnnWgHkEpWehSS52QdzpXJ1C1q0qZrvqIhMlDpMvsSidv2LbU2/XHoJQg5PymjCu2hCI4v9rN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BoO05sa/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P9aWmk024258
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QCczuwq8vr9YM4JhxuUK+LaOovpLMWMbHg4KcBFzT/s=; b=BoO05sa/um/OUG0k
	gPPpp6kRoYTkvM73qDL/lqpNXupAlad2k5rvHNf3OaKwA+4r877/3obWIZenfcUH
	pWsJxWaC104uQ5XawWgG6vLm17uAQxRWcyTpcL6xDH1lnkgYPVv+sAVEZq1U0C7r
	yn6imv3QF6G0CihYoGkACDODQNEdgdM0M5lf1jDJ+BYh/Nbk2m0kGj0Cl0bMhy9t
	NzZE017ox8zApqpI31yy/yd3EOaPpzGmUsGR7XuYEyOE+ltdQFS7QrBo3M027wbA
	0MTUOuVTlAeuypaeC+/M+/R0xtoikRZ4m5C0HVY6xYqVWkzHbztPXAmkIF5pxEf0
	GbDCHQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0euwy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:00:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4cb12718bf7so1820281cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758798041; x=1759402841;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCczuwq8vr9YM4JhxuUK+LaOovpLMWMbHg4KcBFzT/s=;
        b=Gvpg+XojutxTLT9947m1XwoZIDP20QoxvPkf+NmNXI3/8XyIQauSOKS8Swmw3bA4R4
         vwgTu83AeLVCItI7Uv8mOPLzstdu00tJQLuujMmrPjjFTdj84/VpxlMCq6pO+BBXCuZH
         jOWmv3jiw8GVs5I24Jg+28pn3E99ezNHH8P8n58LIZruldppRjMwkeYYu1ZjWw5piT7u
         0Nws0Lq1ROA8hnFV8h33+N9aHlwMk3UjxoPIMLShFZ+AgeG+iZpj7uZ1s/kEX77GsyL3
         ztdqs06Nkkb+ILwRwJwMGVwTr65rjXjHtXuTQh49DYw2PEteMlkvPNDoEFywKFtWob1s
         cvBg==
X-Forwarded-Encrypted: i=1; AJvYcCV/jX8VrQsqoL0+zimwDUvKnr+8xm56MvdLnK6WfG5jz/RGlTxsPtxdn2YRD+/EauBWK/iYkM57DayH6xM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5QYV410I1+NOvgKUuthMrM2Fv1VwYIRgFhrLm2Xg2p6I+A0ih
	iOdLQADGGf+PxXIQaRE/1IjRUr8iZV/7DMZYbq2hiBPs8TkNsT08M44ZakczbwgCez8gIVdywy/
	5RhBUMOGkJcNpAWvDeMNYK/E4cMf6ujEOEkb2pcQQoI0CglJC/AJSOnIrpcjnudBWIxk=
X-Gm-Gg: ASbGncumGrySjDcGviQhQLJhFmN7hCNvz73v0b6UzXteEWFA1wHeF9od8kNKVKNoOBH
	9MthZuqPSxP5B8KwFr6T14X9XG0j8MmBk3kkwVXawrGK+mjlxE0vaoofUnXlbFi0KXJFg6H24oW
	9fgl0RbFJ4j3tVh7BEC1qSDQzUSHQiVs7BU2ob/+F10YquaX07ue6x9sNPuRG+F4fvfb87Ir26u
	X2BOE/mvaHjdSXaMm223vtIe0neB34SGAoV8NVqU/UYs0ewYIgt/B7lntrhzKsg9VgdjlZ4sfzE
	t343NWTYQ43Ajmo9TT5YtUZB7qExQOpNmyQgPWzhNPM0W+w4MCnYQS2b19mBLyZZqmIh99hfEbf
	wBoVlKKCt1enPZL6qXxCuyw==
X-Received: by 2002:a05:622a:11c7:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4da47c0d937mr22183701cf.2.1758798040888;
        Thu, 25 Sep 2025 04:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn2jGP0QZTTpMl5Zj57PzXVDu1Ub21D8fZTsyC8W3OJN86S89MQB+6pORzdjrN9SBWGtKyjg==
X-Received: by 2002:a05:622a:11c7:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4da47c0d937mr22182851cf.2.1758798039899;
        Thu, 25 Sep 2025 04:00:39 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d0d0bsm146870066b.5.2025.09.25.04.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 04:00:39 -0700 (PDT)
Message-ID: <bbef95e0-c8f7-4a7a-9687-9b8798ba70a9@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 13:00:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] arm64: dts: qcom: glymur: Enable ipcc and aoss
 nodes
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-8-24b601bbecc0@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-8-24b601bbecc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d520d9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=cNCWYwXn1kmXQoXjcrgA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: k8gpvBBRqZKrYewiEzoYoIA5gSmr4juc
X-Proofpoint-ORIG-GUID: k8gpvBBRqZKrYewiEzoYoIA5gSmr4juc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX4hzf64xUGkbi
 sq5c/3cGb/WhKrVOcH5Gl5HpN1vFCCdSWbfk2cRW9BFZcjy/1qMofVdIbGd69Se3Tm1QpA1Qidi
 i24803dvim1EZm6g1WZ5xBaMGYJlwLBnJsnxDtBxewmBBNSuboFwX0H0i6ABKBoO18tkZjM8jhm
 N64O9OeggfosdrWfGZbvVgIHtgDhGDQJbIetGLaBSgBY4ETu2HNycCujgjD4TU7AU6eRYAINqHd
 laQb7TZIANj2ulxQnbEly72l/ly/FSoc5/jEpTrvi1NyEhBI/lW1DFuVfrrvV13O7IEPIQUyOdG
 Jt61uaS2GiNHTSZ8vCnjtnSpIjO1EIPkGjOg36LPbrtqtjMifpAVa/f9WwFHyua2ZSyvEdE5oWO
 pF53lX2U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

On 9/25/25 8:32 AM, Pankaj Patil wrote:
> From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> 
> Enable ipcc and aoss nodes on Glmyur SoCs.
> 
> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/glymur.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
> index d924b4778fd37af8fe7b0bceca466dee73269481..2632ef381687c2392f8fad0294901e33887ac4d3 100644
> --- a/arch/arm64/boot/dts/qcom/glymur.dtsi
> +++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/interconnect/qcom,icc.h>
>  #include <dt-bindings/interconnect/qcom,glymur-rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/mailbox/qcom-ipcc.h>
>  #include <dt-bindings/phy/phy-qcom-qmp.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> @@ -2536,6 +2537,17 @@ hsc_noc: interconnect@2000000 {
>  			#interconnect-cells = <2>;
>  		};
>  
> +		ipcc: mailbox@3e04000{

Missing space before '{'

Konrad


