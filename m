Return-Path: <linux-kernel+bounces-785557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F108B34DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 23:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C952C3AC3E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 21:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3D729AAFA;
	Mon, 25 Aug 2025 21:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DC4YZkLM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21DE28FA91
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756156249; cv=none; b=a5uwy0KQep4dEkt7vLLagGg83ZoDlRR5vw0NUwH6p9O4VNrRLhwT95Me+nI42Vr41JUZsdh9utKNd0Bfn+pyWemyJ/6CKBiG87up6mJU4B0V/5kX7w/etFxy29s/yFLdV0dKHgaIIh6f3a1oiYcV1kZzUUqwPMLBFvtHrWioVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756156249; c=relaxed/simple;
	bh=tRXcSyUU8d5kUUS1FjVKUtGu+jckfg9kuVLeFg2aT4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQ2gxpp+LeCeq7o4Hu3xe/xZY8uOkh72+vPMVytRtyUaYGhbe2mKMQonPrNXSocaNshtmUHi05YrGnYLQvZ/c+YPVPgLZba26nbYvB9Wxaiz5OcavFw0Op5xkx3Gs4/n3RujZnkRhvYxOeKthj/sQnAKMrg2o5nIGytO5KGie/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DC4YZkLM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PGv8ps024596
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=o5NoSP+kvpf4oCKEIwkFCPBr
	ErrR3qlyUVN/G6WnM1o=; b=DC4YZkLMVND8ne/s2IQo8cjon2ytCnBP/FLRTRcT
	IiYyfsb0jaqG6Tob0so8DryTQo4nefIN/tAANhpd9rfYEdzF59h/Ii1nnYW0jbZB
	m/i95Xs/dr2h+O7uhsbXheqPKd5G4i2sbzG4dMzemLbYvt3hEei9LXsBHi4d4I0d
	8q4BdCuCuiD48GxzJGkTzb3jsXjtHPsFUBsvcVXto5JtnrlFgFiYJlxD4332jOx6
	ehtIquPaPbrGDYCvMFWz+Jbus9G12Z1ZtAFQ3c/uLA8NTKZp+YYQLw4+d4UyYlb8
	Qf9tJgZLid4qNrClcfQdoYuwUxVX4f5ZryhtiObcrskPZw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48rusk8mg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 21:10:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b2d09814efso24814921cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756156245; x=1756761045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5NoSP+kvpf4oCKEIwkFCPBrErrR3qlyUVN/G6WnM1o=;
        b=gCIrwgiy3hcN95GpoknCdQcoDcqe9IYjdp1gKKE3RY9h2fkblZWZfvD6jlH7+K+qTJ
         /LMJvIJD43oLiJZeNFb7Cd96RaA1O8blg7eb21tglWx4tmgdka+i9AVwum8MRn3VFE6y
         vgxhqASsoPQT97e7FidrtSagaodR//POBSCoUU9pp79Rt4yzTyInhFpoK1jWEzvMUwGT
         GTVft7NxIePhS1LI+TT57XzOVb8X4Ou/rQxN3ulIwrI+IYZm0QJ1mFKxXYwscvOnfmOh
         FocHS18E50jDzP+XHPFE6j3UPd025HfYeottKIam0XzNt96B6ofjNPLqia8F4550e8TF
         Q1kQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSAiqRiJYT+4SQubwjSsVycjSUs3yERdSuVJxkaEdmzn9lwJbUR4vhEsoEBPTIa5b3Tia161a2Clk+4Os=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1esWq6QEc4j0zzzgF52CjQKD1+12D48OqOB0+0O9Pfx0k27Rw
	VTZ5s5kAFin0sxA2Ea1DGJ+nCol8Vmw5qtZc1PfKxF1B2iL2RKMswJPGsqW25kXpuNxG9Kj6KR2
	uIquucS2eq7V091Twjwuj/HOEq/Ogca3N9okTz6jcuZOegumtMo52/siK01ALXVjgtg4=
X-Gm-Gg: ASbGncuqE4dOr+0/Ll2+g1GVAyU5b1ZfDwxCofDSCFCV4QZl6TlxJzsg2tUZqpKOtoS
	UOQnUsYwypPA1M2IJKIM/bnsoZG8cnJZSqjCPqsHG/k6E3O1BWYYhad79XFpk3/gMcsWurpjyL2
	L4AvuPSkMB9xEObVGwwwFYOMUZEJS6EhnkH91bZyy/arlG5UUaxNNjXhIHV0LaXBz4zBeGTbdiN
	QtBg2ZGA63h4i5pkA4Eaw7RszxO/gDL1ITKJ2SPEEgKVikcxj8BmcTsqQdfw7RBm5VoiEAfcERD
	o39W9bPxVqsArpjZpA2KDWRF6o4F3+tSexyf6WpmbzU0csat+c5cdGTywEyDlTZw9kNT59j89K0
	KF5YAIycdFabo0bTw8hMjCmSZ9jDByjQPkHqlD64ocR+PuTdge3Ba
