Return-Path: <linux-kernel+bounces-873867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16614C14F2D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3977C189AF4F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4834F334C3A;
	Tue, 28 Oct 2025 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NpHopJG2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44100335094;
	Tue, 28 Oct 2025 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659114; cv=none; b=cQs5Brw5FAKcte8sP70cQ1jRHXNKJjMQ6W7NXAGRewAnT+d+hRFKchuwWUQ2vj78dAalEIwyisuQl0JM+PdK2skC3xGLMusWObCsjQVXfoZXXxvd62w+EpAQty0xQQ6q3j5wcrRd1tKiXicfNBcVF+ft8mL5bX6kqN1wHrsIrf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659114; c=relaxed/simple;
	bh=uQhSAlEHEPiPgASelFdHu++LY6iEZ6HEiRIEWHa7QT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtZhek73NzZ9owcK7B1fsGzYSn/fqMxlCJAE89KpzHDPLbeTDPqnEFDEJwXmENTsC0LFn1A25CD4W3ullU8z0Twz5u8o8xljoAkIUx1O9rxLWZSxpoNoNAAkVEMGw6XyXyu7Lb1TNPid/iclPbkaGGzHPH0V8Oq6McKXNphcd7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NpHopJG2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761659112; x=1793195112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uQhSAlEHEPiPgASelFdHu++LY6iEZ6HEiRIEWHa7QT4=;
  b=NpHopJG2uoFtqnDJWvDcb5k2td/m5hlFv0VxPckdz/pVAEijsSwH17vD
   HYq4eJ6JJnK4zDvqkj7Dl1aHOIkwTwYiH9OZCRBbiBBRbOawwQBTlb9qV
   gr+d2aVL1MYYHflgdDxwnfaXYmIqPi5szQdCuqhBySnnm50rMp31pte1/
   X75BoX+ydfYOYyq9viN/PKuvQe1exhgalhGnH8aorX7avm9CLcP1ZXbWr
   ++0H6coUTqszSk4BuRKj//afrbVbDeCBrkyFUITOb70YFOdIoEfPgPiYQ
   S4oSoG5tNR/N0/LnaOcgVBZrT7LndyXfuGo8G3RzOPsAC7Aq3IeHAEEjs
   w==;
X-CSE-ConnectionGUID: zZ8h3UEgRvmQBGZKvwO9Dg==
X-CSE-MsgGUID: mzQXdYChTdi6WxhrzE7IZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="51331899"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="51331899"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 06:45:12 -0700
X-CSE-ConnectionGUID: 76nnSBjuSTWUBXSnc3REyA==
X-CSE-MsgGUID: OYJqKwtZQ8CpB1luTm97tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184977725"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.244.148])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 06:45:09 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: uttkarsh.aggarwal@oss.qualcomm.com
Cc: mathias.nyman@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mathias.nyman@intel.com,
	wesley.cheng@oss.qualcomm.com
Subject: [RFT PATCH] xhci: sideband: Fix race condition in sideband unregister
Date: Tue, 28 Oct 2025 15:44:51 +0200
Message-ID: <20251028134452.244096-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <51ca2248-5699-4c6d-b037-a57c90ed44ac@linux.intel.com>
References: <51ca2248-5699-4c6d-b037-a57c90ed44ac@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uttkarsh Aggarwal observed a kernel panic during sideband un-register
and found it was caused by a race condition between sideband unregister,
and creating sideband interrupters.
The issue occurrs when thread T1 runs uaudio_disconnect() and released
sb->xhci via sideband_unregister, while thread T2 simultaneously accessed
the now-NULL sb->xhci in xhci_sideband_create_interrupter() resulting in
a crash.

Ensure new endpoints or interrupter can't be added to a sidenband after
xhci_sideband_unregister() cleared the existing ones, and unlocked the
sideband mutex.
Reorganise code so that mutex is only taken and released once in
xhci_sideband_unregister(), and clear sb->vdev while mutex is taken.

