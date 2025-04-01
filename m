Return-Path: <linux-kernel+bounces-582742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD30A77227
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 02:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8363A8FEF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Apr 2025 00:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F4713635E;
	Tue,  1 Apr 2025 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MlvfbK3z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFC02E3360
	for <linux-kernel@vger.kernel.org>; Tue,  1 Apr 2025 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743468933; cv=none; b=l6Xy0GmZ1TBMCVMpteW1NferlN+4qS4L4QbNiHZZWZ+D91qUyKhzweLwrbz7ICJOMsh0WK0Jw7gY27/SajyL5PqaUqoWmrxlClthYgVQuitkClfr4rOpbe84/I34MX1eBQPUREmT5HK0Icot0os3tTCc/wZDMPBuF1kTS+6BR9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743468933; c=relaxed/simple;
	bh=8o2k9g5sLBWOfm1VOkVvdzmPHSJLcNQqbHhyibgc/UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=If8W8pQqsjB8evDQrzqFyFfHxEkz3oeeBVCfjRuxhq3fembfoXhpR+QVlcafnkCCjYeSfpWGV/+Dq4KLRRCFqOabLsiIdmhhbxFKLYBI+//Z0toXH/TdSox+ZeMmE7SJstH5QEDo0lQNDfY9MSBP83swpl1b11GTtkrd3Pv3zZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MlvfbK3z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VFCuxt014509
	for <linux-kernel@vger.kernel.org>; Tue, 1 Apr 2025 00:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Yt9/DkdKL9fcmRUwD+msEiKi
	l6RqRPihQ0PGpkAzQ4g=; b=MlvfbK3zLw0CvqP2YA3udjDGeqMXjbeHHe3kuKxG
	F5QY3Wqay0jRBfMgF5P9ehCWBJHvstUvvwKbhLac/lEMKjJ6B6hpNKrTqlRC6bc+
	2QQ9DwXWlEwOJcjuInslqvH85uGiwDv2T+94V6IdrcnbPH+6rCbWV8JOHoqBTGae
	IFTkcfQCuWgS7i97GamtPLMo9vMotcgWruyveqDJcblbpoIVYFZlHTcdOJz0lqtm
	5tuRmcNUOo6IdvwaRzJqak8N0/iS0qQucnT6bqzq4c51vXwIFD1I6xWMf3M3GiRc
	GxDwHqmEJp8uz5ipvTzcCb7HObjYxfX+aL7P6s4uvaFv/A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p7tve2j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 01 Apr 2025 00:55:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c3c8f8ab79so755632385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 17:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743468929; x=1744073729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yt9/DkdKL9fcmRUwD+msEiKil6RqRPihQ0PGpkAzQ4g=;
        b=Kh1XtqwOz8Gx5TfKoVr4QCriy3HIyhDY1hNVPtaZ1BT1aKg801QObuA5NEOKLh8a3s
         qzYn+SD98SLA2rfsRyyNyYccq/7qjAfiyRn+bPTzzUQTWb8hx4wzQPEOPE9F+MTdPaqe
         K4acbVe/IcbG0ZhOGHnoTQrAx+bmLCmXpcFqGgG4cyLbW7kqMrqu0ElZtIlIuULYWeKd
         g1UMwUIMRkBl9oOVTRTcA3aD4JbxqRY5Qasy5X262AmoQLvwbbnYRYs+Liq7nMy1eMEM
         3BHWBOBFYbjQ38FGTHNU7599zFuSt37K2O14/BpX6Vp/omo8mg2yCSFWQg1I/KHdBN8A
         bOkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIwRUU1Gy8LulHIUEeU1bT5xHybrfYUEbHv5bjjUMJLfKMqjzRglg/P/DO9QTKi04DScQBAG0dz2e2FdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIEJClv5Z8YyZBblH6E0x49zI/r7FMOPasijjPB0RK6v6B9Znl
	X9td6DFeaAx7afPf30CtITwShw1nHXWgc/fH3sEJ+TzWDKXSLYSMyowSeqdn1ZrNF9A/JldidaB
	Mho/HsGKLZtHS1Tf0zO5s+pdkkiV+NJjnvzdP8NR8z+2p1n8UsLIspnqtIg3see4=
