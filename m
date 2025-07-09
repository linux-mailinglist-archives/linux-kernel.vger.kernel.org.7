Return-Path: <linux-kernel+bounces-723915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E13E2AFEC62
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0F371C45609
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7652E5B26;
	Wed,  9 Jul 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eIOADTHe"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FF2E5B13
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072093; cv=none; b=cPmx1OxED0kQIlPAt6k2kn1nB/lQPZWbgXL+YTiGZo7uO7K0hYkBpHTlLH2B7ZUm9xZneBIgjl6pMzGwjrWMcoAJ8o2troVwGtFe6ATPhBVdvM7F3yv5aancXu6C5w/7qsuLowGVBBzOYYQbThYyuYiOliP36pDKboAvu72FrtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072093; c=relaxed/simple;
	bh=zUxumM8TYtASQtxVbc0OxTZstf6esCItSZ1OBn+4Z0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ITsJc7Eu6QQpxXzWUuJALRXRH1s3H/gAUK8SE2N3JaVNVpFkVUr82aPHH+Rq5mjMGYaCtV9eFvrGa/rSWSLnlmnSd/dS6fDblF53MgVNDeyOy8K3AnvZDHgcSj++M5Lbk13k0v9dQCzcODbd/eLmFnRTuaa9mey0nFHumdIMYyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eIOADTHe; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138f5e8ff5so6330a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752072091; x=1752676891; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIXIgTU/d0DHVgdq3Al05Y23M2ENHaeJ4kUVB+5AwJQ=;
        b=eIOADTHeoMDecUAuCHO31Yvd9rkNTQXmRLrLO/z0vQ1PlPCwfY7dffzCmQd5vtnXvG
         ieZnpsuUv5VN/qMZvoV1xP2ASWYOtyjqNCfVxFqfUpDxQMR756JNduJL75jhhNGTt4tT
         VYAz1PyeIUw/ZeRwiifRJy/rCwHIcHXdlsOD1LawCTBjqi/pKfiJBhiSgqBtwb1MgO6U
         UXj2FzHkIAKGK2pkGgDFpkluWs6hasyweVLw/Bus5odG4bz10ROMDSlb+fFU4Kv7ksxV
         w4dDWe/dHrdihcLryTZ4XqU+/FNXQYY3dF0RDaR7Ah1c1gs5RrzRDlMfdZ4zSDVR0pyy
         mFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072091; x=1752676891;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIXIgTU/d0DHVgdq3Al05Y23M2ENHaeJ4kUVB+5AwJQ=;
        b=ZoYXwnAlAe8YgJxgzYfYSPslIKuzB9gcNL5Qvbhc+cH06rjI4/BPEaNvXXlgNKPxQw
         tjuWcRhXI9I8us9w3dVo0vQkcCVFjzNpJNz5N3EmHK1ZjnrYNz5TMq0zAjhcXdb/Aw13
         3/kjKzc0SlgODJAJRKVfMHvN7Z+T6dvDR93x53KagCtK9f6AT+28Uk4HmYOHJpNZ1M89
         e1rcaLf0oHADYvJKQHAEhkOrYioku1qksGIAGlQeAwLk9C/tdjFbE9SoaVuagme11tkg
         epOdAP7w7HAycRzauU6Hu8yMHKOsFCuBhiR8KoJJyb7qXBWF9sjMUoLbkTxwm7wLtXFl
         cvUQ==
X-Gm-Message-State: AOJu0YwIUlL1JO5pgYKIoDJ8krphsOwJBn6DIdGq4ZPGLnLPS9J0mUNp
	hfWOKm1as8o9qfm6TTPFTpa2bR/z3g2lL+3ck2JQaCqDjNcKZI6aTIlqooDK42Qq83Az5OMxXP1
	OH3i+ww==
