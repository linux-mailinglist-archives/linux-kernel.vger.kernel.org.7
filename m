Return-Path: <linux-kernel+bounces-758544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFB1B1D0A5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C7F1AA31A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3205277CA1;
	Thu,  7 Aug 2025 01:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Ssc+rCxL"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93A23506E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 01:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531131; cv=none; b=bt0TEgo7B6JDdordDyeQ4BZsOX6lMJ/lrMHtHzFFuTNI7SVCQ2jpGjw2oDW3i8eDFY4tXD5VMSrPydKUUF3lMw23SvKCFxIK/q4qGIw8DYl4faYPngg2XBmmMAkjL2up0ieeKVbFfpLyoOoRImCHJfyE7bx+vUY2hQb7W9RHHbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531131; c=relaxed/simple;
	bh=alpPo77l/7pgZG8VakBmdAb8i5nQRPDoWfvaWJcTLlE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cz3dhQUJ7z7N61s5rILgQ+oRp673w+tVskbG1JSB7qPTbzB62yYrxZOAIngsd6QTlTSs0JWiUpChEUnWsDkNNzP8/JikXAfKaT7MhcbpNz1+kKl7b4psWN7nf3+3n/YwcorfC39lWGVp0MIy6iT5lqD9t9TTeeITFsIoK+XUnkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Ssc+rCxL; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7073075c767so6818236d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 18:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531127; x=1755135927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQny4bvpzR8mZbBN1/IVSyxQ9U+JDItGyGw2v+12Jn8=;
        b=Ssc+rCxL+/PekNC5vdpImp4eezZQQXUkesj3lXT7/LRqLT5EuydORJWfACh5Cn2cIY
         YBcBm306eWtSCd6DMYtn8CAx4zwsq1WD/ZSlEakuZyk0n/qkn4VIfvmlDDoKdqDckvxE
         Lh0QJtZiZl2GNLax0IITljlWdsRn20FcbKc0EBpqeTJldwIl59uNYW8QL9Dl+sFrrGkz
         j10+/4VMwzmnNppVZw/zQs9Lgx+ocFg7fbqf7ZozcMRQHeIyHquf6szREDwAALh+8kqG
         /HzRidnV0987oBRaJS5VxBh7mjGKe9LUp/SFKGa27PKa+SyW+BmUghIMRcBnmlx14Hjd
         YeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531127; x=1755135927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQny4bvpzR8mZbBN1/IVSyxQ9U+JDItGyGw2v+12Jn8=;
        b=ScPuPzWLdKXwPCDlg60uTSoPRJyQDOoGAgg3zo8T2hls8gmia12j5sYlJlWSzXX6BR
         9w+41X0byBzQBFjPYgUlUGt6BF9NN63vlP0/gAsqA5zsprdCTPMp9cDXtrDKlkfeP52f
         nIzfjbxvikGbG0oe8xDCqstVC00SWtrEMfjsKerwxUVPviMBtiBlQ9ciEaZMiZtGuwOw
         l4Q4radO+PLyyhheBoN/o3LOYLWMBuJSkTOU1c6VP2HTX7CoNQApm57gKj8uug6Eok54
         x+ZhVjhAOlGwbxnuXp14iy5qo5jivX208C9SZxIjQzvV2cijszZjQUt/86fUytCW+USa
         j+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhCYbXxlc/NjizFvGRFEIkVGyJBsXOJNFaPPup5DkIK2ZybagZu3KHNaBBguG8Fs+XL5Y/PvedTrkl1mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEAHeI8sCVHMTfAtlxmGGK07v50awG1fnjZ0c+tAf6JjoeZBMe
	4AAXDd6trwZDUzMFhsM/8OXAq2jTOJtR1oPKlGSDLSvg1bVIdEaQAEQcjEv1DmIfncg=
X-Gm-Gg: ASbGncuaX8jzyMdR1n8YV/ywhrc2g164iMSLBOahxZlxHoKnAbFilM7hr/BAFFoR527
	G6f2IFI8zeLafpV8fJ7T7K/LP5uPCqv1WbzxDnw1ZQAjOcG2XRqMl6QRrkNXXGjd5epxqhKsM1u
	Gvx9XrJFOa3mtHtfqT8Mtm7dBVmG5xwRLUkez+n8Nng1R2/3eaG4ZeaGx9Qvpr0OS1cWVm8pcB0
	vezfoRtTMHt5WNjKyg379Oj4IQVsEMcNRxZ2YLYAVH36XsNURQPW9eP7J1uWIj7P98/1kmzLNPJ
	HbzhDgJc2p09cm9RGT4NjOYXGQmh+pH4vAz5nee+IREEK0ndVqok48EXJA96OWJr391gQkhhUJI
	GySHP8Uif+S1vvz/z9plS8AB004COOOWnwTlN6eRlxAT7NEwK5Vw8l5ngsf8fCDgLgqmvmVJFbs
	y+jnB7k8YYL1jP
