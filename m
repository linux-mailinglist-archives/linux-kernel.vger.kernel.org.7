Return-Path: <linux-kernel+bounces-868874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E844C06639
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192303A9ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF70E30C347;
	Fri, 24 Oct 2025 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVNoVVL1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676431A561
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310809; cv=none; b=WjlqGO4RuDa0uA6T02CXawMOgdsCz0prCmuJdjEg5UxPNIWkIhbeSaE8b0huWhhrBrqrrIQdneypzmIXENpKY/2Oz0Ho8XVGgH8hLY9gjd9tKWjiLzyX/teT6586Zn7E+MFbXAj3w7V0LJWPsp4kGue+DitpbYbPeZKifADYoOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310809; c=relaxed/simple;
	bh=QfTvVbIuqmoycjiuRETlY7C9n0ihBDGSioOczwrJMCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tn6O2HwE5HaHwZ+Y0vQUVoZKsqjvTN04yZBKKfekoSRlkehJKGeO/xWUHYvcSBKkjwSsqV1HjvPEKIM9x+b8wOzKLhsV7QHV7AqEZr5TWGYdZUfLYCwMbZz/7ruVLP4RKhSZcyMRh0cCyp2+t4NBeUoFZEesHQ15A1tlpBMMlZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVNoVVL1; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761310807; x=1792846807;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QfTvVbIuqmoycjiuRETlY7C9n0ihBDGSioOczwrJMCw=;
  b=SVNoVVL18eJ0dprLciQNRjIFZHI+9FAsCY8L950ik13+2F4eaOn+D0BV
   C4czsGRp8liBy1Eu//aStvCxxztvb2ijWXTtpTJ29KiBRIw/9vWlWwehv
   n2gxrZqDcZAN1P1oJJEEllg6slyDDB0ggdCRJpOJnI6jHpPOBrtJ3Hn6b
   XytVvMl7ubOGVEr0yEpXJmpK9DCq7Z2SWADSnsONUFmGBE+GYqPm7fTeF
   hrtLhqohcV45FWs0WXqNIGiB9d61ZmTuYyfEuxxENIxFsw3thzH2YaRfZ
   QEHs1ZWSrWbnkwLOqsdGKfVjOs/Nua3s5tl4SlquS7LYrB2vy4MwtTorV
   A==;
X-CSE-ConnectionGUID: Wp6+9c+uTGGSwKGLAC8k3w==
X-CSE-MsgGUID: OP7ZIqk1QCmrW5zVFzuS9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63383273"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="63383273"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 06:00:06 -0700
X-CSE-ConnectionGUID: YeeKue6vRVubzaQ+hdLLoQ==
X-CSE-MsgGUID: UdyED/htTh+reGyBYB8d7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; 
   d="scan'208";a="183599458"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2025 06:00:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 266C196; Fri, 24 Oct 2025 15:00:01 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Borislav Petkov (AMD)" <bp@alien8.de>,
	David Kaplan <david.kaplan@amd.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] x86/bugs: Remove dead code which might prevent from building
Date: Fri, 24 Oct 2025 14:59:59 +0200
Message-ID: <20251024125959.1526277-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang, in particular, is not happy about dead code:

arch/x86/kernel/cpu/bugs.c:1830:20: error: unused function 'match_option' [-Werror,-Wunused-function]
 1830 | static inline bool match_option(const char *arg, int arglen, const char *opt)
      |                    ^~~~~~~~~~~~
1 error generated.

Remove a leftover from the previous cleanup.

Fixes: 02ac6cc8c5a1 ("x86/bugs: Simplify SSB cmdline parsing")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e08de5b0d20b..d7fa03bf51b4 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1827,13 +1827,6 @@ void unpriv_ebpf_notify(int new_state)
 }
 #endif
 
-static inline bool match_option(const char *arg, int arglen, const char *opt)
-{
-	int len = strlen(opt);
-
-	return len == arglen && !strncmp(arg, opt, len);
-}
-
 /* The kernel command line selection for spectre v2 */
 enum spectre_v2_mitigation_cmd {
 	SPECTRE_V2_CMD_NONE,
-- 
2.50.1


