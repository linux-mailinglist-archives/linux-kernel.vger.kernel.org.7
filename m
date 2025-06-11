Return-Path: <linux-kernel+bounces-682536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2453AD6174
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 23:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A973AB756
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 21:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33BF244667;
	Wed, 11 Jun 2025 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J+gN7p+Z"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B63380
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677762; cv=none; b=mA9hwMywUAkPrEUfp/qlGTGZFYVymHKQXbSXkAx6j4j4hcj3rADWJreF7Y0AHsuzj+Xq3ntJ+MCfiI03pdZU/eWFWjRiL03Gu4ycuynDS/9Jc8wT04aMj6LoxARKlExBXFUyTwam91q7uGSA02HzznaeUf+VeseZ3XIZZrF03BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677762; c=relaxed/simple;
	bh=xrXCXEE5X80+3t6cu/KauRicKGyvW4P82JBR8PfJ/Ag=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=m942b9Osjl/vbGX9e8x7VPQ3o87z0pwqD7FNIcHaytmtsbo6Re5aESUl7Ov6JCukv3blCVPZrl7kL3gzMwTiPWh2i2S7uyeBuNYDsdfOHDDe9LxEAIvzpnsCER7I5oOd50TLLw3aHBBYgo/ks7NHDq7a8PMBmvRgQKCZnmtb4CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J+gN7p+Z; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2355651d204so1797705ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 14:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749677760; x=1750282560; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IcmBd622WcHMOVHZB6OFu12SHal0z947c0kQ48vgFY=;
        b=J+gN7p+Zf77DkzocliSxXY+AQNdLkm9WopOIf8nemyzW6mCbjsHPCJOQeudPTCTJYj
         hSerAKY3mFIk9oddbCmSZj1yRLbB7YvcijvX37duIq6+o++DveP/r22EeFk6d4gOUi17
         9iOlz0oOlEiZCXoO/a3Wq5tg4KcW+NRACnyFxrtVSnMZxqSqSIOlcv7LtHowjvMKykai
         QJ420HBKOtmpGEtXzrFQfaSZNWgS3fbcZEQyCfi5YuNgZEg9TKSwNfMWjrdm+DeqXNDR
         I5PX31MTe1q20M83eTxfm71dnLlB2Jk9PcquJfMpGk83DD8c90q1uxlZIjgjeby1Xi7P
         FyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749677760; x=1750282560;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IcmBd622WcHMOVHZB6OFu12SHal0z947c0kQ48vgFY=;
        b=rDz3H1Ekzzo8CkGfo1p+APQyOvqs5xye4Xyv+O2RpPmnvVxNgbRCLBi9P7QESv09pC
         YgSvOzFiI5a2T5mONfMtsiHuIQ5GSgzGIg5rxfofU1i1iC20bHHH5C63MnA8JtMIpu1c
         sqUrdgACOBxFn3a4B6grezYi75kIuGTtRWjYtwi3gP+ENHkzopeppu2h2Gv8Ra4Jab0b
         Vp/xQT16+4nI8gZoYyMUeNUxgwxXw4XsQ1HUFq/kPnYDpYlBPwpkGye7C5j+Oj/8WYh7
         gAg3W8Ej323sF+JvIde15ZyIj2N012Tw7ZXGHTNf3OMDgOahh4OiWYn7QS1ij82fRSOy
         ZnCw==
X-Forwarded-Encrypted: i=1; AJvYcCXsi/+lTky+Kw44bM86BRiwnxKdnA196TlQga9ghUwRz8hAQ2yiFH4JCUP/BPJmDOVVGuWSk6fhHpM4nVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRrHD5s0UCcjr9AkK01UIQJQFDq+vNN1XkbzErQhcFrLlJfvBL
	Rop+w5Epm40XYIZGxu8zBm/iLyrhXstCWufpR1RsTNZJwBoOkl2jIA5Ch4469WybagfzE9HrYSK
	OpbjKlA==
X-Google-Smtp-Source: AGHT+IE4XH/OC2Iw8DaPJ4HTHpV5OX6/6vmmyrAmtCwBAR3UB6uVms1/MlWYcYS7wNtEgSk+3aV2UoD9HAM=
X-Received: from pjtd16.prod.google.com ([2002:a17:90b:50:b0:312:dbc:f731])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d2c6:b0:234:c65f:6c0f
 with SMTP id d9443c01a7336-23641aa245dmr57140055ad.8.1749677759907; Wed, 11
 Jun 2025 14:35:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 14:35:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611213557.294358-1-seanjc@google.com>
