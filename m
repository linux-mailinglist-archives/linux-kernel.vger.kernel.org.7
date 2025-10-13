Return-Path: <linux-kernel+bounces-850854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA56BBD4AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42B0F541E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB11F26F2BE;
	Mon, 13 Oct 2025 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bK90y1O3"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83090261B7F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368542; cv=none; b=DcFT+2GTGOgbtTH5xfjRB95MwEyGfAiIF4EQS4c3IlO3A8hmqRoPZCjd1RJ5yJMqG+KhqM1oGSU8udljJDy97IDrMgbBK632qUXOJQ7heEjgtPo8BlcOq6uTAkSNFHFreE4+5H7tG+4wXxo7KDFfZtD4a3p2ZX7Qo3wmveZvftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368542; c=relaxed/simple;
	bh=2UhKxpWUkIifGUgfHcgz/LXU79xXY7bzYokZjULRNnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwLMm7LFH8/A4rrm3A9HHrNTNEf6X1hfjGoNJWqRiXtHD8EsjEhr7MY4uZbsT0Ib4CQhn2PNsumSacvROHLZJMoDkeyeF7W2uUQqkUgTxwImgYlkmegUp7Zc+OO9UwrdUi1zdtoq1pxY6LdXFYEaxzDJWt2k/oBIcVFcsMdDE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bK90y1O3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e52279279so30694785e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760368539; x=1760973339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDn63HL1kwJS/kY3r585sacU2JfuR+fJZeZdcH4A9XQ=;
        b=bK90y1O35TGA1PtbYgnjynZom88ttaHqOKQzkYqP+sU+Q6LOSOKUIQCA44d6Cy9Lkr
         dHuZXhtLOFiQz3g/BrVWT9cKaTQIhtEGH7uf7oz4hlEPqf8wO76N0AMdab1pa5LelKKE
         heMdkK/b+QxI4/auVhOBd+UvnBGNv2iEVSrNLFaUj2Io+EDANFJYHBLgT98EPVt7Rvkc
         AMMsLaO88ltcm3m0jQs0x58I3bEig6w+LnWHGc5QdYwa82Xl1Vc8CAcwzkBk6YROfu19
         rS/W3lhDEviaKW48gfGQpwmd8iMgP53lwjwl0KaIMzvurgv/2/CshxWwzvNwSbmbE+B4
         APVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368539; x=1760973339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDn63HL1kwJS/kY3r585sacU2JfuR+fJZeZdcH4A9XQ=;
        b=lMrNy9A5pdphYNSXMLb+YYD7HCZSmSZBjn8Jzpg6FLHODAQnlg1RPEwLEzHnO7Vp5X
         glFadZlsQY436bSISnggKn7kw762VT9ZIup7A5gEes8WlNAtr3vzbiPVGkfgm8HJ18Kt
         TEbB8EamM1mX/KDGXJqh13D/gKjC2mI5qUSDv3fm5OLsZSYOoMRxKWDi4K7RQ8xznBrk
         w0UfKGqtmAdNYbvxQ4UbEadfdYolm2BV4thhpbgQv5Hh5dHGcgGbnoUIRMIjsf48hjv8
         Bi4bS0X0hsoFxbz0wcGjaB4y3+a3QWNdxP5hRlKjn1PF75CQ1n1RGjD5z07PB8tkgnZF
         hgEw==
X-Forwarded-Encrypted: i=1; AJvYcCW17uAelBLtYXXJv3R96S8I2zUrWJm8KVhANkbSXiMHy3oWEdM/hqUeDJIxhERHfLAFjhx6Rvwu43A3LCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnKALXrV4oLfPokv8sfpKY7se0bD14cGh7oXWtBTRpE61eFlhK
	wL4W5sQY/PjwqSMsisdLUCIdJ8bLK1CtGBCpOYB5AWkRpYaTUCnDv5YL
X-Gm-Gg: ASbGnctwzdtQM0FN1xQXYZD0fxO8a5Wo5C7Xuh29ShdnBnCS7U2v9w1p/JCkVoRgi9t
	Pbcnr8NiCo+cdV0oJm58gvXcCh4IVe+MULLHGfWanUPVs4k2JCotJt5gIisJqop31yWzRQ6TnFX
	oYB7gzbdGXFBv3zAzD6bKkXmtGDGF8prYAdhJBk2XluZbIVTxC8nKR+G77dhmvOEGHxfZHjP/oR
	BVL1QFTkgRz8ed9NO1O/phN7i1f7NfP50rXKDLe12Gjj8I5P+/e1Dubiq2lRwN/iVGcOfHmZR3O
	pNTHnZ1J1S0v/lYMj009+r+O7YH2SpOEO/f16/1aFLOhUq08dYDMrzgmzlakRBN2UAGn16ESAw5
	/sYSYbFUIrNpM3ND7J7kCgAFdE3GOX2sgeYEo5Ycj2w7z8xA1kwYt7yZgy+ORZ4ucmyo2i1RZ+p
	EZxi9k
X-Google-Smtp-Source: AGHT+IGwJqj5PmL4e2MI1le7nNOJW+jd0SIfBCswYBmaCJKr1jrFAghd2jBuPptFtHUN4Hmx6R2roQ==
X-Received: by 2002:a05:600c:4752:b0:46e:49fb:4776 with SMTP id 5b1f17b1804b1-46fa9a9f05emr138719385e9.11.1760368538589;
        Mon, 13 Oct 2025 08:15:38 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.3.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab36a773sm135545825e9.0.2025.10.13.08.15.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 08:15:38 -0700 (PDT)
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
Subject: [PATCH v2 2/4] KVM: selftests: Fix unaligned mmap allocations
Date: Mon, 13 Oct 2025 16:14:59 +0100
Message-ID: <20251013151502.6679-3-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013151502.6679-1-jackabt.amazon@gmail.com>
References: <20251013151502.6679-1-jackabt.amazon@gmail.com>
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


