Return-Path: <linux-kernel+bounces-880691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A3648C26587
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2983934AFA2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FDC32ED4B;
	Fri, 31 Oct 2025 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uId7y65h"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18681309DDB
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931697; cv=none; b=aspUUaME8WudjJ72sW1pPFvsnrZzpUcOESqeHnTpyZ/eiBCODA1SQ/GhpLYjmwVvRs6rD2pmvftthUZF9/1wQygdvvnPk1oOUv0vDOOqmX6lF9ulMWUfnALBHucoM6ONGBrE9/jPs1M2Fpf5AureA+r/XYxpCSI8m0MV/VqeXW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931697; c=relaxed/simple;
	bh=9SSY1folB+duN1Z637f7cJ0O43yr4Zt9RriQBj05roM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=McBW+Q0tBtrmdMBzQFGudq2HD1oLL84XIurmc8lzs6nN5x+b99ZnjvdF/qAGwuhrBk/MMaoZJ9okPH6wSMbwlNX4mFKiIDTHnVv27RdF2T89vdRk+0lZ7KU1lImAQj4uaHyrT8tKS1Mai2UfREmGzMiPPAdYLteeKTMUjV5fQeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=uId7y65h; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 19DC1B5;
	Fri, 31 Oct 2025 18:26:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761931575;
	bh=9SSY1folB+duN1Z637f7cJ0O43yr4Zt9RriQBj05roM=;
	h=From:Subject:Date:To:Cc:From;
	b=uId7y65hlTu2bACspNHUnUPnO2ewYDVwKqha0H6TwWXSU/U0SJ9/NB3tq3+Rm/QZa
	 sxp8z4lFiTdlrkM28Uklg2bDOr1yTmhMwUTwE6naVkjmSA9Wdgiqp7F8lR/lWdtX7l
	 zuN4kxbSCGvvz9FCy+/0kfEnbHkAylGQVnqJrUmA=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Subject: [PATCH 00/13] platform/raspberrypi: Add Broadcom Videocore shared
 memory support
Date: Fri, 31 Oct 2025 22:57:20 +0530
Message-Id: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHjxBGkC/yXNwQ6CMAyA4VchO1szN4FBjPE9DIfRFdlhICsSE
 8O7O+D4t+nXn2CKnljU2U9EWjz7cUhxOWUCezu8CLxLLZRU+UVqCe0VFgQOgMFCV5SqRF2hU7l
 IJ+9Inf/u3LM5OtL0Sep8DEUgZrurdXY7UFUlsfcTOOJ52y0aJDhrXIFGo8L84R1ZHod2tNGdc
 Qz37VlrmSBF8HOdaWuKQprSGF2JZl3/IRC+59kAAAA=
X-Change-ID: 20251030-b4-vc-sm-cma-f6727c39cd25
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 bcm-kernel-feedback-list@broadcom.com
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jai Luthra <jai.luthra@ideasonboard.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.org>, 
 Dom Cobley <popcornmix@gmail.com>, 
 Alexander Winkowski <dereference23@outlook.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Juerg Haefliger <juerg.haefliger@canonical.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4137;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=9SSY1folB+duN1Z637f7cJ0O43yr4Zt9RriQBj05roM=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpBPGTIF52f00vRd2pwHOlyYuo04j8E+9SkmKbr
 CumA/Ys9leJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQTxkwAKCRBD3pH5JJpx
 RZSxEADPMPUvu2vFXvGNh0skoDic2m8IZq4TOVSmTG0MihhMvHlaoft3qTBJFmIW9UMiid4plg4
 0/YTxc2mvYn26HrhtHq3mpAr88EdHq0ew7168lt2aFmQzffx9SnACNOxaDh8vlCJPfXJHnr1oyB
 8SFJuhftOKU0d0q1BolETdOK6ZIF1V26nAgKuK7HcSnVg+6LPY9yexPSdbpCXjHCQrteYTz6AB/
 Iw6nlfS9NN2rpIbPdayWlBX3Hvu9FwjJFO9CFxc+pHi8yp4nMlB0tQHwY0pq1pddLTsbRYZD7zp
 toh5brPceUEWgMnVutqbi4KB6gxSsa9EP+kfLsw8JO5e8Oy3K8sj1NtvnNck9XkJlk20C+rrA6D
 Mfng5Ko6DAeCmC8rgGkI/qgQCLMjboBtGQNfR3QQABsHQBYN2Jd28IjBQ8I1QkuYilrDUmSVQ88
 m0I3HGgruYNxSOQUanuAh44nNzUbrBoGjUQhF9SfM7i1XvJSLipw37hv9h+NWIM4+kLmoYMlw2X
 sS9x7m4X2iTc544HfmURFye1aU5ZVsG3l8AmSwr3r88mrHySFV8ih8XSyF6gB3y/iDT+KLnSDB6
 LvUmmSiY0qlPHnwO10rmkATrhpws+YLMT07POOYyD4vtxMxDITcwJ4De/rNuH/NpFGUMCDXnLFt
 QIB+ONdx2mmwWTA==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

