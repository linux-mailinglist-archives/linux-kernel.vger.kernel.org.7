Return-Path: <linux-kernel+bounces-787724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1704B37A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 08:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D59C2083E9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 06:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF6D2E1745;
	Wed, 27 Aug 2025 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Y9hRrN/A"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE612D5C6A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756275889; cv=none; b=qAUwmUoXhYXX99S1IdGdS/Lh+66FYRVtu356P+v5rUV+HZMm/PVpUcXU94c4t8U3Pzwdi7yC3aiV+Ek/GeEBd1LDoAQsKby+l3z+0LCufH1kUlfRlP+OnIGun7GRgJz7/42PTU0JfuXmBOC+N7VUl/SoPK65jgUiJugDLP8BbyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756275889; c=relaxed/simple;
	bh=EtUNz7kErHkJEDA3qLyWBB/J5HXF/UDPj4Bc0vPU/vU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NMA5N1AfNhHeYmoJaiXQdRuhIpE4Jc8PYiY9npkz1i9FQsAkfSXKaIQX0ePu3H0Rq5VYlm0Gnz4tocD5x2DrvAho6BsZ7ST7KQOatqqzHp19n7C43kyxkWDX7lSuZE3Y+itGEBCZzZD+FuqXOX5BgW8jZZP8zXmF9BMrUkhQmhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Y9hRrN/A; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [223.190.80.94])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 318F2300E;
	Wed, 27 Aug 2025 08:23:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1756275820;
	bh=EtUNz7kErHkJEDA3qLyWBB/J5HXF/UDPj4Bc0vPU/vU=;
	h=From:Subject:Date:To:Cc:From;
	b=Y9hRrN/AKtDl5FZ5vwsQ+OV1MC9UrM3yz52y3qSRYCLtU9MFf0cCSbUqfzbXYBOsy
	 dZtMdfpL2ko0sm+XS8YOh5wBIN2slpZichZ04NptBDQhPFLhg8unX7ryRSf9IF5/ve
	 0U0AB1/n4BJSPIMzrERc9dtflTuePoRgRO7Nokkc=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Subject: [PATCH 0/5] staging: Destage VCHIQ interface and MMAL
Date: Wed, 27 Aug 2025 11:54:07 +0530
Message-Id: <20250827-vchiq-destage-v1-0-5052a0d81c42@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIekrmgC/x2MQQqAIBAAvxJ7TlDDrL4SHUS33IuVhgTi35OOw
 zBTIGEkTLB0BSJmSnSGBqLvwHoTDmTkGoPkUvFJapatp5s5TI9pcpgdChy1UtpBa66IO73/b91
 q/QBX3Sv+XwAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3934;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=EtUNz7kErHkJEDA3qLyWBB/J5HXF/UDPj4Bc0vPU/vU=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBorqSWMz/LstFox1XD8YJZ2iNfr3r6C2FjT8GwI
 3WLJG3SI/6JAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaK6klgAKCRBD3pH5JJpx
 RWpJD/9bobUpaIVvLFGyCTlDcB6FLJPOluThmgC/UewvxRBlhJ1Mq3MF0GT6OVS4r4ORGrpY45/
 2EbxmdPy7t4+73z3KzAaqK8Wq0s+tmEfJ200RO9rZx+P7rqXrrqhH8DX0x+NjDXLsm6r6Zo+q5o
 6SBai6Rb0EnLMuJ1q1Co1IazZwauc4DWOqlJZHWdu+GmczGWSQndYdaerqJ0rTVAqr29Ng+YoJs
 8y2nL65v2aguMoEDh0uOFQva2EWjLXuAElWOfpeEf+0wd7BGgosVM9ZinmLfEZQ+RhNAFRV3Exv
 NvkoKqIMAHKb2pEPjNFPd4vQdPAiQ2od/N6KfL6EsVJp3REdWGsPweYdNKVgV/Tb8jsLPQ0eD3t
 YntewlTgeNe+qIh9gAGGzpGzKDUTcyhvOQBvWijLGJ5OGn5AldhQINGqZhQpJjUEyEBxLEzih/r
 h82tvYrF7jWDe+FebM40hhYQY1+kKIkJ9+LU3FeyuOUsYgFLaAVTdEfqjQOpQ2kCu1ZjRBiSern
 4O8p4xoCNxoSpI0PNL+4vgsxnUqddtCW+0L9+Hu6+az/7udmfjWPm8rLT1panFsGXrpjRICBX+z
 I5TeyQxS9kebMzK/2z+tYIDyS3FmEPTYQPS+gq+AxQMvqHodwTw3iSnsFNJkhfoBbvE0HtE3Z6T
 VF92mV36iJv3t2Q==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

