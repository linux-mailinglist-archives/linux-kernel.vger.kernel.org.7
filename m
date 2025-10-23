Return-Path: <linux-kernel+bounces-867344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 492B3C02549
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BFDF1897996
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665352882CD;
	Thu, 23 Oct 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Oot65kqp"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185D218AD4;
	Thu, 23 Oct 2025 16:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235852; cv=none; b=utZiIbmN+tgefBT7XJpsxv0g9/RnmekCfR+Dwgxtjq7B3+eny8yUQaoSfGLZMQiKeR+suTLyg5cXEluhS5VUh9Nvk+KjGLutT7NGvIew0tpvDVXjxxwrs4JA5+QNR0BfnzcwHnclHnPE18oseXCr31nW/iajt120v2OPl5yJKng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235852; c=relaxed/simple;
	bh=pmQLm6GEGlG7rBrfuxiItNE41J2dqW27S9NcsdSbcMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FC43dQe/imefBmfywr89glGZdmi/+NJ6XMv8AM/0Cem2nWnPE3M89jZEpqyHJGJvGaEWEt8vuRcBXkJ5c1sbiaKH+gnvGxCUPw3IJ4IFsSeZzH4/kBvIBwDK5kmMbxszbhNjWPaeK6LlZ10KE9PZSUK5XDmEl0JP278hduze+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Oot65kqp; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B46C340B37
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761235844; bh=7B+dnWNof1Zmrb1t2MzOBFBQHsy9rJcjISIjjcS4SK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oot65kqpph1+1J4i0Fe/S6cOstraUtnU6lXtGzDb1zhh7MkG/pFtmttbTYnFOXpdG
	 5or2ypERdelTtlO53XeEmsqS00bhBuTD5hlWOHCWJ0F4+YYHr7DVYtdKFXAxKPG40D
	 tYg4slzgM2W66QaXHQ6uIIvrac7AhytDogwCyKuVWusIpH2Fc61DO9wnqR+kX1aObR
	 iJvml97ioIt6yueU4/oATU+s0fVZfiWE+zEsnk3gTBRhXTIGQriOBBoL299wBBCTQx
	 kHr7vRwTKrpJzVVFShKloZjvP+kHZKCbce++hnqtaS2DQYDOjP+q8PxlJ5Ln++nake
	 e9c20DFIGQgDg==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id B46C340B37;
	Thu, 23 Oct 2025 16:10:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 01/10] docs: Move the "features" tools to tools/docs
Date: Thu, 23 Oct 2025 10:10:09 -0600
Message-ID: <20251023161027.697135-2-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023161027.697135-1-corbet@lwn.net>
References: <20251023161027.697135-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scripts for managing the features docs are found in three different
directories; unite them all under tools/docs and update references as
needed.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx/kernel_feat.py                           | 4 ++--
 .../features/scripts => tools/docs}/features-refresh.sh       | 0
 {scripts => tools/docs}/get_feat.pl                           | 2 +-
 {Documentation/features => tools/docs}/list-arch.sh           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename {Documentation/features/scripts => tools/docs}/features-refresh.sh (100%)
 rename {scripts => tools/docs}/get_feat.pl (99%)
 rename {Documentation/features => tools/docs}/list-arch.sh (83%)

diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index e3a51867f27b..aa56fa8f32bd 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -13,7 +13,7 @@
     :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
 
     The ``kernel-feat`` (:py:class:`KernelFeat`) directive calls the
-    scripts/get_feat.pl script to parse the Kernel ABI files.
+    tools/docs/get_feat.pl script to parse the Kernel ABI files.
 
     Overview of directive's argument and options.
 
@@ -83,7 +83,7 @@ class KernelFeat(Directive):
         srctree = os.path.abspath(os.environ["srctree"])
 
         args = [
-            os.path.join(srctree, 'scripts/get_feat.pl'),
+            os.path.join(srctree, 'tools/docs/get_feat.pl'),
             'rest',
             '--enable-fname',
             '--dir',
diff --git a/Documentation/features/scripts/features-refresh.sh b/tools/docs/features-refresh.sh
similarity index 100%
rename from Documentation/features/scripts/features-refresh.sh
rename to tools/docs/features-refresh.sh
diff --git a/scripts/get_feat.pl b/tools/docs/get_feat.pl
similarity index 99%
rename from scripts/get_feat.pl
rename to tools/docs/get_feat.pl
index 40fb28c8424e..d75e7c85dc85 100755
--- a/scripts/get_feat.pl
+++ b/tools/docs/get_feat.pl
@@ -18,7 +18,7 @@ my $enable_fname;
 my $basename = abs_path($0);
 $basename =~ s,/[^/]+$,/,;
 
-my $prefix=$basename . "../Documentation/features";
+my $prefix=$basename . "../../Documentation/features";
 
 # Used only at for full features output. The script will auto-adjust
 # such values for the minimal possible values
diff --git a/Documentation/features/list-arch.sh b/tools/docs/list-arch.sh
similarity index 83%
rename from Documentation/features/list-arch.sh
rename to tools/docs/list-arch.sh
index ac8ff7f6f859..96fe83b7058b 100755
--- a/Documentation/features/list-arch.sh
+++ b/tools/docs/list-arch.sh
@@ -8,4 +8,4 @@
 
 ARCH=${1:-$(uname -m | sed 's/x86_64/x86/' | sed 's/i386/x86/' | sed 's/s390x/s390/')}
 
-$(dirname $0)/../../scripts/get_feat.pl list --arch $ARCH
+$(dirname $0)/get_feat.pl list --arch $ARCH
-- 
2.51.0


