Return-Path: <linux-kernel+bounces-891188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93837C421C0
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050F918936BC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7541D79BE;
	Sat,  8 Nov 2025 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dXcqXRgT"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3DE3595B;
	Sat,  8 Nov 2025 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762561043; cv=none; b=usfKd/6Rf4l/JmNIuPWwKI7HKzbKYRJYZTVSlI6wSjEPV/IrRVn+HA6UZu2gO5RkAGaTdeCQK8LC/zLHf79MseLhHARDs5OJH0RtdyD9D6qzJRRYTlYvxg7ZuAXihYrdPz4kyEOdtUU3QLr2jcatvzpSIiYrmQ5xGbvFED5R8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762561043; c=relaxed/simple;
	bh=ojB+a2DTst1XfKFJV78Vgu0HOH/aW8mkmjJDGhjVS88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRHCkcDUSxFjlr4bRhv5XvZa5ut17hA+w2gPDBp9yQYh4fcLuGkMl4mKYOzlumzVf53HlGS7hzdJfbSZPmTAs1vORozaD3Rv7Dmv55VVyATicRL2VXh5v0a4CUKt1WhiY7H0kk7nn4vnS+cPJjsbj8EnBTdxCOwD76reQbeeXew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=dXcqXRgT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id D9948B3;
	Sat,  8 Nov 2025 01:15:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762560923;
	bh=ojB+a2DTst1XfKFJV78Vgu0HOH/aW8mkmjJDGhjVS88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dXcqXRgTwgvkImn2+w7CpcGZrDRAEErxLOct0yKJycod7ino1Mz20CPU13jFLfwhw
	 SRGiVrTchZun6ttRqi/Vt5PAq46h4J/1Ic/GsfoRDzHZFtDPRkJEC9Fp9svuZAy1QJ
	 vQ+2qf6TrdNxVIqT7nFWb1OummJIFJNfm+IJpSKA=
Date: Sat, 8 Nov 2025 02:17:13 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Dafna Hirschfeld <dafna@fastmail.com>, Keke Li <keke.li@amlogic.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Dan Scally <dan.scally@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Antoine Bouyer <antoine.bouyer@nxp.com>,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Michael Riesch <michael.riesch@collabora.com>
Subject: Re: [PATCH v8 4/8] media: Documentation: uapi: Add V4L2 ISP
 documentation
Message-ID: <20251108001713.GL5558@pendragon.ideasonboard.com>
References: <20251020-extensible-parameters-validation-v8-0-afba4ba7b42d@ideasonboard.com>
 <20251020-extensible-parameters-validation-v8-4-afba4ba7b42d@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020-extensible-parameters-validation-v8-4-afba4ba7b42d@ideasonboard.com>

Hi Jacopo,

Thank you for the patch.

On Mon, Oct 20, 2025 at 10:24:50AM +0200, Jacopo Mondi wrote:
> Add userspace documentation for V4L2 ISP generic parameters and
> statistics formats.
> 
> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> Reviewed-by: Michael Riesch <michael.riesch@collabora.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> ---
>  .../userspace-api/media/v4l/meta-formats.rst       |   1 +
>  Documentation/userspace-api/media/v4l/v4l2-isp.rst | 120 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  3 files changed, 122 insertions(+)
> 
> diff --git a/Documentation/userspace-api/media/v4l/meta-formats.rst b/Documentation/userspace-api/media/v4l/meta-formats.rst
> index d9868ee88a0717c1acaa4ee477eaed96a6411f73..7b758ea9eb4ac3c4b354bf8e2f319985ed9e2b37 100644
> --- a/Documentation/userspace-api/media/v4l/meta-formats.rst
> +++ b/Documentation/userspace-api/media/v4l/meta-formats.rst
> @@ -25,3 +25,4 @@ These formats are used for the :ref:`metadata` interface only.
>      metafmt-vivid
>      metafmt-vsp1-hgo
>      metafmt-vsp1-hgt
> +    v4l2-isp
> diff --git a/Documentation/userspace-api/media/v4l/v4l2-isp.rst b/Documentation/userspace-api/media/v4l/v4l2-isp.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..b53df722ed29117c3827314e844fc4de61343f40
> --- /dev/null
> +++ b/Documentation/userspace-api/media/v4l/v4l2-isp.rst
> @@ -0,0 +1,120 @@
> +.. SPDX-License-Identifier: GFDL-1.1-no-invariants-or-later
> +
> +.. _v4l2-isp:
> +
> +************************
> +Generic V4L2 ISP formats
> +************************
> +
> +ISP configuration and statistics: theory of operations
> +======================================================
> +
> +ISP configuration parameters are computed by userspace and programmed into a
> +*parameters buffer* which is queued to the ISP driver on a per-frame basis.
> +
> +ISP statistics are collected at a specific time point and drivers use them to
> +populate a *statistics buffer* which is then returned to userspace.
> +
> +The parameters and statistics buffers are organized in a driver-specific
> +way, and their data layout differs between one driver and another.
> +
> +ISP drivers generally exchange parameters and statistics with userspace through
> +a metadata output and capture node respectively, implementing the
> +:c:type:`v4l2_meta_format` interface. Each ISP driver defines one metadata
> +capture format and one metadata output format to be used on those video nodes,
> +and the buffer content layout and organization is fixed by the format definition.
> +
> +The uAPI/ABI problem
> +--------------------
> +
> +By upstreaming the metadata formats that describe the parameters and statistics
> +buffers layout, driver developers make them part of the Linux kernel ABI. As for
> +most peripherals, ISP driver development in Linux is often an iterative process,
> +in which not all of the hardware features are supported in the first version.
> +
> +The support for new features and/or bug fixes may land in the kernel at a later
> +stage and require changes to the metadata formats definition. This is
> +considered an ABI breakage that is strictly forbidden by the Linux kernel
> +policies. For this reason, any change in the ISP parameters and statistics
> +buffer layout would require defining a new metadata format.
> +
> +For these reasons Video4Linux2 has introduced support for generic ISP parameters
> +and statistics data types, designed with the goal of being:
> +
> +- Extensible: new features can be added later on without breaking the existing
> +  interface
> +- Versioned: different versions of the format can be defined without
> +  breaking the existing interface
> +
> +ISP configuration
> +=================
> +
> +Before the introduction of generic formats
> +------------------------------------------
> +
> +Metadata output formats that describe ISP configuration parameters were
> +typically realized by defining C structures that reflect the ISP registers
> +layout and get populated by userspace before queueing the buffer to the ISP.
> +Each C structure usually corresponds to one ISP *processing block*, with each
> +block implementing one of the ISP supported features.
> +
> +The number of supported ISP blocks, the layout of their configuration data are
> +fixed by the format definition, incurring in the above described uAPI/uABI
> +problem.
> +
> +Generic ISP parameters
> +----------------------
> +

