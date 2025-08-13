Return-Path: <linux-kernel+bounces-767519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5246DB25596
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16ED03BCD64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7E92F39D1;
	Wed, 13 Aug 2025 21:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="NNsqny6d"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497D2F0C64;
	Wed, 13 Aug 2025 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120757; cv=none; b=lQzc5V2td/ofBRD1sVwqWFnoInDXfLork4biYZVVemN72qYDAdKTOaV4Zl8NAlbSkBMnBQ+56wFbNrYHIMKQxduW+SnqUhXdk4C040ow1+Vk1B9RfPrNSSD5ORYzDny5eu7NdbT3I99o54lZ++Tfu0lMhTmD94h9zpu9j6l2DvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120757; c=relaxed/simple;
	bh=i6r2cjqRgdoWCE3T1s1d2OsuEgwemxbRmk7qaifEkZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tmS2lS7D+0pIEdbFqS1tmSqfCjgSUTuZNDwmOuaFVAgIowIM14hgbqV+DvWgBwiMaymR0C/5dbG7YYZ6QhZsAxPoBVG/nsqc6oCWI4Yp3xluWxKjSSchZKB9jPlYbhvjQLz44EOE16aEDhZeBpjzWiE60yUhUYUqJQzKsbfFKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=NNsqny6d; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D079840AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755120751; bh=uai5P2Z7dyR9FKIsZAMHGxNGWkNu0mA8sIZFMSJISjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NNsqny6daSZRimNvA/M9l5hXdBoJOUJpxTyTBcYWgpIF+vW6zsxqK6pzTF/qB7U2S
	 c9TapNRWzkeSofL29YPDhZBirG1eVIDai2cqJZFCop3tDWM8cmXuof6DNq50al4nNh
	 sMMv+qVzxPwP1/k37oDz6DMeHiWWRxPoZdEDx/uTwMOys4aiCM+txRNnngwcohn49t
	 mF9rV9k5kFvad7oUgIy0e059c9IzxUBi11Xwmv12YjR4Jsm+r9HmFE7noDRtoIuUPZ
	 InOj/l3rPRzwdyC0aOlcfZvB7jqWF+M8HxqxVg4WF1A/DfVKbivgzI8By4JIDeO4FJ
	 F8VPItWcFV5iA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id D079840AF9;
	Wed, 13 Aug 2025 21:32:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 06/13] docs: move get_abi.py to tools/doc
Date: Wed, 13 Aug 2025 15:32:05 -0600
Message-ID: <20250813213218.198582-7-corbet@lwn.net>
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
 {scripts => tools/doc}/get_abi.py  | 0
 5 files changed, 3 insertions(+), 4 deletions(-)
 rename {scripts => tools/doc}/get_abi.py (100%)

diff --git a/Documentation/Kconfig b/Documentation/Kconfig
index 3a0e7ac0c4e3..70178e9e0c6c 100644
--- a/Documentation/Kconfig
+++ b/Documentation/Kconfig
@@ -19,7 +19,7 @@ config WARN_ABI_ERRORS
 	  described at Documentation/ABI/README. Yet, as they're manually
 	  written, it would be possible that some of those files would
 	  have errors that would break them for being parsed by
-	  scripts/get_abi.pl. Add a check to verify them.
+	  tools/doc/get_abi.py. Add a check to verify them.
 
 	  If unsure, select 'N'.
 
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 962c4fab94b0..eef5decb79b8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -13,7 +13,7 @@ endif
 
 # Check for broken ABI files
 ifeq ($(CONFIG_WARN_ABI_ERRORS),y)
-$(shell $(srctree)/scripts/get_abi.py --dir $(srctree)/Documentation/ABI validate)
+$(shell $(srctree)/tools/doc/get_abi.py --dir $(srctree)/Documentation/ABI validate)
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
index ec9872642597..b41b78215035 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7302,7 +7302,6 @@ P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
 F:	tools/doc/
-F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
diff --git a/scripts/get_abi.py b/tools/doc/get_abi.py
similarity index 100%
rename from scripts/get_abi.py
rename to tools/doc/get_abi.py
-- 
2.50.1


