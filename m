Return-Path: <linux-kernel+bounces-798330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D27B41C63
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A6156146E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BE82F5332;
	Wed,  3 Sep 2025 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JKPCQNP3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15782F4A15
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896789; cv=none; b=X20aAtMwgvmX5Hf1/T4KCtuB7XW3LaQi9zKj3PZIhS9P80faRbj0pPYOX6ta/LLqj+ozXrctgUn0JfYGnSiJ1z01yU+Lxlt3uPLy3QrNMX7l0GzV/E6m72hbCfYnUoJv0iugVmx5/w8Y5MwzkMKLxYil2+WlkqzqISa/ylbGPPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896789; c=relaxed/simple;
	bh=0JsCaLzzil1TY+KiNKyqe/k7zCPamDfM/hBakfXAQIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3vF8bwS7USW+BuisoxtJ6veeMgkuCtvoOrV8Q+pek7FOxhei45cYsJ8aufzMggK2SUyWwkJlyN6gdIp5KetfjmhTtCYKbLOZVFMw8Y7VSdEgIvVmyB5v6xN83i/iPlRPWTijfoM5s1jGYa8qXBnTCVksAXksZfpX/KgLHXEWOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JKPCQNP3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583AMoHQ023422
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 10:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nk/aD07bI4u37nmHFKVnLrthW7H+D84XS76rtbwDMsA=; b=JKPCQNP3EKr7o6/h
	Cpay4YV4EGCfkmKPvPOmBWcha6HOB1OQugPMveQIh71h8QmfD0I3bj3a+5cS4pO9
	ZyvNAJZoXMBVuY7IUZNWQaV0Y0+LiaDqGessa2ZxI+ZSzm8g7yx4IYLsqFOFkLSz
	HjBbEaNhkqffC6U3i6QEkVhDT/1xXo33Q+8bJr9gxpp+FCE3SKVZI3IPl7VyTHbM
	L9wyAKOutkkKH2mYtTSX1aOYru7yBVcIFTelkCRkyEqplMCiMK7G2CazRrRaXC2L
	0cM3Mk0mn2Iaf/B1U6FUNWFfota2tHyM16Kt/BjczWTayRdJhM6axyoYPWOWmyk9
	zkSKAw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpbh3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:53:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b3d3fc4657so1333811cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:53:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756896786; x=1757501586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk/aD07bI4u37nmHFKVnLrthW7H+D84XS76rtbwDMsA=;
        b=BeS56MH0w0T+Qp7OB4iTGfcouIo7PkkfBiRRQbRlXmSQBREb0ZWvZq7lxzf3qTFEbm
         qPzSEr8xRY9eqt2RUNMmaXcyNeboUAfiZGhi+wNdsvErTEjcaRk9C8/MnY4IWhU10nsQ
         o//azYXAK+OfYaXUznC5bRsRo+ZljzBcB7Dwav7UNr/KbJVp2fTqA4wlrhlwlaA+Xpxm
         GtjgDK+eMjXxD8LAwdikGZKNvdu6SnA4uAlERv/DAzodfhVdA3svgFJBaim/8qg2T92X
         KUHS0yU8Kor+7QKpHFdaScI/sq5d93uR9E0Pe/L3H3fa5N3s+v21+DCSUGq/fpblyFAM
         m1eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV2nXpSMMQK7y8qE5Cb3oqmjDJZzmNsZbp/BCRJTIXNJjcKCEqjIk07RsSx7v1bdVA7YqNXggu0J+Jeso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8cmJmivTmoiFcBL+djkqPlUaH/aVok8K/OInP/EIAawuCJrKY
	XIvxsn5fuauUhwsf2WajyZ7vuY3HM6RPZlatMEsrNHa/yMeTvsXUq6lcmrc7zkxQ7DJLBifZylb
	/soMo41qqBPKQ2Fk2KLwbqgOys/A4MDgd6Iar5wTIZJpk5qNog5YxfH+x34xYLpEKU8A=
