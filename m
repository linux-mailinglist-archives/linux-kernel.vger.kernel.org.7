Return-Path: <linux-kernel+bounces-798334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D44B41C73
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF8B1BA64D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3BE2F99B0;
	Wed,  3 Sep 2025 10:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XL9JUpZ+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0065F2F3639
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896888; cv=none; b=HWR7xv6UA8HLsA78iUl/0zz6rkWlAPF2QnBb5KQ5LxmcJTeuqCTpCU5Zleqi3E8bKP0rX0Iou/PdWCBCHVFnj3eZKaz847UQMp8bz/ZFzH5AMdl3EHA96LFzK6ZDZRatcLhkALKVIwmnae5WC2VV8i9dthZAWugVJSNOr4/pVPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896888; c=relaxed/simple;
	bh=Tm+ubvDpNij69TvVH7w3Pi5cDsVKJICM7WBgBpUCufU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2Mi4EN6kY+KfTEkWL3Fj25si856M48Be+Kl+6M8qsLdBk6rIkP3eDrsqZPqjxUt4ZKIumxOvpmdgpH5GHflfGppVxGPk7cZzDXN8DwV2evwlceWhAdyu2XggjXNzMt+NOBBf5HN9fpJEpe300qlGGlzxXlO38hImNWJAjb2z4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XL9JUpZ+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583AB8Kw021832
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 10:54:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SN52Stku6irzzygye658oXiBDSvkmv+/53cdsuo8Qoc=; b=XL9JUpZ+VtDwPbNG
	R12bsrBYQgiEvFwu7M6IkEk0sHMwzQjPhmsvgvSX/rcv72V3Xad3TjVc4xMZFrrF
	ly+LStev01TlDrXqB3MUO8ipPdmAzrtcuQNmRAAbaeDH/pryFP357V7OITcmz8JU
	3vIpsQjTkFotg5EFcDTtAnwa1k5tvD5FVya2qjvL0oJXNtxA9FBg/eTxEQsTN6Eb
	yOTX7AI448QwROoEYzShuS5QdElPe1Yu7fjJWYMf37V9K8cW4eGYazkhN4NMIrrc
	yREXPskGTy6/7D9GWSAiCkdz57G50OTIGECgZ07VMftIU4bGD/kgJ+I530QXQiiO
	6W6O2w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s3e6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:54:45 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7148174e111so9443466d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756896884; x=1757501684;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SN52Stku6irzzygye658oXiBDSvkmv+/53cdsuo8Qoc=;
        b=ZQ+W9BxhDlbG4N2ADTTIYHSna4Kd/qEROos4wrlclWhfZ+jHPjBvkUxH+8xMmR4kAV
         tARzWqXoXJKbp3QXMKarrqRCU1CY50y5xPX/2hmHN4tPkWVa4/erdlO7YX1m2b21c8RG
         Qe7zreWj93J4rb/iX4ClukzOm0LF+nlFS0DeHCshmy4LfV9dYCM9EgJEezqMPaoLH1DT
         WvMt/elFCK2ZGNIT1dGDJWJBQiSjdmfNKz8Hlb0QQ94iwQqeepRMCDIoGXYCMZ3AyFhg
         IxlESjnor2TRf+MRXta4ueTAcgzZjj0uJp6jIloitMY0wBkV+7b0V8MvROGRkvVPirJB
         BhXw==
X-Forwarded-Encrypted: i=1; AJvYcCWrrFHYFrpClnik7DnKVhT8XFT9WLZLizLxliABJVuYuVXfN09wjlTRiZQac5Rp523BOxeezv1KsPPZrDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKtAtGWdS+IcVMzVuNDcRm70fnFlS2cmoPIYCjnW/74kaKVnQB
	10l6zO8+X7u1LeS46SJuNRITiux/2go05xv6k6FacZsS1ftrhsPn+9FBuspOb+Vet8VBIoC1VpU
	I4sLrIlkMRIL9npJ+jMKfIZyzLccC9eL8hV16Zpd3oyJ/vhuSzhVy+hFZprK3Td0TegA=
X-Gm-Gg: ASbGncvknH3vvz+N1EsyCqFynbifGWuvDR5rnHtyHo+Z5vrJD1FFGIaMbv1Gnk9FGcJ
	3wgS/zPvESmhieY8vTV5oW8c88gt6yLawmGSd0JMJ+eeP68mrq1Zvfds+MmrLKZcNYSM52Gmqyk
	5qcmcqBEMFaylwvyOgCi9TrqeP0RxJwozKnQWEvy8CyGFXsbztzHm6T9Gvv9z7c8boSh4/9JjKY
	efiTYNd5ydKI1g6PAFBi/+cZdtOApVjI3ipommVkkV/NzbF9RV5Mu7yeDpPTZfB3wbLSeoP+9o7
	gC0VlvIE5ar0h4yIN2SZUjprOg7D4xD+QX0lQ5Zjz2Kv4SmHtmccQWXmh1LuVpTzFgMyBJ+xChZ
	E4ntRBvbP40+HCxgpbvG1AA==
