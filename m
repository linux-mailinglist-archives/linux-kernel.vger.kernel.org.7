Return-Path: <linux-kernel+bounces-765182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B544B22C97
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F0D2A03EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A7A2FD1DE;
	Tue, 12 Aug 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJvkgrZk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E97C2F83AB;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=aX8/W6ps6suCAFyzSOnTGGKwHSImcGI3ZDtfD4Z6cA21k1gmkNYPwAaPshTF0NpvZu6mL+//WchI/22G8Yyzi5qTll5A6c7hKKshxh1t8BDkESVMVWeR9phlQKS9x4qsJXVRqTs/W/0D3DJ8hu7lvQXRsjtDphyV43dxA/UQ+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=ItIkJyr4HT0xtooM1nUIr4FJ0PKDwnkSm1jezVW3R2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sM7Zw+bSxkv21tTPFBdONOb+yDmS3BHclXljrz8z8ctyhLHE5fWAFglslNFkCEr000rTulmM1ZJ/Zm8nWGARHFL514NB7pWinL/CGytfR743/gM6YiYASsxCMsrpG/aHn/BNlMvxMClotH8KzQFp6Ca0kRelXRe0o+NFr7UQ//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJvkgrZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40B4C4AF1C;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013985;
	bh=ItIkJyr4HT0xtooM1nUIr4FJ0PKDwnkSm1jezVW3R2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJvkgrZkKkXGQJEYFtLP2iaNJg4BLn1zHUONvIY2ZXcext028TZGoOstV3hCweafR
	 XUc/LuJTlrWAYVrL0ub1vli8gnK8cUmIuvixaF0Ks5gLALT0QZwRNLJ/2afFcnyzMa
	 4Yo9GM7RRD80/zrfHt+VNg1XDEz27xyurHFpCWsgCWNEn9R49PdOUONPJfO9Vho+90
	 x0Hnt/reEa7P4UMOOOWj8Lc9wAx3J50KvlSYQOZZ+XzT/v3IDqfPNKL1Tk6qVYNcQx
	 7KIO61BENCltobikUe7tKTw0TcgYEedFdKVV1OeUBzRKUg67pReIquMVzjp6CaP0fm
	 ZugIgCuyOACJA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kWw-3ZWr;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/39] scripts: sphinx-pre-install: move ancillary checkers to a separate class
Date: Tue, 12 Aug 2025 17:52:44 +0200
Message-ID: <e2671eb14fae7a8510f5305ac44ad8063e237a5f.1754992972.git.mchehab+huawei@kernel.org>
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

The code there are just a bunch of static functions that are used by
the main class. group them altogether to better organize the code.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 160 +++++++++++++++++-----------------
 1 file changed, 81 insertions(+), 79 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 47dce1fcddfb..b00e50028f4d 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -150,85 +150,11 @@ class DepManager:
         if output_msg:
             print(f"\n{output_msg}\n")
 
-class SphinxDependencyChecker:
-    # List of required texlive packages on Fedora and OpenSuse
-    texlive = {
-        "amsfonts.sty":       "texlive-amsfonts",
-        "amsmath.sty":        "texlive-amsmath",
-        "amssymb.sty":        "texlive-amsfonts",
-        "amsthm.sty":         "texlive-amscls",
-        "anyfontsize.sty":    "texlive-anyfontsize",
-        "atbegshi.sty":       "texlive-oberdiek",
-        "bm.sty":             "texlive-tools",
-        "capt-of.sty":        "texlive-capt-of",
-        "cmap.sty":           "texlive-cmap",
-        "ctexhook.sty":       "texlive-ctex",
-        "ecrm1000.tfm":       "texlive-ec",
-        "eqparbox.sty":       "texlive-eqparbox",
-        "eu1enc.def":         "texlive-euenc",
-        "fancybox.sty":       "texlive-fancybox",
-        "fancyvrb.sty":       "texlive-fancyvrb",
-        "float.sty":          "texlive-float",
-        "fncychap.sty":       "texlive-fncychap",
-        "footnote.sty":       "texlive-mdwtools",
-        "framed.sty":         "texlive-framed",
-        "luatex85.sty":       "texlive-luatex85",
-        "multirow.sty":       "texlive-multirow",
-        "needspace.sty":      "texlive-needspace",
-        "palatino.sty":       "texlive-psnfss",
-        "parskip.sty":        "texlive-parskip",
-        "polyglossia.sty":    "texlive-polyglossia",
-        "tabulary.sty":       "texlive-tabulary",
-        "threeparttable.sty": "texlive-threeparttable",
-        "titlesec.sty":       "texlive-titlesec",
-        "ucs.sty":            "texlive-ucs",
-        "upquote.sty":        "texlive-upquote",
-        "wrapfig.sty":        "texlive-wrapfig",
-    }
-
-    def __init__(self, args):
-        self.pdf = args.pdf
-        self.virtualenv = args.virtualenv
-        self.version_check = args.version_check
-
-        self.deps = DepManager(self.pdf)
-
-        self.need_symlink = 0
-        self.need_sphinx = 0
-        self.need_pip = 0
-        self.rec_sphinx_upgrade = 0
-        self.verbose_warn_install = 1
-
-        self.system_release = ""
-        self.install = ""
-        self.virtenv_dir = ""
-        self.python_cmd = ""
-        self.activate_cmd = ""
-
-        # Some distros may not have a Sphinx shipped package compatible with
-        # our minimal requirements
-        self.package_supported = True
-
-        # Recommend a new python version
-        self.recommend_python = None
-
-        # Certain hints are meant to be shown only once
-        self.first_hint = True
-
-        self.min_version = (0, 0, 0)
-        self.cur_version = (0, 0, 0)
-        self.latest_avail_ver = (0, 0, 0)
-        self.venv_ver = (0, 0, 0)
-
-        prefix = os.environ.get("srctree", ".") + "/"
-
-        self.conf = prefix + "Documentation/conf.py"
-        self.requirement_file = prefix + "Documentation/sphinx/requirements.txt"
-        self.virtenv_prefix = ["sphinx_", "Sphinx_" ]
-
-    #
-    # Ancillary methods that don't depend on self
-    #
+class AncillaryCheckers:
+    """
+    Ancillary methods that checks for missing dependencies for different
+    types of types, like binaries, python modules, rpm deps, etc.
+    """
 
     @staticmethod
     def which(prog):
