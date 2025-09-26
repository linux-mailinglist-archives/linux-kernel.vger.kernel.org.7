Return-Path: <linux-kernel+bounces-834652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B09BA530D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 616D97B99DF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF75429617D;
	Fri, 26 Sep 2025 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gw4bZmBW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F728D83E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921424; cv=none; b=IHIDpVjevQTs7iuOl6arU1h8LPexPNub11Cg3mS8RYqZ+7hXNBikN5UPz5XmFCYRdUZktZCuhVHkAQ2DdaXrNSejpfxseJfKr5YjbdNK0PHA8BgYg2rDdg82GzHAx0ZQFuNe138voJsU7lYI/45gGbDYmCnx+3jIA+O10Nm1tlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921424; c=relaxed/simple;
	bh=gu11TsYv6vNBmZ2FzYsI3o2VkvQDcJu3rAdvQklLAVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9Gg1K9BLpXHJLVpOL5V8aVsO21LoShsiEy8ENmlMWcIsmmoWYJErjdUGTcLyGHB8vgrNob2uz2IwsS1TzyUmnAWfKmiOTbVYWmQfR80i5WPhd1LLCiw2mzpMpjcEOrvDlK2adtlX4M4hHmmnme80QGgTQPzMhh1myNAYTGM5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gw4bZmBW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758921421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w9EcAJwkVO1k6z+Bq8iB9jwHou2j8ZHFnEQnT5CP3gA=;
	b=gw4bZmBWufjE08lTv0z9h9Ms6O2fKceKwcFGyG/q/JAb1CMEk2qOMY/SsJq9EVMA4RXeQj
	yibCZBc6KrD7EALJMd9k2Ll8gXiqjFrlDukF1xY/tNnNaA9359r9gil38AnAmRYFQT7XXL
	bGAHZSLFlw1HVSJtp7iTyryPwFmCO1I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-s9_PWsKIPsKcygqW0WAW6w-1; Fri, 26 Sep 2025 17:16:59 -0400
X-MC-Unique: s9_PWsKIPsKcygqW0WAW6w-1
X-Mimecast-MFC-AGG-ID: s9_PWsKIPsKcygqW0WAW6w_1758921419
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-81ea2bb8602so782330085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758921419; x=1759526219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9EcAJwkVO1k6z+Bq8iB9jwHou2j8ZHFnEQnT5CP3gA=;
        b=aKkGvgkwBnHZu3MDXr74CmfiwBTFz7LriwcF+VisUx0d1vHyyBKTYcO28fiXPlFQS5
         ++ZX7ZB35T4g2bPrGZArr19S59WcQ2O5k1y7olCxufUS+8Dsgw2UcdLLfN2V8v8b6egl
         /EQ0PXYsjTgDfTdhiTHo+to2XrELqcAlfqX3XhsAt7qtXFCf986F2bs8x4NWJGzY9+ZF
         QtixauC02QcnKSJfB9Uxt4Ths5JvZfUAX7z7w5atsuRPidaQovzm4GTuA1/cJcLEJdy5
         QopSNKlpE/1ZKTwq9xtjSF8RQ/UMAytSiY6lB1up9dKKutbjNq2r8B+II8e+MB1SMLmV
         iSWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkjdpzVp0SAV9xNzOOpkZSqLO62DEQ4HyN2CkUEIizQ240jnfkW7by3lIgB9bKkr2yW7yESNc8SkyvV0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye6/dlseI8ftSbXqSu8/sfhEZG1cb1BdRS/5XsVgZ60KPO5Uf9
	ji9px5Kx12iFBlPQLEdwBtaNA0in1fZdHvU8xV2AivDn2jd6mrX1sQ3ZPEzljVSlg+2K+fFqH8w
	5capQz0J3t/bAUFt8acxU9RgWYwWqsndDxldSa2PvVt5Sc4V2SYzTBCD6cp+aURc9JA==
