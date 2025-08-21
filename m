Return-Path: <linux-kernel+bounces-780041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF94BB2FCAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C8F724527
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C332EDD51;
	Thu, 21 Aug 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrSDWfIf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E280A2857F7;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786100; cv=none; b=pxY7T9luwTGbR55Dna40FH2ZBuoLJ0xGsuNxU93/YK+AM01EA8fHP1XW7PIxLxv6wC/Ij7uXVzF9/npoGvdgf7+xnZvEdqCNviuh5OYvSSu9DcuNrTaEduiP1lIvaiPJr8w1gKKE1h0snzl2kJgdwnZRHAVooKV1uUEV4c3qijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786100; c=relaxed/simple;
	bh=LQfriqJ7w45m1TsmRVR1XR73bImTQyUEqk93YtSCuzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8XPqzh21EX9QPpYlZyiZlxpYyuzZHupActfJPI91rWqVmRvNvmx9KZw963CgTIntYYM39wQgXSBJir931XKFhvsZ/dXNTuDG0fTTANoP7D64IdrWkqGO0DYKyvUdkSvoCa0OinYASPHlvG91XB3x0Pv+cwJsBdyuOjIn8BIykE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrSDWfIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D934C2BCF5;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=LQfriqJ7w45m1TsmRVR1XR73bImTQyUEqk93YtSCuzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HrSDWfIf7ufCni7PxZ62/b7X3KzBuHr3HM03lebFs6XM9xW98cOU+TplnNkMgCi1d
	 kyx2B39dd6dIqq/LaBPX0pf9c+whwhkjz/BugfmXqYA7v9gk+3Q1FWeTSswzBWgLO7
	 gkcZgyanlORJ1W5VX7ZVZyCU6dLvYThv9wGu3wfh8J3yFxe3/MfwuBHry8dZBRFJ9k
	 eptdpIda1A7cMJY76XXOSfGp3Y93DzPdVvrPORrhrozdSmz3LELXVhrYDceuUUOyDz
	 JGzLZWMNW/Qvabcl32hLlsBLaAvHR2kReC5OjOMOTK5UnGmOvGU7Bg4+/UBPsEz8Cf
	 Bq3UlqEqMT2TQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT9M-2DIg;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 21/24] docs: kernel_include.py: remove Include class inheritance
Date: Thu, 21 Aug 2025 16:21:27 +0200
Message-ID: <69206f9a5709c39591be515397fde851658eedc0.1755784930.git.mchehab+huawei@kernel.org>
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


