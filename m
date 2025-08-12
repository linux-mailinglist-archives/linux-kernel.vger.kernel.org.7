Return-Path: <linux-kernel+bounces-765201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B27B22CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF88683702
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671192FAC11;
	Tue, 12 Aug 2025 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRK+xXeR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFABA2F83D7;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=qQM9Ne0y23uug9CbwD7tRF80APABf07X0rQmFlAE/Lsm7xI/9+jqZYiO3fMDMgZYhRY3pZx4s50K+DK+rVrkMOO6Xi5dwAqxc3QAQbgtY5hJWIhswpBvlMV22w6tzzHiQkTYAxhiXUSRcEeAx8TbQVRJan7tLHKqxYVWq+1TGF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=exdw2BI48vq3oUG1To7cfGu2j5O2HUT3gs88cLp4ySs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rttR24viO/KaYlObMZS7G8Oit2fQwKdMucPh4oEyhaI/eKdv06wyoRF2mKO/QADYSgl2Wn5zF6KBNe3SX5zxinS5ZZiZa+nIaLuOw74S0FQ0bgwioWvOfeliHZ9J5jokArOMXSeewqRgn3St6NoP/6LRI26iFMWcDo4IducW3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRK+xXeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0ACC4AF14;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013985;
	bh=exdw2BI48vq3oUG1To7cfGu2j5O2HUT3gs88cLp4ySs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRK+xXeRjeCuS6e/Cwg9j1dfx7HGtPsjQ0mf1upnbNIJsxpBDHw880j8ui0jEW2uD
	 Lp4MzDvcDb/YU3UXbhH7UVJsh5SbBlGA06iAqStjnZc0gZFVG1WgwNuXaQk9hyq9Dx
	 3yJR+CpudTFZFaxCI2b3aqCs+3X+UxcSbCmm/VGodsggUKP8F10q4RuAVnU0mqz3vB
	 RfrhUxk5+wptAkt7kcdG6a/Xbl8oqWP6jG+v5wgnEq0esUf8FNzaNlYVztJiZ29eJk
	 3jGCSi50/1vvFWqI4iRZ933OpLUHJ/9hr1HFzo2rb9KBX/Lvo1nRUApjB0opo7hrSb
	 FFRp5gCAy+hTA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kWQ-2aOx;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/39] scripts: sphinx-pre-install: improve Gentoo package deps logic
Date: Tue, 12 Aug 2025 17:52:36 +0200
Message-ID: <365fe5e7d568da932dcffde65f48f2c1256cb773.1754992972.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754992972.git.mchehab+huawei@kernel.org>
References: <cover.1754992972.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

It took me a lot of time, but I guess understand now what it
takes to install a package on Gentoo.

Handling dependencies is a nightmare, as Gentoo refuses to emerge
some packages if there's no package.use file describing them.
To make it worse, compilation flags shall also be present there
for some packages. If USE is not perfect, error/warning messages
like those are shown:

  gnome-base/librsvg dev-texlive/texlive-xetex media-fonts/dejavu dev-python/pyyaml

...

!!! The following binary packages have been ignored due to non matching USE:

    =media-gfx/graphviz-12.2.1-r1 X pdf -python_single_target_python3_13 qt6 svg
    =media-gfx/graphviz-12.2.1-r1 X pdf python_single_target_python3_12 -python_single_target_python3_13 qt6 svg
    =media-gfx/graphviz-12.2.1-r1 X pdf qt6 svg
    =media-gfx/graphviz-12.2.1-r1 X pdf -python_single_target_python3_10 qt6 svg
    =media-gfx/graphviz-12.2.1-r1 X pdf -python_single_target_python3_10 python_single_target_python3_12 -python_single_target_python3_13 qt6 svg
    =media-fonts/noto-cjk-20190416 X
    =app-text/texlive-core-2024-r1 X cjk -xetex
    =app-text/texlive-core-2024-r1 X -xetex
    =app-text/texlive-core-2024-r1 -xetex
    =dev-libs/zziplib-0.13.79-r1 sdl

If emerge is allowed, it will simply ignore the above packages,
creating an incomplete installation, which will later fail when
one tries to build docs with images or build PDFs.

After the fix, command line commands to produce the needed USE
chain will be emitted, if they don't exist yet.

        sudo su -c 'echo "media-gfx/graphviz" > /etc/portage/package.use/graphviz'
        sudo su -c 'echo "media-gfx/imagemagick" > /etc/portage/package.use/imagemagick'
        sudo su -c 'echo "media-libs/harfbuzz icu" > /etc/portage/package.use/media-libs'
        sudo su -c 'echo "media-fonts/noto-cjk" > /etc/portage/package.use/media-fonts'
        sudo su -c 'echo "app-text/texlive-core xetex" > /etc/portage/package.use/texlive'
        sudo su -c 'echo "dev-libs/zziplib sdl" > /etc/portage/package.use/zziblib'

