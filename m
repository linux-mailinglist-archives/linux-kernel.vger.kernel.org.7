Return-Path: <linux-kernel+bounces-720425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C6AFBB8D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E27D3BEF03
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F6A2690EC;
	Mon,  7 Jul 2025 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFhC8mx7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098426A084
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915317; cv=none; b=ladg3EoSfbial/lTg6CZ5+5FaKnjgfmF+GQoNxOoGOc68pnaFPZaDMwvCR+Ljw7wJ87rWcJTXBSX9i758TgsWQli+RT66vOWtUMX4U0Fobleo7pLPTSZGsVJEbQj6vq9IMRI9PMxVVI9hWCCmvf3ylmoBuhWZtjmk+DQmoELWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915317; c=relaxed/simple;
	bh=IlroywlKbJTxbgFXfvixBNi1PxBQUvaIHsJkVuBe1aM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lcZ0yQbkGCdr4kj8OwdDkBEet39TosUn+SpJHkTybAuCHAvUxgwFmZJEm0+HoC1ugiSyFC+qcmhSXNvhntnw6LOLeIpewdGqIGffZgbDRKc+MZCQfQit4OHAuX7rxna+mpo3c8ej6XZ2B8cQ/kJZUALJM8sD0QYgPC2tfvNXXuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFhC8mx7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751915316; x=1783451316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IlroywlKbJTxbgFXfvixBNi1PxBQUvaIHsJkVuBe1aM=;
  b=WFhC8mx7nXFwCFosyCJscfxWGR2Qh5U9O6rJl+/5EpzyIYLdUQpoNV+/
   om51s3Vpz6kDJ99rHugW8yw2HtjlzVS+gtJcI7upzi9iYYc3O9Y19OqqU
   gqoIjD2+ObpwWNcIkwjhfthyV2rIhHzCS0C4g0SZwXoMwGnZ2enKElK7x
   gF6ifywVxERZJwYfoarLJJogRusxB0Tkv5OUrRyT4AUyqwEpQlC73X09A
   lefQ5XoSu27Fzi1nQxjNeetEVMevMJRH3pB60rkq/zsXE7NxXhaB1krnY
   eCAaviz3fmATup6BRciiXlqoDIQn/SMzG+GS8pwPc0/YhBMGQ3YfqOG1d
   A==;
X-CSE-ConnectionGUID: d4Zp0yGrRLGgYz0kbzkwSw==
X-CSE-MsgGUID: bopKiexFSPWlwDhoEpngzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="57945692"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="57945692"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:08:36 -0700
X-CSE-ConnectionGUID: xv7nRmA6QsSvgvdiVWy1xw==
X-CSE-MsgGUID: KjIKuxyfSqO0cCWH9zOmmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="154707526"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 12:08:33 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	alexander.usyskin@intel.com,
	gregkh@linuxfoundation.org,
	daniele.ceraolospurio@intel.com
Subject: [PATCH v7 7/9] drm/xe/xe_late_bind_fw: Reload late binding fw during system resume
Date: Tue,  8 Jul 2025 00:42:35 +0530
Message-Id: <20250707191237.1782824-8-badal.nilawar@intel.com>
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

Reload late binding fw during resume from system suspend

v2:
  - Unconditionally reload late binding fw (Rodrigo)
  - Flush worker during system suspend

Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/xe_pm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 734fe259600e..13afaf97d831 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -127,6 +127,8 @@ int xe_pm_suspend(struct xe_device *xe)
 	if (err)
 		goto err;
 
+	xe_late_bind_wait_for_worker_completion(&xe->late_bind);
+
 	for_each_gt(gt, xe, id)
 		xe_gt_suspend_prepare(gt);
 
@@ -205,6 +207,8 @@ int xe_pm_resume(struct xe_device *xe)
 
 	xe_pxp_pm_resume(xe->pxp);
 
+	xe_late_bind_fw_load(&xe->late_bind);
+
 	drm_dbg(&xe->drm, "Device resumed\n");
 	return 0;
 err:
-- 
2.34.1


