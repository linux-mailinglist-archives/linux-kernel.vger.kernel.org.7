Return-Path: <linux-kernel+bounces-887027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7233C370AE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5381A22A24
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDC531DDBD;
	Wed,  5 Nov 2025 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GYE5iFNC"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A51831353C;
	Wed,  5 Nov 2025 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363183; cv=none; b=Gy6TfMMdoFL3U0peHx54jsKsb2KqypCOZUM5zAkPBQ7JP+0MhaP+m24ESzl8EO9XXvmID1iURfoh4GJL4gyHZc9O44nfx27Z2ftO8dm30Dg5b0VDphH4Wqs2X8pIOjZ6sX58Z/SRsBT5Iy/SA0wRQVl2kf02JQs2nnJSJge07qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363183; c=relaxed/simple;
	bh=nUw06SpualPBrUCbreEZukSxYJFldjGiyXLqJA/+W/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTSF/C3SZHYJW08z18HuZIwjBE4AEq7oaVxtD4pvFZdVdrsNuFr/i0ywEfoXIdIMuNDse30+YypHYTcCeDu92AiMIEQVj2EhBZ4bU/34ei+y4mbtny4LEm0AmDdqmoMqiFRCBbF/kU+taQdBgSzq5yHmzpG9ju9vwSX5JFJpIiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=GYE5iFNC; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 810CA7E0;
	Wed,  5 Nov 2025 18:17:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762363057;
	bh=nUw06SpualPBrUCbreEZukSxYJFldjGiyXLqJA/+W/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GYE5iFNCFro4v8Mks7/CnxXPWRfIDY59DAKVU5nZwniLh25QUunrqQI754SbS/+vw
	 jvFGZY9x0IhNlWsrVWlR7qqo3oo34033+O32uKPTlENQT/f8sN0OUsVZ+nZgMnEbfL
	 i+VY0epv5jVCDJRTGD+us3Z7UAercYn7Wa+lfrko=
Date: Wed, 5 Nov 2025 19:19:28 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Alice Yuan <alice.yuan@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Robert Chiras <robert.chiras@nxp.com>,
	Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Hans Verkuil <hans@jjverkuil.nl>,
	Sakari Ailus <sakari.ailus@iki.fi>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v4 0/5] media: imx8qxp: add parallel camera support
Message-ID: <20251105171928.GB6046@pendragon.ideasonboard.com>
References: <20250729-imx8qxp_pcam-v4-0-4dfca4ed2f87@nxp.com>
 <20250805010822.GC24627@pendragon.ideasonboard.com>
 <aLbcpEZXm5G1Onq7@lizhi-Precision-Tower-5810>
 <20250902123920.GM13448@pendragon.ideasonboard.com>
 <aLhJDXnz9HPGrWcp@lizhi-Precision-Tower-5810>
 <aQuDSROHLGHIhtlh@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQuDSROHLGHIhtlh@lizhi-Precision-Tower-5810>

Hi Frank,

On Wed, Nov 05, 2025 at 12:03:05PM -0500, Frank Li wrote:
> On Wed, Sep 03, 2025 at 09:56:29AM -0400, Frank Li wrote:
> > On Tue, Sep 02, 2025 at 02:39:20PM +0200, Laurent Pinchart wrote:
> > > On Tue, Sep 02, 2025 at 08:01:40AM -0400, Frank Li wrote:
> > > > On Tue, Aug 05, 2025 at 04:08:22AM +0300, Laurent Pinchart wrote:
> > > > > Hi Frank,
> > > > >
> > > > > Thank you for the patches.
> > > > >
> > > > > I've quite busy these days, and I don't believe I will have time to
> > > > > review this series before coming back from OSS Europe at the beginning
> > > > > of September. Let's see if anyone on CC could volunteer.
> > > >
> > > > Laurent Pincha
> > > > 	I hope you have good time at OSS.
> > > >
> > > > 	Do you have chance to review this patch?
> > >
> > > I'm going through my mail backlog, which is really big at the moment.
> >
> > Understand.
> >
> > > I'd like someone else to volunteer to review this series. It won't scale
> > > if I have to review all NXP media patches in my spare time :-/
> >
> > Yes, but none volunteer review this in passed months. Expecially key
> > reviewer. I am reviewing i3c patches. but Not familiar v4l system yet. It
> > need scalable solution. I can help filter some common and simple problem
> > from beginning.
> 
> Laurent Pinchart:
> 
> 	Do you have chance to check this serise? this one should be related simple.
> 	This one sent at 7/29. Still not any volunteer to review it.

