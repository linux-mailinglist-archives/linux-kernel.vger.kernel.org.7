Return-Path: <linux-kernel+bounces-881701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD99C28C94
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44B7B4E3EED
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C79246768;
	Sun,  2 Nov 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsUZ1A25"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C954DDC5
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762075867; cv=none; b=mk42++9kVNfM64qbZGgPRuXnO+NaJW1w2qkHgn3KztPxUxe/1YXZ0zqRbYxogO3kuqEnIhliMtp3w0hLC7eO8ujMZyRg24rqVESwCD7gDYoMMtK0cdkvEsoaY5wba4znMCuZYZ6gz/JPrHgJrjezmg02MD5iEMo5vVNXcrDbQEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762075867; c=relaxed/simple;
	bh=6j7Eeimkr/RPgor4Yox2va+Is4mXhLt/uJfiY58ZIhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jz8YU82oUpJJDSGro0X5jRRBP0tXHhrtcnhefQeXl+ihzqbFnPZulR6T45Sx9QBrXC+kgvp+mabs5zSHtypBwILCqhN7oO695IfiDNWxDgKrmRPiONV2t2SqOC7m2nIya51c1KN18lhObNzh+BaQyjgOJBsU9vtbMMyGmQq7CUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsUZ1A25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10797C4CEF7;
	Sun,  2 Nov 2025 09:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762075864;
	bh=6j7Eeimkr/RPgor4Yox2va+Is4mXhLt/uJfiY58ZIhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SsUZ1A251spxc6Me3ndAceo4lcf2ovEgE696cy5QK8jasIfOAGq3UY+Q5evikaULj
	 nOhMYsSB3FS3XkQlXT3HlOxjSENgmmVpJxeXKsY1kjbEgcJ7nhLeo6v6Fy9BSgEbSS
	 wkfeVBVRC+vm2H2sxRSlna21yrlS+iszqvgWYx3pLcbHVLzPj5ThlXDMOyhEuicV2D
	 FXzLvaHAcl/rfqa3YvPA1jgLsFC7f0B7Lio66AzDCMxrv+TspnAYdLOv/owy7x0Jit
	 UsrS/70JJX5oum0jlBaP2s3Ul6cHxynQgOaJdddgLqZDPckvUcxup0w1vm22hWlop8
	 NDvoEL0lQzxjQ==
Message-ID: <cc7edba3-af91-44ef-9899-18c21a3f33bd@kernel.org>
Date: Sun, 2 Nov 2025 10:30:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] platform/raspberrypi: Add new vc-sm-cma driver
To: Jai Luthra <jai.luthra@ideasonboard.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 bcm-kernel-feedback-list@broadcom.com
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Dom Cobley <popcornmix@gmail.com>,
 Alexander Winkowski <dereference23@outlook.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Juerg Haefliger <juerg.haefliger@canonical.com>
References: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
 <20251031-b4-vc-sm-cma-v1-9-0dd5c0ec3f5c@ideasonboard.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251031-b4-vc-sm-cma-v1-9-0dd5c0ec3f5c@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/2025 18:27, Jai Luthra wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> Add Broadcom VideoCore Shared Memory support.

You will have to come with really, really good argument why CMA is not
working for you. This is how you write commit msgs. All further is not
really helpful.