X-Gm-Gg: ASbGnctQ+0aiJM3//ISwSsf76NhhBfNbyGRJb3VGUhxX2V9DShLCUkYNFGVXzq64RH+
	VWYbUv3IgeuGixI8YRlyjkniN4ophdKDHSClCU/iPZG4DXvJO+DYziSn7kyPlVzuEZjQ182rz0u
	ZjFEPB3VEJKPV6s+WmurmvKw+GATPJj0JoD9CAcJ1NY1EV5c1rRhCFJL+k+riVYhhTjQt0aw+IR
	xJBR+IY0N2+fOKGrUXGURu9L1sa/ML5ALPx1zfRVZxoe0mPePYDZ0Em/FPcU3IAnq5vkSUoe/98
	wHbhuMDNXRzwZF4Wbz06RzfSroDpOZZvDyWSWtMcd1ru7bzG6/q07DfxAyQHlKR+G0AE0WCQsHS
	1NBM=
X-Received: by 2002:a05:620a:2913:b0:7c5:e283:7d0a with SMTP id af79cd13be357-7c6908430d8mr1598417385a.30.1743468929132;
        Mon, 31 Mar 2025 17:55:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+s43CcP4CDnMik98fedETIwmIvBFIiiN42MxuJhRd7qeTCnzq7nkWQ3AXlUV1C1XQuX7+5w==
X-Received: by 2002:a05:620a:2913:b0:7c5:e283:7d0a with SMTP id af79cd13be357-7c6908430d8mr1598414585a.30.1743468928726;
        Mon, 31 Mar 2025 17:55:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b0957fd7fsm1227575e87.114.2025.03.31.17.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 17:55:26 -0700 (PDT)
Date: Tue, 1 Apr 2025 03:55:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        laurentiu.tudor1@dell.com, abel.vesa@linaro.org, johan@kernel.org
Subject: Re: [PATCH v2 2/2] drm/msm/dp: Introduce link training per-segment
 for LTTPRs
Message-ID: <ytqnodci5xhkd4eqs3homrdwbv4zkaiewalfsbuclvkkaw754t@wpt3noqxlcvu>
References: <20250311234109.136510-1-alex.vinarskis@gmail.com>
 <20250311234109.136510-3-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311234109.136510-3-alex.vinarskis@gmail.com>
X-Authority-Analysis: v=2.4 cv=OIon3TaB c=1 sm=1 tr=0 ts=67eb3982 cx=c_pps a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=Wc1Mo8DDgmJwFSagYRAA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: iFj2Ndd3PfRkj79wciw0_h7JDQcM0QsF
X-Proofpoint-GUID: iFj2Ndd3PfRkj79wciw0_h7JDQcM0QsF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_11,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504010004

