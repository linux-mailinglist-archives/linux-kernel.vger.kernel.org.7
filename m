Return-Path: <linux-kernel+bounces-825599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13018B8C4DC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D21C7B9F51
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F52729BDB6;
	Sat, 20 Sep 2025 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI9E94AN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257D1C01;
	Sat, 20 Sep 2025 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758361234; cv=none; b=HAUPid0CUvcB6CDxrVlq2F0PS412YRRO0oL86HiIaOZyWmBtbFsEazd6jV4/XlpTidLyCAbi5GcGGr+7nc88Lw21iJyIKZbx5lnKPJdIMwYp0f+5B4tREvE9oBfHnMFaXHKhRjk6qtHmvWMAKBNuelMZQ8YqICp7wm70uye3sJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758361234; c=relaxed/simple;
	bh=xbzwfMN6e7C5zCCSQEnr3hE5fyzJlmvNXk+6zgDub/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OEpynEvJUm4xR7aBjbQiIhdLt/VukY6BQ01C0OwovMnTbJOV2mkmyL7HdPJ+ZapLHQT8/m/25orXxeC0wSl/PpqeVloHtdlRa3sp4VxZ11OmBGGNUL3dkEeDQj6rnUL5IKtR+rzCpTnbiYV4p0vm6nl5DtrW97WtqdNxBvO8dmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sI9E94AN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523C1C4CEEB;
	Sat, 20 Sep 2025 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758361234;
	bh=xbzwfMN6e7C5zCCSQEnr3hE5fyzJlmvNXk+6zgDub/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sI9E94ANlerxsRVoSHoPiD6vbFA1UNCKOiEwSukXrr4+DF4eJr0Sey7ox3YSEjkIo
	 cNcuJ2WtbhJVxUDBFwFmiyYo7hCH1iwMf+soczf0w7GOb/zC55AVLqRWhq8AaRBZRT
	 iTmblIR0t7TVgKf2jjWMWU9R1GRtUB76vDmXZ5bTWkPGp3dMXrrriES1YRA4SMfCPF
	 SoA3R5QxRQU+iLYtMUJGwCMoQ4qaSwgYU/toOJfQImtnbZ7Umxh8O326Gj4xHRAIjF
	 jWH+ZKNhwQQ3i4GUmk9NsEOh+BHX/hWemItL735zBExIs3TjW8UfuXGAYFOvmzFgKA
	 RGsmvKXhFCaqQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uzu52-00000004Z2s-1N2x;
	Sat, 20 Sep 2025 11:40:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] tools/docs: sphinx-build-wrapper: handle sphinx-build errors
Date: Sat, 20 Sep 2025 11:40:24 +0200
Message-ID: <b7e152291fadd91694cbb6b086caefa4b6470fdd.1758361087.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758361087.git.mchehab+huawei@kernel.org>
References: <cover.1758361087.git.mchehab+huawei@kernel.org>
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


