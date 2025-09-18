Return-Path: <linux-kernel+bounces-822837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76145B84C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13931687DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE853090E0;
	Thu, 18 Sep 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OW4Verms"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125D2FE575
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201434; cv=none; b=IObgIj2XTgPg5gs99ALcOQtkneZS8DUYBlUvRgupTlhqRfRQvsEi6VR6ERZnpcVdBF98YTNB2DYNFvz/xXMwmgAVA9t6BjxkqBotRmMp/lpRnqJ01l4J/HfaGXRjmzB7RcayeR+LQdP6rE0fgJMntWbFM7IgQlYpSi+xU/k6sS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201434; c=relaxed/simple;
	bh=dhe0LcEudXUM/0ByQP9TwCeEHazgLIGsobggf5v6AJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXfP5ENdeOJQCJY3Ru3tkl0phbCAgOCjdTktwe+OqGBFbH6hXSts84naEa6uQcCE/vywNCDktITCTqkT0bDV9sisQcqNyNkyPeJ9WVULNgDpwWNK5dmFrIF5NzizJ96Q3lfB6SxoOjPrukgsZQ8FEHGeubJWF1SHJICYtazSbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OW4Verms; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758201433; x=1789737433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dhe0LcEudXUM/0ByQP9TwCeEHazgLIGsobggf5v6AJo=;
  b=OW4VermsUyvGE5qMS2oPwF0sUJAFgB4wABgNWBRZnikLGDYyoCAt81cx
   OzrlFiyMnfQ2wAe4qIVqNx0mpG9J6luC+qyOn6NyMOQ05DqRuOKWkc50i
   wwiz8rxd5z30tB0p2Op0IVo2QHW5YTfJqxjK7i+8wvQ87Pocq8/muhyAq
   naTdY2sTRowEb9BfPa35gNdpObfbShkr01UXtEyTyNa39HLkbVKyhz2H9
   OBvuyjbesbvs96ueVLV6IrGmvTNl6VLf+Ivt/HBCioCmESTVdRVYu+cxP
   HPh0oja/afj6bqU4PbxMrB1ibegUixtandMKYyLnY16Xt9f7HOLh8Psk3
   g==;
X-CSE-ConnectionGUID: VH0atjajR3m0JE4TlvDbgg==
X-CSE-MsgGUID: R29piNf8Q4ykDMF8BhPZHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="77970700"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="77970700"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 06:17:12 -0700
X-CSE-ConnectionGUID: v+8EzqSpRsmTlC5pwmlFsA==
X-CSE-MsgGUID: w2crqmmJT8a7VVHJ8j2TXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="174648785"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 06:17:10 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next 1/5] mei: me: trigger link reset if hw ready is unexpected
Date: Thu, 18 Sep 2025 16:04:31 +0300
Message-ID: <20250918130435.3327400-2-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918130435.3327400-1-alexander.usyskin@intel.com>
References: <20250918130435.3327400-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver can receive HW not ready interrupt unexpectedly.
E.g. for cards that go donwn to D3cold.
Trigger link reset in this case to synchronize driver and
firmware state.
No need to do that sync if driver is going down or interrupt is
received before driver started initial link reset sequence.
Introduce UNINITIALIZED device state to allow interrupt handler
to ignore interrupts before first init.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/hw-me.c   | 17 ++++++++++++++---
 drivers/misc/mei/init.c    |  2 +-
 drivers/misc/mei/mei_dev.h |  3 ++-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index 346633ebc6e6..3172dc095b53 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1373,9 +1373,20 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
 	/*  check if we need to start the dev */
 	if (!mei_host_is_ready(dev)) {
 		if (mei_hw_is_ready(dev)) {
-			dev_dbg(&dev->dev, "we need to start the dev.\n");
-			dev->recvd_hw_ready = true;
-			wake_up(&dev->wait_hw_ready);
+			/* synchronized by dev mutex */
+			if (waitqueue_active(&dev->wait_hw_ready)) {
+				dev_dbg(&dev->dev, "we need to start the dev.\n");
+				dev->recvd_hw_ready = true;
+				wake_up(&dev->wait_hw_ready);
+			} else if (dev->dev_state != MEI_DEV_UNINITIALIZED &&
+				   dev->dev_state != MEI_DEV_POWERING_DOWN &&
+				   dev->dev_state != MEI_DEV_POWER_DOWN) {
+				dev_dbg(&dev->dev, "Force link reset.\n");
+				schedule_work(&dev->reset_work);
+			} else {
+				dev_dbg(&dev->dev, "Ignore this interrupt in state = %d\n",
+					dev->dev_state);
+			}
 		} else {
 			dev_dbg(&dev->dev, "Spurious Interrupt\n");
 		}
diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index 4d1d5423b612..b9fb54328a7b 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -399,7 +399,7 @@ void mei_device_init(struct mei_device *dev,
 	init_waitqueue_head(&dev->wait_hw_ready);
 	init_waitqueue_head(&dev->wait_pg);
 	init_waitqueue_head(&dev->wait_hbm_start);
-	dev->dev_state = MEI_DEV_INITIALIZING;
+	dev->dev_state = MEI_DEV_UNINITIALIZED;
 	dev->reset_count = 0;
 
 	INIT_LIST_HEAD(&dev->write_list);
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 4ab2b9100fd4..9f2044ae6cc4 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -57,7 +57,8 @@ enum file_state {
 
 /* MEI device states */
 enum mei_dev_state {
-	MEI_DEV_INITIALIZING = 0,
+	MEI_DEV_UNINITIALIZED = 0,
+	MEI_DEV_INITIALIZING,
 	MEI_DEV_INIT_CLIENTS,
 	MEI_DEV_ENABLED,
 	MEI_DEV_RESETTING,
-- 
2.43.0


