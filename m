Return-Path: <linux-kernel+bounces-794950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39818B3EB27
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9E34857FA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2124632A832;
	Mon,  1 Sep 2025 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcQnCq39"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDD12DF134;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740838; cv=none; b=Kwy0LSto5sa2zk4VOu5Z9PeM2waxDynOXjnbRZzAU54TBf9JrTgIJGRcz+y1qJDsKZpiwjD2/LhuNVAEYsZCNl/GK8cU5ZBvLbl2dXREC1ZzlyZMJAqxrvjv6HDTP5LgM3vnEL+0NV5y9h1YfHm3EVIWnswwAwZKtm03g02G9fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740838; c=relaxed/simple;
	bh=Ld40DIosQaG612Luo0e07Pz1gNPegp2n6qzf8+9RXGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P6DkE59RoyCY7OCRcSeYGOlgP6a/x40T5GE+drHyMDJe0Twi4R/rSpVB817zsq7z/3mdLE4bSghbtzIdhh2nG0URqvBxw2EkdhocldaAoZZRAcx41DZiiJ4fmfVCe9QBk6jd3CpfmDve9dJgKHpL4G4oxtoeA5Vk4xS4i6G88mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcQnCq39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A611C4CEF7;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740837;
	bh=Ld40DIosQaG612Luo0e07Pz1gNPegp2n6qzf8+9RXGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pcQnCq39cNpeAqfaLdw0m83/tky5sytynihjOItCbRr4LxbVwEUAV2vuxusg6gd/t
	 A8xtECWrQYHlyG0gJ55mgW/TraDjfKe1QYbHqRHYwlsdqjGw8SRlE4xXo/At3UsSTO
	 4HSgE010kvt7TUqrsy2WnE5WvxYo8+I8B/IfKv4bUcA7ShDsW/19Ww28Z2AN30AWPV
	 hXwp3iDB8PjYeREsQkpC0SHQtOXmc+gLZe93AvCIS9ed2JRT7KwATH4QJgQRI2T9L+
	 JZoR3lRV42D9jPaYjs8FLYmvkgnPbd+/6dkzYtxm+T0yUp7QwBG6G8kpxSCm5jqTFJ
	 pII8RlHmCcRoQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut6Xb-00000003HLi-2DcQ;
	Mon, 01 Sep 2025 17:33:55 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 02/15] scripts/jobserver-exec: move its class to the
  lib directory
Date: Mon,  1 Sep 2025 17:33:37 +0200
Message-ID: <928e3c95aa49c94c8b3dc312de129e36acf9cc87.1756740314.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756740314.git.mchehab+huawei@kernel.org>
References: <cover.1756740314.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

To make it easier to be re-used, move the JobserverExec class=0D
to the library directory.=0D
=0D
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
---=0D
 scripts/jobserver-exec   | 152 +++------------------------------------=0D
 scripts/lib/jobserver.py | 149 ++++++++++++++++++++++++++++++++++++++=0D
 2 files changed, 160 insertions(+), 141 deletions(-)=0D
 create mode 100755 scripts/lib/jobserver.py=0D
=0D
diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec=0D
index b386b1a845de..40a0f0058733 100755=0D
--- a/scripts/jobserver-exec=0D
+++ b/scripts/jobserver-exec=0D
@@ -1,155 +1,25 @@=0D
 #!/usr/bin/env python3=0D
 # SPDX-License-Identifier: GPL-2.0+=0D
-#=0D
-# pylint: disable=3DC0103,C0209=0D
-#=0D
-# This determines how many parallel tasks "make" is expecting, as it is=0D
-# not exposed via an special variables, reserves them all, runs a subproce=
ss=0D
-# with PARALLELISM environment variable set, and releases the jobs back ag=
ain.=0D
-#=0D
-# https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#=
POSIX-Jobserver=0D
 =0D
