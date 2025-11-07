Return-Path: <linux-kernel+bounces-891149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C3C41F84
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 00:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAC153AA1D5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 23:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF612314B77;
	Fri,  7 Nov 2025 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ez+Kc6Zz"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9070D21D3F8;
	Fri,  7 Nov 2025 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762558465; cv=none; b=qyenauKS9L6GUxsJ/0siqvuF7Hl/D930EXnWjkprjzrFhuwXUJDjCa8spr5nmpWjk58fyt+Tlaby+40LOkdXqJr4z27tUEiTowBl47w1JLrKuutHf0qn9W4lFGOswl4th/6qNuHThMSWozUns1wOdTALFtPaxJRFfeE19APso/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762558465; c=relaxed/simple;
	bh=v+aqR0oFDtbY2RGxbmZS4i8tsceD2wMT6FgrKxFkNuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPh+P6m4zHXhub7OMA55paY1oV+vCd0ceVaxeKQR4unluD0GKDijXBHkA+PXEE4J1e4GUN0hiD8ckk9hWKkxulHwIREPcs5eVZI3lIlYmNb+CYr/y6ueIEpdvNrQbRfwaosiif19JN3pkDfkAqEwhF/bMdVKVjM7EV5b9CeswbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ez+Kc6Zz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 129F1A8F;
	Sat,  8 Nov 2025 00:32:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762558345;
	bh=v+aqR0oFDtbY2RGxbmZS4i8tsceD2wMT6FgrKxFkNuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ez+Kc6Zz2r29s2sYFBQG5meYqDQS0uR06fGd3xSE43sTrHVbruW1AMszX9TAleTON
	 u4RbeQ8JObhaehHFv3VGDLcKakJ5LehXpt9KkbYsUSV7k7MVrQAO9q0GNU73VX/6Ib
	 4nJS82/EDBUunMnuyX6kPqAVpNiBvhX7KnNyXuzo=
Date: Sat, 8 Nov 2025 01:34:15 +0200
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
Subject: Re: [PATCH v8 8/8] media: Documentation: kapi: Add v4l2 generic ISP
 support
Message-ID: <20251107233415.GK5558@pendragon.ideasonboard.com>
References: <20251020-extensible-parameters-validation-v8-0-afba4ba7b42d@ideasonboard.com>
 <20251020-extensible-parameters-validation-v8-8-afba4ba7b42d@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020-extensible-parameters-validation-v8-8-afba4ba7b42d@ideasonboard.com>

Hi Jacopo,

Thank you for the patch.

On Mon, Oct 20, 2025 at 10:24:54AM +0200, Jacopo Mondi wrote:
> Add to the driver-api documentation the v4l2-isp.h types and
> helpers documentation.
> 
> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> Reviewed-by: Michael Riesch <michael.riesch@collabora.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> ---
>  Documentation/driver-api/media/v4l2-core.rst |  1 +
>  Documentation/driver-api/media/v4l2-isp.rst  | 49 ++++++++++++++++++++++++++++
>  MAINTAINERS                                  |  1 +
>  3 files changed, 51 insertions(+)
> 
> diff --git a/Documentation/driver-api/media/v4l2-core.rst b/Documentation/driver-api/media/v4l2-core.rst
> index ad987c34ad2a8460bb95e97adc4d850d624e0b81..a5f5102c64cca57b57b54ab95882b26286fb27de 100644
> --- a/Documentation/driver-api/media/v4l2-core.rst
> +++ b/Documentation/driver-api/media/v4l2-core.rst
> @@ -27,3 +27,4 @@ Video4Linux devices
>      v4l2-common
>      v4l2-tveeprom
>      v4l2-jpeg
> +    v4l2-isp
> diff --git a/Documentation/driver-api/media/v4l2-isp.rst b/Documentation/driver-api/media/v4l2-isp.rst
> new file mode 100644
> index 0000000000000000000000000000000000000000..150ba39b257b23e6a8ca1a348047f5b55588fbf7
> --- /dev/null
> +++ b/Documentation/driver-api/media/v4l2-isp.rst
> @@ -0,0 +1,49 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +V4L2 generic ISP parameters and statistics support
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Design rationale
> +================
> +
> +ISP configuration parameters and statistics are processed and collected by
> +drivers and exchanged with userspace through data types that usually
> +reflect the ISP peripheral registers layout.
> +
> +Each ISP driver defines its own metadata output format for parameters and
> +a metadata capture format for statistics. The buffer layout is realized by a
> +set of C structures that reflects the registers layout. The number and types
> +of C structures is fixed by the format definition and becomes part of the Linux
> +kernel uAPI/uABI interface.
> +
> +Because of the hard requirement of backward compatibility when extending the
> +user API/ABI interface, modifying an ISP driver capture or output metadata
> +format after it has been accepted by mainline is very hard if not impossible.
> +
> +It generally happens, in fact, that after the first accepted revision of an ISP
> +driver the buffers layout need to be modified, either to support new hardware
> +blocks, to fix bugs or to support different revisions of the hardware.
> +
> +Each of these situations would require defining a new metadata format, making it
> +really hard to maintain and extend drivers and requiring userspace to use
> +the correct format depending on the kernel revision in use.
> +
> +V4L2 ISP configuration parameters
> +=================================
> +
> +For these reasons, Video4Linux2 defines generic types for ISP configuration
> +parameters and statistics. Drivers are still expected to define their own
> +formats for their metadata output and capture nodes, but the buffers layout can
> +be defined using the extensible and versioned types defined by
> +include/uapi/linux/media/v4l2-isp.h.
> +
> +Drivers are expected to provide the definitions of their supported ISP blocks,
> +the control flags and the expected maximum size of a buffer.

What are the control flags here ? Is it a leftover from a previous
version ?

With this addressed,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> +
> +For driver developers a set of helper functions to assist them with validation
> +of the buffer received from userspace is available in
> +drivers/media/v4l2-core/v4l2-isp.c
> +
> +V4L2 ISP support driver documentation
> +=====================================
> +.. kernel-doc:: include/media/v4l2-isp.h
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5833f82caa7f2f734bb0e1be144ade2109b23988..cd1137c7754538d02bd72521fec6c89e082246d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26856,6 +26856,7 @@ V4L2 GENERIC ISP PARAMETERS AND STATISTIC FORMATS
>  M:	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/driver-api/media/v4l2-isp.rst
>  F:	Documentation/userspace-api/media/v4l/v4l2-isp.rst
>  F:	drivers/media/v4l2-core/v4l2-isp.c
>  F:	include/media/v4l2-isp.h

-- 
Regards,

Laurent Pinchart

