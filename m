Return-Path: <linux-kernel+bounces-859323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05476BED4A8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 753BC19A4EEC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355292512C8;
	Sat, 18 Oct 2025 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="E1aY8Eou"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B83A261B92
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807892; cv=none; b=jSQEPng+zy5s0S1iJ2SC/QBnaMTCDSqMCxjWO2pfjD0nxGloMdsMLjC8yc3Mzv5oLxoHneaOFkOlwnmt5Bxc83FgSXFopG5+DqlRJ+Dxcg4ZwYSNKfFDGKiBiD4ydseVEFiZ1D4VJK8So8OmyBUx6VVA78z46a0Yp5P0ZAa3f2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807892; c=relaxed/simple;
	bh=3WWC3nv053Mu9XPdOFn+xrlFtzqec5hSHDB0nXy9HI8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0wnh09FeFc/Qkmj9GZB7itf/2ZhGoyZIh8aeeMlu6d8Ys8OVv53m3NUH+NqGrClHTmvfT1ed1WuDz/a2grWW5JyJ15+9lMnxrGh0hMkz2MsZg9v0FNLlSWuinECBLB1ZD1K5isoQbJyrHlzaSTDSgDWknwR2sXfz+y+HVXa2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=E1aY8Eou; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-7946137e7a2so52664686d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760807889; x=1761412689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+4s/LMKH18C3S9kWxUuCFP/sSm2GXOGXRSXRIxgHJg=;
        b=E1aY8EouFucyW8bbwCYfa7o6TUN9ne+AiwHCYZyJ2uCnz2WIcfUfUPEyibc7OPOQTU
         GJMV7RkQlgzLpDb5TzZEH51P4uFBVHRaUK1rfbwcGXi8youOEoXnaRa7NRkT3RO+DOPW
         nvMj7OoycEjd3Ty0mjofSCmviQxq8ImZMnMpNjE8qDipGMbHULaBxYVXit6VjcMZf4UR
         AImhFMgUukD4NV8NwvESBUIIKKY0IHytL+tV3KgCz4yfsWmINhc98hv3v2e/4S5NFWl6
         UiIIIpipcA4ChFrJgRDoGbKetVPG8tcizaWosX1DFtr19PA2aytKlwy3sTEwOgQUZaMm
         Wr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807889; x=1761412689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+4s/LMKH18C3S9kWxUuCFP/sSm2GXOGXRSXRIxgHJg=;
        b=s6leyrT68Krva3zyErSebtdQNyUf++W1JuUYj+S+pIGaWwRitEEe/foSIiLngDE6UZ
         5DRFyBGsJt0fcmG6mnlj6fBC9ekJeUPFrSGF8vQ1wEZ/Pti5UlN6fEHZm6JQ6oIRB6PA
         2oP5mzf9uZ1eJoS0gjwiUddoYrDzVdkKYLpQQ6DuZYcDPgj+rkPuY03VwNzzmqvIfbvc
         Jm7T0own1NmdxzFtV7L9MCJGuJQzk9Wbj5O1v0xnf7AHpq8pjY+iX/r55VV1nCKZGT8E
         dk/+iuhPSlHJT8tEc4Xc+Gdbxh20plqoKnfhdUswPYBGDMF10igsfGH6/XLQ/P5LaZns
         GLIA==
X-Forwarded-Encrypted: i=1; AJvYcCUJn+pBPdAsmLjydDa9SVrD+SgItRSgktT1UxguQiI0vk3zgDor068RaZR2Zz/om6DZck/xeZYW2YpDmIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzobJUc1LJPkQDtE5PKyqoR69dl8H+xXfLEToJGwlAWg4dqcO8M
	7kq3FJVqT4utDAIuklsi1zxe22whuMQTvORnuci7mt6dPC66e6CcrUEAzfvkEQrYPuw=
X-Gm-Gg: ASbGncsqKPA2cKdOKvxB6HWnHV/NwhAKBtWv3zbDsi8i3EZxighVZLSrpkzuZA4pl0b
	jiw+GNFuERRskmE4SYmD/Yggpdr+dhOdZFioeJ439uO6nFLchn4nfB4JNI+7YZ3lkYolmqX7eSV
	vN7I1uVEoIMpOR1w5aPgnQBe9N58LB90SU8rJ7Hifb2OvJLWPx2nj5rorT6cBfs2W2naRKD1RcP
	oM9U0+rxz48cly/dvVHraHdLV5dZWhQ15GEwuMRHYMx2X4DyjBQOwYtKN36V1pEXTasnNCMnzU0
	65JQ+orRa+UvMvyMirXpMF4upUe4SbZH3JRA/zLBaG/HkFi6DiDeDYpykQq8x8ENvwCvmRcIWjK
	2Da6RLUQNSzi0wBPpM+E9ttGTy4u0jtz2V79crmOV0n1k1mwlO7Eurmtb2Ese+hRAwe09J2kRcA
	k0PnNXpTkMLF1Sp1gBR0mdao1TrrnAZIhJ+0c06ZRRYqOsi9SubPDty11NlK481ib950j4cspT4
	C/eCD+g79WcpdrcvBQenKPZjislnQiP1O277bVDwQ8=
X-Google-Smtp-Source: AGHT+IGwicpZ/o0IuY1PRlF5+Xwpp0Zedm9EU1jTpFbIRqEFcd5qCkFHdNzCn7aZrNCsS7eWlfmhaw==
X-Received: by 2002:ad4:5b85:0:b0:7ea:1156:def3 with SMTP id 6a1803df08f44-87c205b103cmr120184846d6.28.1760807889222;
        Sat, 18 Oct 2025 10:18:09 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8e909sm18478116d6.62.2025.10.18.10.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:18:08 -0700 (PDT)
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
Subject: [PATCH v6 09/10] liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
Date: Sat, 18 Oct 2025 13:17:55 -0400
Message-ID: <20251018171756.1724191-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Metadata is preserved via 512-bytes, which requires using slabs. Slabs
are not safe to be used with KHO because of kfence, and because partial
slabs may lead leaks to the next kernel. Change the size to be
PAGE_SIZE.

While this change could potentially increase metadata overhead on
systems with sparsely preserved memory, this is being mitigated by
ongoing work to reduce sparseness during preservation via 1G guest
pages. Furthermore, this change aligns with future work on a stateless
KHO, which will also use page-sized bitmaps for its radix tree metadata.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/kexec_handover.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index ebfc31814d16..7c8e89a6b953 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -67,10 +67,10 @@ early_param("kho", kho_parse_enable);
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
@@ -78,12 +78,14 @@ early_param("kho", kho_parse_enable);
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
@@ -130,19 +132,19 @@ static struct kho_out kho_out = {
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
@@ -222,8 +224,7 @@ static int __kho_preserve_order(struct kho_mem_track *track, unsigned long pfn,
 		}
 	}
 
-	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS,
-				sizeof(*bits));
+	bits = xa_load_or_alloc(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
 	if (IS_ERR(bits))
 		return PTR_ERR(bits);
 
-- 
2.51.0.915.g61a8936c21-goog


