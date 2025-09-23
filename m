Return-Path: <linux-kernel+bounces-828169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E2B94193
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59732481DA6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA8A25785B;
	Tue, 23 Sep 2025 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CM+odUjY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473AA2512EE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758597768; cv=none; b=cpJ6hCEjtprpArKpD3sONwtwZijxHFumcD85hbLF0edDOsRJuKWGnU40DcqhCzq9xAmrsZOYd2eQ1P+loDVhLv4ENgmczrV+kkNLzoMjnc6WMVqwh/X+ZMHXEkXT8Uh13WdMHtLBkzwAgRqiOe0W7lmS77332YT6yFx/EYgbduQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758597768; c=relaxed/simple;
	bh=bUJcxQih4KiH7TxBpUbWKHnOijLpBfmdbFJuespwDCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+iAIfnOCgF0ODhD6d1aWTdJCcP7/JYmF3oje6lYNQSkM14fs8eU4AxU12zF6M4rJbBI1P8+l9Fjb8YYT8fBIqnxaIZYTUJ2wQE+tBx3Joc9zethPP8XdxCe9RuOxkxulPiQKLfPEsG3LN+9kQzc1u5ylCFdCM+enbL3Q923vMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CM+odUjY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MH5uRf011598
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4BaStgRA9naaMpcfCvi59hb/GSqirNOjqp8oFnDbiF0=; b=CM+odUjYk9HSIgd5
	DJaukv6vyEehW1eky22WBy+ltxZyyNXvmQrOGf2yB5dGEh0em48l38wcSuaUpHBm
	qC+AyIYJIviechqUhVRhcZwuZlr8gEdI5ApWMMsWUO4AjzSujVzVAP/SH0CRUOGR
	yV4Xd+AqSj0v+bOeAZph5LRLJ6oYz3ASjPXlgSbMIfKVWgpN3rDwva0YIqOHq4L1
	rPHMbHnzR2Uf6U47R9jSC2xav5GZ3MwQhvlKsRNIWyD+3+6PI+QkSCoEUQbyKrHQ
	VCsxFHeBIlzWN4PmlBtp/x4IezHd2YFNY8PPFQLMCtEeJBLza78JdvXi++splWxw
	Dp2SiQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kkhq275-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 03:22:45 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78f2b1bacfcso83121176d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758597765; x=1759202565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4BaStgRA9naaMpcfCvi59hb/GSqirNOjqp8oFnDbiF0=;
        b=J9xqH9Fr8YJUBx7sJKYQlqN6wgFAbrU+iLRAImmy3g/EzrRY+wo230hZwIu+mbG3jI
         LuyKE/2mCOqKOA8CDsYf1y91LUfbhh8ae7FLXhER5hRaxzMXcEsOn+k6aG6XyQLJDE8f
         0GMYcNBpjtprguWHOq3QvDnOvrsWd5tWf3UuU6v4LP9qo+1T9h+xZMeSON6aSsWOZOIS
         QGbEeJRbR+PRwhsc8DEBz8CWXDFI1QAIttq43HfUkklDdqI+idEAHiJLg/eaLSVYhxhN
         Xird1dQSD2xm6sB9RDu7CXD68L9KA9sJPVnig2bpRwWwPTUbbxmJMV7kgHtHjLedqJm2
         OaIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1vuMK9vn2Jooy2MbGUUObdDk2TeOl8sPMi2zqw+q1093rQfgDrhh0u9PpjZKzcdYJAbY/Z0BzF7lKCw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj6YzSirFZ20pSCK89Xa6wnY8EhYLUFHok6NsV+WEVwgliFSdJ
	HWRglyvAZ+VQhGJY+mh0BDcvTX+eEZYmZQhZohxaTzqQR270zy2YhDYZl0nnD+gGAg/1+dVte0t
	kfxvT6ySx71Zz7KkcQE1CrUJ3ddAojdH9sHDBZQH+hcBDjqB1TtIZZZQthnR/tug5Po0=
