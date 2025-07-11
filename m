Return-Path: <linux-kernel+bounces-727380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17528B0195E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447153AA20F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017ED27EFF3;
	Fri, 11 Jul 2025 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OX36XM2I"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D327055F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752228445; cv=none; b=FCo9MUTwHk2rNsppvubycQrweNcvQxVcenbYAA262HatKhcOk3BMHVxSHnqq8fmhzaGcLxP9p56cNuz/8higEFVlWKm4hh8xT44RoraeRArsb2djrKo3qzGY+HB9iG3oRjGu3Dm4oy/sBPYEbqML198oJc2jsPjUX60Ke7oKcQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752228445; c=relaxed/simple;
	bh=CcydoED0MJvysDQAThGymHG08lbVZKiwtFq+CoQ36+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3bv/M/d9LiPdrIpVuABrw6mZvCqviLQ2YoAXrRTugn8QMETL3zX/BGPy+F0sGCxm1xRIXmLhrshacEggSVA/tCsSrWlczg4utOZn19+8T3KW2ycUKyp/UXFL5Q8UZfd2iF+CnLIC0boVxyvAPS4wqNQ9PRPobkILyVEyH6ie7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OX36XM2I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B1X8wk007976
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:07:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hk3nB5hWTU3eT0rJpe16RuFw4gADrZf69fEfZrrhc2E=; b=OX36XM2IQUjYjYLC
	L4JqjrIbaAKVweFxyeSK4wN6dvE5lT3qkwMV3183xhN+svzUylTx27sH8vR82D3X
	+LLBCt3WcV84TxXekS8/MyTWVz+kG7i8lcJt1qytO7ynWUTB6CoX424yAETo2RPN
	GI1G4svg4yTDq7t8w6NYEOGIeuqdE4CpsJx2rPk3W8hASUpbrsZ5hZMLHFvFEjcO
	qMrGz9PAdsny5U4hNRfrPN78cKVMWMC20zXUTrBtgBIHofaJlF3THCtJLJR0Aaz0
	NXLzVJqw4XPu6CKZO3k7OtEdmuwugIMMcajabtwMwsh5H18H7CiEmLAZ7qq3ppHe
	i+HmWA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcg8639-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:07:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7df5870c8b1so10821285a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752228441; x=1752833241;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hk3nB5hWTU3eT0rJpe16RuFw4gADrZf69fEfZrrhc2E=;
        b=YNgjmwu9bKbEtztXqat30J5V1QTSb2UHglxfhAIXL+KdcISIhT3Nb3HUoHlW3DS/HT
         LOXirAXZ6Ct0RMfrGNRHLX4bmR6LmggWvxuW2VBkCe99BmREaaB06Kd+8Ii+VxYdfSiV
         /AX/FkvphBeihpuAmsbPSIAputdatU5lJwmMh3mbfy8m7mnUMFVkxHa4abtWdIoajF4+
         Nugk+rKQjkbmwyrax+Jbu2KvQyds42+L9PtvNQXLhNEXxOyM0Ftm4TqCy/GDXOWqcbWc
         1Nu7IRVIr/5wBZVdddUGD8O9ygYx+Pr0HY5zTzFBF+bQOEc0UN0YsuiU/vqq3jJuiOpV
         KHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1egpQFGYQnrIcjp4s/Pkzynxx/Oo4kLMyQ1LGUxQViriy3l61fJqOOZrmSHzMo6nhbh03IkPDjFhM3Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfxQQkS7oeTCbEwW6L7NirSp/nKvtvFIMIYz0wSJPCdS2cGHU2
	jJK9TCYBlZz+LDmmtSIVBDefldbc5bCWwV/OEsWEnet/oR8YN7JPRkat2Xfd0t7ffiZbFTZWitW
	AQVdGQonqoR2DPWpVI6ybjo0wHauwqEp2FNjMB4Dc9dkoUrUqkiBxNKJfiERlXiPF3DKQm3iZs/
	c=
X-Gm-Gg: ASbGncsXVlp5zgLNB4rawreObMWucMN//0miGXCNbdpWu51bDp6DO4YytJNMkffPYcU
	DtBEh6IgsbBFYuaZd4kBPkwq+YzSDpu2TiPJoeOOatcPJ7awrVySkf44zyu/D0j5q5tS34AipoL
	TKyZkLZpIHC6GM7v+nIWxvu4/xTJCfTA4JIbRDxYGuDcQbHSkB4+Uut7393RNsdEr94O52hwEm6
	TdD/PfYyrW76Vg8h7WjfU5Tef/a22tUHWU/S163XaOQHC8eARpxxg9YBGBvszajYBa0lGAq1IYA
	sN+zbIKaHAcbjI0c0VKtE7BA3DIYgV6/ik28qrS7JrnygVc1XkhBxKisuapvqzbU8eBdqB4kuIb
	YYaS5BLobJeUWT3+KH3wc
