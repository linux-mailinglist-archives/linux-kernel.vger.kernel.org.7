Return-Path: <linux-kernel+bounces-767523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D37B25585
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD9D2A1B32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9F42FC696;
	Wed, 13 Aug 2025 21:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hhVafAcs"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D63C30AACA;
	Wed, 13 Aug 2025 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120759; cv=none; b=n5VBHJTgXiPNNd3Jqx/7pLiFm6EgSiiNGvldpAz3khpQTKw80aADJ0hAHPpq3tuVKqq3NlSFIdgQSJ+J6Du0nLAW6/vzRUmtLTEbzEoGPKN1NTw12sXoEPY3QQyTcEXzaZD+YmtZTFeL8TuU6egudGZIC16MvBPaPUw+ETndS6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120759; c=relaxed/simple;
	bh=bCqcEuYXIZ5FS0iGGlt/V5k155zzYR3s8m9do/BeNFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dscQwURhrY/ZYU+D645O7R2BO32mHZqPCfpHZ37Bg0sRoYOh1oETWIFJi+4Ffb44F3cssfYr/zGHJ0Uc/Hoa7XLwUoRuBZ+8CnLRl/C1jbxNEZVj/fK40j/TfBtKnh8xezNnYznLEhfcn6ateYpypVpmkCJDP9ZNrfBizy7tg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hhVafAcs; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9AC0A40AFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755120753; bh=n0Uge/EydivOUALbTlxUcyMHQ+hRH50kMHQoRmNZbsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhVafAcso4jU6ES5Kl6Km6bZcrjTFmUX3wtKUgbPPO2sA3IFGdhkIQQynqR8X2eh7
	 rYmgWmaEUjjpOxfMONtofgT0XumzXBf5THhtQCau7u0LQ9ZxuLEUuJyYhtUOSTWx6l
	 Hyu0td5mqz3Eo5wCCKaE3Cw/U40ySREr9pCzBktumEnP+RCeGyJtU5mD/jqNPJ4Wx5
	 bfOATRAr2qKPAi0znNDLm8djZrD7K4iDurtFG4wZeD3Xw3fTMBPZj6sJtnbVC0F+Fa
	 nKB6li2AqX3Frkwo9VpMSaToI4k5a7LgPxb3MbKrLivoy6ZUYufE2n2Oqu5a7ocyZt
	 xkACiZS+frnew==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 9AC0A40AFC;
	Wed, 13 Aug 2025 21:32:32 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 09/13] docs: move parse-headers.pl to tools/doc
Date: Wed, 13 Aug 2025 15:32:08 -0600
Message-ID: <20250813213218.198582-10-corbet@lwn.net>
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

Move the tool and fix all the references, including the numerous ones that
said "parse_headers" instead of "parse-headers".

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/doc-guide/parse-headers.rst                   | 6 +++---
 .../translations/it_IT/doc-guide/parse-headers.rst          | 6 +++---
 .../translations/zh_CN/doc-guide/parse-headers.rst          | 6 +++---
 Documentation/userspace-api/media/Makefile                  | 2 +-
 MAINTAINERS                                                 | 1 -
 {Documentation/sphinx => tools/doc}/parse-headers.pl        | 4 ++--
 6 files changed, 12 insertions(+), 13 deletions(-)
 rename {Documentation/sphinx => tools/doc}/parse-headers.pl (98%)

diff --git a/Documentation/doc-guide/parse-headers.rst b/Documentation/doc-guide/parse-headers.rst
index 204b025f1349..954cd81523a0 100644
--- a/Documentation/doc-guide/parse-headers.rst
+++ b/Documentation/doc-guide/parse-headers.rst
@@ -15,14 +15,14 @@ about how to use it inside the Kernel tree.
 
 .. _parse_headers:
 
-parse_headers.pl
+parse-headers.pl
 ^^^^^^^^^^^^^^^^
 
 NAME
 ****
 
 
-parse_headers.pl - parse a C file, in order to identify functions, structs,
+parse-headers.pl - parse a C file, in order to identify functions, structs,
 enums and defines and create cross-references to a Sphinx book.
 
 
@@ -30,7 +30,7 @@ SYNOPSIS
 ********
 
 
-\ **parse_headers.pl**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
+\ **parse-headers.pl**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
 
 Where <options> can be: --debug, --help or --usage.
 
