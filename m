Return-Path: <linux-kernel+bounces-898950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C193C565AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4263B7C5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDAD3314DE;
	Thu, 13 Nov 2025 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="e2pNzDCP"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3594626AEC;
	Thu, 13 Nov 2025 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023797; cv=none; b=AIt1IKPKEeXC70KdEMe7A/u/Y8UanL30NQ4q2b//Ao25c2RoeKp9GaxnOXf/Hk9W/pNBCEKQJz8JQUWsjG/cFvh29pR+tV2Dmebo8zWaJLOfZ25PcpnvUjAbqq9UsM8J/17w4l+6eAHZFzhaQBH3zxO2gOAK1g/2a+4S2B9cgOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023797; c=relaxed/simple;
	bh=UOgTQkkkp1H2nG+lxAD2F3Vu4CDZrPn7c+/0lcsIlNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nh4Wml6l+onoeQnGcePL98ys3caJvt0QJ1pm6Jmh5P9ff1DAo95+4BZqwbcOp1ZvUblLNsRi78OlV3Bk69AOdl3N4E2A/ivfQitrtgMdSBSbxRsKSjlM//i1uuvj5ufRUw3IQ1sXuKfWa7N3rDxHnCYFvtyg1BRakOVrSPtSgMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=e2pNzDCP; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from ideasonboard.com (93-61-96-190.ip145.fastwebnet.it [93.61.96.190])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2F1AE446;
	Thu, 13 Nov 2025 09:47:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1763023672;
	bh=UOgTQkkkp1H2nG+lxAD2F3Vu4CDZrPn7c+/0lcsIlNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e2pNzDCPZIKDkyzxxq91fglySIFiWMthPLSV9LNF9lOz2dTDZQ+7V4oqcZ9G2AnCe
	 edajj9I082V5AYHAVABC/+ZqUDMNrBU/NyWOOeQ7hrJBaWY9tpQucVXG8lTmkzlsSS
	 QMfe83hwWI37FBkLqVqWhvQplapeLjWHEQyI7xWE=
Date: Thu, 13 Nov 2025 09:49:49 +0100
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To: Antoine Bouyer <antoine.bouyer@nxp.com>
Cc: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Dafna Hirschfeld <dafna@fastmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Keke Li <keke.li@amlogic.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Dan Scally <dan.scally@ideasonboard.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Michael Riesch <michael.riesch@collabora.com>
Subject: Re: [PATCH v8 5/8] media: v4l2-core: Introduce v4l2-isp.c
Message-ID: <mowumvzl6rk2st2lwdhqfuepwm6txxrmr7praxn43tski52xox@vvgr2hyllxgz>
References: <20251020-extensible-parameters-validation-v8-0-afba4ba7b42d@ideasonboard.com>
 <20251020-extensible-parameters-validation-v8-5-afba4ba7b42d@ideasonboard.com>
 <90267077-c74c-4e05-809d-94694d162e18@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90267077-c74c-4e05-809d-94694d162e18@nxp.com>

HI Antoine

