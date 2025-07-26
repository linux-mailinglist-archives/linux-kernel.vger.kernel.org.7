Return-Path: <linux-kernel+bounces-746785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5922B12B13
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF2A1C20E5C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDA7242D68;
	Sat, 26 Jul 2025 15:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ODRrSFI5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2BF21A425
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753542567; cv=none; b=DTKbWWnW9PloqGEgpUkraMAlR90OXmVP82zd5u2x00OhCIKN2UpT+1Xb/wNeHXg2IMMc+s4FQt+G12pe+3WCb4/LGVOgPf/qwr9TEUKSa0fi4crRATKrNkK3AJ02Ef8rRLAvMsGFVGQd5oNqjEinXxJxAC0GiGmkkxq6YQalQo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753542567; c=relaxed/simple;
	bh=okJe6yh9v8uuAGRBrwp135oARlrz/vOci+1yETy4xuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUK5BSe9A3KW1T9CDq+CGYAWQpLxXQoQESnbMpbcwlAe/98w6JqchfO4WmjMX3Ox2hoG9CKNe7ODBenaXcatltGANWcYzXT8VDBuj1kD6oNiQL9oPqIXjTEp1XxNHka0nIostONGpY1kFD1GeVEb4yaPvIaZuww7IdBw1iIOst4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ODRrSFI5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56QBR9Gf021184
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 15:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ixn5D6011HJHnN4b/bvT9nT2
	5y5QsLKPv3noCoNau3Y=; b=ODRrSFI5coiqiyA9HOcv4aRexKNxMGBu5didthN+
	1fr2x3KZu01VHyR8yNbfiSxP8NmbGrw+Ixa1yURrEwwlTy8zlOu6RxBruyXkDctX
	OcBCzcy/LouRHjwmEXK3TcDK3KaulE3leJgt0h9xyBMdWybMCxZbQw0n9NHNrsPd
	eN3OPGGEENi36iDpHWia3Ij1BQSkMoHT/GqMa6dcvQuOx2l88pCFCk+JWSwLBtrd
	eto9/HKu0lWmWxPLmlLh94C6suvB1jmjDGSsZ9F9E5aCabUMh+FZJwasJYdb2Qx6
	ebPPvlzSt4t8eah91LsCo+uuyOZy7eIYs1KFgGdVtUYJtQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pm28syf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 15:09:24 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7073140087aso8531146d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 08:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753542564; x=1754147364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixn5D6011HJHnN4b/bvT9nT25y5QsLKPv3noCoNau3Y=;
        b=Af8Jvkdg+5SE1r1N21yxzybm1wYi+DNCq5O9SX2fdzD7A1mhDHlCLfe6pRCDh98bIL
         9d8ebnX6rEAX5wD7D0XuiK/R1vImHvlybvWi+1jVlm2YuynZSQth94Wvs6BYhD5U9w36
         ziD3EG7nOTK7+f0Cpn8UQ/9m+X7/JGFqC5Xzl00xdALCLAdvhm/j9sM2xx4x2IAa57ML
         tL6layD3qPI8xQVmrocwqY4Z8qlnYE0AvupKQtWGfHW2hsrOuhEqkNB2/SrmSlGKliQO
         vYYSHJIvDQCFfJe8+U6VobqMn3AfNiVnH8QCR1KIBlg/4f200m8NRV7KJJsAt7XQBaHj
         ROBg==
X-Forwarded-Encrypted: i=1; AJvYcCVwtXiD7rxi0d817jfe1187cnpONF+SxK4+4/CPn3VyiKxN1cqWEGCeNeySYsnBEQvyoJgrCRV+jeU6o/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVAoYSC0CxdcTLw3KqoN/6pdxt372/BTG5NArruV+g4+p9+xhy
	hgDT0MYgs/PFQHxDTGlu0zfGiW/xEUNRJQpSEZd0+tJLMJ8rZQ9LqqGJhZ5NUZIsRQ0zwh38dfD
	mWkx1zIeE6Fn9MF/kprv/+PnhYOim/gEtRNP2iCnaQmKIT99WsES2do53elS88bxrY2I=
X-Gm-Gg: ASbGnctDqfL4s9Av0p6dmJmm02rLHEhabxcdirR14AIe0gUAIOMynxTy8LxmwERM+EU
	K9dAczK3aO6wh5fxv1aIiOpSDbrODWaIwqNcfaDTzNn1k0615HPyUZpARZAjAXTWTwkiNceSdEX
	qP1mqETNxK75isJqXhE5FZZvL/AXIrKhnct8jbkdOAwnxgveFQSaMOXAq153oE/p1WfJtFaIsZT
	ycjQhBnonXedQVVTe6qdLgnJPqVCI+25PlmKXD3scbqaccDGpEBt0/9Wkr3XWuPyMpHd4G25wyR
	dZ2tAMMIjEZBaRSOKWrKl+pxHZGayaQ9lFTsNmcgyNuRymd4Sf1KYSJJ12Xqk5v7KDXLYK5Lbew
	D5vpoIfJnWNBODcZSMiRIOEqhxYcwRSFVO9P2kZBWZeOV8UTDWpPl
