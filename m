Return-Path: <linux-kernel+bounces-746783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1275CB12B0F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD971885D1B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074F7226CE5;
	Sat, 26 Jul 2025 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kjiwna85"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7819B3EC
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753542245; cv=none; b=f4D5Czl5UL1ggVIhM1T6H0LUmrFlTI31NHDx9WxGb1OFK1aZMSJs7ku0C6EOsMSdQziDP2jZgKVdj8t+NXSwckL32eoZbmXkXb8ghCrjN0ibWSmxKhFtjV1IbuJbQVLT4n0UFY8A90UptJfulzRkQ+b/GitoNgKTb8JLAlQ6QzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753542245; c=relaxed/simple;
	bh=0fYurmCO3K4/iISAi04fPhQ1dV3UqSuH6sWM7Bzt1lE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwvajx5Z4G5kCT/pOTAptlhVuHng/52fRzn3tN9Y3c4CfgNveRG2dS/V9vu6jy5/pyWfGLjKgYvyUsFVtcfk+xHHWVo84Va4cX5fUxfPB2FNEWLS4z6YVuuwn0X+i00ZfJ4Xj1TvdR5ZZyAecHBCv0JX/st0BCYhHEv3hOPaGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kjiwna85; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56QBio9C006675
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 15:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KOu2HhfwicxO6ZxeG9X/WFZX
	3rLbNpoLtuIggGSR5aA=; b=Kjiwna85FCEgUu7k9O9X4SQsDuhwUSJF2Aj9HUwC
	MRR6sYLRLgmmKJBBYlW2r6Bo2BDVv5Vt3pbdlCV0cbGA/8bTlrJT7uYXjLcUbUvX
	F+DeBoW9PVNzSiae8JE4Jl0Iif4Mw8x+gZW8HHCbhNw9EylbLiVz/DVOwqBhMkdf
	75UxaFb8UbFGJbU6heHCvnYQ1Ip3sb5m8pRVjOYtcfIETuYWCFPRLUDs5p58+Zeb
	qunW7mZW+7GmPEiMuIjRqhKemnkVQRdivbBhvTTrCw6eqPoL143MQ4GIhB9oNArp
	iB7ns8j+pLrdtsb7mFTulck89JDtSCDJcUpFnymHqw2Ysg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xgs4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 15:04:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e2c8137662so656870185a.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 08:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753542241; x=1754147041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOu2HhfwicxO6ZxeG9X/WFZX3rLbNpoLtuIggGSR5aA=;
        b=aye3NbiJVFhHoNtpIOMAo8bafPkf6viw1nZTosjK76PBbJlQAAAjIT0uSmx6w6Zy8e
         QEFY1ZC6rFtOWGLQ8Q41pGK8kPDXae6rT2tIWHKV4x31WJOvj5Osgpr2loTe5PFcOJfR
         s7ivhR62zaUutstexXqK1GxPGowiXxlOQ4udnBtXJ9sp/lv+zZ8V9rqwoVyX615OCW5m
         7LNtDUZPSYZaIMlCuczoFYkrqraJAWIOOWTo9tNoL/hoBblvWj3Mqqm4JkV+0gnV4CZu
         aJEmgg5v9qhA/9C/5onf8raBCahsqcmfl+LbCqNa6I1W2pJ+hJ9DBLJy7PAI2qqu2jII
         rgRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9M4B0IFDUCzovvdjbLe8m0TQMXCEawD88QBPM6jwvrZWJs0AcXr0y256uIM7YLpGHfiHoUr8vcTU+1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZQdPQt2VUPK8mGrzHoHPE9YhpspLrQAux3CabM/3SSbCmn1vw
	bPHNE3odDJEyTSERtv0FDaHVOLNBvb3mZnTEykvN7N/FgZbQW7TVGQhm8zKknAWyPD2F7qSYGMD
	LLPXTJCfIDzTC/wM7TfAadlLVSHVMh/lNLaWjC5UuKCc+5xHUjQiZ0TcJtfvqhXKS9nI=
