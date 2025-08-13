Return-Path: <linux-kernel+bounces-766734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4755DB24A79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C756189DD45
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A32E718A;
	Wed, 13 Aug 2025 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PmO/5kWk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0CE2D063C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091218; cv=none; b=ae4foOX5Rx17PD7WPOE4S1kWZ7yw0EdOM7qIjhm68jkJTjCDQc1QkHz6QE2ggFPPOvzmJxak67ZL+KebCQAkDXHNmCK6Mc9FoYTzORh63lVXE4L5+EfkKpWmTLWRmXA6wtWTXkRlkynxD+GAmdAhugwKGM09dctfp/KCWlsqkg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091218; c=relaxed/simple;
	bh=cF4J2KzPJYVx4GX3+biAZIlpuzUEplvCKRsyEe1kEXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojL+t4PHM1R5OJucPG+mq3zGjI6X6oBEZh/afbHttp7WRCdUO2KFf30SMzpgkUF4eBqXZoLnZo3p1TQ9rSFQKLo3TCOcYJtl7gNtxaD+k30ruQzyQ2PdOpI47Fau9p61G3uy9ysKuEAEz6/Y4ZfpC7cTyv6EjRsK14oUCRnQxHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PmO/5kWk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DBM2rE024302
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ooSdKgrdAgny5Oon5I/uo/G4
	MrpVcka6ZVCJKKfgn6Y=; b=PmO/5kWk6tBtmKQ5pWu/b3fKp3TivHNR/Ej2mrWt
	OLlbeqblHYZN7ZWma7668t2n1zOxBHD/IfBeGDcWLbi2aXPoG3TchLGw0cOszZI6
	LcbwtSo1lTzrbEiXSsGLy5z7T/s6rOQU6ucRizqDEPu8Q6Fd+oaCodnaS+7jNeHA
	d8Mcmkx81FbgrPdfEdoSGz3MLLcX6wMBy42Lo/BxPLGsEMpNJ3u+Wik1Z5aVdM2q
	3mB9Jr+jwWM8bV9ckv3wBZH2gntnrqxkW5Xpam0U53BVeTZiosfJ+J0/CjkyceAq
	TUlGgdGyvuQEDT0Oj08aZBmhkwU7k1sIGInSbrJIHet4yg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48gr9rrjea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:20:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b076528c4aso73555131cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755091214; x=1755696014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooSdKgrdAgny5Oon5I/uo/G4MrpVcka6ZVCJKKfgn6Y=;
        b=s2Ya/VZomXMkE7598CjNlyah0OGpWYtbvCfBH/sd/u5V9S/6RDWhadDXh8tBf+ocHc
         EW3x60kWaYwJLH8FNFJL9c/u3ov0wXX4dPuHquK8i87v47AQ9xyz+oUMn9cPAX79RvHz
         95fLGPoWCP3Wmk2pjwUkcUId0kV3u7ruHtJ+tSa3p9H6dNXaFx+n45eA+mrDh+YdOSLL
         MZmVICOlq3btm77eF4LVGrbP1ZPZ1KrzhIH8AhEqAg5TrohdYGZ1cPU0XjnfxyUauJ/q
         b5xfpLXT7pB07AvcUaKMafQMmd2qCjwnPj3xfGfq/pbBfvz7m6KEeNkam83JgXN2eFAa
         +Xlw==
X-Forwarded-Encrypted: i=1; AJvYcCV0I1XAJ7RV8+Zdi0q3zsjk+Vqx4eD+aVYrI0GKjKYbPZ0Bq1Cm3+YYG4nfvPI4D7mIIbLAsa4xhNWyh9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR+JHEfM96ordIOfvqBxSveLZTqtfiawS2EPkI2ofvLzvVUc4D
	eSmyu7lhTuYCVSqcCxOhOchK+a3WJ9Oag/0wlLrdb+3TaaEGOE+4C2dA1gvgzaoKOB65SH3PL0t
	gVQsrze+FxNxFxLpX25pd37f6wuDU9nRfpRHf3VMNxmkWE/mjjzAHMf/w8c8sagW6shA=