X-Gm-Gg: ASbGncvzz8QrPe5zVPZ6OQCR/LVFLGMMZDpWTLRR516l4U9LTA1j8buwyAdNo1Y0+2L
	es7AAHllju+F6uDzxNYLYBU1B9U8xpGgFtbggi3GUqCdIhe2jazi/HqhzjKn0S4ND3wRmvjIWxZ
	BnzUgsCN6pROTXpDGvTKaRQ+cc1qvPX22EoLQ5wtzmQgiAtDrOzeHHyEUmuW3mQ5LvcbLbnBzTO
	0eyw4eku1VVK4tRAch1LVf4Il1saTjO5yD8AqkpMAPJOwkqX2OxwqPFiLsoHSBbd3+To77FOPA+
	ryTbXa6iL4mniqa1QWIC5m0HLvXLxSbefWUtHRUNiVKoqg+J286VSLcqQMm6i5WcbBAyMxj1ZOq
	ExlEm9AvLjWVbZI/0zdjA9w==
X-Received: by 2002:a05:622a:3c8:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4b30e906341mr136817881cf.2.1756896785647;
        Wed, 03 Sep 2025 03:53:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6DHpztMpPTybl8ilZYNgYnaTyfWSXJC32t+1unhFqKny8Zv6s0B7MHj0N3nPJVj7uZZHvgA==
X-Received: by 2002:a05:622a:3c8:b0:4ab:6e68:1186 with SMTP id d75a77b69052e-4b30e906341mr136817671cf.2.1756896785056;
        Wed, 03 Sep 2025 03:53:05 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040f1cf4b9sm931051066b.29.2025.09.03.03.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 03:53:04 -0700 (PDT)
Message-ID: <57e90560-2eef-4c16-84cf-cfca58240885@oss.qualcomm.com>
Date: Wed, 3 Sep 2025 12:53:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: qcom: x1e80100: add video node
To: Wangao Wang <quic_wangaow@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Qiwei Liu <quic_qiweil@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250903-add_iris_for_x1e80100-v1-0-410e9e6c79f0@quicinc.com>
 <20250903-add_iris_for_x1e80100-v1-1-410e9e6c79f0@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250903-add_iris_for_x1e80100-v1-1-410e9e6c79f0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NYVLv_GZD7W-LFOfPsw73SVUSzz9942H
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b81e12 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=k-zUgsc7-9G9n07UOVQA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: NYVLv_GZD7W-LFOfPsw73SVUSzz9942H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX7UHyQKEvxw68
 zjj92M4O1TFTANKZyCNsa0siiSEt88JfNvZRxUirgwlLhyz+FdLuL8w+m3XnRdbbbmEE8ofWvT3
 P9aRhiKHSFWS2urxYNVvLbm/5NEawaje3RGYck/YFG1bR2xLXpBenBLTLG0qya5DwJ4H4vau75u
 7ilbhgfzNAF1edh9b5P10eVT/yd3DJRBnRmSLJfc/RbPnWlMsIg08BYDoFY4OyVsx0N72lQCgbm
 e/wWg2dJ9hEABHqoq+5h/Jxggs8UKCB6vK371J2rf0bcD+Mefk0hLIWTMsr226CLQ1DN75cZnxy
 XNfITbEAJHf3ZexxLDqekb+V+wd6A+pYxE/GHS/X3DDk8ckX5J+nMMGPwOru4X8ssC4h0bxRgfL
 Um9P6zCC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

On 9/3/25 10:27 AM, Wangao Wang wrote:
> Add the IRIS video-codec node on X1E80100 platform to support video
> functionality.
> 
> Signed-off-by: Wangao Wang <quic_wangaow@quicinc.com>
> ---

[...]

> +			memory-region = <&video_mem>;
> +
> +			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
> +			reset-names = "bus";
> +
> +			iommus = <&apps_smmu 0x1940 0x0>,
> +				     <&apps_smmu 0x1947 0x0>;

the '<'s should be aligned

Konrad

