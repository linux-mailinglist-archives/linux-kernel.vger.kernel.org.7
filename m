Return-Path: <linux-kernel+bounces-746795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A758AB12B4A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1519541745
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1E42857CD;
	Sat, 26 Jul 2025 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PTZRpZ+I"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73805191499
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753545403; cv=none; b=PLTdQZ4MBRNvEnK943NotRmb9ys72hSL/1apeGbpDubwXeP7SJJIq3Pl72yhZoBLph6Iwksr36t3SaNQvjHmDMQg0NegfdfHiIlq25GmPCMKd54cyF44k+gzaEMHeQTT+JY0E1+Zz+bEzI+e7TiVDNKD2qNEu7wN/XKUIEj9JWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753545403; c=relaxed/simple;
	bh=NN9VVT8eKGGUfYVLNCVVrHRfeyBum1eonJiuvh9tR/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSdMlI046JwcJwpksoXqpqlixJESyPVzNxCqt/slxkGt2XJig0QV0AmoZF6unnrUTnhg88DGHWCWRmuPsYsfdeBnWK32tVpi1hseWy3utZ2Fdmabl5v6S0ZXxI7KNDG1nMnB5O1Hvj4dp465bdZBxGJYrrqhDEtP+jy2wlC5Ajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PTZRpZ+I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56QDkuTm024569
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 15:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=tIrPQ8madd5jGCW14pSsiU+Q
	ivNVLu9kNYSOeVPgHuo=; b=PTZRpZ+Ir/Z0zGB4WJXGQP4XPc5xAt/EF92YCcV2
	CMoRLLSwsYrCVuMly4OUFWKX4Nnp7bRZHdR77HfNl0Myjro1/OR4qM3qj1+9hb8u
	LOHSouk6ohGTjL8iHcsPNByNw3/WRtkHHK450sr+EmhJu5fYiBRyGnP2tCeokIwD
	w31w5mUjzFUEaedLU0ZCDJWnf9ml8mzBSpJLLRBw6Jf9gnJQv3wzhQ1709MOsRA1
	cNBXlSVE2acz+ATp4JAIRlWpK4E3At3xVdcdkKDO+XLOcYUAkQnKNJlEeIH86gKb
	MKgGvhpXqxlcA6LKwxkXZoH/p4LAF5/fOLNAstWDDxpsqQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xgtss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 15:56:39 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7048088a6fdso51689006d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 08:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753545399; x=1754150199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tIrPQ8madd5jGCW14pSsiU+QivNVLu9kNYSOeVPgHuo=;
        b=QDFibCG0AZMhupu7BJBamQG56rX97UHZiLg+C/5fBKz58wLvRu7UI/4AobEYPZhtFD
         Q1jTwtfMdRUDDmnsoHu1XwvItNxjXSUjV9RZDYqrQpHfvtWhXAWzJtGwLLgWP2rEcI9E
         hMisOrk+GLmmns1FpYzpmQmi0N+/25R6SsvfWrmQiBqPX8hvhSWWi0caHgt0bid5gPCl
         Bis22ap+MuCRNNTYPlcfA8mIfaHTdV+kJPwKJ5JpoT3oaqeFvpIVvXbI4u1vFBh8sKKl
         v0/6/RJjGRrXiI538TiTWENWzg6aTeInUSTaqMpoq7tchCjOY6rQTsnDZUQG1Bzf7vbb
         QPrA==
X-Forwarded-Encrypted: i=1; AJvYcCUBMmq4vcnCHrSM8ajdWjMTbw7D656foFWhE7eDVISxKAENmicZwYrfX+juIwWBA+hqtcCQOhcPOLePXCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaMiO8TdXiRamND1i7TDMdgxqas3+6tR8St2dzKujcuQ6TM8DL
	cf5lJzyqctXXBCjaWWks+OwCBdOmSOLfG74jaJuxm6LxMhtX5GJmtJka1Wjt0ru1ZpxjuE/Xpy7
	E2PRxC+S6kvNDSZIJPioW8qVJrmC+Tt+4DA+0Kpd3iZixbVTG9uugM7qfj0Ug5alHoiY=
