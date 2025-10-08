Return-Path: <linux-kernel+bounces-845248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD0BBC4269
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982DF1898C56
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DE82F5468;
	Wed,  8 Oct 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jpRRGqoT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3F1339A4
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759915505; cv=none; b=aXyi0HC0A6eN+xhy7mcP4nOmIhsFNy1zSMMKFLBzE/uzIummg+5zup/BJ5e7Iz+Qwr9CM0w5wRnQoK50sVanlxhYpyNn4DCL2pYFA6IAUTYxC0G9bmagzJkWm6Yp0Eym6dmrFmJjvL/qHmmMhfWZUgnZmJGOh4BM0UtuqimEbSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759915505; c=relaxed/simple;
	bh=O6qH37oakVwtaoNReKarYY9VZ2pTe8/oJBJaPMHF0Y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0YhGMreG+c8Zk2xjQjnE+sGPrjuoEnTxKeOpfhSGVkSR9qQy+ufaCZ5QYJh5q5saK5e9h9POuBL9td/lLT6oIMiPevNbXpDxz3rZeUWtASR2qA21gDc+PUrgzI7usOLdJvKeAgjUUZWloOfxbzJT22msEMdfyPImQ7FSouIiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jpRRGqoT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890TiJ028979
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 09:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L95f1zinJTN+46hqsd1dIKLTDhMuPjf5VhEFjeoH9Bg=; b=jpRRGqoT+H5Qg8hL
	VuAWX6QnpzDcT893J3lXgIrEKENzGBhotyOouVCNa+2GJXL48gLRDJE1oQ06WQuq
	7Ht/XRo5owi7cUcxKA5eV3vrc6SHRO5i2QHNyPRTvGwHMQdXnRB4xex97oSE9JFD
	7aKb1YB4LiftcCLZRSP0oebgOiZP6klRFRMHNjM/5r+GFPQLgqLzNK0wJIx34x3Y
	DmqGnTxTLY3j4zEGVpLDrFdKfDP3yMDjupGMWEO8rz50BEqPfmjDxcS84UIYZBCG
	KPm+lTGDrxhhpoGNPH68PBsMpradQjquN1s3mllqSP9RIgk8DWg1gldvljnOIVb7
	JZsaeg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9e23sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:25:03 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-879fa4a2989so7395156d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759915502; x=1760520302;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L95f1zinJTN+46hqsd1dIKLTDhMuPjf5VhEFjeoH9Bg=;
        b=SbPNUfj5dWtmDHw+WDJWxkJng/rSZMzIO+vuZxlvGTIWYctXfxOEWJkZLgLMhkRot0
         u9IbzmELwB0UrIxzYwz7EfLhDz+AVMC1GYV6PFlJsaUdRduGJwqmX9q/L1y3VW0bjmrb
         UqVBWklFTVpnUJNspvTGI6UNBcf9vZgl/KQwGEVZZW5GsgLbPryGo4YXKK3uRst+aki4
         s4WpueMByiLtJ/5lRLPirnfmdPPbiYP6adA/36QTGsL9D5QVuijxRjc32rFTURUViFCK
         rzhyYYbtKIIpxDYnvfLjc7Moo3T3KddBZHhZXYQOZ0lkdV1g85vP5viQPrkfzAr2ohM+
         409Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNnr79lUoJmrquxgnHjx2ZUTl4iSfxheNONc0z6BwyOoiWkf5/DMPHrFIbUL85LNKJ9COfu3hiN0Udah4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfqzyX/jMxlmpTWIGR0GBLBDOc9cbhR9TJGnEBdG7MtrHuHbY0
	D9UDkEG14D9KV+LFaLCi2GpUEp+cECm5d4X1+tFgFkBSlim3oEuqZbeZB5BF72OaPTnpUKegrCR
	PD7v/3SyaiPAPgxZsQbr4NpGEX3RGQvr9IQBRuRq8zltCfL0XXjdhKxkTM3nKt6SkL7w=
X-Gm-Gg: ASbGncslvSPhEuj1FBsWUm6v68DqAx388NCTIFlYD/HvAoUnOvqQy7wFcVxmHAvSsEE
	eSIcBIfM1hF7h+nV8dTKJ3uOwnz6a4V2hoCOqoQA/k0jDrXKzKqcAjsP5jT1niKtifWZDyNFvNw
	/rcHwvCrciVpG726iRd3kQ7N661DkRiUVuiHpqB7cGFy4ff22PU6aYawiLXK4wjYpF8sJCGBjLE
	UxStU91nN1I8BP/rq4SNmSAvdGA/5pMpO1nlLRewMMJ+a25t6qZVy45lDCsk6LQms2lxM0EVFaS
	6yMgYZKTKZ9pCCW+GBwrW0QA5TNwhTYBMW6acSbDEQf3Wqcc1udtbr6rTG4MJxFYMD+RsvM6SXh
	ir08DDoX3eXzxEitaOCEq3Lc8j/k=
