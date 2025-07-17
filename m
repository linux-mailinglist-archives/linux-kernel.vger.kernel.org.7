Return-Path: <linux-kernel+bounces-735963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C48B095F8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD64A449CA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBE423716B;
	Thu, 17 Jul 2025 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZODzgaVF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F3229B28
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752785347; cv=none; b=ZHRgJRrUFsSX3HNOpGGWNqMPSFuUU3U005WnLYpmaxxobBeh37+/CRBeTBJQcN7DNvC5QORyjnB8sP3EzhjUfszSgDwyde1CQ2Zff44Jkj+CJxNV/x9z4dmwlIvkfxIbpAUppF0A27wHek3eXmc1yPFW7M+LB98di0N6aCtZ+Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752785347; c=relaxed/simple;
	bh=Lv5I/l69wbo8RENfJ/KSckfR2rUPD9dYes5xZ4X8ePk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cf5kGO+8sWhxqAJJCV7F/MaJR1UAcTGLXd/cqnBenUmeSosHlz9/aXMIwUKF2LVmzqdonfBFWGDTf43uUlNiCyNDCoyEgy6AsGqzThAsvV18DBRcDIlMubAXKG8B2zV7F7zyPFSmxOQpBezW+E4YS/oM5pjGbGDcj4QZ7/ategA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZODzgaVF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HD3fCA007255
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9CmYaonQmugq/A4aPpsk6Yn5qRo2GpUcf9NGF+0jewo=; b=ZODzgaVFXqDSAbAX
	LfKxIzB6QdXDsZi4ImF0dwBp2TXCcsNhS6UED+aEZlPRNhtTx+6tQZOxmHlyQ0XJ
	86tClR2BvCALhvt9pu9tfPDf3zwmNgqvytEHRMKqmtgbWbLKHgVyoi2Vpq7U+Uzc
	mMcXIyQELPGgPM+V2jCUNQZVrluAeHsfIiJNfjNTr2Jkm9POmL2IatCpUImukDlO
	HQLhVpF0OAt0a5m42K7IRUhwjQCovePyH79Gg3MNkGsA05XbOIK8EwIjBqCyOHSh
	O2twmTg5nwKnFD6KIFiElguhTQtujDJFqbZbDtx/ylp2NW+CywH9U4iLLEe68oPp
	Mpg+1g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfcaaab0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 20:49:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ab61b91608so3989641cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752785344; x=1753390144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9CmYaonQmugq/A4aPpsk6Yn5qRo2GpUcf9NGF+0jewo=;
        b=FYf58A1+YmOulSIXUk00sPVoaxxJblf6MKjp8UA3Em7o9Uqiho1zNN+Kx04eazrvOC
         mSNEzPXMPzsEgHySJB0RYqsKJz9G3ok/37RuBa1kGwMkB0PeyzxIh9mGb3ihtu0iQCaU
         /Xkf1YH6jYr5GONl45UZekZCQQTL2xapivWR19lCG3G+9IXcfVr27FyACrYJnUbshzVv
         wgZVf5dbiHT+YJUo1Jce9dJHVOdE15GvzWUYn5M+O66YxdHp5W+ojcWPVoEyveAk4lQJ
         lg4M7a4WQsthnq5QZ89oYwxLot578YT8Uz36pIN71aWOXedkvg48BG2msPk8R7ywXtzr
         wUTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ7mN+m3L0p5mBmeZDaety7tVRpNUaJAEDqd4kPVw+qcdXbsQp98KIOr7X9DPfdUTkvOytlW31dRMKeIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWvR4KLjHL5WXFqYKFc72wqrO20zUYKJrVrLYS0flnxCdNBjGr
	Cxz187lAYHGlv4q1b0ciBrSdYQcQrzdQIpLaXISISQNhjknIGq5T1/T4OGe0jjtmDrtdp6Sutbs
	At2jC5CU7svvYZQ0LYQXLCcjWzSz6A3kN2asS7FC+QoDde4NPuUvEiA1WomFlnYkZRxI=
X-Gm-Gg: ASbGncvTqY1XembWtKUnUcPmRzQlkIzuJIpZfUJo0jYRsBFeAwBDBr6SYLZa8L4qoJs
	Q7HAfNgcKeRoKRo2sf70iYmZvrgYoqLCTOfMVYIN6uh94zvRQ/4ylF7ggp9vs3BEwhkWJzj38Af
	PmUESzNTVTxwiQHjlfI/meG8q0DtHlYySXII671gvNCLol0Jpk8ZBjvFEJ7+D5bHyMzpZqTjyc5
	4xFCVQ/YHOU3Pr7hQnfkLW1+bWyC8CeYA4KXvAv1ESrC5nHd6qWNPxYVQ+QWXIAPNFs4BvfVs9u
	Wcu/UyfklIhGhHkp7IFVtq5pdtYm7dyDdZ9q+XzzpZHosv1InjNj/LpDnCxky5mgWoO6EZq0TGe
	K2JNXSGm8OP7pHB8FPRca
