Return-Path: <linux-kernel+bounces-723779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E308DAFEB06
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103D35A3D01
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33A42E8E16;
	Wed,  9 Jul 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTTV7/m9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792652E54AF;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=hUZXU3sTYSJig8oSg0GtYDCbACFZRW+0G3go7X+IgfXmyzzVY3mGzYBCkAcmlx/NScr4LflLsBuzd53KmnjtVWgUs44UmT3J+mR4W9Uiaj5ipJV17o1CuTawzaiMJKVaPLdS6eBhweRJ7ZhwP06dF4tvJSastb3hfNvU5dyx25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=/jImrr319PEnvqJZTbkdnCbbvj1ZipRv+JMChc+/DL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVwzKVCJlicDxOjOI7K/niF5WFzsyJmRSGmNRyxNNtPYGVt/ABNehHcqF4i/jqOOgBh0MOuT4W6ElZalxTeqyQukkKoHkMGYWq1Jl4uSmH0aAElXooRE6ojo+//XSgK+gIXK5IQJBTh4HEZ47k4zJztwX+tdG5fs39kVdHBhHSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTTV7/m9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7150C116C6;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069140;
	bh=/jImrr319PEnvqJZTbkdnCbbvj1ZipRv+JMChc+/DL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sTTV7/m9IcMkKCpAY5HDGdeanlTqcE7OTFuAsD1Z1wVjv3ziewX07HbT2EHONilHh
	 dzA5AyXHUMcLijcm6HzKtlvyFUrpYBWZYJo7KXKXdgfdRSUQ7mRWkQWMg753dBro0r
	 2rbhl9m6drE+F8oPTVDQ1aIXtquubwkbLUZ6Kv/JnVINpd9j9/Et9+Gm4lpUnY25Hz
	 igDycT0si6Z7t23AQNb9+gciIu6P/hoN8GNK42QGyuSfwlLYDvytuhOw4Teph9w3r2
	 cFv7EFYJrbNaIVlTvIq0rpVg7fiV1VUtly++ffxkSocu7YmV9K3+Rx9BMInsP+jtle
	 oczyd7XKPNdzQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECR-1E2e;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/39] scripts: sphinx-pre-install: drop support for old virtualenv
Date: Wed,  9 Jul 2025 15:51:39 +0200
Message-ID: <2d41a32a842ced85bc8512f3969e5354de556a21.1752067814.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752067814.git.mchehab+huawei@kernel.org>
References: <cover.1752067814.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Up to Python 3.2, the virtual environment were created
via virtualenv binary.

As we dropped support for such old version, clean up the code.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 69 +++++++++--------------------------
 1 file changed, 18 insertions(+), 51 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index b639acd455cc..0a73b1b33842 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -80,7 +80,6 @@ class SphinxDependencyChecker:
         self.need_symlink = 0
         self.need_sphinx = 0
         self.need_pip = 0
-        self.need_virtualenv = 0
         self.rec_sphinx_upgrade = 0
         self.verbose_warn_install = 1
 
@@ -919,12 +918,14 @@ class SphinxDependencyChecker:
         else:
             print("\nSphinx needs to be installed either:\n1) via pip/pypi with:\n")
 
-        self.python_cmd = os.path.abspath(sys.argv[0])
-
-        print(f"\t{virtualenv_cmd} {self.virtenv_dir}")
-        print(f"\t. {self.virtenv_dir}/bin/activate")
-        print(f"\tpip install -r {self.requirement_file}")
-        self.deactivate_help()
+        if not virtualenv_cmd:
+            print("   Currently not possible.\n")
+            print("   Please upgrade Python to a newer version and run this script again")
+        else:
+            print(f"\t{virtualenv_cmd} {self.virtenv_dir}")
+            print(f"\t. {self.virtenv_dir}/bin/activate")
+            print(f"\tpip install -r {self.requirement_file}")
+            self.deactivate_help()
 
         print("\n2) As a package with:")
 
@@ -953,6 +954,7 @@ class SphinxDependencyChecker:
 
     def check_needs(self):
         self.get_system_release()
+        self.python_cmd = sys.executable
 
         # Check if Sphinx is already accessible from current environment
         self.check_sphinx()
@@ -965,56 +967,21 @@ class SphinxDependencyChecker:
             ver = ver_str(self.cur_version)
             print(f"Sphinx version: {ver}\n")
 
-        # FIXME: Check python command line, trying first python3
-        self.python_cmd = self.which("python3")
-        if not self.python_cmd:
-            self.python_cmd = self.check_program("python", 0)
-
         # Check the type of virtual env, depending on Python version
-        if self.python_cmd:
-            if self.virtualenv:
-                try:
-                    result = self.run(
-                        [self.python_cmd, "--version"],
-                        capture_output=True,
-                        text=True,
-                        check=True,
-                    )
+        virtualenv_cmd = None
 
-                    output = result.stdout + result.stderr
-
-                    match = re.search(r"(\d+)\.(\d+)\.", output)
-                    if match:
-                        major = int(match.group(1))
-                        minor = int(match.group(2))
-
-                        if major < 3:
-                            sys.exit("Python 3 is required to build the kernel docs")
-                        if major == 3 and minor < 3:
-                            self.need_virtualenv = True
-                    else:
-                        sys.exit(f"Warning: couldn't identify {self.python_cmd} version!")
-
-                except subprocess.CalledProcessError as e:
-                    sys.exit(f"Error checking Python version: {e}")
-            else:
-                self.add_package("python-sphinx", 0)
+        if sys.version_info < MIN_PYTHON_VERSION:
+            min_ver = ver_str(MIN_PYTHON_VERSION)
+            print(f"ERROR: at least python {min_ver} is required to build the kernel docs")
+            self.need_sphinx = 1
 
         self.venv_ver = self.recommend_sphinx_upgrade()
 
-        virtualenv_cmd = ""
-
         if self.need_pip:
-            # Set virtualenv command line, if python < 3.3
-            # FIXME: can be removed as we're now with an upper min requirement
-            #        but then we need to check python version
-            if self.need_virtualenv:
-                virtualenv_cmd = self.which("virtualenv-3")
-                if not virtualenv_cmd:
-                    virtualenv_cmd = self.which("virtualenv-3.5")
-                if not virtualenv_cmd:
-                    self.check_program("virtualenv", 0)
-                    virtualenv_cmd = "virtualenv"
+            if sys.version_info < MIN_PYTHON_VERSION:
+                self.need_pip = False
+                print("Warning: python version is not supported.")
+
             else:
                 virtualenv_cmd = f"{self.python_cmd} -m venv"
                 self.check_python_module("ensurepip", 0)
-- 
2.49.0


