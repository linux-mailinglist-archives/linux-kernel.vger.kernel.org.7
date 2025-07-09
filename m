Return-Path: <linux-kernel+bounces-723786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E1FAFEB12
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D2A17192C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627DA2EA745;
	Wed,  9 Jul 2025 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRxU+ImK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5BE2E5B2A;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=ThQNfNlXf7b1vqMHoYIxE0Y8Vsn6cgYzF/45epVptpF2JlhKFZqt5tjMcXGUgZ/MaUGMf6WCv+Dw3Gld+ytt/M5B9+rj5FyiewbumAGfGLPDZPQ9Tgfe29WtLGV/olkyRbzHlUeCLYYiMeb109hIG6/Y67jQmiPGCoGjhg9Deao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=Yy7J/4VoJF2hoh3IMFZrdyACnwG/igCZyNXpxhDszW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlN1LSWrDEJwHsXkJqcaEk1mfSyBBAVhKv+N9klG5TyCKWUYfysD1imfBIbDmQRybYGYmnpLdtI9AZu567VjGDIOpdinCu6dtcBN3IFJxkoRmKdwcvSmRu5lfI9DgCTOVvY7GhRZcjuDkOYFFerkwDetDfwA5wfx1qPli4hQRiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRxU+ImK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86866C4CEFC;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=Yy7J/4VoJF2hoh3IMFZrdyACnwG/igCZyNXpxhDszW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nRxU+ImKrFr+absNDBcNqu17DM+zVNoh2D/JL4O0p+jVdEkAKOFz5ODt4m5dI8Xnq
	 HhC9iK+BINEHIAThRZpJQRfYDaDpRBTuGigrWyBfMTsj3vSLHyAiNoZQeacp8mHVA3
	 1pY6BpwGPTfwCzQDsf//yFztLUElvJRHqOHnH7wpFkUraEjOpjl1UIBrVorsTmkdI9
	 ZirStnyRecZESoHwd1JikUen4ksPst32jxLKjiMk1udw6ev6vv1iL3zRcsKWUScOfR
	 bxod9o3/FNgHOHgqq1EkDQpFR+pMeEvhop+mEOHN5r3PO6zR3OfmQDBBhX5L3UouXC
	 UTrWJiUVMK4ig==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECU-1JGs;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/39] scripts: sphinx-pre-install: Address issues with OpenSUSE Leap 15.x
Date: Wed,  9 Jul 2025 15:51:40 +0200
Message-ID: <2d67c2cc005ec27b377bbc2e33e45ca19006ee96.1752067814.git.mchehab+huawei@kernel.org>
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

On openSUSE Leap 15.6, which is the current LTS version, has two
Sphinx packages. The normal one requires Python 3.6, which we
don't support anymore. However, it also has Python 3.11 with a
newer Sphinx version (7.2.6).

Suggest the newer version:

        Detected OS: openSUSE Leap 15.6.
        ERROR: at least python 3.7 is required to build the kernel docs
        Warning: python version is not supported.
        Warning: better to also install "convert".
        Warning: better to also install "dot".
        ERROR: please install "yaml", otherwise, build won't work.
        You should run:

                sudo zypper install --no-recommends ImageMagick graphviz python311-pyyaml

        Sphinx needs to be installed either:
        1) via pip/pypi with:

           Currently not possible.

           Please upgrade Python to a newer version and run this script again

        2) As a package with:

                sudo zypper install --no-recommends python311-Sphinx

            Please note that Sphinx >= 3.0 will currently produce false-positive
           warning when the same name is used for more than one type (functions,
           structs, enums,...). This is known Sphinx bug. For more details, see:
                https://github.com/sphinx-doc/sphinx/pull/8313

        Can't build as 2 mandatory dependencies are missing

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 0a73b1b33842..eca42d90ed01 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -556,6 +556,22 @@ class SphinxDependencyChecker:
 
         progs["latexmk"] = "texlive-latexmk-bin"
 
+        match = re.search(r"(Leap)\s+(\d+).(\d)", self.system_release)
+        if match:
+            rel = int(match.group(2))
+
+            # Leap 15.x uses Python 3.6, which is not compatible with
+            # the build system anymore. Suggest Python 3.11
+            if rel == 15:
+                if not self.which(self.python_cmd):
+                    self.add_package(self.python_cmd, 0)
+
+                progs.update({
+                    "python-sphinx": "python311-Sphinx",
+                    "virtualenv":    "python311-virtualenv",
+                    "yaml":          "python311-pyyaml",
+                })
+
         # FIXME: add support for installing CJK fonts
         #
         # I tried hard, but was unable to find a way to install
-- 
2.49.0


