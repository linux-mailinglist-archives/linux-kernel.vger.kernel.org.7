Return-Path: <linux-kernel+bounces-869482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71113C07FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B111501200
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3762E7641;
	Fri, 24 Oct 2025 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="dMJGEN62"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4ED2E283A;
	Fri, 24 Oct 2025 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336533; cv=none; b=RLOjn6z1hFgsjzMbziwoZuSvsIKbHU5uE2si6WacDsJFvAd5lPXBRyYi24yeFpMLu+hhhB0xYjT2ouCyNsubGeDsQyA461rU+wemeHHXsvKIP5B1Xg1IBTj1ySEo2djR3UD6EQO9LgyqIgheT5TiL0Wf+Wcnvi36ccHIQqQoBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336533; c=relaxed/simple;
	bh=BJM6rksB/mI3U0nzwLElhOR5H27udwbWSIvyVXTQBeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqjpV3j0cyEmB9vMaYJLfojv2rQLmdIitL2KSXKcDTahJ4+y0uW1zJoXTL8X8N1b3s6gA9tNMuOg5EEWL9GzxfUlXwoe48ycJ45VjRH650onDmjk7ZD0a5z97V51oytnbCbpWy76nc+R1kgh4OhTuM8DoZlL6/4d2+RT1StH2JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=dMJGEN62; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E0A8D40C29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761336526; bh=OqcmgG5y5pz2b2qMWeVYfNKx46YGBJkCkE+Pc29vERk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dMJGEN62FvaP/mHFS4goEtAV6c9/Hi3Wcgku/ISUAAgQjcetxMXWz6g+E+WSyMxdp
	 UASlaRM91q9zu6/uRXE9Uw9JPzSZ0AuMM+uzwDv5UByLP18MHesBjW4abvtqztuWhP
	 b3gR/H44dusHjHYkLb83r6gb4aGyMPCSlAhn27pP2bvY9ldiU8cQmgZwml5O9VS/nn
	 BCwMMbzISSokqqKTMfxoL6ewd1bTBbOVFP2luhGTP1Xte0sY2hHtxxiG0G2Q9U78+X
	 9cAoGGU5Ezxu1ki5jJqcP+shQtyAt4QP907rwvc241ujvk0RLEXkf7f+9Mmtplo9wE
	 /li1HY1iTOKqQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id E0A8D40C29;
	Fri, 24 Oct 2025 20:08:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v3 3/8] docs: move scripts/documentation-file-ref-check to tools/docs
Date: Fri, 24 Oct 2025 14:08:24 -0600
Message-ID: <20251024200834.20644-4-corbet@lwn.net>
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

Add this script to the growing collection of documentation tools.

Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/Makefile                               | 4 ++--
 MAINTAINERS                                          | 2 --
 {scripts => tools/docs}/documentation-file-ref-check | 2 +-
 tools/docs/sphinx-pre-install                        | 2 +-
 4 files changed, 4 insertions(+), 6 deletions(-)
 rename {scripts => tools/docs}/documentation-file-ref-check (99%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 65d184eab739..1476aa1701ce 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -8,7 +8,7 @@ subdir- := devicetree/bindings
 ifneq ($(MAKECMDGOALS),cleandocs)
 # Check for broken documentation file references
 ifeq ($(CONFIG_WARN_MISSING_DOCUMENTS),y)
-$(shell $(srctree)/scripts/documentation-file-ref-check --warn)
+$(shell $(srctree)/tools/docs/documentation-file-ref-check --warn)
 endif
 
 # Check for broken ABI files
@@ -78,7 +78,7 @@ htmldocs-redirects: $(srctree)/Documentation/.renames.txt
 	@tools/docs/gen-redirects.py --output $(BUILDDIR) < $<
 
 refcheckdocs:
-	$(Q)cd $(srctree);scripts/documentation-file-ref-check
+	$(Q)cd $(srctree); tools/docs/documentation-file-ref-check
 
 cleandocs:
 	$(Q)rm -rf $(BUILDDIR)
diff --git a/MAINTAINERS b/MAINTAINERS
index cd187b9f1dc2..fc1da52433b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7411,7 +7411,6 @@ S:	Maintained
 P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
-F:	scripts/documentation-file-ref-check
 F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
@@ -7451,7 +7450,6 @@ M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-doc@vger.kernel.org
 S:	Maintained
 F:	Documentation/sphinx/parse-headers.pl
-F:	scripts/documentation-file-ref-check
 F:	tools/docs/sphinx-pre-install
 
 DOCUMENTATION/ITALIAN
diff --git a/scripts/documentation-file-ref-check b/tools/docs/documentation-file-ref-check
similarity index 99%
rename from scripts/documentation-file-ref-check
rename to tools/docs/documentation-file-ref-check
index 408b1dbe7884..0cad42f6943b 100755
--- a/scripts/documentation-file-ref-check
+++ b/tools/docs/documentation-file-ref-check
@@ -17,7 +17,7 @@ my %false_positives = (
 );
 
 my $scriptname = $0;
-$scriptname =~ s,.*/([^/]+/),$1,;
+$scriptname =~ s,tools/docs/([^/]+/),$1,;
 
 # Parse arguments
 my $help = 0;
diff --git a/tools/docs/sphinx-pre-install b/tools/docs/sphinx-pre-install
index 698989584b6a..647e1f60357f 100755
--- a/tools/docs/sphinx-pre-install
+++ b/tools/docs/sphinx-pre-install
@@ -313,7 +313,7 @@ class MissingCheckers(AncillaryMethods):
         Right now, we still need Perl for doc build, as it is required
         by some tools called at docs or kernel build time, like:
 
-            scripts/documentation-file-ref-check
+            tools/docs/documentation-file-ref-check
 
         Also, checkpatch is on Perl.
         """
-- 
2.51.0