Most of the text above is a design rationale that in my opinion doesn't
belong to the UAPI documentation. You already include a design rationale
in the kernel documentation, in patch 8/8. If some of the text above
contains a more verbose explanation, it could be moved there.

I would shorten all this to

************************
Generic V4L2 ISP formats
************************

Generic ISP formats are metadata formats that define a mechanism to pass ISP
parameters and statistics between userspace and drivers in V4L2 buffers. They
are designed to allow extending the data in a backward-compatible way.

ISP configuration
=================

> +The generic ISP configuration parameters format is realized by a defining a
> +single C structure that contains a header, followed by a binary buffer where
> +userspace programs a variable number of ISP configuration data block, one for
> +each supported ISP feature.
> +
> +The :c:type:`v4l2_isp_params_buffer` structure defines the parameters buffer
> +header which is followed by a binary buffer of ISP configuration parameters.
> +Userspace shall correctly populate the buffer header with the versioning

s/versioning information/extensible parameters format version/

> +information and with the size (in bytes) of the binary data buffer where it will
> +store the ISP blocks configuration.
> +
> +Each *ISP configuration block* is preceded by an header implemented by the
> +:c:type:`v4l2_isp_params_block_header` structure, followed by the configuration
> +parameters for that specific block, defined by the ISP driver specific data
> +types.
> +
> +Userspace applications are responsible for correctly populating each block's
> +header fields (type, flags and size) and the block-specific parameters.
> +
> +ISP Block enabling, disabling and configuration
> +-----------------------------------------------
> +
> +When userspace wants to configure and enable an ISP block it shall fully
> +populate the block configuration and set the V4L2_ISP_PARAMS_FL_BLOCK_ENABLE
> +bit in the block header's `flags` field.
> +
> +When userspace simply wants to disable an ISP block the
> +V4L2_ISP_PARAMS_FL_BLOCK_DISABLE bit should be set in block header's `flags`
> +field. Drivers accept a configuration parameters block with no additional
> +data after the header in this case.
> +
> +If the configuration of an already active ISP block has to be updated,
> +userspace shall fully populate the ISP block parameters and omit setting the
> +V4L2_ISP_PARAMS_FL_BLOCK_ENABLE and V4L2_ISP_PARAMS_FL_BLOCK_DISABLE bits in the
> +header's `flags` field.
> +
> +Setting both the V4L2_ISP_PARAMS_FL_BLOCK_ENABLE and
> +V4L2_ISP_PARAMS_FL_BLOCK_DISABLE bits in the flags field is not allowed and not
> +accepted.

s/and not accepted/and returns an error/

> +
> +Any further extension to the parameters layout that happens after the ISP driver

s/Any further extension/Extensions/

> +has been merged in Linux can be implemented by adding new blocks definition

s/after the ISP driver has been merged in Linux //

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> +without invalidating the existing ones.
> +
> +ISP statistics
> +==============
> +
> +Support for generic statistics format is not yet implemented in Video4Linux2.
> +
> +V4L2 ISP uAPI data types
> +========================
> +
> +.. kernel-doc:: include/uapi/linux/media/v4l2-isp.h
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d925745077f21e5a1388a30217a24beeb4fff3b5..f52237d57710cadff78b297d2b4610b508f55092 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26856,6 +26856,7 @@ V4L2 GENERIC ISP PARAMETERS AND STATISTIC FORMATS
>  M:	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/userspace-api/media/v4l/v4l2-isp.rst
>  F:	include/uapi/linux/media/v4l2-isp.h
>  
>  VF610 NAND DRIVER

-- 
Regards,

Laurent Pinchart

