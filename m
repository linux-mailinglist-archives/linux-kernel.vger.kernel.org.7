Return-Path: <linux-kernel+bounces-877046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A39DC1D102
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40314188A023
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F8835A14A;
	Wed, 29 Oct 2025 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTp7dWOY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E00719CD03
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761767675; cv=none; b=alHdOZPtE633famqHuP0NWTUJg8rM7Q0npulhbdslN4jxLU6dxVJ9X96NeUN8VGlVCsfUIzparTexXjc/LzURwfzRY1EKRYHMgXllOxlwK/pXJT2FXUAV01Mwu3znWy/y8bHmRuGFO0UQXtDKGQC343zWMr3+d4PbzmKhDndeA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761767675; c=relaxed/simple;
	bh=Q9R5oNlw9Jij7yT3x7DTQ90PV5QkxPmK5VlOiupsNdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ERkB56oYmME27xxfGWsLHldIn0DVvLw5Z8/TwzmC2nrAru52azkSPF0swy3fboZFCXeqUdvSnhnyK3N8bQc8d9YC7UPjydDADHdqIpFIiImzZty9DEMXoPLmvj4TDZM7mGUSeKaqWmXbjfHFpJ0fMCTB+Xg8dVx8Tq22DL3HzrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTp7dWOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FE0C4CEF7;
	Wed, 29 Oct 2025 19:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761767674;
	bh=Q9R5oNlw9Jij7yT3x7DTQ90PV5QkxPmK5VlOiupsNdY=;
	h=From:To:Cc:Subject:Date:From;
	b=oTp7dWOYg5dFtx4zwjonZca3Z0BqB3uGM1DTydU4M7n/mSoitt+3diQEkHg6EGscF
	 zYxu4C6TJlpyFlY+eCWFsw4VlpukMO4+u9qFjn1OYOFk8nlyXgU9I1EUBs7OsWbEcm
	 ZoRbKiTidAnseUQQjDu6r/rBNp3GbIt3OY0f+P7UGPhejfMKVniVKywnWNXZwh+Pd0
	 EOd6BnqHIziZk74j+vfVvCeUT1coUVHf9F/Wz1fJdTwTS/WdJ7cIyl1A4NYBE+JjHk
	 KEVRSUU6IGzb0qFxsx8mePf+2EvefpjwQ4OdOF5OuPeUN6W7Ud5RaCjaTOjb3thYLG
	 jnEC2+wAq4BXg==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] objtool: Fix skip_alt_group() for non-alternative STAC/CLAC
Date: Wed, 29 Oct 2025 12:54:08 -0700
Message-ID: <3d22415f7b8e06a64e0873b21f48389290eeaa49.1761767616.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an insn->alt points to a STAC/CLAC instruction, skip_alt_group()
assumes it's part of an alternative ("alt group") as opposed to some
other kind of "alt" such as an exception fixup.

While that assumption may hold true in the current code base, Linus has
an out-of-tree patch which breaks that assumption by replacing the
STAC/CLAC alternatives with raw STAC/CLAC instructions.

Make skip_alt_group() more robust by making sure it's actually an alt
group before continuing.

Fixes: 2d12c6fb7875 ("objtool: Remove ANNOTATE_IGNORE_ALTERNATIVE from CLAC/STAC")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 620854fdaaf63..9004fbc067693 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3516,8 +3516,11 @@ static bool skip_alt_group(struct instruction *insn)
 {
 	struct instruction *alt_insn = insn->alts ? insn->alts->insn : NULL;
 
+	if (!insn->alt_group)
+		return false;
+
 	/* ANNOTATE_IGNORE_ALTERNATIVE */
-	if (insn->alt_group && insn->alt_group->ignore)
+	if (insn->alt_group->ignore)
 		return true;
 
 	/*
-- 
2.51.0