X-Received: by 2002:ad4:5743:0:b0:707:4eab:2b5e with SMTP id 6a1803df08f44-70fa1d92d30mr148150816d6.4.1756896884460;
        Wed, 03 Sep 2025 03:54:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEetDZkFBnEZJ/kKVop60xaty004rw6FYmAAfEqO0MuEDwRglU3hRd6MaQX/oR3QxdMGUb85g==
X-Received: by 2002:ad4:5743:0:b0:707:4eab:2b5e with SMTP id 6a1803df08f44-70fa1d92d30mr148150266d6.4.1756896883912;
        Wed, 03 Sep 2025 03:54:43 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61ded4749aesm7462141a12.32.2025.09.03.03.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 03:54:43 -0700 (PDT)
Message-ID: <6083a6b2-c5cc-41f0-8026-e022f2f4eb38@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 12:54:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/7] arm64: dts: qcom: Add initial support for MSM8937
To: =?UTF-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Rob Clark
 <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, iommu@lists.linux.dev,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org, Dang Huynh <danct12@riseup.net>
References: <20250831-msm8937-v8-0-b7dcd63caaac@mainlining.org>
 <20250831-msm8937-v8-5-b7dcd63caaac@mainlining.org>
 <67aa2a1a-3adf-4c97-a7b8-865b5ca3b17e@oss.qualcomm.com>
 <EA8D417C-9B17-4AA0-A448-316F8904AF90@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <EA8D417C-9B17-4AA0-A448-316F8904AF90@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX07r7I2KWG21P
 d5YTLaBcj94qCZbTgq+CrtSlVoh4fUzfu/3QnAmRG6JSNFgpq0TbIMiSfEAAGPNBd1hFNal3WFW
 c3e+6ZwE5djcA5QQoLoUs5jhnM+ozogELAy1Ng/xC0lO6mhnmtDVVRNliXmHYoDIOEtgLrAQSVI
 7ApPrT8nDB5KgsPe7da8HFwepxyeAJZOInhMVxvsWpoA+0qipWSX/JgQV34vHjIzn0TFv6ppYes
 +5jBQt1fnpHga4OVmVZ1aWh6+ur4ei/W6BvjI4JURnI3vFKdqfFCmJXRW88ReqUTxu1gwt0+0Ap
 Vlwcpm5Z6vp6xJPKLVLuWHH5HiDypr8+/M5p482z1P77POjLRHrw/LOLfs7EobmDmqglwb/d/OS
 CgJiIoQy
X-Proofpoint-GUID: -9nSBtfRZMZtWfnM3ve-I5V6JO5k_ec8
X-Proofpoint-ORIG-GUID: -9nSBtfRZMZtWfnM3ve-I5V6JO5k_ec8
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b81e76 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=bBqXziUQAAAA:8
 a=OuZLqq7tAAAA:8 a=G6GrHqeLqaT2Jh2KzrsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=BjKv_IHbNJvPKzgot4uq:22 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

On 9/3/25 12:47 PM, Barnabás Czémán wrote:
> 
> 
> On 3 September 2025 12:42:38 CEST, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:
>> On 8/31/25 2:29 PM, Barnabás Czémán wrote:
>>> From: Dang Huynh <danct12@riseup.net>
>>>
>>> Add initial support for MSM8937 SoC.
>>>
>>> Signed-off-by: Dang Huynh <danct12@riseup.net>
>>> Co-developed-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>>> ---
>>
>> [...]
>>
>>> +		qfprom: qfprom@a4000 {
>>> +			compatible = "qcom,msm8937-qfprom", "qcom,qfprom";
>>> +			reg = <0x000a4000 0x1000>;
>>
>> here you reserve 0x1000 for the qfprom
>>
>> [...]
>>
>>> +			gpu_speed_bin: gpu-speed-bin@601b {
>>> +				reg = <0x601b 0x1>;
>>
>> and here you make way for OOB accesses
> Ack
>>
>> Make qfprom length 0x3000 with the current base and the gpu
>> speed bin should be at base+0x201b, I *think* (the docs aren't
>> super clear on that)
>>
>> [...]
>>
>>> +		mdss: display-subsystem@1a00000 {
>>> +			compatible = "qcom,mdss";
>>> +			reg = <0x01a00000 0x1000>,
>>> +			      <0x01ab0000 0x1040>;
>>
>> In v5, I pointed out the size of vbif should be 0x3000.. and the random
> Where 0x3000 is come from downstream is using 0x1040 for vbif.

Hardware documentation.

Konrad

