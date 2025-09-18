Return-Path: <linux-kernel+bounces-785608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA910B34E73
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD3DF189222D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B529D291;
	Mon, 25 Aug 2025 21:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AYcJqTdm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAA729CB2D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756158758; cv=none; b=lAJJqoGodpXNXSyFJ9kdD4NX5oEpLFRCUwh7Ze8Dybw0Fbc1WlToTKWxFwXUmsYWy6KI0Js4nJ0PPHUP+Zf4KtMUCywUnzwAcssWzGjionxlm7w0MYyF2GALDgEdkOA7Gk72yc2HZK2t2CNK0k300voyLHuicsHZ1K21kKsY3wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756158758; c=relaxed/simple;
	bh=10eedD1gOuU+o/uAhQzM9f24w5D8De9uD2PGeV1uyUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqiUoS7bqIxaN23jv8hiMwsPeF/Des7JVcwbCqIgFHazGjec3KibB85L8PZzEBJtxt5FqdCniLk3VUkxflIeDosJEAHQs5HdzBPAyGW0GnJVxMpKkB9granlu8cnAIdRTkATL4ski+N4Kqa72ojKSylqfCrycuQaU+H1w0dQeyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AYcJqTdm; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PFuFPW020705
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rzP7DKMfRUX0VkJ6PVSwHW2+
	tdCAdM+bAVofUptR3os=; b=AYcJqTdm6Eq8YvN7JJ+8RZDUN30VAly6mptHdSgz
	zb7F4V7K8JWLPzrIJ9wl8sSx6Ns1ftyFkAG8fLAXK9SO1KfborFJo9iwiAc37vaE
	i2ntf3TG1AzU6PDw9oHvgexq+Rt7pdf+GAymiktWcU8uLdzmN32PCeNqedXiYTEk
	6LjxBR2hMWeBZOx6WQbkJnf0k//N6K+0JmWnjZnbTkUkHgiRSQG1xfXJsnA8bQUH
	TleLpefJGZoNgSpN4CITYIniNFyZb6XAdBRCizU2ZPulu2MAf+X5uXPZ7x4TZS93
	0juBc4pvabqAeTlFksuV6g+PDc6+RzPbneGndBIreqDDhw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x86kg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:52:35 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b2bf285aa5so53320491cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756158753; x=1756763553;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzP7DKMfRUX0VkJ6PVSwHW2+tdCAdM+bAVofUptR3os=;
        b=afxgrH1kUgb35YPsiz5yj8lq6b3bgmf9XPB+V+cEi2VSfZLS++2VzLMyN2XWlX/co0
         7zdQO8njq1+pH+HDEOFWQxtSRcLla2Oje0o4qYYFOE4OixR1mz1POQ1PNujzrkLggaR+
         Bdn+a+GQUZZRC7mhdeTuCH+cxRuKfvKh8EB+Z1x1mk+g0lQJQRxg8ZXiLund4v+fsy8i
         aba9fY6TB6KqQXE5bWbGxft/YybauU2WGCnrB67ny/MgvaByJ5E2B5ErN27wln2Tvohg
         FZ1lpuwvQ3YBT428hO/6vw9UC9lRhTESZXdX/EgYtt/zRZ3sMFdrPbArtvXav87hY5J8
         Oqsg==
X-Forwarded-Encrypted: i=1; AJvYcCXU7V0s9eVjqBUSjD/jpwkeW1u8J21piafgofClCw1FxAiLZbeMr2pDBCORwOI6h7ERT/5+wQJCXxHgCM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+WvDjJdgeOUTxgq+4TOwNKv3y+3y9ZAmiarSgptJe9wGlIZri
	WBRA5+l5sk37nB6lVPIfH1qs2dS+a2S3PabeiWwg3TC/tBOlf6Q7iHiC2J3RkhWwQh0ps0hIP9k
	VGhQSPrJ1xut79OANt6OS1kVrm+kWwfAvjYFvKQcWpWopfgyjIiHEfMzpM/LzYgdkqIs=
