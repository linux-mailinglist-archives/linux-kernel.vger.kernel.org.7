Return-Path: <linux-kernel+bounces-767521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B5B25581
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40ED16E4C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41DC2F39D4;
	Wed, 13 Aug 2025 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Hu3VU+RS"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F5E3093CE;
	Wed, 13 Aug 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120758; cv=none; b=Wo86KjyBsgz/B3mXDtmulKu+5wnuU/v/bRsCPR18DTu505hNZv8R69SDJtzZKl31WdviNWtwMEI9nZs647vXSx0JO3DGgvynZelg8t2U+U+Hwpo9rzH93qcuZpnPfiqER5CyE7ZNfKwR0dJM6YCN/5CKmLC9fhdm8OdebOwpj6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120758; c=relaxed/simple;
	bh=XG0IUTzgggjHC7XpWjNslDa9iaLpJbCXZTSzuwzJvw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aGMCNS3ID321FJ6AYW7rwtPsWq4x7ZL43MqFBoev351lQm7v3+WM1/D8RUWWFchk3EAlxEuDFYOWRRoZPH2hs5yBUW/CPLha19MuXEl/HNJKIMSjMjcLgeO6Y+ULpXtQHcEFzhGigCut1mTo4ofdfcGG9ziIvfbRc8Pg3IJ0KZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Hu3VU+RS; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A1A5440AF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755120750; bh=GwRKiICIPVgXd2SKXzVv6F2/MjfrEfTZ1LdNZfZSnnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hu3VU+RSuMGiprUals2x6pp71+vCP21VAiAtLsEiMMHbdnR+iO6UhUkEgM+cJCVO5
	 f1tMSxxhxhIZUak1qObUH+qk2sQGqJl6SGRT/jwhme0IVhzCGGyaNLRygyQiYoo3YI
	 pVvYymi0UpBMpzDuGzMfM4hSfBM51x1vKq7LwdBpeGCcQIeQyGVCy2Ipz5KiW+zkQz
	 tciT13De7HAG39IUzVnjrXLIm0XKAuBsV2U8qgz8QhYgttojZXo3OD7ua6TeUlXO6s
	 EcpaZhkrX7DQB6VsqTlP09Eb4z5Lefc+GGDkXEK5fI3jCZsle3QYTJbQcC9hV7akU/
	 hJ8W8fvekI7oQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id A1A5440AF7;
	Wed, 13 Aug 2025 21:32:29 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 04/13] docs: move scripts/documentation-file-ref-check to tools/doc
Date: Wed, 13 Aug 2025 15:32:03 -0600
Message-ID: <20250813213218.198582-5-corbet@lwn.net>
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

Add this script to the growing collection of documentation tools.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/Makefile                              | 4 ++--
 MAINTAINERS                                         | 3 +--
 scripts/sphinx-pre-install                          | 2 +-
 {scripts => tools/doc}/documentation-file-ref-check | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)
 rename {scripts => tools/doc}/documentation-file-ref-check (99%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 70095465dce1..f7b8342f9666 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -8,7 +8,7 @@ subdir- := devicetree/bindings
 ifneq ($(MAKECMDGOALS),cleandocs)
 # Check for broken documentation file references
 ifeq ($(CONFIG_WARN_MISSING_DOCUMENTS),y)
-$(shell $(srctree)/scripts/documentation-file-ref-check --warn)
+$(shell $(srctree)/tools/doc/documentation-file-ref-check --warn)
 endif
 
 # Check for broken ABI files
@@ -167,7 +167,7 @@ endif # HAVE_SPHINX
 # work or silently pass without Sphinx.
 
 refcheckdocs:
-	$(Q)cd $(srctree);scripts/documentation-file-ref-check
+	$(Q)cd $(srctree); tools/doc/documentation-file-ref-check
 
 cleandocs:
 	$(Q)rm -rf $(BUILDDIR)
diff --git a/MAINTAINERS b/MAINTAINERS
index ca4c7992369d..ec9872642597 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7302,7 +7302,6 @@ P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
 F:	tools/doc/
-F:	scripts/documentation-file-ref-check
 F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
@@ -7342,7 +7341,7 @@ M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-doc@vger.kernel.org
 S:	Maintained
 F:	Documentation/sphinx/parse-headers.pl
-F:	scripts/documentation-file-ref-check
+F:	tools/doc/
 F:	scripts/sphinx-pre-install
 
 DOCUMENTATION/ITALIAN
diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index b8474848df4e..5d006a037428 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -406,7 +406,7 @@ class MissingCheckers(AncillaryMethods):
         Right now, we still need Perl for doc build, as it is required
         by some tools called at docs or kernel build time, like:
 
-            scripts/documentation-file-ref-check
+            tools/doc/documentation-file-ref-check
 
         Also, checkpatch is on Perl.
         """
diff --git a/scripts/documentation-file-ref-check b/tools/doc/documentation-file-ref-check
similarity index 99%
rename from scripts/documentation-file-ref-check
rename to tools/doc/documentation-file-ref-check
index 408b1dbe7884..2dc53f5661b1 100755
--- a/scripts/documentation-file-ref-check
+++ b/tools/doc/documentation-file-ref-check
@@ -17,7 +17,7 @@ my %false_positives = (
 );
 
 my $scriptname = $0;
-$scriptname =~ s,.*/([^/]+/),$1,;
+$scriptname =~ s,tools/doc/([^/]+/),$1,;
 
 # Parse arguments
 my $help = 0;
-- 
2.50.1


