Return-Path: <linux-kernel+bounces-837913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA78BAE096
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBE64A7AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6A023817E;
	Tue, 30 Sep 2025 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NtFZGqjP"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F31E260D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 16:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759249744; cv=none; b=VLnywFnmCRsGPGxDf7rgXq8tPBsSuGJL/+NoUHchK9PoAljDYjUi9rCXR7GPC7grBUFyZd1xM/cCdS6JdUDHLuDk/570HgdELj6xTRvErWl7SVudmuqVjSGTgiACDmKdTAYDkCRnZdtqm/dywLgGSPbqNN3uxiOiV3cfbx8VAw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759249744; c=relaxed/simple;
	bh=jvs1HpDbHuLHsXwdNWN5OQ0EARN3lWmBRfQzMHZ4nD8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J7+TRplsdm+qw2/QSuUEv+wrRjpJIGGwAqt7vdFD3M6URGGnrCTJMcrR9UjBYwOiLjXEApQ17iY52JnPypEMxy970lBDnGirikw2P0rt66TyQ6f8Hq/P4zSCI2IHbrLNeCWlMopxomqVLNZL8LefUrRR9twszH9MGNZQuZSabUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NtFZGqjP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-336b646768eso4544901a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759249742; x=1759854542; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IvqulNZyHw3NH8THJ4dZILvp5eZnrhz0uuimme275IM=;
        b=NtFZGqjP9/oDU/iJQb1suyJeAJSQGyRMiGsMfGsjox+lP8W+OY6lE/C7GfRLxTN3y1
         LUGXtwqtupEgvrUTGJx8WXY7m5ZsZhSZ9tVMMlTs6G92E8AAbhjdMWt26Q3SA30YJQLf
         cx+V+/tGScN5UQaskeFLaagz5KkWFhlYrlJaffFP+gqMgYY6GorU3MyehYzHsgGMDPov
         epPDUJmqKKD7+Hc43KGZ/hmQa9YsukYXZwlGI6zzs4uul8jRIz3dJO0Lilk7WYD/6ivD
         q/NSx5aA2cGwCPj7E8h4/9UQ+vQ3stMa+E4wBCAM1Rspp3EmaGbGZzFWzNHcvjFIxrIW
         I66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759249742; x=1759854542;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IvqulNZyHw3NH8THJ4dZILvp5eZnrhz0uuimme275IM=;
        b=YNRKlbbuiXr2pLonNs4Wv18n1G13wIoBNlGy0eT+cMRr0d72TX39mxTF9h1EmGkzzY
         PqthHRpy37D0yfy0zcjVVlTsjJXefCyhwtkCR+Lh3I9C+oZoHkLDBwg8bevpLtngP4OQ
         kwAxkq9VcSqeuxCEaRqwdWJAFEEieF9WiqwPp/FwxniAfEydMciMcW3PkWxbyrU3W77p
         BzUUTUzK77nRaidFkuV5WRQ08G8GMSn5gQhAjCMAwRMpDHGJu09/F+wPIuXxKIIubVXs
         73wIk/7VF8pYLF9D+mzWhgKORyyjD44YkmhOPkRTTIR+9VMOE7ZPGwUqh2bA1Ia5vOFw
         18ag==
X-Forwarded-Encrypted: i=1; AJvYcCVhT3YAQ+ydxQJ6SlqtAtiTvq10uqpKcnQqawOtmVl/LOzDyNDkNEybTuKP8UoDF9Iaec4AxTtfJxFk8xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywod7FKLw8w1aJTadiDF8Mx3AvmOC0BU5hcb6cCKD7NmISWjOu0
	C2RVs75TqFbDVb38TS8k4zMV08CNnwHT1tupqLWTawe6wYxPOrd7TnSwxcaQ7bi3j20s7VGBuCu
	wU+m2yg==
