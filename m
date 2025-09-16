Return-Path: <linux-kernel+bounces-818582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55104B5939B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80757188D11B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4EC30CD92;
	Tue, 16 Sep 2025 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIZNDe55"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C1306B1E;
	Tue, 16 Sep 2025 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018218; cv=none; b=c38WC3GseLnR/JAka7iid8H4k8M+BdUoWsPfM23uBb1yUcfojEA0aIj2PeawYTxxIMg29hM1f+dUUNhc+/ZVu7QBr+Wk0cKilWKzZv9JP0RQmfAKJJ4My4CdIJ/qzPH78PWBVIdJClxLwT94lzAfQ1ikX01oqh75yScWxVgcryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018218; c=relaxed/simple;
	bh=wEAxHaH+b5lGJ2p9wznCjcSzxoTOkCLXr72tiMvcqis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DHCQHeWm9LkfAK2ByfzCvtPtbORPtyItCtHqfA+YYO3V2mKQoVV6O70Zakls1MLuPyrA1O5vEcadduHX/wpf4I/vXqBZvdx5pFiXzYpENM00Vn+42j/kpquvtH4JapbFrZ5FAVa/KpWxxlPKKw/2xdhdwdm83DMU2IeYDmERU3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIZNDe55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB81C4CEF0;
	Tue, 16 Sep 2025 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018217;
	bh=wEAxHaH+b5lGJ2p9wznCjcSzxoTOkCLXr72tiMvcqis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIZNDe55/Q7Ls0C12HR4UdsoSw5HDT5JRVBnkC3bFB1XO2+to9Br3IhpxcOH8g83T
	 7dsOTnADVAR+19A3929DsEsfla51SwTxt8GTbE2ze+4V/OOSe17ELJfvSxxfgUS9ag
	 eWbwGXmBV+U73RLEUevpg8S0X9xtJHKI+REGJDFdxmy17nRapmq7topVIOd0AZzAxS
	 h4Di79qIBp+8cLpSkn9AxaZ9DM9MilgCDRi8NOVqyVNUhXgAoTGb/S+h65PwGGVH+R
	 ZLwC2hl0K24NweGaB5tJbJ7HwqvXVUzAFXXVfo7ac97fJi9K62AxSNINsf4hdata3D
	 /0J8g42XKCdUA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uySqT-0000000BBPl-0YIc;
	Tue, 16 Sep 2025 12:23:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 16/21] tools/docs: sphinx-build-wrapper: Fix output for duplicated names
Date: Tue, 16 Sep 2025 12:22:52 +0200
Message-ID: <3b22d3fde97520edd0120453ab44e23c90f1ae1f.1758018030.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758018030.git.mchehab+huawei@kernel.org>
References: <cover.1758018030.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
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
index 0e2cb087cdac..cd7c450832d0 100755
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


