Return-Path: <linux-kernel+bounces-746797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23C5B12B4F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 18:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB3F1691D9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A30246768;
	Sat, 26 Jul 2025 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F+LExV5j"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AE91DF75B
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753545812; cv=none; b=WLFOVEaF12ApwEYUEq3IqIf8/qYZW5hnUvaCbL8J97/irxsM6x43ugnYLv9hVGRCAGzK+6eCa2n1JYDs2h8JaJhFquD70FJD/PZhdHsD9R4RdAe9JXps8QBXu066o7z9D0WDyjUhho3pwxZTTwETcUPFsC4pk7PevUzTeuq3Q3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753545812; c=relaxed/simple;
	bh=K7PI0VLob2TMw3JitF7cOuVwXqjL4avFTvGrPSc5m3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbER9JhMUy41B0NWAVb+zp2URXb5AIqHAasWxYSGW88FlpwyEc1D0Sz5Q7WpOzrAagkv/6nzjIeiJ4MeJE2N8VEElOBpGRCMthf4l6dl5wAEMUmvuZs1R9Sp64bJ/sCzPY6J4dwVrjFlXFD5juylrGotcX0lyUUNFwXWcEajZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F+LExV5j; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56QCblIj014749
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=F8YYMH9gFarS0Tc24iZ48d4j
	M4eJuDvGBE7Mq7h0k3E=; b=F+LExV5jic8uYinXfX7flw4Vd6D7ptJFKponMqZ0
	Ctya1PsH2QyVo/e7+IcYo5w9YLrz1FPv2HW74nURJhm3xHT05dSnsyqA2fENzSYt
	IirH+EQReM90OfNBtAGoUqNJSKtfam1I0jQlOOkVwIYO3dzQLvInw/Y4MopCN354
	GBVH5zAUN9JjWVSDuXKdS3ggN8EuXtHtdr6vPvtd48E/Oh3eYdBXIB+oVQcjjCLT
	CG0d6o5AlBz2C/RM2Ely0OAYMXY1nwqSqrUW3psYgmQKIiunnhk8L9r1t4Tx96ww
	MBcvAbhhQGuOa9qTU3lCmI2zWUStXXJ08bb1soO/vA8SwA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mqk124v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:03:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7073cc86450so911906d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 09:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753545808; x=1754150608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8YYMH9gFarS0Tc24iZ48d4jM4eJuDvGBE7Mq7h0k3E=;
        b=Xu3Z+Y1GxfcE49570vukUJHn9MmIdGH6/C0uuT3r2aS+tpntbG+1WkdHWbPoqT886h
         pHmei+d0oCde8eLL6Hd+e3pcXojQdRFrXYW3sY0U4b/WVt3+wv6JJ7X7C60maiLDdl7K
         Bzi/BzUPPMK37SQvNrQJKWZYrX0L1ewTohrUjZ1IKrg6sgVjhnen7FZoLy/WvsZkeFoZ
         ir2Chm/VAtS3Nb14HsRcVbIwkId4s93McMb6PgFjLBFyh+duHysSO5sgI0CQkO/Mo3mt
         R2Wxd6iycIlMAAmOnoyqA9HacNoWTx/6/sfCs4OGJT4OvgBmHJ5v+U/QpymAJ/MaE28A
         vK2g==
X-Forwarded-Encrypted: i=1; AJvYcCWepBxcHllEu8QQjM07AWYyccA1QL/0iXSLBn2rFTlvClAhoG+2zzTTD869SAcO+cwVKpMgT0FhNKczSLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVB7FjmGzNWcUG3D8fGvEjw2lp9sScjIUxyON3yU3fk4+Ab6gp
	OnyVbeLIg16Bztbe+5zl4vFBMl0i5k6/O7SSfqyes80qJ5RWE+tK4Q/FCFV7ToVufEJ9QJLwYeA
	H54/rLF7ttgmIIAGwqkZQGBVwBupFJ8GBwQk9fgNkpzqbtNACYkrBledDSrji8Ox1xac=
