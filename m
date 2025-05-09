Return-Path: <linux-kernel+bounces-642396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89651AB1E11
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 22:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7721C25E90
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 20:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A542297B87;
	Fri,  9 May 2025 20:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UP0j4VTY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE0296FBC;
	Fri,  9 May 2025 20:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821887; cv=none; b=tiKKirYgdiZBBvzUn6/Ol1gO4qM1aoYc4uv+7LvueGA5YWlp4hLmu5O8dhgombJgR80/EUAYXodmEQhE7XgrDELXv4uxTaxST83Iqc1KkHXiOzAJTB8Iv0CYHsYabKUoFP29o3aNe7ZSiXnZdSBBH3zII+5TPDHHTqbiYv0pRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821887; c=relaxed/simple;
	bh=31ROD4LxAHEXgMf4J97V0RMD8+gDvAKgCY+5TpvyP/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftAden8pymQ1G0FA/1sFMBQNqrfcQItSOvsXmwGKC9zV6X2RKJ1GQEh/pcbnMkq5WmthbvIMgk8OolmVLvHPKiIkyDAEh6QBBUru9pBiYVfJX4is1zJOL3/QnShdL6FZnJIRRlw2RdjIl4VyYHz6Wy7zdWNWZSiXFAcNs527+Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UP0j4VTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BE5C4CEEE;
	Fri,  9 May 2025 20:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746821887;
	bh=31ROD4LxAHEXgMf4J97V0RMD8+gDvAKgCY+5TpvyP/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UP0j4VTYeX5hKxuNbS9jtkocy1sM0ptGI4ufTcutN3XEHnrSyB11xqAp7Zv/tTswp
	 HMcUEA1Im1sZyE2m0ccrfH12imhXu9jXjsVfv4E1dwTPSXgKFuyZh3C74y5DZOUSCe
	 wwREeNalMiIlUbuWqyK4f+k5vHv/acQNi6bO5GEj6YY1TSM7mjUCcOZZWhIlVwOUaf
	 LnvOevtLPMUXWxHKkCGKwLmordOd4J/PAAY5SAqumHv+xnUsgDpkaK0Kn4hVZZHp25
	 5ROZpPGPt5WnNa8SeCM/ZRhMoEq9GqeO0mzv1R4kDnAmOUUtfYHKLF41+fUIgqX2lQ
	 zRk+mOg0lbMdQ==
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
	Puranjay Mohan <puranjay@kernel.org>
Subject: [PATCH v2 32/62] objtool: Suppress section skipping warnings with --dryrun
Date: Fri,  9 May 2025 13:16:56 -0700
Message-ID: <7eccdb0b09eff581377e5efab8377b6a37596992.1746821544.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746821544.git.jpoimboe@kernel.org>
References: <cover.1746821544.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's common to use --dryrun on binaries that have already been
processed.  Don't print the section skipping warnings in that case.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3b9443b98fd5..66cbeebd16ea 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -637,7 +637,9 @@ static int create_static_call_sections(struct objtool_file *file)
 
 	sec = find_section_by_name(file->elf, ".static_call_sites");
 	if (sec) {
-		WARN("file already has .static_call_sites section, skipping");
+		if (!opts.dryrun)
+			WARN("file already has .static_call_sites section, skipping");
+
 		return 0;
 	}
 
@@ -719,7 +721,9 @@ static int create_retpoline_sites_sections(struct objtool_file *file)
 
 	sec = find_section_by_name(file->elf, ".retpoline_sites");
 	if (sec) {
-		WARN("file already has .retpoline_sites, skipping");
+		if (!opts.dryrun)
+			WARN("file already has .retpoline_sites, skipping");
+
 		return 0;
 	}
 
@@ -757,7 +761,9 @@ static int create_return_sites_sections(struct objtool_file *file)
 
 	sec = find_section_by_name(file->elf, ".return_sites");
 	if (sec) {
-		WARN("file already has .return_sites, skipping");
+		if (!opts.dryrun)
+			WARN("file already has .return_sites, skipping");
+
 		return 0;
 	}
 
@@ -795,7 +801,9 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
 
 	sec = find_section_by_name(file->elf, ".ibt_endbr_seal");
 	if (sec) {
-		WARN("file already has .ibt_endbr_seal, skipping");
+		if (!opts.dryrun)
+			WARN("file already has .ibt_endbr_seal, skipping");
+
 		return 0;
 	}
 
@@ -852,7 +860,9 @@ static int create_cfi_sections(struct objtool_file *file)
 
 	sec = find_section_by_name(file->elf, ".cfi_sites");
 	if (sec) {
-		WARN("file already has .cfi_sites section, skipping");
+		if (!opts.dryrun)
+			WARN("file already has .cfi_sites section, skipping");
+
 		return 0;
 	}
 
@@ -900,7 +910,9 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 
 	sec = find_section_by_name(file->elf, "__mcount_loc");
 	if (sec) {
-		WARN("file already has __mcount_loc section, skipping");
+		if (!opts.dryrun)
+			WARN("file already has __mcount_loc section, skipping");
+
 		return 0;
 	}
 
@@ -944,7 +956,9 @@ static int create_direct_call_sections(struct objtool_file *file)
 
 	sec = find_section_by_name(file->elf, ".call_sites");
 	if (sec) {
-		WARN("file already has .call_sites section, skipping");
+		if (!opts.dryrun)
+			WARN("file already has .call_sites section, skipping");
+
 		return 0;
 	}
 
-- 
2.49.0


