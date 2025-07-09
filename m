Return-Path: <linux-kernel+bounces-723801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34926AFEB20
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6ECC1889341
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D272D2ED85D;
	Wed,  9 Jul 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j612QRsW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0202E6D08;
	Wed,  9 Jul 2025 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069142; cv=none; b=ZnpUolnOqjcWhTZA8quoHIBOTYYHd8lkPUch+nv7ruR8e7Pd7dNOHOGAqPWPGmgQvKJZkankYRZmnBlKTRQGeIDTqkqll38NMmbvs4JiBX+jhivSke+5rrRxSbWnr4Z2aDgzWaUV0MdoudPDrYASE6WyYPAOC12Wm/xTVVZh5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069142; c=relaxed/simple;
	bh=QTYVPi5+QHYNlWAjLlwESsHYWhntymHRulFXntyK2Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WeMSlRF+HrGN7WZTSxpMWzuo5jhZnA9yr2AGbI2Xexh+Gz+4iuXguhq722TG1umh7lJiZJEndPqS7wf7Ke8QcVk7kq4594MkqwjuVb+yNDjUe4Zm/o2C3oK9ZsEU+l9cCHF5DoZdrQ1EOgfhjLPjRixlFtA840ciBWR7Rnj4e6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j612QRsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBA5C4CEF8;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=QTYVPi5+QHYNlWAjLlwESsHYWhntymHRulFXntyK2Ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j612QRsWx48p2RmEwVw4V78JHpb7j1E5lUslmENJznu/IINFtAsBrLyu6jcYECrf2
	 MEumM0KFPc43kxIVTi8DLn8476dzHluDF/j9vTUPBtGWROLYgLF43XQdg9BaCwBjnD
	 fw7Hd7A8edE6/g+n6wfAva7JqJ6VEcf3YXRxp2eh5gwVdTcNiyeUgmm4BWtE3AL6dY
	 qFFnOENBJyaV0z3kbSYjvQhKhF2+GAjwo99RvQkX6oD42l64kAhyfkHmdsLxSNadWT
	 guN0nxTLARrmlC+cxYT8dY1yHRkXnigzPRity+n/lIGq4p/Aoyq1yjbCC5XKT80686
	 kFfzsUsyTjz6w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000EDP-2uMQ;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 27/39] scripts: sphinx-pre-install: move ancillary checkers to a separate class
Date: Wed,  9 Jul 2025 15:51:59 +0200
Message-ID: <335809ee3f373a2f4193be259c3f0bf769f4c0b9.1752067814.git.mchehab+huawei@kernel.org>
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
2.49.0


