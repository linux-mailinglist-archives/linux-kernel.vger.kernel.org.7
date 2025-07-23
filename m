Return-Path: <linux-kernel+bounces-742749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F515B0F63B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027055869D8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C13C302CD5;
	Wed, 23 Jul 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="LVSylLjr"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEB82FF474
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282074; cv=none; b=rjc80KOeKiQ5xqJFtbYmTX+0sqRUkJX8ZUj/g+fOmUhYWJ+CS1XvnG+xaKec4ErBZvd9TJ36hB56TaGXbqCS5MEApg5X0GQ+Q2XxRqaSUg2H0RK+ZFAK/cOIfp2jsHRDC5JanB8zOVm0nyijTXU/aseMb8EQ/NomHqammt1SiMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282074; c=relaxed/simple;
	bh=XdAIwDQk9O8+e27TqOcTJB/ZHlzR4zDdUnKHElnpGKk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGCi2UU9vYmbBNUojoPPWVm5w0YZLxXbfIsdpCYhg44GiJyP/tjSxjOejNhn2931cI5T8dAnA7xIF6QBGP7wHXiYUrjrSMIJRqgRezafQBw/kbPV/qzNB8oYZLj3I3h3cai/iopIQ5ZrmcWNFQJEKdACCzy2Bh5w/DwXvkaRwd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=LVSylLjr; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71840959355so27367b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282068; x=1753886868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=po25YEPvXRrTuFLL1nDXhv73SfufZ4T7e/xtjD+elU8=;
        b=LVSylLjr2ZxFjIaHssw6wLCghfI2bDo8oKymdDfL5NC68rbnDiJqjPGgnTACsmXUYv
         rKpXyjTbKYvhrR8DMxGZwIeMAWpOyxnf8VVp1IJ7rIqPdm0NI+LT7vt2Kekm/WxZw5qB
         sxtnOwJXoFVrjHVNHv3L6QPM3vRnoRBUgN1VwzZ4B+LccRuz7ex9ABKBCgcAv5Li/Z9P
         xuMW1NoPiGvqLN4e09NHGhxNpj2TdRPFXB9scJk5ZQQVMyJOBHoVz4jBJ8Ysc3nHOt1y
         9D2cTHFahp6KzgU8QS0kk52apndPb/ytbEd63P4KvoVcm2cvJTJuqXoDYwA9hhLRErq+
         OYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282068; x=1753886868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=po25YEPvXRrTuFLL1nDXhv73SfufZ4T7e/xtjD+elU8=;
        b=kaE9CLpqb9PQqv5ySalNwaGKFnU95KRkeweGlM4zoA1g7JLarGN1uyCbo1ozaZA5IK
         2+RLhdmw8v6qUJvVgMt29C1gtPFkCF1WcmeKpGUJuM+Xu86otWdm5N74PMEMQ4449d4V
         qMzMtRMc0C9Dm7y/spQ7n5JXKnV59nsXAbHtPwFpVUf+ytu9c1Ons+unHWWZLO1lemOU
         HwmG0huW8bvi34+w/vkruLjheSrCRc7ZWvFn6iCVEhOtVyPrXwRGr+ep83oqUm+eTx5w
         1HlXjerknU9BEKo9/neoxHM7FdRpD6seIXvnLSHXd7mIHpExO3je8d81vjnEACLK34Dn
         HsLA==
X-Forwarded-Encrypted: i=1; AJvYcCVf8u0NhPi2QrPuUXgZ05ijd/BeyEoYJ03aP8QqLta8vWUICTgoQkjxElWBUs9/r1zKyWS1cqhON/NEtT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBDpR/saLDZ6cvt2i1EipwjFXDGVinHO61U6BITW3B9elyPK5
	nFuGXUPXy1OnPpOnhzFv4at/xMfKv3PbNXfoZovYHYMmwtldeXXCLULNJF33b0yDMJU=
X-Gm-Gg: ASbGncub5mwmIQzs0K+i1K9LjSn6NjU2hJhULIwrpbARGcOwtLczMuGcQOB5XBxBO//
	X/UQQXzRjemHqbgyv9XvICfDAlB7LQiYg5sO5A/WYntxDJKzsPSVfEaCFzlz1TlA7OKaKvBMZ0o
	KC6w/GUrudxm2rkARJPkSBiEbZHBd13CwkTAKitAJc4J76SdnC1X2YygEIaURFodozVJPUxw15o
	9nWW5h6bfA6nnKPSg2emyoIphWzAPT8Wy9WR7x0Dkp1QPjoffoZv3IfRKets3eWhtpU/AJxi0aY
	MFXDJwBlddbhNkHxiDhTfzmpl5z/QIJFAOIl1IGHs9cghA+hPSEEqN3Bmf+8T3QebqKf54mz/ze
	Ln8Jyg5qpkziWD7K4mwmq9XC4t+1W4V+MIn8aI0gGTdzFzyVnczIDvd6Z1WrXxw/VmPMF2tMfkH
	AqfMCtI0iczI3jYg==
X-Google-Smtp-Source: AGHT+IHUEvrhwYQb+PkqEHsQ9NVaBJx/HXsqV9Ci/9SKu6SQ4+1qmUQGxK2puIL8Ml0NTVfy05s2Ig==
X-Received: by 2002:a05:690c:620c:b0:713:fe84:6f96 with SMTP id 00721157ae682-719a0b8f1fbmr86322747b3.14.1753282067864;
        Wed, 23 Jul 2025 07:47:47 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:46 -0700 (PDT)
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
Subject: [PATCH v2 26/32] mm: shmem: allow freezing inode mapping
Date: Wed, 23 Jul 2025 14:46:39 +0000
Message-ID: <20250723144649.1696299-27-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
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
index 578a5f3d1935..1dd2aad0986b 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -22,6 +22,14 @@
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
@@ -183,6 +191,15 @@ static inline bool shmem_file(struct file *file)
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
index 6eded368d17a..d1e74f59cdba 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1297,7 +1297,8 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 		loff_t newsize = attr->ia_size;
 
 		/* protected by i_rwsem */
-		if ((newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
+		if ((info->flags & SHMEM_F_MAPPING_FROZEN) ||
+		    (newsize < oldsize && (info->seals & F_SEAL_SHRINK)) ||
 		    (newsize > oldsize && (info->seals & F_SEAL_GROW)))
 			return -EPERM;
 
@@ -3291,6 +3292,10 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 			return -EPERM;
 	}
 
+	if (unlikely((info->flags & SHMEM_F_MAPPING_FROZEN) &&
+		     pos + len > inode->i_size))
+		return -EPERM;
+
 	ret = shmem_get_folio(inode, index, pos + len, &folio, SGP_WRITE);
 	if (ret)
 		return ret;
@@ -3664,6 +3669,11 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 
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
2.50.0.727.gbf7dc18ff4-goog


