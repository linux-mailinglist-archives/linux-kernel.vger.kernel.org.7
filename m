Return-Path: <linux-kernel+bounces-742520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA26B0F2BB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0081C86818
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5942E6122;
	Wed, 23 Jul 2025 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hpa0DRnu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C5134A8
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275712; cv=none; b=sYTtQGqtfFP1NS0SvHNYBmPDqtxkRpVr/tnFmRVtY/FGY3SGJRBvjfN7MCaDc6EjQahdb19VL8O7mrVg7EmcSzNN2sxak9QFVIEj4JwiHONgCzA9QOqYlvvlOdHdq33Udvg1PE+8tScY7AnqUJWg0Wo7vCnPA2w3G9LLjAipCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275712; c=relaxed/simple;
	bh=dRAk0o72e+X33KIq1LpoL6MfpiBTQz1RGTe2fzqE5FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YML/9T+6mNou7+xgYVTIwVBFxtNPiBLRq047CQuhAGZf3PQ9FQrWQr7aV0DPJjBp7Rqd37WO37xA5rBwmkz1uMhHf9YS2HO/0LmsaDIVotWQcWYmFsrkSBVaD2sN6MPedYdLUJn8fRsFwSlrR3QXPB34+naBybwFH87rqJpXEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hpa0DRnu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9ZSqv027816
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1wPevboyTw5NwvNz5iHDyoVz
	DX1UybG8R0FxydcjI4w=; b=Hpa0DRnuOU88PnbYNQ38/T3Mu4FVgeRR/v8904uk
	xJdfCBisz64OSOHu5mc3OGS8mxV8yzgE7wLlz7eMqf1xBbfPIvm1PbpD5jwRtwR+
	V9qEC7OMlmjIHQRl+8D/m/8VB9KKBoVzLotuCrgfLHQ/59hkyth/ydQJK3jN0GQQ
	cp6PvlPJP0fBUZmCLy0SuE4ro4ZfQ7yJx29YahA7BUjSrslvMC41BDJ35xp6P2RZ
	lynwOwepUcEWlseWadWTF3wzU5DESPvNydujJ8TzrqqJmSNY+J3aCocphGqYxIlG
	1d8TRBQVv3AHNCuqtyDGOcQsVu2UO3Pbkyb1CpLKSH/UXQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048s5768-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 13:01:50 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-427850a77a2so161274b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 06:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753275709; x=1753880509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wPevboyTw5NwvNz5iHDyoVzDX1UybG8R0FxydcjI4w=;
        b=cNpBdey5CTRi0reELfYRpSrZZp6HZKINeV2u5Nl/QjlnrtdDXLvvQi8AOVYDLyhkd6
         hwaxjx/uS6/f+P7F3NyRHy6i7L3DRldmsoAFWYOWI4RCxDem4hyhzA6p+gbu6+zpbBCI
         9n6VEtKaUyo41sPsyCl1y1J0k2kehGZ92GZ/WqwlJl3LYRTkYUWFjHpLhnA6uMA9wTCP
         UYhbhRzWe14WW/IOlq5E1w4wOj253NRBmWrHNUaKF8Pxjtu7kcQ66O9ZreCLvN548Urn
         wuRXIptjkiRhCF+wwFqdLUHLPvboJEihEr1RMGGwGKnWqCwXgBc5QT+tocI8rKDhDCHI
         MqGw==
X-Forwarded-Encrypted: i=1; AJvYcCVg1Nfpf/2q8F1wo3EfJiX+V7iMhGUyfpuU6tvz2kk2nBpAyeHoFx08E9zfceL5VaRfeZEm88AwcVuN8KA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxki1xgJc68lyEVPaACClc+3uFr5SHHHd2W63kYu/QsvIZwqsJn
	h9ou0F/LuMWRrCU+iO6tV5JXud6ctFveZ/L1Y4zAbh1MyQBWcUy+Xa0iQyV+BzkUypsHCIVVANh
	ECDk4hJ9Knd1Fynl1YhCayeCoyNBp0YwggG9WDaPteDqRB1fu7rNuYefsm+GnhunSlG4=
X-Gm-Gg: ASbGncvLgr7Jx5S7J/lydAJEjckqjwP3QtHAJiNGYD0UCq0XoyNGnnX2JmVQQzztplb
	jlF9/BFljZ7TQ0e07k+1R0Uney4GPq681K4nt1waOzQOqcTsHMW6jdzACYaBbGUF2jTC2eCttl7
	fYmY5wmNnF44ZwarXCj1cswiiuTH9zgbccJ4S7sfqhUoY5rBzduVmc9GjLMv0gBqHBwsBvRCO/a
	B8auMy6IkOgzLgGCajyh2ZWMV7ovtfpPTg4uSLfNrM6e0Atxt11pU7+ZC3tGUeLitnChwNzicWX
	I8G/LU8sy90s7iffztHz2ZRpCWPwU1M+UFX2ptGj6YIwLp3UxHh+FY7pjsN9HhG35cwcsjAGA4G
	3lypGKTaje3UlnUxUWFTr3aIE6IyGZlwCgfJq/bsw+FBB5CxXQYf6
