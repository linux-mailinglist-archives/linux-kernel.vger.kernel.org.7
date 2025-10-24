Return-Path: <linux-kernel+bounces-869481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B26C07FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C49F44EC3F5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B222E62AF;
	Fri, 24 Oct 2025 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="HAXCuvIA"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B42A2E1C63;
	Fri, 24 Oct 2025 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336533; cv=none; b=HNCjbr6S5tKJLbaz9niJqYl7Qqcd6VCJi+VU2ov+i3dzLxBz1tTez2+qyhpv6t3LG6FE/qTIRqO6HlQkL5oO7SpWJ56Aixn7+IWlt2YS3Xp3BqMPaI/GXeLCaXMcOy2qmFNALkLs3UkAmCy35uH6GqlZW1rmcp7N9ogGCvV/GDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336533; c=relaxed/simple;
	bh=TdHXcDiNWao5l+MSzK2kBWUaJug8oDVRsNcOEnrV9QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjWDsCXgJVyZ20HSFMMluglUV/IPWBeDsi5W1MELgv6OluFXrDkZ5KC2KrJEJIXfHiFTopiurqfk9pma4nDO8ZxWsXps1tEiCGvinDbBxsmvA+NjSEFplMAmeDx+8/NOETI9Ef3o2qTe/jn4S354/weUMB7GhRb0sdpFTGyGXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=HAXCuvIA; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1F3EB40B38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761336524; bh=a07wvbJJF2Sphbu4YX87L2J5mPBdv/tkJJyhVfoX/G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HAXCuvIA4jJ3+oXl7FHzqrcMyyz2kOCedKHnh4Ur8+uyqNN9fvfDl7f22m+Jpzmgn
	 sp16Xu6/hWumMuoM3MRAgYfft3C4AEY9e9QUjxMwQtfVNsd9Icjda8wY6LKoV59zAt
	 l7Aoh2P2ab2YDfWLvp7dhTFcsl9ZaUkOQhodQmn1xTllZ9CPJPOsnx/1foSGtHBKw4
	 zRv/eGQiqAssoLr+tGuTVPRtzu+YKnIHThruX8tjqHMG10UHXcZNC4Vf2RhcR/EMld
	 uWvqVKiR2+pQu/QEvwf3dilfUJ6aD3oXitaoRTvpni18kpL2ZGpJ/Gf0OUw1iK3GlY
	 w9oA1TpfZiS+A==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 1F3EB40B38;
	Fri, 24 Oct 2025 20:08:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v3 1/8] docs: Move the "features" tools to tools/docs
Date: Fri, 24 Oct 2025 14:08:22 -0600
Message-ID: <20251024200834.20644-2-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024200834.20644-1-corbet@lwn.net>
References: <20251024200834.20644-1-corbet@lwn.net>
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

Acked-by: Jani Nikula <jani.nikula@intel.com>
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
index aaac76892ceb..81c67ef23d8d 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -13,7 +13,7 @@
     :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
 
     The ``kernel-feat`` (:py:class:`KernelFeat`) directive calls the
-    scripts/get_feat.pl script to parse the Kernel ABI files.
+    tools/docs/get_feat.pl script to parse the Kernel ABI files.
 
     Overview of directive's argument and options.
 
@@ -85,7 +85,7 @@ class KernelFeat(Directive):
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


