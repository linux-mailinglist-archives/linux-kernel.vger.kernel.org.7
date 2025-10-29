Return-Path: <linux-kernel+bounces-876016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE14BC1A64E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A8B43588F7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453BA37A3BD;
	Wed, 29 Oct 2025 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/Yv8fxg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A534F37A3BC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740866; cv=none; b=jQFMIUC/+YhznJTVtuOXP7BnoUQ+glE4AD54bQVP5xRUqPxFP1fKnPU7g06qaRLJzyj3iudRYRfYZEKhQzax3+SGshTGNmPDPQt/t7hvievq5DUL/BuNIwjge/OAN4yh72jVxPkxk+2qrsdU5PnxPQNWHiu80BYnPEHBpl+PMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740866; c=relaxed/simple;
	bh=DCoK6pwGLjqnVjPIVSOAYnDIrvGBx0j4cz5OUpUwA7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=urHZji5DAD8H2SW5Kn//yz4v/kTRo8B5xU1f8KXgTaUQZe55zjfsLuqKb15qoQP5RMGecJ1AISI3XuopmQ0JuCtsTMDKD8FTr0u7hfp0Iv2SZCUfV5aufKw8SGaE4Jttag9k2PGLEJmone/uUprTZvDuDg4pfLKy1TusKMnWmU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/Yv8fxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EBDC4CEF7;
	Wed, 29 Oct 2025 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740866;
	bh=DCoK6pwGLjqnVjPIVSOAYnDIrvGBx0j4cz5OUpUwA7g=;
	h=From:To:Cc:Subject:Date:From;
	b=u/Yv8fxgwAizgEWY3HxlPdOQoNBo96ejVwVf9G9BQ/7Dx8ICxeUN4hczhbCms+NMA
	 PeugsaoGJZCt1fkkzruONBnLAgaKW6R4C7bw3itd8ANbaUbpKRpKt97IvI9vHG9KGb
	 2H8fnK5fpUJhilJQfSxUbuA8nHFxRSE9hmKOR1xAHPMdy6Nd+cX1Mf5PED8iq7PBe8
	 c1Hi1OdxsXUGOxgZV9Bzw66STXPFAESg3q6vAT3Bj2ItyNQ6g4n8w8g+CTvfqEAXWv
	 k74ioGaqreH6Hl6c/9ESBLkmyByKnzU/3Z6ysZt8UxzaUAvd7IZ3fpQlTvRskrks/I
	 e4Ag7HhaqMDNQ==
From: Borislav Petkov <bp@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] lib/Kconfig.debug: Cleanup CONFIG_DEBUG_SECTION_MISMATCH help text
Date: Wed, 29 Oct 2025 13:27:43 +0100
Message-ID: <20251029122743.1110-1-bp@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Simplify formulations, correct flow, split it into proper paragraphs and
update structure.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 lib/Kconfig.debug | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8aaaf72ec4f7..cfcaefb3c46d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -494,23 +494,23 @@ config DEBUG_SECTION_MISMATCH
 	bool "Enable full Section mismatch analysis"
 	depends on CC_IS_GCC
 	help
-	  The section mismatch analysis checks if there are illegal
-	  references from one section to another section.
-	  During linktime or runtime, some sections are dropped;
-	  any use of code/data previously in these sections would
-	  most likely result in an oops.
-	  In the code, functions and variables are annotated with
-	  __init,, etc. (see the full list in include/linux/init.h),
-	  which results in the code/data being placed in specific sections.
+	  The section mismatch analysis checks if there are illegal references
+	  from one section to another. During linktime or runtime, some
+	  sections are dropped; any use of code/data previously in these
+	  sections would most likely result in an oops.
+
+	  In the code, functions and variables are annotated with __init,
+	  __initdata, and so on (see the full list in include/linux/init.h).
+	  This directs the toolchain to place code/data in specific sections.
+
 	  The section mismatch analysis is always performed after a full
-	  kernel build, and enabling this option causes the following
-	  additional step to occur:
-	  - Add the option -fno-inline-functions-called-once to gcc commands.
-	    When inlining a function annotated with __init in a non-init
-	    function, we would lose the section information and thus
-	    the analysis would not catch the illegal reference.
-	    This option tells gcc to inline less (but it does result in
-	    a larger kernel).
+	  kernel build, and enabling this option causes the option
+	  -fno-inline-functions-called-once to be added to gcc commands.
+
+	  However, when inlining a function annotated with __init in
+	  a non-init function, we would lose the section information and thus
+	  the analysis would not catch the illegal reference.  This option
+	  tells gcc to inline less (but it does result in a larger kernel).
 
 config SECTION_MISMATCH_WARN_ONLY
 	bool "Make section mismatch errors non-fatal"
-- 
2.51.0


