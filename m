Return-Path: <linux-kernel+bounces-875786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E65C19D39
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56CEE508E45
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C47032B9BC;
	Wed, 29 Oct 2025 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iAW0kRtk"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED292FAC0D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733866; cv=none; b=KzemOs5x21omNHrxA9JJi2VsS6IK1/VBYWXPnJXx7xjMypOsWvUamKmFgWYUP+++O45T1nx5oEyOm89Vz208lWGdgm6CNQSUBOjCqyDY+MOl5rVUp3ixx4PAfbnPtlnwr6pvtL8b+OnF0GJEH7XvqhXpCWFHh/3wysiB/swMekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733866; c=relaxed/simple;
	bh=zWwTB1bRbhn07J7+tC2NHNnJhjR0kZ1TVfVS15isUIQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DWrAGe2Epa2wu149E47U/VIAHiuD1dmBG8tPSKxP5bjjwHBPl6L+nzvuheiN3QDiPBc3CtPVTsROlt7I+BjFTf2e4dvMtTAJMfMRlRxhVcAyHZz54bYvdgnxDzEkJ7B+8KEvMcZwS3k/U33HxrL37WWstuP7XRMp8vdWj/D/E0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=iAW0kRtk; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E57B911DD;
	Wed, 29 Oct 2025 11:29:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761733752;
	bh=zWwTB1bRbhn07J7+tC2NHNnJhjR0kZ1TVfVS15isUIQ=;
	h=From:Subject:Date:To:Cc:From;
	b=iAW0kRtk+Inveiq3hawn16XE7/i5hHXHbL7hdWMCUoMGSW3+EWDDabS/ns8G8hD5x
	 CQ3Mmf11SS5wWB9EYoDArLN5TQSAMT6Jtp66c0dTVJIlpVo27I4Dh0fspnd3mNNjcJ
	 8nmcPkc5A3T9EAm5Tgjl3IEJEOjyk1D2tIlFvRnA=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Subject: [PATCH v3 0/7] staging: Destage VCHIQ interface and MMAL
Date: Wed, 29 Oct 2025 16:00:04 +0530
Message-Id: <20251029-vchiq-destage-v3-0-da8d6c83c2c5@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKzsAWkC/3XMsQ7CIBDG8VdpmMUALYU6+R7GAbnT3mCp0BBN0
 3eXdnFQx/9dvt/MEkbCxA7VzCJmShSGEvWuYr53ww05QWmmhNLCKsOz7+nBAdPkyrPuACW2Rms
 DrGzGiFd6bt7pXLqnNIX42vgs1+s/KUsuuBZaOQFW+kYdCdClMFyCi7D34c5WMKsP0okvRBWkt
 bYpEHhn7A9kWZY36VYT+vYAAAA=
X-Change-ID: 20250827-vchiq-destage-39de1e67557d
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kernel-list@raspberrypi.com, 
 Stefan Wahren <wahrenst@gmx.net>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Phil Elwell <phil@raspberrypi.com>, Umang Jain <uajain@igalia.com>, 
 Jai Luthra <jai.luthra@ideasonboard.com>, Umang Jain <uajain@igalia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7528;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=zWwTB1bRbhn07J7+tC2NHNnJhjR0kZ1TVfVS15isUIQ=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpAezYJJ7vcBBXayN5I77b8KgFd5Ud0BnyGvfQr
 PCTl17L6bmJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQHs2AAKCRBD3pH5JJpx
 RXVrD/9zV9yvNJDKOHDfoUhNEM6Enw+HOaxOxou+spvIrqMVbVIS5TAzNxBFftBW7SXFCTteuB0
 m389+B097UHcRNRTfyKJO/5ARiZvU0/lQn6FyQuiuWHOh9F9jMoQuvHvK6F3mtkaWF7KOytDtEh
 knooL78StOFYoOs3SU685rgj/QP6mo0xLhw3NTepBmEOM++hbGGtPU5Z2jGg4WDpoAdFD2KFKew
 0Gwl/9O8Uwix0V0r79/7zesDIRPy47ypxmwV7671MMrANMCBQ8z/FBr796ZmiZHMngipkbUDFVK
 OEGNA/wTJJy2Qv/7h13TXlmasS9BoXbwk47SImkI3LSm7VtCN1pGjarQVaYVUhNpuX2/HWaBPMe
 l/tNUelevk6jc5m9qY/hce1DvtQUea2lNZyJ7rBIKYulHOwuCTKixPPmRedKaO7rWfpg+99aqdQ
 UvTf8zpTddnd5qsQ8qjpFTAUGCI+PJIq/C/lgVJC8RA5cJtACs6LHZdxAOS9wPuSQDeq0neCOLI
 OBULVH/0PZeSC9FtrWSAwkXMUMve9VBYtXb4ym8FlKQZsPyqoZymUC+IIDGUGTAzTXZUxvKqtv+
 zDde3uciBJaSLDa2Smr3bw0V+WgVUuXKr7DtnHQM/+r0sIPtGT6EPMemcw6Sxx6ZLSQnI06pUGR
 FXAj681stkRVrrQ==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

Hi,

The goal of this series is to begin the destaging and upstreaming
process for various Raspberry Pi peripherals that currently interact
with the firmware using the VCHIQ interface present in the staging tree.

While destaging the interface to drivers/platform/raspberrypi, also move
the VCHIQ memory abstraction layer (MMAL) driver. Secondly, drop the
bcm2835-camera driver, as the bcm2835-unicam driver using V4L2 framework
is the recommended way to capture from CSI sensors on this platform.

The bcm2835-audio driver is left as-is in the staging tree, as I am not
an expert on ALSA. Volunteers are welcome :)