X-Gm-Gg: ASbGnct8zZqUtMsgijQi+cZ+p+XRxktkU2zqxPt9ymWItXvSzbK7h0Xi6ygDLEW9KlI
	y+w/I+S1kc+NnOM/ekNc8sQgpJ4HPDMW939Xq4NXQUxj3P6t6aDSGL3u0Um6uRsq8FRSstVF0HM
	yG4AGN3BnCWSCvJgMYx8DnKPU0/GhCLBFne0db/sTlEvK8ihAjVzSu4S3QoXyoTf6PceN9a9kzn
	FTQUAPEFhceEkBgDIW826HEJLub1RaKMHcgu/ZwGewoe2Ob530tYaCLK5ZejXj13zighDAe3zZ4
	8Wx4Q6IX2MvpR5kWNFybs1Cc8tQFKNzG8Tca+NBfsvr1sCVDKs0sjM46UBgSSlV8qDWGXq67usx
	E2/Wlo792hvxUZlJyLd9uWSRXdkvq1nJeSGvZzgCsOWCNIUjApkq9
X-Received: by 2002:ac8:7dcd:0:b0:4b2:967f:cb4b with SMTP id d75a77b69052e-4b2aab242c5mr154403111cf.63.1756158752996;
        Mon, 25 Aug 2025 14:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRE/RoN4lvZ0O44LljLL95XWWsQGSlyUtdu63KRiRfQWg+Pz5EWS583JNP2BeD47L/qFiraQ==
X-Received: by 2002:ac8:7dcd:0:b0:4b2:967f:cb4b with SMTP id d75a77b69052e-4b2aab242c5mr154402661cf.63.1756158752175;
        Mon, 25 Aug 2025 14:52:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f48177b55sm567102e87.62.2025.08.25.14.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:52:31 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:52:29 +0300
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
Subject: Re: [PATCH v3 20/38] drm/msm/dp: Add support for MST channel slot
 allocation
Message-ID: <jbobh2meagyzmv6p3lxnu55wyzavldhyqloudcfj3cybeaco3e@hfip5yehyepv>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-20-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-20-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: LnIXQ8lGxIvJS1nsqBF9px8XG3g7KPsb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfXwwoZSHC+cJN5
 sBD6cD+SOGl2VICZPrfzErdfw78X3M+KCQZw9IrLbf73XNRgDdjoQXTrmqr11Eu/TkFD94bx6tx
 o4EdZYp/rxpCShjs51jCHYz6+9+7DFJHmcY9OHnWz7KbT4ociUiukZCzuZt54EvlDgpatvZsU/8
 AoYnKbKhE2H5996skqthGm9VdBGf8nZQ0Vv4Vz6Cxvjv9Md1IJtB1GNI0Fc8PBUMjvDeFPhM6RA
 fhPGgVm+8QacM9LSL3gYdR+dCBZusA2ztD03vQqyqYEB6NUC9+DRNG1CyIjm5aasQjFHWOqUdgy
 HbTr8sCc3gdNX7HenxkLq8Us4HW5GEsCao21awiW+/CUekOVjA8jtrHUmFPH0JlHe3+YPo93/jh
 jeXDo7f0
X-Proofpoint-GUID: LnIXQ8lGxIvJS1nsqBF9px8XG3g7KPsb
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68acdb23 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Sfuty-t4yrZ6XxHQvawA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_10,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044