Hi,

The vc-sm-cma driver allows contiguous memory blocks to be imported into
the VideoCore VPU memory map. This series adds support for this driver
and various changes to VCHIQ MMAL layer required to get this functional.

These changes have lived in the staging directory of the downstream
Raspberry Pi tree since quite some time, but are necessary for getting
the VCHIQ based peripherals like the ISP and codec functional in
mainline.

This series depends on an earlier series, destaging VCHIQ interface and
MMAL driver, which was posted here:
https://lore.kernel.org/all/20251029-vchiq-destage-v3-0-da8d6c83c2c5@ideasonboard.com/

Thanks,
	Jai

Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
Dave Stevenson (13):
      platform/raspberrypi: vchiq-mmal: Avoid use of bool in structures
      platform/raspberrypi: vchiq-mmal: Add support for event callbacks.
      platform/raspberrypi: vchiq-mmal: Support sending data to MMAL ports
      platform/raspberrypi: vchiq-mmal: Fix client_component for 64 bit kernel
      platform/raspberrypi: vchiq-mmal: Add in the bayer and gray formats
      platform/raspberrypi: vchiq-mmal: Update video parameters
      platform/raspberrypi: vchiq-mmal: Free the event context for control ports
      platform/raspberrypi: vchiq-mmal: Fix memory leak in error path
      platform/raspberrypi: Add new vc-sm-cma driver
      platform/raspberrypi: vchiq-mmal: Use vc-sm-cma to support zero copy
      platform/raspberrypi: vchiq-mmal: Reset buffers_with_vpu on port_enable
      platform/raspberrypi: vchiq-mmal: Add defines for mmal_es_format flags
      platform/raspberrypi: vchiq: Register vc-sm-cma as a platform driver

 MAINTAINERS                                               |    7 +
 drivers/platform/raspberrypi/Kconfig                      |    2 +
 drivers/platform/raspberrypi/Makefile                     |    1 +
 drivers/platform/raspberrypi/vc-sm-cma/Kconfig            |    9 +
 drivers/platform/raspberrypi/vc-sm-cma/Makefile           |    9 +
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c            | 1619 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm.h            |   83 ++++++
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm_cma_vchi.c   |  513 ++++++++++++++++++++++++++++++++++++
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm_cma_vchi.h   |   63 +++++
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm_defs.h       |  298 +++++++++++++++++++++
 drivers/platform/raspberrypi/vc-sm-cma/vc_sm_knl.h        |   28 ++
 drivers/platform/raspberrypi/vchiq-interface/vchiq_arm.c  |    3 +
 drivers/platform/raspberrypi/vchiq-mmal/Kconfig           |    3 +-
 drivers/platform/raspberrypi/vchiq-mmal/mmal-common.h     |    5 +
 drivers/platform/raspberrypi/vchiq-mmal/mmal-encodings.h  |   41 +++
 drivers/platform/raspberrypi/vchiq-mmal/mmal-msg-format.h |   10 +
 drivers/platform/raspberrypi/vchiq-mmal/mmal-msg.h        |   35 +++
 drivers/platform/raspberrypi/vchiq-mmal/mmal-parameters.h |   38 ++-
 drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.c      |  269 +++++++++++++++++--
 drivers/platform/raspberrypi/vchiq-mmal/mmal-vchiq.h      |    5 +
 include/linux/raspberrypi/vc_sm_cma_ioctl.h               |  114 ++++++++
 21 files changed, 3132 insertions(+), 23 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251030-b4-vc-sm-cma-f6727c39cd25
prerequisite-message-id: <20251029-vchiq-destage-v3-0-da8d6c83c2c5@ideasonboard.com>
prerequisite-patch-id: b0a98fe9aa5b5cd548c55f01fb51962d15c2a86d
prerequisite-patch-id: a745143658be8020e9c906f7b503473b54cacb82
prerequisite-patch-id: 163c9bc2d42a9b743ae726d1e5559fdc8988d5a2
prerequisite-patch-id: 8d81e9507d7e47daca70eb681b1400d96e5cd869
prerequisite-patch-id: 28f7ab0db3909b8ab9201d47741e7f941322680f
prerequisite-patch-id: c39620e68ca4ef9441f621db946c072f3be66721
prerequisite-patch-id: 47af76c416f5d80839e384ffb5b2d37032d2ee7a

Best regards,
-- 
Jai Luthra <jai.luthra@ideasonboard.com>