X-Received: by 2002:a05:622a:241:b0:4ae:cc75:46e7 with SMTP id d75a77b69052e-4b2aab44eb1mr153288391cf.57.1756156245444;
        Mon, 25 Aug 2025 14:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo1/N0DbFsRaUXJYQAheMpfHeFkegCfsbtibM2neyB5yZ+Wlh3+3JMp7GtjIumnjz3kcEsdA==
X-Received: by 2002:a05:622a:241:b0:4ae:cc75:46e7 with SMTP id d75a77b69052e-4b2aab44eb1mr153288021cf.57.1756156244734;
        Mon, 25 Aug 2025 14:10:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35caab61sm1814974e87.140.2025.08.25.14.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 14:10:43 -0700 (PDT)
Date: Tue, 26 Aug 2025 00:10:41 +0300
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
Subject: Re: [PATCH v3 17/38] drm/msm/dp: add support to send ACT packets for
 MST
Message-ID: <mtli7kelybfot6ai3lqjagy6hahnpkimqjnjbk26shaoekqoht@cbycvfsmry4o>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-17-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-17-01faacfcdedd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=SY73duRu c=1 sm=1 tr=0 ts=68acd157 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=xirQvcjanROXNmDBG14A:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: K49EZXvabwHYzMCeT0jn2Rh1bs4oFDdv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDE1MyBTYWx0ZWRfX7ze8PqUBWj5P
 TDRiBK/ElKsAldgALpdj+4LD7b3/dyrfScsCQesbZ8SMudOO8l5q0VXH8li3kH3vVQGshccdSU0
 zvu8jfOwIiTf/eLaC8amEmZ95ujhPMuLuTa0gKuPuuGvayY6oG7cjnnFEvHeUKRkSO3fNbfKnq+
 DqCEkTHD7bObQg9fgWyy6+czQgSfc2QJyPiiNFbROPz9+InWp3a9dJ3bBSEg82WR5E7BVvMBMx8
 5SI2esLAw/5ceImEoO7Pb1rv6JhuzysxRsWxn4mU5dXthWv/e404tmI7YHCeQ31uYzRzUntiPeE
 5wC0TtNDhXzDedzbYWzgGO8SPaey1Xs7Npqj6rsQYkCCzp44ez8LfSk3symbQs8msGDehUYwwcf
 1UkNgxQ2
X-Proofpoint-ORIG-GUID: K49EZXvabwHYzMCeT0jn2Rh1bs4oFDdv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_10,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508250153

