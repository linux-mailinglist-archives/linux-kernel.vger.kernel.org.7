Return-Path: <linux-kernel+bounces-735203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1696FB08C1A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5971F188BB60
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC92BDC11;
	Thu, 17 Jul 2025 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jAt0LGkS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8B92BD586
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753153; cv=none; b=HM3zCza/RktJxRhuQCF70+rhwxg9mttuIKMU2vmVlkyUtfEMXDsErBgAeA5X87mH4OYfm93MqUx2fI7mY/qYeHMKvvauo1+RLWaMiBICaAMb+veb8+1tOGYkr/Wii8uXf2zIoEa6davaiow/264T/01skpDp0N7lfWah2wofZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753153; c=relaxed/simple;
	bh=JhYxfdlFBrgBJs/tk2SA7Oedtf+sGKDg3q3NMifzV6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbT6wcWiRzSaxd6kSU6rrvk5NJWdgnZZlVkI1ZI4MeW1o7tlkKOylyp9n/KlDPUXANldisZHl1YT0v2Xzh4fC5u4Q0k/YNZcexLCR/fIgrUQA/qWpO+oiE1k7FNT77iWtCx4LKP2n+4pTD8dfDswuV5sUK8QIfZTHZJTvaI/esI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jAt0LGkS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H4XZXm015642
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:52:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WZVGQnL5TZo99a4mnnswTTOdpwcB5rmoTJT1t4G0z/I=; b=jAt0LGkSBPvwMg3V
	FvC9NZYuq2vosfYQDNrxR9Y7DZPBHxBFTmPd/UBx/Td2R8TKg1jwg8gOMIwOx+MU
	A3h1+Fj5rymhZ5wKlwJ0BRIMoqB01E5jXC996ekTd9mupCtAfVWgh9gxG2iQaqtV
	FW5lADnuCsAKof2+kQ6JJ80/0M1yNbQWj0D1gTY37+64By3DgGvLpy9XUlHy4eeF
	+OxsIMYUoMlDyov8+/le1F/rL5Z4uX8eXWSvjdi03Qb6w5zvPDYjKUwJUETJyN1T
	CS4K+XcpeOQSg/XNZk51Wp1Y41sh8N7am3UgY6Oh3j5bxgAxvTfw/cvtowWoZUam
	sout6Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dytew4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:52:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab7a01c38cso1796031cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753150; x=1753357950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZVGQnL5TZo99a4mnnswTTOdpwcB5rmoTJT1t4G0z/I=;
        b=U4bHxQDXYjxAvvVzu7oyXCEBydY639TxHiOckwctH3fKwVD9FGCRDUZySnfLF+Uc3h
         RiOdDPG5pbWFuojqQko36FVxjngX0h1hFTebMe5SmJ9qg3zVlC/2Gna8aNPCkh+wlkL8
         mCUNC7OipdnOLl8/rPbq7B/SN9t7y0LvKvG9i14m7Kg97I8F03C/YASxGKhSPIOkiHjx
         WOJt16dbUXYaEsA1U4RPMYXjMCPfgklCnrZmHmjd3ebkXfv4Y7bdlQZhr2AErdStj4/R
         nM7FUb5xJcUCPnoJ0YmTtvNbJlDy7aEkNg6T3G864CFt3MdWGvr9u7DtcowgCoUEgZmK
         eZgw==
X-Forwarded-Encrypted: i=1; AJvYcCWjDQWwzjxhGV7bDqA00ZC/gAKUTvPPvTY9pY/AZkpyz6DMOgeUlP4giLp/z4bzAqSw2dHt/PBuDyLsnN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOzMjl1F7SJz9VnUtuEFdEL396QxEoCYC7Tdvt1Duv+TYFIysU
	EqdOSnDBQiv/U+ooKNU7HboZxRd/wOnn50TlwM+rvQ8MP1D6YUz6yaS54DFgOn+m6WpLckplfJ4
	WLRG6JoAKOm1dnlxOPKIqhM0kq89FzbGFVulMbf7Y7uTEPbkLsGcqpeMEjBEuLFysgE3MKtbzdZ
	c=
