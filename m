Return-Path: <linux-kernel+bounces-793875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7853FB3D992
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352733AC984
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E3524677B;
	Mon,  1 Sep 2025 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="e67ix/3v"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305A1C6FE5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707156; cv=none; b=iFAozeks/v5mDI0wwWdIRdW2ASmBUjEC1D76Xg4QIbA2kWmJcKxaK+GcLbuM1Mk7F7azXZKpsHEVIt72ojZPg4e1tXowG6C1PY/8qDTO7tkJORgwb2vYOyYXEQPp0dZF7/5yWYnKONLsMzV08+8HqgWESWv3jEej+3VldG/PHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707156; c=relaxed/simple;
	bh=V4LU0I3hCKksqnAA2+hhIoz1XTJlKk2FJeYaC7TfaKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=di/Z/Z1PBlYbX6FvU7RpYdiztochF6UPzvpPw7t92GS/5bP5EuH75lXEjopuMfkHuljOTjvmFE68bjKIHPUFkDw88UePtKOVIpbt2g2C/UkBFQZGSzvOgmf/XUu4+AFR7rGKLIRGWVaYCQ/8VOIfQpZeVKsX1kyPwGWfmThXD5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=e67ix/3v; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61ce9bcc624so4260141a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756707153; x=1757311953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAmcQheZtK8H9lT/6SrM187F2xtfPKvpNjdr5OvH7Wc=;
        b=e67ix/3v71Nn+XL1e/dWU4M6HMurmhaAXARhPS+g5memYuktmEuqgIhcKkWdNhb7F7
         K7FA/rYROi3eEI97Dd4g+4QXv/6Y7VIMhqWjtF5+QBM1C8+CdVgIBLSSEPs4sj1ctGHQ
         aP7QgXEC/3eTEP4f1G6VkXbCphcw3vGNFQqnxUZ3A29IBIeL2NfBdZ/e5VVEMfToHPkV
         rvERlKOgkaeNPnQP8w5yc/JKCxsep1VTiyRwcVDx/q7m1yHGrbQMrie+snT7HKCOKVUR
         F+f6DAn5+ArUOcyPzLOQIvrbpJJ5Rw9KDi2A4CI8gmwVrtO5rLREmn6PMi69gQGdAvJ6
         myyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707153; x=1757311953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAmcQheZtK8H9lT/6SrM187F2xtfPKvpNjdr5OvH7Wc=;
        b=XYsfCxCP35drrlKrbqevZV+fSdd99nvLraSsNIDCur/RyOKLIYXpsuh+UY6JZidVf6
         P7vIOsDElxGIxeEgtTkRetO14eEQ9yyqsdW/F8QAw+eX279tqZf16FQIgW0qIvcG8sdW
         pwO2OIpKnya4zfv15SvGXE2Deb4W43GYwLep+f/z0mVJLkcF04IlQxSKJG8Dau/KNx+w
         GRFE9vQL7z8TqVveImmyox69UnDlp5hBvWp40J4sMfaeWXnrMTvxJBg5z0umPEu861oJ
         VzCoZvFX6/meZF9ZRs0hpncudDIwrARaE72asczv2QZmNvJ9RaTboYUaIn/zgbZ+mgIj
         WBew==
X-Forwarded-Encrypted: i=1; AJvYcCXMU9wu/S7zTgY51Fw1X/U10GeZ9yNJBHWNkQJqvbPdpooDx9s9fNQ2aYZk8WmIbH4nwgqzV6EM4iWwCCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtewGSHLoMMA5kEHAt69mOnyxJqYSEzB5WRmh+r7vbhbibpw2N
	nWEF6j8oQOAz+tTqIxdotxEEJBGJgVx8gRMfHnAWIc5Jnxmbaqh+tBb/ZnI+a7yS6pQ=
X-Gm-Gg: ASbGncspZYs8VgWMQT9Gy0rlqwAmg0QxY2rE2gFXu/p+6YXsKJi9scSpu89j3gLcipR
	dfDubDmQvdUbS5A4bYmkT4QBJUOmiosWOX4/w3vaUcBburJxaTL9WWeiSSDVasJZ5N+O5arodoP
	rKVrzwgyT4FZ+vXy5hQvS6COO7RbFhJsoVcew387Eiks6Ps+CosI2Y36wJKEmXIKzDeYOMguihy
	gxcRf9Z96mGpplxsFmJeIGvJBw+7B2FTe5uzS0053W7FZp8e1gim27uD1NUx1Kz8Abqo2+jT2e6
	hkcrQx+oa2f8wEIwlvHY7zp5bqVqkSU0Z1UbTcw+OH0d12ZXWmo/gZsqXESCpG1TV/yxZhq/3WN
	W5LtUF1DeEXMGsQU5n+OS02+zGbjkSbIFQJIrvGY/xa0PDKagGDkrQy4qiPGro8eWgUVBnArhAH
	wMK8TsaxkSTCx7sgS5DbGnYw33dcJZcN38
X-Google-Smtp-Source: AGHT+IGAZtQ8S0AtmfPW/zy24FKXFpTjW7KLkRhUqL2JQUArAEikfl5S7NyGUJW7THgkMENC9KM8zA==
X-Received: by 2002:a05:6402:5419:b0:61c:87da:4bff with SMTP id 4fb4d7f45d1cf-61d26d7801dmr5403229a12.26.1756707153277;
        Sun, 31 Aug 2025 23:12:33 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc231561sm6374533a12.23.2025.08.31.23.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:12:32 -0700 (PDT)
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
Subject: [PATCH v3 01/12] mm/shmem: add `const` to lots of pointer parameters
Date: Mon,  1 Sep 2025 08:12:12 +0200
Message-ID: <20250901061223.2939097-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901061223.2939097-1-max.kellermann@ionos.com>
References: <20250901061223.2939097-1-max.kellermann@ionos.com>
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
index 640fecc42f60..d55bceaa1c80 100644
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


