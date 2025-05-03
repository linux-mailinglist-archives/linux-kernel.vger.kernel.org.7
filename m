Return-Path: <linux-kernel+bounces-630602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66702AA7C71
	for <lists+linux-kernel@lfdr.de>; Sat,  3 May 2025 00:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEAA44A0BA3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 22:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8ED215184;
	Fri,  2 May 2025 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M4owbPlI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F721518F
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746226368; cv=none; b=MXRXS1KuSooqT5JHrTgUVVFxq0Rl3T4BoSaJP4ZG4FDPOavQ6XW4AbtDOmix1GtMEhb9wuSukfBm1prFhPZgVCnURAgNK0D7pRK+8OMz/XEfFyDDa9uzgbcxWjYAcB7hOeoEJLzLuDOEcsN2MANRplIVImroAGOHH/Ulsxgwq4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746226368; c=relaxed/simple;
	bh=8hZ91w2arLugpliTVJsM/F0LGd3WgsYUoN0l3oJTMVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA1XcPoBmdQdZwbRq28UTYzuQxCMr1em2f2bcQNbgerjBW0o667NuVFGtmObTc6qewxb4sPX76oHaWdVO/LQLVXXAZiHcLriU9cNMeyYMLLJ7Q+I1Q4QCf1NtyjFqnQ8XRFtk7+rj3EP15SNzj9x1FOV+7XN3nTh9da/Qeky6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M4owbPlI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 542KAqUt031500
	for <linux-kernel@vger.kernel.org>; Fri, 2 May 2025 22:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=IMgAeV6O9mToM6/y5/LWAAK7
	kKgWJWa/1zV0eFvjo2Y=; b=M4owbPlIx830KWEtD2qzmIOJ0vpdBREmuHVV0IY6
	lOmcaJO4nb7/TECsPc0QZdXryxi9x/hNOcl3Cw4TD3oZYoJQ4hdIwnp48STQYq8j
	zfSS4di/0Z2+2lqvJKbNEA6XZDpnVwNXb4saHH0LEj3Ow863SpZfOuTHk2f6K5v9
	jAAdFf7y5WngmnjBjBoi+oyzVlGBlFz/3KXNQDvTmJSzHZobx3N/tApCA8fnN1ZQ
	8L09vPreOj5g51+nl6LakGZKFvKJHuUIFsY5l4ftgNToMdKe6bnsfVfuHE7X8BJS
	jBskEexEF2LjJxy3LKFyx8IaykauLZfwVnOboiq5jx/w6A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46b6u2hm4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 22:52:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-476b2179079so51676361cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 15:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746226364; x=1746831164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMgAeV6O9mToM6/y5/LWAAK7kKgWJWa/1zV0eFvjo2Y=;
        b=qWKaOuuaFO2ZVOuDkXA9R/4Nl246t/uiohi/deUwIwZNW4PFYE+167ISFn1VtZShcW
         r3oRfaPDnXOS04MceZ2zul4jNy+yirDlk7GRVJfz24mQtHLzQVz0zXCB8G1wyFHIzmLJ
         O0zlTXhH+OpPi3m46Z2VjuvBAtMEkCOx80BkzPqPGyG5u6B9bJAggT3VlsG+wvdW/3KD
         NxqqV5PYAOAwq96sFTmZ4mdN2siMcwD2sse02GNjwgdp/tG8E3j0bHw+UrLoe93tbsgr
         OWq3HXLatwh13NRxqpDMDQs6FZHUoW6BmH4Nbjc6vAEonVR/th5046hR+XsgY+OLG2/g
         D2Ow==
X-Forwarded-Encrypted: i=1; AJvYcCURX3G/EWhhAC90+Z9zYUIlGn+/5fYdpDOiZpc1J1XHRHfJpvETlnpTwmUPRvPk3v033eg/OwGqsh+WYuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVMSXl0PzsRBL34BlLHmJHueCjfDlu0lb0k86LSNQO+Dv7GbkX
	uk+xQmlfUFUGs0JGd1hPU4aVYosIHEHTv+0E5kqVNUfoWUOWJG7ijNi4SGUOZEsuw3xIaeJEZZh
	5oBZT9trXXDc2gojDPR9XWlo/Y418PTUpEVJnS+uXTSVu/AkHgZLAoZEn3baYB7A=
