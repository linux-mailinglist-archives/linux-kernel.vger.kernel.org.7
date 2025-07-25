Return-Path: <linux-kernel+bounces-746411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE2AB12672
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19531CC47DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2025D533;
	Fri, 25 Jul 2025 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="03V7FVBs"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8A2571B6
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481242; cv=none; b=SPIrt6ghfQozm93y4NhhQQBQ+9hG3lLqdcvmiRqrmNaMPRUCGe/gNl0qM+KHsQcIQijPy8te7UVCHszo00riwu/ZsBnntSNAc9GqUpZtQ5ORCuABkUkHIE3HkOCv7CuoBxc2gm8ko8ltr1JANHCx7mHolQST2Uvw1CstCeYsW8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481242; c=relaxed/simple;
	bh=dOClt1NwvDVpRU80gTFWcyuWOIvVeKn+ThhysRynZpk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cxyZ6VwNi5kM+28eR7cXaVUQU+1g2YUGtxztzc7j6rgKqlTVvom5+5tUVC+7IB24k9dBhHGfR2iu6e4UoemzcomwXoA8EwEJGUUM1nIdMxLZilXq5p0HiDoKFXcaBTho/qrZdpfjNQpumPFEx5YBgy9xTZ+igzqGBOBHG1YFUZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=03V7FVBs; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-754f57d3259so3795421b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753481240; x=1754086040; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tBeOKKUu9MDa10fqJN9yMcoaQctbrDlnjx6wVe8w2s4=;
        b=03V7FVBsJuaO+bs4PQNpAHM+QIXNFV77gO80TKvm3fdMqsrubuw7WvOyXLl5PgQqWi
         wUdgbewLu8mllwxvRAzTuT38EBgn4pdQncuYVpRGGvOrC6eZT4zWiUaNjDQ7Y6njw+P9
         gTM4I5/uahtUg19sy+kPDUZfQxSIsJFA7Up8NBqV9amFGtAeMag5Q1HZHHcjgb8R4Zfw
         gCrx2uFadC2MNOgBthCUNaejCENVA1MSuGy6esNBk5uvbJAj4rG7uFq7mCU9nKZO1q2R
         ugwx6AuLYi7CRa2D3Eb0sRCDehqZ7wczIhl8DOexg7AXn988VXhuT50n6/BbvVvJEQAa
         0SbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753481240; x=1754086040;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBeOKKUu9MDa10fqJN9yMcoaQctbrDlnjx6wVe8w2s4=;
        b=bgxSeyAs+6gQTAQ6xLdBMXhqhuEtMwb40mEWTJQfxxxuCuEGTfYB1HbZ+nxSTdtaTe
         JB1APrp3SfaIV5g8v0VigK/WNAfuWexv5S3VuxQDKtSbDwxMVBYMYjBwF5w+eCx2V/fU
         bMzgK4wDvjVayW0DUuLuzYgzhkugl4Ruxh3SH8NLIdyYMV4U5SKhhTIZ3q9n6VtA1BZg
         UTURtCmm6w7i0IrvEhiooS/6uwmNdOyu2NOe5CBI8L3NQk1S+vEh15MR8ceQaCkhcJRz
         Mo95ftUW92SsLHpymnMjBPZ1cA08MPMPm75Kr21MFvZ+cHmq6GFLNlesaBBg42U0iL/W
         n1iw==
X-Forwarded-Encrypted: i=1; AJvYcCXAUAdOD4hFhoMwApDANUpsSrqd+7WnYLARpDuda7WdGqzfUEv60lNZ10IKJVWUU69O7fswkCSb3rM+XRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwiVT8A17FKfEjkiq2mKxBEM4x16a22ZZeQRTSBoAorXx/kcOH
	ylGemyaMmR2sTr6IGJ9vJ0LfmvCOy9Rbnrh6J5pyvjakJcGPQJz5CWMyL33A/Wb7EW0EF6PSXum
	b9lqKBw==
X-Google-Smtp-Source: AGHT+IFKtV9YCuYm4GMi+ww4GUsiHDRGAnCY76kK5cmeJMRiwgSG/xrwCu5Vp5xBw7Fb5VOjtzhjarlLP1U=
X-Received: from pgmt19.prod.google.com ([2002:a63:2253:0:b0:b3f:3788:ecc1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d19:b0:220:9174:dd5f
 with SMTP id adf61e73a8af0-23d70053439mr6107339637.15.1753481239990; Fri, 25
 Jul 2025 15:07:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 25 Jul 2025 15:07:02 -0700
In-Reply-To: <20250725220713.264711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725220713.264711-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250725220713.264711-3-seanjc@google.com>
Subject: [GIT PULL] KVM: Dirty Ring changes for 6.17
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A set of Dirty Ring changes to fix a flaw where a misbehaving userspace can
induce a soft lockup, along with general hardening and cleanups.

The following changes since commit 28224ef02b56fceee2c161fe2a49a0bb197e44f5:

  KVM: TDX: Report supported optional TDVMCALLs in TDX capabilities (2025-06-20 14:20:20 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-dirty_ring-6.17

for you to fetch changes up to 614fb9d1479b1d90721ca70da8b7c55f69fe9ad2:

  KVM: Assert that slots_lock is held when resetting per-vCPU dirty rings (2025-06-20 13:41:04 -0700)

----------------------------------------------------------------
KVM Dirty Ring changes for 6.17

Fix issues with dirty ring harvesting where KVM doesn't bound the processing
of entries in any way, which allows userspace to keep KVM in a tight loop
indefinitely.  Clean up code and comments along the way.

----------------------------------------------------------------
Sean Christopherson (6):
      KVM: Bound the number of dirty ring entries in a single reset at INT_MAX
      KVM: Bail from the dirty ring reset flow if a signal is pending
      KVM: Conditionally reschedule when resetting the dirty ring
      KVM: Check for empty mask of harvested dirty ring entries in caller
      KVM: Use mask of harvested dirty ring entries to coalesce dirty ring resets
      KVM: Assert that slots_lock is held when resetting per-vCPU dirty rings

 include/linux/kvm_dirty_ring.h |  18 ++-----
 virt/kvm/dirty_ring.c          | 111 +++++++++++++++++++++++++++++------------
 virt/kvm/kvm_main.c            |   9 ++--
 3 files changed, 89 insertions(+), 49 deletions(-)

