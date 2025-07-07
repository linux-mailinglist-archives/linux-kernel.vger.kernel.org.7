Return-Path: <linux-kernel+bounces-720419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7232BAFBB81
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A64C423B83
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E42C266B6B;
	Mon,  7 Jul 2025 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYobiy45"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C6D26560A
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915300; cv=none; b=qGokossZnbzTqZhRExmwniIuxOTvgwJO6salee447AnAAZvmnNSgWg0VqBMrUrGEL509CIh/37nVeg4kkwNLLEpMMhuGcWqqGdp28/0Ucut0EfTbFEFtVUGscp2h2eg4RLSba/poqONqM4zw1y/Oztym21vL2PQWKnv+5ubmNhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915300; c=relaxed/simple;
	bh=u16CpbdUihPkyI+FiM2IX3TbeuU1zDLWDn5AwsQR/6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3C3tSE3CyQY6rPZ4jDy3QnKbY50DMEq5c22toVQY0jUzJ6QPzgmOC9ZLQE9tpZDcRuD+mvPh9ItoCSj6lILZHap31mjkTN5Ajc5puREirikgLf3rgzy+Zd5O3MPKyUNanHaaROHv+ILpXf0oRpLbzab07HAT29OT2cvQMmRIpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYobiy45; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751915299; x=1783451299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u16CpbdUihPkyI+FiM2IX3TbeuU1zDLWDn5AwsQR/6k=;
  b=IYobiy45fRSqhi9cRon4AVraUejDRtSqANUnE/BgGtar0c1a+zXUHqPd
   eHiaWT9dJyXLqu37QTnYQRZzh1LlOqEVMjE9b8QNqnnoEZFLjUgVda9OA
   A3eVYn3CCC6iL0VDozjKjM8ZX+52oOmslauGAOGS5dRtm5LhD5GpO2hXT
   I0lsO1EpmEYoCwElTuxIo/p0VHG4LSrHYAlRX3rtDoQN13QkOIDFgU52z
   gzVBG1NTSUDS/Kv0TFx8NuwRm3gWR/J20fBq+drNq2YYUUJpZQq5Zaj8c
   Ez48x297cjsuUJxsV3c6E1cwCDeiehsQWKHgGkzGwmi3QrOeO8avBaE/F
   A==;
X-CSE-ConnectionGUID: tkN7zu4iTxCQqf9dMk3PUw==
X-CSE-MsgGUID: ThD7dRwoQZqT+04sYosJAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57945662"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="57945662"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:08:19 -0700
X-CSE-ConnectionGUID: P5kTkzMqTCmC47UyZXoknQ==
X-CSE-MsgGUID: KxMsyIbqQqS2ZpS0a7nZSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="154707419"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:08:16 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	alexander.usyskin@intel.com,
	gregkh@linuxfoundation.org,
	daniele.ceraolospurio@intel.com
Subject: [PATCH v7 1/9] mei: bus: add mei_cldev_mtu interface
Date: Tue,  8 Jul 2025 00:42:29 +0530
Message-Id: <20250707191237.1782824-2-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707191237.1782824-1-badal.nilawar@intel.com>
References: <20250707191237.1782824-1-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

Allow to bus client to obtain client mtu.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
---
 drivers/misc/mei/bus.c     | 13 +++++++++++++
 include/linux/mei_cl_bus.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 67176caf5416..f860b1b6eda0 100644
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


