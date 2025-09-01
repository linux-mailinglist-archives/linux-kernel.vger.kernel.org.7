Return-Path: <linux-kernel+bounces-795316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4246AB3EFDC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87C71A84D88
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35CD274B34;
	Mon,  1 Sep 2025 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gLK6PNaB"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219BC272E54
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 20:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759833; cv=none; b=pCbSAd9GANaXsfveb4kGobCb47gHcrXdeFy8s7zvjBfWCZS0yaOJRF17+m06ir16mNqCXMHO3skx2ZAMYDq0fegtLm85CGcWVYen85Uh0IB9YLR1v0/1n/RdH+LQhfuSux91dbBUmx0X8OSRaedcfXLRz6z/a6p19L0IHrHw6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759833; c=relaxed/simple;
	bh=t7XT6CEbh7zjmSeSWCr8ZD1olx5I3kyEJDSmUA/OyVg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V68KGMujazWyUQ5ebNxV7J2j5GmcE0CqMiLRGOfV3GWwODPFnY+xX5LBDRc8CF5GoVbqWhu4Msm9wrtYzb0ZAmbEv3VWZ+7hkeY4KHdL1iYFj6R7etHFF+Ducjny3rwfMVgONN2d7Qrt0a1afCV+24w3kaqSIBQ0bPZO/T89Wh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gLK6PNaB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7322da8so918598566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759829; x=1757364629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tn78QatM6psXy56nBwVEP8sZrX8rAS66Lkst08QtRU=;
        b=gLK6PNaBOzEjiJLFIBBwG8cqcduLvvio1BVX1TRz97HZpLz9lDaGp6o0CD3qN/XB0q
         o/4OqHjiotjvrZYa+wf1FTUJ8T65cXLA2ScYnw1k6ZfioDI0BVxJMkB4l2BCYUDrINot
         rmGggpiREPYta3Rs+GBXRkuEORhN0RuXWt76fjtcuZwGzdUSA40Ub2CnGPEY1pgVwIwy
         g3WN3zz1o1T4EQhtfHqnjvl4hZSvCvSp9sAY7YPaEFPIITppvKBoXQTFmhX4Sm0Diq1/
         Kue/GBW55svAnQzp1ap83FKsFfc/YTmbN03CxMqbS5Bk4md+DNIOT2bJHkpTTYkEtN8w
         9Eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759829; x=1757364629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tn78QatM6psXy56nBwVEP8sZrX8rAS66Lkst08QtRU=;
        b=Uq0tJyE4yWvTpmXLnNql+LwdCr11rNui8Oa1pf+tdOHlErawJEIA3q+TKkNAdc5U+v
         FzMIo+drsxvG3Qew59GzG9Iw7oMZIbZFDqpsPZXc9b/BVMKz0fgsfwfQG1LXp7hsqjOH
         pbXeK50ZxNH/JDQ70/PQjwrXKk9b0h8lVdjWYV3Z7AU5+XBcb9wKh4vWyiVQ/zW1Amy0
         rQ8YReWz+p2RrdLybN6v1rmv6+tNPBUCFS7y0sme7j9S6MbPdom7+Oc3sFOcc5xMW4L9
         jnPcciPtQ196PB+ai1NIALBOKJlItHr1PA6FCatAwcLLB9uOnfxaCqghAommg8PEnJEU
         mXaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSfilglJaHXp4uwQzlNobwEPf3A9Vep9DDSzKLhJ+4WgWZTSytWKrs3YLveDzYe/p/vvzlbYUy1CCWT0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gA2QZK/B8BPbFHIRn9AAne6kY49jffrC90iQ3tbvuglrAhUH
	QEfkeS0uQCWnKLImXtCNeRgmI863uvwVJmAdude9b6k6fhAzVQSvKTjyqeo3pSjv2Wg=
X-Gm-Gg: ASbGncsnYmBB79V5QqYy1ijSyTPTWfqEkOJerWDw456Q3+jnW82QNrKxdN8lpi1K5Rm
	R/yFFPzoRGYHtGFZWKr4hvTeRrhh0dgzfbo86UIroKyUKUbT7FQ2naNYxmgI/+sscWf4iLzcf0V
	oBTlyzGeMF6z9k7sX0A6ukJ4SkAqWZbu+S3ezdjXcMV9C6tuXqU1ZModszweislv/qHAfL9t/BU
	StoUM24LsamPMcv63oeH5BVModAeKugwkupDxz2C50VvA6WH8Q/RxCGIbCQn8jKP1FDBty+KCHx
	T4e0kEsGvmcmqlLQWrCf1tItVqZrITRzxeDKvIPWRihqTyZHrnAQZvmX5MYIiV4TbKyOhLfr7cE
	Hwi6O3DwQAwIT2pGgFcGsVQfxFQCMIiOYZ0X1lp9iTueKW5UGacdGDUHQ19GKfhrzM+t5UvICMN
	ibG0lHsW7RlBzIexbIQB3zu+uwKse6AUIo
X-Google-Smtp-Source: AGHT+IF8f2IkqJ53snw7rUXbJM+rbFqtblA8YnCowS1e50uvKMXTh+/K+YqxtlkXHOf7uiwvUXJSGA==
X-Received: by 2002:a17:907:1c81:b0:aff:a36:e6e with SMTP id a640c23a62f3a-b01f20c705cmr970127566b.57.1756759829377;
        Mon, 01 Sep 2025 13:50:29 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:29 -0700 (PDT)
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
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 01/12] mm: constify shmem related test functions for improved const-correctness
Date: Mon,  1 Sep 2025 22:50:10 +0200
Message-ID: <20250901205021.3573313-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We select certain test functions which either invoke each other,
functions that are already const-ified, or no further functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       | 8 ++++----
 include/linux/shmem_fs.h | 4 ++--
 mm/shmem.c               | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cd14298bb958..18deb14cb1f5 100644
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
index 640fecc42f60..2df26f4d6e60 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -275,18 +275,18 @@ static const struct vm_operations_struct shmem_vm_ops;
 static const struct vm_operations_struct shmem_anon_vm_ops;
 static struct file_system_type shmem_fs_type;
 
-bool shmem_mapping(struct address_space *mapping)
+bool shmem_mapping(const struct address_space *mapping)
 {
 	return mapping->a_ops == &shmem_aops;
 }
 EXPORT_SYMBOL_GPL(shmem_mapping);
 
-bool vma_is_anon_shmem(struct vm_area_struct *vma)
+bool vma_is_anon_shmem(const struct vm_area_struct *vma)
 {
 	return vma->vm_ops == &shmem_anon_vm_ops;
 }
 
-bool vma_is_shmem(struct vm_area_struct *vma)
+bool vma_is_shmem(const struct vm_area_struct *vma)
 {
 	return vma_is_anon_shmem(vma) || vma->vm_ops == &shmem_vm_ops;
 }
-- 
2.47.2


