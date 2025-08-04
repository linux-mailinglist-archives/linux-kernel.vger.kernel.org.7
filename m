Return-Path: <linux-kernel+bounces-754711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 430C4B19B42
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60CA1897C75
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3669223DDE;
	Mon,  4 Aug 2025 06:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yEUlfzfx"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CB028371
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754287414; cv=none; b=a93qnVJ1OeCquLkrZuJDUVgqBBc5Qvr+aDiWrDIj+NCnLXWHCnJwAAGBj4xUP7NXdWTcpGbGj3LQfTEremcH9fcrj3d+oy74h8ojXNUVa3kVP2o+mXFEgfkY2SNt0zvSiZBRP1oMo7qRu6Pr8bIlGloHT/6R8UB92xImxTL43KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754287414; c=relaxed/simple;
	bh=oAGSGnDEDrQrlF0aTsGdsgHBJ9fqdeBOD+35tuZvaPI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FJb/rFPLwkJx8IqWVXlRFHnP3lnaZpCGDDdNgTpGCVI2NSooXvSsyHl0F/stH7GGtubAgrMzUvYrpn7mJaijwHfpPNLQSm9I5yxgk65kSb6ffrPvjCIWbu7eiLQnMz802SYQzLjjFe0JtH20d2nVq+6vQ6MX0RvH/pbT9Xx4nbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yEUlfzfx; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chullee.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76bf0093461so2722690b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 23:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754287412; x=1754892212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=elcErCyGxPWsZdvaiFeyMC/Tyr7wc6dFQorNHNgelwg=;
        b=yEUlfzfxO1UeqqiNpCBwVGQsMhyy9r+bZgKTlp0SsV8lwCtJbq0GE4dQD7UFPboq8A
         Z8u0dwLyefhUbMMpVllAoFz7Q+b2Ir7baGhuk2dTzI/AqKCsf/yc8+2pAqNW3H6mDuYJ
         r2N1qP9fE2UatjIg+vHp3taWeXun4hzoAr8jstqW5VyK4HLoHFODOUvxEHnr1qUd7IhO
         Jpgac0MmPwogu34RAaHd9LHuPZY5WakS/WeGeyC3VV3BgJ7hvj+XpSbqoOHz+xrvyl74
         lD1t9NrqtHGy5Ezt9Q+6EJrwTp5estcZFbTx3plZKMxC3Ichv4TRMk7Io52w7hyh+Ctb
         9QyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754287412; x=1754892212;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elcErCyGxPWsZdvaiFeyMC/Tyr7wc6dFQorNHNgelwg=;
        b=K/UMOWUocNxh/4X/5gchbjGuuSep1m+aQyiRFVrnQYBu2DprN5vSccnSyWa/q4QDt3
         OkgssFTPK4wLnnpNEx4orDJMTyliyBRV3p/AEWlf4EqAAUP4vWW3isvctcpKiyCflBv9
         5Od10rcmJ+mB5C+NON9J40n1IZT6RDbP1TOCSl8OJZ1i7//p9m23mt18X/ffDwiijzr6
         ibQhGoc2Th2R9qvkW0XvlcI/RdqrPXHBHT9ywM+uM16hww1vU4OYnoBNVi+ehfTcVMaf
         iEs81FtsuepxTyvSOIKCafMfsEVD/2eKpwbyxw62RvWXDxH18SpHoYzwVTqG1348MZ30
         Vzqw==
X-Forwarded-Encrypted: i=1; AJvYcCXFZ0DuwQh9VemyWP+mSrBFxAqcs0LXUeuZmRDNAd/75YA4R/rKtgtvsc2XtfCkvv8T+R9783Mpw4y/48s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAD4/CPnnMUggtfw0ZNNFn6NeS8v69q7hfYX4y0zWBxz7sO0D
	uUC+65aO1EeG4+UvMdA0/MrzTAVfVpLMcoQZYG2b2Zb7KP9OMCQCtRoQ+y9RDeufZ/3ahV6Cxx+
	akwvlKNQsAQ==