On Mon, Aug 25, 2025 at 10:16:03PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Whenever virtual channel slot allocation changes, the DP
> source must send the action control trigger sequence to notify
> the sink about the same. This would be applicable during the
> start and stop of the pixel stream. Add the infrastructure
> to be able to send ACT packets for the DP controller when
> operating in MST mode.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 39 +++++++++++++++++++++++++++++++++++--
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  4 ++--
>  drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
>  5 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 608a1a077301b2ef3c77c271d873bb4364abe779..16e5ed58e791971d5dca3077cbb77bfcc186505a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -142,6 +142,7 @@ struct msm_dp_ctrl_private {
>  	bool core_clks_on;
>  	bool link_clks_on;
>  	bool stream_clks_on[DP_STREAM_MAX];
> +	bool mst_active;
>  };
>  
>  static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
> @@ -227,6 +228,32 @@ static int msm_dp_aux_link_configure(struct drm_dp_aux *aux,
>  	return 0;
>  }
>  
> +void msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl)
> +{
> +	struct msm_dp_ctrl_private *ctrl;
> +	bool act_complete;
> +
> +	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
> +
> +	if (!ctrl->mst_active)
> +		return;
> +
> +	msm_dp_write_link(ctrl, REG_DP_MST_ACT, 0x1);
> +	/* make sure ACT signal is performed */
> +	wmb();
> +
> +	msleep(20); /* needs 1 frame time */
> +
> +	act_complete = msm_dp_read_link(ctrl, REG_DP_MST_ACT);
> +
> +	if (!act_complete)
> +		drm_dbg_dp(ctrl->drm_dev, "mst ACT trigger complete SUCCESS\n");
> +	else
> +		drm_dbg_dp(ctrl->drm_dev, "mst ACT trigger complete failed\n");

Shouldn't it return an error if the register dind't latch? Also,
shouldn't we set mst_active only if the write went through?

> +
> +	return;
> +}
> +
>  /*
>   * NOTE: resetting DP controller will also clear any pending HPD related interrupts
>   */
> @@ -2079,6 +2106,8 @@ static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl)
>  
>  	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>  
> +	msm_dp_ctrl_mst_send_act(&ctrl->msm_dp_ctrl);
> +
>  	ret = msm_dp_ctrl_wait4video_ready(ctrl);
>  end:
>  	return ret;
> @@ -2275,7 +2304,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
>  	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl, ctrl->panel->stream_id);
>  	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl);
>  
> -	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl);
> +	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, false);
>  	if (ret) {
>  		DRM_ERROR("failed to enable DP link controller\n");
>  		return ret;
> @@ -2355,7 +2384,7 @@ static bool msm_dp_ctrl_channel_eq_ok(struct msm_dp_ctrl_private *ctrl)
>  	return drm_dp_channel_eq_ok(link_status, num_lanes);
>  }
>  
> -int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
> +int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl, bool mst_active)
>  {
>  	int rc = 0;
>  	struct msm_dp_ctrl_private *ctrl;
> @@ -2373,6 +2402,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
>  
>  	rate = ctrl->panel->link_info.rate;
>  	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
> +	ctrl->mst_active = mst_active;
>  
>  	msm_dp_ctrl_core_clk_enable(&ctrl->msm_dp_ctrl);
>  
> @@ -2643,6 +2673,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
>  
>  	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
>  
> +	msm_dp_ctrl_mst_send_act(msm_dp_ctrl);
> +
>  	ret = msm_dp_ctrl_wait4video_ready(ctrl);
>  	if (ret)
>  		return ret;
> @@ -2682,6 +2714,8 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
>  
>  	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
>  
> +	ctrl->mst_active = false;
> +
>  	dev_pm_opp_set_rate(ctrl->dev, 0);
>  	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
>  
> @@ -2849,6 +2883,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
>  	ctrl->link_base = link_base;
>  	ctrl->mst2link_base = mst2link_base;
>  	ctrl->mst3link_base = mst3link_base;
> +	ctrl->mst_active = false;
>  
>  	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl, max_stream);
>  	if (ret) {
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index 2baf7a1ff44dd7139d2da86390121d5e7a063e9a..abf84ddf463638900684f2511549a593783d2247 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -16,7 +16,7 @@ struct msm_dp_ctrl {
>  
>  struct phy;
>  
> -int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
> +int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl, bool mst_active);
>  int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
>  int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
>  void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
> @@ -50,5 +50,5 @@ void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
>  void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
>  
>  void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
> -
> +void msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl);
>  #endif /* _DP_CTRL_H_ */
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 562a5eccf3f08c5669cc7c2ad1268897e975d0c4..eeba73f81c5ce7929dac88f4b47ac3741659864b 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -709,7 +709,7 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
>  		force_link_train = true;
>  	}
>  
> -	rc = msm_dp_ctrl_on_link(dp->ctrl);
> +	rc = msm_dp_ctrl_on_link(dp->ctrl, msm_dp_display->mst_active);
>  	if (rc) {
>  		DRM_ERROR("Failed link training (rc=%d)\n", rc);
>  		msm_dp_display->connector->state->link_status = DRM_LINK_STATUS_BAD;
> @@ -1557,6 +1557,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
>  	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
>  
>  	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
> +	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl);
>  }
>  
>  static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index a839d0a3941eac3e277185e42fddea15ca05a17f..9442157bca9d63467b4c43fa644651ad2cbcbef5 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -21,6 +21,7 @@ struct msm_dp {
>  	bool audio_enabled;
>  	bool power_on;
>  	bool prepared;
> +	bool mst_active;
>  	unsigned int connector_type;
>  	bool is_edp;
>  	bool internal_hpd;
> diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
> index a806d397ff9d9ad3830b1f539614bffcc955a786..de3d0b8b52c269fd7575edf3f4096a4284ad0b8d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_reg.h
> +++ b/drivers/gpu/drm/msm/dp/dp_reg.h
> @@ -158,6 +158,8 @@
>  #define DP_CONFIGURATION_CTRL_BPC_SHIFT		(0x08)
>  #define DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT	(0x0D)
>  
> +#define REG_DP_MST_ACT				(0x00000500)
> +
>  #define REG_DP_SOFTWARE_MVID			(0x00000010)
>  #define REG_DP_SOFTWARE_NVID			(0x00000018)
>  #define REG_DP_TOTAL_HOR_VER			(0x0000001C)
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

