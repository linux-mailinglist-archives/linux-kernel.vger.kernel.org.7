Return-Path: <linux-kernel+bounces-760140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0EDB1E705
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F6D18969B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751C325CC62;
	Fri,  8 Aug 2025 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gg+FaaDE"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9852754739
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754651724; cv=none; b=ie4Q1+DpOj1iKe3rRBDxnJMoPjGMRqHROOjKxfMKkPpbH6zXjV9qmXBoblHjWr/DIyTZPLX22KojovE4lNpYR7ORqrWG+0XnceBYYRk/UJW0Cg5kNzF9qU+QX/9ClHPd36YbJ7Hw/cX9hW8Y/zSQe1ArmuiQQ6mxL0xcXEtcIRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754651724; c=relaxed/simple;
	bh=kVIGxRmpFWXiRvc5mNgCHRtqlqyc4fpy/RJqNu7XK80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PgcsfLmwhsLIGLAEkTioN/B3k+QUwEtoi8nSlVsbe4Vduok+fQyYAVf9swBfKIDXMKJD0/k5gF0aO8aGI8rLKTj1xqYfGfURYrdgLd9ENxUMgx9ALZMzuTeM0am+8SZ2yVd0QxptmcXGKdwxzE7iRCXjsZ3QIqfSuoNCJy2QeL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gg+FaaDE; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C3FE416B8;
	Fri,  8 Aug 2025 13:14:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1754651670;
	bh=kVIGxRmpFWXiRvc5mNgCHRtqlqyc4fpy/RJqNu7XK80=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gg+FaaDErK5aOhPABlQDHksVzeSIrSlVYfFZ21lW/pDuCbQtcjWSEYRW10yQ4gJ5i
	 fuBBxAl+GUb1i5y3uWWhdpHhFVBrceeSmGR/dOJyIs1cp21Ve918U7+BFvL/699XsI
	 W0C6lK2+LPmSCbKXQ3S4xCYF9XI8ZzjddmoWnvik=
Message-ID: <e239f4e3-ebe8-44ab-abcb-6bab191a9994@ideasonboard.com>
Date: Fri, 8 Aug 2025 14:15:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/11] drm: Add new pixel formats for Xilinx Zynqmp
To: Vishal Sagar <vishal.sagar@amd.com>,
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Pekka Paalanen <ppaalanen@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>
References: <20250425-xilinx-formats-v5-0-c74263231630@ideasonboard.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <20250425-xilinx-formats-v5-0-c74263231630@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

Any further comments on this series? Can we get this merged?

 Tomi