X-Google-Smtp-Source: AGHT+IHzjBQ0AdCcBjAnrdTTq/5Smhx7Q7IlZ3njiQ56g/bLqUrOXudSTMTSnkrzIbu2QJ5VRD4RdJoqhv8=
X-Received: from pjbnu4.prod.google.com ([2002:a17:90b:1b04:b0:32e:ca6a:7ca9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d91:b0:32b:9bec:158f
 with SMTP id 98e67ed59e1d1-339a6f5b668mr72251a91.29.1759249742526; Tue, 30
 Sep 2025 09:29:02 -0700 (PDT)
Date: Tue, 30 Sep 2025 09:29:00 -0700
In-Reply-To: <aNvT8s01Q5Cr3wAq@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919214259.1584273-1-seanjc@google.com> <aNvLkRZCZ1ckPhFa@yzhao56-desk.sh.intel.com>
 <aNvT8s01Q5Cr3wAq@yzhao56-desk.sh.intel.com>
Message-ID: <aNwFTLM3yt6AGAzd@google.com>
Subject: Re: [PATCH] KVM: x86: Drop "cache" from user return MSR setter that
 skips WRMSR
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 30, 2025, Yan Zhao wrote:
> On Tue, Sep 30, 2025 at 08:22:41PM +0800, Yan Zhao wrote:
> > On Fri, Sep 19, 2025 at 02:42:59PM -0700, Sean Christopherson wrote:
> > > Rename kvm_user_return_msr_update_cache() to __kvm_set_user_return_msr()
> > > and use the helper kvm_set_user_return_msr() to make it obvious that the
> > > double-underscores version is doing a subset of the work of the "full"
> > > setter.
> > > 
> > > While the function does indeed update a cache, the nomenclature becomes
> > > slightly misleading when adding a getter[1], as the current value isn't
> > > _just_ the cached value, it's also the value that's currently loaded in
> > > hardware.
> > Nit:
> > 
> > For TDX, "it's also the value that's currently loaded in hardware" is not true.
> since tdx module invokes wrmsr()s before each exit to VMM, while KVM only
> invokes __kvm_set_user_return_msr() in tdx_vcpu_put().

No?  kvm_user_return_msr_update_cache() is passed the value that's currently
loaded in hardware, by way of the TDX-Module zeroing some MSRs on TD-Exit.

Ah, I suspect you're calling out that the cache can be stale.  Maybe this?

  While the function does indeed update a cache, the nomenclature becomes
  slightly misleading when adding a getter[1], as the current value isn't
  _just_ the cached value, it's also the value that's currently loaded in
  hardware (ignoring that the cache holds stale data until the vCPU is put,
  i.e. until KVM prepares to switch back to the host).

Actually, that's a bug waiting to happen when the getter comes along.  Rather
than document the potential pitfall, what about adding a prep patch to mimize
the window?  Then _this_ patch shouldn't need the caveat about the cache being
stale.

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index ff41d3d00380..326fa81cb35f 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -789,6 +789,14 @@ void tdx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
                vt->msr_host_kernel_gs_base = read_msr(MSR_KERNEL_GS_BASE);
 
        vt->guest_state_loaded = true;
+
+       /*
+        * Several of KVM's user-return MSRs are clobbered by the TDX-Module if
+        * VP.ENTER succeeds, i.e. on TD-Exit.  Mark those MSRs as needing an
+        * update to synchronize the "current" value in KVM's cache with the
+        * value in hardware (loaded by the TDX-Module).
+        */
+       to_tdx(vcpu)->need_user_return_msr_update = true;
 }
 
 struct tdx_uret_msr {
@@ -816,7 +824,6 @@ static void tdx_user_return_msr_update_cache(void)
 static void tdx_prepare_switch_to_host(struct kvm_vcpu *vcpu)
 {
        struct vcpu_vt *vt = to_vt(vcpu);
-       struct vcpu_tdx *tdx = to_tdx(vcpu);
 
        if (!vt->guest_state_loaded)
                return;
@@ -824,11 +831,6 @@ static void tdx_prepare_switch_to_host(struct kvm_vcpu *vcpu)
        ++vcpu->stat.host_state_reload;
        wrmsrl(MSR_KERNEL_GS_BASE, vt->msr_host_kernel_gs_base);
 
-       if (tdx->guest_entered) {
-               tdx_user_return_msr_update_cache();
-               tdx->guest_entered = false;
-       }
-
        vt->guest_state_loaded = false;
 }
 
@@ -1067,7 +1069,11 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu, u64 run_flags)
                update_debugctlmsr(vcpu->arch.host_debugctl);
 
        tdx_load_host_xsave_state(vcpu);
-       tdx->guest_entered = true;
+
+       if (tdx->need_user_return_msr_update) {
+               tdx_user_return_msr_update_cache();
+               tdx->need_user_return_msr_update = false;
+       }
 
        vcpu->arch.regs_avail &= TDX_REGS_AVAIL_SET;
 
diff --git a/arch/x86/kvm/vmx/tdx.h b/arch/x86/kvm/vmx/tdx.h
index ca39a9391db1..fcac1627f71f 100644
--- a/arch/x86/kvm/vmx/tdx.h
+++ b/arch/x86/kvm/vmx/tdx.h
@@ -67,7 +67,7 @@ struct vcpu_tdx {
        u64 vp_enter_ret;
 
        enum vcpu_tdx_state state;
-       bool guest_entered;
+       bool need_user_return_msr_update;
 
        u64 map_gpa_next;
        u64 map_gpa_end;


