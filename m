Return-Path: <linux-kernel+bounces-752082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72154B17118
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B249D58684A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6335D2C15A6;
	Thu, 31 Jul 2025 12:23:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F73239562
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964635; cv=none; b=X2j/oAvDl5YAyzHB8r9L/XEFEM18QLiA9NvAMeFVO7O4L+COUTnN6M4b2uhzByw1MY0NoNuvbVRzXAOLQ2eaFqLk/kMlDacDO35otXKUXLnpmVjx7wcUDcPrlBMrTmiN40yPsZzHqVenFN6SEnhkd8rWFMFeaArIHSx652BnIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964635; c=relaxed/simple;
	bh=0N4/UcZGlpKfMNYPPMVZGAeFZcrW4w1eiHheYBGfg98=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TjSB6mJmwgYNzN7qIKocNkrelkEl4NPM/6V1g4zweEiQP1LVlt7GBOAHOkx2rnVOHXBd6dqKHobelUbtxy/KUD/N0NdZIep3IbXuckeN+D/zQGfY66tnsMz8FiFlwAwHZ+FCZmp/U8P6RX76m5W+VW9APvYxq+bJruWGQjM0RL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BC441D13;
	Thu, 31 Jul 2025 05:23:44 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 961AD3F673;
	Thu, 31 Jul 2025 05:23:50 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v6 00/10] coresight: Fix and improve clock usage
Date: Thu, 31 Jul 2025 13:23:36 +0100
Message-Id: <20250731-arm_cs_fix_clock_v4-v6-0-1dfe10bb3f6f@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEhgi2gC/33NSw6CMBAG4KuYrq0ZSinFlfcwpsEylUahpjWNh
 nB3BzZsjMls/nl8M7GE0WNix93EImaffBgpqP2O2b4db8h9R5kJEBUoUfM2DsYm4/zb2Eewd5M
 lRyGvBRZONwIYXT4j0nxVzxfKvU+vED/rkyyX7n+PCjhYBIDGltrpE20dbBjYouVqE2ohfwsVC
 ap0SuquRRDFJszz/AWhtjaA9gAAAA==
X-Change-ID: 20250627-arm_cs_fix_clock_v4-e24b1e1f8920
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mark Brown <broonie@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753964630; l=4075;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=0N4/UcZGlpKfMNYPPMVZGAeFZcrW4w1eiHheYBGfg98=;
 b=oghc8hKq3Mr+SsKl2ihMcTvE/kZKPzQEzLvLxtivVo2yM7fhxeMEOwdi1W6tLN/Ac1b3Pqdh7
 mpe08WruKR1B7huNMBDy0YRxXNm4oSDcQ+1syImrOdRoOuzAgAE9TaN
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

Also tested on Hikey960 for emulating static funnel and replicator
without clock nodes. Mark kindly tested on imx8mp board.

---
Changes in v6:
- Changed to devm_clk_get_optional_enabled() for pclk, for fixing the
  clock initialization failure reported by Mark.
- Added James test tags as no change for ACPI.
- Link to v5: https://lore.kernel.org/r/20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com

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