X-Google-Smtp-Source: AGHT+IFDLY6OfylAhVLjR/Rwf8Wt3N0W8uox0MdBAD2RtWhU6riKyOdha2HLTDjSeTROfebQD4Ts1Q5RcMY=
X-Received: from pjbsk10.prod.google.com ([2002:a17:90b:2dca:b0:312:1af5:98c9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d89:b0:315:c77b:37d6
 with SMTP id 98e67ed59e1d1-31c3c2e27e6mr186837a91.23.1752072091506; Wed, 09
 Jul 2025 07:41:31 -0700 (PDT)
Date: Wed, 9 Jul 2025 07:41:30 -0700
In-Reply-To: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com>
Message-ID: <aG5_mowwoIogBSqH@google.com>
Subject: Re: [RFC PATCH v8 00/35] AMD: Add Secure AVIC Guest Support
From: Sean Christopherson <seanjc@google.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, Thomas.Lendacky@amd.com, 
	nikunj@amd.com, Santosh.Shukla@amd.com, Vasant.Hegde@amd.com, 
	Suravee.Suthikulpanit@amd.com, David.Kaplan@amd.com, x86@kernel.org, 
	hpa@zytor.com, peterz@infradead.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	kirill.shutemov@linux.intel.com, huibo.wang@amd.com, naveen.rao@amd.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 09, 2025, Neeraj Upadhyay wrote:
> Kishon Vijay Abraham I (2):
>   x86/sev: Initialize VGIF for secondary VCPUs for Secure AVIC
>   x86/sev: Enable NMI support for Secure AVIC
> 
> Neeraj Upadhyay (32):
>   KVM: x86: Open code setting/clearing of bits in the ISR
>   KVM: x86: Remove redundant parentheses around 'bitmap'
>   KVM: x86: Rename VEC_POS/REG_POS macro usages
>   KVM: x86: Change lapic regs base address to void pointer
>   KVM: x86: Rename find_highest_vector()
>   KVM: x86: Rename lapic get/set_reg() helpers
>   KVM: x86: Rename lapic get/set_reg64() helpers
>   KVM: x86: Rename lapic set/clear vector helpers
>   x86/apic: KVM: Move apic_find_highest_vector() to a common header
>   x86/apic: KVM: Move lapic get/set helpers to common code
>   x86/apic: KVM: Move lapic set/clear_vector() helpers to common code
>   x86/apic: KVM: Move apic_test)vector() to common code
>   x86/apic: Rename 'reg_off' to 'reg'
>   x86/apic: Unionize apic regs for 32bit/64bit access w/o type casting
>   x86/apic: Simplify bitwise operations on apic bitmap
>   x86/apic: Move apic_update_irq_cfg() calls to apic_update_vector()
>   x86/apic: Add new driver for Secure AVIC
>   x86/apic: Initialize Secure AVIC APIC backing page
>   x86/apic: Populate .read()/.write() callbacks of Secure AVIC driver
>   x86/apic: Initialize APIC ID for Secure AVIC
>   x86/apic: Add update_vector() callback for apic drivers
>   x86/apic: Add update_vector() callback for Secure AVIC
>   x86/apic: Add support to send IPI for Secure AVIC
>   x86/apic: Support LAPIC timer for Secure AVIC
>   x86/apic: Add support to send NMI IPI for Secure AVIC
>   x86/apic: Allow NMI to be injected from hypervisor for Secure AVIC
>   x86/apic: Read and write LVT* APIC registers from HV for SAVIC guests
>   x86/apic: Handle EOI writes for Secure AVIC guests
>   x86/apic: Add kexec support for Secure AVIC
>   x86/apic: Enable Secure AVIC in Control MSR
>   x86/sev: Prevent SECURE_AVIC_CONTROL MSR interception for Secure AVIC
>     guests
>   x86/sev: Indicate SEV-SNP guest supports Secure AVIC
> 
> Sean Christopherson (1):
>   x86/apic: KVM: Deduplicate APIC vector => register+bit math

Boris, do you anticipate taking this entire series for 6.17?  If not, I'd be more
than happy to grab all of the KVM => x86/apic renames and code movement for 6.17,
e.g. to avoid complications if a conflicting KVM change comes along.  I can throw
them in a dedicated topic branch so that you could ingest the dependency prior to
6.17-rc1 if necessary.

I.e. these:

  x86/apic: Rename 'reg_off' to 'reg'
  x86/apic: KVM: Move apic_test)vector() to common code
  x86/apic: KVM: Move lapic set/clear_vector() helpers to common code
  x86/apic: KVM: Move lapic get/set helpers to common code
  x86/apic: KVM: Move apic_find_highest_vector() to a common header
  KVM: x86: Rename lapic set/clear vector helpers
  KVM: x86: Rename lapic get/set_reg64() helpers
  KVM: x86: Rename lapic get/set_reg() helpers
  KVM: x86: Rename find_highest_vector()
  KVM: x86: Change lapic regs base address to void pointer
  KVM: x86: Rename VEC_POS/REG_POS macro usages
  x86/apic: KVM: Deduplicate APIC vector => register+bit math
  KVM: x86: Remove redundant parentheses around 'bitmap'
  KVM: x86: Open code setting/clearing of bits in the ISR

