Return-Path: <linux-kernel+bounces-867348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B91C02576
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35D4188923C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43642BE63F;
	Thu, 23 Oct 2025 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MDmIO9Qt"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5428504F;
	Thu, 23 Oct 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235854; cv=none; b=nUu6aa0snHSe1TD48EAaMdUOgASn9fnMXs30JB6SYct7sK/tYF5encz8/UU/4i0VYWeGK53M/pUrCjjhnwF7AVfHAMNsTyAEcmaib/+aNkIBRiXrYjppwSX3mHSEHlFSj0KBQ2lrtpA3zASXd1Pj+UnD49KTaX08yG+RFhxzpMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235854; c=relaxed/simple;
	bh=LRpnw9MK/hUds6OU5tl+6N0+i65CTzif2Q3isV3Ypek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkDbQKJFoBMeWhBf4TXOnE2VV3/EsCSj+QZAHBT9koY+FqyDi5+2a3JOYOZpxb9VTEQ8iGfjjtvpAMbLQIrlEiZp4W/ak0q53+PRWvJnIpp2oTLofFpsXAnLyV7XULNJ4yT3MTx5jJL9sOQwjvW9HoqfxRgvB9zdtKNGZClROls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=MDmIO9Qt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7E49040B3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761235847; bh=etR/6GTLY6B86EqHrcYoTLI/I2O/7Dvfk2FICOvFGys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDmIO9QtwMYCJKbcK7zgRaS8YvP/sHA39cWAw4/znjJJhD13dezqtIIWtgYHbCfXP
	 D6e9hA67Jucg50EdRGomzMJQFljEXeLO57uX7h0IoxhjKfyJDGp3RZq6CkZXx9lCim
	 r2uPbGvvWdu/jBgzdukEQI/N3m8CR17tP2hJZOhSit9xqjM6AtBj2QmyNRlN5vDqrF
	 zT+LNONvPwQazXRy0Uz6ym6e+qWRcLR6/kCtSjxiy93tT3QksKUEA/ZoLeU4ldVOES
	 bUjP8InOuczZIdABIQ4rhe1YaEtQqeu+zIQYHltc3joFR10iHkRcZP+F7Zy6lIQ3xh
	 kzMnWrzuFILRw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 7E49040B3E;
	Thu, 23 Oct 2025 16:10:46 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 05/10] docs: move get_abi.py to tools/docs
Date: Thu, 23 Oct 2025 10:10:13 -0600
Message-ID: <20251023161027.697135-6-corbet@lwn.net>
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

Move this tool out of scripts/ to join the other documentation tools; fix
up a couple of erroneous references in the process.

It's worth noting that this script will fail badly unless one has a
PYTHONPATH referencing scripts/lib/abi.

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
index 8704566d5197..caee0acbbda2 100644
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
index 7ef1bdfa265b..fe0ed118a5ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7302,7 +7302,6 @@ P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
 F:	tools/docs/
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


