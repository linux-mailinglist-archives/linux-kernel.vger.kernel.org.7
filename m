Return-Path: <linux-kernel+bounces-755743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4458CB1AB2F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 01:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D741A18A16C1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132BA231845;
	Mon,  4 Aug 2025 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEeBdvQm"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC38B2248B0
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754348771; cv=none; b=TJVkjD7ac6D+bi2jR0ihdvGOShIrWxZNOYdzG3/iFNC5niBlc8USYE9qUozE6RYFbpoPHVkOVUN+dkuVxAI5valCQFf5NXRstTUDO3N1oybVkqJM9UT6rjleObI+erLRolVjfn6W4Cv458EfKvxV0VqM1Q61Oj1wLuv+MJJEy/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754348771; c=relaxed/simple;
	bh=v/u8qFxDC9l+K270hMb9mE10NY/miJp2NeLA9euKoCk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dkTFe95U3fxg5RPPPifrrIU2rWX8GRfe4F3YM6v8y6ixxagJrgm2g1QNnFhTCJj3V8EiThm1daVMGLBl0vdxbbTyN9Jmkmtmy80c3k51ZwRYOo2SKt8imgD+soO48ESUwBobOt1MoJ+8X13Y8EYKg1J/gN3hyc/KAU2eoqTRfhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEeBdvQm; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2400a0ad246so41596575ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754348769; x=1754953569; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=99peTYq7PqSOTmRGzdVy2JEjNepzduj5OBy6x67rWAU=;
        b=aEeBdvQmyOlwAK2/mSJ/3ZHARmIjyToHqLXZzJmBdUYnHs5RsPU0E88y4WIV5+TLVX
         yaz2RX+vh3K6H2KG+wCuv6vHxff3joD+BK9SYkrD0bhcKq70Ww7CpVZt1mB+mntNmhrY
         q4cbsh6XsfiR4d8+n8WrdUCq3DXyXlmf1IDCxlYFxUGp1WH2G8k+VKxiT3TCswwsDPT9
         3jGQsROtR3xOWSPqoUeQHTYRwhkFKkCiCqbHa3yAHFliHACVDtIELFVuxUL5qJOiMcyv
         dG4NlNCoEPIaWO/s9EQ9U6X4OxHh6vuM347MD2qPVgpdQbsoepUg0HvfO5ljimEdWww4
         pkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754348769; x=1754953569;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=99peTYq7PqSOTmRGzdVy2JEjNepzduj5OBy6x67rWAU=;
        b=C7yieJl4eXQA+5oNH0FlW+HmifnN47Baxp4YLAhZK4alKVATz4QmcUMHJ8EDiXOpzc
         7eTystFDB8ZdwAmd02Gpc3QUvK2KREQ748UAHzvNCdqg/FqvZ0YXz1+YWXzGr377DEJt
         clDMmtPouXUjsbIKHjz9ncO98Bt2ZRwaJ9qFEFLUbMc/iqA81tiBJX5h4hH+ae/YB55d
         IqYa7fXB/l9aTrhHa+wGU9w+W4PiNcWB9l5z25nCazAYLyT2DwNPGxWLhpaUDCz+Xv9n
         RjNPobZ/iDC5HdDaclQ4Q418rgxntX04CQFvs0Kly8sqN/C45bS+qKOGHJmvE3n+tDVA
         76+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4trqzFdLvpf0m0QuHdNE2Vg8hlWjTRgrDZuLHvLJn71EXSacQL7MSu4G1Z3VgF3gSEp0QTuTRtJNcTyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVIxf2uQLgNG41epmdBIS3qQHjrqW2o1pdkGlDr+akxRXOyKt5
	9NK4YoPLm0Sld3Cws2nkMEMF7HHecxkl/5Du2JMuHw2Jlw5bW0BRLyJmrjevl4w9xCP6cp0u29j
	vzC49jggycQ==
