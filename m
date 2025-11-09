Return-Path: <linux-kernel+bounces-891881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BACC43B6D
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 10:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CCA8188817A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 09:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7762D4816;
	Sun,  9 Nov 2025 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEUBGIWK"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5A613C3F2
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762682066; cv=none; b=px6qzLXhh0TFSVjC92Vdm24kW76E6sEwhq/Fo4unSuR/mFeecLPrt3CJkpPS4VxIV7i0yFraOUiaCAv1V17Vq+/FdbfLbeVHKhDbOfaCV82vfH0JDNzV5RCrVyj9cf78Z7qqNq5itabj72hxkyMXDD46yCqrsssBRldNNnod9io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762682066; c=relaxed/simple;
	bh=RgoZ0Fk4zJLGfI2ojrl3UMeiwuZKAGycVmYMTGzuki8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LgPeB1J18t9FFAaXZhZwpTcAbxzgix9wJ5YT2lF2z0BJgZhPc4ZXdL8TYNCj6VUhoUo9CuQzKHiTQUU6TytklRbc1ead24VnARJACd2C1gBTH/QFMjCcgzxN/c3pE+9TzeTYPkS8CksBRbVZx4If8koI6TktkcH4ClQC5jlc8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEUBGIWK; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-340ad724ea4so267318a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 01:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762682064; x=1763286864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2mJACnQxh4sD/p1rN5JTzDZGkA2szKxHiA+o6hUrw0=;
        b=WEUBGIWKn8zjiI2FT4nmGFnDAv1GtR8DnyQcBymXWurETqCNJ9Q6JB2g52sNyhDGGr
         S78PLGzNf/01yT/GX7oL2UKdmWdaJbAJu7L/pfO8CIeVTHRSb/ruOJeWTGbWEBmt1x8q
         HFd3QylXKpGUN3uaGjJskXqjvu8JgVaDz0kP3PNXiG+S6481+LRTnI9tgBrl/+rntjYD
         YvuiSkr1tsP3ze8p619J2Qh+xINJNEtMWJTidwwEFBg6Bx/joRvmv3Ahii+GDcyTR87L
         p3oxErHV3+YiBwXScAT4hIuBfRTbGJ3MKnHE8gbYTNlIWRiUuT0iHwAwl2+2FYvuanVb
         KibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762682064; x=1763286864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2mJACnQxh4sD/p1rN5JTzDZGkA2szKxHiA+o6hUrw0=;
        b=FuS5Z+88Hs/sRBug21a8wL6EHQs7JZvGb7mvYeZRcAk/o7aSbV297JpXDHE61jnFTx
         CGfwfGzT8woTKeG7qdlrzGi/oICGLhkalI+ELQTNqlGBK3pi583myqL1DRk9EwwcFehK
         IPoXJgLY96jn5ApKGANGwVsarZq+BnozQTpZO82BcpDnuwUPenMdEDo/Ww6JKzeGw2IP
         2aPdkZMLGyLiuZIQVewKFoEEMvGdpgQigcS8W0wtRQmSHoggM3qP2hgF7W3pLfRV6Iqn
         IOul9z5t903/odKsAf/Xv2zyyLHRCkr5wQf5JyCFsBhBug8O60Wc9Ep6MDOYXJphkT3M
         qe1g==
X-Forwarded-Encrypted: i=1; AJvYcCV3XEmLGiASG40mBsY6NGOHCCmu9bskqpztLoumc3VRzEExCRNupySiL74mU4a8RYgF04+gFfNB6c1xUUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxW0kiRZtk/tYXVUSEUQE5qElZEbMdQ6occqPBwkWU7rdVYN2N
	q2wlknAse0uouDesT5LTH//eBUzfvJ7ESZGo/jpVkU0gZZgfSth65Hkv
