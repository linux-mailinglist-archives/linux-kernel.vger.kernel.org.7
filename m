Return-Path: <linux-kernel+bounces-768372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF40B26072
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EBC1C20E98
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAEE2ECEBD;
	Thu, 14 Aug 2025 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="naplBDp7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A187F2EB5D3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162364; cv=none; b=gVdpxsJuLAwI8ZNzyfGvgVcPJnrcbuBEzGJ4u5qdaiooYmETJ54mUEe0dFtfPduJttPMHy872NhJPsq/Uufmq68G3U5C3E3j4INQOkO6u2Z5zT0KNR2J4x/ipRa3PjBBNAemWYuyCflstfSwuPzN9KPk1OFVnz6AyN68weWj/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162364; c=relaxed/simple;
	bh=NI+dYIxxhqJp999IOMqAx81Qp2Q0vsobR7QCx/rzeh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLJ/YqM+BNIH4Wzlx8TQ9DMaWSQ+1bLhEk9WDFDVwD3RvFhZYLcTglbiWbDdtciAiIXnTbyp1OyrD84BUdl3V3Minb12O3LSFQmMSrEfpd/vEioX0mN7/1j4ePD7hcG43A/5L2ht35RAID3/Chz1266vxEsgL/KDSFkJO/dtU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=naplBDp7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMbjfH029114
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=u83LGKfQavcBzgp0I3ktMakL
	FeOK42oeRXtS8jSDHss=; b=naplBDp74OJuAWrMcC7asyzHAH1NU4XFaVhpCHJb
	QAR8CSv5NU496F8ccOFesaKKpNY1Z5X+dQSSbuyK2yla+APLrTrusQREBQXCXptS
	3hfXcOl2HSxnJN6SdQ6yAJtXbRqy1kfKnnd7XFar1XKBpMUTjzClAnRYsySFKkZS
	uuPwK9KKOiKzOFsTY7qHhIPrPPKoXJUiEXm/Vp+5g4gOgep1FzJ/7qEa2B56M0ui
	XaPsR7nKQ7R2NCW8syC6mJLHgAfwKPRLEanJXlsjwIRGEC+oLFfmwgcWbh+b9Xgs
	owsPoKQBTrVvGOQ9HnhXasgAo4+1Af0dM1vC8DnK/6BkoA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9x4h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:06:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b109affec8so18128321cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162360; x=1755767160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u83LGKfQavcBzgp0I3ktMakLFeOK42oeRXtS8jSDHss=;
        b=sPmX8rMZJHQiIeLJjTa4LXP4YrHw9kYYkKNpJEU90XZsXDw6coH0etjGLb6GoEIPQw
         k1Hwd8YATbkqgXvAJM/IpWLKcd3cSoPvnBeJRT+ThE4tU/ruSwnyWj+6BgrV6rAwImmW
         cNbxw87SOetk28Eq/dLHeCWdjuqNDsVjFSTdoAIyj6Q29bZBw3mLu1TZFx1vWC9BF0cv
         SlGu9ncjpZP1xGNq9aB9kuckQ3yK9tbCQcJ/yWPCvo0Diks2lrCcB7QbbawJur5gEYEi
         RYGs7/3au3bPCdKx4ZGllrjMqe/0nCnWQnZ1k2QaysaLhme5KD9Ff8YMswMpPnY59lqh
         +N3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvSXxmR0lqn0aWR8XghEkgxfiMe3/1kfSvDgBD8++6ZBXhjBQmvVMYEnP8KWsmVMNDXbteexd51o7zbZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHQ9iQ8HTqY6AQPGdSwpYCFBRGdoAJmPkNwO7txN7KJYrlkTP+
	PmqyKoY5ZtwMtxrsaWmiBHD5XYSOvsHqBQ7FJSAbn+r81R6RlopkZXdBPm0bkvS52q4jJF2YIOj
	MxA6w53pzsV6h5taxvK9CsDsrPjgYf4+iqkJwDO3/D5177TcVJMpW11IOLLTGqzop0Kk=
X-Gm-Gg: ASbGncudCGLhZ0Eq+1vF9hvr1868qPGp7lFSI7apumsS0QYlcnOMgJvqr0X4WPoPxlm
	gLwsKm+2mhV7oBPLaHsBGtBklyOrmEsG2oduGWluO9f7QMZOGl5btsKO+NTydsy8mcNb/K9NZrH
	3/WhIVC6fVxdWKghOaJROyi2vYurvzvc6W4GWqjNYSXSAdvDLayfkVmEyQAmKVDANCJW+FrlbsI
	dQndrrfJxjdPBXVLi8wy4i/3fKQudztBoG9JZYU6CysqkSjrCITPfnifGJOG1XiBGlLcMZfWC03
	h459WkMVmuINGLhkJ6treydpGnY8vl8WnEtDrPp9fE4z3UbN1CFX4aBGCj8O5v4P06zhPQ+XnDa
	Ph8ET8iuhAv3Efnc+1STsxBT5e5kEGpj+VpvlyrFqEAqnNyrNA11e
