Return-Path: <linux-kernel+bounces-838139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FEDBAE86B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 22:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93FD24E03FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEB8242D63;
	Tue, 30 Sep 2025 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OKIFGfsA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BED821A421
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759263671; cv=none; b=QYIcMmkArymd2exorFlYZmPk/6RyPZ/o0uqZoPriMZ53B1YaWhrw5Nh0391MlHlcFHTZ/eybNtcs3QG9mAp4gQHQeiUlYzkTSXY7g2LPfrDqkFRUtZUiU9JD4gjGcyRdYXCWOA4OupKCriSVJiLwW9Yu7j6aBJXzD9AdvqKbvl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759263671; c=relaxed/simple;
	bh=rxceyoBHzvM4ZjFAVY6FkDDrXnSA/1H3WOTMIrvT6vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqUHld6yIfjpHJ71iaWSkj2HTs/QKrAprJJVA8hcFfLhAW99K71IW22QUOplFdHewa6swVzqDNL9vvoU6hDN1p7tXMaJ19F2fGhAu5W2i9RTQpkG7nTyLD+vBntRxA8mOgZWvN9ph/+5YojkRheGjrRpLUBrsroE/OehhLKpTmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OKIFGfsA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UC0stc015093
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+VFb0crc/qOwGeBvP/JtK6gr
	pmOtlDvuwQF4VkTnYOY=; b=OKIFGfsAMS6m9Xdz77R/OpPAtDirEHauS58EhqBK
	TFdGF65sxJhhca0WWxoGIJzqTzensMRHi1C4MUxrjEccLsQPnreEXG/IYa96Epp5
	vp2O/DWSYZSHs/H1Tcw4yEavtsgQB+LCBGFbhwfq7vmCvhoch6shAXdozWriH1vd
	SGRy2WHwYItvrIRcm2jYNTe/BAZROnuMzfXh79HwM4h/oA7e5RSs1p7Hxtx0y+wD
	0MlAkDlzFu54pcauGfmFnSyJJB/MwnHpl+KEvIaoUsXbqsuwFSOQZWe3U0MkjR9q
	xp1n2t3tcxIZ6Pg9Z+nVVQS/wRiH2YNRsJxFZecGEJpOSQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr2bb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 20:21:08 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e1015c48c8so5103071cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759263667; x=1759868467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VFb0crc/qOwGeBvP/JtK6grpmOtlDvuwQF4VkTnYOY=;
        b=KHNIGF7k73BclS26DZkxjJgviCYqcQhDz+NJVEfPVOKebKIeIiWXnbRhw4KXIA/YMq
         BtuAqUVTmbkYpfvViaaRZqgKi3BbQaMB1SFnswac+45a0HzclyLF3ENR/3/eSJtLR0vZ
         DYGcVb7ftIjgrNo65+nZ4MOTZUvud7bxiweLgpkbGiPWac4t+Fzqwjktavlkc0jsFVEM
         OniKUPhRIAXt05itraWSYcBI7GOa6mzZdWhac/c2nbmTEC41Q3o9bv2jsysGXzZAduwl
         wBjdHVopq17XMiD7CFiy9a7aCG6584CbCNyH7Ko72Kt+Si0lvymtZ5/1Zh4Ju6aj7XyH
         45YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvDJs4SkHEztfZrkLMLUdXSW8IaHNLr5nzybOQY6luOjaVbeAeWGNuqwYquJ4/u9Hj8leO1YiSN4J5EGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZjjZbVHf6ws59k7afVzhmm5PrSMw7GtbsKDaHb1gmDxJpj0y8
	A9iOzdwN8n+4MAiuVgX6kzb8Q3GZaKmpHgREqGvDXfmGGJHOVnW8DJYK25C0mYdeDkCGTUoMZuA
	rnBCsLPAsuP15nS5GDnXtBDNNVdP3bEkufW5WcAHzXzm9U88MMtGa1iSyJO/BaVWsv8Y=
X-Gm-Gg: ASbGncsifHCQe8qAH7HDKxWsss1gToMXio5a+tSJljUmu/amFcf8hcPONEl63gFzCcr
	YsZWQbjE9e4yzBeACtGnNmOYDRSNDAwt+ECqIe+yhL5MA5gIi+8gHcr+JPC6hWW3iiLZLO9RrD3
	zs1uGTnAa0e/ahoJWR86o+83j1TH5ScIgPvADnSUp1H1OsRYANE2bTGbHPa0x6qI7VPcvNVrznG
	t4bodtxqE7LmTbfOiY6TPZd5BVdvjAdfRKcNkoCRnnGTyNO7gb5gunHGNMHrDcrVo91FbLR5ag1
	0jQkQiRJ4tS6+Fmkgb0h1zsBfE65iY7qxLj+MV5XrBpJst7Z3FUDtYJLEO0LLost4Bnh5lpsGap
	bzrIVjIrb5rs4cBD4QnbJNmHVqoYSAeRJ1+4T876bS3yshz9cqVZqKJRydg==