On Wed, Mar 12, 2025 at 12:38:04AM +0100, Aleksandrs Vinarskis wrote:
> DisplayPort requires per-segment link training when LTTPR are switched
> to non-transparent mode, starting with LTTPR closest to the source.
> Only when each segment is trained individually, source can link train
> to sink.
> 
> Implement per-segment link traning when LTTPR(s) are detected, to
> support external docking stations. On higher level, changes are:
> 
> * Pass phy being trained down to all required helpers
> * Run CR, EQ link training per phy
> * Set voltage swing, pre-emphasis levels per phy
> 
> This ensures successful link training both when connected directly to
> the monitor (single LTTPR onboard most X1E laptops) and via the docking
> station (at least two LTTPRs).
> 
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 137 +++++++++++++++++++---------
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |   2 +-
>  drivers/gpu/drm/msm/dp/dp_display.c |   4 +-
>  3 files changed, 99 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index d8633a596f8d..419a519ccf6b 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -79,6 +79,8 @@ struct msm_dp_ctrl_private {
>  	struct msm_dp_link *link;
>  	struct msm_dp_catalog *catalog;
>  
> +	int *lttpr_count;

Please move lttpr_count to msm_dp_ctrl or msm_dp_link. It would remove a
need for this ugly pointer.

> +
>  	struct phy *phy;
>  
>  	unsigned int num_core_clks;
> @@ -1034,9 +1036,11 @@ static int msm_dp_ctrl_set_vx_px(struct msm_dp_ctrl_private *ctrl,
>  	return 0;
>  }
>  
> -static int msm_dp_ctrl_update_vx_px(struct msm_dp_ctrl_private *ctrl)
> +static int msm_dp_ctrl_update_phy_vx_px(struct msm_dp_ctrl_private *ctrl,
> +					enum drm_dp_phy dp_phy)
>  {
>  	struct msm_dp_link *link = ctrl->link;
> +	int reg = DP_TRAINING_LANE0_SET;
>  	int ret = 0, lane, lane_cnt;
>  	u8 buf[4];
>  	u32 max_level_reached = 0;
> @@ -1075,8 +1079,11 @@ static int msm_dp_ctrl_update_vx_px(struct msm_dp_ctrl_private *ctrl)
>  
>  	drm_dbg_dp(ctrl->drm_dev, "sink: p|v=0x%x\n",
>  			voltage_swing_level | pre_emphasis_level);
> -	ret = drm_dp_dpcd_write(ctrl->aux, DP_TRAINING_LANE0_SET,
> -					buf, lane_cnt);
> +
> +	if (dp_phy != DP_PHY_DPRX)
> +		reg = DP_TRAINING_LANE0_SET_PHY_REPEATER(dp_phy);

Please always init reg here rather than using a default value above.
It's a cleaner code IMO.

> +
> +	ret = drm_dp_dpcd_write(ctrl->aux, reg, buf, lane_cnt);
>  	if (ret == lane_cnt)
>  		ret = 0;
>  
> @@ -1084,9 +1091,10 @@ static int msm_dp_ctrl_update_vx_px(struct msm_dp_ctrl_private *ctrl)
>  }
>  
>  static bool msm_dp_ctrl_train_pattern_set(struct msm_dp_ctrl_private *ctrl,
> -		u8 pattern)
> +		u8 pattern, enum drm_dp_phy dp_phy)
>  {
>  	u8 buf;
> +	int reg = DP_TRAINING_PATTERN_SET;
>  	int ret = 0;
>  
>  	drm_dbg_dp(ctrl->drm_dev, "sink: pattern=%x\n", pattern);
> @@ -1096,7 +1104,10 @@ static bool msm_dp_ctrl_train_pattern_set(struct msm_dp_ctrl_private *ctrl,
>  	if (pattern && pattern != DP_TRAINING_PATTERN_4)
>  		buf |= DP_LINK_SCRAMBLING_DISABLE;
>  
> -	ret = drm_dp_dpcd_writeb(ctrl->aux, DP_TRAINING_PATTERN_SET, buf);
> +	if (dp_phy != DP_PHY_DPRX)
> +		reg = DP_TRAINING_PATTERN_SET_PHY_REPEATER(dp_phy);

The same comment here.

> +
> +	ret = drm_dp_dpcd_writeb(ctrl->aux, reg, buf);
>  	return ret == 1;
>  }
>  
> @@ -1115,12 +1126,16 @@ static int msm_dp_ctrl_read_link_status(struct msm_dp_ctrl_private *ctrl,
>  }
>  
>  static int msm_dp_ctrl_link_train_1(struct msm_dp_ctrl_private *ctrl,
> -			int *training_step)
> +			int *training_step, enum drm_dp_phy dp_phy)
>  {
> +	int delay_us;
>  	int tries, old_v_level, ret = 0;
>  	u8 link_status[DP_LINK_STATUS_SIZE];
>  	int const maximum_retries = 4;
>  
> +	delay_us = drm_dp_read_clock_recovery_delay(ctrl->aux,
> +		ctrl->panel->dpcd, dp_phy, false);
> +
>  	msm_dp_catalog_ctrl_state_ctrl(ctrl->catalog, 0);
>  
>  	*training_step = DP_TRAINING_1;
> @@ -1129,18 +1144,19 @@ static int msm_dp_ctrl_link_train_1(struct msm_dp_ctrl_private *ctrl,
>  	if (ret)
>  		return ret;
>  	msm_dp_ctrl_train_pattern_set(ctrl, DP_TRAINING_PATTERN_1 |
> -		DP_LINK_SCRAMBLING_DISABLE);
> +		DP_LINK_SCRAMBLING_DISABLE, dp_phy);
>  
> -	ret = msm_dp_ctrl_update_vx_px(ctrl);
> +	msm_dp_link_reset_phy_params_vx_px(ctrl->link);
> +	ret = msm_dp_ctrl_update_phy_vx_px(ctrl, dp_phy);
>  	if (ret)
>  		return ret;
>  
>  	tries = 0;
>  	old_v_level = ctrl->link->phy_params.v_level;
>  	for (tries = 0; tries < maximum_retries; tries++) {
> -		drm_dp_link_train_clock_recovery_delay(ctrl->aux, ctrl->panel->dpcd);
> +		fsleep(delay_us);
>  
> -		ret = msm_dp_ctrl_read_link_status(ctrl, link_status);
> +		ret = drm_dp_dpcd_read_phy_link_status(ctrl->aux, dp_phy, link_status);

Please rebase this code on top of drm-misc-next.

>  		if (ret)
>  			return ret;
>  
> @@ -1161,7 +1177,7 @@ static int msm_dp_ctrl_link_train_1(struct msm_dp_ctrl_private *ctrl,
>  		}
>  
>  		msm_dp_link_adjust_levels(ctrl->link, link_status);
> -		ret = msm_dp_ctrl_update_vx_px(ctrl);
> +		ret = msm_dp_ctrl_update_phy_vx_px(ctrl, dp_phy);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1213,21 +1229,31 @@ static int msm_dp_ctrl_link_lane_down_shift(struct msm_dp_ctrl_private *ctrl)
>  	return 0;
>  }
>  
> -static void msm_dp_ctrl_clear_training_pattern(struct msm_dp_ctrl_private *ctrl)
> +static void msm_dp_ctrl_clear_training_pattern(struct msm_dp_ctrl_private *ctrl,
> +					       enum drm_dp_phy dp_phy)
>  {
> -	msm_dp_ctrl_train_pattern_set(ctrl, DP_TRAINING_PATTERN_DISABLE);
> -	drm_dp_link_train_channel_eq_delay(ctrl->aux, ctrl->panel->dpcd);
> +	int delay_us;
> +
> +	msm_dp_ctrl_train_pattern_set(ctrl, DP_TRAINING_PATTERN_DISABLE, dp_phy);
> +
> +	delay_us = drm_dp_read_channel_eq_delay(ctrl->aux,
> +		ctrl->panel->dpcd, dp_phy, false);

Misaligned, checkpatch should warn about it.

> +	fsleep(delay_us);
>  }
>  
>  static int msm_dp_ctrl_link_train_2(struct msm_dp_ctrl_private *ctrl,
> -			int *training_step)
> +			int *training_step, enum drm_dp_phy dp_phy)
>  {
> +	int delay_us;
>  	int tries = 0, ret = 0;
>  	u8 pattern;
>  	u32 state_ctrl_bit;
>  	int const maximum_retries = 5;
>  	u8 link_status[DP_LINK_STATUS_SIZE];
>  
> +	delay_us = drm_dp_read_channel_eq_delay(ctrl->aux,
> +		ctrl->panel->dpcd, dp_phy, false);

Misaligned

> +
>  	msm_dp_catalog_ctrl_state_ctrl(ctrl->catalog, 0);
>  
>  	*training_step = DP_TRAINING_2;
> @@ -1247,12 +1273,12 @@ static int msm_dp_ctrl_link_train_2(struct msm_dp_ctrl_private *ctrl,
>  	if (ret)
>  		return ret;
>  
> -	msm_dp_ctrl_train_pattern_set(ctrl, pattern);
> +	msm_dp_ctrl_train_pattern_set(ctrl, pattern, dp_phy);
>  
>  	for (tries = 0; tries <= maximum_retries; tries++) {
> -		drm_dp_link_train_channel_eq_delay(ctrl->aux, ctrl->panel->dpcd);
> +		fsleep(delay_us);
>  
> -		ret = msm_dp_ctrl_read_link_status(ctrl, link_status);
> +		ret = drm_dp_dpcd_read_phy_link_status(ctrl->aux, dp_phy, link_status);
>  		if (ret)
>  			return ret;
>  
> @@ -1262,7 +1288,7 @@ static int msm_dp_ctrl_link_train_2(struct msm_dp_ctrl_private *ctrl,
>  		}
>  
>  		msm_dp_link_adjust_levels(ctrl->link, link_status);
> -		ret = msm_dp_ctrl_update_vx_px(ctrl);
> +		ret = msm_dp_ctrl_update_phy_vx_px(ctrl, dp_phy);
>  		if (ret)
>  			return ret;
>  
> @@ -1271,10 +1297,32 @@ static int msm_dp_ctrl_link_train_2(struct msm_dp_ctrl_private *ctrl,
>  	return -ETIMEDOUT;
>  }
>  
> +static int msm_dp_ctrl_link_train_1_2(struct msm_dp_ctrl_private *ctrl,
> +				      int *training_step, enum drm_dp_phy dp_phy)
> +{
> +	int ret;
> +
> +	ret = msm_dp_ctrl_link_train_1(ctrl, training_step, dp_phy);
> +	if (ret) {
> +		DRM_ERROR("link training #1 on phy %d failed. ret=%d\n", dp_phy, ret);
> +		return ret;
> +	}
> +	drm_dbg_dp(ctrl->drm_dev, "link training #1 on phy %d successful\n", dp_phy);
> +
> +	ret = msm_dp_ctrl_link_train_2(ctrl, training_step, dp_phy);
> +	if (ret) {
> +		DRM_ERROR("link training #2 on phy %d failed. ret=%d\n", dp_phy, ret);
> +		return ret;
> +	}
> +	drm_dbg_dp(ctrl->drm_dev, "link training #2 on phy %d successful\n", dp_phy);
> +
> +	return 0;
> +}
> +
>  static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
>  			int *training_step)
>  {
> -	int ret = 0;
> +	int ret = 0, i;

Don't mix initialized and non-initialized variables in the same line.

>  	const u8 *dpcd = ctrl->panel->dpcd;
>  	u8 encoding[] = { 0, DP_SET_ANSI_8B10B };
>  	u8 assr;
> @@ -1286,8 +1334,6 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
>  	link_info.rate = ctrl->link->link_params.rate;
>  	link_info.capabilities = DP_LINK_CAP_ENHANCED_FRAMING;
>  
> -	msm_dp_link_reset_phy_params_vx_px(ctrl->link);
> -
>  	msm_dp_aux_link_configure(ctrl->aux, &link_info);
>  
>  	if (drm_dp_max_downspread(dpcd))
> @@ -1302,23 +1348,29 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
>  				&assr, 1);
>  	}
>  
> -	ret = msm_dp_ctrl_link_train_1(ctrl, training_step);
> +	for (i = *ctrl->lttpr_count - 1; i >= 0; i--) {
> +		enum drm_dp_phy dp_phy = DP_PHY_LTTPR(i);
> +
> +		ret = msm_dp_ctrl_link_train_1_2(ctrl, training_step, dp_phy);
> +		msm_dp_ctrl_clear_training_pattern(ctrl, dp_phy);
> +
> +		if (ret)
> +			break;
> +	}
> +
>  	if (ret) {
> -		DRM_ERROR("link training #1 failed. ret=%d\n", ret);
> +		DRM_ERROR("link training of LTTPR(s) failed. ret=%d\n", ret);
>  		goto end;
>  	}
>  
> -	/* print success info as this is a result of user initiated action */
> -	drm_dbg_dp(ctrl->drm_dev, "link training #1 successful\n");
> -
> -	ret = msm_dp_ctrl_link_train_2(ctrl, training_step);
> +	ret = msm_dp_ctrl_link_train_1_2(ctrl, training_step, DP_PHY_DPRX);
>  	if (ret) {
> -		DRM_ERROR("link training #2 failed. ret=%d\n", ret);
> +		DRM_ERROR("link training on sink failed. ret=%d\n", ret);
>  		goto end;
>  	}
>  
>  	/* print success info as this is a result of user initiated action */
> -	drm_dbg_dp(ctrl->drm_dev, "link training #2 successful\n");
> +	drm_dbg_dp(ctrl->drm_dev, "link training on sink successful\n");
>  

No need for keeping these debug messages, you have them in
msm_dp_ctrl_link_train_1_2().

>  end:
>  	msm_dp_catalog_ctrl_state_ctrl(ctrl->catalog, 0);
> @@ -1636,7 +1688,7 @@ static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl)
>  	if (ret)
>  		goto end;
>  
> -	msm_dp_ctrl_clear_training_pattern(ctrl);
> +	msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);
>  
>  	msm_dp_catalog_ctrl_state_ctrl(ctrl->catalog, DP_STATE_CTRL_SEND_VIDEO);
>  
> @@ -1660,7 +1712,7 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
>  		return false;
>  	}
>  	msm_dp_catalog_ctrl_send_phy_pattern(ctrl->catalog, pattern_requested);
> -	msm_dp_ctrl_update_vx_px(ctrl);
> +	msm_dp_ctrl_update_phy_vx_px(ctrl, DP_PHY_DPRX);
>  	msm_dp_link_send_test_response(ctrl->link);
>  
>  	pattern_sent = msm_dp_catalog_ctrl_read_phy_pattern(ctrl->catalog);
> @@ -1902,7 +1954,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
>  			}
>  
>  			/* stop link training before start re training  */
> -			msm_dp_ctrl_clear_training_pattern(ctrl);
> +			msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);

