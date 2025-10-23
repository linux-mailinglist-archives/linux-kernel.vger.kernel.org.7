Return-Path: <linux-kernel+bounces-867349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E07C7C02568
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF7F54F06CD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BBA2BE62E;
	Thu, 23 Oct 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="tQYSKoZH"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FB4287505;
	Thu, 23 Oct 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235854; cv=none; b=tbDDSnvfP+0hAytd222bKa01SRMG/m2yTD7QwVcMEjRX+3q/rhHFwicukIYmFlX1Zo7l/l2xqqD2kbKjLJmQKGbwfyVZXvXqYX9fMVMjDDD7zg03IeU/omzCGFS/OY2a49jeA8WfP8LLf7+qyMjxJPjD4KD6Cf6uBQPePJnzry4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235854; c=relaxed/simple;
	bh=ay7LqayYFLYaK0WgZ03484UBz19Z5TEXubtEz0nzgM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Usqux43Tl/vcNtX+qkhgi2fA78tIr6V9o5Mq7lswwNxxUupcjiQnSdvWWxyChe+wgllEtnbwGepu6KVsFOvVUjfuBbwxKuqnC7EZlvA1Z+VkIQ4GNX9gt2lD+Gn1/s5Iah8IG3feKrRckx50GcYgVlX8tvmS2MTWxIrqpjOcikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=tQYSKoZH; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D175E40B3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761235846; bh=3YvOTucfpeUEGbqlTx75y9PY+fjgWvNX5tL1PNjabvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQYSKoZHyDFKuIF1vTN7m8+MGTmXzSjaWlM2pqNXsFVzK1UOlomSX9jzVIFHPwra4
	 RWIAOZ9mwoWaJdgcmLQvK4ecdjKuGvSorL7S6sTwBO9c01mqBYL+PY08wvjR9mnn5w
	 W+8/Um4kGhJUoUZlOTwk8lfwfM/5AXe6uDlwNBHcmhEx95ufP6dOrjtHJjNzsaCR4M
	 ZZ02VHFvS5sg6jqQnqrov5F45r2T9ngrZnE9Z5gCUbl9Kz3mR0kCg36bIFc0z5sR7o
	 lY70UcFCk4hoq9dqHAKyIeUpWo+XIpfWYdiI0OvjtXMF0HQE8CpwDWZwfhoDSHJJxs
	 qj3uCD+HF1hPw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id D175E40B3D;
	Thu, 23 Oct 2025 16:10:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 04/10] docs: move scripts/documentation-file-ref-check to tools/docs
Date: Thu, 23 Oct 2025 10:10:12 -0600
Message-ID: <20251023161027.697135-5-corbet@lwn.net>
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

Add this script to the growing collection of documentation tools.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/Makefile                               | 4 ++--
 MAINTAINERS                                          | 3 +--
 scripts/sphinx-pre-install                           | 2 +-
 {scripts => tools/docs}/documentation-file-ref-check | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)
 rename {scripts => tools/docs}/documentation-file-ref-check (99%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b8795f704385..8704566d5197 100644
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
@@ -167,7 +167,7 @@ endif # HAVE_SPHINX
 # work or silently pass without Sphinx.
 
 refcheckdocs:
-	$(Q)cd $(srctree);scripts/documentation-file-ref-check
+	$(Q)cd $(srctree); tools/docs/documentation-file-ref-check
 
 cleandocs:
 	$(Q)rm -rf $(BUILDDIR)
diff --git a/MAINTAINERS b/MAINTAINERS
index 0f2d9ff01ae6..7ef1bdfa265b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7302,7 +7302,6 @@ P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
 F:	tools/docs/
-F:	scripts/documentation-file-ref-check
 F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
@@ -7342,7 +7341,7 @@ M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-doc@vger.kernel.org
 S:	Maintained
 F:	Documentation/sphinx/parse-headers.pl
-F:	scripts/documentation-file-ref-check
+F:	tools/docs/
 F:	scripts/sphinx-pre-install
 
 DOCUMENTATION/ITALIAN
diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index b8474848df4e..c8cc370df076 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -406,7 +406,7 @@ class MissingCheckers(AncillaryMethods):
         Right now, we still need Perl for doc build, as it is required
         by some tools called at docs or kernel build time, like:
 
-            scripts/documentation-file-ref-check
+            tools/docs/documentation-file-ref-check
 
         Also, checkpatch is on Perl.
         """
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
-- 
2.51.0


