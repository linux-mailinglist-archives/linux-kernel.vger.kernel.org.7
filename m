Return-Path: <linux-kernel+bounces-770593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E46FAB27CE0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4038B621A0B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64412727E5;
	Fri, 15 Aug 2025 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ikFCxz3v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77950253B71;
	Fri, 15 Aug 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249046; cv=none; b=TcaqCg+ToPwiz+vp3WQqPSv5qkqlBT3DyA+LLJUeJGNDh1tZsNwNQm2/ynMDF53KlHZG9FFJwpc4Rqra+R4QNFN8hmIKCjKnnq80qSloU5YFUYJGNM1LZbCkMxdxjaIWyv5Fo05eegVhTrFsp75O0Xu67Dj9c0MLSDxCc3mBT/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249046; c=relaxed/simple;
	bh=BfdXrBj0UmYvzxano54Wp1l/E3jXjigLAPd4mfQS0g4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ogxKe+oXuhzcn1/Vi6mAjwGDql5hZn9yVwy8TQrzHJN0M8oOODgURAb/7C6rMZ1vDXN+WbSGCDky6cI1gyTBpOUb08/7sD2i59jQMvvsY35tTyNVeYtNKM13an+sTl2257wQPq+3o2Y1jItFRQ/tla6dG3JFEAje1/dLpZpmAKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ikFCxz3v; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755249045; x=1786785045;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BfdXrBj0UmYvzxano54Wp1l/E3jXjigLAPd4mfQS0g4=;
  b=ikFCxz3vaksRTQNXeYi3ZY+GPLX/2gafsjOoTw9V/GObXwLTpDlGOLXW
   REyCVOL5Ph3LS0o3w18YzWGigBgoTHcMmpCqNo04dsrfKvUd8E4X0WDB/
   JZbzZqqp9pEjdqnAAt7AxSxGLBhxY9q/RxweoJyE1CL3vogyXrp0MDttY
   pWo/J6eRBR4AZIBdTWJPblleDbwxI6qMJo7P4IVPiS/4lC1WyMmTqVLO5
   SwMRPuE3ySZ7PmAzoyxyYXoaJeUCDqKbp1tNMvto99xCf6+6V4umFXLci
   nfylRzCjGD009gLOyTjtfhvCNmHRFbW8FEFOwMHUOhVVufpAm2LVWGvHZ
   w==;
X-CSE-ConnectionGUID: eTWJwL18QhqHI2EMSxm2XA==
X-CSE-MsgGUID: 5aI2O12JSwywUQk8aYyvEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="57681939"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="57681939"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 02:10:43 -0700
X-CSE-ConnectionGUID: bCQw11EBTkygZtcb355a5w==
X-CSE-MsgGUID: OfYXrsb/RpyK4IBQ83cLKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="172313110"
Received: from ly-workstation.sh.intel.com ([10.239.182.53])
  by orviesa005.jf.intel.com with ESMTP; 15 Aug 2025 02:10:40 -0700
From: Yi Lai <yi1.lai@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	wad@chromium.org,
	luto@amacapital.net,
	kees@kernel.org,
	thomas.weissschuh@linutronix.de,
	usama.anjum@collabora.com,
	yi1.lai@intel.com
Subject: [PATCH] selftests/kselftest_harness: Add harness-selftest.expected to TEST_FILES
Date: Fri, 15 Aug 2025 17:10:32 +0800
Message-ID: <20250815091032.802171-1-yi1.lai@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The harness-selftest.expected is not installed in INSTALL_PATH.
Attempting to execute harness-selftest.sh shows warning:

diff: ./kselftest_harness/harness-selftest.expected: No such file or
directory

Add harness-selftest.expected to TEST_FILES.

Signed-off-by: Yi Lai <yi1.lai@intel.com>
---
 tools/testing/selftests/kselftest_harness/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kselftest_harness/Makefile b/tools/testing/selftests/kselftest_harness/Makefile
index 0617535a6ce4..d2369c01701a 100644
--- a/tools/testing/selftests/kselftest_harness/Makefile
+++ b/tools/testing/selftests/kselftest_harness/Makefile
@@ -2,6 +2,7 @@
 
 TEST_GEN_PROGS_EXTENDED := harness-selftest
 TEST_PROGS := harness-selftest.sh
+TEST_FILES := harness-selftest.expected
 EXTRA_CLEAN := harness-selftest.seen
 
 include ../lib.mk
-- 
2.43.0


