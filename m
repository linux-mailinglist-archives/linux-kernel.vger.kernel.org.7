Return-Path: <linux-kernel+bounces-819387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA510B59FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B608B1C02DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE24127F4CE;
	Tue, 16 Sep 2025 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4mveTCoV"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AF427990C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758045290; cv=none; b=XnVI5Aia9RfVRBdJUibqEgM2qF8fI/Rf2MXdzId6srI7VvFZPvG7aQ31K/w1HrmjdaUz18hvk/bhbhjtZG5Eek0kouMY3ktShHdDTKS6HAv772MYgtxJp2+vaUBL8j4Cw/yqsskpUJGPaJiqWMxkuoza2OtIM4t93j6tS5a+hIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758045290; c=relaxed/simple;
	bh=5pc1vYWv8Mh+GZOqkyZtqcd5AHyJPIFY0nw20gvCFXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S4uYHrxhpX/q9WwZZGOEoOx/WtXDAgTyuJ8uF8VD/hsj1ePluxxjkUXhsgblUYGwNExB1z2pAGIDJ0NCYHUVQPrqo2xRs8sTU0uDyC5O+D0yNi7XVfnCrwX7J11OU38hhYmcQ8rjXPpECLcsyENrAMBcwwdDXkSkE6CmIaGs/KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4mveTCoV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b54b37ba2d9so179191a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758045288; x=1758650088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9rYwd9Yt4KSJMAiHCxDd/fBe/YrUr9zrmO6WYo46ZM0=;
        b=4mveTCoVKwFDxR8KT0T0AIU/9GrdxO1I4bd2QmoBtfCnYnyPTSdUeW8W8/I+U92CkR
         9VAqEriu4ZmVLOzLg6bOpylGPOclPfae0c34kZF51rvicJDt+GWZ+dDBtiZLGYMgVtTK
         cY+ffat7PZrKhboLGq3exicFYteryLQSv/OlXbjLPL7Df2pxWxcetclND3O4JEzJibUp
         BwoWHuD8ktP1eudrgx3OMYZcvmA61rr7kswGtnhOrt891L9+xDpZy91OZl4m8/YEyjGX
         IeTbRzO0H+m3rvBjmPlcUleaEqBmCCI9Zhpnq/giUAZBLAYCzdkHtPh5exGbrp35LNgP
         NZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758045288; x=1758650088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rYwd9Yt4KSJMAiHCxDd/fBe/YrUr9zrmO6WYo46ZM0=;
        b=HqOWXgsiX3JkLmiOqnyBZbiaXkbYkfeGQQUTPd3f4GjGo2/xZUPYw9mcGqyyeT3GGd
         kd607IFXfaDy+fSZWDlwMZyodTb4Ffk+JcxmbYbWBd0fZ0NZPb5nI+tItoJUNVvorTzb
         UhVXJyKkBIyYPQosNJuoOTep5Co2doRJeaXq3hvrcKIeX1YUiiKARlRAs7fbNMzCKu4j
         15U3EWYpEpOHX4xU2Kd5JFDhjFOwXzFJ6cYX7h6vdkDKOEt7EMvKjCJUpeonw54q5Tt/
         sqv3uvOzwi/BvHO7XTmQLJJlYPtbPifFHRPxVZPWEqVR1hLek1YrCBNY0c+T3hmibap7
         fAvg==
X-Forwarded-Encrypted: i=1; AJvYcCWocvmHki01mRTyJ/oB00Vn8VobTcLoAEEGdvrXfwfeW5MEhFZ/hr/VcleN4AxJMcidp9srW/GX1LrGYA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzByYwOgwfycYVR1kFAM9Bf+3OcNaCvozpwx9JAxSgW1wghE2/s
	gcB+fx61WJkjdFY8k/lZczNSSNY7we9CZahxiCfpuaN7fFOD+gnUwLmqHhHv/IkARylTmUuB3wk
	xsTS3LQ==
X-Google-Smtp-Source: AGHT+IHxYRALXe/6aqTfS3mOIcKC9WdzJl0+HjYjtsgS8nKde2B3kRmWxItE8RmZHp3qoFvozkM2g48OqEw=
X-Received: from pjbnb15.prod.google.com ([2002:a17:90b:35cf:b0:328:116e:273])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:da87:b0:32e:7478:f743
 with SMTP id 98e67ed59e1d1-32ea60efe78mr3955493a91.11.1758045287913; Tue, 16
 Sep 2025 10:54:47 -0700 (PDT)
Date: Tue, 16 Sep 2025 10:54:46 -0700
In-Reply-To: <0387b08a-a8b0-4632-abfc-6b8189ded6b4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909182828.1542362-1-xin@zytor.com> <aMLakCwFW1YEWFG4@google.com>
 <0387b08a-a8b0-4632-abfc-6b8189ded6b4@linux.intel.com>
Message-ID: <aMmkZlWl4TiS2qm8@google.com>
Subject: Re: [RFC PATCH v1 0/5] x86/boot, KVM: Move VMXON/VMXOFF handling from
 KVM to CPU lifecycle
From: Sean Christopherson <seanjc@google.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-pm@vger.kernel.org, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, pavel@kernel.org, brgerst@gmail.com, 
	david.kaplan@amd.com, peterz@infradead.org, andrew.cooper3@citrix.com, 
	kprateek.nayak@amd.com, chao.gao@intel.com, rick.p.edgecombe@intel.com, 
	dan.j.williams@intel.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 11, 2025, Arjan van de Ven wrote:
> Hi,
> > I also want to keep the code as a module, both to avoid doing VMXON unconditionally,
> 
> can you expand on what the problem is with having VMXON unconditionally enabled?

Unlike say EFER.SVME, VMXON fundamentally changes CPU behavior.  E.g. blocks INIT,
activates VMCS caches (which aren't cleared by VMXOFF on pre-SPR CPUs, and AFAIK
Intel hasn't even publicly committed to that behavior for SPR+), restricts allowed
CR0 and CR4 values, raises questions about ucode patch updates, triggers unique
flows in SMI/RSM, prevents Intel PT from tracing on certain CPUs, and probably a
few other things I'm forgetting.

> A lot of things are much simpler if it's on at cpu up, and turned off only at the
> down path (be it offline of kexec).. no refcounting, no locking, etc...

For Intel.  Unless _all_ vendors and architectures follow suit, KVM will need
the refcounting and locking.  And while it's not anyone's fault, the *vast*
majority of complexity around enabling virtualization in KVM is due to VMX.
I.e. KVM added a bunch of code to deal with the aformentioned side effects of
VMXON, and as a result, all other vendors/architectures have had to deal with
that complexity.

> so would be good to understand what the problem would be with having it always on

Doing VMXON unconditionally is a minor objection.  My primary objection is that
this series does what's easiest for TDX, and leaves behind all of the VMX-induced
technical debt in KVM.

