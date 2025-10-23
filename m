Return-Path: <linux-kernel+bounces-867346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF7FC02555
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E283A2BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AD6296BD4;
	Thu, 23 Oct 2025 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="f4VUpO5D"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022127BF80;
	Thu, 23 Oct 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235853; cv=none; b=eMUN6dqhoOX+RRYIYrLty3plHcoBnr6BFV7H8nwdwVbU3RXcsm6wreB1giJnd9g+HNtGUuAtf13OdPFoIdK7LbfOySex8ObTDlthJD2W+lmRnaRvmlKjp+KuUVXlOP8IYj3eQ/bbE3T2TnuC0fUDKS+CJox+oX7YQNeFrRqz/zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235853; c=relaxed/simple;
	bh=1DeAt+miaf7OBthY5pdWlHKaoZyqCaTCoxx2d2ZGGEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XY87AqHBa2lmx8iwX8GVYO/01QNAT2c6O35lBHX5JibKB520TyVJKlJGWNyW9J7XyCh4jXKRMysree1Zy15bMspJOnJYI1yeFKDqMN4oKpGLmzgQNbqP9b18v4qaLZZaGWryM0kQexfj21TcDZzkK7qQkQPxK8/6F4/SZG9n7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=f4VUpO5D; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6221C40B38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761235845; bh=9rMXRjXbCdAJHtM1bzSH9NAyKdbEgLHTKEMBp8A8CXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4VUpO5Dje4PP4FS9Fd8LAgWYAIlsn+6QwPbhL7/u5j+s/AgYlSSE4w1aYESYf8+c
	 Pa4p8naJVQ70azLynaJMQa6Ssmcs88O2h1kM7Gk7pVt0PulAPlpfGkPt3JVIZpp7qb
	 VhI1LmtOP+jkimWIXqML+GJN3DQ7r5NVpQlO0G05fQRB+mQqMcxC7Hhhw00bUKp7V+
	 2P78ijB8r17A7tPGTCH1/dbCo4Mx4x4nvL61CcyY6tnj4JQPYlsJAz+2UCgEHXI4Zd
	 GMgS/XDApHdW1h/r54Q6qqoxWhS7zdb4RTbtiPPczKoJG8c+fxnRBqKOGaPLPumnNH
	 6W4Mdvjs4zFVQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 6221C40B38;
	Thu, 23 Oct 2025 16:10:44 +0000 (UTC)
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
	Dongliang Mu <dzm91@hust.edu.cn>
Subject: [PATCH v2 02/10] docs: move checktransupdate.py to tools/docs
Date: Thu, 23 Oct 2025 10:10:10 -0600
Message-ID: <20251023161027.697135-3-corbet@lwn.net>
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

The checktranslate.py tool currently languishes in scripts/; move it to
tools/docs and update references accordingly.

Cc: Alex Shi <alexs@kernel.org>
Cc: Yanteng Si <si.yanteng@linux.dev>
Cc: Dongliang Mu <dzm91@hust.edu.cn>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/doc-guide/checktransupdate.rst              | 6 +++---
 .../translations/zh_CN/doc-guide/checktransupdate.rst     | 6 +++---
 Documentation/translations/zh_CN/how-to.rst               | 2 +-
 MAINTAINERS                                               | 2 +-
 {scripts => tools/docs}/checktransupdate.py               | 8 ++++----
 5 files changed, 12 insertions(+), 12 deletions(-)
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
index ddd99c0f9b4d..0d51bdf72e95 100644
--- a/Documentation/translations/zh_CN/how-to.rst
+++ b/Documentation/translations/zh_CN/how-to.rst
@@ -437,7 +437,7 @@ git email 默认会抄送给您一份，所以您可以切换为审阅者的角
 对于首次参与 Linux 内核中文文档翻译的新手，建议您在 linux 目录中运行以下命令：
 ::
 
-	./script/checktransupdate.py -l zh_CN``
+	tools/docs/checktransupdate.py -l zh_CN``
 
 该命令会列出需要翻译或更新的英文文档，结果同时保存在 checktransupdate.log 中。
 
diff --git a/MAINTAINERS b/MAINTAINERS
index dafc11712544..1b5413e779f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7301,8 +7301,8 @@ S:	Maintained
 P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
+F:	tools/docs/
 F:	scripts/check-variable-fonts.sh
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


