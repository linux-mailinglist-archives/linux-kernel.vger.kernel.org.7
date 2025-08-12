Return-Path: <linux-kernel+bounces-765169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9325DB22C79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2A6189DC5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEF02FA814;
	Tue, 12 Aug 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/piWB0h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471412F2907;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=XRpVE7yB4e0Z4CsghXvrUtFLG/yTFcdVr0uR0N58gBr14S4QJonX73bN7ZWdQWN1wKKBX3ghmKGNvR/Jp6JP9TExMFqD+pDOlTgI2rlMBLVW1LKS8Imk5QjKYp2oKC+zA7nAEr00MGsxYSCEoq0JO4ezUhyIWHxP2R1OuiQaoWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=d4OYIow3OjJEsE2LMoKb03hk1/jC/7h0+7RSb/71xC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mM6/m86vob6qb+XZEcvXHEYPeP9wEWIItWVfQMwaymJPz2dj9Hh1ZPX0gwLTuUd9ueDLg5b9GcdDxDy36z8XReRVaNBk9BeY3ZYDPfVdTCm6vCNpjZn52ROWB4hWaISaEUlJrhVJf67uyIfGPp4cIEW2n6vo/8IaBrWN/hzfcZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/piWB0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C410CC4CEFD;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=d4OYIow3OjJEsE2LMoKb03hk1/jC/7h0+7RSb/71xC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/piWB0hMGMC1sBe5DyHaYshf7X/mSl8VjLYGoeKH9AgWtppEu5xZQaE7sjHEWW4x
	 y/VW2mNX/hKM6bA4/VG4znCRo31Af1qfd0IURd+K3k4xGbQKpls3ygD4uysuDGnGyL
	 gJB1yr+wT9Gjj+yeRqt0ODWzcQQ8IuSdciATCLTPIWj9bvjWUv27EGKpN00T5XplcF
	 ebP3r3lSFT67PkO1yGBfEbbKlSrltbZWG9k2Lt0dILkcKSif8GAKvl0g1PFbHL5QyZ
	 d6XZn1mJhUJKjzehI5BHU5wk36mW8g4kN9z8MrfGunICgfyRRN1VZ4nXrfiPXFkzXx
	 tah17j+rIZ40Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kVi-1D9E;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/39] scripts: sphinx-pre-install: Address issues with OpenSUSE Leap 15.x
Date: Tue, 12 Aug 2025 17:52:25 +0200
Message-ID: <a1600e292b63f96f40163e350238812158ebd6c2.1754992972.git.mchehab+huawei@kernel.org>
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
2.50.1


