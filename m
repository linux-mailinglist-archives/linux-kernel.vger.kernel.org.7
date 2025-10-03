Return-Path: <linux-kernel+bounces-841852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADCBBB8643
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 01:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC3A19E4504
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 23:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350372DF12C;
	Fri,  3 Oct 2025 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zen6oU47"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A8C2DF710
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759533991; cv=none; b=jTIgYs5Gw4nDX6FAV48DBjAzCckWRBLaU+oFLg3+QoCHEwntI10syw6QI7xbZKMIl/Loa1SRvU4xGxyY6nycAXOTTWfUhmA2y0DVXuqI1+pMONZ0+dKPDavRxI5egkuKD06IMZ0yBR5+8rIqpTVL69+Au5bwczJtrMQAQcBr47w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759533991; c=relaxed/simple;
	bh=0xeumNRu0bdu/oLbIMPmUD2rrS5rFLO2H9kNKTpm7Eg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lA0j6yMXzAnTqkfC0AcbM9xFpYNI2yMl3VgXrAGbrLz/law1bbH0eSVn6VroNdHbPqDdSDK0GUPX8u5Ed5fMcWSTsRj+tXbXU2IBFyrhdvFomDbRCvtQ/dVqnifFBow9nIDwxM0fA5nZ7pSJK4uX7KhTC20C3zCFvAbWuP4RUNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zen6oU47; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-269939bfccbso31731555ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 16:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759533989; x=1760138789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qrTDG0acHPOPKJ3AVdBdofNeaQKfhOMghQNh09nNQB8=;
        b=zen6oU47fV/1SDB+LIeNzFsLd35ERNRIYcyID8yvAuvb793VqKD8bIrIPqoSE2YNFC
         yY7ish9Upr3nxIb3LGMX79ZSmf8Wb6FnLCIkPVLARK+wLDpKI1EWFjanWAs4/Zi6WVD5
         VmEIb+T8fEJQh4aP6z1EsMJfPRIYOF8JQtj7PafnJL3bUB0GE5iIFiUmtLnFRSANyNeH
         a9FNoMGOLtCEEuONSkUBGsWNOMcFl9GFR0Bo0UmrBpWBa5c+lRHR5uBQeEo1aRzjXZp0
         2JHtzbGUWtIySbaydOn5MFPvtfdoVLVc9p1q00/ORWFC+fu2nlulS9UfMkd0o67tdZWw
         UtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759533989; x=1760138789;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qrTDG0acHPOPKJ3AVdBdofNeaQKfhOMghQNh09nNQB8=;
        b=omELrXoWKkXQi+hgwlPH77HIoQ/hBExq5JdY6h4YqCauNVyHEAAfrLLNbe1+t9UdXG
         Th1egtFq1Pv7rmAfNpJvUk5OHpe2Xr4RMFo+xViuZ7hULjTubW/UqE1W0tXQ0qliWfbz
         V21niCONkA4k9VS+x+gF9jFbwXebBspzJlw2UpzDfsJE1tJ35NSXBluAI8xPQ1rX19Az
         CWRV7RukqOQrJ7wwJp6jGNDRN0eMYv7dVCndVWnLDrFO/FA9UBg775aNPltSxfD8CLLF
         ufnEpeVh65PNf2TyoTFJWbTPn4HKivJpXcSL9Hb8tKKVQlvmyPdmdK5FMbuGTefulCRr
         8/Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWWvd+GvQicQxbQ/i3JLPImErivBEUPIrFa91QK54R7xHol74uY+uQibykdSc+xrG8kP0p4JEXCU7RMLNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd9BAkwivEMIJsSl9g4ci/L2JeWJ89rtQ8OuPx7zEXIcv/zUjO
	IrVuPvN1vAeAheXDT5XEe12HMPnTHDF5r0Ptg+qRpB9kdgKHbPyPQQGPj6OYyJ85aXEfRgHXfQB
	fXVM3cA==
X-Google-Smtp-Source: AGHT+IGTaO3/D04Td+DbjpLaoUihiDB5eETO+E+bVM2wQesLhDsp0vKrjYvnc7RvC0OhiVRi6XrR4kqXyXQ=
X-Received: from plot3.prod.google.com ([2002:a17:902:8c83:b0:27e:4187:b4d3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b50:b0:24e:3cf2:2453
 with SMTP id d9443c01a7336-28e9a7031c4mr52954735ad.61.1759533989354; Fri, 03
 Oct 2025 16:26:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  3 Oct 2025 16:26:03 -0700
In-Reply-To: <20251003232606.4070510-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003232606.4070510-11-seanjc@google.com>
Subject: [PATCH v2 10/13] KVM: selftests: Isolate the guest_memfd
 Copy-on-Write negative testcase
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the guest_memfd Copy-on-Write (CoW) testcase to its own function to
better separate positive testcases from negative testcases.

No functional change intended.

Suggested-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 319fda4f5d53..640636c76eb9 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -40,15 +40,20 @@ static void test_file_read_write(int fd, size_t total_size)
 		    "pwrite on a guest_mem fd should fail");
 }
 
-static void test_mmap_supported(int fd, size_t total_size)
+static void test_mmap_cow(int fd, size_t size)
 {
-	const char val = 0xaa;
-	char *mem;
-	size_t i;
-	int ret;
+	void *mem;
 
-	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	TEST_ASSERT(mem == MAP_FAILED, "Copy-on-write not allowed by guest_memfd.");
+}
+
+static void test_mmap_supported(int fd, size_t total_size)
+{
+	const char val = 0xaa;
+	char *mem;
+	size_t i;
+	int ret;
 
 	mem = kvm_mmap(total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
 
@@ -272,6 +277,7 @@ static void __test_guest_memfd(struct kvm_vm *vm, uint64_t flags)
 
 	if (flags & GUEST_MEMFD_FLAG_MMAP) {
 		gmem_test(mmap_supported, vm, flags);
+		gmem_test(mmap_cow, vm, flags);
 		gmem_test(fault_overflow, vm, flags);
 	} else {
 		gmem_test(mmap_not_supported, vm, flags);
-- 
2.51.0.618.g983fd99d29-goog


