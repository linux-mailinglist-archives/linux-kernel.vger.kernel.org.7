Return-Path: <linux-kernel+bounces-812123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C7DB53342
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1EB4839D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA835322DB8;
	Thu, 11 Sep 2025 13:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gFfuzORe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DA9322C60
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596172; cv=none; b=szDxpVek/mxn+2t2Ri5JVUqb67uFEa/dO3lJ4dtmb7DzoyFF1jxDB9XXZA9Hgh4avm2oju+kckT5BBXQ2xoV4DZ7J776kj/ZRZoDW1Jalbnn1kcilV8Ga247tJjAxCcdCLQ2sYK1OQ3Mv6d5AIyXMNtCstTs0pB3IGfHo9swDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596172; c=relaxed/simple;
	bh=rcLSc7hHkh273I4IR9ngx+j8+RXCarvHAfoFY1lO9nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/d4bj55zcO0lzmKMXhGdsPK18WZkgMNNmtY3i2N+94dBUSqQQE5ZMPuef8gtL60czNBpE8OMhGaZk7PeKx8rtL5zzSNxlRwRfZ4Wn2mntk3v+7mnMARaklUsDIQ4mSrvYIVk+xDSo32Me5CXK5Et8Yb5/jsgTJp8t8GTyEdmlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gFfuzORe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BB5nP1026350
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	I8RyZQ7s9En3k+A9mP9sTd12gbOqQ8qWm+XADZfrx+w=; b=gFfuzOReeKZp9Tcv
	7BjR5bFEDvUerbezOcuNRQmikLLZAsok1Fg10+MrsDrvPocd6fG/3YuzQ3AlU0oH
	4qtkJIdvtpsUj5jkvwNtKPI9X+Xtt4rIDeRpiiEnUxvayZXFjxGGFXfJNta1d5jI
	OEcb1VicJF+NpHXLIFJgl6QFNRxl+vW4a5agw+fQfdqxylhFe7bTozn/QwjwzUCr
	dPuhbxNG7d96Dlkz6Vl53sWPIsEe06bcGoDrR1+0lY+wcQGsHZmQ+ebqn+oXyK5S
	jf+3m/pIL5s2BM8oXEQCXyvm4qOWMuWbB6eygKv9m3K5LgcHR/KagLkREhxFEWoB
	fv8qPQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0ynm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:09:29 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5449f6cacd1so899518e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:09:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757596168; x=1758200968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8RyZQ7s9En3k+A9mP9sTd12gbOqQ8qWm+XADZfrx+w=;
        b=OKr74jPJ4ZUAVszM9OybnoiyKRhnIw+ZH41ckwob6JNiFx0c871yYaIn1qV4cAvEtp
         LnOEXxLwTfzEoNrAepsUfIneDCSD/jGOZBCafuPzWliTca/zvme059ECjD2zhIU17ekT
         XQVj38eg0TbagEttgdvC+UTY4p2hjSvStph9Es+r2oV3/7jOy7eQiDfj28s8aHZR+osc
         G11G5g6IaG4kvOLr30bDcnB/sojeYG5PkfJUUOCk1BAEw/LQYRG2LxQMFlZ0x/OUjPT6
         eTQE+hx9ZLJYVkGzfW0ZGWG3ZBBF7In4I9ZmyhONXpUoCLhzPI0y/K38FiDP1obSebmz
         yJIA==
X-Forwarded-Encrypted: i=1; AJvYcCW6h9+2A0wYGKFUcB+Ict2cdeaj5ku5oEKxMEBzKPDrFcQS/msicQSZQvGaDPXsYIbtgVM8KzvNaqbuAvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKAzzudikSoEWPyqzP6fx3mBbtO0frXHhGKyAh28cDEoF/EOe2
	XRpBDQR3+4feB5l+H1WP8rNBLhSdJRVwzaRq+GP7MEA7IZIEBPGtIOYXu8p5Euvv77XdQdkWPy0
	+QKzCwtrQF8yecEic8yhziH/hEcJ8Dvh3vSGw7RnSlG4fQSknwavMIiH6FDYsWxAb8ddbYhVGTc
	M=
X-Gm-Gg: ASbGncsLz3fRgmQH4qgZI9r17ls4SEfSnqjrFW/YMmE2vZmc/Gk2Insh7ktgEeyjTHZ
	FuNmH07adeZGfRHRFq/7ddgD3hdGVBcqFTdomHuN6Py7CeGDkCbVRidMhrni/kgaNKoMq92x3e3
	+I7pLZ7LwESzMVrp0j1uOhGipShwD077kZOWgnPmPZW/suSKtHbrrkTEZrNzgqpQaeGRr3xN0Vx
	7bVdV/Aw/I2dGd9oIx6AbRvGubqstPoyZ/SVIMO1kTz1oB2ikPvpSrr+pop9RiM8jvrFk0ndquT
	mCmazG3XBGA8Ecxbp9xS3qzCkx27wXuFJD9wDRiWIV1+0NOWmZ9ci95gOiuZ+mVh4LlaXBwvDwM
	d0jJV0AoRJvkhdTKvT1glm5f/LAySrpjssMWodaxQX+NUtxNoZAWo
