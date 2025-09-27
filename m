Return-Path: <linux-kernel+bounces-834825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9140ABA599F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 671207AB73D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D42A271457;
	Sat, 27 Sep 2025 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AUospkRK"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C65A26A09B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953360; cv=none; b=MfOTmfyXt90MnKIiGHBK9bM3fFuu+WufYRFL+kB1DgiSGO7FwBWLv6ZHQt03ItNtofIoPFWdPQ8547uo6K3WNfHE76oxi5K/awo3hZ9WHPf9Mlut5QooLHMbhDJB4D1o5J1cvIv/tztjtGg7V8N4kpJQF0k7qlH4qG0xLX+tD3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953360; c=relaxed/simple;
	bh=tJ8obNyJBSqLGai4C6/dtRkSVtfSlPwriPRv35bhdks=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MoegBdtU1CwNYtpZj86YQxGnNv3jGD+3bdsQCJH8HsI/1+GRDBXMF8vbQhLQCXQRmnVXuDAZougybI4a/qvDfXmDHuDU3BE8kGMbjBTH3ZGY+6rTvq+6NRRQyP2UUpmbhkBlQN8sHnG8gYmrPvKuBhf3M4tnAGqenT3xyE2Cs0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AUospkRK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32eaeba9abaso4265539a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758953359; x=1759558159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nEYtlx+tuY9254QaVsQTChmKIULD0WdOC0xeQldlmcQ=;
        b=AUospkRKqBhrmApc19wqDc+8qulSckHd6P3R2fRDxmtiSe/lfGuBxRchjf7Fv4FlsT
         dqGSgbfhKF4LCUhgvb31BoNjzwzq+x2J/9wUsf+5GLZYHxWY255NdVEAzam5i+DFIv7j
         nNkxRtZQ9arqkKu1QMKjjuBlLxKthONnwolm0tNQjWfHHQDXGn8TSvMGWiKDcI5jpFmt
         u5VpR7qJE4bbu2NLzj+3wBayRS+1tpGYzrBXMeWQuNNw2+pqqVJ0JZ8Lbj0KWB3lHdTU
         Dp2LD44+mK5BmEhqi20O1drNsfsGWO76g9SHSHBGg8QwW6JEs7Wr9ApJ78umudf7T0JT
         7wPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953359; x=1759558159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEYtlx+tuY9254QaVsQTChmKIULD0WdOC0xeQldlmcQ=;
        b=sfxfmTwdITsfxb8Yzbt0jHTRa6eLoZ7+pDfwWczOF/fRJFf/2/IZgnlyw81kPa2wUq
         xpkZQ4PHzSzRuZ6q+dsp8T1zz4oye+JPB58mrHo28PgZKikUGY/gaTOJp1vQX84mgP7O
         MSKTwvvwVv5GBe7V4dkFXYprUL+PMQ0X5XG+OhwTZsneOBnEUGUThN3mNMSlRoFYYjyh
         dbz5DITOBt50+ZTuZdgeOF+nPmZazyzjWf+GdSJxIUw5ZAikotJPCTlFh5Cm0TcLCO7Q
         EUbz533J1LJnXZ21jod6OCYLBO5IkyICmujqXDmpnxNxcZv7jdF10G4o52tgh43vn0oE
         skSA==
X-Forwarded-Encrypted: i=1; AJvYcCWsN4FadDBCU1uqlmlRdXYTetJu1ZZZmJM6qz071R1YDznEHwJndwBQoK6MO01Sr2Fb31dWG0wHAj3XXLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPI8i1sK33S1wMkzt6gkHHF2lxjei/yYgvLHyybNxvU5d9tym
	MXuY3JyhfG8UqFXoR5E5C3bK/VSXG0k7zvrn/zEEe9KMddCN0W6pI9EIhYqCOcpIpmZFVG2W0bv
	m4qc8eA==
