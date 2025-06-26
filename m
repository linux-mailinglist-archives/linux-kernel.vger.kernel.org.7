Return-Path: <linux-kernel+bounces-704885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8808AEA2E0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 17:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034C11885C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 15:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9E52ECE8F;
	Thu, 26 Jun 2025 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G+Iq6z4L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3EB2ECE8C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952136; cv=none; b=sRgD0xf03/cwUdKqkonnldcGVsI5d+ZwIBwVLs37/9U7fnCCYPdNIpZXa6FjrvnmtlrwC4vXt4ak/l6ju2dJ7yQM5bRFv8EHsPMF5wVlhqpqVjEote3qh29mKS1QA/2WlujlEyJ9jh3XbTz9YBktREBphpL3LigOfGHVQB/BfaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952136; c=relaxed/simple;
	bh=DVxGAOB+z9HgOV6c2p86HhKpJK+II0e+oGR0iJDzZLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EueZ4k1UXoJ7azexh0EVDyPNr2iokktg9cXAV/ce0UeQ8ccWqtrcCddxCd3/KiHNO02UQ8MHF8JKoe1vNfTIokr19ALo2ecXB3Z+c0L3FNL8XUMZk8/hhQmYXnQ1c3Dvga1CxpK3yrfS3HLBReCa4FkkHKMMD9YVpogHSzo67tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G+Iq6z4L; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750952135; x=1782488135;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DVxGAOB+z9HgOV6c2p86HhKpJK+II0e+oGR0iJDzZLU=;
  b=G+Iq6z4LkoyYdYUsC5utfV6zSP5zkHR+Pem9TRngIDv5/9znBGd4+707
   uuMt2coMCTkwcXJMDSwX4wwUkELKrGRGsnMFQougTVFVx4oultuhF7Pyi
   VjGoghvgoy1LHxibxr5A/eFTQcwExITUJD5DQbwXlVIJjtWGEv7R8pnjh
   +Ilzexg7fMrIA2413jNiJHzoNne7Gw0HQP03tr7h04wPMQ/UQUQ8tEhvA
   Id0ZVer/8hNi2HknBLbqlQU1Zh1FX9kF762Z8XFPHtEqmH0HjG1/AnDhQ
   QTdrh/qKjEb74spQqBz49N41+YWb7xP94ScvXqapOB3HGNGSKwS6i+5kg
   g==;
X-CSE-ConnectionGUID: yjz1Sig5R32pCn7LupAJ6Q==
X-CSE-MsgGUID: B8vqatL6SvO24GbmruiZTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="57063444"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="57063444"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 08:35:28 -0700
X-CSE-ConnectionGUID: 7vwt+UJtR1CWF13eHODhjw==
X-CSE-MsgGUID: BMHf2IvGREyl0k2RoQSt7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="157111055"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 26 Jun 2025 08:35:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id DFF3F2AD; Thu, 26 Jun 2025 18:35:24 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v1 1/1] libnvdimm: Don't use "proxy" headers
Date: Thu, 26 Jun 2025 18:35:23 +0300
Message-ID: <20250626153523.323447-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Note that kernel.h is discouraged to be included as it's written
at the top of that file.

While doing that, sort headers alphabetically.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/libnvdimm.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index e772aae71843..dce8787fba53 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -6,12 +6,12 @@
  */
 #ifndef __LIBNVDIMM_H__
 #define __LIBNVDIMM_H__
-#include <linux/kernel.h>
+
+#include <linux/ioport.h>
 #include <linux/sizes.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/uuid.h>
-#include <linux/spinlock.h>
-#include <linux/bio.h>
 
 struct badrange_entry {
 	u64 start;
@@ -80,7 +80,9 @@ typedef int (*ndctl_fn)(struct nvdimm_bus_descriptor *nd_desc,
 		struct nvdimm *nvdimm, unsigned int cmd, void *buf,
 		unsigned int buf_len, int *cmd_rc);
 
+struct attribute_group;
 struct device_node;
+struct module;
 struct nvdimm_bus_descriptor {
 	const struct attribute_group **attr_groups;
 	unsigned long cmd_mask;
@@ -121,6 +123,7 @@ struct nd_mapping_desc {
 	int position;
 };
 
+struct bio;
 struct nd_region;
 struct nd_region_desc {
 	struct resource *res;
@@ -147,8 +150,6 @@ static inline void __iomem *devm_nvdimm_ioremap(struct device *dev,
 	return (void __iomem *) devm_nvdimm_memremap(dev, offset, size, 0);
 }
 
-struct nvdimm_bus;
-
 /*
  * Note that separate bits for locked + unlocked are defined so that
  * 'flags == 0' corresponds to an error / not-supported state.
@@ -238,6 +239,8 @@ struct nvdimm_fw_ops {
 	int (*arm)(struct nvdimm *nvdimm, enum nvdimm_fwa_trigger arg);
 };
 
+struct nvdimm_bus;
+
 void badrange_init(struct badrange *badrange);
 int badrange_add(struct badrange *badrange, u64 addr, u64 length);
 void badrange_forget(struct badrange *badrange, phys_addr_t start,
-- 
2.47.2