X-Google-Smtp-Source: AGHT+IFqMT0HUt9lre9uw9F3rpS7vpTxQLIi22l4S1gL4FMPIdcVTcCnIgm3Am+TvXdeRU0xrWJBwQ==
X-Received: by 2002:ad4:5761:0:b0:707:5694:89e4 with SMTP id 6a1803df08f44-709796c75b1mr72234786d6.47.1754531126973;
        Wed, 06 Aug 2025 18:45:26 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:26 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v3 27/30] mm: shmem: allow freezing inode mapping
Date: Thu,  7 Aug 2025 01:44:33 +0000
Message-ID: <20250807014442.3829950-28-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

To prepare a shmem inode for live update via the Live Update
Orchestrator (LUO), its index -> folio mappings must be serialized. Once
the mappings are serialized, they cannot change since it would cause the
serialized data to become inconsistent. This can be done by pinning the
folios to avoid migration, and by making sure no folios can be added to
or removed from the inode.

While mechanisms to pin folios already exist, the only way to stop
folios being added or removed are the grow and shrink file seals. But
file seals come with their own semantics, one of which is that they
can't be removed. This doesn't work with liveupdate since it can be
cancelled or error out, which would need the seals to be removed and the
file's normal functionality to be restored.

Introduce SHMEM_F_MAPPING_FROZEN to indicate this instead. It is
internal to shmem and is not directly exposed to userspace. It functions
similar to F_SEAL_GROW | F_SEAL_SHRINK, but additionally disallows hole
punching, and can be removed.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pahsa.tatashin@soleen.com>
---
 include/linux/shmem_fs.h | 17 +++++++++++++++++
 mm/shmem.c               | 12 +++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 923f0da5f6c4..f68fc14f7664 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -24,6 +24,14 @@ struct swap_iocb;
 #define SHMEM_F_NORESERVE	BIT(0)
 /* Disallow swapping. */
 #define SHMEM_F_LOCKED		BIT(1)
+/*
+ * Disallow growing, shrinking, or hole punching in the inode. Combined with
+ * folio pinning, makes sure the inode's mapping stays fixed.
+ *
+ * In some ways similar to F_SEAL_GROW | F_SEAL_SHRINK, but can be removed and
+ * isn't directly visible to userspace.
+ */
+#define SHMEM_F_MAPPING_FROZEN	BIT(2)
 
 struct shmem_inode_info {
 	spinlock_t		lock;
@@ -186,6 +194,15 @@ static inline bool shmem_file(struct file *file)
 	return shmem_mapping(file->f_mapping);
 }
 
+/* Must be called with inode lock taken exclusive. */
+static inline void shmem_i_mapping_freeze(struct inode *inode, bool freeze)
+{
+	if (freeze)
+		SHMEM_I(inode)->flags |= SHMEM_F_MAPPING_FROZEN;
+	else
+		SHMEM_I(inode)->flags &= ~SHMEM_F_MAPPING_FROZEN;
+}
+
 /*
  * If fallocate(FALLOC_FL_KEEP_SIZE) has been used, there may be pages
  * beyond i_size's notion of EOF, which fallocate has committed to reserving:
diff --git a/mm/shmem.c b/mm/shmem.c
index 8e6b3f003da5..ef57e2649a41 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1329,7 +1329,8 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 		loff_t newsize = attr->ia_size;
 
 		/* protected by i_rwsem */
-		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
+		if ((info->flags & SHMEM_F_MAPPING_FROZEN) ||
+		    (newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
 		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
 			return -EPERM;
 
@@ -3352,6 +3353,10 @@ shmem_write_begin(const struct kiocb *iocb, struct address_space *mapping,
 			return -EPERM;
 	}
 
+	if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
+		     pos + len > inode->i_size))
+		return -EPERM;
+
 	ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
 	if (ret)
 		return ret;
@@ -3725,6 +3730,11 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 
 	inode_lock(inode);
 
+	if (info->flags & SHMEM_F_MAPPING_FROZEN) {
+		error = -EPERM;
+		goto out;
+	}
+
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		struct address_space *mapping = file->f_mapping;
 		loff_t unmap_start = round_up(offset, PAGE_SIZE);
-- 
2.50.1.565.gc32cd1483b-goog