X-Google-Smtp-Source: AGHT+IF6vIIzDerk2cBzZQlvwadLrhR1TOkCtIQIwNCroPKro/RhZzTNUtNZJKpBqXTVX8NlRL0dVCt5620F
X-Received: from pjbsu6.prod.google.com ([2002:a17:90b:5346:b0:312:151d:c818])
 (user=chullee job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3e2f:b0:234:9656:7db9
 with SMTP id d9443c01a7336-24246fdff37mr117055555ad.32.1754348769029; Mon, 04
 Aug 2025 16:06:09 -0700 (PDT)
Date: Mon,  4 Aug 2025 16:05:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804230558.746338-1-chullee@google.com>
Subject: [PATCH v2 1/2] f2fs: add lookup_mode mount option
From: Daniel Lee <chullee@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	Daniel Lee <chullee@google.com>
Content-Type: text/plain; charset="UTF-8"

For casefolded directories, f2fs may fall back to a linear search if
a hash-based lookup fails. This can cause severe performance
regressions.

While this behavior can be controlled by userspace tools (e.g. mkfs,
fsck) by setting an on-disk flag, a kernel-level solution is needed
to guarantee the lookup behavior regardless of the on-disk state.

This commit introduces the 'lookup_mode' mount option to provide this
kernel-side control.

The option accepts three values:
- perf: (Default) Enforces a hash-only lookup. The linear fallback
  is always disabled.
- compat: Enables the linear search fallback for compatibility with
  directory entries from older kernels.
- auto: Determines the mode based on the on-disk flag, preserving the
  userspace-based behavior.

Signed-off-by: Daniel Lee <chullee@google.com>
---
v2:
- rework mount option parsing to use the new mount API.
- add lookup_mode field to struct f2fs_mount_info.
- add show_options support for the new option.
 Documentation/filesystems/f2fs.rst | 19 +++++++++++++++++++
 fs/f2fs/dir.c                      | 17 ++++++++++++++++-
 fs/f2fs/f2fs.h                     |  7 +++++++
 fs/f2fs/super.c                    | 25 +++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 03b1efa6d3b2..a80ed82a547a 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -370,6 +370,25 @@ errors=%s		 Specify f2fs behavior on critical errors. This supports modes:
 			 ====================== =============== =============== ========
 nat_bits		 Enable nat_bits feature to enhance full/empty nat blocks access,
 			 by default it's disabled.
+lookup_mode=%s		 Control the directory lookup behavior for casefolded
+			 directories. This option has no effect on directories
+			 that do not have the casefold feature enabled.
+
+			 ================== ========================================
+			 Value		    Description
+			 ================== ========================================
+			 perf		    (Default) Enforces a hash-only lookup.
+					    The linear search fallback is always
+					    disabled, ignoring the on-disk flag.
+			 compat		    Enables the linear search fallback for
+					    compatibility with directory entries
+					    created by older kernel that used a
+					    different case-folding algorithm.
+					    This mode ignores the on-disk flag.
+			 auto		    F2FS determines the mode based on the
+					    on-disk `SB_ENC_NO_COMPAT_FALLBACK_FL`
+					    flag.
+			 ================== ========================================
 ======================== ============================================================
 
 Debugfs Entries
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index fffd7749d6d1..48f4f98afb01 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -16,6 +16,21 @@
 #include "xattr.h"
 #include <trace/events/f2fs.h>
 
+static inline bool f2fs_should_fallback_to_linear(struct inode *dir)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
+
+	switch (F2FS_OPTION(sbi).lookup_mode) {
+	case LOOKUP_PERF:
+		return false;
+	case LOOKUP_COMPAT:
+		return true;
+	case LOOKUP_AUTO:
+		return !sb_no_casefold_compat_fallback(sbi->sb);
+	}
+	return false;
+}
+
 #if IS_ENABLED(CONFIG_UNICODE)
 extern struct kmem_cache *f2fs_cf_name_slab;
 #endif
