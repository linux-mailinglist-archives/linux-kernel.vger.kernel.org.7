Return-Path: <linux-kernel+bounces-820640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9540B7D1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640DA4816D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48221328981;
	Wed, 17 Sep 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcqaPjO5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C2372893;
	Wed, 17 Sep 2025 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111357; cv=none; b=OAy1qdkJMtXt68EF6IDt4uD3hYSjGVNZFc5F/b7PZAd7Ah6b1YIg2KwP4DYJ7UIi5fEzpofOcZt2aufDyXRNFx5NDXDN4ZskcRGhKINqcEF2KrwphtEIM4TJxGyTa89UkO924BmdOyszVYGYmUgn5NHjdI1ZISeNPnSod7XRhbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111357; c=relaxed/simple;
	bh=k6YcbtXwsJKesw6XBa4evKMXBMHtuUFMe++T/iQChqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saqmNJjtDOT6H7kPErYbTxw6iUjsxF2IJgQTQg9ICimIeKgIubbrozdkJodTit7Z/abE9v8WNDJ6gkNAo6ol4VhaNa2iH5EEn6TlPFNwjmfzhYG5mY33AJ3lgUmdQI9guL3z9SIHdvK38Ju1nmL7Shx3TRFE0j9/MuLMUJIovkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcqaPjO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8338C4CEFB;
	Wed, 17 Sep 2025 12:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111356;
	bh=k6YcbtXwsJKesw6XBa4evKMXBMHtuUFMe++T/iQChqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CcqaPjO5d13YqyrnTLHuAHXUsgGfZqF+/MIN+tJYABEREFfiexjUsj6fK/pAk2B/4
	 Tjqp6GGJlwIEJnDnn4cDf1HhDY99CluKDx0s6gkfKJPXzG4c1/+uzOZWQbB5XLzjeN
	 DfNb/cf2k3oWAkN+V3e5WNBRg3vHwPxdfSH6SF5ZMe0BoTN+S1VwptcuKciry0tfMo
	 X9Doezmkjn+TES6E0TilslNbX1JF7a0W2Ryn+87UJv5dvN0YfwKHfLlXpoRetox1O5
	 kUXbBna6vT6iU6cUYZJpPiZqeBFr4lLuJYhbOrWI+KxhYW+OP+4tvXDTO53S8Utqvd
	 KkroKx5+Mwh7g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uyr4h-0000000CGeK-2BSi;
	Wed, 17 Sep 2025 14:15:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 18/24] tools/docs: sphinx-build-wrapper: Fix output for duplicated names
Date: Wed, 17 Sep 2025 14:15:12 +0200
Message-ID: <66cef4f4600ec0252044cefd7117ed873438f337.1758111077.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758111077.git.mchehab+huawei@kernel.org>
References: <cover.1758111077.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

When SPHINXDIRS is used, basename may be identical for different
files. If this happens, the summary and error detection won't be
accurate.

Fix it by using relative names from builddir.

While here, don't duplicate names. Report, instead:

- SUCCESS
    output PDF file was built
- FAILED
    latexmk/xelatex didn't build any PDF output
- FAILED: no .tex files were generated
    Sphinx didn't build any tex file for SPHINXDIRS directories
- FAILED ({python exception})
    When a concurrent.futures is catched. Usually indicates an
    internal error at the build logic.

With that, building multiple dirs with the same name is reported
properly:

    $ make V=1 SPHINXDIRS="admin-guide/media driver-api/media userspace-api/media" pdfdocs

    Summary
    =======
    admin-guide/media/pdf/media.pdf  : SUCCESS
    driver-api/media/pdf/media.pdf   : SUCCESS
    userspace-api/media/pdf/media.pdf: SUCCESS

And if at least one of them fails, return code will be 1.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 6c2580303e8e..8d1f77c4a880 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -329,9 +329,6 @@ class SphinxBuilder:
                     continue
 
                 name = name[:-len(tex_suffix)]
-
-                max_len = max(max_len, len(name))
-
                 has_tex = True
 
                 future = executor.submit(self.build_pdf_file, latex_cmd,
@@ -343,34 +340,35 @@ class SphinxBuilder:
 
                 pdf_name = name + ".pdf"
                 pdf_from = os.path.join(from_dir, pdf_name)
+                pdf_to = os.path.join(pdf_dir, pdf_name)
+                out_name = os.path.relpath(pdf_to, self.builddir)
+                max_len = max(max_len, len(out_name))
 
                 try:
                     success = future.result()
 
                     if success and os.path.exists(pdf_from):
-                        pdf_to = os.path.join(pdf_dir, pdf_name)
-
                         os.rename(pdf_from, pdf_to)
 
                         #
                         # if verbose, get the name of built PDF file
                         #
                         if self.verbose:
-                           builds[name] = os.path.relpath(pdf_to, self.builddir)
+                           builds[out_name] = "SUCCESS"
                     else:
-                        builds[name] = "FAILED"
+                        builds[out_name] = "FAILED"
                         build_failed = True
                 except futures.Error as e:
-                    builds[name] = f"FAILED ({repr(e)})"
+                    builds[out_name] = f"FAILED ({repr(e)})"
                     build_failed = True
 
         #
         # Handle case where no .tex files were found
         #
         if not has_tex:
-            name = "Sphinx LaTeX builder"
-            max_len = max(max_len, len(name))
-            builds[name] = "FAILED (no .tex file was generated)"
+            out_name = "LaTeX files"
+            max_len = max(max_len, len(out_name))
+            builds[out_name] = "FAILED: no .tex files were generated"
             build_failed = True
 
         return builds, build_failed, max_len
-- 
2.51.0


