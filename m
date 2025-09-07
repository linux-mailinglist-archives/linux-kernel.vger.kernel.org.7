Return-Path: <linux-kernel+bounces-804568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C20B479E7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 10:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1143201007
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 08:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA7622128B;
	Sun,  7 Sep 2025 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZR4SG/pN"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23724220F38
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757235492; cv=none; b=qev09wiQKP58Aw0lmuu2ujEDCTkKLBzUIpW+GBrNb338UUfAd91L0AAiqC1gLxJCvYEPYf8k2nVHVBKD0qLg/52H6/Pqa1Ky1yC8e1Biy2TWZgLssk1k7GqvfndDWilQ4exWSwtE1bkNR6F+2gmcAm9Y0sQRtITe7aoOn2/isRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757235492; c=relaxed/simple;
	bh=urxKbO6IjAEWXg1wOZAzBCB0JekqsXSzdYZrt1rKapI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qa0ZvJ6vTJfCZ6GqmyHkNb30pT+ASo3vqASef1d4TjtCILTlvJvenm0Cbwjn3MRUcIFhxDTs7ksbLnX/IC0z2FFEVK0IuRxzgtFpayRVI1LmrmLghPWmoRNW1R0b/s7BVS1U/LVdKejdWZZSwk2T9eORbsa90dpsZyZLTpyQrR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZR4SG/pN; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c67:84a2:d86d:fcf7:24b4:e467])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 04984156F;
	Sun,  7 Sep 2025 10:56:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1757235418;
	bh=urxKbO6IjAEWXg1wOZAzBCB0JekqsXSzdYZrt1rKapI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZR4SG/pNBk4nlWoCksclD77t91JEhHkk9hpbebJ3z+W107d6CVssGiQRLDLCEwyA5
	 qMdLzjZG+qq3R63gKaQaWbAhvUde8K1QOTR2UQyvp3Gkl+uyDLxN0p8OHFS65UK1gb
	 a3hVxVq1VJPic5hwEUtY/xxNhU5/Q4ZrJdb81f1c=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Sun, 07 Sep 2025 14:26:22 +0530
Subject: [PATCH v2 2/5] staging: vc04_services: Cleanup VCHIQ TODO entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-vchiq-destage-v2-2-6884505dca78@ideasonboard.com>
References: <20250907-vchiq-destage-v2-0-6884505dca78@ideasonboard.com>
In-Reply-To: <20250907-vchiq-destage-v2-0-6884505dca78@ideasonboard.com>
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
 Jai Luthra <jai.luthra@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=urxKbO6IjAEWXg1wOZAzBCB0JekqsXSzdYZrt1rKapI=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBovUkHRs79bNs69HwXoKkioXQeZaoNjFy8jcaZL
 ojljO4vOoGJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaL1JBwAKCRBD3pH5JJpx
 RR6xD/9TT24Y9oNt2pu+hN9rRlze4cUnM2NMlBk7deYVFe4QXhfG4gh9RSr29SG3BTqcGBlnrqv
 DGw8muOYDUv1+1/G7nlmub8pCGbA3VWvSK+R0tmiUkeh2qkvEFiugn1FiD6+gf3OxS3vVlC6eeT
 vv9zOmJOQxXFSeqncjp5ibQ1cQu2xddtRWk44T1N77amZmb13Xhp8NXzkVEMVQBJxBCNa4st1pE
 7nFSfdpHnQ6cG6r8B4qAH1PMfZkpT691dgQH3yEV48pA/zSGdteY9Rpl4W47HxLsxR+bL6uL65g
 XyFVJ5YVVU3xTNFpkS8rVV3phlqgy4iIVJDjM6AApr+BYDhaveQSgOcBRiwlnE+Lo9/ItmVszHc
 /BW2c9QW3Hz+g2Ser0cPzHgeL9dfu+hi5jACCzlkL0BHANaYjQmJ03Q0XNIbgZZuUDe4UOSbcgz
 QdXLOYPHEHhxezbqqT6lviioFiZZ6C2mkPBtgWtZsX33t6PlN820U3GBG24on90TlbRm2OD6jIt
 M8o+fVo8pkwZf5kH8ZVauCPgldu+pE/aItrkSr2ZSsZ6nnS92xJWWB5oRGTb65Bj5sefk0OsHhk
 /kGnX5GEOrRFykvX6+83hFx63MFgGAH2iNabf7TFGYr8lGS5y/lZ1BpRMd5z87Y7kDAKwRPlmYQ
 9LSRT2Puw9dxHqw==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

Raspberry Pi downstream drivers using VCHIQ have changed a lot since
kernel version 4.4 mentioned in the TODO, and are tangential to the
destaing process - so drop those items from the list.

Secondly, the code indentation for the vchiq interface driver is not so
bad anymore since Umang's series (linked below) got merged, so drop it
from the TODO.

Link: https://lore.kernel.org/all/20241013112128.397249-1-umang.jain@ideasonboard.com/
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/staging/vc04_services/interface/TODO | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/TODO b/drivers/staging/vc04_services/interface/TODO
index f6f24600aa86240fba77169f62f3e657e42727c3..2357dae413f102df49a233f7263ad0299bfe004a 100644
--- a/drivers/staging/vc04_services/interface/TODO
+++ b/drivers/staging/vc04_services/interface/TODO
@@ -1,28 +1,4 @@
-* Import drivers using VCHI.
-
-VCHI is just a tool to let drivers talk to the firmware.  Here are
-some of the ones we want:
-
-  - vc_mem (https://github.com/raspberrypi/linux/blob/rpi-4.4.y/drivers/char/broadcom/vc_mem.c)
-
-  This driver is what the vcdbg userspace program uses to set up its
-  requests to the firmware, which are transmitted across VCHIQ.  vcdbg
-  is really useful for debugging firmware interactions.
-
-  - VCSM (https://github.com/raspberrypi/linux/tree/rpi-4.4.y/drivers/char/broadcom/vc_sm)
-
-  This driver is used for talking about regions of VC memory across
-  firmware protocols including VCHI.  We'll want to extend this driver
-  to manage these buffers as dmabufs so that we can zero-copy import
-  camera images into vc4 for rendering/display.
-
 * Documentation
 
 A short top-down description of this driver's architecture (function of
 kthreads, userspace, limitations) could be very helpful for reviewers.
-
-* Reformat core code with more sane indentations
-
-The code follows the 80 characters limitation yet tends to go 3 or 4 levels of
-indentation deep making it very unpleasant to read. This is specially relevant
-in the character driver ioctl code and in the core thread functions.

-- 
2.50.1


