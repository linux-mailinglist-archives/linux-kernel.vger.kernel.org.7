Return-Path: <linux-kernel+bounces-720619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EEBAFBE56
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5667F1AA5C45
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F782289E2C;
	Mon,  7 Jul 2025 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w26HAPty"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B291C5D55
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 22:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751928508; cv=none; b=RIFEa/72JOpUO5u3GFIzIX7kdBmO0Spu+S/onMjUwq33TmCdFBgOdUCgOlRLh+w/4HWhV8sy+365QyA3pWHnc52R7k/H5SXq/aYnkg5+YdqiTxEF9H7mCziOKHSHbc42hhBYUqHu2lmV/896xXLNZRQD4iQK/Un2hQoiWdUeVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751928508; c=relaxed/simple;
	bh=qTTzVQZqrUBqIzRb5vqidn4kh4nL50b+EzSDbmeigy0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tlmG+oTrvzjJeuwTUDSz5zcqw315RQ8ofzwvTLtPDyomXxMFaotqSyNVTNBF8AGRYfBFlDHnPDViXotqQFpM+cjhUmlN+XtWk9fhDfE4DSNkQNjBNVPP85DKLYG9VrxF5oj4gxZvUexhqki3aOPcV8uvq6Vqs8H2/dc0vt5bSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w26HAPty; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2fcbd76b61so4321655a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 15:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751928506; x=1752533306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2iVC6lDsTdmoSNx7WZ+C+NX+iZ0b1chQ7kg4FWN8O+c=;
        b=w26HAPtym+gX7BQITP90GS2kInKl4Z2LdXevcmfqhZP0rZZSodrACctyerU0m7TL7z
         6JBCLHqMpvUCYT6RfD7sFQLTO8YDNSWhnRb4//npw1Rp0ZclBGPi5NML85zyDWYynE6G
         S4E57yI8+ICApp/sUIuTyzibQRt3FpkpLPDVtdsW+l8GgYvWyJqfuQr2vN72LCYjHpER
         SEsG1QqGG71aY7KtyNnnhlOcKxNvJPo5VBIXr5HaIjva4tEwRRc2VzvVIlWaYUVWQUHc
         ciUDEitIKN3WbdsKOHFJqZB0hr02HIanEXveEWigLcwNkXlrvebh4DMiN1KlRL+Wf1U3
         IaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751928506; x=1752533306;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2iVC6lDsTdmoSNx7WZ+C+NX+iZ0b1chQ7kg4FWN8O+c=;
        b=EGIus5CO3CK8P64ACv8tD66VGiDs/Q8rniSdMqdcL0+FQs9RDcrmV1fyYjEvgM4WLb
         7RGP/Rh/JTcq93VoM92z+DOZIGiam1IsGbwE4ajviAh4wxtH+KOrxDZvvyQoKkyqk9Ad
         fRXbltcJP4YS+uq/qBawPDnHrTAHnm/QU1JPNrpakYnbMx7vd3tLkHwxpCn4GyraOeY7
         5LRqLynXvI5qmAAugaAiDGVRAK5SbwDRYJMNlRrMlBRe0ekb/bc1dTuygXq7JQ/HQk7O
         LBYX7vBUO+A3ZFdVUknDyL8s1KaVJLAnwPPKE6VNyr7loul+rKCIYU/vmocn3AugmOLi
         M1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCErI1pGSWzJ8gqiarLvqj6DqUWGNFGT9+rkKyWfDHbFPQEtQcMENux0M1zpFECVmEg9sIiftIxLnAHak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAEQTIxLcODsm6xFesSrl6zCsaaXeBrZVrIgB3+WMcWsrLeaSf
	vgx80P7XlBXyHLF46OQJ+76F4lyFdCItreJzcVuxrvzFuNogXkCIsC92iBOv199HCY7NfW4tZNI
	TmyhpEISI/hMfJvhn5HSNJQ==
X-Google-Smtp-Source: AGHT+IH5usXrcgv6G7UO8iG/pmDVqqZn9ALh6f8wfddQy1sUslJZlOFFJqd5ucBJzZtUqEs15wA0TBPkvJ9yjJES
X-Received: from plbjf14.prod.google.com ([2002:a17:903:268e:b0:235:ee71:80d5])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d58d:b0:234:d292:be83 with SMTP id d9443c01a7336-23c8746ffe3mr244048355ad.10.1751928506186;
 Mon, 07 Jul 2025 15:48:26 -0700 (PDT)
Date: Mon,  7 Jul 2025 22:47:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250707224720.4016504-1-jthoughton@google.com>
Subject: [PATCH v5 0/7] KVM: x86/mmu: Run TDP MMU NX huge page recovery under
 MMU read lock
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sean/Paolo,

I'm finishing off Vipin's NX huge page recovery optimization for the TDP
MMU from last year. This is a respin on the series I sent a couple weeks
ago, v4. Below is a mostly unchanged cover letter from v4.

NX huge page recovery can cause guest performance jitter, originally
noticed with network tests in Windows guests. Please see Vipin's earlier
performance results[1]. Below is some new data I have collected with the
nx_huge_pages_perf_test that I've included with this series.

