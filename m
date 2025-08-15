Return-Path: <linux-kernel+bounces-770823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A9DB27F64
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE91CAE696B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BA0304961;
	Fri, 15 Aug 2025 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEiNrh4A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AA72882D9;
	Fri, 15 Aug 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257846; cv=none; b=ZMeVLwu5Cveu9BLIUzmmUI2XRoQh4uDH3F4TKqWWLtv0Mjo0t4FviOPRmFilndYWNpiIb4/XIOwgYnjCzuMDzU3dmPB6WEBhz/v5DkQ8Bq5ryh1VXIuKHCEyypA6zBxpa2yESMrUigY8zDRd/yYCHa9PZeoj0fHTKDqzo+e/z1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257846; c=relaxed/simple;
	bh=DJ6PKIVf54EN0EVhgnkCRmWpgby/c+jMwkXMtSedHKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+7kYEeCxJXyz6AC0vXdzczO75hTuKgrZ+eR1YIGNON5BIQWTIa12A1LUOYUDsMhqd4ZzSIq3wnjzjYtUHfArUxMHfHKBBCa0OAyqoQLPo5/fSDcVm5ah5ypoJ/VbRznLBPAySZJQpWarjTcZgkTusQlY30+yK8k3BdR6queJ9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEiNrh4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ABBC4CEF9;
	Fri, 15 Aug 2025 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755257846;
	bh=DJ6PKIVf54EN0EVhgnkCRmWpgby/c+jMwkXMtSedHKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oEiNrh4ABj+qWKIVW68luFPDGQLHKAgttGTwtsc72LU9xVoOhpAtbHuU9RuXk6pJA
	 qznykEih+00AH4X4jSDJ/9MfjIR+MmD+7ffPJp8Qd4HtJCQZk8r1LEAfA+/qEx7jI1
	 InDT/4NtgC9GIu4W9QaqCqgvtdOgj2D/hYe7uWRgakn274zS+PaluoMFGi5kQGLrlC
	 B1X/DCNC7G59F9KgNJF+VocT7HEPqC2MaX8Y9ovkeHq9pFQAoFPRhm012zqgfmDHdE
	 SO8hEyoAp9rwh6vU33HRjHStF3CmH3UJJY4xRo3BmyKJ51iWEw4Cl6/VD00Ke17RzV
	 EntO3ofGVxGtw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umskO-000000042T9-0CGZ;
	Fri, 15 Aug 2025 13:37:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] docs: conf.py: rename some vars at latex_documents logic
Date: Fri, 15 Aug 2025 13:36:20 +0200
Message-ID: <8105a4afe3210cd974a4e0cba9c280226a9aa63e.1755256868.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755256868.git.mchehab+huawei@kernel.org>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Currently, the logic uses fn and doc vars, but they don't
properly describe what such vars do.

Make them clearer:
	- fname: points to the file name to search (index.rst);
	- doc: contains the name of the LaTeX or PDF doc to
	  be produced.

With that, the checks for SPHINXDIRS and for subdirs will
be more coherent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index c8401ed75402..6e12c7d8e07e 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -93,31 +93,31 @@ def config_init(app, config):
 
     # When SPHINXDIRS is used, we just need to get index.rst, if it exists
     if not os.path.samefile(doctree, app.srcdir):
-        doc = "index"
-        doc_name = os.path.basename(app.srcdir)
-        if os.path.exists(os.path.join(app.srcdir, doc + ".rst")):
-            latex_documents.append((doc, doc_name + ".tex",
-                                    "Linux %s Documentation" % doc_name.capitalize(),
+        doc = os.path.basename(app.srcdir)
+        fname = "index"
+        if os.path.exists(os.path.join(app.srcdir, fname + ".rst")):
+            latex_documents.append((fname, doc + ".tex",
+                                    "Linux %s Documentation" % doc.capitalize(),
                                     "The kernel development community",
                                     "manual"))
             return
 
     # When building all docs, or when a main index.rst doesn't exist, seek
     # for it on subdirectories
-    for fn in os.listdir(app.srcdir):
-        doc = os.path.join(fn, "index")
-        if not os.path.exists(os.path.join(app.srcdir, doc + ".rst")):
+    for doc in os.listdir(app.srcdir):
+        fname = os.path.join(doc, "index")
+        if not os.path.exists(os.path.join(app.srcdir, fname + ".rst")):
             continue
 
         has = False
         for l in latex_documents:
-            if l[0] == doc:
+            if l[0] == fname:
                 has = True
                 break
 
         if not has:
-            latex_documents.append((doc, fn + ".tex",
-                                    "Linux %s Documentation" % fn.capitalize(),
+            latex_documents.append((fname, doc + ".tex",
+                                    "Linux %s Documentation" % doc.capitalize(),
                                     "The kernel development community",
                                     "manual"))
 
-- 
2.50.1