X-Gm-Gg: ASbGncuEVXNUgikfQgQWHIkCMpojseLgaNtfCJBmAhkhkva9iMDEwHLW2ButTBJpGtt
	k2IqJHUfavS7LWsf+e4hvaPB002rnsRIYk3EGANiYaFhywcnc4YsnyPXo3M+oWO7eCNIwyVKpWe
	NTExRBQoEt0EIyZ3i3P4BfxvxzNR/ColAea21CCMf6tsAKu88nIob1quLjYYGfARkOwgYvpZ9mH
	AHtVSCnhbDvgjtu458RBs9oiUahflztJsQE8/n3QpE2UeZvTXRHl9rkuxbbaOx272LOIwbSpNxk
	I8u5IyVujiTizQ2UVj/Cvs9fvQECAwrUvL+NAd+y+l40GldFoxKDfV6Sn0Xi3DSavO3rk3YOpqN
	Ip1+VCjoDLPpEKt9CaBgu
X-Received: by 2002:a05:622a:1889:b0:4ab:76d2:1981 with SMTP id d75a77b69052e-4ab90a4e458mr45118421cf.5.1752753149737;
        Thu, 17 Jul 2025 04:52:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuOt8ES7BujIafZFzB0IDxfkg7AjYigc52yOQaSQVHFHTLySwxQnQewjoSqSZcB6Uo+8EkFA==
X-Received: by 2002:a05:622a:1889:b0:4ab:76d2:1981 with SMTP id d75a77b69052e-4ab90a4e458mr45118231cf.5.1752753149235;
        Thu, 17 Jul 2025 04:52:29 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9734069sm10024385a12.48.2025.07.17.04.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:52:28 -0700 (PDT)
Message-ID: <e69e6128-3f50-4bd3-89bb-09d7b237a568@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 13:52:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add glymur pinctrl driver
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>, andersson@kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250716150822.4039250-1-pankaj.patil@oss.qualcomm.com>
 <20250716150822.4039250-3-pankaj.patil@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250716150822.4039250-3-pankaj.patil@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ePHil95fPxILEBH0rUtHYXtypY_Kizie
X-Authority-Analysis: v=2.4 cv=RtXFLDmK c=1 sm=1 tr=0 ts=6878e3ff cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=-TUSC38FYRssDIeIjfMA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEwMyBTYWx0ZWRfX8kSY864FlJAw
 /xY50dEc3dGwvT6ikOLSotHhyvaOl+tGvaN4ptsTP9w3JLqHBJa/5PjIciyPJkkhGL3J+RjDU4P
 +dfMp1XyYg7z2mFDnk3tVE3xuG/PdUw3oK5YH8SRVGHFxGAOwRvQZ8O4c9jqxL4yO+98dRQh99A
 7GZhVvzsQVXxb4YreopwC+j01hZQhrlF6EF9kg0geN6ZXFQPww2cKgVyBZhsMhpKGHXtM+PcqqB
 V6S3Y4KK36sTDduEMpH+7C5gbbFjxXXzFQ7yOK6fslDJCYHlRGcbXqAN7ttMwb6lHQNw/rvV32z
 pic5Ss2BUaLtxNRZ4fk3Pnv+wFAqkJDsR+z/RLxxAijtnYBfqCctGD7UpRsnXxPsKLnXn0GnRyg
 kXjwJzNoBKAbrfCJw6CRz2vcnmOfGDIjLB9INPvYC33/ZwkaXdjLb0LtPASLhikR0Ijnujjl
X-Proofpoint-GUID: ePHil95fPxILEBH0rUtHYXtypY_Kizie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170103

On 7/16/25 5:08 PM, Pankaj Patil wrote:
> Add TLMM pinctrl driver to support pin configuration with pinctrl
> framework for Glymur SoC.
> 
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---

[...]

> +	[249] = PINGROUP(249, pmc_oca_n, _, _, _, _, _, _, _, _, _, _),
> +	[250] = UFS_RESET(ufs_reset, 0x104004),

You'll need to borrow the #define from 8750 pinctrl

and then:

UFS_RESET(ufs_reset, 0x104004, 0x105000),

> +	[251] = SDC_QDSD_PINGROUP(sdc2_clk, 0xff000, 14, 6),
> +	[252] = SDC_QDSD_PINGROUP(sdc2_cmd, 0xff000, 11, 3),
> +	[253] = SDC_QDSD_PINGROUP(sdc2_data, 0xff000, 9, 0),
> +};
> +

[...]

> +static const struct msm_pinctrl_soc_data glymur_tlmm = {
> +	.pins = glymur_pins,
> +	.npins = ARRAY_SIZE(glymur_pins),
> +	.functions = glymur_functions,
> +	.nfunctions = ARRAY_SIZE(glymur_functions),
> +	.groups = glymur_groups,
> +	.ngroups = ARRAY_SIZE(glymur_groups),
> +	.ngpios = 250,

251 (0..=250, incl. ufs reset)

Konrad

