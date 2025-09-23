Return-Path: <linux-kernel+bounces-828093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B8CB93EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128802A4AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C75826E715;
	Tue, 23 Sep 2025 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UqevwbKu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5550226CE2D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592711; cv=none; b=vBpDhbfXkJfjgvKvN9eOBXSThytrvxD1pqRP+oWQPniri2s/x7IVdIi7eYhcTjp8dKVwOC6piYIoeiRO2CReXYr6ep35HvCiUj0a9VJsE5Us+mYpt/so7STXtCb/0fc79MwqJdMQ6Jgab36DVmmre5B6SieRCLXf9JMMNfJDKcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592711; c=relaxed/simple;
	bh=Ez+2+z9s2cZ3Ks+zfr6d2CtjABwPPY0+0vnJRhDSqjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf6OWUqXPbZWMTRXxtduetPjnhH823Sn0ShuXXKPm4i4PbLmRINBRI7iSTaxIH260l9qhhtPJW4wXBDnhHLKbyE/pdkPLoEMPHLoneb9zFqiLlbyEGcGWME2nh5SZOufFtnZikNp7JMG6i5QViNcF4o0VIiL2XhKq6x4LatwcqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UqevwbKu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MIFBOw006485
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wjZBpcuck2b3wq2R80w3BXiH3NCwuHgMqXfKHFPCfUw=; b=UqevwbKuVrII/QtV
	nwG11NVaZ1R6HuGxJB/01OGjPm2+eEpRGoK+UolPuBI21JvO3GbVEISDIWjZKeLS
	BPENgATFfm/GL+JUgAFomijvrXZennRbZFnnHvbk937sIebZrXINrxRg6WIyt+Fx
	vLVxw5PKkSGAOif2n2Dpx93ljmphbhm1V9aoLMq8LUWysIZJ1L6bjS5+unjePSQS
	amv4yZDARGHBEzXfLp7u6kZWmkOcJkM9gyGFG1I8d5sofY5PdckFzlCeOn/DyDgZ
	NJlahtyP157t1jxmC/a2AjY+9MwqXgrQo4fZO5EBHqCobtwgW/HAXaLyzaedJuLA
	0iwkeQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98esc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:58:28 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-78e4e07aa39so83324716d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758592707; x=1759197507;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wjZBpcuck2b3wq2R80w3BXiH3NCwuHgMqXfKHFPCfUw=;
        b=sju4YdCYKThmp/aY4YRg+a9LfPfzm2oDH1+HmZjNRR1b9I4v7OI9uAvWCp2tXY2ZgD
         YNbl+LG6O3nt57evNg6PvEbRPYKWoGmXmRZpQS3Ef15zhaMrTsjSjDGVTRFS9Mt14tpV
         mHJ7y0ye7xVom7IXD6jK8OM7lxD4EKmb1Xb2hwTaYQqI19pvRtxXOYV6fBh2JW4lxJXg
         P6HpZFLcQcOlt/EJlOIB9Khos+swDTDpmKzzgiSHuLExKkVDE5PqySVkvL3YWTIFQVpM
         /Y0ijN3+NTmJikEn1G2iSNyLf4MrE7RZHvJ/KEaCozhK+UhHlCaS1aqja5hH9a7rs5ff
         R1Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUYWKW7p9YRh29ggzLAjnjEwxMW4OQgLkU1o2egYu5QDxPr0+WVjEbR61wDyRM52tWWvf2F5qAm4C8tvEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2V6cI9e6URAzK4IMnNrkB3dyCQo9es+/e5NKoj7dCY4nxlv4/
	E4vTgIw00x5yyVUW6DORLRHQcCEuwCxAcq2BlCalqhuF2YGjZcABVEG9VwYZaA0vlbWfFIMAgbD
	LjZw2ensgyMSHy16aWMf4vHCH9bxGYCc4h8NuS9EvnL1mH3zjb50LUa5TC+gmtAGs9VvWWZeyFh
	U=
