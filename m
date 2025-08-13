Return-Path: <linux-kernel+bounces-767517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ACCB2558B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6852D1894ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1839030E82E;
	Wed, 13 Aug 2025 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="c6SwqjFF"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B72D0619;
	Wed, 13 Aug 2025 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120757; cv=none; b=mFPOmwcYhV1dE4W35fH+PnRBa8H3v705UF1xVzX5N3EiRcP6EnLtIg4+K/soTqH9JHtwCKIvJcc4H+4ZsfaX95smaWvmThnidJyts2l9VvbTgANswwV7J/O0ZPJpRdBPuv7XQIt8PsKaK3j4ADxvXg8IanRvRFsoialS1VRZiBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120757; c=relaxed/simple;
	bh=GAeSo81aRJCHa6njntB+bHNuYGxPFpAiBOc+6zf1/+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oo3Mw2I3JVNPnh609nkDs/ihRwfTZcZI192E3DX4mzXp6zjyZj85vYcX3OQjByavVf99xdSdELxTPF1MXmgydtGzIFargO+fa9imgwdqY0hKvbeMsZ9nALfn6VOMTyvS5ZHIk0rL1E9JekIPKeS/QGZdAQqh7HeXBoNxoJUSVH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=c6SwqjFF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7998840AF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755120748; bh=PsPNbSaYzwvhzthLzHDyROjNPxhZjHCPCuc2sHZOU0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6SwqjFFaGUzkYjXMPRDY3maNfLir6CDu0UqnTEjzxl43FrpBf0WmfvNlDAAlzhZC
	 HbUtzT8ziHER4OBI/GRRLGBiXtP96NRzBuWsTq9r+Updjw2KDhOINYmeZgzlW/4lIi
	 CbHo8NL+fGyVSyd4Yldnb8oGkeqhcssXEghSNF/jJ3sxD9NcbjRKh4Pv1O9Tvk5eWa
	 E2tf4MfDf4/unpfWM+aynHeZcH76J1UsIK4eMVgUNtMc4w3PD6YRZRMAOlypQlRq0Q
	 WKA32CXs/u5Cf32DfDdj3f5SkAvwkq9Dy1XRr7VbiMNaZ8Dncqs76Yg/WedY2S5ZS5
	 FVlOjTK0gBfRw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 7998840AF5;
	Wed, 13 Aug 2025 21:32:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 02/13] docs: move checktransupdate.py to tools/doc
Date: Wed, 13 Aug 2025 15:32:01 -0600
Message-ID: <20250813213218.198582-3-corbet@lwn.net>
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

The checktranslate.py tool currently languishes in scripts/; move it to
tools/doc and update references accordingly.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/doc-guide/checktransupdate.rst              | 6 +++---
 .../translations/zh_CN/doc-guide/checktransupdate.rst     | 6 +++---
 Documentation/translations/zh_CN/how-to.rst               | 2 +-
 MAINTAINERS                                               | 2 +-
 {scripts => tools/doc}/checktransupdate.py                | 8 ++++----
 5 files changed, 12 insertions(+), 12 deletions(-)
 rename {scripts => tools/doc}/checktransupdate.py (98%)

diff --git a/Documentation/doc-guide/checktransupdate.rst b/Documentation/doc-guide/checktransupdate.rst
index dfaf9d373747..48bf1ee9a62e 100644
--- a/Documentation/doc-guide/checktransupdate.rst
+++ b/Documentation/doc-guide/checktransupdate.rst
@@ -27,15 +27,15 @@ Usage
 
 ::
 
-   ./scripts/checktransupdate.py --help
+   tools/doc/checktransupdate.py --help
 
 Please refer to the output of argument parser for usage details.
 
 Samples
 
--  ``./scripts/checktransupdate.py -l zh_CN``
+-  ``tools/doc/checktransupdate.py -l zh_CN``
    This will print all the files that need to be updated in the zh_CN locale.
--  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst``
+-  ``tools/doc/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst``
    This will only print the status of the specified file.
 
 Then the output is something like:
diff --git a/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
index d20b4ce66b9f..165e25155084 100644
--- a/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
+++ b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
@@ -28,15 +28,15 @@
 
 ::
 
-    ./scripts/checktransupdate.py --help
+    tools/doc/checktransupdate.py --help
 
 具体用法请参考参数解析器的输出
 
 示例
 
--  ``./scripts/checktransupdate.py -l zh_CN``
+-  ``tools/doc/checktransupdate.py -l zh_CN``
    这将打印 zh_CN 语言中需要更新的所有文件。
--  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst``
+-  ``tools/doc/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst``
    这将只打印指定文件的状态。
 
 然后输出类似如下的内容：
diff --git a/Documentation/translations/zh_CN/how-to.rst b/Documentation/translations/zh_CN/how-to.rst
index ddd99c0f9b4d..cf66c72ee0c5 100644
--- a/Documentation/translations/zh_CN/how-to.rst
+++ b/Documentation/translations/zh_CN/how-to.rst
@@ -437,7 +437,7 @@ git email 默认会抄送给您一份，所以您可以切换为审阅者的角
 对于首次参与 Linux 内核中文文档翻译的新手，建议您在 linux 目录中运行以下命令：
 ::
 
-	./script/checktransupdate.py -l zh_CN``
+	tools/doc/checktransupdate.py -l zh_CN``
 
 该命令会列出需要翻译或更新的英文文档，结果同时保存在 checktransupdate.log 中。
 
diff --git a/MAINTAINERS b/MAINTAINERS
index dafc11712544..a3a396fc1c3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7301,8 +7301,8 @@ S:	Maintained
 P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
+F:	tools/doc/
 F:	scripts/check-variable-fonts.sh
-F:	scripts/checktransupdate.py
 F:	scripts/documentation-file-ref-check
 F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
diff --git a/scripts/checktransupdate.py b/tools/doc/checktransupdate.py
similarity index 98%
rename from scripts/checktransupdate.py
rename to tools/doc/checktransupdate.py
index e39529e46c3d..61bd7b02ca55 100755
--- a/scripts/checktransupdate.py
+++ b/tools/doc/checktransupdate.py
@@ -9,9 +9,9 @@ commit to find the latest english commit from the translation commit
 differences occur, report the file and commits that need to be updated.
 
 The usage is as follows:
-- ./scripts/checktransupdate.py -l zh_CN
+- tools/doc/checktransupdate.py -l zh_CN
 This will print all the files that need to be updated or translated in the zh_CN locale.
-- ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst
+- tools/doc/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst
 This will only print the status of the specified file.
 
 The output is something like:
@@ -168,7 +168,7 @@ def check_per_file(file_path):
 def valid_locales(locale):
     """Check if the locale is valid or not"""
     script_path = os.path.dirname(os.path.abspath(__file__))
-    linux_path = os.path.join(script_path, "..")
+    linux_path = os.path.join(script_path, "../..")
     if not os.path.isdir(f"{linux_path}/Documentation/translations/{locale}"):
         raise ArgumentTypeError("Invalid locale: {locale}")
     return locale
@@ -232,7 +232,7 @@ def config_logging(log_level, log_file="checktransupdate.log"):
 def main():
     """Main function of the script"""
     script_path = os.path.dirname(os.path.abspath(__file__))
-    linux_path = os.path.join(script_path, "..")
+    linux_path = os.path.join(script_path, "../..")
 
     parser = ArgumentParser(description="Check the translation update")
     parser.add_argument(
-- 
2.50.1