X-Received: by 2002:a05:622a:11:b0:4af:1912:5966 with SMTP id d75a77b69052e-4b10ab03114mr29191311cf.55.1755162360560;
        Thu, 14 Aug 2025 02:06:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHflOgmqWtfQyIjvsUEupQSwbEKJuD51/ae0PBG04IRq+7Km2Le+7kgi+QLV5PttmGOq5tpw==
X-Received: by 2002:a05:622a:11:b0:4af:1912:5966 with SMTP id d75a77b69052e-4b10ab03114mr29190971cf.55.1755162360054;
        Thu, 14 Aug 2025 02:06:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55ccd2fa76esm2229886e87.120.2025.08.14.02.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:05:59 -0700 (PDT)
Date: Thu, 14 Aug 2025 12:05:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, fengsheng5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 drm-dp 02/11] drm/hisilicon/hibmc: fix dp
 probabilistical detect errors after HPD irq
Message-ID: <aayi7zjrmru2ancexrqmcutams6ohde3nrkhqacixwp45dsk4v@7ig6hqzahdxf>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
 <20250813094238.3722345-3-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813094238.3722345-3-shiyongbang@huawei.com>
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689da6fa cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=i0EeH86SAAAA:8 a=Wb6V2SaiAW0i5CbIPAAA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: la7KuPVcbe-_ONYtoiajC5LAU-O2cFDc
X-Proofpoint-ORIG-GUID: la7KuPVcbe-_ONYtoiajC5LAU-O2cFDc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfXy6vs2WcqwIEP
 UyhjRfuC0rb1+v7Pta5ziPiIbFGkfWgem2fCB9nsrhPi5j6mZAwWrm3hV1gfe22GMkXJ2uqah1T
 bIGK8RBtvrpN5x0N/qxOIWwn6/BQ9SzA86XwR0hI28b1++/X8HQhHsslxjXUhyIU6UJuhv5Wl7D
 1HrFsG1hVA4U/2TERmm9vxEzNA9FWXUY6+pxzzGmmWrdhyyj57KQVsrk7Aw7rDtNBsMucau9WXr
 PII2aWDw0x0MUy0BsiPA/18lf6wjXTRNWDVelGt8qa5VAeeKnTaOYBmJcqKQFY2JToZ9N/wghUL
 VYxo+hDL2T9/yq31ZrjHQN1iKRb0aizpStSLaOSiRysBnMLQxiXnO/g9YF4PFKJCZXMiMeFhboX
 gBBVeFue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

On Wed, Aug 13, 2025 at 05:42:29PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> The debouncing when HPD pulled out still remains sometimes, 200ms still can
> not ensure helper_detect() is correct. So add a flag to hold the sink
> status, and changed detect_ctx() functions by using flag to check status.

THis doesn't explain what is wrong with
drm_connector_helper_detect_from_ddc(). In the end, this function
doesn't use the HPD pin.

> 
> Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v3 -> v4:
>   - remove link training process in hibmc_dp_detect(), suggested by Dmitry Baryshkov.
>   - remove if (dev->registered), suggested by Dmitry Baryshkov.
> ---
>  drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  1 +
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 19 ++++++++++++-------
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> index 665f5b166dfb..68867475508c 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> @@ -50,6 +50,7 @@ struct hibmc_dp {
>  	struct drm_dp_aux aux;
>  	struct hibmc_dp_cbar_cfg cfg;
>  	u32 irq_status;
> +	int hpd_status;
>  };
>  
>  int hibmc_dp_hw_init(struct hibmc_dp *dp);
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index d06832e62e96..ded38530ecda 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -34,9 +34,12 @@ static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
>  static int hibmc_dp_detect(struct drm_connector *connector,
>  			   struct drm_modeset_acquire_ctx *ctx, bool force)
>  {
> -	mdelay(200);
> +	struct hibmc_dp *dp = to_hibmc_dp(connector);
>  
> -	return drm_connector_helper_detect_from_ddc(connector, ctx, force);
> +	if (dp->hpd_status)
> +		return connector_status_connected;
> +	else
> +		return connector_status_disconnected;
>  }
>  
>  static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
> @@ -115,21 +118,23 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
>  {
>  	struct drm_device *dev = (struct drm_device *)arg;
>  	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
> +	struct hibmc_dp *dp = &priv->dp;
>  	int idx;
>  
>  	if (!drm_dev_enter(dev, &idx))
>  		return -ENODEV;
>  
> -	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {
> +	if (((dp->irq_status & DP_MASKED_SINK_HPD_PLUG_INT) && !dp->hpd_status)) {
>  		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
> -		hibmc_dp_hpd_cfg(&priv->dp);
> +		hibmc_dp_hpd_cfg(dp);
> +		dp->hpd_status = 1;
>  	} else {
>  		drm_dbg_dp(&priv->dev, "HPD OUT isr occur!\n");
> -		hibmc_dp_reset_link(&priv->dp);
> +		hibmc_dp_reset_link(dp);
> +		dp->hpd_status = 0;
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

