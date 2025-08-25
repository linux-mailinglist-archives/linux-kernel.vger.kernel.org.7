Return-Path: <linux-kernel+bounces-785200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6CEB34770
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD16F20067A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C924A3054EB;
	Mon, 25 Aug 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tog2T2DC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25EC301022;
	Mon, 25 Aug 2025 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756139449; cv=none; b=Ehca0RkIhLixVHZxMibaOY99lpd/S4MLexoDj6vXgTNz4+qL1NrNN1Gqj4crymdeD0OHPIfPZrnULf8q6cJcd93Gyo8NNtV3IoE/K9D6z4GtXcTdxv+HF+rGfbBFYrbQcws8lQMGEZSO3mGL7PywpIh3yXdWsFbIMAO2p/FCgDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756139449; c=relaxed/simple;
	bh=RnTLGaGUuMOKF6PxxwxnFcuRL48slw9WnQakpfhYXJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyRkYVLmlwmaTwEfJVDqPu47w812Zvzxx3Eh88V4E3DQRaVkWmObHbVGu++7DP8PUqSXeKw+4RsrVsQ8kaPAyf2pW5Oe6ecGY2qJZ5YJLtmN6wKxwr4qNuIZyY9EkD4XkMHcM2oNNLeaAazegRJzzRgnlVTFckw5DQNKWXC7y10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tog2T2DC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21298C4AF09;
	Mon, 25 Aug 2025 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756139449;
	bh=RnTLGaGUuMOKF6PxxwxnFcuRL48slw9WnQakpfhYXJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tog2T2DCPTUzPCA6keEz8S/Ws08qqip3oSC6KGuspdbXsk1zuj5DmVn9DKY3KDIE8
	 nX5IFtnwYczokEmZv7vprKz6xh6f8+uFq7VG/7wpmkvrsNDtZD4e7Niw/7/IUW4ONb
	 5fvd3CFgDGBOheyCOkSWOIXfvq80FSRkGqP5fdvfpVcaX4+LNSESLdY6BsR8Vv//gQ
	 BEsgqdo7F1rdIIBeelHLVWjBOH+CHI/06lSAr2XYJV0tmrvwNm4Pdy3QO0GRg7KmZN
	 9lCiZX1uQgIVJ8JN+vlZnXt6srAiczXydoyygzedzW5PaVkr6zo5NZplySc5aZfphc
	 RXGBRMzj25xiQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uqa5n-0000000HALM-0oLk;
	Mon, 25 Aug 2025 18:30:47 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/13] scripts/jobserver-exec: move its class to the lib directory
Date: Mon, 25 Aug 2025 18:30:29 +0200
Message-ID: <275aff71243dcaf7fe07ec239c89ed9a8f529a34.1756138805.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756138805.git.mchehab+huawei@kernel.org>
References: <cover.1756138805.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

To make it easier to be re-used, move the JobserverExec class
to the library directory.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/jobserver-exec   | 152 +++------------------------------------
 scripts/lib/jobserver.py | 149 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 160 insertions(+), 141 deletions(-)
 create mode 100755 scripts/lib/jobserver.py

diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec
index b386b1a845de..40a0f0058733 100755
--- a/scripts/jobserver-exec
+++ b/scripts/jobserver-exec
@@ -1,155 +1,25 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0+
-#
-# pylint: disable=C0103,C0209
-#
-# This determines how many parallel tasks "make" is expecting, as it is
-# not exposed via an special variables, reserves them all, runs a subprocess
-# with PARALLELISM environment variable set, and releases the jobs back again.
-#
-# https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
 
-"""
-Interacts with the POSIX jobserver during the Kernel build time.
-
-A "normal" jobserver task, like the one initiated by a make subrocess would do:
-
-    - open read/write file descriptors to communicate with the job server;
-    - ask for one slot by calling:
-        claim = os.read(reader, 1)
-    - when the job finshes, call:
-        os.write(writer, b"+")  # os.write(writer, claim)
-
-Here, the goal is different: This script aims to get the remaining number
-of slots available, using all of them to run a command which handle tasks in
-parallel. To to that, it has a loop that ends only after there are no
-slots left. It then increments the number by one, in order to allow a
-call equivalent to make -j$((claim+1)), e.g. having a parent make creating
-$claim child to do the actual work.
-
-The end goal here is to keep the total number of build tasks under the
-limit established by the initial make -j$n_proc call.
-"""
-
-import errno
 import os
-import subprocess
 import sys
 
