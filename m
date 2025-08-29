Return-Path: <linux-kernel+bounces-790893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04639B3AEF1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 02:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CAA3B5F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92BC25A2C8;
	Fri, 29 Aug 2025 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7aEbgmf"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF82522B4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 00:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756426012; cv=none; b=g41D4nSePFzB0yPy5oBuCYp7cRkiJ/r5aTRcAlHVFrDbyg1qZK5vm5f3ahTWwcfTq7yr6g4u/sHw0gw2WBVve9/lvwg/q6yia7XLc2Ki8H0QTyi0Pb0Wfu1p5b3XfZSfgZJdUXfp7QlUZ712O8vZ7UYe+BgFkMSyfWGvB1P4HZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756426012; c=relaxed/simple;
	bh=H65S3rJ44uz1vGqMB8iQWHr3yMc9skrgmgdydv2RDBA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G1aFboYPv4wgTqDKce+QIjKH88SkZI/HC7LkKv6bVaNSXJ2YukS5X99ob8gy+1LQw7sazrMdaLBROP2Ip1ckkDjwnbVh1ohO/E1MDQ9dT3xp3tRZfo2qD71IUFDHS/1hlhJiP1YDsy1R07v8cP30B9Zey0W3xP5wD9tnuhLHg3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h7aEbgmf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3234811cab3so1748036a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 17:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756426011; x=1757030811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RxLpwttBWSyhDMcXeP9tOwiMvx8JT1XOIrXDB90LYs0=;
        b=h7aEbgmfH+cGre/Y2hSqw0HDXlCJOU5E8gTFMEVIQY2NBWKPF/f3Aof7R/4NYyTOEK
         XFbvZ2EtoskhR2KUItwuHL1lDI6xI/n6oyIIwxLxfAn/pZ29t1OGDjf+JEHG6omlDpyz
         fC8wDMl6OM9sRglQLx7ogsBJMlQnObo18oL3OYk+ciYqXzdMuCy7GAmlPd+ncncRSNbn
         tcwXiymIvsFRQkwqba89MhM6bjt/+hyb0A6djJf5t23thqLtGBQh0rbtszDaAiHCz4k9
         gIH8Mx4k6qtXS+Tzqfegzgg91JYPUtr+VueaJWQ5Q5l4Qov0HK6fRBUaNlA6oZ8SwiuS
         F6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756426011; x=1757030811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RxLpwttBWSyhDMcXeP9tOwiMvx8JT1XOIrXDB90LYs0=;
        b=EpuyadTBcKfaVsTFkYJLLCb+c0REETox+cf/raGj86ICHSG351iAV0NAkLNgO3uQRd
         ouvkOOfUPemZBlHPGTKXVY+0G7LcTkPmZdx+tMAThToFVGKgqj4sKEBEk4YaPiID6Nx7
         Q+mjnhUkyY1wHy8reHNNyexZLbDU/kwIy031gD90aNaN1vzihFGytR6CK1sOTay/fG2D
         6fg6q6bz+KQ0A61t2TTXq1fbH/u4Nigs28V71ke15EE471vUx/+0qMLjaZQIvl3yJDdF
         tT8IhpFjyIiMX8pI+4a6cYKjoZs7SWiVnu5DaoW5DSjRGreRatRG2FNRxcnSJzN98rIh
         bTXg==
X-Forwarded-Encrypted: i=1; AJvYcCWbpY/mTHJJ6CButsbzraE3ONJ98ahTirG5q4gVP3VuOmjxPWF2ukVoQhs3QW4Tjd7zRzlbMQ2ef7/BIeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwivUz0YYOXV0SeWaC0VPHXvWxv8Ao9ZJtNvcl1+K68AM87xEJ5
	KXjXeva4yLvx6dNgST4G6u2UzDEfLuSO4CcXZpAuyTTAI/4Srfd/btZ1r3EIwaBGwTy17LOpMVN
	PHihv9g==
X-Google-Smtp-Source: AGHT+IGLzPaUhXZ+u9d9SfG1XeBM9vvj2fmTjF1JBq9az/V7jTBWQ9o6GVfcj9yTochgKtIXUfKJVyXd6sU=
X-Received: from pjbnb7.prod.google.com ([2002:a17:90b:35c7:b0:327:41f6:db15])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c02:b0:324:ece9:6afb
 with SMTP id 98e67ed59e1d1-32515eadfb6mr29318208a91.3.1756426010777; Thu, 28
 Aug 2025 17:06:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 28 Aug 2025 17:06:17 -0700
In-Reply-To: <20250829000618.351013-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829000618.351013-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829000618.351013-18-seanjc@google.com>
Subject: [RFC PATCH v2 17/18] KVM: TDX: Assert that mmu_lock is held for write
 when removing S-EPT entries
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yan Zhao <yan.y.zhao@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Unconditionally assert that mmu_lock is held for write when removing S-EPT
entries, not just when removing S-EPT entries triggers certain conditions,
e.g. needs to do TDH_MEM_TRACK or kick vCPUs out of the guest.
Conditionally asserting implies that it's safe to hold mmu_lock for read
when those paths aren't hit, which is simply not true, as KVM doesn't
support removing S-EPT entries under read-lock.

Only two paths lead to remove_external_spte(), and both paths asserts that
mmu_lock is held for write (tdp_mmu_set_spte() via lockdep, and
handle_removed_pt() via KVM_BUG_ON()).

Deliberately leave lockdep assertions in the "no vCPUs" helpers to document
that wait_for_sept_zap is guarded by holding mmu_lock for write.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/tdx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b73f260a55fd..aa740eeb1c2a 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1714,8 +1714,6 @@ static void tdx_track(struct kvm *kvm)
 	if (unlikely(kvm_tdx->state != TD_STATE_RUNNABLE))
 		return;
 
-	lockdep_assert_held_write(&kvm->mmu_lock);
-
 	err = tdh_mem_track(&kvm_tdx->td);
 	if (unlikely(tdx_operand_busy(err))) {
 		/* After no vCPUs enter, the second retry is expected to succeed */
@@ -1761,6 +1759,8 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 err, entry, level_state;
 
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
 	/*
 	 * HKID is released after all private pages have been removed, and set
 	 * before any might be populated. Warn if zapping is attempted when
-- 
2.51.0.318.gd7df087d1a-goog