X-Received: by 2002:ac8:5a50:0:b0:4a9:9695:64c0 with SMTP id d75a77b69052e-4ab90a8b01cmr59189811cf.8.1752785344079;
        Thu, 17 Jul 2025 13:49:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsdUOD63AuogKrskTaxBSHWwDEDfZBOoSuBlZWtt3hsMXZqbmo6AUjQ6EHFno6axLzFcjgbQ==
X-Received: by 2002:ac8:5a50:0:b0:4a9:9695:64c0 with SMTP id d75a77b69052e-4ab90a8b01cmr59189571cf.8.1752785343480;
        Thu, 17 Jul 2025 13:49:03 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c95246e2sm10463988a12.17.2025.07.17.13.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 13:49:02 -0700 (PDT)
Message-ID: <793434f9-7cdc-409f-b855-380be7a2b0db@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:48:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 10/14] net: ethernet: qualcomm: Initialize PPE
 RSS hash settings
To: Luo Jie <quic_luoj@quicinc.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lei Wei <quic_leiwei@quicinc.com>,
        Suruchi Agarwal <quic_suruchia@quicinc.com>,
        Pavithra R <quic_pavir@quicinc.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
References: <20250626-qcom_ipq_ppe-v5-0-95bdc6b8f6ff@quicinc.com>
 <20250626-qcom_ipq_ppe-v5-10-95bdc6b8f6ff@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250626-qcom_ipq_ppe-v5-10-95bdc6b8f6ff@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE4MyBTYWx0ZWRfX28jsLYX17O3A
 8j1MJf6U7B+3lOMsfky4MGWBxPKkbCVPINITrTo4q+o+fNZsP3hdxIWZTO0iCWr09puN4RKcXMq
 Su7mE3rVgWAQ9mJWEbRZvprlBpDOo82XUmceUIAhvdfo7xafCBstCwlh7npTvUynS2FJAhCARji
 hmSvv11lSAoBbDXxqjb6NlF+A7NK81+3F1JgV2jGAP2nz0P/b7lmiPoAlOsI5/c+F1tV74YcCip
 dOoEqqGRqWHYs7RJPOZumpcPHuN846dd3YNtNs+cA3Lt2/x3fQuLXiy+ZT05J5xs16YOyb/PZAB
 i19xPncdMMkIM6Kz7qPCSwQAJ2xt6VyShOpgwTBHjnkNsH+Gr+q8HkxKICBMiapRyTd8bXjKuwC
 eQBCjSKHXHZIKRK7f+tLT4aRbjqNyHTwm7DQrAZpWm8KaTCb8GTQUn/ugKz2hhnQHdHuDUhw
X-Proofpoint-GUID: BJecSY3E0bTJC5Cs9kdzpyFtnTIaEffH
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=687961c1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=afnzvhLNFvO1QOecfk8A:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: BJecSY3E0bTJC5Cs9kdzpyFtnTIaEffH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170183

On 6/26/25 4:31 PM, Luo Jie wrote:
> The PPE RSS hash is generated during PPE receive, based on the packet
> content (3 tuples or 5 tuples) and as per the configured RSS seed. The
> hash is then used to select the queue to transmit the packet to the
> ARM CPU.
> 
> This patch initializes the RSS hash settings that are used to generate
> the hash for the packet during PPE packet receive.
> 
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---
>  drivers/net/ethernet/qualcomm/ppe/ppe_config.c | 194 ++++++++++++++++++++++++-
>  drivers/net/ethernet/qualcomm/ppe/ppe_config.h |  39 +++++
>  drivers/net/ethernet/qualcomm/ppe/ppe_regs.h   |  40 +++++
>  3 files changed, 272 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> index dd7a4949f049..3b290eda7633 100644
> --- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> @@ -1216,6 +1216,143 @@ int ppe_counter_enable_set(struct ppe_device *ppe_dev, int port)
>  	return regmap_set_bits(ppe_dev->regmap, reg, PPE_PORT_EG_VLAN_TBL_TX_COUNTING_EN);
>  }
>  
> +static int ppe_rss_hash_ipv4_config(struct ppe_device *ppe_dev, int index,
> +				    struct ppe_rss_hash_cfg cfg)
> +{
> +	u32 reg, val;
> +
> +	switch (index) {
> +	case 0:
> +		val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL, cfg.hash_sip_mix[0]);
> +		break;
> +	case 1:
> +		val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL, cfg.hash_dip_mix[0]);
> +		break;
> +	case 2:
> +		val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL, cfg.hash_protocol_mix);
> +		break;
> +	case 3:
> +		val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL, cfg.hash_dport_mix);
> +		break;
> +	case 4:
> +		val = FIELD_PREP(PPE_RSS_HASH_MIX_IPV4_VAL, cfg.hash_sport_mix);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	reg = PPE_RSS_HASH_MIX_IPV4_ADDR + index * PPE_RSS_HASH_MIX_IPV4_INC;
> +
> +	return regmap_write(ppe_dev->regmap, reg, val);

FWIW you can assign the value in the switch statement and only FIELD_PREP
it in the regmap_write, since the bitfield is the same

Konrad

