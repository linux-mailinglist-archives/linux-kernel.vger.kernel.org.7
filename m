Return-Path: <linux-kernel+bounces-834651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAA4BA530A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96E61BC61C4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7902280338;
	Fri, 26 Sep 2025 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHbkpEr5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCDC2A1CA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758921419; cv=none; b=GajBQ1It1D+n0MyOS6uM6K3R+o+SpjF0+smUCjuZ9/Up+Fa7FXDchobRQnw9kseJaK+iR8sJi39nPvWWqOwEy/oR5JajlPBxF4oEnEMofwrGKW1WdOrhr917BnobhpjQtGDq59c87PEw7Vd2m+pTl0V0mJX7H5PFPiyvbVbkwXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758921419; c=relaxed/simple;
	bh=+r0KiWt+im6CDI3PI/x2bvWoS8HvsNFYV/olXE7hcXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Uob0gVNKxNYjv58KArmyhbCx0Fpn3BscLM3Fot3kq/IUobLWn9po46woKUzPrrzjZxzU5kqLxVTrqEEAbvLwX6FCr3ghtEF9ngaykpSo75NU5rrh8gpSlVuWYxntl2BycJ1de+tNsTk8np9Ex9Bzti3HdOs7ZHE5SU6gXnqwkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHbkpEr5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758921416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pZu6gR0HqznnFJ7wyYHzy7twyjelDSGtnmT3D9hiRco=;
	b=eHbkpEr5SuYl1jpdXrA5nn+CU2Y9AWayuzDJPIyQW9dxsCOv5tzAx2tEtfPfNbyhHE0044
	rBFCYq2ThupOBhj15oNLzb4Pr8Pfgfk8AwYRMQ0e2PmtGM98OFGIjzm6VoBHtQRkN5A2Hq
	xwkCiUt8gghsoyVHpwiS5N+s/khBG2c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-E0395EuiPNmNeJT_-xV_IQ-1; Fri, 26 Sep 2025 17:16:55 -0400
X-MC-Unique: E0395EuiPNmNeJT_-xV_IQ-1
X-Mimecast-MFC-AGG-ID: E0395EuiPNmNeJT_-xV_IQ_1758921414
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-844772ccee9so528182585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758921414; x=1759526214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZu6gR0HqznnFJ7wyYHzy7twyjelDSGtnmT3D9hiRco=;
        b=gSCbNk7s2oehCXRnKkRquk6HSketZ2hFGy3IZEn42IBsr6uW1u5r8w63UERHx5ImNL
         +kIafblbF1pCtapy73dm6Y0+UR+ESe2ydRxnyE3VteTs3JiAmAue0MGKAUSwxfzw3L/7
         8ZKxVsntQdGqxJOMBzo6Hld2+odDAOy14afratEt4+n8WWTGxQWXZlTvunpKi4gaKjk0
         Ve7k0QKeGi/fSOQAr2iF7ezDYoyGmVXOvjKFKPfkulHEyT9FT79tQy6dn+cXooTYM5+m
         55xLeEtXEaK7Rbd/aJ79NQx03OLR1TQch4TIycQMSKULuQoF7WMMCsOfXfNS7WDnHObH
         CS3w==
X-Forwarded-Encrypted: i=1; AJvYcCUwr79Utf5mIV6WH8IR7JQ2dDYk6gVcc8Fd23K1LmY6+sYy2yZgYRBFG4jFU7NjZ6BSAI1wcE7q055KacE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7IZcDczrniNUDcMfw2NMy+KO0OdEBBrlw1uvWHvgvglHXe7if
	HCcJl2EwHY8PY1d+z/8Zl0Hn30ZC/gOH1dOA81OoKVDyL+O1paAUs3Rk+j/ZWObfttASbn0X2Hn
	Mk473jhcmKuoOatNn4T+fVb4io+vlLUA3iSmzwDduSG78dB4HcG1zFHBBYuMdDCfg9w==
X-Gm-Gg: ASbGncskZp366WzpEFKwLHOjQNDTfnQxzdSLmxxygyo/5ceiFDbMSFkrqioBUKZH+cx
	OiULEPLTyJ6r9QPie4vHvaXz0d62aGqJNm416QjJRbAcg3OUIofZBGJqrC7LYPo2DksFaJ9MzNy
	M7Lsi0Ti4KxVXw7LmoSVWvR0p4vpn7tESUy7XmP0UxZ+AQUdINQkE3aqGpPfMbaEkotJGPcDnzv
	7/Qm+B3khRheysoRLsC6i7/reW3H3PdmNWH7foG5WDThXsHsyluMZHG656kzoqeZTnrSxo9EtKx
	JYYXKika0kxAtezbb4UANFwDsuprwA==
