Return-Path: <linux-kernel+bounces-729919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1345AB03D93
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D5E189C723
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38F024728D;
	Mon, 14 Jul 2025 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hw45MD5a"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A8246BC7
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752493385; cv=none; b=tDLohLDGCieRMt14GrwMJcruTyA+yI92xAmdOPMZv6u6jrGd8Tmsak7Ygvnw/f1j+25+wYwP6+MEXebVoSC9wfnJmlrf2oPmZe4weHZpQXksu6relmSPhVaW0j/hyBXSNBcbuqz0rZFDDxZN+2TxRtTENJSaL8DEtnDNJAvg79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752493385; c=relaxed/simple;
	bh=9P7/K4l68JVMwkyF6KMKV0NtEpx6DPPOxrt7Lb8OKQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQxBhDIofWONUSvAuodSaXpR+cRdqYI2UUBD7MNeXsF9YDVH15uG9OaDXPwNqhh1fk/x9wSndpBSj2WlUj2UgjqkY8KGtprywlmflZqMRc21OtsZaA/6PzCBj8o3uHzsmgh4WxNrfUM31f86+03tYaQQpRmOXVGNUzfCgEqyGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hw45MD5a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9jpED022925
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=winGaSM/18oanJNdTZV+PwIP
	QLMxfMBvR22zaRLbI78=; b=hw45MD5adSzrjU01I8Y6dZs+DYpW4+Inzta7Hv86
	THBnn/KYjBHJ/v4JApAIIlQjbXPrglJ902rt18N45A9F+L5TJmAl9LSM8is9bV3N
	jwlKzLHX+1Di3KhmLr1IP0OuazbNdfkysrhZBgJWO+mSNLHtQQNovCApfRq191yJ
	RlPHrBoUCgUoQ4J9ciOyQxjHn0s8WcKVEBIKZWAAFNmU60n7A0SelM3THJHMd67U
	+dcmvNqpYg1WZ7Pjxb4ftWItpWO8rZGx/kDypONQ6tGx/vuWACiVSsmRAuTqEGVx
	tl1bNyRrqSa74/7YgRo7bXhftpyhlFNiU9G16x2eSAHU+g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxavjds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 11:43:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c5bb68b386so1287230585a.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 04:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752493381; x=1753098181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=winGaSM/18oanJNdTZV+PwIPQLMxfMBvR22zaRLbI78=;
        b=kv5GB4vOygaHiTyoY5CfmsZsR4gJXUiAdtyo0PIkFuVweas3R4D/wHc9pQeGPW6RVN
         mpuIU34igIG9WG/wTAQ7B8Qv3Mzm1i8sRRIdFrM69XKjOE8dbIciSOexF5mIkwT+s4Po
         7xMgCuRFzagp718TIYYkPMr2oUxjzuT620Q/a+IvTnZeozQtoslDxy1f30g+a1VKw01W
         wBUh9UO+oCXNTPBRF6/Am75eVshtXL5gVXCBteVGTB1Kv23YQ3/EzsObTG1IIqEky4mD
         zsDaEJyk8616fiUe+ytHMfB77HlZ0esZrPr+08WKRJ1ydUA5lxb+D7edbjsZvBnJW4Fe
         HJog==
X-Forwarded-Encrypted: i=1; AJvYcCXQ9GO13yoXl0DpgUcywJ4SR3YOnVH6L1v9SF0t5+VuUmiQ14xM9Btk+PuF/m9JzDNfB16i7tPr3qDAmAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS5WUWak24fpPghXaWbEVqAbePueI5A4Twbgn/CCYDGoL4SD1/
	SwTk0JHcnI3N3/YQ3DvzRgwBBpFsvERUPB4tbY4EUb9DK4Z0pHH3AcmkWGOR7mXzubOvbPoLdZj
	lnUq0WFPx32hYjuaHnNkhL6in+O9BYsllGZ6SKejmFUah4rLALrTw7fPn8PSVVj1fc90=
X-Gm-Gg: ASbGncuqCmyb19Bjo1PJPjRa96WtKLVRqd5NFP03EW7DmP2NXZbsRm+3d6R9nsTjQe7
	R80R6u7kv9Ub22mpkMIZy5OGYc4u+i8+x8gWNq1ZWTI5fT7Dn0TiJs6mq5nw7RnHKrF/9Zsnsoj
	jN1iIFH11MofvRaAWSYn/j+1mWRwIqnbUeHsIbfslPx/EZz8HqrPRUhqf/rI9wiC2mC4ddh4Mg0
	e+tyA4IUp04A0KbVFVRPjA4JpnIE3zOiGrX3DJ28zF7MmMjUuYYlDr8JMO2YNz1H6m8q8JUT6fw
	qgHlimQyopy40KFbLu3waw955CsRaQ//RbmLRzCmH8gLb9wlKRsJZ8bluf/2UTd38dwwJ25Fkdx
	OG74SfAv2CgBc7ELXC4e9u9mXUtWuo75cLfuw1FQE7OolKBaduAqy
X-Received: by 2002:a05:620a:4113:b0:7d4:3de6:b4fa with SMTP id af79cd13be357-7ddea7159demr1547497885a.20.1752493380996;
        Mon, 14 Jul 2025 04:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1ANcTVbh2OL/XbOiKu39H2wmW7FN3jGWrVAYORjESiyqWa4YcIdnDQxG+JWuz1xF0P2+GMg==
