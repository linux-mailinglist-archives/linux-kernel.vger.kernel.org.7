Return-Path: <linux-kernel+bounces-791400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36917B3B665
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168991CC05EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CB82BE646;
	Fri, 29 Aug 2025 08:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O171H4Aa"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98822D322F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457326; cv=none; b=MsMFsj2kWfylW4By5Cm1NaswAQ2PU842uDiI65B42L/uAqaLJxPvSh0UJSjbp9Sx2wuk1bWp/DmbdGz0pN1WcKRSIQdAEcz2znolMHvob0uCNXPQGZ8/W5u1VE1qMsDQ0De4Fl0v4Q8gE4gtdNa+IY+xsE3LwrldwwjgJluPUtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457326; c=relaxed/simple;
	bh=U35e/E8q0I+gH4p+LPvs4gYYi3QH4Uu1M0lmIoOA1sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs4NIivVno4WhQq7ON8TTgeam7bw48sXi+eRz/G5qwpvMFtB+GyRrhRWx7y4BR6ZMtPT8dzTzNLskXh6j68TzCPEmz7dWTP6sxrYnDbHdiu/q0+1eImKhMI4Cz8LtVI8AoL71MBix42YiVYmTqblDCc/HhxElcl3NNfaI7d+nDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O171H4Aa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T85Eag003534
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/5pBODwspf82fhKHX/+Qq3M8
	oCn/6yRZrJbLU7BeMOU=; b=O171H4Aal17R09DovZSV+f7s9mAfCdAdtrQVTFsl
	GQlxb/LkQrUq/6+/W0kU6lq/0pofV7O7pLQhM+o1+aXy9r4fAPkuYL2MXiD4siQs
	g1Na+02TxmDq29fo1qK8CUsEFolUHv7Tc/CfS4QJaFJpsGjh9LlP/jSUXO0lRmWZ
	/CEbX8JaAtsj2hyphwKEMHu9i/NeKTePzqcndXiJ2Ty5Bd2R0/1PdwworLi+vW8J
	VU+zqzS11JwUSpjblFP44O2dPwkJuocpegRv6CbYE+UMyxnMNW1agMiKOmNwftF9
	j6bgIpa5uAUClt6tHX6mVrzhmjzjmE3cf5qsJHFYQFAZGQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tp5k38xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:48:43 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70ddbb81696so35328226d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756457322; x=1757062122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5pBODwspf82fhKHX/+Qq3M8oCn/6yRZrJbLU7BeMOU=;
        b=O3yNw2pw/Uk9V5Roo4nGP6tpi0kcPcdo4CzuysB331UXmD5pfLH9RNtspKvJ5JJYH5
         Mpe4IlisGIFtjTyU7ANmw4GhhYzVIgVI2+a4AZFXIp76MapFgb7Z3j/VoGE0QDrBxXnB
         RFib/JzVsFx2v+fuE20SejiQtQBwXLzBJFBN43fMfgwO9bkyfwIeXajxFLN2kc2ppOr8
         kSsdHRnGDRZ2HEML7syguH2jimHwgxQUSzB/xSmhr68jtUoqvbhkiCwZ/MR6CtMrkuSx
         OZPHA0Ff7JtuJnvPwsXT8xqTOaCiyMjh/SWVF1QFoz2kebux7xkYzd257+uVuVWhL6l+
         9IWA==
X-Forwarded-Encrypted: i=1; AJvYcCVIS20APBvxU3R7MbZzaPdZNQlF9OlXSAAVOW2jfN6qg2x/PEobo1i/iHz+qvpIKKOma3Q4l4rjZ8zavg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAt7sSkf/C5Knivv3vwaszTEaMlC0W5R5ayE+GAO2XqPJ+zYRx
	5DtR/OMZ+r7G1x7iFJLHY/Q79FsrWMGMwB4/DVrVdZknVJeoXuGT1Xcqxkhnj6ZwKkUWwF06vSn
	vPtBm9fpSSE7sY061YEyAQt74ddana1H4ay98NSZizc4cMy2Jq1cYGEX5HypHRLkIU/U=
X-Gm-Gg: ASbGncu1EBmmG11AShltPB58Pv75aFxCNQXpc3W61tLggr2JBuV0RmPJziVjASk9dMY
	p1Jc58qg9qRXmBrzRHrka87p17U75/KqTRxt2mP+6utIg46drtmSoIzCnNUE0vEWQBRG6EBh9cg
	eZY5M9W/r3iuYGx2oKkDVmPi/1eTSPq8l6DPgoR4j79vYon5XvdsgwrGgfBZbF/xUBgnVnaNIBM
	eAKbrVJrwZbjtE4v4Ir6dEZIVlb1RZvVi38eu9Y4L0N1EiUwHMtpYXrDnVnW0833BqaiMFohW0C
	tTnG+LxZyYQwSr4JP9ZoqbNRjJFnmbK7sdeHNKdFR+hMWNrjPJ9QU4alSTE7hslL+f3IJWrXzZj
	g6llgGT/3yPLqVDeufeIJt9O9YV1EKzJnWra/tqHcCm2786i9L9LM