-"""=0D
-Interacts with the POSIX jobserver during the Kernel build time.=0D
-=0D
-A "normal" jobserver task, like the one initiated by a make subrocess woul=
d do:=0D
-=0D
-    - open read/write file descriptors to communicate with the job server;=
=0D
-    - ask for one slot by calling:=0D
-        claim =3D os.read(reader, 1)=0D
-    - when the job finshes, call:=0D
-        os.write(writer, b"+")  # os.write(writer, claim)=0D
-=0D
-Here, the goal is different: This script aims to get the remaining number=
=0D
-of slots available, using all of them to run a command which handle tasks =
in=0D
-parallel. To to that, it has a loop that ends only after there are no=0D
-slots left. It then increments the number by one, in order to allow a=0D
-call equivalent to make -j$((claim+1)), e.g. having a parent make creating=
=0D
-$claim child to do the actual work.=0D
-=0D
-The end goal here is to keep the total number of build tasks under the=0D
-limit established by the initial make -j$n_proc call.=0D
-"""=0D
-=0D
-import errno=0D
 import os=0D
-import subprocess=0D
 import sys=0D
 =0D
+LIB_DIR =3D "lib"=0D
+SRC_DIR =3D os.path.dirname(os.path.realpath(__file__))=0D
 =0D
-class JobserverExec:=0D
-    """=0D
-    Claim all slots from make using POSIX Jobserver.=0D
+sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))=0D
 =0D
-    The main methods here are:=0D
-    - open(): reserves all slots;=0D
-    - close(): method returns all used slots back to make;=0D
-    - run(): executes a command setting PARALLELISM=3D<available slots job=
s + 1>=0D
-    """=0D
+from jobserver import JobserverExec                  # pylint: disable=3DC=
0415=0D
 =0D
-    def __init__(self):=0D
-        """Initialize internal vars"""=0D
-        self.claim =3D 0=0D
-        self.jobs =3D b""=0D
-        self.reader =3D None=0D
-        self.writer =3D None=0D
-        self.is_open =3D False=0D
 =0D
