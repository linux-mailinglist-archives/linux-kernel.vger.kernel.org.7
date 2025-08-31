Return-Path: <linux-kernel+bounces-793295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5A8B3D1A5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A271793C6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805EB253B66;
	Sun, 31 Aug 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YtAFVxvl"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73663219E8C
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633180; cv=none; b=ggyEfJrexmznEW45ZIbx52IM7opisnzL6CaV179NdaSeFfG9npySdpVQU2rzvdseNOXU9JsIfFsPuSclSmyFX2jB2+4E1oMJD6vBWAIq+yc6gzAYRw3QGO22LRAv2LoC6LXAw+mCBC8WrxDiWp702DhVPCtx7RCwoRLPnk8RtfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633180; c=relaxed/simple;
	bh=JD+RzaExQ6OG9EIN0zTya2+8ASA7RgRp6zJS9nX4PAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPUGx2sXLS1tQe2BIs66lTvDcc/IhM6a6/wLf+8NWLejrxmUJqMafnrtm6tUYfTFLjweWkqita+sYnW2CRvYW2PWGd02hG9sgjfMwaCPbIdHWhf7HyIylmoBv1TxJ+aCNILM9cMm6py+j0jF8sgHDF8irH2Q70BYZr05WP/j+nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YtAFVxvl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b0428b537e5so5128066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756633177; x=1757237977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZGxnQhsC2P8euySzPswvqJrcJH4ogAsIfO9DHwigow=;
        b=YtAFVxvlDNxxxdhA3P9Po5SL6/ooINWn8u6ZhbH8iftLjRIPgg/JcQxjotLQqWpz16
         hHAHp8nNkiU7EBXN0sMPekjZ0Guwud8rCDhMfdW1L73Oyzu2mRqbSPlbKN7IzsgkBtua
         OLvKNFdbAWLujLis2Hk5mQsrs3uVo/9xi4eYEI6oEJVSoPtcWa+CXQmbs2xQTfu4u1g2
         mttR3lYTqFfP8EMQFzgTrHK1P/+9H5pSZ74P2E1xOqpqikRR+17rio5Qj2ikHm3kqblo
         ZL7ASMxDUMifNhi61+fWTlnSPXK0DcXG0sF3mpOorftZ8PNZNafGm10REu+GQHzIblfj
         wzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756633177; x=1757237977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZGxnQhsC2P8euySzPswvqJrcJH4ogAsIfO9DHwigow=;
        b=pMpxb0wNhcmtqE685D60opSSNsv+Mu7pkuDxsSUqleMddhs1jRlYIXVfCpic/f2nNj
         C+WCW/7aaMSfu6q2HVIDO0OS/gmF3RqVy0EewKykkuCZvduTjMZBolDK+jFYDvuIT9My
         Leu68C9HnHFv+VLLRlny+KRpknnCtVKFJ93m3j6SloQeNz35fH+zFSBkFXIhVIvuBTm7
         UAj4FQXVwmPnFNgpjHlNQAPsDEn5SljXRGOx54dGa1bdmPSi9bFHBUZ1/I3nzOr4koa4
         jj2M/yKnrW4pIVpoxoNpG/Xq+bXLuptPSZhk7Vx21UV/f5oDMf7kOLr9IJv65NIfURwD
         KPjg==
X-Forwarded-Encrypted: i=1; AJvYcCUCgJzgxanG6ZBZ9fNzVueo+hamyVBYZVqGhntFZWxY998k1HlrR/NrQTDm3hoof1l8qN4Hh4SFVuqoito=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuWRmo+ZY792g5Kj2o2rXRzupnqYOf90O2Ksa7aCPRLX4Kn+Qy
	mUOdfnNsHbzss5TLFlk4JJJWeEPxXHMNRk3pYfkBxKFT37YyfIj4oHeRW3ZgF3F/jss=
