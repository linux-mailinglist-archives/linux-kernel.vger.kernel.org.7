Return-Path: <linux-kernel+bounces-889386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9336C3D719
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB941891D51
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D203043A9;
	Thu,  6 Nov 2025 21:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z+I6Uk42"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B7E303C9A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462931; cv=none; b=PZWEENLu2/68xt9rH3JLOZy95JLU7FqHs7W17icp0MXIXQQe2Jg5Av53GWwtS3ZUxIyuv54NzHiVZYDX5g8R+RekgnBVgaIZLY4vWR4nd7PivV/PrAah4pOPtBG7nyfSqewDFCoca/cUZA3whPLYiGtHg+FaLx9lHlMKljKt/zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462931; c=relaxed/simple;
	bh=K4r0PNR/pXspBk+Ybp47LxKdosojHAfMcGsiWbchkRM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=COXk+CPavOSxw5w6VsHW3A1/dRqt8LaaxvMQdx90FxS59GOdPJtCxXzW92WrwQZKIPiKa/RZiliD8yZTYxFoEqASvT772pT0bABjxEjDNKDHs+Y0RkIfMxD6UexQcjrYDjNIntOqEnPFToUahH08Y/9hyiaLA2jdNYK42tESgdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z+I6Uk42; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-272b7bdf41fso1395115ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762462929; x=1763067729; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etgqy533ROEysuZvffdaI1/BVd4Q9s3epCFCu4cehdk=;
        b=Z+I6Uk42XJ6/OFmZdWOBnzPppMF8JHtQ6cQg2cDarSi0fYcAIqGH5OI06NdPJ1LcLL
         J1wd0PxQHyTyY5N5EwX4a760DLxcnFUHUUduqF6jVNKG+X8s8xZeSw1N80KOavyudD/x
         3Q0sguD7JvA1gmIQqQaXQ5n58b/NvuufBKitbTrlvKxsagXFExKU73oNQtHKpGn+PUT9
         DJ9vdtT3+hsTO40Wwm+ysDjWOLAgAnMDRTMtKDuLEsH1UCzwMMPD8/R/ZcdeGRRP7OEa
         8J4xGo6Htc9KUaGppZzzOI2+2XjYvVdQzFUW9G2MKstcQtPOqeYoes2QdgHK/tv39JLN
         iOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762462929; x=1763067729;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etgqy533ROEysuZvffdaI1/BVd4Q9s3epCFCu4cehdk=;
        b=COyKodedMH7J33rZp9LskrLPVCO697aULaoMCFriKZ7jCaDOesYqvEIKdzSsurbPfy
         fN/ObwWt7pB7WGZUSw1dGOu+wBzlvrZ7O/WmNVtb0zw8e9UVYX9Cf0GSCfDQzhLulilR
         /0YLZrN9jD+81SfqQK/o7WQOBWoznUqFJ9fk+XzvxfzixPfb/pZiJ/nuPSdLjv+uEYwN
         Wgh/JcJtJ3sdbY27VDyCKgpoZ6C0Kh3TNEzcqCbJFKfK3N+jk7GnP9m/c1YDUGH6NWsw
         0mc7uBPbKpC/Zm/y/le5nS4URBE4SLa5meQn1R54FoRAtSTO1DNE3F0E85/2KtkJVjNm
         1bsg==
X-Forwarded-Encrypted: i=1; AJvYcCXJdfoHcVHs8DPYC1lVv15o1sKbgb/5gNBmezgdpB1l6rozjjong8befINNgBpQW1C0LjDuNZH7BPbmJ+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUxT21bVpYLz8kUXb9+Sna90jEZ8PFm5Q7Qqhi/SnqQZig/uXi
	EZeue5aiJvXmb4sEBCISxmRPpUzeNXwSgSdMqjGj5V0oliYD9k3RgudjZCYwcevmp9iykcM7Nav
	EuQ4kAQ==
X-Google-Smtp-Source: AGHT+IF68+vi3zbqywUQatkJVyKP2WAhgDao7YLP3uY26pGcAOhsev+0/UeCKxtZdrx+5pOPGxmZ0MpMUNk=
X-Received: from plblk16.prod.google.com ([2002:a17:903:8d0:b0:294:f721:8bc2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5cb:b0:295:24ab:fb08
 with SMTP id d9443c01a7336-297c0474ce9mr11049625ad.47.1762462928932; Thu, 06
 Nov 2025 13:02:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Nov 2025 13:02:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106210206.221558-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Use "checked" versions of get_user() and put_user()
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"

Use the normal, checked versions for get_user() and put_user() instead of
the double-underscore versions that omit range checks, as the checked
versions are actually measurably faster on modern CPUs (12%+ on Intel,
25%+ on AMD).

The performance hit on the unchecked versions is almost entirely due to
the added LFENCE on CPUs where LFENCE is serializing (which is effectively
all modern CPUs), which was added by commit 304ec1b05031 ("x86/uaccess:
Use __uaccess_begin_nospec() and uaccess_try_nospec").  The small
optimizations done by commit b19b74bc99b1 ("x86/mm: Rework address range
check in get_user() and put_user()") likely shave a few cycles off, but
the bulk of the extra latency comes from the LFENCE.

Don't bother trying to open-code an equivalent for performance reasons, as
the loss of inlining (e.g. see commit ea6f043fc984 ("x86: Make __get_user()
generate an out-of-line call") is largely a non-factor (ignoring setups
where RET is something entirely different),

As measured across tens of millions of calls of guest PTE reads in
FNAME(walk_addr_generic):

              __get_user()  get_user()  open-coded  open-coded, no LFENCE
Intel (EMR)           75.1        67.6        75.3                   65.5
AMD (Turin)           68.1        51.1        67.5                   49.3

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/all/CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/hyperv.c          | 2 +-
 arch/x86/kvm/mmu/paging_tmpl.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 38595ecb990d..de92292eb1f5 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1568,7 +1568,7 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 		 * only, there can be valuable data in the rest which needs
 		 * to be preserved e.g. on migration.
 		 */
-		if (__put_user(0, (u32 __user *)addr))
+		if (put_user(0, (u32 __user *)addr))
 			return 1;
 		hv_vcpu->hv_vapic = data;
 		kvm_vcpu_mark_page_dirty(vcpu, gfn);
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index ed762bb4b007..901cd2bd40b8 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -402,7 +402,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 			goto error;
 
 		ptep_user = (pt_element_t __user *)((void *)host_addr + offset);
-		if (unlikely(__get_user(pte, ptep_user)))
+		if (unlikely(get_user(pte, ptep_user)))
 			goto error;
 		walker->ptep_user[walker->level - 1] = ptep_user;
 

base-commit: a996dd2a5e1ec54dcf7d7b93915ea3f97e14e68a
-- 
2.51.2.1041.gc1ab5b90ca-goog