X-Gm-Gg: ASbGncv9lQwgelRr0uGD6Mi8R6tVvJme3XJxuxNTbMrCpWACx4jercC8t+dqCgTobfw
	TbtrgNCv3cWRH8MYgItCUz8z00j8zj1Mql5zCVzVfCdRAU5bsR3mJYlY7k0fObioJUzHrlj9ueB
	njC8GmmMskk989ltII4nyvm9IvbZHl2OIgH1lvrmKd4ZyQlRb9A1IK9VwdlOD3fkYbkHWqJFaDE
	fkrZJU/DWSaIBvqS1jQbqe9MCbzpvul+1407BwrDl+ROTJYxXZQWkdWPu/88UHgXmUOojk3mJeq
	Ykc1KSSbnw2PtcGJJ54MQmmHEPGw0w==
X-Received: by 2002:a05:620a:4722:b0:82f:5ffb:1704 with SMTP id af79cd13be357-85aea5ff651mr1128781585a.42.1758921418994;
        Fri, 26 Sep 2025 14:16:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUPCqwUFOJYLq99ntR5y4uXNMimgWCraucnJeJODIKMmZEqHjL7gOw98u8EnRi2EraMkV6DA==
X-Received: by 2002:a05:620a:4722:b0:82f:5ffb:1704 with SMTP id af79cd13be357-85aea5ff651mr1128776485a.42.1758921418443;
        Fri, 26 Sep 2025 14:16:58 -0700 (PDT)
Received: from x1.com ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-86042e32249sm210604785a.44.2025.09.26.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 14:16:57 -0700 (PDT)
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
Subject: [PATCH v3 2/4] mm/shmem: Support vm_uffd_ops API
Date: Fri, 26 Sep 2025 17:16:48 -0400
Message-ID: <20250926211650.525109-3-peterx@redhat.com>
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

Add support for the new vm_uffd_ops API for shmem.  Note that this only
introduces the support, the API is not yet used by core mm.

It only needs a separate uffd_get_folio() definition but that's oneliner.

Due to the limitation of the current vm_uffd_ops on MISSING mode support,
the shmem UFFDIO_COPY/ZEROPAGE process are still hard-coded in mm/.

Cc: Hugh Dickins <hughd@google.com>
Acked-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/shmem.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 4855eee227310..e7b44efbfddf2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3148,6 +3148,13 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 #endif /* CONFIG_TMPFS_QUOTA */
 
 #ifdef CONFIG_USERFAULTFD
+
+static int shmem_uffd_get_folio(struct inode *inode, pgoff_t pgoff,
+				struct folio **folio)
+{
+	return shmem_get_folio(inode, pgoff, 0, folio, SGP_NOALLOC);
+}
+
 int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 			   struct vm_area_struct *dst_vma,
 			   unsigned long dst_addr,
@@ -5191,6 +5198,18 @@ static int shmem_error_remove_folio(struct address_space *mapping,
 	return 0;
 }
 
+#ifdef CONFIG_USERFAULTFD
+static const struct vm_uffd_ops shmem_uffd_ops = {
+	.uffd_features	=	__VM_UFFD_FLAGS,
+	.uffd_ioctls	=	BIT(_UFFDIO_COPY) |
+				BIT(_UFFDIO_ZEROPAGE) |
+				BIT(_UFFDIO_WRITEPROTECT) |
+				BIT(_UFFDIO_CONTINUE) |
+				BIT(_UFFDIO_POISON),
+	.uffd_get_folio	=	shmem_uffd_get_folio,
+};
+#endif
+
 static const struct address_space_operations shmem_aops = {
 	.dirty_folio	= noop_dirty_folio,
 #ifdef CONFIG_TMPFS
@@ -5293,6 +5312,9 @@ static const struct vm_operations_struct shmem_vm_ops = {
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
 #endif
+#ifdef CONFIG_USERFAULTFD
+	.userfaultfd_ops = &shmem_uffd_ops,
+#endif
 };
 
 static const struct vm_operations_struct shmem_anon_vm_ops = {
@@ -5302,6 +5324,9 @@ static const struct vm_operations_struct shmem_anon_vm_ops = {
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
 #endif
+#ifdef CONFIG_USERFAULTFD
+	.userfaultfd_ops = &shmem_uffd_ops,
+#endif
 };
 
 int shmem_init_fs_context(struct fs_context *fc)
-- 
2.50.1