In (a) subsequent series, I will upstream the following components:
- working driver for the OV5647 sensor in raspberry pi camera v1 module
- vc-sm-cma driver
- bcm2835-isp driver

Thanks,
	Jai

Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
Changes in v3:
- Reorder patches, drop bcm2835-camera first before destaging interface
- Add a new patch to drop usage of bcm2835-camera from vchiq_arm
- Add a new patch improving inline documentation (picked from
  https://lore.kernel.org/linux-staging/20250509221152.13564-2-wahrenst@gmx.net/)
- Update MAINTAINERS file to cover all drivers starting with vchiq-*
  from the first commit, rather than changing it twice
- Replace s/broadcom/raspberrypi in commit title and messages
- Link to v2: https://lore.kernel.org/r/20250907-vchiq-destage-v2-0-6884505dca78@ideasonboard.com

Changes in v2:
- Destage to drivers/platform/raspberrypi instead
- Move BCM_VIDECORE menuconfig definition to the new directory's Kconfig
  along with BCM2835_VCHIQ and VCHIQ_CDEV
- Link to v1: https://lore.kernel.org/r/20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com

---
Jai Luthra (6):
      staging: vc04_services: Drop bcm2835-camera driver
      staging: vchiq_arm: Remove bcm2835_camera from vchiq
      include: linux: Destage VCHIQ interface headers
      staging: vc04_services: Cleanup VCHIQ TODO entries
      platform/raspberrypi: Destage VCHIQ interface
      platform/raspberrypi: Destage VCHIQ MMAL driver

Phil Elwell (1):
      staging: vchiq_arm: Improve inline documentation

 MAINTAINERS                                                                                                 |    2 +
 drivers/platform/Kconfig                                                                                    |    2 +
 drivers/platform/Makefile                                                                                   |    1 +
 drivers/platform/raspberrypi/Kconfig                                                                        |   52 ++
 drivers/platform/raspberrypi/Makefile                                                                       |   15 +
 drivers/{staging/vc04_services/interface => platform/raspberrypi/vchiq-interface}/TESTING                   |    0
 drivers/platform/raspberrypi/vchiq-interface/TODO                                                           |    4 +
 drivers/{staging/vc04_services/interface/vchiq_arm => platform/raspberrypi/vchiq-interface}/vchiq_arm.c     |   20 +-
 drivers/{staging/vc04_services/interface/vchiq_arm => platform/raspberrypi/vchiq-interface}/vchiq_bus.c     |    4 +-
 drivers/{staging/vc04_services/interface/vchiq_arm => platform/raspberrypi/vchiq-interface}/vchiq_core.c    |    4 +-
 drivers/{staging/vc04_services/interface/vchiq_arm => platform/raspberrypi/vchiq-interface}/vchiq_debugfs.c |    6 +-
 drivers/{staging/vc04_services/interface/vchiq_arm => platform/raspberrypi/vchiq-interface}/vchiq_dev.c     |    7 +-
 drivers/{staging/vc04_services/interface/vchiq_arm => platform/raspberrypi/vchiq-interface}/vchiq_ioctl.h   |    3 +-
 drivers/{staging/vc04_services => platform/raspberrypi}/vchiq-mmal/Kconfig                                  |    0
 drivers/{staging/vc04_services => platform/raspberrypi}/vchiq-mmal/Makefile                                 |    0
 drivers/{staging/vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-common.h                            |    0
 drivers/{staging/vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-encodings.h                         |    0
 drivers/{staging/vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-msg-common.h                        |    0
 drivers/{staging/vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-msg-format.h                        |    0
 drivers/{staging/vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-msg-port.h                          |    0
 drivers/{staging/vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-msg.h                               |    0
 drivers/{staging/vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-parameters.h                        |    0
 drivers/{staging/vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-vchiq.c                             |    5 +-
 drivers/{staging/vc04_services => platform/raspberrypi}/vchiq-mmal/mmal-vchiq.h                             |    0
 drivers/staging/vc04_services/Kconfig                                                                       |   49 --
 drivers/staging/vc04_services/Makefile                                                                      |   14 -
 drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c                                                 |    5 +-
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.c                                                       |    3 +-
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.h                                                       |    3 +-
 drivers/staging/vc04_services/bcm2835-camera/Kconfig                                                        |   13 -
 drivers/staging/vc04_services/bcm2835-camera/Makefile                                                       |    6 -
 drivers/staging/vc04_services/bcm2835-camera/TODO                                                           |   17 -
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c                                               | 2011 ---------------------------------------------------------------
 drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.h                                               |  142 -----
 drivers/staging/vc04_services/bcm2835-camera/controls.c                                                     | 1399 --------------------------------------------
 drivers/staging/vc04_services/interface/TODO                                                                |   28 -
 {drivers/staging/vc04_services/include => include}/linux/raspberrypi/vchiq.h                                |    0
 {drivers/staging/vc04_services/interface/vchiq_arm => include/linux/raspberrypi}/vchiq_arm.h                |    0
 {drivers/staging/vc04_services/interface/vchiq_arm => include/linux/raspberrypi}/vchiq_bus.h                |    0
 {drivers/staging/vc04_services/interface/vchiq_arm => include/linux/raspberrypi}/vchiq_cfg.h                |    0
 {drivers/staging/vc04_services/interface/vchiq_arm => include/linux/raspberrypi}/vchiq_core.h               |   58 +-
 {drivers/staging/vc04_services/interface/vchiq_arm => include/linux/raspberrypi}/vchiq_debugfs.h            |    0
 42 files changed, 163 insertions(+), 3710 deletions(-)
---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20250827-vchiq-destage-39de1e67557d

Best regards,
-- 
Jai Luthra <jai.luthra@ideasonboard.com>


