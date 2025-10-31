Return-Path: <linux-kernel+bounces-880749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED3CC266E6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3460188C366
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625B6309EF6;
	Fri, 31 Oct 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FF9uIm7E"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F83306D20
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761932562; cv=none; b=Fz7LVKVSq3AzBfG8TQc5hU6DYbGroe9Q6OakkIpBI80azat1wd0p/C7zqMkAbSxmi04QPO4AGjunp6LCcQ0zSm/eqiSsPxcMQqDKOjoRJ8xazKifJbydUFXLmez1IuVIMxe5uDcsw2wIbm8/vZ3JgEqRr4stkMSmOlCl/3+05sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761932562; c=relaxed/simple;
	bh=Vi1AK7tDXHNu8+6GtOYCB2t8PHiERIYxjsDeSZzFi74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOztZHLLx9jsMLmJS8K7qeZJfvMNK6XlinVbuRG/FpVVuw448bhvITFWsGGQCh8VvGkWdpSsIFT8U5wxIk/NagfcJytcPfUGoC7m74Wnlct2J0wnvccL0jeExXtW8EqOtfkZc4HEErvAH1JADthL2Hnngva2zr2zYS72d8MM8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FF9uIm7E; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475dc0ed8aeso17029915e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761932559; x=1762537359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UIJC3NBM2UMTqk3PoOY9/nc0pjUoYvTCpDCDkdmqZY=;
        b=FF9uIm7Exou+2N+0e6oUKT2+SbjNAFwYdQud0Kh1eGQm+XgEkQcMuoKI1GaqUPBGyv
         ziBxWld/spuW4Jdm2VN48+6iKdL6xsY6u+QjZQ1FignyeNyVFV3wJojvInDe3XEzH1A7
         Uo6mXVs/hapkYK5yR4gcId3Rr/Ep7nPR07r1dWbSj9xErw6yOpDnh3MpD9hMAB+EToCF
         Sv+LccIEy7CmmNJs16GST6JTB7Z5EGdlLsX0z9NbtVXsLgQ8yR8dNCElukaDww+AjdwR
         FLLzbTVvJUYis/9X00l6zuE6Yneyi+V7aalio+TzfNVoB/7CsAq4kVh5RzVY1HRvlIx/
         boGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761932559; x=1762537359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UIJC3NBM2UMTqk3PoOY9/nc0pjUoYvTCpDCDkdmqZY=;
        b=dPpkfioQV2gpP7FWCgsAN/uSkgbLe2saLnAojBeLM26ZzlXLYdSClozTNWLGbHcC62
         WdkPXULj4xtQxB6IhbuOZu9CeVotDM45ao6IBAriyYrXKYeeZKTcHdeUEu2yL96ruxzm
         MsKJ1zL/xbYNHATfchTfeTsw02O6KvfLHuZqV+zU3/Xi8fgUkp4snMLGu8/dCN4OawWM
         fzfBW0SfJS+tIhp9ZeykgXY1IwpaOIAbuWdLrZIt/WWJFOKnoLPWE9MAhVA6FoSq31zK
         rYmySMoEZOx3pBFQ+GrqpQt4+qVOGeZj54C6V0kZ4t/6P7WXWoh54mqefVG16Kralc9v
         7RHg==
X-Forwarded-Encrypted: i=1; AJvYcCWk7TPney/UDNmvmhqq5xAnJz0AClKCC2vciy3h5zcU5SspgQCKL3GS/eD5WZmf+yKUPCFV2FakgvWBMtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqi2wXwY+w4d9lWMAE5OYzXlC8HEGfFuG93RmIyuocW5OVPuGr
	zw4x56P65fiy1GNQW3qaw4M4d/czVuTQZwx5v9UKpwn0+lpZcQWErf28
X-Gm-Gg: ASbGncvhfsFc5jv3HafqaDUAeWmyR7UVJ5gW+V/+6597ucjKeAacrfFzB1hIFUyY8ZG
	WkSMh8fvIeTCUt+SDc/vfB39TNEBByU8IjDaggouB/MbLaiuxCmaQg5jeu2EDRkjQSIiaEOESd8
	i4cH1ty23svv1Z68QQu1L63xrw6OA6ZxGfNzNLW8UI7NFjVsVZJLGE2snIyQYve2/iVAKWNVcyb
	oEvWe0kkSX49bWtys8UU3WR2np75pdCKKHfznTmgzjgX+5bmyBGJGt7xTAogWO0IVFjW5RfzsQi
	tXELpNTbakuUgE0R2dD7WDnl6JM0HazCAyK9S8kCT+bPQ65IpMGZR5mKilyVhhNuFyU6z9lb9ac
	PkLuiagIC65mK81cz5LKY6Bu9wMkgnX7r9GdpXjRykw2SNB3lotQQTrm+Jt0HoaQvImtsx/ShOM
	tCAKX9gOwIMF/WhH+0CRqrBC1wn+kyHs+Fwa6Hf2id24VxuQJSGmbbxxNcdCkprZoiCcDKow==
X-Google-Smtp-Source: AGHT+IHibtVJIWc/K0mBwQe+U2KmBQDQucGno7lWKNr4elHe+BJ6Gz1X/k6uEZugfHrHL+Io8kpDnw==
X-Received: by 2002:a05:600c:8b30:b0:471:15df:9fc7 with SMTP id 5b1f17b1804b1-4773086d57cmr36912715e9.26.1761932558871;
        Fri, 31 Oct 2025 10:42:38 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c53eafbsm6728865e9.12.2025.10.31.10.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 10:42:38 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: torvalds@linux-foundation.org
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	tglx@linutronix.de,
	pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 3/3] fs: hide names_cachep behind runtime access machinery
Date: Fri, 31 Oct 2025 18:42:20 +0100
Message-ID: <20251031174220.43458-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031174220.43458-1-mjguzik@gmail.com>
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The var is used twice for every path lookup, while the cache is
initialized early and stays valid for the duration.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/dcache.c                       |  1 +
 include/asm-generic/vmlinux.lds.h |  3 ++-
 include/linux/fs.h                | 17 +++++++++++++++--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index de3e4e9777ea..1afef6cf16b7 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3259,6 +3259,7 @@ void __init vfs_caches_init(void)
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
index 947d7958eb72..bf0606ace221 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -50,6 +50,10 @@
 #include <linux/unicode.h>
 
 #include <asm/byteorder.h>
+#ifndef MODULE
+#include <asm/runtime-const-accessors.h>
+#endif
+
 #include <uapi/linux/fs.h>
 
 struct backing_dev_info;
@@ -3044,8 +3048,17 @@ extern void __init vfs_caches_init(void);
 
 extern struct kmem_cache *names_cachep;
 
-#define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
-#define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
+/*
+ * XXX The runtime_const machinery does not support modules at the moment.
+ */
+#ifdef MODULE
+#define __names_cachep_accessor		names_cachep
+#else
+#define __names_cachep_accessor		runtime_const_ptr(names_cachep)
+#endif
+
+#define __getname()		kmem_cache_alloc(__names_cachep_accessor, GFP_KERNEL)
+#define __putname(name)		kmem_cache_free(__names_cachep_accessor, (void *)(name))
 
 extern struct super_block *blockdev_superblock;
 static inline bool sb_is_blkdev_sb(struct super_block *sb)
-- 
2.34.1


