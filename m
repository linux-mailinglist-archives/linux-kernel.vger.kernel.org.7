Return-Path: <linux-kernel+bounces-838375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F652BAF0A1
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 04:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74A484E1F3D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 02:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C11A2C11EA;
	Wed,  1 Oct 2025 02:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kspfsi7h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAFE280329
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759287318; cv=none; b=Tis7fTYeKFP155X4lHFjYuKX4+jbZuU6wEFm5fo3KvM3eM5oSrSp/+uWgbe2f4R/Pb2yZ0ydEXDq/eD79y1awLuqTgd8TFg4e96nC+aOj4Nzg/aoMQuaHY3nB2BCv+sIW6xGELc2JI4Yef1V2grClwTiTv7/C1KT1ZJKeOcrsMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759287318; c=relaxed/simple;
	bh=KUKjUzwVQn2FgmlvQBDS9HFLYMgv+qW5UWoLhq+xTz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9kzuz/KXJFTEt29dtix4cqLHnqgX+nTtB0AuiSglIQrHH0IWt7467cxu43uS37jjfG+mboyhNqRB6Kxu+mmLARUPDYMD3lMjj0R/dTs2Nl39D1aRdZrF/0YcGgogKCqGHSL6jTNvtJiu/r81OzIZ2VYADXBRVUcxpv1kI0jgQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kspfsi7h; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759287317; x=1790823317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KUKjUzwVQn2FgmlvQBDS9HFLYMgv+qW5UWoLhq+xTz0=;
  b=Kspfsi7hA1UNXTNmCofavVOmZ5FN2ZEYZJ7s08Vju588QKMmiUBQgktF
   X9+ZJ7hANc4soul6K0NRFcDstaTO+xJEv2xe46mchqP/cH3zor/8s0FsY
   PksX7S9Gt8xynrMCq8+bENq0Iqz7Lq0gsN1s4epCcMmFgQJrZrOObrFr3
   +8rkQT8siN1ZcTtF88lMwtlu9jMFK/6Jk8J4r1wNz2sFj7b0jTZ9SGOub
   jWRF81OK1/85VoGH0xV4MNr0XzZ3Z0xIXSFeFBEQsDkZLGBauAQ/UrbN1
   /7PrBgJcr7WT5+z/dkkjfNf9mL9dmORVgFRsXIokAK7q5fGMz2+eFD1QL
   w==;
X-CSE-ConnectionGUID: UTv9pXVSTgeAtwPO608wag==
X-CSE-MsgGUID: 0dgqsmLvRhatzl4XYlNEYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="61662339"
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="61662339"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:16 -0700
X-CSE-ConnectionGUID: Ry9PZvyUToG1F1n0ZVqUpQ==
X-CSE-MsgGUID: 8ue/SW9gT/+WMvlpFYZweQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,305,1751266800"; 
   d="scan'208";a="178629190"
Received: from 984fee019967.jf.intel.com ([10.165.54.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 19:55:15 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	reinette.chatre@intel.com,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	dan.j.williams@intel.com,
	yilun.xu@linux.intel.com,
	sagis@google.com,
	vannapurve@google.com,
	paulmck@kernel.org,
	nik.borisov@suse.com
Cc: Chao Gao <chao.gao@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 13/21] x86/virt/seamldr: Abort updates if errors occurred midway
Date: Tue, 30 Sep 2025 19:52:57 -0700
Message-ID: <20251001025442.427697-14-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251001025442.427697-1-chao.gao@intel.com>
References: <20251001025442.427697-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDX Module update process has multiple stages, each of which may
encounter failures.

The current state machine of updates proceeds to the next stage
regardless of errors. But continuing updates when errors occur midway
is pointless.

Add support of transitioning directly to the final stage on errors,
effectively aborting the update and skipping all remaining stages.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
---
 arch/x86/virt/vmx/tdx/seamldr.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index b074630d42e3..fca558b90f72 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -235,6 +235,7 @@ enum tdp_state {
 static struct {
 	enum tdp_state state;
 	atomic_t thread_ack;
+	atomic_t failed;
 } tdp_data;
 
 static void set_target_state(enum tdp_state state)
@@ -249,8 +250,16 @@ static void set_target_state(enum tdp_state state)
 /* Last one to ack a state moves to the next state. */
 static void ack_state(void)
 {
-	if (atomic_dec_and_test(&tdp_data.thread_ack))
-		set_target_state(tdp_data.state + 1);
+	if (atomic_dec_and_test(&tdp_data.thread_ack)) {
+		/*
+		 * If an error occurred, abort the update by skipping to
+		 * the final state
+		 */
+		if (atomic_read(&tdp_data.failed))
+			set_target_state(TDP_DONE);
+		else
+			set_target_state(tdp_data.state + 1);
+	}
 }
 
 /*
@@ -273,6 +282,9 @@ static int do_seamldr_install_module(void *params)
 			default:
 				break;
 			}
+
+			if (ret)
+				atomic_inc(&tdp_data.failed);
 			ack_state();
 		} else {
 			touch_nmi_watchdog();
@@ -308,6 +320,7 @@ int seamldr_install_module(const u8 *data, u32 size)
 		return -EBUSY;
 	}
 
+	atomic_set(&tdp_data.failed, 0);
 	set_target_state(TDP_START + 1);
 	ret = stop_machine_cpuslocked(do_seamldr_install_module, params, cpu_online_mask);
 	if (ret)
-- 
2.47.3


