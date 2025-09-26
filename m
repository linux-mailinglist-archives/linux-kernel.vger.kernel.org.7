Return-Path: <linux-kernel+bounces-834654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B2ABA530F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DC6D4C61B3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417CB29C327;
	Fri, 26 Sep 2025 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFMaCZ1a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18528C871
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921425; cv=none; b=BhHvGiFrhmidgj5OE1m4dD7i3BWOodkcY6NzOkb9ykkonzKCddWjNPxCY6/4ivGS/4e1o24qEzItdtbSuOcanUiJpobersZF4XkfoSbGg35Wij8y24oQ5mzXHbpTj7nomX63JpdSlrZ+u+G/PGgNaUVnyXNsertQT0oyleAsOMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921425; c=relaxed/simple;
	bh=350FlD+YQ8YFDKnfapWYOsdF+kFMQN+xTfNtEgMMs0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbBrYvinArbvpu4NK5m0U0K9NS/aLdphINMweCuiEhbEw1+SM2fWG4fxzvRjXPy8PLMwuLOsgElWNfDRrywbflZ8Tsl/yqJsox2hzT4oMVc772/RCogiEwiOSWiWfQn7SxLVEwN4lOlKKIT+D3Va0Dgx0nR5pEXKnpmJhUgE6us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFMaCZ1a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758921419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5yeOKo+xy2g0cnjvr8gakW6SdH6gdiBhq2xrS+i8Dw=;
	b=QFMaCZ1aEekDasURp7g1KWkVwh0MwnljOrEemheNO2K/75ZuJvcGhJmPsgmCySGP51rLyi
	JjpNVrt3WtZ1v9RIwQl1dlGteA+Y6n96u1MjJr8F1LERo8vLeCHl1gxDb6lVzpVS6WXiVI
	+4Pp8wBJHnbQ0RtR0GFJqy3CGd7X+ZI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-6WsRYGq9PuCFryKdky68yQ-1; Fri, 26 Sep 2025 17:16:57 -0400
X-MC-Unique: 6WsRYGq9PuCFryKdky68yQ-1
X-Mimecast-MFC-AGG-ID: 6WsRYGq9PuCFryKdky68yQ_1758921417
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5d58d226cso65044841cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758921417; x=1759526217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5yeOKo+xy2g0cnjvr8gakW6SdH6gdiBhq2xrS+i8Dw=;
        b=kBIekeFM+kIjHdqZzWomggA1hX9JzD/++hR9SBgFMS8KWXGjCcp94wEUc3vWFMEQla
         2vQGej0QgWdJ8Ibc85aR3V6HU/0zVkOKS/Ap1BQrJmGIvBgPLE6NnXiHJA8PwliWfdki
         zYQ6OwbzZZP3cr4EZDmLoV7VgviwFrN00DAOm4Iqfohug/CGQKYv1XQad/8YKnmzMeYI
         MZUgPCv70IuI6uRrhbtZ9H/36fRJlU6Hw4bu3RZWtA9ZeY4QVM909Q7nWkErO3TdeYYh
         84g7QBEEc/OMLuP9zOxEz2bTCqQjglnWmQxgmq9wYNgj8A6Ahb5/CNo317LfdM2mIfUQ
         qe9w==
X-Forwarded-Encrypted: i=1; AJvYcCWYklc5h/tAABA5GD6/jMUr5NMur8Olx6VsMCkVBnoPZDIspQkiTOZRGsBZX26A11js9Sq7EIJ8lHI8+SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJc258dbAzyaKeV6l76c86bXmHZz7aQswFxYGcQL8eFSYBV1ek
	o4qen4VrNFxXSUiXKTJAGFHbIDMJRhbgBAUG5oskKbcgBRj2+Q6ZoSfDT5w7A46uQHraPjrXeRV
	b09ZYAB4LZnMIItLT5Tb7RarE1AcFxoLvRhgL0yonOdROyGgyaCR/iJbM0s7qSV8jLA==
X-Gm-Gg: ASbGncv3Xi1Nq+1c1Y0SCy2iBewYVEG4J6xdw1w7yhiTHYaT8y4LpoYVaInlJElWXWo
	Mtj4nXbANDWZWAm+McozWmkucTbixNe7zXjzvlSE4/gdzbtdMXWf/MSEquUAxBU31OgRN5+e+lD
	RmqR4h4oHHD+YDyi7+ZyY8QGVuFHD4BCMSrW/eNbB64B9glkdW03C1nV49OE2RHS4jVS7wXaba+
	9SbYvv16qk99wKrgi0RCrFdZ/npcIkGj93JQT1GcnsuL9/LtY+cNhMO9ZS4zpsPY/2ZbGWh+4e4
	lEm4+jlaz/JCBWD7CsbRnCIuT07b0w==
