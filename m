Return-Path: <linux-kernel+bounces-754089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0428EB18DEF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 12:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B34176304
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 10:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D14E203710;
	Sat,  2 Aug 2025 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M8IKCKUD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF02A920
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754129940; cv=none; b=jlG2ghQC93db1SzxyvCPwTnCFxzAWG6izcwZVExCFzCX7+bIeCyWvOwqgKjVggMr76kB9B8uKTDVTzJXqTrA8AcLTSscbW2X3xVLQLwSVgjtpZTQ/RQKMLxtmGpN+/0s1H4436kQiQClPHqPPpxklvc5pzulAq6vZ6croDGuVXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754129940; c=relaxed/simple;
	bh=Ty1Aj8UW1lb41nlnRREZ4XSqRuhEMNXjZ+eJbc2HABc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tn9a0/O2hqjG2AqkgMgx/G5R+Z76XGAcw7CeeI5w4KU9z7Ox8SGpq/UQ7MZmGq+upiTq8rQ7VwnYRXyuoTwlTbH8QoN5UZ73sKFNlnpmopcEK8GRAshjI5P/sBxC4aCO3nwXII0NK43YsmLW8K40Dzk38cPwzjCrejmHDtair40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M8IKCKUD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5725fT2J023268
	for <linux-kernel@vger.kernel.org>; Sat, 2 Aug 2025 10:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Jx+kGc1/RtPDFH2kU0Zb9HbE
	qcdsxBgONzyUhmEa04Q=; b=M8IKCKUDEC+Bd7QZtmEsqmYVwRAdDw/7z3Lfae+m
	uSnhCG4cChirryJxvVQGcObJPaHmBNSxKmt5xFy95jUK8OH1c3hkCCETqnEDaVUb
	gNzM7e+qacgNXr4mIyeu1ttimWpDBxqOeVRVXewtT7w8jmX+9ThOzUerngFF8frX
	kwenYUebvafcly5XthVInTotUAO8FRpCnrE/J6CGRUyRk17WbCcd6KytPLrfHMXT
	Fxbye/W9+xQVto+0xrQ+DVdTxCEnyogYo777Xxvu0KObV+2aH9z+ugb6fR3zHm+a
	xHZIP3IX0WFPDvkx3XvNh0YigwyME2cTsU7hcoJ2AmF+Sg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48981rgwpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 10:18:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e68bc0408bso225283985a.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 03:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754129937; x=1754734737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx+kGc1/RtPDFH2kU0Zb9HbEqcdsxBgONzyUhmEa04Q=;
        b=S7Yzwt2NFgXBTyTt9R+9OB8nE+Pc+NwSwhh9EtLkXPPyPoOvGKTCFjI9BQIDmQ0U20
         8nNr/QBlavN8qTvsms2Q6R3mb2bCjN4bUHr5NJJnQrM033o+K2VOO6x8SH+3eCeUBt0M
         U6u1IpBNpkCLX+0lNzUQRKdtcN1ol+fXNZOrhIu8YcrmLMrAKyenx7ky8S94WcU1yiZu
         ee4yEPkq/397dX+0FVLTLeunWOJs6pPjlq1qnY5WFP3wiNYVq8FEmibSEilldy/yh7p+
         54DVX1eoxz/G5ceAqvEfRuBBncU5ZjRjE2kbAcIKfbtYMNh6ePwcJWD27mWNEVGQf2Ni
         KRUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw0ltrmxpLbVtKE83coFGBf6zxyIafyR47u6H140p6cRAmkbspNuAXoKkjy/NSAe06wf2iG82Crg9LkzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4tCMIgoxlsYC/QKdJuUpJT5Y25a/BeL2HW9MjXulyLbC+QLrv
	+Mi5J5n9FnPxjVzao3z5esKoLhqPEVteSpZ9Be69zSljNmiGxqBUq2kuoFKKP3JrDKtvWi0qlbI
	Ib1Vve5Vka4pFnzjJGwyEHNmgj0ix13O5y4Jf/aQW0VpCPjQo+G4TXlOQarAOpE7BMAQ=