X-Gm-Gg: ASbGncsXuXQlYLw+G1nmXdM+wjLi3pQ3fp0PgIJkVcbkyuPjKEp7YS2AlJpgq2mRbju
	eIHx3VyWG1XkBSS8jXfHQ1rRKwmFGx6a8pM08375KYX/TDNJmUmPQd48oAbIWjUp9Y52IQ37gDS
	btrhvAwM6p0Nkip/6h+DGspoIMX8JbskN6DNjttHcIvDKHP0jTDSucEU0AV9etMjwTT0aBlZLxC
	CGdIgQ5aWmOGJoJp1bU19sOBUiVpqJAAMVihjfbnqds2PWc6ZeGH/pmFHvgFszz5mu8L+3mWFdt
	Owi7As+6chzr4yIJO3QvZIuYkIUxQiXY1V+72zOq6vSsKAcZxNEPzgLh5tTgRqgh5hBtn80FnmQ
	=
X-Received: by 2002:a05:622a:244e:b0:476:980c:10a8 with SMTP id d75a77b69052e-48c3163ec05mr85645261cf.21.1746226364182;
        Fri, 02 May 2025 15:52:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFAXOcRLf2Z3bspGcZv0cNlael5HGsrydFHbIvTQUjv2j75Z2QZiLIQoy7bHSRAG7G4lj9PQ==
X-Received: by 2002:a05:622a:244e:b0:476:980c:10a8 with SMTP id d75a77b69052e-48c3163ec05mr85645011cf.21.1746226363828;
        Fri, 02 May 2025 15:52:43 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32029306984sm4992161fa.58.2025.05.02.15.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 15:52:42 -0700 (PDT)
Date: Sat, 3 May 2025 01:52:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>, linux-clk@vger.kernel.org,
        Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v5 19/24] drm/msm/dsi: Add support for SM8750
Message-ID: <ahx623ttvzd62u4fri6iqguj7mirlf22tvwbu6k2ngxw6hwbcp@oh7mmex5fjmz>
References: <20250430-b4-sm8750-display-v5-0-8cab30c3e4df@linaro.org>
 <20250430-b4-sm8750-display-v5-19-8cab30c3e4df@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430-b4-sm8750-display-v5-19-8cab30c3e4df@linaro.org>
X-Proofpoint-GUID: eoa8ebm477wy8ziACtiBNK_eWWCz7bCh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDE4NyBTYWx0ZWRfX0Y0y5zosDbj9 bpeuP26vj7c4INCcsPHoxrJH+PAs0RIopZNJx4dEQWk6+BI3bed39xwZ/x+AZc6ecLBipYCa8yl GrloAD8ox4tDq0xhFYM8Nt5LH2SFJqAKXuXCbVF+GigDozKlq1++MDlCjRy1NOCOftDLXtGfN3T
 mFRBCQtCMBqGfbaKOYYNzWJNMGe2WBdN1pdcgPfZfcaef37LPj5xShsvRQsYGuNdmUsZpcze+tx elkOhuo0sa+EVmSvxzB9Y5/AuVqbLMMTpAihDhHNZ3FvI9r0Tn4im+625feXIGSW+SbnqO3WdpD 8AqbQfwSzIychM9dYyk5svy1tyvO2kZgq0/antKPg+uYzMVTa8AoGOET713xB/8IdYAqZFe/ewT
 M8wYUsTOO49NtPqfFoE/ER5M11j5OuHb0gd12mhdETsQCuXOIxsA6n08uODex6Ku/Uz0kqgu
X-Authority-Analysis: v=2.4 cv=b5qy4sGx c=1 sm=1 tr=0 ts=68154cbd cx=c_pps a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=e5mUnYsNAAAA:8 a=KKAkSRfTAAAA:8 a=vPhFULFQeS3k4onP6IoA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=Vxmtnl_E_bksehYqCbjh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: eoa8ebm477wy8ziACtiBNK_eWWCz7bCh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-02_05,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505020187

On Wed, Apr 30, 2025 at 03:00:49PM +0200, Krzysztof Kozlowski wrote:
> Add support for DSI on Qualcomm SM8750 SoC with notable difference:
> 
> DSI PHY PLLs, the parents of pixel and byte clocks, cannot be used as
> parents before DSI PHY is configured, the PLLs are prepared and their
> initial rate is set.  Therefore assigned-clock-parents are not working
> here and driver is responsible for reparenting clocks with proper
> procedure: see dsi_clk_init_6g_v2_9().

Is it still the case? I thought you've said that with the proper flags
there would be no need to perform this in the driver.

> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v5:
> 1. Only reparent byte and pixel clocks while PLLs is prepared. Setting
>    rate works fine with earlier DISP CC patch for enabling their parents
>    during rate change.
> 
> Changes in v3:
> 1. Drop 'struct msm_dsi_config sm8750_dsi_cfg' and use sm8650 one.
> 
> SM8750 DSI PHY also needs Dmitry's patch:
> https://patchwork.freedesktop.org/patch/542000/?series=119177&rev=1
> (or some other way of correct early setting of the DSI PHY PLL rate)
> ---
>  drivers/gpu/drm/msm/dsi/dsi.h      |  2 +
>  drivers/gpu/drm/msm/dsi/dsi_cfg.c  | 14 +++++++
>  drivers/gpu/drm/msm/dsi/dsi_cfg.h  |  1 +
>  drivers/gpu/drm/msm/dsi/dsi_host.c | 81 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 98 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
> index 87496db203d6c7582eadcb74e94eb56a219df292..93c028a122f3a59b1632da76472e0a3e781c6ae8 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi.h
> @@ -98,6 +98,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi);
>  int msm_dsi_runtime_suspend(struct device *dev);
>  int msm_dsi_runtime_resume(struct device *dev);
>  int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host);
> +int dsi_link_clk_set_rate_6g_v2_9(struct msm_dsi_host *msm_host);
>  int dsi_link_clk_set_rate_v2(struct msm_dsi_host *msm_host);
>  int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host);
>  int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_host);
> @@ -115,6 +116,7 @@ int dsi_dma_base_get_6g(struct msm_dsi_host *msm_host, uint64_t *iova);
>  int dsi_dma_base_get_v2(struct msm_dsi_host *msm_host, uint64_t *iova);
>  int dsi_clk_init_v2(struct msm_dsi_host *msm_host);
>  int dsi_clk_init_6g_v2(struct msm_dsi_host *msm_host);
> +int dsi_clk_init_6g_v2_9(struct msm_dsi_host *msm_host);
>  int dsi_calc_clk_rate_v2(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
>  int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host, bool is_bonded_dsi);
>  void msm_dsi_host_snapshot(struct msm_disp_state *disp_state, struct mipi_dsi_host *host);
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index 7754dcec33d06e3d6eb8a9d55e53f24af073adb9..7f8a8de0897a579a525b466fd01bbcd95454c614 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -257,6 +257,18 @@ static const struct msm_dsi_host_cfg_ops msm_dsi_6g_v2_host_ops = {
>  	.calc_clk_rate = dsi_calc_clk_rate_6g,
>  };
>  
> +static const struct msm_dsi_host_cfg_ops msm_dsi_6g_v2_9_host_ops = {
> +	.link_clk_set_rate = dsi_link_clk_set_rate_6g_v2_9,
> +	.link_clk_enable = dsi_link_clk_enable_6g,
> +	.link_clk_disable = dsi_link_clk_disable_6g,
> +	.clk_init_ver = dsi_clk_init_6g_v2_9,
> +	.tx_buf_alloc = dsi_tx_buf_alloc_6g,
> +	.tx_buf_get = dsi_tx_buf_get_6g,
> +	.tx_buf_put = dsi_tx_buf_put_6g,
> +	.dma_base_get = dsi_dma_base_get_6g,
> +	.calc_clk_rate = dsi_calc_clk_rate_6g,
> +};
> +
>  static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
>  	{MSM_DSI_VER_MAJOR_V2, MSM_DSI_V2_VER_MINOR_8064,
>  		&apq8064_dsi_cfg, &msm_dsi_v2_host_ops},
> @@ -300,6 +312,8 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
>  		&sm8550_dsi_cfg, &msm_dsi_6g_v2_host_ops},
>  	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_8_0,
>  		&sm8650_dsi_cfg, &msm_dsi_6g_v2_host_ops},
> +	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_9_0,
> +		&sm8650_dsi_cfg, &msm_dsi_6g_v2_9_host_ops},
>  };
>  
>  const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor)
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> index 120cb65164c1ba1deb9acb513e5f073bd560c496..859c279afbb0377d16f8406f3e6b083640aff5a1 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
> @@ -30,6 +30,7 @@
>  #define MSM_DSI_6G_VER_MINOR_V2_6_0	0x20060000
>  #define MSM_DSI_6G_VER_MINOR_V2_7_0	0x20070000
>  #define MSM_DSI_6G_VER_MINOR_V2_8_0	0x20080000
> +#define MSM_DSI_6G_VER_MINOR_V2_9_0	0x20090000
>  
>  #define MSM_DSI_V2_VER_MINOR_8064	0x0
>  
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 4d75529c0e858160761f5eb55db65e5d7565c27b..694ed95897d49c477726a2b0bec1099e75a3ce21 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -119,6 +119,15 @@ struct msm_dsi_host {
>  	struct clk *pixel_clk;
>  	struct clk *byte_intf_clk;
>  
> +	/*
> +	 * Clocks which needs to be properly parented between DISPCC and DSI PHY
> +	 * PLL:
> +	 */
> +	struct clk *byte_src_clk;
> +	struct clk *pixel_src_clk;
> +	struct clk *dsi_pll_byte_clk;
> +	struct clk *dsi_pll_pixel_clk;
> +
>  	unsigned long byte_clk_rate;
>  	unsigned long byte_intf_clk_rate;
>  	unsigned long pixel_clk_rate;
> @@ -269,6 +278,38 @@ int dsi_clk_init_6g_v2(struct msm_dsi_host *msm_host)
>  	return ret;
>  }
>  
> +int dsi_clk_init_6g_v2_9(struct msm_dsi_host *msm_host)
> +{
> +	struct device *dev = &msm_host->pdev->dev;
> +	int ret;
> +
> +	ret = dsi_clk_init_6g_v2(msm_host);
> +	if (ret)
> +		return ret;
> +
> +	msm_host->byte_src_clk = devm_clk_get(dev, "byte_src");
> +	if (IS_ERR(msm_host->byte_src_clk))
> +		return dev_err_probe(dev, PTR_ERR(msm_host->byte_src_clk),
> +				     "can't get byte_src clock\n");
> +
> +	msm_host->dsi_pll_byte_clk = devm_clk_get(dev, "dsi_pll_byte");
> +	if (IS_ERR(msm_host->dsi_pll_byte_clk))
> +		return dev_err_probe(dev, PTR_ERR(msm_host->dsi_pll_byte_clk),
> +				     "can't get dsi_pll_byte clock\n");
> +
> +	msm_host->pixel_src_clk = devm_clk_get(dev, "pixel_src");
> +	if (IS_ERR(msm_host->pixel_src_clk))
> +		return dev_err_probe(dev, PTR_ERR(msm_host->pixel_src_clk),
> +				     "can't get pixel_src clock\n");
> +
> +	msm_host->dsi_pll_pixel_clk = devm_clk_get(dev, "dsi_pll_pixel");
> +	if (IS_ERR(msm_host->dsi_pll_pixel_clk))
> +		return dev_err_probe(dev, PTR_ERR(msm_host->dsi_pll_pixel_clk),
> +				     "can't get dsi_pll_pixel clock\n");
> +
> +	return 0;
> +}
> +
>  static int dsi_clk_init(struct msm_dsi_host *msm_host)
>  {
>  	struct platform_device *pdev = msm_host->pdev;
> @@ -370,6 +411,46 @@ int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host)
>  	return 0;
>  }
>  
> +int dsi_link_clk_set_rate_6g_v2_9(struct msm_dsi_host *msm_host)
> +{
> +	struct device *dev = &msm_host->pdev->dev;
> +	int ret;
> +
> +	/*
> +	 * DSI PHY PLLs have to be enabled to allow reparenting to them and
> +	 * setting the rates of pixel/byte clocks.
> +	 */
> +	ret = clk_prepare_enable(msm_host->dsi_pll_byte_clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable dsi_pll_byte: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(msm_host->dsi_pll_pixel_clk);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable dsi_pll_byte: %d\n", ret);
> +		goto out_disable_byte_clk;
> +	}
> +
> +	ret = clk_set_parent(msm_host->byte_src_clk, msm_host->dsi_pll_byte_clk);
> +	if (ret)
> +		dev_err(dev, "Failed to parent byte_src -> dsi_pll_byte: %d\n", ret);
> +
> +	ret = clk_set_parent(msm_host->pixel_src_clk, msm_host->dsi_pll_pixel_clk);
> +	if (ret)
> +		dev_err(dev, "Failed to parent pixel_src -> dsi_pll_pixel: %d\n", ret);
> +
> +	clk_disable_unprepare(msm_host->dsi_pll_pixel_clk);
> +	clk_disable_unprepare(msm_host->dsi_pll_byte_clk);
> +
> +	return dsi_link_clk_set_rate_6g(msm_host);
> +
> +out_disable_byte_clk:
> +	clk_disable_unprepare(msm_host->dsi_pll_byte_clk);
> +
> +	return ret;
> +}
> +
>  int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
>  {
>  	int ret;
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

