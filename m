Return-Path: <linux-kernel+bounces-841850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A89BB8637
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 01:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321D119E41AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 23:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E14A27A90A;
	Fri,  3 Oct 2025 23:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/Emx9Fb"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99072DCBFC
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759533987; cv=none; b=eza6NpjoDQXV+d5vz0Z28e5gM/4BUvEkHnUHBDll1WB0MwPD6ezgZFDlYqkWtuS0uXkk4kLP+p1Yb+3+1AmFzI/YHepiTsn6JjsROJVtp4sIYt7UmefbkmxX/S4HtXAW59oAivwsQM8sSBlYoHsmdLQdijEuxcIESstu5Xav/v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759533987; c=relaxed/simple;
	bh=nd69QGguznpeI4Gza41p4mzVL4UTWq4dJdc3g2IHnok=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oTVftcYkrQDn/nr1RsZR2iwZIGOI1Dmqd4sK7bE+6ElwNah4qTULRxLPCK2yjXBjbiczPF6UanapnQc4FZvRbC/vXqdiheq6qoKBPBuX317Gc9JZvsijCCA0rVFvKP3VNKzEsItpqSbSEzjy6I40daEIgcV3ZVHYW3RVebWT1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/Emx9Fb; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b57c2371182so2436121a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 16:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759533985; x=1760138785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hM+LzD7qISlGD7ztSYqO8+LflSdSs8OWf9vFP02fQiE=;
        b=s/Emx9FbbZG1KzOSxuPfyM/RCIAqYSOSGnD22ZBN97BOq5J2oMdmawgcdVHPwPW262
         wMw3UQsK4PFpFOnUdEujITnwZmd+/eWwsMd7gfr1yZy+xQOFEfku5Pz9xqi2ZQT2kydF
         8cGeuO71QAGS8UCLnWes+89xtd7SboEaffrEyI9rFnQajsYhhfAK1Azvjj/kgIbkbok6
         yGfqyo1ex8OPdhser0YewxAlQB+fzaANGAyanAcr8MEoF49/nfm04zHMIJgL1HnDPaeK
         CN34/EsWHBDG0T8fRglDCDBZxmGNKxsdhEicVKiCCbEep9XmKc9C9LiCdnIUyjVsLpvG
         RUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759533985; x=1760138785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hM+LzD7qISlGD7ztSYqO8+LflSdSs8OWf9vFP02fQiE=;
        b=Mi9SF/bRw25RpOtYxFOrLNXa3R3v2mRqHWsrphsKuBKDsiO4QOpzBV4vS/1iZi47Ey
         2NQH8O9tZo9MHnQj8YumqN/3EOOirxjpKEd+AZibkIYjdEBRsq2oH4s8NoEnbB3i9V33
         2JFBjkRI9O6JJPPRNDqeyrfQMR1+aWCMYkhbQMxiCni7GIG7rcgsAy93+xfEa/eTILmu
         yPNOWB/QADGhbDsq8x9SNPZ3jZDn8kEHyacHDr6fb0y1Fb7jocwF3A5BRS6V78vzAbCO
         KrVd7ErrJD1KAgFriTCROiz9r03IwJzk8qA6e2sHj1Hn6Q3pl4JUbjxuCHnnG7QItPj8
         fbNA==
X-Forwarded-Encrypted: i=1; AJvYcCX1Qp/4R4ZuK3nYI/1c2HKFp0W3d+aFm2fATvykkyKZk3c7myt5Dra4rADkDyj7qxM7NKT9Yg0qkAtHu5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlJa2mOMxceDTItLGoiW9aKxbXCCavBTVwjigIO9PZXeBBviyp
	otwJZANAdEujVhZNIU80C/7nUQCi5/L8iHFT++sesmVcav82/QZnlMUk2/smaU2L919SS7a6YoD
	a/M3Thg==
X-Google-Smtp-Source: AGHT+IHsxzQkcr7acPMKC6TgIDvgzhS52pHNU7hj+C6RgZKPwBmYvzlpWGHgGFZ/bj1NAjYqXQWlzBxmdKs=
X-Received: from pfun4.prod.google.com ([2002:a05:6a00:7c4:b0:782:3712:63e4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d84:b0:2f8:b535:7931
 with SMTP id adf61e73a8af0-32b61dfb366mr4895140637.9.1759533985043; Fri, 03
 Oct 2025 16:26:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  3 Oct 2025 16:26:00 -0700
In-Reply-To: <20251003232606.4070510-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003232606.4070510-8-seanjc@google.com>
Subject: [PATCH v2 07/13] KVM: selftests: Create a new guest_memfd for each testcase
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Refactor the guest_memfd selftest to improve test isolation by creating a
a new guest_memfd for each testcase.  Currently, the test reuses a single
guest_memfd instance for all testcases, and thus creates dependencies
between tests, e.g. not truncating folios from the guest_memfd instance
at the end of a test could lead to unexpected results (see the PUNCH_HOLE
purging that needs to done by in-flight the NUMA testcases[1]).

Invoke each test via a macro wrapper to create and close a guest_memfd
to cut down on the boilerplate copy+paste needed to create a test.

Link: https://lore.kernel.org/all/20250827175247.83322-10-shivankg@amd.com
Reported-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 31 ++++++++++---------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index a7c9601bd31e..afdc4d3a956d 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -26,7 +26,7 @@
 
 static size_t page_size;
 
-static void test_file_read_write(int fd)
+static void test_file_read_write(int fd, size_t total_size)
 {
 	char buf[64];
 
@@ -260,14 +260,18 @@ static void test_guest_memfd_flags(struct kvm_vm *vm)
 	}
 }
 
+#define gmem_test(__test, __vm, __flags)				\
+do {									\
+	int fd = vm_create_guest_memfd(__vm, page_size * 4, __flags);	\
+									\
+	test_##__test(fd, page_size * 4);				\
+	close(fd);							\
+} while (0)
+
 static void test_guest_memfd(unsigned long vm_type)
 {
 	struct kvm_vm *vm;
-	size_t total_size;
 	uint64_t flags;
-	int fd;
-
-	total_size = page_size * 4;
 
 	vm = vm_create_barebones_type(vm_type);
 	flags = vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS);
@@ -279,24 +283,21 @@ static void test_guest_memfd(unsigned long vm_type)
 	test_create_guest_memfd_multiple(vm);
 	test_create_guest_memfd_invalid_sizes(vm, flags);
 
-	fd = vm_create_guest_memfd(vm, total_size, flags);
-
-	test_file_read_write(fd);
+	gmem_test(file_read_write, vm, flags);
 
 	if (flags & GUEST_MEMFD_FLAG_MMAP) {
-		test_mmap_supported(fd, total_size);
-		test_fault_overflow(fd, total_size);
+		gmem_test(mmap_supported, vm, flags);
+		gmem_test(fault_overflow, vm, flags);
 	} else {
-		test_mmap_not_supported(fd, total_size);
+		gmem_test(mmap_not_supported, vm, flags);
 	}
 
-	test_file_size(fd, total_size);
-	test_fallocate(fd, total_size);
-	test_invalid_punch_hole(fd, total_size);
+	gmem_test(file_size, vm, flags);
+	gmem_test(fallocate, vm, flags);
+	gmem_test(invalid_punch_hole, vm, flags);
 
 	test_guest_memfd_flags(vm);
 
-	close(fd);
 	kvm_vm_free(vm);
 }
 
-- 
2.51.0.618.g983fd99d29-goog