X-Received: by 2002:ac8:5991:0:b0:4dd:1a2f:4881 with SMTP id d75a77b69052e-4e6eacb81b2mr24861961cf.6.1759915501944;
        Wed, 08 Oct 2025 02:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcl92uBxojrfpj2u3iG0FrNl5442DC039WyNm1j68+Zrj+5/i7kVxlNXd9GuFYpT6YjzjlSw==
X-Received: by 2002:ac8:5991:0:b0:4dd:1a2f:4881 with SMTP id d75a77b69052e-4e6eacb81b2mr24861671cf.6.1759915501248;
        Wed, 08 Oct 2025 02:25:01 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3b8df3sm14262621a12.13.2025.10.08.02.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:25:00 -0700 (PDT)
Message-ID: <6e5f63d1-8e07-45dd-8e98-6d843246ac59@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 11:24:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: Add support for Huawei MateBook
 E 2019
To: Jingzhou Zhu <newwheatzjz@zohomail.com>, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20251008015404.4906-1-newwheatzjz@zohomail.com>
 <20251008015404.4906-3-newwheatzjz@zohomail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251008015404.4906-3-newwheatzjz@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e62def cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=-X776dc9t37Bx4c3_TkA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: AoGkxFI3eQgQ5iarEqUAOY0JaruMNSbM
X-Proofpoint-ORIG-GUID: AoGkxFI3eQgQ5iarEqUAOY0JaruMNSbM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX2G3mMBuAwPu+
 tjovnRwZjaCR99dv4hUfh2zEFIsNooacC0PaSoVJReBOvjdMwuStEsFS1Gh/euZj7Oqn0//t8vq
 QIeInvL4e5Afudb8mZueMw/x+qVubK4+beaf9Di+S5r8/Ye5vQpR1AF/iOgrx7iZao4ce7bZdyM
 m6mxKf5BMG6dnMuWPCbSxUs14vQl2OdZRChFECgXD4hscfoeR28GRZNtsSuKNVT8v10mueyt2tA
 rwKdvo9wCIyhSY8w2/CJFHRKoJQ3I3B50zfER7lJrTYQmtJxwbSXJj21UWZ9RL9m+DxRoR5UkJd
 odHTcSmfCtiBuWEcEPZ1EgVXszP2I6z28rZue/zmw542qwgSt7mvCY75Ci7kozQfWM8kznI0hVd
 MrLf1bEeauoae59G66flNHkEUcKsQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On 10/8/25 3:54 AM, Jingzhou Zhu wrote:
> Add device tree for Huawei MateBook E 2019, which is a 2-in-1 tablet based
> on Qualcomm's sdm850 platform.
> 
> Supported features:
>  - ADSP, CDSP and SLPI
>  - Volume Key
>  - Power Key
>  - Tablet Mode Switching
>  - Display
>  - Touchscreen
>  - Stylus
>  - WiFi [1]
>  - Bluetooth [2]
>  - GPU
>  - USB
>  - Keyboard
>  - Touchpad
>  - UFS
>  - SD Card
>  - Audio (right internal mic and headphone mic not working)
>  - Mobile Network

Just some cosmetic notes

[...]

> +&pm8998_gpios {
> +	sw_edp_1p2_en: sw-edp-1p2-en-state {
> +		pins = "gpio9";
> +		function = "normal";
> +
> +		bias-disable;

odd \n-s inbetween

[...]

> +	mm1-dai-link {
> +		link-name = "MultiMedia1";
> +		cpu {

a \n between the last property and the subsequent subnode is customary

[...]

> +	slim-dai-link {
> +		link-name = "SLIM Playback";
> +		cpu {
> +			sound-dai = <&q6afedai SLIMBUS_0_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +
> +		codec {
> +			sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 AIF1_PB>;
> +		};

'co'dec < 'cp'u < 'p'latform

[...]

> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <81 4>;

Would you happen to know what these correspond to? See e.g. x1-crd.dtsi

> +
> +	cam_indicator_en: cam-indicator-en-state {
> +		pins = "gpio12";
> +		function = "gpio";
> +
> +		drive-strength = <2>;

strange separatory \n-s here too


lgtm otherwise

Konrad