> 
> This new driver allows contiguous memory blocks to be imported into the
> VideoCore VPU memory map, and manages the lifetime of those objects,
> only releasing the source dmabuf once the VPU has confirmed it has
> finished with it.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> staging: vcsm-cma: Fix memory leak from not detaching dmabuf
> 
> When importing there was a missing call to detach the buffer, so each
> import leaked the sg table entry.
> 
> Actually the release process for both locally allocated and imported
> buffers is identical, so fix them to both use the same
> function.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> staging/vc-sm-cma: Avoid log spamming on Pi0/1 over cache alias.
> 
> Pi 0/1 use the 0x80000000 cache alias as the ARM also sees the world
> through the VPU L2 cache.
> vc-sm-cma was trying to ensure it was in an uncached alias (0xc), and
> complaining on every allocation if it weren't. Reduce this logging.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> vc-sm-cma: Restore correct cache maintainance operations
> 
> We have been using the more expensive flush operations rather than
> invalidate and clean since kernel rpi-5.9.y
> 
> These are exposed with:
> 52f1453513ba95084ab811a030032fe605b0cbe2 Re-expose some dmi APIs for use
> in VCSM
> 
> But I believe that commit was dropped when (non-cma) vc-sm was dropped,
> and didn't get updated when the commit was restored
> 
> Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> 
> staging: vc04_services: Fix clang14 warning
> 
> Insert a break to fix a fallthrough warning from clang14. Since the
> fallthrough was to another break, this is a cosmetic change.
> 
> See: https://github.com/raspberrypi/linux/issues/5078
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> 
> vc04_services/vc-sm-cma: Handle upstream require vchiq_instance to be
> passed around
> 
> vc04_services/vc-sm-cma: Switch one-bit bitfields to bool
> 
> Clang 16 warns:
> 
> ../drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:816:19: warning:
> implicit truncation from 'int' to a one-bit wide bit-field changes value
> from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
>     buffer->imported = 1;
> 		     ^ ~
> ../drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:822:17: warning:
> implicit truncation from 'int' to a one-bit wide bit-field changes value
> from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
>     buffer->in_use = 1;
> 		   ^ ~
> 2 warnings generated.
> 
> Signed-off-by: Alexander Winkowski <dereference23@outlook.com>
> 
> vc04_services: vcsm-cma: Detach from the correct dmabuf
> 
> Commit d3292daee319 ("dma-buf: Make locking consistent in
> dma_buf_detach()")
> added checking that the same dmabuf for which dma_buf_attach
> was called is passed into dma_buf_detach, which flagged up
> that vcsm-cma was passing in the wrong dmabuf.
> 
> Correct this so that we don't get the WARN on every dma_buf
> release.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> staging: vc04_services: vc-sm-cma: Remove deprecated header
> 
> The vchiq_connected.h header was removed in f875976ecf45 ("staging:
> vc04_services: Drop vchiq_connected.[ch] files") to simplify the
> implementation.
> 
> Update the vc_sm driver accordingly which can still use the same
> functions through the vchiq_arm.h header declarations.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> 
> staging: vc04_services: vc-sm-cma: Drop include Makefile directive
> 
> Drop the include directive. They can break the build, when one only
> wants to build a subdirectory. Replace with "../" for the includes in
> the vc_sm files instead.
> 
> The fix is equivalent to the four patches between 29d49a76c5b2
> ("staging: vc04_services: bcm2835-audio: Drop include Makefile
> directive")...2529ca211402 ("staging: vc04_services: interface: Drop
> include Makefile directive")
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> 
> staging: vc04_services: vc-sm-cma: Register with vchiq_bus_type
> 
> Register the vcsm rive with the vchiq_bus_type instead of useing the
> platform driver/device.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> 
> staging: vc04_services: vc-sm-cma: Explicitly set DMA mask
> 
> The platform model originally handled the DMA mask. Now that
> we are on the vchiq_bus we need to explicitly set this.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

That's a complete mess of tags. All tags are going to one place. Please
write single commit msg, not consisting of squashed 10 messages.

> 
> staging: vc04_services: vc-sm-cma: Use [map|unmap]_attachment_unlocked
> 
> lockdep throws warnings when using libcamera as buffers are
> mapped and unmapped as the dmabuf->resv lock hasn't been taken.
> 
> Switch to using the _unlocked variants so that the framework takes
> the lock.
> 
> https://github.com/raspberrypi/linux/issues/6814
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> staging: vc04_services: vc-sm-cma: Use a mutex instead of spinlock
> 
> There are no contexts where we should be calling the kernelid_map
> IDR functions where we can't sleep, so switch from using a spinlock
> to using a mutex.
> 
> https://github.com/raspberrypi/linux/issues/6815
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> staging: vc-sm-cma: Fix field-spanning write warning
> 
> Replace one-element array with flexible-array member to fix:
> 
> [   11.725017] ------------[ cut here ]------------
> [   11.725038] memcpy: detected field-spanning write (size 4) of single field "hdr->body" at drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c:130 (size 0)
> [   11.725113] WARNING: CPU: 3 PID: 455 at drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c:130 vc_vchi_cmd_create+0x1a8/0x1d0 [vc_sm_cma]
> 
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> 
> platform/raspberrypi: vc-sm-cma: Fix smatch warnings
> 
> Fix these two smatch warnings for the vc-sm-cma driver, rest were false
> positives:
> 
> ../drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:413
> vc_sm_dma_buf_attach() warn: inconsistent returns '&buf->lock'.
>   Locked on  : 396
>   Unlocked on: 413
> ../drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:1225
> vc_sm_cma_ioctl_alloc() error: we previously assumed 'buffer' could be
> null (see line 1113)
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> [jai.luthra: fix checkpatch and smatch warnings, add entry in MAINTAINERS]
> Co-developed-by: Jai Luthra <jai.luthra@ideasonboard.com>
> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> ---
>  MAINTAINERS                                             |    7 +
>  drivers/platform/raspberrypi/Kconfig                    |    2 +
>  drivers/platform/raspberrypi/Makefile                   |    1 +
>  drivers/platform/raspberrypi/vc-sm-cma/Kconfig          |    9 +
>  drivers/platform/raspberrypi/vc-sm-cma/Makefile         |    9 +
>  drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c          | 1619 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/platform/raspberrypi/vc-sm-cma/vc_sm.h          |   83 ++++++
>  drivers/platform/raspberrypi/vc-sm-cma/vc_sm_cma_vchi.c |  513 +++++++++++++++++++++++++++++++++++++
>  drivers/platform/raspberrypi/vc-sm-cma/vc_sm_cma_vchi.h |   63 +++++
>  drivers/platform/raspberrypi/vc-sm-cma/vc_sm_defs.h     |  298 +++++++++++++++++++++
>  drivers/platform/raspberrypi/vc-sm-cma/vc_sm_knl.h      |   28 ++
>  include/linux/raspberrypi/vc_sm_cma_ioctl.h             |  114 +++++++++
>  12 files changed, 2746 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index df07d1a3c28d048e14a0f65c9f9ff01cc260013a..352c29bb3b94543bcb37c62d26d4c8bae48130ff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5289,6 +5289,13 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/broadcom/tg3.*
>  
> +BROADCOM VIDEOCORE SHARED MEMORY DRIVER
> +M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/raspberrypi/vc-sm-cma/*
> +F:	include/linux/raspberrypi/vc_sm_cma*
> +
>  BROADCOM VK DRIVER
>  M:	Scott Branden <scott.branden@broadcom.com>
>  R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
> diff --git a/drivers/platform/raspberrypi/Kconfig b/drivers/platform/raspberrypi/Kconfig
> index 2c928440a47c08e4d452fe838fe4105c608995a4..68a7a2d5701cd6821ec4b7418a86bf61011c83f6 100644
> --- a/drivers/platform/raspberrypi/Kconfig
> +++ b/drivers/platform/raspberrypi/Kconfig
> @@ -48,5 +48,7 @@ config VCHIQ_CDEV
>  endif
>  
>  source "drivers/platform/raspberrypi/vchiq-mmal/Kconfig"
> +source "drivers/platform/raspberrypi/vc-sm-cma/Kconfig"
> +
>  
>  endif
> diff --git a/drivers/platform/raspberrypi/Makefile b/drivers/platform/raspberrypi/Makefile
> index 2a7c9511e5d8bbe11c05680eea016ef40796b648..1980f618e2185228e1fe173b1e94a3ede0e15bbb 100644
> --- a/drivers/platform/raspberrypi/Makefile
> +++ b/drivers/platform/raspberrypi/Makefile
> @@ -13,3 +13,4 @@ vchiq-objs += vchiq-interface/vchiq_dev.o
>  endif
>  
>  obj-$(CONFIG_BCM2835_VCHIQ_MMAL)	+= vchiq-mmal/
> +obj-$(CONFIG_BCM_VC_SM_CMA)		+= vc-sm-cma/
> diff --git a/drivers/platform/raspberrypi/vc-sm-cma/Kconfig b/drivers/platform/raspberrypi/vc-sm-cma/Kconfig
> new file mode 100644
> index 0000000000000000000000000000000000000000..7daec14dcfc14b6a1492ca9e1670807b5b4f87d8
> --- /dev/null
> +++ b/drivers/platform/raspberrypi/vc-sm-cma/Kconfig
> @@ -0,0 +1,9 @@
> +config BCM_VC_SM_CMA
> +	tristate "VideoCore Shared Memory (CMA) driver"
> +	select BCM2835_VCHIQ

Why you do not have > +	select DMA_SHARED_BUFFER
> +	help
> +	  Say Y here to enable the shared memory interface that
> +	  supports sharing dmabufs with VideoCore.
> +	  This operates over the VCHIQ interface to a service
> +	  running on VideoCore.
> diff --git a/drivers/platform/raspberrypi/vc-sm-cma/Makefile b/drivers/platform/raspberrypi/vc-sm-cma/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..c12c1a13165c18927ab03e8edde762bcb7f32c9b
> --- /dev/null
> +++ b/drivers/platform/raspberrypi/vc-sm-cma/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0
> +vc-sm-cma-$(CONFIG_BCM_VC_SM_CMA) := \
> +	vc_sm.o vc_sm_cma_vchi.o
> +
> +obj-$(CONFIG_BCM_VC_SM_CMA) += vc-sm-cma.o
> +
> +ccflags-y += \
> +	-D__VCCOREVER__=0

Drop

> +
> diff --git a/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..134a8fde7ebfc1325fcd2f5cc9b81ad48a22a802
> --- /dev/null
> +++ b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c
> @@ -0,0 +1,1619 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * VideoCore Shared Memory driver using CMA.
> + *
> + * Copyright: 2018, Raspberry Pi (Trading) Ltd
> + * Dave Stevenson <dave.stevenson@raspberrypi.org>
> + *
> + * Based on vmcs_sm driver from Broadcom Corporation for some API,
> + * and taking some code for buffer allocation and dmabuf handling from
> + * videobuf2.
> + *
> + *
> + * This driver has 3 main uses:
> + * 1) Allocating buffers for the kernel or userspace that can be shared with the
> + *    VPU.
> + * 2) Importing dmabufs from elsewhere for sharing with the VPU.
> + * 3) Allocating buffers for use by the VPU.
> + *
> + * In the first and second cases the native handle is a dmabuf. Releasing the
> + * resource inherently comes from releasing the dmabuf, and this will trigger
> + * unmapping on the VPU. The underlying allocation and our buffer structure are
> + * retained until the VPU has confirmed that it has finished with it.
> + *
> + * For the VPU allocations the VPU is responsible for triggering the release,
> + * and therefore the released message decrements the dma_buf refcount (with the
> + * VPU mapping having already been marked as released).
> + */
> +
> +/* ---- Include Files ----------------------------------------------------- */

Drop such comments.

> +#include <linux/cacheflush.h>
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/debugfs.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma-buf.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/mm.h>
> +#include <linux/of_device.h>

You don't use several of these headers...

> +#include <linux/proc_fs.h>
> +#include <linux/raspberrypi/vchiq_arm.h>
> +#include <linux/raspberrypi/vchiq_bus.h>
> +#include <linux/raspberrypi/vc_sm_cma_ioctl.h>
> +#include <linux/slab.h>
> +#include <linux/seq_file.h>
> +#include <linux/syscalls.h>

Syscalls? What are you going to call here? Isn't this kernel code?

> +#include <linux/types.h>
> +
> +#include "vc_sm_cma_vchi.h"
> +
> +#include "vc_sm.h"
> +#include "vc_sm_knl.h"
> +
> +MODULE_IMPORT_NS("DMA_BUF");
> +
> +/* ---- Private Constants and Types --------------------------------------- */
> +
> +#define DEVICE_NAME		"vcsm-cma"
> +#define DEVICE_MINOR		0
> +
> +#define VC_SM_RESOURCE_NAME_DEFAULT       "sm-host-resource"
> +
> +#define VC_SM_DIR_ROOT_NAME	"vcsm-cma"
> +#define VC_SM_STATE		"state"
> +

...

> +
> +/* Driver loading. */
> +static int bcm2835_vc_sm_cma_probe(struct vchiq_device *device)
> +{
> +	int err;
> +
> +	pr_info("%s: Videocore shared memory driver\n", __func__);

Drop this and all such useless entry/exit or driver success messages.
See coding style.

Also, all drivers are supposed to use dev_xxx, not pr. This is some
really old code.

> +
> +	err = dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
> +	if (err) {
> +		dev_err(&device->dev, "dma_set_mask_and_coherent failed: %d\n",
> +			err);
> +		return err;
> +	}
> +
> +	sm_state = devm_kzalloc(&device->dev, sizeof(*sm_state), GFP_KERNEL);
> +	if (!sm_state)
> +		return -ENOMEM;
> +	sm_state->device = device;
> +	mutex_init(&sm_state->map_lock);
> +
> +	mutex_init(&sm_state->kernelid_map_lock);
> +	idr_init_base(&sm_state->kernelid_map, 1);
> +
> +	device->dev.dma_parms = devm_kzalloc(&device->dev,
> +					     sizeof(*device->dev.dma_parms),
> +					     GFP_KERNEL);
> +	/* dma_set_max_seg_size checks if dma_parms is NULL. */
> +	dma_set_max_seg_size(&device->dev, 0x3FFFFFFF);
> +
> +	vchiq_add_connected_callback(device, vc_sm_connected_init);
> +	return 0;
> +}
> +
> +/* Driver unloading. */
> +static void bcm2835_vc_sm_cma_remove(struct vchiq_device *device)
> +{
> +	pr_debug("[%s]: start\n", __func__);

No

> +	if (sm_inited) {
> +		misc_deregister(&sm_state->misc_dev);
> +
> +		/* Remove all proc entries. */
> +		debugfs_remove_recursive(sm_state->dir_root);
> +
> +		/* Stop the videocore shared memory service. */
> +		vc_sm_cma_vchi_stop(sm_state->vchiq_instance, &sm_state->sm_handle);
> +	}
> +
> +	if (sm_state) {
> +		idr_destroy(&sm_state->kernelid_map);
> +
> +		/* Free the memory for the state structure. */
> +		mutex_destroy(&sm_state->map_lock);
> +	}
> +
> +	pr_debug("[%s]: end\n", __func__);

Drop all such code. This is very poor and old coding practice. Kernel
already gives you tracing for this exact purpose.> +}
> +
> +/* Kernel API calls */
> +/* Get an internal resource handle mapped from the external one. */
> +int vc_sm_cma_int_handle(void *handle)
> +{
> +	struct dma_buf *dma_buf = (struct dma_buf *)handle;
> +	struct vc_sm_buffer *buf;
> +
> +	/* Validate we can work with this device. */
> +	if (!sm_state || !handle) {
> +		pr_err("[%s]: invalid input\n", __func__);
> +		return 0;
> +	}
> +
> +	buf = (struct vc_sm_buffer *)dma_buf->priv;
> +	return buf->vc_handle;
> +}
> +EXPORT_SYMBOL_GPL(vc_sm_cma_int_handle);
> +
> +/* Free a previously allocated shared memory handle and block. */

You need kerneldocs for every EXPORT

> +int vc_sm_cma_free(void *handle)
> +{
> +	struct dma_buf *dma_buf = (struct dma_buf *)handle;
> +
> +	/* Validate we can work with this device. */
> +	if (!sm_state || !handle) {
> +		pr_err("[%s]: invalid input\n", __func__);
> +		return -EPERM;
> +	}
> +
> +	pr_debug("%s: handle %p/dmabuf %p\n", __func__, handle, dma_buf);
> +
> +	dma_buf_put(dma_buf);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(vc_sm_cma_free);
> +
> +/* Import a dmabuf to be shared with VC. */

Kerneldocs everywhere for exports.

> +int vc_sm_cma_import_dmabuf(struct dma_buf *src_dmabuf, void **handle)
> +{
> +	struct dma_buf *new_dma_buf;
> +	int ret;
> +
> +	/* Validate we can work with this device. */
> +	if (!sm_state || !src_dmabuf || !handle) {
> +		pr_err("[%s]: invalid input\n", __func__);
> +		return -EPERM;
> +	}
> +
> +	ret = vc_sm_cma_import_dmabuf_internal(sm_state->data_knl, src_dmabuf,
> +					       -1, &new_dma_buf);
> +
> +	if (!ret) {
> +		pr_debug("%s: imported to ptr %p\n", __func__, new_dma_buf);
> +
> +		/* Assign valid handle at this time.*/
> +		*handle = new_dma_buf;
> +	} else {
> +		/*
> +		 * succeeded in importing the dma_buf, but then
> +		 * failed to look it up again. How?
> +		 * Release the fd again.
> +		 */
> +		pr_err("%s: imported vc_sm_cma_get_buffer failed %d\n",
> +		       __func__, ret);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(vc_sm_cma_import_dmabuf);
> +
> +static struct vchiq_driver bcm2835_vcsm_cma_driver = {
> +	.probe = bcm2835_vc_sm_cma_probe,
> +	.remove = bcm2835_vc_sm_cma_remove,
> +	.driver = {
> +		.name = DEVICE_NAME,
> +		.owner = THIS_MODULE,

Please clean up your driver from 10 year old left overs. Entire driver.

Several patterns here show that you did not clean up this driver before
submitting from basic coding style issues.

> +	},
> +};
> +
> +module_vchiq_driver(bcm2835_vcsm_cma_driver);
> +
> +MODULE_AUTHOR("Dave Stevenson");
> +MODULE_DESCRIPTION("VideoCore CMA Shared Memory Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("vcsm-cma");

Why don't you have proper ID table? How this driver is supposed to be
instantiated?


Best regards,
Krzysztof

