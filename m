Return-Path: <linux-kernel+bounces-879227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F817C22965
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A94C1A6304B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 22:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F73833E341;
	Thu, 30 Oct 2025 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MV6RlvIS"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC9F33C50A
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761864173; cv=none; b=YsVFOPBvxMQw69xO4dIn0M/jNVM0NsltBfCyr3NtLg5+jTW8pq8dQVzC8eI4pAXjB3T8+A9wO9F9SZ25HOUnlemnEMw3tOJZGWmvlaXDICbZEHGBkdAYB+l5w/pSa+4LWGwN2iupBxm8L/RWX7Gv/Ce6I1tdet6zrSlo5Oi/8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761864173; c=relaxed/simple;
	bh=+2Sp1XUMRJ6JAC/0ujMcVleJb+6SOZ/mn2VE06nbeJY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JMc+iZ9vGDkGO8FMAU21PV0gwJZhKnx8eImkpq/Jb2QyZRVUep0pKhxpYufI6vzwZ7FTkNUaMOm8ikUyqJEntLWEoZi+sSFniSimWUZuCWrUPvdpqGN5neVOHIiLQYm5WKcrzkfaWo6RGFwFrynP/khue4JWTlOTf+9oBeBLzsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MV6RlvIS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471737e673so2348120a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761864171; x=1762468971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOafLDsueLSvev3u53pVjuJyaL1S5sstFN4rhC5WLi0=;
        b=MV6RlvISn07HQ2673jfd9/AiYTULiCie+PDDGz/PsYLNcvKieMb/aFdWm4LFW7CrMS
         P/UeBML2Tk2pGphGsQr58NDSoFZlSmAofem6E6d818uryR1FZQ3fRaLKcx7kGMcf6qY6
         uGsQKwJyHFFVnn3USJCRG/TW8kIKiOUynEX1VOh7boFKKIOWr47M0B8Rdg/zAakO7Wd1
         cwPBE7tsxz6k6xU0zhM5jpaY/T0dg6skvC/CP4PFMwdjPXpY+4RSSqIMjlOA+9JAYW6G
         TaM/gPrmEbXJ+OIM190egb+ZQMEYao+SzO2bnd0rj4O7NrpYvbYt1t7kFP0LYGQx2nSC
         95rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761864171; x=1762468971;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOafLDsueLSvev3u53pVjuJyaL1S5sstFN4rhC5WLi0=;
        b=JZGwVG90vsnkv8ZhWz7E9QhBLNfK7cHMOBAJDmbsiKbbAEZa9VAMuJCofANLCsrFxo
         cSTXF1NyF+v8lyE3w2LtinPRtNcFtgbj5jE9QU1ZhpFuENJtfB2Q2tETD6g0faZIUqZY
         sisR+wxhkiGjQ866XZXGpW/bwTXyxOuQJDZN7BNkMRC6xiEBX7gaeJS681moPNfEjvXp
         0WzEm3WwCF+R5nGwf94YBNDSqjvZqN9DTGrNmexJFdyANWFhRBc1Ev5LLv9p11xbc+Xx
         EQqRr5HiYzUBooul8u2YyjS46EkTaJolSNBRxlx+Tnpi2oc5aQItN4bAxOXiWLi6RYF+
         P84Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4bCRyIt0mfdvjHfqjCIQdM+vWZhStR3nVaHSQyz+QJ6aNOEHfwYjhvJDdJYxoq+veZ8gO5glRdTLcs70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKXBECUbl3F3Fkuq480vqvPTj7QR5rrXY8V6yCFhDLlNi3qjn/
	scVQnQ/z/jnEeGCdr+Ezl46wo9vIOxUAbXD47x7hzlt8x3HiiVWFDZAKTdBfwkjCFr9Emnvoxdq
	DCTUUUg==
X-Google-Smtp-Source: AGHT+IHhGN2q1FIohAl+onxF/p1amX45UtOA4egEIJwWspNbS730dhafOtwiNgJzlhbxk6zc5Y5qPYBNLdg=
X-Received: from pjbms9.prod.google.com ([2002:a17:90b:2349:b0:33d:69cf:1f82])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7344:b0:334:96ed:7a73
 with SMTP id adf61e73a8af0-348ca24f6aemr1848972637.8.1761864171291; Thu, 30
 Oct 2025 15:42:51 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 15:42:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030224246.3456492-1-seanjc@google.com>
Subject: [PATCH 0/4] KVM: x86: Cleanup #MC and XCR0/XSS/PKRU handling
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jon Kohler <jon@nutanix.com>
Content-Type: text/plain; charset="UTF-8"

