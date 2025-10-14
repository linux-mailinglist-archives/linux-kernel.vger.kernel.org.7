Return-Path: <linux-kernel+bounces-853476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AB4BDBC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D80534EE6AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B722F069D;
	Tue, 14 Oct 2025 23:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIstPoyN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685FD2EBDC2
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483713; cv=none; b=sSiAbfc7c7ZMQDFs8opkuDP7HXIRziuA6Fx8DjYy6fuxIok0v7Pf7BTfZWWZjWPGvcdtxhr91PN406/uUn8JudAyD5VmxsP51sPCCk03J6TVGkp8b6gckBQq+QYpd1IWHdur5OAPCuh/tDJ0JjcKEabp1n2XnCaR9w7OptSElKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483713; c=relaxed/simple;
	bh=jJcX/NZ+ct+6fZV1L5dGJ7Ilgo3S+W762X5b0jWLAgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8ykmCCMMpqvlQO5VPTlM+qGtRL/nzJJyRZlgNYMMWIL5VRskPBkWzncuCvO9j+YvVS7ct5JjU+S0nbIeZfGqpizUJiylFJEZSe2RvrSblLM4hboi90DjMSZbGSwS3r+1JWNDwIpcSJfcPsCSdpsi1CYxqmFM51K0hkp9G6hS3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YIstPoyN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760483710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzFo/w0Qj8OvgfMsejgN1W3LOUb+8BQstccWgX+yOQo=;
	b=YIstPoyNYfvUtRjM1i9nO355UaIo/qNoohfdwP+7EnsbaukfDkU9lf8KKyVK0t6eIwsYMg
	NnsqdkyQUGG755FJFyw/GZlCFDb8J4VwvNRv3Q9THpbf1dfNazTv5IvOqSdJbXKDBkTvAF
	iPcxBfu1nkv4sbpytKripJfptZPtczw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-ynjsU4jmMfejE6jJiIIlXg-1; Tue, 14 Oct 2025 19:15:09 -0400
X-MC-Unique: ynjsU4jmMfejE6jJiIIlXg-1
X-Mimecast-MFC-AGG-ID: ynjsU4jmMfejE6jJiIIlXg_1760483708
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8645d39787bso3778721185a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483708; x=1761088508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzFo/w0Qj8OvgfMsejgN1W3LOUb+8BQstccWgX+yOQo=;
        b=QbEY+mbMbwU6SzNkbA8BUrejKWoz5ahejJVbIN7ezeb+F/yLwrJZARE8fFP/jN8PqC
         OYTnL9UU0fUs1fEsEYgvWIjSyonHZ88MfuXnEYpGcUbcSSvAYd4FRdw1f1qCiCs7l2Pr
         FYMlIV93hJy0vt3TA3aTIR2UvMQ+jO6ptTXPLbccjlIQzfkq2TYcptV0ymntbaG4guMI
         fCpFiPL7EiIRhUkj8yrPJpCTncWIoc59NjuhJU8G+NC9dNF1lSs80tbt0xndmtAqpOFx
         C26G/64iWpd8qmZ4/+ZpD5TntHyOyTOyH19L32HZjUaQnV++Agh5lQN8HXUGUbZwK0/l
         Pyaw==
X-Gm-Message-State: AOJu0YwweuiB5rDbLivzjhM/bThW+S+hNdFGN1Q56mE+mdxSUI70d7/o
	j8qkxAPrxg9kNz6voLrcxesTMYGfLT174KwNj72qfSYNgi1v4WUPpiI3kuAYcnhcZ4akFylIG6t
	8uRmHMEX/Sf3YwT2oeNMRBTLHgGzUXpIYMl8eV5NmK/9gS8yOO8610Cm0kyTa3zWnsieBuHyPlv
	3Fw5xhFjCqSYd6xVhnNR6QmKCrLLjT5vLsKqn1YmtZV29Z7bI=
X-Gm-Gg: ASbGncu36qX8yAH2eMSb1TVfyhLKr/zkm4FL7Pc8hPFz4Xq3La7T9EJtvpbv6DNtk9l
	5BFLFVGEPqNJusOCpPw9jbC4pc0lYP5pOcxbGeWBOgceHffKHs1qcfcTotkUnBj/LybgLFPrtE2
	zoOqIk1hz5giBSzBbAfkiUDu/WyMmSeUh0rtLSINZ8g9wBTcrhUxx+mnoQvlYiJHqXPP0LxrENj
	scfDIY8OsO2fy0NfVFoFl87qThrOx6fhEGfsi11T87QiXanYdBIkLN38S9K19XfqGEGJrAmRuBC
	IMZ6ZP+HIz9FNXfO/olxpCyNCzVOvA==
X-Received: by 2002:a05:620a:410f:b0:806:7c82:fd2f with SMTP id af79cd13be357-8835509897bmr3876985785a.75.1760483707928;
        Tue, 14 Oct 2025 16:15:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd/tIIPBz928gHS+Wnqdak0VkFeVFx8rUClYPU2w+ExFoWEFASF0U/Scf1/dE0/VkUh8nN1Q==