Hi,

The goal of this series is to begin the destaging and upstreaming
process for various Raspberry Pi peripherals that currently interact
with the firmware using the VCHIQ interface present in the staging tree.

While destaging the interface to drivers/platform/broadcom, also move
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
Jai Luthra (4):
      staging: vc04_services: Cleanup formatting TODO entry
      platform/broadcom: Destage VCHIQ interface
      media: staging: Drop bcm2835-camera driver
      platform/broadcom: Destage VCHIQ MMAL driver

Umang Jain (1):
      include: linux: Destage VCHIQ interface headers

 MAINTAINERS                                        |    2 +
 drivers/platform/Kconfig                           |    2 +
 drivers/platform/Makefile                          |    1 +
 drivers/platform/broadcom/Kconfig                  |   39 +
 drivers/platform/broadcom/Makefile                 |   15 +
 .../broadcom/vchiq-interface}/TESTING              |    0
 .../broadcom/vchiq-interface}/TODO                 |    6 -
 .../broadcom/vchiq-interface}/vchiq_arm.c          |    9 +-
 .../broadcom/vchiq-interface}/vchiq_bus.c          |    4 +-
 .../broadcom/vchiq-interface}/vchiq_core.c         |    4 +-
 .../broadcom/vchiq-interface}/vchiq_debugfs.c      |    6 +-
 .../broadcom/vchiq-interface}/vchiq_dev.c          |    7 +-
 .../broadcom/vchiq-interface}/vchiq_ioctl.h        |    3 +-
 .../broadcom}/vchiq-mmal/Kconfig                   |    0
 .../broadcom}/vchiq-mmal/Makefile                  |    0
 .../broadcom}/vchiq-mmal/mmal-common.h             |    0
 .../broadcom}/vchiq-mmal/mmal-encodings.h          |    0
 .../broadcom}/vchiq-mmal/mmal-msg-common.h         |    0
 .../broadcom}/vchiq-mmal/mmal-msg-format.h         |    0
 .../broadcom}/vchiq-mmal/mmal-msg-port.h           |    0
 .../broadcom}/vchiq-mmal/mmal-msg.h                |    0
 .../broadcom}/vchiq-mmal/mmal-parameters.h         |    0
 .../broadcom}/vchiq-mmal/mmal-vchiq.c              |    5 +-
 .../broadcom}/vchiq-mmal/mmal-vchiq.h              |    0
 drivers/staging/vc04_services/Kconfig              |   39 -
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
 .../raspberrypi => include/linux/vchiq}/vchiq.h    |    0
 .../vchiq_arm => include/linux/vchiq}/vchiq_arm.h  |    0
 .../vchiq_arm => include/linux/vchiq}/vchiq_bus.h  |    0
 .../vchiq_arm => include/linux/vchiq}/vchiq_cfg.h  |    0
 .../vchiq_arm => include/linux/vchiq}/vchiq_core.h |    2 +-
 .../linux/vchiq}/vchiq_debugfs.h                   |    0
 41 files changed, 86 insertions(+), 3671 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250827-vchiq-destage-39de1e67557d

Best regards,
-- 
Jai Luthra <jai.luthra@ideasonboard.com>


