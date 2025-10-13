Return-Path: <linux-kernel+bounces-851042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80415BD533E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAF518A5960
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801FE284B4F;
	Mon, 13 Oct 2025 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7bL0gC2"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E065827FB2A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760374139; cv=none; b=BP2qpLHLb3InX5XwsugOlkmxfHy+Wee54TJ1QU4l8NOHjzQ2NnGea4H+FqQq7MoEYkxt4r9hg01QwANq6d9USMgF24ZNsxZbiAFt1K+5G/gettIVUy6+9mPLM3i7adpwhemXcf05MSn4cCv6KN5kiN/NWlZRO+td5vem2U7bggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760374139; c=relaxed/simple;
	bh=w6lzTshIWy3JM+cSfZr7xkLn0E7l8XLqxjY9wcBsXSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ej1kUPISsrAZ3CRqM52JqwsTUET9IyAqoAYmxAT3B7LuHUv6M2KPMyu1leLnUrDNOZEx7c9Hf+TXH5KJzQKIYrdcFcBAB99N+IGLNZn2lc4jNQ6Ld6wYDGNoMYASAQ3o22H70XOO1pxX5taymcyGgjRO7E+lAca/OhIwxecsCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7bL0gC2; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d5fb5e34cso61507897b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760374137; x=1760978937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w6lzTshIWy3JM+cSfZr7xkLn0E7l8XLqxjY9wcBsXSk=;
        b=u7bL0gC2BaarNAWVn0Hm9ttaEoFXME+NSmb8P4dIQ9GycVtES/DeENIBSz6G4c1D+g
         rX54Wwx+jGOtfZ2VTfteEDa6zviF5+gd9KAwupIF+26YF9r4+v31JvZSU+P7/ThwwYiG
         Z4BbJ7um9riBeielkJtLzLjblNBwR4tN0Z4WoGL+mr7GWI3Rcms4m7NdPWWudogOLg5J
         lR6M4+BwyNhXhlm8QuExTHda8oJglTIQ2iO0xs1wVVr97iUV3vx8WhAkSqHPAampfVcB
         3IOTOjjInGQc6LEEF4qi6erl3eRqYQ4jw/RZjwgrGphjwOeHIKJBIH8SUk8q90+fQNMq
         /7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760374137; x=1760978937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6lzTshIWy3JM+cSfZr7xkLn0E7l8XLqxjY9wcBsXSk=;
        b=nuB0Vi00MWLbxp/L1ioe/kYq//Ufgnfm+N5rRFDf8lC7n/ZDDa6jT9Zu7FGskqDaTJ
         EjQJSEspQIWMl5+0rvrLvyc6CRF5uZY/kJTrDPP2gNkZTFW7qEAS+9jvZt3GXPc/krRV
         EWwTuxGWl6ofVSzD6rpeKGlZZ4ADB6Z17ASZz8GZALBFWKXQai+u8pPz66P/QM+kltpW
         JeOLjq2AfM8tQv1ACFT9HO6AFSe9Ay5+gc9iwKozRGbmxyvfTgSmkGXfk9FedeDV2IAF
         xjJ3VbLz/JWv/klKnVqLGqSXCgrtLHy/HLBsPZmrrGU3oy8U8DOWErRtki5eVXCWbFOn
         JXfw==
X-Forwarded-Encrypted: i=1; AJvYcCXLQzj4gTva55DCfP2o/57eEpDZQMLsQgZsTaKBCKV2S9S2/q806izpG0uZnQmS83grAjBBJlH+6NSkfgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMd9Q8L5MH9G3zBcvgyPQfT7zUCFMR3XCm2uYoYNa6VVSG06u+
	/1bDjN3hiB5NNCI895/iJ2KgXHiY0EHR9b5KMIkGqJByKn/A8dDGMjZfII/W/0Li1DlMTqam+u4
	OfRRFGpe4Vsc8DdEymNkoioN0JwRHTLGHoonxYpL6Hg==
X-Gm-Gg: ASbGnct5PCyDnHB+Zf7TPpLprHsbZmVfT9EGblszsi1UiV46aDUVDceRuY+OWqpxDK9
	v9NPIXL5PgiPTwqyZHzi9/82ptt6xDX4KTlCUek5t2uCftjTTywEM2JmVlbqUYxI6tQ+3N1DLUw
	9ACnBpPhvMMYk9GZqhQxZ2vTuLpAQyqTuE0dNxgY9MygPSBnXyWBbkyU51Y8wcWcOfS4782V3gY
	tqhKVibLfkIlzf19ejnu+WsFAbU+aJlcRTzwO45kg==
X-Google-Smtp-Source: AGHT+IHqmHzAaVDHnow33cvgGG6Z5YF743Jj5ieEa2OjQWYWO3V5SRTF9BXUMfG7UGOBqyiISijlbKOAc4g+hB8SDas=
X-Received: by 2002:a53:ca52:0:b0:63c:dd26:34e with SMTP id
 956f58d0204a3-63cdd260c73mr10670160d50.21.1760374136718; Mon, 13 Oct 2025
 09:48:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008201955.3919537-1-salil.mehta@opnsrc.net>
 <86v7koxk1z.wl-maz@kernel.org> <CAFEAcA8=yhQ-ygoA-fqxzwg69OkdW2nBM0O9X3Lmww4eXuVMWA@mail.gmail.com>
 <867bwzxe9r.wl-maz@kernel.org>
