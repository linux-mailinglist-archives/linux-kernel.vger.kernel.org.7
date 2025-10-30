Return-Path: <linux-kernel+bounces-878045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A5EC1FA4F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A06564E9578
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B7434DB64;
	Thu, 30 Oct 2025 10:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsLfCX6W"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C311307AC4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821459; cv=none; b=n2MF/h0yK3p4Jzcy9yIZHsFGU/2tKkVMcTMsjYmS0wlmHeLehgTmBhih8GzM1ZV5D+Au8uVPcImbX6VtNeFws31/mMaZSdtZc+XkJzY8AdxZgk7KQRbott8NsV4FMZkRupraViCoTjXQBXbDVFgLLPUvmZjv7NseSNk+Ve42rQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821459; c=relaxed/simple;
	bh=Z65r92Iy2Q3CoYFPJWy7LQqKUZs3WILjXTH/na653E8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ntibJHvsn23uV1LnIavPoIZ6GPXsNhimX40rRUyFtEUVHyVcnw0EUUYxY5MSxJTrtrzJcJD4SFXf7LYvUcBIWW/yS5ZwawFFlzQLehbMJsydUgfbQ+dqWWZpTBT6UO+GCWIqr2K2+T66MDE+fXXOJzWynArqq71wZtJTw8t9sww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsLfCX6W; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso1718525a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761821456; x=1762426256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Htru6j8PSSiIR1VQ1fEimOHGXjE7Hw+9EJBZAr9lACM=;
        b=bsLfCX6WFDWoEhgmDxgKUjd9MnX8pT+XuMyA/N9LC824zh36H+nMPPOBtSTSu3WDdf
         /jYMZcK8YHQpa1XY6kf69wAwA+i1GSLnKhBWv4BaA43/ozsiJCDVl8eViurasw3jH7sk
         opbI1FDCJ+V0scR2kNZH4/7EMyohf+rrZpaClJupYApdJezUHyqb/4zAYRrBqCV64/Dh
         skY5t/76NoAcNQGwpB4Fr4xB4t7MtS6hZha2kY+xLqqgZwRBTORoeSr3jvQhLeYNoVgT
         z2u9wTFIOsp5lyejizPdOfyrsmyXC2wyE9F2mxkxRfpqKFGb8H2DyfeEjKan90KSO5D7
         yGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761821456; x=1762426256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Htru6j8PSSiIR1VQ1fEimOHGXjE7Hw+9EJBZAr9lACM=;
        b=m3IAVr566rFEXYwEv6geMCNvAJ3VAW17kUxYMR7rjnRAlf6+GxAGtUfxh7LLclrm31
         2yrenf0yCJfE2pLTDBAJmw6uyM6Si4pC9ZB6oGB7NAuITM8Aa3tkx/H3eMAJFy7XYNWk
         CMFWAfMvT7PdJ+HOvkNwWnoB6Ktj70B9ngORK/5LUC3Kxc/D20yczbpMLiNO9ZZjFMsg
         9GfgBY8Ix8D9wsBozB9F1ba0LVuAV+oQYR4PWjRA+XcbgPVHHehL4izPZ2isCwEkJdfg
         2W3ea4yIqvbyj1P/dd8P5xI4STLTf4sb4MzVSaoTwvzF1IGObgf4b+oOLOezMNvPGaOQ
         CXmg==
X-Forwarded-Encrypted: i=1; AJvYcCUmKCkm11hSIOf8qMkQWbReMIm3McWUZ4upjoh87O037rdpxa9/htTEJwN4M9C4rdJ2OeL/JGQiG8LLsTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3t5RNR4UMmNoVF30Q90FEJIAtGydkqs1NmSEBWvp8dq38KlH2
	h+865U1MuVyYiXdR2Gpz6ZrEnmYCN24SsX5IMN13TPvWhhslIy6VSzbT
X-Gm-Gg: ASbGncsCurb6kLUuIzTKlKB9zePEJ4ka0/aUCAtL2OHdit5O9axopC/O7QQ/qRNWw/A
	HyCl8wzzkqnhoV+OMuiyOS/1rnmETNzb9tMYgAmCbej2gn7iTpB8PHhbOYkGcn2iB/6Qb30dwjF
	BQt9q/5WFKuZla6HJ9DZbOfX7R/rXX6sEINcWYzi2WPST7+dVCOcSWF/ILEKY9S1RmAEQOaopTZ
	SzSClxP+g6wyJyAblw0inL/jM4Cys+5mtRrMECIStax9WLM3BVuSuZ+LpX/qN2h67DCgOHIPpsr
	pETszMaVU3otbFZ3LxmZjGUdn00+D5nFS5tiabOfntL6sC/mfA/RHX929DHsgGpOsVy1lLAk4Rh
	vTVJXHtRY+PdhmNco2u1NvL+jJwRyOZ1nC8G0BK+fKwkUEiilFomeo9OGdOv+L8oAEL9ri2Gela
	Xr2onnS0pfDU6LXtqP3oWoYAspIqYuK3/nRRpgfYX9jk2UkN9EDGXCZMEx8for7lvWMPUh1Q==
X-Google-Smtp-Source: AGHT+IFbURpoPAGpRiSRMFRlNznYmuKDxQh8Pl5N/zDoikMkUdg3+md8B44MHCxo/RRseAvJFoFKhg==
X-Received: by 2002:a05:6402:4311:b0:63e:1e85:6e71 with SMTP id 4fb4d7f45d1cf-64044197c7dmr5303481a12.6.1761821455320;
        Thu, 30 Oct 2025 03:50:55 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd0c1fsm14567185a12.37.2025.10.30.03.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 03:50:54 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org,
	pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3] fs: hide names_cachep behind runtime access machinery
Date: Thu, 30 Oct 2025 11:50:47 +0100
Message-ID: <20251030105048.801379-1-mjguzik@gmail.com>
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

 fs/dcache.c                       |  1 +
 include/asm-generic/vmlinux.lds.h |  3 ++-
 include/linux/fs.h                | 13 +++++++++++--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 035cccbc9276..786d09798313 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3265,6 +3265,7 @@ void __init vfs_caches_init(void)
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
index 68c4a59ec8fb..1095aff77a89 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2960,8 +2960,17 @@ extern void __init vfs_caches_init(void);
 
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


