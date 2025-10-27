Return-Path: <linux-kernel+bounces-871185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37414C0C95F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 282574F7718
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77362F7471;
	Mon, 27 Oct 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXXEv3t5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEED2F1FE4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556005; cv=none; b=L1zEEuMqXhtEaeGl0Q54qx7JPn+A80m5mHRyym7QW3gXCdfNmlcuKw0vXreVxt405d6T8+IoeAgZKTaRYJD9J8jJbeUUdr+7I8DGhw7RQdy8Z34IFHiZ2+KpXkafMDcI2J98qC3KnjGG7u/oc3YljkiVoTAYDw90e35nCCCwVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556005; c=relaxed/simple;
	bh=pQWstgc/fRKdiwHUTjMY9UPGa2kPZ/APfSpe10iLbVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQBnFCA5eBNsv5vM74S+uVA8ROFkHrqXIuoxZ+r8yW58Ms1Nlr9akct+vLSFDxe+bLmoBOctPqRPqRVgxhTPcmy26Wz2a29VzwKRZnjTqgqU1heYLvYwtRBSvtS+9yqARIkNgydsROWqknTbt6h4uoQAWXSX90e47Zlda34/lr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXXEv3t5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761556004; x=1793092004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pQWstgc/fRKdiwHUTjMY9UPGa2kPZ/APfSpe10iLbVM=;
  b=NXXEv3t5fpgU8ttfFalA2vE0rGkN+JuLx+wTI2NkfRV/f1w1rlDoF6zY
   pRgEn7oM8qiDDq/zcSXxHNLbqNSHadHm8QXzeEZKfXHvy6T9fFaye8Blu
   efHJuxiBZtwLn5NtLgXCUSCby8v9KQc46vdzJtX5rlsX0rW4HUE4HPGEy
   OhJutpEYnCzy+BZxrwinCLD+/psXGgit8baxZsLuzUDpxfyhW7P0p0mqu
   aOK7wKVkk6AtK+zvWoS19fvWeJpex35Zx4Kt2a+GhdDPkYpwDW3GaV9VZ
   XWuw052ldnNfxcWk9RBpvlXTvvy2D5AFLLWrRDdjq015PmeFZS3xwQAML
   w==;
X-CSE-ConnectionGUID: B33p2v5TQGaxKmgtI+7I6A==
X-CSE-MsgGUID: EzSyMgMeScq4ZVIl9vfiZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67465197"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="67465197"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:06:43 -0700
X-CSE-ConnectionGUID: 0UxpLtgCTWmPr4E5yr3zgQ==
X-CSE-MsgGUID: RcUtrlpmQW6S4aTfFMiVKA==
X-ExtLoop1: 1
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa003.fm.intel.com with ESMTP; 27 Oct 2025 02:06:41 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3CF1E95; Mon, 27 Oct 2025 10:06:40 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Subject: [PATCH v1 1/1] checkpatch: Don't warn on "orhapned" DT schema file
Date: Mon, 27 Oct 2025 10:06:35 +0100
Message-ID: <20251027090635.1740111-1-andriy.shevchenko@linux.intel.com>
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

Requested-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 scripts/checkpatch.pl | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6729f18e5654..818b49d314ce 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3441,11 +3441,17 @@ sub process {
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
 
+		    ($realfile =~ m@^Documentation/devicetree/bindings/.*\.txt$@)) {
+			if ($realfile =~ m@^include/asm/@) {
+
 # Check for adding new DT bindings not in schema format
 		if (!$in_commit_log &&
 		    ($line =~ /^new file mode\s*\d+\s*$/) &&
-- 
2.50.1


