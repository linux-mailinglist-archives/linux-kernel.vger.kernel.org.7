Return-Path: <linux-kernel+bounces-765188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2066B22CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101E5621BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCE82FD1D4;
	Tue, 12 Aug 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+w62Pcl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7E42F83B1;
	Tue, 12 Aug 2025 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013985; cv=none; b=ZW0DC2xYHX3OItccQWVKnY9MXg2JxRxZiXqkcGeJiMB1xrMiqs1P8m6THZqa6Ev3XHQJYVC7ucxRJ0/I8pv4pFg3xqQAVuWiNLYGmjsiiukgMfvyapquKZtaQ9mIDrOpXykas7+Yhx+53LTL3WI0UFOhPVlFpm6vNPalCfXCwTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013985; c=relaxed/simple;
	bh=bF+JnX/ikO/qErwMHl0WDLefh6mCv/QIysVRvZKXcRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxtZL2BAsf1QYE2JxsK+lA684qwmxKKV1PhOdbI58Fo4LpE6dKzmaKZ2B0ykUQja4Qc9cRgeC3oxa2qLX+uBaXcvra0M77eey4wDqGB5C9LkCyfi+cAjwuvaYMrdy8La9zJJaGaFgETnaUqpyBGHjunFF5USm9XCGRL1zJdWS6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+w62Pcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46F6C4AF11;
	Tue, 12 Aug 2025 15:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755013984;
	bh=bF+JnX/ikO/qErwMHl0WDLefh6mCv/QIysVRvZKXcRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y+w62Pcl0i05qKOqTFFP+s7JJxZl/RYkpHRrUMugH9WUQ4cd7fIIqAMj/kg8eH/bM
	 c2dsE2Ee1YEHUvjDmeg9DdOkQ6ykPPTpjuRgyODB3Fo4r+m1WIqS3hVe74rHeCVMZ8
	 dVhKk0LURlWZt6W2dxblBPsjpVi/RHPeQBU69Jvrn9sCbgSMNbujdQEEgCFibM4d0T
	 UbVpob1Tsm7bIQs/MCW+vqcxY8cIUIp9ISX7Fovz/K/aeE4U9CXDLoxv5CGJgjIMim
	 hP3yK6ehG3x0F6HafhMpePPzvFGK9uG5tTx08gH5Inc1TetV9pPh8UVAKIPBdzWDy3
	 t4Va+GPTCuQZQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ulrJ8-00000006kWA-24Za;
	Tue, 12 Aug 2025 17:53:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/39] scripts: sphinx-pre-install: add a missing f-string marker
Date: Tue, 12 Aug 2025 17:52:32 +0200
Message-ID: <b0ad1795446b17a00ba2dd83f366e784253668e6.1754992972.git.mchehab+huawei@kernel.org>
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

I forgot one f-string marker, with turned to be affecting 3
lines, because of cut-and-paste ;-)

Use the proper f-string marker to print Sphinx version at
the hint lines. Yet, we don't want to print as a tuple, so
call ver_str() for it.

Ideally, we would be placing it directly at the f-string, but
Python 3.6 f-string support was pretty much limited. Only
3.12 (PEP 701) makes it similar to Perl, allowing expressions
inside it. It sounds that function call itself was introduced
on 3.7.

As we explicitly want this one to run on 3.6, as latest Leap
comes with it, we can't use function calls on f-string.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/sphinx-pre-install.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/sphinx-pre-install.py b/scripts/sphinx-pre-install.py
index de5bcfd052b5..6a244105f7ef 100755
--- a/scripts/sphinx-pre-install.py
+++ b/scripts/sphinx-pre-install.py
@@ -914,12 +914,15 @@ class SphinxDependencyChecker:
         if self.cur_version != (0, 0, 0) and self.cur_version >= RECOMMENDED_VERSION:
             return
 
+        if self.latest_avail_ver:
+            latest_avail_ver = ver_str(self.latest_avail_ver)
+
         if not self.need_sphinx:
             # sphinx-build is present and its version is >= $min_version
 
             # only recommend enabling a newer virtenv version if makes sense.
             if self.latest_avail_ver and self.latest_avail_ver > self.cur_version:
-                print("\nYou may also use the newer Sphinx version {self.latest_avail_ver} with:")
+                print(f"\nYou may also use the newer Sphinx version {latest_avail_ver} with:")
                 if f"{self.virtenv_prefix}" in os.getcwd():
                     print("\tdeactivate")
                 print(f"\t. {self.activate_cmd}")
@@ -940,7 +943,7 @@ class SphinxDependencyChecker:
             # installed one via virtenv with a newer version.
             # So, print commands to enable it
             if self.latest_avail_ver > self.cur_version:
-                print("\nYou may also use the Sphinx virtualenv version {self.latest_avail_ver} with:")
+                print(f"\nYou may also use the Sphinx virtualenv version {latest_avail_ver} with:")
                 if f"{self.virtenv_prefix}" in os.getcwd():
                     print("\tdeactivate")
                 print(f"\t. {self.activate_cmd}")
@@ -954,7 +957,7 @@ class SphinxDependencyChecker:
         # Suggest newer versions if current ones are too old
         if self.latest_avail_ver and self.latest_avail_ver >= self.min_version:
             if self.latest_avail_ver >= RECOMMENDED_VERSION:
-                print("\nNeed to activate Sphinx (version {self.latest_avail_ver}) on virtualenv with:")
+                print(f"\nNeed to activate Sphinx (version {latest_avail_ver}) on virtualenv with:")
                 print(f"\t. {self.activate_cmd}")
                 self.deactivate_help()
                 return
-- 
2.50.1