X-Gm-Gg: ASbGncskCG3e5t/Fos7/N+9bYm8wm82G22tZbgYn/oIwJpG7bm3SNjwLpuwwrZaETP3
	jQuUBEIZ4HEk8ubdl0Xnsq988/3U7gNwwwyeD6tSLlrsV0jRc3HwwdrjNMF5WXVRnR/fnLwydkE
	ncaxaWIkZYnSe28RWrz8/jicK1BQNEQV49lERZLIK34Ie6sYK6pA1/d/jC37BNHZOVa01fUvslR
	ZJbVX+vJloG5zzxmV6U8rcaAEECM4ZQWmFqLHChmO69J7hNyTsL7xyzx+b2PuCLWR6wknWEaswG
	CAQJ8RCg09uzoXOTFemMTtpNPC4OeWkRx+nRsDU7tq7iaHZtFWYmC43XTsU/TyeJt3/xrR0tR09
	DTN7setku69nn2Sx1/7UCzR19xcKwOz9smc2KJubXR9cBydSzLfbH
X-Received: by 2002:a05:6214:d61:b0:7dd:16b:2a01 with SMTP id 6a1803df08f44-7e71687bca6mr12820626d6.46.1758597764914;
        Mon, 22 Sep 2025 20:22:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFve1xcjR3BgNxDtbA5JUCymBJBIBi80BRmHw8alfsOEhoUAytyNfVHKakjYTFor0qoU5hHgA==
X-Received: by 2002:a05:6214:d61:b0:7dd:16b:2a01 with SMTP id 6a1803df08f44-7e71687bca6mr12820436d6.46.1758597764303;
        Mon, 22 Sep 2025 20:22:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36be170a88esm8033581fa.70.2025.09.22.20.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 20:22:42 -0700 (PDT)
Date: Tue, 23 Sep 2025 06:22:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongbang Shi <shiyongbang@huawei.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        kong.kongxinwei@hisilicon.com, liangjian010@huawei.com,
        chenjianmin@huawei.com, fengsheng5@huawei.com, libaihan@huawei.com,
        shenjian15@huawei.com, shaojijie@huawei.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 drm-dp 1/4] drm/hisilicon/hibmc: fix dp
 probabilistical detect errors after HPD irq
Message-ID: <xlqffumhurbzcj6sfuu3tr6fafpxb4akwskvd45kqx2h4mprux@armcruouadfx>
References: <20250922024943.311947-1-shiyongbang@huawei.com>
 <20250922024943.311947-2-shiyongbang@huawei.com>
 <4vtis3tmlxhmxjmzhi4jdfriexidtr5u2jdcpmfegyyc5gkznu@mpzganc4k5gp>
 <5e9aad79-fef1-4258-83c4-6938ceafbaa5@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e9aad79-fef1-4258-83c4-6938ceafbaa5@huawei.com>
X-Proofpoint-ORIG-GUID: wWat4PQkuzml52r0T-wJ36t-6FDZOKIG
X-Proofpoint-GUID: wWat4PQkuzml52r0T-wJ36t-6FDZOKIG
X-Authority-Analysis: v=2.4 cv=JMo7s9Kb c=1 sm=1 tr=0 ts=68d21286 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=_EjEUeHQWHsufru9t1QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMiBTYWx0ZWRfX0YfwJc5UWM3b
 +kaMAsOLM+Tj6t6P5JtLoC04xlnYFB26YEWpufX67ZrVPnx5sA9SgXg9yvn3irfjA/s+YUSQQEg
 MT3JiFTbkGD5/ZxNOz+Utx5pbEHJLzVb6StVsyuBaBBr9AsElvq3ckYdJlzUgO0EaQSvvWAkd/Z
 sPqGDxEpSdEUbXOmfPkuat99PUe/j66tvE5QsUf0WG9nfyHmKchSmURCZiXcl69zbNtbfcB36x+
 L2Zufh95Nxd/erbou3Dc6tloi/nY7OcJqiKd9tIwHSLRB5gmobC6QsvqkRZ8BI+jD7rhQujGfIX
 DwaHxSUvhGnMFu8xEzc7rb3cRKEoENKzFXQRuEL2F8+01W69yoauecHCHApnjeGlthMJ46InTDY
 jEKMB7j6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200022