X-Gm-Gg: ASbGncvafl72nLATw61ghkzUq4LgbmTPhNMkSi17Fs7Q0jU1Qlu1OrWwj1eJt3zD3pJ
	Ue04DegDUVsJjTf5q5N1OqEGlCSqHQDZ4fEULubBsLNWx6bj25lp6zZn9Wbw+Uhq2l3vXyQbPDa
	l7+S0rtXPrTGVPA/+XVuuEE9yWomhTQvVSJC2191gny3q2pGkoBbYgrVH0NYyPfLB+l9ggLdCau
	YscwOBRIAIAAfCa0ZHZhI+adI5KBQvsIdoOVdqH6uHGs6JygqKn6uTu5KBOUHdQtbKrdyBLRKzl
	4EIj7XfgPSTVvTfioQXcYVbfANE6svD+1DlPN0OkRkNscfwEMR21IIvYakqfyaErP4SW3S14cFL
	lNi3c0ZJ6P3MrzL+jbEXQrU0nAhnb5CEQ4iFNRZMuVicyUg8RF8f2
X-Received: by 2002:ae9:ec0d:0:b0:7e6:23cb:7296 with SMTP id af79cd13be357-7e63bfa9366mr542097585a.28.1753542240613;
        Sat, 26 Jul 2025 08:04:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGUQ75TTFS9K8q+wvTov62ezkk3euJnllrq1rTL7FabL3OM09p2joBg1In9i43RdV7z39fKg==
X-Received: by 2002:ae9:ec0d:0:b0:7e6:23cb:7296 with SMTP id af79cd13be357-7e63bfa9366mr542091985a.28.1753542239923;
        Sat, 26 Jul 2025 08:03:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b633637c8sm478424e87.113.2025.07.26.08.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 08:03:57 -0700 (PDT)
Date: Sat, 26 Jul 2025 18:03:55 +0300
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
Subject: Re: [PATCH v3 drm-dp 02/11] drm/hisilicon/hibmc: fix dp
 probabilistical detect errors after HPD irq
Message-ID: <f7co2accpkvt4b5jy7ar4j6jqiytmysd3ki32hvhg7w2ohqoo6@nwwxeif6f73q>
References: <20250718065125.2892404-1-shiyongbang@huawei.com>
 <20250718065125.2892404-3-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718065125.2892404-3-shiyongbang@huawei.com>
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=6884ee62 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=i0EeH86SAAAA:8 a=-x_x-SBnuhrWNgYMQ54A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: n4QtOtvuxigHHMEJBCiCgxnElzKwI9dQ
X-Proofpoint-GUID: n4QtOtvuxigHHMEJBCiCgxnElzKwI9dQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDEyOCBTYWx0ZWRfX/368xM85ww4O
 9CzEFHUF0I7zldFgGecv0QtpFIKbqw5/CVRS4nGHDum3bXF1xOzzxg18Q9yC/su5+GRZyi+tgyc
 pw1oI6sBbstpr028BT6xk/dnYaSmlboyVuLD9gfeHncJw4Q+KvOpqY9la8qLlYfn2LSWgy9iPkZ
 w4q1GXNCy0ptzI+c7Bvu4ddso9idy4medKRoDZsbre5HgHM0j5q5fphkUztpftQgKLJ8JHxCWXf
 tX1WYZmm4IucYhxaLL9faYW9O65DTiWeretcnXOAm/1xBLUKdlMMBV+09diLewapSGhpkb0PZzi
 8HltblFLqdRet7dVaUz3mNh7Fb0CdXecUBeu7G3tr9fgG9AiZaBtPji6iXioSXTgC2a+rFQb7IF
 YNOnrFePZj61fz83Wd/AS8liutNtcOFPZM0OI7kiHUqM2EZHvg5CY2PZ5dvLB+ASyto7rH95
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507260128