X-Google-Smtp-Source: AGHT+IHMBbHQiqqtxuRJj5ec5P70FJZ0/coPwj7FXCqLACpqnSQ89lwhXMyLuSH0E1eTQ4YaofJ7abWXCnGI
X-Received: from pfbg17.prod.google.com ([2002:a05:6a00:ae11:b0:76b:f876:772e])
 (user=chullee job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:210c:b0:21f:5598:4c2c
 with SMTP id adf61e73a8af0-23df8fa5edemr12542666637.13.1754287411768; Sun, 03
 Aug 2025 23:03:31 -0700 (PDT)
Date: Sun,  3 Aug 2025 23:03:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250804060327.512247-1-chullee@google.com>
Subject: [PATCH 1/2] f2fs: add lookup_mode mount option
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
 Documentation/filesystems/f2fs.rst | 19 ++++++++++++++
 fs/f2fs/dir.c                      | 17 ++++++++++++-
 fs/f2fs/f2fs.h                     | 41 ++++++++++++++++++++++++++++++
 fs/f2fs/super.c                    | 20 +++++++++++++++
 4 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 440e4ae74e44..01c657ff7ae2 100644
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
index c36b3b22bfff..ba032d21a997 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -16,6 +16,21 @@
 #include "xattr.h"
 #include <trace/events/f2fs.h>
 
+static inline bool f2fs_should_fallback_to_linear(struct inode *dir)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
+
+	switch (f2fs_get_lookup_mode(sbi)) {
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
index 9333a22b9a01..fed588f4fa3d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -132,6 +132,12 @@ extern const char *f2fs_fault_name[FAULT_MAX];
  */
 #define F2FS_MOUNT_LAZYTIME		0x40000000
 
+enum f2fs_lookup_mode {
+	LOOKUP_PERF,
+	LOOKUP_COMPAT,
+	LOOKUP_AUTO,
+};
+
 #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
 #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
 #define set_opt(sbi, option)	(F2FS_OPTION(sbi).opt |= F2FS_MOUNT_##option)
@@ -1355,6 +1361,8 @@ enum {
 	SBI_IS_RESIZEFS,			/* resizefs is in process */
 	SBI_IS_FREEZING,			/* freezefs is in process */
 	SBI_IS_WRITABLE,			/* remove ro mountoption transiently */
+	SBI_LOOKUP_COMPAT,			/* enable compat/auto lookup modes */
+	SBI_LOOKUP_AUTO,			/* enable auto lookup mode */
 	MAX_SBI_FLAG,
 };
 
@@ -4897,6 +4905,39 @@ static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
 	f2fs_invalidate_compress_pages_range(sbi, blkaddr, len);
 }
 
+/*
+ * The lookup mode is stored in two bits within sbi->s_flag:
+ *
+ * SBI_LOOKUP_COMPAT | SBI_LOOKUP_AUTO | Mode
+ * ------------------|-----------------|--------
+ *          0        |         0       | perf
+ *          1        |         0       | compat
+ *          1        |         1       | auto
+ *
+ */
+static inline enum f2fs_lookup_mode f2fs_get_lookup_mode(struct f2fs_sb_info *sbi)
+{
+	if (!is_sbi_flag_set(sbi, SBI_LOOKUP_COMPAT))
+		return LOOKUP_PERF;
+	if (is_sbi_flag_set(sbi, SBI_LOOKUP_AUTO))
+		return LOOKUP_AUTO;
+	return LOOKUP_COMPAT;
+}
+
+static inline void f2fs_set_lookup_mode(struct f2fs_sb_info *sbi,
+						enum f2fs_lookup_mode mode)
+{
+	clear_sbi_flag(sbi, SBI_LOOKUP_COMPAT);
+	clear_sbi_flag(sbi, SBI_LOOKUP_AUTO);
+
+	if (mode == LOOKUP_COMPAT)
+		set_sbi_flag(sbi, SBI_LOOKUP_COMPAT);
+	else if (mode == LOOKUP_AUTO) {
+		set_sbi_flag(sbi, SBI_LOOKUP_COMPAT);
+		set_sbi_flag(sbi, SBI_LOOKUP_AUTO);
+	}
+}
+
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bbf1dad6843f..09cdd4c22e58 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -196,6 +196,7 @@ enum {
 	Opt_age_extent_cache,
 	Opt_errors,
 	Opt_nat_bits,
+	Opt_lookup_mode,
 	Opt_err,
 };
 
@@ -276,6 +277,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_age_extent_cache, "age_extent_cache"},
 	{Opt_errors, "errors=%s"},
 	{Opt_nat_bits, "nat_bits"},
+	{Opt_lookup_mode, "lookup_mode=%s"},
 	{Opt_err, NULL},
 };
 
@@ -1317,6 +1319,22 @@ static int parse_options(struct f2fs_sb_info *sbi, char *options, bool is_remoun
 		case Opt_nat_bits:
 			set_opt(sbi, NAT_BITS);
 			break;
+		case Opt_lookup_mode:
+			name = match_strdup(&args[0]);
+			if (!name)
+				return -ENOMEM;
+			if (!strcmp(name, "perf")) {
+				f2fs_set_lookup_mode(sbi, LOOKUP_PERF);
+			} else if (!strcmp(name, "compat")) {
+				f2fs_set_lookup_mode(sbi, LOOKUP_COMPAT);
+			} else if (!strcmp(name, "auto")) {
+				f2fs_set_lookup_mode(sbi, LOOKUP_AUTO);
+			} else {
+				kfree(name);
+				return -EINVAL;
+			}
+			kfree(name);
+			break;
 		default:
 			f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
 				 p);
@@ -2220,6 +2238,8 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 #endif
 
 	f2fs_build_fault_attr(sbi, 0, 0, FAULT_ALL);
+
+	f2fs_set_lookup_mode(sbi, LOOKUP_PERF);
 }
 
 #ifdef CONFIG_QUOTA
-- 
2.50.1.565.gc32cd1483b-goog