On 25/04/2025 14:01, Tomi Valkeinen wrote:
> Add new DRM pixel formats and add support for those in the Xilinx zynqmp
> display driver.
> 
> All other formats except XVUY2101010 are already supported in upstream
> gstreamer, but gstreamer's kmssink does not have the support yet, as it
> obviously cannot support the formats without kernel having the formats.
> 
> Xilinx has support for these formats in their BSP kernel, and Xilinx has
> a branch here, adding the support to gstreamer kmssink:
> 
> https://github.com/Xilinx/gst-plugins-bad.git xlnx-rebase-v1.18.5
> 
> New formats added:
> 
> DRM_FORMAT_Y8
> - 8-bit Y-only
> - fourcc: "GREY"
> - gstreamer: GRAY8
> 
> DRM_FORMAT_Y10_P32
> - 10-bit Y-only, three pixels packed into 32-bits
> - fourcc: "YPA4"
> - gstreamer: GRAY10_LE32
> 
> DRM_FORMAT_XV15
> - Like NV12, but with 10-bit components
> - fourcc: "XV15"
> - gstreamer: NV12_10LE32
> 
> DRM_FORMAT_XV20
> - Like NV16, but with 10-bit components
> - fourcc: "XV20"
> - gstreamer: NV16_10LE32
> 
> DRM_FORMAT_X403
> - 10-bit planar 4:4:4, with three samples packed into 32-bits
> - fourcc: "X403"
> - gstreamer: Y444_10LE32
> 
> XVUY2101010
> - 10-bit 4:4:4, one pixel in 32 bits
> - fourcc: "XY30"
> 
> Some notes:
> 
> I know the 8-bit greyscale format has been discussed before, and the
> guidance was to use DRM_FORMAT_R8. While I'm not totally against that, I
> would argue that adding DRM_FORMAT_Y8 makes sense, as:
> 
> 1) We can mark it as 'is_yuv' in the drm_format_info, and this can help
>    the drivers handle e.g. full/limited range. Probably some hardware
>    handles grayscale as a value used for all RGB components, in which case
>    R8 makes sense, but when the hardware handles the Y-only pixels as YCbCr,
>    where Cb and Cr are "neutral", it makes more sense to consider the
>    format as an YUV format rather than RGB.
> 
> 2) We can have the same fourcc as in v4l2. While not strictly necessary,
>    it's a constant source of confusion when the fourccs differ.
> 
> 3) It (possibly) makes more sense for the user to use Y8/GREY format
>    instead of R8, as, in my experience, the documentation usually refers
>    to gray(scale) format or Y-only format.
> 
> As we add new Y-only formats, it makes sense to have similar terms, so
> we need to adjust the Y10_P32 format name accordingly.
> 
> I have made some adjustments to the formats compared to the Xilinx's
> branch. E.g. The DRM_FORMAT_Y10_P32 format in Xilinx's kmssink uses
> fourcc "Y10 ", and DRM_FORMAT_Y10. I didn't like those, as the format is
> a packed format, three 10-bit pixels in a 32-bit container, and I think
> Y10 means a 10-bit pixel in a 16-bit container.
> 
> Generally speaking, if someone has good ideas for the format define
> names or fourccs, speak up, as it's not easy to invent good names =).
> That said, keeping them the same as in the Xilinx trees will, of course,
> be slightly easier for the users of Xilinx platforms.
> 
> I made WIP additions to modetest to support most of these formats,
> partially based on Xilinx's code:
> 
> https://github.com/tomba/libdrm.git xilinx
> 
> A few thoughts about that:
> 
> modetest uses bo_create_dumb(), and as highlighted in recent discussions
> in the kernel list [1], dumb buffers are only for RGB formats. They may
> work for non-RGB formats, but that's platform specific. None of the
> formats I add here are RGB formats. Do we want to go this way with
> modetest?
> 
> I also feel that the current structure of modetest is not well suited to
> more complicated formats. Both the buffer allocation is a bit more
> difficult (see "Add virtual_width and pixels_per_container"), and the
> drawing is complicated (see, e.g., "Add support for DRM_FORMAT_XV15 &
> DRM_FORMAT_XV20").
> 
> I have recently added support for these Xilinx formats to both kms++ [2] and
> pykms/pixutils [3][4] (WIP), and it's not been easy... But I have to say I
> think I like the template based version in kms++. That won't work in
> modetest, of course, but a non-templated version might be implementable,
> but probably much slower.
> 
> In any case, I slighly feel it's not worth merging the modetest patches
> I have for these formats: they complicate the code quite a bit, break
> the RGB-only rule, and I'm not sure if there really are (m)any users. If
> we want to add support to modetest, I think a bigger rewrite of the test
> pattern code might be in order.
> 
> [1] https://lore.kernel.org/all/20250109150310.219442-26-tzimmermann%40suse.de/
> [2] git@github.com:tomba/kmsxx.git xilinx
> [3] git@github.com:tomba/pykms.git xilinx
> [4] git@github.com:tomba/pixutils.git xilinx
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
> Changes in v5:
> - Add comment about Y-only formats, clarifying how the display pipeline
>   handles them (they're handled as YCbCr, with Cb and Cr as "neutral")
> - Clarify X403 format in the patch description
> - Set unused Y-only CSC offsets to 0 (instead of 0x1800).
> - Add R-bs
> - Link to v4: https://lore.kernel.org/r/20250326-xilinx-formats-v4-0-322a300c6d72@ideasonboard.com
> 
> Changes in v4:
> - Reformat the drm_format_info entries a bit
> - Calculate block size only once in drm_format_info_bpp()
> - Declare local variables in separate lines
> - Add review tags
> - Fix commit message referring to Y10_LE32 (should be Y10_P32)
> - Link to v3: https://lore.kernel.org/r/20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com
> 
> Changes in v3:
> - Drop "drm: xlnx: zynqmp: Fix max dma segment size". It is already
>   pushed.
> - Add XVUY2101010 format.
> - Rename DRM_FORMAT_Y10_LE32 to DRM_FORMAT_Y10_P32.
> - Link to v2: https://lore.kernel.org/r/20250115-xilinx-formats-v2-0-160327ca652a@ideasonboard.com
> 
> Changes in v2:
> - I noticed V4L2 already has fourcc Y10P, referring to MIPI-style packed
>   Y10 format. So I changed Y10_LE32 fourcc to YPA4. If logic has any
>   relevance here, P means packed, A means 10, 4 means "in 4 bytes".
> - Added tags to "Fix max dma segment size" patch
> - Updated description for "Add warning for bad bpp"
> - Link to v1: https://lore.kernel.org/r/20241204-xilinx-formats-v1-0-0bf2c5147db1@ideasonboard.com
> 
> ---
> Tomi Valkeinen (11):
>       drm/fourcc: Add warning for bad bpp
>       drm/fourcc: Add DRM_FORMAT_XV15/XV20
>       drm/fourcc: Add DRM_FORMAT_Y8
>       drm/fourcc: Add DRM_FORMAT_Y10_P32
>       drm/fourcc: Add DRM_FORMAT_X403
>       drm/fourcc: Add DRM_FORMAT_XVUY2101010
>       drm: xlnx: zynqmp: Use drm helpers when calculating buffer sizes
>       drm: xlnx: zynqmp: Add support for XV15 & XV20
>       drm: xlnx: zynqmp: Add support for Y8 and Y10_P32
>       drm: xlnx: zynqmp: Add support for X403
>       drm: xlnx: zynqmp: Add support for XVUY2101010
> 
>  drivers/gpu/drm/drm_fourcc.c       | 28 ++++++++++++++++---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 55 +++++++++++++++++++++++++++++++++++---
>  include/uapi/drm/drm_fourcc.h      | 29 ++++++++++++++++++++
>  3 files changed, 105 insertions(+), 7 deletions(-)
> ---
> base-commit: ef6517ac5cf971cfeaccea4238d9da7e2425b8b1
> change-id: 20241120-xilinx-formats-f71901621833
> 
> Best regards,