Subject: [PATCH v2 00/18] KVM: x86: Add I/O APIC kconfig, delete irq_comm.c
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add CONFIG_KVM_IOAPIC to allow disabling support for KVM's I/O APIC (and PIC
and PIT) emulation, and delete irq_comm.c by moving its contents to other
files.

Vitaly and Kai, I didn't apply your review/ack to the Hyper-V patch, as I ended
up keeping the helper as kvm_hv_synic_set_irq() to fix the tracepoint
inconsistency and the bad changelog.

v2:
 - Keep kvm_hv_synic_set_irq() instead of renaming it kvm_hv_set_sint() to
   stay consistent with kvm_pic_set_irq() and kvm_ioapic_set_irq(), and with
   its tracepoint. [Vitaly, Kai]
 - Keep kvm_setup_default_irq_routine() instead of folding it into I/O APIC
   allocation, but rename it to kvm_setup_default_ioapic_and_pic_routing().
   [Paolo].
 - Move a bit more code out of x86.c (this time into i8254.c).
 - Guard more code with CONFIG_KVM_IOAPIC (e.g. struct kvm_pit).
 - Fix a changelog typo. [Kai]
 - Collect Kai's Acked-by. [Kai]

v1: https://lore.kernel.org/all/20250519232808.2745331-1-seanjc@google.com

Sean Christopherson (18):
  KVM: x86: Trigger I/O APIC route rescan in
    kvm_arch_irq_routing_update()
  KVM: x86: Drop superfluous kvm_set_pic_irq() => kvm_pic_set_irq()
    wrapper
  KVM: x86: Drop superfluous kvm_set_ioapic_irq() =>
    kvm_ioapic_set_irq() wrapper
  KVM: x86: Drop superfluous kvm_hv_set_sint() => kvm_hv_synic_set_irq()
    wrapper
  KVM: x86: Move PIT ioctl helpers to i8254.c
  KVM: x86: Move KVM_{GET,SET}_IRQCHIP ioctl helpers to irq.c
  KVM: x86: Rename irqchip_kernel() to irqchip_full()
  KVM: x86: Move kvm_setup_default_irq_routing() into irq.c
  KVM: x86: Move kvm_{request,free}_irq_source_id() to i8254.c (PIT)
  KVM: x86: Hardcode the PIT IRQ source ID to '2'
  KVM: x86: Don't clear PIT's IRQ line status when destroying PIT
  KVM: x86: Explicitly check for in-kernel PIC when getting ExtINT
  KVM: Move x86-only tracepoints to x86's trace.h
  KVM: x86: Add CONFIG_KVM_IOAPIC to allow disabling in-kernel I/O APIC
  KVM: Squash two CONFIG_HAVE_KVM_IRQCHIP #ifdefs into one
  KVM: selftests: Fall back to split IRQ chip if full in-kernel chip is
    unsupported
  KVM: x86: Move IRQ mask notifier infrastructure to I/O APIC emulation
  KVM: x86: Fold irq_comm.c into irq.c

 arch/x86/include/asm/kvm_host.h            |  22 +-
 arch/x86/kvm/Kconfig                       |  10 +
 arch/x86/kvm/Makefile                      |   7 +-
 arch/x86/kvm/hyperv.c                      |  10 +-
 arch/x86/kvm/hyperv.h                      |   3 +-
 arch/x86/kvm/i8254.c                       |  90 +++-
 arch/x86/kvm/i8254.h                       |  17 +-
 arch/x86/kvm/i8259.c                       |  17 +-
 arch/x86/kvm/ioapic.c                      |  55 ++-
 arch/x86/kvm/ioapic.h                      |  24 +-
 arch/x86/kvm/irq.c                         | 427 ++++++++++++++++++-
 arch/x86/kvm/irq.h                         |  35 +-
 arch/x86/kvm/irq_comm.c                    | 469 ---------------------
 arch/x86/kvm/lapic.c                       |   7 +-
 arch/x86/kvm/trace.h                       |  80 ++++
 arch/x86/kvm/x86.c                         | 164 +------
 include/linux/kvm_host.h                   |   9 +-
 include/trace/events/kvm.h                 |  84 +---
 tools/testing/selftests/kvm/lib/kvm_util.c |  13 +-
 virt/kvm/irqchip.c                         |   2 -
 20 files changed, 746 insertions(+), 799 deletions(-)
 delete mode 100644 arch/x86/kvm/irq_comm.c


base-commit: 61374cc145f4a56377eaf87c7409a97ec7a34041
-- 
2.50.0.rc1.591.g9c95f17f64-goog