Just DPRX or should this include all LTTPRs? Could you point out how
this is handled inside Intel or AMD drivers?

>  		}
>  
>  		rc = msm_dp_ctrl_reinitialize_mainlink(ctrl);
> @@ -1926,7 +1978,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
>  		 * link training failed
>  		 * end txing train pattern here
>  		 */
> -		msm_dp_ctrl_clear_training_pattern(ctrl);
> +		msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);

The same.

>  
>  		msm_dp_ctrl_deinitialize_mainlink(ctrl);
>  		rc = -ECONNRESET;
> @@ -1997,7 +2049,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
>  		msm_dp_ctrl_link_retrain(ctrl);
>  
>  	/* stop txing train pattern to end link training */
> -	msm_dp_ctrl_clear_training_pattern(ctrl);
> +	msm_dp_ctrl_clear_training_pattern(ctrl, DP_PHY_DPRX);
>  
>  	/*
>  	 * Set up transfer unit values and set controller state to send
> @@ -2207,7 +2259,7 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
>  
>  struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link,
>  			struct msm_dp_panel *panel,	struct drm_dp_aux *aux,
> -			struct msm_dp_catalog *catalog,
> +			struct msm_dp_catalog *catalog, int *lttpr_count,
>  			struct phy *phy)
>  {
>  	struct msm_dp_ctrl_private *ctrl;
> @@ -2242,12 +2294,13 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
>  	init_completion(&ctrl->video_comp);
>  
>  	/* in parameters */
> -	ctrl->panel    = panel;
> -	ctrl->aux      = aux;
> -	ctrl->link     = link;
> -	ctrl->catalog  = catalog;
> -	ctrl->dev      = dev;
> -	ctrl->phy      = phy;
> +	ctrl->panel       = panel;
> +	ctrl->aux         = aux;
> +	ctrl->link        = link;
> +	ctrl->catalog     = catalog;
> +	ctrl->dev         = dev;
> +	ctrl->phy         = phy;
> +	ctrl->lttpr_count = lttpr_count;