+LIB_DIR = "lib"
+SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
-class JobserverExec:
-    """
-    Claim all slots from make using POSIX Jobserver.
+sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
-    The main methods here are:
-    - open(): reserves all slots;
-    - close(): method returns all used slots back to make;
-    - run(): executes a command setting PARALLELISM=<available slots jobs + 1>
-    """
+from jobserver import JobserverExec                  # pylint: disable=C0415
 
-    def __init__(self):
-        """Initialize internal vars"""
-        self.claim = 0
-        self.jobs = b""
-        self.reader = None
-        self.writer = None
-        self.is_open = False
 
-    def open(self):
-        """Reserve all available slots to be claimed later on"""
-
-        if self.is_open:
-            return
-
-        try:
-            # Fetch the make environment options.
-            flags = os.environ["MAKEFLAGS"]
-            # Look for "--jobserver=R,W"
-            # Note that GNU Make has used --jobserver-fds and --jobserver-auth
-            # so this handles all of them.
-            opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
-
-            # Parse out R,W file descriptor numbers and set them nonblocking.
-            # If the MAKEFLAGS variable contains multiple instances of the
-            # --jobserver-auth= option, the last one is relevant.
-            fds = opts[-1].split("=", 1)[1]
-
-            # Starting with GNU Make 4.4, named pipes are used for reader
-            # and writer.
-            # Example argument: --jobserver-auth=fifo:/tmp/GMfifo8134
-            _, _, path = fds.partition("fifo:")
-
-            if path:
-                self.reader = os.open(path, os.O_RDONLY | os.O_NONBLOCK)
-                self.writer = os.open(path, os.O_WRONLY)
-            else:
-                self.reader, self.writer = [int(x) for x in fds.split(",", 1)]
-                # Open a private copy of reader to avoid setting nonblocking
-                # on an unexpecting process with the same reader fd.
-                self.reader = os.open("/proc/self/fd/%d" % (self.reader),
-                                      os.O_RDONLY | os.O_NONBLOCK)
-
-            # Read out as many jobserver slots as possible
-            while True:
-                try:
-                    slot = os.read(self.reader, 8)
-                    self.jobs += slot
-                except (OSError, IOError) as e:
-                    if e.errno == errno.EWOULDBLOCK:
-                        # Stop at the end of the jobserver queue.
-                        break
-                    # If something went wrong, give back the jobs.
-                    if self.jobs:
-                        os.write(self.writer, self.jobs)
-                    raise e
-
-            # Add a bump for our caller's reserveration, since we're just going
-            # to sit here blocked on our child.
-            self.claim = len(self.jobs) + 1
-
-        except (KeyError, IndexError, ValueError, OSError, IOError):
-            # Any missing environment strings or bad fds should result in just
-            # not being parallel.
-            self.claim = None
-
-        self.is_open = True
-
-    def close(self):
-        """Return all reserved slots to Jobserver"""
-
-        if not self.is_open:
-            return
-
-        # Return all the reserved slots.
-        if len(self.jobs):
-            os.write(self.writer, self.jobs)
-
-        self.is_open = False
-
-    def __enter__(self):
-        self.open()
-        return self
-
-    def __exit__(self, exc_type, exc_value, exc_traceback):
-        self.close()
-
-    def run(self, cmd):
-        """
-        Run a command setting PARALLELISM env variable to the number of
-        available job slots (claim) + 1, e.g. it will reserve claim slots
-        to do the actual build work, plus one to monitor its childs.
-        """
-        self.open()             # Ensure that self.claim is set
-
-        # We can only claim parallelism if there was a jobserver (i.e. a
-        # top-level "-jN" argument) and there were no other failures. Otherwise
-        # leave out the environment variable and let the child figure out what
-        # is best.
-        if self.claim:
-            os.environ["PARALLELISM"] = str(self.claim)
-
-        return subprocess.call(cmd)
+"""
+Determines how many parallel tasks "make" is expecting, as it is
+not exposed via an special variables, reserves them all, runs a subprocess
+with PARALLELISM environment variable set, and releases the jobs back again.
 
+See:
+    https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
+"""
 
 def main():
     """Main program"""
