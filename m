Return-Path: <linux-kernel+bounces-831687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9152B9D51C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83C794A0830
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94DC2DEA80;
	Thu, 25 Sep 2025 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UgTSuc6K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85275233134
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758771474; cv=none; b=TYJlMYM2F6Lpi9ckotf9pqOpjCuae7iAhfyQ2aufdhwUnno2qE3/eCuOpqc0TO5HsmBvnmlgOM+G+wxy40jVl4zKKuR8upBCgQdzxFwPbr5szubuAI7XIc/Wo4zz5peO6Dp75DdNPqmFdaL9/7Zl2hRR0px+koYQ9rBqf7MDZh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758771474; c=relaxed/simple;
	bh=SwJ8n9QRRLb939UHBqsh+5lwtzA2jD8olcgzZwVK72A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfjLma39VpNppYfA4UwVVDQyOhjOcGSSNwyU6QAHrmh5FhIwZktKPrpvAYt50lD7hbi7148le/as7hYH40qrRyj7TRRQi7xJksoqqE4r0+lWJ75kyJ0OPjECe/Np1khSuVsLU8oqoLjSRZMhjdLGjVfUN1CME3oTgCw5wbiD3PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UgTSuc6K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONvNDa017438
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=n78nIIomQavWQosZYQPTeoTh
	4ytOcFS5L4hdEAU6XLI=; b=UgTSuc6KmCehqi8ARRkarzQ/yMYshdS5YZXikwc2
	7kEv0mWOqAoVbz2YicphPD1AnKPWlRK1yp+Fmhm3SFLF2E1yvaljAw4k8AtMELg6
	inG7Gz+JOnDV0mhleHIvoHBYxyJFyI7901v6BlbPPK5iouwon9LWTXsbaCKBEIOH
	eimYo1z8/aAmfxm60mIIoxRFz+QEjrkNqCiCRZ+GJ9ejdR8KsVANgS51pb2xPN7c
	PxENgsIhvFIwfVK0cSmGzFd+nlsjppggHlen3kj+tEcsjeH6bQCmWkOlOu5d61Zi
	ArtvXKWsEGrwwYRd1VJG9Jo9uQVCHTZDYJdJP3/srrRK0A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjyxr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 03:37:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-81b8d38504fso174650585a.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758771470; x=1759376270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n78nIIomQavWQosZYQPTeoTh4ytOcFS5L4hdEAU6XLI=;
        b=i6JDkEnsyJn5yNRv0ypWj2bfLXB9PQhSfd4M1le3zeTpU/s++ovnCIAc9aOTZBn1Lu
         L1zfEvTlrRkyKWTAWW0plOrokJ/hlewqsBbLGQfIVNYj5E6szDjG6qsyj54/tEWg2gQZ
         J/128++c+hlqprUhWlVrIo91ekghUups2/8tA1Zyo08cv5u3w0hDCsWW8vxrU5ZrBeyG
         0OPHNm+0UuY+4SHYBWQwtPqaWRxNAY0pIuHugv28w1yXfG3wUOXo4dvzK2PnU2dY9826
         0NpwFzNG8HALfRPqPaiM9KVCbUnwPMAppR7U/7rx/ga2gWY7lPIj6d5St4U84TvAw0aH
         vnLw==
X-Forwarded-Encrypted: i=1; AJvYcCUvIXPsrLiPUJaDHLU8uLeHJs6+FjkSpbXqjGkaCRotKYioIpE1Kzc/vZZTX/fWJ4rsH/jFDVQzNWUvOr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNRFyI1TADektW16IrI5hgoEVeJqN1Dhnm9hBnbfvzJ5y5xeO
	3UUSjR02sHGL1tw2Evz16dTTMmnJPOSGZuviuI0t6UKt17uFsslSHetptDjVbF/ySP3eCg0SkWu
	wpRI2FebmG0OKdDGPRLPbaVyWU8YijWIWCv3Kqu7fYBLzPZDl40HaEPbF8gXiQ/0Xu2g=
