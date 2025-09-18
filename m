Return-Path: <linux-kernel+bounces-785639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90770B34EE2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54E920869E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950CF239573;
	Mon, 25 Aug 2025 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kkgf964o"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A536C1F55FA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160314; cv=none; b=R93IvjO/h3VPmEnpTM89R+qTU4MpooYHFd/NXvG/SpZep51Xau/3kc+Htzm5fmT0wkZ+7OUZHudpLkkfLiPR1MOkT1Xk09iidwe/4rueGOaHT+cRdltT4EtNYjppbuzFD7kIdn5Tq8iBwlWgrY8fUtAHRphU+6RMMnwy6Jcu1Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160314; c=relaxed/simple;
	bh=18+G9ItYgu2+dXrIWwH0AUSy1PIG1s8r32WNAn8YTP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTW1K18ar3YIy9hJYkfadY2SScKZ2tRsXc6O66cWRTDsc4xxpOokL8xZHjKHsR1NfbRNuKRRc3+KbGSf1Go+saJuBkr1VIYkrX0Tr/ymLzzbELPf4TO+spUCQaMyqYEOvWUmjq2+y9K75iWeBQZWt7ZA3m4gz5QNegE2rHEFGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kkgf964o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PG9aAf006049
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6Ie393XGfhaHZ0Us6yXgzMFw
	LUpvRvDwsjf8xQ5Wbcs=; b=kkgf964oa7jkEbAPaxIw+eB7CnTrPrpjz6us7Qcr
	+FbgGWIflQnYdI5iW0RtNdz+od2nphnzOmgI2Eat5WdfYjtLZOGjz1BgQpI+n93V
	FfYbl09yvJepz9SPQOrdimTtpFLgd31QTqt+tY0LKe5UCkkX4Xl5i/SywG5HvNbL
	wJmNKvA6jGvh3d+lupwZSCiSeX0o2+16t7S7V5AflR590DBskfz3htTQHLEun48q
	WCCXfOWb7NOEuhayI7TLNGFRkAY8jodlge87/o45c8AVfKTvt84NRdH8wMydL/rK
	/3Yyw09eQPgZXF4PpphUjz0kxujUUdSK4P9nCUDDIiUEKw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6thxmqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:18:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b1292b00cfso48672311cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756160310; x=1756765110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ie393XGfhaHZ0Us6yXgzMFwLUpvRvDwsjf8xQ5Wbcs=;
        b=h39uBGOtoh6L7zc9Wwr/SrwY3WDUXXbxp/m0qU59m8FsfG4rayOYyB3vWpWx8X9JAP
         m1v6v5eEEDImGXeZSwUu93raKe/jucL0N5QYR9UT2gOUyT29s1MgpvomIw7hoiIi9tV/
         IhwcxxUpxaHH8TfbXGYG8u1fehlppMTCesf7crineEptCsdjU+tcFCuuHwGbAHtBMlZW
         4UQRQZIcgbZI4HXYodcMMEAK8T4HkvK/nGkugxDr8Em9DoMslxTFbYfq53CovovOTwwH
         aMr8XN1UXUYyFnp0ngbuNUIruvpaBHxzTPfNZWKxXLGAQT4nK+lU2FcE7GDCDK0iDEPX
         T9qw==
X-Forwarded-Encrypted: i=1; AJvYcCU4chU/ZOSFflE32EDb7DDjbkFHpSzM20LkcVglEemuIVbOPScHKf4i93ZmwLeKdLkwf4D5amqzqKngreI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuLm5qr6IoldIRDCT7D1pzDEDF4h1371bsQRR6VaaZyC4hlzXk
	hSAl4rOg8K40UfX3sAztiIfU/n056muapO2xtN3JfKI6oMMPxeyPKmzp2vs2xxDASQNVW4APfWK
	Khp/JJtIYvq9Xl3aHwIEqNSD/NlHYzgGF7Lg3mXjUj336VZsEm3e/8B82ECGEwpCpics=
