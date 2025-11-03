Return-Path: <linux-kernel+bounces-883009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F8CC2C429
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 756CC4E2916
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CCC2737E1;
	Mon,  3 Nov 2025 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GscmNxw2"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6FF24729D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177785; cv=none; b=MxUqi3J5/5ZFtbniKKJTVSe22/eZff+9/iYx58NXBAl+QtVwbu2Dv+vCd0VddOFJ6yHYLP4/q18qBiS3I2o4f8cTKH/DXuSAFYuc81AYkrfcQIX4nmChYgfv1kwIi7+ophNFXPYcK3FW/yysjrZHwo/np/GdefDD1c/4hnyqSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177785; c=relaxed/simple;
	bh=KXDl6H+qqZge4uKXB855BS4Z7r9cvx1ekA/u3sKSGG4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=NktxvYL/9piE20nqs2bwrbfjcCTZU69lHR7sBWm+Na3sH1oCPOsU2f7yGCweRA4SN1eNOjDyYjzKEp2i7VPp8UaQO/mdlQPHKVtQOMlb5Q2SCEKgA2rmCb59eHP8hamhJU86ngOG1yklhXv8ppCcMEjqIHuxRKdbIZhUSjf7tLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=GscmNxw2; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9E9E1C73;
	Mon,  3 Nov 2025 14:47:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762177668;
	bh=KXDl6H+qqZge4uKXB855BS4Z7r9cvx1ekA/u3sKSGG4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GscmNxw2Ahpff/7yOF/5Gdq8zU7UolAWADzUUsZG/FUMlNE7g22LCczRIo7KDkEvf
	 vhv6K82LTWElazsy77rJ91An12uw9q6Rlw3tkdzRaaXEXJA6AfCrLY4GwAwOeTElew
	 ptCPyCqMYFXRSBcvnlDCfguFuV5+yzzpFQK0e/Cw=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cc7edba3-af91-44ef-9899-18c21a3f33bd@kernel.org>
References: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com> <20251031-b4-vc-sm-cma-v1-9-0dd5c0ec3f5c@ideasonboard.com> <cc7edba3-af91-44ef-9899-18c21a3f33bd@kernel.org>
Subject: Re: [PATCH 09/13] platform/raspberrypi: Add new vc-sm-cma driver
From: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Phil Elwell <phil@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kieran Bingham <kieran.bingham@ideasonboard.com>, Sumit Semwal <sumit.semwal@linaro.org>, Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>, Alexander Winkowski <dereference23@outlook.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Juerg Haefliger <juerg.haefliger@canonical.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, Krzysztof Kozlowski <krzk@kernel.org>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,Dave Stevenson <dave.stevenson@raspberrypi.com>,  bcm-kernel-feedback-list@broadcom.com
Date: Mon, 03 Nov 2025 19:19:36 +0530
Message-ID: <176217777617.8690.2075618272816893198@freya>
User-Agent: alot/0.12.dev28+gd2c823fe

Hi Krzysztof,


Thanks for the review.

Quoting Krzysztof Kozlowski (2025-11-02 15:00:58)
> On 31/10/2025 18:27, Jai Luthra wrote:
> > From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >=20
> > Add Broadcom VideoCore Shared Memory support.
>=20
> You will have to come with really, really good argument why CMA is not
> working for you. This is how you write commit msgs. All further is not
> really helpful.
>=20

From my limited understanding, this driver allows sharing buffers between
the kernel and the firmware that controls the ISP and codec on the remote
VideoCore VPU.

Maybe Dave can comment better on the historical reasons of this approach
versus other DMA buffer sharing mechanisms available in the kernel, and if
it is feasible/possible to make that change today.

