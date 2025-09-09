Return-Path: <linux-kernel+bounces-808379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D4CB4FF02
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0C81BC70BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DFD31CA55;
	Tue,  9 Sep 2025 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SiQ2qPn3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D9B18FC97
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757427165; cv=none; b=fv2P/7TzBkJQetU46Q2U7gvbtGci/c+pSFKC8CoGiPXzzd7iRO18EZYh1A8CKyaWJH8Gvgu1lX28fJbYsEyJc/SjLWM2qkEN3l4uQUqn1tuQy9YA9/XvwDHqPBWoOHcF9Yv47X+69ISQSES7xhCXKeW6Exk1/ha5Y61Zr23u2T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757427165; c=relaxed/simple;
	bh=eC4ED16E9LjwtX0Gaww1vk+tsrmLbJiujnbiUc7kgko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNqEUa19FyWK/gOgSXbDBlcAWgQMghA8znB8Juq/WDwdufzlcKmqY9msnqOJMtL2b9Jlr46PyHP5pVi1DVffvsNVy9xSfwnpTyQc2Qsd20Qrnh7fqgffYP5BB9ZpRcVT3koqrIEmrLynTrUtcmzGO8dgl+89diJwD2Yy6WSz6tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SiQ2qPn3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899LfuB004293
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 14:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=67PS0C/481rnQLhmSPkrAKjs
	X8cDPvO1jPvWWiHZRdE=; b=SiQ2qPn3xpcyCKMRQjLt407Mz/pj9qBF6qQge3Br
	8XRqdxRn41CBcD8MdreHPjz8gVIyseehYhkx8/vkrbs5XkWR1mF/BByDTxDlgO5q
	0WBKUKIDLyPraiRlHXp7d37syNw5p52NPRnTlbIx7ylD4KRdk42I8VQViKZXEYzz
	vULsrP/IO13nqmtbMuW6BlFij/eOU6ZHwWscbkRlTV1IYvCo0LrZ4Kv/iAqiLQJK
	tooochJSNdwBf4XXbMnIQkkcyV3lt/ospOrg0l0v5onrlIqU6XfQsZbmolAtQM4u
	5VWdRxWDM1ri6XQuI/CvQrUGRB4B5Xv0GnGFLNxEktujhA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapgrvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:12:42 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7222232859fso111458876d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 07:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757427162; x=1758031962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67PS0C/481rnQLhmSPkrAKjsX8cDPvO1jPvWWiHZRdE=;
        b=HjoYXcgZG3N2bllPYysAtZi29cfrGCVFrBnr88mtKPhqSB9yq9fcu90YL7tx4KYMYu
         eczW0yfZyR8MuqRRnOuh3eWooi8TNI35Bm168dQ83GD70WJcFC2SVLZWBTRRDb1hp4cD
         kc9dtLBXxxdacEBau1nGTTC+WMQWoKqxRkPjgq2c1FoLq3zT/GkMiqnGJtH2bnL4tnn+
         +0GTXNc1xtWlZvOl49meulkAJE02+7jh5iLPuJCj4PJ8JsVtvdjAKqFM8Bqxx9g7CoUz
         rOYqLv8pqmsPyvElQNjU0s/NafEe+9mQ8xPSRSvmk3ILupRSoyRcOh2tYfM7COFT2CkR
         laHA==
X-Forwarded-Encrypted: i=1; AJvYcCUioWUpNakNkzrOWLlcUGbEyoZGa2Dh/KomDutxU+RNqRfDOo2skT8jLsHoEVoW3mp7Zja39lzdG+/+lyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym9s+3Ttf75lmo3dc6kF4bYEgqxz8mkej8yLiRmgxE41XMolsy
	p677eK2K2mtT9QEVzC27rsl4iwp81yGiaeqGkjYX5UHTWbWosAw9adxFf6uVYU5w6ep7TkWP903
	OfUa/HM5c0CgVyTA7ENsFBndDAA10vejSBkQITzqIkIMgnjmFp2wrDFVPGpJ0ZuNoQzE=
X-Gm-Gg: ASbGnctytO2kG2L8G+pIDA3y9WsPKowUM31zbTB7xWYKlESXLuQEqpdxtus0rlBab0k
	vEOjZjY74n+hD4LzN90lRlu9Ebfxpb+GkNVyQr08q5hjv7vEJmqG+gObyAS4Ws8iy5V9fXNbdzo
	NSaszRsY4yeA/p25Nm8EVg96QPVwQ1GX5kaC9dymYx5kg2gECET65WWEnrBt3V2/ESvTI333Q6K
	EtFRL/DFNJJNIfzbq+LTyOq2i7J1KitYAkvQ6vlnfYxnFX5aaSUtGcpa65EmWAcBzUlIo4S9/tm
	QoIkyURam0TPVKmb94orAjEOFis6QEPzf0zw/lGCj2ybuc9wwK8QUPmHsZ2K5PuVvIEfWMjkxkQ
	TWQQ5r254eYlmcB9cGl75yCZC6Jf754vGI+TAhx66pxkA6MD2EYFT
X-Received: by 2002:a05:6214:ca5:b0:718:2aac:b388 with SMTP id 6a1803df08f44-739253e0931mr142412466d6.30.1757427161665;
        Tue, 09 Sep 2025 07:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDYTtResNcfpvS0agVEJ7wEB7/FBA6ybJ9ZTMvc6tLI/gx3MP1Fzs6W1ifgn0SJOVGWX+61g==