X-Gm-Gg: ASbGncsS/8xlFdpB1qpmpfLcZINKXKFhaWxnMJCTD7j3exW9v0meQZ1qicg/Po/U3TV
	u5kzM9xufREOtEIJFUfUTmqf7kOExcs7jBDkMKemEcMvYeAhy9/1ql/GlUDpSdSwWdrBJh3WBzg
	zlw7JTxC24PlyPPJJBgyQNK8AUEh9d9lrg59US57GV2++UVVMHqBW1aVNG5vavBFIeRuWkYp/6j
	HS/GsfWSQKucj63Fh5giftTgEq6DFeI++ZkahP+Ri1pV33PjSrdx5E7x8r84QlWtrkqTyr6nMCb
	tt8U9pqGr+2vfWkWDMOQA89fuL3VPjjwG9jzkAqvUDzvt8fVTnBpb1SYJp1Dqn45SLtvgqO9HOi
	AdkEfCqpms6AlmjZW4UDet+ZXRGbaaXqqHCh/bn8/yLZGDAIWSbVB
X-Received: by 2002:ae9:f716:0:b0:7e3:48a2:b978 with SMTP id af79cd13be357-7e696371059mr347570185a.49.1754129936729;
        Sat, 02 Aug 2025 03:18:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkTnIMpLeKTQssFIE7XgfKnhYV45kHZ+Dp3zZITljw76FcrvhI8dE+FJ/ar1u/0l7+mkctwQ==
X-Received: by 2002:ae9:f716:0:b0:7e3:48a2:b978 with SMTP id af79cd13be357-7e696371059mr347568285a.49.1754129936298;
        Sat, 02 Aug 2025 03:18:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898c2e9sm918063e87.4.2025.08.02.03.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 03:18:55 -0700 (PDT)
Date: Sat, 2 Aug 2025 13:18:53 +0300
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
Subject: Re: [PATCH 18/19] drm/msm/dp: Move link training to atomic_enable()
Message-ID: <qz725rrbpae5iw6tmx2s2pbaxl7pliyxf7dd3gyev64zqrbq5t@aeacyijbswl3>
References: <20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com>
 <20250711-hpd-refactor-v1-18-33cbac823f34@oss.qualcomm.com>
 <cofa377vptj7on637u3c3mnxndplcmaegsb5h6idinz5wrvm6s@toylno4uapq4>
 <a085fb45-91e2-4827-b8e9-8af90796cc49@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a085fb45-91e2-4827-b8e9-8af90796cc49@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: WlwyHC6UNS68aEUEohCpdl_vnNabcLND
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAyMDA4NCBTYWx0ZWRfX0VXHFWlbAGaq
 yvL4zSM/P/5RmhDseRkbXLUJvn7K+UmLN3SEtbav3Y/yk54kTPMmEjfNIYHYAixevLq6Z/YYDO1
 TN24CsONlll7YTxhDUUP6yS7q0jrEKfr/kwX7kT+Lnqy+NojYp1GMTeuTLBJeUeSkNFNNozKi13
 S8ch30J2KZmYeuMqUBGyBh+ejJa315K3FViyqPUZBGBl2EIpJAkd1/P7izoeAsZFZH/oDRPmhgr
 toSH68Aa5KgiOpNO3QHXy8/z8sPLXXLv7AxZMXCQij1E5+VJTGZJHg/cOsXBagmaOp+B6t48gjH
 HncSzRGLB7ACKTORV0LxeeU5ItAdM5eW0BqG1erZd7vBg6F1khVB73j9j8o42zeSRLtRZoL/B5n
 +Tv51EHJspZ1QLh3Xky1IIjtuMWums9YsFSCdFgL9/wfeU8I+N+sGBxZiRfn8JWp92XoVhGM
X-Proofpoint-GUID: WlwyHC6UNS68aEUEohCpdl_vnNabcLND
X-Authority-Analysis: v=2.4 cv=a8Mw9VSF c=1 sm=1 tr=0 ts=688de611 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=alj5FwM-wW7eLBos5QIA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508020084

