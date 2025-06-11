Return-Path: <linux-kernel+bounces-681903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3285BAD58CD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 16:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DAF178AAE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCEC295515;
	Wed, 11 Jun 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QKf07+Zg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8905529ACF9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652296; cv=none; b=Yv2VeDdy80ON/vVPAStEFaTEvgTt241ezuVvKJXsDsYXBCrjKZ4TemTA+3flJu3EvchysOBRIRIOhmSNNNIhVNqahwiFmDU/Kh4zG5ive6QzI3j0mwiXLKLVjIC/27CxgAeOMVqeYjVB4rZ0AYzeOoquWcrXTveW7orpvY2zDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652296; c=relaxed/simple;
	bh=vBmDGM2VG9GXU1zyMI3BUGf/9ROVFJl2W1cRXfybvFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlA81Avd+bZ+g9snfRpy8gmhVZRtko0bgnO7AIjRS0pkzZsHJloHn803p3yznar/ulwaS/F1nbjoiKq8U7kkjhb5GqUY90rYLrx9Rv0vRKPRAffeWszWEt/CJvohv7+af1+iCPQDeSZ/5Dy8wNat9fdVcitna0ZlgsS0VnsyqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QKf07+Zg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DMfv014218
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 14:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=s+mAy5hgpXrSdp6Ro8HHOn8e
	lTPskdgVc2l8uVDrGHU=; b=QKf07+ZgJ7Zev/QfBj2zMDE2erG1rGQXiji15lKp
	NqUySwecFM2keBf+DfzniBA978ADqSO5oqvIlL1YQQ6pZq4vCr0W6cAX8vR1aF7Z
	h0JDiT5WvRo+LN6JgimY4/W4a5O8fDOUOkjHUfX4iyuTY2j/mrMa/wnRr2JbHYhH
	r1CdySwEzRw8ZLw3dQokggfxpZgMOf25bseGrKhtTcuYVzwYIV57AYCvjj8xGsKY
	JRdSoRwRH+DEqhBLOhR01a/+G6LTQFbineE4StJum08bamPmwhYL5pmkcsVf6IAC
	+S63zj2H8nkWsbit4v7Te2W4/GX5JI4mkuKjRN4lVznvtg==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 476fmncvxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 14:31:33 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-408da7cb857so1959067b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 07:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749652292; x=1750257092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+mAy5hgpXrSdp6Ro8HHOn8elTPskdgVc2l8uVDrGHU=;
        b=YhQpG2reKeNMUgSJBUa6FB7/iTZJaNGkKKATjeD4cW16c0yEBwXV91Wb96dtEYavB9
         gLm2HgxHRtzdKRIWcq2J7LKxa6soVeLziO4mh7mEtq92b5KLqMGT1sVlcKq+xJHhuDQE
         rqCIT2TD31bQcyJnvsnjvFh0xb2RSar2q11JZc64sYq46snT41SGBYdxnp5Oao8aZnuA
         AZae3rrNUHHPHRWwX5ooc7JGG0t8LLZcNSr0HyXH/3sZJYeoFZhrePyYqMM5REy+EB0d
         wBXGdFnGgCIXo5pvztbW11Oex62y4LzlBXMLdRrVcuwfu/Yv1rJ5t0VMuAwpBGvjetpV
         9U8g==
X-Forwarded-Encrypted: i=1; AJvYcCU0iuhwzZnVdp0ZL/6fYXcFZxr1fqTJXYowrxMywxFkuEPsiMnn/tQ9DNHfko1uGj6+AaI9xJ/b8DjXpgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRiQpiNplZwhwfZOpvVeD4WYYhYeN9kiGI8Af0iEynbjDEktgQ
	ODD1DyCcMoJPTim9BsHX9OM7WIz7UXHbdwRmx1su9v4RKmvdMWcEq858Sp5ZxpbuWLR3asxfDEz
	V5QWWmjZGCS4rwHZprCHG7b14lOBGHfU1w8TGdQzy9mLPNbTOdpf0XbdQxf+H8LdFPww=
