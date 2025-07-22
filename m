Return-Path: <linux-kernel+bounces-740994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B286BB0DEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D546F586A72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ABE2EACFB;
	Tue, 22 Jul 2025 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jwANoZMv"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05042E9EAA
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193901; cv=none; b=aouccXC2FOsuSAlc7SOL1GaWdP1PWqwgzeo7x9sebMJrod81VRYO9o4jkd2a9pkQrayM05vaMxozmUuY5xfornrwxba/0+sO7ULOgwtu33dnMdNKxYyU2yez5oDjBceA7sNtw77lA5Hm4mhSw47VcQ14+W1o8gfyMvxSSKRzQ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193901; c=relaxed/simple;
	bh=bY3dgqDakttVxVXywMf1PUP4YMbHhxFk8wYvTlCOaiM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k99jOOi3Js5EMhPAhnWSqK1lguXrKJA+b5RIsD+nwkrOnot5sUjFpm6Vm6ejbkcQRGa2ekoHIwfCDeDp2UOms18SpxrefT6vm4rMnY48Q/UFB6oLbDd4FFVWQ9xgN5JhIh5VpNZYCK40toV9UNzWJNayel1myZhOQ3LqATO8t6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jwANoZMv; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b3beafa8d60so6962837a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753193899; x=1753798699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SXJbLhloouFQ+b/2jAnDLI5t1uyZweJN+ft9tmst/ws=;
        b=jwANoZMvkTgftpxjVQ4YvlpGCDlsC30d23R7ycApAihAFbk2xfwSrH1nFjSyUmB6Rx
         +5UU0admmQCaaH14kVc0vv4rli6F1qv+UvjtpjH6lS9nP71Nyx5CI+wuBuN8DreIVDDV
         UZzX6CyHsxRr1QX/iVbwQZivoBamiP3nSncQGtxUuiwk3v1iIHib5vcyXux2dWC82IHa
         Y8fydB39XMScKN9ofryaWbayHMKRVa11gEfVMamgvImnKeMkRKUsXUE2j/89Jmt+GmVs
         bReNjVcKK73PCtfLQxlUbFXpR68p7d4jOU1fzfu7st5G/KkfWCBnvnYz/hCSloKDpYNO
         LZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753193899; x=1753798699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXJbLhloouFQ+b/2jAnDLI5t1uyZweJN+ft9tmst/ws=;
        b=F6GjLiRp+wUmXS1A9FwQT0G+YtHSZ8YwtNwXzEp52ZXT+nKKvYUGeM63sEu2RvEtEl
         IBT9DiLXMfv59tKlxiCvCwGFKzZw1XeiKUryR660CjLxljXBbpoo6oUf45QRehRKcgNI
         dn547yY/oZBEyZRXLpIIFSWSj/G1S7PvfFPpyuP/pNeS7B6ptg+uaoWcm9xXxWw0S+zm
         KmM540Zmt/Rv/RCOYgTKVQr8DdQ2/+aw8Pqs7OIx1SYON0CFtqBu6AtX/1H9omO/VmX6
         dx7k6cnAFLgzXEJ5hz8k8ptuiF2DQ3ySYbD7EEGt94FyiyOJgbEnsI0R5KxtnbAE9vhZ
         h2og==
X-Forwarded-Encrypted: i=1; AJvYcCUnahG2bN9j9NqfKXhVwy/1qVAhs10GWoL5V7ethdDrvomwUYGHIYipdehSX2gPBJ2pvJyxFhxwQ2Rdi9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFa7xqPSSwaQzgMLQun/c0wmVfv38qtHA8QZCwMOwIb/HHW7We
	Vfzl49Iza5wKvJUhzsPsNaMVcD0KdSTgd+JKQchEq/KtSkvcGgMy6u1z/6LVY50hVmmhoHK5DSE
	76ZljKQ==
X-Google-Smtp-Source: AGHT+IHw9BMi9fY/PnH2o+mBsek9NwZ7XgWDcLI76MPdiLX0RkV1NMzna7IOYa8d2A4uzc7Oh0terxzIuSo=
X-Received: from pjyr14.prod.google.com ([2002:a17:90a:e18e:b0:309:f831:28e0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f650:b0:234:a139:11f0
 with SMTP id d9443c01a7336-23e2566b058mr326510735ad.7.1753193898784; Tue, 22
 Jul 2025 07:18:18 -0700 (PDT)
Date: Tue, 22 Jul 2025 07:18:17 -0700
In-Reply-To: <20250722065448.413503-4-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722065448.413503-1-darwi@linutronix.de> <20250722065448.413503-4-darwi@linutronix.de>
Message-ID: <aH-dqcMWj3cFDos2@google.com>
Subject: Re: [PATCH v3 3/6] x86: Reorder headers alphabetically
From: Sean Christopherson <seanjc@google.com>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Ogness <john.ogness@linutronix.de>, x86@kernel.org, 
	kvm@vger.kernel.org, x86-cpuid@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 22, 2025, Ahmed S. Darwish wrote:
> Multiple x86 source files use the cpuid_*() macros, but implicitly
> include the main CPUID API header.
> 
> Sort their include lines so that <asm/cpuid/api.h> can be explicitly
> included next.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  arch/x86/boot/startup/sme.c           |  8 +--
>  arch/x86/coco/tdx/tdx.c               |  5 +-
>  arch/x86/events/amd/uncore.c          | 14 +++---
>  arch/x86/events/zhaoxin/core.c        | 11 ++---
>  arch/x86/kernel/apic/apic.c           | 70 +++++++++++++--------------
>  arch/x86/kernel/cpu/amd.c             | 25 +++++-----
>  arch/x86/kernel/cpu/mce/core.c        | 62 ++++++++++++------------
>  arch/x86/kernel/cpu/microcode/amd.c   | 12 ++---
>  arch/x86/kernel/cpu/microcode/core.c  | 22 ++++-----
>  arch/x86/kernel/cpu/microcode/intel.c | 11 +++--
>  arch/x86/kernel/cpu/mshyperv.c        | 28 ++++++-----
>  arch/x86/kernel/cpu/resctrl/core.c    |  5 +-
>  arch/x86/kernel/cpu/scattered.c       |  2 +-
>  arch/x86/kernel/cpu/topology_common.c |  2 +-
>  arch/x86/kernel/cpu/vmware.c          | 13 ++---
>  arch/x86/kernel/jailhouse.c           |  9 ++--
>  arch/x86/kernel/kvm.c                 | 35 +++++++-------
>  arch/x86/kernel/paravirt.c            | 28 +++++------
>  arch/x86/kvm/mmu/mmu.c                | 56 ++++++++++-----------
>  arch/x86/kvm/svm/sev.c                | 25 +++++-----
>  arch/x86/kvm/svm/svm.c                | 50 +++++++++----------
>  arch/x86/kvm/vmx/pmu_intel.c          |  6 ++-
>  arch/x86/kvm/vmx/sgx.c                |  2 +-
>  arch/x86/kvm/vmx/vmx.c                | 18 +++----

If this series is squeezed into Linus' tree just before rc1, I suppose I'm fine
with this patch.  But I am NOT providing an ack for general inclusion, because
the potential for pain is not worth the warm fuzzies we get by having sorted
includes.

