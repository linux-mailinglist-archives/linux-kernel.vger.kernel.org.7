Return-Path: <linux-kernel+bounces-852033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 568FBBD7FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EA3918A4DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E062D8DB0;
	Tue, 14 Oct 2025 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knN0Nlal"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5405922AE65
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427888; cv=none; b=qBKVWfbS8Cq20oEZNpAUIr3m7R0WVYrSOhWawkp7QRm3eGozWKU//iDF5KSLKl1opMWm84aQnEg9Lk3yrmJ642kl7JCAtqA5vaJCOlm+mszPcJDVOitHHPwHtm93YDg/CSZqsG5GIXdnuaEhzawveCXQYSbeDn2YlnQzR1Q9cCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427888; c=relaxed/simple;
	bh=GEkGrg3Y0VhrFhcKMRkq11hTlEvauEQquaSWcnzJ2As=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrnSTlMYNWe+xo8tvUzpHG7O1sfYw2k2lr2RKtmsB+EI+oBAWDZdQLy45k7OjnwK4fhnC9NP7zWGL+4UbA9QlG7kozwhSCENlnPsGXCocd0FnsZhipUdrw4HtM1rvpvpYBTJt7sxQ8wHcdt72E4ekC64iPDqfhJHlD6vY5TWncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knN0Nlal; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D51C4CEE7;
	Tue, 14 Oct 2025 07:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760427886;
	bh=GEkGrg3Y0VhrFhcKMRkq11hTlEvauEQquaSWcnzJ2As=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=knN0Nlal0qGpn0gVor3cxe/sP0hRTASA/uIaFLJk46TcHV+pVlOchbu6SjRGOqipg
	 4WR2WFQSiayBmptuiRmAxZrnN0bZBFeRBQ4lMb7tNl9BkoNumTYm/2lpFPTe5Vldxa
	 0/k8086WoVNPqYR7h3xBYqHsBmkc6fC28D27qcmFEWW/k4o7wIChCNsJcuCekXqXnq
	 gaXjCtDMrJCMvYQalZ19hkyfzbgoWrC2McKT7M/X/g/IFYuuxVL2d8KgGbwacBskpi
	 OfH3tRbcN5EUowOP+dV8EcbQPGQ4SjO1lO0VCCM5HFYgLa6wpXWTGrKfB/YgnHT0lo
	 i37S9spB2Xl4g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v8Zi7-0000000Dlpg-1i61;
	Tue, 14 Oct 2025 07:44:43 +0000
Date: Tue, 14 Oct 2025 08:44:42 +0100
Message-ID: <864is2x6z9.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: salil.mehta@opnsrc.net,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	salil.mehta@huawei.com,
	jonathan.cameron@huawei.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	james.morse@arm.com,
	sudeep.holla@arm.com,
	lpieralisi@kernel.org,
	jean-philippe@linaro.org,
	tglx@linutronix.de,
	oliver.upton@linux.dev,
	richard.henderson@linaro.org,
	andrew.jones@linux.dev,
	mst@redhat.com,
	david@redhat.com,
	philmd@linaro.org,
	ardb@kernel.org,
	borntraeger@linux.ibm.com,
	alex.bennee@linaro.org,
	gustavo.romero@linaro.org,
	npiggin@gmail.com,
	linux@armlinux.org.uk,
	karl.heubaum@oracle.com,
	miguel.luis@oracle.com,
	darren@os.amperecomputing.com,
	ilkka@os.amperecomputing.com,
	vishnu@os.amperecomputing.com,
	gankulkarni@os.amperecomputing.com,
	wangyanan55@huawei.com,
	wangzhou1@hisilicon.com,
	linuxarm@huawei.com