On Tue, Sep 23, 2025 at 10:57:56AM +0800, Yongbang Shi wrote:
> > On Mon, Sep 22, 2025 at 10:49:40AM +0800, Yongbang Shi wrote:
> > > From: Baihan Li <libaihan@huawei.com>
> > > 
> > > The issue is that drm_connector_helper_detect_from_ddc() returns wrong
> > > status when plugging or unplugging the monitor. Use HPD pin status in
> > > DP's detect_ctx() for real physcal monitor in/out, and keep using
> > > detect_frome_ddc() if it's the first time to call detect because of
> > > insmoding driver.
> > If I understand correct, this is not quite right. Consider DP-to-HDMI or
> > DP-to-DVI dongle being plugged without an actual monitor and then the
> > monitor being plugged later on.
> 
> Hi Dmitry,
> Thanks for your correction. So your point is that if the HPD comes in from a dongle.
> Is that okay to add those checks at the end?
> 
>         ret = drm_dp_read_dpcd_caps(dp_dev->aux, dp_dev->dpcd);
> 	if (ret)
> 		return connector_status_disconnected;
> 
> 	if (!drm_dp_is_branch(dpcd))
> 		return connector_status_connected;
> 
> 	if (drm_dp_read_sink_count_cap(connector, dp_dev->dpcd, &dp_dev->desc) &&
> 	    dp_dev->dpcd[DP_DOWNSTREAM_PORT_0] & DP_DS_PORT_HPD) {
> 		ret = drm_dp_read_sink_count(dp_dev->dpcd);
> 		if (ret > 0)
> 			return connector_status_connected;
> 	}

Yes

