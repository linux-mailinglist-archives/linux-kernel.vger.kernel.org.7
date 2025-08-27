Return-Path: <linux-kernel+bounces-788307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAF8B3829C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EDE3BC363
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B333176E8;
	Wed, 27 Aug 2025 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="neYI6t/L"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BD931E0EE
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298445; cv=none; b=Kb2G4I22UNqif+5TPjGr4EuCKizQ3URM+LkO84KuBGAHZFcLAt0kbSH9qt18qWIiVRR6vmvdxN14YWC7eMTWnCQ2uNApnJnpepD2MQy2iVlKbaT8ro8P+n6CgmAU9aUoIzUwwsHI6X0GgvWn3+Zr52CcyRytoSVFejsfCz93cm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298445; c=relaxed/simple;
	bh=Oj9INxjIP6sQuRtRZC1XEXWjUDxgq7X4x6/xPaQ16Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g//QYg/XPuiAM56vOh+S+978gjhZBO7rdh0A2IhBl7p55hZF45vplim2E6Q3c5WmMqoEhLRjwzxFEU5Ek7sqah9+hu5V+lZmD1UeuiqmtIJxb/WG5mR/ONz+HBWB4+PSMzuiFXnpYxX/bYP4t2Ufl5/XmlQmrzk5VQXPvM3O37M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=neYI6t/L; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [213.244.170.152])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 58F0D2093;
	Wed, 27 Aug 2025 14:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756298375;
	bh=Oj9INxjIP6sQuRtRZC1XEXWjUDxgq7X4x6/xPaQ16Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neYI6t/LDCSI6Okctg7uyem8zY2jgCfp4upaDeyVGnQp2R7L566zYTjeGqfBKPHxe
	 po/PaSSgr+A3CNPoSJ6hITWUoUPLVG39eEBdNRSjP9VQTNDgVB089FLlJBaYQQXrFR
	 SytrLKgNDAkQV9FHQwNEQHxPJeJlpF9UFVUeqU3c=
Date: Wed, 27 Aug 2025 14:40:16 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jai Luthra <jai.luthra@ideasonboard.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com,
	Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Umang Jain <uajain@igalia.com>
Subject: Re: [PATCH 1/5] include: linux: Destage VCHIQ interface headers
Message-ID: <20250827124016.GF5650@pendragon.ideasonboard.com>
References: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
 <20250827-vchiq-destage-v1-1-5052a0d81c42@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250827-vchiq-destage-v1-1-5052a0d81c42@ideasonboard.com>

Hi Jai,

Thank you for the patch.

On Wed, Aug 27, 2025 at 11:54:08AM +0530, Jai Luthra wrote:
> From: Umang Jain <umang.jain@ideasonboard.com>
> 
> Move the VCHIQ headers from drivers/staging/vc04_services/include to
> include/linux/vchiq
> 
> This is done so that they can be shared between the VCHIQ interface
> (which is going to be de-staged in a subsequent commit from staging)
> and the VCHIQ drivers left in the staging/vc04_services (namely
> bcm2835-audio, bcm2835-camera).
> 
> The include/linux/vchiq/ provides a central location to serve both
> of these areas.

Lots of SoC-specific headers are stored in include/linux/soc/$vendor/.
This would be include/linux/soc/bcm/vchiq/ in this case. I'm also fine
with include/linux/vchiq/ but other people may have a preference.

> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> ---
>  MAINTAINERS                                                      | 1 +
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c      | 5 +++--
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835.c            | 3 ++-
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835.h            | 3 +--
>  drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c    | 3 ++-
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c    | 9 +++++----
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c    | 4 ++--
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c   | 4 ++--
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c    | 6 +++---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c    | 7 ++++---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h  | 3 +--
>  drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c            | 5 +++--
>  .../include/linux/raspberrypi => include/linux/vchiq}/vchiq.h    | 0
>  .../interface/vchiq_arm => include/linux/vchiq}/vchiq_arm.h      | 0
>  .../interface/vchiq_arm => include/linux/vchiq}/vchiq_bus.h      | 0
>  .../interface/vchiq_arm => include/linux/vchiq}/vchiq_cfg.h      | 0
>  .../interface/vchiq_arm => include/linux/vchiq}/vchiq_core.h     | 2 +-
>  .../interface/vchiq_arm => include/linux/vchiq}/vchiq_debugfs.h  | 0
>  18 files changed, 30 insertions(+), 25 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe168477caa45799dfe07de2f54de6d6a1ce0615..f17ebb1fa51bd7e4dcb2ae1b0fced6d41685dc84 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4754,6 +4754,7 @@ T:	git https://github.com/broadcom/stblinux.git
>  F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>  F:	drivers/pci/controller/pcie-brcmstb.c
>  F:	drivers/staging/vc04_services
> +F:	include/linux/vchiq
>  N:	bcm2711
>  N:	bcm2712
>  N:	bcm283*
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> index 0dbe76ee557032d7861acfc002cc203ff2e6971d..c49f2f7409b84ed6ebdd71787566efb1bc230f55 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c
> @@ -4,11 +4,12 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/completion.h>
> +
> +#include <linux/vchiq/vchiq_arm.h>