X-Gm-Gg: ASbGnctinDe8XnTLRt2lgvmER3HP3CEigi3zYiEb7dlkgE5PNWsk8gT//qSt21l9gYr
	ECLRrv5MkOBlBEsbbSI6nLfOOS3YJVFKmrCUDSCxPJbV9nTbC0fEVxOrHdQyTiAtJZEmGjzPoa3
	PdyFmFo+RWD1DR9bXLi1jp5JPDEFH+cvzPtVLVxsXrohbYomfo+HczbiNtTxectPCMAYp0G/PDL
	HjJo0tjXVn/Vryj9oTdXRiJpGfTNowwvUDbWD//QPKC86PDvRe9BU1cHdPAUfk97FkKDHOrLTSf
	2sScJIrNlO1iRGJdmDhdrTRp4qRITEyzPNhNXPLga3sdKLE9BfSPU/Gj28JWW/6TKlM1fMoL4oa
	xSvfQwNUnfcUbHA6/VbZ4s4pXBZyFvHtAVJE=
X-Received: by 2002:a05:6808:1a10:b0:406:6fd3:ff13 with SMTP id 5614622812f47-40a5d127d4amr2388271b6e.25.1749652291789;
        Wed, 11 Jun 2025 07:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBwhgMD2t1lWLdOJsLoYG9q83M3Y+HNlfbUhI7AgC+iOpcUhMkoJYWvVYmNFJCcuZ11LPMTg==
X-Received: by 2002:a05:6808:1a10:b0:406:6fd3:ff13 with SMTP id 5614622812f47-40a5d127d4amr2388233b6e.25.1749652291300;
        Wed, 11 Jun 2025 07:31:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5536773139csm1962595e87.208.2025.06.11.07.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:31:30 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:31:28 +0300
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
Subject: Re: [PATCH v2 29/38] drm/msm/dp: add connector abstraction for DP MST
Message-ID: <njz3apifgcv2k3kzlmti5rjgqpl43v5yvjqpu6qhpe2kw3bzlu@pqvnrh6ff2um>
References: <20250609-msm-dp-mst-v2-0-a54d8902a23d@quicinc.com>
 <20250609-msm-dp-mst-v2-29-a54d8902a23d@quicinc.com>
 <bmzte2ywtlygl4rru73efnfb4vpi3vkveeq32jhonrmxbogp5h@kqaukhzvcxx3>
 <2ab43ae7-12b6-4d41-9ffd-dbea70e2a662@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ab43ae7-12b6-4d41-9ffd-dbea70e2a662@quicinc.com>
X-Proofpoint-ORIG-GUID: _PG8DdHBbITiJ5FWVIaSmams7YHOiee7
X-Proofpoint-GUID: _PG8DdHBbITiJ5FWVIaSmams7YHOiee7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEyMSBTYWx0ZWRfX1xgRp7mIFMdF
 sXIthz0nAtNuzULgVkOR8wR8+VMqZe80YDW30ikBm1lVj8CV/6oxVVdLY9Phf+rxSwPQAgi9Et2
 xTtxD9eWaymivXjneGOpFufBUB9gih+IADxxlAEnF92JJ+2hY2O72dyB6mXSkoeQd+i+dOybIBP
 xW0qvh32Giss/QlsBIwDPwl2xqCYqHZRNSdukBZn/PwW4B60JQujfcw8PV+LcaVsRH311N0HkcX
 TwEsdxIFGPGvo50TtiIV2lm4OkVLz2Psyr9S27whyHC/OtHbvbfiftsHfX3ZJSyDva1Jr58byHl
 NUgupkwv/rxgD8HAs5PXT5yHBG5HaY9Kad6mYYuuLk9fqVSg4BxozZpc+Y1LJPvL0a+2wX/Npmr
 fyE8XZQOhaOZcdN69HQXjoqMWv+ad4J54fenDYAwNWOW+hERPJygTI8/MOuMXFD4PAvPIMzS
X-Authority-Analysis: v=2.4 cv=K8wiHzWI c=1 sm=1 tr=0 ts=68499345 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=TeuomRHYAdqe4Vjd-BQA:9 a=CjuIK1q_8ugA:10
 a=efpaJB4zofY2dbm2aIRb:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110121

