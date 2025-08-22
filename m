Return-Path: <linux-kernel+bounces-782142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3A0B31BAC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133F71D072C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C555312817;
	Fri, 22 Aug 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVDoFaa1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD23126C2;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872389; cv=none; b=D6D5jEZ1rUxhaprfokIhexTbr7azR6OTvzV9zF6RV6XkOb2zoF7DonV+BNzir6pAsyRFBDa8PdMELEkK2peShwqB7ZgXpGw7/r3bFeFpaTQ6n7K2HnS7kaMTHi9M7xSPsZvAGlBRd5dNRYcDRtSgxnkKSd5Up7prNj/V3zjk7aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872389; c=relaxed/simple;
	bh=LbPxF3kGKvZLO+UE6KiArHqAGzi0BSWTiNNAdqSOJS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xw6+zId8Lcj9b0VGX7qaptNXiApxT1ziem6y+CITVypOUtLhOMRjzUUIBprOLLT0tM2/RC3lPSSUNsxvS9dl7u5Ku1FVDTwqV8+EMP1zjZGxU+DHRRZkrDd/HhmCvKHFvZ/96Ulw6CLbTkH0fwjS3d8G1oLtry9hS3hjHGs0y0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVDoFaa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5A5C2BD00;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=LbPxF3kGKvZLO+UE6KiArHqAGzi0BSWTiNNAdqSOJS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVDoFaa1Qv0iEfJuNlXujfu/uy8r4fTD8UGniLApJSl/Y8DJ2uQY20tUG/7ZSpnVw
	 Sz0NaaL4psw2UZ5vs8BBV7tlx0zeYBu3N/n3bPZbkLAk84WZBRsIimfrMGzTholxoh
	 9pMKVqr28VeNtuOyQEjXchF0/Bzh5ZVVat5jnKGPwwYOuqJTdkRrEGFpAfQLBuKjY7
	 y+S53LC/0JbVh/xjJRmEtLylNr6yaWy8oSMe/2LLhlUTzIvrTLywNegT9euyPGp0lN
	 BsT1KX27vTSsb7ZUGIwuDeQqEX59lD2UvNWzONOyforSncG8lbhmViC/HgvDxjAHRk
	 cm0td/GkcHT3w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCsJ-2s9a;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/24] docs: kernel_include.py: document all supported parameters
Date: Fri, 22 Aug 2025 16:19:34 +0200
Message-ID: <f193160889a2dc296b4df2cc7ebc9934d717ccef.1755872208.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755872208.git.mchehab+huawei@kernel.org>
References: <cover.1755872208.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As we're actually a fork of Sphinx Include, update its
docstring to contain the documentation for the actual
implemented parameters.

Let's use :param: for parameters, as defined at:
https://sphinx-rtd-tutorial.readthedocs.io/en/latest/docstrings.html

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 88 +++++++++++++++++---------
 1 file changed, 58 insertions(+), 30 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index e6f734476ab3..23566ab74866 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -2,53 +2,81 @@
 # SPDX-License-Identifier: GPL-2.0
 # pylint: disable=R0903, R0912, R0914, R0915, C0209,W0707
 
+
 """
-    kernel-include
-    ~~~~~~~~~~~~~~
+Implementation of the ``kernel-include`` reST-directive.
 
-    Implementation of the ``kernel-include`` reST-directive.
+:copyright:  Copyright (C) 2016  Markus Heiser
+:license:    GPL Version 2, June 1991 see linux/COPYING for details.
 
-    :copyright:  Copyright (C) 2016  Markus Heiser
-    :license:    GPL Version 2, June 1991 see linux/COPYING for details.
+The ``kernel-include`` reST-directive is a replacement for the ``include``
+directive. The ``kernel-include`` directive expand environment variables in
+the path name and allows to include files from arbitrary locations.
 
-    The ``kernel-include`` reST-directive is a replacement for the ``include``
-    directive. The ``kernel-include`` directive expand environment variables in
-    the path name and allows to include files from arbitrary locations.
+.. hint::
 
-    .. hint::
+    Including files from arbitrary locations (e.g. from ``/etc``) is a
+    security risk for builders. This is why the ``include`` directive from
+    docutils *prohibit* pathnames pointing to locations *above* the filesystem
+    tree where the reST document with the include directive is placed.
 
-      Including files from arbitrary locations (e.g. from ``/etc``) is a
-      security risk for builders. This is why the ``include`` directive from
-      docutils *prohibit* pathnames pointing to locations *above* the filesystem
-      tree where the reST document with the include directive is placed.
+Substrings of the form $name or ${name} are replaced by the value of
+environment variable name. Malformed variable names and references to
+non-existing variables are left unchanged.
 
-    Substrings of the form $name or ${name} are replaced by the value of
-    environment variable name. Malformed variable names and references to
-    non-existing variables are left unchanged.
+**Supported Sphinx Include Options**:
 
-    This extension overrides Sphinx include directory, adding some extra
-    arguments:
+:param literal:
+    If present, the included file is inserted as a literal block.
 
-    1. :generate-cross-refs:
+:param code:
+    Specify the language for syntax highlighting (e.g., 'c', 'python').
 
-        If present, instead of reading the file, it calls ParseDataStructs()
-        class, which converts C data structures into cross-references to
-        be linked to ReST files containing a more comprehensive documentation;
+:param encoding:
+    Specify the encoding of the included file (default: 'utf-8').
 
-    2. :exception-file:
+:param tab-width:
+    Specify the number of spaces that a tab represents.
 
-        Used together with :generate-cross-refs
+:param start-line:
+    Line number at which to start including the file (1-based).
 
-        Points to a file containing rules to ignore C data structs or to
-        use a different reference name, optionally using a different
-        reference type.
+:param end-line:
+    Line number at which to stop including the file (inclusive).
 
-    3. :warn-broken:
+:param start-after:
+    Include lines after the first line matching this text.
 
-        Used together with :generate-cross-refs:
+:param end-before:
+    Include lines before the first line matching this text.
 
-        Detect if the auto-generated cross references doesn't exist.
+:param number-lines:
+    Number the included lines (integer specifies start number).
+    Only effective with 'literal' or 'code' options.
 
+:param class:
+    Specify HTML class attribute for the included content.
+
+**Kernel-specific Extensions**:
+
+:param generate-cross-refs:
+    If present, instead of directly including the file, it calls
+    ParseDataStructs() to convert C data structures into cross-references
+    that link to comprehensive documentation in other ReST files.
+
+:param exception-file:
+    (Used with generate-cross-refs)
+
+    Path to a file containing rules for handling special cases:
+    - Ignore specific C data structures
+    - Use alternative reference names
+    - Specify different reference types
+
+:param warn-broken:
+    (Used with generate-cross-refs)
+
+    Enables warnings when auto-generated cross-references don't point to
+    existing documentation targets.
 """
 
 # ==============================================================================
-- 
2.50.1


