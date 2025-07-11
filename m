Return-Path: <linux-kernel+bounces-727606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4667B01CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29AA31896EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689062D3EE6;
	Fri, 11 Jul 2025 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yR//a0dO"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0562D239F
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239121; cv=none; b=YnD6CDeSLbB6DD4BZA/yUMbQNSvNzuT8FtwJ+RduXxHrjsZ7TbffYPnenje7a2H+a9M881eqqK8ITTQU6yNyhobQLkRbZYzpSqYiDMfrDigfyiNZHH4Rtld+WPGSKx3cOnMFKrD/sh0lvKrn27prBVL5mawJYOeA67WxdwOWxPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239121; c=relaxed/simple;
	bh=MYqm8zjNLzsWhNoaJgWBTk1kmSsMxa8+rFquDwiG00g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=duGkP5u9LNhiarrMwPq7Gt83dSStiCpg4h0qMwCSZSiTGZSSL3lIem+63k47Mq01MB8xYrGg5c/oJiWq/VviE7Ed0SzATWuBYWJhbXj41xSZCf3XrNZnPqTEbW1Lh9mBltmgWs+vuktaNOvmK49mZNO6ONg10A7NTX7xj1Mp4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yR//a0dO; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-313f8835f29so3318026a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752239119; x=1752843919; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QwYyJ5ZlztEdQTVfkhA2cf/LaOoL8V2/Ke015HjaX6w=;
        b=yR//a0dOl/iJQvQTOM7lIwFR5LZHSUTApyLD2M2ZCg2YYxS7zPhFeWDwbLotEUlYsc
         cKbIpfm2hBPfjfttZymN1tFJkv74H+v+npJB7z0Fp4cwRwLPo/Vryqbj+JxicQVO0a7E
         piGceRvGhvL+YtUHDYQjumHQYUZQrx+PmFN2Ba6fGJgBC47BBI0rdcvv+sSOqWKT4OKV
         zfwN18cNRwqLMGL1yci228kMwn8SkHOkZH+tyOBhrUT9ZTr7/dunNoOAwQjBQZ++m3FJ
         LVVQqo3YdvIOZVjRQKbYlDYHYCqlMJ1cmuprq918P4v59IhBaAVL4JJYJrmsUkwRin+I
         mdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752239119; x=1752843919;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwYyJ5ZlztEdQTVfkhA2cf/LaOoL8V2/Ke015HjaX6w=;
        b=Ltb+AYgS3k0IiCkQnaKVntTJ1eBfsKU1+76cy4Foo2NiaYkL/63Yz3LcQqKWXmR97b
         CPws5c6DCXgxb3moFDFd6by/zvdwJr0TEaCV/GGgYS8COeB7mZADb4V6X47kmp+PIwL5
         tDGcOtRIp3ANNT8tRDYrurCd17RRA667A7GPKmq+jPMe8Zzhb4MhJdM0pLtDu6ZSQ4Fh
         xbC5kGbsq/cRtaoMJEUAyQTMQwz5eBsCcSxfOkN0824z4asL7u0nbTygP3SPMKvBCN2F
         zYevbhE+0a59PsTVhT0MceBoI5Lpudn6se8VO9XeKJZFSMIuNcVzNHgehlp41mbPflkN
         Mf5A==
X-Forwarded-Encrypted: i=1; AJvYcCUKJ/TKDplFh4g7Dw/dq9RQlgqG9sX4LzmFCzQhIDzcsBKhW4gcF4NCJwGTtPXfUszTwi9K7/fYRVj7+R4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8UMWICXEc/3JzDZGSR8+SFLBj7Y0suZV7QxYvL291Qm7seYUI
	1Ury2mZ66hANxgOGTYIW7YDqWCPbd53wYAHL8e9y1FLnTZNea3XV+ZiBGGBCaSEGn183YyJH6iO
	9Abz0rg==
X-Google-Smtp-Source: AGHT+IG/T/kETPzuUaDbQ/UeYIqSlIMYxr5rtfRan0dpxKkBR1ENcgjw540k090RWXQo7plxJAgD4CmFahw=
X-Received: from pjtq14.prod.google.com ([2002:a17:90a:c10e:b0:313:2213:1f54])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:f944:b0:312:1c83:58f7
 with SMTP id 98e67ed59e1d1-31c4c96f436mr5438921a91.0.1752239118743; Fri, 11
 Jul 2025 06:05:18 -0700 (PDT)
