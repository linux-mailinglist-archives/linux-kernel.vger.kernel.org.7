Return-Path: <linux-kernel+bounces-876293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2E9C1B28F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB6F188CEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69773241673;
	Wed, 29 Oct 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm+5stKC"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172F21DE8AD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746146; cv=none; b=ge0/2l3vULMIH2HEsSjLD+xR8GPaLfGnCx5qxfEglgC3IMijEIzM7M7I53ao6mNh+lbGIW0KuIHrvYtoxogTfC+3DdoRnzZrflktc3nIFb05Xg94ye2Y85gCjJ2HZyvLrrYKfXJOq+T+6OYSCT0uRVmivr+3O51DLlraNp0SJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746146; c=relaxed/simple;
	bh=kDjiYYa+XoKtrZgKJjxdI4my5UeWml8agUmpTGGgvQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2wc93sKJkHjX1XASnBHump9zqUutPJskbtCbwqeMUQstU55iiNnHHOtf+IzEU2h9jBfkEEjKWX1UL6b7dQTziYjM+m4s/VNAS+MfsTW8slGxAs4zLAlYpAcxbAyC31CerdeLLfkLiBe98wqZctFGC6z4Il6kPPWxVn2u7xsHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tm+5stKC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso5757606a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761746143; x=1762350943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IInKCL3RDPRCGSLvZWACn/czzIIKwfck9D0q9Pkvxck=;
        b=Tm+5stKC4jStX8LWJV6ob8xXcVXT3OPf6isMYwc+r53zVEoP6tEEx37NENs3EPNlRG
         QTumnQYeTXYqo77NjtoKpp7BfffV3mxkynnnpbryh+C7Nax6Gvcm6ACmgfwKZ4RkSR2A
         Pgb0rcUUhj3c4HahEJFvo9MCcAaB38h8fA+a4oDvo/YEV68m8nBeSyTpLKtbreXsIqUD
         2efSH+ttZizbQDxDm1tUnfbf5eVJ4AeC74zB4zngz9EjtNQJk+SVm1NuSJ6IXa/DVKlm
         6oqfpLu69btXiSyj4I2WLDd5tLFp4OSpNxglEYjXBf1iv3f9NIdO5jNl64hjCx+dC55e
         oUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761746143; x=1762350943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IInKCL3RDPRCGSLvZWACn/czzIIKwfck9D0q9Pkvxck=;
        b=Wl8MbMKogF+KyXT1lbstX2HV6OvL/CzwaPv+0/UEFDqkVklmkEEw7wGC2SA2kx8pZn
         PDCUkUpy835yxt66YweEnMYW0pq9r+QFFURdDf1b6MKF9egVCnkUgytEbKgpv4mzOXEk
         vVGdaALdNbSyRn1gAEL+hG410ZkTqtasOvQhR882li110+ssAo7VAdgOgOFsvIhsFvbH
         0qRF0HA9Hj2cjh/w2ZTeEWQ7RNlrtbd7O6ZdqsJxO49F47RhrrxPY0JT1ud3rSGUo25a
         maiSqcILnfpKhxxVEMZ6XvK7ZGa9fJkS4eXzT17VtZgC3fmJMVCnLJDygblfSWYr1bw1
         pXjA==
X-Forwarded-Encrypted: i=1; AJvYcCXfPRD49tGKR3pF4X3I4stfM1kGU3CXKpKvJYdgORff+CPxda6NkthaubfhSe24tWNfRoEAKfxRyKNzAWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEGTLUkixF23ZDUSivODSB8H/hNjMBCN8ZjuQs0DRNjY7vKTKz
	ekkRckehMdQ6Tu+7joesaWf1jqKDFZysTxj+sLzPCHRFkvhSkPl7dinS
X-Gm-Gg: ASbGncsy2+Rdd/5KkWlqs1g5lFWe1E2+5kHyRnfj7mlZjA5NqkqXkkUactCpvz59qJA
	QaiQbl7i/2ivYcr1+1hfS9I0g2o9SxVtHRg6aoQ7yym/jUq1EguR+ZKmwo8Xrvzql43t67f4Aeo
	66UsDUxm8n/x4OJqv/4EztQ7qrNbgaDbTXeOnAkL6ng0GQqSuTkS5xQuZPo7fO9qbDl2L/xZGL1
	f0CF8KZXjUfcyhgVL+CevMGqNGC7zC7rivXJnte2EFSIwGR6nB2T037DStdbxnH2S7bhW0bMP6l
	Shoena35qrusXHHIzjFq73veCWG8EAywd7XCMI5uOeH03yS76OP8GPbrPjLjglgJzN4dnqLKUFv
	owB3mPyoxszUDavs9z3vOP3Dae1U69IBv6kcUi12vcVonjFMJWqGBpYzCQaUzyax6UeVhEkKW45
	DG1DjthlGQ2Jgi+NCFh3CGAgzl0vKMkDeOi6MVHUeOssd47km3aIV6XkzrTgE=
X-Google-Smtp-Source: AGHT+IHGF8rgk9jMOle8qoaOj44dzw/iGjaOwXckf8wSylKdB6FkqWuzCorlot8CB5ukyGmS0ZQuNw==
X-Received: by 2002:a05:6402:2353:b0:63c:3c63:75ed with SMTP id 4fb4d7f45d1cf-6404425113dmr2611515a12.22.1761746143277;
        Wed, 29 Oct 2025 06:55:43 -0700 (PDT)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef82b6esm12043982a12.11.2025.10.29.06.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:55:42 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [WIP RFC PATCH] fs: hide names_cachep behind runtime_const machinery
Date: Wed, 29 Oct 2025 14:55:38 +0100
Message-ID: <20251029135538.658951-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All path lookups end up allocating and freeing a buffer. The namei cache
is created and at boot time and remains constant, meaning there is no
reason to spend a cacheline to load the pointer.

I verified this boots on x86-64.

The problem is that when building I get the following:
ld: warning: orphan section `runtime_ptr_names_cachep' from `vmlinux.o' being placed in section `runtime_ptr_names_cachep'

I don't know what's up with that yet, but I will sort it out. Before I
put any effort into it I need to know if the idea looks fine.

---
 fs/dcache.c        | 1 +
 include/linux/fs.h | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

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
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 68c4a59ec8fb..08ea27340309 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2960,8 +2960,9 @@ extern void __init vfs_caches_init(void);
 
 extern struct kmem_cache *names_cachep;
 
-#define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
-#define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
+#define __const_names_cachep	runtime_const_ptr(names_cachep)
+#define __getname()		kmem_cache_alloc(__const_names_cachep, GFP_KERNEL)
+#define __putname(name)		kmem_cache_free(__const_names_cachep, (void *)(name))
 
 extern struct super_block *blockdev_superblock;
 static inline bool sb_is_blkdev_sb(struct super_block *sb)
-- 
2.34.1


