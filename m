Return-Path: <linux-kernel+bounces-782140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B87EB31BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A471C272E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F302E341AA6;
	Fri, 22 Aug 2025 14:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us9Gpwf9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEAE3126B7;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=cy566oj0EOVUNA+hq+Pp6bQjXm4OvVR/0scoKTrCFYVjlfD06EolNpLP98hdjYLZSzJyTPaM+iMz1pWgEWXt8JMYfXM3c4OHntzdaIrbouEsVOoJfkUly3y9b731ASuY68mZ4Vt6H1lQEjxFphxJ4A+EYyL7QxIJCQsELzvnhVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=LQfriqJ7w45m1TsmRVR1XR73bImTQyUEqk93YtSCuzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AahTBolZ4UI8WHap5/MO3ulpbY7vwMhHQYfAGbFJBG/8YpnLpVD6GA9sfZKfID4PkKCk1GmvZRQXkGJwEmflKUxxHoK1gbltev9smLjkAzBEMG6GT09T306XnGljw7B0Gex2fy4y/OsG+gaDqctbyYH1HqGqga2NBdwGmmjknWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us9Gpwf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6833FC2BCFD;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=LQfriqJ7w45m1TsmRVR1XR73bImTQyUEqk93YtSCuzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=us9Gpwf99h+qvYS/a+8T+1/mfs4B3xHFRUUQWYt2QgV1GiRQInibaRyMEGkKnlE/h
	 FU338kCo1P6ySBNunbIfM7vpS/w50qpMq8ljjjRcfhogHMSVBf8r/3irGEnT0b3o8Z
	 w1khWMvS7D4upMsD7P4Ls2JWNc14cgItnvE0AmeqpkAbQltjFzf8WxNV0G94XfCwCA
	 6wgNNybY1/yaD3qQuLpIBcwWWVJ7W3Y34L7hQ9vun9VS5OHA5nhQGCmMZ1yX2xOVQJ
	 dVYe+xPExniLau5uJDFAEqKIsmv/kJDlD9foII7bZa4k8IwrHfZvBkERAxwkLDDpAS
	 sG3ncmpLAHKmw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCsF-2lMI;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/24] docs: kernel_include.py: remove Include class inheritance
Date: Fri, 22 Aug 2025 16:19:33 +0200
Message-ID: <a9f2eebf11c6b0c3a2e3bf42e71392cdfd2835d1.1755872208.git.mchehab+huawei@kernel.org>
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

While the original code came from the Sphinx Include class,
such class is monolithic: it has only one function that does
everything, and 3 variables that are used:

	- required_arguments
	- optional_arguments
	- option_spec

So, basically those are the only members that remain from
the original class, but hey! Those are the same vars that every
other Sphinx directive extension has to define!

In summary, keeping inheritance here doesn't make much sense.

Worse than that, kernel-include doesn't support the current set
of options that the original Include class has, but it also
has its own set of options.

So, let's fill in the argument vars with what it does
support, dropping the rest.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 40 ++++++++++++++++++++------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index 3a1753486319..e6f734476ab3 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -62,9 +62,8 @@ import sys
 from docutils import io, nodes, statemachine
 from docutils.statemachine import ViewList
 from docutils.utils.error_reporting import SafeString, ErrorString
-from docutils.parsers.rst import directives
+from docutils.parsers.rst import Directive, directives
 from docutils.parsers.rst.directives.body import CodeBlock, NumberLines
-from docutils.parsers.rst.directives.misc import Include
 
 from sphinx.util import logging
 
@@ -81,18 +80,43 @@ RE_SIMPLE_REF = re.compile(r'`([^`]+)`')
 
 
 # ==============================================================================
-class KernelInclude(Include):
-    """KernelInclude (``kernel-include``) directive"""
+class KernelInclude(Directive):
+    """
+    KernelInclude (``kernel-include``) directive
 
-    # Add extra options
-    option_spec = Include.option_spec.copy()
+    Most of the stuff here came from Include directive defined at:
+        docutils/parsers/rst/directives/misc.py
 
-    option_spec.update({
+    Yet, overriding the class don't has any benefits: the original class
+    only have run() and argument list. Not all of them are implemented,
+    when checked against latest Sphinx version, as with time more arguments
+    were added.
+
+    So, keep its own list of supported arguments
+    """
+
+    required_arguments = 1
+    optional_arguments = 0
+    final_argument_whitespace = True
+    option_spec = {
+        'literal': directives.flag,
+        'code': directives.unchanged,
+        'encoding': directives.encoding,
+        'tab-width': int,
+        'start-line': int,
+        'end-line': int,
+        'start-after': directives.unchanged_required,
+        'end-before': directives.unchanged_required,
+        # ignored except for 'literal' or 'code':
+        'number-lines': directives.unchanged,  # integer or None
+        'class': directives.class_option,
+
+        # Arguments that aren't from Sphinx Include directive
         'generate-cross-refs': directives.flag,
         'warn-broken': directives.flag,
         'toc': directives.flag,
         'exception-file': directives.unchanged,
-    })
+    }
 
     def read_rawtext(self, path, encoding):
             """Read and process file content with error handling"""
-- 
2.50.1