Refuse to add endpoints or interrupter if sb->vdev is not set.
sb->vdev is set when sideband is created and registered.

Reported-by: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
Closes: https://lore.kernel.org/linux-usb/20251028080043.27760-1-uttkarsh.aggarwal@oss.qualcomm.com
Fixes: de66754e9f80 ("xhci: sideband: add initial api to register a secondary interrupter entity")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-sideband.c | 55 ++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index e771a476fef2..c308be9a8e9f 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -86,6 +86,22 @@ __xhci_sideband_remove_endpoint(struct xhci_sideband *sb, struct xhci_virt_ep *e
 	sb->eps[ep->ep_index] = NULL;
 }
 
+static void
+__xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
+{
+	struct usb_device *udev;
+
+	if (!sb->ir)
+		return;
+
+	xhci_remove_secondary_interrupter(xhci_to_hcd(sb->xhci), sb->ir);
+	sb->ir = NULL;
+	udev = sb->vdev->udev;
+
+	if (udev->state != USB_STATE_NOTATTACHED)
+		usb_offload_put(udev);
+}
+
 /* sideband api functions */
 
 /**
@@ -132,6 +148,12 @@ xhci_sideband_add_endpoint(struct xhci_sideband *sb,
 	unsigned int ep_index;
 
 	mutex_lock(&sb->mutex);
+
+	if (!sb->vdev) {
+		mutex_unlock(&sb->mutex);
+		return -ENODEV;
+	}
+
 	ep_index = xhci_get_endpoint_index(&host_ep->desc);
 	ep = &sb->vdev->eps[ep_index];
 
@@ -317,6 +339,12 @@ xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
 		return -ENODEV;
 
 	mutex_lock(&sb->mutex);
+
+	if (!sb->vdev) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	if (sb->ir) {
 		ret = -EBUSY;
 		goto out;
@@ -352,20 +380,11 @@ EXPORT_SYMBOL_GPL(xhci_sideband_create_interrupter);
 void
 xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
 {
-	struct usb_device *udev;
-
-	if (!sb || !sb->ir)
+	if (!sb)
 		return;
 
 	mutex_lock(&sb->mutex);
-	xhci_remove_secondary_interrupter(xhci_to_hcd(sb->xhci), sb->ir);
-
-	sb->ir = NULL;
-	udev = sb->vdev->udev;
-
-	if (udev->state != USB_STATE_NOTATTACHED)
-		usb_offload_put(udev);
-
+	__xhci_sideband_remove_interrupter(sb);
 	mutex_unlock(&sb->mutex);
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_remove_interrupter);
@@ -465,6 +484,7 @@ EXPORT_SYMBOL_GPL(xhci_sideband_register);
 void
 xhci_sideband_unregister(struct xhci_sideband *sb)
 {
+	struct xhci_virt_device *vdev;
 	struct xhci_hcd *xhci;
 	int i;
 
@@ -474,16 +494,23 @@ xhci_sideband_unregister(struct xhci_sideband *sb)
 	xhci = sb->xhci;
 
 	mutex_lock(&sb->mutex);
+
+	vdev = sb->vdev;
+	if (!vdev)
+		return;
+
 	for (i = 0; i < EP_CTX_PER_DEV; i++)
 		if (sb->eps[i])
 			__xhci_sideband_remove_endpoint(sb, sb->eps[i]);
-	mutex_unlock(&sb->mutex);
 
-	xhci_sideband_remove_interrupter(sb);
+	__xhci_sideband_remove_interrupter(sb);
+
+	sb->vdev = NULL;
+	mutex_unlock(&sb->mutex);
 
 	spin_lock_irq(&xhci->lock);
 	sb->xhci = NULL;
-	sb->vdev->sideband = NULL;
+	vdev->sideband = NULL;
 	spin_unlock_irq(&xhci->lock);
 
 	kfree(sb);
-- 
2.43.0


