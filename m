Return-Path: <linux-kernel+bounces-859324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F373BED4C6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 847764F0EE1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83611275105;
	Sat, 18 Oct 2025 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TCfpxQND"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00521268C73
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760807893; cv=none; b=G+Hk1nL5pFwR3Iqu4O55M3TNYFRTD9XacubCoWtrdnq5D+rUCCg0irtZtXMmoSMkk9z8ik8Ry95n7uUfaUKwq1r356obMKloM89E86/zbll+X7jhGmMMN81Titkxc+E+t9fMBv1S08bV8Gm33/StEjiWcGtHNoCgsjf3EWPSxnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760807893; c=relaxed/simple;
	bh=0XF6mZTda3Mo3Xc5oEB8STcY3fJXR4+QE6+7PIztyAs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rs+IVpIBqsW5ITVG/dPykCs2o6BVC4tC1tQqSsOJt3OhNFq8GD3eAkaJ2J+5NpAxlwXfIDo5hqpPw+iMUoGPijskkYESuBeF2hnB9oB4McveYK/4KSULIlJteKoNKIcomIUmYy3DzuZlZG1RgIrNvsbSHi9FHD3AVGfyB4Q47gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=TCfpxQND; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-87be45cba29so43327016d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760807891; x=1761412691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFLCF5XN9yDZ1vXn52PKQdU8GeSc6NQJh3Hjw9F38C4=;
        b=TCfpxQNDL1Il6ExdScCLbtwdSyRZGplQ+lsfZWZW/Soflhx/a9cYn2M4UTtxxFR0IC
         sM4FMAwWc8jDMJfUPzViZAlWGpmXJO7kANxMo2s/C+wQoM7cuWKaJHdDsfUhW35l9b1m
         +i5QdKE1PHPPb/hWw/dxPZB2/3j6/P692Y5BiPxmS3ecM46YTQGmiUI7eL+oHHrQBzpB
         pKOVmfLs94+Io91Y+35dIMe9jryFn1X8ocely1Hdi+iR//T3oCObW7JXTq6+Lb9je7BJ
         bKyYwe+AILl7cY2qbXibR0ag5bPla9NxHt8lR7Y9rKpTW9OQ8xqnrM8eQBkwTuAnokja
         eFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760807891; x=1761412691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFLCF5XN9yDZ1vXn52PKQdU8GeSc6NQJh3Hjw9F38C4=;
        b=pvRgtoomFMQc0275sQH7L+6uLUGyM2n1dKOeq8v6/DUhW7n0zeIw14nPr12LIl9sd7
         Mmd8VDVwoxVTOjgW6nuFN0INCdP02m+fN3bF1htZOyeNHx/U08P+JL1bkS0hQy3lw8MT
         2G4Elih0e5P3/H0cjNzu9xgIW2/jYdKcteykQ5W2aV+/MrnZodMfU/Hyb92MvoFdyKzF
         gLaRycxX/veZ/dWp5h4xeje45OWql/QkT/dx1+IHB1888yd3jX1w5vN5xRQfOHRZbNS2
         lurfLKtjOaUehiNrTecmA9pyHBXOiftD4XQLY9C1YtFZ/Ip8iEIq4UkVqtmIrvD6XsFa
         7qdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuqUqNXtpqNuPFEGYAuWn6WWm34/1s1ihWhE99hAxt65N8Mip4fVOMf2JQSOh3szYz67MEMgs/63P78kY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6u/rVcrCsuylI/28KdhrwMekCATUSQ236R3ZR91rEdDPvk2d6
	J47N3wGqg09GvbYgZ47WyLHOx3Y8jn4+CcrzvMeG/bYqwhKI89uUWzWXaqWkAtZMv0E=
X-Gm-Gg: ASbGncsDglxVnIDu7EQXppOW5szGq/ynFYVf9WyWji4eIEnz1ljKXR6hDGDGbVw82IH
	PuAVNFblrAsNALnwrLCAMgWa5QfjmnMOe5kqvwFk57jJ013tNI/M343gDMRPydzW8VkjYeX9AzC
	zvCAc3eFV5pUwsbbDoxl7VqstkFpDh6XyEIVlu7MA1lqhDi4wHz8WEVSaZHrqSuIcxoyF9eXfZZ
	R7YuPFiszV1DY7CId9HMgdv+YeSd4GK4VJ+2TRN5ha9fi1KU1B2v9dW+eCtpDEMu8YVN6PeuW8l
	1P0yafrh/GgHZj5lgCelrFEMbL09hw4Wm+6bKAOfd4E1LFJb4sE2tOABhDHFMsekj9EWRNC82+v
	8RtXBd7hyhmpBBa/kHrTVuABXbH493yEwD1Lb76f+CTHAbS3aqi7a0QyrzbMxODcvrVlBdggAcM
	tR78hJeHf+hyVKvmQB/Hd0DoJ8y0Php4C48oFPiM+N2lH/LbqxhQHpvg/baNzt29LL/Gm97jl1t
	SwcqwjH7MTUu1xfo1GNsh+ilenzrJ9E
X-Google-Smtp-Source: AGHT+IEbH67r1bkBBr2fGDtH2iJYzk5qXpz4ZuAYuqM7y3IYRwB0Hgi7HzGfKIjAQO2jFT0oN/PwUA==
X-Received: by 2002:a05:6214:8017:b0:87c:226f:f5c7 with SMTP id 6a1803df08f44-87c226ffc83mr105442856d6.38.1760807890764;
        Sat, 18 Oct 2025 10:18:10 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8e909sm18478116d6.62.2025.10.18.10.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:18:10 -0700 (PDT)
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
Subject: [PATCH v6 10/10] liveupdate: kho: allocate metadata directly from the buddy allocator
Date: Sat, 18 Oct 2025 13:17:56 -0400
Message-ID: <20251018171756.1724191-11-pasha.tatashin@soleen.com>
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

KHO allocates metadata for its preserved memory map using the slab
allocator via kzalloc(). This metadata is temporary and is used by the
next kernel during early boot to find preserved memory.

A problem arises when KFENCE is enabled. kzalloc() calls can be
randomly intercepted by kfence_alloc(), which services the allocation
from a dedicated KFENCE memory pool. This pool is allocated early in
boot via memblock.

When booting via KHO, the memblock allocator is restricted to a "scratch
area", forcing the KFENCE pool to be allocated within it. This creates a
conflict, as the scratch area is expected to be ephemeral and
overwriteable by a subsequent kexec. If KHO metadata is placed in this
KFENCE pool, it leads to memory corruption when the next kernel is
loaded.

To fix this, modify KHO to allocate its metadata directly from the buddy
allocator instead of slab.

Fixes: fc33e4b44b27 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 7c8e89a6b953..92662739a3a2 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -132,6 +132,8 @@ static struct kho_out kho_out = {
 	.finalized = false,
 };
 
+DEFINE_FREE(kho_free_page, void *, free_page((unsigned long)_T))
+
 static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 {
 	void *res = xa_load(xa, index);
@@ -139,7 +141,7 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 	if (res)
 		return res;
 
-	void *elm __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	void *elm __free(kho_free_page) = (void *)get_zeroed_page(GFP_KERNEL);
 
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
@@ -352,9 +354,9 @@ static_assert(sizeof(struct khoser_mem_chunk) == PAGE_SIZE);
 static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
 					  unsigned long order)
 {
-	struct khoser_mem_chunk *chunk __free(kfree) = NULL;
+	struct khoser_mem_chunk *chunk __free(kho_free_page) = NULL;
 
-	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	chunk = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!chunk)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.51.0.915.g61a8936c21-goog