On Thu, Nov 13, 2025 at 09:19:10AM +0100, Antoine Bouyer wrote:
>
> Hi Jacopo
>
> On 10/20/25 10:24 AM, Jacopo Mondi wrote:
> >
> > Add to the V4L2 framework helper functions to support drivers when
> > validating a buffer of V4L2 ISP parameters.
> >
> > Driver shall use v4l2_isp_params_validate_buffer_size() to verify the
> > size correctness of the data received from userspace, and after having
> > copied the data to a kernel-only memory location, complete the
> > validation by calling v4l2_isp_params_validate_buffer().
> >
> > Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Reviewed-by: Michael Riesch <michael.riesch@collabora.com>
> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> > ---
> >   MAINTAINERS                        |   2 +
> >   drivers/media/v4l2-core/Kconfig    |   4 ++
> >   drivers/media/v4l2-core/Makefile   |   1 +
> >   drivers/media/v4l2-core/v4l2-isp.c | 128 +++++++++++++++++++++++++++++++++++++
> >   include/media/v4l2-isp.h           |  91 ++++++++++++++++++++++++++
> >   5 files changed, 226 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f52237d57710cadff78b297d2b4610b508f55092..5833f82caa7f2f734bb0e1be144ade2109b23988 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -26857,6 +26857,8 @@ M:      Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> >   L:     linux-media@vger.kernel.org
> >   S:     Maintained
> >   F:     Documentation/userspace-api/media/v4l/v4l2-isp.rst
> > +F:     drivers/media/v4l2-core/v4l2-isp.c
> > +F:     include/media/v4l2-isp.h
> >   F:     include/uapi/linux/media/v4l2-isp.h
> >
> >   VF610 NAND DRIVER
> > diff --git a/drivers/media/v4l2-core/Kconfig b/drivers/media/v4l2-core/Kconfig
> > index 331b8e535e5bbf33f22638b2ae8bc764ad5fc407..d50ccac9733cc39a43426ae7e7996dd0b5b45186 100644
> > --- a/drivers/media/v4l2-core/Kconfig
> > +++ b/drivers/media/v4l2-core/Kconfig
> > @@ -82,3 +82,7 @@ config V4L2_CCI_I2C
> >          depends on I2C
> >          select REGMAP_I2C
> >          select V4L2_CCI
> > +
> > +config V4L2_ISP
> > +       tristate
>
> When configured as module, there's build error:
>
> ERROR: modpost: missing MODULE_LICENSE() in
> drivers/media/v4l2-core/v4l2-isp.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in
> drivers/media/v4l2-core/v4l2-isp.o
>
> It happens when selected from an ISP driver, and ISP driver is a module.
> Then module is applied to v4l2-isp too.

Thanks for reporting it! I was about to send a pull request -.-'

I can reproduce locally

ERROR: modpost: missing MODULE_LICENSE() in drivers/media/v4l2-core/v4l2-isp.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/media/v4l2-core/v4l2-isp.o
make[3]: *** [../scripts/Makefile.modpost:147: Module.symvers] Error 1

And I've fixed it by adding:

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Jacopo Mondi <jacopo.mondi@ideasonboard.com");
MODULE_DESCRIPTION("V4L2 generic ISP parameters and statistics helpers");

Thank you!


