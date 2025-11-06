Return-Path: <linux-kernel+bounces-888283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E8C3A698
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CDA33B2A30
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC2A224244;
	Thu,  6 Nov 2025 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/81D0L3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B652EFD9B
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426216; cv=none; b=MskOy1ak1WwnYQMeNFmMo4udjgH+4tm4K9ve/iCc5+5rVkICJMRDeOtys6ytqi4kqZzQUQzPHVhBfSQzuJLCvOA9nBUl3jhJgx4TEjnjdQ+vsRhqrmP0t/8egmrSww3p+Ty0a1E4yZ/oBSshe6C925hXNFchqcS3elhbQF9wvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426216; c=relaxed/simple;
	bh=5JetFE+gcVoZwYrmSvCyH+NsvkC4E69mgdSuLH2QOoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F7D7CoRtvHxvR5b29aR56/PnWwa/VMBTZSCZUVUj6qog2jySsPYFxW8RBJJCBlyl/qAsApbQf7Fz49BUH185fOYOov9rjshALiV9ytF8pNWk0+Oi2WWEQfIm/09bPPyPQyu2oa3dscpSvAWdEgwWAworwvp3JGmgRoIqt6sjHGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/81D0L3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762426214; x=1793962214;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5JetFE+gcVoZwYrmSvCyH+NsvkC4E69mgdSuLH2QOoY=;
  b=Q/81D0L3nfv94KbiVnErqmUDC7eKul9HQUa0GqzlGVdhVBPi/fDIGKVs
   STrSn7bmWI3ZqGLWEIt2bn7QXrmmuq2zsNQxOqLwoU7HDgHvWdYHad0zJ
   EY/zeEXLO88p4Ki5NHamSNezfrBFqdZq+cZJu99uZike81BtH1WgaorYQ
   HOvXotPwxxL5Y8AvEFxJekPYncOuxyEVkIDZvxngWnR7gpETAvpcVtsZh
   pcljQ6IGPw2ihCTYjgHVpqki5tAfu51g7vWjQayjPx+lNDncl5wRak8zv
   fv4XGA9DbSbI9loAici2LsUxc1IkgwLd3un7S6uh7NLhMQjvsb8gm9f0l
   g==;
X-CSE-ConnectionGUID: e02h34xLS/K7rwV5TmroXw==
X-CSE-MsgGUID: fGx5bsbSS4GVv+9fdeQ7Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64655392"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="64655392"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 02:50:13 -0800
X-CSE-ConnectionGUID: 58B3z4/CSEWdMksFdrA2xw==
X-CSE-MsgGUID: 7EYk24eySOGpNbWoyDW6sg==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 06 Nov 2025 02:50:11 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7E61995; Thu, 06 Nov 2025 11:50:10 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] compiler_types: Warn about unused static inline functions on second
Date: Thu,  6 Nov 2025 11:50:00 +0100
Message-ID: <20251106105000.2103276-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

Per Nathan, clang catches unused "static inline" functions in C files since
commit 6863f5643dd7 ("kbuild: allow Clang to find unused static inline
functions for W=1 build").

Linus said:

> So I entirely ignore W=1 issues, because I think so many of the extra
> warnings are bogus.
>
> But if this one in particular is causing more problems than most -
> some teams do seem to use W=1 as part of their test builds - it's fine
> to send me a patch that just moves bad warnings to W=2.
>
> And if anybody uses W=2 for their test builds, that's THEIR problem..

Here is the change to bump the warning from W=1 to W=2.

Fixes: 6863f5643dd7 ("kbuild: allow Clang to find unused static inline functions for W=1 build")
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/compiler_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 59288a2c1ad2..575a03643fa1 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -253,7 +253,7 @@ struct ftrace_likely_data {
  * for W=1 build. This will allow clang to find unused functions. Remove the
  * __inline_maybe_unused entirely after fixing most of -Wunused-function warnings.
  */
-#ifdef KBUILD_EXTRA_WARN1
+#ifdef KBUILD_EXTRA_WARN2
 #define __inline_maybe_unused
 #else
 #define __inline_maybe_unused __maybe_unused
-- 
2.50.1