@@ -335,6 +261,82 @@ class SphinxDependencyChecker:
 
         return subprocess.run(*args, **kwargs)
 
+class SphinxDependencyChecker(AncillaryCheckers):
+    # List of required texlive packages on Fedora and OpenSuse
+    texlive = {
+        "amsfonts.sty":       "texlive-amsfonts",
+        "amsmath.sty":        "texlive-amsmath",
+        "amssymb.sty":        "texlive-amsfonts",
+        "amsthm.sty":         "texlive-amscls",
+        "anyfontsize.sty":    "texlive-anyfontsize",
+        "atbegshi.sty":       "texlive-oberdiek",
+        "bm.sty":             "texlive-tools",
+        "capt-of.sty":        "texlive-capt-of",
+        "cmap.sty":           "texlive-cmap",
+        "ctexhook.sty":       "texlive-ctex",
+        "ecrm1000.tfm":       "texlive-ec",
+        "eqparbox.sty":       "texlive-eqparbox",
+        "eu1enc.def":         "texlive-euenc",
+        "fancybox.sty":       "texlive-fancybox",
+        "fancyvrb.sty":       "texlive-fancyvrb",
+        "float.sty":          "texlive-float",
+        "fncychap.sty":       "texlive-fncychap",
+        "footnote.sty":       "texlive-mdwtools",
+        "framed.sty":         "texlive-framed",
+        "luatex85.sty":       "texlive-luatex85",
+        "multirow.sty":       "texlive-multirow",
+        "needspace.sty":      "texlive-needspace",
+        "palatino.sty":       "texlive-psnfss",
+        "parskip.sty":        "texlive-parskip",
+        "polyglossia.sty":    "texlive-polyglossia",
+        "tabulary.sty":       "texlive-tabulary",
+        "threeparttable.sty": "texlive-threeparttable",
+        "titlesec.sty":       "texlive-titlesec",
+        "ucs.sty":            "texlive-ucs",
+        "upquote.sty":        "texlive-upquote",
+        "wrapfig.sty":        "texlive-wrapfig",
+    }
+
+    def __init__(self, args):
+        self.pdf = args.pdf
+        self.virtualenv = args.virtualenv
+        self.version_check = args.version_check
+
+        self.deps = DepManager(self.pdf)
+
+        self.need_symlink = 0
+        self.need_sphinx = 0
+        self.need_pip = 0
+        self.rec_sphinx_upgrade = 0
+        self.verbose_warn_install = 1
+
+        self.system_release = ""
+        self.install = ""
+        self.virtenv_dir = ""
+        self.python_cmd = ""
+        self.activate_cmd = ""
+
+        # Some distros may not have a Sphinx shipped package compatible with
+        # our minimal requirements
+        self.package_supported = True
+
+        # Recommend a new python version
+        self.recommend_python = None
+
+        # Certain hints are meant to be shown only once
+        self.first_hint = True
+
+        self.min_version = (0, 0, 0)
+        self.cur_version = (0, 0, 0)
+        self.latest_avail_ver = (0, 0, 0)
+        self.venv_ver = (0, 0, 0)
+
+        prefix = os.environ.get("srctree", ".") + "/"
+
+        self.conf = prefix + "Documentation/conf.py"
+        self.requirement_file = prefix + "Documentation/sphinx/requirements.txt"
+        self.virtenv_prefix = ["sphinx_", "Sphinx_" ]
+
     #
     # Methods to check if a feature exists
     #
-- 
2.50.1