X-Received: by 2002:a05:620a:1a23:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7ddea4222a1mr161755185a.6.1752228441499;
        Fri, 11 Jul 2025 03:07:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrWNOlRhFuBEfA5EPZynQzF8v5JBD8YYJNHk12CZDzRYg39rtNgm6sSnObsdsSkGwVBUSA2w==
X-Received: by 2002:a05:620a:1a23:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7ddea4222a1mr161752885a.6.1752228440873;
        Fri, 11 Jul 2025 03:07:20 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c952b753sm1992960a12.31.2025.07.11.03.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 03:07:20 -0700 (PDT)
Message-ID: <f754d2d1-689d-4681-8cdf-9e1e5daeb6f4@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 12:07:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] drm/msm/dsi_phy_10nm: convert from round_rate() to
 determine_rate()
To: Brian Masney <bmasney@redhat.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250710-drm-msm-phy-clk-round-rate-v1-0-364b1d9ee3f8@redhat.com>
 <20250710-drm-msm-phy-clk-round-rate-v1-1-364b1d9ee3f8@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250710-drm-msm-phy-clk-round-rate-v1-1-364b1d9ee3f8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=6870e25b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=20KFwNOVAAAA:8 a=oYwTbBpYGhGVpGtzMvsA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: XJpqKJq7R3zi2geyCMyN-q2Y6KGtXUJr
X-Proofpoint-GUID: XJpqKJq7R3zi2geyCMyN-q2Y6KGtXUJr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA3MSBTYWx0ZWRfX48bzyazKfTMH
 +8gGrsQqCd8VZuYnEdIH4w8FhHQ1EqftUo6jSIsPIpCWy/rJFHmWcLPm+qqh4gTGvetn5Cb1GJP
 mzTwr4CPNfNoNr//GMTdQmR+CTtkLcQi5RIwbL8hGzeTKLzLMCTKVSUVZfwvat79MFgOFE5rV5a
 osyR+k9HOCwla326jy1l311zCnKiGWYPy8Atwe8+h5NAgemdgQEkKEEPKAhjgPZ3i2ighCX46Je
 XVEwHYRl0B2VFj2WkXJJ2bJmpgfv93vNd9GIl1hi+y0qVSzF0jedisap8Uprb3NwNWywHJvzTto
 S1McHwhwyVcdEgJzoqFqlYr9p4y1of1johDoHSIHsdYkiUL+QK+7R5xFLrC+IGnVfbzvm+6egS/
 mWCxhEZuBIrQKMgCRNVp7zpDCSwcii4q5QEqWPEfgcGkHkld/Vuzq4fcscBnJSrfS6Kb0imN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110071

On 7/10/25 6:27 PM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
> index af2e30f3f842a0157f161172bfe42059cabe6a8a..d9848b5849836a75f8f6b983d96f8901d06a5dd3 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c
> @@ -444,21 +444,21 @@ static unsigned long dsi_pll_10nm_vco_recalc_rate(struct clk_hw *hw,
>  	return (unsigned long)vco_rate;
>  }
>  
> -static long dsi_pll_10nm_clk_round_rate(struct clk_hw *hw,
> -		unsigned long rate, unsigned long *parent_rate)
> +static int dsi_pll_10nm_clk_determine_rate(struct clk_hw *hw,
> +					   struct clk_rate_request *req)
>  {
>  	struct dsi_pll_10nm *pll_10nm = to_pll_10nm(hw);
>  
> -	if      (rate < pll_10nm->phy->cfg->min_pll_rate)
> -		return  pll_10nm->phy->cfg->min_pll_rate;
> -	else if (rate > pll_10nm->phy->cfg->max_pll_rate)
> -		return  pll_10nm->phy->cfg->max_pll_rate;
> -	else
> -		return rate;
> +	if (req->rate < pll_10nm->phy->cfg->min_pll_rate)
> +		req->rate = pll_10nm->phy->cfg->min_pll_rate;
> +	else if (req->rate > pll_10nm->phy->cfg->max_pll_rate)
> +		req->rate = pll_10nm->phy->cfg->max_pll_rate;

clamp_t() smells better for this series

Konrad

