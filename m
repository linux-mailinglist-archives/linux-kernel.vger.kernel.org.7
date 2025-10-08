Return-Path: <linux-kernel+bounces-845327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E43DABC4730
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 909B134F18C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777002F6166;
	Wed,  8 Oct 2025 10:51:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3602EC54A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920711; cv=none; b=m0hP4D1QOiVpafTe2fNK/2q4PjPwWSjsgTIzDZflVbXrig96pUD9FGUTgkTmanVgh8QLtrRypuTIDVmu81hq7VpJzyqZUAX411UWSL9xH9eXvOA4hUGgAp5unT6JiAvCVp1X28IbYrSZc9Te21LIv3tMJj4PpFDgghteExekbQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920711; c=relaxed/simple;
	bh=uGjdg2BDGPCc3OD3GZvJcnUjViKSR2iqLWafDin5fts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QmU6hH9yflw2hYpO5Na0D8aUueqA2v6LAXseKZ4HVCQgKdwZt/YAsSx8X2dpyx/oZVKiyq8mUHIFCij8rMWr1zKa+AtnpUYDIP7UjrQ0KQ2DslXF4oDDcr7zxd39LuKtsGuY4RdWsupi3cW95Xsq/+7OUx6kkt75DjEbW0TkXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3184322FC;
	Wed,  8 Oct 2025 03:51:40 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com [10.40.16.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF6A33F59E;
	Wed,  8 Oct 2025 03:51:45 -0700 (PDT)
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Ketil Johnsen <ketil.johnsen@arm.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panthor: Ensure MCU is disabled on suspend
Date: Wed,  8 Oct 2025 12:51:11 +0200
Message-ID: <20251008105112.4077015-1-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the Panthor driver needs the GPU to be powered down
between suspend and resume. If this is not done, then the
MCU_CONTROL register will be preserved as AUTO, which again will
cause a premature FW boot on resume. The FW will go directly into
fatal state in this case.

This case needs to be handled as there is no guarantee that the
GPU will be powered down after the suspend callback on all platforms.

The fix is to call panthor_fw_stop() in "pre-reset" path to ensure
the MCU_CONTROL register is cleared (set DISABLE). This matches
well with the already existing call to panthor_fw_start() from the
"post-reset" path.

Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 9bf06e55eaee..df767e82148a 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1099,6 +1099,7 @@ void panthor_fw_pre_reset(struct panthor_device *ptdev, bool on_hang)
 	}
 
 	panthor_job_irq_suspend(&ptdev->fw->irq);
+	panthor_fw_stop(ptdev);
 }
 
 /**
-- 
2.43.0