X-Received: by 2002:a05:620a:410f:b0:806:7c82:fd2f with SMTP id af79cd13be357-8835509897bmr3876975885a.75.1760483707106;
        Tue, 14 Oct 2025 16:15:07 -0700 (PDT)
Received: from x1.com ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a23693a0sm1280258685a.53.2025.10.14.16.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:15:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Houghton <jthoughton@google.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	peterx@redhat.com,
	Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v4 1/4] mm: Introduce vm_uffd_ops API
Date: Tue, 14 Oct 2025 19:14:58 -0400
Message-ID: <20251014231501.2301398-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251014231501.2301398-1-peterx@redhat.com>
References: <20251014231501.2301398-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, most of the userfaultfd features are implemented directly in the
core mm.  It will invoke VMA specific functions whenever necessary.  So far
it is fine because it almost only interacts with shmem and hugetlbfs.

Introduce a generic userfaultfd API extension for vm_operations_struct,
so that any code that implements vm_operations_struct (including kernel
modules that can be compiled separately from the kernel core) can support
userfaults without modifying the core files.

With this API applied, if a module wants to support userfaultfd, the
module should only need to properly define vm_uffd_ops and hook it to
vm_operations_struct, instead of changing anything in core mm.

This API will not work for anonymous memory. Handling of userfault
operations for anonymous memory remains unchanged in core mm.

Due to a security concern while reviewing older versions of this series
[1], uffd_copy() will be temprorarily removed.  IOW, MISSING-capable memory
types can only be hard-coded and implemented in mm/.  It would also affect
UFFDIO_COPY and UFFDIO_ZEROPAGE.  Other functions should still be able to
be provided from vm_uffd_ops.

Introduces the API only so that existing userfaultfd users can be moved
over without breaking them.

[1] https://lore.kernel.org/all/20250627154655.2085903-1-peterx@redhat.com/

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h            |  9 +++++++++
 include/linux/userfaultfd_k.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5c01c4b59ca67..011962130c148 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -620,6 +620,8 @@ struct vm_fault {
 					 */
 };
 
+struct vm_uffd_ops;
+
 /*
  * These are the virtual MM functions - opening of an area, closing and
  * unmapping it (needed to keep files on disk up-to-date etc), pointer
@@ -705,6 +707,13 @@ struct vm_operations_struct {
 	struct page *(*find_normal_page)(struct vm_area_struct *vma,
 					 unsigned long addr);
 #endif /* CONFIG_FIND_NORMAL_PAGE */
+#ifdef CONFIG_USERFAULTFD
+	/*
+	 * Userfaultfd related ops.  Modules need to define this to support
+	 * userfaultfd.
+	 */
+	const struct vm_uffd_ops *userfaultfd_ops;
+#endif
 };
 
 #ifdef CONFIG_NUMA_BALANCING
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index c0e716aec26aa..b5b4f3f174b32 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -92,6 +92,35 @@ enum mfill_atomic_mode {
 	NR_MFILL_ATOMIC_MODES,
 };
 
+/* VMA userfaultfd operations */
+struct vm_uffd_ops {
+	/**
+	 * @supported_ioctls: userfaultfd ioctls supported in bitmask.
+	 *
+	 * Userfaultfd ioctls supported by the module.  Below will always
+	 * be supported by default whenever a module provides vm_uffd_ops:
+	 *
+	 *   _UFFDIO_API, _UFFDIO_REGISTER, _UFFDIO_UNREGISTER, _UFFDIO_WAKE
+	 *
+	 * The module needs to provide all the rest optionally supported
+	 * ioctls as a bitmask.  For example, a module needs to set the bit
+	 * BIT(_UFFDIO_CONTINUE) to support userfaultfd minor faults.
+	 */
+	unsigned long supported_ioctls;
+	/**
+	 * minor_get_folio: Handler to resolve UFFDIO_CONTINUE request.
+	 * Must be specified if _UFFDIO_CONTINUE is set.
+	 *
+	 * @inode: the inode for folio lookup
+	 * @pgoff: the pgoff of the folio
+	 * @folio: returned folio pointer
+	 *
+	 * Return: zero if succeeded, negative for errors.
+	 */
+	int (*minor_get_folio)(struct inode *inode, pgoff_t pgoff,
+			       struct folio **folio);
+};
+
 #define MFILL_ATOMIC_MODE_BITS (const_ilog2(NR_MFILL_ATOMIC_MODES - 1) + 1)
 #define MFILL_ATOMIC_BIT(nr) BIT(MFILL_ATOMIC_MODE_BITS + (nr))
 #define MFILL_ATOMIC_FLAG(nr) ((__force uffd_flags_t) MFILL_ATOMIC_BIT(nr))
-- 
2.50.1


