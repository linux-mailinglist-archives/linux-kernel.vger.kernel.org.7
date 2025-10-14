Return-Path: <linux-kernel+bounces-853477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2E4BDBC22
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C274B3E2446
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 23:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97C22ED871;
	Tue, 14 Oct 2025 23:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJnvZRWC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063122E7F0E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 23:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760483719; cv=none; b=P8XbgBmP5p5I4CWNvYE5Qtv4eM8g5Y/3NZxXMjzA7FdRtWsdywqNGr01RK55xBry7GTznZzTH+ZPP03pzWOYXF8weXgOLP/7VBgl9VP5onV1tLh0mJJFrafMOKV7c9nbnSHljP3oPCdbvtpMvOknxdNjPix3+BO979S8emH+Ixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760483719; c=relaxed/simple;
	bh=a9NiOB2cDRAXfNEmLtcqgTWwDIZpMRx9BC4Mx/OMj9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYDFMIL5hrsjrj6GHQfp8Vozd+s130Ifj2nCPXVEphEyZkt8rNjgS8HWAaf1Un5o2L63erCsMMENBf+jLjouVcTJTPJDldXwFY0haNdYgXhMFL055tNqslynGsQX7FkR0eBItVSi9F9BFHMN+7fItP72/shm1Y/Xma7MFhhrCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJnvZRWC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760483714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S8wwcsn2rHV82DpS6Ecdkf6voQq6mgSVsI+Zkz9YIrQ=;
	b=IJnvZRWC7mS7yiA7clIHWcCnWv5grW7z1clbCYLEzbZ/9B64slxswXwOpYKY7hvSFjemNA
	DSh8nTQjrl4KRXwM6xyYBuZJxxd/jkgGRHxNe6kNc3NVtpAPsLgP5/+V75HDpDQtNOwuSo
	fYADrLbHwlNvMY7T+x8hHy2pyLN22cE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-Rw89HUUgN9G-80jFUbgIWw-1; Tue, 14 Oct 2025 19:15:12 -0400
X-MC-Unique: Rw89HUUgN9G-80jFUbgIWw-1
X-Mimecast-MFC-AGG-ID: Rw89HUUgN9G-80jFUbgIWw_1760483712
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8645d39787bso3778737285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 16:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760483712; x=1761088512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8wwcsn2rHV82DpS6Ecdkf6voQq6mgSVsI+Zkz9YIrQ=;
        b=Ko+MiPJII9+e1HkfcyfWML5yxl7MOBS1qrOYp8kCuh1U93XjZnZovP6t0XPHCmtYmh
         Kkl0YJezC3iXgz7XrLMt1d4t5f9r/5mGLcQunlmWKKp4497iGvWTbKm/JnN0jvjK+unT
         X31AGd5ocS+m93IF1AsqdMGnIplCd18DOUrGeBsu1O8ARC65o3xr9xd+XyjzNStoVh7T
         z2PQghZ1uNZZLuW22S+FGgyj6mVMoVZ+pA8q8ym6d2T8RcWCaqObSsA9UGYTOOKnftAX
         4wz+QPi40WDajE1bFB3elgTCmJoJO8NUIyepAzqY+3+9cge3HOUzxcsm3K52EaUKpP/s
         5Sgg==
X-Gm-Message-State: AOJu0Yy718n1ww9QHdYVTvKRbF6/USbaiZUANjQGeqqnWOYjlnUGkdkY
	kWsXirDrh7moYGzv6mezbk+ctTIlqdO9oHsob+7g575DepyN6JC8o/H0tS7JLZvnQB1tgp33hrz
	udMXqYe+ILEB97KAh+zeE6jhFdivGmZTl7QToKJLGEdFaUcvWYtZoPnB+rp5s1tp9RNUSeiAqPu
	DsDWFFS+Bkwd4Q4GZc7jWBmtroy6q0L1ovJ2Rl7j2yDenCIag=
X-Gm-Gg: ASbGncuW6DxP/6svIkm8c1Zn/qzJaGS78QK+Whu7lWzZISVzYU3gd2/RJ4uTkrdnrd8
	DxbS39hSStWcrJJHKoj5K6odza5bZjtjqupRuIiz5sbxbi8Z5tp1uqPmuwjfgBC+Y0nYbWP9bhj
	k6xy6UvYitvyuv433VHAhswpX7Z7QbZgT8cH5c9b59I5I9nCnIjRTAmHwNL+VvhxpJ2karRzX2n
	2qgVIHzFKG1PjaBaethg5l5/KK3n3xwUYe+B6jcFTlOindv1moFAQAWi/2jP9A1mb11eFHvfR49
	kNU9skb6WPe7wGkYOZ7yzlKeLiP5Ig==
X-Received: by 2002:a05:620a:2953:b0:85e:96ce:e833 with SMTP id af79cd13be357-88354caeef5mr3364653085a.67.1760483712061;
        Tue, 14 Oct 2025 16:15:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtVJNooIhMfiRlFPnpx83oUPtb9evj6TnuhZ+j9U679/QGWdl8aBsJeO1wqsoFRICR8/NLsQ==
X-Received: by 2002:a05:620a:2953:b0:85e:96ce:e833 with SMTP id af79cd13be357-88354caeef5mr3364646885a.67.1760483711349;
        Tue, 14 Oct 2025 16:15:11 -0700 (PDT)
Received: from x1.com ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a23693a0sm1280258685a.53.2025.10.14.16.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 16:15:10 -0700 (PDT)
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
Subject: [PATCH v4 2/4] mm/shmem: Support vm_uffd_ops API
Date: Tue, 14 Oct 2025 19:14:59 -0400
Message-ID: <20251014231501.2301398-3-peterx@redhat.com>
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

Add support for the new vm_uffd_ops API for shmem.  Note that this only
introduces the support, the API is not yet used by core mm.

It only needs a separate minor_get_folio() definition but that's oneliner.

Due to the limitation of the current vm_uffd_ops on MISSING mode support,
the shmem UFFDIO_COPY/ZEROPAGE process are still hard-coded in mm/.

Cc: Hugh Dickins <hughd@google.com>
Acked-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/shmem.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index b50ce7dbc84a0..0be112689f9e5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3146,6 +3146,13 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
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
@@ -5189,6 +5196,17 @@ static int shmem_error_remove_folio(struct address_space *mapping,
 	return 0;
 }
 
+#ifdef CONFIG_USERFAULTFD
+static const struct vm_uffd_ops shmem_uffd_ops = {
+	.supported_ioctls	=	BIT(_UFFDIO_COPY) |
+					BIT(_UFFDIO_ZEROPAGE) |
+					BIT(_UFFDIO_WRITEPROTECT) |
+					BIT(_UFFDIO_CONTINUE) |
+					BIT(_UFFDIO_POISON),
+	.minor_get_folio	=	shmem_uffd_get_folio,
+};
+#endif
+
 static const struct address_space_operations shmem_aops = {
 	.dirty_folio	= noop_dirty_folio,
 #ifdef CONFIG_TMPFS
@@ -5291,6 +5309,9 @@ static const struct vm_operations_struct shmem_vm_ops = {
 	.set_policy     = shmem_set_policy,
 	.get_policy     = shmem_get_policy,
 #endif
+#ifdef CONFIG_USERFAULTFD
+	.userfaultfd_ops = &shmem_uffd_ops,
+#endif
 };
 
 static const struct vm_operations_struct shmem_anon_vm_ops = {
@@ -5300,6 +5321,9 @@ static const struct vm_operations_struct shmem_anon_vm_ops = {
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


