Return-Path: <linux-kernel+bounces-780036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE28B2FCCC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BBDE6400C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B402E7F09;
	Thu, 21 Aug 2025 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb53XVar"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CCB28505A;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786099; cv=none; b=PLma+dfdsW0I+FS31gyBAoXfCazmLJ/0zhQmXbDalqoQ/UAeBYKbakL3QncMPDyGhAZfmpfDzVCTeHNk9btM/LvKxLg0U/M3vXcgx10BNzUMIHeMJAzdR39bvfO0hwqpehei7tNHNlS7sHTt3SN0t3waeDxEjHvNdasERRvwzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786099; c=relaxed/simple;
	bh=LbPxF3kGKvZLO+UE6KiArHqAGzi0BSWTiNNAdqSOJS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFqiXuD6jYfKxth6luaYGSQHx7kJz7X1gaW5WKAaJj02nOswNO/9ENPGSzbL8vc+lcywj4lybmr0Cv3S7ReoaxnWhF9gxQIaYNbIrGP6QixkfP5n2Dk1jgvk1/X3V2UEC2XnlsIiribBiCoOfop8mLnos2zI9w//wm6xIHjoytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb53XVar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4FDC2BCC7;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=LbPxF3kGKvZLO+UE6KiArHqAGzi0BSWTiNNAdqSOJS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fb53XVar4QcXj4ZqCEwqyRSFWaW6oNAes6/hAsfIcE/O0nvOYDjoBkRkmrF3bFrAk
	 ZLnSl0IxtpE+IBFG7usy81JmKgKh/WxzsNprAaBzAa0kxzmw9Z5AX6F4otQvch/1vM
	 cHlhLEX3zetONcuvTdbNVo7ID0eflU9vGvZNEBNHdsm9KbDbD4g92Hk0SvHtk3nLWw
	 eOsfzTFmvZ8Vu+3j/f6BUTQjuWXOZ2poEjFc6R6odv98EGZ+1Sy9xwwgg4bR4uHj8z
	 PeG8gaLUrPLQhCWXmltDoauEfZR/EX9M/a4EdpJDk30CjjvVC5YQ6OAlywOmry/l9B
	 QjcvpzWHCC4dw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT9Q-2JzK;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 22/24] docs: kernel_include.py: document all supported parameters
Date: Thu, 21 Aug 2025 16:21:28 +0200
Message-ID: <2bbd518941dd4cae29b3a6f86c6afae711347266.1755784930.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755784929.git.mchehab+huawei@kernel.org>
References: <cover.1755784929.git.mchehab+huawei@kernel.org>
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