X-Gm-Gg: ASbGncvyfk+/r1QK4bDBYFAjV+POA9mxXZCUE7z7fwGInNSRyPs29cynIHbGAjY+0l5
	pYd+9DoVP8YJR6Z2odBMNAqzjrbEZdgDedWcS+5G7Jn1ulvTLf6FxIcV4T2PQgL5h1oO2GGJ39L
	6Bb8n2B5siEOlB4kUAUVJdEGxDXcp+1E2zyHrN8D5ju1uhbgdYYu5kTd9869DjJYWqgkJIBOafs
	UBDAxuTXNHyPp/sNvsab9O5joPbarizVL1Mwdus1JCynyMTkKM9Bqf0RHfD+vDq7XsP6O9+SHtf
	jmCixrYvzkcuna/Qkt4t8OMX8rCwrXd1h9Hr5cd8kGtiBT5WeBgqoiQlty7mCeNBEqAPQNnLQK3
	YgLhhQys1oCM8n/6VnYarulR6q8Oo5QMSr2AqHd6+RKRjLdUEjPidgUk7tlaZYXrPaot4ER4Gy/
	BDsQjxEz0lSbRrqaz4td++UduhPlZM
X-Google-Smtp-Source: AGHT+IGb0U3tFr9TL8bOD50VtKU25lK/Pj6KKmtdQ7daasGpBhl7uujoLGSXyt/2ZeJKF5VCSgi1Gw==
X-Received: by 2002:a17:902:d4c8:b0:297:fe30:3b94 with SMTP id d9443c01a7336-297fe304a7fmr17440385ad.9.1762682064333;
        Sun, 09 Nov 2025 01:54:24 -0800 (PST)
Received: from elitemini.flets-east.jp ([2400:4050:d860:9700:75bf:9e2e:8ac9:3001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c70381sm109013265ad.66.2025.11.09.01.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 01:54:24 -0800 (PST)
From: Masaharu Noguchi <nogunix@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: corbet@lwn.net,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akiyks@gmail.com,
	nogunix@gmail.com
Subject: [PATCH v2] Documentation: f2fs: wrap tables in literal code blocks
Date: Sun,  9 Nov 2025 18:54:16 +0900
Message-ID: <20251109095416.2428351-1-nogunix@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sphinx LaTeX builder fails with the following error when it tries to
turn the ASCII tables in f2fs.rst into nested longtables:

  Markup is unsupported in LaTeX:
  filesystems/f2fs:: longtable does not support nesting a table.

Wrap the tables in literal code blocks so that Sphinx renders them as
verbatim text instead. This prevents the LaTeX builder from attempting
unsupported table nesting and fixes the pdfdocs build.

Akira Yokosawa pointed out that the in-development Sphinx 8.3 latex
builder already handles these nested tables. I still want to fix the
current documentation because Sphinx 8.3 is not released yet, and the
LaTeX build on the stable 8.2.x series (which also requires
"docutils<0.22" for now) remains broken without this change.

Link: https://lore.kernel.org/lkml/20251011172415.114599-1-nogunix@gmail.com/
Changes in v2:
 - wrap the compression level table in a literal block and add the
   missing blank lines so docutils no longer warns about malformed
   tables
 - consistently use ``.. code-block:: none`` for the other ASCII tables
   that previously triggered the LaTeX error

Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
---
 Documentation/filesystems/f2fs.rst | 115 +++++++++++++++--------------
 1 file changed, 61 insertions(+), 54 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index a8d02fe5be83..07b8e752476d 100644
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
@@ -296,14 +298,15 @@ nocheckpoint_merge	 Disable checkpoint merge feature.
 compress_algorithm=%s	 Control compress algorithm, currently f2fs supports "lzo",
 			 "lz4", "zstd" and "lzo-rle" algorithm.
 compress_algorithm=%s:%d Control compress algorithm and its compress level, now, only
-			 "lz4" and "zstd" support compress level config.
-
-                         =========      ===========
-			 algorithm	level range
-                         =========      ===========
-			 lz4		3 - 16
-			 zstd		1 - 22
-                         =========      ===========
+			 "lz4" and "zstd" support compress level config::
+
+				 =========      ===========
+				 algorithm	level range
+				 =========      ===========
+				 lz4		3 - 16
+				 zstd		1 - 22
+				 =========      ===========
+
 compress_log_size=%u	 Support configuring compress cluster size. The size will
 			 be 4KB * (1 << %u). The default and minimum sizes are 16KB.
 compress_extension=%s	 Support adding specified extension, so that f2fs can enable
@@ -368,38 +371,42 @@ errors=%s		 Specify f2fs behavior on critical errors. This supports modes:
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
2.51.1


