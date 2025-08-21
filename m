Return-Path: <linux-kernel+bounces-780559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4727BB3043A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0471CE7061
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9C0312814;
	Thu, 21 Aug 2025 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIjsyfEV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDDB2FC022
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806857; cv=none; b=fy8bZK5hIXwVOHHTfmrRhJJkQfzVBS7o+hNXqTyGDZFgzKGL2n+yMw9z5PtyxvwRTVhAEfkpnARzGSU3pwLo+8nxojIdqvvfIH2v2rvUGXE8Dvtp1iBtJ9wz6p+X6GckIWxEprDRoKesCDL/pb1G6XTD1IPDhZDCdDSraV2mpgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806857; c=relaxed/simple;
	bh=ncGz2ZUizfxPtBenqYCMYHXawyPm3K75je3+1YWzFIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P83/qfUSgpjBP9lT1ExrzRSQM7sAZnb062wLnYek9KSASJr27JNc1k0eCGGj7HgFk1b1NDYUfM770yEj4Z5WwU0zSNH8HENuyR54FwC0WzkObaJ6jGcrrJpwt+Me+WoUIcCY0aul5fGR74dA2167CjrSkyn8TlW92SWUeOvXxzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIjsyfEV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G9hzYOZv6YXUN4v1wicJ53nqMhopJDezqYU76J2buLg=;
	b=UIjsyfEV7qy2FTtz8UFmUG7I29Rb0nWBVva+fIKfoFPP6s7+61Cxi5SZPooIbzNOG4q4kI
	nBcVkIIFucHEaRKucUVGRwZ4PMu2gowRW25DuD9JelcP0s2kOUvrQH3A31dzAmk6M99L0p
	zv8f8tUpRmXp0s0rYpX0mmMRsVeqBDA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-iHVNpiEHPrWR-Fz7NdikEA-1; Thu, 21 Aug 2025 16:07:31 -0400
X-MC-Unique: iHVNpiEHPrWR-Fz7NdikEA-1
X-Mimecast-MFC-AGG-ID: iHVNpiEHPrWR-Fz7NdikEA_1755806850
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b05a59cso9773875e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806850; x=1756411650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9hzYOZv6YXUN4v1wicJ53nqMhopJDezqYU76J2buLg=;
        b=cADB0yL0twAni4kgZfsng3fNDTY0xUEtvJkJvmZTnJQ2dhk4HRbv9eo/+I4dp22FUf
         H2XiVvUONhNeV8NgbKUFWhR7c7FHgjmWF+q9Pm0GTaXm0z9ewSDJCuHMXbfeNplGTjEF
         oeXWynBvVToJ5ECEqGcAmYAztZXCf0x2Uz1XCrNlOom3T7xtrbsVOxKoFYOzp5BsE0Sa
         EsQD7aHQ3ys0wnlPoMuTsXoS7V6Sh4XrcsYamsTLJbcCm7RayCVjKGiZnqCGTVQ5uglU
         4aRwdC1phpirCZv5o/IUh/Z7x2qK99FyI6j0d7LsZrq/vxmziXtLa7AGwk8y0dbjhp2C
         0o4A==
X-Gm-Message-State: AOJu0YxJucdy6HxOgIr802KwWpGtScJ+cC6IxZFDdl6PakhSDiCh/nC9
	OTbiwLgcdXdWCN06jFVm7D9tR4l/seZusVk5mdZqXEaixpMluKqU3Q5R/2kiXneiUbjeXaH2Ols
	2SMpUTiyCVDfDT4L8pVmG1645v8xwlcDJxjDBJkLGOtI55UzokvAlhZT5yzlXtQtlvGziiuW+nz
	U95HDn1PpOMt7Xnqv1QuVk+wBmckW8CpX5qUVH8YpeV/RYK+BG
X-Gm-Gg: ASbGncsAiyRy1XyOQKhOcNhnKYpjUzqDT4M7DgpLpE6fahfAfHgm0c0RQc7rHf/mFOX
	+uUrGy/lHJKZT2j5BdFXtyZyC/LaTn7ANFKrNp5SBwba127sV5H8T14uQGaB/i33pKwtp10ePdw
	48+1PtGP44TDgRobAdx0vtnLwtD9lljGHnBQEXJq+XgsSb92x3dPIg7v1SeelAHJPHch6fEVQd3
	6NMJJUwxU1JxlRlaWkAyLSM/15Ob+4QaRwUGc1zLt8lT90c4ySnDJSf/bSg5r5Qm9kRTHLNPQck
	LsNL4V35H+Ah7/M7e4hmpIefB7xBzYPSyKtEgrJgJHCGpSnmvKbW9kL0fqlDL5sCw/MDZHqRcbp
	dAE1vXQi7zKQymiFSxjiCqw==
X-Received: by 2002:a05:600c:1548:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45b517ddbe2mr2956285e9.31.1755806850217;
        Thu, 21 Aug 2025 13:07:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPNoTdvVqQJqQwQf/z0aFpcDb/7HunF1Y6KwbAqmFFF4D3cnAaKEmAnoGbjwE6N5eIepmoyw==
X-Received: by 2002:a05:600c:1548:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45b517ddbe2mr2955545e9.31.1755806849496;
        Thu, 21 Aug 2025 13:07:29 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c3a8980ed5sm7242256f8f.16.2025.08.21.13.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:29 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	John Hubbard <jhubbard@nvidia.com>,
	kasan-dev@googlegroups.com,
	kvm@vger.kernel.org,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-arm-kernel@axis.com,
	linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Marco Elver <elver@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	netdev@vger.kernel.org,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	virtualization@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	wireguard@lists.zx2c4.com,
	x86@kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH RFC 08/35] mm/hugetlb: check for unreasonable folio sizes when registering hstate
Date: Thu, 21 Aug 2025 22:06:34 +0200
Message-ID: <20250821200701.1329277-9-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821200701.1329277-1-david@redhat.com>
References: <20250821200701.1329277-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's check that no hstate that corresponds to an unreasonable folio size
is registered by an architecture. If we were to succeed registering, we
could later try allocating an unsupported gigantic folio size.

Further, let's add a BUILD_BUG_ON() for checking that HUGETLB_PAGE_ORDER
is sane at build time. As HUGETLB_PAGE_ORDER is dynamic on powerpc, we have
to use a BUILD_BUG_ON_INVALID() to make it compile.

No existing kernel configuration should be able to trigger this check:
either SPARSEMEM without SPARSEMEM_VMEMMAP cannot be configured or
gigantic folios will not exceed a memory section (the case on sparse).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/hugetlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 514fab5a20ef8..d12a9d5146af4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4657,6 +4657,7 @@ static int __init hugetlb_init(void)
 
 	BUILD_BUG_ON(sizeof_field(struct page, private) * BITS_PER_BYTE <
 			__NR_HPAGEFLAGS);
+	BUILD_BUG_ON_INVALID(HUGETLB_PAGE_ORDER > MAX_FOLIO_ORDER);
 
 	if (!hugepages_supported()) {
 		if (hugetlb_max_hstate || default_hstate_max_huge_pages)
@@ -4740,6 +4741,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	}
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order < order_base_2(__NR_USED_SUBPAGE));
+	WARN_ON(order > MAX_FOLIO_ORDER);
 	h = &hstates[hugetlb_max_hstate++];
 	__mutex_init(&h->resize_lock, "resize mutex", &h->resize_key);
 	h->order = order;
-- 
2.50.1


