Return-Path: <linux-kernel+bounces-868329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B61BAC04E7B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3A9B8344D4B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3E32F99AE;
	Fri, 24 Oct 2025 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fHs5qyfc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2085C2F90CC
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292798; cv=none; b=WsU9zCaLCom9nwCsbcEvU041rnDNUyx24jCIlo5dhdKHfI32BgiW05IskFk+FTlBisj3+4MzcZUo3ROEl+GogbrJzUWnY5f/l0bJJNbSHNsm3KMUfLacrjDXBQtQo21wA3kEUythb8am22iunk4qdNcjIeQjMPdkwy9hLWqjKfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292798; c=relaxed/simple;
	bh=9qdzKkUxNwidtGg5qokIRznrRuUeGNDdt4Ipztm1jJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvbgvErYyM5foV6aqu4fSz7P+ysDFnyMea5bL41xn8u0KbUYsFUUGK2uovWBhlgP7lJQPnGyHys3JM8/8PZOC8FF68UuJHadv+I1FUsTolbEyTeVzLsTd1d6ghmlrT88kwmN3D8Ii6ij2lRB2Dc+T3jpkd7PYXkmzcYiUyzlT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fHs5qyfc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3Fg3x003894
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fuIyGKnq00sfHTyE/opfe7bmLAvpc40709+4IDJlYKQ=; b=fHs5qyfcJixJ/hon
	pAeUe+dzu+VSHymPluV0BQnzsGcUrtfYCzT+3IbnK4a/S3H7bT3fRffpMxHO7oCO
	JT1dkGsy98MDLYtwLovkSNQXmUYQFRoeowWgtr/y6qbL+SV5Drs+G5sBJV1Hi8kX
	VVq2gryAGNEgdLc67HkO5i19PBqm/STA2vhmsFu+DKyd9JMq9BbYA0xj+UMWNyUG
	QvwgR8CVdRV0rwuawxrYGxoH216QK1qaXXfh6ubeaQet7QqG0H0omSPuAnjLRH1O
	kLsTta464MPdT5irmdI0VjnqS8eWoR6n8vevrHYVCluMJq/MesAZW801+7rZnUV6
	rFfQfA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2geb8tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:59:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8afec1169so5153461cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:59:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292795; x=1761897595;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuIyGKnq00sfHTyE/opfe7bmLAvpc40709+4IDJlYKQ=;
        b=OD3j/N2gGgfLQruoZwNHNIJ1mDkSqH0LqPy9PBPELoxZka5WFBX9PO0ZbdUPDRPgET
         6Gtl2EJtEWferDpRAVkxxNrlIQVutpt2JbGP+x2eiPeKOiz+J2aamP3iFZAyWF4hOfrM
         IT9XvNi3ooBd624pk0gq9e2fqoRv7xh8zip2NzI+wsslbyCXoWJ1KwU1cTWkNfgG60wP
         OkYp1MOIXXURv1S0WkBYUt+p99kQbMRhQIh0zcOXRtElXuwV8Gx3+s7X7niSAgwMURl6
         pkAupdedgA22nrIIqOiEXt6tvtdFht9CQifLzqvVUN4YadUsq7GvxoZ3xdO6pGIKg4eI
         4ksw==
X-Forwarded-Encrypted: i=1; AJvYcCXZx+TXrO6gUEmABr63DVfX1NMthNEFAtI6Aeaah/UaZQaKCWWAliN1UPk4rnUOcLzB6m4wDYQ1fP0TVS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3S30FGHD8iHF4+YTZlfRi3K24hjldraQFSrPjLWNhBSicMzVx
	8gq+HAAc6TO8KvOFV1tvPQs/6fVqAVB6+eByLLgnNNwNpFjo00oIUxVseSOzhqFiG8cMFfifzjS
	3SBIre5c1DKWNSvSJzrLKXIIJ2fRMvvKnsfC32yYAt2/T1vja5SR1aEyAqI+8j79Bw9I=
