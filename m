Return-Path: <linux-kernel+bounces-792295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47CCB3C277
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F321A24DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162D03451A5;
	Fri, 29 Aug 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="c7nyHeOC"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB1C1F4192
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492331; cv=none; b=eQFhRFPnOpj49RSuIBe0ND7PvpJb4qYfh8x8/ac/TIC2giMYQ5acpIJycjEMIXvCvIJkFj3Hm0tJIM6W+pnNOazSR6Pcnl9iHVMByhESiern3lsHZchNLt/kUK2Kl2YwVid1bbvR7GtZxVl1rGnTXL1UW9WFLuevC1pEvn3kXvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492331; c=relaxed/simple;
	bh=TVUp5dA4IRX5BaG9cKIxs0AOGjT7jJ00wR6t0GEzsPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F9rWp2sRxeZk4uAhUA1M6q93ZT2tjqOX+GYyA48icL3/mEhxuiFWlXzmVO975A0ST8PLr0nYnw4+3puoAW1U9JDYsJZu1TZA0RLgSHsP4IebIvjWq6QmHGqTRFGvwb6VYXtoZrpTILbFv2L31IZnrbykw48ziZ/IDkhLwf99cM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=c7nyHeOC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afeceee8bb1so367323766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756492328; x=1757097128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSo01xEtu7GaLlUrg3B9Uz1MDG42fOObUQbcFYUl6Tw=;
        b=c7nyHeOC+fpSQtuLOgLosbb/0XmDCe1vYZStb/pKoZN4Ef3gRLwWLvE5+pLvdgWsHp
         F7Zgnu635GEBKyRMJlcKq9T/yEn2aV7slCEBESuo88chyi+6DExN+5w0AsecrZ56tT/V
         GtJ3xWY9U1aIO7LS9G06ju7jl2e/wsL2GA+v/xoJuLieeZJVMTiPyTCqNtrfqlSkZDBi
         cmGniEBEqIo2JnoSP3u2KrCGuDIDopvVbQet4JZlM2seTsQtl5aMUdUCnag/reIB6fYo
         h0d3HCuxZo9MNs1Nhf9DSRnsc9OHP8GftRiyfUDf9CdSs+b0nXK7xgRl6rLfiKW0UmFv
         OPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492328; x=1757097128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSo01xEtu7GaLlUrg3B9Uz1MDG42fOObUQbcFYUl6Tw=;
        b=ZLQaypyLqnlUgR3fCSGbhv7lc7AAF2rygZbLk/ts1QrTrP616ZL2yYQjwyoTKwV6jf
         ieTE3EU47OWmyRAFah4GRk9jEnwo3cLSOBypZwx0fQX0csI9rDGM2MqJsudTbq5Thuy9
         ANYn1rzCDsqBa8v2tOmYJgVJVOTQXxsrloU+hieZaTN7+IbSSgQSAYs3K+FigLK/348S
         EwrLPuYLIdzLK6qVQzvzQo4JrmrqcYXt67zfpR16R/c8I7ePMjCTCiWDSPUg8TsCLCEX
         tudwNq7hwOdSZq2kP+K5kqyAN25h+pF1hcHNb+XdALALe97c1Nzx9hClHMz0gC4gy7ar
         fOrg==
X-Forwarded-Encrypted: i=1; AJvYcCWl+ElM9Og44Ov2aLS4jVo/h/GNC62gRQAuqUZ4d7Py+UsdEJkEBpqFFvVKM1iBM0gOzY9vGQEjLb6/EBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWnDK/iemmpp3XLUCsf+mg6VtNX+irsy4AvBWupRWDUMH5031L
	dc8IyBrnP23CGrfsu+rPqxIdYqYW6Sjp8RElZjp1Q8sGvBfKFuIPofN86gBUmyqstoRwmlwKXhz
	g+rFO
X-Gm-Gg: ASbGncvFmDCbodXYV7GFHD+HZQGBhEvFLp4Oh9+Qf3F7fsk0rlFNxCyNhjVwY2/g378
	WQxcja8VjMIYfTLbwjJ63cNlietwwLoB6yaXK9lIyqkbhH6XhTBy5A+Jq0hScHP/hM9Fe75L/lf
	ZJ5xJmPKssx/EcxfxDZhtluOO0ipSJOi8LD1uqMen9Jvzq4o4MD/ev6CzsH+BHmaRapfaNKAR+/
	dWo0zDEMr9OiXHKqdccZe/coeg3bskv9ovQnud9OgZKsP9QgLMHhTalkSyYXwVhwvF8u6eZhnrq
	X0p8mm+jhmOkSU47gNprd3Cg5Vm1UzvokT5vaB1EkaD8pcO0vDeZk1HgNe6uDnT0PwfjOPW8Tou
	lKMCsv4wslsmUCqHsTt52/xlOdSBfFFIGTJCNUBnS1lC2HtIhTKBDWQmeJ2Lm//Zp5mcZbZHyq9
	aug1A4coRfkrWc/VIPW80zlA==
X-Google-Smtp-Source: AGHT+IGgIyPvXdAAvfBmrm+euAdBjSIIwKAClvgKzuXio2hH7ieSXYoNrka6sHgGz0RCbGkrNqL78g==
X-Received: by 2002:a17:907:3f07:b0:afe:35d:fd5d with SMTP id a640c23a62f3a-afe28f75d2cmr2585600666b.1.1756492327516;
        Fri, 29 Aug 2025 11:32:07 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7f1174sm257964466b.9.2025.08.29.11.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:32:07 -0700 (PDT)
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
	surenb@google.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 01/12] mm/shmem: add `const` to lots of pointer parameters
Date: Fri, 29 Aug 2025 20:31:48 +0200
Message-ID: <20250829183159.2223948-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250829183159.2223948-1-max.kellermann@ionos.com>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
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
index 13cc51df3893..2a4476e223a3 100644
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


