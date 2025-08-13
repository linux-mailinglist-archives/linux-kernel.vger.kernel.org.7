Return-Path: <linux-kernel+bounces-767515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A332B25582
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC01189D782
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE27B309DB0;
	Wed, 13 Aug 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kh8pRt1B"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A9F4FA;
	Wed, 13 Aug 2025 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120756; cv=none; b=gY8V9kjxRh2PYbAPl7w+eyf0N6npaLAWnlUAVATkIivJzNhiDwb2+rE9YbRwqMkELmC2xQ9X8QagkakuKoys48PjG9TpuwI9Ycf40KNlMJHiElemp2cTlqLoBbroXhn2fS2VWe6IM0oSy2CPSuYIB66NndlAuIuHLR3JwuJUq+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120756; c=relaxed/simple;
	bh=RGGrljcHtBNsV9dA5thNwiPGsF27rSe2lon6zIKk04s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCWgo2pIMExa5AS+9oY8MF+tvmAClsiJCRgdGRndtagj5UTdmpaqmFHxYUDPavt5Xj+0j1OHMnSa4TeTcGBbfNxp5rZwRu/NbFJC5qFIyNfkXMlQgFMpjWFqIl2sqk+D8KB5GdQVYvn5G9hsnggDJ81h+R1sKVbTOg7Cb2Iu79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kh8pRt1B; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DF34940AF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755120748; bh=CzjeRF3zEfcug+dawfkO511YWICGxQRsIv8DTRbd8oQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kh8pRt1BBFms4rVRHqjKXNgeVLqr327kp9YARc/RClq529zhBN6d4tRG/AQspHRpQ
	 sJ3/pysQnQxsqbB8pcSS8bVXegYpUV+dYlapwsljqmpyaRB7AqjH+04/xfSlaU2XSV
	 l0rHSf8v1EnyV9cEIyTtco6F1/pMBadQmeR4di07fSS1osrnXo35zx7FQqd0vLdRPI
	 knMPrQURnAvE/u54lrYYxApPs7UEKa+10c7Ilm1OO5IVQs/N5uCE8PyuwZhfucJOs2
	 uOf7+/bNDZlvEx7qyXh8jUKZRxhyu0QnQBMJSDRuv8KfMyPvpzzHdhGPpa6FgZHsN+
	 rcPh7cWCWNnjw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id DF34940AF4;
	Wed, 13 Aug 2025 21:32:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 01/13] docs: Move the "features" tools to tools/doc
Date: Wed, 13 Aug 2025 15:32:00 -0600
Message-ID: <20250813213218.198582-2-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813213218.198582-1-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The scripts for managing the features docs are found in three different
directories; unite them all under tools/doc and update references as
needed.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx/kernel_feat.py                           | 4 ++--
 .../features/scripts => tools/doc}/features-refresh.sh        | 0
 {scripts => tools/doc}/get_feat.pl                            | 2 +-
 {Documentation/features => tools/doc}/list-arch.sh            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename {Documentation/features/scripts => tools/doc}/features-refresh.sh (100%)
 rename {scripts => tools/doc}/get_feat.pl (99%)
 rename {Documentation/features => tools/doc}/list-arch.sh (83%)

diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index e3a51867f27b..5453a7b1fc9f 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -13,7 +13,7 @@
     :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
 
     The ``kernel-feat`` (:py:class:`KernelFeat`) directive calls the
-    scripts/get_feat.pl script to parse the Kernel ABI files.
+    tools/doc/get_feat.pl script to parse the Kernel ABI files.
 
     Overview of directive's argument and options.
 
@@ -83,7 +83,7 @@ class KernelFeat(Directive):
         srctree = os.path.abspath(os.environ["srctree"])
 
         args = [
-            os.path.join(srctree, 'scripts/get_feat.pl'),
+            os.path.join(srctree, 'tools/doc/get_feat.pl'),
             'rest',
             '--enable-fname',
             '--dir',
diff --git a/Documentation/features/scripts/features-refresh.sh b/tools/doc/features-refresh.sh
similarity index 100%
rename from Documentation/features/scripts/features-refresh.sh
rename to tools/doc/features-refresh.sh
diff --git a/scripts/get_feat.pl b/tools/doc/get_feat.pl
similarity index 99%
rename from scripts/get_feat.pl
rename to tools/doc/get_feat.pl
index 40fb28c8424e..d75e7c85dc85 100755
--- a/scripts/get_feat.pl
+++ b/tools/doc/get_feat.pl
@@ -18,7 +18,7 @@ my $enable_fname;
 my $basename = abs_path($0);
 $basename =~ s,/[^/]+$,/,;
 
-my $prefix=$basename . "../Documentation/features";
+my $prefix=$basename . "../../Documentation/features";
 
 # Used only at for full features output. The script will auto-adjust
 # such values for the minimal possible values
diff --git a/Documentation/features/list-arch.sh b/tools/doc/list-arch.sh
similarity index 83%
rename from Documentation/features/list-arch.sh
rename to tools/doc/list-arch.sh
index ac8ff7f6f859..96fe83b7058b 100755
--- a/Documentation/features/list-arch.sh
+++ b/tools/doc/list-arch.sh
@@ -8,4 +8,4 @@
 
 ARCH=${1:-$(uname -m | sed 's/x86_64/x86/' | sed 's/i386/x86/' | sed 's/s390x/s390/')}
 
-$(dirname $0)/../../scripts/get_feat.pl list --arch $ARCH
+$(dirname $0)/get_feat.pl list --arch $ARCH
-- 
2.50.1


