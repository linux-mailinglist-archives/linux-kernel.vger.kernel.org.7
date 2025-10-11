Return-Path: <linux-kernel+bounces-849225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BF2BCFA25
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 19:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 266FD189C0E8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A8727FB31;
	Sat, 11 Oct 2025 17:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlsvB1Qf"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647327A935
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760203467; cv=none; b=AjwW+h2KrVGNF8PE9gd2M3sArPzzUAqfpooqN6XezrfJqR/sP9+PWtmBhjtbrRITRfx8muZOtgAXliefWSqZKa8rnl6GYzNzk+uEjg7RpFu6Pf3XTYKycY+/LP4aKN6Hcxarl+KdoPZzYEX8QFip9v/4rzQJCV0OzQs3K6++y6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760203467; c=relaxed/simple;
	bh=wW9RnBHgkY1segWRDpZoIwgvv+8BSy2qVfHh+v6DOF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APi4bRUsZwMw2Hl6htH95KCxs3DXVDNZLrtrtC+dYfp/21MfNxm4XMdsJ4ydijqZ0ehyRx56RZpsazqqFdDQqFZbnL8D4VYlnatKiYE9ZedxpNhZLjYeHSy6WD3+JrnkPaIKZZB+umeKDlCW9yqLWScjLwBB6UF0E2M6i4FXsXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlsvB1Qf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27ec3db6131so6125075ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 10:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760203465; x=1760808265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nr75ZFbZ4/qx4rlwkOcGtUvCvFckrNfl3ESmCUVAzBQ=;
        b=nlsvB1QfFeev0TRg7+g+Ke2aWGOMSIMC0Kaz4UGIm1QeQ+mg4+V3e3Oug0EGPsxsqy
         punU+Vgbo4xxEaSc9t02ATxy2cf5utikIEljt7aa1FDVmaH0jsR3OAKPRq5FeEo4Q07U
         2d2MbhPEMy2QsZypkg1w2ARY5oHEuapKy95fE6HZAh4n6hejSaKjqAg4yfaQ9mb2Q3P4
         GDph3F7bCBYIaH14MVApuRyDZXACcrm30ViCHXtBciGdaJp+VaB7hTbdI7foNfBgRb+S
         wdTBWJwvmbv1Yt0ROtIydoQURhfqsnXi+te+g1OndDbf1SmA2jllEAO+LrRwXXzMyhWG
         vxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760203465; x=1760808265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nr75ZFbZ4/qx4rlwkOcGtUvCvFckrNfl3ESmCUVAzBQ=;
        b=wrmos/6DxGRsGUa/z20guvc5Eod+A5NZBa9janTad3ex2xZAxheJlKrBlpyQuATUhh
         nZDwdyOwXXR+/c+jcfPdCKAYe9tdRBjwW0rNdRNfvhqRVNXzQKFT3DE51EjrkL7f8RgH
         +jN5KHbFsB3K23PSL3V+etturPa1SVRx6I8QKVJ1iQhNpOm+Ipz3Wq3/HBxTj1FO237H
         XRIls94ivF7lk0Jbsy3h9VHtO024kV3eanh5JqaNFWt9zUU04ndvoGApuixTINWms7+e
         vTYwQKncWTOi2LgIoRp/If/hcnYtJchS6MoOJVwmz1x7xjFVxRuRagYW4dpMmxc/GrBO
         bjZw==
X-Forwarded-Encrypted: i=1; AJvYcCVt6I/6V4ELW7ISoa6WA3bsVeZ5AnKV2mFTdct7akjgEnwUpcq9Y51WcLbN1iaDHjrYXAYuia20ClULi4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ISxIm698aTSBkCmSEX1XXbSojaaZz5vEgV5w8LSRjzSbbAdp
	bKT32oyi7Rgp2I6WBmBpLqpJ5DdGNSdA6YFrUertWD57rKHwUI7aCBX4
X-Gm-Gg: ASbGncvr2PPC/qJK2XpJHmt6OhVp3EB25egKFQvGmOpAVlzo+m9yV+w8wzkBlvx8DQQ
	//WtuVZj8q4OAj0Emm2Yoad3B2bYnXcqBgx4U570IPRbf2uMxcV0b9h4YCjRFFSkQofyhCTmBhF
	gC3V6x1NeCF8L8w+54b1UdzAt2UME0gMj2pN0wm/GwaA6MFJRSW4q2K8MLb2izyGz0vJjJCV/Wf
	03bTN3u5odOpvbEUQiE3CoKrFQuZ4ttCr9QFBGQmJTxoLjS+VxuPlQ25hBFwr2KLrQyQPVXvVDC
	9FsKXKuaOt8MqFNXpTJQKzq5lBRsNhHE9OQ47teygDSJ1iK5WPeSyOv+aMA6/2j0axFh2ihtuNv
	1ivV2Kk31mHsdB3Oc0wJD3mwduIN/7a4+Oc3f4Nm76A8R+bG2uJyEExmzNMA=