diff --git a/Documentation/translations/it_IT/doc-guide/parse-headers.rst b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
index 026a23e49767..45b6b6fc4fb5 100644
--- a/Documentation/translations/it_IT/doc-guide/parse-headers.rst
+++ b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
@@ -20,21 +20,21 @@ consultate ``Documentation/userspace-api/media/Makefile``.
 
 .. _it_parse_headers:
 
-parse_headers.pl
+parse-headers.pl
 ^^^^^^^^^^^^^^^^
 
 NOME
 ****
 
 
-parse_headers.pl - analizza i file C al fine di identificare funzioni,
+parse-headers.pl - analizza i file C al fine di identificare funzioni,
 strutture, enumerati e definizioni, e creare riferimenti per Sphinx
 
 SINTASSI
 ********
 
 
-\ **parse_headers.pl**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
+\ **parse-headers.pl**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
 
 Dove <options> può essere: --debug, --usage o --help.
 
diff --git a/Documentation/translations/zh_CN/doc-guide/parse-headers.rst b/Documentation/translations/zh_CN/doc-guide/parse-headers.rst
index a08819e904ed..22253fea5da1 100644
--- a/Documentation/translations/zh_CN/doc-guide/parse-headers.rst
+++ b/Documentation/translations/zh_CN/doc-guide/parse-headers.rst
@@ -19,14 +19,14 @@ Sphinx将生成警告。这有助于保持用户空间API文档与内核更改
 
 .. _parse_headers_zh:
 
-parse_headers.pl
+parse-headers.pl
 ----------------
 
 脚本名称
 ~~~~~~~~
 
 
-parse_headers.pl——解析一个C文件，识别函数、结构体、枚举、定义并对Sphinx文档
+parse-headers.pl——解析一个C文件，识别函数、结构体、枚举、定义并对Sphinx文档
 创建交叉引用。
 
 
@@ -34,7 +34,7 @@ parse_headers.pl——解析一个C文件，识别函数、结构体、枚举、
 ~~~~~~~~
 
 
-\ **parse_headers.pl**\  [<选项>] <C文件> <输出文件> [<例外文件>]
+\ **parse-headers.pl**\  [<选项>] <C文件> <输出文件> [<例外文件>]
 
 <选项> 可以是： --debug, --help 或 --usage 。
 
diff --git a/Documentation/userspace-api/media/Makefile b/Documentation/userspace-api/media/Makefile
index 3d8aaf5c253b..632798bca615 100644
--- a/Documentation/userspace-api/media/Makefile
+++ b/Documentation/userspace-api/media/Makefile
@@ -3,7 +3,7 @@
 # Rules to convert a .h file to inline RST documentation
 
 SRC_DIR=$(srctree)/Documentation/userspace-api/media
-PARSER = $(srctree)/Documentation/sphinx/parse-headers.pl
+PARSER = $(srctree)/tools/doc/parse-headers.pl
 UAPI = $(srctree)/include/uapi/linux
 KAPI = $(srctree)/include/linux
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 2f1374130240..c2d2ce92bf79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7338,7 +7338,6 @@ DOCUMENTATION SCRIPTS
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-doc@vger.kernel.org
 S:	Maintained
-F:	Documentation/sphinx/parse-headers.pl
 F:	tools/doc/
 
 DOCUMENTATION/ITALIAN
diff --git a/Documentation/sphinx/parse-headers.pl b/tools/doc/parse-headers.pl
similarity index 98%
rename from Documentation/sphinx/parse-headers.pl
rename to tools/doc/parse-headers.pl
index 7b1458544e2e..47b90bf8c96d 100755
--- a/Documentation/sphinx/parse-headers.pl
+++ b/tools/doc/parse-headers.pl
@@ -340,12 +340,12 @@ __END__
 
 =head1 NAME
 
-parse_headers.pl - parse a C file, in order to identify functions, structs,
+parse-headers.pl - parse a C file, in order to identify functions, structs,
 enums and defines and create cross-references to a Sphinx book.
 
 =head1 SYNOPSIS
 
-B<parse_headers.pl> [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
+B<parse-headers.pl> [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
 
 Where <options> can be: --debug, --help or --usage.
 
-- 
2.50.1


