Return-Path: <linux-kernel+bounces-829328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D803EB96CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B963B19C671F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C664327A16;
	Tue, 23 Sep 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y/jKNSRI"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44172322DCA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644646; cv=none; b=R9aqV5DAJcy8EXrLCJzdghqae3hbXgLhY9pzh5goYFx1TUCAVfm7pInRR3M75TMHa0a4ZLdoqH0uZE73N3FxZiYLaVY3f0ls3w0A6a4o72gIGG1UUDAlSWRftSDTj3nZLYN3BksewM72dqfIuAXnLTHDVYNau9UtdUahOfy6A8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644646; c=relaxed/simple;
	bh=agu8t+GtnRdTt7ziIGD3+jvwpGAKVQuk0ov+fLZVyEU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m1ov1g4PxXwTk7BnFhDDfzffETnBdT/zJtUxr38V0tPNOxuuGE15flSENt98lSj29NyEt3+gtRZsLXG0XsLYuxmATJakFzajmEDCBsy3JQq2bMYZfRJ7VwESSbr58DfflySPgutNOTw9x7ucZ4+UYQGYxpAK1a5tmY4uZYkZIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y/jKNSRI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458274406so119096125ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758644643; x=1759249443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ct6l4fU3rAG1+iOUtrDMwT6jHIL6tdfk6HjiAM8alg=;
        b=y/jKNSRIeIGfW6GzKfcGD3UY6i7W0zmQn/LNgl7dBD58LKDY17G4DPkzn4VtGhESI+
         oBT9litmmXfiOYgexjJ8F2ZKkAcyLbbbyREyLhlGYbHh9pawWM89SWFGFcBf+V7FoQD9
         aK7VsfD/NsVeV0npfdnh+6j7q7O+BoDqLj2sYmSY02B/pi+ZOGkVQKZG+YE9PcBs9jJm
         RHQTcC96MfwvyV4SEe3U4hDkVstO8T+JZYkfJsz9qiCUn+LP75JL7p1PGSRiqUUN/QT6
         /VVRGTG3js1ptpP+j+v0/3xYD3T3MAJQ+Yxtn8oFwhAQctdX8ZXlXZ4i9RJb9no1CFBt
         aqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644643; x=1759249443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ct6l4fU3rAG1+iOUtrDMwT6jHIL6tdfk6HjiAM8alg=;
        b=u+bNer0V9rOnTJcJmJ1qGAzHKZivl3FPH2Nu3kWsg5MmEJfgFhlbkkq0Fju9KHMM+L
         fJWg/7G5bEZ3vdIglLw2q7BmC/ikx0pDbJVnzb3P536H/BpWppB+SzfH7m8HUR8uQAdN
         VRti7M4ZQmZ8QxzTPwzHd7Wcxzt7r24Jgq8REFTmO3pAUjvY5DJklKt0ZDpFCHIFGOcm
         mcY216ofSUFRm0wtFO00QZWPv1zEUJ0rKMDU6WJmCkrXiTjcKIj6oujoZuyz3BFisOLb
         hQoUfYtPCzucV8aBUXAjRSIK0QnH/fUL8GsZHLwk0OUWeiVj1OSYv9CZDT3HmChSUZ0g
         pFSA==
X-Forwarded-Encrypted: i=1; AJvYcCWcEklooVCSzoU49xEgdIuUTjuVXbMA6KpFE4BQ4mqpm2wngvgVt2NCNpeD2u138g1HPLlhfsMtFb+T774=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKjyEoDVK0AGHdZ56x4PUffdshvH1+kj7z+PGgGtnmdFY+ezEo
	LsbIsllMN58Xjz/kXVR35XA5EIoY/+YaCrK/eDhAumkWr5FADZSQ6JuEgcreYS17KD9fHQJWtw9
	NlE4KPA==
X-Google-Smtp-Source: AGHT+IEHue5KcLk/QqnBm3y2Ig9Ta51qNFW7n2QuwkMnly9TqOobukS1vav1nBv/4Yz6svZXoVmoDEzQJWA=
X-Received: from plbkf5.prod.google.com ([2002:a17:903:5c5:b0:269:b2a5:8823])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94d:b0:268:1623:f8ce
 with SMTP id d9443c01a7336-27cc1572011mr36976535ad.10.1758644643566; Tue, 23
 Sep 2025 09:24:03 -0700 (PDT)
Date: Tue, 23 Sep 2025 09:24:02 -0700
In-Reply-To: <aNIH/ozYmopOuCui@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com> <20250919223258.1604852-30-seanjc@google.com>
 <aNIH/ozYmopOuCui@intel.com>
Message-ID: <aNLJosN_1gZ7z4VF@google.com>
Subject: Re: [PATCH v16 29/51] KVM: VMX: Configure nested capabilities after
 CPU capabilities
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 23, 2025, Chao Gao wrote:
> On Fri, Sep 19, 2025 at 03:32:36PM -0700, Sean Christopherson wrote:
> >Swap the order between configuring nested VMX capabilities and base CPU
> >capabilities, so that nested VMX support can be conditioned on core KVM
> >support, e.g. to allow conditioning support for LOAD_CET_STATE on the
> >presence of IBT or SHSTK.  Because the sanity checks on nested VMX config
> >performed by vmx_check_processor_compat() run _after_ vmx_hardware_setup(),
> >any use of kvm_cpu_cap_has() when configuring nested VMX support will lead
> >to failures in vmx_check_processor_compat().
> >
> >While swapping the order of two (or more) configuration flows can lead to
> >a game of whack-a-mole, in this case nested support inarguably should be
> >done after base support.  KVM should never condition base support on nested
> >support, because nested support is fully optional, while obviously it's
> >desirable to condition nested support on base support.  And there's zero
> >evidence the current ordering was intentional, e.g. commit 66a6950f9995
> >("KVM: x86: Introduce kvm_cpu_caps to replace runtime CPUID masking")
> >likely placed the call to kvm_set_cpu_caps() after nested setup because it
> >looked pretty.
> >
> >Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> 
> I had a feeling I'd seen this patch before :). After some searching in lore, I
> tracked it down:
> https://lore.kernel.org/kvm/20241001050110.3643764-22-xin@zytor.com/

Gah, sorry Xin :-/

