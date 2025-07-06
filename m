Return-Path: <linux-kernel+bounces-716047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3426DAF8148
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 21:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2D73B78DD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 19:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B7B2F5474;
	Thu,  3 Jul 2025 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S999c0lc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A742E2F3628
	for <linux-kernel@vger.kernel.org>; Thu,  3 Jul 2025 19:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751570809; cv=none; b=pFbtwoAzVP6mmfZgIKmp/vVXFm8MIiTzH07rcztkXpSlon3ECrD7JxTZzSqJHOScmVaUrIQYUE5G9mA9d+yGW2SmID++bt+2DJxAgNeGZT7qBrmbnFEIDRErQ5BkEUe0yThWBZWk4KPWQNVT2QlEzhSKScQ/G7kSZdQ6uPWbRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751570809; c=relaxed/simple;
	bh=u16CpbdUihPkyI+FiM2IX3TbeuU1zDLWDn5AwsQR/6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FtZxSMF/6LHc1v47IMLX1mfHtlPStTk+/ee9xPMdleEFUXfqpReahaYnPFNnGnJ+qnwpkpGcbfb/7gn5TenOyCIyII6bA7jvZH8iqCPHMpFcaj7kiSUut8ncqJz/PpiEhqGP0LkiO3aQ4/ABWGimYfP62yUlg26tWl/QYH9Oogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S999c0lc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751570807; x=1783106807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u16CpbdUihPkyI+FiM2IX3TbeuU1zDLWDn5AwsQR/6k=;
  b=S999c0lcDZZc29PCMqtKooVbvQJb6SpOr89B0dDMZdiT1iWjDY+/2vZ7
   8Wh3HzULtxc0VqOI2qfLLt+8cNy/rAh4axbX6Vjy6r7Ee3LzSWQUpUz7L
   KdU/EoOg8KNh9d10TmGbtGEIUQI0Vb5U2a/PfJCci/aKzN1AUG0FX5YrY
   TFEOnzRIxBkADtSGveeUTyCQuwodwtdo5SpuYt70x5NIoPNsAfC0OXe/r
   6HD24Rd1aLE17X9FrHK2Pr4lF8WJoa8tiOL7yojElnNlLH0qTATZq9Qe/
   bHQlZN2DJ4TAWkxONQoDFHrI/+JNvpsTVmQxqr5/TNkryMjkpyxP9wJZb
   w==;
X-CSE-ConnectionGUID: YAQJtXPZRHaG1/oV5Z7f6w==
X-CSE-MsgGUID: M8Shs3FfR3aE+VhEm0fkaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65361990"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="65361990"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 12:26:47 -0700
X-CSE-ConnectionGUID: l5Hkqx0CQ3Kg+8Fq+D9G/A==
X-CSE-MsgGUID: 1u6PebRgQH+HHXvXOPP7KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="191624625"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 12:26:46 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	alexander.usyskin@intel.com,
	gregkh@linuxfoundation.org,
	daniele.ceraolospurio@intel.com
Subject: [PATCH v6 01/10] mei: bus: add mei_cldev_mtu interface
Date: Fri,  4 Jul 2025 01:00:57 +0530
Message-Id: <20250703193106.954536-2-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703193106.954536-1-badal.nilawar@intel.com>
References: <20250703193106.954536-1-badal.nilawar@intel.com>
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


