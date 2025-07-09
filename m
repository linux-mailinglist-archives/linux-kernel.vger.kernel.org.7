Return-Path: <linux-kernel+bounces-723776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B482AFEB05
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8587058277C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36442E92B2;
	Wed,  9 Jul 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoMPIdfx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7956F2E54B5;
	Wed,  9 Jul 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069141; cv=none; b=ROooTBHZtW4h8PmcUUZS86Dbj/Oi3xbnzMQHYGM+iYSK7Czz+fRI8JLduMFj6mNiyOOVKfz9K4TxgIOd0E/iaK9w0uIYFp+ByiuhNDePfTuGjSChYPjUnfeJdtT7Hwmx5UOYy705kieyU4TTayCv2PXtnP4XGtSXtxn3XlCm+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069141; c=relaxed/simple;
	bh=9Jx/W99p/t5XFLDw498BHo4ed17hE2P+Zs79xhnHe/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBcS1c6m9hsXwJF9aP6oQ0VlvjXSFt5fiJcUCTedjrkJu/Oul3L87KF3P76buBkV4r2CgbJFX9s9P3wC/6+eTnRRAwQj6CCOz/YWlJD9yv5FOAZ4XrWZwURdKsRnSfaM505HBe7NSSyGgDPwqi/RZ8Y3YxZuNX/dmMXnVAUAoKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoMPIdfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE86C4CEFE;
	Wed,  9 Jul 2025 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752069140;
	bh=9Jx/W99p/t5XFLDw498BHo4ed17hE2P+Zs79xhnHe/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YoMPIdfx6CCVfaSvAEwo09TJsNDCb4mMCkwAfUh1b4IkyoBI1VKYrYfa8hJvEkouQ
	 Ga7ZTCHZ0amlWcWxjzpDprmjILYs9hpcNya7fq69bntPk4n8oDgP+YREZOkeViYNZs
	 feOzCM3S0hWxkXVsj5T/mSkvZ9RXHo27oO7z4t9kEzy7qZB0ap5TU37V+XRKzckrUF
	 auOyY+xxgiKvNqG+z+6Waafml32KocnokUh2IdOryiz2Jb7JbviM7sbQtL2rKRMEdz
	 NznN3OFD0X5jrzAfXJpl9H0vJc7X/3/mCj1KTdyMVIeI+G+HwvHN8fK5X3ngaZVpyT
	 z2XijSdHaufnw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1uZVDd-00000000ECp-1tpT;
	Wed, 09 Jul 2025 15:52:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 15/39] scripts: sphinx-pre-install: add a missing f-string marker
Date: Wed,  9 Jul 2025 15:51:47 +0200
Message-ID: <f27ae904076159916a01016263275fdafc301df6.1752067814.git.mchehab+huawei@kernel.org>
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
2.49.0