This series is the result of the recent PUCK discussion[*] on optimizing the
XCR0/XSS loads that are currently done on every VM-Enter and VM-Exit.  My
initial thought that swapping XCR0/XSS outside of the fastpath was spot on;
turns out the only reason they're swapped in the fastpath is because of a
hack-a-fix that papered over an egregious #MC handling bug where the kernel #MC
handler would call schedule() from an atomic context.  The resulting #GP due to
trying to swap FPU state with a guest XCR0/XSS was "fixed" by loading the host
values before handling #MCs from the guest.

Thankfully, the #MC mess has long since been cleaned up, so it's once again
safe to swap XCR0/XSS outside of the fastpath (but when IRQs are disabled!).

As for what may be contributing to the SAP HANA performance improvements when
enabling PKU, my instincts again appear to be spot on.  As predicted, the
fastpath savings are ~300 cycles on Intel (~500 on AMD).  I.e. if the guest
is literally doing _nothing_ but generating fastpath exits, it will see a
~%25 improvement.  There's basically zero chance the uplift seen with enabling
PKU is dues to eliding XCR0 loads; my guess is that the guest actualy uses
protection keys to optimize something.

Why does kvm_load_guest_xsave_state() show up in perf?  Probably because it's
the only visible symbol other than vmx_vmexit() (and vmx_vcpu_run() when not
hammering the fastpath).  E.g. running perf top on a running VM instance yields
these numbers with various guest workloads (the middle one is running
mmu_stress_test in the guest, which hammers on mmu_lock in L0).  But other than
doing INVD (handled in the fastpath) in a tight loop, there's no perceived perf
improvement from the guest.

Overhead  Shared Object       Symbol
  15.65%  [kernel]            [k] vmx_vmexit
   6.78%  [kernel]            [k] kvm_vcpu_halt
   5.15%  [kernel]            [k] __srcu_read_lock
   4.73%  [kernel]            [k] kvm_load_guest_xsave_state
   4.69%  [kernel]            [k] __srcu_read_unlock
   4.65%  [kernel]            [k] read_tsc
   4.44%  [kernel]            [k] vmx_sync_pir_to_irr
   4.03%  [kernel]            [k] kvm_apic_has_interrupt


  45.52%  [kernel]            [k] queued_spin_lock_slowpath
  24.40%  [kernel]            [k] vmx_vmexit
   2.84%  [kernel]            [k] queued_write_lock_slowpath
   1.92%  [kernel]            [k] vmx_vcpu_run
   1.40%  [kernel]            [k] vcpu_run
   1.00%  [kernel]            [k] kvm_load_guest_xsave_state
   0.84%  [kernel]            [k] kvm_load_host_xsave_state
   0.72%  [kernel]            [k] mmu_try_to_unsync_pages
   0.68%  [kernel]            [k] __srcu_read_lock
   0.65%  [kernel]            [k] try_get_folio

  17.78%  [kernel]            [k] vmx_vmexit
   5.08%  [kernel]            [k] vmx_vcpu_run
   4.24%  [kernel]            [k] vcpu_run
   4.21%  [kernel]            [k] _raw_spin_lock_irqsave
   2.99%  [kernel]            [k] kvm_load_guest_xsave_state
   2.51%  [kernel]            [k] rcu_note_context_switch
   2.47%  [kernel]            [k] ktime_get_update_offsets_now
   2.21%  [kernel]            [k] kvm_load_host_xsave_state
   2.16%  [kernel]            [k] fput

[*] https://drive.google.com/corp/drive/folders/1DCdvqFGudQc7pxXjM7f35vXogTf9uhD4

Sean Christopherson (4):
  KVM: SVM: Handle #MCs in guest outside of fastpath
  KVM: VMX: Handle #MCs on VM-Enter/TD-Enter outside of the fastpath
  KVM: x86: Load guest/host XCR0 and XSS outside of the fastpath run
    loop
  KVM: x86: Load guest/host PKRU outside of the fastpath run loop

 arch/x86/kvm/svm/svm.c  | 20 ++++++++--------
 arch/x86/kvm/vmx/main.c | 13 ++++++++++-
 arch/x86/kvm/vmx/tdx.c  |  3 ---
 arch/x86/kvm/vmx/vmx.c  |  7 ------
 arch/x86/kvm/x86.c      | 51 ++++++++++++++++++++++++++++-------------
 arch/x86/kvm/x86.h      |  2 --
 6 files changed, 56 insertions(+), 40 deletions(-)


base-commit: 4cc167c50eb19d44ac7e204938724e685e3d8057
-- 
2.51.1.930.gacf6e81ea2-goog


