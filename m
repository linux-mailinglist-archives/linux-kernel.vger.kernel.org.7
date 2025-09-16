Return-Path: <linux-kernel+bounces-818566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FC7B5936F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364DF16F8D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81EC30496B;
	Tue, 16 Sep 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMygKhJr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FBF2C11EC;
	Tue, 16 Sep 2025 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018215; cv=none; b=EgSeI53FR5Td/RStKeQaiYaq3Uc0tEiaDnhCEIQemUr7pfC/JrtprKPd84ylYwP0C/j4RT77cYd2qu+vaCe6qJRjVAFrme2Vn1rI/iLdiQcZSdjXe5lTUdrLIFAYMFTETJ1mjObAoc01Vo5KrB5TZ3NnWFZhtwo1rM4CsQTaDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018215; c=relaxed/simple;
	bh=AiE/HI6OagdGD9ZL2nK8qpA5ue5A1dovU9+3kLCIiqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1UR1CmSCNYrnJWb5ksDoN2oGM/Ia5OSZtNJI/P+w6PAyrAFRUd7XX/TL4mM9p9vuZbRylvk8H/cGjWp+pqBkWThu3gWCZ1XOALaqL/n1ESFa6MuNeB0GRk7OPhSwjfiSFh2cYiVEJBWlPVqrg1xCcw+ldV12HV6HUvMEPl2CqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMygKhJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6D5C4CEEB;
	Tue, 16 Sep 2025 10:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018214;
	bh=AiE/HI6OagdGD9ZL2nK8qpA5ue5A1dovU9+3kLCIiqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BMygKhJrgo7vUxghn7+v0xBl2D+t+ZS/WFpGDWb7MRI3zNlAl+gS5FUIiLfUIJqze
	 HuBDImoJgiCrRqbfj8EHAAOhGYMI9sgGt8hd/jq8BQjSJcXWjgexBt4yNsHqZCvmlz
	 hG1Hvqhz8iuIlcXjf5FfhnUdhuRltWs7RSeoCde+TAFfNT0OjONXcuIa4nhB18Jj5i
	 Tj1e60HJbpsF3wOGePZibSVddk5sWQD6WSyMxDWs4BOwggsap/z+gbx/QRvnafUY3S
	 43BkN+eX1NY+cdDZXBxt3VKF3h0Xn96b9pWByPh5N4qSHT1sHQ/4z5jcm69aVIN8iR
	 U/kCpxRClqrLw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uySqS-0000000BBOZ-2ak2;
	Tue, 16 Sep 2025 12:23:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/21] scripts/jobserver-exec: move the code to a class
Date: Tue, 16 Sep 2025 12:22:37 +0200
Message-ID: <79700002248605fa9ad45ade0165e67b04d457b0.1758018030.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758018030.git.mchehab+huawei@kernel.org>
References: <cover.1758018030.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Convert the code inside jobserver-exec to a class and
properly document it.

Using a class allows reusing the jobserver logic on other
scripts.

While the main code remains unchanged, being compatible with
Python 2.6 and 3.0+, its coding style now follows a more
modern standard, having tabs replaced by a 4-spaces
indent, passing autopep8, black and pylint.

The code now allows allows using a pythonic way to
enter/exit a python code, e.g. it now supports:

	with JobserverExec() as jobserver:
	    jobserver.run(sys.argv[1:])

With the new code, the __exit__() function should ensure
that the jobserver slot will be closed at the end, even if
something bad happens somewhere.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/jobserver-exec | 218 ++++++++++++++++++++++++++++-------------
 1 file changed, 151 insertions(+), 67 deletions(-)

diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec
index 7eca035472d3..b386b1a845de 100755
--- a/scripts/jobserver-exec
+++ b/scripts/jobserver-exec
@@ -1,77 +1,161 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0+
 #
+# pylint: disable=C0103,C0209
+#
 # This determines how many parallel tasks "make" is expecting, as it is
 # not exposed via an special variables, reserves them all, runs a subprocess
 # with PARALLELISM environment variable set, and releases the jobs back again.
 #
 # https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
-from __future__ import print_function
-import os, sys, errno
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
+"""
+
+import errno
+import os
 import subprocess
+import sys
 
-# Extract and prepare jobserver file descriptors from environment.
-claim = 0
-jobs = b""
-try:
-	# Fetch the make environment options.
-	flags = os.environ['MAKEFLAGS']
-
-	# Look for "--jobserver=R,W"
-	# Note that GNU Make has used --jobserver-fds and --jobserver-auth
-	# so this handles all of them.
-	opts = [x for x in flags.split(" ") if x.startswith("--jobserver")]
-
-	# Parse out R,W file descriptor numbers and set them nonblocking.
-	# If the MAKEFLAGS variable contains multiple instances of the
-	# --jobserver-auth= option, the last one is relevant.
-	fds = opts[-1].split("=", 1)[1]
-
-	# Starting with GNU Make 4.4, named pipes are used for reader and writer.
-	# Example argument: --jobserver-auth=fifo:/tmp/GMfifo8134
-	_, _, path = fds.partition('fifo:')
-
-	if path:
-		reader = os.open(path, os.O_RDONLY | os.O_NONBLOCK)
-		writer = os.open(path, os.O_WRONLY)
-	else:
-		reader, writer = [int(x) for x in fds.split(",", 1)]
-		# Open a private copy of reader to avoid setting nonblocking
-		# on an unexpecting process with the same reader fd.
-		reader = os.open("/proc/self/fd/%d" % (reader),
-				 os.O_RDONLY | os.O_NONBLOCK)
-
-	# Read out as many jobserver slots as possible.
-	while True:
-		try:
-			slot = os.read(reader, 8)
-			jobs += slot
-		except (OSError, IOError) as e:
-			if e.errno == errno.EWOULDBLOCK:
-				# Stop at the end of the jobserver queue.
-				break
-			# If something went wrong, give back the jobs.
-			if len(jobs):
-				os.write(writer, jobs)
-			raise e
-	# Add a bump for our caller's reserveration, since we're just going
-	# to sit here blocked on our child.
-	claim = len(jobs) + 1
-except (KeyError, IndexError, ValueError, OSError, IOError) as e:
-	# Any missing environment strings or bad fds should result in just
-	# not being parallel.
-	pass
-
-# We can only claim parallelism if there was a jobserver (i.e. a top-level
-# "-jN" argument) and there were no other failures. Otherwise leave out the
-# environment variable and let the child figure out what is best.
-if claim > 0:
-	os.environ['PARALLELISM'] = '%d' % (claim)
-
-rc = subprocess.call(sys.argv[1:])
-
-# Return all the reserved slots.
-if len(jobs):
-	os.write(writer, jobs)
-
-sys.exit(rc)
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
+    def run(self, cmd):
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
+        return subprocess.call(cmd)
+
+
+def main():
+    """Main program"""
+    with JobserverExec() as jobserver:
+        jobserver.run(sys.argv[1:])
+
+
+if __name__ == "__main__":
+    main()
-- 
2.51.0


