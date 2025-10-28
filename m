Return-Path: <linux-kernel+bounces-874812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2A3C1725E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9042B4F67FE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7F7357735;
	Tue, 28 Oct 2025 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gSxSKruF"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CC3355811;
	Tue, 28 Oct 2025 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689433; cv=none; b=qJqRWABvf44JjdyE9wCdxbx4v33xXwnAupUPXiCJp4rXl4BgNpSgJYhVx26SCIqvnjv6qThOG3fvWQqk7IKcYSH3wM6odu77fr/JF5sUndIFh+69HR7AAGZaGEatKsh7ICVx1G8nRfOnR+oRYpGuVEIoOjYxmLZi2Oa+WNGEQSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689433; c=relaxed/simple;
	bh=BGJrmBz+LlEN/JX0JNDCunWcL198n52vvjEnUgzCzao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdL8CtSC3NteNLNEIemq6zamE0UwSirnA26mUHMULJtT0UyizAkGC39+8im17t8TOU7sz4k9/cPm8TpmTo9hJwqZZJCugAdwTLAD8iDbvJEXx0555HtnoW+RdEMDCtT9BNxgkalvSA9YhFgF4TivMfMO7lZrUAdd+PxhTHR249k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=gSxSKruF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E59AF40B45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761689427; bh=R4IKlDLI/49ZAIPAg6XecBoRQ7zpdNfvZA7OZO2keFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gSxSKruFe5+cYOFwKqatb8u5uASypNczdc0YGqAVe5cwPeQvCb2+8JzBShB3WmUe3
	 E8HLQEBJ9/NHYmWR3b5YtIopbo44S33SCd17uk0YELjkHRNizxV1H7VqtIMf4y6KSb
	 NzBeb1FAinplH318JNbKxcSfvnNAGVIAG3jEKdThttMcAvScHyo277lUJxmejphRey
	 EQz/yzhQeaRFLcA4k+/lS+nDUMu2GVHAfLuG5v0KmshUtJUJS+E06pp2hoKhvIU9ty
	 8RZxRPm7mo0OP07CTA2mTsxtViemOSG//kyI1GbqtCnheADZoeOp57dq1FUTXuIp1H
	 bz8kZFunvW97w==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id E59AF40B45;
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
Subject: [PATCH v4 4/7] docs: move get_abi.py to tools/docs
Date: Tue, 28 Oct 2025 16:10:12 -0600
Message-ID: <20251028221017.5785-5-corbet@lwn.net>
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

Move this tool out of scripts/ to join the other documentation tools; fix
up a couple of erroneous references in the process.

It's worth noting that this script will fail badly unless one has a
PYTHONPATH referencing scripts/lib/abi.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/Kconfig              | 2 +-
 Documentation/Makefile             | 2 +-
 Documentation/sphinx/kernel_abi.py | 2 +-
 MAINTAINERS                        | 1 -
 {scripts => tools/docs}/get_abi.py | 0
 5 files changed, 3 insertions(+), 4 deletions(-)
 rename {scripts => tools/docs}/get_abi.py (100%)

diff --git a/Documentation/Kconfig b/Documentation/Kconfig
index 3a0e7ac0c4e3..8b6c4b84b218 100644
--- a/Documentation/Kconfig
+++ b/Documentation/Kconfig
@@ -19,7 +19,7 @@ config WARN_ABI_ERRORS
 	  described at Documentation/ABI/README. Yet, as they're manually
 	  written, it would be possible that some of those files would
 	  have errors that would break them for being parsed by
-	  scripts/get_abi.pl. Add a check to verify them.
+	  tools/docs/get_abi.py. Add a check to verify them.
 
 	  If unsure, select 'N'.
 
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 1476aa1701ce..734ec9c9a62c 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -13,7 +13,7 @@ endif
 
 # Check for broken ABI files
 ifeq ($(CONFIG_WARN_ABI_ERRORS),y)
-$(shell $(srctree)/scripts/get_abi.py --dir $(srctree)/Documentation/ABI validate)
+$(shell $(srctree)/tools/docs/get_abi.py --dir $(srctree)/Documentation/ABI validate)
 endif
 endif
 
diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 4c4375201b9e..32e39fb8bc3b 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -14,7 +14,7 @@
     :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
 
     The ``kernel-abi`` (:py:class:`KernelCmd`) directive calls the
-    scripts/get_abi.py script to parse the Kernel ABI files.
+    AbiParser class to parse the Kernel ABI files.
 
     Overview of directive's argument and options.
 
diff --git a/MAINTAINERS b/MAINTAINERS
index fc1da52433b6..5c632cd3902c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7411,7 +7411,6 @@ S:	Maintained
 P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
-F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
diff --git a/scripts/get_abi.py b/tools/docs/get_abi.py
similarity index 100%
rename from scripts/get_abi.py
rename to tools/docs/get_abi.py
-- 
2.51.0


