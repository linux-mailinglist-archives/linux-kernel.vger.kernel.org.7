Return-Path: <linux-kernel+bounces-812257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11085B5351F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159DE1CC0257
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D8D33CE9F;
	Thu, 11 Sep 2025 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXW0HILV"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFBC33A02E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600479; cv=none; b=DWGVGCbOLw86Giaiapkhj8nj+spaJ02dy9GJ5KbWmgKigxTm1ke8y7tMcfi1yvBIJipKDOEbnsRLtSAQozZvJFDJ2GLJQEh2mJHBdCPGmIjFaGcuRjj0+7EdQ8cCrnwOWw5ATJBpNRntZoHsU9Ox9Wgtdvm0p6NF6WbpLBqlIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600479; c=relaxed/simple;
	bh=mdx6eG+7ml4VsoMCqwGhoY4J8bC5AkD5+1l0FkjARuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gcYCJAGp/I+kMAvfffSkHSWrWFiKXHDVSHzC55A3I3zlGACTI+hzQgrDl1eaHk2US4/8aQVo+76uPB4jj5yoPw+LiafejAGQH/n4kC03vLiw+YS03g7d7e49hJ9trJlOA4F6cZwYhZnBk/0NDU2Nx569Ssy33EaxUncI1/H9mRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bXW0HILV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--guanyulin.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471757d82fso609919a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757600478; x=1758205278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=48S/R06M0Dnc7mgADD0bZrS065nRJq6arY7ofHgCeqs=;
        b=bXW0HILVHCh8mVtd+Ic48nf4MCrBpGKAK1YmmQojYzeOi22SA23YxlvtfD/iG8afuU
         R8otcqrNiPtncbuvDVX1r9nDD5dTbmNPixiNwyrA4GFfh3PyWUE1p9LRoV6FdjJqbQjQ
         cHvcpidtWDoJYrLJMIyMSyx44mzhg6XHHiAEtYc+ofpdPAhg94T6qJV13VjXatj6CABC
         TsTpwXdqxCcrsz2a9QaRCcWr0z9rL6PPPrbrrElanhodQj+N96pSALhx3cz+EOtit9Hu
         mSZ5M0anre9jvbHPrRP3ktp7W8ccdW1OFIGgxJP9J1SMC0Wlncj90Jd2BTCDIDbESw3v
         vQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757600478; x=1758205278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48S/R06M0Dnc7mgADD0bZrS065nRJq6arY7ofHgCeqs=;
        b=N6MppyocLXoeRqiJ7gIxz61WmRYxfcF/sfSuyuTmQbp58pKOYi4tW5fN7C4NP33wMC
         9eG83Fhz9mIwnlRkooX1G/ckYTGPpZYrqTLvF8aQo+oZ4gqk34nXKpQiDJcu4wIvuMja
         H3OoX2eLvMk6PT4p67AVdiBcLWzJTVykMQUPCiNkObjvtT2LKIP2KiVWXNVUkMPOH1iY
         rGQ5vR1/vE0Wg1CmKgv1/UNS3E1q+KfhkifFnSzDq8gq2/mNmOzhSG3KW1RZRwhmgSsn
         AtcvVzPzqzsfahnNutt3NXpt/zsCjYV4J731DXX8zOtlVl07J4L8Y94IW1K/EL3T8wV9
         y7jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgjxAUSj9L1X4liqpyyfYM9Sp037riQmuWDzi+h9lEh/nro7sz4m5aAcyuJurIhnEK2feSOjpww69iSDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCqYP5hTegAHN5XQ+ezUqAa+QD95qeGRVSZb4HYPllAJqr+UcY
	fN2mLWUNGYfJxVlEqVXQj5Ss3huHRNVumdYnyNxs5attTAa+nY/O9YFRN1WnJM+yVP9JlyDC4Z9
	hXZtvIuAD2zQI/OPX8Q==
