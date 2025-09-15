Return-Path: <linux-kernel+bounces-817655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD22B584F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4B891AA7BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE41B27C842;
	Mon, 15 Sep 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EuNE+aar"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E81C215F42
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757962421; cv=none; b=TkyP6F+MMO9/nLyDKkSAiLR1nfszsITXjsGzUceGo+6XES0aZ3R+0TqupAPJG7tr6UQVEpxoqIh9okIoFShzL4lCtAOPXBkrzjaXsgyS927fvc7lytW4/21YHiQC6FoddG///w4odKhyQv+ktoKe04P+fFC+78Vfw8DfnGf+pVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757962421; c=relaxed/simple;
	bh=WaCGK7JVGkNZfy8wWvMHPjeoKB2xSuL6UkAla4ZV4uE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxhrjaL9eXf+aY0E/Umg4I91Is/z5m2HFeVAs4McmCHddsF/Z72I5NjRVVZaj1Zuxf8KwCiIIMZS43mUTHiNNOPcRmYCWEog273dgFudFTb93FlejP6e/7EOxKGr6vNNhmW2KktLAeo79Oap4/C3yjGdmINtPUxLdGMUTkxE0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EuNE+aar; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FDrBfA009023
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nMMKPwbFMSjvy9PWk7yGxyrz
	P5qxhwSObKoN7zz9Cmg=; b=EuNE+aarumICU53Pb8nbWw1vWJELMwtngsr/NFhj
	b67tH0/faAVXM8BakGNmxzZL/eduCfCUAQ5+knxk3lp63THxklrq5jhZZOsjC9c6
	rYhIyXq9WCA/I1qxRoAmbRRUj6sYT6CS738RLMZUXPU20MWvtdKAq2ZtI9mWI/jD
	5ja3P28kw8CeSkfuwXvWnghnPmgBJeKGJ0FD6Ppqlbxce14ELRdSkIDDstuJAjK9
	tXF/CWtbY9GrrQpleEC9M/mOAeomKPXO84c84sfITddHT01T2T11KX/Xirf9HDkC
	1LVewdCj0d01yUnv0q4qsbqR/EOIOnXmbrJxBfCBFbTWlQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 495eqpw0u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 18:53:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b345aff439so120778921cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757962417; x=1758567217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMMKPwbFMSjvy9PWk7yGxyrzP5qxhwSObKoN7zz9Cmg=;
        b=YyGudzJLS2MmFaSG0N+E/8CtjY5mc4oH3+8QKH1M3ydaEFrzMP1yw19G9otY1bZPhS
         CBWboMxvFVE+khveuLXgqAE4BL8OxQu5eRN/NoS0SaiztwqYm/WnA9JwRUxfP+ZStEzY
         h2Ma07BAVYBHy6vqqmKAvHSGGt+UL7doVZLdDskTOogpf2YPK78EbGR2xKxbsrCMMl7v
         A6Edkj58WRZkCMo0dgr3MoiUjBGQWXYKFcxsMlEXI7j5QvU+IiGFNRpS92wy+sDgCLra
         CAZ+vSgc16Ys/N55UhC2BF0XO3iplgAankY3JUa1zAmnLnPyjarUvMuqYD/QhaOuh/jd
         OUOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp1ZSHMI2f7LnJILDjnSUa5eSaeKQKKSF92HiqvNhOVO1KjCQp+PjC0yOFZZyJXtmMS1BM77lRCs+fS28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxI7t2ftmDGAio4Pix9tj3VP7Ev6aYMqa4/qsOV7BcQjbIHd0u
	leT1NnGsMPqDt28sCtSgy+L5IgoA6tZy6m2+wV2YiwylhRR6snQtuQ+12k1HJBqo7BEd6aCQbHW
	FxEniEQWp48a+iem4mS+FcuBnhBDPPxgesuBCG0bvRGx9/riK6pUA69M+okioE1RSmmk=
X-Gm-Gg: ASbGncurMGby6M16FXywxo5JPE+Uz/Jph1GrQgVpyZFsOLtCSeB8EGC715l9eQDHiJG
	yEjL1uuYKnXo6JoPqh3NR3GnUqxgz4tE7Mfy1YTKL6AGz11oyo2OjC8Akwb+YWWwd6k1943miOK
	JzxKmLXwOx0yL4tKvpY7hDLyGCmlgPOnt8MNCZgKuxmyCqZn/IohBeHm71QZdZO5DM3t34kwzph
	NfKQMjhwk4ImH08N7X9Beb/qVAy7sWvNGailr+Hp/MlBrXncqptdlJhM5wWXCeu2Y1oGETszg9N
	iCWb/1L/I5ycJmTj59uNcFazBeiV2loOcp2q+jwCmOiMRmM5geHad/H/hXU2BAQTps3ey0v/8rW
	ZLT9kOg7egeuSiWm/BLzP0mfJZbb0gduqpYPyJXRUTsPyB2SHlO/F
