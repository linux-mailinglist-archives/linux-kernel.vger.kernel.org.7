Return-Path: <linux-kernel+bounces-867352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8687C02573
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68833A5691
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02672C11EA;
	Thu, 23 Oct 2025 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FzwL4OJs"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841D296BC4;
	Thu, 23 Oct 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235856; cv=none; b=hxYtZONheVgfhht/Gt5UpEHAnlDccVKaPAAB/K6/0lTDpQ19+rdLR+PuIr9wt4W5mbAyfemVUam/aAuR23C5BuNT4BX9NQMKuzqauhH3FJ88ELBXUMluEGCB9+EUP+92EPGtrdIlmMJjYvz1hVcGUPPCP3hwVeJdY8KMQHxiSl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235856; c=relaxed/simple;
	bh=B3WMrEoBGqxwlKaiXZCd7ySlsfrFx7s1x23iMC5lcXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjCWZ9mhgKC6/7PWUvHIycu7VlYq+CPgOVBVanVNwzl0uInvHlpYWfzVB8ggpz92cBS5Hl1AWeu5PqIuiqhuL4BIw9nPDoR7HFUDr/z1N8c2iW6Gytzs5faP/wSx7I8q4RsUBxvR4hENU762UhWFaRyxLaNp0AZKnhAt1neyCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FzwL4OJs; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B717840B42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761235850; bh=RtbYJANxx8V4mpWmI9ykigw4M/n+z/0Lqbs+aZPz0xU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FzwL4OJsf+uQ95LmsdQ4xZ646p2uX0QtWprLEjVnpxihfA0s/sthFt4/+IRlbHwYW
	 V6rLJX6av0ic7kMdT/GR3aFgUrngTQ5FZsFkCGcYoa5qO2VkKk+QF53Q7cPobMn/UW
	 CFP0/EJQ7tFeK6UovWO0Avcy9BjKWfWuxYsXQtnmcNc29jUWH835zse47nPUMtPk6B
	 QqYXzyVkqktzkCD3aercBe11ApJF4rcfeocpwDO/0ym3NX21pbWOKZs/500F33EY4t
	 POZTuPSiigb6X5DAt9P8wAnEeg8at5MsnLC4Q1R/0UaYFamqM0Mu5Vx9jRzalFVnHh
	 Fd8hANWYpS8xA==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id B717840B42;
	Thu, 23 Oct 2025 16:10:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 09/10] docs: move find-unused-docs.sh to tools/docs
Date: Thu, 23 Oct 2025 10:10:17 -0600
Message-ID: <20251023161027.697135-10-corbet@lwn.net>
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

...and update references accordingly.

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
index 1fb265a0ffd0..2f2195a77c60 100755
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


