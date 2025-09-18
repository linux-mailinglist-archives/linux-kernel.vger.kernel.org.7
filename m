Return-Path: <linux-kernel+bounces-821255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD47B80DD6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4756517BE09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE722FE077;
	Wed, 17 Sep 2025 16:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkNQZQ/N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643BC2FF677;
	Wed, 17 Sep 2025 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125072; cv=none; b=obmeDnCKx2ubAlO1D12hGAKNmYSnWmymtlNmZSMsZAqO/2WidgFb6jaKZpz5dVZcBRM5Idm+p8hCIGVId9tYYzW2up6jElBHZ7zbfQbXBmqE4qnifK8qbx9S72ty4GjqPoUbnhMlTNrzL3HA7QiOJ6uZXDeTzMZEfYEM9NTexEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125072; c=relaxed/simple;
	bh=2uS6YlV3041wW9Be9iB8ks973VJhTpuup64rjjMC3zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0meB4o1y83a/dwB/sEXMt3LX3dXSbrVr252O4gtrRf9poh6P4b6oyHeKtssC0PjcBJ2aR4TJNrZMG6CdTobzq/ET6aLn0ps3ewjIJDFddrX4IaB9OWqMk0QuS7/kcnB8d/q0KLSeC19Kn42on6QTGi8ryMH1Fdbxso5HV1z/Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkNQZQ/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F99C4CEE7;
	Wed, 17 Sep 2025 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758125072;
	bh=2uS6YlV3041wW9Be9iB8ks973VJhTpuup64rjjMC3zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZkNQZQ/Nf840zv5wP/T7xCpY7+8RB2qmrKH3hlTvGcr1szsaGjnY9cWTrYPiRSoOv
	 UeGaLa1KK0bDIAMD4cIkzZU6S97C0KWv/ZqyVAdtotxiJEmr/Vzu/1hXFBjBOV4xHP
	 U7KhBDDAb+5BrxQXLM5GB57qSS5r4J+2OKr2CgrCWgvBkoC6mMmorrgxjIVza7iJm0
	 kZfMA3+keMWT+IzPY1kAeU8fNQZ7vi08SpuyKV8b2ssEyB+Lrwkp9CLrCLaK8SII0o
	 MFcWr8u2v1+Sm47unsaXdNJ3GcquKgmNFLcIFFo//BlT/IUv9D+F4+KPO5JazCdiml
	 ga3AC12seuOmQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	live-patching@vger.kernel.org,
	Song Liu <song@kernel.org>,
	laokz <laokz@foxmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Weinan Liu <wnliu@google.com>,
	Fazla Mehrab <a.mehrab@bytedance.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 22/63] objtool: Fix "unexpected end of section" warning for alternatives
Date: Wed, 17 Sep 2025 09:03:30 -0700
Message-ID: <40ce569362a352124b2012172221ac2847a62a8c.1758067943.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1758067942.git.jpoimboe@kernel.org>
References: <cover.1758067942.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the short circuiting logic in next_insn_to_validate(), control
flow may silently transition from .altinstr_replacement to .text without
a corresponding nested call to validate_branch().

As a result the validate_branch() 'sec' variable doesn't get
reinitialized, which can trigger a confusing "unexpected end of section"
warning which blames .altinstr_replacement rather than the offending
fallthrough function.

Fix that by not caching the section.  There's no point in doing that
anyway.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1165dd1669f0b..bea9b124dcf48 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3521,15 +3521,12 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 {
 	struct alternative *alt;
 	struct instruction *next_insn, *prev_insn = NULL;
-	struct section *sec;
 	u8 visited;
 	int ret;
 
 	if (func && func->ignore)
 		return 0;
 
-	sec = insn->sec;
-
 	while (1) {
 		next_insn = next_insn_to_validate(file, insn);
 
@@ -3769,7 +3766,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 			WARN("%s%sunexpected end of section %s",
 			     func ? func->name : "", func ? "(): " : "",
-			     sec->name);
+			     insn->sec->name);
 			return 1;
 		}
 
-- 
2.50.0