X-Google-Smtp-Source: AGHT+IFsG3zbN/kmvbNOuQouQ0ic1WH0IKXhyBribfWc70ashGg7Mq/eeT221uhkPlACgdQUrm0qBYb84SF5DWA=
X-Received: from pfbdo14.prod.google.com ([2002:a05:6a00:4a0e:b0:775:f9fa:fb14])
 (user=guanyulin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:918a:b0:249:467e:ba4c with SMTP id adf61e73a8af0-25344dc4b17mr26377631637.42.1757600477715;
 Thu, 11 Sep 2025 07:21:17 -0700 (PDT)
Date: Thu, 11 Sep 2025 14:20:15 +0000
In-Reply-To: <20250911142051.90822-1-guanyulin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250911142051.90822-1-guanyulin@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250911142051.90822-4-guanyulin@google.com>
Subject: [PATCH v16 3/4] xhci: sideband: add api to trace sideband usage
From: Guan-Yu Lin <guanyulin@google.com>
To: gregkh@linuxfoundation.org, mathias.nyman@intel.com, hannelotta@gmail.com, 
	zijun.hu@oss.qualcomm.com, xu.yang_2@nxp.com, stern@rowland.harvard.edu, 
	andriy.shevchenko@linux.intel.com, amardeep.rai@intel.com, 
	dominique.martinet@atmark-techno.com, quic_wcheng@quicinc.com, 
	sakari.ailus@linux.intel.com, dh10.jung@samsung.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guan-Yu Lin <guanyulin@google.com>
Content-Type: text/plain; charset="UTF-8"

The existing sideband driver only registers sidebands without tracking
their active usage. To address this, sideband will now record its active
usage when it creates/removes interrupters. In addition, a new api is
introduced to provide a means for other dirvers to fetch sideband
activity information on a USB host controller.

Signed-off-by: Guan-Yu Lin <guanyulin@google.com>
---
 drivers/usb/host/xhci-sideband.c  | 36 +++++++++++++++++++++++++++++++
 include/linux/usb/xhci-sideband.h |  9 ++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/usb/host/xhci-sideband.c b/drivers/usb/host/xhci-sideband.c
index d49f9886dd84..e771a476fef2 100644
--- a/drivers/usb/host/xhci-sideband.c
+++ b/drivers/usb/host/xhci-sideband.c
@@ -266,6 +266,31 @@ xhci_sideband_get_event_buffer(struct xhci_sideband *sb)
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_get_event_buffer);
 
+/**
+ * xhci_sideband_check - check the existence of active sidebands
+ * @hcd: the host controller driver associated with the target host controller
+ *
+ * Allow other drivers, such as usb controller driver, to check if there are
+ * any sideband activity on the host controller. This information could be used
+ * for power management or other forms of resource management. The caller should
+ * ensure downstream usb devices are all either suspended or marked as
+ * "offload_at_suspend" to ensure the correctness of the return value.
+ *
+ * Returns true on any active sideband existence, false otherwise.
+ */
+bool xhci_sideband_check(struct usb_hcd *hcd)
+{
+	struct usb_device *udev = hcd->self.root_hub;
+	bool active;
+
+	usb_lock_device(udev);
+	active = usb_offload_check(udev);
+	usb_unlock_device(udev);
+
+	return active;
+}
+EXPORT_SYMBOL_GPL(xhci_sideband_check);
+
 /**
  * xhci_sideband_create_interrupter - creates a new interrupter for this sideband
  * @sb: sideband instance for this usb device
@@ -286,6 +311,7 @@ xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
 				 bool ip_autoclear, u32 imod_interval, int intr_num)
 {
 	int ret = 0;
+	struct usb_device *udev;
 
 	if (!sb || !sb->xhci)
 		return -ENODEV;
@@ -304,6 +330,9 @@ xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
 		goto out;
 	}
 
+	udev = sb->vdev->udev;
+	ret = usb_offload_get(udev);
+
 	sb->ir->ip_autoclear = ip_autoclear;
 
 out:
@@ -323,6 +352,8 @@ EXPORT_SYMBOL_GPL(xhci_sideband_create_interrupter);
 void
 xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
 {
+	struct usb_device *udev;
+
 	if (!sb || !sb->ir)
 		return;
 
@@ -330,6 +361,11 @@ xhci_sideband_remove_interrupter(struct xhci_sideband *sb)
 	xhci_remove_secondary_interrupter(xhci_to_hcd(sb->xhci), sb->ir);
 
 	sb->ir = NULL;
+	udev = sb->vdev->udev;
+
+	if (udev->state != USB_STATE_NOTATTACHED)
+		usb_offload_put(udev);
+
 	mutex_unlock(&sb->mutex);
 }
 EXPORT_SYMBOL_GPL(xhci_sideband_remove_interrupter);
diff --git a/include/linux/usb/xhci-sideband.h b/include/linux/usb/xhci-sideband.h
index 45288c392f6e..005257085dcb 100644
--- a/include/linux/usb/xhci-sideband.h
+++ b/include/linux/usb/xhci-sideband.h
@@ -11,6 +11,7 @@
 
 #include <linux/scatterlist.h>
 #include <linux/usb.h>
+#include <linux/usb/hcd.h>
 
 #define	EP_CTX_PER_DEV		31	/* FIXME defined twice, from xhci.h */
 
@@ -83,6 +84,14 @@ xhci_sideband_get_endpoint_buffer(struct xhci_sideband *sb,
 				  struct usb_host_endpoint *host_ep);
 struct sg_table *
 xhci_sideband_get_event_buffer(struct xhci_sideband *sb);
+
+#if IS_ENABLED(CONFIG_USB_XHCI_SIDEBAND)
+bool xhci_sideband_check(struct usb_hcd *hcd);
+#else
+static inline bool xhci_sideband_check(struct usb_hcd *hcd)
+{ return false; }
+#endif /* IS_ENABLED(CONFIG_USB_XHCI_SIDEBAND) */
+
 int
 xhci_sideband_create_interrupter(struct xhci_sideband *sb, int num_seg,
 				 bool ip_autoclear, u32 imod_interval, int intr_num);
-- 
2.51.0.384.g4c02a37b29-goog


