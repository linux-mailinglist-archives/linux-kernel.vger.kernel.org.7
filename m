Return-Path: <linux-kernel+bounces-748193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3059CB13DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97077A3FE8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7650F27054B;
	Mon, 28 Jul 2025 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hebo2XbC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D126FA5A;
	Mon, 28 Jul 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714477; cv=none; b=jWb4Zutm5u9A/K4fbiIUzVmkIsgw593xxwfjcIPLPPdC+i0KL9TLsv+y4/x+GKTxHRkr5krWqkb3Djt+dmWJkeo0/uurNPdAioDrGNUKQl+UbqjlYKJJW9jvUAJE8+n6oAmb6CnjYNCpgW8rUjjTZAexKdoyISeapuYrZuTJhMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714477; c=relaxed/simple;
	bh=nij+y+Cb9IleH2KdiWnocENo17uAg8rZIjz77rKHtVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXDdnOTGwZLDVFEHc0pqCfwy63o1LVs9EII4nA9YStg7bYbQU2u095mLCOc/CftGu2jGtdHyCf7g1xBdkzBOwrDJqN8ch6SjAadSG829sdXRCr73KGuw7cEcjjTn/XgCwEtmA9f0w2RCzk+ACaMNwpWUekjImv/ViiBtZwnNXjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hebo2XbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75859C4CEF9;
	Mon, 28 Jul 2025 14:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753714477;
	bh=nij+y+Cb9IleH2KdiWnocENo17uAg8rZIjz77rKHtVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hebo2XbCIms51ZBDi0JaGbLYeTPzbuVx852oP9PI0qYoad6X76agNeJzAOFehZE6P
	 WIOHhzSB4RKenmeKJSS46Ht+j0jk2//noOo5HCIg7muFaDFARSfk4PeavBon4IL5RS
	 eOOx0Q3EH0xlRitkQ3BWTQlhuhAXs/LQcgdl61mJj98uUVmjfzYT2h8ujtqCkSdEY/
	 rQQe2qlnnRQkO4GaODdUcoX0wrPcVXUkJIglepN3i4Esz4CL9zeDb5ILPzQhMIhk/l
	 Crj12JsAaqoFsivlEgQrFAi+h4LFHKSVO+XZWN3ySevgff6UCcLRO9HGVaBMtMdezu
	 ZDxx9udA3V+XA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1ugPFK-00000000G5T-2db7;
	Mon, 28 Jul 2025 16:54:34 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	workflows@vger.kernel.org
Subject: [PATCH 2/2] docs: changes: better document Python needs
Date: Mon, 28 Jul 2025 16:54:29 +0200
Message-ID: <adb2d431b60228a772ec4423457a08e9af4b1d2d.1753713955.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753713955.git.mchehab+huawei@kernel.org>
References: <cover.1753713955.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Python is listed as an optional dependency, but this is not
true, as:

1) CONFIG_LTO_CLANG runs a python script at scripts/Makefile.vmlinux_o;

2) kernel-doc is called during compilation when some DRM options
   like CONFIG_DRM_I915_WERROR are enabled;

3) allyesconfig/allmodconfig will enable both.

So, better document that.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/process/changes.rst | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index bccfa19b45df..f6abecf6da86 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -61,7 +61,7 @@ Sphinx\ [#f1]_         3.4.3            sphinx-build --version
 GNU tar                1.28             tar --version
 gtags (optional)       6.6.5            gtags --version
 mkimage (optional)     2017.01          mkimage --version
-Python (optional)      3.9.x            python3 --version
+Python                 3.9.x            python3 --version
 GNU AWK (optional)     5.1.0            gawk --version
 ====================== ===============  ========================================
 
@@ -154,6 +154,17 @@ Perl
 You will need perl 5 and the following modules: ``Getopt::Long``,
 ``Getopt::Std``, ``File::Basename``, and ``File::Find`` to build the kernel.
 
+Python
+------
+
+CONFIG_LTO_CLANG requires python 2.7 or 3.0+; some DRM config options like
+CONFIG_DRM_I915_WERROR require at least Python 2.7 or 3.4+.
+
+The kernel-doc tool and docs build require at least 3.6, but they depend on
+dict changes that happened on 3.7 to produce valid results.
+
+Other tools within the Kernel tree require newer versions.
+
 BC
 --
 
-- 
2.49.0