You can group this with the other headers above (ideally in alphabetical
order when #include statements are already sorted). Same comment where
applicable below.

With that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +
>  #include "bcm2835.h"
>  #include "vc_vchi_audioserv_defs.h"
>  
> -#include "../interface/vchiq_arm/vchiq_arm.h"
> -
>  struct bcm2835_audio_instance {
>  	struct device *dev;
>  	unsigned int service_handle;
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> index b74cb104e9de00e7688a320949111a419cca084a..5011720940715c12a2d2fe58b40ed84dcb2e6824 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
> @@ -6,7 +6,8 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  
> -#include "../interface/vchiq_arm/vchiq_bus.h"
> +#include <linux/vchiq/vchiq_bus.h>
> +
>  #include "bcm2835.h"
>  
>  static bool enable_hdmi;
> diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
> index 49ec5b496edb4ba8634171b1390c4e15181e4048..7e63ef251c37269032fc20ae1237855245e5e0a7 100644
> --- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
> +++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
> @@ -5,13 +5,12 @@
>  #define __SOUND_ARM_BCM2835_H
>  
>  #include <linux/device.h>
> +#include <linux/vchiq/vchiq.h>
>  #include <linux/wait.h>
>  #include <sound/core.h>
>  #include <sound/pcm.h>
>  #include <sound/pcm-indirect.h>
>  
> -#include "../include/linux/raspberrypi/vchiq.h"
> -
>  #define MAX_SUBSTREAMS   (8)
>  #define AVAIL_SUBSTREAMS_MASK  (0xff)
>  
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> index fa7ea4ca4c36f4ec7f76f6ffbea9f45205116bb8..fcbbe1aa60b768e5a7a08a131f595a0457f4473a 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
> @@ -26,7 +26,8 @@
>  #include <media/v4l2-common.h>
>  #include <linux/delay.h>
>  
> -#include "../interface/vchiq_arm/vchiq_bus.h"
> +#include <linux/vchiq/vchiq_bus.h>
> +
>  #include "../vchiq-mmal/mmal-common.h"
>  #include "../vchiq-mmal/mmal-encodings.h"
>  #include "../vchiq-mmal/mmal-vchiq.h"
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 721b15b7e13b9f25cee7619575bbfa1a4734cce8..10138c1454dd7fdcbab6b95ea41f8e1ac2defc4b 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -30,11 +30,12 @@
>  #include <linux/uaccess.h>
>  #include <soc/bcm2835/raspberrypi-firmware.h>
>  
> -#include "vchiq_core.h"
> +#include <linux/vchiq/vchiq_core.h>
> +#include <linux/vchiq/vchiq_arm.h>
> +#include <linux/vchiq/vchiq_bus.h>
> +#include <linux/vchiq/vchiq_debugfs.h>
> +
>  #include "vchiq_ioctl.h"
> -#include "vchiq_arm.h"
> -#include "vchiq_bus.h"
> -#include "vchiq_debugfs.h"
>  
>  #define DEVICE_NAME "vchiq"
>  
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
> index 41ece91ab88aa647a348910a0b913d0b28a8c761..5d55dbff82150a84b15483e71718c48f5cb8caea 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
> @@ -11,8 +11,8 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  
> -#include "vchiq_arm.h"
> -#include "vchiq_bus.h"
> +#include <linux/vchiq/vchiq_arm.h>
> +#include <linux/vchiq/vchiq_bus.h>
>  
>  static int vchiq_bus_type_match(struct device *dev, const struct device_driver *drv)
>  {
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index e2cac0898b8faa3c255de6b8562c7096a9683c49..ac0379f5f45dfa331dc2fec8d580d176f931cf2b 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -15,8 +15,8 @@
>  #include <linux/rcupdate.h>
>  #include <linux/sched/signal.h>
>  
> -#include "vchiq_arm.h"
> -#include "vchiq_core.h"
> +#include <linux/vchiq/vchiq_arm.h>
> +#include <linux/vchiq/vchiq_core.h>
>  
>  #define VCHIQ_SLOT_HANDLER_STACK 8192
>  
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
> index d5f7f61c5626934b819e8ff322e22ae3d6158b31..b1a8f1abafc2fa83132b1a02ba343d71315950de 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
> @@ -5,9 +5,9 @@
>   */
>  
>  #include <linux/debugfs.h>
> -#include "vchiq_core.h"
> -#include "vchiq_arm.h"
> -#include "vchiq_debugfs.h"
> +#include <linux/vchiq/vchiq_core.h>
> +#include <linux/vchiq/vchiq_arm.h>
> +#include <linux/vchiq/vchiq_debugfs.h>
>  
>  #ifdef CONFIG_DEBUG_FS
>  
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> index 3b20ba5c736221ce1cacfc9ce86eca623382a30b..781d6dd64ee33816b52b62f1f25bcd33363d8e02 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> @@ -11,10 +11,11 @@
>  #include <linux/compat.h>
>  #include <linux/miscdevice.h>
>  
> -#include "vchiq_core.h"
> +#include <linux/vchiq/vchiq_core.h>
> +#include <linux/vchiq/vchiq_arm.h>
> +#include <linux/vchiq/vchiq_debugfs.h>
> +
>  #include "vchiq_ioctl.h"
> -#include "vchiq_arm.h"
> -#include "vchiq_debugfs.h"
>  
>  static const char *const ioctl_names[] = {
>  	"CONNECT",
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
> index afb71a83cfe7035e5dd61003fa99fd514ca18047..638469f18f859a0c7e738ef5bed7bf3c3ebebe59 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
> @@ -5,8 +5,7 @@
>  #define VCHIQ_IOCTLS_H
>  
>  #include <linux/ioctl.h>
> -
> -#include "../../include/linux/raspberrypi/vchiq.h"
> +#include <linux/vchiq/vchiq.h>
>  
>  #define VCHIQ_IOC_MAGIC 0xc4
>  #define VCHIQ_INVALID_HANDLE (~0)
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> index 3fe482bd279390a7586c49bde00f38c61558ca8e..f5e141908b0f91ca4172d48aee37f0329d239d7c 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> @@ -22,11 +22,12 @@
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/completion.h>
> +#include <linux/vchiq/vchiq.h>
>  #include <linux/vmalloc.h>
>  #include <media/videobuf2-vmalloc.h>
>  
> -#include "../include/linux/raspberrypi/vchiq.h"
> -#include "../interface/vchiq_arm/vchiq_arm.h"
> +#include <linux/vchiq/vchiq_arm.h>
> +
>  #include "mmal-common.h"
>  #include "mmal-vchiq.h"
>  #include "mmal-msg.h"
> diff --git a/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h b/include/linux/vchiq/vchiq.h
> similarity index 100%
> rename from drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
> rename to include/linux/vchiq/vchiq.h
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h b/include/linux/vchiq/vchiq_arm.h
> similarity index 100%
> rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.h
> rename to include/linux/vchiq/vchiq_arm.h
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h b/include/linux/vchiq/vchiq_bus.h
> similarity index 100%
> rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
> rename to include/linux/vchiq/vchiq_bus.h
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cfg.h b/include/linux/vchiq/vchiq_cfg.h
> similarity index 100%
> rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_cfg.h
> rename to include/linux/vchiq/vchiq_cfg.h
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/include/linux/vchiq/vchiq_core.h
> similarity index 99%
> rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> rename to include/linux/vchiq/vchiq_core.h
> index 9b4e766990a493d6e9d4e0604f2c84f4e7b77804..dbcb19e7a6d39b94967261c4ab23d6325e999249 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
> +++ b/include/linux/vchiq/vchiq_core.h
> @@ -15,7 +15,7 @@
>  #include <linux/spinlock_types.h>
>  #include <linux/wait.h>
>  
> -#include "../../include/linux/raspberrypi/vchiq.h"
> +#include "vchiq.h"
>  #include "vchiq_cfg.h"
>  
>  /* Do this so that we can test-build the code on non-rpi systems */
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h b/include/linux/vchiq/vchiq_debugfs.h
> similarity index 100%
> rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
> rename to include/linux/vchiq/vchiq_debugfs.h
> 

-- 
Regards,

Laurent Pinchart