X-Gm-Gg: ASbGnctE/3uxvBwqPas3BHX3bu1AchldI1wmxfK6h66NqZJtMN/b+WKb99cD6jnghCf
	LoHA3b5vq8cP8eL4V0hIZbqx1nrQdGgVsRDJ1pIinmiCia97kbTiIBsGwacw9LVK5l5MTyP+TBU
	TgCfPHc9lKmmSDASUOu+sxuNe806dwJbvFdwHb3/VNfDkZbJO6s/MCLJxoC2l37tyL05Mf+qCpR
	P5z2bRCrJss1qpso28tvpthhsRT1a9HlZbg1gqykbxXh96VzHmGAR20fJZK/Vcu9BsGgASk6ErA
	cIx3BjuQE1db1Vs7lIWG5AeOBskqukXI1Jw57dNfnNamZSdWqHq59XbPJfFcbzrYsp4ECzvrbQ1
	Z+4HHgDyTbshWdj1188yTn5Lh5ipf32ZR/9JrXCe3RKac7YplDxuD
X-Received: by 2002:ad4:5ba7:0:b0:707:ba4:a21e with SMTP id 6a1803df08f44-707204b1297mr70903196d6.1.1753545398977;
        Sat, 26 Jul 2025 08:56:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu6/6Qrd0NVqUPcz9xf3nCGfxuIvGW3vtlwlKgmZwdgV3eV2NmRcB5QbvqysWqMLUcGNih9w==
X-Received: by 2002:ad4:5ba7:0:b0:707:ba4:a21e with SMTP id 6a1803df08f44-707204b1297mr70902886d6.1.1753545398413;
        Sat, 26 Jul 2025 08:56:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f426e396sm4837531fa.70.2025.07.26.08.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 08:56:37 -0700 (PDT)
Date: Sat, 26 Jul 2025 18:56:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, fengsheng5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        jani.nikula@linux.intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 drm-dp 06/11] drm/hisilicon/hibmc: add dp mode valid
 check
Message-ID: <btqoqwyxfykei6vyhmeczllewxyzf6xvr7r2hhowoentp3tdvi@vxrukpznwujk>
References: <20250718065125.2892404-1-shiyongbang@huawei.com>
 <20250718065125.2892404-7-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718065125.2892404-7-shiyongbang@huawei.com>
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=6884fab7 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=i0EeH86SAAAA:8 a=XbdV3e9dyi12BMDtw4MA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: mIy_rmniS9sgO5rVHiuoN2EWYT7jmGA-
X-Proofpoint-GUID: mIy_rmniS9sgO5rVHiuoN2EWYT7jmGA-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDEzOCBTYWx0ZWRfX7rHqpH7wPJgu
 ACAKcDVadu6fV2+pEYGedMFtv54zBqNyHM67f4dSxzMgVqv2L3y1wehO6rDZXw40T9OV1miHhMS
 YL4WgQB4vCHVxkucsbQucOXt727eH9r6uvCBjzxEbfYxvTm2tyaL6VnbEuWDV36vJSgY1PoaFav
 4Xg5Ju+oo421B4L57szWRzwvF9EDkLblq7dheNeFQH8hC+qrabyjzYUENuUGG8couV0n3KKMedl
 wKvNBHJ6yxz8HcX6PhIRR2JtLvEvbGfd00Rtj7AamEvZsFwKHk0a4AVMlDjUVyWJySKqULYMhYZ
 uHhQGE6lKRx8JkiKW2vsXBJ4a/nQ5HEwVkLE5JRsgBmwDUZ1NpFSor4LPgZB+mxGKGbRe8XmyoT
 hOrn0Pb30yX1vzrnyVhm7VzOhv7gdm72qbDIldIY+bLpCD4pmUSbBrZB0ZZFBT9tL/dTciKz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507260138

