Return-Path: <linux-kernel+bounces-869487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F4FC07FF5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C0C405F34
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299752E9EDF;
	Fri, 24 Oct 2025 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="T87SBZgN"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8807A2E6CC4;
	Fri, 24 Oct 2025 20:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336536; cv=none; b=vE0npviofCwILBzyuVhj2JzY5TMJ5xPzGgf8hjdDdPP+8CdS4DY0zTZrijzP48wskfxUNFJ0g59gV+MyOKH6K8JkH+aSkyhiOmMWn9GZU3V3X8ZVmPFJyDcNwzIepxJTiTdxjpvrvggp9LTwNP8Hg+qBmTyz/JceexDMAzocNfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336536; c=relaxed/simple;
	bh=M67VoMxyAvaa3Q2G2y/IHqN7Ue15OSITp43jSgQUByA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvytzQE24TUshtHvMjVKQ9GgDeNwAzUXM4eAiETBT0ueKqhLx/YwS12XM1I3WoDQo1cRhL12tybZ9CcvwdR7w35Bl5olQO8Z2vjV4SH5EK4Y0b/q+LhqCZ57DMrHHzAmbMVW/c52Strm1dT5vzuruZ93n2k0XgTiflH/vxf3F7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=T87SBZgN; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F064D40C2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761336527; bh=hWt5ftNAvpwXgRb0lngYloq1RnkyCYaqYr1EN/nuY5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T87SBZgND2TSSiFZN3+D6MM/9bT/1oMZR6hxCFRb0RHJKVNDthsXGDXT7AjP89wBd
	 1d7K6FODGXgqUqPa3Wm76oN1buTcrf/K27q2PmIcK73XaTqCMkH/UMV9EmRwn6frZK
	 8zwY5/hTcXKtLSP5bQWf4MVxYtA0yG73TcWT3IFsikga3VkwVfVOpQA0dbZSwfMoGF
	 Nlwl0Uqq9N5pLPHn4mkDPoq+LC1H1aWgVqNG4FbWWGgip6gL6Y8ElMGAZOJ94pZ3m0
	 NXU3mWQ+wcVuJCMhzWcr+kyDSwyZ66kf90j52l8nSzu0GAc3ES3mHoZ54Xng/01bo7
	 RwSZdt3CAl8gA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id F064D40C2A;
	Fri, 24 Oct 2025 20:08:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v3 4/8] docs: move get_abi.py to tools/docs
Date: Fri, 24 Oct 2025 14:08:25 -0600
Message-ID: <20251024200834.20644-5-corbet@lwn.net>
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

Move this tool out of scripts/ to join the other documentation tools; fix
up a couple of erroneous references in the process.

It's worth noting that this script will fail badly unless one has a
PYTHONPATH referencing scripts/lib/abi.

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


