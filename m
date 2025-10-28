Return-Path: <linux-kernel+bounces-874811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B61C1725B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 121294E283A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D799B35771F;
	Tue, 28 Oct 2025 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Jshba6H9"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23863557E9;
	Tue, 28 Oct 2025 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761689432; cv=none; b=hENChI4GvuAHVBb3J+C9qtX4D1VwTDb3ai1/EN+opdFCJV3hS9Qc9drAIsmE+xRp5rU1Hu9LxcmS125hjMjsc4FRVllll+ta83xXKPtLHvPHIU+yEfOAQGPJoTBHfzvuQAUBhKtyeMqx8qVCgb93lafOMD5woCJs1PU5jgn7RwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761689432; c=relaxed/simple;
	bh=/14+de53sdHLFxJy3FlGFFHpx3a4rldgHBttfIj2tlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYLhXiO+oost/X/o0csao+naXyqbEbiI9fXedU2aTH3Rul9psprF9qcQ5oYyjdsb2IWl9dRbnpxV6k03SaYk104If1rL1E37MtV7XfHe+cjoPqSj3ub0cqFCWll8zbroTdmA80YcxCnFTrqy6zAXTdTDmj3ootnlV0pL+z4VD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Jshba6H9; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5A8B240B3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761689426; bh=gKQ8fFVrdgwZdfTHmfmE67b43gu/oNObSB701iiqA04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jshba6H9+IMkv9V/3NpVeEe1KvqIzqHW1l8sXECeN3KakFChXGnsBSFdvkwJBfMAO
	 KbnXiR5Ul6/UCzOpcz/nKS+101EIXhep8oQkZzj9b8Q+9VB33K/eHZZmwGT8uSH/QF
	 zuNcl1uoBIukraDaRLqTZ0QzMCdq+KJoCY+WNVfkMatRKusxwWXxYV8DkY1LGRhDOZ
	 J2c77OZN2WqF2AkXgQB9ZPtox2Q4ksR3NXFg4B+ZGRpjVl+DUtbbe3gRm+OS9jOqyT
	 7a6De039t/7V+JdMm+gXzHMJBQOECbOq8HPBJSW7l2I2xqBEw34bQ/qxbTZrcy7fTT
	 HsVszhyYg7rcg==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 5A8B240B3A;
	Tue, 28 Oct 2025 22:10:25 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v4 2/7] docs: move checktransupdate.py to tools/docs
Date: Tue, 28 Oct 2025 16:10:10 -0600
Message-ID: <20251028221017.5785-3-corbet@lwn.net>
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

The checktranslate.py tool currently languishes in scripts/; move it to
tools/docs and update references accordingly.

Cc: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <si.yanteng@linux.dev>
Cc: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/doc-guide/checktransupdate.rst              | 6 +++---
 .../translations/zh_CN/doc-guide/checktransupdate.rst     | 6 +++---
 Documentation/translations/zh_CN/how-to.rst               | 2 +-
 MAINTAINERS                                               | 1 -
 {scripts => tools/docs}/checktransupdate.py               | 8 ++++----
 5 files changed, 11 insertions(+), 12 deletions(-)
 rename {scripts => tools/docs}/checktransupdate.py (97%)

diff --git a/Documentation/doc-guide/checktransupdate.rst b/Documentation/doc-guide/checktransupdate.rst
index dfaf9d373747..7b25375cc6d9 100644
--- a/Documentation/doc-guide/checktransupdate.rst
+++ b/Documentation/doc-guide/checktransupdate.rst
@@ -27,15 +27,15 @@ Usage
 
 ::
 
-   ./scripts/checktransupdate.py --help
+   tools/docs/checktransupdate.py --help
 
 Please refer to the output of argument parser for usage details.
 
 Samples
 
--  ``./scripts/checktransupdate.py -l zh_CN``
+-  ``tools/docs/checktransupdate.py -l zh_CN``
    This will print all the files that need to be updated in the zh_CN locale.
--  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst``
+-  ``tools/docs/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst``
    This will only print the status of the specified file.
 
 Then the output is something like:
diff --git a/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
index d20b4ce66b9f..dbfd65398077 100644
--- a/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
+++ b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
@@ -28,15 +28,15 @@
 
 ::
 
-    ./scripts/checktransupdate.py --help
+    tools/docs/checktransupdate.py --help
 
 具体用法请参考参数解析器的输出
 
 示例
 
--  ``./scripts/checktransupdate.py -l zh_CN``
+-  ``tools/docs/checktransupdate.py -l zh_CN``
    这将打印 zh_CN 语言中需要更新的所有文件。
--  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst``
+-  ``tools/docs/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst``
    这将只打印指定文件的状态。
 
 然后输出类似如下的内容：
diff --git a/Documentation/translations/zh_CN/how-to.rst b/Documentation/translations/zh_CN/how-to.rst
index 714664fec308..7ae5d8765888 100644
--- a/Documentation/translations/zh_CN/how-to.rst
+++ b/Documentation/translations/zh_CN/how-to.rst
@@ -437,7 +437,7 @@ git email 默认会抄送给您一份，所以您可以切换为审阅者的角
 对于首次参与 Linux 内核中文文档翻译的新手，建议您在 linux 目录中运行以下命令：
 ::
 
-	./script/checktransupdate.py -l zh_CN``
+	tools/docs/checktransupdate.py -l zh_CN``
 
 该命令会列出需要翻译或更新的英文文档，结果同时保存在 checktransupdate.log 中。
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 5aa6d769b254..cd187b9f1dc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7411,7 +7411,6 @@ S:	Maintained
 P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
-F:	scripts/checktransupdate.py
 F:	scripts/documentation-file-ref-check
 F:	scripts/get_abi.py
 F:	scripts/kernel-doc*
diff --git a/scripts/checktransupdate.py b/tools/docs/checktransupdate.py
similarity index 97%
rename from scripts/checktransupdate.py
rename to tools/docs/checktransupdate.py
index e39529e46c3d..e894652369a5 100755
--- a/scripts/checktransupdate.py
+++ b/tools/docs/checktransupdate.py
@@ -9,9 +9,9 @@ commit to find the latest english commit from the translation commit
 differences occur, report the file and commits that need to be updated.
 
 The usage is as follows:
-- ./scripts/checktransupdate.py -l zh_CN
+- tools/docs/checktransupdate.py -l zh_CN
 This will print all the files that need to be updated or translated in the zh_CN locale.
-- ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst
+- tools/docs/checktransupdate.py Documentation/translations/zh_CN/dev-tools/testing-overview.rst
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
2.51.0


