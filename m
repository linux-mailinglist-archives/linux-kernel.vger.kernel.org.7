Return-Path: <linux-kernel+bounces-803284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 963C6B45CF7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBFD1CC4ADC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA093DAC02;
	Fri,  5 Sep 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmZalw/Z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAAC393DF9
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757087139; cv=none; b=UTQk6YkIi2YR6uM5wtLkusvGl1WDru0WNYe4o4QP9SKmw7YTfZ8sodc/BpE6NlsWNVF6iFPRjvn57+Zhuyg1HOwu+iChYBA1vuITPW+AU8yxIk8euZFwKJsnBtd6pLa3aWwKy8ROiQOceRD+9NPOyKxAkYicgWb7/T686F/R1Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757087139; c=relaxed/simple;
	bh=l801J5UodOcYedUIujlh+PG5DgFaooMNL5FGS8EBxfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o1BNJP0nZXBL+NcUcWuL03epleNEWg+Bb/iotRE9Idy9VuwhVP66t8/d7dbjXVxCxTJnVnXRG7NrQtV0cr8AZmdMxKeixADYta29buxjCXwpzDzlykiYH7WCcycqrXOA2Lo9MLXCGsI87/MRx/KSOSH5ULMO4/jcx+29C4BCj2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmZalw/Z; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757087138; x=1788623138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l801J5UodOcYedUIujlh+PG5DgFaooMNL5FGS8EBxfA=;
  b=BmZalw/Z39QqeW3ytfSL0XwyY1azCrh3AOOLaNzbLTkf39h81P/y/Pi6
   IcmLs/LfNb8HfymSBTUgc1CV+ay0V0vhRdJGY96MXoCCI3U4GjmCWIGJh
   OIpIaeWOvASMzxd66xWYDCVqyIdRy74pnzoi6+B3TWV4I6ia98cr2v5pI
   JXmuRowSC4n7xKVwQ8p5dELf0Fsz+DJNNl6xUoCTGwFfeIKDVpU+7TDYV
   OL0H2UDPaO3PQCWRHso5QlqLtbptpC9F693R/9gm30Ddpki9GKG7k9GU/
   ikCYntQH3Vjk3Ls17QnOKbXFkBuU25240rCalm9IiljXDr0lQ32AcgqnZ
   A==;
X-CSE-ConnectionGUID: vJ3dEYwzQn+6OkYlRZgV/Q==
X-CSE-MsgGUID: ZiRlfg8QS72qXn0LIz6urA==
X-IronPort-AV: E=McAfee;i="6800,10657,11544"; a="70144665"
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="70144665"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 08:45:37 -0700
X-CSE-ConnectionGUID: GVV61kKuSU2uaWl+23kfiQ==
X-CSE-MsgGUID: DxK6dXHfSwqugc9K1WXHwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,241,1751266800"; 
   d="scan'208";a="172071799"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 08:45:34 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	alexander.usyskin@intel.com,
	gregkh@linuxfoundation.org,
	daniele.ceraolospurio@intel.com,
	mika.westerberg@linux.intel.com,
	lucas.demarchi@intel.com,
	karthik.poosa@intel.com
Subject: [PATCH v9 6/9] drm/xe/xe_late_bind_fw: Reload late binding fw in rpm resume
Date: Fri,  5 Sep 2025 21:19:50 +0530
Message-Id: <20250905154953.3974335-7-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250905154953.3974335-1-badal.nilawar@intel.com>
References: <20250905154953.3974335-1-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reload late binding fw during runtime resume.

Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/xe/xe_late_bind_fw.c | 2 +-
 drivers/gpu/drm/xe/xe_late_bind_fw.h | 1 +
 drivers/gpu/drm/xe/xe_pm.c           | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw.c b/drivers/gpu/drm/xe/xe_late_bind_fw.c
index bb161d99602e..d4d64677bf48 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw.c
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw.c
@@ -82,7 +82,7 @@ static int xe_late_bind_fw_num_fans(struct xe_late_bind *late_bind)
 		return 0;
 }
 
-static void xe_late_bind_wait_for_worker_completion(struct xe_late_bind *late_bind)
+void xe_late_bind_wait_for_worker_completion(struct xe_late_bind *late_bind)
 {
 	struct xe_device *xe = late_bind_to_xe(late_bind);
 	struct xe_late_bind_fw *lbfw;
diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw.h b/drivers/gpu/drm/xe/xe_late_bind_fw.h
index 28d56ed2bfdc..07e437390539 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw.h
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw.h
@@ -12,5 +12,6 @@ struct xe_late_bind;
 
 int xe_late_bind_init(struct xe_late_bind *late_bind);
 int xe_late_bind_fw_load(struct xe_late_bind *late_bind);
+void xe_late_bind_wait_for_worker_completion(struct xe_late_bind *late_bind);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index a2e85030b7f4..b7c05508f67a 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -21,6 +21,7 @@
 #include "xe_gt_idle.h"
 #include "xe_i2c.h"
 #include "xe_irq.h"
+#include "xe_late_bind_fw.h"
 #include "xe_pcode.h"
 #include "xe_pxp.h"
 #include "xe_sriov_vf_ccs.h"
@@ -575,6 +576,9 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 	if (IS_SRIOV_VF(xe))
 		xe_sriov_vf_ccs_register_context(xe);
 
+	if (xe->d3cold.allowed)
+		xe_late_bind_fw_load(&xe->late_bind);
+
 out:
 	xe_rpm_lockmap_release(xe);
 	xe_pm_write_callback_task(xe, NULL);
-- 
2.34.1


