Return-Path: <linux-kernel+bounces-861950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC2EBF41BD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 02:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B51154216B9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 00:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEF519CC28;
	Tue, 21 Oct 2025 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="ehty/tAK"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8F22A1C7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 00:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005343; cv=none; b=Z9n0XFWNTT9vJwy1JGkfoEomKXJ5cjnb1g9q1MY2cRkT2y8tm9v0Ro2H4z8cAdj9u4fkkslLqnlF2upS3Zq99o4iwi61nV6dKhxPnmfNIfGCZR4AV/oqjc069UueEjkqV2Thl7gdId7nowxoDBhHiqJR0QCZI8378ncxWnXL9C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005343; c=relaxed/simple;
	bh=xIuMw8XMRWLgufCuYNoWPBcLu0nLGH0NZhBNT+EtTIA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwwMWagKA1GdeLv++TopwQfmCTaDPBKjNsDAm0km0IOd4TT+t6Ukpwy4QigsC6ILhjE1hut//tIhUMaKF5dGdeRUk6NRIkx+myeNx2f+TR0CY7gukiQshq7vDYidDbbCCkhqqNKhqlH3NSHggJ53TR6O+FXpu9hVccr0wXKHWJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=ehty/tAK; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54aa789f9b5so3558330e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761005340; x=1761610140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+GEFK7rnEt3wQnfXqm/bMcNjTmF7K5naCxuLWf6Icw=;
        b=ehty/tAKFGHks2sbLBfXKyRy3Ea3aFc0DeyOIhbFbeFW5DkZJTUQHhdxdloUiOTExU
         Zo4O7cmT2FAwnt40WXhUDIxI7E+iaEY+sMTJlDvcbZQr3IoQv9MgDzFdhvI5mMp2posu
         T6RR1CPDy+M/1DrYCioPXB82XTFlrdxlQSfCk8lRgluKMgTYx8qSlnWiDy9YEYWIjdNC
         2T/T7ZZJbDgg476jM2X6VistbNA6MCW2xztM5G00yIIND9If/O4ep8HTRq1cHho7quVm
         hN3KT/glYqPgbrcN4v08Ng4moIt0D68j8Qt9o1RS8MiSIb6B4mauFuQO4VdDGBJFM2nT
         dwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761005340; x=1761610140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+GEFK7rnEt3wQnfXqm/bMcNjTmF7K5naCxuLWf6Icw=;
        b=JgpUpmx/PSER2IbVKLGEQwcM5pnRUnpqvK/D2o2m6XJzrf5Yd6cvmLtm9LKcAdUlkt
         6ogdGbAfkLnxGYYYpIrBYuu8rKrpnlUCVaxUXeNPho1L6ZkMJScsQp6LKYA+ePTZUZKN
         IMnqxzu1hifewGda5X6yBWyaeVZQmUMPfY25JJ5MggH9Z91EJDrzKmf0p+3rJC7ptf7g
         FsdAglEJCXENZHN/+PpalE4Fec1uUtfG65BwdRRnziNtdKmanNGfT3Nhl5w/uuIyXreI
         fsGqK7uSak1xuUV+K3OSOjJPoPlCYjTcjOsNL4C6onurbLOsDQa0yIWhYMY+evjB9ewO
         MQ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGunHgTaX34+JFLjxuhjCp8ToH+9e6ESyfDm06Ik2KSUST/HiAXsAl7YupJsI3JGu2AUWhjc4VQoEipBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyw/Qcv2K/9BWPeHQdM5S03ov/3CE7ug1L/AELsytIsj4Qd/5w
	Sg4ER3dWMlZd05vZtMu2i08ieTz2wysN/pU7X0JEVTzch4PQqST/OA63OTLg5A7EXP8=
X-Gm-Gg: ASbGncv43HOidiI4NL+NI4+Dx9sVYbXgg708JTRRThrON2tkB/iBrN1siEuFPAokzuF
	TtTDE8uoL1utrXhKw3NVKTYLJWHyGrVcH68WF1thEXlGIyqi4QGI/S2+6aA2H3OTAClczY7mHNz
	D+nIzQQqq5GhO0HwmOUEj3a23ZYjNT/YUC+Y9hZuj9hNAcLXzdMWGAz5hA6KvQX/APFr3zjrTX8
	yCasbqV9Z4fMlm2zRnC+RqkDL2OR6kze1H54QW/TjTROB59rnyIEQJ2BXW8+kAVHw5SVGnU8ya5
	iE5C/VdUu+VwY/qW+ep+6njpqNcFWyH+Isa3qv3GY81sTPje16SEoV2tjpWEMkyYUA95hk54b1m
	n90bFxbM9QEO1j76bAPxv46Ss2raHde+lQpwn0HzT8HS8+TFHuJzFJMey+ZBTyNowWqmcpUddZ+
	yQ1lO4V4qHxieL1SyLw76rGdov5pRN2Rwedn9BZMKGmPJprw+QmKxVka7XCYGqH8bPm0RVNFRQm
	bmA2fsWSpFveoRR08FPo8ofaqGREAQEUV86ZZ9fD/I=