X-Gm-Gg: ASbGnctgVgvH3MQL0dtJpO230fdxx8oq0CAd99qO11XvFnZJZ/KIkVFrjH6bTji8iJA
	XJI1vEX1Q731gq4Yp6eUfEzm57qLDtlOAxtbLL5lKe8JcEsJivVlEa+Xr7XsXiIcfzfEN2d4Yd1
	msqnhKMAFIEW5ZN1HVxB+xWBc51EvBNE94qlbCJxyf7yEzNTSInXHWKlLvA6WjdV8g7GdCL6hlJ
	XKl4iHC1Jt2KdJRB9yb/7Ppi7JpHRefoCgkJMSQ6NaexWefJxjYvEGHjmE/fV0/5BvBagw67w0T
	wZ8Zasc+l/48qRg5aChAQjU+1fDg43vD9spzkX3AYwQbA3TlHyzxfg+YbH0lNKcaLCy4U4hg2YR
	4LFurhFowZQdakJ+pkYrmzoWiyRYpAobVsTGxqXybAWV8HXkqlg0k
X-Received: by 2002:a05:6214:f6c:b0:78e:ea84:768f with SMTP id 6a1803df08f44-7e705d7bf47mr11043066d6.30.1758592706912;
        Mon, 22 Sep 2025 18:58:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2UHfHXJZyQ10p2X6Fpt5TanjCh8LeDMIwT7ePmjsHI9tTKDN1phKB8vhk3eST38TyWHjFsw==
X-Received: by 2002:a05:6214:f6c:b0:78e:ea84:768f with SMTP id 6a1803df08f44-7e705d7bf47mr11042766d6.30.1758592706397;
        Mon, 22 Sep 2025 18:58:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57e80683e89sm1357059e87.95.2025.09.22.18.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 18:58:25 -0700 (PDT)
Date: Tue, 23 Sep 2025 04:58:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Drew Fustini <fustini@kernel.org>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michal Wilczynski <m.wilczynski@samsung.com>,
        Han Gao <rabenda.cn@gmail.com>, Yao Zi <ziyao@disroot.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/8] drm: verisilicon: add a driver for Verisilicon
 display controllers
Message-ID: <7zswcrcfsypbd36mddslreeli2zbrn33nyqkxmwdufakhl2vgm@bb6i6zfgeznh>
References: <20250921083446.790374-1-uwu@icenowy.me>
 <20250921083446.790374-4-uwu@icenowy.me>
 <a46szgmjrwgqhv5issuijyvih4tof3xa45tdhxv4qjplekszpz@55tgbkeby7zr>
 <dacdfabb30fae413949d8bde28a709096ecda4c7.camel@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dacdfabb30fae413949d8bde28a709096ecda4c7.camel@icenowy.me>
X-Proofpoint-GUID: 8qSctXD6KnUZM64ZYVuyTfmX_oV9k9vA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX2mH3oxbadWZ5
 EWEixuYQQVvY6z14MCKLeZftlfKnjQfdhlbKj67GF/pvOH9LYRHHI7FbKUK15pePbG1u6VoNifM
 5/E40ncHDbPYIk8QkRfHUp6yJZyU7BqLqRMkEUHPpqaOaJz/P0VtNIJWBr7Ey2cNwcwQhfwQFe3
 DvXZ28jz4kgN/HaUYHPa8D7ncoRHBLsDxb5VoxIrUAhoLxE4Vl/lT/x32sKZBXzijVHcQwlwGQl
 7SfPh182TsCq22pCl73mBwyrpRB+K8HpVHK7Zr3evnQGMKXyDL/8xGBfBBEJTMZlSyAIwIWpjbt
 JWEzNTgtItwF+KnBQvgRg4kC2jo6Jx98QLkrApSX/FV56QR1qEid7ZkD0BdCivA1ZCKxbM8L5Kt
 cIRhB6DQ
X-Proofpoint-ORIG-GUID: 8qSctXD6KnUZM64ZYVuyTfmX_oV9k9vA
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d1fec4 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=ZNbfwUPgZe5FKaAedJYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

