Return-Path: <linux-kernel+bounces-806692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC447B49A9F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4F5205E55
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642EE2D77F7;
	Mon,  8 Sep 2025 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WibYJ9oQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D64219A86
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757361865; cv=none; b=VqsE4dQE+vyryJHuhgHfETHmddxeRtZ/kyfTJIDiINGcYSt88izhdmILYQOMm1GIomPbZqMsVQqvF31pLLTpG4CSWpMYF+ve8Ws/MOW46em3NiJKPRV3f487266/julM/CaAyjvTlHGq5JbxLnKHaNPPDo4kfhw/NJiiqNfNsYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757361865; c=relaxed/simple;
	bh=+NePflDATS5QOa0hbaV4PypN/lmygk6Hj+KrPbbnvnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Hl5vEHi26n/sCIN1otxL38PTA9f6bEoKjbZzrVIWRjdeZzD6LtJPYnzGf5LHe9ds+QWSc5CKEA1E0PtYjX2gisnygw2+Cs2zkbVdHXOkJGnP/WwoheUDfQYOj/jhK4bRWnIAngfwYzphaUonhocMo4EhNVhzqNTLEZWP9BIeX7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WibYJ9oQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD6BC4CEF1;
	Mon,  8 Sep 2025 20:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757361865;
	bh=+NePflDATS5QOa0hbaV4PypN/lmygk6Hj+KrPbbnvnE=;
	h=From:Date:Subject:To:Cc:From;
	b=WibYJ9oQd3WZzrqUEoJTuiaSSWrQWNh4/Kpt/w5p+nSfnxy6qqezYaj7SAZqVGQ92
	 wEOlNQ0Ms9n0QFeiDGOyaqRrQ2LW/A2n2Z08AmeMe83FAZFR3mUAQpOnFfy04MPw88
	 i3ykBjORqKFuddib6x/eDmrweYpICFSnrXOUx7k3+m2ekcYAKJ3/yOUnvn6lb/xxyf
	 4DoEufPPOActMgMYxHMmLvZSzqRMnUyZM0Kn26vP3x0hMu72Iqr17R1siiWmH+kfO+
	 ed7yu9fPPxObFr94uypLBGjm0+Rdep309UfEy92h8m0c8JPZvk7lmySmz8V2YLAx3f
	 nEnRXB6abG9PQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 08 Sep 2025 13:04:18 -0700
Subject: [PATCH] objtool: Ignore __pi___cfi_ prefixed symbols
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-x86-startup-fix-pi-cfi-warnings-v1-1-4b42b43fecf3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAME2v2gC/x2NSwqFMAwAryJZv0At+KlXkbcoNtVsakn8gXh3i
 8uBYeYGJWFSGKobhA5WXlOB+lfBtPg0E3IoDNbYxjjT49W3qJuXbc8Y+cLMOEXG00viNCs6CtG
 6zoQQCUolCxXtO4z/53kBGO213XEAAAA=
X-Change-ID: 20250908-x86-startup-fix-pi-cfi-warnings-9edf2970ddfe
To: Josh Poimboeuf <jpoimboe@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, 
 Ard Biesheuvel <ardb@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630; i=nathan@kernel.org;
 h=from:subject:message-id; bh=+NePflDATS5QOa0hbaV4PypN/lmygk6Hj+KrPbbnvnE=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBn7zY5/6rS5c5Xleg9PaE/pp8SalReCVt49wt7PFyz2+
 or9SVGNjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjAR0XOMDJP2J2/nc8nk3mg0
 5Y1dHFNNjWXQ3GlTJ7orXDrPZZ5/O5KRYdpv1tu3HOc94H6TpS7mfW/9o9Dws8n15VfSX9WHMf9
 cyAsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building with CONFIG_CFI_CLANG=y after the recent series to
separate the x86 startup code, there are objtool warnings along the
lines of:

  vmlinux.o: warning: objtool: __pi___cfi_startup_64_load_idt() falls through to next function __pi_startup_64_load_idt()
  vmlinux.o: warning: objtool: __pi___cfi_startup_64_setup_gdt_idt() falls through to next function __pi_startup_64_setup_gdt_idt()
  vmlinux.o: warning: objtool: __pi___cfi___startup_64() falls through to next function __pi___startup_64()

As the comment in validate_branch() states, this is expected, so ignore
these symbols in the same way that __cfi_ and __pfx_ symbols are already
ignored for the rest of the kernel.

Fixes: 7b38dec3c5af ("x86/boot: Create a confined code area for startup code")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 92ce18886477..6d6323508e4b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3576,6 +3576,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			/* Ignore KCFI type preambles, which always fall through */
 			if (!strncmp(func->name, "__cfi_", 6) ||
 			    !strncmp(func->name, "__pfx_", 6) ||
+			    !strncmp(func->name, "__pi___cfi_", 11) ||
 			    !strncmp(func->name, "__pi___pfx_", 11))
 				return 0;
 

---
base-commit: 8e5b2f272c1801071142af33b193130bbcc5ba9d
change-id: 20250908-x86-startup-fix-pi-cfi-warnings-9edf2970ddfe

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


