Return-Path: <linux-kernel+bounces-827117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A60B905B2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A01117BF8C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04F3305E0D;
	Mon, 22 Sep 2025 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsO6AwWR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05646304BB7;
	Mon, 22 Sep 2025 11:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540496; cv=none; b=K9N5o6zsnw8L90xjEm8jweq9+XJXqaNRbljB40E3xzvMB5SGClo/zmFp3YCk+fQhK5z3pbaiKaF/FZgJT3B8ZouH1cBKDTswX9gjtk1lYulO7LVZ+oCHrgJvE0fVMoWI0GstLwvzIyRKy99zLimAtvzauQWAVy7ey+tutXoQVm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540496; c=relaxed/simple;
	bh=PjXZqimCvxE+X4M4BbjWwHEk7oJMd1v2hyiYUkthPLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWeNj9SmqRZgDId58RRssJVYEu/CwZ7WNGqXWEIHy95PIu1yD5Q8xKkppSe2R0qeUIILru61bA66h/jc8yrxUnSgHiAJcwgXlymwzp39js4wlsB71LNlEQmQiD0q9tyHASe6CcmDQet9lJ3QFGIsqrpwwxQBrQQ8AJ8MsvJYyMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsO6AwWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF507C4CEF7;
	Mon, 22 Sep 2025 11:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758540495;
	bh=PjXZqimCvxE+X4M4BbjWwHEk7oJMd1v2hyiYUkthPLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsO6AwWRbeQ96US1koibocRGT37Q9qcS/ERgwRNoPprTihsI5whzZezaG9Y91Tisl
	 R6QMtXIMgjj+dbJKgQ+XFMbN+epEk1LLFKPgcAoXWC4RHsu+36n3FuHa12UrfcjxDh
	 iZxrlnkjjn+HjC0vlA9N3/xzrLpzFiBMjtjhNHcItfoGEWI3J6gzBLdzJbk6smvY+t
	 Tv5bfijZTqi/M6k2kWuCW+hkKckz8FADz2MwGVYbO1pM3/XkmXU47SEJ/gNtRF+Ooe
	 HKr3Ad1KpW6fKcf2oAUZuzWM5leYuspxEhTjhPeUSlyQkWE3QIfHeGIKaiSSArqzxA
	 es2OXax4g22Vw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v0eiL-00000005vOp-3NiQ;
	Mon, 22 Sep 2025 13:28:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/3] tools/docs: sphinx-build-wrapper: fix compat with recent Tumbleweed
Date: Mon, 22 Sep 2025 13:27:38 +0200
Message-ID: <8917f862e0b8484c68408c274129c9f37a7aefb4.1758539031.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758539031.git.mchehab+huawei@kernel.org>
References: <cover.1758539031.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On recent versions of openSUSE Tumbleweed, sphinx-buildis is no longer
a Python script, but something else. Such change is due to how
it now handles alternatives:

    https://en.opensuse.org/openSUSE:Migrating_to_libalternatives_with_alts

The most common approach that distros use for alternatives is via
symlinks:

    lrwxrwxrwx 1 root root 22 out 31  2024 /usr/bin/java -> /etc/alternatives/java
    lrwxrwxrwx 1 root root 37 mar  5  2025 /etc/alternatives/java -> /usr/lib/jvm/java-21-openjdk/bin/java

With such approach, one can sun the script with either:

    <sphinx>
    python3 <script>

However, openSUSE's implementation uses an ELF binary (/usr/bin/alts),
which breaks the latter format.

It is needed to allow users to specify the Python version to be
used while building docs, as some distros like Leap 15.x are
shipped with:

- older, unsupported python3/python3-sphinx packages;
- more modern python3xx/python3xx-sphinx packages that work
  properly.

On such distros, building docs require running make with:

    make PYTHON3=python3.11 htmldocs

Heh, even on more moderen distros where python3-sphinx
is supported, one may still want to use a newer package,
for instance, due to performance issues, as:

    - with Python < 3.11, kernel-doc is 3 times slower;
    - while building htmldocs with Python 3.13/Sphinx 8.x
      takes about 3 minutes on a modern machine, using
      Sphinx < 8.0 can take up to 16 minutes to build docs
      (7.x are the worse ones and require lots of RAM).

So, even with not too old distros, one still may want to use
for instance PYTHON3=python3.11.

To acommodate using PYTHON3 without breaking on Tumbleweed,
add a workaround that will only use:

    $(PYTHON3) sphinx-build

if PYTHON3 env var is not default.

While here, drop the special check for venv, as, with venv,
we can just call sphinx-build directly without any extra
checks.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/all/883df949-0281-4a39-8745-bcdcce3a5594@infradead.org/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index bd8e2ed746e7..98c4db5b7c47 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -185,6 +185,19 @@ class SphinxBuilder:
         self.kernelrelease = os.environ.get("KERNELRELEASE", "unknown")
         self.pdflatex = os.environ.get("PDFLATEX", "xelatex")
 
+        #
+        # Kernel main Makefile defines a PYTHON3 variable whose default is
+        # "python3". When set to a different value, it allows running a
+        # diferent version than the default official python3 package.
+        # Several distros package python3xx-sphinx packages with newer
+        # versions of Python and sphinx-build.
+        #
+        # Honor such variable different than default
+        #
+        self.python = os.environ.get("PYTHON3")
+        if self.python == "python3":
+            self.python = None
+
         if not interactive:
             self.latexopts = os.environ.get("LATEXOPTS", "-interaction=batchmode -no-shell-escape")
         else:
@@ -272,10 +285,16 @@ class SphinxBuilder:
             if self.n_jobs:
                 n_jobs = str(self.n_jobs)
 
-            if self.venv:
-                cmd = ["python"]
+            #
+            # We can't simply call python3 sphinx-build, as OpenSUSE
+            # Tumbleweed uses an ELF binary file (/usr/bin/alts) to switch
+            # between different versions of sphinx-build. So, only call it
+            # prepending "python3.xx" when PYTHON3 variable is not default.
+            #
+            if self.python:
+                cmd = [self.python]
             else:
-                cmd = [sys.executable]
+                cmd = []
 
             cmd += [sphinx_build]
             cmd += [f"-j{n_jobs}"]
-- 
2.51.0


