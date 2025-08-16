Return-Path: <linux-kernel+bounces-772287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FA4B290DF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 00:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F7C61C200A3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 22:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BB61FF1C7;
	Sat, 16 Aug 2025 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K2xgxipe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA11946DA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 22:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755383575; cv=none; b=MyPLkP7Zgmm0OjY4j+Q3BbmE9nbqmwJag0T6TdRWxv3zTedWvGggSGlg6wTAi667a5xqLhDvL44GGJbyY1Sn7heZgp8DDPx8KXA0h4djyJ1Qa6eFN1BBzd8geOed2q+G5mB36yPyP6i2rCmtBBGAgqB7ykvzMFBqWCGXSHMbkCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755383575; c=relaxed/simple;
	bh=sd4+RrMKGwHtU4lC05PDtAxWhVK4w7S7+3xoOOcbgK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIsvggJUJKuCjzcqpiBuaLKJ9NS20HYiO4aDbRDkr6AY8TyJETLeyaS2qRxGE5J0lWCn6nqPQuCcK0rJFikxykMKVUcpLOs+c62dAyu4yX3Hoq7LPpo1uMa4jyByQb5aH8srhWohGS5ZnZvG7DBJwK0pS0DYFoh8FJYX+X31BSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K2xgxipe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57GMU2ka021064
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 22:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=C3ba6mWe6/FITpK9HqJUybgJ
	tGlTyVzJ+GPY6KnnnOg=; b=K2xgxipeF7JII+uGV1QSfm13T/qIw7zyf4APPddD
	dDn7d475rqJ3MD17dq23TDIk8YKQjhnYq7Ny2qb7VQnh4gTHrzxDR0FusLWVhK8r
	r3WT7gAnNZUyhUgRL++smU3T4jFbo3bsGX1Trr7MRfGaORz4urX6jzrRCtMQIwI2
	Xh80IunpdcYfNIu5U/hPi07SFrL1/h4dla+A7owB9zc1oxr1ZOkkjmcX9lDV7+pf
	RnYIuzeUGReRaXqAmZOhjx1jEKyPPimCbPVvHFHfyghY9+pkSAEYXydgLqTia+Lp
	Z4M9gd9MmGdSm4p4dh0iaRC/WP17WPmKeK4DnqNkYw2qHw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jjrfs7r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 22:32:51 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70a88d99c1cso67573506d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755383570; x=1755988370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3ba6mWe6/FITpK9HqJUybgJtGlTyVzJ+GPY6KnnnOg=;
        b=TMpFXR3bHJ6Pgre2z5qHFhkC6KWjgZ8A/rWNbNW4u/Z3gq7NkgC/IjEIq4FNA2FC84
         zCbNRb3Etso7ubyqFIGbfI/5Ii37p+1gjz193Cce2TEtFx+7a0qSU1IciGZH4ihmoJin
         lODFE3ir0J0i41WNNpWnjmubAauc4zGKDYECoyU/B/WbjzzUxPn7u+trq6VqkYVfJ3uh
         pOtN3nDsjE8Woqb2MvImJGW20zswf7g2qrBTIl8BWKNfexmNnsLHxVZoXqg/14X6dwTG
         KH/h7q3PMXDsGBSK5CNsSCln9tLolg4htXxxFG4cIEjIOCQbfrM1hg5dpcKL+q8822nc
         flVQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+uE7ImFhU4DxFTBEgZbMp6kzqOouaMkpXzPSu8tenRk3wWw5UmiQCMZNRohm+LpGF+r8mMqfn+jgnTK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoUqn1g1izaJSlDByVJCS8X3WWfzA0oINmkQw05GUG3ePkrShx
	zWEjKGtLATa6GibOG4bDUiJv6WJXty0QFrKExuvWd2BgSshf9nqzYwoTT6RpPSGh4OX+SCctsBT
	6jf/+UXBpDuZHOlxBm+5lJlU3XfxpfqW01OD1ibSyIYGbvHHEatSsPq1mJrkI7iXMZeE=
