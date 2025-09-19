Return-Path: <linux-kernel+bounces-825240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A535B8B63B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1517D3B8D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC49C2D1F42;
	Fri, 19 Sep 2025 21:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UX6JsU0F"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BA4209F43
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758318417; cv=none; b=jiIOSXDMwEZKESq2r7A70Exi6dTHATSBVzSGe8+JRZRLFjFf0pUCCVAvNKhSY+aF/334W8aYWTjtiLMWIMjxO4aBhhfdjI8cIBXDnvDLFOq93Lqxy6PEK0qhcRwfQc4TumBk6ONd+WzYHUn0YWiEwqUSmIPAekGLDV3eOUnJQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758318417; c=relaxed/simple;
	bh=AUS4nr/rDif+V+xe9IsqZ5FN2gkmrqhx2jRuWPZTdfA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=X4PHCm6HTCKSUSFBo7yuz2TvqvVhTWCpZICRjphnuNEDKJzl6cmdm/kWm5Xop7RlXWuW/oY63kXWNZo3ENuHrJMs4pHMN7nFtiguqtiFotgqRVbwnWW9OE0Q6EM9aVc2375XyHrXn4+JF9kot3C2znFLscX/ateae25JinsZMTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UX6JsU0F; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so2241437a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758318415; x=1758923215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=undFp4zdqw4NCnpIkyyBd40cMSqd4jcrOix/QDPRRVs=;
        b=UX6JsU0FFtad4SvGeJ60tGZ24lVMa1SD7/ZcypZQ7XQ/P7NpHpYKa1xkuIz6wwOMbg
         dm2yrP+vsyakKJmfB8u/GP/7XccZlbJoZv8XiQjA47aKVrcU766uUPWWkBcjRUGRBcYp
         gmfSoLV0PPtoj0LyqyYBViE5rYdB1K8AJIOroWcbJ45zrJwoBqzdXDqklfc9ssSijIIM
         lziwQ+BuHiRr71Ls37hxSEYDlv8D8CONOGHAl9P2LKzTm5WtEoXrBvwA4Zn6/u5/yy0z
         r9kQNxJqtPiasNEH+YlH8hHTf0Ym0LqTXuoEBRhWq7iCHt7hwUAvqMijGXsznMDbOWcI
         7gBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758318415; x=1758923215;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=undFp4zdqw4NCnpIkyyBd40cMSqd4jcrOix/QDPRRVs=;
        b=ThJw36cKI5n/szHk9QaahTL3UqWpcJ6GYKSJrGe776FZijbDKvI6wMNjKs2FoNR3y4
         3GVeHZiTCQqXojnXWHlM81RmB4lah0fMrGyXWFpn9t4uJWC9ZPT3BnyYV85V7hDf5HM7
         +yfERi/ZH5w6476u2KdssLn3sqi2jke0tas0NPR+uxlYBIF1Q8fgVP1fmezSZOLBN804
         5DcrI+sWheYPHjQrluUKzuw+Z4FxrrwhLX4JE4zR/WcF2JHaA4hl0I5DK5Xzh2aKpWU9
         zSSdjepF2t0l522l7L1119wDwGNRaYT9vkPbqOFEwe5jFOZQKSTMjCzjeGUyB6YUI2uf
         VagQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIJKNA13/NVnVxHHin/i2W2k6G1BkhLhY5ajkdbDff1m7u8yvVDw7Dn3Ycx9+Inhcdqol+Sfv+iueelSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzddD5aqESzJWPAGbIngzHAVw4oRET5Qgl4hjDeHA9GgxYEureB
	UhCBMTIdggrW5v+re+OK5qZymjg5MaG09KXqbr6uvbyGGhT7s8JzqpgO+X9hkltHJes3Wm/M9/H
	ESHwXDQ==
X-Google-Smtp-Source: AGHT+IHwURqvd642KdaTU1mfj20eabhbJ6uKkmnO/La3OtCyYCA2+pljnIKs8G/Z4MSixUbzNEv0v+P15kw=
X-Received: from pjbqn15.prod.google.com ([2002:a17:90b:3d4f:b0:32e:aa46:d9ab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2cc6:b0:32b:9774:d340
 with SMTP id 98e67ed59e1d1-33098386bfemr5830642a91.33.1758318415162; Fri, 19
 Sep 2025 14:46:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 14:46:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919214648.1585683-1-seanjc@google.com>
Subject: [PATCH v4 0/5] KVM: selftests: PMU fixes for GNR/SRF/CWF
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Yi Lai <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fix KVM PMU selftests errors encountered on Granite Rapids (GNR),
Sierra Forest (SRF) and Clearwater Forest (CWF).

The cover letter from v2 has gory details, as do the patches.

v4:
 - Fix an unavailable_mask goof. [Dapeng]
 - Fix a bitmask goof (missing BIT_ULL()). [Dapeng]

v3: 
 - https://lore.kernel.org/all/20250919004512.1359828-1-seanjc@google.com/
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

 tools/testing/selftests/kvm/include/x86/pmu.h | 26 ++++++++
 .../selftests/kvm/include/x86/processor.h     |  7 ++-
 tools/testing/selftests/kvm/lib/x86/pmu.c     | 49 +++++++++++++++
 .../testing/selftests/kvm/lib/x86/processor.c |  4 ++
 .../selftests/kvm/x86/pmu_counters_test.c     | 63 +++++++++++++------
 .../selftests/kvm/x86/pmu_event_filter_test.c |  4 +-
 .../selftests/kvm/x86/vmx_pmu_caps_test.c     |  3 +-
 7 files changed, 135 insertions(+), 21 deletions(-)


base-commit: c8fbf7ceb2ae3f64b0c377c8c21f6df577a13eb4
-- 
2.51.0.470.ga7dc726c21-goog


