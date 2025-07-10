Return-Path: <linux-kernel+bounces-726633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D1AB00FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4338A1CA47B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9602BEFF3;
	Thu, 10 Jul 2025 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Hw0MpmB/"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAD91FBEA2;
	Thu, 10 Jul 2025 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190315; cv=none; b=OIgytWAgLKLcQWU8gwUc0L4x5MBmHCIRaWEVv1ZjTJZqPGQHA3cd5CeJvvtG8EDJcYpGyKxaU7VASugIifAFXywoKi2S4Y8iLt9dBrdiJLkQnaQG2Jq+NWxvzSR4xK4Eyz9yc+jtxvnFOMS8uI7A48LfmkFqyBqvnjvf0POk3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190315; c=relaxed/simple;
	bh=Q1YUx91y5nYhB6VU82yWweGV/eOwFVOIzRSUEm0+ueg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CglwmeARPF4g6goISVjow/6lE0QHQG5d+Ap5/58XScrv34RHYu7WJiJS51w3Owjw1vwpS4RVv634jQOBLbf/q36W84jFU6vNi5joAKcvw/lmtKfqrfp+fVyxkatgdQMofQLdVc3WEdc82a+RA/yWS8v6gFhWUtZhyt8n45WFOhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Hw0MpmB/; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E676440AB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752190313; bh=VuniN21Y4B6Zp1MwsGk1HnxqjkJQcalXLlnY4fhQ904=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hw0MpmB/GDbJLWi4oV3ClSutTbd6LnqynpkzcPYLUOTE5kGD1AAlHvI+jtOK/pCgQ
	 To6ojT9hCC6WdZ7Ot684rrHMf7gPk3zGTOqnkokxpyZId+Yd5eAhBbN4oQN6O2QbY5
	 Y+Fvs91RdfLx7wTKgXOZLNHOw2L36UldVfzjr4yfxnydq7tbqnq5Py+7WDU7on5Nl3
	 kWMySkXC+KylFoHTeJJC6dHY4qvqmDB6TOk0VK2BdyUpgk/etzY639iXSJhycLWIEL
	 J5q1/QQWr31FIPVKS01QZCAe/Oz/ngV40gTc+uveRYvJB4sueY639wBsZrmSKWczAT
	 ZE+6GESuOiL0A==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id E676440AB5;
	Thu, 10 Jul 2025 23:31:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 01/12] docs: kdoc; Add a rudimentary class to represent output items
Date: Thu, 10 Jul 2025 17:31:31 -0600
Message-ID: <20250710233142.246524-2-corbet@lwn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710233142.246524-1-corbet@lwn.net>
References: <20250710233142.246524-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This class is intended to replace the unstructured dict used to accumulate
an entry to pass to an output module.  For now, it remains unstructured,
but it works well enough that the output classes don't notice the
difference.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_item.py   | 26 ++++++++++++++++++++++++++
 scripts/lib/kdoc/kdoc_parser.py | 30 +++++++++---------------------
 2 files changed, 35 insertions(+), 21 deletions(-)
 create mode 100644 scripts/lib/kdoc/kdoc_item.py

diff --git a/scripts/lib/kdoc/kdoc_item.py b/scripts/lib/kdoc/kdoc_item.py
new file mode 100644
index 000000000000..add2cc772fec
--- /dev/null
+++ b/scripts/lib/kdoc/kdoc_item.py
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# A class that will, eventually, encapsulate all of the parsed data that we
+# then pass into the output modules.
+#
+
+class KdocItem:
+    def __init__(self, name, type, start_line, **other_stuff):
+        self.name = name
+        self.type = type
+        self.declaration_start_line = start_line
+        #
+        # Just save everything else into our own dict so that the output
+        # side can grab it directly as before.  As we move things into more
+        # structured data, this will, hopefully, fade away.
+        #
+        self.other_stuff = other_stuff
+
+    def get(self, key, default = None):
+        ret = self.other_stuff.get(key, default)
+        if ret == default:
+            return self.__dict__.get(key, default)
+        return ret
+
+    def __getitem__(self, key):
+        return self.get(key)
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 831f061f61b8..a5a59b97a444 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -16,7 +16,7 @@ import re
 from pprint import pformat
 
 from kdoc_re import NestedMatch, KernRe
-
+from kdoc_item import KdocItem
 
 #
 # Regular expressions used to parse kernel-doc markups at KernelDoc class.
@@ -271,32 +271,20 @@ class KernelDoc:
         The actual output and output filters will be handled elsewhere
         """
 
-        # The implementation here is different than the original kernel-doc:
-        # instead of checking for output filters or actually output anything,
-        # it just stores the declaration content at self.entries, as the
-        # output will happen on a separate class.
-        #
-        # For now, we're keeping the same name of the function just to make
-        # easier to compare the source code of both scripts
-
-        args["declaration_start_line"] = self.entry.declaration_start_line
-        args["type"] = dtype
-        args["warnings"] = self.entry.warnings
-
-        # TODO: use colletions.OrderedDict to remove sectionlist
+        item = KdocItem(name, dtype, self.entry.declaration_start_line, **args)
+        item.warnings = self.entry.warnings
 
-        sections = args.get('sections', {})
-        sectionlist = args.get('sectionlist', [])
+        sections = item.get('sections', {})
+        sectionlist = item.get('sectionlist', [])
 
         # Drop empty sections
         # TODO: improve empty sections logic to emit warnings
         for section in ["Description", "Return"]:
-            if section in sectionlist:
-                if not sections[section].rstrip():
-                    del sections[section]
-                    sectionlist.remove(section)
+            if section in sectionlist and not sections[section].rstrip():
+                del sections[section]
+                sectionlist.remove(section)
 
-        self.entries.append((name, args))
+        self.entries.append((name, item))
 
         self.config.log.debug("Output: %s:%s = %s", dtype, name, pformat(args))
 
-- 
2.49.0


