Return-Path: <linux-kernel+bounces-874808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA98C17249
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D1B404118
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5983563E5;
	Tue, 28 Oct 2025 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Rx5jrApX"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C23557FC;
	Tue, 28 Oct 2025 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689428; cv=none; b=ie3fQtzXGpTBLqoaknq9M5R9JJn2hXzcvDVbTDvItCZPYjgdH1Ih9Fi9rloJNN2hYdhfvQAcE5tc5t6lR/q9qOnkdl/nomW1SCrGWsf3LlRSH7HHSXScbLWIg3r0M9tykQeELjq4WKlIlOBu7k9mpN0sGSfCCcRsf76Hwoh95/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689428; c=relaxed/simple;
	bh=+p4cARr4R8Bde1SloqE3PxCK7sYvxHLFI+eewvzwEEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0FD5zhTdxe72ZwHtU0XruR/k5HEqjxVpeP63xrPulUzhNHovZDuXxL8Y626iXz4AZBjrY8cFviZZMnZkBBaK/ew6ff5wKRFKbNvTX6N5TYcfErWLWJtCmev5uKFbxVkVlrIi+bj/149i5GSo3n4BkiqDlLfRwr0J+jP9zj1a8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Rx5jrApX; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3ACEC40B3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761689426; bh=BAsEGL3KcKrI+xGyU+nw8dEQJHYyVk8KT7GgiOuSFN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rx5jrApXCWKzkX1MAbEs4VdskN4K7Ov604Yq5fvXuciaUcEZtWBqvAsM+/x36ge74
	 dVPmbyAm11PRjGJGmwoH5BmcI6WK0h/hVNrSw9xMLiX2tJq3e0j2WiORvhEulld+J+
	 olzZrBjIDazSMips92jcU8J8+EjogxDWq3PYp8LQT9g2J1/SupIE8DgZgoJS1TFgWP
	 bgWRbgs5qLz/xlYeXmfDXBmreoQhfIaI1lMAnYSApTWGFP+rGcQUVRZh7WK+uTaI0X
	 oTLNYZSYcJJPC5bX/tewkPqCxqzMqOTFS4ncp2Jb5pXlazdIDsdZ6W0j7U4v3wWRgx
	 vM+gTj/4yVPew==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 3ACEC40B3D;
	Tue, 28 Oct 2025 22:10:26 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v4 3/7] docs: move scripts/documentation-file-ref-check to tools/docs
Date: Tue, 28 Oct 2025 16:10:11 -0600
Message-ID: <20251028221017.5785-4-corbet@lwn.net>
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

Add this script to the growing collection of documentation tools.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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


