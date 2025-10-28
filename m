Return-Path: <linux-kernel+bounces-874807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051C3C17240
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA841B24FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC41A355810;
	Tue, 28 Oct 2025 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="UWZFgGM0"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC3A3002CE;
	Tue, 28 Oct 2025 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689427; cv=none; b=f74+U1x8UmpCn0gq7nOlU0MbK+dA0CwOgteJwdW648X1ww396XRw1rZQit6o+omC8mIVKSDLwP7lblK9AfZaMe1B5b47MpWWiKFR04z3tB8nykuIQNIC8tEEYHdQO17+CjfiOkBaSenhjbJLm4blES+NwhX7xrM57c21NFOc//k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689427; c=relaxed/simple;
	bh=kawGsCfUvXr+7vSeBdeE2yqE2s7nhjHnLojMxqecUbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JK4UzYIVJJSpjz6WplUX2qlxhm5shz7R3PQFIkFDnyuJUY/2gax2Y3sbNUF2GzPs0HTK1Xf8yiHb2xL5r58QVknzy1w6kuBC587vLYqth+my/rBusZmqCxWfMgjhnkJBVcMQX62XHVR1O5q6FX9+rCD/293Rlgkaz4UvmPI3t04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=UWZFgGM0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A5D8440B38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761689425; bh=GgmtuNmfwXa+txVVMIvIpG2HLe8hEqtvp0iZpan2vnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UWZFgGM034QfexiT++iLJIxr+7MviBGF/gbsaYmkm028d4FQquKA95U9lpVhBTDi9
	 Ez8G4bljzSljjHc8glFF9HvmbWMcio6aM4IsGgskm9y4dYEPOGqsuetELf1lJ1KnzW
	 65VJaUFl3oJkcuLL3QSyU2EnO82RXhUST8LX0Yj9BWCDP9+5rua70BC60edmQE0IwM
	 +4NDpcuUpKLmoXCEm08zSces5/mxUVIT+8Wkeophb6CphET2IV4OY2bcxoiefPayZn
	 muaqytZ6b91/I9A0mA24iJuY04VAojTbmcq83boDA0arGh83ylHnhdu1EVbbRhctHX
	 p5nyQJ3/iMUNg==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id A5D8440B38;
	Tue, 28 Oct 2025 22:10:24 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v4 1/7] docs: Move the "features" tools to tools/docs
Date: Tue, 28 Oct 2025 16:10:09 -0600
Message-ID: <20251028221017.5785-2-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028221017.5785-1-corbet@lwn.net>
References: <20251028221017.5785-1-corbet@lwn.net>
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

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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


