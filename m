Return-Path: <linux-kernel+bounces-874301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E39C8C15F93
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EB454F7D86
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C764834AB16;
	Tue, 28 Oct 2025 16:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SEFM0n+6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B75833DEE8;
	Tue, 28 Oct 2025 16:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670335; cv=none; b=QemkphH/vP37SAo7gcZPG+Avi2Eqxc7kzQuD+mWZIWY3D5Zdp7mJcYA2qYaS/kT+qByUZXcXaJHFOmwfPUEKy6mLwgqvi4Nwv123NL4EZ2Stg9F1xiFBtuWHhQ2wznX/hKJJCwF3vx7gg1Ezb5pGCnle/ER+BsQ9fxTOGIK0vbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670335; c=relaxed/simple;
	bh=SsI3vE4lFVvttLwlWp30jk+SCL5jWqCV/MCGalhV7Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MIQECnif1FMWUEfggf8nzCTY7y0UG4cxEiatfv0hUMlWNEukOjOK27SCmYAEcgDjQYel22vtFDbRx+Ohbrvbki+iuQxckQ/L1cdJwZomSjWQhYZQOV8VMitHVY9BlAbVPawd/0zMCDt4BFtWSW6OJgrf/MuvxKXXSSdAzshdQgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SEFM0n+6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761670333; x=1793206333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SsI3vE4lFVvttLwlWp30jk+SCL5jWqCV/MCGalhV7Ow=;
  b=SEFM0n+64Yu91SrzB0mG34z2b2N0GZQf52Q10DzfSw8W4DJehPzN0CPf
   X/U5i/PHJsms2ikN+wmY17fOrRDCRG7e5DzBI0HiIz2vjHFkJUs8z411c
   x2R/5B6/0jfe3bYJhjMcEu7bEb2ChasxImoU0f6ezExlmUST7rVLzh9Cd
   FQbYEj6mOaXv7ehp9Metzb79IFUsZ0jzrcH7TYKqtcv6YSPaI4rESG6/p
   myAeurA2LNVazo6MWmW9dwi0OkvoGXUAQJYq03Iq4V5pIvU8aNrAX1crv
   6Z9+f5BEsB3xmSUPNrmoejfaVGCumkcon9MiKIvi8UM1DwBWNM+tEG5ke
   A==;
X-CSE-ConnectionGUID: hcMkMvdiQ8Cn2LDzh1/RZg==
X-CSE-MsgGUID: csdDkFInQSCGUoX7Ih9Apg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63685309"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="63685309"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 09:52:12 -0700
X-CSE-ConnectionGUID: m/ZpeFbbR0+rEI1wX/pvLw==
X-CSE-MsgGUID: 2zeChfU2T7mKf8eWGNiqhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="189454888"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mnyman-desk.intel.com) ([10.245.244.148])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 09:52:10 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: uttkarsh.aggarwal@oss.qualcomm.com
Cc: mathias.nyman@linux.intel.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mathias.nyman@intel.com,
	wesley.cheng@oss.qualcomm.com
Subject: [RFT PATCH v2] xhci: sideband: Fix race condition in sideband unregister
Date: Tue, 28 Oct 2025 18:51:53 +0200
Message-ID: <20251028165153.283980-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <db07f48d-27cf-4681-b10e-38d252e24512@linux.intel.com>
References: <db07f48d-27cf-4681-b10e-38d252e24512@linux.intel.com>
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
Reorganize code so that mutex is only taken and released once in
xhci_sideband_unregister(), and clear sb->vdev while mutex is taken.

Use mutex guards to reduce human unlock errors in code

Refuse to add endpoints or interrupter if sb->vdev is not set.
sb->vdev is set when sideband is created and registered.

Reported-by: Uttkarsh Aggarwal <uttkarsh.aggarwal@oss.qualcomm.com>
Closes: https://lore.kernel.org/linux-usb/20251028080043.27760-1-uttkarsh.aggarwal@oss.qualcomm.com
Fixes: de66754e9f80 ("xhci: sideband: add initial api to register a secondary interrupter entity")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---

v2:
  use guard() and fix missing mutex_unlock as recommended by greg k-h 

---
 drivers/usb/host/xhci-sideband.c | 97 +++++++++++++++++---------------
 1 file changed, 53 insertions(+), 44 deletions(-)

diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index e771a476fef2..2daa0ba7ad9a 100644
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
@@ -131,14 +147,17 @@ xhci_sideband_add_endpoint(struct xhci_sideband *sb,
 	struct xhci_virt_ep *ep;
 	unsigned int ep_index;
 
-	mutex_lock(&sb->mutex);
+	guard(mutex)(&sb->mutex);
+
+	if (!sb->vdev)
+		return -ENODEV;
+
 	ep_index = xhci_get_endpoint_index(&host_ep->desc);
 	ep = &sb->vdev->eps[ep_index];
 
-	if (ep->ep_state & EP_HAS_STREAMS) {
-		mutex_unlock(&sb->mutex);
+	if (ep->ep_state & EP_HAS_STREAMS)
 		return -EINVAL;
-	}
+
 
 	/*
 	 * Note, we don't know the DMA mask of the audio DSP device, if its
@@ -148,14 +167,11 @@ xhci_sideband_add_endpoint(struct xhci_sideband *sb,
 	 * and let this function add the endpoint and allocate the ring buffer
 	 * with the smallest common DMA mask
 	 */
-	if (sb->eps[ep_index] || ep->sideband) {
-		mutex_unlock(&sb->mutex);
+	if (sb->eps[ep_index] || ep->sideband)
 		return -EBUSY;
-	}
 
 	ep->sideband = sb;
 	sb->eps[ep_index] = ep;
-	mutex_unlock(&sb->mutex);
 
 	return 0;
 }
@@ -180,18 +196,16 @@ xhci_sideband_remove_endpoint(struct xhci_sideband *sb,
 	struct xhci_virt_ep *ep;
 	unsigned int ep_index;
 
-	mutex_lock(&sb->mutex);
+	guard(mutex)(&sb->mutex);
+
 	ep_index = xhci_get_endpoint_index(&host_ep->desc);
 	ep = sb->eps[ep_index];
 
-	if (!ep || !ep->sideband || ep->sideband != sb) {
-		mutex_unlock(&sb->mutex);
+	if (!ep || !ep->sideband || ep->sideband != sb)
 		return -ENODEV;
-	}
 
 	__xhci_sideband_remove_endpoint(sb, ep);
 	xhci_initialize_ring_info(ep->ring);
-	mutex_unlock(&sb->mutex);
 
 	return 0;
 }
@@ -316,28 +330,25 @@ xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
 	if (!sb || !sb->xhci)
 		return -ENODEV;
 
-	mutex_lock(&sb->mutex);
-	if (sb->ir) {
-		ret = -EBUSY;
-		goto out;
-	}
+	guard(mutex)(&sb->mutex);
+
+	if (!sb->vdev)
+		return -ENODEV;
+
+	if (sb->ir)
+		return -EBUSY;
 
 	sb->ir = xhci_create_secondary_interrupter(xhci_to_hcd(sb->xhci),
 						   num_seg, imod_interval,
 						   intr_num);
-	if (!sb->ir) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!sb->ir)
+		return -ENOMEM;
 
 	udev = sb->vdev->udev;
 	ret = usb_offload_get(udev);
 
 	sb->ir->ip_autoclear = ip_autoclear;
 
-out:
-	mutex_unlock(&sb->mutex);
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_create_interrupter);
@@ -352,21 +363,12 @@ EXPORT_SYMBOL_GPL(xhci_sideband_create_interrupter);
 void
 xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
 {
-	struct usb_device *udev;
-
-	if (!sb || !sb->ir)
+	if (!sb)
 		return;
 
-	mutex_lock(&sb->mutex);
-	xhci_remove_secondary_interrupter(xhci_to_hcd(sb->xhci), sb->ir);
-
-	sb->ir = NULL;
-	udev = sb->vdev->udev;
+	guard(mutex)(&sb->mutex);
 
-	if (udev->state != USB_STATE_NOTATTACHED)
-		usb_offload_put(udev);
-
-	mutex_unlock(&sb->mutex);
+	__xhci_sideband_remove_interrupter(sb);
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_remove_interrupter);
 
@@ -465,6 +467,7 @@ EXPORT_SYMBOL_GPL(xhci_sideband_register);
 void
 xhci_sideband_unregister(struct xhci_sideband *sb)
 {
+	struct xhci_virt_device *vdev;
 	struct xhci_hcd *xhci;
 	int i;
 
@@ -473,17 +476,23 @@ xhci_sideband_unregister(struct xhci_sideband *sb)
 
 	xhci = sb->xhci;
 
-	mutex_lock(&sb->mutex);
-	for (i = 0; i < EP_CTX_PER_DEV; i++)
-		if (sb->eps[i])
-			__xhci_sideband_remove_endpoint(sb, sb->eps[i]);
-	mutex_unlock(&sb->mutex);
+	scoped_guard(mutex, &sb->mutex) {
+		vdev = sb->vdev;
+		if (!vdev)
+			return;
+
+		for (i = 0; i < EP_CTX_PER_DEV; i++)
+			if (sb->eps[i])
+				__xhci_sideband_remove_endpoint(sb, sb->eps[i]);
 
-	xhci_sideband_remove_interrupter(sb);
+		__xhci_sideband_remove_interrupter(sb);
+
+		sb->vdev = NULL;
+	}
 
 	spin_lock_irq(&xhci->lock);
 	sb->xhci = NULL;
-	sb->vdev->sideband = NULL;
+	vdev->sideband = NULL;
 	spin_unlock_irq(&xhci->lock);
 
 	kfree(sb);
-- 
2.43.0