The NX huge page recovery for the shadow MMU is still done under the MMU
write lock, but with the TDP MMU, we can instead do it under the MMU
read lock by:

1. Tracking the possible NX huge pages for the two MMUs separately
   (patch 1).
2. Updating the NX huge page recovery routine for the TDP MMU to
    - zap SPTEs atomically, and
    - grab tdp_mmu_pages_lock to iterate over the NX huge page list
   (patch 3).

I threw in patch 4 because it seems harmless and closer to the "right"
thing to do. Feel free to drop it if you don't agree with me. :)

I'm also grabbing David's execute_perf_test[3] while I'm at it. It was
dropped before simply because it didn't apply at the time. David's test
works well as a stress test for NX huge page recovery when NX huge page
recovery is tuned to be very aggressive.

Changes since v4[4]:
- 32-bit build fixups for patch 1 and 3.
- Small variable rename in patch 3.

Changes since v3[2]:
- Dropped the move of the `sp->nx_huge_page_disallowed` check to outside
  of the tdp_mmu_pages_lock.
- Implemented Sean's array suggestion for `possible_nx_huge_pages`.
- Implemented some other cleanup suggestions from Sean.
- Made shadow MMU not take the RCU lock in NX huge page recovery.
- Added a selftest for measuring jitter.
- Added David's execute_perf_test[3].

-- Results
$ cat /sys/module/kvm/parameters/nx_huge_pages_recovery_period_ms
100
$ cat /sys/module/kvm/parameters/nx_huge_pages_recovery_ratio
4

$ ./nx_huge_pages_perf_test -b 16G -s anonymous_hugetlb_1gb
[Unpatched] Max fault latency: 8496724 cycles
[Unpatched] Max fault latency: 8404426 cycles
[ Patched ] Max fault latency: 49418 cycles
[ Patched ] Max fault latency: 51948 cycles

$ ./nx_huge_pages_perf_test -b 16G -s anonymous_hugetlb_2mb
[Unpatched] Max fault latency: 5320740 cycles
[Unpatched] Max fault latency: 5384554 cycles
[ Patched ] Max fault latency: 50052 cycles
[ Patched ] Max fault latency: 103774 cycles

$ ./nx_huge_pages_perf_test -b 16G -s anonymous_thp
[Unpatched] Max fault latency: 7625022 cycles
[Unpatched] Max fault latency: 6339934 cycles
[ Patched ] Max fault latency: 107976 cycles
[ Patched ] Max fault latency: 108386 cycles

$ ./nx_huge_pages_perf_test -b 16G -s anonymous
[Unpatched] Max fault latency: 143036 cycles
[Unpatched] Max fault latency: 287444 cycles
[ Patched ] Max fault latency: 274626 cycles
[ Patched ] Max fault latency: 303984 cycles

We can see about a 100x decrease in maximum fault latency for both
2M pages and 1G pages. This test is only timing writes to unmapped
pages that are not themselves currently undergoing NX huge page
recovery. The test only produces interesting results when NX huge page
recovery is actually occurring, so the parameters are tuned to make it
very likely for NX huge page recovery to occur in the middle of the
test.

Based on latest kvm/next.

[1]: https://lore.kernel.org/kvm/20240906204515.3276696-3-vipinsh@google.com/
[2]: https://lore.kernel.org/kvm/20240906204515.3276696-1-vipinsh@google.com/
[3]: https://lore.kernel.org/kvm/20221109185905.486172-2-dmatlack@google.com/
[4]: https://lore.kernel.org/kvm/20250616181144.2874709-1-jthoughton@google.com/

David Matlack (1):
  KVM: selftests: Introduce a selftest to measure execution performance

James Houghton (3):
  KVM: x86/mmu: Only grab RCU lock for nx hugepage recovery for TDP MMU
  KVM: selftests: Provide extra mmap flags in vm_mem_add()
  KVM: selftests: Add an NX huge pages jitter test

Vipin Sharma (3):
  KVM: x86/mmu: Track TDP MMU NX huge pages separately
  KVM: x86/mmu: Rename kvm_tdp_mmu_zap_sp() to better indicate its
    purpose
  KVM: x86/mmu: Recover TDP MMU NX huge pages using MMU read lock

 arch/x86/include/asm/kvm_host.h               |  43 +++-
 arch/x86/kvm/mmu/mmu.c                        | 180 +++++++++-----
 arch/x86/kvm/mmu/mmu_internal.h               |   7 +-
 arch/x86/kvm/mmu/tdp_mmu.c                    |  49 +++-
 arch/x86/kvm/mmu/tdp_mmu.h                    |   3 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 .../testing/selftests/kvm/execute_perf_test.c | 199 ++++++++++++++++
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +-
 .../testing/selftests/kvm/include/memstress.h |   4 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  15 +-
 tools/testing/selftests/kvm/lib/memstress.c   |  25 +-
 .../kvm/x86/nx_huge_pages_perf_test.c         | 223 ++++++++++++++++++
 .../kvm/x86/private_mem_conversions_test.c    |   2 +-
 13 files changed, 656 insertions(+), 99 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/execute_perf_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/nx_huge_pages_perf_test.c


base-commit: 8046d29dde17002523f94d3e6e0ebe486ce52166
-- 
2.50.0.727.gbf7dc18ff4-goog


