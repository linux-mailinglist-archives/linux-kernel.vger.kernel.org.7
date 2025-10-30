Return-Path: <linux-kernel+bounces-878048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8991C1FA70
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE09A1897E23
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBBF354ACE;
	Thu, 30 Oct 2025 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N852fcS/"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857D354AC5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821571; cv=none; b=JazngKyC8UbhRaXMOJEuHulVTrK270KbVS6zuGloYZQB1L0cH7KApakM26cUoti/HA5Vpaeow11oDNl4yEV3hT/dFyid7o69tGL5K/fwrWWg/dgtJasuhEQeIGOHccWXyvaNXzSaRuXf6V907dYJX2DNw7IznO+tt/OJKysBj54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821571; c=relaxed/simple;
	bh=Mos+bVHWWaIClE7j2ZiSkxnpxLMWWphG3MVvM2Pmiws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WCR5fe8D2AEhJTxeGrpx2mzNSCRmaB5Cocq7kG7cVkyg0G1aNxVh0y4jQVvR0F6lcJTGwgLD6WgLSHYy8EKlh+7H9lnLf7w7fMRyViWdieh65CxeFEPxXpMBtTkKC+mGv9OJN4qEAGI+PGMqxEaDzHhQhdA6zT175fNe4I+tMbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N852fcS/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b6d83bf1077so176746766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761821568; x=1762426368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x2fMs//ttuDkI1LP3R5XEdMm907B0irHXCx1o3kP9jo=;
        b=N852fcS/spNy4VGFx7HZcuVGDFi3qyXDnRg6uZAF69xD9sf5nBHBsjAwi6TFJL8xIH
         eZdRg/2GvsSdFBoMNl1zrgC5SWvQ7ufjK9ZnlTlbKnc/3VsWIfFQT98gmQWV/B25/Rn2
         R4UFZqGYWkRyken/34M6WpLQBBle8VZrxejeolbXAUWkbIaJAoZdJDbDCgd+0T7F29m9
         YwcKCb6zIptRye0/BSWtZ99XZCGsrlPTTiFvMVO3sK65Xwy3jBFjMdUNpOS23FgafTJV
         AtopWkwC6rmDkgjKs4R3BzzWHVW0NwajTUIG3hFjv5b/CKmpv5UqkF0nWGaaa89kW0LD
         X95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821568; x=1762426368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2fMs//ttuDkI1LP3R5XEdMm907B0irHXCx1o3kP9jo=;
        b=rVugeWE/NjvjFQbzyvlogLI4iUylSsDJhNgO9cM5dFpS8wpgdzHL6vj7uYyUyLLiWC
         ChvdWZ9yr598frs0MSBcZ5BlV7nSzjknHDSO/WUwuCnIEr/SvRKJu0U6No2VWmcrBnRR
         mO98V52jjlxFD+Qbwvw7smIPis9Qh97Mg9MOR/Bxxj1dguWVUEmSkoLSMnJSm0XUp48L
         NDjS2Ut2TRosgYiXXiyBWegiQP6dpBD1Oq1SDz0r6oK1n0h6xlQ2bNhYrhbd2HpPaQo5
         SFh6e+tmVLF11OCzSPDgmhcA6UenSk46V4Ms87T9pmDuoMCHQOW81B/WzAPlZFyudhKE
         8YCg==
X-Forwarded-Encrypted: i=1; AJvYcCVr9cBlhnDcSk9fJks2L+G0N21gzE+7+atJnikNjAxrfUAkgI5cxVMPz31u8gJ2orelx12EiMK3NyUBkDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRZJHOCz4GUINhB6P9thPLNBvRdKqomgrohAOuNUDnHed+YoKC
	9a67p58G6IKjMWmk0qIWrdm0p/FycOg2sxSTnAgmWgd7CUqNwrxav7z3
X-Gm-Gg: ASbGnctahKSNx5aWc1LLMVKQ4Mb2/uXVmKBYbA/MZWUduJ20juJobJ4mvR7Bypyydls
	RF1AXP4KNKLDlGgyT5bGncwwoguZgZFWW7fremqRHjCWUpCPkcOBJTMpHG64upveOHef/oks1kg
	hgRU9WAofYiKJlETZHEzm7GvY59RsExk9Ubf6/5ZF7QyLO63c5CADH90hW7puhAQQ3pRfrTiqoU
	nF28aPjscIdigIhpv1UzirnqZFnloq7m7jlhP5sW5HKu/TmlYeuLjt5jSLqa8+Vgf+l/XLtmRuB
	oik451TjjrpWlTgMD7ydA9DYW2LbQWP6US7oVMBqXENSXyL5yu039bZbaD3ai1AwliTWGwQImBb
	59EaY2XCsC0fe9R6YTDNZz8lhUwoHoxCdUOBjThN5myg7REW/iNbX3JdB0RhoxrhgQ7xbEFL0UV
	RMv1wr3bmFUfj5p4PvwUffdVBb6wiAmAmdzqxyh2qW6kFQqd/t