X-Received: by 2002:a05:620a:4010:b0:844:9c74:e839 with SMTP id af79cd13be357-85ae0dc231fmr1383424785a.22.1758921414367;
        Fri, 26 Sep 2025 14:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiAxabx7r/K6xtC+G+7Mvff3t/oz7JvM0JCJVRVTnSujlCH49LXQ8vENfM3WuriZPZ3r27Ig==
X-Received: by 2002:a05:620a:4010:b0:844:9c74:e839 with SMTP id af79cd13be357-85ae0dc231fmr1383416685a.22.1758921413650;
        Fri, 26 Sep 2025 14:16:53 -0700 (PDT)
Received: from x1.com ([142.188.210.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-86042e32249sm210604785a.44.2025.09.26.14.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 14:16:52 -0700 (PDT)
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
Subject: [PATCH v3 0/4] mm/userfaultfd: modulize memory types
Date: Fri, 26 Sep 2025 17:16:46 -0400
Message-ID: <20250926211650.525109-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[based on latest akpm/mm-new of Sep 26th, commit e612c80ae0aeb]

v3 changelog:
- Fixed checkpatch issues on spaces or typedef
- Dropped uffd_copy() API
- Refined commit messages here and there to reflect the removal of uffd_copy()

v1: https://lore.kernel.org/r/20250620190342.1780170-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20250627154655.2085903-1-peterx@redhat.com

This series is an alternative proposal of what Nikita proposed here on the
initial three patches:

  https://lore.kernel.org/r/20250404154352.23078-1-kalyazin@amazon.com

This is not yet relevant to any guest-memfd support, but paving way for it.
Here, the major goal is to make kernel modules be able to opt-in with any
form of userfaultfd supports, like guest-memfd.  This alternative option
should hopefully be cleaner, and avoid leaking userfault details into
vm_ops.fault().

It also means this series does not depend on anything.  It's a pure
refactoring of userfaultfd internals to provide a generic API, so that
other types of files, especially RAM based, can support userfaultfd without
touching mm/ at all.

To achieve it, this series introduced a file operation called vm_uffd_ops.
The ops needs to be provided when a file type supports any of userfaultfd.

With that, I moved both hugetlbfs and shmem over, whenever possible.  So
far due to concerns on exposing an uffd_copy() API, the MISSING faults are
still separately processed and can only be done within mm/.  Hugetlbfs kept
its special paths untouched.

An example of shmem uffd_ops:

static const vm_uffd_ops shmem_uffd_ops = {
	.uffd_features	= 	__VM_UFFD_FLAGS,
	.uffd_ioctls	= 	BIT(_UFFDIO_COPY) |
				BIT(_UFFDIO_ZEROPAGE) |
				BIT(_UFFDIO_WRITEPROTECT) |
				BIT(_UFFDIO_CONTINUE) |
				BIT(_UFFDIO_POISON),
	.uffd_get_folio	=	shmem_uffd_get_folio,
};

No functional change expected at all after the whole series applied.  There
might be some slightly stricter check on uffd ops here and there in the
last patch, but that really shouldn't stand out anywhere to anyone.

For testing: besides the cross-compilation tests, I did also try with
uffd-stress in a VM to measure any perf difference before/after the change;
The static call becomes a pointer now.  I really cannot measure anything
different, which is more or less expected.

Comments welcomed, thanks.

Peter Xu (4):
  mm: Introduce vm_uffd_ops API
  mm/shmem: Support vm_uffd_ops API
  mm/hugetlb: Support vm_uffd_ops API
  mm: Apply vm_uffd_ops API to core mm

 include/linux/mm.h            |   9 +++
 include/linux/userfaultfd_k.h |  83 ++++++++++++++++-----------
 mm/hugetlb.c                  |  19 +++++++
 mm/shmem.c                    |  25 +++++++++
 mm/userfaultfd.c              | 102 ++++++++++++++++++++++++++--------
 5 files changed, 181 insertions(+), 57 deletions(-)

-- 
2.50.1