-    def open(self):=0D
-        """Reserve all available slots to be claimed later on"""=0D
-=0D
-        if self.is_open:=0D
-            return=0D
-=0D
-        try:=0D
-            # Fetch the make environment options.=0D
-            flags =3D os.environ["MAKEFLAGS"]=0D
-            # Look for "--jobserver=3DR,W"=0D
-            # Note that GNU Make has used --jobserver-fds and --jobserver-=
auth=0D
-            # so this handles all of them.=0D
-            opts =3D [x for x in flags.split(" ") if x.startswith("--jobse=
rver")]=0D
-=0D
-            # Parse out R,W file descriptor numbers and set them nonblocki=
ng.=0D
-            # If the MAKEFLAGS variable contains multiple instances of the=
=0D
-            # --jobserver-auth=3D option, the last one is relevant.=0D
-            fds =3D opts[-1].split("=3D", 1)[1]=0D
-=0D
-            # Starting with GNU Make 4.4, named pipes are used for reader=
=0D
-            # and writer.=0D
-            # Example argument: --jobserver-auth=3Dfifo:/tmp/GMfifo8134=0D
-            _, _, path =3D fds.partition("fifo:")=0D
-=0D
-            if path:=0D
-                self.reader =3D os.open(path, os.O_RDONLY | os.O_NONBLOCK)=
=0D
-                self.writer =3D os.open(path, os.O_WRONLY)=0D
-            else:=0D
-                self.reader, self.writer =3D [int(x) for x in fds.split(",=
", 1)]=0D
-                # Open a private copy of reader to avoid setting nonblocki=
ng=0D
-                # on an unexpecting process with the same reader fd.=0D
-                self.reader =3D os.open("/proc/self/fd/%d" % (self.reader)=
,=0D
-                                      os.O_RDONLY | os.O_NONBLOCK)=0D
-=0D
-            # Read out as many jobserver slots as possible=0D
-            while True:=0D
-                try:=0D
-                    slot =3D os.read(self.reader, 8)=0D
-                    self.jobs +=3D slot=0D
-                except (OSError, IOError) as e:=0D
-                    if e.errno =3D=3D errno.EWOULDBLOCK:=0D
-                        # Stop at the end of the jobserver queue.=0D
-                        break=0D
-                    # If something went wrong, give back the jobs.=0D
-                    if self.jobs:=0D
-                        os.write(self.writer, self.jobs)=0D
-                    raise e=0D
-=0D
-            # Add a bump for our caller's reserveration, since we're just =
going=0D
-            # to sit here blocked on our child.=0D
-            self.claim =3D len(self.jobs) + 1=0D
-=0D
-        except (KeyError, IndexError, ValueError, OSError, IOError):=0D
-            # Any missing environment strings or bad fds should result in =
just=0D
-            # not being parallel.=0D
-            self.claim =3D None=0D
-=0D
-        self.is_open =3D True=0D
-=0D
-    def close(self):=0D
-        """Return all reserved slots to Jobserver"""=0D
-=0D
-        if not self.is_open:=0D
-            return=0D
-=0D
-        # Return all the reserved slots.=0D
-        if len(self.jobs):=0D
-            os.write(self.writer, self.jobs)=0D
-=0D
-        self.is_open =3D False=0D
-=0D
-    def __enter__(self):=0D
-        self.open()=0D
-        return self=0D
-=0D
-    def __exit__(self, exc_type, exc_value, exc_traceback):=0D
-        self.close()=0D
-=0D
-    def run(self, cmd):=0D
-        """=0D
-        Run a command setting PARALLELISM env variable to the number of=0D
-        available job slots (claim) + 1, e.g. it will reserve claim slots=
=0D
-        to do the actual build work, plus one to monitor its childs.=0D
-        """=0D
-        self.open()             # Ensure that self.claim is set=0D
-=0D
-        # We can only claim parallelism if there was a jobserver (i.e. a=0D
-        # top-level "-jN" argument) and there were no other failures. Othe=
rwise=0D
-        # leave out the environment variable and let the child figure out =
what=0D
-        # is best.=0D
-        if self.claim:=0D
-            os.environ["PARALLELISM"] =3D str(self.claim)=0D
-=0D
-        return subprocess.call(cmd)=0D
+"""=0D
+Determines how many parallel tasks "make" is expecting, as it is=0D
+not exposed via an special variables, reserves them all, runs a subprocess=
=0D
+with PARALLELISM environment variable set, and releases the jobs back agai=
n.=0D
 =0D
+See:=0D
+    https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.htm=
l#POSIX-Jobserver=0D
+"""=0D
 =0D
 def main():=0D
     """Main program"""=0D
diff --git a/scripts/lib/jobserver.py b/scripts/lib/jobserver.py=0D
new file mode 100755=0D
index 000000000000..98d8b0ff0c89=0D
--- /dev/null=0D
+++ b/scripts/lib/jobserver.py=0D
@@ -0,0 +1,149 @@=0D
+#!/usr/bin/env python3=0D
+# SPDX-License-Identifier: GPL-2.0+=0D
+#=0D
+# pylint: disable=3DC0103,C0209=0D
+#=0D
+#=0D
+=0D
+"""=0D
+Interacts with the POSIX jobserver during the Kernel build time.=0D
+=0D
+A "normal" jobserver task, like the one initiated by a make subrocess woul=
d do:=0D
+=0D
+    - open read/write file descriptors to communicate with the job server;=
=0D
+    - ask for one slot by calling:=0D
+        claim =3D os.read(reader, 1)=0D
+    - when the job finshes, call:=0D
+        os.write(writer, b"+")  # os.write(writer, claim)=0D
+=0D
+Here, the goal is different: This script aims to get the remaining number=
=0D
+of slots available, using all of them to run a command which handle tasks =
in=0D
+parallel. To to that, it has a loop that ends only after there are no=0D
+slots left. It then increments the number by one, in order to allow a=0D
+call equivalent to make -j$((claim+1)), e.g. having a parent make creating=
=0D
+$claim child to do the actual work.=0D
+=0D
+The end goal here is to keep the total number of build tasks under the=0D
+limit established by the initial make -j$n_proc call.=0D
+=0D
+See:=0D
+    https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.htm=
l#POSIX-Jobserver=0D
+"""=0D
+=0D
+import errno=0D
+import os=0D
+import subprocess=0D
+import sys=0D
+=0D
+class JobserverExec:=0D
+    """=0D
+    Claim all slots from make using POSIX Jobserver.=0D
+=0D
+    The main methods here are:=0D
+    - open(): reserves all slots;=0D
+    - close(): method returns all used slots back to make;=0D
+    - run(): executes a command setting PARALLELISM=3D<available slots job=
s + 1>=0D
+    """=0D
+=0D
+    def __init__(self):=0D
+        """Initialize internal vars"""=0D
+        self.claim =3D 0=0D
+        self.jobs =3D b""=0D
+        self.reader =3D None=0D
+        self.writer =3D None=0D
+        self.is_open =3D False=0D
+=0D
+    def open(self):=0D
+        """Reserve all available slots to be claimed later on"""=0D
+=0D
+        if self.is_open:=0D
+            return=0D
+=0D
+        try:=0D
+            # Fetch the make environment options.=0D
+            flags =3D os.environ["MAKEFLAGS"]=0D
+            # Look for "--jobserver=3DR,W"=0D
+            # Note that GNU Make has used --jobserver-fds and --jobserver-=
auth=0D
+            # so this handles all of them.=0D
+            opts =3D [x for x in flags.split(" ") if x.startswith("--jobse=
rver")]=0D
+=0D
+            # Parse out R,W file descriptor numbers and set them nonblocki=
ng.=0D
+            # If the MAKEFLAGS variable contains multiple instances of the=
=0D
+            # --jobserver-auth=3D option, the last one is relevant.=0D
+            fds =3D opts[-1].split("=3D", 1)[1]=0D
+=0D
+            # Starting with GNU Make 4.4, named pipes are used for reader=
=0D
+            # and writer.=0D
+            # Example argument: --jobserver-auth=3Dfifo:/tmp/GMfifo8134=0D
+            _, _, path =3D fds.partition("fifo:")=0D
+=0D
+            if path:=0D
+                self.reader =3D os.open(path, os.O_RDONLY | os.O_NONBLOCK)=
=0D
+                self.writer =3D os.open(path, os.O_WRONLY)=0D
+            else:=0D
+                self.reader, self.writer =3D [int(x) for x in fds.split(",=
", 1)]=0D
+                # Open a private copy of reader to avoid setting nonblocki=
ng=0D
+                # on an unexpecting process with the same reader fd.=0D
+                self.reader =3D os.open("/proc/self/fd/%d" % (self.reader)=
,=0D
+                                      os.O_RDONLY | os.O_NONBLOCK)=0D
+=0D
+            # Read out as many jobserver slots as possible=0D
+            while True:=0D
+                try:=0D
+                    slot =3D os.read(self.reader, 8)=0D
+                    self.jobs +=3D slot=0D
+                except (OSError, IOError) as e:=0D
+                    if e.errno =3D=3D errno.EWOULDBLOCK:=0D
+                        # Stop at the end of the jobserver queue.=0D
+                        break=0D
+                    # If something went wrong, give back the jobs.=0D
+                    if self.jobs:=0D
+                        os.write(self.writer, self.jobs)=0D
+                    raise e=0D
+=0D
+            # Add a bump for our caller's reserveration, since we're just =
going=0D
+            # to sit here blocked on our child.=0D
+            self.claim =3D len(self.jobs) + 1=0D
+=0D
+        except (KeyError, IndexError, ValueError, OSError, IOError):=0D
+            # Any missing environment strings or bad fds should result in =
just=0D
+            # not being parallel.=0D
+            self.claim =3D None=0D
+=0D
+        self.is_open =3D True=0D
+=0D
+    def close(self):=0D
+        """Return all reserved slots to Jobserver"""=0D
+=0D
+        if not self.is_open:=0D
+            return=0D
+=0D
+        # Return all the reserved slots.=0D
+        if len(self.jobs):=0D
+            os.write(self.writer, self.jobs)=0D
+=0D
+        self.is_open =3D False=0D
+=0D
+    def __enter__(self):=0D
+        self.open()=0D
+        return self=0D
+=0D
+    def __exit__(self, exc_type, exc_value, exc_traceback):=0D
+        self.close()=0D
+=0D
+    def run(self, cmd, *args, **pwargs):=0D
+        """=0D
+        Run a command setting PARALLELISM env variable to the number of=0D
+        available job slots (claim) + 1, e.g. it will reserve claim slots=
=0D
+        to do the actual build work, plus one to monitor its childs.=0D
+        """=0D
+        self.open()             # Ensure that self.claim is set=0D
+=0D
+        # We can only claim parallelism if there was a jobserver (i.e. a=0D
+        # top-level "-jN" argument) and there were no other failures. Othe=
rwise=0D
+        # leave out the environment variable and let the child figure out =
what=0D
+        # is best.=0D
+        if self.claim:=0D
+            os.environ["PARALLELISM"] =3D str(self.claim)=0D
+=0D
+        return subprocess.call(cmd, *args, **pwargs)=0D
-- =0D
2.51.0=0D
=0D

