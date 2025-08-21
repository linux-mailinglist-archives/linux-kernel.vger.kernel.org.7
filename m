Return-Path: <linux-kernel+bounces-779275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB341B2F180
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57545E1868
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8DD2FDC2C;
	Thu, 21 Aug 2025 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmF0foju"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F152EB87B;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764225; cv=none; b=q9RvwT7iswV4tSfl5spugFDmEjIoc2ge+qbI5TOGb11oHdDxt7MIOdWh/htAjyUxRIFZDxgcXqmlL6ggaNpqw3dx53L4uWjI7KoiproiPJxOkI3iWsxX5fran5hSWJE/g5Ize1TUraFdxi6CAycU44A7c0h5AHCSNrwMTesyOvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764225; c=relaxed/simple;
	bh=iovWlxU8FZeQLZGB4r7Pf0D7peHGXlMDwJzqoqefxR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9HNm6goXyUud35jxkUiA75DYeaHsw2tz5J+u76lexx4iQ1J6hQ4FjTNm/UUCv8X3EIZc2qC7LO35jDVtQJRjfRsuKd1Uyib2O6P2aXxdTW9RKs5p/2byWhY7jszy/BSZvNWqacmLm2zrhyNyH8uHNLRw8RXO7mPVzRGYy2igRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmF0foju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CE3C19422;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764224;
	bh=iovWlxU8FZeQLZGB4r7Pf0D7peHGXlMDwJzqoqefxR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmF0fojuaGjjcf8TfUhJqOY+OSnS+UT88p05wMFvWLNbH/y0EuaGgDI+CmMC3Q8oT
	 QQ1Ro14ylWGilYM6zVarTkxdV63q0VYZnc6u7aCwjHMQzZrahVb+HRQu1kxnhjTTv5
	 kxl1nx5Ix4uWAe+R6ZDXcQ4SR9Q6fjYzhsxZRxq0U4M2leqvng6qVaslcozl9wIDDb
	 muD1X/2ihdFviCK+WbGNUNKRIiMFJBfW2gPvFCAilJzLN5q6NEvmWnolWyQgdeyw35
	 ZcxIi3O0067sE59h2loMnno2ZYs+SggTLaL4xpgE9B34AKDtLqh0A/aCZGIMqbh2Jj
	 DeTKzpsyFBcMQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up0Tm-0000000BLgP-2xb9;
	Thu, 21 Aug 2025 10:17:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/14] docs: conf.py: fix some troubles for LaTeX output
Date: Thu, 21 Aug 2025 10:16:42 +0200
Message-ID: <8104ce56a5ea3509fbb56a8163b779d38a6aaa9c.1755763127.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755763127.git.mchehab+huawei@kernel.org>
References: <cover.1755763127.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

While PDF docs work fine on RPM-based distros, it causes conflicts
on Debian & friends.

There are multiple root causes here:

- the latex_elements still resambles the one from Sphinx 1.x
  times, where font configurations were stored under
  "preamble". It doesn't follow the current recommended way from
  Sphinx documentation:

	https://www.sphinx-doc.org/en/master/latex.html

- instead of setting the main font, from where other fonts are
  derivated, it sets romanfont;

- "fontenc" is not set. This allows the *.tex output file to
  contain an UTF-8 incompatible fontset:

	\usepackage[T1]{fontenc}

Address such issues to help preventing incompatible usage of
both T1 font and UTF-8 ones that comes from DejaVu font
family.

On some distros, this even generate a LaTeX font warning about
corrupted NFSS tables like this (I got it when running it in
interactive mode):

	Package: fontenc 2021/04/29 v2.0v Standard LaTeX package
	LaTeX Font Info:    Trying to load font information for T1+lmr on input line 11
	6.
	LaTeX Font Info:    No file T1lmr.fd. on input line 116.

	LaTeX Font Warning: Font shape `T1/lmr/m/n' undefined
	(Font)              using `T1/lmr/m/n' instead on input line 116.

	! Corrupted NFSS tables.
	wrong@fontshape ...message {Corrupted NFSS tables}
                                                  error@fontshape else let f...
	l.116 ...\familydefault\seriesdefault\shapedefault

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 628af81e6879..5888e2988b4f 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -461,6 +461,7 @@ latex_elements = {
     # Latex figure (float) alignment
     # 'figure_align': 'htbp',
     # Don't mangle with UTF-8 chars
+    "fontenc": "",
     "inputenc": "",
     "utf8extra": "",
     # Set document margins
@@ -476,13 +477,14 @@ latex_elements = {
     "maxlistdepth": "10",
     # For CJK One-half spacing, need to be in front of hyperref
     "extrapackages": r"\usepackage{setspace}",
-    # Additional stuff for the LaTeX preamble.
-    "preamble": dedent(r"""
-        % Use some font with UTF-8 support with XeLaTeX
+    "fontpkg": dedent(r"""
         \usepackage{fontspec}
+        \setmainfont{DejaVu Serif}
         \setsansfont{DejaVu Sans}
-        \setromanfont{DejaVu Serif}
         \setmonofont{DejaVu Sans Mono}
+        \newfontfamily\headingfont{DejaVu Serif}
+    """),
+    "preamble": dedent(r"""
         % Load kerneldoc specific LaTeX settings
         \input{kerneldoc-preamble.sty}
     """)
-- 
2.50.1


