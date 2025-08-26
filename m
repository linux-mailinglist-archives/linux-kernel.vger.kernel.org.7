Return-Path: <linux-kernel+bounces-787171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A15B3726C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FF324E1D63
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFABF36CDE0;
	Tue, 26 Aug 2025 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZNh+i9om"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875571A76B1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233806; cv=none; b=jDlxBBs15IfcLaflp/8yDyPjbWqN2/My6U6ai28he3+RwiErTchmN5ZkpqN4se51fLH7ayxihr4Zmm6rdFGmUXk9MmDt33i6H7cQKuBm2QJkyzMvlGbd15do81C7V7xPOYrnPsyes0jyeiDWVkpLvoFPE/+cOpYCbwsegpsqX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233806; c=relaxed/simple;
	bh=ggRaJLRo5UeUdBFtV//bF7fKUiC60pw5VhN5jconsLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKCeXNKQ/o38rkGa6nTWk7f4LB8vYXgWbKKRFbI57e+l9JkKpervvIY5Kj66jgnKEkNN58JOcffD7qfy/Jb2Gtvxxa39h1+Wl5TIPI1Pr78nQdbxD0At1dYNrZ8bwDpsU58X1sSi8A6QguWTGG7Q11sxhSSmAN29gmQ3fKdk3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZNh+i9om; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFPlEF018824
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hWvpoDjNTLvT9P7wnT7Jb3O4
	DlLy2jCuWuzYdjcW+9Q=; b=ZNh+i9ome76gk3UWE/kiZNeB8GgzN0paBILqu5zt
	n8BNOSSHRRoW0YWKf3ccCJysB/6a7Z2WR4+0opjwkdIydpQCOWBWNBAzwiESsuTE
	24hg0BKO/sc3jOzUA7N2+E+zKWMX09l3GGVgvwXfJ6x6kEq3nTp7tR3ux+aCQhA9
	MhJxafW3LTm9oOuVGYSThjrSzLoQrjS1XkelLsXs6Jt5JzBxOZy5rNsQkqoqiSR4
	1Hhz45c7pi9cBsMEZb8Z2nD/7rriX3+Sji/nu/PkmLflQQm7owpVWtqo1EZM2JTG
	1R0HxQKZwz4616BUyfeFF6ccL9EhfRreS03hwIUJZv9xPA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rtpevd8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:43:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e8704ea619so1451626585a.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756233802; x=1756838602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWvpoDjNTLvT9P7wnT7Jb3O4DlLy2jCuWuzYdjcW+9Q=;
        b=wdsJJH1UF6eIASOwkXE4yOc65QarTU2VuSz+/BGP/GjjgTksJrma7VSM4DxzJHikbt
         E0rpZ8e3tDVOppSPagD0M68UhUoPD/uBjR0n97OelDjHHGkud+elDkPTo9/GWGJqOXsw
         nx2qHQJy/NNPbcV8ark/b/TJ734Tw4QiQBPs0HoBMYS14vLra0LIL0RHio5onl09wJUg
         vjMbfT1FkygfoN66aNrcET+ZL2gRc317UHFZSQVttapWhb+NCqpNRgoPtFtD2Q3u+SEt
         StlY131nzMzvv7dgyxqioLr0RM1RAx2UySQcCrNEaSsirlczJZ2zwmxS2erx9qXFuW/x
         DqZw==
X-Forwarded-Encrypted: i=1; AJvYcCXuen+D+9/ZRNHwwr3JsRSgNNkiTYVEx/W4nCCCvKbEfZ+Stycr8w8nXTCpNiQSRgJT0+sPDAnsUIU3xI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8YC5HZjyuN3PfaFBomdd8hWfegnIS/uQgxqlNUIybvLXit25D
	c4NSWURRHzxz9LlOSFdz5s+V+0w4E9/sLnMk1JCJJ22YHcVUaj9fTU+wsDDe3Z7qONaZgPvQinL
	I/sQNezj1zp59XIOTEtOcRXoG7vtvngLAjo3JRW5KRY80s30LK4z7gPPWcYhsdij1a/M=
X-Gm-Gg: ASbGncsHVU6QqKaWndefOtMKlinHi6fR1D+m3Js/Ks19nQDp1xppZAHAI/TWzXjVavZ
	ol4LYGG8GnewYQXr9a/5nFEKsOQmdvEZf5z82hMgEeqJATyTndet8erjsOnatMQl4Pg07/5FoDU
	TPorUQjM/4mfSKh0tOlqRoZsfdpuq9xnO1h6bRHZvK8WM3j7TUzWt2hYN1JbsUmtfsY3UPmy/n/
	jVxNkv7hoSSrMNP5/j4JxeoYF72lbElYUtiauCbyIsXWc7RlxY2J/zETm+jnVyjpfP65x8ISBYh
	mOihyJT5YmB3oBXDPU8Zh8NoMZU6i4kQgfEF3fVFpXewVuv+iPCpN/LCeCc+CpHyLagoU1YC/S9
	1LNGndRAitWBd3oc4GO10FCK0X5Etre9YdlBehbJA124EX4rGONI/
X-Received: by 2002:a05:622a:588d:b0:4b2:ee95:6c54 with SMTP id d75a77b69052e-4b2ee95851dmr3728621cf.43.1756233802294;
        Tue, 26 Aug 2025 11:43:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6IfNHCoBBouEBY9m2TV/n1ySuwPSthCvJdO6LrRDTTfuS+b800yiqyuWzOwKIizgebXIBOA==