X-Gm-Gg: ASbGncv3q3DG6SzMC/CQscc79kjeej+o9d48PdSdwyafcwf2soY8JE9Ta/zSvlW0EmN
	452oUVHjbqSGLJ3Bmu8SrpqTwQfKgMiQRy22urwbfoc01qz7UqCGy6AwTDURzIlBv+fKJw9A2HG
	6o+Kr+D07k9XNhu3n32icb3KCyf5FG5+l8I2ewdl2lY/pWsHCsmY5z6saEBvrPKjKZV+iabke0o
	8Sl0Egnh98nl1DtQe+zO97x+VkmGy4xD6heodIZgWtT7Yp5szSmkAF/jRc+UUEBcHBQKtWMOHHP
	FF7eT1V40Xw6az2nFfZDitrpslYl77jpY2simVMs5LPVeCb17P5Wtps+IZhiiLhi0Xz/wHnKy/3
	XHZbQoXg+GiXU3LtsDCdWWzSWBQy8dqvaFr6ZD+pzshKMGRSsOo2Wbrl+KbX1qoCvPk+7487PgQ
	0gTOQKA41uhGOot/83Ih2+3rxO92/OQU5G
X-Google-Smtp-Source: AGHT+IHsLsYix0uo6uMedopX+OAnJsP45C6YTimEtUIUmbOP23yVgqxQq1YfVopQwWMRzI83RCvrdg==
X-Received: by 2002:a17:907:80c:b0:af9:a5f8:2f0c with SMTP id a640c23a62f3a-b01d8c9275bmr395699766b.28.1756633176716;
        Sun, 31 Aug 2025 02:39:36 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd8656sm597512566b.56.2025.08.31.02.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:39:36 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer parameters
Date: Sun, 31 Aug 2025 11:39:07 +0200
Message-ID: <20250831093918.2815332-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250831093918.2815332-1-max.kellermann@ionos.com>
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm.h       | 8 ++++----
 include/linux/shmem_fs.h | 4 ++--
 mm/shmem.c               | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 00c8a54127d3..a40a3c42c904 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -979,11 +979,11 @@ static inline void vma_iter_set(struct vma_iterator *vmi, unsigned long addr)
  * The vma_is_shmem is not inline because it is used only by slow
  * paths in userfault.
  */
-bool vma_is_shmem(struct vm_area_struct *vma);
-bool vma_is_anon_shmem(struct vm_area_struct *vma);
+bool vma_is_shmem(const struct vm_area_struct *vma);
+bool vma_is_anon_shmem(const struct vm_area_struct *vma);
 #else
-static inline bool vma_is_shmem(struct vm_area_struct *vma) { return false; }
-static inline bool vma_is_anon_shmem(struct vm_area_struct *vma) { return false; }
+static inline bool vma_is_shmem(const struct vm_area_struct *vma) { return false; }
+static inline bool vma_is_anon_shmem(const struct vm_area_struct *vma) { return false; }
 #endif
 
 int vma_is_stack_for_current(struct vm_area_struct *vma);
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 6d0f9c599ff7..0e47465ef0fd 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -99,9 +99,9 @@ extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
 #ifdef CONFIG_SHMEM
-bool shmem_mapping(struct address_space *mapping);
+bool shmem_mapping(const struct address_space *mapping);
 #else
-static inline bool shmem_mapping(struct address_space *mapping)
+static inline bool shmem_mapping(const struct address_space *mapping)
 {
 	return false;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 13cc51df3893..2f765bbc20bc 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -275,18 +275,18 @@ static const struct vm_operations_struct shmem_vm_ops;
 static const struct vm_operations_struct shmem_anon_vm_ops;
 static struct file_system_type shmem_fs_type;
 
-bool shmem_mapping(struct address_space *mapping)
+bool shmem_mapping(const struct address_space *const mapping)
 {
 	return mapping->a_ops == &shmem_aops;
 }
 EXPORT_SYMBOL_GPL(shmem_mapping);
 
-bool vma_is_anon_shmem(struct vm_area_struct *vma)
+bool vma_is_anon_shmem(const struct vm_area_struct *const vma)
 {
 	return vma->vm_ops == &shmem_anon_vm_ops;
 }
 
-bool vma_is_shmem(struct vm_area_struct *vma)
+bool vma_is_shmem(const struct vm_area_struct *const vma)
 {
 	return vma_is_anon_shmem(vma) || vma->vm_ops == &shmem_vm_ops;
 }
-- 
2.47.2


