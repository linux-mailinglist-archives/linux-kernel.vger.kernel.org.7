Return-Path: <linux-kernel+bounces-774336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8C6B2B136
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC70A6853EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2292F3451CA;
	Mon, 18 Aug 2025 19:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNwlWiXF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932553451A7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543815; cv=none; b=mZkRL0hzSzmTzXzw6LMymQdTfHEOhDeyLG/BG3iT6pu3n1L7nEohCpOhAG/0wtrtiUfQSGNTDn4kob13/RhYtniNRmTFCykXWVPxoNs95ExpNoHE32RaNfWcdHu9QufC5jIypgJSS6S3G7KBUrggWdo9cbmbS3987O9oJ5NJtac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543815; c=relaxed/simple;
	bh=KY/5N+bWJucd8CA8IBpc7G9EJJypnH8ub4mLKiGO3pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f36fgtkv8kSw896DcouDCt2ag69ODPYw15VhxrLTdWQVLSAJsnzKd6T3lfbDfe5nu2vzNKb6djZgfu221kjjWcJ/YufmzsZawTL3+vxmcrPgQHovUjYg0dJRULxHXVsVs+Q0Caw7T9t1yKf5DVunvMz8ZTi/CsnIhPLnSCOz6FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNwlWiXF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755543814; x=1787079814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KY/5N+bWJucd8CA8IBpc7G9EJJypnH8ub4mLKiGO3pU=;
  b=CNwlWiXFfPENKwOh4hEyfDtuNMmjie85s6hppECqGrX2wExk4BeJ9m1n
   dBpcNI3tT0NtEZLYAoZE8Ihk7z/kbggvTOryk7YWP6PyRAHukZjvaSi8E
   pRoG7ySLN+s2xWoAlAM+EDHsdpr0cZTHvsGvft4G9vVy/VOrzsy0Y493G
   WZJJtCvq/sOtRhYfKXcff5ba/xBuhvVPMEVnsrj63L8g3yocD7zksNZsE
   Lbga5YDBs0jaLMsCnInusqqzH/EM0kplsxQkL1FgdGt6bE2ZOFgW+xjpQ
   4+pVWcW2gu1QvYk6xYZolDIRQXeuglrb41eo+r9QtnQ2z11/Vpk9JRp1r
   g==;
X-CSE-ConnectionGUID: mI8mF31PQg+jGlhCchFozA==
X-CSE-MsgGUID: /fGaGybkS3CULLsQdI3FdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11526"; a="69151586"
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="69151586"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 12:03:31 -0700
X-CSE-ConnectionGUID: B97bswzxRl6mgxHeFfw1dQ==
X-CSE-MsgGUID: 2va1DEReQrO52M24lvh4uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,300,1747724400"; 
   d="scan'208";a="171890589"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa003.jf.intel.com with ESMTP; 18 Aug 2025 12:03:30 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Alex Murray <alex.murray@canonical.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH 1/2] x86/microcode/intel: Refresh the revisions that determine old_microcode
Date: Mon, 18 Aug 2025 12:01:36 -0700
Message-ID: <20250818190137.3525414-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818190137.3525414-1-sohil.mehta@intel.com>
References: <20250818190137.3525414-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the minimum expected revisions of Intel microcode based on the
microcode-20250512 (May 2025) release.

Cc: <stable@kernel.org> # v6.15+
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
 .../kernel/cpu/microcode/intel-ucode-defs.h   | 86 +++++++++++--------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