diff --git a/scripts/lib/jobserver.py b/scripts/lib/jobserver.py
new file mode 100755
index 000000000000..98d8b0ff0c89
--- /dev/null
+++ b/scripts/lib/jobserver.py
@@ -0,0 +1,149 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0+
+#
+# pylint: disable=C0103,C0209
+#
+#
+
+"""
+Interacts with the POSIX jobserver during the Kernel build time.
+
+A "normal" jobserver task, like the one initiated by a make subrocess would do:
+
+    - open read/write file descriptors to communicate with the job server;
+    - ask for one slot by calling:
+        claim = os.read(reader, 1)
+    - when the job finshes, call:
+        os.write(writer, b"+")  # os.write(writer, claim)
+
+Here, the goal is different: This script aims to get the remaining number
+of slots available, using all of them to run a command which handle tasks in
+parallel. To to that, it has a loop that ends only after there are no
+slots left. It then increments the number by one, in order to allow a
+call equivalent to make -j$((claim+1)), e.g. having a parent make creating
+$claim child to do the actual work.
+
+The end goal here is to keep the total number of build tasks under the
+limit established by the initial make -j$n_proc call.
+
+See:
+    https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
+"""
+
+import errno
+import os
+import subprocess
+import sys
+
+class JobserverExec:
+    """
+    Claim all slots from make using POSIX Jobserver.
+
+    The main methods here are:
+    - open(): reserves all slots;
+    - close(): method returns all used slots back to make;
+    - run(): executes a command setting PARALLELISM=<available slots jobs + 1>
+    """
+
+    def __init__(self):
+        """Initialize internal vars"""
+        self.claim = 0
+        self.jobs = b""
+        self.reader = None
+        self.writer = None
+        self.is_open = False
+
+    def open(self):
+        """Reserve all available slots to be claimed later on"""
+
+        if self.is_open:
+            return
+
+        try:
+            # Fetch the make environment options.
+            flags = os.environ["MAKEFLAGS"]
+            # Look for "--jobserver=R,W"
+            # Note that GNU Make has used --jobserver-fds and --jobserver-auth
+            # so this handles all of them.
+            opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
+
+            # Parse out R,W file descriptor numbers and set them nonblocking.
+            # If the MAKEFLAGS variable contains multiple instances of the
+            # --jobserver-auth= option, the last one is relevant.
+            fds = opts[-1].split("=", 1)[1]
+
+            # Starting with GNU Make 4.4, named pipes are used for reader
+            # and writer.
+            # Example argument: --jobserver-auth=fifo:/tmp/GMfifo8134
+            _, _, path = fds.partition("fifo:")
+
+            if path:
+                self.reader = os.open(path, os.O_RDONLY | os.O_NONBLOCK)
+                self.writer = os.open(path, os.O_WRONLY)
+            else:
+                self.reader, self.writer = [int(x) for x in fds.split(",", 1)]
+                # Open a private copy of reader to avoid setting nonblocking
+                # on an unexpecting process with the same reader fd.
+                self.reader = os.open("/proc/self/fd/%d" % (self.reader),
+                                      os.O_RDONLY | os.O_NONBLOCK)
+
+            # Read out as many jobserver slots as possible
+            while True:
+                try:
+                    slot = os.read(self.reader, 8)
+                    self.jobs += slot
+                except (OSError, IOError) as e:
+                    if e.errno == errno.EWOULDBLOCK:
+                        # Stop at the end of the jobserver queue.
+                        break
+                    # If something went wrong, give back the jobs.
+                    if self.jobs:
+                        os.write(self.writer, self.jobs)
+                    raise e
+
+            # Add a bump for our caller's reserveration, since we're just going
+            # to sit here blocked on our child.
+            self.claim = len(self.jobs) + 1
+
+        except (KeyError, IndexError, ValueError, OSError, IOError):
+            # Any missing environment strings or bad fds should result in just
+            # not being parallel.
+            self.claim = None
+
+        self.is_open = True
+
+    def close(self):
+        """Return all reserved slots to Jobserver"""
+
+        if not self.is_open:
+            return
+
+        # Return all the reserved slots.
+        if len(self.jobs):
+            os.write(self.writer, self.jobs)
+
+        self.is_open = False
+
+    def __enter__(self):
+        self.open()
+        return self
+
+    def __exit__(self, exc_type, exc_value, exc_traceback):
+        self.close()
+
+    def run(self, cmd, *args, **pwargs):
+        """
+        Run a command setting PARALLELISM env variable to the number of
+        available job slots (claim) + 1, e.g. it will reserve claim slots
+        to do the actual build work, plus one to monitor its childs.
+        """
+        self.open()             # Ensure that self.claim is set
+
+        # We can only claim parallelism if there was a jobserver (i.e. a
+        # top-level "-jN" argument) and there were no other failures. Otherwise
+        # leave out the environment variable and let the child figure out what
+        # is best.
+        if self.claim:
+            os.environ["PARALLELISM"] = str(self.claim)
+
+        return subprocess.call(cmd, *args, **pwargs)
-- 
2.51.0