X-Google-Smtp-Source: AGHT+IEiKbkHyTIPqxuiQK/s9jE4arlePP4EQ1uFjj4rccnMC3Ytmd/xdu5/e3ZeVXOoj3cegKmXtQ==
X-Received: by 2002:a05:6122:2222:b0:54a:9cff:6fe7 with SMTP id 71dfb90a1353d-5564ee53244mr5078357e0c.4.1761005340123;
        Mon, 20 Oct 2025 17:09:00 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55661f6e351sm2822882e0c.4.2025.10.20.17.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 17:08:58 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org,
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH v3 2/3] liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
Date: Mon, 20 Oct 2025 20:08:51 -0400
Message-ID: <20251021000852.2924827-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
In-Reply-To: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KHO memory preservation metadata is preserved in 512 byte chunks which
requires their allocation from slab allocator. Slabs are not safe to be
used with KHO because of kfence, and because partial slabs may lead
leaks to the next kernel. Change the size to be PAGE_SIZE.

The kfence specifically may cause memory corruption, where it randomly
provides slab objects that can be within the scratch area. The reason
for that is that kfence allocates its objects prior to KHO scratch is
marked as CMA region.

While this change could potentially increase metadata overhead on
systems with sparsely preserved memory, this is being mitigated by
ongoing work to reduce sparseness during preservation via 1G guest
pages. Furthermore, this change aligns with future work on a stateless
KHO, which will also use page-sized bitmaps for its radix tree metadata.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/kexec_handover.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 7b460806ef4f..e5b91761fbfe 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -69,10 +69,10 @@ early_param("kho", kho_parse_enable);
  * Keep track of memory that is to be preserved across KHO.
  *
  * The serializing side uses two levels of xarrays to manage chunks of per-order
- * 512 byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order of a
- * 1TB system would fit inside a single 512 byte bitmap. For order 0 allocations
- * each bitmap will cover 16M of address space. Thus, for 16G of memory at most
- * 512K of bitmap memory will be needed for order 0.
+ * PAGE_SIZE byte bitmaps. For instance if PAGE_SIZE = 4096, the entire 1G order
+ * of a 8TB system would fit inside a single 4096 byte bitmap. For order 0
+ * allocations each bitmap will cover 128M of address space. Thus, for 16G of
+ * memory at most 512K of bitmap memory will be needed for order 0.
  *
  * This approach is fully incremental, as the serialization progresses folios
  * can continue be aggregated to the tracker. The final step, immediately prior
@@ -80,12 +80,14 @@ early_param("kho", kho_parse_enable);
  * successor kernel to parse.
  */
 
-#define PRESERVE_BITS (512 * 8)
+#define PRESERVE_BITS (PAGE_SIZE * 8)
 
 struct kho_mem_phys_bits {
 	DECLARE_BITMAP(preserve, PRESERVE_BITS);
 };
 
+static_assert(sizeof(struct kho_mem_phys_bits) == PAGE_SIZE);
+
 struct kho_mem_phys {
 	/*
 	 * Points to kho_mem_phys_bits, a sparse bitmap array. Each bit is sized
@@ -133,19 +135,19 @@ static struct kho_out kho_out = {
 	.finalized = false,
 };
 
-static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
+static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 {
 	void *res = xa_load(xa, index);
 
 	if (res)
 		return res;
 
-	void *elm __free(kfree) = kzalloc(sz, GFP_KERNEL);
+	void *elm __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
 
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
 
-	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), PAGE_SIZE)))
 		return ERR_PTR(-EINVAL);
 
 	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
@@ -218,8 +220,7 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 		}
 	}
 
-	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
-				sizeof(*bits));
+	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
 	if (IS_ERR(bits))
 		return PTR_ERR(bits);
 
-- 
2.51.0.869.ge66316f041-goog


