Return-Path: <linux-kernel+bounces-804566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 070B1B479E5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DF83BD7BB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 08:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C5A21B9D2;
	Sun,  7 Sep 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="T19QGUw7"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37898218AC1
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757235486; cv=none; b=LvGxRDyzMnFcnHoKukiMww5Bb75CUanVLLB14BzqAoGLt13qRGi6VKJqVcbox7LvRI/d6TMqtO5PIdaYHDzdXFwdAcYJ4kTmv5FBoKULKrjcRaPaKip+1qJMgVU5qStYjMfNBpq19c1SA2zkhXmLcHWi8TJR/z6RxFQq/gKoUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757235486; c=relaxed/simple;
	bh=m/UHy/ZLrHUE5XV08ED24MSjRUavmbTkg1b809+RU8k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vm9EdoFIigPg36twk5B+aaQm/ur/+NBdcB7cu7S5VCDO2PxkTiJVvTo2OiVpX3W8j6apgwXV8aZvcnobu5oWtmEt80Dc3+ccN8zsIY/l7h/rc2jRKb8w4wx+0MzqF8KYoRuFv5q9tXFkbWRzivfkf04BwxpmDKXi7XltSIRlkHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=T19QGUw7; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c67:84a2:d86d:fcf7:24b4:e467])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id B734E156F;
	Sun,  7 Sep 2025 10:56:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757235402;
	bh=m/UHy/ZLrHUE5XV08ED24MSjRUavmbTkg1b809+RU8k=;
	h=From:Subject:Date:To:Cc:From;
	b=T19QGUw7UlW8ym1Uk9jeflpbJ0wV7oLmLHJUIzjZRlPsvJzRSrXVRownXT4OLqJKL
	 5VKcb90+Iz7cJEizdLWAYG7H2VzBJJnUIQeggBj8OEFS5SoSTYfidFIQjGjhVZMDHF
	 g5haGaLtnYQlnfpMNzY8ptJ+nDkhB9/nlRa+qhMg=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Subject: [PATCH v2 0/5] staging: Destage VCHIQ interface and MMAL
Date: Sun, 07 Sep 2025 14:26:20 +0530
Message-Id: <20250907-vchiq-destage-v2-0-6884505dca78@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALRIvWgC/3WMMQ4CIRBFr7KZWgygyGrlPcwWyIwyhaCwIZoNd
 xe3t3z/570FCmWmAqdhgUyVC6fYQW8G8MHFOwnGzqClNnLUVlQf+CWQyuz6uTsiKTpYYyxCd56
 Zbvxee5epc+Ayp/xZ81X91n+lqoQURhrtJI7K7/WZkVxJ8Zpcxq1PD5haa1/q7yECsQAAAA==
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
 Jai Luthra <jai.luthra@ideasonboard.com>, 
 Umang Jain <umang.jain@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4287;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=m/UHy/ZLrHUE5XV08ED24MSjRUavmbTkg1b809+RU8k=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBovUkFefTa9sxVPoan3sf14F8HxeMoyHhT0YFvN
 ZNF5857Q7CJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaL1JBQAKCRBD3pH5JJpx
 RSPeEACPrBHdgfZT6tFgQOYwtqOzPQREVps+92zZIoOJ5pvGZsE+8wS9apRuYO8XIZEiht51P0s
 hrBKXuCekn7r+x/KU2Fuawuozr2aGCRbMPa74OxPl1ZdUr0IK7nWRPdy4x4hbHPMtgga3eCUq7F
 YJBHpg0TFd0blqFj1FkCt1pjQXN7Ub0gTZsEw/HkJa38L8tDgE2XkekBSfOnpPN9zn+BYZpMViu
 Z/PQ7bGEQMbMZBGlK6rC4g2RJgsJ+gAocqqhcAlzjXkixWYa1ouGZUP3qM2uMxSaFjdXl7jngOT
 1UxDsAbwri7V25/MRKw6W8vviM58qcwfPJ2a7/9tDFDVmrY9XCXUaaqMjj181H5VB95wsb1UggE
 nYuzdtoE63DrVBe3kVbcr37bHsP38NwGyqoZLQS2yW0RKfArRFcJkf/UhHuwJJ/fYuBdzdyoisC
 xMywOqdw1mGmzReqRUTk697u4AwhW+F3qQB/b7T2gjfp604EUA8Mj6LWawkKvMlPEETPIDflHMX
 os4F96CvdxVMNz0F+MA3Rmeu3kWnhkrXMYmMA57Bi8WYLoGtebPRiJJlJp3Hh6cx5iQl62rMnAm
 CvRwxkadfqTFrwZ2DUZR0F6Zk5U8uE44znnHT9/gdkRy89PSWF1H9S248eV2u3HrTRclZxVko3o
 zJKf4eV9h/AVoCg==
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