X-Gm-Gg: ASbGncsjp7QckTPbuqx+5++tzt3gqEayIdFSlHks0oNhB2wsDGXgnGgjZ67PgzV0cn4
	PbJxpbxvgKRCMyEqayNi6qrzQW4GKZQmiEeMN0mcahHQudG/1V5/ii8FhrQDd4Mx+9UPe60rT4K
	aTYZeOmHvnypd0upwZCWdEnF8BvVNNNIfu+igrCMekN6/kBFXTfXCvBEdoxXb8hyfhZvfpbJ5au
	GhJH0xr2IgExnRgtMOSsu/z+nbp30qy10GfLUcyj4y1lVR62QWVDVsN1AhHjksaNTUz4FM9Z9i2
	sK2bWC6qI0a/XbmHfAqsOPjq4MxDf+suCPx3Dp273qMCIQPle+w4VCp6cIpIV9zFgYBw+QmGKoZ
	9WlG8f+AESnew79YxpsNqTQehUtm+RNsvP3z++0Sk7bQQVNX+abDp
X-Received: by 2002:a05:620a:2907:b0:80a:72d7:f0cd with SMTP id af79cd13be357-85aed8cbc11mr225517085a.56.1758771469852;
        Wed, 24 Sep 2025 20:37:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Mkya6v8AWWGYf6q1L7jR77pkQxfEZnuvWyLMjPjoG8YIV9rwp0IrPi1ugpz+EuhpXNM8VQ==
X-Received: by 2002:a05:620a:2907:b0:80a:72d7:f0cd with SMTP id af79cd13be357-85aed8cbc11mr225513785a.56.1758771469267;
        Wed, 24 Sep 2025 20:37:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb7bfb413sm2245821fa.56.2025.09.24.20.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 20:37:47 -0700 (PDT)
Date: Thu, 25 Sep 2025 06:37:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, jingoohan1@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, hjc@rock-chips.com, heiko@sntech.de,
        andy.yan@rock-chips.com, dianders@chromium.org,
        m.szyprowski@samsung.com, luca.ceresoli@bootlin.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 10/17] drm/bridge: analogix_dp: Apply
 drm_bridge_connector helper
Message-ID: <ykj7xrnpagbtftr7wt2vkyc4d4u4k5nmxsir433jzz7lhc3oq3@gaq4kicsrlpr>
References: <20250912085846.7349-1-damon.ding@rock-chips.com>
 <20250912085846.7349-11-damon.ding@rock-chips.com>
 <tsgfxlkxty653crmzmwsr7p6slf27pxf6n6to5p7zvi6wsl444@525tz5uhbj44>
 <2870c278-3c65-4d8f-ace3-1fd5b03af2b4@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2870c278-3c65-4d8f-ace3-1fd5b03af2b4@rock-chips.com>
X-Proofpoint-ORIG-GUID: v7riDoeqjMvMpjiXLZht1p-3X8EQQf2t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX6eV0uuyP5w/Q
 unXtzirfoperTTG6hNMVsv0yfkcFVJ/4nyCr3Hr+0t/LuT0xSWPsQd7rTE240jH0psMpi+i2uTj
 GSG8w4ELNQ6HwygZZMsiK1MKXfhjMXAjYtosYnrWc0Jj07VtVlXt1J595hcvxYjhExfsA4g7xsg
 vfPARk1q/0mGD2fmwso/s4VCiYpgcipBlvPAyebnFxQHNv2nfaCLbnwqw3RG6GNCQHFTEBeKSdT
 qGi6hyxe2/VhR8FawVRnJ3Y47EC7xRf9Z7GKMrcFAS41GMsPZIRmtQSCtExmrfF/m9XP8y63Qnr
 qLNLvGy57iGEy95yCC5AXqGQmyOqzf3LMLKAEkI2F/zRI6sj9nIaAQAxEBLfqjq6Z63BeohfgwM
 90I4Hxk6
X-Proofpoint-GUID: v7riDoeqjMvMpjiXLZht1p-3X8EQQf2t
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d4b90f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=e-wIutcIwHs2mBw2ZVAA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