On Fri, Jul 18, 2025 at 02:51:20PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> If DP is connected, add mode check and BW check in mode_valid_ctx() to
> ensure DP's cfg is usable.
> 
> For example: Some DP's mode(1920x1080 60HZ 138.5 MHz) gives to drm,
> however, the GPU is configured for 148MHz in display_ctrl_adjust() by
> looking up the table of struct hibmc_pll_table{}. This difference will
> cause the DP to not display because the clock the DP gets via drm frame
> is 138MHz.
> 
> Fixes: f9698f802e50 ("drm/hisilicon/hibmc: Restructuring the header dp_reg.h")
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 10 ++++
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  6 +++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 51 +++++++++++++++++++
>  3 files changed, 67 insertions(+)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> index b4d612047f36..7fbd51ffd778 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> @@ -276,6 +276,16 @@ void hibmc_dp_reset_link(struct hibmc_dp *dp)
>  	dp->dp_dev->link.status.channel_equalized = false;
>  }
>  
> +u8 hibmc_dp_get_link_rate(struct hibmc_dp *dp)
> +{
> +	return dp->dp_dev->link.cap.link_rate;
> +}
> +
> +u8 hibmc_dp_get_lanes(struct hibmc_dp *dp)
> +{
> +	return dp->dp_dev->link.cap.lanes;
> +}
> +
>  static const struct hibmc_dp_color_raw g_rgb_raw[] = {
>  	{CBAR_COLOR_BAR, 0x000, 0x000, 0x000},
>  	{CBAR_WHITE,     0xfff, 0xfff, 0xfff},
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> index 9b45e88e47e4..0059a2648a38 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> @@ -12,6 +12,10 @@
>  #include <drm/drm_print.h>
>  #include <drm/display/drm_dp_helper.h>
>  
> +/* 27 * 10000000 * 80% = 216000000 */
> +#define DP_MODE_VALI_CAL	216000000
> +#define BPP_24				24
> +
>  struct hibmc_dp_dev;
>  
>  enum hibmc_dp_cbar_pattern {
> @@ -62,5 +66,7 @@ void hibmc_dp_reset_link(struct hibmc_dp *dp);
>  void hibmc_dp_hpd_cfg(struct hibmc_dp *dp);
>  void hibmc_dp_enable_int(struct hibmc_dp *dp);
>  void hibmc_dp_disable_int(struct hibmc_dp *dp);
> +u8 hibmc_dp_get_link_rate(struct hibmc_dp *dp);
> +u8 hibmc_dp_get_lanes(struct hibmc_dp *dp);
>  
>  #endif
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index 354e18bb2998..99b30a6c7e06 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -15,6 +15,28 @@
>  
>  #define DP_MASKED_SINK_HPD_PLUG_INT	BIT(2)
>  
> +struct hibmc_dp_disp_clk {
> +	u16 hdisplay;
> +	u16 vdisplay;
> +	u32 clock;
> +};
> +
> +static const struct hibmc_dp_disp_clk hibmc_dp_clk_table[] = {
> +	{640, 480, 25175}, /* 25175 khz */
> +	{800, 600, 40000}, /* 40000 khz */
> +	{1024, 768, 65000}, /* 65000 khz */
> +	{1152, 864, 80000}, /* 80000 khz */
> +	{1280, 768, 79500}, /* 79500 khz */
> +	{1280, 720, 74250}, /* 74250 khz */
> +	{1280, 960, 108000}, /* 108000 khz */
> +	{1280, 1024, 108000}, /* 108000 khz */
> +	{1440, 900, 106500}, /* 106500 khz */
> +	{1600, 900, 108000}, /* 108000 khz */
> +	{1600, 1200, 162000}, /* 162000 khz */
> +	{1920, 1080, 148500}, /* 148500 khz */
> +	{1920, 1200, 193250}, /* 193250 khz */
> +};

I generally think that these kind of tables are too limiting. Please try
to achieve the same by checking the clock with the PLL code instead of
checking the modes against the table.

> +
>  static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
>  {
>  	const struct drm_edid *drm_edid;
> @@ -42,9 +64,38 @@ static int hibmc_dp_detect(struct drm_connector *connector,
>  	return connector_status_disconnected;
>  }
>  
> +static int hibmc_dp_mode_valid(struct drm_connector *connector,
> +			       const struct drm_display_mode *mode,
> +			       struct drm_modeset_acquire_ctx *ctx,
> +			       enum drm_mode_status *status)
> +{
> +	struct hibmc_dp *dp = to_hibmc_dp(connector);
> +	u64 cur_val, max_val;
> +
> +	/* check DP link BW */
> +	cur_val = (u64)mode->htotal * mode->vtotal * drm_mode_vrefresh(mode) * BPP_24;
> +	max_val = (u64)hibmc_dp_get_link_rate(dp) * DP_MODE_VALI_CAL * hibmc_dp_get_lanes(dp);
> +
> +	*status = cur_val > max_val ? MODE_CLOCK_HIGH : MODE_OK;
> +
> +	/* check the clock */
> +	for (size_t i = 0; i < ARRAY_SIZE(hibmc_dp_clk_table); i++) {
> +		if (hibmc_dp_clk_table[i].hdisplay == mode->hdisplay &&
> +		    hibmc_dp_clk_table[i].vdisplay == mode->vdisplay) {
> +			if (hibmc_dp_clk_table[i].clock != mode->clock) {
> +				*status = MODE_CLOCK_RANGE;
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
>  	.get_modes = hibmc_dp_connector_get_modes,
>  	.detect_ctx = hibmc_dp_detect,
> +	.mode_valid_ctx = hibmc_dp_mode_valid,
>  };
>  
>  static int hibmc_dp_late_register(struct drm_connector *connector)
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