X-Gm-Gg: ASbGncuxPQoig67/q76eppfEeZMqa8Crd5XyXMPQq3LuXA7JBdHdOtWV2u+y+u8Husz
	bAu44ubQuaJKZ9P0D2x4rc/yJYivMmkvktMKLM8vQJmWFVHP6FmujabpHMPeZEqcS4arh6iAAWL
	5eqJgokGEDEsmBhDxD723D6aDpME1287QQ/HhwtLBa97tANoqAsRuuFgUXjKZ2VPfpq+7PKEpZk
	mC/hcA1HgrNB7EHlBR4DzKNZjRMZPw1KAo02jFeuOCuYYzvSSF3lAGHvr08do2jHPMV/FjRrHob
	4ur/V3IjdF1BTl9Yfqg9Fa1WDUT/s095/JdVJcAeawjQodS5eMbJDvkYl1pWTUVDuYytAULpPBG
	mP1cxIuOTzzd8bNTMSpxV6SmL/2PZ1HQ15m1hyH1wSqggBMpfTx/F
X-Received: by 2002:ac8:7fcf:0:b0:4b0:8e2e:fd9b with SMTP id d75a77b69052e-4b0fc84c7a9mr36983561cf.28.1755091213878;
        Wed, 13 Aug 2025 06:20:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDgDle1InGMOPuybwxLgieUskJGHH8XuVVqbrHQglZjmc8+Qkb0eXHtL9wdmFlYAQFWpnA2Q==
X-Received: by 2002:ac8:7fcf:0:b0:4b0:8e2e:fd9b with SMTP id d75a77b69052e-4b0fc84c7a9mr36982741cf.28.1755091213183;
        Wed, 13 Aug 2025 06:20:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ac575sm5248951e87.69.2025.08.13.06.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:20:12 -0700 (PDT)
Date: Wed, 13 Aug 2025 16:20:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <quic_yongmou@quicinc.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v2 05/38] drm/msm/dp: allow dp_ctrl stream APIs to use
 any panel passed to it
Message-ID: <6fz5vmolnzg2ccye7b7znqj3lit67mxin6wthf4tsiujtrnkjz@wg5ib77x3ith>
References: <20250609-msm-dp-mst-v2-0-a54d8902a23d@quicinc.com>
 <20250609-msm-dp-mst-v2-5-a54d8902a23d@quicinc.com>
 <5emeno6zpefewmysmmfb6s64mme32pzatgpzeu6hnuzgfi3q4t@i6zpgj5am3ie>
 <61834162-7e73-4467-9dd7-bfb1dcbd0afb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61834162-7e73-4467-9dd7-bfb1dcbd0afb@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5NCBTYWx0ZWRfX/ac/eskQekIl
 YZhFL2abE5B+xSL85YQyigfuLIc0SCcg+03bbAQRasux7tt7MZFHgCzPam0LpMNcQUft0qz8hWy
 h2OmS7QpN3HovOSPs28GGl+IQvZBMeR48shFtnoFcQuQRDQtP17KcoaxvcTVL29wnANlYwk2tEp
 hY3e3qA9MCnAjxyWnaKdyV/fKrXwQioBc5PZFAq4OzfrdcsVsTh6unZAiZsOwC7VDhb3z0qfh10
 AgspTqojGFDhF4HDxibu0osBk5RG4OTS5VHUGPPZPhDESwe/D20eZt9kM2mhFe8YnuQuNtYt2Uw
 xKzWsGmv7O4MzVV/09t7KNpuhKJzV2H04dQ9KZMUKcFzrIytuCXxPclaEm3qVuLwbC8EcTr1FBP
 8H/+2iCB
X-Authority-Analysis: v=2.4 cv=NIrV+16g c=1 sm=1 tr=0 ts=689c910f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=eaxZvfGbl-QS4wH2Ez8A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: F5bglOD7vfWlKLOaI8k2ewxDA4-5Lx8D
X-Proofpoint-GUID: F5bglOD7vfWlKLOaI8k2ewxDA4-5Lx8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508130094

