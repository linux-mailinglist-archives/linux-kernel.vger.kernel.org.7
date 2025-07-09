Return-Path: <linux-kernel+bounces-723800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B212EAFEB29
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3F3164F62
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA352ED164;
	Wed,  9 Jul 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr3TdxNU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E432E62D3;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069142; cv=none; b=F03xLaX7zdUYiLJ+KYyZiHVazRVBEKP+5TM5xc/uVkQA9l5uPyJiu4ZnrA/gpH/ZUZgkHWl53yqT7LpzwWPNdo/0uI9XJfFQAQnBIG6N7iDTM6YFXNL9xWKG0w+3XJX+qQ/aDYiDhtoabBmB93rEnMrzpnltpfMASaFbheqL+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069142; c=relaxed/simple;
	bh=ki5wlJa+Ive/qv1Artc7D8D1XJBHfhfyZzJdUIy50F4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbGcOGMZN/FMiEDXHgHmp7CoDmL4v3ZHIL8KYzkVbCx4ES1FJ/uBvB4NXvw0jlRigso/pBCnIPqmwd6xsGn3rn1IjK244j02z2tAHoyj1OQ1eRxKqQH7uCK2vjbf+8001H1GvJnlI/kKMSMh0Xr4erPzC+9AiUuqZ3C9+wDUiHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr3TdxNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE68BC2BC9E;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069141;
	bh=ki5wlJa+Ive/qv1Artc7D8D1XJBHfhfyZzJdUIy50F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jr3TdxNUPxwDQ0+KAn7MxHZo6eaufpyFTWDuzre1fsTcUiWOgDf6imsmwM2oPfpFc
	 e8re19FLOG4ULbZEDupkuWS5tsCyg2uHmDDMYKO9PWYYvw8XNIbJ3/T2+7Cnfu5Nyz
	 k4vEDOh5hKTc+Zh48pQFqpnHrFYB+mua1kNSCO2QbXzWJSEk6NYlYUi06JcRPFiuBc
	 RIqIIRhuCqco1O8ycuMMFjOziAX6JjiKYUWe5VN7kpNNB4Q7N/+xy4KD07vmLgDCif
	 Rb8GSEiUMkJp9WcCq3jBT+LYRZg/nGoYZOpMbHaW2RUos18gOulDhuDd0uuJu4J13o
	 RMcYlN4RPdL9A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ED7-2Ol3;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/39] scripts: sphinx-pre-install: move package instructions to a new func
Date: Wed,  9 Jul 2025 15:51:53 +0200
Message-ID: <243a2d17dcbf262fb5eff8d66cdb78be35bd1aca.1752067814.git.mchehab+huawei@kernel.org>
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

Currently, if Python < 3.7, package install will fail. That happens
with OpenSuse Leap and RHEL-based ver 8 distros.

OpenSuse allows installing Sphinx with Python 3.11, but RHEL-based
distros don't.

Prepare to recomend only venv on such cases. For now, just split
the recomendation on a new function that will check for a
paramtere to be called.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 44 +++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index 2f6036eadc94..2360ca2ed21c 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -89,6 +89,9 @@ class SphinxDependencyChecker:
         self.python_cmd = ""
         self.activate_cmd = ""
 
+        # Some distros may not have a Sphinx shipped package compatible with
+        # our minimal requirements
+        self.package_supported = True
         # Certain hints are meant to be shown only once
         self.first_hint = True
 
@@ -969,6 +972,27 @@ class SphinxDependencyChecker:
 
         return self.latest_avail_ver
 
+    def recommend_package(self):
+
+        print("\n2) As a package with:")
+
+        old_need = self.need
+        old_optional = self.optional
+        self.missing = {}
+        self.pdf = False
+        self.optional = 0
+        self.install = ""
+        old_verbose = self.verbose_warn_install
+        self.verbose_warn_install = 0
+
+        self.add_package("python-sphinx", 0)
+
+        self.check_distros()
+
+        self.need = old_need
+        self.optional = old_optional
+        self.verbose_warn_install = old_verbose
+
     def recommend_sphinx_version(self, virtualenv_cmd):
         # The logic here is complex, as it have to deal with different versions:
         #	- minimal supported version;
@@ -1053,24 +1077,8 @@ class SphinxDependencyChecker:
             print(f"\tpip install -r {self.requirement_file}")
             self.deactivate_help()
 
-        print("\n2) As a package with:")
-
-        old_need = self.need
-        old_optional = self.optional
-        self.missing = {}
-        self.pdf = False
-        self.optional = 0
-        self.install = ""
-        old_verbose = self.verbose_warn_install
-        self.verbose_warn_install = 0
-
-        self.add_package("python-sphinx", 0)
-
-        self.check_distros()
-
-        self.need = old_need
-        self.optional = old_optional
-        self.verbose_warn_install = old_verbose
+        if self.package_supported:
+            self.recommend_package()
 
         print("\n" \
               "    Please note that Sphinx >= 3.0 will currently produce false-positive\n" \
-- 
2.49.0