X-Received: by 2002:a05:6214:ca5:b0:718:2aac:b388 with SMTP id 6a1803df08f44-739253e0931mr142411406d6.30.1757427160689;
        Tue, 09 Sep 2025 07:12:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3380653144asm33874861fa.27.2025.09.09.07.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 07:12:39 -0700 (PDT)
Date: Tue, 9 Sep 2025 17:12:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Harikrishna Shenoy <h-shenoy@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org,
        andy.yan@rock-chips.com, mordan@ispras.ru, linux@treblig.org,
        viro@zeniv.linux.org.uk, aradhya.bhatia@linux.dev, javierm@redhat.com,
        tomi.valkeinen@ideasonboard.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devarsht@ti.com, u-kumar1@ti.com,
        s-jain1@ti.com, lyude@redhat.com, luca.ceresoli@bootlin.com
Subject: Re: [PATCH v6 2/6] drm/bridge: cadence: cdns-mhdp8546*: Change
 drm_connector from structure to pointer
Message-ID: <r4l4dayuhfdqbj3txtyvuffuffe2kxefbeq32pqu226ttwik46@wy23kgtqvfvx>
References: <20250909090824.1655537-1-h-shenoy@ti.com>
 <20250909090824.1655537-3-h-shenoy@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909090824.1655537-3-h-shenoy@ti.com>
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c035da cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=sozttTNsAAAA:8 a=2Lv77nt56LAVqU4y0Q0A:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: svQBdlkiulso-475aZ8IypjFEXCmcsZ8
X-Proofpoint-ORIG-GUID: svQBdlkiulso-475aZ8IypjFEXCmcsZ8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX2OcDkqNe8GLI
 xHYEeDOv6KmlVHvxBvpuKo34xPafThkQraIAsZvvM2abn5fniE2qNnET8lmqqmaiFTh5nJ7vd86
 AygzEJmrMcjjOk0guQ6yd8Gk6HtJp2tS72Si2UhCFuMxN0MJ+cvEkNoQ97BCc4xQlhnSCDxiak7
 t3Im2aatFi/upgWBbLR5E1jSPFeH5iHG5GmwdW44ldQ9lQoMkO6GBSO5qhpVwt3xNuGJ0D4Ng9/
 cGTqwR3D8aVerTueiyEGXT+OGvIyxkrNOSM9pFpfV7ZxQ2yXFisioQaZzCym4mMnNiW1+Cj3Yxd
 IJDc3PzVi0Lgr21LWMXOmNEhSmmA3uoXFqR2NRNIWOo362q7gXizY80cmAHCESBeStJhOm8aTjh
 iLB5bhXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

On Tue, Sep 09, 2025 at 02:38:20PM +0530, Harikrishna Shenoy wrote:
> From: Jayesh Choudhary <j-choudhary@ti.com>
> 
> After adding DBANC framework, mhdp->connector is not initialised during
> bridge_attach(). The connector is however required in few driver calls
> like cdns_mhdp_hdcp_enable() and cdns_mhdp_modeset_retry_fn().
> Use drm_connector pointer instead of structure, set it in bridge_enable()
> and clear it in bridge_disable(), and make appropriate changes.
> 
> Fixes: c932ced6b585 ("drm/tidss: Update encoder/bridge chain connect model")

Same question. If HDCP was broken, then this should be fixing
6a3608eae6d3 ("drm: bridge: cdns-mhdp8546: Enable HDCP") instead.

> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 12 ++++++------
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h |  2 +-
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c |  8 ++++----
>  3 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> index bad2fc0c7306..b297db53ba28 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
> @@ -375,7 +375,7 @@ struct cdns_mhdp_device {
>  	 */
>  	struct mutex link_mutex;
>  
> -	struct drm_connector connector;
> +	struct drm_connector *connector;
>  	struct drm_bridge bridge;
>  
>  	struct cdns_mhdp_link link;
> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
> index 42248f179b69..59f18c3281ef 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
> @@ -394,7 +394,7 @@ static int _cdns_mhdp_hdcp_disable(struct cdns_mhdp_device *mhdp)
>  	int ret;
>  
>  	dev_dbg(mhdp->dev, "[%s:%d] HDCP is being disabled...\n",
> -		mhdp->connector.name, mhdp->connector.base.id);
> +		mhdp->connector->name, mhdp->connector->base.id);
>  
>  	ret = cdns_mhdp_hdcp_set_config(mhdp, 0, false);
>  
> @@ -445,7 +445,7 @@ static int cdns_mhdp_hdcp_check_link(struct cdns_mhdp_device *mhdp)
>  
>  	dev_err(mhdp->dev,
>  		"[%s:%d] HDCP link failed, retrying authentication\n",
> -		mhdp->connector.name, mhdp->connector.base.id);
> +		mhdp->connector->name, mhdp->connector->base.id);
>  
>  	ret = _cdns_mhdp_hdcp_disable(mhdp);
>  	if (ret) {
> @@ -487,13 +487,13 @@ static void cdns_mhdp_hdcp_prop_work(struct work_struct *work)
>  	struct cdns_mhdp_device *mhdp = container_of(hdcp,
>  						     struct cdns_mhdp_device,
>  						     hdcp);
> -	struct drm_device *dev = mhdp->connector.dev;
> +	struct drm_device *dev = mhdp->connector->dev;
>  	struct drm_connector_state *state;
>  
>  	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
>  	mutex_lock(&mhdp->hdcp.mutex);
>  	if (mhdp->hdcp.value != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> -		state = mhdp->connector.state;
> +		state = mhdp->connector->state;
>  		state->content_protection = mhdp->hdcp.value;
>  	}
>  	mutex_unlock(&mhdp->hdcp.mutex);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