X-Gm-Gg: ASbGnctUmxGtmZd4Y4Cepeu6mxObevjVKpb3nPfyOngUopleaAfcBgWZPk6JQnwxcCj
	1yNbsPTmGV3P5ShDAP2oNSYJ3Bd+0bAleiQTmcVyLtjw/TPZAAnp4DelRV02ZXSn9hUxo/PGBoC
	4qxYEPJURGQsj9BBqoIuz2UPsj93k1DdbOvB0j4JjhDMUYOrQrv9tWp2kaRfTLqVpT7Ftehq+vK
	nqJiB8vkFLvag78BxunOjDsB1wV6KAp4T1gBvLtyzTF/5uu4KHSuZnmWNEg5bxPs1sAr8ZHEVH6
	lDv4NQDkZAf/z4Ku9s6KynZgFtEodRtrjVRXNEP91HxIs6holJcFPZROY2jKvIWEQIJNBJ6SBfq
	JsSb3iFbBI6Jct/EMc8ZCRZMnQgudnQRpr3fu/yzDCEvGkTP7jsyZ
X-Received: by 2002:a05:622a:494:b0:4b0:8eb3:7c9e with SMTP id d75a77b69052e-4b2aaa9507emr138550751cf.36.1756160310218;
        Mon, 25 Aug 2025 15:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwgt1vEz2gXMrLQpWwvX6melW5EcGvji+K/cgoy8aqU+Ga0jrWISvg+KVNNOXH4k4qNO/GkQ==
X-Received: by 2002:a05:622a:494:b0:4b0:8eb3:7c9e with SMTP id d75a77b69052e-4b2aaa9507emr138550331cf.36.1756160309464;
        Mon, 25 Aug 2025 15:18:29 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f3fe78b1fsm1327329e87.134.2025.08.25.15.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 15:18:28 -0700 (PDT)
Date: Tue, 26 Aug 2025 01:18:26 +0300
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
Subject: Re: [PATCH v3 23/38] drm/msm/dp: abstract out the dp_display stream
 helpers to accept a panel
Message-ID: <f6y7h2nikuqedo64nqzh27fjteyyvndfeqakqw3ce2cvcz4v7s@jmpwlgoqsw3i>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-23-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-23-01faacfcdedd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0MyBTYWx0ZWRfX422tNRy7G+q+
 PSZLSTq1NtbIa/vU0RfI/CgVioH8GibexVrBzQN8obYkO78CkcgXVpdCXSZ74x5HtWBEIld43Yx
 74jpc+mjfXNx4dLZKzLph3eEGmVCHetLHpkSdyzH8a1u6ETaCyXbPiVL+KwtON6zmO48JnuFsiS
 chbinmLQ0vFhKvzvf5MSeyCKmpPWrb8X9OBdRclnArAkosKA/JfaZupkeBEOcEwCs4lGxwUwxcG
 tFNp3LMZlL9pF2ehygUaIJnZMcc3NnBZNIygQQl+dWSpAGb9raZe55omc3lH0VO/VoxijnzC02f
 6DSi4aHRu3CmusNqfDWiU1lz1ZOcfC6R29gfj17Lw+FBZoHv2H4CODDEUs7/FiI1NWH1XSgSfkz
 PDsTU3Xd
X-Proofpoint-ORIG-GUID: yEysbmkdBUNC0mDJht1tXak65XimWfPl
X-Proofpoint-GUID: yEysbmkdBUNC0mDJht1tXak65XimWfPl
X-Authority-Analysis: v=2.4 cv=W544VQWk c=1 sm=1 tr=0 ts=68ace138 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=8K8LDW8wUMBAfiAu:21 a=xqWC_Br6kY4A:10
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=8-mp4fwYeUK2sr-pB3oA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_10,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230043

On Mon, Aug 25, 2025 at 10:16:09PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Currently the dp_display bridge helpers, in particular the
> dp_display_enable()/dp_display_disable() use the cached panel.
> To be able to re-use these helpers for MST use-case abstract the
> helpers to use the panel which is passed in to them.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 138 +++++++++++++++++++++++-------------
>  drivers/gpu/drm/msm/dp/dp_display.h |  12 ++++
>  2 files changed, 102 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index e02ada7a3dc3b89618aeadd998e9a41236ee6bbf..0815973e6597492e09f33359d9777c0e8ce31e0d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -695,6 +695,11 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
>  
>  	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
>  
> +	if (msm_dp_display->prepared) {

Why is it a part of this patch?

> +		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
> +		return 0;
> +	}
> +
>  	rc = pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
>  	if (rc) {
>  		DRM_ERROR("failed to pm_runtime_resume\n");
> @@ -722,7 +727,8 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
>  	return rc;
>  }
>  
> -static int msm_dp_display_enable(struct msm_dp_display_private *dp)
> +static int msm_dp_display_enable(struct msm_dp_display_private *dp,
> +				 struct msm_dp_panel *msm_dp_panel)

