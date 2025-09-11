Return-Path: <linux-kernel+bounces-812195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED3AB53458
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42EC93B034F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64BB32ED54;
	Thu, 11 Sep 2025 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/2VcPHK"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5C3335BBF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598593; cv=none; b=ES4sl79UJ2sKM57A7nYbZZYQHmx5beM0Lz2zE0y2CtGN8rUJ+mofU8KKRnGdNPz5uoIuQdI9bviN/Awgh69yKP/VbtQ840QIbrgwQuWwBgzuf1WmKBX0uw1rxNj+s+3M7fmuaRANS+aMhiltHHJjS+OkCZX1zLcaHrqwV2UsyxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598593; c=relaxed/simple;
	bh=2UhKxpWUkIifGUgfHcgz/LXU79xXY7bzYokZjULRNnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JLgM/ZwNsr6ELTpiFxfU1KZ271lIP6N84GEoev/Mjpy1BttbAJY5eQSwPsZp57mGQT2U4hDTQ82Kw+A3b5u6xMQj79gxXzMyD7gQhttUyNDdboQQK2IoYMJjRoJKzPDQv3rjnINoVFhjSvM9mXBVzsZBMNGp3Ni8QF6Vzzr179o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/2VcPHK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e7512c8669so598327f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 06:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757598590; x=1758203390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDn63HL1kwJS/kY3r585sacU2JfuR+fJZeZdcH4A9XQ=;
        b=d/2VcPHKnnxLoNjb+hbSuzZLQDqY3a3ybFTMDseP23ghYT2LImdZx2IGMgkAvXnV46
         0lZBkD9xh9MYXSodC4k5TTh8TUgo+RwTZgzoSzPjITwuzRPQUjCKhhCMqE857VwMgK53
         VF3IWCKYzD6AKQYSFzyTQZNXBoHFtXuW1d1HY1eS0+NQ7iG5H75RGB9TemtodIq9LhjM
         Z2hrVS9K3mDbVK2/qMxJ9qJ6t1kOmtJLMvTrpCB84lzQmvfzkOHytZfeMExyuUnoucMP
         y9V3MN1SGEmejwkAd8qGLsdiYfdiJrwNkLOQbCrAgq1g1+I+HJns3Lpb2R0+fo8CI7Oa
         fdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757598590; x=1758203390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDn63HL1kwJS/kY3r585sacU2JfuR+fJZeZdcH4A9XQ=;
        b=WRgsRZOhSo21Q1QSjHqh1LcmZs1MWzGo1EbKKpIw5Wlur2F+BXb4en+s9Ik67+GJN3
         tUIwmK8gkECHaqCqkt7tg3jUAbqUsA0R3wAm2Ixe6WeE7vSXaSwFgUvyr3IMaWTsX3YK
         6IiqRA2AOoK087zrRc2UBZF+zPeEyuYFyHC0IpVwUjEdTMJ9+yZD/GZUbB9jdMsTaa6N
         q00WplSq0PtX6nxYeQnHUOzct5U0wDIoHTWuwVelZDtf8qJqb5Bj6h7TiijKHjZzUJSV
         6paiVPoo5OyDm6Nfwa8cvTL6gTrBjVQBm+1lxJhuyHxjD2f0gHcmlfp3ffpcqWKDUfOi
         g5mg==
X-Forwarded-Encrypted: i=1; AJvYcCUxycFwe6ryka9vHcQkJIcTvWfeD2S10T8IBhNEN/DCTtbxZ745ltN5sP5RcvAg3OTFI7Pj+kHg2tR2upM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhUgH2Uhj6+tcOSkqg5snUCaklarU8R4MCdGI6ZsM/py3HO+Yw
	WxTbgRPk6fMC294QA2LBSZ73/mROk3asQy2wR5btdV9lBUNnigyguJrQ
X-Gm-Gg: ASbGncvG1c2lLMS0R+tobpEkYkHaXWQaeouaexxh5OL71FrJ+rLV7jYVUFOlPAyb5+s
	9nuafQA7bG9cCE53WALgot9kmA3fF4kEceTi6ru6WsU7z+DUYOMabBynh4x39T96cHiNsbkwbXN
	GylzLrYUjDOVRpZzcP3mZqHV/VyAP6M7woXkCu8llOltBNIX4aMBrVvp8J+9WsFozc1uYIqAJEQ
	cKQn3lYsk+pWvPDYZQzn57l3RHIBqf+rGb6vLllumPn8zar+vHwHU/MCfedg9mnHh/fLf8Myaxp
	KcQE2Nciq2W1vc+z+btroGqaYA8VgT6gle9DuimQlMgA8CMCmKSlR28L5gydmy7gLxWeM/1TsQL
	5KErlfEcZkwZprG2ug7G0VAffdnOKoSpzZ2gefWU83CwOUys2JOaxklbafPZTGb7qUT+HSIHK
X-Google-Smtp-Source: AGHT+IH6i2Rlk1oZZIkubpWUyVstEoqiFYIwX8SUUvSh7jWZ3DNV3Wa4AF6A7KNkrZ7i9r1nUbzyjw==
X-Received: by 2002:a05:6000:4023:b0:3e7:5fca:2177 with SMTP id ffacd0b85a97d-3e75fca25admr2356651f8f.11.1757598589695;
        Thu, 11 Sep 2025 06:49:49 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760778915sm2608361f8f.12.2025.09.11.06.49.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Sep 2025 06:49:49 -0700 (PDT)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com,
	roypat@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH 4/6] KVM: selftests: Fix unaligned mmap allocations
Date: Thu, 11 Sep 2025 14:46:46 +0100
Message-Id: <20250911134648.58945-5-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250911134648.58945-1-jackabt.amazon@gmail.com>
References: <20250911134648.58945-1-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

When creating a VM using mmap with huge pages, and the memory amount does
not align with the underlying page size. The stored mmap_size value does
not account for the fact that mmap will automatically align the length
to a multiple of the underlying page size. During the teardown of the
test, munmap is used. However, munmap requires the length to be a
multiple of the underlying page size.

Update the vm_mem_add method to ensure the mmap_size is aligned to the
underlying page size.

Signed-off-by: Jack Thomson <jackabt@amazon.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index c3f5142b0a54..b106fbed999c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1051,7 +1051,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	/* Allocate and initialize new mem region structure. */
 	region = calloc(1, sizeof(*region));
 	TEST_ASSERT(region != NULL, "Insufficient Memory");
-	region->mmap_size = mem_size;
 
 #ifdef __s390x__
 	/* On s390x, the host address must be aligned to 1M (due to PGSTEs) */
@@ -1060,6 +1059,11 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	alignment = 1;
 #endif
 
+	alignment = max(backing_src_pagesz, alignment);
+	region->mmap_size = align_up(mem_size, alignment);
+
+	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
+
 	/*
 	 * When using THP mmap is not guaranteed to returned a hugepage aligned
 	 * address so we have to pad the mmap. Padding is not needed for HugeTLB
@@ -1067,12 +1071,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 	 * page size.
 	 */
 	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
-		alignment = max(backing_src_pagesz, alignment);
-
-	TEST_ASSERT_EQ(guest_paddr, align_up(guest_paddr, backing_src_pagesz));
-
-	/* Add enough memory to align up if necessary */
-	if (alignment > 1)
 		region->mmap_size += alignment;
 
 	region->fd = -1;
-- 
2.43.0