X-Received: by 2002:a0c:e34f:0:b0:707:23a2:f57c with SMTP id 6a1803df08f44-70723a2f8e4mr47702556d6.30.1753542563772;
        Sat, 26 Jul 2025 08:09:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy1JODq1MZqt5dpjdetFUJ9lRnqH7LIhbzdGEOoche9a8M9EHiu3rVcJDYdyKqBn/gYOvZQw==
X-Received: by 2002:a0c:e34f:0:b0:707:23a2:f57c with SMTP id 6a1803df08f44-70723a2f8e4mr47702246d6.30.1753542563268;
        Sat, 26 Jul 2025 08:09:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f4278c27sm4508101fa.76.2025.07.26.08.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 08:09:22 -0700 (PDT)
Date: Sat, 26 Jul 2025 18:09:19 +0300
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
Subject: Re: [PATCH v3 drm-dp 05/11] drm/hisilicon/hibmc: fix rare monitors
 cannot display problem
Message-ID: <hx6dx2xxkdjyrhjz24bnnomywsvup532bk3jo3oswzftid6yyw@gu2bjjk4ahrm>
References: <20250718065125.2892404-1-shiyongbang@huawei.com>
 <20250718065125.2892404-6-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718065125.2892404-6-shiyongbang@huawei.com>
X-Proofpoint-GUID: zpBWY8sEDLVEueH4lb9TaOkvuuVFs0DP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDEzMiBTYWx0ZWRfXwa9qPp+ugjk4
 J3eo+N46kByhHREOXnDcp0E+W3Tb/JP6lEKtyhlwcuKOvnUNFFL7XFZ2OdFwtE5ojrHCKByAmxe
 /oQdju8Pxv6BaC29yOaMnA+zthyn6AldmXM3Ob3NXogxD9O1pzHEwlRq4I4FNS5zs1yLUMZKh8J
 NMbC/2wJZgZ236mdbHlKA4MnFaZhC4aD1c68Yj/EgxKHDy+0wkBPD3SxqSjUDiKJ3yxhZA0jpP0
 SWJFTVbEhcsVvDOhgAUIuPjfyFOUNs0/nDQ64dzk2gaE8eyjOgTLAb53w2hXGidjH3t6dCX+L//
 pzsYBxDbGO0PvYAZMj1fwFB2NAvex9TppAEdPxu/orCrw9STqtnCU/swRggfENCTrfxh1FjXmdl
 t3VH9AIumEGSxv7aDnOet4zww93IQa/ugHgKlsZAGCRCb15Qu6W73XyuvAZsnnGFvm2Ieqsd
X-Authority-Analysis: v=2.4 cv=HfYUTjE8 c=1 sm=1 tr=0 ts=6884efa4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=i0EeH86SAAAA:8 a=hhupN-KlCfBdHl9C51QA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: zpBWY8sEDLVEueH4lb9TaOkvuuVFs0DP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507260132

On Fri, Jul 18, 2025 at 02:51:19PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> In some case, the dp link training success at 8.1Gbps, but the sink's
> maximum supported rate is less than 8.1G.  So change the default 8.1Gbps
> link rate to the rate that reads from devices' capabilities.

You are doing more than changing default link rate. Please split away
non-related changes. This is especially imporant for Fixes commits.

