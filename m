Return-Path: <linux-kernel+bounces-819359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C15B59F45
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3FE460E25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF89274FEF;
	Tue, 16 Sep 2025 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LV1AUR6K"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208BD26D4E5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043760; cv=none; b=UrBflxAy28JK2GMpTT9jaRi9RiTz85K56bsQh1bKe5aax+1ovV7oAVl8MQkX0yYLUBKk3Z+kT1xcGWZ3afK0JvHPcT57VGGHmEuBmKNbtao3lHlbv8VANwaArc8OlBIi95wdJSXrk3hNCDTIj6zsvRDD1NbF6uVlvFNRTDul3Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043760; c=relaxed/simple;
	bh=x2oJ9FRKNYFoPq9uE8DflagCpHS9R20ZJCWQVj563o4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rNdNX00fU49q8DWyg5+0hPHsglq/mULNT+VS2h7VldfYqvDL7sP7GF4siKGdOfnUV7sGr1v6044gCIKyt0g0ZaV+dNknpx6OKpa6zJyMjqhPZ6viQGvcqBz5XyZEBbosK31f+LpnmH8HGcbQBVYePB2MfmJTYuoBDuMVKfEZYJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LV1AUR6K; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b549a25ade1so7318860a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758043758; x=1758648558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GL4dczl9DwyqBhOns7ZdMdYMLxJa00fu4ypjI0VjCNY=;
        b=LV1AUR6Kmz96Uaxb4yGGm1PjRRgn1Q3Jo0stXJ4R7mWvJZ8VSryhIhbzu3QSMSkZsL
         3XeNuw54RQCQe/eZ71S7Z6cvA/82GLE48edRJMM1gmPq2wlCHghW9prBKdmyQPIb3rYK
         3paIUIqYdt7mwNv+xS0q28+t7bPCwA7h79anYQ6HNH6oiCRstddQzV1jgBqxogZHCakd
         kuve1YN3TgAVGMwJwUvCTpbKbcnDZtXfuHvUr84MyEMPwHiwBY29mrC7x55G/QZntcy2
         3Yt9NhI7X5XuIw1EwkN7DpDtr1WGhVMO8V2RdFvGKuCogDYsQ9BWRszw57dqzRAcQaoT
         DbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758043758; x=1758648558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GL4dczl9DwyqBhOns7ZdMdYMLxJa00fu4ypjI0VjCNY=;
        b=RCyIMST2wmazq0g8o0A6DaLCprZErx1KSvJ3i9OEgvWxf4T5g1Ja0SKZWXgGj8fR+W
         TT4TL82BS7T4JhsoewBW+m+vIU7fOPdlT27BUgzVh2ToAAgCogp0DwG3MT5/9dS3zS8u
         5uoGKmpJFpZLEGv0+Y+moFazog3XCuRUq2H8ZknpgtlLa/fWZ94nmFGwXxWK78/nNcu9
         ZI+C5srsp8/FQ4Too94a2uHB/nu7LxJVKVLjaxKdN/G8FXiLkh8vu+x8VuDiJHWDIUPP
         3ZqwSP5xOBRNo8mVJTCEoExzmxCLTulJwqj3nhtP3PoW65VGkfASDceSfKsrnzXods2f
         mSAA==
X-Forwarded-Encrypted: i=1; AJvYcCU4a9T7SC3/3czb9NsXMNclZs2eQb5CQ1nL+rDeRAZIgioThyol45O4COF+X+Ci43LbAWPqjp7m1NkiRRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyydwLHJj0B6OJIxnHFbp3wTbd9VlklQ7yz4KzAb2rz6AJ/YsD4
	gUXoBElmm950wSLY+oIetl2lLnQbCS40tmFEpv94Vta9V6Hj8vuBrqpza8SYG0qt/P8moi1u1Fo
	gjwzMbQ==
X-Google-Smtp-Source: AGHT+IHIRjCadr12K2XcMlYlymNh7pblovdAh58AkUupKWLfMdFpZGymrkH3qbjHbupba6U1ttaO4vlmiYY=
X-Received: from pjp16.prod.google.com ([2002:a17:90b:55d0:b0:329:ec3d:72ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f87:b0:329:d8d2:3602
 with SMTP id 98e67ed59e1d1-32de4f7dce2mr23780964a91.17.1758043758281; Tue, 16
 Sep 2025 10:29:18 -0700 (PDT)
Date: Tue, 16 Sep 2025 10:29:16 -0700
In-Reply-To: <eacc2a0a-2215-4582-bf08-9c199cf23018@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909182828.1542362-1-xin@zytor.com> <aMLakCwFW1YEWFG4@google.com>
 <eacc2a0a-2215-4582-bf08-9c199cf23018@intel.com>
Message-ID: <aMmebJJ2m1A5O-13@google.com>
Subject: Re: [RFC PATCH v1 0/5] x86/boot, KVM: Move VMXON/VMXOFF handling from
 KVM to CPU lifecycle
From: Sean Christopherson <seanjc@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-pm@vger.kernel.org, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, pavel@kernel.org, brgerst@gmail.com, 
	david.kaplan@amd.com, peterz@infradead.org, andrew.cooper3@citrix.com, 
	kprateek.nayak@amd.com, arjan@linux.intel.com, chao.gao@intel.com, 
	rick.p.edgecombe@intel.com, dan.j.williams@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 11, 2025, Dave Hansen wrote:
> On 9/11/25 07:20, Sean Christopherson wrote:
> > VPID and ASID allocation need to be managed system-wide, otherwise
> > running KVM alongside another hypervisor-like entity will result in
> > data corruption due to shared TLB state.
> What other hypervisor-like entities are out there?

gVisor, VMware Workstation, Virtual Box, and maybe a few more?  Though the three
named are all moving to KVM (Virtual Box may already have full KVM support).
But it's not just existing entities, it's also the fact that lack of common
virtualization infrastructure has definitely deterred others from trying to
upstream non-KVM hypervisors (or hypervisor-like projects).

Now, that's arguably been a good thing in hindsight, e.g. gVisor, VMware, and
Virtual Box wouldn't have switched to KVM had upstream accepted their custom
drivers/hypervisors.  But I like to give us the benefit of the doubt in the sense
that, had someone tried to upstream a KVM-like hypervisor, I think we would have
redirected them into KVM and figured out how to close any gaps, as opposed to
blindly accepting a newfangled hypervisors.

However, no one even so much as proposes new hypervisor-like entities in upstream,
at least not for x86, because the barrier to doing so is extremely high due to KVM
having a stranglehold on all things virtualization.  And even if no one ever lands
another hypervisor-like thing in upstream, I think KVM (and the kernel at-large)
would benefit if patches were at least posted, e.g. would help identify areas of
opportunity and/or flaws in KVM.

> The TDX module needs (or will need) VMXON for some things that aren't
> strictly for virtualization. But what other entities are out there?

The end usage for TDX might not be virtualization focused, but the _kernel's_
usage of VMXON is absolutely for virtualization.  SEAMCALL/SEAMRET are literally
VM-Exit/VM-Enter.