@@ -366,7 +381,7 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 
 out:
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (!sb_no_casefold_compat_fallback(dir->i_sb) &&
+	if (f2fs_should_fallback_to_linear(dir) &&
 		IS_CASEFOLDED(dir) && !de && use_hash) {
 		use_hash = false;
 		goto start_find_entry;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7029aa8b430e..1c0edb8a7134 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -212,6 +212,7 @@ struct f2fs_mount_info {
 	int compress_mode;			/* compression mode */
 	unsigned char extensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN];	/* extensions */
 	unsigned char noextensions[COMPRESS_EXT_NUM][F2FS_EXTENSION_LEN]; /* extensions */
+	unsigned int lookup_mode;
 };
 
 #define F2FS_FEATURE_ENCRYPT			0x00000001
@@ -1448,6 +1449,12 @@ enum {
 	TOTAL_CALL = FOREGROUND,
 };
 
+enum f2fs_lookup_mode {
+	LOOKUP_PERF,
+	LOOKUP_COMPAT,
+	LOOKUP_AUTO,
+};
+
 static inline int f2fs_test_bit(unsigned int nr, char *addr);
 static inline void f2fs_set_bit(unsigned int nr, char *addr);
 static inline void f2fs_clear_bit(unsigned int nr, char *addr);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e16c4e2830c2..ed17ab4d5cef 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -181,6 +181,7 @@ enum {
 	Opt_nat_bits,
 	Opt_jqfmt,
 	Opt_checkpoint,
+	Opt_lookup_mode,
 	Opt_err,
 };
 
@@ -244,6 +245,13 @@ static const struct constant_table f2fs_param_errors[] = {
 	{}
 };
 
+static const struct constant_table f2fs_param_lookup_mode[] = {
+	{"perf",	LOOKUP_PERF},
+	{"compat",	LOOKUP_COMPAT},
+	{"auto",	LOOKUP_AUTO},
+	{}
+};
+
 static const struct fs_parameter_spec f2fs_param_specs[] = {
 	fsparam_enum("background_gc", Opt_gc_background, f2fs_param_background_gc),
 	fsparam_flag("disable_roll_forward", Opt_disable_roll_forward),
@@ -300,6 +308,7 @@ static const struct fs_parameter_spec f2fs_param_specs[] = {
 	fsparam_enum("memory", Opt_memory_mode, f2fs_param_memory_mode),
 	fsparam_flag("age_extent_cache", Opt_age_extent_cache),
 	fsparam_enum("errors", Opt_errors, f2fs_param_errors),
+	fsparam_enum("lookup_mode", Opt_lookup_mode, f2fs_param_lookup_mode),
 	{}
 };
 
@@ -336,6 +345,7 @@ static match_table_t f2fs_checkpoint_tokens = {
 #define F2FS_SPEC_discard_unit			(1 << 21)
 #define F2FS_SPEC_memory_mode			(1 << 22)
 #define F2FS_SPEC_errors			(1 << 23)
+#define F2FS_SPEC_lookup_mode			(1 << 24)
 
 struct f2fs_fs_context {
 	struct f2fs_mount_info info;
@@ -1143,6 +1153,10 @@ static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_nat_bits:
 		ctx_set_opt(ctx, F2FS_MOUNT_NAT_BITS);
 		break;
+	case Opt_lookup_mode:
+		F2FS_CTX_INFO(ctx).lookup_mode = result.uint_32;
+		ctx->spec_mask |= F2FS_SPEC_lookup_mode;
+		break;
 	}
 	return 0;
 }
@@ -1652,6 +1666,8 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
 		F2FS_OPTION(sbi).memory_mode = F2FS_CTX_INFO(ctx).memory_mode;
 	if (ctx->spec_mask & F2FS_SPEC_errors)
 		F2FS_OPTION(sbi).errors = F2FS_CTX_INFO(ctx).errors;
+	if (ctx->spec_mask & F2FS_SPEC_lookup_mode)
+		F2FS_OPTION(sbi).lookup_mode = F2FS_CTX_INFO(ctx).lookup_mode;
 
 	f2fs_apply_compression(fc, sb);
 	f2fs_apply_test_dummy_encryption(fc, sb);
@@ -2416,6 +2432,13 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	if (test_opt(sbi, NAT_BITS))
 		seq_puts(seq, ",nat_bits");
 
+	if (F2FS_OPTION(sbi).lookup_mode != LOOKUP_PERF) {
+		if (F2FS_OPTION(sbi).lookup_mode == LOOKUP_COMPAT)
+			seq_show_option(seq, "lookup_mode", "compat");
+		else if (F2FS_OPTION(sbi).lookup_mode == LOOKUP_AUTO)
+			seq_show_option(seq, "lookup_mode", "auto");
+	}
+
 	return 0;
 }
 
@@ -2480,6 +2503,8 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 #endif
 
 	f2fs_build_fault_attr(sbi, 0, 0, FAULT_ALL);
+
+	F2FS_OPTION(sbi).lookup_mode = LOOKUP_PERF;
 }
 
 #ifdef CONFIG_QUOTA
-- 
2.50.1.565.gc32cd1483b-goog


