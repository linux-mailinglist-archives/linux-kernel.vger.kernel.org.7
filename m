Return-Path: <linux-kernel+bounces-887756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B94C3900F
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463423B72C0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CE0245021;
	Thu,  6 Nov 2025 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCTxI+6X"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4394E2BAF9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 03:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762400154; cv=none; b=ub2gMqaBnjRDXG5PcaolXrjWn1ir2v1WduHOnoYRC08gSuAVY+Iv4O3PrSw3myqOAQ4ctCPwyzInD13AqGv4uSpwIbgWHG0BcaiaNnXd/iUDsvFlbH5azYx6XBxbmYUiv+tD5Sf68c6L7iRr6E0UGHn3w0+GT6q4eLNNEpxlY2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762400154; c=relaxed/simple;
	bh=zgNTFpCXM3o9g2ZXsFBLXyEVmzMgXOrMc94PnKAGIk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmtr6DQu49SuZC2EcOIkCXUsV3umcK38I9bgNJhFvI+aMe0hVKECtI2TVpVO+J1eR+Fz0CM3zVfH2jwCEkU+KiaU+JuvAKCKib13iyT1G+nbI28xxLVDgb2EB3e4s6/YlC8TD2E8ChnOgImaC3MJhnvlG2uTq/Y9sPHHZD9ZSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCTxI+6X; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762400154; x=1793936154;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zgNTFpCXM3o9g2ZXsFBLXyEVmzMgXOrMc94PnKAGIk4=;
  b=SCTxI+6XAV6S6AGCv3OWFEXLCIMj+RjXiG9/XHXIBizcEtpoukqG1cG+
   4beNCAYbBgxqJoBUERJrGqFhJXFfHsMW1Ljw72AXFGWfV2jUeFB1cO3Hi
   oT0K2rfbDtifn87Er9Lqby3q31TB7J+gOXkkCbDkU9M/sKluYf9BDB69Q
   7ubl39s7pGfs0lVhr5wYcw3Fsnl7bCquenkdnMiPhaYHhfSp86n3Xfmqk
   gxCZ/jeiLrZA+dPgCigxrqFeHR6K/g2KPNvQNT4PVwaZEfbHW8pzTNbbZ
   Jd5FdbufJr4qofoLQb/pLkUOyTZhurigNRhV123u48+7zH6Bysm4KAwFJ
   A==;
X-CSE-ConnectionGUID: F8qKnSjhSu2q8a/G7lknlQ==
X-CSE-MsgGUID: ewc6KoeESla0mOvtfKzkAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="81930332"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="81930332"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 19:35:53 -0800
X-CSE-ConnectionGUID: 8eewTtwKTtSfZG6ABkdL9A==
X-CSE-MsgGUID: 9FhqImc5SwqqvQ0/2wOfbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="187351125"
Received: from junxiao.bj.intel.com ([10.238.152.69])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 19:35:49 -0800
From: Junxiao Chang <junxiao.chang@intel.com>
To: lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	daniele.ceraolospurio@intel.com,
	alexander.usyskin@intel.com,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: baoli.zhang@intel.com,
	junxiao.chang@intel.com
Subject: [PATCH] drm/me/gsc: mei interrupt top half should be in irq disabled context
Date: Fri,  7 Nov 2025 11:31:52 +0800
Message-ID: <20251107033152.834960-1-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MEI GSC interrupt comes from i915 or xe driver. It has top half and
bottom half. Top half is called from i915/xe interrupt handler. It
should be in irq disabled context.

With RT kernel(PREEMPT_RT enabled), by default IRQ handler is in
threaded IRQ. MEI GSC top half might be in threaded IRQ context.
generic_handle_irq_safe API could be called from either IRQ or
process context, it disables local IRQ then calls MEI GSC interrupt
top half.

This change fixes B580 GPU boot issue with RT enabled.

Fixes: e02cea83d32d ("drm/xe/gsc: add Battlemage support")
Tested-by: Baoli Zhang <baoli.zhang@intel.com>
Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 drivers/gpu/drm/xe/xe_heci_gsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.c b/drivers/gpu/drm/xe/xe_heci_gsc.c
index a415ca4887914..32d509b113915 100644
--- a/drivers/gpu/drm/xe/xe_heci_gsc.c
+++ b/drivers/gpu/drm/xe/xe_heci_gsc.c
@@ -221,7 +221,7 @@ void xe_heci_gsc_irq_handler(struct xe_device *xe, u32 iir)
 	if (xe->heci_gsc.irq < 0)
 		return;
 
-	ret = generic_handle_irq(xe->heci_gsc.irq);
+	ret = generic_handle_irq_safe(xe->heci_gsc.irq);
 	if (ret)
 		drm_err_ratelimited(&xe->drm, "error handling GSC irq: %d\n", ret);
 }
@@ -241,7 +241,7 @@ void xe_heci_csc_irq_handler(struct xe_device *xe, u32 iir)
 	if (xe->heci_gsc.irq < 0)
 		return;
 
-	ret = generic_handle_irq(xe->heci_gsc.irq);
+	ret = generic_handle_irq_safe(xe->heci_gsc.irq);
 	if (ret)
 		drm_err_ratelimited(&xe->drm, "error handling GSC irq: %d\n", ret);
 }
-- 
2.43.0


