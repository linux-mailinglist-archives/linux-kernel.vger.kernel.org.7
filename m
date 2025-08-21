Return-Path: <linux-kernel+bounces-780585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AE4B30576
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85EA62252D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 20:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A73A37E8FA;
	Thu, 21 Aug 2025 20:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfFLyn1A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396B3352FCB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806930; cv=none; b=gq5rrNfAhXcGgl7CIVk5SgvbdfB1cpkYk9Y1SH3aowfCVt14/a5ShGaq2Nk0ykskD1gomNpDK/dHFhTA3l1Wj2IJccnovjYLVTMlE7/2gXXtZN2Iw5M2LaoQefUCaSN9+7+4JDzrpgFHq3xNRcEOxu2vyBuQP2P2fw5UxGNni4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806930; c=relaxed/simple;
	bh=izYuZWtM9expuJ4aw1W3JEFW5k9djBINp3Pti4HydYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ub3J/FroVF8M3eHj3DGt6QkwQc4/03qTiDAwz1lELTebTdM4MlC2vbobinlLfaMiw4UJemIaXgxAmgMcz50POL4RBDCy/j3EM2NXDUfBaGaG48XRmUk9dcZjLJAh5uvZ3rUS7zTqSOJqf6qaalY75yLkU4SVjc5LZqT4+ILkICM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfFLyn1A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755806926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z7iPpUiW3LrFM0W3XrB+Z82uodwKTsefoCzXwhLbLUo=;
	b=BfFLyn1A3XUVMIK7uWjBslQ/m5F4eZHOGDiQuVm47rEGkd1Qi3fOYJdvSTYrt0cvWmMHVK
	oliEGHlLVDNhj7HJNikH54vLF1sA8w7ojbTlg2u+aeEWboEMIDKE99cXIcQ0FTla0A7+Kb
	WFYeNfLl6kwIgaKllu8wQf/1LOPGMk4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-yE00JGsZNsme9YE7sViW4g-1; Thu, 21 Aug 2025 16:08:44 -0400
X-MC-Unique: yE00JGsZNsme9YE7sViW4g-1
X-Mimecast-MFC-AGG-ID: yE00JGsZNsme9YE7sViW4g_1755806923
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b9e41037e6so864603f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806923; x=1756411723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7iPpUiW3LrFM0W3XrB+Z82uodwKTsefoCzXwhLbLUo=;
        b=ZdzWqoXCLx4h/CaY/SbN1s34FJB4V58Lqi36x0PtQ3U2amBxV/BUnbogZLc7oWDFp4
         ZCKA6+9kjCDRvF9z7MtwNr1/G/rTHmfft/EsOJCyoHYQ55RtjfQfmwlVzgYB28h9q33Q
         rcTkxVld4P344U3wcN4gFo6WNCE6UPuZ2eUT8DOZFejQa0/WCl1Kkiq2erDT4xdQdEuQ
         AcfzzUzACjvHtRcXO8cFmCrvw3nTNLUsprNO51btPsNVaEkPK3rGzTxdW1hf+QiKsK8j
         Uzh18IxJNAklD9M6bfOnvVZxSPzIe0wzULAjMX9cLolFQWzhWEd/7RftSP2oqQnSGL2i
         iwBA==
X-Gm-Message-State: AOJu0YyVRlIm+VDFV+TGyzO7JLvlj8lTiIgN/Qk9wCFLL2/bNzrG8t8m
	Q2VEGluNMIYLgu5+1GxsrJnvPsCr7v1smCBku4YTJPQQ4kg2uJw7uTEDT+GhASMj/mlx51l4Iwe
	G2OBkoQFeUpjXYCZ+BXjNsvJYQAdwmWqEbXVq5ddhT+TLrMZJNBnWC3aPiN0WdRft66sXwguEN7
	JPkAr9eJKaIo2HqyJZQJNsbbP+/WI+828BzSJy/l8Pvnxazn2l
X-Gm-Gg: ASbGncvN9nyA7TM111tbJBH/WHgR88UNia2r1yP2SOCzewdeLLDUijTCuoaUG4B8WEf
	8GJUVcVentxQycxi9OkcwiuEQfdjj9l/zKGWy5ufnZKoszSBcWrqt6P77WpBN85zG2qV6OBV9tn
	iziHEtKbgCP0nXmkEGj3qGzg2Yabj0plUA0NL+YG4ehxahgoKoPuT/A7jTMOhCx/lDuRZfEdSgy
	EyBj9HY2b3n5oZOiwKxPPAHfdj29XT0pU/+expsAHiVfbj57pwmsa2bb32I70E3/Z5frRGScmDl
	E/eNajny+POg15a7psPW6e/xu8vPbLtzG8w9zqp/AiLzDxCG/+tq6KECIOEW7JgWhhjARAOT1Oe
	6w2QYFpy1mBRIDQxogN3n/w==
X-Received: by 2002:a5d:64ed:0:b0:3b5:dafc:1525 with SMTP id ffacd0b85a97d-3c5dc7313famr204708f8f.33.1755806922998;
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnHzRKC08dohUKQD/XdldMc6IWYVddiLtTh8Yidep5vx+5++gzVG23SiimMwYZ+HldR36Zkg==
X-Received: by 2002:a5d:64ed:0:b0:3b5:dafc:1525 with SMTP id ffacd0b85a97d-3c5dc7313famr204645f8f.33.1755806922505;
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
Received: from localhost (p200300d82f26ba0008036ec5991806fd.dip0.t-ipconnect.de. [2003:d8:2f26:ba00:803:6ec5:9918:6fd])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b50e3a587sm10028205e9.18.2025.08.21.13.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:08:42 -0700 (PDT)
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
Subject: [PATCH RFC 34/35] block: update comment of "struct bio_vec" regarding nth_page()
Date: Thu, 21 Aug 2025 22:07:00 +0200
Message-ID: <20250821200701.1329277-35-david@redhat.com>
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

Ever since commit 858c708d9efb ("block: move the bi_size update out of
__bio_try_merge_page"), page_is_mergeable() no longer exists, and the
logic in bvec_try_merge_page() is now a simple page pointer
comparison.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/bvec.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 0a80e1f9aa201..3fc0efa0825b1 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -22,11 +22,8 @@ struct page;
  * @bv_len:    Number of bytes in the address range.
  * @bv_offset: Start of the address range relative to the start of @bv_page.
  *
- * The following holds for a bvec if n * PAGE_SIZE < bv_offset + bv_len:
- *
- *   nth_page(@bv_page, n) == @bv_page + n
- *
- * This holds because page_is_mergeable() checks the above property.
+ * All pages within a bio_vec starting from @bv_page are contiguous and
+ * can simply be iterated (see bvec_advance()).
  */
 struct bio_vec {
 	struct page	*bv_page;
-- 
2.50.1


