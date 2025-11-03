Return-Path: <linux-kernel+bounces-882690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA26C2B224
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C5E234938D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00D92FFDF7;
	Mon,  3 Nov 2025 10:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQctnQvS"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65922FF14E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166964; cv=none; b=i762G5n/XxZKyCW2HNxX1d8AXOjE8TCo+BqZDQOLsZf34POamIsneRtcZgCqAEOpGLAga/x+bjphHwnPKAfbk77hh6WzF6m/vk9ldNZ1CaYTDmOcTuY7qM4413xojPN9wS53GjwyWiln5bO6jPNiUyaQM9pAFa51/JkZ2ed7VkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166964; c=relaxed/simple;
	bh=3W6Xuuc2I1xsIYPE53X0l6DDrvgNWRJfyqWNvoG+sYk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ILnUbGU6+IrfO5UEMgre5fhO0xRkubeAdy/oTPrNscnEcJbfMTp8uR2URPugc8PjTK9Ie9RBmVONS+AeeAHYT6F70U2hC+uHVLXJoWiNWeuCI/gH4TiALvUK0DGXBrdNwa+NsOWCooVuCzWT7zrVqQ2lXhuh+RN2b9np8DgrhUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQctnQvS; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b70bca184ccso62790166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 02:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762166961; x=1762771761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5xgBKghQgoZ8jHr9LooPHr1KU7mYZjYus8oMFAhjcE=;
        b=CQctnQvSqz5l4szjHnf9m0Eg3Oa5eW/UvOKl1FrQYT6Gh6P+GVwQ1KSdLjsF753ZPq
         RSJtwsCmUJ9yuYBJjtFoAHF60CH1Hx+ETZkDFHEglgBUyDNIKH+lNxKbDw6RICXE25Sx
         k15EamVKtVDXSDNPFvkJXX7sjdpRBPg35SjdYAGNDJ1Nio4TRpjVl6YYRjn2Ee1GJcpD
         19jNNTy+MrXPfSURyIUg8k93vwtYAbayUpE+l713oXaEjVkDX0pJipDpxAvwk1HrCl4h
         LIIgGR3/6rHr7nls2Cd+dmJnX2Jo+rZIfxTBPLcJSY2z1hdHZZzwSm+469+/eUwmqloI
         JgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762166961; x=1762771761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5xgBKghQgoZ8jHr9LooPHr1KU7mYZjYus8oMFAhjcE=;
        b=NRTJEGo6IE9K4xUeh/yPRmwTkz6Q2q2LMYH1sxZxsXU7lCKJOTD+7R8r54jYTU5169
         d+UqoJzSAm3BHH8VuFmvlOK86kEKujxjCJAq8+jyBiKh3qT0CAFXMlrZzLz+qZcGU3+F
         VJc694hhv9RNmxypAdz06wDiPEBNKDyANnrelwCoW7snkLFjWCr6YJ5pqt1fFfqn8O7I
         XnE3zjFg3aPJZJWgZ9N4lOWx1Jy9fURb66/01/aXZuWMUOgcvS7sdBC/Kddm6qeBRt77
         1CSDiE1kv6y8dtA4CJ8NQrysh4FBpbekTwJueezeLlqRzefCeJ5JzKD28c20RyOJoQuI
         gdVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXF6UqE3iRxqZqp5KDxqiOuXbyrWc9L4LseiVJl/3McCvljNRyxSa0qgeFc9JbQX7WmaiQZQz+5sZcvAmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi7eZZUFFTz1WWAmwy33JNg965e/DPYlUMAOCtRLrOubCvuLD2
	0Gy+Y96l/N2zI0gZpGfR55zblBV90q9TPDTsx3EVCzJMktU2HLD/zT5+p6WmDhpSqpdrwnrQujA
	b+y7H5zCFKSx9qw==
X-Google-Smtp-Source: AGHT+IH7VLvpWRkyGeIFJn46JBW7w21D13s7SFtrkQAw9lj7o8FPwTrJxc6kXqC3MUiKZWsGcCG1jYhBht0kPw==
X-Received: from ejcux13.prod.google.com ([2002:a17:907:cf8d:b0:b6d:74f9:3451])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:2685:b0:b6d:7f28:4319 with SMTP id a640c23a62f3a-b70700b98c7mr1505627066b.3.1762166961470;
 Mon, 03 Nov 2025 02:49:21 -0800 (PST)
Date: Mon, 03 Nov 2025 10:49:20 +0000
In-Reply-To: <aQUuYqowQtbRCYyC@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031003040.3491385-1-seanjc@google.com> <20251031003040.3491385-4-seanjc@google.com>
 <DDWHCMBU8GVB.1CXGUGVWSF8RD@google.com> <aQUuYqowQtbRCYyC@google.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDZ01Y0TC9J2.26YWWKHOKKGSG@google.com>
Subject: Re: [PATCH v4 3/8] x86/bugs: Use an X86_FEATURE_xxx flag for the MMIO
 Stale Data mitigation
From: Brendan Jackman <jackmanb@google.com>
To: Sean Christopherson <seanjc@google.com>, Brendan Jackman <jackmanb@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri Oct 31, 2025 at 9:47 PM UTC, Sean Christopherson wrote:
> On Fri, Oct 31, 2025, Brendan Jackman wrote:
>> On Fri Oct 31, 2025 at 12:30 AM UTC, Sean Christopherson wrote:
>> > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
>> > index 723666a1357e..9acf6343b0ac 100644
>> > --- a/arch/x86/kernel/cpu/bugs.c
>> > +++ b/arch/x86/kernel/cpu/bugs.c
>> > @@ -192,14 +192,6 @@ EXPORT_SYMBOL_GPL(cpu_buf_idle_clear);
>> >   */
>> >  DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
>> >  
>> > -/*
>> > - * Controls CPU Fill buffer clear before VMenter. This is a subset of
>> > - * X86_FEATURE_CLEAR_CPU_BUF_VM, and should only be enabled when KVM-only
>> > - * mitigation is required.
>> > - */
>> 
>> This comment wasn't super clear IMO but now that we're losing it, maybe
>> we can replace it with a WARN_ON() at the end of
>> cpu_apply_mitigations() or something (maybe it belongs in VMX code)? To
>> make it more obvious that X86_FEATURE_CLEAR_CPU_BUF_VM and
>> X86_FEATURE_CLEAR_CPU_BUF_MMIO are mutually exclusive.
>
> No objection from me if we want strong guarantees that CLEAR_CPU_BUF_VM and
> CLEAR_CPU_BUF_MMIO are mutually exclusive.  Though I do think the KVM side of
> things (and the kernel in general) should be paranoid and not lean _too_ hard
> on such assumptions.

Ah, after finishing the review I realised these are _not_ actually
mutually exclusive in terms of the implementation. So asserting here
that they are mutually exclusive would just be confusing, rather than
helfpul, IMO.

