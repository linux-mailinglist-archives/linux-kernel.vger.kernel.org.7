Return-Path: <linux-kernel+bounces-756030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 796EBB1AEE5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 562324E2350
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A7E221280;
	Tue,  5 Aug 2025 06:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cluUfSEf"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C7022068A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376923; cv=none; b=aFFnmOvcuHy5zZAV5tWJ5sLIaqwcmtII9CO6+jcXQVspYaUN5Nbz3FEusf9E9WDIcXGLiIEvZy/fVkKOOVQye1Urd0P5KlJpiPfLHVSfQg4q0tDH+7dNRf1CkJpMSfgU7AAZ8ElV2n5eo9le4zsKjgHGyVp1jJKasw532bktCmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376923; c=relaxed/simple;
	bh=FWiQ/cn0h9cwc3brNPzLifLYW/RAGqg1eESQ+GWLN9A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=M0bPgMRwkr1uc9d7OTd4RPfvPekIGDz2yaXL2n7kafYga2szVUl1Lub2xHHR+3AQJWx875ZmPQ+QZkckNVj2weRC9x1+670LTRJjUxg55fuoLuQD8WTO8LGA/x3N65NpVmQP75iMwiqADSWtgjAN2ens+B+YsIWfz4T+lyZ4JqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cluUfSEf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24283069a1cso13012415ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754376920; x=1754981720; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KEpLNwzlu2PrVruo6qrV5HzwRqjVG1/m25AZhXshC6w=;
        b=cluUfSEfsBU2lWW498Hs4GU4+ERqhzt4RNWjLSQOMAApkJl+NX5VOGyMuoExQ3NFbC
         oEokCPEgsbG2olEHQAxCvp3TEu9iqHfSApYwjiYs/NZEcSyIEuZDC9KbYh6O52RLdmw2
         CeF8lirUU4KuzkoxG5BRSQ5On05A3Buwfkp6Az8cWCX1FxfU3d0k7v64etkeP8t+E8yM
         5mpVuHkZTS8Od5nN6wrJqoyusoW+WtOxTmT21bvTcEyt0puCcGlYgE5MZoufKjKpoYCw
         oAky/1fJ4cTd1mFqoWpFpW6OYzJDkkiv68lXn6JcGS0yS6Rwlr96E8/0wEqasZ93dc7e
         hCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754376920; x=1754981720;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KEpLNwzlu2PrVruo6qrV5HzwRqjVG1/m25AZhXshC6w=;
        b=jGJUsAikirtQ7kLM+egTXwDRupg5qk6BdQMHduZWdHeRdwYd5GVSTCpUzxm8B+RP0M
         8GialQr2DjAnMs3e6X7RQGK+y/lAYrzv11X7XapQbECZi5upjOVK9bFz1zFQXgs+40Hl
         M4JJorYvh0NmnfoiG1/VsN2ZCvUMFH0CgPH9fuuASFTgS7dfImtzlS+A7V/ZsY+cOQ0d
         cwwHs05N00oYMSH90bryw4WE32YdINqiO9M3IObvbxJyMmtjysvAL/ELh9QDFj4Gtg8T
         tEU0MiT2M2mlLlQKIc6WDWA/Lggu6mNHx/I5xqrYdMdlnHWRTyuXQMDEufZQcu2N6AsX
         WGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGeAI2Oi9wy4+r2TKeFsm42XeLlkLmi6ni8sPBVIo4rS00GUJNRywvcqJzJCEEvql+u+654xSY38uEZyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgpSf2gg1QLXl9tDq7CYBuGfbjXkPSAu0q+QN6mUKt04Fj4rXy
	LT1sawTYLT3dz/dbg73QgXyYswLkYa4uFmCboMZ0M1JgEMfQ6drQiaK5FRxWqKBRihzR56VqTDc
	UEZzz/hghdA==
X-Google-Smtp-Source: AGHT+IH8Mbj611XAjvSLNlIYBSto0/pFpbsPWDpwTNg0FN6ajxiBIGOOPATE1mYeK7Nt6sEdS7CUdT0+0nbz
X-Received: from plok5.prod.google.com ([2002:a17:903:3bc5:b0:240:718d:564a])
 (user=chullee job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea06:b0:240:887c:7b95
 with SMTP id d9443c01a7336-24246f30415mr190317035ad.5.1754376920190; Mon, 04
 Aug 2025 23:55:20 -0700 (PDT)
Date: Mon,  4 Aug 2025 23:52:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805065228.1473089-1-chullee@google.com>
Subject: [PATCH v3 1/2] f2fs: add lookup_mode mount option
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
v3:
- show option lookup_mode=perf.
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
index e16c4e2830c2..0638ae9816ac 100644
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
 
+	if (F2FS_OPTION(sbi).lookup_mode == LOOKUP_PERF)
+		seq_show_option(seq, "lookup_mode", "perf");
+	else if (F2FS_OPTION(sbi).lookup_mode == LOOKUP_COMPAT)
+		seq_show_option(seq, "lookup_mode", "compat");
+	else if (F2FS_OPTION(sbi).lookup_mode == LOOKUP_AUTO)
+		seq_show_option(seq, "lookup_mode", "auto");
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