X-Received: by 2002:a05:6214:5186:b0:70d:b3de:cec9 with SMTP id 6a1803df08f44-70dd59c1196mr125891066d6.22.1756457322324;
        Fri, 29 Aug 2025 01:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq1ezFqcENyB1YLJXTV7TThom8X2IGaTOdTprgqE2iRpU+3lXQDMjeVPvPOaC+kNzjQAaeVA==
X-Received: by 2002:a05:6214:5186:b0:70d:b3de:cec9 with SMTP id 6a1803df08f44-70dd59c1196mr125890886d6.22.1756457321839;
        Fri, 29 Aug 2025 01:48:41 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f6784526csm461424e87.84.2025.08.29.01.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:48:39 -0700 (PDT)
Date: Fri, 29 Aug 2025 11:48:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, jingoohan1@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, hjc@rock-chips.com, heiko@sntech.de,
        andy.yan@rock-chips.com, l.stach@pengutronix.de, dianders@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 07/13] drm/bridge: analogix_dp: Apply
 drm_bridge_connector helper
Message-ID: <ghp33yxo24gaubn6pijks3wnuch3fpbmi5z27cq7pk3siffiox@jb2zw3lt35hk>
References: <20250814104753.195255-1-damon.ding@rock-chips.com>
 <20250814104753.195255-8-damon.ding@rock-chips.com>
 <incxmqneeurgli5h6p3hn3bgztxrzyk5eq2h5nq4lgzalohslq@mvehvr4cgyim>
 <62dfbe1d-3e36-4bc5-9b25-a465e710f23b@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62dfbe1d-3e36-4bc5-9b25-a465e710f23b@rock-chips.com>
X-Authority-Analysis: v=2.4 cv=V9F90fni c=1 sm=1 tr=0 ts=68b1696b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=s8YR1HE3AAAA:8 a=g_3uhpjf_u-dzjrkN2gA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI4MDA5NSBTYWx0ZWRfX4HW86qjq33GZ
 KH2YI1hPV/o2wW4z1CZbg7nHxsbxAe2S8kncsxcM+8N80OQqem+HVfH51kL9CtobN+UssmL4XCo
 2+0Er3ia+c3MEIs3HnaX1DuJ9YF06t94Bq016MYf1kusodcMGRa2jzIubt16VpbhADSTI+rtP7C
 e7ErOhl0S1W86UVCuvd7cEr7TCx/x+gAtT5nGX2TjcShGs9YAfnWgyefyQD9EQyZmfHJPXDqnCY
 BY/Y3QG/FB+FIgrZ8biw0TqCbTXfKuQUhcZH9Kknu5mG2unw/0Hem/6pUFPX8H3kDSDF23/z4mu
 F8xMFXPrZCEPyQRnwQKyxVliofC6RtZ5uTfHwWecWmYvzIRGjAPL6U/cbpW8mf5ZNfoD+28/DNh
 vPQTbtKQ
X-Proofpoint-ORIG-GUID: vtIR5CuHc0R5pKdea3zlT-qmT7Zld1Lu
X-Proofpoint-GUID: vtIR5CuHc0R5pKdea3zlT-qmT7Zld1Lu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508280095