On Fri, Jul 18, 2025 at 02:51:16PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> The debouncing when HPD pulled out still remains sometimes, 200ms still can
> not ensure helper_detect() is correct. Add hibmc_dp_detect_link() in
> detect_ctx(), which is to try dp link training.

I'm not sure if I follow the commit message. Anyway, link training
should be a part of atomic_(pre)_enable, not a detect_ctx.

> 
> Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c    | 27 +++++++++++++++----
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  2 ++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 10 ++++---
>  3 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> index 8f0daec7d174..2d2fb6e759c3 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> @@ -3,6 +3,7 @@
>  
>  #include <linux/io.h>
>  #include <linux/delay.h>
> +#include <drm/drm_managed.h>
>  #include "dp_config.h"
>  #include "dp_comm.h"
>  #include "dp_reg.h"
> @@ -162,6 +163,8 @@ int hibmc_dp_hw_init(struct hibmc_dp *dp)
>  
>  	mutex_init(&dp_dev->lock);
>  
> +	drmm_mutex_init(drm_dev, &dp->link_train_mutex);
> +
>  	dp->dp_dev = dp_dev;
>  
>  	dp_dev->dev = drm_dev;
> @@ -238,19 +241,33 @@ void hibmc_dp_display_en(struct hibmc_dp *dp, bool enable)
>  	msleep(50);
>  }
>  
> -int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode)
> +int hibmc_dp_detect_link(struct hibmc_dp *dp)
>  {
>  	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
> -	int ret;
> +	int ret = 0;
> +
> +	mutex_lock(&dp->link_train_mutex);
>  
>  	if (!dp_dev->link.status.channel_equalized) {
>  		ret = hibmc_dp_link_training(dp_dev);
> -		if (ret) {
> +		if (ret)
>  			drm_err(dp->drm_dev, "dp link training failed, ret: %d\n", ret);
> -			return ret;
> -		}
>  	}
>  
> +	mutex_unlock(&dp->link_train_mutex);
> +
> +	return ret;
> +}
> +
> +int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode)
> +{
> +	struct hibmc_dp_dev *dp_dev = dp->dp_dev;
> +	int ret;
> +
> +	ret = hibmc_dp_detect_link(dp);
> +	if (ret)
> +		return ret;
> +
>  	hibmc_dp_display_en(dp, false);
>  	hibmc_dp_link_cfg(dp_dev, mode);
>  
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> index 665f5b166dfb..9b45e88e47e4 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> @@ -50,9 +50,11 @@ struct hibmc_dp {
>  	struct drm_dp_aux aux;
>  	struct hibmc_dp_cbar_cfg cfg;
>  	u32 irq_status;
> +	struct mutex link_train_mutex; /* link training mutex */
>  };
>  
>  int hibmc_dp_hw_init(struct hibmc_dp *dp);
> +int hibmc_dp_detect_link(struct hibmc_dp *dp);
>  int hibmc_dp_mode_set(struct hibmc_dp *dp, struct drm_display_mode *mode);
>  void hibmc_dp_display_en(struct hibmc_dp *dp, bool enable);
>  void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg);
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index d06832e62e96..354e18bb2998 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -34,9 +34,12 @@ static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
>  static int hibmc_dp_detect(struct drm_connector *connector,
>  			   struct drm_modeset_acquire_ctx *ctx, bool force)
>  {
> -	mdelay(200);
> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(connector->dev);
>  
> -	return drm_connector_helper_detect_from_ddc(connector, ctx, force);
> +	if (!hibmc_dp_detect_link(&priv->dp))
> +		return connector_status_connected;
> +
> +	return connector_status_disconnected;
>  }
>  
>  static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
> @@ -128,8 +131,7 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
>  		hibmc_dp_reset_link(&priv->dp);
>  	}
>  
> -	if (dev->registered)
> -		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
> +	drm_connector_helper_hpd_irq_event(&priv->dp.connector);
>  
>  	drm_dev_exit(idx);
>  
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

