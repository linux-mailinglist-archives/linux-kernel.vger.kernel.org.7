Return-Path: <linux-kernel+bounces-875792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B87C19D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E16EA565085
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB70218ACC;
	Wed, 29 Oct 2025 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="T0QfsYMF"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9993376AA
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733893; cv=none; b=p68w+pl1cYXzswFLcl0nzh+R5TDxaA6jj+PO9mWo4wCaHvcUdxrYrdTWCKJk0NRu1tAvUvjEpm9RRQzhwweFbg9BX1tZW8efGq3EpmSLdkhZuty9N2XHgh7VSSpwaVZxFtLj2eejDgiB70VfHWaaF+oMsei0BeT8gNN9EWA+RxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733893; c=relaxed/simple;
	bh=wPwLQXSELR0ixBqTwTTJFnBDsK4IZ1P3IckTUrJ9amY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HavMbBiDx1qjHfXfG5u9xyw29OTMGJt+ew6AxU1njH+ZTkukdhACWe3k8w9V4zx4xjSpx59DAoRYm+of+8UYSk1907qQU8idofC1TipYFvrQy7WUxy16R/xHtYWr/B14Cblb8fAWaZxYeUgq/BwbAGXgrqyHBzlynsLAOsSvwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=T0QfsYMF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9557311DD;
	Wed, 29 Oct 2025 11:29:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761733780;
	bh=wPwLQXSELR0ixBqTwTTJFnBDsK4IZ1P3IckTUrJ9amY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T0QfsYMFrTEo0tcF0OduiTysUSlCbLTfZTSutctxMaCul6A2p936Abix4HmTjd82D
	 kEZ0WGzkT0WGriYtZagpgK62VVb16uOWuQiWonX/4bOyqSOHa9b2rvGU/9P3SgUz0+
	 eHN/z/IgFkNdBl1H9uH8RboLtC4IQEREZdSIoznU=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Wed, 29 Oct 2025 16:00:09 +0530
Subject: [PATCH v3 5/7] staging: vc04_services: Cleanup VCHIQ TODO entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-vchiq-destage-v3-5-da8d6c83c2c5@ideasonboard.com>
References: <20251029-vchiq-destage-v3-0-da8d6c83c2c5@ideasonboard.com>
In-Reply-To: <20251029-vchiq-destage-v3-0-da8d6c83c2c5@ideasonboard.com>
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
 Jai Luthra <jai.luthra@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=wPwLQXSELR0ixBqTwTTJFnBDsK4IZ1P3IckTUrJ9amY=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpAezdMJ1O8pQVmB5jUByA2R6K4BKl54dgbBTjl
 x8IGOtViQ2JAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQHs3QAKCRBD3pH5JJpx
 Rbj/D/9vlEDbMgomGvt5ehFPRPdChwLo+N59QY+S38u/sGKWHaWBI59dYVQK84U8uRHCNSwtk97
 BRHe+1Kgfrk5YGJCvno+KCG16D8jtuRwltG+ESy4ycAPh2W7snrNNr2AVAyJJdyR7XbdSUHKNbI
 4ptZ7EvlWZpg0rTiGUs4W+ZUIl0nCVYNgnFYsc9x7YCln1L4mZ4mr4fWq7Oz5MYotP62+bzww34
 6qTxUAYUye91glfFzbApgjWv1g1y0sd5iublxRR6+HK4tSPnRaYxXLWva5nFxRT86sTTgpjTRc1
 LLKkV9vCSRRYI0TJ/HbBqvk24eRvhymFN2n8kNywTr/Xdtrl8ptw0ye6ICk4ZiswPEqfetAVwLi
 +kIpZNe08KMuFTVjjCx67x08nJ3TX4F7l9Kw92V395QbNYjdURb6TouhcaBkqBXR/5t7WNQXxGG
 h0CYfh1PfhUramxNJ0KYqlCOOuq2yeOjmFicPIk/pOjdbRE4fW3izI95h483ByMMsDrDWvdaIIz
 BGkAl1ZGjuhAJF0yemOlql9d/xTxuxA2evPhX1crWzPCc9ooDoEgb2O3Ww1c1rYjirbbKhBkixS
 P++G56puqqABeGXqnv61nC2vO48REz5v6pCl1p8Nr7/8Epb9Mv7pjQeQgDep4v5+EfzKtksbb8h
 6AayKjOcr+OZdIw==
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
2.51.0


