Return-Path: <linux-kernel+bounces-579096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF26FA73FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 22:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7AE3BE8F6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 20:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18C21F4C86;
	Thu, 27 Mar 2025 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKjk42dl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F62E1F463D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743108891; cv=none; b=FYB0qix/h755BbWmki8dpx/ArXWiucOG0ur7QzmrCY3exzE34SXu5jRN3eRHL+uwdKtbJ9uaMk8Qa02zQ8kN+2/bAOThkG4k9B76IdfglIhftIDZuggi8umpFTEiDUhtb5ocUT3EZwkawmSH+BnVX0SVLMazARRthd2jLZeOu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743108891; c=relaxed/simple;
	bh=ooCiG1pF4040CksZrN8oejXD/ZlBQakpeu4sxsiC2Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5IesxSwf+He8O/clruvceqhutIFnwpi15BjUi+ncojeliNXEbbojfVgEQDLxInNLAw3CLgT2xtQoLPj2RZrkxTgo0cIb8VVZe+u7yd3qzhzSnLSUX/IvKGQ74um6i5LzLc1PW3+47FEGWsntZ92aN2os9eFHR7Ewp9H1+V0rpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKjk42dl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D56F1C4CEE8;
	Thu, 27 Mar 2025 20:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743108890;
	bh=ooCiG1pF4040CksZrN8oejXD/ZlBQakpeu4sxsiC2Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UKjk42dlf/O6lPFJE+q1Bx8MPVfGdL2T9ziIpRG8pRknsN3Fb4coYRBgcoAsC5FRK
	 YOq4T1VdCOL5QEmrlmRzAyl2cSIAQ6h2t2kEp+DG8TdwW4McvH1UxxhqcFIW8L/jkn
	 yQc/TtuDBqAcWKbWtDm+DqKmfqfWkyh4VJJXGvZWuTN7Bnvxigkys4gsC5g+rIeIdA
	 WRrJR1tgfX4MXs6H2PYr8SdRPsfJtpeDqEJ00hY+cTcrXIL9dOdHuUKadIjGhOJFBx
	 d62BtkOMLhZFIvN/RgufVpE6o0cpQL3XfolAAUlDsBjCOWagNYL10Cb7+tKhK4QjEK
	 ul7RhU5WKwrVw==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 21/41] x86/alternatives: Assert that text_poke_int3_handler() can only ever handle 'tp_vec[]' based requests
Date: Thu, 27 Mar 2025 21:53:34 +0100
Message-ID: <20250327205355.378659-22-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250327205355.378659-1-mingo@kernel.org>
References: <20250327205355.378659-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/alternative.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index f75806d699be..883c2146ce54 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2510,6 +2510,10 @@ static __always_inline int patch_cmp(const void *key, const void *elt)
 	return 0;
 }
 
+#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_int3_loc))
+static struct text_poke_int3_loc tp_vec[TP_VEC_MAX];
+static int tp_vec_nr;
+
 noinstr int text_poke_int3_handler(struct pt_regs *regs)
 {
 	struct text_poke_int3_vec *desc;
@@ -2534,6 +2538,8 @@ noinstr int text_poke_int3_handler(struct pt_regs *regs)
 	if (!desc)
 		return 0;
 
+	WARN_ON_ONCE(desc->vec != tp_vec);
+
 	/*
 	 * Discount the INT3. See text_poke_int3_batch().
 	 */
@@ -2592,10 +2598,6 @@ noinstr int text_poke_int3_handler(struct pt_regs *regs)
 	return ret;
 }
 
-#define TP_VEC_MAX (PAGE_SIZE / sizeof(struct text_poke_int3_loc))
-static struct text_poke_int3_loc tp_vec[TP_VEC_MAX];
-static int tp_vec_nr;
-
 /**
  * text_poke_int3_batch() -- update instructions on live kernel on SMP
  * @tp:			vector of instructions to patch
-- 
2.45.2