X-Google-Smtp-Source: AGHT+IHDS/1rGu/qMTg3HP/g+EzjHB0vBFkMKwHWzTIyGYYPbY2si4NNPBadPtSI7F369JWGXkWS7w==
X-Received: by 2002:a17:902:c950:b0:26a:3c75:5241 with SMTP id d9443c01a7336-2902744bc67mr119102425ad.9.1760203464660;
        Sat, 11 Oct 2025 10:24:24 -0700 (PDT)
Received: from elitemini.flets-east.jp ([2400:4050:d860:9700:ff1c:3f53:c7ab:f611])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034dea083sm89355075ad.24.2025.10.11.10.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 10:24:24 -0700 (PDT)
From: Masaharu Noguchi <nogunix@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE SYSTEM),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH] Documentation: f2fs: wrap tables in literal code blocks to fix LaTeX build
Date: Sun, 12 Oct 2025 02:24:15 +0900
Message-ID: <20251011172415.114599-1-nogunix@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sphinx LaTeX builder fails with the following error:

  Markup is unsupported in LaTeX:
  filesystems/f2fs:: longtable does not support nesting a table.

Wrap the ASCII tables in literal code blocks so that they are rendered
as code instead of interpreted as tables. This fixes pdfdocs build
failure.

Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
---
 Documentation/filesystems/f2fs.rst | 106 ++++++++++++++++-------------
 1 file changed, 57 insertions(+), 49 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index a8d02fe5be83..80f94f309cea 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -188,34 +188,36 @@ fault_type=%d		 Support configuring fault injection type, should be
 			 enabled with fault_injection option, fault type value
 			 is shown below, it supports single or combined type.
 
-			 ===========================      ==========
-			 Type_Name                        Type_Value
-			 ===========================      ==========
-			 FAULT_KMALLOC                    0x00000001
-			 FAULT_KVMALLOC                   0x00000002
-			 FAULT_PAGE_ALLOC                 0x00000004
-			 FAULT_PAGE_GET                   0x00000008
-			 FAULT_ALLOC_BIO                  0x00000010 (obsolete)
-			 FAULT_ALLOC_NID                  0x00000020
-			 FAULT_ORPHAN                     0x00000040
-			 FAULT_BLOCK                      0x00000080
-			 FAULT_DIR_DEPTH                  0x00000100
-			 FAULT_EVICT_INODE                0x00000200
-			 FAULT_TRUNCATE                   0x00000400
-			 FAULT_READ_IO                    0x00000800
-			 FAULT_CHECKPOINT                 0x00001000
-			 FAULT_DISCARD                    0x00002000
-			 FAULT_WRITE_IO                   0x00004000
-			 FAULT_SLAB_ALLOC                 0x00008000
-			 FAULT_DQUOT_INIT                 0x00010000
-			 FAULT_LOCK_OP                    0x00020000
-			 FAULT_BLKADDR_VALIDITY           0x00040000
-			 FAULT_BLKADDR_CONSISTENCE        0x00080000
-			 FAULT_NO_SEGMENT                 0x00100000
-			 FAULT_INCONSISTENT_FOOTER        0x00200000
-			 FAULT_TIMEOUT                    0x00400000 (1000ms)
-			 FAULT_VMALLOC                    0x00800000
-			 ===========================      ==========
+			 .. code-block:: none
+
+			     ===========================      ==========
+			     Type_Name                        Type_Value
+			     ===========================      ==========
+			     FAULT_KMALLOC                    0x00000001
+			     FAULT_KVMALLOC                   0x00000002
+			     FAULT_PAGE_ALLOC                 0x00000004
+			     FAULT_PAGE_GET                   0x00000008
+			     FAULT_ALLOC_BIO                  0x00000010 (obsolete)
+			     FAULT_ALLOC_NID                  0x00000020
+			     FAULT_ORPHAN                     0x00000040
+			     FAULT_BLOCK                      0x00000080
+			     FAULT_DIR_DEPTH                  0x00000100
+			     FAULT_EVICT_INODE                0x00000200
+			     FAULT_TRUNCATE                   0x00000400
+			     FAULT_READ_IO                    0x00000800
+			     FAULT_CHECKPOINT                 0x00001000
+			     FAULT_DISCARD                    0x00002000
+			     FAULT_WRITE_IO                   0x00004000
+			     FAULT_SLAB_ALLOC                 0x00008000
+			     FAULT_DQUOT_INIT                 0x00010000
+			     FAULT_LOCK_OP                    0x00020000
+			     FAULT_BLKADDR_VALIDITY           0x00040000
+			     FAULT_BLKADDR_CONSISTENCE        0x00080000
+			     FAULT_NO_SEGMENT                 0x00100000
+			     FAULT_INCONSISTENT_FOOTER        0x00200000
+			     FAULT_TIMEOUT                    0x00400000 (1000ms)
+			     FAULT_VMALLOC                    0x00800000
+			     ===========================      ==========
 mode=%s			 Control block allocation mode which supports "adaptive"
 			 and "lfs". In "lfs" mode, there should be no random
 			 writes towards main area.
