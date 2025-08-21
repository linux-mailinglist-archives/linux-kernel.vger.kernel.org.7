Return-Path: <linux-kernel+bounces-780552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F65B303F4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1F3A23629
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBD434F499;
	Thu, 21 Aug 2025 20:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gpsj5xLh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A434DCE3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806836; cv=none; b=fE0j/ys4mtskUS5BcPEZThV9IzK5jCgHp81X1IXj/bNUkzs2rng/Rai89Hat/8HVWAZuFvucOGxGlH9DiwYe8KsRB0bJZTqY7RzgJVPulb99aPox3bbUefwBxNySed72kUYXb+Ab000uZalDlAiXYNmIdbt+j2udskIQ7PkXi3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806836; c=relaxed/simple;
	bh=6nSseGe+74q2JGOSoz3zO112Eo1zTQLz4H2FdYfsyUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkNq2cwDcrssQsD3LFpMF60XpNA23vFFsBts1WltDaR/z3svxog8bAZWYkKaoT0bW/7ViuJS/R+5+xMutGMvzj/xIg4FX7JrZL4KijoNgDO7pF5kuZ7RGRL52vr+GZGTKhtUgCyF3AL/afhQyWQw8Yt/6pzX63ohLBgvGjByCMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gpsj5xLh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XmvTcrL5C0dM7rPtm73IEcsYc8PUVzmaMdzwCc2EnvI=;
	b=Gpsj5xLhTVAQOWAG/6cwI+51yt7xTehBlujO1Xuspshnj8UDaL6k85ikQ3oxi/NjhxFWwy
	4PQUF5gUgRgdF1PNa0q2SAeOjJp7mwgK2C9/FMtbWCXkjvtP3g0jaWpabvGLZBAsHIHJjY
	TfTs4wQJGui19rUEYrNkD3ooKiUFK28=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-gPYQh7XCO5mtaWxZTPnppg-1; Thu, 21 Aug 2025 16:07:10 -0400
X-MC-Unique: gPYQh7XCO5mtaWxZTPnppg-1
X-Mimecast-MFC-AGG-ID: gPYQh7XCO5mtaWxZTPnppg_1755806830
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b467f5173so9412005e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806830; x=1756411630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmvTcrL5C0dM7rPtm73IEcsYc8PUVzmaMdzwCc2EnvI=;
        b=qYbECLb0whVP2l0WtyZI1FsL4SOUqA68M4GcJvkwhECx+BVPlDU2K4GdJNoqUuD37U
         SA1BmSModYjyhKg/EOBbKwBs00za1n2lisgS1+kPHWLOzm5GWhqSeMRfxJavTCm1Z27+
         ux2XsApp07bgTwKqq4cjUAcvskW0WfM7Px+pfQRb92BM/gkrC+tlbNlWxfPxvjGGYEfx
         bJbk8w2VD8r1J9RkbWinUAyzYt4FHlT0pZmkvmj/T8sr6oX43xprBtT/9FcJYLloJCOr
         uo5PPYEX81n+IppzncEesX7BDvh/5ozAnX8rNVGdyrD6VKDySAkNEwPlVhu7yZU8dJde
         l9qA==
X-Gm-Message-State: AOJu0YyETW5eYlDc/PLlYh1CIt2fKLhrKrygZ/JbckEiZIcG60WPMbWv
	LD+Kcp4LRUpgm5lOLk08slrbuwncx7ZeljFmadFaKHiK75N6jvTvVrKHemDgxPkZqfjBbqHgsCh
	Tnz5aTQn82TCLzT6sP3vw1K6Iy/4Eg/Qi6Y8lwABInpQVkCYkD1zcht2WagTpHE34v3EsJcYSJj
	wZ8rzxp4h48zEN+2oX0Yd8A7pM2XXQ1kemtYMppzJ66xkfyOOw
X-Gm-Gg: ASbGncsvfNx3bzrVhtFzwYbaFuxSCqFxE10GpPIhl3C5LS8zKUE3YInMmeJmHsmJ3K6
	aqABAQ0RpKYTGPxV9vHgmF2N0AEbWWLiDBB6XV1G3IuE8wCAtSdnYBK6h1PzCMM5U/rclhsNSxC
	NhNTKBKBjyi46m7o+d267JDrV5H1ug01KH8tiCgI1op8JptFfu8f8TC4V5L0aqqxMrdEZ8ARCM3
	KZEuxpGaHmhRMbad9QHR18KYqs8Jpzyuan7y/MgLtN+Gzx9BN1QgyqrLwPVpbMxe+oCwf/INC79
	9qnFMzdWKrOFTSBXKEhymPm4Pu95f9f/rMr/rKc7sLyB0PP2NpyOuHBYFJSFuSjQa1hV5dMyWT/
	7+Y2jn41ekha6+63vQo8Z4w==
X-Received: by 2002:a05:600c:4506:b0:456:eab:633e with SMTP id 5b1f17b1804b1-45b517c5f34mr3673995e9.17.1755806829625;
        Thu, 21 Aug 2025 13:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvYkVaGxfZdplMxnR9eu9+L8mDJqjqWM2enq3Cze2cE8zEp05huuco+bDpuuERUQ/1xaOAqQ==
X-Received: by 2002:a05:600c:4506:b0:456:eab:633e with SMTP id 5b1f17b1804b1-45b517c5f34mr3673145e9.17.1755806828996;
        Thu, 21 Aug 2025 13:07:08 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e1852asm8722665e9.25.2025.08.21.13.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:08 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
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
Subject: [PATCH RFC 01/35] mm: stop making SPARSEMEM_VMEMMAP user-selectable
Date: Thu, 21 Aug 2025 22:06:27 +0200
Message-ID: <20250821200701.1329277-2-david@redhat.com>
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

In an ideal world, we wouldn't have to deal with SPARSEMEM without
SPARSEMEM_VMEMMAP, but in particular for 32bit SPARSEMEM_VMEMMAP is
considered too costly and consequently not supported.

However, if an architecture does support SPARSEMEM with
SPARSEMEM_VMEMMAP, let's forbid the user to disable VMEMMAP: just
like we already do for arm64, s390 and x86.

So if SPARSEMEM_VMEMMAP is supported, don't allow to use SPARSEMEM without
SPARSEMEM_VMEMMAP.

This implies that the option to not use SPARSEMEM_VMEMMAP will now be
gone for loongarch, powerpc, riscv and sparc. All architectures only
enable SPARSEMEM_VMEMMAP with 64bit support, so there should not really
be a big downside to using the VMEMMAP (quite the contrary).

This is a preparation for not supporting

(1) folio sizes that exceed a single memory section
(2) CMA allocations of non-contiguous page ranges

in SPARSEMEM without SPARSEMEM_VMEMMAP configs, whereby we
want to limit possible impact as much as possible (e.g., gigantic hugetlb
page allocations suddenly fails).

Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 4108bcd967848..330d0e698ef96 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -439,9 +439,8 @@ config SPARSEMEM_VMEMMAP_ENABLE
 	bool
 
 config SPARSEMEM_VMEMMAP
-	bool "Sparse Memory virtual memmap"
+	def_bool y
 	depends on SPARSEMEM && SPARSEMEM_VMEMMAP_ENABLE
-	default y
 	help
 	  SPARSEMEM_VMEMMAP uses a virtually mapped memmap to optimise
 	  pfn_to_page and page_to_pfn operations.  This is the most
-- 
2.50.1


