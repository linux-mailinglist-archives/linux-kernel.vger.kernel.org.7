Return-Path: <linux-kernel+bounces-842673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE4BBD43B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA085189430C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D26253F20;
	Mon,  6 Oct 2025 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a5Y5Z59A";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a5Y5Z59A"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB63267B01
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736883; cv=none; b=PbqrdO+tqjdCvG/SpRmpFRJdoP8dgxqXL98gGQ6XQrx/rK5K3sAZTTLl5ffGovYd4FZas7PsD191o+RGgMufUHlRiWqjcx2zLOsSUJ5Bzj9+CDWsvN5Xomvdis+JA3FF2NOBoiZ6lTQTopmIYfBUxKcgmLZMB3iYHI2V7DnFE7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736883; c=relaxed/simple;
	bh=c7fAOBqk7UEFTT1rHzTO+w5WofrovLhWZXNFGxGJ4qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J01TyUVIKxoE9JCyjYEgQdMmOVrooKpOEWG7i3WPTE2DL8yhE83OgwgL7r9H+Goh6ict6xIoJTRZCMPe8puRenZdxB8/ymHuJUzyxjoFrMNA7KyzcbWKWR/pPEjW83aJHy5w7ZMgDx0smiYMwU7alGJLd4sG1T1BKk/DkzrhZBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a5Y5Z59A; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a5Y5Z59A; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E6A01F7A2;
	Mon,  6 Oct 2025 07:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759736878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r/BMyo6khWa29aiXqyUPT6mG23afddOhl9mRjZB9VYg=;
	b=a5Y5Z59Atv/+js3D1sY2gtngTAUP01+jE0EuVRCUgx9J4sNZLDCBUGTvij/d19N/qu5DoE
	F+zbqsspvEALMDUbs9j5H7mV/dbGFHtNIbkty8Brq6U/YfXZzMKRbtX4EQKMFSgoSkHiWV
	t023PjvDJ0s9LTEbOMHngbsqJeBc9bc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759736878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r/BMyo6khWa29aiXqyUPT6mG23afddOhl9mRjZB9VYg=;
	b=a5Y5Z59Atv/+js3D1sY2gtngTAUP01+jE0EuVRCUgx9J4sNZLDCBUGTvij/d19N/qu5DoE
	F+zbqsspvEALMDUbs9j5H7mV/dbGFHtNIbkty8Brq6U/YfXZzMKRbtX4EQKMFSgoSkHiWV
	t023PjvDJ0s9LTEbOMHngbsqJeBc9bc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D08713A7E;
	Mon,  6 Oct 2025 07:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Iqn3FC5042jBHgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 06 Oct 2025 07:47:58 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 18/21] objtool: Allow multiple pv_ops arrays
Date: Mon,  6 Oct 2025 09:46:03 +0200
Message-ID: <20251006074606.1266-19-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006074606.1266-1-jgross@suse.com>
References: <20251006074606.1266-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Having a single large pv_ops array has the main disadvantage of needing
all prototypes of the single array members in one header file. This is
adding up to the need to include lots of otherwise unrelated headers.

In order to allow multiple smaller pv_ops arrays dedicated to one
area of the kernel each, allow multiple arrays in objtool.

For better performance limit the possible names of the arrays to
start with "pv_ops".

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch
---
 tools/objtool/arch/x86/decode.c       |  8 ++-
 tools/objtool/check.c                 | 74 +++++++++++++++++++++------
 tools/objtool/include/objtool/check.h |  2 +
 3 files changed, 66 insertions(+), 18 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 0ad5cc70ecbe..d253148edc6a 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -649,10 +649,14 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 			immr = find_reloc_by_dest(elf, (void *)sec, offset+3);
 			disp = find_reloc_by_dest(elf, (void *)sec, offset+7);
 
-			if (!immr || strcmp(immr->sym->name, "pv_ops"))
+			if (!immr || strncmp(immr->sym->name, "pv_ops", 6))
 				break;
 
-			idx = (reloc_addend(immr) + 8) / sizeof(void *);
+			idx = pv_ops_idx_off(immr->sym->name);
+			if (idx < 0)
+				break;
+
+			idx += (reloc_addend(immr) + 8) / sizeof(void *);
 
 			func = disp->sym;
 			if (disp->sym->type == STT_SECTION)
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8793b73d50d2..1675c16c3793 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -542,21 +542,57 @@ static int decode_instructions(struct objtool_file *file)
 }
 
 /*
- * Read the pv_ops[] .data table to find the static initialized values.
+ * Known pv_ops*[] arrays.
  */