On Mon, Aug 25, 2025 at 10:16:06PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> DP MST streams share 64 MTP slots in a time-multiplexed manner. This patch
> adds support for calculating the rate governor, slot allocation, and slot
> reservation in the DP controller.
> 
> Each MST stream can reserve its slots by calling
> dp_display_set_stream_info() from its bridge callbacks.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 213 +++++++++++++++++++++++++++++++++++-
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |   7 +-
>  drivers/gpu/drm/msm/dp/dp_display.c |  40 ++++---
>  drivers/gpu/drm/msm/dp/dp_display.h |   5 +-
>  drivers/gpu/drm/msm/dp/dp_panel.h   |   1 +
>  drivers/gpu/drm/msm/dp/dp_reg.h     |  14 ++-
>  6 files changed, 262 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index c313a3b4853a1571c43a9f3c9e981fbc22d51d55..9d58d9480fc4ab33c58218ef9beb54c64805c34c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -109,6 +109,11 @@ struct msm_dp_vc_tu_mapping_table {
>  	u8 tu_size_minus1;
>  };
>  
> +struct msm_dp_mst_ch_slot_info {
> +	u32 start_slot;
> +	u32 tot_slots;
> +};
> +
>  struct msm_dp_ctrl_private {
>  	struct msm_dp_ctrl msm_dp_ctrl;
>  	struct drm_device *drm_dev;
> @@ -143,6 +148,8 @@ struct msm_dp_ctrl_private {
>  	bool link_clks_on;
>  	bool stream_clks_on[DP_STREAM_MAX];
>  	bool mst_active;
> +
> +	struct msm_dp_mst_ch_slot_info mst_ch_info[DP_STREAM_MAX];
>  };
>  
>  static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
> @@ -267,6 +274,77 @@ static void msm_dp_ctrl_mst_config(struct msm_dp_ctrl_private *ctrl, bool enable
>  	msm_dp_write_link(ctrl, REG_DP_MAINLINK_CTRL, mainlink_ctrl);
>  }
>  
> +static void msm_dp_ctrl_mst_channel_alloc(struct msm_dp_ctrl_private *ctrl,
> +				      enum msm_dp_stream_id stream_id, u32 ch_start_slot,
> +				      u32 tot_slot_cnt)
> +{
> +	u32 i, slot_reg_1, slot_reg_2, slot;
> +	u32 reg_off = 0;
> +	int const num_slots_per_reg = 32;
> +
> +	if (ch_start_slot > DP_MAX_TIME_SLOTS ||
> +	    (ch_start_slot + tot_slot_cnt > DP_MAX_TIME_SLOTS)) {
> +		DRM_ERROR("invalid slots start %d, tot %d\n",
> +			  ch_start_slot, tot_slot_cnt);
> +		return;
> +	}
> +
> +	drm_dbg_dp(ctrl->drm_dev, "stream_id %d, start_slot %d, tot_slot %d\n",
> +		   stream_id, ch_start_slot, tot_slot_cnt);
> +
> +	if (stream_id == DP_STREAM_1)
> +		reg_off = REG_DP_DP1_TIMESLOT_1_32 - REG_DP_DP0_TIMESLOT_1_32;
> +
> +	slot_reg_1 = 0;
> +	slot_reg_2 = 0;
> +
> +	if (ch_start_slot && tot_slot_cnt) {
> +		ch_start_slot--;
> +		for (i = 0; i < tot_slot_cnt; i++) {

You can replace loops with maths.

> +			if (ch_start_slot < num_slots_per_reg) {
> +				slot_reg_1 |= BIT(ch_start_slot);
> +			} else {
> +				slot = ch_start_slot - num_slots_per_reg;
> +				slot_reg_2 |= BIT(slot);
> +			}
> +			ch_start_slot++;
> +		}
> +	}
> +
> +	drm_dbg_dp(ctrl->drm_dev, "stream_id:%d slot_reg_1:%d, slot_reg_2:%d\n", stream_id,
> +		   slot_reg_1, slot_reg_2);
> +
> +	if (stream_id > DP_STREAM_1) {
> +		msm_dp_write_mstlink(ctrl, stream_id, REG_DP_MSTLINK_TIMESLOT_1_32,
> +				      slot_reg_1);
> +		msm_dp_write_mstlink(ctrl, stream_id, REG_DP_MSTLINK_TIMESLOT_33_63,
> +				      slot_reg_2);
> +	} else {
> +		msm_dp_write_link(ctrl, REG_DP_DP0_TIMESLOT_1_32 + reg_off, slot_reg_1);
> +		msm_dp_write_link(ctrl, REG_DP_DP0_TIMESLOT_33_63 + reg_off, slot_reg_2);
> +	}
> +}
> +
> +static void msm_dp_ctrl_update_rg(struct msm_dp_ctrl_private *ctrl,
> +				 enum msm_dp_stream_id stream_id, u32 x_int, u32 y_frac_enum)
> +{
> +	u32 rg, reg_off = 0;
> +
> +	rg = y_frac_enum;
> +	rg |= (x_int << 16);
> +
> +	drm_dbg_dp(ctrl->drm_dev, "stream_id: %d x_int:%d y_frac_enum:%d rg:%d\n",
> +		stream_id, x_int, y_frac_enum, rg);
> +
> +	if (stream_id == DP_STREAM_1)
> +		reg_off = REG_DP_DP1_RG - REG_DP_DP0_RG;
> +
> +	if (stream_id > DP_STREAM_1)
> +		msm_dp_write_mstlink(ctrl, stream_id, REG_DP_MSTLINK_DP_RG, rg);
> +	else
> +		msm_dp_write_link(ctrl, REG_DP_DP0_RG + reg_off, rg);
> +}
> +
>  /*
>   * NOTE: resetting DP controller will also clear any pending HPD related interrupts
>   */
> @@ -2634,7 +2712,105 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_li
>  	return ret;
>  }
>  
> -int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel)
> +static void msm_dp_ctrl_mst_calculate_rg(struct msm_dp_ctrl_private *ctrl,
> +					 struct msm_dp_panel *panel,
> +					 u32 *p_x_int, u32 *p_y_frac_enum)