X-Received: by 2002:a05:6808:2203:b0:406:7cef:46a with SMTP id 5614622812f47-426c642f047mr2288844b6e.19.1753275708743;
        Wed, 23 Jul 2025 06:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGneR6HtJeJALFHOLFmNSXyrHOofiM8HoHdB+oxIXAcXdndJc6GaB0Ve8NkfrbBMs8XEHgUuw==
X-Received: by 2002:a05:6808:2203:b0:406:7cef:46a with SMTP id 5614622812f47-426c642f047mr2288580b6e.19.1753275706737;
        Wed, 23 Jul 2025 06:01:46 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91f12b0sm21241281fa.98.2025.07.23.06.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:01:45 -0700 (PDT)
Date: Wed, 23 Jul 2025 16:01:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Renjiang Han <quic_renjiang@quicinc.com>
Cc: quic_qiweil@quicinc.com, quic_wangaow@quicinc.com,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: venus: pm_helpers: add fallback for the opp-table
Message-ID: <k6umaq7xrfma44vm75ea6m7vqd3hn367xdymsjylp3zcqn5vmd@jbvgdknnc7ri>
References: <20250723-fallback_of_opp_table-v1-1-20a6277fdded@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723-fallback_of_opp_table-v1-1-20a6277fdded@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDExMSBTYWx0ZWRfX2iplbbemY21x
 /hWRL6pveFmEaaK41F60y7nW2PD7m/BWwvC94ZQiQMqFzbgpA8DpfbFvMCMDLo6ibBdxOz8bHeu
 xN+/MvrxEnBVC9TA5xZRNmkt+u+P2T5fDJ79ZF9IV3MZK9NYdHH4b1Rg8OZ/EoW9rQ3VM9qQba3
 6qSN835tR9Y3jpaURr2xxo9LzIecxw3Aod1YavqUjpRjk+zEl/jOViwNezteOX6IwXLW56YPx8W
 ZzRzbiVtW/9EpR3SnOPLuz9jk531xtjlRv101jtt0Q+5FC9E9+QfO4Nr75ZO6oTSa1DOfZuzFdq
 bdD3GvBPpdF7SoHKmc+qGrVTAUPFLV72ObNwSBDpvnZxVw8NPMKSu5G+bH6ebPaHRVMLwubS72Z
 Y64GWcHqGST/YXAeXhI4HRR5u8z9eb/W1psq+xEg4gxTISNKHnfkBNysg6o2mQMNkM12CgEW
X-Proofpoint-ORIG-GUID: qvPgITHnaKS5IRjN22s1-EyIRD1-5se2
X-Proofpoint-GUID: qvPgITHnaKS5IRjN22s1-EyIRD1-5se2
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=6880dd3e cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=iWKRvkjQqEvONqlByQsA:9
 a=CjuIK1q_8ugA:10 a=_Y9Zt4tPzoBS9L09Snn2:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230111

On Wed, Jul 23, 2025 at 06:26:02PM +0530, Renjiang Han wrote:
> Since the device trees for both HFI_VERSION_1XX and HFI_VERSION_3XX
> do not include an opp-table and have not configured opp-pmdomain, they
> still need to use the frequencies defined in the driver's freq_tbl.
> 
> Both core_power_v1 and core_power_v4 functions require core_clks_enable
> function during POWER_ON. Therefore, in the core_clks_enable function,
> if calling dev_pm_opp_find_freq_ceil to obtain the frequency fails,
> it needs to fall back to the freq_tbl to retrieve the frequency.
> 
> Signed-off-by: Renjiang Han <quic_renjiang@quicinc.com>
> ---
> Since device trees for both HFI_VERSION_1XX and HFI_VERSION_3XX do not
> contain an opp-table and have not configured opp-pmdomain, they still
> need to use the frequencies defined in the driver's freq_tbl.
> 
> Therefore, if calling dev_pm_opp_find_freq_ceil to obtain the frequency
> fails in the core_clks_enable, it needs to fall back to the freq_tbl to
> retrieve the frequency.
> 
> Validated this series on QCS615 and msm8916.
> ---
>  drivers/media/platform/qcom/venus/pm_helpers.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Fixes: b179234b5e59 ("media: venus: pm_helpers: use opp-table for the frequency")

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

-- 
With best wishes
Dmitry