X-Google-Smtp-Source: AGHT+IEjU4cRNO8ssbDd40p0Rsm4mPs9yM8f3bA7Ta6b1kdGrzwQAEELJFb2X6mjbzvKi6hTLmu6hH7IwgM=
X-Received: from pjrd6.prod.google.com ([2002:a17:90a:b306:b0:32e:a3c3:df27])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4f86:b0:31e:cc6b:320f
 with SMTP id 98e67ed59e1d1-3342a2574b0mr10461278a91.5.1758953358557; Fri, 26
 Sep 2025 23:09:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Sep 2025 23:09:04 -0700
In-Reply-To: <20250927060910.2933942-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927060910.2933942-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250927060910.2933942-5-seanjc@google.com>
Subject: [GIT PULL] KVM: Selftests changes for 6.18
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A mix of fixes, cleanups and new coverage.  Note, there's also a large-ish new
MSR selftest coming in through the "cet" pull request.

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-selftests-6.18

for you to fetch changes up to df1f294013da715f32521b3d0a69773e660a1af5:

  KVM: selftests: Add ex_str() to print human friendly name of exception vectors (2025-09-23 08:39:02 -0700)

----------------------------------------------------------------
KVM selftests changes for 6.18

 - Add #DE coverage in the fastops test (the only exception that's guest-
   triggerable in fastop-emulated instructions).

 - Fix PMU selftests errors encountered on Granite Rapids (GNR), Sierra
   Forest (SRF) and Clearwater Forest (CWF).

 - Minor cleanups and improvements

----------------------------------------------------------------
Alok Tiwari (1):
      KVM: selftests: Fix typo in hyperv cpuid test message

Dapeng Mi (2):
      KVM: selftests: Add timing_info bit support in vmx_pmu_caps_test
      KVM: selftests: Validate more arch-events in pmu_counters_test

Gopi Krishna Menon (1):
      KVM: selftests: fix minor typo in cpumodel_subfuncs

James Houghton (1):
      KVM: selftests: Fix signedness issue with vCPU mmap size check

Sean Christopherson (8):
      KVM: selftests: Move Intel and AMD module param helpers to x86/processor.h
      KVM: selftests: Add support for #DE exception fixup
      KVM: selftests: Add coverage for 'b' (byte) sized fastops emulation
      KVM: selftests: Dedup the gnarly constraints of the fastops tests (more macros!)
      KVM: selftests: Add support for DIV and IDIV in the fastops test
      KVM: selftests: Track unavailable_mask for PMU events as 32-bit value
      KVM: selftests: Reduce number of "unavailable PMU events" combos tested
      KVM: selftests: Add ex_str() to print human friendly name of exception vectors

Sukrut Heroorkar (1):
      selftests/kvm: remove stale TODO in xapic_state_test

dongsheng (1):
      KVM: selftests: Handle Intel Atom errata that leads to PMU event overcount

 tools/testing/selftests/kvm/include/kvm_util.h     | 17 +++--
 tools/testing/selftests/kvm/include/x86/pmu.h      | 26 +++++++
 .../testing/selftests/kvm/include/x86/processor.h  | 35 ++++++++-
 tools/testing/selftests/kvm/lib/kvm_util.c         | 42 ++---------
 tools/testing/selftests/kvm/lib/x86/pmu.c          | 49 +++++++++++++
 tools/testing/selftests/kvm/lib/x86/processor.c    | 39 +++++++++-
 .../selftests/kvm/s390/cpumodel_subfuncs_test.c    |  2 +-
 tools/testing/selftests/kvm/x86/fastops_test.c     | 82 +++++++++++++++++-----
 tools/testing/selftests/kvm/x86/hyperv_cpuid.c     |  2 +-
 tools/testing/selftests/kvm/x86/hyperv_features.c  | 16 ++---
 .../testing/selftests/kvm/x86/monitor_mwait_test.c |  8 +--
 .../testing/selftests/kvm/x86/pmu_counters_test.c  | 67 ++++++++++++------
 .../selftests/kvm/x86/pmu_event_filter_test.c      |  4 +-
 .../testing/selftests/kvm/x86/vmx_pmu_caps_test.c  |  7 +-
 tools/testing/selftests/kvm/x86/xapic_state_test.c |  4 +-
 tools/testing/selftests/kvm/x86/xcr0_cpuid_test.c  | 12 ++--
 16 files changed, 303 insertions(+), 109 deletions(-)