> 
> Thanks，
> Baihan
> 
> 
> > > Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
> > > Signed-off-by: Baihan Li <libaihan@huawei.com>
> > > Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> > > ---
> > > ChangeLog:
> > > v5 -> v6:
> > >    - use HPD status in DP detect_ctx(), suggested by Dmitry Baryshkov.
> > > v4 -> v5:
> > >    - fix the commit message and DP detect_ctx(), suggested by Dmitry Baryshkov.
> > > ---
> > >   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c     | 12 ++++++++++++
> > >   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h     |  7 +++++++
> > >   drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h    |  3 +++
> > >   drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c | 13 +++++++++++--
> > >   4 files changed, 33 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> > > index 8f0daec7d174..4d8d3e4d4f84 100644
> > > --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> > > +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.c
> > > @@ -2,6 +2,7 @@
> > >   // Copyright (c) 2024 Hisilicon Limited.
> > >   #include <linux/io.h>
> > > +#include <linux/iopoll.h>
> > >   #include <linux/delay.h>
> > >   #include "dp_config.h"
> > >   #include "dp_comm.h"
> > > @@ -305,3 +306,14 @@ void hibmc_dp_set_cbar(struct hibmc_dp *dp, const struct hibmc_dp_cbar_cfg *cfg)
> > >   	hibmc_dp_reg_write_field(dp_dev, HIBMC_DP_COLOR_BAR_CTRL, BIT(0), cfg->enable);
> > >   	writel(HIBMC_DP_SYNC_EN_MASK, dp_dev->base + HIBMC_DP_TIMING_SYNC_CTRL);
> > >   }
> > > +
> > > +void hibmc_dp_update_hpd_status(struct hibmc_dp *dp)
> > > +{
> > > +	int status;
> > > +
> > > +	readl_poll_timeout(dp->dp_dev->base + HIBMC_DP_HPD_STATUS, status,
> > > +			   FIELD_GET(HIBMC_DP_HPD_CUR_STATE, status) != dp->hpd_status,
> > > +			   1000, 100000); /* DP spec says 100ms */
> > > +
> > > +	dp->hpd_status = FIELD_GET(HIBMC_DP_HPD_CUR_STATE, status);
> > > +}
> > > diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> > > index 665f5b166dfb..8348ad9e34a8 100644
> > > --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> > > +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> > > @@ -14,6 +14,11 @@
> > >   struct hibmc_dp_dev;
> > > +enum hibmc_hpd_status {
> > > +	HIBMC_HPD_OUT,
> > > +	HIBMC_HPD_IN,
> > > +};
> > > +
> > >   enum hibmc_dp_cbar_pattern {
> > >   	CBAR_COLOR_BAR,
> > >   	CBAR_WHITE,
> > > @@ -50,6 +55,7 @@ struct hibmc_dp {
> > >   	struct drm_dp_aux aux;
> > >   	struct hibmc_dp_cbar_cfg cfg;
> > >   	u32 irq_status;
> > > +	int hpd_status;
> > >   };
> > >   int hibmc_dp_hw_init(struct hibmc_dp *dp);
> > > @@ -60,5 +66,6 @@ void hibmc_dp_reset_link(struct hibmc_dp *dp);
> > >   void hibmc_dp_hpd_cfg(struct hibmc_dp *dp);
> > >   void hibmc_dp_enable_int(struct hibmc_dp *dp);
> > >   void hibmc_dp_disable_int(struct hibmc_dp *dp);
> > > +void hibmc_dp_update_hpd_status(struct hibmc_dp *dp);
> > >   #endif
> > > diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> > > index 394b1e933c3a..64306abcd986 100644
> > > --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> > > +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_reg.h
> > > @@ -24,6 +24,9 @@
> > >   #define HIBMC_DP_CFG_AUX_READY_DATA_BYTE	GENMASK(16, 12)
> > >   #define HIBMC_DP_CFG_AUX			GENMASK(24, 17)
> > > +#define HIBMC_DP_HPD_STATUS			0x98
> > > +#define HIBMC_DP_HPD_CUR_STATE		GENMASK(7, 4)
> > > +
> > >   #define HIBMC_DP_PHYIF_CTRL0			0xa0
> > >   #define HIBMC_DP_CFG_SCRAMBLE_EN		BIT(0)
> > >   #define HIBMC_DP_CFG_PAT_SEL			GENMASK(7, 4)
> > > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> > > index d06832e62e96..48c9c97eef0e 100644
> > > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> > > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> > > @@ -34,9 +34,16 @@ static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
> > >   static int hibmc_dp_detect(struct drm_connector *connector,
> > >   			   struct drm_modeset_acquire_ctx *ctx, bool force)
> > >   {
> > > -	mdelay(200);
> > > +	struct hibmc_dp *dp = to_hibmc_dp(connector);
> > > +
> > > +	/* if no HPD just probe DDC */
> > > +	if (!dp->irq_status)
> > > +		return drm_connector_helper_detect_from_ddc(connector, ctx, force);
> > > -	return drm_connector_helper_detect_from_ddc(connector, ctx, force);
> > > +	if (dp->hpd_status == HIBMC_HPD_IN)
> > > +		return connector_status_connected;
> > > +
> > > +	return connector_status_disconnected;
> > >   }
> > >   static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
> > > @@ -128,6 +135,8 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
> > >   		hibmc_dp_reset_link(&priv->dp);
> > >   	}
> > > +	hibmc_dp_update_hpd_status(&priv->dp);
> > > +
> > >   	if (dev->registered)
> > >   		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
> > > -- 
> > > 2.33.0
> > > 

-- 
With best wishes
Dmitry