On Wed, Aug 13, 2025 at 05:52:04PM +0800, Yongxing Mou wrote:
> 
> 
> On 2025/6/9 21:12, Dmitry Baryshkov wrote:
> > On Mon, Jun 09, 2025 at 08:21:24PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Currently, the dp_ctrl stream APIs operate on their own dp_panel
> > > which is cached inside the dp_ctrl's private struct. However with MST,
> > > the cached panel represents the fixed link and not the sinks which
> > > are hotplugged. Allow the stream related APIs to work on the panel
> > > which is passed to them rather than the cached one. For SST cases,
> > > this shall continue to use the cached dp_panel.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.c    | 37 ++++++++++++++++++++-----------------
> > >   drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 +++--
> > >   drivers/gpu/drm/msm/dp/dp_display.c |  4 ++--
> > >   3 files changed, 25 insertions(+), 21 deletions(-)
> > 
> > I think previous review comments got ignored. Please step back and
> > review them. Maybe I should ask you to go back to v1 and actually check
> > all the review comments there?
> > 
> Sorry for that.. i will check all the comments again.. thanks
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > index 1ce3cca121d0c56b493e282c76eb9202371564cf..aee8e37655812439dfb65ae90ccb61b14e6e261f 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> > > @@ -135,7 +135,8 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
> > >   	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
> > >   }
> > > -static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
> > > +static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl,
> > > +				    struct msm_dp_panel *msm_dp_panel)
> > >   {
> > >   	u32 config = 0, tbd;
> > >   	const u8 *dpcd = ctrl->panel->dpcd;
> > > @@ -143,7 +144,7 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
> > >   	/* Default-> LSCLK DIV: 1/4 LCLK  */
> > >   	config |= (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);
> > > -	if (ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
> > > +	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
> > >   		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
> > >   	/* Scrambler reset enable */
> > > @@ -151,7 +152,7 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
> > >   		config |= DP_CONFIGURATION_CTRL_ASSR;
> > >   	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
> > > -			ctrl->panel->msm_dp_mode.bpp);
> > > +			msm_dp_panel->msm_dp_mode.bpp);
> > >   	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
> > > @@ -174,20 +175,21 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
> > >   	msm_dp_catalog_ctrl_config_ctrl(ctrl->catalog, config);
> > >   }
> > > -static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
> > > +static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl,
> > > +						struct msm_dp_panel *msm_dp_panel)
> > >   {
> > >   	u32 cc, tb;
> > >   	msm_dp_catalog_ctrl_lane_mapping(ctrl->catalog);
> > >   	msm_dp_catalog_setup_peripheral_flush(ctrl->catalog);
> > > -	msm_dp_ctrl_config_ctrl(ctrl);
> > > +	msm_dp_ctrl_config_ctrl(ctrl, msm_dp_panel);
> > >   	tb = msm_dp_link_get_test_bits_depth(ctrl->link,
> > > -		ctrl->panel->msm_dp_mode.bpp);
> > > +		msm_dp_panel->msm_dp_mode.bpp);
> > >   	cc = msm_dp_link_get_colorimetry_config(ctrl->link);
> > >   	msm_dp_catalog_ctrl_config_misc(ctrl->catalog, cc, tb);
> > > -	msm_dp_panel_timing_cfg(ctrl->panel);
> > > +	msm_dp_panel_timing_cfg(msm_dp_panel);
> > >   }
> > >   /*
> > > @@ -1317,7 +1319,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
> > >   	u8 assr;
> > >   	struct msm_dp_link_info link_info = {0};
> > > -	msm_dp_ctrl_config_ctrl(ctrl);
> > > +	msm_dp_ctrl_config_ctrl(ctrl, ctrl->panel);
> > 
> > Could you please explain, when is it fine to use ctrl->panel and when it
> > is not? Here you are passing msm_dp_panel to configure DP link for link
> > training. I don't think we need the panel for that, so just using
> > ctrl->panel here is incorrect too.
> > 
> Emm, If we need to program registers related to the pixel clock or DP link
> with MST(all of them need pass the stream_id to determine the register
> address), we should pass in msm_dp_panel. If we're only programming the
> other parts not related to the stream_id, passing in ctrl->panel is
> sufficient.

What is stored in ctrl->panel in the MST case? Can we split it into the
link and sink parts? E.g. dpcd or downstream_ports are not a part of the
panel itself. They describe a link between DPTX and DPRX.

Downstream_ports might be even more fun. How do we support MST hub being
connected through another MST hub?

> here in link tranning, it's right, we actually don't need to pass in the
> panel. But since in msm_dp_ctrl_config_ctrl, we will write config to DP0/DP1
> CONFIGURATION_CTRL, even mst2/mst3 link CONFIGURATION_CTRL. and this func
> will also been called in msm_dp_ctrl_configure_source_params. so we need add
> ctrl->panel here.

I'd prefer a cleaner interface here. Could you please separate
stream-dependent and stream-independent parts?

> > >   	link_info.num_lanes = ctrl->link->link_params.num_lanes;
> > >   	link_info.rate = ctrl->link->link_params.rate;

-- 
With best wishes
Dmitry