A comment would be appreciated.

> +{
> +	u64 min_slot_cnt, max_slot_cnt;
> +	u64 raw_target_sc, target_sc_fixp;
> +	u64 ts_denom, ts_enum, ts_int;
> +	u64 pclk = panel->msm_dp_mode.drm_mode.clock;
> +	u64 lclk = 0;
> +	u64 lanes = ctrl->link->link_params.num_lanes;
> +	u64 bpp = panel->msm_dp_mode.bpp;
> +	u64 pbn = panel->pbn;
> +	u64 numerator, denominator, temp, temp1, temp2;
> +	u32 x_int = 0, y_frac_enum = 0;
> +	u64 target_strm_sym, ts_int_fixp, ts_frac_fixp, y_frac_enum_fixp;
> +
> +	lclk = ctrl->link->link_params.rate;
> +
> +	/* min_slot_cnt */
> +	numerator = pclk * bpp * 64 * 1000;
> +	denominator = lclk * lanes * 8 * 1000;
> +	min_slot_cnt = drm_fixp_from_fraction(numerator, denominator);
> +
> +	/* max_slot_cnt */
> +	numerator = pbn * 54 * 1000;
> +	denominator = lclk * lanes;
> +	max_slot_cnt = drm_fixp_from_fraction(numerator, denominator);
> +
> +	/* raw_target_sc */
> +	numerator = max_slot_cnt + min_slot_cnt;
> +	denominator = drm_fixp_from_fraction(2, 1);
> +	raw_target_sc = drm_fixp_div(numerator, denominator);
> +
> +	/* target_sc */
> +	temp = drm_fixp_from_fraction(256 * lanes, 1);
> +	numerator = drm_fixp_mul(raw_target_sc, temp);
> +	denominator = drm_fixp_from_fraction(256 * lanes, 1);
> +	target_sc_fixp = drm_fixp_div(numerator, denominator);
> +
> +	ts_enum = 256 * lanes;
> +	ts_denom = drm_fixp_from_fraction(256 * lanes, 1);
> +	ts_int = drm_fixp2int(target_sc_fixp);
> +
> +	temp = drm_fixp2int_ceil(raw_target_sc);
> +	if (temp != ts_int) {
> +		temp = drm_fixp_from_fraction(ts_int, 1);
> +		temp1 = raw_target_sc - temp;
> +		temp2 = drm_fixp_mul(temp1, ts_denom);
> +		ts_enum = drm_fixp2int(temp2);
> +	}
> +
> +	/* target_strm_sym */
> +	ts_int_fixp = drm_fixp_from_fraction(ts_int, 1);
> +	ts_frac_fixp = drm_fixp_from_fraction(ts_enum, drm_fixp2int(ts_denom));
> +	temp = ts_int_fixp + ts_frac_fixp;
> +	temp1 = drm_fixp_from_fraction(lanes, 1);
> +	target_strm_sym = drm_fixp_mul(temp, temp1);
> +
> +	/* x_int */
> +	x_int = drm_fixp2int(target_strm_sym);
> +
> +	/* y_enum_frac */
> +	temp = drm_fixp_from_fraction(x_int, 1);
> +	temp1 = target_strm_sym - temp;
> +	temp2 = drm_fixp_from_fraction(256, 1);
> +	y_frac_enum_fixp = drm_fixp_mul(temp1, temp2);
> +
> +	temp1 = drm_fixp2int(y_frac_enum_fixp);
> +	temp2 = drm_fixp2int_ceil(y_frac_enum_fixp);
> +
> +	y_frac_enum = (u32)((temp1 == temp2) ? temp1 : temp1 + 1);
> +
> +	*p_x_int = x_int;
> +	*p_y_frac_enum = y_frac_enum;
> +
> +	drm_dbg_dp(ctrl->drm_dev, "mst lane_cnt:%llu, rate:%llu x_int:%d, y_frac:%d\n",

globally, for all patches: s/\<mst\>/MST/g

> +		   lanes, lclk, x_int, y_frac_enum);
> +}
> +
> +static void msm_dp_ctrl_mst_stream_setup(struct msm_dp_ctrl_private *ctrl,
> +					 struct msm_dp_panel *panel,
> +					 u32 max_streams)

