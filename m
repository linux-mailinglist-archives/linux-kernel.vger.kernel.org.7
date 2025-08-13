Return-Path: <linux-kernel+bounces-767524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E91B25599
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967CA1BC09DD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F9A2FC68F;
	Wed, 13 Aug 2025 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AR2qs5kN"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CBC30AADC;
	Wed, 13 Aug 2025 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120759; cv=none; b=KmaPJOQTK+7ardkoRMnf9jGWSblwxi2NzCbI12q527QsTufzhixNxvHPtWehx6Uz+hBjjUoT8klliTMonnx8R3Hd30z55yUWXPizZB/2Sq5eKhP7viz+L5yTXp6VE0dVGrTv3tinY3/sR8wWZnAj94xeOvooOBTxPm4eYEI6Usw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120759; c=relaxed/simple;
	bh=cHVafsQkMatusIyl18LnCBDDt3qyCUmVBGagdV25Z4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vh386Ent/3q0NhLYpMAyznPRj8pDsNpLroOOcSZQSwbaXz83N+GN0NAxBAZbxZbjUGiVS88N2n/qjhC8Os//Wj58CVy+2+Pn5aJqD4UPM83dxpU+ePp1Ij7svLGzHmh5do/9KV7m9qOj4cWNlJKyXpTkYjFmpN57eHWyc9WLIYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AR2qs5kN; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5A51D40AFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755120754; bh=ciA6v8vzpOCLxeWYQORVHLpqww7jCTPQ8HyEFYK1r4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AR2qs5kNk3zh31ibd/2k7Qln6r4g1TyxFmuCjgSrowl3QoqFc5K0UhCTF/MhfBrCE
	 /LTW/XKIrSqFHopXsn/PICyyjyLInaKPaQPwhB1075ej1SXqKfXsYX0426vrGsdsY6
	 78ge88lfckzPNPPqGasapy0L4EZjtCYM6EFEWRmqGOmONpMVj7mDJeH8qAb5FMGUww
	 mqkNqAZCQ7v7akXQMKM8BWE/9uaRXj9a1SbmMyQkvui5LfnJbuL1m79MJFjlA9cxT8
	 qhKvQRK2eIY7SEd00tTt550NOV0qfHU44WopXYNUMzYpjH7+61/IjfA7zVoeTMp+yY
	 o2NzMMcTszPGQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 5A51D40AFF;
	Wed, 13 Aug 2025 21:32:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 12/13] docs: move find-unused-docs.sh to tools/doc
Date: Wed, 13 Aug 2025 15:32:11 -0600
Message-ID: <20250813213218.198582-13-corbet@lwn.net>
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

...and update references accordingly.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/doc-guide/contributing.rst                    | 2 +-
 Documentation/translations/zh_CN/doc-guide/contributing.rst | 2 +-
 {scripts => tools/doc}/find-unused-docs.sh                  | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename {scripts => tools/doc}/find-unused-docs.sh (85%)

diff --git a/Documentation/doc-guide/contributing.rst b/Documentation/doc-guide/contributing.rst
index 662c7a840cd5..81633c6c6c11 100644
--- a/Documentation/doc-guide/contributing.rst
+++ b/Documentation/doc-guide/contributing.rst
@@ -152,7 +152,7 @@ generate links to that documentation.  Adding ``kernel-doc`` directives to
 the documentation to bring those comments in can help the community derive
 the full value of the work that has gone into creating them.
 
-The ``scripts/find-unused-docs.sh`` tool can be used to find these
+The ``tools/doc/find-unused-docs.sh`` tool can be used to find these
 overlooked comments.
 
 Note that the most value comes from pulling in the documentation for
diff --git a/Documentation/translations/zh_CN/doc-guide/contributing.rst b/Documentation/translations/zh_CN/doc-guide/contributing.rst
index 394a13b438b0..d205f8ed9fce 100644
--- a/Documentation/translations/zh_CN/doc-guide/contributing.rst
+++ b/Documentation/translations/zh_CN/doc-guide/contributing.rst
@@ -124,7 +124,7 @@ C代码编译器发出的警告常常会被视为误报，从而导致出现了
 这使得这些信息更难找到，例如使Sphinx无法生成指向该文档的链接。将 ``kernel-doc``
 指令添加到文档中以引入这些注释可以帮助社区获得为编写注释所做工作的全部价值。
 
-``scripts/find-unused-docs.sh`` 工具可以用来找到这些被忽略的评论。
+``tools/doc/find-unused-docs.sh`` 工具可以用来找到这些被忽略的评论。
 
 请注意，将导出的函数和数据结构引入文档是最有价值的。许多子系统还具有供内部
 使用的kernel-doc注释；除非这些注释放在专门针对相关子系统开发人员的文档中，
diff --git a/scripts/find-unused-docs.sh b/tools/doc/find-unused-docs.sh
similarity index 85%
rename from scripts/find-unused-docs.sh
rename to tools/doc/find-unused-docs.sh
index 0ae445dec2e4..a64389a15f09 100755
--- a/scripts/find-unused-docs.sh
+++ b/tools/doc/find-unused-docs.sh
@@ -5,10 +5,10 @@
 # This script detects files with kernel-doc comments for exported functions
 # that are not included in documentation.
 #
-# usage: Run 'scripts/find-unused-docs.sh directory' from top level of kernel
+# usage: Run 'tools/doc/find-unused-docs.sh directory' from top level of kernel
 # 	 tree.
 #
-# example: $scripts/find-unused-docs.sh drivers/scsi
+# example: $tools/doc/find-unused-docs.sh drivers/scsi
 #
 # Licensed under the terms of the GNU GPL License
 
@@ -18,7 +18,7 @@ if ! [ -d "Documentation" ]; then
 fi
 
 if [ "$#" -ne 1 ]; then
-	echo "Usage: scripts/find-unused-docs.sh directory"
+	echo "Usage: tools/doc/find-unused-docs.sh directory"
 	exit 1
 fi
 
-- 
2.50.1