Subject: Re: [RFC PATCH] KVM: arm64: vgic-v3: Cache ICC_CTLR_EL1 and allow lockless read when ready
In-Reply-To: <CAFEAcA8FhgcaM_OsHKB3+3Z7B_oZJqU4LHX_j9p-ZQrHfWGX7g@mail.gmail.com>
References: <20251008201955.3919537-1-salil.mehta@opnsrc.net>
	<86v7koxk1z.wl-maz@kernel.org>
	<CAFEAcA8=yhQ-ygoA-fqxzwg69OkdW2nBM0O9X3Lmww4eXuVMWA@mail.gmail.com>
	<867bwzxe9r.wl-maz@kernel.org>
	<CAFEAcA8FhgcaM_OsHKB3+3Z7B_oZJqU4LHX_j9p-ZQrHfWGX7g@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: peter.maydell@linaro.org, salil.mehta@opnsrc.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, salil.mehta@huawei.com, jonathan.cameron@huawei.com, will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, james.morse@arm.com, sudeep.holla@arm.com, lpieralisi@kernel.org, jean-philippe@linaro.org, tglx@linutronix.de, oliver.upton@linux.dev, richard.henderson@linaro.org, andrew.jones@linux.dev, mst@redhat.com, david@redhat.com, philmd@linaro.org, ardb@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org, gustavo.romero@linaro.org, npiggin@gmail.com, linux@armlinux.org.uk, karl.heubaum@oracle.com, miguel.luis@oracle.com, darren@os.amperecomputing.com, ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com, gankulkarni@os.amperecomputing.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com, linuxarm@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 13 Oct 2025 17:48:44 +0100,
Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> On Mon, 13 Oct 2025 at 11:55, Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Mon, 13 Oct 2025 09:42:58 +0100,
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Thu, 9 Oct 2025 at 14:48, Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > On Wed, 08 Oct 2025 21:19:55 +0100,
> > > > salil.mehta@opnsrc.net wrote:
> > > > >
> > > > > From: Salil Mehta <salil.mehta@huawei.com>
> > > > >
> > > > > [A rough illustration of the problem and the probable solution]
> > > > >
> > > > > Userspace reads of ICC_CTLR_EL1 via KVM device attributes currently takes a slow
> > > > > path that may acquire all vCPU locks. Under workloads that exercise userspace
> > > > > PSCI CPU_ON flows or frequent vCPU resets, this can cause vCPU lock contention
> > > > > in KVM and, in the worst cases, -EBUSY returns to userspace.
> > > > >
> > > > > When PSCI CPU_ON and CPU_OFF calls are handled entirely in KVM, these operations
> > > > > are executed under KVM vCPU locks in the host kernel (EL1) and appear atomic to
> > > > > other vCPU threads. In this context, system register accesses are serialized
> > > > > under KVM vCPU locks, ensuring atomicity with respect to other vCPUs. After
> > > > > SMCCC filtering was introduced, PSCI CPU_ON and CPU_OFF calls can now exit to
> > > > > userspace (QEMU). During the handling of PSCI CPU_ON call in userspace, a
> > > > > cpu_reset() is exerted which reads ICC_CTLR_EL1 through KVM device attribute
> > > > > IOCTLs. To avoid transient inconsistency and -EBUSY errors, QEMU is forced to
> > > > > pause all vCPUs before issuing these IOCTLs.
> > > >
> > > > I'm going to repeat in public what I already said in private.
> > > >
> > > > Why does QEMU need to know this? I don't see how this is related to
> > > > PSCI, and outside of save/restore, there is no reason why QEMU should
> > > > poke at this. If QEMU needs fixing, please fix QEMU.
> > >
> > > I don't know the background here, but generally speaking,
> > > when we do a CPU reset that includes writing all the CPU state
> > > of the "this is freshly reset from userspace's point of view" vcpu
> > > back to the kernel. More generally, userspace should be able to
> > > read and write sysregs for a vcpu any time it likes, and not
> > > arbitrarily get back -EBUSY. What does the kernel expect
> > > userspace to do with an errno like that?
> >
> > The main issue here is that GICv3 is modelled as a device, just like
> > GICv2, and that all the sysregs that are relevant to the GIC have the
> > same status as the MMIO registers: they can only be accessed when the
> > vcpus are not running.
> >
> > These sysregs are not visible through the normal ONE_REG API, and
> > therefore not subjected to the "do whatever you want" rule.
> 
> Ah, I'd forgotten that. But the cpuif registers are still
> per-cpu, and they do still need to be reset on vcpu reset,
> and that might still happen for a single vcpu when the VM
> as a whole is still running.
> 
> That said, QEMU's current code for this could be refactored
> to avoid the reset-time read of ICC_CTLR_EL1 from the kernel.
> We do this so we can set the userspace struct field for this
> register to the right value. But we could ask the kernel for
> that value once on VM startup since it's not going to change mid-run.

The reset value is indeed cast in stone once the GIC has been created.

> That would bring ICC_CTLR_EL1 into line with the other cpuif
> registers, where QEMU assumes it knows what the kernel's
> reset value of them is (mostly "0") and doesn't bother to ask.
> This is different from how we handle ONE_REG sysregs, where
> I'm pretty sure we do ask the kernel the value of all of them
> on a vcpu reset. (And then write the values back again, which
> is a bit silly but nobody's ever said it was a performance
> problem for them :-))
>
> > Should we have done something else when the GICv3 save/restore API was
> > introduced and agreed upon with the QEMU people? Probably. Can we
> > change it now? Probably not. The only thing we could relax is the
> > scope of the lock when accessing a sysreg, so that we only mandate
> > that the targeted vcpu is not running instead of the whole VM.
> >
> > And finally, if you object to this API, why should we do for GICv5,
> > which is so far implemented by following the exact same principles?
> 
> I don't object to the API inherently (I don't care whether we
> do these register reads via a dev ioctl or something else,
> from userspace's point of view it's just "do some syscall,
> get a value") -- I'm just objecting to the kernel's
> implementation of it where it might return EBUSY :-)

To me, EBUSY has a clear meaning: you're otherwise using the resource,
and you need to relinquish it first, while EINVAL indicates that the
kernel doesn't understand what you want.

As I said, I'm happy to look at reducing the locking to only the
target vcpu in the case of a sysreg being accessed, but EBUSY will
stay.

> 
> (Also, if the kernel had failed EINVAL unconditionally for
> an attempt to do this on a not-stopped VM then we'd probably
> have found this mismatch in understanding about how the
> API should work years ago. "Mostly works but sometimes fails
> EBUSY" is the worst of all worlds.)
> 
> I haven't yet got as far as thinking about the KVM interface
> for GICv5 yet...

I guess that for the time being, we'll assume that GICv3 is the
reference.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