>
> > +       depends on VIDEOBUF2_CORE
> > diff --git a/drivers/media/v4l2-core/Makefile b/drivers/media/v4l2-core/Makefile
> > index 2177b9d63a8ffc1127c5a70118249a2ff63cd759..329f0eadce994cc1c8580beb435f68fa7e2a7aeb 100644
> > --- a/drivers/media/v4l2-core/Makefile
> > +++ b/drivers/media/v4l2-core/Makefile
> > @@ -29,6 +29,7 @@ obj-$(CONFIG_V4L2_CCI) += v4l2-cci.o
> >   obj-$(CONFIG_V4L2_FLASH_LED_CLASS) += v4l2-flash-led-class.o
> >   obj-$(CONFIG_V4L2_FWNODE) += v4l2-fwnode.o
> >   obj-$(CONFIG_V4L2_H264) += v4l2-h264.o
> > +obj-$(CONFIG_V4L2_ISP) += v4l2-isp.o
> >   obj-$(CONFIG_V4L2_JPEG_HELPER) += v4l2-jpeg.o
> >   obj-$(CONFIG_V4L2_MEM2MEM_DEV) += v4l2-mem2mem.o
> >   obj-$(CONFIG_V4L2_VP9) += v4l2-vp9.o
> > diff --git a/drivers/media/v4l2-core/v4l2-isp.c b/drivers/media/v4l2-core/v4l2-isp.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..35f0b701f1729c3c0ccc34b1c89189b179e0b684
> > --- /dev/null
> > +++ b/drivers/media/v4l2-core/v4l2-isp.c
> > @@ -0,0 +1,128 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Video4Linux2 generic ISP parameters and statistics support
> > + *
> > + * Copyright (C) 2025 Ideas On Board Oy
> > + * Author: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> > + */
> > +
> > +#include <media/v4l2-isp.h>
> > +
> > +#include <linux/bitops.h>
> > +#include <linux/device.h>
> > +
> > +#include <media/videobuf2-core.h>
> > +
> > +int v4l2_isp_params_validate_buffer_size(struct device *dev,
> > +                                        struct vb2_buffer *vb,
> > +                                        size_t max_size)
> > +{
> > +       size_t header_size = offsetof(struct v4l2_isp_params_buffer, data);
> > +       size_t payload_size = vb2_get_plane_payload(vb, 0);
> > +
> > +       /* Payload size can't be greater than the destination buffer size */
> > +       if (payload_size > max_size) {
> > +               dev_dbg(dev, "Payload size is too large: %zu\n", payload_size);
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Payload size can't be smaller than the header size */
> > +       if (payload_size < header_size) {
> > +               dev_dbg(dev, "Payload size is too small: %zu\n", payload_size);
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(v4l2_isp_params_validate_buffer_size);
> > +
> > +int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
> > +                                   const struct v4l2_isp_params_buffer *buffer,
> > +                                   const struct v4l2_isp_params_block_info *info,
> > +                                   size_t num_blocks)
> > +{
> > +       size_t header_size = offsetof(struct v4l2_isp_params_buffer, data);
> > +       size_t payload_size = vb2_get_plane_payload(vb, 0);
> > +       size_t block_offset = 0;
> > +       size_t buffer_size;
> > +
> > +       /*
> > +        * Currently only the first version of the V4L2 ISP parameters format is
> > +        * supported. We accept both V0 and V1 to support existing drivers
> > +        * compatible with V4L2 ISP that use either 0 or 1 as their "first
> > +        * version" identifiers.
> > +        */
> > +       if (buffer->version != V4L2_ISP_PARAMS_VERSION_V0 &&
> > +           buffer->version != V4L2_ISP_PARAMS_VERSION_V1) {
> > +               dev_dbg(dev,
> > +                       "Unsupported V4L2 ISP parameters format version: %u\n",
> > +                       buffer->version);
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Validate the size reported in the header */
> > +       buffer_size = header_size + buffer->data_size;
> > +       if (buffer_size != payload_size) {
> > +               dev_dbg(dev, "Data size %zu and payload size %zu are different\n",
> > +                       buffer_size, payload_size);
> > +               return -EINVAL;
> > +       }
> > +
> > +       /* Walk the list of ISP configuration blocks and validate them. */
> > +       buffer_size = buffer->data_size;
> > +       while (buffer_size >= sizeof(struct v4l2_isp_params_block_header)) {
> > +               const struct v4l2_isp_params_block_info *block_info;
> > +               const struct v4l2_isp_params_block_header *block;
> > +
> > +               block = (const struct v4l2_isp_params_block_header *)
> > +                       (buffer->data + block_offset);
> > +
> > +               if (block->type >= num_blocks) {
> > +                       dev_dbg(dev,
> > +                               "Invalid block type %u at offset %zu\n",
> > +                               block->type, block_offset);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               if (block->size > buffer_size) {
> > +                       dev_dbg(dev, "Premature end of parameters data\n");
> > +                       return -EINVAL;
> > +               }
> > +
> > +               /* It's invalid to specify both ENABLE and DISABLE. */
> > +               if ((block->flags & (V4L2_ISP_PARAMS_FL_BLOCK_ENABLE |
> > +                                    V4L2_ISP_PARAMS_FL_BLOCK_DISABLE)) ==
> > +                    (V4L2_ISP_PARAMS_FL_BLOCK_ENABLE |
> > +                    V4L2_ISP_PARAMS_FL_BLOCK_DISABLE)) {
> > +                       dev_dbg(dev, "Invalid block flags %x at offset %zu\n",
> > +                               block->flags, block_offset);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               /*
> > +                * Match the block reported size against the info provided
> > +                * one, but allow the block to only contain the header in
> > +                * case it is going to be disabled.
> > +                */
> > +               block_info = &info[block->type];
> > +               if (block->size != block_info->size &&
> > +                   (!(block->flags & V4L2_ISP_PARAMS_FL_BLOCK_DISABLE) ||
> > +                   block->size != sizeof(*block))) {
> > +                       dev_dbg(dev,
> > +                               "Invalid block size %u (expected %zu) at offset %zu\n",
> > +                               block->size, block_info->size, block_offset);
> > +                       return -EINVAL;
> > +               }
> > +
> > +               block_offset += block->size;
> > +               buffer_size -= block->size;
> > +       }
> > +
> > +       if (buffer_size) {
> > +               dev_dbg(dev, "Unexpected data after the parameters buffer end\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(v4l2_isp_params_validate_buffer);
> > diff --git a/include/media/v4l2-isp.h b/include/media/v4l2-isp.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..8b4695663699e7f176384739cf54ed7fa2c578f8
> > --- /dev/null
> > +++ b/include/media/v4l2-isp.h
> > @@ -0,0 +1,91 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Video4Linux2 generic ISP parameters and statistics support
> > + *
> > + * Copyright (C) 2025 Ideas On Board Oy
> > + * Author: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> > + */
> > +
> > +#ifndef _V4L2_ISP_H_
> > +#define _V4L2_ISP_H_
> > +
> > +#include <linux/media/v4l2-isp.h>
> > +
> > +struct device;
> > +struct vb2_buffer;
> > +
> > +/**
> > + * v4l2_isp_params_buffer_size - Calculate size of v4l2_isp_params_buffer
> > + * @max_params_size: The total size of the ISP configuration blocks
> > + *
> > + * Users of the v4l2 extensible parameters will have differing sized data arrays
> > + * depending on their specific parameter buffers. Drivers and userspace will
> > + * need to be able to calculate the appropriate size of the struct to
> > + * accommodate all ISP configuration blocks provided by the platform.
> > + * This macro provides a convenient tool for the calculation.
> > + */
> > +#define v4l2_isp_params_buffer_size(max_params_size) \
> > +       (offsetof(struct v4l2_isp_params_buffer, data) + (max_params_size))
> > +
> > +/**
> > + * v4l2_isp_params_validate_buffer_size - Validate a V4L2 ISP buffer sizes
> > + * @dev: the driver's device pointer
> > + * @vb: the videobuf2 buffer
> > + * @max_size: the maximum allowed buffer size
> > + *
> > + * This function performs validation of the size of a V4L2 ISP parameters buffer
> > + * before the driver can access the actual data buffer content.
> > + *
> > + * After the sizes validation, drivers should copy the buffer content to a
> > + * kernel-only memory area to prevent userspace from modifying it,
> > + * before completing validation using v4l2_isp_params_validate_buffer().
> > + *
> > + * The @vb buffer as received from the vb2 .buf_prepare() operation is checked
> > + * against @max_size and it's validated to be large enough to accommodate at
> > + * least one ISP configuration block.
> > + */
> > +int v4l2_isp_params_validate_buffer_size(struct device *dev,
> > +                                        struct vb2_buffer *vb,
> > +                                        size_t max_size);
> > +
> > +/**
> > + * struct v4l2_isp_params_block_info - V4L2 ISP per-block info
> > + * @size: the block expected size
> > + *
> > + * The v4l2_isp_params_block_info collects information of the ISP configuration
> > + * blocks for validation purposes. It currently only contains the expected
> > + * block size.
> > + *
> > + * Drivers shall prepare a list of block info, indexed by block type, one for
> > + * each supported ISP block and correctly populate them with the expected block
> > + * size.
> > + */
> > +struct v4l2_isp_params_block_info {
> > +       size_t size;
> > +};
> > +
> > +/**
> > + * v4l2_isp_params_validate_buffer - Validate a V4L2 ISP parameters buffer
> > + * @dev: the driver's device pointer
> > + * @vb: the videobuf2 buffer
> > + * @buffer: the V4L2 ISP parameters buffer
> > + * @info: the list of per-block validation info
> > + * @num_blocks: the number of blocks
> > + *
> > + * This function completes the validation of a V4L2 ISP parameters buffer,
> > + * verifying each configuration block correctness before the driver can use
> > + * them to program the hardware.
> > + *
> > + * Drivers should use this function after having validated the correctness of
> > + * the vb2 buffer sizes by using the v4l2_isp_params_validate_buffer_size()
> > + * helper first. Once the buffer size has been validated, drivers should
> > + * perform a copy of the user provided buffer into a kernel-only memory buffer
> > + * to prevent userspace from modifying its content after it has been submitted
> > + * to the driver, and then call this function to complete validation.
> > + */
> > +int v4l2_isp_params_validate_buffer(struct device *dev, struct vb2_buffer *vb,
> > +                                   const struct v4l2_isp_params_buffer *buffer,
> > +                                   const struct v4l2_isp_params_block_info *info,
> > +                                   size_t num_blocks);
> > +
> > +#endif /* _V4L2_ISP_H_ */
> >
> > --
> > 2.51.0
> >
>