X-Received: by 2002:a05:622a:5d4:b0:4b2:8ac4:f097 with SMTP id d75a77b69052e-4e27faf2456mr85876531cf.33.1759263667346;
        Tue, 30 Sep 2025 13:21:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs3xT3p2rzPd59HRBIpsMj0tVPI+tZJQCN5NZbJA76QgFcZCY2wPZXNF7YjDhP63JSlWg6Kw==
X-Received: by 2002:a05:622a:5d4:b0:4b2:8ac4:f097 with SMTP id d75a77b69052e-4e27faf2456mr85875861cf.33.1759263666813;
        Tue, 30 Sep 2025 13:21:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58316a32113sm5289277e87.102.2025.09.30.13.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:21:05 -0700 (PDT)
Date: Tue, 30 Sep 2025 23:21:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        simona@ffwll.ch, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
        alim.akhtar@samsung.com, jingoohan1@gmail.com, p.zabel@pengutronix.de,
        hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
        dianders@chromium.org, m.szyprowski@samsung.com,
        luca.ceresoli@bootlin.com, jani.nikula@intel.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 11/18] drm/display: bridge_connector: Ensure last
 bridge determines EDID/modes detection capabilities
Message-ID: <4r25h5uaamfkprrmvrtdqfjlcgcnkfyca2o5q53hteta7rlrbq@xqlrjxhi7z2u>
References: <20250930090920.131094-1-damon.ding@rock-chips.com>
 <20250930090920.131094-12-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930090920.131094-12-damon.ding@rock-chips.com>
X-Proofpoint-GUID: lL2P_JWQXzb8KQibtZgJ11zb3r-_LY_h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX8xu0RS6po6iq
 1RHZ+TmGcV4sILFoD9kPUGNsF1cpz7qbEBKQxsDS/ruz9DhfQCGYxp1aMqcN+XvF60sRIhP0sYa
 HJreTdoarnJiwwg6AA5XUcz2AesPcpMhGvaAwyHlE18XZqV5DQ9qmci3l5GKngfbSi6ooeDkuu5
 zHn0ZEgEC1qXxKYyPaJ3BnzCr94KfFSv1McpKi6pu7e0ZJfMDRKkb22ZHMUtjCojZXZm3AVreQg
 Z7wq2bsblutGIHu48Uv1nZ8tH9rYA+N9aK1xP+sjrs+3hrlJHdMmsZb5ANE1Mji9liY5VSNbbh5
 edmwhMKvistNXuwXqMlIoDZOD8sj9MrNfVUXlpbLoQ4s1nEhgbsUCh5GbPblrCJfPOp2URYfs6u
 p52GKWYQ+JgCpRZmsg/scsmKSj34lA==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68dc3bb4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=s8YR1HE3AAAA:8 a=EUspDBNiAAAA:8 a=2L4VR2zxEnLzMnak7dgA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-ORIG-GUID: lL2P_JWQXzb8KQibtZgJ11zb3r-_LY_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017

On Tue, Sep 30, 2025 at 05:09:13PM +0800, Damon Ding wrote:
> When multiple bridges are present, EDID detection capability
> (DRM_BRIDGE_OP_EDID) takes precedence over modes detection
> (DRM_BRIDGE_OP_MODES). To ensure the above two capabilities are
> determined by the last bridge in the chain, we handle three cases:
> 
> Case 1: The later bridge declares only DRM_BRIDGE_OP_MODES
>  - If the previous bridge declares DRM_BRIDGE_OP_EDID, set
>    &drm_bridge_connector.bridge_edid to NULL and set
>    &drm_bridge_connector.bridge_modes to the later bridge.
>  - Ensure modes detection capability of the later bridge will not
>    be ignored.
> 
> Case 2: The later bridge declares only DRM_BRIDGE_OP_EDID
>  - If the previous bridge declares DRM_BRIDGE_OP_MODES, set
>    &drm_bridge_connector.bridge_modes to NULL and set
>    &drm_bridge_connector.bridge_edid to the later bridge.
>  - Although EDID detection capability has higher priority, this
>    operation is for balance and makes sense.
> 
> Case 3: the later bridge declares both of them
>  - Assign later bridge as &drm_bridge_connector.bridge_edid and
>    and &drm_bridge_connector.bridge_modes to this bridge.
>  - Just leave transfer of these two capabilities as before.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../gpu/drm/display/drm_bridge_connector.c    | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

But I'd suggest pulling this to a top of the series to let others also
take a look at it.

-- 
With best wishes
Dmitry

