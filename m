Return-Path: <linux-kernel+bounces-839030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBAABB0AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD081890B40
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE65254B1B;
	Wed,  1 Oct 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAMRMnLk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91CE70814;
	Wed,  1 Oct 2025 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328137; cv=none; b=qxVz2Ur2LOFDz+CeEvgi6kpyq4F9yHaAXgY6fig/5ewUpR7jQFeSnHV2yOq5rYI+KoWlatiDxB/b9h/h0vtJSzcktdAJ2md9WxFyuYpfHMDongUf0jkXNagcHnHAgddLjIg6RhE7Od4H9RLOergNEeIw9CkQzdoDaTlcgJCgImo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328137; c=relaxed/simple;
	bh=ByrMKW6U9oaI4lD+zo8zFpFS4hv7Szimd0l86ILcZmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtphAWM//mdxV0UXxs1nviHxNMA2BYaol11puyIoLclUXi7HQE4tJ6Ol+X8pnmHd1s3WiWX2tUQpdUe+U/IEPPDMUY8a5hWCH33A2+qco5LaIS2LLrlqf0CzG1PiKUvlLMj1NarZD4NbMKmqvJbhBduKtNaLGSp2NoWknDN9sA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAMRMnLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89195C4CEFA;
	Wed,  1 Oct 2025 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759328136;
	bh=ByrMKW6U9oaI4lD+zo8zFpFS4hv7Szimd0l86ILcZmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dAMRMnLkABaPgeVImbKFr2GlnwxNEs6uRbTyqu59AZ8LtdkTlsxEFoSQ/bNRT0yhH
	 i/wr596D1r2aLRdTsTcdzw3rFo+jljjm+adia8b+s8m5BK3TkeGLbz1fmEHh0pjLd7
	 6oh92rPrsR2eb84THYI4zf3J+F1g8JPjpqhUgSralOc6fsJaygMS4u0QLDzkLDM4By
	 zfE5mPOwLiveAFroi+c9DOiXB8+tgw/k3rZUPPWuukkxMnRsq7JrwCDLPUFmbeX3FL
	 IYfAKt8Lh60Bx6/885wdT/OGQ1z55MFAGbZU4hKjO4xNHzoiZA5Vf3iD8wXxp3PXMF
	 azZ5KxN332vnQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v3xcE-0000000BJ9R-3F5M;
	Wed, 01 Oct 2025 16:15:34 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2 2/3] tools/docs: sphinx-build-wrapper: pdflatex is needed only for pdf
Date: Wed,  1 Oct 2025 16:15:25 +0200
Message-ID: <313df7b4aab653e8fc40c30120c0dbebf8a0bcb1.1759328070.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759328070.git.mchehab+huawei@kernel.org>
References: <cover.1759328070.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Fix the logic which checks for pdflatex. Currently, it complains
for both pdfdocs and latexdocs, but for the latter, all it is
needed is Sphinx.

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Closes: https://lore.kernel.org/linux-doc/cover.1758881658.git.mchehab+huawei@kernel.org/T/#ma81ff2e11b8579e5edc23e4381e464081ae668b7
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index cce985dced00..a74998e8309a 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -650,7 +650,7 @@ class SphinxBuilder:
             if not sphinxbuild and target != "mandocs":
                 sys.exit(f"Error: {self.sphinxbuild} not found in PATH.\n")
 
-        if builder == "latex":
+        if target == "pdfdocs":
             if not self.pdflatex_cmd and not self.latexmk_cmd:
                 sys.exit("Error: pdflatex or latexmk required for PDF generation")
 
-- 
2.51.0


