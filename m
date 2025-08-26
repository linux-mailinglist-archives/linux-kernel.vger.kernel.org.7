Return-Path: <linux-kernel+bounces-786704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C19B364E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6235A563285
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A802D46A4;
	Tue, 26 Aug 2025 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOSINhmj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF4A2BE032;
	Tue, 26 Aug 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214861; cv=none; b=RuzQEkvsYSFLgQ3vi1UXlxTArkZOwcB9CxpWhKn+w9jYSZ6hqks7NxXEA7dxDezNl1fKt1a9ELV2m9IYPSdqcQXc+9wOzg/57yV1zDkQfar6Kh4ubgiBNoznwnQFrIL8p2q6j09y+80hN7I/28N3omVbziTRRoRo8q6/coiBKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214861; c=relaxed/simple;
	bh=lumhdBg3fSrCQUGxBI0173sBnu5KZJP0UEoCXMyZZ4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XALjfvle29c53iCcuZiRCKa4JVf78IJvYH5QTfMeCUduDn/XcHwJwQH4I0MFc9/vqHv43+2nVXir0jWWImeXLczM+qadHtFnmxBRi2vJnBao1uAUCQ+XWUEwv6DvdOdri3CjUXNWaVaWPdEwR3RRTvsG/H1fKVMLQWKl4dT3fuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOSINhmj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756214860; x=1787750860;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lumhdBg3fSrCQUGxBI0173sBnu5KZJP0UEoCXMyZZ4s=;
  b=QOSINhmjhKPzpeuXhenR9dXzm3T1XUisD6coRHe77lbU/VppqZRVBi8z
   du4MaQ9I6Gb4Bupy7vdNR/TMk/7Kz+iDT5VZSNYCwIKoWZzOg9d5Wp35K
   R0keLjT+GOi5EszoWETk+m+cABEMhfRA45W2r97T4GyKmVBLA7AwlfyCn
   kAsvn/i6kLG/sF3UeOpUPS0Id0Dpo2MwWUIZb9pmyhjmZ8ipDKUFIawY3
   mgLB/EvxlJB+dGnJauw7Hbfb/5bBJ4fbWaR2Ilug45EEf1mKBEoxQylHA
   vDi0lDZnd3A8WueHqZwoy0/YuOWRCPd/1JgENYNlV0idLnn8OFgFtHKL1
   w==;
X-CSE-ConnectionGUID: AnS0HuXsQWqZvQiCBjualw==
X-CSE-MsgGUID: BtQiq8akQV2z/l5E+40xfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="61084416"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="61084416"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 06:27:39 -0700
X-CSE-ConnectionGUID: PBqqGOEERhCyiVo23dKOuA==
X-CSE-MsgGUID: H+OF/kYxQS+qQUPcSO6g3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="200467370"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 26 Aug 2025 06:27:37 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 2F15E95; Tue, 26 Aug 2025 15:27:36 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] ASoC: amd: acp: Remove (explicitly) unused header
Date: Tue, 26 Aug 2025 15:27:16 +0200
Message-ID: <20250826132734.278226-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fwnode.h is not supposed to be used by the drivers as it
has the definitions for the core parts for different device
property provider implementations. Drop it.

Note, that fwnode API for drivers is provided in property.h
which is included here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: rebased on top of latest Linux Next

 sound/soc/amd/acp/amd-sdw-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/amd-sdw-acpi.c b/sound/soc/amd/acp/amd-sdw-acpi.c
index 238b584887ee..0160b0df26a0 100644
--- a/sound/soc/amd/acp/amd-sdw-acpi.c
+++ b/sound/soc/amd/acp/amd-sdw-acpi.c
@@ -17,8 +17,8 @@
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/export.h>
-#include <linux/fwnode.h>
 #include <linux/module.h>
+#include <linux/property.h>
 #include <linux/soundwire/sdw_amd.h>
 #include <linux/string.h>
 
-- 
2.50.1