X-Received: by 2002:a05:6122:a13:b0:539:5cff:8070 with SMTP id 71dfb90a1353d-5472c0d490fmr6491525e0c.9.1757596167813;
        Thu, 11 Sep 2025 06:09:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd/VAt6jkDmxnGnMNUH/ZV3Br3jOJxAgjfGzfoucxUs9TbwAHF++l7wDbp7nNv5hn99Y6zAA==
X-Received: by 2002:a05:6122:a13:b0:539:5cff:8070 with SMTP id 71dfb90a1353d-5472c0d490fmr6491493e0c.9.1757596167378;
        Thu, 11 Sep 2025 06:09:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f163f51desm2799101fa.25.2025.09.11.06.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:09:25 -0700 (PDT)
Date: Thu, 11 Sep 2025 16:09:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Miguel Gazquez <miguel.gazquez@bootlin.com>
Cc: Maxime Ripard <mripard@kernel.org>, Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
        kory.maincent@bootlin.com, romain.gantois@bootlin.com, praneeth@ti.com,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: Re: [PATCH] drm/bridge: ite-it66121: Add drm_connector support
Message-ID: <2l5kp4ojrcsg2apcpv7mzeeypwynecyfesenks6zzvnst3qkbt@4yhbosy2zhah>
References: <20250909-it66121-fix-v1-1-bc79ca83df17@bootlin.com>
 <do5zciwcanpiciy52zj3nn6igmwlgmbcfdwbibv2ijxm2fif5s@ib6jhzi5h2jo>
 <6164422a-6265-4726-8da5-68bb8eafb9e6@bootlin.com>
 <20250911-innocent-daffodil-macaque-797f13@houat>
 <012046ab-d866-4b3a-8c8a-e130bc2b9628@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <012046ab-d866-4b3a-8c8a-e130bc2b9628@bootlin.com>
X-Proofpoint-ORIG-GUID: 7Grw3YmVkxsyIo8EsZtm4zbz_fh5d_w6
X-Proofpoint-GUID: 7Grw3YmVkxsyIo8EsZtm4zbz_fh5d_w6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfX27ZWTOcRvSd/
 Psa1bEbJCXO8wkSA1h/fJXmmxAsgf51o1yRzTVtqsmyJmOHnBx5flIlS2uQ4d4ukqqEymHJjO1d
 KEhKx4mFKhYqmsn2cbU5dmXUs/mAkHtmjDLBdWxuCmg6p2nNbtbb+8GBC9DEmzQ1BgZ+RIGFsvG
 EMNxKhXKQrNbpX+HMlSjzSJ0VpxU/t6rjdg/5tJeK4VdHyzzl67k8aC4vVN5g3xv1N+JjyOfs6z
 9PxF4GCxjZJPQnMUfXL4TU8/13nR/DXW1Gz38GbGf+htXYAwCOQA9uiQak09PxWLAqeFoNAL5GB
 1dtc5gqR0gagkVJk+42lKN6JJu4TS3hguTNB/gy0UVgNlNgk3YZC6g8c44oDKegsuWqz8mK42G3
 jFApf/34
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68c2ca09 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=yJojWOMRYYMA:10 a=sozttTNsAAAA:8 a=J4TtIqrawgGb-EQjl3IA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

On Thu, Sep 11, 2025 at 02:49:59PM +0200, Miguel Gazquez wrote:
> 
> 
> Le 11/09/2025 à 11:50, Maxime Ripard a écrit :
> > On Thu, Sep 11, 2025 at 10:51:06AM +0200, Miguel Gazquez wrote:
> > > 
> > > 
> > > Le 10/09/2025 à 04:28, Dmitry Baryshkov a écrit :
> > > > On Tue, Sep 09, 2025 at 06:16:43PM +0200, Miguel Gazquez wrote:
> > > > > From: Aradhya Bhatia <a-bhatia1@ti.com>
> > > > > 
> > > > > Add support for DRM connector and make the driver support the older
> > > > > format of attaching connectors onto the encoder->bridge->connector
> > > > > chain.
> > > > > This makes the driver compatible with display controller that only
> > > > > supports the old format.
> > > > > 
> > > > > [Miguel Gazquez: Rebased + made driver work with or without
> > > > > DRM_BRIDGE_ATTACH_NO_CONNECTOR]
> > > > 
> > > > What is the use case for not using DRM_BRIDGE_ATTACH_NO_CONNECTOR?
> > > 
> > > Some display controller drivers (like the tilcdc) call drm_bridge_attach
> > > without DRM_BRIDGE_ATTACH_NO_CONNECTOR, so the bridge must support both with
> > > and without DRM_BRIDGE_ATTACH_NO_CONNECTOR to be compatible with all display
> > > controllers.
> > 
> > I'd rather convert tilcdc to use DRM_BRIDGE_ATTACH_NO_CONNECTOR then.
> 
> The problem is that doing that break devicetrees using the tilcdc and a
> bridge who doesn't support DRM_BRIDGE_ATTACH_NO_CONNECTOR (there are
> multiple bridges that don't support DRM_BRIDGE_ATTACH_NO_CONNECTOR), and if
> my understanding is correct breaking devicetrees is not allowed.

How does it break devicetree? The drm_bridge_connector isn't a part of
DT.

-- 
With best wishes
Dmitry

