Return-Path: <linux-kernel+bounces-744556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E51B9B10E85
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2611D00402
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F4E2E9EBA;
	Thu, 24 Jul 2025 15:22:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274F92797B1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370571; cv=none; b=kgq/v7NUeFJNBhdHSQz2zdNepgfeJwRio9oTsiDY/8ZsBJ8ybM7TZzBvEkk+2hcbg4dLpufrusmLG814ZDrsEPOuntqumHVCbCom7IacK8S5HmZMxS4V8Sae4aHhBB7kOaFEfrlpRnbk0f9zoKGPt8E5m1BP6lTXAAHYDKWcsnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370571; c=relaxed/simple;
	bh=F7T9nvv0uLffYhCRh87EZr0EoG1kA4a/EwoD/IwlL6A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L8HGnf0ijMfeJDtV+mlXl/Y50EF/0OjziOEPuuqE7U9YM95JA/kYrUcHbBMFz2SvWYBSZ1joq7Z1uMDs2raXDxZh+TZKMBLt1yd48ilXQesI/TqXiViY2ccZSLHINAGCJCDzrP2HBbM9tetczzKFCD2FL0a1AzixkdsAkQXytlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE9231A00;
	Thu, 24 Jul 2025 08:22:41 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A7233F6A8;
	Thu, 24 Jul 2025 08:22:46 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v5 00/10] coresight: Fix and improve clock usage
Date: Thu, 24 Jul 2025 16:22:30 +0100
Message-Id: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALZPgmgC/32N0QrCMAxFf2Xk2UpWO9188j9klBlTV3SrtFKU0
 X837gOEvJzcm5MFEkfPCY7VApGzTz7MAs2mAhqH+cbKX4VBo25wrw9qiJOlZJ1/W3oEuttsFGt
 zqbl2bacR5PIZWfLVeu6FR59eIX7WJ9n8tv99MqiQGBE72rWuPUlrS2GCvpTyBQjWqbK0AAAA
X-Change-ID: 20250627-arm_cs_fix_clock_v4-e24b1e1f8920
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753370566; l=3664;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=F7T9nvv0uLffYhCRh87EZr0EoG1kA4a/EwoD/IwlL6A=;
 b=9Th4KNs/INGYG9r1I/3sSGrUqCwEhs2YCEhlfVXn5x/5bFlIVFfmsHk3j8CO/Gtqnc+lRi48p
 T3QnZZqmu70CmsUSSJIhmQDhYd9mYuXl7W1TonNdYjtzd5yLSCO7z5n
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series fixes and improves clock usage in the Arm CoreSight drivers.

Based on the DT binding documents, the trace clock (atclk) is defined in
some CoreSight modules, but support is absent. In most cases, the issue
is hidden because the atclk clock is shared by multiple CoreSight
modules and the clock is enabled anyway by other drivers. The first
three patches address this issue.

The programming clock (pclk) management in CoreSight drivers does not
use the devm_XXX() variant APIs, the drivers needs to manually disable
and release clocks for errors and for normal module exit.  However, the
drivers miss to disable clocks during module exit. The atclk may also
not be disabled in CoreSight drivers during module exit. By using devm
APIs, patches 04 and 05 fix clock disabling issues.

Another issue is pclk might be enabled twice in init phase - once by
AMBA bus driver, and again by CoreSight drivers. This is fixed in
patch 06.

Patches 07 to 10 refactor the clock related code. Patch 07 consolidates
the clock initialization into a central place. Patch 08 polishes driver
data allocation. Patch 09 makes the clock enabling sequence consistent.
Patch 09 removes redundant condition checks and adds error handling in
runtime PM.

This series has been verified on Arm64 Juno platform, for both DT and
ACPI modes.

---
Changes in v5:
- Skip clock management for ACPI devices (Suzuki).
- Link to v4: https://lore.kernel.org/r/20250627-arm_cs_fix_clock_v4-v4-0-0ce0009c38f8@arm.com

Changes in v4:
- Separated patch 07 into two patches, one is for clock consolidation
  and another is for polishing driver data allocation (Anshuman).

Changes in v3:
- Updated subjects for patches 04 and 05 (Anshuman).
- Refined condition checking "if (dev_is_amba(dev))" in patch 07
  (Anshuman).

---
Leo Yan (10):
      coresight: tmc: Support atclk
      coresight: catu: Support atclk
      coresight: etm4x: Support atclk
      coresight: Appropriately disable programming clocks
      coresight: Appropriately disable trace bus clocks
      coresight: Avoid enable programming clock duplicately
      coresight: Consolidate clock enabling
      coresight: Refactor driver data allocation
      coresight: Make clock sequence consistent
      coresight: Refactor runtime PM

 drivers/hwtracing/coresight/coresight-catu.c       | 53 ++++++++---------
 drivers/hwtracing/coresight/coresight-catu.h       |  1 +
 drivers/hwtracing/coresight/coresight-core.c       | 48 ++++++++++++++++
 drivers/hwtracing/coresight/coresight-cpu-debug.c  | 41 +++++---------
 drivers/hwtracing/coresight/coresight-ctcu-core.c  | 24 +++-----
 drivers/hwtracing/coresight/coresight-etb10.c      | 18 ++----
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 17 ++----
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 32 ++++++-----
 drivers/hwtracing/coresight/coresight-etm4x.h      |  4 +-
 drivers/hwtracing/coresight/coresight-funnel.c     | 66 ++++++++--------------
 drivers/hwtracing/coresight/coresight-replicator.c | 63 ++++++++-------------
 drivers/hwtracing/coresight/coresight-stm.c        | 34 +++++------
 drivers/hwtracing/coresight/coresight-tmc-core.c   | 48 ++++++++--------
 drivers/hwtracing/coresight/coresight-tmc.h        |  2 +
 drivers/hwtracing/coresight/coresight-tpiu.c       | 36 +++++-------
 include/linux/coresight.h                          | 31 +---------
 16 files changed, 228 insertions(+), 290 deletions(-)
---
base-commit: a80198ba650f50d266d7fc4a6c5262df9970f9f2
change-id: 20250627-arm_cs_fix_clock_v4-e24b1e1f8920

Best regards,
-- 
Leo Yan <leo.yan@arm.com>


