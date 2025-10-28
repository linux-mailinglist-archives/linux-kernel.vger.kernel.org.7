Return-Path: <linux-kernel+bounces-874810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D3CC17258
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 733FD4FAC8E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804933570D4;
	Tue, 28 Oct 2025 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PBlkGcyT"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E83563E4;
	Tue, 28 Oct 2025 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689430; cv=none; b=AL+LPXY9H0Gjh72aHGaZP77LXr96JuERpVHHJ9ZDirM2qhSy0xGBwNdWu7rwPYGOO4aNHZhLw0gB8uDg4DP++2Hu7cndab4uzP3VogOjEREyJlidDmjh/FnuMVNvC0SykXdq2/5jtUZr9ox6tiQA2Oo6Zu28bpeeWbx5aaG7gO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689430; c=relaxed/simple;
	bh=Su8I4ZpmI0lXEKrYUMdIBG2EmR2jPYhJ1smLKIargxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EeggQLBvUYIY2Uo8pqzSxPiFSmABL/36oTJbwfkvicHao8S3MVPAJJL30PmkNgX7Oyh55Uy4WmyhRa/HKqvEJPpIg/6ePeWUm74Lk0/kwDF0tmfZ85p2OsTtDjGNmH+qJ/hEzFnlj5yrYvQ6GFdjQTy3XD0nGfzR8d5FErhdnZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PBlkGcyT; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5C22140C2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761689428; bh=XByR8V9qclC7Yr58OJitI2Wdvv3KcBWFUkrYuK1bai4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBlkGcyTzSSP6xmQDgL+1zmjtbt/PZxFO+jhJLl7OxHJwtoaFQBSZzxFH2kT+nq6b
	 rxJ5lWYeTqqfi/jy7GM2CF2FblhsSoxz0gtDX00vzzFtQVa9wsnM/pywPKBM3QrSws
	 77FVn/RO42aBGLZGH8irUASbQjBZbEXqyBhLB+hZae+JHPa4OyXedyQpmMaMyGKyPo
	 XHhie/FUN1ekUjsmbEkQYwl0hEcvIQSqhNhWkAsXuj54yl6rG8lSHtTjPbzkNTwA4A
	 jvPygLFbrDfjZAHbhBU8J2fnv/V4JXl9prGE6i9hwTWlKx5fEKDq6Oo3ERG7piBkvj
	 OOja4/ErTVY7A==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 5C22140C2D;
	Tue, 28 Oct 2025 22:10:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v4 6/7] docs: move find-unused-docs.sh to tools/docs
Date: Tue, 28 Oct 2025 16:10:14 -0600
Message-ID: <20251028221017.5785-7-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028221017.5785-1-corbet@lwn.net>
References: <20251028221017.5785-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

...and update references accordingly.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/doc-guide/contributing.rst                    | 2 +-
 Documentation/translations/zh_CN/doc-guide/contributing.rst | 2 +-
 {scripts => tools/docs}/find-unused-docs.sh                 | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename {scripts => tools/docs}/find-unused-docs.sh (85%)

diff --git a/Documentation/doc-guide/contributing.rst b/Documentation/doc-guide/contributing.rst
index 662c7a840cd5..f8047e633113 100644
--- a/Documentation/doc-guide/contributing.rst
+++ b/Documentation/doc-guide/contributing.rst
@@ -152,7 +152,7 @@ generate links to that documentation.  Adding ``kernel-doc`` directives to
 the documentation to bring those comments in can help the community derive
 the full value of the work that has gone into creating them.
 
-The ``scripts/find-unused-docs.sh`` tool can be used to find these
+The ``tools/docs/find-unused-docs.sh`` tool can be used to find these
 overlooked comments.
 
 Note that the most value comes from pulling in the documentation for
diff --git a/Documentation/translations/zh_CN/doc-guide/contributing.rst b/Documentation/translations/zh_CN/doc-guide/contributing.rst
index 394a13b438b0..b0c8ba782b16 100644
--- a/Documentation/translations/zh_CN/doc-guide/contributing.rst
+++ b/Documentation/translations/zh_CN/doc-guide/contributing.rst
@@ -124,7 +124,7 @@ C代码编译器发出的警告常常会被视为误报，从而导致出现了
 这使得这些信息更难找到，例如使Sphinx无法生成指向该文档的链接。将 ``kernel-doc``
 指令添加到文档中以引入这些注释可以帮助社区获得为编写注释所做工作的全部价值。
 
-``scripts/find-unused-docs.sh`` 工具可以用来找到这些被忽略的评论。
+``tools/docs/find-unused-docs.sh`` 工具可以用来找到这些被忽略的评论。
 
 请注意，将导出的函数和数据结构引入文档是最有价值的。许多子系统还具有供内部
 使用的kernel-doc注释；除非这些注释放在专门针对相关子系统开发人员的文档中，
diff --git a/scripts/find-unused-docs.sh b/tools/docs/find-unused-docs.sh
similarity index 85%
rename from scripts/find-unused-docs.sh
rename to tools/docs/find-unused-docs.sh
index d6d397fbf917..05552dbda5bc 100755
--- a/scripts/find-unused-docs.sh
+++ b/tools/docs/find-unused-docs.sh
@@ -5,10 +5,10 @@
 # This script detects files with kernel-doc comments for exported functions
 # that are not included in documentation.
 #
-# usage: Run 'scripts/find-unused-docs.sh directory' from top level of kernel
+# usage: Run 'tools/docs/find-unused-docs.sh directory' from top level of kernel
 # 	 tree.
 #
-# example: $scripts/find-unused-docs.sh drivers/scsi
+# example: $tools/docs/find-unused-docs.sh drivers/scsi
 #
 # Licensed under the terms of the GNU GPL License
 
@@ -18,7 +18,7 @@ if ! [ -d "Documentation" ]; then
 fi
 
 if [ "$#" -ne 1 ]; then
-	echo "Usage: scripts/find-unused-docs.sh directory"
+	echo "Usage: tools/docs/find-unused-docs.sh directory"
 	exit 1
 fi
 
-- 
2.51.0