The new logic tries to be smart enough to detect for missing files
and missing arguments. Yet, as Gentoo seems to require users to
manage those package.use files by hand, the logic isn't perfect:
users may still need to verify for conflicts on different use
files.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 86 +++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 10 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index cd9c83b17971..94f3d2e32fd6 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -737,22 +737,88 @@ class SphinxDependencyChecker:
             print("You should run:")
         print("\n")
 
+        # Handling dependencies is a nightmare, as Gentoo refuses to emerge
+        # some packages if there's no package.use file describing them.
+        # To make it worse, compilation flags shall also be present there
+        # for some packages. If USE is not perfect, error/warning messages
+        #   like those are shown:
+        #
+        #   !!! The following binary packages have been ignored due to non matching USE:
+        #
+        #    =media-gfx/graphviz-12.2.1-r1 X pdf -python_single_target_python3_13 qt6 svg
+        #    =media-gfx/graphviz-12.2.1-r1 X pdf python_single_target_python3_12 -python_single_target_python3_13 qt6 svg
+        #    =media-gfx/graphviz-12.2.1-r1 X pdf qt6 svg
+        #    =media-gfx/graphviz-12.2.1-r1 X pdf -python_single_target_python3_10 qt6 svg
+        #    =media-gfx/graphviz-12.2.1-r1 X pdf -python_single_target_python3_10 python_single_target_python3_12 -python_single_target_python3_13 qt6 svg
+        #    =media-fonts/noto-cjk-20190416 X
+        #    =app-text/texlive-core-2024-r1 X cjk -xetex
+        #    =app-text/texlive-core-2024-r1 X -xetex
+        #    =app-text/texlive-core-2024-r1 -xetex
+        #    =dev-libs/zziplib-0.13.79-r1 sdl
+        #
+        # And will ignore such packages, installing the remaining ones. That
+        # affects mostly the image extension and PDF generation.
 
-        portages = [
-            "media-gfx/imagemagick",
-            "media-gfx/graphviz",
-        ]
+        # Package dependencies and the minimal needed args:
+        portages = {
+            "graphviz": "media-gfx/graphviz",
+            "imagemagick": "media-gfx/imagemagick",
+            "media-libs": "media-libs/harfbuzz icu",
+            "media-fonts": "media-fonts/noto-cjk",
+            "texlive": "app-text/texlive-core xetex",
+            "zziblib": "dev-libs/zziplib sdl",
+        }
 
         if self.first_hint:
-            for p in portages:
-                result = self.run(["grep", p, "/etc/portage/package.use/*"],
-                                stdout=subprocess.PIPE, text=True)
-                if not result.stdout.strip():
-                    print(f"\tsudo emerge -av1 {p}")
+            use_base = "/etc/portage/package.use"
+            files = glob(f"{use_base}/*")
+
+            for fname, portage in portages.items():
+                install = False
+
+                while install == False:
+                    if not files:
+                        # No files under package.usage. Install all
+                        install = True
+                        break
+
+                    args = portage.split(" ")
+
+                    name = args.pop(0)
+
+                    cmd = ["grep", "-l", "-E", rf"^{name}\b" ] + files
+                    result = self.run(cmd, stdout=subprocess.PIPE, text=True)
+                    if result.returncode or not result.stdout.strip():
+                        # File containing portage name not found
+                        install = True
+                        break
+
+                    # Ensure that needed USE flags are present
+                    if args:
+                        match_fname = result.stdout.strip()
+                        with open(match_fname, 'r', encoding='utf8',
+                                errors='backslashreplace') as fp:
+                            for line in fp:
+                                for arg in args:
+                                    if arg.startswith("-"):
+                                        continue
+
+                                if not re.search(rf"\s*{arg}\b", line):
+                                    # Needed file argument not found
+                                    install = True
+                                    break
+
+                    # Everything looks ok, don't install
+                    break
+
+                # emit a code to setup missing USE
+                if install:
+                    print(f"\tsudo su -c 'echo \"{portage}\" > {use_base}/{fname}'")
 
             self.first_hint = False
 
-        print(f"\tsudo emerge --ask {self.install}")
+        # Now, we can use emerge and let it respect USE
+        print(f"\tsudo emerge --ask --changed-use --binpkg-respect-use=y {self.install}")
 
     #
     # Dispatch the check to an os_specific hinter
-- 
2.50.1