> 
> Fixes: 54063d86e036 ("drm/hisilicon/hibmc: add dp link moduel in hibmc drivers")
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h  |  4 ++-
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    |  6 +---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c  | 33 +++++++++++++------
>  .../gpu/drm/hisilicon/hibmc/dp/dp_serdes.c    | 12 -------
>  4 files changed, 27 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> index 4add05c7f161..18a961466ff0 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_comm.h
> @@ -25,6 +25,9 @@ struct hibmc_link_status {
>  struct hibmc_link_cap {
>  	u8 link_rate;
>  	u8 lanes;
> +	int rx_dpcd_revision;
> +	bool is_tps3;
> +	bool is_tps4;
>  };
>  
>  struct hibmc_dp_link {
> @@ -62,7 +65,6 @@ struct hibmc_dp_dev {
>  
>  void hibmc_dp_aux_init(struct hibmc_dp *dp);
>  int hibmc_dp_link_training(struct hibmc_dp_dev *dp);
> -int hibmc_dp_serdes_init(struct hibmc_dp_dev *dp);
>  int hibmc_dp_serdes_rate_switch(u8 rate, struct hibmc_dp_dev *dp);
>  int hibmc_dp_serdes_set_tx_cfg(struct hibmc_dp_dev *dp, u8 train_set[HIBMC_DP_LANE_NUM_MAX]);
>  
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> index 2d2fb6e759c3..b4d612047f36 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> @@ -155,7 +155,6 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>  {
>  	struct drm_device *drm_dev = dp->drm_dev;
>  	struct hibmc_dp_dev *dp_dev;
> -	int ret;
>  
>  	dp_dev = devm_kzalloc(drm_dev->dev, sizeof(struct hibmc_dp_dev), GFP_KERNEL);
>  	if (!dp_dev)
> @@ -169,13 +168,10 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>  
>  	dp_dev->dev = drm_dev;
>  	dp_dev->base = dp->mmio + HIBMC_DP_OFFSET;
> +	dp_dev->serdes_base = dp_dev->base + HIBMC_DP_HOST_OFFSET;
>  
>  	hibmc_dp_aux_init(dp);
>  
> -	ret = hibmc_dp_serdes_init(dp_dev);
> -	if (ret)
> -		return ret;
> -
>  	dp_dev->link.cap.lanes = 0x2;
>  	dp_dev->link.cap.link_rate = DP_LINK_BW_8_1;
>  
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> index 74f7832ea53e..6c69fa2ae9cf 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_link.c
> @@ -39,6 +39,14 @@ static int hibmc_dp_link_training_configure(struct hibmc_dp_dev *dp)
>  	/* enhanced frame */
>  	hibmc_dp_reg_write_field(dp, HIBMC_DP_VIDEO_CTRL, HIBMC_DP_CFG_STREAM_FRAME_MODE, 0x1);
>  
> +	ret = hibmc_dp_get_serdes_rate_cfg(dp);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = hibmc_dp_serdes_rate_switch(ret, dp);
> +	if (ret)
> +		return ret;
> +
>  	/* set rate and lane count */
>  	buf[0] = dp->link.cap.link_rate;
>  	buf[1] = DP_LANE_COUNT_ENHANCED_FRAME_EN | dp->link.cap.lanes;
> @@ -325,6 +333,20 @@ static int hibmc_dp_link_downgrade_training_eq(struct hibmc_dp_dev *dp)
>  	return hibmc_dp_link_reduce_rate(dp);
>  }
>  
> +static void hibmc_dp_update_caps(struct hibmc_dp_dev *dp)
> +{
> +	dp->link.cap.rx_dpcd_revision = dp->dpcd[DP_DPCD_REV];
> +
> +	dp->link.cap.is_tps3 = (dp->dpcd[DP_DPCD_REV] >= DP_DPCD_REV_13) &&
> +			       (dp->dpcd[DP_MAX_LANE_COUNT] & DP_TPS3_SUPPORTED);
> +	dp->link.cap.is_tps4 = (dp->dpcd[DP_DPCD_REV] >= DP_DPCD_REV_14) &&
> +			       (dp->dpcd[DP_MAX_DOWNSPREAD] & DP_TPS4_SUPPORTED);
> +	dp->link.cap.link_rate = dp->dpcd[DP_MAX_LINK_RATE];
> +	dp->link.cap.lanes = dp->dpcd[DP_MAX_LANE_COUNT] & DP_MAX_LANE_COUNT_MASK;
> +	if (dp->link.cap.lanes > HIBMC_DP_LANE_NUM_MAX)
> +		dp->link.cap.lanes = HIBMC_DP_LANE_NUM_MAX;
> +}
> +
>  int hibmc_dp_link_training(struct hibmc_dp_dev *dp)
>  {
>  	struct hibmc_dp_link *link = &dp->link;
> @@ -334,16 +356,7 @@ int hibmc_dp_link_training(struct hibmc_dp_dev *dp)
>  	if (ret)
>  		drm_err(dp->dev, "dp aux read dpcd failed, ret: %d\n", ret);
>  
> -	dp->link.cap.link_rate = dp->dpcd[DP_MAX_LINK_RATE];
> -	dp->link.cap.lanes = 0x2;
> -
> -	ret = hibmc_dp_get_serdes_rate_cfg(dp);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = hibmc_dp_serdes_rate_switch(ret, dp);
> -	if (ret)
> -		return ret;
> +	hibmc_dp_update_caps(dp);
>  
>  	while (true) {
>  		ret = hibmc_dp_link_training_cr_pre(dp);
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c
> index 676059d4c1e6..8191233aa965 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_serdes.c
> @@ -57,15 +57,3 @@ int hibmc_dp_serdes_rate_switch(u8 rate, struct hibmc_dp_dev *dp)
>  
>  	return 0;
>  }
> -
> -int hibmc_dp_serdes_init(struct hibmc_dp_dev *dp)
> -{
> -	dp->serdes_base = dp->base + HIBMC_DP_HOST_OFFSET;
> -
> -	writel(FIELD_PREP(HIBMC_DP_PMA_TXDEEMPH, DP_SERDES_VOL0_PRE0),
> -	       dp->serdes_base + HIBMC_DP_PMA_LANE0_OFFSET);
> -	writel(FIELD_PREP(HIBMC_DP_PMA_TXDEEMPH, DP_SERDES_VOL0_PRE0),
> -	       dp->serdes_base + HIBMC_DP_PMA_LANE1_OFFSET);
> -
> -	return hibmc_dp_serdes_rate_switch(DP_SERDES_BW_8_1, dp);
> -}
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

