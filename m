Return-Path: <linux-kernel+bounces-871202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49514C0CA08
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77D13A6E8C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E322E7BB4;
	Mon, 27 Oct 2025 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/XiaqOq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977382E7F11
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556669; cv=none; b=savePoPs2yt4MJQsPlTNz7RqG88A2xaZtUBBJCgXtAtTQsPOir3vS8ufqmJ7JvcBpqo5X6Bf0aCXjF5Bqyak7ndJzPsXch/Ti18CI1BBwqDYcUVE8RcqJ/g+Q3y/51loD1h8EB06S/2j8Spjb1zf+GV3hfEIS2Qo9AnITfLbot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556669; c=relaxed/simple;
	bh=VCNUVKbAdb2+h7EleaRRC4KU1wzGu293L+c3xLH8YPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhTkSbgx/M4Jw3CMPLhYPAaGgu5QhPELX6IGCovkcDIx3gij7woETQmOR7LMvYWOx95dAxxq+Oq8NhNibVe46JSs5FMrqYN/HWDfUZXkEFXBZZDP9SYRQ/7Y14bUheLUgt7VR/Z3lXdPJbP5XXL7Ao2vlvflfJDCwDhoYbp6mg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/XiaqOq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761556667; x=1793092667;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VCNUVKbAdb2+h7EleaRRC4KU1wzGu293L+c3xLH8YPU=;
  b=T/XiaqOqJ5V5kJcUPdi5EM4EUaH6xE2b++EoKpK1mZhUKdBrZcjn5lb1
   lbpItCR2HPgRXE+stqiYWd/4Qjx2Nab6MdlJJ1mkOwZX5AtJ1jY5QQwqs
   MSa3LPggrY4HiUQe6IsjDRS0ag6bYDvv6Mv2EGcFrFDJu2Ia6DnVjWsJA
   tkxDxJX8Wty0WqNNeYNfSt8PoTKPdH+qgIBccYX+29KmadQsY+43DyGyH
   4ZUL5yMP9B+xJYVCjI36ZxPYy0B0M6GCHeZUa+J3obnrXCzth6OKdCzge
   uXB1IvZZeNPaqtxJ3lih6+NUSLeN78LjnC+jcA1jfvvheN7H2z+4CqdUB
   w==;
X-CSE-ConnectionGUID: aFyMU2UgTvaN+dWttL5otA==
X-CSE-MsgGUID: /0Oavld3TZKHOR8AuWzc8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74974978"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="74974978"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:17:47 -0700
X-CSE-ConnectionGUID: XfB2QgpiT4WXIfHWXmb8/w==
X-CSE-MsgGUID: 1TYKMS33SmeZw9Q/PXTimg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184612046"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 27 Oct 2025 02:17:44 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 3E04D95; Mon, 27 Oct 2025 10:17:44 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Subject: [PATCH v2 1/1] checkpatch: Don't warn on "orhapned" DT schema file
Date: Mon, 27 Oct 2025 10:17:24 +0100
Message-ID: <20251027091742.1741742-1-andriy.shevchenko@linux.intel.com>
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

v2: drop some leftovers

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


