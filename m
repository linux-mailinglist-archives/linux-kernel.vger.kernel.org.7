Return-Path: <linux-kernel+bounces-785292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163ABB348A5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068261A85B56
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF75302CB5;
	Mon, 25 Aug 2025 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gBow2Tw2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8678E301463
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142925; cv=none; b=IqRKx0rtuPZDYITi+OFG+vSXqmOSEPHq+t7rSQX9rZPOkP8WDIJRO3gLNZC1e+QNNhwWsQ8vP8h2oYuG+yaxeHHomxRX12CAUUUEM2UsR8WgKr8SgJ494feclFNbZCflq/+l+dY0zyDKJP53JLa6YNtCATgz6NUccwZBYYl/Ims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142925; c=relaxed/simple;
	bh=M0Ou+wHUk2SOrtxa5Db8yCe07ShGV4deqOVkyB6hBPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxqtqfbVsq1tU9nq5oDhIlMfYnfjuSFqRd0bbEFje2ItBHwjrFFSRDxpPoLEMhUvE88hIm09n7CZED1HPAdQnKgeHNVNAscgPKZhOPhN6Cq00Jzu9btALnCi8Qk6/76IqY6ER62vwrmj+HLpMoNi7neQvob5qcfInCfsquKAW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gBow2Tw2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PFrvHs024522
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=a8nUyAPGjf8x9ikWVpGDqkIv
	+8rZqElYhK4d+QfYf+E=; b=gBow2Tw2JnrLZzOWisGdzxf6rKnKfn14a1JYIE0N
	tg9HvO8y5SMF/NKFCI+KJCjb3TaQ1ZzsvFC4kecymjcJBdgZVnQ031xlKsoxwJhu
	3Gm3aLgCmKcfihXGVGHeKULG6YZOs9INXlyeW2yYW3nH0pBccQWEGlDFqsHQGyEL
	NiCEvZLR9hwaAJ3sKEBqrg7Q3xQ7xI3OdhBgNgWH8tcN1s/n/CHS48U8FTWo3unC
	LdHp6pn7CTEP+JaKezD0CcpnAZJZuoqbTaXiFn3hoPz8t62THVp/bf4kKxQ+YSyR
	GGxevGj5CRzLlQEcjrFOxS9nzYM6n03CX42773UdqBnGWg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6thwxps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:28:42 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109c7ad98so171473321cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756142921; x=1756747721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8nUyAPGjf8x9ikWVpGDqkIv+8rZqElYhK4d+QfYf+E=;
        b=tv9LYlyLQsgOardDzeV45citDIS16kVDXiksOv5EHaeGVNRPVp5yuDjPZ7FBX4a9MR
         eIaWNGx1t1wWZJtTXitl0KT4OSKI2I39wQLkicRAkkG+0XYMUGAf1Zqt7BeiMZiGJeAs
         n7HOAbD32D7K92EB4pXP1LBvnVA8SpLgvfs/Vpdq94Kjj6rRpEZdHwJG0KErs0Mx7bvc
         v60jayBSBaWEqpeFstyLiptG2Oql1nsh0dpt4rwQDMz02IZ4JtdamGOtUjUMUp6LCm5x
         stLTugz6m3ZzJLxoRrizOaG66S1bT1hhsQwP5QEIuR9P8MqZR5AQ3jb+1m8ZJAHsZUzO
         NbRw==
X-Forwarded-Encrypted: i=1; AJvYcCWn8YWa07m9/EFwdcqsRE8KgFAH3BeegWjsks6547w6sZJ/cIlBOyeymXy5BRZunfEJIBMdUuWNBXiI0zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCltUeev83JZdTR9ix22fNHlteOscKUnHMb/FDgoSiMHJ+4PTR
	3zGhuTH18n3UiLtOwRWRe01bIEqf0ANW71mj/giz/xXC7HeNXiS4cM2KWRqmxjpTJoDHPbwD/qi
	nICiyuG8Io3XmwKoyuJVwXhug63yR0RiNTGoOkX+NZYFTE90yp2JOqXSSurLFZJiFHNY=
X-Gm-Gg: ASbGncuowCl0QEybxaVGZ7T12bGD6PrZwXmOMctXLabLk7JG+7BR/jOH8/FoLahFbs2
	MEOzjODogChdjweneOwl+kQZDWXydHMhwPiCfACTOdFNLbVdjB+G50Ijh0vd1mpqwUjHedj1VKD
	/UnpYvw+Zj3y3Vt/9NMgQ/OIQYDOiHUiS0QD37EzYOzQx8Tn5nJdyN82IjrmT2XRce0+1U7D2ee
	D2rv7wQNIoUGB/yEOmCkjIPUTHOrwoBTdqs05WE8K+C2JsT32NtFX6kb7BzjCQZM4J+7pgq9nFL
	QrDCseeB9SIccC21S1h74JugrLpfbmMcrwyglnCqf9w3JWhxhsicrEOe3yzzVraCRMJDHOOawOm
	sqa7hJPiOcjrVDUH+/4GSid7sN3L2rWZpI+Qju17Q9CKwa5ohY4jw
X-Received: by 2002:ac8:7dc8:0:b0:4b2:d4d8:13e4 with SMTP id d75a77b69052e-4b2d4d8177bmr46741541cf.19.1756142920928;
        Mon, 25 Aug 2025 10:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElrTmsGh7ReiQT+rKWOGk73Md6WxupMETAj2QE15ZZrrWLzM1ZHzlak3lQmf4cmEkmQHgLYQ==
