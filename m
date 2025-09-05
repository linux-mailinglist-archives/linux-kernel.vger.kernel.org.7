Return-Path: <linux-kernel+bounces-803279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FEBB45CED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9FB5A6ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FF5242D95;
	Fri,  5 Sep 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ba3h1ekH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460B302179
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087122; cv=none; b=p+ckBwm/ogTWjYW1iEWPAM+OQKG6w7nioK2FT/7b1gUVLXOnC6mH8x5ILMhVkf2g4RxD+k3PWB6qIg7LMFvwI8Bd9/8ZI95UjHAJVJrLYc0j+ZZnHYbz0lDOeybOUPQuKNl04z8NV43epXTvEivCSHokJ/7ctTBJSgxHQrWQtzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087122; c=relaxed/simple;
	bh=vgk1lqclsOlLszFoOqnW3JFUcsS7Usoj1a9piG+7EIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=br86D++XuQp8HUlMEfMXwHOZy6dxT+a5kiKD0THh9U9lmf+6jcllUnAgw+KDqUqjwJxldeUpii9AXqcQzKpDzLoyDkmFg8wIhrjEaNwDSpaEsAyzzrUFNkQmMhf7CaYp4VC4sG/Ob3M5y+2Ron5QFA1MMbGdNoQ53l6LDJaiF8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ba3h1ekH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757087120; x=1788623120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vgk1lqclsOlLszFoOqnW3JFUcsS7Usoj1a9piG+7EIQ=;
  b=ba3h1ekHb+HmJcdpqNNdRS5dHiEDLfE4SrFyff+z6sIy0EPD75COj3jA
   mj2yFbjZnACCyyzJ+jBGJ242trSX/LMidnsgztW4ATIbFS4NhnKXm0z7N
   KnNr7GvHUPLc4a6QbrdXcEPl+tdbe1uw2TP+2aUc48A+quOPhufxeY3ND
   r7uSOdXq3K0rLJ14XNQR91nwakEAfaiMDUYQgZGWSzkvf8N+yFlM/VX18
   GBnZEh7I1sPr+wGU28amdU7YTmnzARVrsGorGZl2R8gP55frnxtN70zrJ
   BgolqewGQ7Z/KRSnSqrH6ioXua/8RzExIFc6d1SS4xgG1lRy9l2ZEeAIk
   g==;
X-CSE-ConnectionGUID: IFHIv3sCRAq0sL7QAIXr8Q==
X-CSE-MsgGUID: aSL77rkTQB2l/ZtwOhxIjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70144627"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="70144627"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 08:45:20 -0700
X-CSE-ConnectionGUID: odg4evxLQj6xyoAPm5P5wA==
X-CSE-MsgGUID: cEmgysSeTEGVR9bETP0cGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="172071715"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 08:45:17 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	alexander.usyskin@intel.com,
	gregkh@linuxfoundation.org,
	daniele.ceraolospurio@intel.com,
	mika.westerberg@linux.intel.com,
	lucas.demarchi@intel.com,
	karthik.poosa@intel.com
Subject: [PATCH v9 1/9] mei: bus: add mei_cldev_mtu interface
Date: Fri,  5 Sep 2025 21:19:45 +0530
Message-Id: <20250905154953.3974335-2-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905154953.3974335-1-badal.nilawar@intel.com>
References: <20250905154953.3974335-1-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

Add a new helper function that allows MEI client drivers
to query the maximum transmission unit (MTU) for a connected
MEI client.

This is useful for clients that need to transmit large payloads,
such as firmware blobs, allowing them to determine the maximum
message size that can be safely sent before starting transmission and
size of the buffer to allocate when receiving data.

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/misc/mei/bus.c     | 13 +++++++++++++
 include/linux/mei_cl_bus.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 5cc3ad07d5be..09aae8f9d225 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -614,6 +614,19 @@ u8 mei_cldev_ver(const struct mei_cl_device *cldev)
 }
 EXPORT_SYMBOL_GPL(mei_cldev_ver);
 
+/**
+ * mei_cldev_mtu - max message that client can send and receive
+ *
+ * @cldev: mei client device
+ *
+ * Return: mtu or 0 if client is not connected
+ */
+size_t mei_cldev_mtu(const struct mei_cl_device *cldev)
+{
+	return mei_cl_mtu(cldev->cl);
+}
+EXPORT_SYMBOL_GPL(mei_cldev_mtu);
+
 /**
  * mei_cldev_enabled - check whether the device is enabled
  *
diff --git a/include/linux/mei_cl_bus.h b/include/linux/mei_cl_bus.h
index 725fd7727422..a82755e1fc40 100644
--- a/include/linux/mei_cl_bus.h
+++ b/include/linux/mei_cl_bus.h
@@ -113,6 +113,7 @@ int mei_cldev_register_notif_cb(struct mei_cl_device *cldev,
 				mei_cldev_cb_t notif_cb);
 
 u8 mei_cldev_ver(const struct mei_cl_device *cldev);
+size_t mei_cldev_mtu(const struct mei_cl_device *cldev);
 
 void *mei_cldev_get_drvdata(const struct mei_cl_device *cldev);
 void mei_cldev_set_drvdata(struct mei_cl_device *cldev, void *data);
-- 
2.34.1