Date: Fri, 11 Jul 2025 06:05:10 -0700
In-Reply-To: <7103b312-b02d-440e-9fa6-ba219a510c2d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611095158.19398-1-adrian.hunter@intel.com>
 <175088949072.720373.4112758062004721516.b4-ty@google.com>
 <aF1uNonhK1rQ8ViZ@google.com> <7103b312-b02d-440e-9fa6-ba219a510c2d@intel.com>
Message-ID: <aHEMBuVieGioMVaT@google.com>
Subject: Re: [PATCH V4 0/1] KVM: TDX: Decrease TDX VM shutdown time
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: pbonzini@redhat.com, Adrian Hunter <adrian.hunter@intel.com>, kvm@vger.kernel.org, 
	rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com, 
	kai.huang@intel.com, reinette.chatre@intel.com, tony.lindgren@linux.intel.com, 
	binbin.wu@linux.intel.com, isaku.yamahata@intel.com, 
	linux-kernel@vger.kernel.org, yan.y.zhao@intel.com, chao.gao@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 11, 2025, Xiaoyao Li wrote:
> On 6/26/2025 11:58 PM, Sean Christopherson wrote:
> > On Wed, Jun 25, 2025, Sean Christopherson wrote:
> > > On Wed, 11 Jun 2025 12:51:57 +0300, Adrian Hunter wrote:
> > > > Changes in V4:
> > > > 
> > > > 	Drop TDX_FLUSHVP_NOT_DONE change.  It will be done separately.
> > > > 	Use KVM_BUG_ON() instead of WARN_ON().
> > > > 	Correct kvm_trylock_all_vcpus() return value.
> > > > 
> > > > Changes in V3:
> > > > 	Refer:
> > > >              https://lore.kernel.org/r/aAL4dT1pWG5dDDeo@google.com
> > > > 
> > > > [...]
> > > 
> > > Applied to kvm-x86 vmx, thanks!
> > > 
> > > [1/1] KVM: TDX: Add sub-ioctl KVM_TDX_TERMINATE_VM
> > >        https://github.com/kvm-x86/linux/commit/111a7311a016
> > 
> > Fixed up to address a docs goof[*], new hash:
> > 
> >        https://github.com/kvm-x86/linux/commit/e4775f57ad51
> > 
> > [*] https://lore.kernel.org/all/20250626171004.7a1a024b@canb.auug.org.au
> 
> Hi Sean,
> 
> I think it's targeted for v6.17, right?
> 
> If so, do we need the enumeration for the new TDX ioctl? Yes, the userspace
> could always try and ignore the failure. But since the ship has not sailed,
> I would like to report it and hear your opinion.

Bugger, you're right.  It's sitting at the top of 'kvm-x86 vmx', so it should be
easy enough to tack on a capability.

This?

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index f0d961436d0f..dcb879897cab 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9147,6 +9147,13 @@ KVM exits with the register state of either the L1 or L2 guest
 depending on which executed at the time of an exit. Userspace must
 take care to differentiate between these cases.
 
+8.46 KVM_CAP_TDX_TERMINATE_VM
+-----------------------------
+
+:Architectures: x86
+
+This capability indicates that KVM supports the KVM_TDX_TERMINATE_VM sub-ioctl.
+
 9. Known KVM API problems
 =========================
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b58a74c1722d..e437a50429d3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4823,6 +4823,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
        case KVM_CAP_READONLY_MEM:
                r = kvm ? kvm_arch_has_readonly_mem(kvm) : 1;
                break;
+       case KVM_CAP_TDX_TERMINATE_VM:
+               r = !!(kvm_caps.supported_vm_types & BIT(KVM_X86_TDX_VM));
+               break;
        default:
                break;
        }
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 7a4c35ff03fe..54293df4a342 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -960,6 +960,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_EL2 240
 #define KVM_CAP_ARM_EL2_E2H0 241
 #define KVM_CAP_RISCV_MP_STATE_RESET 242
+#define KVM_CAP_TDX_TERMINATE_VM 243
 
 struct kvm_irq_routing_irqchip {
        __u32 irqchip;