X-Gm-Gg: ASbGncsqgMavmSlYqZFmlJpbqrm3CAR5jWHlhU5QpuLZkT+88GN3Z+oWGZjfmlIHR44
	JyxTLQ3CbF66CH/bilnl+S8bfSLIR4Q88eONc91XyhxtqLcRW0pAjV8lS74oYNE2xaplAyNixAM
	4TndU2VWhBVseXITw/Q6r1Xrj843Yj+XydwbSMxkOZuk3+EQbCJgFriMTWuPHEpxvzTPEivCCvu
	8Oe8ak9/cnFn2H4XMSLzwrtNi0c+hrR6fC84jWkH6m3I3g4YIcCY9mRWW5CH7Tdju/42ZFvWPSB
	TmSeTQaSKW5/SmuPA6ZNNFLqlXjfeUF4bXUVR4OhVwLNFa9BqRS/837vjfpOYkX2c9Q26SFIrxr
	Gfpv0Ua4b1U7DWFw4HfEF0EOVzqkKY+aWEq/XUXWm+Dchqtl8Jy50
X-Received: by 2002:ad4:5dec:0:b0:707:151d:3234 with SMTP id 6a1803df08f44-707205a9d4cmr62478086d6.30.1753545808042;
        Sat, 26 Jul 2025 09:03:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhdNdjiKsH+hA/24bP2oys9SXNS9W2drat5pIegemSx766wz2FYOAMVdk+G01+gfGwX7scUA==
X-Received: by 2002:ad4:5dec:0:b0:707:151d:3234 with SMTP id 6a1803df08f44-707205a9d4cmr62477386d6.30.1753545807317;
        Sat, 26 Jul 2025 09:03:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b6316d936sm502145e87.37.2025.07.26.09.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 09:03:25 -0700 (PDT)
Date: Sat, 26 Jul 2025 19:03:23 +0300
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
Subject: Re: [PATCH v3 drm-dp 08/11] drm/hisilicon/hibmc: fix no showing when
 no connectors connected
Message-ID: <tqbbkhod5et6yxyfhzmgelborrhwjaazk6ylkw3srlqmmkp6ou@jefvdyktsuds>
References: <20250718065125.2892404-1-shiyongbang@huawei.com>
 <20250718065125.2892404-9-shiyongbang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718065125.2892404-9-shiyongbang@huawei.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDE0MCBTYWx0ZWRfX+BDaqWOvCAHI
 VcvT8+24ih/o4B1DgC31Nbp4VCX/wy61B3NURDrr/qLXx6QEGKQxWv2Bqsl1r2oAWslLEpGOBQK
 oOG8LySj0tBa2GXkcyCWd1nhC1zY1TZUe3jJDqjaJSSf/v91O7pD7KgjSBRbZavjB5zpq+6XQUz
 /nobfmeY4JBjEPiiDozomXCbBCG/UWQeeh+bltPSVs7fcku3sye5pSfFeUAsSiWse/WKz0W+dCX
 jc2SSI8qM0b1cwcZuOmFS073d0yNt/WE29AD0+8Z70UFFX6BFi5mWRBdqQgHUh/yy4CuHOQCqei
 CEsajnYAKrPcsFfp+HMto4e9QQDSiIq8zDPSCZ5A764HPV9AXwtgxD2Xv59/XIbwWma2upcfYwi
 K6sOASJ6B8nK3v4nzURmoNoy69taBW323qokgpOOKw6q1n00VpEK8KcboXgPIp3bj3uxjq8E
X-Authority-Analysis: v=2.4 cv=fqPcZE4f c=1 sm=1 tr=0 ts=6884fc51 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=i0EeH86SAAAA:8 a=nBfjFdyouy9m0_FljzMA:9 a=CjuIK1q_8ugA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: xl8_BRf2digoXBVzLfJF5JbyC9M8rndI
X-Proofpoint-ORIG-GUID: xl8_BRf2digoXBVzLfJF5JbyC9M8rndI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 impostorscore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507260140

On Fri, Jul 18, 2025 at 02:51:22PM +0800, Yongbang Shi wrote:
> From: Baihan Li <libaihan@huawei.com>
> 
> Our chip support KVM over IP feature, so hibmc diiver need to support

I assume that KVM-over-IP doesnt provide EDID reads. This needs to be
stated in the commit message.

