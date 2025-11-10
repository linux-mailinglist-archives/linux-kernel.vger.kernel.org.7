Return-Path: <linux-kernel+bounces-894351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2078BC49D13
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC332188D04E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7655A305043;
	Mon, 10 Nov 2025 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdzdViAu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B7A194A73;
	Mon, 10 Nov 2025 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762818644; cv=none; b=p50UvB7IpozEht1VKUU4YXvAR1VQzoERH6yuEL8oTM1CGJ1gWzcXRh3WWXtMWYo28sSth4fGCJvfaXgMJfzX59HkpgV8xYSgfHQYHq7hdaYdiJgbJvNZx6zL2Tu8O6dhjG1Z+j/zcYF4VeT2L6OS9ZrJAe2rQF2+SGPNUKTPkZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762818644; c=relaxed/simple;
	bh=29gaiYI3dWNEWIACZ9XRwKB433NzhJewEGqvUDHbs5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V91a5+cSv8Mm8dhy7iY/6YbbDhEUVKGiC90w7vXpCjASV6fFD8RuP1J3vIKeetcngjLvYcEHpZ0+cOyLDeWeYEA3OpcO+N/RREARzkFAxblQKi6FlyG5fFB0HUcfJHp+kg8BddFIj6SvWcqeqZ/hd2xHTSd94o5uNqQC1EbnXyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdzdViAu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762818643; x=1794354643;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=29gaiYI3dWNEWIACZ9XRwKB433NzhJewEGqvUDHbs5c=;
  b=bdzdViAuTkHv4lSsIcN5fkJ1LF0SzC7I9EEiwNqW0caoQugzNMHuaa30
   IZ8TkgvlYLZQi2uuQP7sG/maZHLxk7v/dv0X/I0m7Ebtvbz3QIrEqz7pr
   ko/tvGjbDMOiwElna0ZnuND2tgJ8nXW9YPHeIK1Jraa6McJcBV1Odd0AJ
   coOC48YG6JqoXIDl65wLHHKHrlDj7VnlDa3eYaO2YWqr8ZEV9+iECqYGo
   rJVNAn3byue7OnPVzlRyHMU9dVgCVlb6bbDe+5WWjYZDC7Om5oF/f2GVe
   CDHpR+t6f53XCXbo9689wmpwtAmFFYh7sDZecx6qMix4Nrq54pCU3rokc
   A==;
X-CSE-ConnectionGUID: YJF+iwTrR/6ULUp7gLpFoQ==
X-CSE-MsgGUID: Lpi0JM1aTiivtpFn/FnAoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64910716"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="64910716"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 15:50:42 -0800
X-CSE-ConnectionGUID: v0/8y6UUT1OeyU+Cf1Kd2A==
X-CSE-MsgGUID: vDFYy77vQXaNq+urdOQq0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="188772879"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by orviesa007.jf.intel.com with ESMTP; 10 Nov 2025 15:50:42 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: alexhung@gmail.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86/intel/hid: Add Nova Lake support
Date: Mon, 10 Nov 2025 15:50:41 -0800
Message-ID: <20251110235041.123685-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ACPI ID for Nova Lake.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/hid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index f25a427cccda..9c07a7faf18f 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -55,6 +55,7 @@ static const struct acpi_device_id intel_hid_ids[] = {
 	{ "INTC10CB" },
 	{ "INTC10CC" },
 	{ "INTC10F1" },
+	{ "INTC10F2" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, intel_hid_ids);
-- 
2.51.0