I'd rather reduce noise and keep old assignments intact.

>  
>  	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl);
>  	if (ret) {
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index b7abfedbf574..3fb45b138b31 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -27,7 +27,7 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl);
>  void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl);
>  struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link,
>  			struct msm_dp_panel *panel,	struct drm_dp_aux *aux,
> -			struct msm_dp_catalog *catalog,
> +			struct msm_dp_catalog *catalog, int *lttpr_count,
>  			struct phy *phy);
>  
>  void msm_dp_ctrl_reset_irq_ctrl(struct msm_dp_ctrl *msm_dp_ctrl, bool enable);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index d0c2dc7e6648..393ce3479a7e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -108,6 +108,7 @@ struct msm_dp_display_private {
>  	struct msm_dp_event event_list[DP_EVENT_Q_MAX];
>  	spinlock_t event_lock;
>  
> +	int lttpr_count;
>  	u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE];
>  
>  	bool wide_bus_supported;
> @@ -397,7 +398,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	if (rc)
>  		goto end;
>  
> -	msm_dp_display_lttpr_init(dp, dpcd);
> +	dp->lttpr_count = msm_dp_display_lttpr_init(dp, dpcd);
>  
>  	rc = msm_dp_panel_read_sink_caps(dp->panel, dp->lttpr_common_caps, connector);
>  	if (rc)
> @@ -798,6 +799,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
>  
>  	dp->ctrl = msm_dp_ctrl_get(dev, dp->link, dp->panel, dp->aux,
>  			       dp->catalog,
> +			       &dp->lttpr_count,
>  			       phy);
>  	if (IS_ERR(dp->ctrl)) {
>  		rc = PTR_ERR(dp->ctrl);
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