index cb6e601701ab..2d48e6593540 100644
--- a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
+++ b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
@@ -67,9 +67,8 @@
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0008, .driver_data = 0x1000191 },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0010, .driver_data = 0x2007006 },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0020, .driver_data = 0x3000010 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0040, .driver_data = 0x4003605 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0080, .driver_data = 0x5003707 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0800, .driver_data = 0x7002904 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0080, .driver_data = 0x5003901 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0800, .driver_data = 0x7002b01 },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0004, .driver_data = 0x1c },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0008, .driver_data = 0x700001c },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0010, .driver_data = 0xf00001a },
@@ -81,51 +80,62 @@
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5f, .steppings = 0x0002, .driver_data = 0x3e },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x66, .steppings = 0x0008, .driver_data = 0x2a },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x6a, .steppings = 0x0020, .driver_data = 0xc0002f0 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x6a, .steppings = 0x0040, .driver_data = 0xd0003e7 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x6c, .steppings = 0x0002, .driver_data = 0x10002b0 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x6a, .steppings = 0x0040, .driver_data = 0xd000404 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x6c, .steppings = 0x0002, .driver_data = 0x10002d0 },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x7a, .steppings = 0x0002, .driver_data = 0x42 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x7a, .steppings = 0x0100, .driver_data = 0x24 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x7e, .steppings = 0x0020, .driver_data = 0xc6 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x7a, .steppings = 0x0100, .driver_data = 0x26 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x7e, .steppings = 0x0020, .driver_data = 0xca },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8a, .steppings = 0x0002, .driver_data = 0x33 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8c, .steppings = 0x0002, .driver_data = 0xb8 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8c, .steppings = 0x0004, .driver_data = 0x38 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8d, .steppings = 0x0002, .driver_data = 0x52 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8c, .steppings = 0x0002, .driver_data = 0xbc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8c, .steppings = 0x0004, .driver_data = 0x3c },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8d, .steppings = 0x0002, .driver_data = 0x56 },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x0200, .driver_data = 0xf6 },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x0400, .driver_data = 0xf6 },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x0800, .driver_data = 0xf6 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x1000, .driver_data = 0xfc },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0100, .driver_data = 0x2c000390 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0080, .driver_data = 0x2b000603 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0040, .driver_data = 0x2c000390 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0020, .driver_data = 0x2c000390 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0010, .driver_data = 0x2c000390 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x1000, .driver_data = 0x100 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0010, .driver_data = 0x2c0003f7 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0020, .driver_data = 0x2c0003f7 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0040, .driver_data = 0x2c0003f7 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0080, .driver_data = 0x2b000639 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0100, .driver_data = 0x2c0003f7 },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x96, .steppings = 0x0002, .driver_data = 0x1a },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x97, .steppings = 0x0004, .driver_data = 0x37 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x97, .steppings = 0x0020, .driver_data = 0x37 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbf, .steppings = 0x0004, .driver_data = 0x37 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbf, .steppings = 0x0020, .driver_data = 0x37 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9a, .steppings = 0x0008, .driver_data = 0x435 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9a, .steppings = 0x0010, .driver_data = 0x435 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x97, .steppings = 0x0004, .driver_data = 0x3a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x97, .steppings = 0x0020, .driver_data = 0x3a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9a, .steppings = 0x0008, .driver_data = 0x437 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9a, .steppings = 0x0010, .driver_data = 0x437 },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9c, .steppings = 0x0001, .driver_data = 0x24000026 },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x0200, .driver_data = 0xf8 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x0400, .driver_data = 0xf8 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x0400, .driver_data = 0xfa },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x0800, .driver_data = 0xf6 },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x1000, .driver_data = 0xf8 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x2000, .driver_data = 0x100 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0004, .driver_data = 0xfc },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0008, .driver_data = 0xfc },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0020, .driver_data = 0xfc },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa6, .steppings = 0x0001, .driver_data = 0xfe },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa6, .steppings = 0x0002, .driver_data = 0xfc },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa7, .steppings = 0x0002, .driver_data = 0x62 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xaa, .steppings = 0x0010, .driver_data = 0x20 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xb7, .steppings = 0x0002, .driver_data = 0x12b },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0004, .driver_data = 0x4123 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0008, .driver_data = 0x4123 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0100, .driver_data = 0x4123 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbe, .steppings = 0x0001, .driver_data = 0x1a },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xcf, .steppings = 0x0004, .driver_data = 0x21000283 },
-{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xcf, .steppings = 0x0002, .driver_data = 0x21000283 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x2000, .driver_data = 0x104 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0004, .driver_data = 0x100 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0008, .driver_data = 0x100 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0020, .driver_data = 0x100 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa6, .steppings = 0x0001, .driver_data = 0x102 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa6, .steppings = 0x0002, .driver_data = 0x100 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa7, .steppings = 0x0002, .driver_data = 0x64 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xaa, .steppings = 0x0010, .driver_data = 0x24 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xad, .steppings = 0x0002, .driver_data = 0xa0000d1 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xaf, .steppings = 0x0008, .driver_data = 0x3000341 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xb5, .steppings = 0x0001, .driver_data = 0xa },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xb7, .steppings = 0x0002, .driver_data = 0x12f },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xb7, .steppings = 0x0010, .driver_data = 0x12f },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0004, .driver_data = 0x4128 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0008, .driver_data = 0x4128 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0100, .driver_data = 0x4128 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbd, .steppings = 0x0002, .driver_data = 0x11f },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbe, .steppings = 0x0001, .driver_data = 0x1d },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbf, .steppings = 0x0004, .driver_data = 0x3a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbf, .steppings = 0x0020, .driver_data = 0x3a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbf, .steppings = 0x0040, .driver_data = 0x3a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbf, .steppings = 0x0080, .driver_data = 0x3a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xc5, .steppings = 0x0004, .driver_data = 0x118 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xc6, .steppings = 0x0004, .driver_data = 0x118 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xc6, .steppings = 0x0010, .driver_data = 0x118 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xca, .steppings = 0x0004, .driver_data = 0x118 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xcf, .steppings = 0x0002, .driver_data = 0x210002a9 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xcf, .steppings = 0x0004, .driver_data = 0x210002a9 },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x00, .steppings = 0x0080, .driver_data = 0x12 },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x00, .steppings = 0x0400, .driver_data = 0x15 },
 { .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x01, .steppings = 0x0004, .driver_data = 0x2e },
-- 
2.43.0


