Return-Path: <linux-kernel+bounces-829332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ED5B96D37
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 18:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D616166B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B09E322DCA;
	Tue, 23 Sep 2025 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfp9xoB2"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3A11B423C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758644893; cv=none; b=IVX2dXR+qsaazmGxjqbxDUhIis2pdzGvqvanLrMsTNCICfj+IsEnpOv9KB7ctzxxUcWpsqc4FvfUK3Vd8Y2dLmwHNsW49iOHfjz2rG56+AUFjwmZ/Vzued1/2ff7Dn3EHW72xAyJBdv0t5TKrbhoMedkq6l+bCECdok90qYxZYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758644893; c=relaxed/simple;
	bh=4np2wkKDt6W/4syS89Rp28z7eGj165wxMzc3Q7oON+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=srbUb/vUSff2umTydBBsLv286JUGCLKifhuUjzAJJsd/oHPIyY2RqUxMeGrZbXBpmJSUQCRNBZ+ZJ36hlE0OIwZ7p1S9dFY8XA8Z5EUqkWX1ggxQZemz4ijfODqQ0OMAoEvT1RV8RNfSwwArt254QU7F6IZUKGMKhN9p1BWR9bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pfp9xoB2; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77f2d29dc2aso1942186b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758644891; x=1759249691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1HEmm25r5KcPTR3FBQDysGSspUbCRvEgX0AYHZ6q6E=;
        b=pfp9xoB2+nN7icBT0LceGNubIl1Tjl9w0fiTMsqwIZPAV/Vk5aTE9YUice9RAx5yY+
         7T2nngA6usb9TQl2f2XyEHsphwicAQrcFt+APxQoGIqpHZjxhxBl7Ria9VtXA2Uq1lCe
         GxCtY+5jhdZ5qQntNcSM3/cHhQbcY9lEDlRVyTOK+nTTMVW+10u/EigSpKlJT7Cu0FED
         KLISEfjeHYYDBI2Hr8DLK0z9kalQk084xA7irwb/CwVstplUxNKcvvz16YI+RJ6RrDnA
         CLdZeKQinStDGk5brgVyjU6q2S2hHJT20vTJcMnccgLi73d27iJ0oQEy2GqxP5dk4hsU
         zb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758644891; x=1759249691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1HEmm25r5KcPTR3FBQDysGSspUbCRvEgX0AYHZ6q6E=;
        b=jmAqCeUP6xL0ixOvZeA6KwroHw42c1+eJmmgSMRA1pAbIAiUso9ihdqWlzOtwGYeCa
         +gGP99CcLlcZFviQ2bVHKVFYJhTVgD3F/TD9fqZE7iYboLC/UTR2sR1Z8uKjSI4qOP/c
         /qeoFsTbfCI+KzAYhq9/+m+/qYJWG3wQVsUWd6IZjACDkrmFSnUqGq1pVxsaRLs+K9vC
         21eaVH1FNfIyG8YP56MmVXHzxkrstftijxI6G2bQPz2db/aBIo6RfuI0dSqmUkPmgRO1
         cjEHqkdVFihRiBjglIxkmt5tndhBUzNJGXpWbEuvBy9Wg7ou8GTvSXYljP3olLHRzXwg
         OUng==
X-Forwarded-Encrypted: i=1; AJvYcCXZKjm3ngJONbQ6OicHuEA+eG9b8VYQdsOrdFuxNZbdlLQTn9zAYhYNkJ1C81Ucfx1gwKfJqIIFZJwABbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfDz6sZ354HnKyMG7BVbTryXQzQ1KYlXbDWnKCBdFPj1dyHQqM
	b7TwYrbaDQ3J8hl5k/N0/w1FbxlmIcuMfX4wXIrJneQlK026Q/tORbtuMt7vFaaEZ6mfAii6Jg7
	Y6+ZFIw==
X-Google-Smtp-Source: AGHT+IHx1drcB+12ihwrtisk8JEb7Xi0YVN2JOPO9iiRooccULaIcDKSUw3kAKz9gcHuWZx5ErT2yAW0g/0=
X-Received: from pfbeg23.prod.google.com ([2002:a05:6a00:8017:b0:77f:606b:78ff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1398:b0:77e:7302:dbe7
 with SMTP id d2e1a72fcca58-77f53acdcdamr4124318b3a.27.1758644890871; Tue, 23
 Sep 2025 09:28:10 -0700 (PDT)
Date: Tue, 23 Sep 2025 09:28:09 -0700
In-Reply-To: <aNIJawIapU86zXZG@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com> <20250919223258.1604852-35-seanjc@google.com>
 <aNIJawIapU86zXZG@intel.com>
Message-ID: <aNLKmQ5VQsoArdnJ@google.com>
Subject: Re: [PATCH v16 34/51] KVM: nVMX: Advertise new VM-Entry/Exit control
 bits for CET state
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 23, 2025, Chao Gao wrote:
> > 	/* We support free control of debug control saving. */
> > 	msrs->exit_ctls_low &= ~VM_EXIT_SAVE_DEBUG_CONTROLS;
> > }
> >@@ -7200,11 +7204,16 @@ static void nested_vmx_setup_entry_ctls(struct vmcs_config *vmcs_conf,
> > #ifdef CONFIG_X86_64
> > 		VM_ENTRY_IA32E_MODE |
> > #endif
> >-		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS;
> >+		VM_ENTRY_LOAD_IA32_PAT | VM_ENTRY_LOAD_BNDCFGS |
> >+		VM_ENTRY_LOAD_CET_STATE;
> > 	msrs->entry_ctls_high |=
> > 		(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER |
> > 		 VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL);
> > 
> >+	if (!kvm_cpu_cap_has(X86_FEATURE_SHSTK) &&
> >+	    !kvm_cpu_cap_has(X86_FEATURE_IBT))
> >+		msrs->exit_ctls_high &= ~VM_ENTRY_LOAD_CET_STATE;
> 
> one copy-paste error here. s/exit_ctls_high/entry_ctls_high/

Thank you.  I distinctly remember _trying_ to be extra careful.  *sigh*

Fixup squashed.

