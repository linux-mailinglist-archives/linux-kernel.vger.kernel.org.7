Return-Path: <linux-kernel+bounces-767526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6EBB25590
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214B82A4FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF4F2FE2EF;
	Wed, 13 Aug 2025 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SLQr5zo5"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5BA30AAC9;
	Wed, 13 Aug 2025 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120759; cv=none; b=uFzuCcwn7j22tv5Ouo16Z0Td37L31MAEQwJvUNx7zc5g96e+n0MA1F7GsuY7VSGNG8KvUtHF3wbLHexTlPMJeTJXgsTw2eA7gyMlJm7DrPJhlKPzfv+sYg4ZyPN37WYAWRXYYMFPpkZ9WlwA8OJB1+czdz87laxOHSkoOVuozFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120759; c=relaxed/simple;
	bh=l2wAMQP4sd8u8DIkV05eu2m8rWVPbKq2bfICqcnq5cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSB3pcNEaUYGIoKq29Uo31TPTC8nx++G47YZrluW42OM7K1gUC+8smAyyXlkYjU2erb5WOhiDIkyG/jgAzax3L0jGX07hUz/uDpSmD3GYPrKhB7M37ti0N+lWfd55fCzN1ody1rDJQNwRtLMMyT7vLTx05o4IGXL/Vp/9iROWik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SLQr5zo5; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 32A8940AFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755120753; bh=32vKyyGUyTxxutit98H+4XopSx7i9WC4YipC+gt6Ig4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLQr5zo5BocxqDDkYG4SrgGkR1dsnPio2rfyKX0XbAzUyxClkFRRGLuqy5CGKQ8xz
	 9L7DhaxXaG24BKEa0Nb1DRkwDU8akZuqAHjGnTVcDbbK89qrCPJKWNM4YMpXRI5xxm
	 FBOSYgAHCxlH4dK9YK3+Khi/4RNR3j2GhAHkd3VeGzzcJvyWOjEgaVYppz7brXTY2H
	 L0USSF98bCtS/6WnK0Uufz966NG/mVijijMoHg3xLf0oXtYbHKwyvSGqwcxM3c1GiM
	 /HPMYzOSFiZ9lwmTPZFPk2r34KLMB9bn8nlZC4WxVmvskzEPYpO0pZM0JREWZ0WhWf
	 2IwwgJak8q4ow==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 32A8940AFE;
	Wed, 13 Aug 2025 21:32:33 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 10/13] docs: move kernel-doc to tools/doc
Date: Wed, 13 Aug 2025 15:32:09 -0600
Message-ID: <20250813213218.198582-11-corbet@lwn.net>
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

