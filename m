Return-Path: <linux-kernel+bounces-779267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C58B2F16E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDF5AA47ED
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760182ECD1B;
	Thu, 21 Aug 2025 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXP4dk7v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ECC2EB84E;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764224; cv=none; b=V5E16plZKsl4zjIs7MEgnx+psP0puvO6Y4hsnJIAbcDpI1m1ZffpnHYzBPy19R2mIaixfrYpY8FVX/oYcc3mlSAn8VDzyCIGolbClSZwn+fF8L59J4vUpDhwBUYDPyAeOmdIxsAsih0Ho0wFUQ3N206g8NgdW6ZMTACMuuRWGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764224; c=relaxed/simple;
	bh=DJ6PKIVf54EN0EVhgnkCRmWpgby/c+jMwkXMtSedHKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2/R9ZyZ3NxK9atLNVPg9DOXgO7HAKJByxgDeM00vj1dY/1OeW3kYgs0W8VI+OzhSlS4QJeFeOCTo7muxuHVXvAhCDd+Xxh5ssS4yw8Pu3naJJtNFT5aZvurv1O2v9DdVt+lGaRAFyAu8vHwpA8mIwgJVviwh9RwuZw3GVlvcqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXP4dk7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA7EC4CEF4;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764224;
	bh=DJ6PKIVf54EN0EVhgnkCRmWpgby/c+jMwkXMtSedHKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXP4dk7vOyNbAGBj56xDMTrj/2AnzQpjmSjN2X/Wzb+e0n19WhwNGd0R+GE4wBhq6
	 5Gp3IWbT3vRoRTp+9rp3T38xSepxkr+RjBmsLu2lJvgn0H+pu9kQW1RXBKMUR7JQaN
	 OZNJf9thUOkJQUmyBTsIg0Jy8cELG8N+O073ywwerHNxtlkn5b+dUHxFulEkaVVUYz
	 OVubCFrx0OVqC61nDSJB3iBo+QIscgJqFRUxqnGqUGoG10CfZNNvkcuqfcjBmbN2gK
	 AOX+SnqkBrBZ418eKK/3Jsc8gzWgS8UonZhASRHeu+87PDeKMIlvWRB+GQ7QwFvU8k
	 Li2qiqAqBnmdg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up0Tm-0000000BLgH-2k4h;
	Thu, 21 Aug 2025 10:17:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/14] docs: conf.py: rename some vars at latex_documents logic
Date: Thu, 21 Aug 2025 10:16:40 +0200
Message-ID: <b030d9bc53550905adbe9367b2a3915d7331b4c5.1755763127.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755763127.git.mchehab+huawei@kernel.org>
References: <cover.1755763127.git.mchehab+huawei@kernel.org>
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