These changes look fine, but they raise an interesting question: should
we rework the interface, making the msm_dp_panel the top-level object,
which then controls the ctrl, link, etc.?

>  {
>  	int rc = 0;
>  	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
> @@ -733,7 +739,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
>  		return 0;
>  	}
>  
> -	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel, dp->max_stream);
> +	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, dp->max_stream);
>  	if (!rc)
>  		msm_dp_display->power_on = true;
>  
> @@ -779,37 +785,17 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
>  	msm_dp_display->audio_enabled = false;
>  }
>  
> -static int msm_dp_display_disable(struct msm_dp_display_private *dp)
> +static int msm_dp_display_disable(struct msm_dp_display_private *dp,
> +				  struct msm_dp_panel *msm_dp_panel)
>  {
>  	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
>  
>  	if (!msm_dp_display->power_on)
>  		return 0;
>  
> -	msm_dp_panel_disable_vsc_sdp(dp->panel);
> +	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
>  
> -	/* dongle is still connected but sinks are disconnected */
> -	if (dp->link->sink_count == 0) {
> -		/*
> -		 * irq_hpd with sink_count = 0
> -		 * hdmi unplugged out of dongle
> -		 */
> -
> -		/* set dongle to D3 (power off) mode */
> -		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> -		msm_dp_ctrl_off_pixel_clk(dp->ctrl, dp->panel->stream_id);
> -		msm_dp_ctrl_off_link(dp->ctrl);
> -		/* re-init the PHY so that we can listen to Dongle disconnect */
> -		msm_dp_ctrl_reinit_phy(dp->ctrl);
> -	} else {
> -		/*
> -		 * unplugged interrupt
> -		 * dongle unplugged out of DUT
> -		 */
> -		msm_dp_ctrl_off_pixel_clk(dp->ctrl, dp->panel->stream_id);
> -		msm_dp_ctrl_off_link(dp->ctrl);
> -		msm_dp_display_host_phy_exit(dp);
> -	}
> +	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);

This doesn't seems to be a part of this patch. Maybe move it to the
previous patch, reworking this piece of code?

>  
>  	msm_dp_display->power_on = false;
>  
> @@ -1538,52 +1524,90 @@ void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display)
>  	return;
>  }
>  
> -void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
> +void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display, struct msm_dp_panel *msm_dp_panel)
>  {
>  	struct msm_dp_display_private *dp;
>  	int rc = 0;
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0, 0, 0);
> -

Please, don't mix different kinds of refactoring. You've promised to
bring in msm_dp_panel as an argument, but then you are also
restructuring functions. Try making your changes more logical or atomic.

