Return-Path: <linux-kernel+bounces-867350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C4DC02570
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6963A636D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BA22BEFF2;
	Thu, 23 Oct 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Njn0NklU"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF832882A6;
	Thu, 23 Oct 2025 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235854; cv=none; b=XkzKh5P3VFIGe+wqQVi1s5SJqhbtyEZ+A/mSATGTp3opGx7jVNMR8e5y0YBRCk/RhwsY9ybpiFq9l7nB0hwBk2WfFc0BvAzBL1t3W+im1dXfMlovahfuJmyY35vKK9lqc/+ic1PTkIsXFgos/hJOSS1bD2NYYcT0ncwKA3QMSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235854; c=relaxed/simple;
	bh=GXP3AsEBJRlrI5Px1+f+ZXn0gQuTFpvOmI0BUCuE+yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSh5/HbNtTrpcqpLRHce2+z2kTo29joU09zOoVxmElmP9eNWrLMOmy7aGYgqvMJtgm0jJFJrSh7HvCiw3TGIJ95YFGqlRIwr1RWHFxdLj6LfWkhlVHq69MDBiHVAUxJagDDSV0Mv14n2isDRZw7Lpb+9IZj8CxQF7LppTSk/C3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Njn0NklU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C324540B41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761235849; bh=sR/lP58tIJyHcilyEmgV29zZ+b0N+5E3LuZI7egPUxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Njn0NklUPqaRC9qVqAUr6hZFERBrcJKmZKCtjRw6O2y4cKFBMQp0Lw89kzppdOHoY
	 FP3QSOajQSFGItXXfCqAdYDoYPDz39rwfBriHIM4DPw4S/YFCUBYv+PNcZ1QLCy2wE
	 F+KgANVtBzJca+lu5d/3Mt0+cCe1BNDVx7+N86xntmo2Yk551dodGwouaXmn2WuXzt
	 DQhq6wg7IQVaHeHkXWf5WphgvTdJ0gmu7iYbezxT7sloWVb2yh6xekoxJ+KUPaitin
	 WjCwE6NYCV6opR3U2LpKAfZSy+ePMEzLbr7BH9/UhlWtH3AYkoe/6Nn3ZjjEG+SSYn
	 3uWpD36V3VIUw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id C324540B41;
	Thu, 23 Oct 2025 16:10:48 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 08/10] docs: move split-man.pl to tools/docs
Date: Thu, 23 Oct 2025 10:10:16 -0600
Message-ID: <20251023161027.697135-9-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023161027.697135-1-corbet@lwn.net>
References: <20251023161027.697135-1-corbet@lwn.net>
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
 {scripts => tools/docs}/split-man.pl                      | 0
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename {scripts => tools/docs}/split-man.pl (100%)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index dd5854b4131c..6eaf127c5cca 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -584,15 +584,15 @@ from the kernel git tree::
 
   $ tools/docs/kernel-doc -man \
     $(git grep -l '/\*\*' -- :^Documentation :^tools) \
-    | scripts/split-man.pl /tmp/man
+    | tools/docs/split-man.pl /tmp/man
 
 Some older versions of git do not support some of the variants of syntax for
 path exclusion.  One of the following commands may work for those versions::
 
   $ tools/docs/kernel-doc -man \
     $(git grep -l '/\*\*' -- . ':!Documentation' ':!tools') \
-    | scripts/split-man.pl /tmp/man
+    | tools/docs/split-man.pl /tmp/man
 
   $ tools/docs/kernel-doc -man \
     $(git grep -l '/\*\*' -- . ":(exclude)Documentation" ":(exclude)tools") \
-    | scripts/split-man.pl /tmp/man
+    | tools/docs/split-man.pl /tmp/man
diff --git a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
index bac959b8b7b9..91184d48e750 100644
--- a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
@@ -604,4 +604,4 @@ Come utilizzare kernel-doc per generare pagine man
 Se volete utilizzare kernel-doc solo per generare delle pagine man, potete
 farlo direttamente dai sorgenti del kernel::
 
-  $ tools/docs/kernel-doc -man $(git grep -l '/\*\*' -- :^Documentation :^tools) | scripts/split-man.pl /tmp/man
+  $ tools/docs/kernel-doc -man $(git grep -l '/\*\*' -- :^Documentation :^tools) | tools/docs/split-man.pl /tmp/man
diff --git a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst b/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
index fb2bbaaa85c1..7f20171259d0 100644
--- a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
@@ -484,16 +484,16 @@ kernel-doc扩展包含在内核源代码树中，位于 ``Documentation/sphinx/k
 
   $ tools/docs/kernel-doc -man \
     $(git grep -l '/\*\*' -- :^Documentation :^tools) \
-    | scripts/split-man.pl /tmp/man
+    | tools/docs/split-man.pl /tmp/man
 
 一些旧版本的git不支持路径排除语法的某些变体。
 以下命令之一可能适用于这些版本::
 
   $ tools/docs/kernel-doc -man \
     $(git grep -l '/\*\*' -- . ':!Documentation' ':!tools') \
-    | scripts/split-man.pl /tmp/man
+    | tools/docs/split-man.pl /tmp/man
 
   $ tools/docs/kernel-doc -man \
     $(git grep -l '/\*\*' -- . ":(exclude)Documentation" ":(exclude)tools") \
-    | scripts/split-man.pl /tmp/man
+    | tools/docs/split-man.pl /tmp/man
 
diff --git a/scripts/split-man.pl b/tools/docs/split-man.pl
similarity index 100%
rename from scripts/split-man.pl
rename to tools/docs/split-man.pl
-- 
2.51.0


