Return-Path: <linux-kernel+bounces-867347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B80BC02564
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6458718944DB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0640029A9F9;
	Thu, 23 Oct 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Zla44Ejb"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD7A285041;
	Thu, 23 Oct 2025 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761235854; cv=none; b=nx28oBhsyt57fmmI7aTvLM+8h07e42FT5hT1VG0fbvMADS1kvf3+YN06TQjhJFCWjUGIq6Z2kgT/pLqrP07LzuyjV6nPIx+Ums2TDpMX4RCATlWEhtwJF37/z+juyDhcw2zlZQJwTKX53j02IGI4HYrfn7iiL7Enw0cFnHTNgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761235854; c=relaxed/simple;
	bh=8P8taraxs1uuHrr/CGO4KY4XXu5f1WNgd9GnAXLkw4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3P7zhaHFwF55vERYqh0SAAga/Z+JTjKTXFTauuOh3DFdyZRXhw5BuK2L6lmJOKmmPwDra8HcdD32X2zB0ITcErLpM6mxGnNKf7eiN01yLI6VzpNoDt5cEyz4w2WiDHJP3UL0TanfLT89jzZjJs+69zk3m4uy9u/Hl7S1eJsDHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Zla44Ejb; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 288B740B3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761235847; bh=HxBM8CSaZKzLY2c3shQRSeg/wD3W83HffdkFjTShZWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zla44EjbUaOh0kGF2K07shBu99G14suTYjwTmirwk4foqX81oETVeJGo7jFlGrvMC
	 eWIBEBKeY3AJQRW/MRbX7uPu+eNsU6QnvRZcxWG25QEl+KyRaL9IL2qBz/GsYO1pG1
	 hm0k53JrPhMVKxQSjN5xLe1IKl9vTjx5AZKrkrzPqG5UjWi+mwdF+v8/+XfgdI5by9
	 DUdwp2XmDJZvbBKmakbao2YhSfcxdutrunWjkhwEPXWZqt36KzB+g+jQJUs6z4exfK
	 hg9GlyjDGhyOlU0qC7BI7M9U9gVGH/AE+JNCsKvVv+gq/aLFF6lH8Oy7k5pt3BnEDa
	 fPbZRGU+cPP8A==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 288B740B3F;
	Thu, 23 Oct 2025 16:10:47 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 06/10] docs: move test_doc_build.py to tools/docs
Date: Thu, 23 Oct 2025 10:10:14 -0600
Message-ID: <20251023161027.697135-7-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023161027.697135-1-corbet@lwn.net>
References: <20251023161027.697135-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add this tool to tools/docs.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/doc-guide/sphinx.rst        | 2 +-
 {scripts => tools/docs}/test_doc_build.py | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename {scripts => tools/docs}/test_doc_build.py (100%)

diff --git a/Documentation/doc-guide/sphinx.rst b/Documentation/doc-guide/sphinx.rst
index 607589592bfb..ff408391d8c5 100644
--- a/Documentation/doc-guide/sphinx.rst
+++ b/Documentation/doc-guide/sphinx.rst
@@ -149,7 +149,7 @@ a venv with it with, and install minimal requirements with::
 
 A more comprehensive test can be done by using:
 
-	scripts/test_doc_build.py
+	tools/docs/test_doc_build.py
 
 Such script create one Python venv per supported version,
 optionally building documentation for a range of Sphinx versions.
diff --git a/scripts/test_doc_build.py b/tools/docs/test_doc_build.py
similarity index 100%
rename from scripts/test_doc_build.py
rename to tools/docs/test_doc_build.py
-- 
2.51.0


