Return-Path: <linux-kernel+bounces-850382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4429ABD2AC0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA2A14F0BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607D430594F;
	Mon, 13 Oct 2025 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uv1CRgQH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75A30215D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760352900; cv=none; b=L7YDIUqulNHK9gsXlFvjrh0mfJC0jOJhQONfLAyquk1vzrCFKyBM9oJbxYEbOqTAWUfSAazTxZCYB5XsXXJer+dHAN8XMPJxtncWKNBy0TasHQNeWoNvNC3cXcpcYLrUGDvH1eQQWJyfE6SJd+sMCVIlCPxcnX10KRXtSl9sPu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760352900; c=relaxed/simple;
	bh=hDtDBPq7mpQu59X1/KQKeSG4qGjdGKZLxJrvhsMtr8s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQ9aRvl7XWAcUtLwJi5jml+JqFAFahcQXbJnkUZ+xWF1J57H8dhK2RLBzjAtQV/6VwqEpfPqzmr6bnsGs8RhuC235G1RU9dGnfroZNqvPXHQzuGhceFwdRL7AiRpLH7R4gCBjv5MUSdrca+aqLShbSWzVIob7bhS4yXgnZ9BOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uv1CRgQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B25C4CEE7;
	Mon, 13 Oct 2025 10:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760352900;
	bh=hDtDBPq7mpQu59X1/KQKeSG4qGjdGKZLxJrvhsMtr8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uv1CRgQHUG5FCeSMmKXhInPfYnrb1p1wekfU4umGXqr7isPVVwiPFyxcc7xmk9Kie
	 gsWVRFinc1T3GBcTJnY3Ku6zRxwPviuItaPs2QgnczDleixks3ocMtO7S3DPUyjzFP
	 gHtWsXZkZ9tL4hDYs1WKKbeee6PAwGDSF8oLpGEmqScG+he0WEzT6bt/Edh6eXG9iX
	 k/Zbm6yIuQ/lxdInD30PuoKQ5YTKVrO/21+pmsuLa8CSfcF7eq7KWZwMH9NdB3wN8r
	 ER8PmXbSaz+oZ26t2JCuIIk7L5qfbf1kg0RqRWltR+D6+rm2pN2R7ucQucD+6yesd9
	 rE6u+6llNL+oQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1v8GCf-0000000DU5W-12CP;
	Mon, 13 Oct 2025 10:54:57 +0000
Date: Mon, 13 Oct 2025 11:54:56 +0100
Message-ID: <867bwzxe9r.wl-maz@kernel.org>
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
In-Reply-To: <CAFEAcA8=yhQ-ygoA-fqxzwg69OkdW2nBM0O9X3Lmww4eXuVMWA@mail.gmail.com>
References: <20251008201955.3919537-1-salil.mehta@opnsrc.net>
	<86v7koxk1z.wl-maz@kernel.org>
	<CAFEAcA8=yhQ-ygoA-fqxzwg69OkdW2nBM0O9X3Lmww4eXuVMWA@mail.gmail.com>
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

On Mon, 13 Oct 2025 09:42:58 +0100,
Peter Maydell <peter.maydell@linaro.org> wrote:
> 
> On Thu, 9 Oct 2025 at 14:48, Marc Zyngier <maz@kernel.org> wrote:
> >
> > On Wed, 08 Oct 2025 21:19:55 +0100,
> > salil.mehta@opnsrc.net wrote:
> > >
> > > From: Salil Mehta <salil.mehta@huawei.com>
> > >
> > > [A rough illustration of the problem and the probable solution]
> > >
> > > Userspace reads of ICC_CTLR_EL1 via KVM device attributes currently takes a slow
> > > path that may acquire all vCPU locks. Under workloads that exercise userspace
> > > PSCI CPU_ON flows or frequent vCPU resets, this can cause vCPU lock contention
> > > in KVM and, in the worst cases, -EBUSY returns to userspace.
> > >
> > > When PSCI CPU_ON and CPU_OFF calls are handled entirely in KVM, these operations
> > > are executed under KVM vCPU locks in the host kernel (EL1) and appear atomic to
> > > other vCPU threads. In this context, system register accesses are serialized
> > > under KVM vCPU locks, ensuring atomicity with respect to other vCPUs. After
> > > SMCCC filtering was introduced, PSCI CPU_ON and CPU_OFF calls can now exit to
> > > userspace (QEMU). During the handling of PSCI CPU_ON call in userspace, a
> > > cpu_reset() is exerted which reads ICC_CTLR_EL1 through KVM device attribute
> > > IOCTLs. To avoid transient inconsistency and -EBUSY errors, QEMU is forced to
> > > pause all vCPUs before issuing these IOCTLs.
> >
> > I'm going to repeat in public what I already said in private.
> >
> > Why does QEMU need to know this? I don't see how this is related to
> > PSCI, and outside of save/restore, there is no reason why QEMU should
> > poke at this. If QEMU needs fixing, please fix QEMU.
> 
> I don't know the background here, but generally speaking,
> when we do a CPU reset that includes writing all the CPU state
> of the "this is freshly reset from userspace's point of view" vcpu
> back to the kernel. More generally, userspace should be able to
> read and write sysregs for a vcpu any time it likes, and not
> arbitrarily get back -EBUSY. What does the kernel expect
> userspace to do with an errno like that?

The main issue here is that GICv3 is modelled as a device, just like
GICv2, and that all the sysregs that are relevant to the GIC have the
same status as the MMIO registers: they can only be accessed when the
vcpus are not running.

These sysregs are not visible through the normal ONE_REG API, and
therefore not subjected to the "do whatever you want" rule.

Should we have done something else when the GICv3 save/restore API was
introduced and agreed upon with the QEMU people? Probably. Can we
change it now? Probably not. The only thing we could relax is the
scope of the lock when accessing a sysreg, so that we only mandate
that the targeted vcpu is not running instead of the whole VM.

And finally, if you object to this API, why should we do for GICv5,
which is so far implemented by following the exact same principles?

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