In-Reply-To: <867bwzxe9r.wl-maz@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Oct 2025 17:48:44 +0100
X-Gm-Features: AS18NWCAS9w1mC8fOxNHNg9CQTZ_Zo0jkRVSjMdF_vJRpxD-dkzMerf3nH7E2I4
Message-ID: <CAFEAcA8FhgcaM_OsHKB3+3Z7B_oZJqU4LHX_j9p-ZQrHfWGX7g@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: arm64: vgic-v3: Cache ICC_CTLR_EL1 and allow
 lockless read when ready
To: Marc Zyngier <maz@kernel.org>
Cc: salil.mehta@opnsrc.net, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, salil.mehta@huawei.com, 
	jonathan.cameron@huawei.com, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, james.morse@arm.com, sudeep.holla@arm.com, 
	lpieralisi@kernel.org, jean-philippe@linaro.org, tglx@linutronix.de, 
	oliver.upton@linux.dev, richard.henderson@linaro.org, andrew.jones@linux.dev, 
	mst@redhat.com, david@redhat.com, philmd@linaro.org, ardb@kernel.org, 
	borntraeger@linux.ibm.com, alex.bennee@linaro.org, gustavo.romero@linaro.org, 
	npiggin@gmail.com, linux@armlinux.org.uk, karl.heubaum@oracle.com, 
	miguel.luis@oracle.com, darren@os.amperecomputing.com, 
	ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com, 
	gankulkarni@os.amperecomputing.com, wangyanan55@huawei.com, 
	wangzhou1@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 11:55, Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 13 Oct 2025 09:42:58 +0100,
> Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Thu, 9 Oct 2025 at 14:48, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Wed, 08 Oct 2025 21:19:55 +0100,
> > > salil.mehta@opnsrc.net wrote:
> > > >
> > > > From: Salil Mehta <salil.mehta@huawei.com>
> > > >
> > > > [A rough illustration of the problem and the probable solution]
> > > >
> > > > Userspace reads of ICC_CTLR_EL1 via KVM device attributes currently takes a slow
> > > > path that may acquire all vCPU locks. Under workloads that exercise userspace
> > > > PSCI CPU_ON flows or frequent vCPU resets, this can cause vCPU lock contention
> > > > in KVM and, in the worst cases, -EBUSY returns to userspace.
> > > >
> > > > When PSCI CPU_ON and CPU_OFF calls are handled entirely in KVM, these operations
> > > > are executed under KVM vCPU locks in the host kernel (EL1) and appear atomic to
> > > > other vCPU threads. In this context, system register accesses are serialized
> > > > under KVM vCPU locks, ensuring atomicity with respect to other vCPUs. After
> > > > SMCCC filtering was introduced, PSCI CPU_ON and CPU_OFF calls can now exit to
> > > > userspace (QEMU). During the handling of PSCI CPU_ON call in userspace, a
> > > > cpu_reset() is exerted which reads ICC_CTLR_EL1 through KVM device attribute
> > > > IOCTLs. To avoid transient inconsistency and -EBUSY errors, QEMU is forced to
> > > > pause all vCPUs before issuing these IOCTLs.
> > >
> > > I'm going to repeat in public what I already said in private.
> > >
> > > Why does QEMU need to know this? I don't see how this is related to
> > > PSCI, and outside of save/restore, there is no reason why QEMU should
> > > poke at this. If QEMU needs fixing, please fix QEMU.
> >
> > I don't know the background here, but generally speaking,
> > when we do a CPU reset that includes writing all the CPU state
> > of the "this is freshly reset from userspace's point of view" vcpu
> > back to the kernel. More generally, userspace should be able to
> > read and write sysregs for a vcpu any time it likes, and not
> > arbitrarily get back -EBUSY. What does the kernel expect
> > userspace to do with an errno like that?
>
> The main issue here is that GICv3 is modelled as a device, just like
> GICv2, and that all the sysregs that are relevant to the GIC have the
> same status as the MMIO registers: they can only be accessed when the
> vcpus are not running.
>
> These sysregs are not visible through the normal ONE_REG API, and
> therefore not subjected to the "do whatever you want" rule.

Ah, I'd forgotten that. But the cpuif registers are still
per-cpu, and they do still need to be reset on vcpu reset,
and that might still happen for a single vcpu when the VM
as a whole is still running.

That said, QEMU's current code for this could be refactored
to avoid the reset-time read of ICC_CTLR_EL1 from the kernel.
We do this so we can set the userspace struct field for this
register to the right value. But we could ask the kernel for
that value once on VM startup since it's not going to change mid-run.

That would bring ICC_CTLR_EL1 into line with the other cpuif
registers, where QEMU assumes it knows what the kernel's
reset value of them is (mostly "0") and doesn't bother to ask.
This is different from how we handle ONE_REG sysregs, where
I'm pretty sure we do ask the kernel the value of all of them
on a vcpu reset. (And then write the values back again, which
is a bit silly but nobody's ever said it was a performance
problem for them :-))

> Should we have done something else when the GICv3 save/restore API was
> introduced and agreed upon with the QEMU people? Probably. Can we
> change it now? Probably not. The only thing we could relax is the
> scope of the lock when accessing a sysreg, so that we only mandate
> that the targeted vcpu is not running instead of the whole VM.
>
> And finally, if you object to this API, why should we do for GICv5,
> which is so far implemented by following the exact same principles?

I don't object to the API inherently (I don't care whether we
do these register reads via a dev ioctl or something else,
from userspace's point of view it's just "do some syscall,
get a value") -- I'm just objecting to the kernel's
implementation of it where it might return EBUSY :-)

(Also, if the kernel had failed EINVAL unconditionally for
an attempt to do this on a not-stopped VM then we'd probably
have found this mismatch in understanding about how the
API should work years ago. "Mostly works but sometimes fails
EBUSY" is the worst of all worlds.)

I haven't yet got as far as thinking about the KVM interface
for GICv5 yet...

-- PMM