X-Received: by 2002:a05:620a:4113:b0:7d4:3de6:b4fa with SMTP id af79cd13be357-7ddea7159demr1547493685a.20.1752493380450;
        Mon, 14 Jul 2025 04:43:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fab8bd4a8sm15926061fa.65.2025.07.14.04.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 04:42:59 -0700 (PDT)
Date: Mon, 14 Jul 2025 14:42:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>
Subject: Re: [PATCH 01/19] drm/msm/dp: Track when DP is physically plugged in
Message-ID: <ytskndhnox6p2ozwqxnpfyj7d4finr2go7qih4hpjqaf6onigc@zhiunxyw6xaa>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
 <20250711-hpd-refactor-v1-1-33cbac823f34@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711-hpd-refactor-v1-1-33cbac823f34@oss.qualcomm.com>
X-Proofpoint-GUID: Ao1ssDDOM0io42OT2bldUqClwVtiQVJr
X-Proofpoint-ORIG-GUID: Ao1ssDDOM0io42OT2bldUqClwVtiQVJr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA2OCBTYWx0ZWRfXxi+Q1vDmYEY2
 06cj9otmyFZ8Jvd7XQb5piZHwSdlOJPS/hAriCLy87xq3e0dhesxS87XWwFn/XtRz6JracfdzO1
 ZUnhIcLyG317GE0xFdmJI/JpJbvpmHglUgcw1ipCeDNVAf9RyfMQT5KqwxzSO8F+Jln4ZpWo7/d
 7yDCos5c0EzqINM3Xa/GbU3AM26kr/o59t0rIabs1V/wh7su2SvcAwBaYAxgeUFWOuK9QB0BrvR
 AN4LWxZtFbpcs4aJn5U9tck4nQcvJo0GFSGQnFOYYqSknMQ0WTrQOL7ZKic+j6aXsNdc+0hUnpw
 8YyfEVK9ARZadrNg0m1UuKAVOn6dhlTctpMA5sruoTI4/MUhzIf96Ppt+31Bn+WZCfbxnfwN5ef
 /2f9hbtdAFFx1vPUUWI8sIfdflWdvsBL7AO4NH5qYWOqP3Vfzr/gBJFXxdKHKBEzmmIHQWiV
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=6874ed45 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=cYTOvpCF5i-df0i3KWcA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140068

On Fri, Jul 11, 2025 at 05:58:06PM -0700, Jessica Zhang wrote:
> Add a boolean to track whether the DP cable is physically plugged in.

I think there is more than that. Other drivers check that there is
actually something connected (so checking the sink count, etc.). See
Mediatek or IT6505 drivers, they have simple examples.

> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 11 ++++++++++-
>  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index d87d47cc7ec3..6945df782f7b 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -531,6 +531,7 @@ static int msm_dp_display_handle_port_status_changed(struct msm_dp_display_priva
>  			rc = msm_dp_display_process_hpd_high(dp);
>  			if (rc)
>  				dp->hpd_state = ST_DISCONNECTED;
> +			dp->msm_dp_display.connected = true;
>  		}
>  	}
>  
> @@ -604,6 +605,8 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
>  		return 0;
>  	}
>  
> +	dp->msm_dp_display.connected = true;
> +
>  	if (state == ST_DISCONNECT_PENDING) {
>  		/* wait until ST_DISCONNECTED */
>  		msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 1); /* delay = 1 */
> @@ -621,6 +624,7 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp, u32 data)
>  	ret = msm_dp_display_usbpd_configure_cb(&pdev->dev);
>  	if (ret) {	/* link train failed */
>  		dp->hpd_state = ST_DISCONNECTED;
> +		dp->msm_dp_display.connected = false;
>  		pm_runtime_put_sync(&pdev->dev);
>  	} else {
>  		dp->hpd_state = ST_MAINLINK_READY;
> @@ -662,6 +666,8 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
>  	drm_dbg_dp(dp->drm_dev, "Before, type=%d hpd_state=%d\n",
>  			dp->msm_dp_display.connector_type, state);
>  
> +	dp->msm_dp_display.connected = false;
> +
>  	/* unplugged, no more irq_hpd handle */
>  	msm_dp_del_event(dp, EV_IRQ_HPD_INT);
>  
> @@ -680,6 +686,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp, u32 data)
>  		msm_dp_ctrl_off_link(dp->ctrl);
>  		msm_dp_display_host_phy_exit(dp);
>  		dp->hpd_state = ST_DISCONNECTED;
> +		dp->msm_dp_display.connected = false;
>  		msm_dp_display_notify_disconnect(&dp->msm_dp_display.pdev->dev);
>  		pm_runtime_put_sync(&pdev->dev);
>  		mutex_unlock(&dp->event_mutex);
> @@ -1596,8 +1603,10 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
>  		return;
>  	}
>  
> -	if (dp->is_edp)
> +	if (dp->is_edp) {
>  		msm_dp_hpd_plug_handle(msm_dp_display, 0);
> +		dp->connected = true;
> +	}

So, are we returning 'disconnected' for eDP panels up to the
atomic_enable() point? Then nobody will ever enable it.

>  
>  	mutex_lock(&msm_dp_display->event_mutex);
>  	if (pm_runtime_resume_and_get(&dp->pdev->dev)) {
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
> index cc6e2cab36e9..68bd8be19463 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.h
> +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> @@ -16,6 +16,7 @@ struct msm_dp {
>  	struct platform_device *pdev;
>  	struct drm_connector *connector;
>  	struct drm_bridge *next_bridge;
> +	bool connected;
>  	bool link_ready;
>  	bool audio_enabled;
>  	bool power_on;
> 
> -- 
> 2.50.1
> 

-- 
With best wishes
Dmitry