X-Gm-Gg: ASbGnctm66QJv6A2Pd6mPKjE/wxSTQnsgkqAOOGsYjO8T/cXI9F3CrF/k1Yb/ArAkqQ
	fGNQRSbw87mIiYkCTVZxSegglLO9CBSwjGqxUYaksX5Ahz0FJynXTo5k5cf0eaKWqibEedtJkp1
	BkaFDDQ+ZyTj3J4UiCfPzShFu39vXne/oHd38VF+hn+5huaFiY3opbYX73r1PZr1MU9CZI4dbN+
	6ZUpVWvhtMlDVbLcjqle9OcL0QaOX8HH/hGj/E7N9WcOZCMzBbkoevhzRXuWqH0eaN/qe6/1ocD
	OCqVhE5QgPyiRXJ05LujcGQOXR9uT+HSv9L2/NE0FamSOajMYIhknTgn7FfqTEdmwytCvyPUc3t
	rJs1S2S6x78i+6tSeieCY05AidxKYMc/MxBbaTJULe43d9CD5Xo2p
X-Received: by 2002:a05:6214:27ce:b0:709:76b4:5934 with SMTP id 6a1803df08f44-70ba7cb50cbmr88687306d6.53.1755383570155;
        Sat, 16 Aug 2025 15:32:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKuzN0c/0YYn1p1jAaOU3B+VoPLwa68I5qJyYUXQn+BNmUzka5OX8ZtuZHKOCDSwVrIyp25g==
X-Received: by 2002:a05:6214:27ce:b0:709:76b4:5934 with SMTP id 6a1803df08f44-70ba7cb50cbmr88687006d6.53.1755383569638;
        Sat, 16 Aug 2025 15:32:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef351630sm1030915e87.3.2025.08.16.15.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 15:32:48 -0700 (PDT)
Date: Sun, 17 Aug 2025 01:32:46 +0300
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
Message-ID: <ce47v3y77uc4dunlwyvmfe6j7d7mza4zfrbvu5dz67t66jdlop@vqgv47saj37i>
References: <20250813094238.3722345-1-shiyongbang@huawei.com>
 <20250813094238.3722345-3-shiyongbang@huawei.com>
 <aayi7zjrmru2ancexrqmcutams6ohde3nrkhqacixwp45dsk4v@7ig6hqzahdxf>
 <1dd93bb7-4f67-4b9b-8b6a-d7c5c77cf807@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dd93bb7-4f67-4b9b-8b6a-d7c5c77cf807@huawei.com>
X-Proofpoint-GUID: 7gUZypywDAK8Qzu8TBS-DFozCFzPVrde
X-Authority-Analysis: v=2.4 cv=YrsPR5YX c=1 sm=1 tr=0 ts=68a10713 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=i0EeH86SAAAA:8 a=X2fXuBRfP1M7z_oXNIAA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzOSBTYWx0ZWRfX98hcUru4HXoJ
 pOKy/KEbYtDMdv4bbr9naReIbfShJExMJiuB7raRMqKo45RwvERuJUqmdkRrNOSLDXc55bhsa26
 PxdSLEBdj/FoIowjKyiVsjlHvduU4NSXDrLd7Ny7TBuFonvkElYM2kYGlRbVg+/rs8TH3TKomaG
 gxl6IozgRoX+Eyn5x22JbwWSrfQ7GD6p2b+BpkUejUaQ0bucHEva9WldrTjmt4a83f6GloMEpGD
 ekTFNImw6cWrzy7xexGsdUubgU+Qbvgsjji9pggcqR+lmy5sRzv62evOZvdxRZ0GmxKzLMg6rRD
 1mnzS9EgXnPVYHZgQdybdHSLiDlEZj6aT5dYFqFSxOrCWfBMmElO3O2PkaRqUw1xnYVDV3/C7aV
 J4JldMnv
X-Proofpoint-ORIG-GUID: 7gUZypywDAK8Qzu8TBS-DFozCFzPVrde
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_06,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160039

