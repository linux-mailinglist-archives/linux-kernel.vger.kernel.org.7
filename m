Return-Path: <linux-kernel+bounces-824814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D28B8A349
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107C41B204C0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51D3315D32;
	Fri, 19 Sep 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVDhQcAL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE32274B55;
	Fri, 19 Sep 2025 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758294607; cv=none; b=Ir6uacaNVqRtkKsjvS0+0bDWyRXSzL7mmERcW5P9tKaYcyAAR6lL49Mxp5EyRZawqVQ2c1bYnpdptpPZaZgpMWyzpHynDF9gGDrbkc+M2GxA7MxPhPJdeQE9DFjWOyGuyj0JqYwxQ5DLk/fkQuEhR01gGPNLcten04IhwWlnru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758294607; c=relaxed/simple;
	bh=xbzwfMN6e7C5zCCSQEnr3hE5fyzJlmvNXk+6zgDub/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCpYNjBntJAXZ6Vgf4KWXru1dQxLRP6QLmmndVu1JoggvmSi+vRzpQu5aVyulRsGfUuqG6/XtbY4hyvxFReiFLsj9B1xGBkjPdfE2FEcsEKzRbc2Kpjkm0MKEpJzO5E5HBwiZLNIyhfdmlU+l3+q6SLGQ1eginpTvhd0cd9uo5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVDhQcAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED74C4AF09;
	Fri, 19 Sep 2025 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758294606;
	bh=xbzwfMN6e7C5zCCSQEnr3hE5fyzJlmvNXk+6zgDub/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EVDhQcALcqiD008FqguB0fdplLuIOjBPL3PFhrwTBAaDB5kZw63DDX3CwLZ+hEjBc
	 x8aynb8TLZxyRYOmWxYaXA/RMglt2ucLratPWAFQsgcik0w0dp6hJZMChxnBL9cdhj
	 6j70Cp9COcSzlraxq+kHh3eJZSa1+XZzo3dDIMKrVUjNtn3oULZ7/UjF0gKaQzy3at
	 PIsNL4ZctzDLR8iLNCcFgW4Ltp29J/3bVJEysQul0EEO9E8TmoRdqJ63r62kng6S4Z
	 k1ammTHpv1ASG+db6AxjtyW0+gxQeGowTnTwCv7nieGrB4EeQ3XuqZQ4QIfYaAzPi5
	 dxW9O8+coxn+A==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uzckO-0000000443d-3OwL;
	Fri, 19 Sep 2025 17:10:04 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tools/docs: sphinx-build-wrapper: handle sphinx-build errors
Date: Fri, 19 Sep 2025 17:09:59 +0200
Message-ID: <fcdb49ce5aff559b54c7f8527eee9338f82e5975.1758294450.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758294450.git.mchehab+huawei@kernel.org>
References: <cover.1758294450.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

If sphinx-build returns an error, exit the script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 6ed3d58ec277..b7e97c10d7dc 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -275,7 +275,7 @@ class SphinxBuilder:
             if self.venv:
                 cmd = ["python"]
             else:
-                cmd = [sys.executable,]
+                cmd = [sys.executable]
 
             cmd += [sphinx_build]
             cmd += [f"-j{n_jobs}"]
@@ -718,7 +718,12 @@ class SphinxBuilder:
                 self.handle_man(kerneldoc, docs_dir, src_dir, output_dir)
             else:
                 try:
-                    self.run_sphinx(sphinxbuild, build_args, env=self.env)
+                    result = self.run_sphinx(sphinxbuild, build_args,
+                                             env=self.env)
+
+                    if result:
+                        sys.exit(f"Build failed: return code: {result}")
+
                 except (OSError, ValueError, subprocess.SubprocessError) as e:
                     sys.exit(f"Build failed: {repr(e)}")
 
-- 
2.51.0