X-Received: by 2002:ac8:7dc8:0:b0:4b2:d4d8:13e4 with SMTP id d75a77b69052e-4b2d4d8177bmr46740991cf.19.1756142920362;
        Mon, 25 Aug 2025 10:28:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3365e20dac8sm16526111fa.8.2025.08.25.10.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:28:39 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:28:38 +0300
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
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/38] drm/msm/dp: splite msm_dp_ctrl_config_ctrl()
 into link parts and stream parts
Message-ID: <vvemyg2t3ycjwb3uhwua7ow6yjvo2mnu5tdrqc3ed3iuj5ue3v@bfvgfhcxbgke>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-5-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-5-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0MyBTYWx0ZWRfX5Yl8X1PjbxSa
 JJyC1pogkMbZ0npaouDt4Oyxh380jTV7+uLQYkkX/zyKe676s4dXGOIbqudK5+pyAvAx4/QpGsz
 +gMr6zk0W+M77XJeGbJ3pPj3o/R3tb9iUyFCSLpv2z08VPw91pYQm5GIp0+sgSwEh4sA+m6dlrm
 UgoTrWcFK/rl0/NODTobO2Wv+7KxZwruwMkERXV0oLJpeu1WakVeOxOasWKlqU55U3Se3nzN86A
 o4M7AWC3CIbBDMopo4Td1lAQz0P6r24ZknAUo9DbNos0HWJfIz9tfY6c885Fzl8PEDN4vVQtasy
 5QVuZ0NTuOpx8bQ+xCX1Ch73avjAjCBivgxOe6eubrX58w74PM7B6NvhLrC+ZZyDTddFK2GgvJ2
 aok0hlzQ
X-Proofpoint-ORIG-GUID: PBuG-olAjoJegGgYyQ-UioiZqIrglMfd
X-Proofpoint-GUID: PBuG-olAjoJegGgYyQ-UioiZqIrglMfd
X-Authority-Analysis: v=2.4 cv=W544VQWk c=1 sm=1 tr=0 ts=68ac9d4a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=irA99dXQLtNLEYesqbQA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_08,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230043

On Mon, Aug 25, 2025 at 10:15:51PM +0800, Yongxing Mou wrote:
> The DP_CONFIGURATION_CTRL register contains both link-level and
> stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
> all of them together, which makes it harder to support MST.
> 
> This patch separates the configuration into two functions:

git grep "This patch" Documentation/process

> - msm_dp_ctrl_config_ctrl_link(): handles link-related fields
> - msm_dp_ctrl_config_ctrl_streams(): handles stream-specific fields
> 
> It also moves the link-related configuration out of
> msm_dp_ctrl_configure_source_params().

Why? And it looks like a separate patch...

> 
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c | 49 +++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index e1ff4c6bb4f0eed2e1ff931f12ba891cf81feffb..45d6c9a7f7ddaa049443253cbf4c6fc5feda3177 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -380,26 +380,41 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
>  	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
>  }
>  
> -static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
> +static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
> +					    struct msm_dp_panel *msm_dp_panel)
>  {
>  	u32 config = 0, tbd;
> +
> +	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
> +
> +	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
> +		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
> +
> +	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
> +			msm_dp_panel->msm_dp_mode.bpp);
> +
> +	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
> +
> +	if (msm_dp_panel->psr_cap.version)
> +		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
> +
> +	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
> +
> +	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
> +}
> +
> +static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
> +{
> +	u32 config = 0;
>  	const u8 *dpcd = ctrl->panel->dpcd;
>  
>  	/* Default-> LSCLK DIV: 1/4 LCLK  */
>  	config |= (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);
>  
> -	if (ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
> -		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
> -
>  	/* Scrambler reset enable */
>  	if (drm_dp_alternate_scrambler_reset_cap(dpcd))
>  		config |= DP_CONFIGURATION_CTRL_ASSR;
>  
> -	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
> -			ctrl->panel->msm_dp_mode.bpp);
> -
> -	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
> -
>  	/* Num of Lanes */
>  	config |= ((ctrl->link->link_params.num_lanes - 1)
>  			<< DP_CONFIGURATION_CTRL_NUM_OF_LANES_SHIFT);
> @@ -413,10 +428,7 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
>  	config |= DP_CONFIGURATION_CTRL_STATIC_DYNAMIC_CN;
>  	config |= DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK;
>  
> -	if (ctrl->panel->psr_cap.version)
> -		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
> -
> -	drm_dbg_dp(ctrl->drm_dev, "DP_CONFIGURATION_CTRL=0x%x\n", config);
> +	drm_dbg_dp(ctrl->drm_dev, "link DP_CONFIGURATION_CTRL=0x%x\n", config);
>  
>  	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
>  }
> @@ -439,10 +451,7 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
>  {
>  	u32 colorimetry_cfg, test_bits_depth, misc_val;
>  
> -	msm_dp_ctrl_lane_mapping(ctrl);
> -	msm_dp_setup_peripheral_flush(ctrl);
> -
> -	msm_dp_ctrl_config_ctrl(ctrl);
> +	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
>  
>  	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
>  	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
> @@ -1614,7 +1623,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
>  	u8 assr;
>  	struct msm_dp_link_info link_info = {0};
>  
> -	msm_dp_ctrl_config_ctrl(ctrl);
> +	msm_dp_ctrl_config_ctrl_link(ctrl);
>  
>  	link_info.num_lanes = ctrl->link->link_params.num_lanes;
>  	link_info.rate = ctrl->link->link_params.rate;
> @@ -2524,6 +2533,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
>  	 */
>  	reinit_completion(&ctrl->video_comp);
>  
> +	msm_dp_ctrl_lane_mapping(ctrl);
> +	msm_dp_setup_peripheral_flush(ctrl);
> +	msm_dp_ctrl_config_ctrl_link(ctrl);
> +
>  	msm_dp_ctrl_configure_source_params(ctrl);
>  
>  	msm_dp_ctrl_config_msa(ctrl,
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

