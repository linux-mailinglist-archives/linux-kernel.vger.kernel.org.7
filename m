Return-Path: <linux-kernel+bounces-723782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C41AFEB11
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2865916F64A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C342E8DEC;
	Wed,  9 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPliMzAf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889862E5B08;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=UuB483cqZjqP104Vv70DqdEhpf6jkAddubQHCal4TVViqGruI8Flyp6fvAvWSKvca/7PEht/BmFPQyXGFzpMmFLUxcWBKnBHj33mZmposTf378FSQmfJZYDIxJzr+VubHNwhH5h4cWusoUypTaLED/F0QveOn72y3bl18jqTCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=cFBLDKNOa0cAvpqcz75eL+YkNUnkHhNOQfpoyeRf6Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDKvicaEHJRVE0a8gWt3QNxOhvUPsnH7sO16PVNfsEneFoyrOErkK0Z8yTpajsMMAjKNiX5fsnJW4BPzBhiJfHNFdJGiKeCIazenSkh19uXuMhStsnFDFikC/FGhFxe9e1+c8JvSCF9yi/VkK5EgK8VPNa6BryzhbX98WdCdsmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPliMzAf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4377C4AF10;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=cFBLDKNOa0cAvpqcz75eL+YkNUnkHhNOQfpoyeRf6Hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPliMzAf3njyuzZfLwW05Ceh/4IgNefqHpq5AsO/WIyROwZu92xeSsohvsvmiNeLZ
	 PQJUc6eYGMspbz23cSf0dI0IKkGOSs1rRfXNk1cw7qf/2inVbTOq/Wv1oRnoECkDgk
	 QdJXdQb+BPBScMTT9YR7OyBFtrCq8OSbOidyawMc875gSU1fvcOvKzs6e4rgCjdsaO
	 r7dSwXJbp2SwPqBfgvTgrhKYo82EkM/MiYtqYwvNXchIBc399iJ27g7X08DkARXp81
	 +zl5auA4092lmLeVkdStd4tx864piV7stVGPogA/1tCy+hkllhBpJG1UeQz9BUkDJx
	 1FeXyjemo/svg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDS-307S;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 28/39] scripts: sphinx-pre-install: add more generic checkers on a class
Date: Wed,  9 Jul 2025 15:52:00 +0200
Message-ID: <bdf261a8fc29a06d41168244cac2b0ba45efe13c.1752067814.git.mchehab+huawei@kernel.org>
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

Better organize the code by moving the more generic methods
to MissingCheckers. Such class contain only binary and package
dependent missing checkers, but no distro-specific data or code.

All distro-specific data/code remains at SphinxDependencyChecker
class.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 142 ++++++++++++++++++----------------
 1 file changed, 76 insertions(+), 66 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index b00e50028f4d..9127487bd4d7 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -150,7 +150,7 @@ class DepManager:
         if output_msg:
             print(f"\n{output_msg}\n")
 
-class AncillaryCheckers:
+class AncillaryMethods:
     """
     Ancillary methods that checks for missing dependencies for different
     types of types, like binaries, python modules, rpm deps, etc.
@@ -261,81 +261,24 @@ class AncillaryCheckers:
 
         return subprocess.run(*args, **kwargs)
 
-class SphinxDependencyChecker(AncillaryCheckers):
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
+class MissingCheckers(AncillaryMethods):
 
-    def __init__(self, args):
+    def __init__(self, args, texlive):
         self.pdf = args.pdf
         self.virtualenv = args.virtualenv
         self.version_check = args.version_check
+        self.texlive = texlive
 
         self.deps = DepManager(self.pdf)
 
         self.need_symlink = 0
         self.need_sphinx = 0
-        self.need_pip = 0
-        self.rec_sphinx_upgrade = 0
+
         self.verbose_warn_install = 1
 
-        self.system_release = ""
-        self.install = ""
         self.virtenv_dir = ""
-        self.python_cmd = ""
-        self.activate_cmd = ""
 
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
+        self.install = ""
 
     #
     # Methods to check if a feature exists
@@ -460,9 +403,9 @@ class SphinxDependencyChecker(AncillaryCheckers):
             if match:
                 return parse_version(match.group(1))
 
-    def check_sphinx(self):
+    def check_sphinx(self, conf):
         try:
-            with open(self.conf, "r", encoding="utf-8") as f:
+            with open(conf, "r", encoding="utf-8") as f:
                 for line in f:
                     match = re.match(r"^\s*needs_sphinx\s*=\s*[\'\"]([\d\.]+)[\'\"]", line)
                     if match:
@@ -513,6 +456,73 @@ class SphinxDependencyChecker(AncillaryCheckers):
 
         return True
 
+class SphinxDependencyChecker(MissingCheckers):
+
+    def __init__(self, args):
+        # List of required texlive packages on Fedora and OpenSuse
+        texlive = {
+            "amsfonts.sty":       "texlive-amsfonts",
+            "amsmath.sty":        "texlive-amsmath",
+            "amssymb.sty":        "texlive-amsfonts",
+            "amsthm.sty":         "texlive-amscls",
+            "anyfontsize.sty":    "texlive-anyfontsize",
+            "atbegshi.sty":       "texlive-oberdiek",
+            "bm.sty":             "texlive-tools",
+            "capt-of.sty":        "texlive-capt-of",
+            "cmap.sty":           "texlive-cmap",
+            "ctexhook.sty":       "texlive-ctex",
+            "ecrm1000.tfm":       "texlive-ec",
+            "eqparbox.sty":       "texlive-eqparbox",
+            "eu1enc.def":         "texlive-euenc",
+            "fancybox.sty":       "texlive-fancybox",
+            "fancyvrb.sty":       "texlive-fancyvrb",
+            "float.sty":          "texlive-float",
+            "fncychap.sty":       "texlive-fncychap",
+            "footnote.sty":       "texlive-mdwtools",
+            "framed.sty":         "texlive-framed",
+            "luatex85.sty":       "texlive-luatex85",
+            "multirow.sty":       "texlive-multirow",
+            "needspace.sty":      "texlive-needspace",
+            "palatino.sty":       "texlive-psnfss",
+            "parskip.sty":        "texlive-parskip",
+            "polyglossia.sty":    "texlive-polyglossia",
+            "tabulary.sty":       "texlive-tabulary",
+            "threeparttable.sty": "texlive-threeparttable",
+            "titlesec.sty":       "texlive-titlesec",
+            "ucs.sty":            "texlive-ucs",
+            "upquote.sty":        "texlive-upquote",
+            "wrapfig.sty":        "texlive-wrapfig",
+        }
+
+        super().__init__(args, texlive)
+
+        self.need_pip = 0
+        self.rec_sphinx_upgrade = 0
+
+        self.system_release = ""
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
 
     #
     # Distro-specific hints methods
@@ -1187,7 +1197,7 @@ class SphinxDependencyChecker(AncillaryCheckers):
         self.python_cmd = sys.executable
 
         # Check if Sphinx is already accessible from current environment
-        self.check_sphinx()
+        self.check_sphinx(self.conf)
 
         if self.system_release:
             print(f"Detected OS: {self.system_release}.")
-- 
2.49.0