X-Gm-Gg: ASbGnctUwR+GQqqZynxeZoF5NAt29U7xL6xApg7uy4Xvpe/kwnwyj+JWWM6ImNzqT1S
	9NeQZLvWlI24ex3w1zBJIdOjq9x1GrQjK5HjwBLng81Mq4XL+OKmK9Hu4oVSRX0tl8IdH57CRwp
	y8dWCVqvwIWd4pBfX1X0BldpFWOvf/+pFS1aEbVE7MUCwSiEqmHy6CI+Va/5LlX9qs/QYvQlIa+
	FDr5XK39GNlq0gmaof/ztVICcMpPsE6yLkpOP9nrnBehtxAMnElkpwsw36I/la5/e3m+LCoPoJn
	jAy8sGNas4ytyxv5FMmnOb+FBg/6fWNekXPxmZZyNIEHk0ve2Z30wN+HszaYf8fw9M46E14PPCD
	0ENFmz0DDI3PLKAdUF9cJX3RkF5DLImTnBWC7DMH2etjlFwcKSJkBQdPF
X-Received: by 2002:a05:622a:1a0c:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4ea116e2fb8mr114380581cf.7.1761292794874;
        Fri, 24 Oct 2025 00:59:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrPmBQGWI5ofRE81ElAyZ58hzjoOsMkKuLVYPW5g1VjELKe0SfysdfObTDgxtmAz9Kjx5wLw==
X-Received: by 2002:a05:622a:1a0c:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4ea116e2fb8mr114380371cf.7.1761292794282;
        Fri, 24 Oct 2025 00:59:54 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d5144efbcsm472338466b.66.2025.10.24.00.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 00:59:53 -0700 (PDT)
Message-ID: <150836aa-b69b-4dfa-8118-4c32f181e03a@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 09:59:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: qcom: talos-evk: Add sound card
 support with DA7212 codec
To: Le Qi <le.qi@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com
References: <20251024023720.3928547-1-le.qi@oss.qualcomm.com>
 <20251024023720.3928547-3-le.qi@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251024023720.3928547-3-le.qi@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX+O6/LH0r5L4Y
 n4VyLIoMH4uSjqE68Z/m9RCjOf11MQ+6V6O2iwBREAsEua/8jrtI41xHbJ8vmIJNpk8RXziaHR3
 COO4d2M44zPlzw1XGiAUbu7GQh1Sx5JbfiRo1o3CnvfvEoEM+N5naC7RwY/1hgTEI06I8rknLX1
 XZ4gLyTDiglX1wc/T9X6RFsgh3IgJVZqoac5cAUBBN7Z1M/Ey6r2xgEcz3a0ajjW6/pDyf/qJq7
 zo19uEjhUqFlTBMk61Fe4ZNwd++J2KboUfu6oCazMSvpruHEZLgBzqt3P5qDmUtmgC1QU468Crw
 txwNcgOn5CUBQpWdXmYD50JAPPEljSj3TDz1CI18ie1dYroeu9p/QjFCCOd1D2sCGPUsW+xcnXi
 6E7J+uJVT7w6MeNVoxZJL17h4/hGdQ==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68fb31fb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Q3T1G7DDasfguL93IWYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: eA2qiHsmInBL7ib8W8huciMh0SZqeCKJ
X-Proofpoint-ORIG-GUID: eA2qiHsmInBL7ib8W8huciMh0SZqeCKJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

On 10/24/25 4:37 AM, Le Qi wrote:
> Add the sound card node for QCS615 Talos EVK with DA7212 codec
> connected over the Primary MI2S interface. The configuration enables
> headphone playback and headset microphone capture, both of which have
> been tested to work.
> 
> The sound card integrates:
>  - DA7212 codec on I2C5
>  - Primary MI2S playback and capture DAI links
>  - Pin control for MI2S1 signals
> 
> Signed-off-by: Le Qi <le.qi@oss.qualcomm.com>
> ---

[...]

> +	sound {
> +		compatible = "qcom,qcs615-sndcard";
> +		model = "qcs615-snd-card";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mi2s1_data0>, <&mi2s1_data1>, <&mi2s1_sck>, <&mi2s1_ws>;

property-n
property-names

in this order, please

[...]

>  &tlmm {
> +	mi2s1_data0: mi2s1-data0-state {
> +		pins = "gpio110";
> +		function = "mi2s_1";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +
> +	mi2s1_data1: mi2s1-data1-state {
> +		pins = "gpio111";
> +		function = "mi2s_1";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +
> +	mi2s1_sck: mi2s1-sck-state {
> +		pins = "gpio108";
> +		function = "mi2s_1";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +
> +	mi2s1_ws: mi2s1-ws-state {
> +		pins = "gpio109";
> +		function = "mi2s_1";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};

You can group these together (i.e. create a single entry with
pins = "gpio108", "gpio109"...)  and move them to the SoC DTSI

Konrad