It's not that max_streams can change... I'd totally prefer to stop
passing it as params.

> +{
> +	u32 x_int, y_frac_enum;
> +
> +	if (!ctrl->mst_active)
> +		return;
> +
> +	drm_dbg_dp(ctrl->drm_dev, "mst stream channel allocation\n");
> +
> +	msm_dp_ctrl_mst_stream_channel_slot_setup(&ctrl->msm_dp_ctrl, max_streams);
> +
> +	msm_dp_ctrl_mst_calculate_rg(ctrl, panel, &x_int, &y_frac_enum);
> +
> +	msm_dp_ctrl_update_rg(ctrl, panel->stream_id, x_int, y_frac_enum);
> +}
> +
> +int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl,
> +			  struct msm_dp_panel *msm_dp_panel, u32 max_streams)
>  {
>  	int ret = 0;
>  	bool mainlink_ready = false;
> @@ -2688,6 +2864,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>  	if (!ctrl->mst_active)
>  		msm_dp_ctrl_setup_tr_unit(ctrl);
>  
> +	msm_dp_ctrl_mst_stream_setup(ctrl, msm_dp_panel, max_streams);
> +
>  	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>  
>  	msm_dp_ctrl_mst_send_act(msm_dp_ctrl);
> @@ -2742,6 +2920,39 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
>  			phy, phy->init_count, phy->power_count);
>  }
>  
> +void msm_dp_ctrl_set_mst_channel_info(struct msm_dp_ctrl *msm_dp_ctrl,
> +				      enum msm_dp_stream_id stream_id,
> +				      u32 start_slot, u32 tot_slots)
> +{
> +	struct msm_dp_ctrl_private *ctrl;
> +
> +	if (!msm_dp_ctrl || stream_id >= DP_STREAM_MAX) {
> +		DRM_ERROR("invalid input\n");
> +		return;
> +	}
> +
> +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
> +
> +	ctrl->mst_ch_info[stream_id].start_slot = start_slot;
> +	ctrl->mst_ch_info[stream_id].tot_slots = tot_slots;
> +}
> +
> +void msm_dp_ctrl_mst_stream_channel_slot_setup(struct msm_dp_ctrl *msm_dp_ctrl, u32 max_streams)
> +{
> +	struct msm_dp_ctrl_private *ctrl;
> +	int i;
> +
> +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
> +
> +	if (!ctrl->mst_active)
> +		return;
> +
> +	for (i = DP_STREAM_0; i < max_streams; i++) {
> +		msm_dp_ctrl_mst_channel_alloc(ctrl, i, ctrl->mst_ch_info[i].start_slot,
> +					      ctrl->mst_ch_info[i].tot_slots);
> +	}
> +}
> +
>  irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl)
>  {
>  	struct msm_dp_ctrl_private *ctrl;
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index abf84ddf463638900684f2511549a593783d2247..751f00c97b94dc3b9e8fae2a86e261f71f293425 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -17,7 +17,8 @@ struct msm_dp_ctrl {
>  struct phy;
>  
>  int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl, bool mst_active);
> -int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
> +int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl,
> +			  struct msm_dp_panel *msm_dp_panel, u32 max_streams);
>  int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
>  void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
>  void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id);
> @@ -51,4 +52,8 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
>  
>  void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
>  void msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl);
> +void msm_dp_ctrl_mst_stream_channel_slot_setup(struct msm_dp_ctrl *msm_dp_ctrl, u32 max_streams);
> +void msm_dp_ctrl_set_mst_channel_info(struct msm_dp_ctrl *msm_dp_ctrl,
> +				      enum msm_dp_stream_id stream_id,
> +				      u32 start_slot, u32 tot_slots);
>  #endif /* _DP_CTRL_H_ */
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index eeba73f81c5ce7929dac88f4b47ac3741659864b..17633ba79aa7642856051b69227e8f5b23d76730 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -733,7 +733,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
>  		return 0;
>  	}
>  
> -	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel);
> +	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel, dp->max_stream);
>  	if (!rc)
>  		msm_dp_display->power_on = true;
>  
> @@ -817,21 +817,33 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
>  	return 0;
>  }
>  
> -int msm_dp_display_set_stream_id(struct msm_dp *dp,
> -				 struct msm_dp_panel *panel, enum msm_dp_stream_id stream_id)
> +int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display, struct msm_dp_panel *panel,
> +				   enum msm_dp_stream_id stream_id, u32 start_slot,
> +				   u32 num_slots, u32 pbn, int vcpi)

