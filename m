Return-Path: <linux-kernel+bounces-661179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14823AC2798
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 18:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B288D1B63444
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 16:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B422298CBD;
	Fri, 23 May 2025 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yxn2CxIW"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31431298C00
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748017518; cv=none; b=if8xa9nGWvZI9eO5tD44DmjlJE7AbHNSDeR4j9rA8UMhX/bli3pFsU1fEBAU9btX6WHvGgkuQdTL1Kk7iSvOKeqZ92pTldlLsofm5Nep1qWz56fqX2uHrpAJptdAhu/qHZDmB9ZUi92sPPOpnvZIn9Xfpm8QHuOopkq4F9Qkt7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748017518; c=relaxed/simple;
	bh=pGUeqwprGZoXCxhP3CpFNIt3D2yK6irBdnlxCagzO9w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ITNalDGKcweClAepMHbncUthSkzvHtVUGosC0XgdOK3WRytL7Bv3gjxJMTc6SeXpLmxAMLpMku5/kd1OTxAw/sSmMowZDH6wV1UnY3lKcDAcD1NPSG7GpYy8CFcMrbGoD57I6Gjnq3kieUVxTKU7tZqmrayk7yZvHnu5y2z6gQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yxn2CxIW; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742b01ad1a5so242314b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748017516; x=1748622316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vL9yoVKIvL/ZpPCv2NyD8nz+QWrVMneQrqlXk4GCp6k=;
        b=Yxn2CxIW7WSf7EZ9nkNneb0adNw7OJPtKxAd3aEOylnsIgW9OIRK/idk8Gmxpr4zpQ
         bmZ7ZPgf1y9+McXt8kzxfolybaP23lyWJX0b6kYBksJzVRLQg0lSP7DcxTvS2zzYG/Mu
         kbzcOj2k2eryBESju6k3cYm+e2tix6uCAVXwAHHbfnBgVzhzHpvb83yYDTqadRiFni2r
         JXpeOF4jSRwftrr/ATQsWi3tBtkuBHqIRSWl16XfJ5YERTfmPpIR2r/yw6RafFiSzX44
         p3gpXwAy0sS9h7OMyOjUCNlee7jUtDLx94Xrso83+2YtNKKiSvxXqnS9fk7Ko+9BVLKq
         l6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748017516; x=1748622316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vL9yoVKIvL/ZpPCv2NyD8nz+QWrVMneQrqlXk4GCp6k=;
        b=IDr8QSem9zl/D8quHktYAMcJFj+4SkhtqOKsg9nA1lcPZnE9/kcEV9uEb5jfR6hYuo
         x8JZuKmQl+0DM1Ko6CQ6sfpsGGrRJYsx/1gMviHQ6lIxWrGW9R4zSem0VUOSHEpo9/3g
         9OISB4eezki64SaANzZqxokVcvaArdCp2zP6FxiymZPRsfDqttM6K2maPj81oynrWkJV
         xRnptBG/qRbgNSj5bbHFG0jV66oA5t9jGkbp9TGLV8wNXdFytzoxIq5UiK45SVPjbvch
         88giuwcRYmXulpdWxH8ehwxLNPaK8/93bhyF0e5rBmilghBWAZJO07nFTHbIIWJHg6sq
         AdBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAX2DKUUGCzfQ8AhMoZ0SGsOYt+ti05kz+t4/M8ktXxMHbyfqS38s2AL5+I90WLDnVCR8Bi8CHZuPMJBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4+S7iQZ5tJOeKl5Vq51BgxkTyb6afh46D5zcZ7QC+iMtihBIL
	4u+BIMcb2Y5JXpMlsGAJgO9d78FR3kNccsV9HSu5Tx8S1Mtw8gbdYm0qdYDZJyf3n9LG66cbOrt
	nEirJog==
X-Google-Smtp-Source: AGHT+IEmr+q2Kj7SHDfKCzgWfyENRKXRJEnatn4gL0A2hVQRWGCweVecs/Z9aHB4483uOLHCk6aIA8ioJCk=
X-Received: from pgh6.prod.google.com ([2002:a05:6a02:4e06:b0:b16:5cac:7fb3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:7001:b0:1f5:790c:94a
 with SMTP id adf61e73a8af0-2170cc8fb2dmr46011731637.25.1748017516553; Fri, 23
 May 2025 09:25:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 23 May 2025 09:25:03 -0700
In-Reply-To: <20250523162504.3281680-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523162504.3281680-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523162504.3281680-7-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: VMX changes for 6.16
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

A handful of minor tweaks and fixes, and a big reduction of the boilerplate
needed for forking vt_x86_ops between VMX and TDX.

The following changes since commit 45eb29140e68ffe8e93a5471006858a018480a45:

  Merge branch 'kvm-fixes-6.15-rc4' into HEAD (2025-04-24 13:39:34 -0400)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-vmx-6.16

for you to fetch changes up to 907092bf7cbddee4381729f23a33780d84b1bb7c:

  KVM: VMX: Clean up and macrofy x86_ops (2025-05-02 13:37:26 -0700)

----------------------------------------------------------------
KVM VMX changes for 6.16:

 - Explicitly check MSR load/store list counts to fix a potential overflow on
   32-bit kernels.

 - Flush shadow VMCSes on emergency reboot.

 - Revert mem_enc_ioctl() back to an optional hook, as it's nullified when
   SEV or TDX is disabled via Kconfig.

 - Macrofy the handling of vt_x86_ops to eliminate a pile of boilerplate code
   needed for TDX, and to optimize CONFIG_KVM_INTEL_TDX=n builds.

----------------------------------------------------------------
Chao Gao (1):
      KVM: VMX: Flush shadow VMCS on emergency reboot

Sean Christopherson (2):
      KVM: nVMX: Check MSR load/store list counts during VM-Enter consistency checks
      KVM: x86: Revert kvm_x86_ops.mem_enc_ioctl() back to an OPTIONAL hook

Uros Bizjak (1):
      KVM: VMX: Use LEAVE in vmx_do_interrupt_irqoff()

Vishal Verma (3):
      KVM: VMX: Move vt_apicv_pre_state_restore() to posted_intr.c and tweak name
      KVM: VMX: Define a VMX glue macro for kvm_complete_insn_gp()
      KVM: VMX: Clean up and macrofy x86_ops

 arch/x86/include/asm/kvm-x86-ops.h |   2 +-
 arch/x86/kvm/vmx/main.c            | 202 ++++++++++++++++++-------------------
 arch/x86/kvm/vmx/nested.c          |  31 ++++--
 arch/x86/kvm/vmx/posted_intr.c     |  10 +-
 arch/x86/kvm/vmx/posted_intr.h     |   3 +-
 arch/x86/kvm/vmx/vmenter.S         |   3 +-
 arch/x86/kvm/vmx/vmx.c             |   5 +-
 arch/x86/kvm/vmx/x86_ops.h         |  66 +-----------
 arch/x86/kvm/x86.c                 |   7 +-
 9 files changed, 142 insertions(+), 187 deletions(-)