On Fri, Aug 01, 2025 at 04:58:55PM -0700, Jessica Zhang wrote:
> 
> 
> On 7/14/2025 4:54 AM, Dmitry Baryshkov wrote:
> > On Fri, Jul 11, 2025 at 05:58:23PM -0700, Jessica Zhang wrote:
> > > Currently, the DP link training is being done during HPD. Move
> > > link training to atomic_enable() in accordance with the atomic_enable()
> > > documentation.
> > > 
> > > In addition, don't disable the link until atomic_post_disable() (as part
> > > of the dp_ctrl_off[_link_stream]() helpers).
> > > 
> > > Since the link training is moved to a later part of the enable sequence,
> > > change the bridge detect() to return true when the display is physically
> > > connected instead of when the link is ready.
> > 
> > These two parts should be patch #2 in the series.
> > 
> > > 
> > > Finally, call the plug/unplug handlers directly in hpd_notify() instead
> > > of queueing them in the event thread so that they aren't preempted by
> > > other events.
> > > 
> > > Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_display.c | 15 ++++++++-------
> > >   drivers/gpu/drm/msm/dp/dp_drm.c     |  6 +++---
> > >   2 files changed, 11 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > > index 87f2750a99ca..32e1ee40c2c3 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > > @@ -410,11 +410,6 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
> > >   	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
> > >   	msm_dp_link_reset_phy_params_vx_px(dp->link);
> > > -	rc = msm_dp_ctrl_on_link(dp->ctrl);
> > > -	if (rc) {
> > > -		DRM_ERROR("failed to complete DP link training\n");
> > > -		goto end;
> > > -	}
> > >   	msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
> > > @@ -1561,6 +1556,12 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
> > >   		force_link_train = true;
> > >   	}
> > > +	rc = msm_dp_ctrl_on_link(msm_dp_display->ctrl);
> > > +	if (rc) {
> > > +		DRM_ERROR("Failed link training (rc=%d)\n", rc);
> > > +		dp->connector->state->link_status = DRM_LINK_STATUS_BAD;
> > > +	}
> > > +
> > >   	msm_dp_display_enable(msm_dp_display, force_link_train);
> > >   	rc = msm_dp_display_post_enable(dp);
> > > @@ -1706,7 +1707,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
> > >   		return;
> > >   	if (!msm_dp_display->link_ready && status == connector_status_connected)
> > > -		msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
> > > +		msm_dp_hpd_plug_handle(dp, 0);
> > >   	else if (msm_dp_display->link_ready && status == connector_status_disconnected)
> > > -		msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
> > > +		msm_dp_hpd_unplug_handle(dp, 0);
> > 
> > This chunk should be separated from this patch. I'd ask to drop
> > EV_HPD_PLUG_INT / EV_HPD_UNPLUG_INT completely and call DRM functions
> > all over the place instead. You can do it in a single patch, which comes
> > after this one.
> 
> Hi Dmitry,
> 
> Sure I can split this into a separate patch.
> 
> Is the goal here to remove the event queue entirely?

I think so.

> 
> I can drop EV_USER_NOTIFICATION,

With the link training being moved to atomic_enable, there should be no
need for an extra event here, I agree.

> but I'm not sure if I can completely drop
> EV_HPD_[UN]PLUG_INT entirely without major refactor of the plug/unplug
> handlers since they are used for the HPD IRQ handling.

And one of the pieces of the problem is that it's not doing its job
correctly.

The code flow should be:
- Inside the IRQ handler notify DRM core about HPD events from the
  bridge, don't do anything else.
- Inside detect() callback read DPCD bits and identify if there is a
  valid branch device.
- Inside hpd_notify() check if DPRX has sent IRQ_HPD pulse, handle the
  rest of the tasks: link events, etc.

Note: we might want to duplicate DPCD reading between detect() and
hpd_notify() in order to relieve detect from updating the DP structures.

-- 
With best wishes
Dmitry

