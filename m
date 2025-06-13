Return-Path: <linux-kernel+bounces-686343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FCEAD962A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 22:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF6943B9FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 20:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D6B2441A7;
	Fri, 13 Jun 2025 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sCpkmZ51"
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC9230BD2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846200; cv=none; b=bSDEAufmiIS6cjRlCurGTCS2N3HyCf+X8jLuoxMDtV1UWjiNOzXdb2UIXi2aQzdaJSTnoa4Kvd6c7GmhlQXB7EXM0A6fTVl8bGTct35Kh4nOCWESWzfGwxj1Krw625mM9lJ5NNpkBWQtHKurz8hxEWFJ6eQl/XSlHSMIumnrmPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846200; c=relaxed/simple;
	bh=8gmILVzYXPmjjGUIsH9eWGR9Rra1qOYhb4nQNPz0gc4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N4Yv6C24oIj0FCYIo5hsdlI8MxlJ1mUlanCjXOwc7HyHFK9UByr8j3EjSRhYqd88Jd2/23jAJ/KO6MWCsJcxFre7KIcciEGrkhXZ06AdXGosUWtOYJG6K6NidSU9z7pUrOJCVww48HO82aPyb//QtX0HPW7EIDGsruXK6lgokh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sCpkmZ51; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6fad9167e4cso48766766d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jun 2025 13:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749846197; x=1750450997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DX/xHz+tMRHmnLBdQrk8X6gYCRIzZ4iFb/dOIXUWY1s=;
        b=sCpkmZ51YQUmA7hCWuiTLTZpm7VwgS/G1bhJlh4SyhljRF8hUiiJqq3KN4+tnTruTu
         qZC8az7MCHBSbuPfbvHOoYeDhXkbhs2bzYkaFe1p7vBPYAioWjIgwJC7mWc5cODtgPPO
         nLnSytTgumt5PGdhTz8bLSQBk4NX32z3hu+ii/JDZwbfP5DSoQqbVk6XEn0vOts3bljg
         hSWp/7lqjgZS4inp5lh2NWL7dIB3e4km5ojbIkQgBt/spQMVXG3eBhJzxwkCVyWD/vis
         znrf/SXsGouSAHGbU/vx/0gqAPWl7fJ7sa+HgvPpyg8CSrRQakzBwsK1XU7jJZefaiAw
         ig8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846197; x=1750450997;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DX/xHz+tMRHmnLBdQrk8X6gYCRIzZ4iFb/dOIXUWY1s=;
        b=P/V4jTX6qDaDV/Qr9FsBcBihniu8xJ7Fvqh1ABdc5HmBB4parzKe6EPCybk2fuHeWO
         QYsD/RXpaxtx2+62CiszkE21MbIVfd9ZEjsiFHeIZAOyCV48FInIpsXoQtFsAW5CyEsk
         lQqgD68+pQV7IyBMZN2oCJ8KJ601nYHqIhh9OKlL+3WLRBax+Auk3jGKFafmJoiHjz26
         FVwgYRBT09iUZ4IU6OlLlj3RqA5SAjVow86dOUH1zTP3T8ya3L6ex7EoXBY3LGQ6ueFD
         /godf1ZjJS8FQXxrPyuP2m+NH47wryRpjcxKu2323v8PDCEUQUyjZhVvq2T7zrEvV0GT
         SRiA==
X-Forwarded-Encrypted: i=1; AJvYcCUFk95o2Lxpaweye9neFVJ8SQuEkce8l4JgCU48kSwu+CqrsMz5o9iC4h4OWAUBbSFy29fxgqsR+gboySM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXiWv4zUgsOx05HLHoJywsb96Cj67PI12F2Nr+ce3n29ynuWRU
	mjBB9ZSeBRi/0QaThGyTcjOAP1JAGCoEpaYbEvsM5S1WkbFoE05d7gjsvceVatI6JLhq9OLL5jP
	Ct8Bj7eJmkzYpIYgcssQy4w==
X-Google-Smtp-Source: AGHT+IHyGNtB7NefXVdv8iF+PBR2LESsvOZ54jrXgI5FfNPmf14/uKsjZFUZ5pZQkvN595I2eUBiQ9ycClKVNbdl
X-Received: from qvbqm17.prod.google.com ([2002:a05:6214:5691:b0:6fa:ffa2:11b6])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:434a:b0:6fa:c653:5da8 with SMTP id 6a1803df08f44-6fb473f343dmr14454936d6.0.1749846197151;
 Fri, 13 Jun 2025 13:23:17 -0700 (PDT)
Date: Fri, 13 Jun 2025 20:23:07 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250613202315.2790592-1-jthoughton@google.com>
Subject: [PATCH v4 0/7] KVM: x86/mmu: Run TDP MMU NX huge page recovery under
 MMU read lock
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sean/Paolo,

I'm finishing off Vipin's NX huge page recovery optimization for the TDP
MMU from last year.

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

 arch/x86/include/asm/kvm_host.h               |  39 ++-
 arch/x86/kvm/mmu/mmu.c                        | 175 +++++++++-----
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
 13 files changed, 646 insertions(+), 100 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/execute_perf_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/nx_huge_pages_perf_test.c


base-commit: 8046d29dde17002523f94d3e6e0ebe486ce52166
-- 
2.50.0.rc2.692.g299adb8693-goog