On Wed, Sep 24, 2025 at 05:14:57PM +0800, Damon Ding wrote:
> Hi Dmitry,
> 
> On 9/12/2025 7:03 PM, Dmitry Baryshkov wrote:
> > On Fri, Sep 12, 2025 at 04:58:39PM +0800, Damon Ding wrote:
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
> > > 
> > > Changes in v5:
> > > - Set the flag fo drm_bridge_attach() to DRM_BRIDGE_ATTACH_NO_CONNECTOR
> > >    for next bridge attachment of Exynos side.
> > > - Distinguish the &drm_bridge->ops of Analogix bridge based on whether
> > >    the downstream device is a panel, a bridge or neither.
> > > - Remove the calls to &analogix_dp_plat_data.get_modes().
> > > ---
> > >   .../drm/bridge/analogix/analogix_dp_core.c    | 151 ++++++++----------
> > >   .../drm/bridge/analogix/analogix_dp_core.h    |   1 -
> > >   drivers/gpu/drm/exynos/exynos_dp.c            |  25 +--
> > >   .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  11 +-
> > >   include/drm/bridge/analogix_dp.h              |   3 +-
> > >   5 files changed, 95 insertions(+), 96 deletions(-)
> > > 
> > > @@ -1532,6 +1487,7 @@ EXPORT_SYMBOL_GPL(analogix_dp_resume);
> > >   int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
> > >   {
> > > +	struct drm_bridge *bridge = &dp->bridge;
> > >   	int ret;
> > >   	dp->drm_dev = drm_dev;
> > > @@ -1545,7 +1501,23 @@ int analogix_dp_bind(struct analogix_dp_device *dp, struct drm_device *drm_dev)
> > >   		return ret;
> > >   	}
> > > -	ret = drm_bridge_attach(dp->encoder, &dp->bridge, NULL, 0);
> > > +	if (dp->plat_data->panel)
> > > +		/* If the next is a panel, the EDID parsing is checked by the panel driver */
> > > +		bridge->ops = DRM_BRIDGE_OP_MODES | DRM_BRIDGE_OP_DETECT;
> > > +	else if (dp->plat_data->next_bridge)
> > > +		/* If the next is a bridge, the supported operations depend on the next bridge */
> > > +		bridge->ops = 0;
> > 
> > And what if the next bridge is dp_connector without a separate HPD pin?
> 
> This case was indeed not taken into account.
> 
> If the next is a bridge, it should be better to set DRM_BRIDGE_OP_DETECT and
> return connector_status_connected in analogix_dp_bridge_detect(). This
> ensures the connection status remains connected for both the dp-connector
> and the bridges without DRM_BRIDGE_OP_DETECT.

Maybe OP_EDID | OP_DETECT? I think, we need to fix drm_bridge_connector
to stop preferring OP_EDID bridges over OP_MODES if the latter one is
enountered later in the chain. In other words inside
drm_bridge_connector_init() clear bridge_edid if OP_MODES is encountered
and vice versa. This way you can always declare OP_EDID here (after
converting to panel bridge) and then letting panel's OP_MODES take over
mode declaration. Would you please include such a patch in the next
iteration?

> 
> > 
> > > +	else
> > > +		/* In DP mode, the EDID parsing and HPD detection should be supported */
> > > +		bridge->ops = DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT;
> > > +
> > > +	bridge->of_node = dp->dev->of_node;
> > > +	bridge->type = DRM_MODE_CONNECTOR_eDP;
> > > +	ret = devm_drm_bridge_add(dp->dev, &dp->bridge);
> > > +	if (ret)
> > > +		goto err_unregister_aux;
> > > +
> > > +	ret = drm_bridge_attach(dp->encoder, bridge, NULL, 0);
> > >   	if (ret) {
> > >   		DRM_ERROR("failed to create bridge (%d)\n", ret);
> > >   		goto err_unregister_aux;
> > 
> 
> Best regards,
> Damon
> 

-- 
With best wishes
Dmitry