> displaying without any connectors plugged in. If no connectors connected,
> set the vdac connector status to 'connected' to handle BMC KVM. Use
> is_connected to check all physical outputs.
> For get_modes: using BMC modes for connector if no display is attached to
> phys VGA cable, otherwise use EDID modes by drm_connector_helper_get_modes.
> 
> Fixes: 4c962bc929f1 ("drm/hisilicon/hibmc: Add vga connector detect functions")
> Signed-off-by: Baihan Li <libaihan@huawei.com>
> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> ---
> ChangeLog:
> v2 -> v3:
>   - fix hibmc_connector_get_modes() and hibmc_vdac_detect() to realize BMC KVM, suggested by Dmitry Baryshkov.
> ---
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    |  5 +-
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  4 ++
>  .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 55 +++++++++++++------
>  3 files changed, 45 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> index 99b30a6c7e06..262ebe6138f0 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> @@ -58,9 +58,12 @@ static int hibmc_dp_detect(struct drm_connector *connector,
>  {
>  	struct hibmc_drm_private *priv = to_hibmc_drm_private(connector->dev);
>  
> -	if (!hibmc_dp_detect_link(&priv->dp))
> +	if (!hibmc_dp_detect_link(&priv->dp)) {
> +		priv->is_connected |= BIT(0);

Magic value BIT(0)

>  		return connector_status_connected;
> +	}
>  
> +	priv->is_connected &= ~BIT(0);
>  	return connector_status_disconnected;
>  }
>  
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> index ca8502e2760c..d68588ecec9b 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
> @@ -31,6 +31,7 @@ struct hibmc_vdac {
>  	struct drm_connector connector;
>  	struct i2c_adapter adapter;
>  	struct i2c_algo_bit_data bit_data;
> +	int phys_status;
>  };
>  
>  struct hibmc_drm_private {
> @@ -43,6 +44,9 @@ struct hibmc_drm_private {
>  	struct drm_crtc crtc;
>  	struct hibmc_vdac vdac;
>  	struct hibmc_dp dp;
> +
> +	/* VGA and DP phys connect status, BIT(0) is DP, BIT(1) is VGA */

#define those.

> +	int is_connected;

And you need a lock around this one, otherwise you might get a race
between DP's and VGA's code setting and clearing bits here.

>  };
>  
>  static inline struct hibmc_vdac *to_hibmc_vdac(struct drm_connector *connector)
> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> index 841e81f47b68..3cdf640d1785 100644
> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
> @@ -25,27 +25,18 @@
>  static int hibmc_connector_get_modes(struct drm_connector *connector)
>  {
>  	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
> -	const struct drm_edid *drm_edid;
>  	int count;
>  
> -	drm_edid = drm_edid_read_ddc(connector, &vdac->adapter);
> -
> -	drm_edid_connector_update(connector, drm_edid);
> -
> -	if (drm_edid) {
> -		count = drm_edid_connector_add_modes(connector);
> -		if (count)
> -			goto out;
> +	if (vdac->phys_status == connector_status_connected) {
> +		count = drm_connector_helper_get_modes(connector);
> +	} else {
> +		drm_edid_connector_update(connector, NULL);
> +		count = drm_add_modes_noedid(connector,
> +					     connector->dev->mode_config.max_width,
> +					     connector->dev->mode_config.max_height);
> +		drm_set_preferred_mode(connector, 1024, 768); // 1024x768
>  	}
>  
> -	count = drm_add_modes_noedid(connector,
> -				     connector->dev->mode_config.max_width,
> -				     connector->dev->mode_config.max_height);
> -	drm_set_preferred_mode(connector, 1024, 768);
> -
> -out:
> -	drm_edid_free(drm_edid);
> -
>  	return count;
>  }
>  
> @@ -57,10 +48,38 @@ static void hibmc_connector_destroy(struct drm_connector *connector)
>  	drm_connector_cleanup(connector);
>  }
>  
> +static int hibmc_vdac_detect(struct drm_connector *connector,
> +			     struct drm_modeset_acquire_ctx *ctx,
> +			     bool force)
> +{
> +	struct hibmc_drm_private *priv = to_hibmc_drm_private(connector->dev);
> +	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
> +	enum drm_connector_status status;
> +
> +	status = drm_connector_helper_detect_from_ddc(connector, ctx, force);
> +
> +	vdac->phys_status = status;
> +
> +	if (status == connector_status_connected) {
> +		priv->is_connected |= BIT(1);
> +		return connector_status_connected;
> +	}
> +
> +	priv->is_connected &= ~BIT(1);
> +
> +	/* if all connectors are disconnected,
> +	 * return connected to support BMC KVM display.
> +	 */
> +	if (!priv->is_connected)
> +		return connector_status_connected;
> +
> +	return connector_status_disconnected;
> +}
> +
>  static const struct drm_connector_helper_funcs
>  	hibmc_connector_helper_funcs = {
>  	.get_modes = hibmc_connector_get_modes,
> -	.detect_ctx = drm_connector_helper_detect_from_ddc,
> +	.detect_ctx = hibmc_vdac_detect,
>  };
>  
>  static const struct drm_connector_funcs hibmc_connector_funcs = {
> -- 
> 2.33.0
> 

-- 
With best wishes
Dmitry

