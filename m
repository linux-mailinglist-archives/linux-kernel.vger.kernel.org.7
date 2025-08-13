Return-Path: <linux-kernel+bounces-767525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE77B2559A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D847D1BC282F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335102FC6BF;
	Wed, 13 Aug 2025 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MgtBGUZ3"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BEC2FFDEC;
	Wed, 13 Aug 2025 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120759; cv=none; b=YdqdNvDX+J4Fp/GQQriZLlbED614BCQxHCrsMYZE1I8K0HN1+J3UeT4IYG8XRU4GjLY9eL33bnVjsIUjH6T9rXpu4YGqgaHmL2Sbb+Q18E5jswYedoPec9BUB86Tk7SeyEZaLCGqrOTSy3xqx4WU6SSzzndUw4Roy7mPsZtosic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120759; c=relaxed/simple;
	bh=YrTV7I0EV9/14jjGp98GHdddZ1yBD5j3sBBEqWvqx08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q88QLQjR0sdCxF1OF2xWuHUGl1EeAKPml1rCSt3IRD0kuctVkiXCyyCATc5T3ZoW16ayJRmXTu7OTB72PReY8J7wzT3UbQKjGCjh6VNUTmR/v4fUJVzjEub96KdklZZxdBl6Ptx+IC1Zh4g4MOZjB7aG3stU4imr7I5rv7LjyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=MgtBGUZ3; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BEE2040AFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755120754; bh=n+EXUx0NIy4qnYvjItAxM4tBrzlvkFAYtOvhUN+rFt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MgtBGUZ3ySXelPqfP0/vwADarDekDlbbA66cGkTrg+4hfyf4GZySaH5pZV0Dczd4N
	 KWZ0Nbbv6k+sBcjgtyr8zGbwlgFPHI1b2DR1gQMyiziFCVekPZCcfnJjMYPbgxBxTj
	 KZwJw9IBAk+3PjYooh0BgvBBAWNe1wbP2fqvjpSicxdkYeczBSiZdhuY88ThXL9Imi
	 m3ev8CgInGTXNNxbeoaCsNr0Q6hB9xYu6nssNnXWGoKHwvHfVDaCFRcT+6fkYDA/Ig
	 mIfG+rxIv5aaEru+iCkj0r2UuFXQqVo6gG1DcaaBwHBBnvBRz1zQ4F70Rc4EG4iDMv
	 FJ6pO9q0UWNVg==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id BEE2040AFD;
	Wed, 13 Aug 2025 21:32:33 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 11/13] docs: move split-man.pl to tools/doc
Date: Wed, 13 Aug 2025 15:32:10 -0600
Message-ID: <20250813213218.198582-12-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813213218.198582-1-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

...and update all references to it.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/doc-guide/kernel-doc.rst                    | 6 +++---
 Documentation/translations/it_IT/doc-guide/kernel-doc.rst | 2 +-
 Documentation/translations/zh_CN/doc-guide/kernel-doc.rst | 6 +++---
 {scripts => tools/doc}/split-man.pl                       | 0
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename {scripts => tools/doc}/split-man.pl (100%)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 6fc89d444ada..b7c8ce55323c 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -584,15 +584,15 @@ from the kernel git tree::
 
   $ tools/doc/kernel-doc -man \
     $(git grep -l '/\*\*' -- :^Documentation :^tools) \
-    | scripts/split-man.pl /tmp/man
+    | tools/doc/split-man.pl /tmp/man
 
 Some older versions of git do not support some of the variants of syntax for
 path exclusion.  One of the following commands may work for those versions::
 
   $ tools/doc/kernel-doc -man \
     $(git grep -l '/\*\*' -- . ':!Documentation' ':!tools') \
-    | scripts/split-man.pl /tmp/man
+    | tools/doc/split-man.pl /tmp/man
 
   $ tools/doc/kernel-doc -man \
     $(git grep -l '/\*\*' -- . ":(exclude)Documentation" ":(exclude)tools") \
-    | scripts/split-man.pl /tmp/man
+    | tools/doc/split-man.pl /tmp/man
diff --git a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
index 05ea0f03c80b..bf04ceea2d83 100644
--- a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
@@ -604,4 +604,4 @@ Come utilizzare kernel-doc per generare pagine man
 Se volete utilizzare kernel-doc solo per generare delle pagine man, potete
 farlo direttamente dai sorgenti del kernel::
 
-  $ tools/doc/kernel-doc -man $(git grep -l '/\*\*' -- :^Documentation :^tools) | scripts/split-man.pl /tmp/man
+  $ tools/doc/kernel-doc -man $(git grep -l '/\*\*' -- :^Documentation :^tools) | tools/doc/split-man.pl /tmp/man
diff --git a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst b/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
index b242e52f911c..a807295bc403 100644
--- a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
@@ -484,16 +484,16 @@ kernel-doc扩展包含在内核源代码树中，位于 ``Documentation/sphinx/k
 
   $ tools/doc/kernel-doc -man \
     $(git grep -l '/\*\*' -- :^Documentation :^tools) \
-    | scripts/split-man.pl /tmp/man
+    | tools/doc/split-man.pl /tmp/man
 
 一些旧版本的git不支持路径排除语法的某些变体。
 以下命令之一可能适用于这些版本::
 
   $ tools/doc/kernel-doc -man \
     $(git grep -l '/\*\*' -- . ':!Documentation' ':!tools') \
-    | scripts/split-man.pl /tmp/man
+    | tools/doc/split-man.pl /tmp/man
 
   $ tools/doc/kernel-doc -man \
     $(git grep -l '/\*\*' -- . ":(exclude)Documentation" ":(exclude)tools") \
-    | scripts/split-man.pl /tmp/man
+    | tools/doc/split-man.pl /tmp/man
 
diff --git a/scripts/split-man.pl b/tools/doc/split-man.pl
similarity index 100%
rename from scripts/split-man.pl
rename to tools/doc/split-man.pl
-- 
2.50.1