@@ -298,12 +300,14 @@ compress_algorithm=%s	 Control compress algorithm, currently f2fs supports "lzo"
 compress_algorithm=%s:%d Control compress algorithm and its compress level, now, only
 			 "lz4" and "zstd" support compress level config.
 
-                         =========      ===========
+			 .. code-block:: none
+
+			     =========      ===========
 			 algorithm	level range
-                         =========      ===========
+			     =========      ===========
 			 lz4		3 - 16
 			 zstd		1 - 22
-                         =========      ===========
+			     =========      ===========
 compress_log_size=%u	 Support configuring compress cluster size. The size will
 			 be 4KB * (1 << %u). The default and minimum sizes are 16KB.
 compress_extension=%s	 Support adding specified extension, so that f2fs can enable
@@ -368,38 +372,42 @@ errors=%s		 Specify f2fs behavior on critical errors. This supports modes:
 			 the partition in read-only mode. By default it uses "continue"
 			 mode.
 
-			 ====================== =============== =============== ========
-			 mode			continue	remount-ro	panic
-			 ====================== =============== =============== ========
-			 access ops		normal		normal		N/A
-			 syscall errors		-EIO		-EROFS		N/A
-			 mount option		rw		ro		N/A
-			 pending dir write	keep		keep		N/A
-			 pending non-dir write	drop		keep		N/A
-			 pending node write	drop		keep		N/A
-			 pending meta write	keep		keep		N/A
-			 ====================== =============== =============== ========
+			 .. code-block:: none
+
+			     ====================== =============== =============== ========
+			     mode			continue	remount-ro	panic
+			     ====================== =============== =============== ========
+			     access ops		normal		normal		N/A
+			     syscall errors		-EIO		-EROFS		N/A
+			     mount option		rw		ro		N/A
+			     pending dir write	keep		keep		N/A
+			     pending non-dir write	drop		keep		N/A
+			     pending node write	drop		keep		N/A
+			     pending meta write	keep		keep		N/A
+			     ====================== =============== =============== ========
 nat_bits		 Enable nat_bits feature to enhance full/empty nat blocks access,
 			 by default it's disabled.
 lookup_mode=%s		 Control the directory lookup behavior for casefolded
 			 directories. This option has no effect on directories
 			 that do not have the casefold feature enabled.
 
-			 ================== ========================================
-			 Value		    Description
-			 ================== ========================================
-			 perf		    (Default) Enforces a hash-only lookup.
+			 .. code-block:: none
+
+			     ================== ========================================
+			     Value		    Description
+			     ================== ========================================
+			     perf		    (Default) Enforces a hash-only lookup.
 					    The linear search fallback is always
 					    disabled, ignoring the on-disk flag.
-			 compat		    Enables the linear search fallback for
+			     compat		    Enables the linear search fallback for
 					    compatibility with directory entries
 					    created by older kernel that used a
 					    different case-folding algorithm.
 					    This mode ignores the on-disk flag.
-			 auto		    F2FS determines the mode based on the
+			     auto		    F2FS determines the mode based on the
 					    on-disk `SB_ENC_NO_COMPAT_FALLBACK_FL`
 					    flag.
-			 ================== ========================================
+			     ================== ========================================
 ======================== ============================================================
 
 Debugfs Entries
-- 
2.51.0


