Return-Path: <linux-kernel+bounces-780567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A37B30498
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8F816BF45
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B035FC17;
	Thu, 21 Aug 2025 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ibk57JeW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C635CEC3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806878; cv=none; b=dPFtPupTzPQK677ZKdT7qXTrNLefHsYMB5QIKM2MBO1R0mLWaZmlf2UOZyYOwrk0iFaXCm/83Fcfyy6v8NlZ4ad+MESJ4rQNiPHjxWBNMZIsJXu0tlu3Qg+fPTYO32/KvCiOFdFlh8hmn9JA4Bsr+cRkptiiOSU3d8xDL+5OQFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806878; c=relaxed/simple;
	bh=DqyVXDGsUgZb9r/3HwvxxZbRj3b/8OImyDb3ud4Q1pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/tT9EmJ1f1QwRejbJDx+7Li0TTHbcJkeRnW1PG1GPYDsCKYSYwdvxHzegmJHDpyTp9aKlIRwIIcVVWPGvRIycLniEUyu/bggC2xdzq34aqEBnNo87eUw2bVzvucUcqyZ9X54zhVRWJ4sXkJrSFCInq4i0sqTwTK/IbaL7CF4uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ibk57JeW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCvnB/7xI7T/4p4mwWx/D4+W6s//h9G2+oSyfbDOFZs=;
	b=Ibk57JeWoGlmYmhEGO0mKqFFj7juZc9klc56ivvxd6emwSHYUf5E5WtJTxvTnWUV9Qd2QY
	m1LVc02TAYYhUQm5CU9NLYfhKREWI0RmzBTrK6+boeFsd5I+YhLqF+rAo9Ya/u5ysDeMvj
	Z4Ya7F8irll0NLQT7VgESlWogDxzBDI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-MxA5xqXZO8Wqq41dANvRGA-1; Thu, 21 Aug 2025 16:07:53 -0400
X-MC-Unique: MxA5xqXZO8Wqq41dANvRGA-1
X-Mimecast-MFC-AGG-ID: MxA5xqXZO8Wqq41dANvRGA_1755806872
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b4d6f3ab0so8379635e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806872; x=1756411672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QCvnB/7xI7T/4p4mwWx/D4+W6s//h9G2+oSyfbDOFZs=;
        b=H3hq2SCTQrNrLEZnI7julAXuUFjCwthd0XDxY7EY8+X0rPa1bW3Nkc54Pr2h48Ah1N
         y/TqS7iatiyhqorSaZwfkJ3iterHsDmjpvq+19AjupFGWYNgWV/uNIWdaf4Gy7743eHr
         EckubyHzlbk0SvIPV0D08pdDRro6AbmGPmORYxwJWy4YG4OwvI20FdQqJ8G3KC+boMfu
         z3xcMb8f1fvKekOg2X8QdEwyIjARBOUy/bzb9zTmVFQz9p9OnFze6Chbal6V3cnGIYFk
         JNPVEvMlA+3LyjI79sN+UY6uHNxg8C2xYBB+oI7dH9Bhdz4OdNHeE3sBndyXWhq1bNn7
         Wwow==
X-Gm-Message-State: AOJu0YwtYHxY3/hWYwsMdsyrB3/qQf8wy58xZDUippHAY1+SZhYtGkdq
	Zi+OAKX8/0bsCAXone4BpvcLXzCqdUAUC9dEmeTdu2lVwH0oZcH0CAge7H2NvFJ/VvNyJ47mWBl
	fS4lZvJ5tWkLGs+T60d0PQouU4Edx5+ZaMLWRuJk/pSrHM8Dqd66mTf2f2US+iWrZ32m3/38HPr
	yOvJO5kboByZFj3Ryu+9qPbeb3GOWk/o6P1/bqm/WhyvLXJTYT
X-Gm-Gg: ASbGncvA1tRFMNH+ew2YU5YwWz/r+1w+EpJAdmT8UE4Oeg3WgSucOPKln100XweuCel
	xdIG8voPMtuY2MmcFcAj6v14p5ZR9cAGoj1qzDeYjNlRSUauR2Bl2fv77EGxFjaxe4Zh3+w2zYn
	dMdvKZqrklbpz6iMDlBkusdw+G4PxzwwlZyJhoIRF7kJMGbrcx61tXNZG5vnMnTAX3+NFZEQLdV
	OSgj8KhMog6wRqBMobtMU+GJm3gw3phjdOy2vDh3dRdtrL6mPr7KyAE68Z8fM3+f7CPcYbkq7rC
	77nGVV3GhK2+x/min/k7mjuZ5uZ+CKRWf+5xYtUy2rGKoJq+wILDtNYnOaL9O/9WZI8v9ZFIeUK
	AN9Rpv+JjgWEsfOxZXX1ynw==
X-Received: by 2002:a05:600c:1d07:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45b5179e897mr2279215e9.10.1755806871888;
        Thu, 21 Aug 2025 13:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQe1GSIQC6LfutgynQLrqB1o4Jo0GTrBjlhxRWjM7nqTD8l8oEo1HOcPxtIuVQVn3tsHm8QA==
X-Received: by 2002:a05:600c:1d07:b0:459:e025:8c40 with SMTP id 5b1f17b1804b1-45b5179e897mr2278575e9.10.1755806871147;
        Thu, 21 Aug 2025 13:07:51 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b4e1d77e0sm22159155e9.0.2025.08.21.13.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:07:50 -0700 (PDT)
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
Subject: [PATCH RFC 16/35] mm/pagewalk: drop nth_page() usage within folio in folio_walk_start()
Date: Thu, 21 Aug 2025 22:06:42 +0200
Message-ID: <20250821200701.1329277-17-david@redhat.com>
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

It's no longer required to use nth_page() within a folio, so let's just
drop the nth_page() in folio_walk_start().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index c6753d370ff4e..9e4225e5fcf5c 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -1004,7 +1004,7 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 found:
 	if (expose_page)
 		/* Note: Offset from the mapped page, not the folio start. */
-		fw->page = nth_page(page, (addr & (entry_size - 1)) >> PAGE_SHIFT);
+		fw->page = page + ((addr & (entry_size - 1)) >> PAGE_SHIFT);
 	else
 		fw->page = NULL;
 	fw->ptl = ptl;
-- 
2.50.1