Move kernel-doc to join the rest of the tools, and update references
throughout the tree.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/conf.py                                |  2 +-
 Documentation/doc-guide/kernel-doc.rst               | 12 ++++++------
 Documentation/kbuild/kbuild.rst                      |  2 +-
 Documentation/process/coding-style.rst               |  2 +-
 .../translations/it_IT/doc-guide/kernel-doc.rst      |  8 ++++----
 .../translations/sp_SP/process/coding-style.rst      |  2 +-
 .../translations/zh_CN/doc-guide/kernel-doc.rst      | 10 +++++-----
 Documentation/translations/zh_CN/kbuild/kbuild.rst   |  2 +-
 .../translations/zh_CN/process/coding-style.rst      |  2 +-
 .../translations/zh_TW/process/coding-style.rst      |  2 +-
 MAINTAINERS                                          |  1 -
 Makefile                                             |  2 +-
 drivers/gpu/drm/i915/Makefile                        |  2 +-
 scripts/find-unused-docs.sh                          |  2 +-
 scripts/kernel-doc                                   |  1 -
 scripts/kernel-doc.py => tools/doc/kernel-doc        |  0
 16 files changed, 25 insertions(+), 27 deletions(-)
 delete mode 120000 scripts/kernel-doc
 rename scripts/kernel-doc.py => tools/doc/kernel-doc (100%)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index f9828f3862f9..600cf5d32af8 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -564,7 +564,7 @@ pdf_documents = [
 # kernel-doc extension configuration for running Sphinx directly (e.g. by Read
 # the Docs). In a normal build, these are supplied from the Makefile via command
 # line arguments.
-kerneldoc_bin = "../scripts/kernel-doc.py"
+kerneldoc_bin = "../tools/doc/kernel-doc.py"
 kerneldoc_srctree = ".."
 
 # ------------------------------------------------------------------------------
diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index af9697e60165..6fc89d444ada 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -54,7 +54,7 @@ Running the ``kernel-doc`` tool with increased verbosity and without actual
 output generation may be used to verify proper formatting of the
 documentation comments. For example::
 
-	scripts/kernel-doc -v -none drivers/foo/bar.c
+	tools/doc/kernel-doc -v -none drivers/foo/bar.c
 
 The documentation format is verified by the kernel build when it is
 requested to perform extra gcc checks::
@@ -349,7 +349,7 @@ differentiated by whether the macro name is immediately followed by a
 left parenthesis ('(') for function-like macros or not followed by one
 for object-like macros.
 
-Function-like macros are handled like functions by ``scripts/kernel-doc``.
+Function-like macros are handled like functions by ``tools/doc/kernel-doc``.
 They may have a parameter list. Object-like macros have do not have a
 parameter list.
 
@@ -571,7 +571,7 @@ from the source file.
 
 The kernel-doc extension is included in the kernel source tree, at
 ``Documentation/sphinx/kerneldoc.py``. Internally, it uses the
-``scripts/kernel-doc`` script to extract the documentation comments from the
+``tools/doc/kernel-doc`` script to extract the documentation comments from the
 source.
 
 .. _kernel_doc:
@@ -582,17 +582,17 @@ How to use kernel-doc to generate man pages
 If you just want to use kernel-doc to generate man pages you can do this
 from the kernel git tree::
 
-  $ scripts/kernel-doc -man \
+  $ tools/doc/kernel-doc -man \
     $(git grep -l '/\*\*' -- :^Documentation :^tools) \
     | scripts/split-man.pl /tmp/man
 
 Some older versions of git do not support some of the variants of syntax for
 path exclusion.  One of the following commands may work for those versions::
 
-  $ scripts/kernel-doc -man \
+  $ tools/doc/kernel-doc -man \
     $(git grep -l '/\*\*' -- . ':!Documentation' ':!tools') \
     | scripts/split-man.pl /tmp/man
 
-  $ scripts/kernel-doc -man \
+  $ tools/doc/kernel-doc -man \
     $(git grep -l '/\*\*' -- . ":(exclude)Documentation" ":(exclude)tools") \
     | scripts/split-man.pl /tmp/man
diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 3388a10f2dcc..ae7b0669e3ec 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -180,7 +180,7 @@ architecture.
 KDOCFLAGS
 ---------
 Specify extra (warning/error) flags for kernel-doc checks during the build,
-see scripts/kernel-doc for which flags are supported. Note that this doesn't
+see tools/doc/kernel-doc for which flags are supported. Note that this doesn't
 (currently) apply to documentation builds.
 
 ARCH
diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index d1a8e5465ed9..b2d16449a27b 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -614,7 +614,7 @@ it.
 
 When commenting the kernel API functions, please use the kernel-doc format.
 See the files at :ref:`Documentation/doc-guide/ <doc_guide>` and
-``scripts/kernel-doc`` for details. Note that the danger of over-commenting
+``tools/doc/kernel-doc`` for details. Note that the danger of over-commenting
 applies to kernel-doc comments all the same. Do not add boilerplate
 kernel-doc which simply reiterates what's obvious from the signature
 of the function.
diff --git a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
index aa0e31d353d6..05ea0f03c80b 100644
--- a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
@@ -80,7 +80,7 @@ Al fine di verificare che i commenti siano formattati correttamente, potete
 eseguire il programma ``kernel-doc`` con un livello di verbosità alto e senza
 che questo produca alcuna documentazione. Per esempio::
 
-	scripts/kernel-doc -v -none drivers/foo/bar.c
+	tools/doc/kernel-doc -v -none drivers/foo/bar.c
 
 Il formato della documentazione è verificato della procedura di generazione
 del kernel quando viene richiesto di effettuare dei controlli extra con GCC::
@@ -378,7 +378,7 @@ distinguono in base al fatto che il nome della macro simile a funzione sia
 immediatamente seguito da una parentesi sinistra ('(') mentre in quelle simili a
 oggetti no.
 
-Le macro simili a funzioni sono gestite come funzioni da ``scripts/kernel-doc``.
+Le macro simili a funzioni sono gestite come funzioni da ``tools/doc/kernel-doc``.
 Possono avere un elenco di parametri. Le macro simili a oggetti non hanno un
 elenco di parametri.
 
@@ -595,7 +595,7 @@ documentazione presenti nel file sorgente (*source*).
 
 L'estensione kernel-doc fa parte dei sorgenti del kernel, la si può trovare
 in ``Documentation/sphinx/kerneldoc.py``. Internamente, viene utilizzato
-lo script ``scripts/kernel-doc`` per estrarre i commenti di documentazione
+lo script ``tools/doc/kernel-doc`` per estrarre i commenti di documentazione
 dai file sorgenti.
 
 Come utilizzare kernel-doc per generare pagine man
@@ -604,4 +604,4 @@ Come utilizzare kernel-doc per generare pagine man
 Se volete utilizzare kernel-doc solo per generare delle pagine man, potete
 farlo direttamente dai sorgenti del kernel::
 
-  $ scripts/kernel-doc -man $(git grep -l '/\*\*' -- :^Documentation :^tools) | scripts/split-man.pl /tmp/man
+  $ tools/doc/kernel-doc -man $(git grep -l '/\*\*' -- :^Documentation :^tools) | scripts/split-man.pl /tmp/man
diff --git a/Documentation/translations/sp_SP/process/coding-style.rst b/Documentation/translations/sp_SP/process/coding-style.rst
index 025223be9706..73c43b49480f 100644
--- a/Documentation/translations/sp_SP/process/coding-style.rst
+++ b/Documentation/translations/sp_SP/process/coding-style.rst
@@ -633,7 +633,7 @@ posiblemente POR QUÉ hace esto.
 
 Al comentar las funciones de la API del kernel, utilice el formato
 kernel-doc. Consulte los archivos en :ref:`Documentation/doc-guide/ <doc_guide>`
-y ``scripts/kernel-doc`` para más detalles.
+y ``tools/doc/kernel-doc`` para más detalles.
 
 El estilo preferido para comentarios largos (de varias líneas) es:
 
diff --git a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst b/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
index ccfb9b8329c2..b242e52f911c 100644
--- a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
+++ b/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
@@ -43,7 +43,7 @@ kernel-doc注释用 ``/**`` 作为开始标记。 ``kernel-doc`` 工具将提取
 用详细模式和不生成实际输出来运行 ``kernel-doc`` 工具，可以验证文档注释的格式
 是否正确。例如::
 
-	scripts/kernel-doc -v -none drivers/foo/bar.c
+	tools/doc/kernel-doc -v -none drivers/foo/bar.c
 
 当请求执行额外的gcc检查时，内核构建将验证文档格式::
 
@@ -473,7 +473,7 @@ doc: *title*
 如果没有选项，kernel-doc指令将包含源文件中的所有文档注释。
 
 kernel-doc扩展包含在内核源代码树中，位于 ``Documentation/sphinx/kerneldoc.py`` 。
-在内部，它使用 ``scripts/kernel-doc`` 脚本从源代码中提取文档注释。
+在内部，它使用 ``tools/doc/kernel-doc`` 脚本从源代码中提取文档注释。
 
 .. _kernel_doc_zh:
 
@@ -482,18 +482,18 @@ kernel-doc扩展包含在内核源代码树中，位于 ``Documentation/sphinx/k
 
 如果您只想使用kernel-doc生成手册页，可以从内核git树这样做::
 
-  $ scripts/kernel-doc -man \
+  $ tools/doc/kernel-doc -man \
     $(git grep -l '/\*\*' -- :^Documentation :^tools) \
     | scripts/split-man.pl /tmp/man
 
 一些旧版本的git不支持路径排除语法的某些变体。
 以下命令之一可能适用于这些版本::
 
-  $ scripts/kernel-doc -man \
+  $ tools/doc/kernel-doc -man \
     $(git grep -l '/\*\*' -- . ':!Documentation' ':!tools') \
     | scripts/split-man.pl /tmp/man
 
-  $ scripts/kernel-doc -man \
+  $ tools/doc/kernel-doc -man \
     $(git grep -l '/\*\*' -- . ":(exclude)Documentation" ":(exclude)tools") \
     | scripts/split-man.pl /tmp/man
 
diff --git a/Documentation/translations/zh_CN/kbuild/kbuild.rst b/Documentation/translations/zh_CN/kbuild/kbuild.rst
index e5e2aebe1ebc..3650a48a8db6 100644
--- a/Documentation/translations/zh_CN/kbuild/kbuild.rst
+++ b/Documentation/translations/zh_CN/kbuild/kbuild.rst
@@ -158,7 +158,7 @@ UTS_MACHINE 变量（在某些架构中还包括内核配置）来猜测正确
 KDOCFLAGS
 ---------
 指定在构建过程中用于 kernel-doc 检查的额外（警告/错误）标志，查看
-scripts/kernel-doc 了解支持的标志。请注意，这目前不适用于文档构建。
+tools/doc/kernel-doc 了解支持的标志。请注意，这目前不适用于文档构建。
 
 ARCH
 ----
diff --git a/Documentation/translations/zh_CN/process/coding-style.rst b/Documentation/translations/zh_CN/process/coding-style.rst
index 0484d0c65c25..64f0c13ff831 100644
--- a/Documentation/translations/zh_CN/process/coding-style.rst
+++ b/Documentation/translations/zh_CN/process/coding-style.rst
@@ -545,7 +545,7 @@ Linux 里这是提倡的做法，因为这样可以很简单的给读者提供
 也可以加上它做这些事情的原因。
 
 当注释内核 API 函数时，请使用 kernel-doc 格式。详见
-Documentation/translations/zh_CN/doc-guide/index.rst 和 scripts/kernel-doc 。
+Documentation/translations/zh_CN/doc-guide/index.rst 和 tools/doc/kernel-doc 。
 
 长 (多行) 注释的首选风格是：
 
diff --git a/Documentation/translations/zh_TW/process/coding-style.rst b/Documentation/translations/zh_TW/process/coding-style.rst
index 311c6f6bad0b..1e9dee6bbdd0 100644
--- a/Documentation/translations/zh_TW/process/coding-style.rst
+++ b/Documentation/translations/zh_TW/process/coding-style.rst
@@ -548,7 +548,7 @@ Linux 裏這是提倡的做法，因爲這樣可以很簡單的給讀者提供
 也可以加上它做這些事情的原因。
 
 當註釋內核 API 函數時，請使用 kernel-doc 格式。詳見
-Documentation/translations/zh_CN/doc-guide/index.rst 和 scripts/kernel-doc 。
+Documentation/translations/zh_CN/doc-guide/index.rst 和 tools/doc/kernel-doc 。
 
 長 (多行) 註釋的首選風格是：
 
diff --git a/MAINTAINERS b/MAINTAINERS
index c2d2ce92bf79..0fa427577f15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7302,7 +7302,6 @@ P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
 F:	tools/doc/
-F:	scripts/kernel-doc*
 F:	scripts/lib/abi/*
 F:	scripts/lib/kdoc/*
 F:	tools/net/ynl/pyynl/lib/doc_generator.py
diff --git a/Makefile b/Makefile
index 6bfe776bf3c5..44577bd357bb 100644
--- a/Makefile
+++ b/Makefile
@@ -460,7 +460,7 @@ HOSTPKG_CONFIG	= pkg-config
 
 # the KERNELDOC macro needs to be exported, as scripts/Makefile.build
 # has a logic to call it
-KERNELDOC       = $(srctree)/scripts/kernel-doc.py
+KERNELDOC       = $(srctree)/tools/doc/kernel-doc.py
 export KERNELDOC
 
 KBUILD_USERHOSTCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 853543443072..6e732e0079c1 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -426,7 +426,7 @@ always-$(CONFIG_DRM_I915_WERROR) += \
 
 quiet_cmd_hdrtest = HDRTEST $(patsubst %.hdrtest,%.h,$@)
       cmd_hdrtest = $(CC) $(filter-out $(CFLAGS_GCOV), $(c_flags)) -S -o /dev/null -x c /dev/null -include $<; \
-		$(srctree)/scripts/kernel-doc -none -Werror $<; touch $@
+		$(srctree)/tools/doc/kernel-doc -none -Werror $<; touch $@
 
 $(obj)/%.hdrtest: $(src)/%.h FORCE
 	$(call if_changed_dep,hdrtest)
diff --git a/scripts/find-unused-docs.sh b/scripts/find-unused-docs.sh
index d6d397fbf917..0ae445dec2e4 100755
--- a/scripts/find-unused-docs.sh
+++ b/scripts/find-unused-docs.sh
@@ -54,7 +54,7 @@ for file in `find $1 -name '*.c'`; do
 	if [[ ${FILES_INCLUDED[$file]+_} ]]; then
 	continue;
 	fi
-	str=$(PYTHONDONTWRITEBYTECODE=1 scripts/kernel-doc -export "$file" 2>/dev/null)
+	str=$(PYTHONDONTWRITEBYTECODE=1 tools/doc/kernel-doc -export "$file" 2>/dev/null)
 	if [[ -n "$str" ]]; then
 	echo "$file"
 	fi
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
deleted file mode 120000
index 3b6ef807791a..000000000000
--- a/scripts/kernel-doc
+++ /dev/null
@@ -1 +0,0 @@
-kernel-doc.py
\ No newline at end of file
diff --git a/scripts/kernel-doc.py b/tools/doc/kernel-doc
similarity index 100%
rename from scripts/kernel-doc.py
rename to tools/doc/kernel-doc
-- 
2.50.1