X-Google-Smtp-Source: AGHT+IFMTygC3+gqrtXUUzH1zNbg/OMlbiBBICFZ1UC/Za8Di5ViFt9D9cLL/GISuOPRk7evbrcVxQ==
X-Received: by 2002:a17:906:9fcc:b0:b4f:ee15:8ae8 with SMTP id a640c23a62f3a-b703d5cb622mr617942666b.58.1761821567542;
        Thu, 30 Oct 2025 03:52:47 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6da1e2226fsm1301118166b.20.2025.10.30.03.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:52:46 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org,
	pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v4] fs: hide names_cachep behind runtime access machinery
Date: Thu, 30 Oct 2025 11:52:40 +0100
Message-ID: <20251030105242.801528-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The var is used twice for every path lookup, while the cache is
initialized early and stays valid for the duration.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

ACHTUNG WARNING POZOR UWAGA Блять: the namei cache can be used by
modules while the runtime machinery does not work with them. I did some
testing and ifdef MODULE seems to work around the probnlem, but perhaps
someone with build-fu could chime in? I verified with a hello world
module that this works fine, but maybe I missed a case.

v4:
- unbotch the diff below, apologies for the spam

v3:
- fix compilation failure on longarch as reported by kernel test robot,
  used their repro script to confirm

v2:
- ifdef on module usage -- the runtime thing does *not* work with modules
- patch up the section warn, thanks to Pedro for spotting what's up with
  the problem

Linus cc'ed as he added the runtime thing + dcache usage in the first place.

Per the above the machinery does not support kernel modules and I have
no interest in spending time to extend it.

I tried to add a compilation time warn should someone compile a module
with it, but there is no shared header so I decided to drop the matter.

Should someone(tm) make this work for modules I'm not going to protest.

Vast majority of actual usage is coming from core kernel, which *is*
getting the new treatment and I don't think the ifdef is particularly
nasty.

 fs/dcache.c                       |  3 +--
 include/asm-generic/vmlinux.lds.h |  3 ++-
 include/linux/fs.h                | 15 +++++++++++++--
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 035cccbc9276..ef83323276f0 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -35,8 +35,6 @@
 #include "internal.h"
 #include "mount.h"
 
-#include <asm/runtime-const.h>
-
 /*
  * Usage:
  * dcache->d_inode->i_lock protects:
@@ -3265,6 +3263,7 @@ void __init vfs_caches_init(void)
 {
 	names_cachep = kmem_cache_create_usercopy("names_cache", PATH_MAX, 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL);
+	runtime_const_init(ptr, names_cachep);
 
 	dcache_init();
 	inode_init();
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index dcdbd962abd6..c7d85c80111c 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -939,7 +939,8 @@
 
 #define RUNTIME_CONST_VARIABLES						\
 		RUNTIME_CONST(shift, d_hash_shift)			\
-		RUNTIME_CONST(ptr, dentry_hashtable)
+		RUNTIME_CONST(ptr, dentry_hashtable)			\
+		RUNTIME_CONST(ptr, names_cachep)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 68c4a59ec8fb..cfaabd4824f2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -50,6 +50,8 @@
 #include <linux/unicode.h>
 
 #include <asm/byteorder.h>
+#include <asm/runtime-const.h>
+
 #include <uapi/linux/fs.h>
 
 struct backing_dev_info;
@@ -2960,8 +2962,17 @@ extern void __init vfs_caches_init(void);
 
 extern struct kmem_cache *names_cachep;
 
-#define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
-#define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
+/*
+ * XXX The runtime_const machinery does not support modules at the moment.
+ */
+#ifdef MODULE
+#define __names_cachep		names_cachep
+#else
+#define __names_cachep		runtime_const_ptr(names_cachep)
+#endif
+
+#define __getname()		kmem_cache_alloc(__names_cachep, GFP_KERNEL)
+#define __putname(name)		kmem_cache_free(__names_cachep, (void *)(name))
 
 extern struct super_block *blockdev_superblock;
 static inline bool sb_is_blkdev_sb(struct super_block *sb)
-- 
2.34.1