On Thu, Aug 14, 2025 at 08:19:41PM +0800, Yongbang Shi wrote:
> 
> > On Wed, Aug 13, 2025 at 05:42:29PM +0800, Yongbang Shi wrote:
> > > From: Baihan Li <libaihan@huawei.com>
> > > 
> > > The debouncing when HPD pulled out still remains sometimes, 200ms still can
> > > not ensure helper_detect() is correct. So add a flag to hold the sink
> > > status, and changed detect_ctx() functions by using flag to check status.
> > THis doesn't explain what is wrong with
> > drm_connector_helper_detect_from_ddc(). In the end, this function
> > doesn't use the HPD pin.
> 
> I'm sorry about the misunderstanding.
> The issue is that after plugging or unplugging the monitor, the driver takes no action sometimes
> even though an interrupt is triggered. The root cause is that drm_connector_helper_detect_from_ddc()
> still returns connected status when the monitor is unplugged.
> And I will fix the way in the end.

Can you perform a normal DP detection: read DPCD and check that there is
a DPRX attached and that it's either non-branch device or it has one or
more sinks?

> 
> Thanks,
> Baihan Li!
> 
> 
> > > Fixes: 3c7623fb5bb6 ("drm/hisilicon/hibmc: Enable this hot plug detect of irq feature")
> > > Signed-off-by: Baihan Li <libaihan@huawei.com>
> > > Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
> > > ---
> > > ChangeLog:
> > > v3 -> v4:
> > >    - remove link training process in hibmc_dp_detect(), suggested by Dmitry Baryshkov.
> > >    - remove if (dev->registered), suggested by Dmitry Baryshkov.
> > > ---
> > >   drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h    |  1 +
> > >   .../gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c    | 19 ++++++++++++-------
> > >   2 files changed, 13 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> > > index 665f5b166dfb..68867475508c 100644
> > > --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> > > +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
> > > @@ -50,6 +50,7 @@ struct hibmc_dp {
> > >   	struct drm_dp_aux aux;
> > >   	struct hibmc_dp_cbar_cfg cfg;
> > >   	u32 irq_status;
> > > +	int hpd_status;
> > >   };
> > >   int hibmc_dp_hw_init(struct hibmc_dp *dp);
> > > diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> > > index d06832e62e96..ded38530ecda 100644
> > > --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> > > +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
> > > @@ -34,9 +34,12 @@ static int hibmc_dp_connector_get_modes(struct drm_connector *connector)
> > >   static int hibmc_dp_detect(struct drm_connector *connector,
> > >   			   struct drm_modeset_acquire_ctx *ctx, bool force)
> > >   {
> > > -	mdelay(200);
> > > +	struct hibmc_dp *dp = to_hibmc_dp(connector);
> > > -	return drm_connector_helper_detect_from_ddc(connector, ctx, force);
> > > +	if (dp->hpd_status)
> > > +		return connector_status_connected;
> > > +	else
> > > +		return connector_status_disconnected;
> > >   }
> > >   static const struct drm_connector_helper_funcs hibmc_dp_conn_helper_funcs = {
> > > @@ -115,21 +118,23 @@ irqreturn_t hibmc_dp_hpd_isr(int irq, void *arg)
> > >   {
> > >   	struct drm_device *dev = (struct drm_device *)arg;
> > >   	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
> > > +	struct hibmc_dp *dp = &priv->dp;
> > >   	int idx;
> > >   	if (!drm_dev_enter(dev, &idx))
> > >   		return -ENODEV;
> > > -	if (priv->dp.irq_status & DP_MASKED_SINK_HPD_PLUG_INT) {
> > > +	if (((dp->irq_status & DP_MASKED_SINK_HPD_PLUG_INT) && !dp->hpd_status)) {
> > >   		drm_dbg_dp(&priv->dev, "HPD IN isr occur!\n");
> > > -		hibmc_dp_hpd_cfg(&priv->dp);
> > > +		hibmc_dp_hpd_cfg(dp);
> > > +		dp->hpd_status = 1;
> > >   	} else {
> > >   		drm_dbg_dp(&priv->dev, "HPD OUT isr occur!\n");
> > > -		hibmc_dp_reset_link(&priv->dp);
> > > +		hibmc_dp_reset_link(dp);
> > > +		dp->hpd_status = 0;
> > >   	}
> > > -	if (dev->registered)
> > > -		drm_connector_helper_hpd_irq_event(&priv->dp.connector);
> > > +	drm_connector_helper_hpd_irq_event(&priv->dp.connector);
> > >   	drm_dev_exit(idx);
> > > -- 
> > > 2.33.0
> > > 

-- 
With best wishes
Dmitry