On Tue, Sep 23, 2025 at 09:10:28AM +0800, Icenowy Zheng wrote:
> 在 2025-09-23星期二的 03:53 +0300，Dmitry Baryshkov写道：
> > On Sun, Sep 21, 2025 at 04:34:41PM +0800, Icenowy Zheng wrote:
> > > This is a from-scratch driver targeting Verisilicon DC-series
> > > display
> > > controllers, which feature self-identification functionality like
> > > their
> > > GC-series GPUs.
> > > 
> > > Only DC8200 is being supported now, and only the main framebuffer
> > > is set
> > > up (as the DRM primary plane). Support for more DC models and more
> > > features is my further targets.
> > > 
> > > As the display controller is delivered to SoC vendors as a whole
> > > part,
> > > this driver does not use component framework and extra bridges
> > > inside a
> > > SoC is expected to be implemented as dedicated bridges (this driver
> > > properly supports bridge chaining).
> > > 
> > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > ---
> > > Changes in v2:
> > > - Changed some Control flows according to previous reviews.
> > > - Added missing of_node_put when checking of endpoints for output
> > > type.
> > > - Switched all userspace-visible modeset objects to be managed by
> > > drmm
> > >   instead of devm.
> > > - Utilize devm_drm_bridge_alloc() in internal bridge.
> > > - Prevented the usage of simple encoder helpers by passing a NULL
> > > funcs pointer.
> > > - Let devm enable clocks when getting them.
> > > - Removed explicit `.cache_type = REGCACHE_NONE` in regmap config.
> > > - Fixed a debug print using a variable before initialization.
> > > - Fixed a wrong index when using bulk to handle resets.
> > > - Added missing configuration for DPI format (currently fixed
> > > RGB888).
> > > 
> > >  drivers/gpu/drm/Kconfig                       |   2 +
> > >  drivers/gpu/drm/Makefile                      |   1 +
> > >  drivers/gpu/drm/verisilicon/Kconfig           |  15 +
> > >  drivers/gpu/drm/verisilicon/Makefile          |   5 +
> > >  drivers/gpu/drm/verisilicon/vs_bridge.c       | 330
> > > ++++++++++++++++++
> > >  drivers/gpu/drm/verisilicon/vs_bridge.h       |  40 +++
> > >  drivers/gpu/drm/verisilicon/vs_bridge_regs.h  |  54 +++
> > >  drivers/gpu/drm/verisilicon/vs_crtc.c         | 217 ++++++++++++
> > >  drivers/gpu/drm/verisilicon/vs_crtc.h         |  29 ++
> > >  drivers/gpu/drm/verisilicon/vs_crtc_regs.h    |  60 ++++
> > >  drivers/gpu/drm/verisilicon/vs_dc.c           | 205 +++++++++++
> > >  drivers/gpu/drm/verisilicon/vs_dc.h           |  39 +++
> > >  drivers/gpu/drm/verisilicon/vs_dc_top_regs.h  |  27 ++
> > >  drivers/gpu/drm/verisilicon/vs_drm.c          | 177 ++++++++++
> > >  drivers/gpu/drm/verisilicon/vs_drm.h          |  29 ++
> > >  drivers/gpu/drm/verisilicon/vs_hwdb.c         | 150 ++++++++
> > >  drivers/gpu/drm/verisilicon/vs_hwdb.h         |  29 ++
> > >  drivers/gpu/drm/verisilicon/vs_plane.c        | 102 ++++++
> > >  drivers/gpu/drm/verisilicon/vs_plane.h        |  68 ++++
> > >  .../gpu/drm/verisilicon/vs_primary_plane.c    | 157 +++++++++
> > >  .../drm/verisilicon/vs_primary_plane_regs.h   |  53 +++
> > >  21 files changed, 1789 insertions(+)
> > >  create mode 100644 drivers/gpu/drm/verisilicon/Kconfig
> > >  create mode 100644 drivers/gpu/drm/verisilicon/Makefile
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_bridge.c
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_bridge.h
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_bridge_regs.h
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.c
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc.h
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_crtc_regs.h
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc.c
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc.h
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_dc_top_regs.h
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_drm.c
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_drm.h
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_hwdb.c
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_hwdb.h
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.c
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_plane.h
> > >  create mode 100644 drivers/gpu/drm/verisilicon/vs_primary_plane.c
> > >  create mode 100644
> > > drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
> > > 
> > > +
> > > +static int vs_bridge_atomic_check(struct drm_bridge *bridge,
> > > +                                 struct drm_bridge_state
> > > *bridge_state,
> > > +                                 struct drm_crtc_state
> > > *crtc_state,
> > > +                                 struct drm_connector_state
> > > *conn_state)
> > > +{
> > > +       struct vs_bridge *vbridge =
> > > drm_bridge_to_vs_bridge(bridge);
> > > +
> > > +       if (vbridge->intf == VSDC_OUTPUT_INTERFACE_DP &&
> > > +           !vs_bridge_out_dp_fmt_supported(bridge_state-
> > > >output_bus_cfg.format))
> > > +               return -EINVAL;
> > 
> > I still think that it's better to have per-interface type bridge
> > funcs
> > rather than checking for the interface type inside the function.
> > 
> > > +
> > > +       vbridge->output_bus_fmt = bridge_state-
> > > >output_bus_cfg.format;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +
> > > +       bridge = devm_drm_bridge_alloc(drm_dev->dev, struct
> > > vs_bridge, base,
> > > +                                      &vs_bridge_funcs);
> > > +       if (!bridge)
> > > +               return ERR_PTR(-ENOMEM);
> > > +
> > > +       bridge->crtc = crtc;
> > > +       bridge->intf = intf;
> > > +       bridge->next = next;
> > > +
> > > +       if (intf == VSDC_OUTPUT_INTERFACE_DPI)
> > > +               enctype = DRM_MODE_ENCODER_DPI;
> > > +       else
> > > +               enctype = DRM_MODE_ENCODER_NONE;
> > 
> > Nit: DRM_MODE_ENCODER_TMDS ?
> 
> The DC it self never encodes TMDS, and although most SoC connect the DP
> interface to HDMI TX controllers, it's theortically to use other
> bridges here (e.g. DP TX controllers).

But NONE also doesn't sound completely correct here. Anyway, this is
really a minor thing, so feel free to ignore this comment.

> 
> > 
> > > +
> > > +       bridge->enc = drmm_plain_encoder_alloc(drm_dev, NULL,
> > > enctype, NULL);
> > > +       if (IS_ERR(bridge->enc)) {
> > > +               dev_err(drm_dev->dev,
> > > +                       "Cannot initialize encoder for output
> > > %u\n", output);
> > > +               ret = PTR_ERR(bridge->enc);
> > > +               return ERR_PTR(ret);
> > > +       }
> > > +
> > > +       bridge->enc->possible_crtcs = drm_crtc_mask(&crtc->base);
> > > +
> > > +       ret = drm_bridge_attach(bridge->enc, &bridge->base, NULL,
> > > +                               DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> > > +       if (ret) {
> > > +               dev_err(drm_dev->dev,
> > > +                       "Cannot attach bridge for output %u\n",
> > > output);
> > > +               return ERR_PTR(ret);
> > > +       }
> > > +
> > > +       bridge->conn = drm_bridge_connector_init(drm_dev, bridge-
> > > >enc);
> > > +       if (IS_ERR(bridge->conn)) {
> > > +               dev_err(drm_dev->dev,
> > > +                       "Cannot create connector for output %u\n",
> > > output);
> > > +               ret = PTR_ERR(bridge->conn);
> > > +               return ERR_PTR(ret);
> > > +       }
> > > +       drm_connector_attach_encoder(bridge->conn, bridge->enc);
> > > +
> > > +       return bridge;
> > > +}
> > 
> > Other than that LGTM.
> > 
> 

-- 
With best wishes
Dmitry