On Wed, Aug 20, 2025 at 05:18:13PM +0800, Damon Ding wrote:
> Hi Dmitry,
> 
> On 8/17/2025 12:43 AM, Dmitry Baryshkov wrote:
> > On Thu, Aug 14, 2025 at 06:47:47PM +0800, Damon Ding wrote:
> > > Apply drm_bridge_connector helper for Analogix DP driver.
> > > 
> > > The following changes have been made:
> > > - Apply drm_bridge_connector helper to get rid of &drm_connector_funcs
> > >    and &drm_connector_helper_funcs.
> > > - Remove unnecessary parameter struct drm_connector* for callback
> > >    &analogix_dp_plat_data.attach.
> > > - Remove &analogix_dp_device.connector.
> > > - Convert analogix_dp_atomic_check()/analogix_dp_detect() to
> > >    &drm_bridge_funcs.atomic_check()/&drm_bridge_funcs.detect().
> > > - Split analogix_dp_get_modes() into &drm_bridge_funcs.get_modes() and
> > >    &drm_bridge_funcs.edid_read().
> > > 
> > > Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> > > 
> > > ------
> > > 
> > > Changes in v2:
> > > - For &drm_bridge.ops, remove DRM_BRIDGE_OP_HPD and add
> > >    DRM_BRIDGE_OP_EDID.
> > > - Add analogix_dp_bridge_edid_read().
> > > - Move &analogix_dp_plat_data.skip_connector deletion to the previous
> > >    patches.
> > > 
> > > Changes in v3:
> > > - Rebase with the new devm_drm_bridge_alloc() related commit
> > >    48f05c3b4b70 ("drm/bridge: analogix_dp: Use devm_drm_bridge_alloc()
> > >    API").
> > > - Expand the commit message.
> > > - Call drm_bridge_get_modes() in analogix_dp_bridge_get_modes() if the
> > >    bridge is available.
> > > - Remove unnecessary parameter struct drm_connector* for callback
> > >    &analogix_dp_plat_data.attach.
> > > - In order to decouple the connector driver and the bridge driver, move
> > >    the bridge connector initilization to the Rockchip and Exynos sides.
> > > 
> > > Changes in v4:
> > > - Expand analogix_dp_bridge_detect() parameters to &drm_bridge and
> > >    &drm_connector.
> > > - Rename the &analogix_dp_plat_data.bridge to
> > >    &analogix_dp_plat_data.next_bridge.
> > > ---
> > >   .../drm/bridge/analogix/analogix_dp_core.c    | 145 ++++++++----------
> > >   .../drm/bridge/analogix/analogix_dp_core.h    |   1 -
> > >   drivers/gpu/drm/exynos/exynos_dp.c            |  18 ++-
> > >   .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  11 +-
> > >   include/drm/bridge/analogix_dp.h              |   3 +-
> > >   5 files changed, 88 insertions(+), 90 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > > index 7876b310aaed..a8ed44ec8ef5 100644
> > > --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > > +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> > > @@ -947,24 +947,16 @@ static int analogix_dp_disable_psr(struct analogix_dp_device *dp)
> > >   	return analogix_dp_send_psr_spd(dp, &psr_vsc, true);
> > >   }
> > > -static int analogix_dp_get_modes(struct drm_connector *connector)
> > > +static int analogix_dp_bridge_get_modes(struct drm_bridge *bridge, struct drm_connector *connector)
> > >   {
> > > -	struct analogix_dp_device *dp = to_dp(connector);
> > > -	const struct drm_edid *drm_edid;
> > > +	struct analogix_dp_device *dp = to_dp(bridge);
> > >   	int num_modes = 0;
> > > -	if (dp->plat_data->panel) {
> > > +	if (dp->plat_data->panel)
> > >   		num_modes += drm_panel_get_modes(dp->plat_data->panel, connector);
> > > -	} else {
> > > -		drm_edid = drm_edid_read_ddc(connector, &dp->aux.ddc);
> > > -		drm_edid_connector_update(&dp->connector, drm_edid);
> > > -
> > > -		if (drm_edid) {
> > > -			num_modes += drm_edid_connector_add_modes(&dp->connector);
> > > -			drm_edid_free(drm_edid);
> > > -		}
> > > -	}
> > > +	if (dp->plat_data->next_bridge)
> > > +		num_modes += drm_bridge_get_modes(dp->plat_data->next_bridge, connector);
> > 
> > If there is a next bridge which provides OP_MODES, then
> > drm_bridge_connector will use it for get_modes() and skip this one
> > completely. I'm not sure what's the value of this call.
> 
> Following your advice, it is really a good idea to distinguish the
> drm_bridge_ops between the panel and the bridge. Will add it in v5.
> 
> > 
> > >   	if (dp->plat_data->get_modes)
> > >   		num_modes += dp->plat_data->get_modes(dp->plat_data, connector);
> > > @@ -972,51 +964,39 @@ static int analogix_dp_get_modes(struct drm_connector *connector)
> > >   	return num_modes;
> > >   }
> > > -static struct drm_encoder *
> > > -analogix_dp_best_encoder(struct drm_connector *connector)
> > > +static const struct drm_edid *analogix_dp_bridge_edid_read(struct drm_bridge *bridge,
> > > +							   struct drm_connector *connector)
> > >   {
> > > -	struct analogix_dp_device *dp = to_dp(connector);
> > > +	struct analogix_dp_device *dp = to_dp(bridge);
> > > +	const struct drm_edid *drm_edid = NULL;
> > > -	return dp->encoder;
> > > -}
> > > +	drm_edid = drm_edid_read_ddc(connector, &dp->aux.ddc);
> > > +	if (dp->plat_data->get_modes)
> > > +		dp->plat_data->get_modes(dp->plat_data, connector);
> > 
> > 
> > So, we have DDC, but we still want to return platform modes? What is the
> > usecase for that?
> > 
> > There might be some, but I think it deserves a comment in the source
> > file.
> > 
> 
> For Rockchip side, since RK3588 and RK3576 can support YUV formats while the
> other can not, the &analogix_dp_plat_data.get_modes() help filter out YUV
> formats for some platforms(The YUV feature support may not be fit for this
> patch series and will come later).

Note, get_modes() here adds modes rather than filtering them. You can
use .mode_valid in order to filter out YUV modes.

> 
> For Exynos side, I think &analogix_dp_plat_data.get_modes() can help
> parse the video mode set in the eDP DT node when there is no available panel
> or bridge.

I think this should be handled by a separate bridge. E.g. see how the
imx-legacy-bridge is implemented.

> 
> I will add some comments about it in the next version.
> 

-- 
With best wishes
Dmitry