>  	if (msm_dp_display->prepared) {
> -		rc = msm_dp_display_enable(dp);
> +		rc = msm_dp_display_enable(dp, msm_dp_panel);
>  		if (rc)
>  			DRM_ERROR("DP display enable failed, rc=%d\n", rc);
>  
>  		rc = msm_dp_display_post_enable(msm_dp_display);
>  		if (rc) {
>  			DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
> -			msm_dp_display_disable(dp);
> +			msm_dp_display_disable(dp, msm_dp_panel);
>  		}
>  	}
>  
>  	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
>  }
>  
> -void msm_dp_display_atomic_disable(struct msm_dp *msm_dp_display)
> +void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
>  {
>  	struct msm_dp_display_private *dp;
>  
>  	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
>  
> -	msm_dp_ctrl_push_idle(dp->ctrl, dp->panel);
> +	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0, 0, 0);
> +
> +	msm_dp_display_enable_helper(msm_dp_display, dp->panel);
> +}
> +
> +void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
> +				   struct msm_dp_panel *msm_dp_panel)
> +{
> +	struct msm_dp_display_private *dp;
> +
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	msm_dp_ctrl_push_idle(dp->ctrl, msm_dp_panel);
>  	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl,
>  		dp->max_stream);
>  	msm_dp_ctrl_mst_send_act(dp->ctrl);
>  }
>  
> -static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
> +void msm_dp_display_atomic_disable(struct msm_dp *msm_dp_display)
>  {
> -	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
> +	struct msm_dp_display_private *dp;
> +
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	msm_dp_display_disable_helper(msm_dp_display, dp->panel);
> +}
> +
> +void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
> +{
> +	struct msm_dp_display_private *dp;
> +
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	if (!msm_dp_display->prepared) {
> +		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
> +		return;
> +	}
> +
> +	/* dongle is still connected but sinks are disconnected */
> +	if (dp->link->sink_count == 0)
> +		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
> +
> +	msm_dp_ctrl_off_link(dp->ctrl);
> +
> +	/* re-init the PHY so that we can listen to Dongle disconnect */
> +	if (dp->link->sink_count == 0)
> +		msm_dp_ctrl_reinit_phy(dp->ctrl);
> +	else
> +		msm_dp_display_host_phy_exit(dp);
>  
>  	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
>  
>  	msm_dp_display->prepared = false;
>  }
>  
> -void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
> +void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
>  {
>  	struct msm_dp_display_private *msm_dp_display;
>  
> @@ -1597,28 +1621,46 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
>  
>  	msm_dp_display_audio_notify_disable(msm_dp_display);
>  
> -	msm_dp_display_disable(msm_dp_display);
> +	msm_dp_display_disable(msm_dp_display, msm_dp_panel);
> +
> +	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
> +}
> +
> +void msm_dp_display_atomic_post_disable(struct msm_dp *msm_dp_display)
> +{
> +	struct msm_dp_display_private *dp;
> +
> +	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
> +
> +	msm_dp_display_atomic_post_disable_helper(msm_dp_display, dp->panel);
>  
>  	msm_dp_display_unprepare(msm_dp_display);
> +}
>  
> -	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
> +void msm_dp_display_mode_set_helper(struct msm_dp *msm_dp,
> +				    const struct drm_display_mode *mode,
> +				    const struct drm_display_mode *adjusted_mode,
> +				    struct msm_dp_panel *msm_dp_panel)
> +{
> +	struct msm_dp_display_private *dp;
> +
> +	dp = container_of(msm_dp, struct msm_dp_display_private, msm_dp_display);
> +
> +	msm_dp_display_set_mode(msm_dp, adjusted_mode, msm_dp_panel);
> +	/* populate wide_bus_support to different layers */
> +	dp->ctrl->wide_bus_en = msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ?
> +		false : dp->wide_bus_supported;
>  }
>  
> -void msm_dp_display_mode_set(struct msm_dp *dp,
> +void msm_dp_display_mode_set(struct msm_dp *msm_dp,
>  			     const struct drm_display_mode *mode,
>  			     const struct drm_display_mode *adjusted_mode)
>  {
> -	struct msm_dp_display_private *msm_dp_display;
> -	struct msm_dp_panel *msm_dp_panel;
> -
> -	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
> -	msm_dp_panel = msm_dp_display->panel;
> +	struct msm_dp_display_private *dp;
>  
> -	msm_dp_display_set_mode(dp, adjusted_mode, msm_dp_panel);
> +	dp = container_of(msm_dp, struct msm_dp_display_private, msm_dp_display);
>  
> -	/* populate wide_bus_support to different layers */
> -	msm_dp_display->ctrl->wide_bus_en = msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 ?
> -		false : msm_dp_display->wide_bus_supported;
> +	msm_dp_display_mode_set_helper(msm_dp, mode, adjusted_mode, dp->panel);
>  }
>  
>  void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge)
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index fa92f763d2304f15af7c4e1e7e8aab5a6ffd3459..20b7ed735b3f428e894b82ae2756d0efcfa47624 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -51,5 +51,17 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
>  int msm_dp_display_set_stream_info(struct msm_dp *dp_display, struct msm_dp_panel *panel,
>  				   enum msm_dp_stream_id stream_id,
>  				   u32 start_slot, u32 num_slots, u32 pbn, int vcpi);
> +void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
> +				  struct msm_dp_panel *msm_dp_panel);
> +void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
> +				   struct msm_dp_panel *msm_dp_panel);
> +void msm_dp_display_mode_set_helper(struct msm_dp *msm_dp_display,
> +				    const struct drm_display_mode *mode,
> +				    const struct drm_display_mode *adjusted_mode,
> +				    struct msm_dp_panel *msm_dp_panel);
> +void msm_dp_display_atomic_post_disable_helper(struct msm_dp *msm_dp_display,
> +					       struct msm_dp_panel *msm_dp_panel);
> +
> +void msm_dp_display_unprepare(struct msm_dp *dp);
>  
>  #endif /* _DP_DISPLAY_H_ */
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