-static int add_pv_ops(struct objtool_file *file, const char *symname)
+static struct {
+	const char *name;
+	int idx_off;
+} pv_ops_tables[] = {
+	{ .name = "pv_ops", },
+	{ .name = NULL, .idx_off = -1 }
+};
+
+/*
+ * Get index offset for a pv_ops* array.
+ */
+int pv_ops_idx_off(const char *symname)
+{
+	int idx;
+
+	for (idx = 0; pv_ops_tables[idx].name; idx++) {
+		if (!strcmp(symname, pv_ops_tables[idx].name))
+			break;
+	}
+
+	return pv_ops_tables[idx].idx_off;
+}
+
+/*
+ * Read a pv_ops*[] .data table to find the static initialized values.
+ */
+static int add_pv_ops(struct objtool_file *file, int pv_ops_idx)
 {
 	struct symbol *sym, *func;
 	unsigned long off, end;
 	struct reloc *reloc;
-	int idx;
+	int idx, idx_off;
+	const char *symname;
 
+	symname = pv_ops_tables[pv_ops_idx].name;
 	sym = find_symbol_by_name(file->elf, symname);
-	if (!sym)
-		return 0;
+	if (!sym) {
+		ERROR("Unknown pv_ops array %s", symname);
+		return -1;
+	}
 
 	off = sym->offset;
 	end = off + sym->len;
+	idx_off = pv_ops_tables[pv_ops_idx].idx_off;
+	if (idx_off < 0) {
+		ERROR("pv_ops array %s has unknown index offset", symname);
+		return -1;
+	}
+
 	for (;;) {
 		reloc = find_reloc_by_dest_range(file->elf, sym->sec, off, end - off);
 		if (!reloc)
@@ -574,7 +610,7 @@ static int add_pv_ops(struct objtool_file *file, const char *symname)
 			return -1;
 		}
 
-		if (objtool_pv_add(file, idx, func))
+		if (objtool_pv_add(file, idx + idx_off, func))
 			return -1;
 
 		off = reloc_offset(reloc) + 1;
@@ -590,11 +626,6 @@ static int add_pv_ops(struct objtool_file *file, const char *symname)
  */
 static int init_pv_ops(struct objtool_file *file)
 {
-	static const char *pv_ops_tables[] = {
-		"pv_ops",
-		NULL,
-	};
-	const char *pv_ops;
 	struct symbol *sym;
 	int idx, nr, ret;
 
@@ -603,11 +634,20 @@ static int init_pv_ops(struct objtool_file *file)
 
 	file->pv_ops = NULL;
 
-	sym = find_symbol_by_name(file->elf, "pv_ops");
-	if (!sym)
+	nr = 0;
+	for (idx = 0; pv_ops_tables[idx].name; idx++) {
+		sym = find_symbol_by_name(file->elf, pv_ops_tables[idx].name);
+		if (!sym) {
+			pv_ops_tables[idx].idx_off = -1;
+			continue;
+		}
+		pv_ops_tables[idx].idx_off = nr;
+		nr += sym->len / sizeof(unsigned long);
+	}
+
+	if (nr == 0)
 		return 0;
 
-	nr = sym->len / sizeof(unsigned long);
 	file->pv_ops = calloc(sizeof(struct pv_state), nr);
 	if (!file->pv_ops) {
 		ERROR_GLIBC("calloc");
@@ -617,8 +657,10 @@ static int init_pv_ops(struct objtool_file *file)
 	for (idx = 0; idx < nr; idx++)
 		INIT_LIST_HEAD(&file->pv_ops[idx].targets);
 
-	for (idx = 0; (pv_ops = pv_ops_tables[idx]); idx++) {
-		ret = add_pv_ops(file, pv_ops);
+	for (idx = 0; pv_ops_tables[idx].name; idx++) {
+		if (pv_ops_tables[idx].idx_off < 0)
+			continue;
+		ret = add_pv_ops(file, idx);
 		if (ret)
 			return ret;
 	}
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 00fb745e7233..51f2396c5943 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -125,4 +125,6 @@ struct instruction *next_insn_same_sec(struct objtool_file *file, struct instruc
 	     insn && insn->sec == _sec;					\
 	     insn = next_insn_same_sec(file, insn))
 
+int pv_ops_idx_off(const char *symname);
+
 #endif /* _CHECK_H */
-- 
2.51.0


