Return-Path: <linux-kernel+bounces-680469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CD1AD45DE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 00:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CA93A6AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jun 2025 22:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F0428B7EF;
	Tue, 10 Jun 2025 22:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMf8cp26"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DEE289E3A;
	Tue, 10 Jun 2025 22:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749594298; cv=none; b=N68uFRHf/GRNOPX6h9mNDU1rmeSjtjmVeuox7NBDHDSCsVuzX2/A+ifzekkj7Eenxn6CA8csjsx/iraGli1AwxXLNU2cZTAl+t34nOklBGCDJFA3cXsHltAg9S+YWrYKB4mVR5U62cYJnbT2MmW6ZIwlN/AeFwJw8jMex+04+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749594298; c=relaxed/simple;
	bh=BlHoR7DMPYMfkdgzGm4aEVB2aVG/tIrR2uyRaZZVc00=;
	h=Subject:To:Cc:From:Date:Message-Id; b=LnoXTKpn/wil78asbH/HdwW6W7y0zyPjwYuqbXW4Db2OTx/KBeUHv3QaZAb3CPRWh4LOqtk8WEQ91CwsWeqiX+DKUQXoOpQ/IjiLBJzWv7w16KOYmHobeDxcS4ZuE28QD4tIWfsfwh1RrmMi1CLQW7/fCfGxQpu8xIj0rcDsJlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMf8cp26; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749594294; x=1781130294;
  h=subject:to:cc:from:date:message-id;
  bh=BlHoR7DMPYMfkdgzGm4aEVB2aVG/tIrR2uyRaZZVc00=;
  b=hMf8cp26Cvx2n0z60H138/JdyhUWI9ukqU5bb9LxGhIrvafRfDWKhBfZ
   mtMj9QgiYDPrcdHchYLNEkLVnFFVkVJRSby7RwsEoq4YrQH6X8ZYkaGtk
   bwSgpHAo58RV2cfs7zbUpxDl3P3FYQslKaHXMhc8iZghVWJkvBlXpUMXa
   Iol7CfZYzUouWvBCXR3AldwoXfvltFhMgAjyX4b7Jy47yKPLu1mH590RJ
   VNUyWQI8s3Uo9DeVhs7CUVDxweR6bb7OTpumgRGpCwhzCZk8O9dRz9mSz
   Kor9KAA6NWsAuE7n0xLTY4hXo+ixEmju9ytnL/D/TO3Z2zEiVIbkTq49h
   g==;
X-CSE-ConnectionGUID: hOQsjpRcSn+po/ze9jtMxw==
X-CSE-MsgGUID: dEP4moJXSKCTnuTzEytcQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62759586"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="62759586"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 15:24:21 -0700
X-CSE-ConnectionGUID: TMEHgI/rSnOsvM3vQhREgQ==
X-CSE-MsgGUID: nYRfNVrlRr+PKbqi7LUbGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="146951945"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa009.jf.intel.com with ESMTP; 10 Jun 2025 15:24:20 -0700
Subject: [PATCH] x86/mm: Disable INVLPGB when PTI is enabled
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov (AMD) <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>, Nadav Amit <nadav.amit@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>, stable@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Tue, 10 Jun 2025 15:24:20 -0700
Message-Id: <20250610222420.E8CBF472@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

PTI uses separate ASIDs (aka. PCIDs) for kernel and user address
spaces. When the kernel needs to flush the user address space, it
just sets a bit in a bitmap and then flushes the entire PCID on
the next switch to userspace.

But, this bitmap is a single 'unsigned long' which is plenty for
all 6 dynamic ASIDs. But, unfortunately, the INVLPGB support
brings along a bunch more user ASIDs, as many as ~2k more. The
bitmap can't address that many.

Fortunately, the bitmap is only needed for PTI and all the CPUs
with INVLPGB are AMD CPUs that aren't vulnerable to Meltdown and
don't need PTI. The only way someone can run into an issue in
practice is by booting with pti=on on a newer AMD CPU.

Disable INVLPGB if PTI is enabled. Avoid overrunning the small
bitmap.

Note: this will be fixed up properly by making the bitmap bigger.
For now, just avoid the mostly theoretical bug.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Fixes: 4afeb0ed1753 ("x86/mm: Enable broadcast TLB invalidation for multi-threaded processes")
Cc: stable@vger.kernel.org
Cc: Rik van Riel <riel@surriel.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---

 b/arch/x86/mm/pti.c |    5 +++++
 1 file changed, 5 insertions(+)

diff -puN arch/x86/mm/pti.c~no-INVLPGB-plus-KPTI arch/x86/mm/pti.c
--- a/arch/x86/mm/pti.c~no-INVLPGB-plus-KPTI	2025-06-10 15:02:14.439554339 -0700
+++ b/arch/x86/mm/pti.c	2025-06-10 15:09:47.713198206 -0700
@@ -98,6 +98,11 @@ void __init pti_check_boottime_disable(v
 		return;
 
 	setup_force_cpu_cap(X86_FEATURE_PTI);
+
+	if (cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
+		pr_debug("PTI enabled, disabling INVLPGB\n");
+		setup_clear_cpu_cap(X86_FEATURE_INVLPGB);
+	}
 }
 
 static int __init pti_parse_cmdline(char *arg)
_