On Wed, Jun 11, 2025 at 08:06:28PM +0800, Yongxing Mou wrote:
> 
> 
> On 2025/6/9 23:44, Dmitry Baryshkov wrote:
> > On Mon, Jun 09, 2025 at 08:21:48PM +0800, Yongxing Mou wrote:
> > > From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > 
> > > Add connector abstraction for the DP MST. Each MST encoder
> > > is connected through a DRM bridge to a MST connector and each
> > > MST connector has a DP panel abstraction attached to it.
> > > 
> > > Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > Signed-off-by: Yongxing Mou <quic_yongmou@quicinc.com>
> > > ---
> > >   drivers/gpu/drm/msm/dp/dp_mst_drm.c | 515 ++++++++++++++++++++++++++++++++++++
> > >   drivers/gpu/drm/msm/dp/dp_mst_drm.h |   3 +
> > >   2 files changed, 518 insertions(+)
> > 
> > It generally feels liks 80% of this patch is a generic code. Please
> > extract generic DP MST connector and push it under drm/display. Other DP
> > MST drivers should be able to use it.
> > 
> > > 
> > > diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> > > index a3ea34ae63511db0ac920cbeebe30c4e2320b8c4..489fa46aa518ff1cc5f4769b2153fc5153c4cb41 100644
> > > --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> > > +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> > > @@ -25,8 +25,12 @@
> > >    * OF THIS SOFTWARE.
> > >    */
> > > +#include <drm/drm_edid.h>
> > > +#include <drm/drm_managed.h>
> > >   #include "dp_mst_drm.h"
> > > +#define MAX_DPCD_TRANSACTION_BYTES 16
> > > +
> > >   static struct drm_private_state *msm_dp_mst_duplicate_bridge_state(struct drm_private_obj *obj)
> > >   {
> > >   	struct msm_dp_mst_bridge_state *state;
> > > @@ -79,6 +83,61 @@ static int msm_dp_mst_find_vcpi_slots(struct drm_dp_mst_topology_mgr *mgr, int p
> > >   	return num_slots;
> > >   }
> > > +static int msm_dp_mst_get_mst_pbn_div(struct msm_dp_panel *msm_dp_panel)
> > > +{
> > > +	struct msm_dp_link_info *link_info;
> > > +
> > > +	link_info = &msm_dp_panel->link_info;
> > > +
> > > +	return link_info->rate * link_info->num_lanes / 54000;
> > > +}
> > > +
> > > +static int msm_dp_mst_compute_config(struct drm_atomic_state *state,
> > > +				      struct msm_dp_mst *mst, struct drm_connector *connector,
> > > +				      struct drm_display_mode *mode)
> > > +{
> > > +	int slots = 0, pbn;
> > > +	struct msm_dp_mst_connector *mst_conn = to_msm_dp_mst_connector(connector);
> > > +	int rc = 0;
> > > +	struct drm_dp_mst_topology_state *mst_state;
> > > +	int pbn_div;
> > > +	struct msm_dp *dp_display = mst->msm_dp;
> > > +	u32 bpp;
> > > +
> > > +	bpp = connector->display_info.bpc * 3;
> > > +
> > > +	pbn = drm_dp_calc_pbn_mode(mode->clock, bpp << 4);
> > 
> > Is this going to change if DSC is in place? Will it bring fractional BPP
> > here?
> > 
> Actually, in this patch series, MST not support DSC. So we just don't
> consider this scenario.

But you still can answer the question.


[...]

> > > +
> > > +	return msm_dp_display_mode_valid(dp_display, &dp_display->connector->display_info, mode);
> > > +}
> > > +
> > > +static struct drm_encoder *
> > > +msm_dp_mst_atomic_best_encoder(struct drm_connector *connector, struct drm_atomic_state *state)
> > 
> > Do we need this callback? Don't we have a fixed relationship between
> > connectors and encoders?

This was left unanswered.

> > 
> > > +{
> > > +	struct msm_dp_mst_connector *mst_conn = to_msm_dp_mst_connector(connector);
> > > +	struct msm_dp *dp_display = mst_conn->msm_dp;
> > > +	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
> > > +	struct drm_encoder *enc = NULL;
> > > +	struct msm_dp_mst_bridge_state *bridge_state;
> > > +	u32 i;
> > > +	struct drm_connector_state *conn_state = drm_atomic_get_new_connector_state(state,
> > > +										    connector);
> > > +
> > 

[...]

> > > +	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
> > > +		if (WARN_ON(!old_conn_state->best_encoder)) {
> > > +			rc = -EINVAL;
> > > +			goto end;
> > > +		}
> > > +
> > > +		drm_bridge = drm_bridge_chain_get_first_bridge(old_conn_state->best_encoder);
> > 
> > This really looks like this should be a bridge's callback.

And this one

> > 
> > > +		if (WARN_ON(!drm_bridge)) {
> > > +			rc = -EINVAL;
> > > +			goto end;
> > > +		}
> > > +		bridge = to_msm_dp_mst_bridge(drm_bridge);
> > > +
> > > +		bridge_state = msm_dp_mst_br_priv_state(state, bridge);
> > > +		if (IS_ERR(bridge_state)) {
> > > +			rc = PTR_ERR(bridge_state);
> > > +			goto end;
> > > +		}
> > > +
> > > +		if (WARN_ON(bridge_state->connector != connector)) {
> > > +			rc = -EINVAL;
> > > +			goto end;
> > > +		}
> > > +
> > > +		slots = bridge_state->num_slots;
> > > +		if (slots > 0) {
> > > +			rc = drm_dp_atomic_release_time_slots(state,
> > > +							      &mst->mst_mgr,
> > > +							      mst_conn->mst_port);
> > > +			if (rc) {
> > > +				DRM_ERROR("failed releasing %d vcpi slots %d\n", slots, rc);
> > > +				goto end;
> > > +			}
> > > +			vcpi_released = true;
> > > +		}
> > > +
> > > +		if (!new_conn_state->crtc) {
> > > +			/* for cases where crtc is not disabled the slots are not
> > > +			 * freed by drm_dp_atomic_release_time_slots. this results
> > > +			 * in subsequent atomic_check failing since internal slots
> > > +			 * were freed but not the dp mst mgr's
> > > +			 */
> > > +			bridge_state->num_slots = 0;
> > > +			bridge_state->connector = NULL;
> > > +			bridge_state->msm_dp_panel = NULL;
> > > +
> > > +			drm_dbg_dp(dp_display->drm_dev, "clear best encoder: %d\n", bridge->id);
> > > +		}
> > > +	}
> > 
> > This looks like there are several functions fused together. Please
> > unfuse those into small and neat code blocks.

And this :-D

> > 
> > > +
> > > +mode_set:
> > > +	if (!new_conn_state->crtc)
> > > +		goto end;
> > > +
> > > +	crtc_state = drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
> > > +
> > > +	if (drm_atomic_crtc_needs_modeset(crtc_state) && crtc_state->active) {
> > 
> > Use of crtc_state->active doesn't look correct.


...

> > 
> > > +		if (WARN_ON(!new_conn_state->best_encoder)) {
> > > +			rc = -EINVAL;
> > > +			goto end;
> > > +		}
> > > +
> > > +		drm_bridge = drm_bridge_chain_get_first_bridge(new_conn_state->best_encoder);
> > > +		if (WARN_ON(!drm_bridge)) {
> > > +			rc = -EINVAL;
> > > +			goto end;
> > > +		}
> > > +		bridge = to_msm_dp_mst_bridge(drm_bridge);
> > > +
> > > +		bridge_state = msm_dp_mst_br_priv_state(state, bridge);
> > > +		if (IS_ERR(bridge_state)) {
> > > +			rc = PTR_ERR(bridge_state);
> > > +			goto end;
> > > +		}
> > > +
> > > +		if (WARN_ON(bridge_state->connector != connector)) {
> > > +			rc = -EINVAL;
> > > +			goto end;
> > > +		}
> > 
> > Can all of this actually happen?

...

> > 
> > > +
> > > +		/*
> > > +		 * check if vcpi slots are trying to get allocated in same phase
> > > +		 * as deallocation. If so, go to end to avoid allocation.
> > > +		 */
> > > +		if (vcpi_released) {
> > > +			drm_dbg_dp(dp_display->drm_dev,
> > > +				   "skipping allocation since vcpi was released in the same state\n");
> > > +			goto end;
> > > +		}
> > > +
> > > +		if (WARN_ON(bridge_state->num_slots)) {
> > > +			rc = -EINVAL;
> > > +			goto end;
> > > +		}
> > > +
> > > +		slots = msm_dp_mst_compute_config(state, mst, connector, &crtc_state->mode);
> > > +		if (slots < 0) {
> > > +			rc = slots;
> > > +			goto end;
> > > +		}
> > > +
> > > +		bridge_state->num_slots = slots;
> > > +	}
> > > +
> > > +end:
> > > +	drm_dbg_dp(dp_display->drm_dev, "mst connector:%d atomic check ret %d\n",
> > > +		   connector->base.id, rc);
> > > +	return rc;
> > > +}
> > > +
> > > +static void dp_mst_connector_destroy(struct drm_connector *connector)
> > > +{
> > > +	struct msm_dp_mst_connector *mst_conn = to_msm_dp_mst_connector(connector);
> > > +
> > > +	drm_connector_cleanup(connector);
> > > +	drm_dp_mst_put_port_malloc(mst_conn->mst_port);
> > > +}
> > > +
> > > +/* DRM MST callbacks */
> > > +static const struct drm_connector_helper_funcs msm_dp_drm_mst_connector_helper_funcs = {
> > > +	.get_modes =    msm_dp_mst_connector_get_modes,
> > > +	.detect_ctx =   msm_dp_mst_connector_detect,
> > > +	.mode_valid =   msm_dp_mst_connector_mode_valid,
> > > +	.atomic_best_encoder = msm_dp_mst_atomic_best_encoder,
> > > +	.atomic_check = msm_dp_mst_connector_atomic_check,
> > > +};
> > > +
> > > +static const struct drm_connector_funcs msm_dp_drm_mst_connector_funcs = {
> > > +	.reset = drm_atomic_helper_connector_reset,
> > > +	.destroy = dp_mst_connector_destroy,
> > > +	.fill_modes = drm_helper_probe_single_connector_modes,
> > > +	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> > > +	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> > > +};
> > > +
> > > +static struct drm_connector *
> > > +msm_dp_mst_add_connector(struct drm_dp_mst_topology_mgr *mgr,
> > > +			 struct drm_dp_mst_port *port, const char *pathprop)
> > > +{
> > > +	struct msm_dp_mst *dp_mst;
> > > +	struct drm_device *dev;
> > > +	struct msm_dp *dp_display;
> > > +	struct msm_dp_mst_connector *mst_connector;
> > > +	struct drm_connector *connector;
> > > +	int rc, i;
> > > +
> > > +	dp_mst = container_of(mgr, struct msm_dp_mst, mst_mgr);
> > > +
> > > +	dp_display = dp_mst->msm_dp;
> > > +	dev = dp_display->drm_dev;
> > > +
> > > +	mst_connector = devm_kzalloc(dev->dev, sizeof(*mst_connector), GFP_KERNEL);
> > 
> > This shows that somebody doesn't understand the reason for drmm and the
> > difference between devm and drmm and the lifetime of the objects. Do you
> > see two issues in this line?
> > 
> > Let me help you. Please use normal (non-managed) memory here. It is the
> > only correct way to allocate memory for MST connectors.
> > 
> Thanks for point it.. it will lead to mem leak.. so we need to use
> kzalloc()...

- Did you understand why devm is unsuitable here?
- Why drmm is also unsutable?
- What is the implication of using kzalloc() here?

> > > +
> > > +	drm_modeset_lock_all(dev);
> > > +
> > > +	rc = drm_connector_dynamic_init(dev, &mst_connector->connector,
> > > +					&msm_dp_drm_mst_connector_funcs,
> > > +					DRM_MODE_CONNECTOR_DisplayPort, NULL);
> > > +	if (rc) {
> > > +		drm_modeset_unlock_all(dev);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	mst_connector->dp_panel = msm_dp_display_get_panel(dp_display);
> > > +	if (!mst_connector->dp_panel) {
> > > +		DRM_ERROR("failed to get dp_panel for connector\n");
> > > +		drm_modeset_unlock_all(dev);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	mst_connector->dp_panel->connector = &mst_connector->connector;
> > > +	mst_connector->msm_dp = dp_display;
> > > +	connector = &mst_connector->connector;
> > > +	drm_connector_helper_add(&mst_connector->connector, &msm_dp_drm_mst_connector_helper_funcs);
> > > +
> > > +	if (connector->funcs->reset)
> > > +		connector->funcs->reset(connector);
> > > +
> > > +	/* add all encoders as possible encoders */
> > > +	for (i = 0; i < dp_mst->max_streams; i++) {
> > > +		rc = drm_connector_attach_encoder(&mst_connector->connector,
> > > +						  dp_mst->mst_bridge[i].encoder);
> > > +		if (rc) {
> > > +			DRM_ERROR("failed to attach encoder to connector, %d\n", rc);
> > > +			drm_modeset_unlock_all(dev);
> > > +			return NULL;
> > > +		}
> > > +	}
> > > +
> > > +	mst_connector->mst_port = port;
> > > +	drm_dp_mst_get_port_malloc(mst_connector->mst_port);
> > > +
> > > +	drm_object_attach_property(&mst_connector->connector.base,
> > > +				   dev->mode_config.path_property, 0);
> > > +	drm_object_attach_property(&mst_connector->connector.base,
> > > +				   dev->mode_config.tile_property, 0);
> > 
> > subconnector? Or do we report the subconnector only for the main DP
> > port?


...

> > 
> > > +
> > > +	drm_modeset_unlock_all(dev);
> > > +
-- 
With best wishes
Dmitry

