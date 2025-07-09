Return-Path: <linux-kernel+bounces-723794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D81AFEB0C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808FB1888CFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42372EAB68;
	Wed,  9 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANpv1uxW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F332E6135;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=jkDuDovTpOeqqZBFr8fExHOyGQpsxL8eNaXiFNjvz56wCBmKEo7SB7wEpgMcFV96vW0saP4UjbcCbJRMbLs5K1fCw97ZRkfaCETM798KsmPEDywoG302EpJbE62vZSrHij3TCWiDxAlAz/Bjb+S0JrMGtBqT9zJAIpg/6x3aWk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=coaR5Sph2qr70HI6P7zzhT6A3liWbym2RGbAoiUCuwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftsxATWgnj614AWOK4heOl9SExK/xiMu/RWY3UcdFRIUJIyln6FB0J+b46dr7G9sO55zIQcNQdlGdY+DdEsKp9Fkczm6/kNfTYsZ+c1CLLhMQzaV5W9kCn4ySDC4TxL82wa22OuZorLlHTN9z21Vl/tq/jtc1c2kjbg/bQvh5UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANpv1uxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780CDC4CEFD;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=coaR5Sph2qr70HI6P7zzhT6A3liWbym2RGbAoiUCuwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ANpv1uxWWTSc8CMMwmcBBEJ69A1ibI8R7bxfENDTGbdj5L88Tw+cuDkPOyc3ksFz1
	 TsAsJ6L9q3CL77BAMik/f2RVhEQgGlZLP9fp7sg41mrlInpDbvcXZw08TrFkf5DtfD
	 L4ce1gW0FQykrA3rzJeO/9lmy9B1jUO5d2NYvaYlIj7CVOqC9ExCioUqK21h/D0Rx0
	 jUKRrzmNf1jQOgAQj5Kexyi9au1IPqPiZNfRxbwYAZ5W/gmEgHZR5YB794cUIP+A3U
	 ze7Sy/jSy/EP0ALKZ4uI4HGSL5tiNdjq+SQdZ25UXAcSvxWygV/8rgIdAmJCYOtSTl
	 6TiwvdgeudztA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ED1-2EB3;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/39] scripts: sphinx-pre-install: improve Gentoo package deps logic
Date: Wed,  9 Jul 2025 15:51:51 +0200
Message-ID: <424781c12a0f08f3b0e6e707b0aa140acac5e742.1752067814.git.mchehab+huawei@kernel.org>
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
2.49.0