X-Received: by 2002:ac8:7d89:0:b0:4b7:95da:b3c7 with SMTP id d75a77b69052e-4b795dac12amr105744081cf.48.1757962417422;
        Mon, 15 Sep 2025 11:53:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl1bgwAg6xsiD3botpPruuj1Z5eTwC4YuXll3Zv1jmcPqXrGVhLUi0yvP8XfARs9TjfTPNrg==
X-Received: by 2002:ac8:7d89:0:b0:4b7:95da:b3c7 with SMTP id d75a77b69052e-4b795dac12amr105743251cf.48.1757962416589;
        Mon, 15 Sep 2025 11:53:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f1a8211afsm28253981fa.45.2025.09.15.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 11:53:35 -0700 (PDT)
Date: Mon, 15 Sep 2025 21:53:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Harikrishna Shenoy <h-shenoy@ti.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, simona@ffwll.ch,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, sjakhade@cadence.com, yamonkar@cadence.com,
        lumag@kernel.org, dianders@chromium.org, jani.nikula@intel.com,
        luca.ceresoli@bootlin.com, andy.yan@rock-chips.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, devarsht@ti.com, u-kumar1@ti.com,
        s-jain1@ti.com, tomi.valkeinen@ideasonboard.com
Subject: Re: [PATCH v5 2/2] drm: bridge: cdns-mhdp8546: Add support for DSC
 and FEC
Message-ID: <d6l5vwx5s5oopyhniqbc3wputceblazpry2omeja2qvak37y2m@dbge4vedh7ko>
References: <20250915103041.3891448-1-h-shenoy@ti.com>
 <20250915103041.3891448-3-h-shenoy@ti.com>
 <pwd4hocrxrnfymby6szzp7irlveoa36er7yn5ivlht5mwxrpdz@r237bd3epols>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pwd4hocrxrnfymby6szzp7irlveoa36er7yn5ivlht5mwxrpdz@r237bd3epols>
X-Proofpoint-GUID: POArYlGFtqM4MadEX1A0618qHYGtpsD4
X-Proofpoint-ORIG-GUID: POArYlGFtqM4MadEX1A0618qHYGtpsD4
X-Authority-Analysis: v=2.4 cv=XJIwSRhE c=1 sm=1 tr=0 ts=68c860b2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=e5mUnYsNAAAA:8 a=Br2UW1UjAAAA:8 a=sozttTNsAAAA:8
 a=aquk1Lx4SgTA5jucOdcA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDE4NiBTYWx0ZWRfX5XZwtceryGkZ
 ZdFlKPIC29Nc/nZmBmQv59Wzwn2fI5X94m2XYxwzAdiaRkWpT10z++Gm14kyl6Xnl8WPiAKtkch
 1GRh055L52feWlPHUC4w0Dwxx9bokm2+wMN9iXLKaOoffywGYz+ta+7CJkVTtWZ9UHpK7LEkh2E
 w66jdzphv+RDfi7fHqx7gRYGRrXtIOCYAlQE4L8ROZRE925rqmWdBgY1RnhIe/a8Leq5UpuYcRX
 thVYrd7VOdHM277u/WF7msK59JJ/H03cQWQh3/8480wm0lkE2xd2BG3braFlu6Kz2WrRDjIphzv
 Cqm8c6bBqBjDpH0swkKNbQhan+sm9D87A3/SKv8+7po/96B/RhyXw4+OiRwBKDuHvnbdXJWbQiN
 48RbpjJb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_07,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130186

On Mon, Sep 15, 2025 at 02:06:58PM +0300, Dmitry Baryshkov wrote:
> On Mon, Sep 15, 2025 at 04:00:41PM +0530, Harikrishna Shenoy wrote:
> > From: Swapnil Jakhade <sjakhade@cadence.com>
> > 
> > Enable support for Display Stream Compression (DSC) in independent
> > mode with a single stream, along with Forward Error Correction (FEC)
> > in the Cadence MHDP8546 DisplayPort controller driver.
> > 
> > FEC is required when DSC is enabled to ensure reliable transmission
> > of the compressed stream.
> > 
> > Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> > Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
> > ---
> >  drivers/gpu/drm/bridge/cadence/Makefile       |   2 +-
> >  .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 367 ++++++++-
> >  .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  68 ++
> >  .../drm/bridge/cadence/cdns-mhdp8546-dsc.c    | 695 ++++++++++++++++++
> >  .../drm/bridge/cadence/cdns-mhdp8546-dsc.h    | 285 +++++++
> >  5 files changed, 1392 insertions(+), 25 deletions(-)
> >  create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-dsc.c
> >  create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-dsc.h
> > 
> > +		goto err;
> > +	}
> > +
> > +	if (ret > 0)
> > +		return 0;
> > +err:
> > +	return ret;
> > +}
> 
> Consider extracting a common helper and using it here and in the Intel
> DP driver. Also please use new DPCD helpers which return 0 instead of
> size.

For the reference, some time ago one of my colleagues implemented DP DSC
support for the drm/msm driver. It didn't go in for multiple reasons,
but feel free to use it as an inspiration for possible generic helpers.
See https://patchwork.freedesktop.org/series/113240/


-- 
With best wishes
Dmitry

