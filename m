Return-Path: <linux-kernel+bounces-823825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEB5B87860
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AA91B27B17
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9271A9FB7;
	Fri, 19 Sep 2025 00:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1vB3FFw"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81908246786
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242717; cv=none; b=SluYRAANDrDBXWjkN/ZjgosdoSCmBPSJyQSw35Irc/Rc8OvoySbMcyWl1uZA9U2l69w411n4NY+FGZ5hqZaTBEskIlIbJ/BFgWVBJmh85UmfL3m4+ExSfPBbw69uqI/LFQE87Ezk4XwL0csBwvz34k6wB5ItFLeyVJQ5cyngT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242717; c=relaxed/simple;
	bh=bsV77/bMuqebcjiVVvZ5gDl+9q4dLc4oVxblBiG8n+M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=td08eG0BcG5t0IFzjXBCrLAdVxx/PJKF5d0X52muVK1eXn2E8CWu6b8BxACDcFCN/riQlYoXYrxAgFhheBPsey57L899FNtLTwTpDlBt4aA6YGfwE3JmMI3Ihl4LJRCtNL1Ojt5QLIKL0dmU39s51Ctj6FVsu2kv5aQieiYN408=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1vB3FFw; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32d4e8fe166so2010498a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758242715; x=1758847515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7RIKbCZfNFdayGXGxAhpCXDfU3xbJOGgRgNJzlXobZI=;
        b=s1vB3FFwkFGOEAk+bt4cfY42VK0/caVp6N8aC3bp+Fpz7qF04M6PwFIiZLmVjXBiF7
         PnxiQe8/1ZLIy7G38dCHzoVvgjIHf1RYNDmu14NKxSwg7lEoM/l5UclU2AoCSVUac24g
         5DZ6VobsN1ODwFoaTQknSIFmVMwKGGkIjM0/pdO+kvJm2F/oeKAU1eFpLhOyo1OVfq3y
         5Lp3vM4UU+qVC4pJWJQVdNzgxe3qNQuYywKwE3UYQrrVxadp0B+7dsN6zFf+ulD2H8Pc
         wHwXe9CTN8Njan6Gf7oQXdPwIeuz9cA2NF0Xgp7BC2wTchaGMqsO+PEZS3MiEfaJ7lOJ
         eDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758242715; x=1758847515;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RIKbCZfNFdayGXGxAhpCXDfU3xbJOGgRgNJzlXobZI=;
        b=jXuhP9UpneonG5+Ra2h5cBYaP3N2i/WtM+FjsxEOSE3N8y4S5GobzlYfWTVrOvGeLT
         pmAcqH0EM3pPrA1b6pOsqGEs8vxoeBmQku06q2Ra1JDXr042hpAx8T0A79k/Hibvns4m
         VviGQd2LcGAK58fAxO/Qjpx/3SalAxtUYlIXcZPBprc0NFCtEE2KhWpsfksZ6y0NmvxF
         4FK9On0MPvfJWTj3WokYddZl0HvAfgXZ5KNvdv/0iIkMAtBJkOYnRdn8V4sO4dOTHnXz
         7zUhOa7hVYl5gup9M3jP0ku2PCja7C+MGw6o/Zz9rl/6fkpqPY3FJ0eXOyQVWQtPmCYu
         RkFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlwmlLHD+5NrQYecdPiFoY7mzdGTexW/cuUuW+qavD64ajxO/+Dzky3dU41KtTNQcYoRxtffbEjLtuXhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuX3FZmuaWwozJjXRSIQJkT6EvscnYIKMb1+RWfcW0XLuaOUmS
	QvqE44zOtw5iebyYdzezsWNiHxLVMaEjecOW3vNLcnlr7W5ZtF+kt5zNYJ8NHrncrRz/QzbbFSz
	l/46gNw==
X-Google-Smtp-Source: AGHT+IEJX0cGT7ZG0MLkxlnzGuBapT8OTD8Bz86/0A7NTTY2S5UCxJ9fTew6oKc6bJGnhytklRA8oUSqYiw=
X-Received: from pjbsc11.prod.google.com ([2002:a17:90b:510b:b0:32e:7282:b66])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d60c:b0:32e:7bbc:bf13
 with SMTP id 98e67ed59e1d1-3309838d043mr1526033a91.34.1758242714742; Thu, 18
 Sep 2025 17:45:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Sep 2025 17:45:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919004512.1359828-1-seanjc@google.com>
Subject: [PATCH v3 0/5] KVM: selftests: PMU fixes for GNR/SRF/CWF
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Yi Lai <yi1.lai@intel.com>, 
	dongsheng <dongsheng.x.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fixes KVM PMU selftests errors encountered on Granite Rapids (GNR),
Sierra Forest (SRF) and Clearwater Forest (CWF).

The cover letter from v2 has gory details, as do the patches.
 
v3: 
 - Make PMU errata available to all tests by default.
 - Redo testing of "unavailable PMU events" to drastically reduce the number
   of testcases.

v2:
 - https://lore.kernel.org/all/20250718001905.196989-1-dapeng1.mi@linux.intel.com 
 - Add error fix for vmx_pmu_caps_test on GNR/SRF (patch 2/5).
 - Opportunistically fix a typo (patch 1/5).

v1: https://lore.kernel.org/all/20250712172522.187414-1-dapeng1.mi@linux.intel.com

Dapeng Mi (2):
  KVM: selftests: Add timing_info bit support in vmx_pmu_caps_test
  KVM: selftests: Validate more arch-events in pmu_counters_test

Sean Christopherson (2):
  KVM: selftests: Track unavailable_mask for PMU events as 32-bit value
  KVM: selftests: Reduce number of "unavailable PMU events" combos
    tested

dongsheng (1):
  KVM: selftests: Handle Intel Atom errata that leads to PMU event
    overcount

 tools/testing/selftests/kvm/include/x86/pmu.h | 24 +++++++
 .../selftests/kvm/include/x86/processor.h     |  7 ++-
 tools/testing/selftests/kvm/lib/x86/pmu.c     | 49 +++++++++++++++
 .../testing/selftests/kvm/lib/x86/processor.c |  4 ++
 .../selftests/kvm/x86/pmu_counters_test.c     | 63 +++++++++++++------
 .../selftests/kvm/x86/pmu_event_filter_test.c |  4 +-
 .../selftests/kvm/x86/vmx_pmu_caps_test.c     |  3 +-
 7 files changed, 133 insertions(+), 21 deletions(-)


base-commit: c8fbf7ceb2ae3f64b0c377c8c21f6df577a13eb4
-- 
2.51.0.470.ga7dc726c21-goog