X-Received: by 2002:a05:622a:5c1a:b0:4ca:10bd:baef with SMTP id d75a77b69052e-4da488a0db8mr127805751cf.27.1758921416704;
        Fri, 26 Sep 2025 14:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBcMQvy1EznIKbV08RyV+Az/cmOQuuNvDrJwaaM3Rmt+xpQZNuQS8EHNMhqLjuus0FkmUnnw==
X-Received: by 2002:a05:622a:5c1a:b0:4ca:10bd:baef with SMTP id d75a77b69052e-4da488a0db8mr127805241cf.27.1758921416109;
        Fri, 26 Sep 2025 14:16:56 -0700 (PDT)
Received: from x1.com ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-86042e32249sm210604785a.44.2025.09.26.14.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 14:16:55 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	James Houghton <jthoughton@google.com>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	peterx@redhat.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v3 1/4] mm: Introduce vm_uffd_ops API
Date: Fri, 26 Sep 2025 17:16:47 -0400
Message-ID: <20250926211650.525109-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250926211650.525109-1-peterx@redhat.com>
References: <20250926211650.525109-1-peterx@redhat.com>
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
[1], uffd_copy() will be temprorarily removed.  IOW, so far MISSING-capable
memory types can only be hard-coded and implemented in mm/.  It would also
affect UFFDIO_COPY and UFFDIO_ZEROPAGE.  Other functions should still be
able to be provided from vm_uffd_ops.

Introduces the API only so that existing userfaultfd users can be moved
over without breaking them.

[1] https://lore.kernel.org/all/20250627154655.2085903-1-peterx@redhat.com/

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/mm.h            |  9 +++++++++
 include/linux/userfaultfd_k.h | 37 +++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6b6c6980f46c2..8afb93387e2c6 100644
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
index c0e716aec26aa..b1949d8611238 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -92,6 +92,43 @@ enum mfill_atomic_mode {
 	NR_MFILL_ATOMIC_MODES,
 };
 
+/* VMA userfaultfd operations */
+struct vm_uffd_ops {
+	/**
+	 * @uffd_features: features supported in bitmask.
+	 *
+	 * When the ops is defined, the driver must set non-zero features
+	 * to be a subset (or all) of: VM_UFFD_MISSING|WP|MINOR.
+	 *
+	 * NOTE: VM_UFFD_MISSING is still only supported under mm/ so far.
+	 */
+	unsigned long uffd_features;
+	/**
+	 * @uffd_ioctls: ioctls supported in bitmask.
+	 *
+	 * Userfaultfd ioctls supported by the module.  Below will always
+	 * be supported by default whenever a module provides vm_uffd_ops:
+	 *
+	 *   _UFFDIO_API, _UFFDIO_REGISTER, _UFFDIO_UNREGISTER, _UFFDIO_WAKE
+	 *
+	 * The module needs to provide all the rest optionally supported
+	 * ioctls.  For example, when VM_UFFD_MINOR is supported,
+	 * _UFFDIO_CONTINUE must be supported as an ioctl.
+	 */
+	unsigned long uffd_ioctls;
+	/**
+	 * uffd_get_folio: Handler to resolve UFFDIO_CONTINUE request.
+	 *
+	 * @inode: the inode for folio lookup
+	 * @pgoff: the pgoff of the folio
+	 * @folio: returned folio pointer
+	 *
+	 * Return: zero if succeeded, negative for errors.
+	 */
+	int (*uffd_get_folio)(struct inode *inode, pgoff_t pgoff,
+			      struct folio **folio);
+};
+
 #define MFILL_ATOMIC_MODE_BITS (const_ilog2(NR_MFILL_ATOMIC_MODES - 1) + 1)
 #define MFILL_ATOMIC_BIT(nr) BIT(MFILL_ATOMIC_MODE_BITS + (nr))
 #define MFILL_ATOMIC_FLAG(nr) ((__force uffd_flags_t) MFILL_ATOMIC_BIT(nr))
-- 
2.50.1