vcpi isn't being used at this patch, don't add it.

>  {
>  	int rc = 0;
> -	struct msm_dp_display_private *msm_dp_display;
> +	struct msm_dp_display_private *dp;
> +	const int max_slots = 64;
>  
> -	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	if (!msm_dp_display) {
> +	if (!dp) {
>  		DRM_ERROR("invalid input\n");
>  		return -EINVAL;
>  	}
>  
> -	if (panel)
> +	if (start_slot + num_slots > max_slots) {
> +		DRM_ERROR("invalid channel info received. start:%d, slots:%d\n",
> +			  start_slot, num_slots);
> +		return -EINVAL;
> +	}
> +
> +	msm_dp_ctrl_set_mst_channel_info(dp->ctrl, stream_id, start_slot, num_slots);
> +
> +	if (panel) {

The panel is always passed, as far as I can see.

>  		panel->stream_id = stream_id;
> +		panel->pbn = pbn;
> +	}
>  
>  	return rc;
>  }
> @@ -1533,7 +1545,7 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	msm_dp_display_set_stream_id(msm_dp_display, dp->panel, 0);
> +	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0, 0, 0);
>  
>  	if (msm_dp_display->prepared) {
>  		rc = msm_dp_display_enable(dp);
> @@ -1550,14 +1562,16 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
>  	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
>  }
>  
> -void msm_dp_display_atomic_disable(struct msm_dp *dp)
> +void msm_dp_display_atomic_disable(struct msm_dp *msm_dp_display)
>  {
> -	struct msm_dp_display_private *msm_dp_display;
> +	struct msm_dp_display_private *dp;
>  
> -	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
> -	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl);
> +	msm_dp_ctrl_push_idle(dp->ctrl);
> +	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl,
> +		dp->max_stream);
> +	msm_dp_ctrl_mst_send_act(dp->ctrl);
>  }
>  
>  static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index 9442157bca9d63467b4c43fa644651ad2cbcbef5..fa92f763d2304f15af7c4e1e7e8aab5a6ffd3459 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -48,7 +48,8 @@ void msm_dp_display_mode_set(struct msm_dp *dp,
>  enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
>  					       const struct drm_display_info *info,
>  					       const struct drm_display_mode *mode);
> -int msm_dp_display_set_stream_id(struct msm_dp *dp,
> -				 struct msm_dp_panel *panel, enum msm_dp_stream_id stream_id);
> +int msm_dp_display_set_stream_info(struct msm_dp *dp_display, struct msm_dp_panel *panel,
> +				   enum msm_dp_stream_id stream_id,
> +				   u32 start_slot, u32 num_slots, u32 pbn, int vcpi);
>  
>  #endif /* _DP_DISPLAY_H_ */
> diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
> index 2bfe3695994235d04e209a2785915107c6a8e413..cb5bf6c99a6f7a68995f0f0ac48382dc90beca31 100644
> --- a/drivers/gpu/drm/msm/dp/dp_panel.h
> +++ b/drivers/gpu/drm/msm/dp/dp_panel.h
> @@ -50,6 +50,7 @@ struct msm_dp_panel {
>  	u32 hw_revision;
>  
>  	enum msm_dp_stream_id stream_id;
> +	u32 pbn;
>  
>  	u32 max_dp_lanes;
>  	u32 max_dp_link_rate;
> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
> index fda847b33f8d0d6ec4d2589586b5a3d6c9b1ccf3..ee4debf796910e00d370ab4c687009747bae5378 100644
> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
> @@ -364,6 +364,19 @@
>  #define REG_DP_PHY_AUX_BIST_CFG			(0x00000050)
>  #define REG_DP_PHY_AUX_INTERRUPT_STATUS         (0x000000BC)
>  
> +/* DP MST related registers */
> +#define DP_MAX_TIME_SLOTS 64
> +
> +#define REG_DP_MSTLINK_DP_RG			(0X0000011C)
> +#define REG_DP_DP0_TIMESLOT_1_32		(0x00000404)
> +#define REG_DP_DP0_TIMESLOT_33_63		(0x00000408)
> +#define REG_DP_DP1_TIMESLOT_1_32		(0x0000040C)
> +#define REG_DP_DP1_TIMESLOT_33_63		(0x00000410)
> +#define REG_DP_MSTLINK_TIMESLOT_1_32		(0x00000038)
> +#define REG_DP_MSTLINK_TIMESLOT_33_63		(0x0000003C)
> +#define REG_DP_DP0_RG				(0x000004F8)
> +#define REG_DP_DP1_RG				(0x000004FC)
> +
>  /* DP HDCP 1.3 registers */
>  #define DP_HDCP_CTRL                                   (0x0A0)
>  #define DP_HDCP_STATUS                                 (0x0A4)
> @@ -388,5 +401,4 @@
>  #define HDCP_SEC_DP_TZ_HV_HLOS_HDCP_RCVPORT_DATA10     (0x018)
>  #define HDCP_SEC_DP_TZ_HV_HLOS_HDCP_RCVPORT_DATA11     (0x01C)
>  #define HDCP_SEC_DP_TZ_HV_HLOS_HDCP_RCVPORT_DATA12     (0x020)
> -
>  #endif /* _DP_REG_H_ */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

