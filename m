Return-Path: <linux-kernel+bounces-877838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FAEC1F2A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACC93A84E4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0C133B955;
	Thu, 30 Oct 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpfrmsiV"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1061C311944
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814808; cv=none; b=rNbLAVD1VpAFjr4vJXyfWzWgYIu2js1+HIC3HdId1XndH03uiUo22mzzBjwxiaKRC+FxxfmFii4AGwh2XAb0MsmqK/7OYXFCVdUQ7Dl1XEbymU1HAP33Smr00kswYSv1zCjnWjZXt86RKDXOJBkjpyYqMX1iPX+K1RASxphogVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814808; c=relaxed/simple;
	bh=L4OqF4veqjJRfD75vtvwH0IaU1PIwn/jrpz4y/4KfdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qTZR+ycs1RvCCXp9SWrtDLXtX4K1JvFFfWQordL8tGiZgveSJWzKQteEOflg7OdIT5hNh935ebn3QggJLCGyB17Hs8pB6VS6myVGjM9stDwkTpkHaXxom5xLiNjirVtWNfOaejgbzmWfxllVWqq6ECsQMlMilY7m03O9xf8fVik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpfrmsiV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so105284866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761814805; x=1762419605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P0+8fO05/PuCO9OoMUOz5f65CPRV2XshMkV8o8v782M=;
        b=ZpfrmsiVYEZe/B8rJhOqd6EVay/zlhXos4vc6N6XM2sSSvHpCI2B019oyZTRY8TkNx
         m1F65vzXxyPPKkNn6eUUKljL68qFSubXliQ7WmiJZG9MgVmW1onJPxijZG1wbDiTCG42
         Q5A0no7rh3Qmxyh1t8alY5z2Dh27Pu8tSKl6qrUxIgmm6/TAu2dyvWeG6apm71vO4vZ5
         Ympj0/k74JSRqXIRbtZSOc19qs9UVlCmd8G0lSVag7oZjHYGIh6n4rp/R9NXhPhZKo56
         kwkoKab/F8FrQF/Jm1/uzksbcE5fBiwW5PZParfh+bYLOTHK64aad2l6qcqtrkPbrvxR
         obZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761814805; x=1762419605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P0+8fO05/PuCO9OoMUOz5f65CPRV2XshMkV8o8v782M=;
        b=qqkvngNGoLS8H5qZmdgHFTss57EbdAy0y+96ez8RHdNCgSVhyyICo4YBbz75vg7QN7
         UdVZWW5hERLKJTTI5r1YeHkOznIM2F9mo7z+HEqHRwCrMoRyqbbhqoaQP1o5+Rz/keli
         1LKm67C5hmOANtbzvkkxNkU2qCUOxN5RxIi8iZLDnmYe5DpgV0r7nBOQFVlCgSC41FbX
         2PPi5zegXLrqyG1E9YJnJ2yTTTuUGUJDx9G2+zwpTyquYR+KU9jqn8etyPx+mLVdC8KW
         jApKW1/ovLDjz2jvaRFuhutFPEdIcmSuCB6wSIQFO4iYiN5HBWGLOBKtEq3SAij1cdBO
         Hclg==
X-Forwarded-Encrypted: i=1; AJvYcCXwc7opb6R/zTvUicieeV81EjeL7IUCv4nNtPFgSaxBMF2BBHU8+MJ//EjHFju2XOU0MD6Y59zYIeqgnEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/xIo4UouaopCYH6ZBDkgo0h5KFdN9hmHKRlEo44Tyjc/59E6Y
	Z+3IAZmjTqz8hJefSm7bUJ7xxVsMw2JJrznVZw3W3wWHXhJJyrjV7TBt
X-Gm-Gg: ASbGncuMWdN2pKMIKRZIJ3YTZqCzRyzwC1VNbra6vaXeCSw4+fBFI24X7tQ4RUuRrRj
	7kKAptM3zV6P1PaHqpLJLG01cZ5uFLkZT3qQEZy8hj+VSU/uhwuv8JtjO00Q2lkWy1MXkVyAkhV
	ihdw7IL3/PA2IHl6L33I14a+vLGb6UES8x2xO86Y/hh6RvEvMHLO4BuJ7lBCe3B2t3dGGL2YLWA
	mIxD71eooMkrVQ+3SdfXe9ybrPCUmn9LBz+XUQ84YEYqARFjP01Rqa47P0cPe7TmbzWhsNZAPXr
	GAyHJWydkdXsk6VjIyNIUjSP5g35dp/SfeBIGLCR/jDJ+OAWzqoV5Gu16cP8Uoj6E5QoY9I71AB
	0a+9iOwBIpQLkML/lZEZKbPbXbjlRj+fRQFvOb/qins7kb9fCGqx8CDOR7yYYrINCsEuDguUB7H
	vrUkavWGmyMDsZFHF8Wt9WCOxKhFXLS3QpnCjPwmBdCKktKrVF
X-Google-Smtp-Source: AGHT+IETnbn5ZI7bAOkJG2PqIFf3VbumGaZSxqD4BZrdpxfKUgB6mVZK6e1kKPBpYaEUFcyabzCN/w==
X-Received: by 2002:a17:907:7211:b0:b40:6e13:1a7f with SMTP id a640c23a62f3a-b703d38ca50mr669744566b.27.1761814804969;
        Thu, 30 Oct 2025 02:00:04 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d854430dbsm1676234666b.63.2025.10.30.02.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:00:04 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org,
	pfalcato@suse.de,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2] fs: hide names_cachep behind runtime access machinery
Date: Thu, 30 Oct 2025 09:59:45 +0100
Message-ID: <20251030085949.787504-1-mjguzik@gmail.com>
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

ACHTUNG WARNING POZOR UWAGA Блять: I did some testing and ifdef MODULE
seems to work, but perhaps someone with build-fu could chime in? I
verified with a hello world module that this fine, but maybe I missed a
case.

v2:
- ifdef on module usage -- the runtime thing does *not* work with modules
- patch up the section warn, thanks to Pedro for spotting what's up with
  the problem

Linus cc'ed as he added the runtime thing + dcache usage in the first place.

The machinery does not support kernel modules and I have no interest in
spending time to extend it.

I tried to add a compilation time warn should someone compile a module
with it, but there is no shared header so I decided to forego doing it.

Should someone(tm) make this work for modules I'm not going to protest.

Absent that, vast majority of actual usage is coming from core kernel,
which *is* getting the new treatment and I don't think the ifdef is
particularly nasty.

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