In (a) subsequent series, I will upstream the following components that
use VCHIQ interface:
- vc-sm-cma driver
- bcm2835-isp driver

Thanks,
	Jai

Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
Changes in v2:
- Destage to drivers/platform/raspberrypi instead
- Move BCM_VIDECORE menuconfig definition to the new directory's Kconfig
  along with BCM2835_VCHIQ and VCHIQ_CDEV
- Link to v1: https://lore.kernel.org/r/20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com

---
Jai Luthra (4):
      staging: vc04_services: Cleanup VCHIQ TODO entries
      platform/broadcom: Destage VCHIQ interface
      media: staging: Drop bcm2835-camera driver
      platform/broadcom: Destage VCHIQ MMAL driver

Umang Jain (1):
      include: linux: Destage VCHIQ interface headers

 MAINTAINERS                                        |    2 +
 drivers/platform/Kconfig                           |    2 +
 drivers/platform/Makefile                          |    1 +
 drivers/platform/raspberrypi/Kconfig               |   52 +
 drivers/platform/raspberrypi/Makefile              |   15 +
 .../raspberrypi/vchiq-interface}/TESTING           |    0
 drivers/platform/raspberrypi/vchiq-interface/TODO  |    4 +
 .../raspberrypi/vchiq-interface}/vchiq_arm.c       |    9 +-
 .../raspberrypi/vchiq-interface}/vchiq_bus.c       |    4 +-
 .../raspberrypi/vchiq-interface}/vchiq_core.c      |    4 +-
 .../raspberrypi/vchiq-interface}/vchiq_debugfs.c   |    6 +-
 .../raspberrypi/vchiq-interface}/vchiq_dev.c       |    7 +-
 .../raspberrypi/vchiq-interface}/vchiq_ioctl.h     |    3 +-
 .../raspberrypi}/vchiq-mmal/Kconfig                |    0
 .../raspberrypi}/vchiq-mmal/Makefile               |    0
 .../raspberrypi}/vchiq-mmal/mmal-common.h          |    0
 .../raspberrypi}/vchiq-mmal/mmal-encodings.h       |    0
 .../raspberrypi}/vchiq-mmal/mmal-msg-common.h      |    0
 .../raspberrypi}/vchiq-mmal/mmal-msg-format.h      |    0
 .../raspberrypi}/vchiq-mmal/mmal-msg-port.h        |    0
 .../raspberrypi}/vchiq-mmal/mmal-msg.h             |    0
 .../raspberrypi}/vchiq-mmal/mmal-parameters.h      |    0
 .../raspberrypi}/vchiq-mmal/mmal-vchiq.c           |    5 +-
 .../raspberrypi}/vchiq-mmal/mmal-vchiq.h           |    0
 drivers/staging/vc04_services/Kconfig              |   49 -
 drivers/staging/vc04_services/Makefile             |   14 -
 .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    |    5 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  |    3 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.h  |    3 +-
 .../staging/vc04_services/bcm2835-camera/Kconfig   |   13 -
 .../staging/vc04_services/bcm2835-camera/Makefile  |    6 -
 drivers/staging/vc04_services/bcm2835-camera/TODO  |   17 -
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  | 2011 --------------------
 .../vc04_services/bcm2835-camera/bcm2835-camera.h  |  142 --
 .../vc04_services/bcm2835-camera/controls.c        | 1399 --------------
 drivers/staging/vc04_services/interface/TODO       |   28 -
 .../include => include}/linux/raspberrypi/vchiq.h  |    0
 .../linux/raspberrypi}/vchiq_arm.h                 |    0
 .../linux/raspberrypi}/vchiq_bus.h                 |    0
 .../linux/raspberrypi}/vchiq_cfg.h                 |    0
 .../linux/raspberrypi}/vchiq_core.h                |    2 +-
 .../linux/raspberrypi}/vchiq_debugfs.h             |    0
 42 files changed, 103 insertions(+), 3703 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250827-vchiq-destage-39de1e67557d

Best regards,
-- 
Jai Luthra <jai.luthra@ideasonboard.com>


