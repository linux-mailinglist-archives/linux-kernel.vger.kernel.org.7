Return-Path: <linux-kernel+bounces-881083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DBCC2765F
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 04:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CE614E028E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 03:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CC52571D8;
	Sat,  1 Nov 2025 03:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YE4GI8Fm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A4212FB3
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761966654; cv=none; b=ZvT6jOCELEhBkAmxjkwa9xB9fAftTlNHoB3FGG5mNFKYfMKuKpK/42c7Z6kAukeVUJ9ERAY3mAATwe7O6205JQ1Dii13fgHVz1sGOidx5X5eCbNIzLsUgHlHSOFRj00PJ0/DAEwcXsBiF/svPoTzuKQovHfgdQC5O+xXNfnEcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761966654; c=relaxed/simple;
	bh=e2ppcsw5vrnDLhjG9IG7t1gIPzbTAfc/eHNpnig1wk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eS39uw9w9xQCu+M/H85O/HxCw+RmRqt6/aNaI6yuJPXGx1UJplTXVqIwepP2S0z8jqZgTGnQtA/pKmH2Shsq4zKlOB4LdKlqHEe5Z63VW5tmE+1fgRExeIwvDe35uG1Q8/n/ZzaLMY/s3DanQwClxO2wWFNhzWlzTRtUVT+kPFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YE4GI8Fm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761966652; x=1793502652;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=e2ppcsw5vrnDLhjG9IG7t1gIPzbTAfc/eHNpnig1wk0=;
  b=YE4GI8FmdYpuGWRphBlr39nCi7jXODjr1tDMRBNTOEMbqozGats2/XtX
   fOheM+/e5f29KdMAeRCzQ9rrms6bHT46jBcf6OnU5CppmE6fzYIHG0ysh
   xSlDrPH099XV3EOQauzGZhpAuxIpyvfCepx5zm6zBFTAs/6SD6qLvKyu1
   hrSc9Zk93RJ0L5uyn9RcyhgJi9G8sGant4XZDUkLwpJ9gxOQnMK5NMR+u
   aOAO1t502YrLHUdC3a13W4TxEdQU3R7Q8uCTx6Z2rx0lUOC0VaK4ixU0k
   Qj14AmXS4eysxg6orl81c7yHsGL0ddgsP9jySo+SpskuhR+GEU8EAuXIU
   w==;
X-CSE-ConnectionGUID: bH5VbRRjTaCbbZ7QyyNEIQ==
X-CSE-MsgGUID: RhsVU7RNQl24Ly4fVfkmVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11599"; a="63150983"
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="63150983"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 20:10:51 -0700
X-CSE-ConnectionGUID: brsDFrXqQZyA3pHE3hW02g==
X-CSE-MsgGUID: rZe12tLERJGkgMLJnoKVNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,271,1754982000"; 
   d="scan'208";a="190727873"
Received: from unknown (HELO hyperion.local) ([10.243.61.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 20:10:51 -0700
From: Marc Herbert <marc.herbert@linux.intel.com>
Date: Sat, 01 Nov 2025 03:10:24 +0000
Subject: [PATCH] x86/msr: add CPU_OUT_OF_SPEC taint name to "unrecognized"
 pr_warn(msg)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251101-tainted-msr-v1-1-e00658ba04d4@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAB96BWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2MD3ZLEzLyS1BTd3OIiXZM0k9Rki8TkFEvTZCWgjoKi1LTMCrBp0bG
 1tQCWKB+3XQAAAA==
X-Change-ID: 20251030-tainted-msr-4f4ec8acd95c
To: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, 
 Marc Herbert <marc.herbert@linux.intel.com>
X-Mailer: b4 0.15-dev

While restricting access, commit a7e1f67ed29f ("x86/msr: Filter MSR
writes") also added warning and tainting. But the warning message never
mentioned tainting. Moreover, this uses the "CPU_OUT_OF_SPEC" flag which
is not clearly related to MSRs: that flag is overloaded by several,
fairly different situations, including some much scarier ones. So,
without an expert around (thank you Dave Hansen), it would have been
practically impossible to root cause the tainting from just the log file
at hand.  Fix this by simply appending the CPU_OUT_OF_SPEC flag to the
warning message.

This readability issue happened when staring at logs involving the
Intel Memory Latency Checker (among many other things going on in that
log). The MLC disables hardware prefetch.

Signed-off-by: Marc Herbert <marc.herbert@linux.intel.com>
---
 arch/x86/kernel/msr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index e17c16c54a37..21355130cc78 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -98,8 +98,8 @@ static int filter_write(u32 reg)
 	if (!__ratelimit(&fw_rs))
 		return 0;
 
-	pr_warn("Write to unrecognized MSR 0x%x by %s (pid: %d).\n",
-	        reg, current->comm, current->pid);
+	pr_warn("Write to unrecognized MSR 0x%x by %s (pid: %d), tainting %s\n",
+		reg, current->comm, current->pid, taint_flags[TAINT_CPU_OUT_OF_SPEC].desc);
 	pr_warn("See https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/about for details.\n");
 
 	return 0;

---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251030-tainted-msr-4f4ec8acd95c

Best regards,
--  
Marc Herbert <marc.herbert@linux.intel.com>


