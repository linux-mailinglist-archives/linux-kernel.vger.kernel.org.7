Return-Path: <linux-kernel+bounces-886472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6D4C35B24
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E057F4F84CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E441F31618C;
	Wed,  5 Nov 2025 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="sB3g4MNj"
Received: from smtp118.iad3b.emailsrvr.com (smtp118.iad3b.emailsrvr.com [146.20.161.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D8309EFA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346799; cv=none; b=iRgaa1+7nlvNztZNWbUqB10MUPQBqe0BCxfURBUJ5JEnydnyjT2HwXdt7IKNE4QNDcjTxR5EAbydWjE8X8J4gqgWtN3q4J/zgK4tWOVtsVebaVAHKBdl1UfgsMhEY0ZcGGWcem6SB+E5mpMg5Ld1jTTu3jjEzH+W05OW4zZ5260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346799; c=relaxed/simple;
	bh=rttMBNq7CNMC29zCHl+wi+kGnMXxMUeo2UrICXdlOCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdGFMwwNtpVcgLfJHSW4k07DVeFOHF9BZ0/0erBZSy92XrHFCD6ylpb5iVuFNC9WZay63U3SsjQ51BGJdtjJfOtWgmXovNTDp6pbucORfMHQbUDAEIDZ84miZ39FIj2zqg1rH/HTNpsseUDkalRtdQKtwon2jryg94ybufW0vF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=sB3g4MNj; arc=none smtp.client-ip=146.20.161.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1762346286;
	bh=rttMBNq7CNMC29zCHl+wi+kGnMXxMUeo2UrICXdlOCs=;
	h=From:To:Subject:Date:From;
	b=sB3g4MNjifBkUxuQ1gg0fbdYlhAULDrPvIZa0xxOP4P/U654kg/qn66Is0HzrJ2Vu
	 reu2E/+cqzKKLfcsVg4UomBXR7P0rxbHyD2pMO/t+TM1AgwHrp0zOdivbIUPRo+qh0
	 Bk1rIiMzKrmhxNAhC97DhAV+bqU65/oyLLY/bgh4=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp7.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 7335D601DB;
	Wed,  5 Nov 2025 07:38:05 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH v2 4/4] fpga: region: Add dummy definitions of API functions
Date: Wed,  5 Nov 2025 12:31:08 +0000
Message-ID: <20251105123752.93672-5-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105123752.93672-1-abbotti@mev.co.uk>
References: <20251104153013.154463-1-abbotti@mev.co.uk>
 <20251105123752.93672-1-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 2331ede2-2f65-45fd-b71e-e0d81416256f-5-1

Add dummy definitions of the FPGA region API functions for build
testing.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
v2: Correct conditional compilation test for FPGA_REGION tristate
    configuration.
---
 include/linux/fpga/fpga-region.h | 44 +++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 5fbc05fe70a6..11263b33f0dc 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-bridge.h>
+#include <linux/err.h>
 
 struct fpga_region;
 
@@ -54,23 +55,58 @@ struct fpga_region {
 
 #define to_fpga_region(d) container_of(d, struct fpga_region, dev)
 
+#define fpga_region_register_full(parent, info) \
+	__fpga_region_register_full(parent, info, THIS_MODULE)
+
+#define fpga_region_register(parent, mgr, get_bridges) \
+	__fpga_region_register(parent, mgr, get_bridges, THIS_MODULE)
+
+#if IS_ENABLED(CONFIG_FPGA_REGION)
 struct fpga_region *
 fpga_region_class_find(struct device *start, const void *data,
 		       int (*match)(struct device *, const void *));
 
 int fpga_region_program_fpga(struct fpga_region *region);
 
-#define fpga_region_register_full(parent, info) \
-	__fpga_region_register_full(parent, info, THIS_MODULE)
 struct fpga_region *
 __fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
 			    struct module *owner);
 
-#define fpga_region_register(parent, mgr, get_bridges) \
-	__fpga_region_register(parent, mgr, get_bridges, THIS_MODULE)
 struct fpga_region *
 __fpga_region_register(struct device *parent, struct fpga_manager *mgr,
 		       int (*get_bridges)(struct fpga_region *), struct module *owner);
 void fpga_region_unregister(struct fpga_region *region);
 
+#else
+static inline struct fpga_region *
+fpga_region_class_find(struct device *start, const void *data,
+		       int (*match)(struct device *, const void *))
+{
+	return NULL;
+}
+
+static inline int fpga_region_program_fpga(struct fpga_region *region)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline struct fpga_region *
+__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
+			    struct module *owner)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline struct fpga_region *
+__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
+		       int (*get_bridges)(struct fpga_region *), struct module *owner)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline void fpga_region_unregister(struct fpga_region *region)
+{
+}
+#endif
+
 #endif /* _FPGA_REGION_H */
-- 
2.51.0


