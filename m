Return-Path: <linux-kernel+bounces-871240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB5C0CB79
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 540E24F33F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818FC2F0C68;
	Mon, 27 Oct 2025 09:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5FwQFZa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1D2E9EB2
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557904; cv=none; b=mFrDElvc/UOR7V1cF2kWFi/B3X5pKzpmtFvT1SXNZS+QTMMkTihDHDD7f7vM5BvsYixf/CVdRb6sJAqoLxFxENTrCikyFcvN+FNS6effATpTQR9rAGVJLkB/cfavrJsmAXKWgFYyKm/w8ABUQmebPbmHyoNZFu413VS1Spc/Exk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557904; c=relaxed/simple;
	bh=pQ/SgEAn7QKZohwPf3HV9vDLlLvOkbLX/6MzW7SNNyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GPX9aPhOLYC61NLlWLywFm5DuVydsHp0nz6y5zZISZJs5FA9SVYM+sM+ARWkPPKuysEPTdVpoyzrTGOpzMdCfMdklb+/PG34Q7QDmiaCz39N4J4VR8ppgwJSEupdWiNWxk+jAvuqtnWX7kOOSPgeEBp4dWBeWj5BdZMp24DNhwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5FwQFZa; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761557903; x=1793093903;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pQ/SgEAn7QKZohwPf3HV9vDLlLvOkbLX/6MzW7SNNyA=;
  b=M5FwQFZaQgqFbXJRiUbkkmvvFnEstSsh2u+Eayv/JumoKnKz9cbNIBAI
   DF2MpD3aamM6dbZR0by0XGNZfdsnWPj4/wZ1KbuhmnuTkB4vt/HNXDddI
   cABk/YPMrWGTgcFsKD0+YKiIpAJrlleD0LO42Ur067QN9n3Lu6g2co8O/
   DhT+QLZue+0t7gTCg81ArzvC8AeInQG2c+Fbga6BKVjQdh8ngJgBNbqrf
   Ec8SQwekg5l6BGIG4cQXqEzXKR3cSQeGBMEjp2ykploYqAqNzsg3ammeA
   GmCj3oKzomUXMIbMna2yeQEeXE9Vea7scsYamGYv2FOYhDOyKDoXTqCus
   g==;
X-CSE-ConnectionGUID: LZisN0seQTW5jYW38Y9dCg==
X-CSE-MsgGUID: nAEUgP48RRuak6ofmxfwRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62663204"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="62663204"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:38:23 -0700
X-CSE-ConnectionGUID: TD9MQEUaQsWzDTtADA7B/Q==
X-CSE-MsgGUID: yB4BiA/STZWCkUJLYV9amQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184900376"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 27 Oct 2025 02:38:21 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 477C295; Mon, 27 Oct 2025 10:38:20 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Subject: [PATCH v3 1/1] checkpatch: Don't warn on "orhapned" DT schema file
Date: Mon, 27 Oct 2025 10:36:23 +0100
Message-ID: <20251027093818.1806010-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently checkpatch warns is the DT schema file is absent in MAINTAINERS.
However the DT schema files are self-contained in this sense and
have embedded information about maintainers of it. This is a requirement.
Hence, avoid checkpatch warning about it.

Tested-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v3: removed Requested-by tag
v2: drop some leftovers


The motivation of the patch is that DT people complaining about checkpatch but
doing nothing about it. They should be more collaborative.

 scripts/checkpatch.pl | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6729f18e5654..db274a7c2fb0 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3441,9 +3441,12 @@ sub process {
 		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
 		      (defined($1) || defined($2))))) {
 			$is_patch = 1;
-			$reported_maintainer_file = 1;
-			WARN("FILE_PATH_CHANGES",
-			     "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
+			# DT bindings are incorporate maintainer information, no need to report
+			if ($realfile !~ m@^Documentation/devicetree/bindings/@)) {
+				$reported_maintainer_file = 1;
+				WARN("FILE_PATH_CHANGES",
+				     "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
+			}
 		}
 
 # Check for adding new DT bindings not in schema format
-- 
2.50.1


