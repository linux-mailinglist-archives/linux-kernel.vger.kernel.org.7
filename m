Return-Path: <linux-kernel+bounces-767441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 491B4B2543E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A8EC1C841C3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7832FC257;
	Wed, 13 Aug 2025 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCAuey5o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7661D2FC246;
	Wed, 13 Aug 2025 20:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115548; cv=none; b=l277/8Na8Vg6k1XnjgBRIvJm0Xn0EUMWvGDP7WJTgQzLwkq5qAb/xdhwesgTtNGiO54VMGT1WCSaH/JwrY9K3GhJLIt5QGlZbwRAkQlAFcR5jFzUvJssSh7wjUE0fZn0oLS9yVctRO+eY44aUZ2PgkI+Xf9gb2vYmgWUVrwt9zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115548; c=relaxed/simple;
	bh=uEVHABxCEiwnU8tKBBUUCtzmMs27UN1iNxCxhXGvkX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hjs/i9nl3hpofH3zeslFnfB2jRGcvzYYGYVj9QoJxdmJlEWrh0UoHykZDe4Pfg/XFcjpgmYXpzn7mQ6OJMtIvqS8Sti/OaPe80JKXqtwf1FezVZTPb23rFLoBnwO1yC6LCKDZU1cSgb64P9rw+8kI6NQOZvU6Zr7GpEniGvFZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCAuey5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353CCC4CEEB;
	Wed, 13 Aug 2025 20:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755115548;
	bh=uEVHABxCEiwnU8tKBBUUCtzmMs27UN1iNxCxhXGvkX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCAuey5oCRhCMDMl2n8nIh6VPRzusNZDSWVTXM3cY+OTdoyZA6y1w/XA8rzVWirzY
	 VvG5FJesxMkleKNE5va1GuCLzduSS8OBMKIMuMdJwegC/4AmxNts55vZsWdI8sq7T8
	 K6V6B/VL5K1nUGw1MLB+BdzOuDoxz5xTzMYR/sT402hYyMNTrddK7jsbmtDz5UKFC5
	 ZE3KMYFQ0NNucPju21kr1lqwwMPyePvS8OloDV/5w2efluJYQJ43pOlYFUMzrVw2hV
	 2podSCpJpM1WePWAdyjx15xktLmoO9bvGCjRAp801KhtN6dPLRwt2/SfP4QIRrX43S
	 xlWjrJEtFyN3Q==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 8/9] Documentation: Fix trace typos
Date: Wed, 13 Aug 2025 15:05:04 -0500
Message-ID: <20250813200526.290420-9-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813200526.290420-1-helgaas@kernel.org>
References: <20250813200526.290420-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/trace/fprobe.rst      |  2 +-
 Documentation/trace/ftrace-uses.rst |  2 +-
 Documentation/trace/ftrace.rst      | 14 +++++++-------
 Documentation/trace/histogram.rst   |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/trace/fprobe.rst b/Documentation/trace/fprobe.rst
index 71cd40472d36..06b0edad0179 100644
--- a/Documentation/trace/fprobe.rst
+++ b/Documentation/trace/fprobe.rst
@@ -81,7 +81,7 @@ Same as ftrace, the registered callbacks will start being called some time
 after the register_fprobe() is called and before it returns. See
 :file:`Documentation/trace/ftrace.rst`.
 
-Also, the unregister_fprobe() will guarantee that the both enter and exit
+Also, the unregister_fprobe() will guarantee that both enter and exit
 handlers are no longer being called by functions after unregister_fprobe()
 returns as same as unregister_ftrace_function().
 
diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
index e198854ace79..e225cc46b71e 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -193,7 +193,7 @@ FTRACE_OPS_FL_RECURSION
 	Note, if this flag is set, then the callback will always be called
 	with preemption disabled. If it is not set, then it is possible
 	(but not guaranteed) that the callback will be called in
-	preemptable context.
+	preemptible context.
 
 FTRACE_OPS_FL_IPMODIFY
 	Requires FTRACE_OPS_FL_SAVE_REGS set. If the callback is to "hijack"
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index af66a05e18cc..aef674df3afd 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -30,7 +30,7 @@ disabled and enabled, as well as for preemption and from a time
 a task is woken to the task is actually scheduled in.
 
 One of the most common uses of ftrace is the event tracing.
-Throughout the kernel is hundreds of static event points that
+Throughout the kernel are hundreds of static event points that
 can be enabled via the tracefs file system to see what is
 going on in certain parts of the kernel.
 
@@ -383,7 +383,7 @@ of ftrace. Here is a list of some of the key files:
 	not be listed in this count.
 
 	If the callback registered to be traced by a function with
-	the "save regs" attribute (thus even more overhead), a 'R'
+	the "save regs" attribute (thus even more overhead), an 'R'
 	will be displayed on the same line as the function that
 	is returning registers.
 
@@ -392,7 +392,7 @@ of ftrace. Here is a list of some of the key files:
 	an 'I' will be displayed on the same line as the function that
 	can be overridden.
 
-	If a non ftrace trampoline is attached (BPF) a 'D' will be displayed.
+	If a non-ftrace trampoline is attached (BPF) a 'D' will be displayed.
 	Note, normal ftrace trampolines can also be attached, but only one
 	"direct" trampoline can be attached to a given function at a time.
 
@@ -402,7 +402,7 @@ of ftrace. Here is a list of some of the key files:
 
 	If a function had either the "ip modify" or a "direct" call attached to
 	it in the past, a 'M' will be shown. This flag is never cleared. It is
-	used to know if a function was every modified by the ftrace infrastructure,
+	used to know if a function was ever modified by the ftrace infrastructure,
 	and can be used for debugging.
 
 	If the architecture supports it, it will also show what callback
@@ -418,7 +418,7 @@ of ftrace. Here is a list of some of the key files:
 
 	This file contains all the functions that ever had a function callback
 	to it via the ftrace infrastructure. It has the same format as
-	enabled_functions but shows all functions that have every been
+	enabled_functions but shows all functions that have ever been
 	traced.
 
 	To see any function that has every been modified by "ip modify" or a
@@ -517,7 +517,7 @@ of ftrace. Here is a list of some of the key files:
 	Whenever an event is recorded into the ring buffer, a
 	"timestamp" is added. This stamp comes from a specified
 	clock. By default, ftrace uses the "local" clock. This
-	clock is very fast and strictly per cpu, but on some
+	clock is very fast and strictly per CPU, but on some
 	systems it may not be monotonic with respect to other
 	CPUs. In other words, the local clocks may not be in sync
 	with local clocks on other CPUs.
@@ -868,7 +868,7 @@ Here is the list of current tracers that may be configured.
 
   "mmiotrace"
 
-	A special tracer that is used to trace binary module.
+	A special tracer that is used to trace binary modules.
 	It will trace all the calls that a module makes to the
 	hardware. Everything it writes and reads from the I/O
 	as well.
diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
index 2b98c1720a54..af6d2e15568e 100644
--- a/Documentation/trace/histogram.rst
+++ b/Documentation/trace/histogram.rst
@@ -840,7 +840,7 @@ Extended error information
 
   The compound key examples used a key and a sum value (hitcount) to
   sort the output, but we can just as easily use two keys instead.
-  Here's an example where we use a compound key composed of the the
+  Here's an example where we use a compound key composed of the
   common_pid and size event fields.  Sorting with pid as the primary
   key and 'size' as the secondary key allows us to display an
   ordered summary of the recvfrom sizes, with counts, received by
-- 
2.43.0