> >=20
> > This new driver allows contiguous memory blocks to be imported into the
> > VideoCore VPU memory map, and manages the lifetime of those objects,
> > only releasing the source dmabuf once the VPU has confirmed it has
> > finished with it.
> >=20
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >=20
> > staging: vcsm-cma: Fix memory leak from not detaching dmabuf
> >=20
> > When importing there was a missing call to detach the buffer, so each
> > import leaked the sg table entry.
> >=20
> > Actually the release process for both locally allocated and imported
> > buffers is identical, so fix them to both use the same
> > function.
> >=20
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >=20
> > staging/vc-sm-cma: Avoid log spamming on Pi0/1 over cache alias.
> >=20
> > Pi 0/1 use the 0x80000000 cache alias as the ARM also sees the world
> > through the VPU L2 cache.
> > vc-sm-cma was trying to ensure it was in an uncached alias (0xc), and
> > complaining on every allocation if it weren't. Reduce this logging.
> >=20
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >=20
> > vc-sm-cma: Restore correct cache maintainance operations
> >=20
> > We have been using the more expensive flush operations rather than
> > invalidate and clean since kernel rpi-5.9.y
> >=20
> > These are exposed with:
> > 52f1453513ba95084ab811a030032fe605b0cbe2 Re-expose some dmi APIs for use
> > in VCSM
> >=20
> > But I believe that commit was dropped when (non-cma) vc-sm was dropped,
> > and didn't get updated when the commit was restored
> >=20
> > Signed-off-by: Dom Cobley <popcornmix@gmail.com>
> >=20
> > staging: vc04_services: Fix clang14 warning
> >=20
> > Insert a break to fix a fallthrough warning from clang14. Since the
> > fallthrough was to another break, this is a cosmetic change.
> >=20
> > See: https://github.com/raspberrypi/linux/issues/5078
> >=20
> > Signed-off-by: Phil Elwell <phil@raspberrypi.com>
> >=20
> > vc04_services/vc-sm-cma: Handle upstream require vchiq_instance to be
> > passed around
> >=20
> > vc04_services/vc-sm-cma: Switch one-bit bitfields to bool
> >=20
> > Clang 16 warns:
> >=20
> > ../drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:816:19: warning:
> > implicit truncation from 'int' to a one-bit wide bit-field changes value
> > from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
> >     buffer->imported =3D 1;
> >                    ^ ~
> > ../drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:822:17: warning:
> > implicit truncation from 'int' to a one-bit wide bit-field changes value
> > from 1 to -1 [-Wsingle-bit-bitfield-constant-conversion]
> >     buffer->in_use =3D 1;
> >                  ^ ~
> > 2 warnings generated.
> >=20
> > Signed-off-by: Alexander Winkowski <dereference23@outlook.com>
> >=20
> > vc04_services: vcsm-cma: Detach from the correct dmabuf
> >=20
> > Commit d3292daee319 ("dma-buf: Make locking consistent in
> > dma_buf_detach()")
> > added checking that the same dmabuf for which dma_buf_attach
> > was called is passed into dma_buf_detach, which flagged up
> > that vcsm-cma was passing in the wrong dmabuf.
> >=20
> > Correct this so that we don't get the WARN on every dma_buf
> > release.
> >=20
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >=20
> > staging: vc04_services: vc-sm-cma: Remove deprecated header
> >=20
> > The vchiq_connected.h header was removed in f875976ecf45 ("staging:
> > vc04_services: Drop vchiq_connected.[ch] files") to simplify the
> > implementation.
> >=20
> > Update the vc_sm driver accordingly which can still use the same
> > functions through the vchiq_arm.h header declarations.
> >=20
> > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> >=20
> > staging: vc04_services: vc-sm-cma: Drop include Makefile directive
> >=20
> > Drop the include directive. They can break the build, when one only
> > wants to build a subdirectory. Replace with "../" for the includes in
> > the vc_sm files instead.
> >=20
> > The fix is equivalent to the four patches between 29d49a76c5b2
> > ("staging: vc04_services: bcm2835-audio: Drop include Makefile
> > directive")...2529ca211402 ("staging: vc04_services: interface: Drop
> > include Makefile directive")
> >=20
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> >=20
> > staging: vc04_services: vc-sm-cma: Register with vchiq_bus_type
> >=20
> > Register the vcsm rive with the vchiq_bus_type instead of useing the
> > platform driver/device.
> >=20
> > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> >=20
> > staging: vc04_services: vc-sm-cma: Explicitly set DMA mask
> >=20
> > The platform model originally handled the DMA mask. Now that
> > we are on the vchiq_bus we need to explicitly set this.
> >=20
> > Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>=20
> That's a complete mess of tags. All tags are going to one place. Please
> write single commit msg, not consisting of squashed 10 messages.
>=20

Will do.

In v2, I plan to retain authorship for all the community contributions this
driver has seen through the downstream github tree using Co-developed-by
tags.

Please let me know if anyone currently with the Signed-off-by tags has any
objections to that.

> >=20
> > staging: vc04_services: vc-sm-cma: Use [map|unmap]_attachment_unlocked
> >=20
> > lockdep throws warnings when using libcamera as buffers are
> > mapped and unmapped as the dmabuf->resv lock hasn't been taken.
> >=20
> > Switch to using the _unlocked variants so that the framework takes
> > the lock.
> >=20
> > https://github.com/raspberrypi/linux/issues/6814
> >=20
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >=20
> > staging: vc04_services: vc-sm-cma: Use a mutex instead of spinlock
> >=20
> > There are no contexts where we should be calling the kernelid_map
> > IDR functions where we can't sleep, so switch from using a spinlock
> > to using a mutex.
> >=20
> > https://github.com/raspberrypi/linux/issues/6815
> >=20
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >=20
> > staging: vc-sm-cma: Fix field-spanning write warning
> >=20
> > Replace one-element array with flexible-array member to fix:
> >=20
> > [   11.725017] ------------[ cut here ]------------
> > [   11.725038] memcpy: detected field-spanning write (size 4) of single=
 field "hdr->body" at drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vch=
i.c:130 (size 0)
> > [   11.725113] WARNING: CPU: 3 PID: 455 at drivers/staging/vc04_service=
s/vc-sm-cma/vc_sm_cma_vchi.c:130 vc_vchi_cmd_create+0x1a8/0x1d0 [vc_sm_cma]
> >=20
> > Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> >=20
> > platform/raspberrypi: vc-sm-cma: Fix smatch warnings
> >=20
> > Fix these two smatch warnings for the vc-sm-cma driver, rest were false
> > positives:
> >=20
> > ../drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:413
> > vc_sm_dma_buf_attach() warn: inconsistent returns '&buf->lock'.
> >   Locked on  : 396
> >   Unlocked on: 413
> > ../drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:1225
> > vc_sm_cma_ioctl_alloc() error: we previously assumed 'buffer' could be
> > null (see line 1113)
> >=20
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > [jai.luthra: fix checkpatch and smatch warnings, add entry in MAINTAINE=
RS]
> > Co-developed-by: Jai Luthra <jai.luthra@ideasonboard.com>
> > Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> > ---
> >  MAINTAINERS                                             |    7 +
> >  drivers/platform/raspberrypi/Kconfig                    |    2 +
> >  drivers/platform/raspberrypi/Makefile                   |    1 +
> >  drivers/platform/raspberrypi/vc-sm-cma/Kconfig          |    9 +
> >  drivers/platform/raspberrypi/vc-sm-cma/Makefile         |    9 +
> >  drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c          | 1619 +++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++
> >  drivers/platform/raspberrypi/vc-sm-cma/vc_sm.h          |   83 ++++++
> >  drivers/platform/raspberrypi/vc-sm-cma/vc_sm_cma_vchi.c |  513 +++++++=
++++++++++++++++++++++++++++++
> >  drivers/platform/raspberrypi/vc-sm-cma/vc_sm_cma_vchi.h |   63 +++++
> >  drivers/platform/raspberrypi/vc-sm-cma/vc_sm_defs.h     |  298 +++++++=
++++++++++++++
> >  drivers/platform/raspberrypi/vc-sm-cma/vc_sm_knl.h      |   28 ++
> >  include/linux/raspberrypi/vc_sm_cma_ioctl.h             |  114 +++++++=
++
> >  12 files changed, 2746 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index df07d1a3c28d048e14a0f65c9f9ff01cc260013a..352c29bb3b94543bcb37c62=
d26d4c8bae48130ff 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5289,6 +5289,13 @@ L:     netdev@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/net/ethernet/broadcom/tg3.*
> > =20
> > +BROADCOM VIDEOCORE SHARED MEMORY DRIVER
> > +M:   Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> > +L:   linux-kernel@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/platform/raspberrypi/vc-sm-cma/*
> > +F:   include/linux/raspberrypi/vc_sm_cma*
> > +
> >  BROADCOM VK DRIVER
> >  M:   Scott Branden <scott.branden@broadcom.com>
> >  R:   Broadcom internal kernel review list <bcm-kernel-feedback-list@br=
oadcom.com>
> > diff --git a/drivers/platform/raspberrypi/Kconfig b/drivers/platform/ra=
spberrypi/Kconfig
> > index 2c928440a47c08e4d452fe838fe4105c608995a4..68a7a2d5701cd6821ec4b74=
18a86bf61011c83f6 100644
> > --- a/drivers/platform/raspberrypi/Kconfig
> > +++ b/drivers/platform/raspberrypi/Kconfig
> > @@ -48,5 +48,7 @@ config VCHIQ_CDEV
> >  endif
> > =20
> >  source "drivers/platform/raspberrypi/vchiq-mmal/Kconfig"
> > +source "drivers/platform/raspberrypi/vc-sm-cma/Kconfig"
> > +
> > =20
> >  endif
> > diff --git a/drivers/platform/raspberrypi/Makefile b/drivers/platform/r=
aspberrypi/Makefile
> > index 2a7c9511e5d8bbe11c05680eea016ef40796b648..1980f618e2185228e1fe173=
b1e94a3ede0e15bbb 100644
> > --- a/drivers/platform/raspberrypi/Makefile
> > +++ b/drivers/platform/raspberrypi/Makefile
> > @@ -13,3 +13,4 @@ vchiq-objs +=3D vchiq-interface/vchiq_dev.o
> >  endif
> > =20
> >  obj-$(CONFIG_BCM2835_VCHIQ_MMAL)     +=3D vchiq-mmal/
> > +obj-$(CONFIG_BCM_VC_SM_CMA)          +=3D vc-sm-cma/
> > diff --git a/drivers/platform/raspberrypi/vc-sm-cma/Kconfig b/drivers/p=
latform/raspberrypi/vc-sm-cma/Kconfig
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..7daec14dcfc14b6a1492ca9=
e1670807b5b4f87d8
> > --- /dev/null
> > +++ b/drivers/platform/raspberrypi/vc-sm-cma/Kconfig
> > @@ -0,0 +1,9 @@
> > +config BCM_VC_SM_CMA
> > +     tristate "VideoCore Shared Memory (CMA) driver"
> > +     select BCM2835_VCHIQ
>=20
> Why you do not have > + select DMA_SHARED_BUFFER
> > +     help
> > +       Say Y here to enable the shared memory interface that
> > +       supports sharing dmabufs with VideoCore.
> > +       This operates over the VCHIQ interface to a service
> > +       running on VideoCore.
> > diff --git a/drivers/platform/raspberrypi/vc-sm-cma/Makefile b/drivers/=
platform/raspberrypi/vc-sm-cma/Makefile
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..c12c1a13165c18927ab03e8=
edde762bcb7f32c9b
> > --- /dev/null
> > +++ b/drivers/platform/raspberrypi/vc-sm-cma/Makefile
> > @@ -0,0 +1,9 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +vc-sm-cma-$(CONFIG_BCM_VC_SM_CMA) :=3D \
> > +     vc_sm.o vc_sm_cma_vchi.o
> > +
> > +obj-$(CONFIG_BCM_VC_SM_CMA) +=3D vc-sm-cma.o
> > +
> > +ccflags-y +=3D \
> > +     -D__VCCOREVER__=3D0
>=20
> Drop
>=20
> > +
> > diff --git a/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c b/drivers/p=
latform/raspberrypi/vc-sm-cma/vc_sm.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..134a8fde7ebfc1325fcd2f5=
cc9b81ad48a22a802
> > --- /dev/null
> > +++ b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c
> > @@ -0,0 +1,1619 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * VideoCore Shared Memory driver using CMA.
> > + *
> > + * Copyright: 2018, Raspberry Pi (Trading) Ltd
> > + * Dave Stevenson <dave.stevenson@raspberrypi.org>
> > + *
> > + * Based on vmcs_sm driver from Broadcom Corporation for some API,
> > + * and taking some code for buffer allocation and dmabuf handling from
> > + * videobuf2.
> > + *
> > + *
> > + * This driver has 3 main uses:
> > + * 1) Allocating buffers for the kernel or userspace that can be share=
d with the
> > + *    VPU.
> > + * 2) Importing dmabufs from elsewhere for sharing with the VPU.
> > + * 3) Allocating buffers for use by the VPU.
> > + *
> > + * In the first and second cases the native handle is a dmabuf. Releas=
ing the
> > + * resource inherently comes from releasing the dmabuf, and this will =
trigger
> > + * unmapping on the VPU. The underlying allocation and our buffer stru=
cture are
> > + * retained until the VPU has confirmed that it has finished with it.
> > + *
> > + * For the VPU allocations the VPU is responsible for triggering the r=
elease,
> > + * and therefore the released message decrements the dma_buf refcount =
(with the
> > + * VPU mapping having already been marked as released).
> > + */
> > +
> > +/* ---- Include Files ------------------------------------------------=
----- */
>=20
> Drop such comments.
>=20
> > +#include <linux/cacheflush.h>
> > +#include <linux/cdev.h>
> > +#include <linux/device.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/dma-buf.h>
> > +#include <linux/errno.h>
> > +#include <linux/fs.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/module.h>
> > +#include <linux/mm.h>
> > +#include <linux/of_device.h>
>=20
> You don't use several of these headers...
>=20
> > +#include <linux/proc_fs.h>
> > +#include <linux/raspberrypi/vchiq_arm.h>
> > +#include <linux/raspberrypi/vchiq_bus.h>
> > +#include <linux/raspberrypi/vc_sm_cma_ioctl.h>
> > +#include <linux/slab.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/syscalls.h>
>=20
> Syscalls? What are you going to call here? Isn't this kernel code?
>=20
> > +#include <linux/types.h>
> > +
> > +#include "vc_sm_cma_vchi.h"
> > +
> > +#include "vc_sm.h"
> > +#include "vc_sm_knl.h"
> > +
> > +MODULE_IMPORT_NS("DMA_BUF");
> > +
> > +/* ---- Private Constants and Types ----------------------------------=
----- */
> > +
> > +#define DEVICE_NAME          "vcsm-cma"
> > +#define DEVICE_MINOR         0
> > +
> > +#define VC_SM_RESOURCE_NAME_DEFAULT       "sm-host-resource"
> > +
> > +#define VC_SM_DIR_ROOT_NAME  "vcsm-cma"
> > +#define VC_SM_STATE          "state"
> > +
>=20
> ...
>=20
> > +
> > +/* Driver loading. */
> > +static int bcm2835_vc_sm_cma_probe(struct vchiq_device *device)
> > +{
> > +     int err;
> > +
> > +     pr_info("%s: Videocore shared memory driver\n", __func__);
>=20
> Drop this and all such useless entry/exit or driver success messages.
> See coding style.
>=20
> Also, all drivers are supposed to use dev_xxx, not pr. This is some
> really old code.
>=20

Will do.

> > +
> > +     err =3D dma_set_mask_and_coherent(&device->dev, DMA_BIT_MASK(32));
> > +     if (err) {
> > +             dev_err(&device->dev, "dma_set_mask_and_coherent failed: =
%d\n",
> > +                     err);
> > +             return err;
> > +     }
> > +
> > +     sm_state =3D devm_kzalloc(&device->dev, sizeof(*sm_state), GFP_KE=
RNEL);
> > +     if (!sm_state)
> > +             return -ENOMEM;
> > +     sm_state->device =3D device;
> > +     mutex_init(&sm_state->map_lock);
> > +
> > +     mutex_init(&sm_state->kernelid_map_lock);
> > +     idr_init_base(&sm_state->kernelid_map, 1);
> > +
> > +     device->dev.dma_parms =3D devm_kzalloc(&device->dev,
> > +                                          sizeof(*device->dev.dma_parm=
s),
> > +                                          GFP_KERNEL);
> > +     /* dma_set_max_seg_size checks if dma_parms is NULL. */
> > +     dma_set_max_seg_size(&device->dev, 0x3FFFFFFF);
> > +
> > +     vchiq_add_connected_callback(device, vc_sm_connected_init);
> > +     return 0;
> > +}
> > +
> > +/* Driver unloading. */
> > +static void bcm2835_vc_sm_cma_remove(struct vchiq_device *device)
> > +{
> > +     pr_debug("[%s]: start\n", __func__);
>=20
> No
>=20
> > +     if (sm_inited) {
> > +             misc_deregister(&sm_state->misc_dev);
> > +
> > +             /* Remove all proc entries. */
> > +             debugfs_remove_recursive(sm_state->dir_root);
> > +
> > +             /* Stop the videocore shared memory service. */
> > +             vc_sm_cma_vchi_stop(sm_state->vchiq_instance, &sm_state->=
sm_handle);
> > +     }
> > +
> > +     if (sm_state) {
> > +             idr_destroy(&sm_state->kernelid_map);
> > +
> > +             /* Free the memory for the state structure. */
> > +             mutex_destroy(&sm_state->map_lock);
> > +     }
> > +
> > +     pr_debug("[%s]: end\n", __func__);
>=20
> Drop all such code. This is very poor and old coding practice. Kernel
> already gives you tracing for this exact purpose.> +}
> > +
> > +/* Kernel API calls */
> > +/* Get an internal resource handle mapped from the external one. */
> > +int vc_sm_cma_int_handle(void *handle)
> > +{
> > +     struct dma_buf *dma_buf =3D (struct dma_buf *)handle;
> > +     struct vc_sm_buffer *buf;
> > +
> > +     /* Validate we can work with this device. */
> > +     if (!sm_state || !handle) {
> > +             pr_err("[%s]: invalid input\n", __func__);
> > +             return 0;
> > +     }
> > +
> > +     buf =3D (struct vc_sm_buffer *)dma_buf->priv;
> > +     return buf->vc_handle;
> > +}
> > +EXPORT_SYMBOL_GPL(vc_sm_cma_int_handle);
> > +
> > +/* Free a previously allocated shared memory handle and block. */
>=20
> You need kerneldocs for every EXPORT
>=20
> > +int vc_sm_cma_free(void *handle)
> > +{
> > +     struct dma_buf *dma_buf =3D (struct dma_buf *)handle;
> > +
> > +     /* Validate we can work with this device. */
> > +     if (!sm_state || !handle) {
> > +             pr_err("[%s]: invalid input\n", __func__);
> > +             return -EPERM;
> > +     }
> > +
> > +     pr_debug("%s: handle %p/dmabuf %p\n", __func__, handle, dma_buf);
> > +
> > +     dma_buf_put(dma_buf);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(vc_sm_cma_free);
> > +
> > +/* Import a dmabuf to be shared with VC. */
>=20
> Kerneldocs everywhere for exports.
>=20
> > +int vc_sm_cma_import_dmabuf(struct dma_buf *src_dmabuf, void **handle)
> > +{
> > +     struct dma_buf *new_dma_buf;
> > +     int ret;
> > +
> > +     /* Validate we can work with this device. */
> > +     if (!sm_state || !src_dmabuf || !handle) {
> > +             pr_err("[%s]: invalid input\n", __func__);
> > +             return -EPERM;
> > +     }
> > +
> > +     ret =3D vc_sm_cma_import_dmabuf_internal(sm_state->data_knl, src_=
dmabuf,
> > +                                            -1, &new_dma_buf);
> > +
> > +     if (!ret) {
> > +             pr_debug("%s: imported to ptr %p\n", __func__, new_dma_bu=
f);
> > +
> > +             /* Assign valid handle at this time.*/
> > +             *handle =3D new_dma_buf;
> > +     } else {
> > +             /*
> > +              * succeeded in importing the dma_buf, but then
> > +              * failed to look it up again. How?
> > +              * Release the fd again.
> > +              */
> > +             pr_err("%s: imported vc_sm_cma_get_buffer failed %d\n",
> > +                    __func__, ret);
> > +     }
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(vc_sm_cma_import_dmabuf);
> > +
> > +static struct vchiq_driver bcm2835_vcsm_cma_driver =3D {
> > +     .probe =3D bcm2835_vc_sm_cma_probe,
> > +     .remove =3D bcm2835_vc_sm_cma_remove,
> > +     .driver =3D {
> > +             .name =3D DEVICE_NAME,
> > +             .owner =3D THIS_MODULE,
>=20
> Please clean up your driver from 10 year old left overs. Entire driver.
>=20
> Several patterns here show that you did not clean up this driver before
> submitting from basic coding style issues.
>=20

Indeed, my bad. For this first iteration, I was avoiding making any
significant changes to this driver other than major bugfixes, as this all
is fairly well-tested by the Raspberry Pi community.

But yes, this driver is very out of date compared to current mainline
standards. Will clean up before posting v2.

> > +     },
> > +};
> > +
> > +module_vchiq_driver(bcm2835_vcsm_cma_driver);
> > +
> > +MODULE_AUTHOR("Dave Stevenson");
> > +MODULE_DESCRIPTION("VideoCore CMA Shared Memory Driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("vcsm-cma");
>=20
> Why don't you have proper ID table? How this driver is supposed to be
> instantiated?
>=20

Sorry, I was unaware of this discussion:
https://lore.kernel.org/linux-media/2023100955-stunt-equate-c6fa@gregkh/

I will switch to using an ID table.

This and other drivers for audio, isp, codec are all instantiated as
platform drivers under the VCHIQ bus (PATCH 13/13).

>=20
> Best regards,
> Krzysztof

Thanks,
Jai