I'm afraid I won't have time to review this for the time being. My spare
time is already exhausted by all the other drivers I maintain upstream. 

> 	How do we move forward?

I think this is a question for the subsystem maintainers. Hans, Mauro ?

> > > > > On Tue, Jul 29, 2025 at 12:06:21PM -0400, Frank Li wrote:
> > > > > > Add parallel camera support for i.MX8 chips.
> > > > > >
> > > > > > The below patch to add new format support to test ov5640 sensor
> > > > > >    media: nxp: isi: add support for UYVY8_2X8 and YUYV8_2X8 bus codes
> > > > > >
> > > > > > The bindings and driver for parallel CSI
> > > > > >    dt-bindings: media: add i.MX parallel csi support
> > > > > >    media: nxp: add V4L2 subdev driver for parallel CSI
> > > > > >
> > > > > > DTS part need depend on previous MIPI CSI patches.
> > > > > >   https://lore.kernel.org/imx/20250522-8qxp_camera-v5-13-d4be869fdb7e@nxp.com/
> > > > > >
> > > > > >   arm64: dts: imx8: add parellel csi nodes
> > > > > >   arm64: dts: imx8qxp-mek: add parallel ov5640 camera support
> > > > > >
> > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > ---
> > > > > > Changes in v4:
> > > > > > - remove imx93 driver support since have not camera sensor module to do test now.
> > > > > >   Add it later
> > > > > > - Add new patch
> > > > > >   media: v4l2-common: Add helper function v4l_get_required_align_by_bpp()
> > > > > > - See each patche's change log for detail.
> > > > > > - Link to v3: https://lore.kernel.org/r/20250708-imx8qxp_pcam-v3-0-c8533e405df1@nxp.com
> > > > > >
> > > > > > Changes in v3:
> > > > > > - replace CSI with CPI.
> > > > > > - detail change see each patch's change logs
> > > > > > - Link to v2: https://lore.kernel.org/r/20250703-imx8qxp_pcam-v2-0-188be85f06f1@nxp.com
> > > > > >
> > > > > > Changes in v2:
> > > > > > - remove patch media: nxp: isi: add support for UYVY8_2X8 and YUYV8_2X8 bus codes
> > > > > >   because pcif controller convert 2x8 to 1x16 to match isi's input
> > > > > > - rename comaptible string to fsl,imx8qxp-pcif
> > > > > > - See each patches's change log for detail
> > > > > > - Link to v1: https://lore.kernel.org/r/20250630-imx8qxp_pcam-v1-0-eccd38d99201@nxp.com
> > > > > >
> > > > > > ---
> > > > > > Alice Yuan (2):
> > > > > >       dt-bindings: media: add i.MX parallel CPI support
> > > > > >       media: nxp: add V4L2 subdev driver for camera parallel interface (CPI)
> > > > > >
> > > > > > Frank Li (3):
> > > > > >       media: v4l2-common: Add helper function v4l_get_required_align_by_bpp()
> > > > > >       arm64: dts: imx8: add camera parallel interface (CPI) node
> > > > > >       arm64: dts: imx8qxp-mek: add parallel ov5640 camera support
> > > > > >
> > > > > >  .../devicetree/bindings/media/fsl,imx93-pcif.yaml  | 126 ++++
> > > > > >  MAINTAINERS                                        |   2 +
> > > > > >  arch/arm64/boot/dts/freescale/Makefile             |   3 +
> > > > > >  arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi     |  13 +
> > > > > >  .../boot/dts/freescale/imx8qxp-mek-ov5640-cpi.dtso |  83 +++
> > > > > >  arch/arm64/boot/dts/freescale/imx8qxp-ss-img.dtsi  |  27 +
> > > > > >  drivers/media/platform/nxp/Kconfig                 |  11 +
> > > > > >  drivers/media/platform/nxp/Makefile                |   1 +
> > > > > >  drivers/media/platform/nxp/imx-parallel-cpi.c      | 728 +++++++++++++++++++++
> > > > > >  include/media/v4l2-common.h                        |  30 +
> > > > > >  10 files changed, 1024 insertions(+)
> > > > > > ---
> > > > > > base-commit: 37a294c6211bea9deb14bedd2dcce498935cbd4e
> > > > > > change-id: 20250626-imx8qxp_pcam-d851238343c3

-- 
Regards,

Laurent Pinchart

