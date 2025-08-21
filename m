Return-Path: <linux-kernel+bounces-780590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D99B30586
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071BB1CE7F03
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED552D7DEF;
	Thu, 21 Aug 2025 20:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+v4RC/S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935D62C0285
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807163; cv=none; b=mHhKz/gtFlckBVcDI1rhwpwyUH7r0CgrZeJWDEfVyBnu506PD/IObvesiUx9UXGq8Har7evV0fS1b7PRvAyiVMaA4fZ1k76k3nmUTdQhygoOUuPLIYMJUV+d8pFpo0f5+n/+18FC4KGWz9GDZvmk9GY1VGE9FGCLjuwQpz4roLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807163; c=relaxed/simple;
	bh=tCsSQl+WRq69JZRVPLbubBOBHgSgQIUjNop92vdLyr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGdQRnIYR9dgg9ERpSUALEC/yrpVSxLtPH0ixLNdWe2tisN2mQBjOhn/qsijYUQoim4JyTFPjeGsmdRRNMm7c7e90lq0aKGNhrO5/TzaB4glAb1AYoxqMaCU9eX1wIpS8SVjIhWZSzpx6Kf3pKgbVDZf8ia9YslkOcFfT7hGOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+v4RC/S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755807160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wK69Pd9CHZjKZhmlaft7kkJNdToX7IH/S9WvVIRScQg=;
	b=V+v4RC/Spx+pLZQPEfNd7HbHpn/jXXupPOYZOzLnqMTsvxz4y+wB0DH16+waJ/bSxtqnUO
	CoA3g3tYKuYiBiruwNh8yg1WlZ3CP958TsdSpEQ2FAs/u4pyRRfHacKj3ZuFdrYv7QFJAp
	KZ5EMmQgCT2V5CgTZ6hKbnc4w/Zd7us=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-gDEBGb4YOZW02XWYP41PEA-1; Thu, 21 Aug 2025 16:08:39 -0400
X-MC-Unique: gDEBGb4YOZW02XWYP41PEA-1
X-Mimecast-MFC-AGG-ID: gDEBGb4YOZW02XWYP41PEA_1755806918
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9d41b88ffso838828f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806918; x=1756411718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wK69Pd9CHZjKZhmlaft7kkJNdToX7IH/S9WvVIRScQg=;
        b=jd11zGf7ZZp666a1k4wZIwyQfdhF22KcYFqNmGAW4gE1V5Rg5Cjg6dh2uSY7CJhdZo
         yhoWVGmVNk+ksU6+/w0IFvvYMe57mXm2Q3o747u3ByJFMdb+Nudzpskckhk1BTTL3MK3
         4JjWlN5k5PS5nTcy3nmGSymKp9r8GZaJYiAGk05fmy52kkYUHYu9HT8e9RG2KNIYmTHF
         45IWbzU1LSNl0L0XPqVFs2m99AbpjPnOk0Os29b2ZgPVpwt2UFU7Hgh2TXIPwUbNbPe2
         Bn5ziQsJNgReeqWKHf6ka/pdPPU6GYDZlZS/megEny5O9jCDN/rzGu1K2Lih+d5/sWau
         8izQ==
X-Gm-Message-State: AOJu0YwRlXDRX0wa0iW4OcaqbNuyG5ikm+kKvJpESr3lo1DTMTUgMdLc
	8kkuyd6niK8zG7C7dD4Vq0HvdzzlUqUWgzwwhEDEplT3FQfVgnSOfjRATbH5fMr0QUt1DgPPQHx
	RKrVw2TrPubQeYd4b3SDu8KPwc5Lm2d2gFsrfvYGZceUB0izY6dk6yc2WZzcSXUXcWN96bU+63O
	gl6AOJY1IHArVJ80x1MACYJQ4aBVAoacL+TtqtDJ0LR6QTp6WU
X-Gm-Gg: ASbGncuZbwf7ISphiSo0b5YZIOhQ/7g9tw8O+yd4Z5+b4/IGC1JOvx1IR+SbP0yFZ3w
	ZsMBbr5I5wugcsIM16m/VPywPKsxYjZ44O4YnVf6Qn6MTF4S6mbBhebiVqXrnpTOqdJbQcqwh+x
	fSlHf9iN7BNwt2eG78r2EoLDN5fppgf0TOnWb6JiO9h7M6JZa6lp9Dyt5w7y/cD9U94RHRVOFI/
	+o1mtab/VwlF2MfBsD2oR22a96+jmhmXzZSBT/by49zltd6d8BFvKH4SJul/1uh6kDgtEOkz8Cj
	MAeZMkfmDm57giZW+61wJbRqdyg0/YnQmz7i/tiAIP4WzyuTi9LEET3cIsHSIh9Vwi1WUvVUPmV
	ugt2WH4bSXYw/8vWyEnEk1Q==
X-Received: by 2002:a5d:64e9:0:b0:3b8:d7c7:62d7 with SMTP id ffacd0b85a97d-3c5daefc298mr218344f8f.16.1755806918042;
        Thu, 21 Aug 2025 13:08:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETBfJ8klmP3LMs+G3FmlUfLKA9Qlb/rzelQ5gyETYamNwKefh2PCq6Da3p1XS4Ia+K1NPGrw==
X-Received: by 2002:a5d:64e9:0:b0:3b8:d7c7:62d7 with SMTP id ffacd0b85a97d-3c5daefc298mr218279f8f.16.1755806917364;
        Thu, 21 Aug 2025 13:08:37 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c4ccbf04fasm3355197f8f.7.2025.08.21.13.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:36 -0700 (PDT)
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
Subject: [PATCH RFC 32/35] mm/gup: drop nth_page() usage in unpin_user_page_range_dirty_lock()
Date: Thu, 21 Aug 2025 22:06:58 +0200
Message-ID: <20250821200701.1329277-33-david@redhat.com>
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

There is the concern that unpin_user_page_range_dirty_lock() might do
some weird merging of PFN ranges -- either now or in the future -- such
that PFN range is contiguous but the page range might not be.

Let's sanity-check for that and drop the nth_page() usage.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index f017ff6d7d61a..0a669a766204b 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -237,7 +237,7 @@ void folio_add_pin(struct folio *folio)
 static inline struct folio *gup_folio_range_next(struct page *start,
 		unsigned long npages, unsigned long i, unsigned int *ntails)
 {
-	struct page *next = nth_page(start, i);
+	struct page *next = start + i;
 	struct folio *folio = page_folio(next);
 	unsigned int nr = 1;
 
@@ -342,6 +342,9 @@ EXPORT_SYMBOL(unpin_user_pages_dirty_lock);
  * "gup-pinned page range" refers to a range of pages that has had one of the
  * pin_user_pages() variants called on that page.
  *
+ * The page range must be truly contiguous: the page range corresponds
+ * to a contiguous PFN range and all pages can be iterated naturally.
+ *
  * For the page ranges defined by [page .. page+npages], make that range (or
  * its head pages, if a compound page) dirty, if @make_dirty is true, and if the
  * page range was previously listed as clean.
@@ -359,6 +362,8 @@ void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
 	struct folio *folio;
 	unsigned int nr;
 
+	VM_WARN_ON_ONCE(!page_range_contiguous(page, npages));
+
 	for (i = 0; i < npages; i += nr) {
 		folio = gup_folio_range_next(page, npages, i, &nr);
 		if (make_dirty && !folio_test_dirty(folio)) {
-- 
2.50.1


