Return-Path: <linux-kernel+bounces-829032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53582B961E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EF024E2E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECD21FAC4B;
	Tue, 23 Sep 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuNG8HXR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4B34BA36
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758636069; cv=none; b=oX0qD6TQLE1YS4UutBXgrfdrKzfHtIaqDLckwXeme84Q+aNAONesQO0gLxGpPZreQZYYtM68uoHxGZB252IAikmhRnwvFEKIRR8lZZde7LLmDyDEdswVXPD8hUaEZz2upiIKUYrd0I//dbYxqWQJPWJBqXPDWNdGutNOo1wh5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758636069; c=relaxed/simple;
	bh=nb2IBQ5wTq0D5BxCpXD4CA8iasEixpkGBsX33b/sPRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sgm3IbxKRGat9c41VARy/U9VRFdfeNs0oFqZ9ROihQ1FPl3q1dA5KyqNznG8/un+iRR5oJ0axXSDQKg7USwxEwbttOW95jTp3gaMYio6zK0AneI5k78S+cHELX3lf7yY6jHVkQBggrjiMxcneV/UXRuL2KZA4ekDlnXSiw39Odk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YuNG8HXR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758636066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r9zfyxkmjCESQ8duOa/Grq2TL8+r2DC084netIbpbPA=;
	b=YuNG8HXRa98iIepGtGZDylj7kN4jEqS3m6hQetDUYOncQS/OseM0otOMmdeYd8jJAbLRuC
	hsFlKlyx+5cpY0WkQSJ5azOUU4wCPiegMAAzY3U7iEBPSknrGARHR/RxpXQ+eWe9PMLdtd
	xIs4utqA56EhxJcdtrKvTvkAstnEBpI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-kCPMfpzlN0ufvLtXTLA9uw-1; Tue, 23 Sep 2025 10:01:05 -0400
X-MC-Unique: kCPMfpzlN0ufvLtXTLA9uw-1
X-Mimecast-MFC-AGG-ID: kCPMfpzlN0ufvLtXTLA9uw_1758636064
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45e05ff0b36so11389385e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758636064; x=1759240864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9zfyxkmjCESQ8duOa/Grq2TL8+r2DC084netIbpbPA=;
        b=m7mDH8tELaV55wEEqZk4X0LFIgK+zrNPeblHk1dpaLzrTiBwlISeNCiaAhP/dXEGDZ
         VMuLp/XN600cD4SPTgikx3mmeaGxEVg24CjEdxZFNesfWyQruyrJr2EZgOubgVs7jHkU
         38xZpJtgYFKzZpkxsopkkaK9kKbdLCQjc+HmgEf/68gbG9K+7sZUORXM1Or0cCvRFDg4
         /L+g7kPeulXC4mViQdGThUlXdhDdrkDflqTMpIs0gpbLmJjIySAelSBf8C3ardO7FexY
         +gkOei17VuwDScYxxmey7op8uVUDRbuzIQxKtsw5vBJeAFf6nOE6Ru2J5v0wdknrmwBw
         6IiQ==
X-Gm-Message-State: AOJu0Yw0W0sgFgQYT2LKy6+dtpYnS7y0yFzDfXHYROXjwAdYc4Gd3TeV
	rteNV93XAfZ5w2ZZWzq/Onp0Pn8EhI7G6u9mTv6m7c7L2LMlTdDpx/UoqkgHHc1OSOxHxlAIWMK
	+5JCDGsDi1WhybGwEkODjScRQuFQOJF5rurRPZHWDFJ0pvQBafHm2ldD3JMTA1rGh7cPZYCjD7o
	v/HKuRQuA5HVeoZNMG+zUI5sRaYWZAgX3074+Xeugx5r7YmtkA
X-Gm-Gg: ASbGnctEqrsy0M5xUXsbckLOuNM4LxxMoIF+7QYQ9vJKlkcGgw2YiwvxsaWexZb+5jF
	SKjHnJMbrXYgKDw0z8NKsd6n5zQzdQ2pTCui9c+bxO2+zHypWh0M1vutjNBK1GtzDa2WugenUsa
	EEmFVQw6caIpIH1YKUEibipyD6hP/6k1ZdCkWxITdvwqqMzUOA1RTlw21OB2FjRMvrt26n4OJdy
	u7vIBhIDYMk7YvVUICILnzwjCsSLr/EPwH8dsbNI/zQ84igqoWv65EfRd+G41DP+yzhtprdq1E8
	Ng8JpQI3CaN4gl3QgnaHqr9/CCOUrG1etsaFdLyaJfjjkbAZXkpevCQBLX3qFTAU0Ws=
X-Received: by 2002:a05:600c:4fcf:b0:46d:1a9b:6d35 with SMTP id 5b1f17b1804b1-46e1e167fa7mr27764805e9.14.1758636062567;
        Tue, 23 Sep 2025 07:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzy72VmsUr7RNP34u9SB8i9Mn1d2HLUqmTAVbvDGWXn8O1Qe3RSKx5Tt/IQ9sqOIviJ/KYJA==
X-Received: by 2002:a05:600c:4fcf:b0:46d:1a9b:6d35 with SMTP id 5b1f17b1804b1-46e1e167fa7mr27762765e9.14.1758636060590;
        Tue, 23 Sep 2025 07:01:00 -0700 (PDT)
Received: from localhost (p4ff1fd57.dip0.t-ipconnect.de. [79.241.253.87])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e23adce1bsm17786785e9.24.2025.09.23.07.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 07:01:00 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v1] mm: convert folio_page() back to a macro
Date: Tue, 23 Sep 2025 16:00:58 +0200
Message-ID: <20250923140058.2020023-1-david@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 73b3294b1152 ("mm: simplify folio_page() and folio_page_idx()")
we converted folio_page() into a static inline function. However
briefly afterwards in commit a847b17009ec ("mm: constify highmem related
functions for improved const-correctness") we had to add some nasty
const-away casting to make the compiler happy when checking const
correctness.

So let's just convert it back to a simple macro so the compiler can
check const correctness properly. There is the alternative of
using a _Generic() similar to page_folio(), but there is not a lot of
benefit compared to just using a simple macro.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 568011930e358..48e27768e7ba9 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -316,10 +316,7 @@ static __always_inline unsigned long _compound_head(const struct page *page)
  * check that the page number lies within @folio; the caller is presumed
  * to have a reference to the page.
  */
-static inline struct page *folio_page(const struct folio *folio, unsigned long n)
-{
-	return (struct page *)(&folio->page + n);
-}
+#define folio_page(folio, n)	(&(folio)->page + (n))
 
 static __always_inline int PageTail(const struct page *page)
 {
-- 
2.51.0