X-Received: by 2002:a05:622a:588d:b0:4b2:ee95:6c54 with SMTP id d75a77b69052e-4b2ee95851dmr3728131cf.43.1756233801582;
        Tue, 26 Aug 2025 11:43:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f42101509sm1719052e87.106.2025.08.26.11.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:43:20 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:43:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 32/38] drm/msm/dp: propagate MST state changes to dp
 mst module
Message-ID: <bmni5a57d5c6wu4zwlu3uokscnrmgsuvze254afwqcfdlqplzb@fss6ewfptdvv>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-32-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-32-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-GUID: pRZt-84BPUJgVlZ7MKuQLD1BVdCQvj5b
X-Proofpoint-ORIG-GUID: pRZt-84BPUJgVlZ7MKuQLD1BVdCQvj5b
X-Authority-Analysis: v=2.4 cv=Hd8UTjE8 c=1 sm=1 tr=0 ts=68ae004b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=XT7MnVG-IMvVsVpEgAUA:9
 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE0MiBTYWx0ZWRfX+ihQaPCjXVJb
 WgOHlpdzbDDH3SPRlgrtAL5neEsla3A+iXHRuMpSvww3qWvtfd7RFvJjIozsMyenIyijf8SaIXv
 NWD1VIri8AiQK3kcfoQDn/jL9FYC5T4m5M6zBF9He29xXaK/401FxT4OVb4rDKz/tXnj/KH2TbY
 Zz7dtCWpU5vQcPfO+VZCf9b6yl2/3b9pW3dXMguvUGqu5Hthph28HW0PTenCh8HoZyeBwlCFhmh
 BdEDweRU+a182aY1mcFV2PmNIfrzgoB8HE0tvj15kIiF48yT/pFdBqrmG47aZo9EqMMZ1FVWjzi
 Ld2cZ27WkjFdn/bvoioUEOraMKrMj0WmsdYJWiWR4C01yd2GxZCKlJMjw/wVatYOrUqbIJi8Ume
 1+MYNvty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250142

On Mon, Aug 25, 2025 at 10:16:18PM +0800, Yongxing Mou wrote:
> Introduce APIs to update the MST state change to MST framework when
> device is plugged/unplugged.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 10 +++++++++-
>  drivers/gpu/drm/msm/dp/dp_mst_drm.c | 15 +++++++++++++++
>  drivers/gpu/drm/msm/dp/dp_mst_drm.h |  1 +
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 59720e1ad4b1193e33a4fc6aad0c401eaf9cbec8..909c84a5c97f56138d0d62c5d856d2fd18d36b8c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -28,6 +28,7 @@
>  #include "dp_drm.h"
>  #include "dp_audio.h"
>  #include "dp_debug.h"
> +#include "dp_mst_drm.h"
>  
>  static bool psr_enabled = false;
>  module_param(psr_enabled, bool, 0);
> @@ -269,7 +270,6 @@ static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *d
>  		dp->panel->video_test = false;
>  	}
>  
> -

Unrelated

>  	drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
>  			dp->msm_dp_display.connector_type, hpd);
>  
> @@ -386,6 +386,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  
>  	msm_dp_link_reset_phy_params_vx_px(dp->link);
>  
> +	if (dp->msm_dp_display.mst_active)
> +		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, true);

I'd say, this should be a part of the previous patch.

> +
>  	if (!dp->msm_dp_display.internal_hpd)
>  		msm_dp_display_send_hpd_notification(dp, true);
>  
> @@ -608,6 +611,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
>  	if (!dp->msm_dp_display.internal_hpd)
>  		msm_dp_display_send_hpd_notification(dp, false);
>  
> +	if (dp->msm_dp_display.mst_active) {
> +		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, false);
> +		dp->msm_dp_display.mst_active = false;
> +	}
> +
>  	/* signal the disconnect event early to ensure proper teardown */
>  	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);
>  
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> index 331d08854049d9c74d49aa231f3507539986099e..ca654b1963467c8220dd7ee073f25216455d0490 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> @@ -924,6 +924,21 @@ msm_dp_mst_add_connector(struct drm_dp_mst_topology_mgr *mgr,
>  	return connector;
>  }
>  
> +int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
> +{
> +	int rc;
> +	struct msm_dp_mst *mst = dp_display->msm_dp_mst;

Reverse X-mas

> +
> +	rc = drm_dp_mst_topology_mgr_set_mst(&mst->mst_mgr, state);
> +	if (rc < 0) {
> +		DRM_ERROR("failed to set topology mgr state to %d. rc %d\n",
> +			  state, rc);
> +	}
> +
> +	drm_dbg_dp(dp_display->drm_dev, "dp_mst_display_set_mgr_state state:%d\n", state);
> +	return rc;
> +}
> +
>  static const struct drm_dp_mst_topology_cbs msm_dp_mst_drm_cbs = {
>  	.add_connector = msm_dp_mst_add_connector,
>  };
> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> index 5e1b4db8aea4506b0e1cc1cc68980dd617d3f72a..8fe6cbbe741da4abb232256b3a15ba6b16ca4f3e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
> @@ -87,5 +87,6 @@ int msm_dp_mst_drm_bridge_init(struct msm_dp *dp, struct drm_encoder *encoder);
>  int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
>  
>  void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display);
> +int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state);
>  
>  #endif /* _DP_MST_DRM_H_ */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

