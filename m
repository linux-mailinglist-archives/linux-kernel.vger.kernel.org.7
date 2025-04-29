Return-Path: <linux-kernel+bounces-625411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB032AA1120
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 18:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A8D51A855FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DE9242917;
	Tue, 29 Apr 2025 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtiqLYMx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6968D21A43B;
	Tue, 29 Apr 2025 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745942572; cv=none; b=iI/Cf+JrcHuGm/CUUerJKyxxzyhM43aPlrVmL3oIsOrNbdJxSu7/XpDiA4hHPC/XE5Y5mzFSXwCrYwpwrn0S3jz0NJ4TYmRa7knKaC7FTUbLxow17UqMJqqnwz8t0Pnwwn5vcMFsbdOHwLtuP4n78MceqrcM/6nomqbG520w4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745942572; c=relaxed/simple;
	bh=zN8T8Z7DU9dSjGLCBZRU0KOgzvW5uVSk7Yqtz8Uj3MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBcrZOt50r6vpXYd8nlhK0O2kHOXoVJoSAjHptBQPYN+gs+4OknGsyFVQ5iyrLt+zGu31SjUrpFCMM6vBFklHexSTstuXIKIyvxJV5QOOeOsTlPD1GKQRJPlmERwZY9v721rrt+lg2gpKiY/djH+7aEYpOy9JZZKFgPCkuJgo6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtiqLYMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D3FC4CEE3;
	Tue, 29 Apr 2025 16:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745942571;
	bh=zN8T8Z7DU9dSjGLCBZRU0KOgzvW5uVSk7Yqtz8Uj3MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UtiqLYMx8RlhW1e1bXzsQlErHQzSY1mzHeFiJ0/7M585DkQomVHPlSkL7WJLYcuqm
	 YOMTi059KttTuncO6lcsxlncUJxKSumq7ec1jwXg73Vb2+gkfmtsekKx9eba02jP5s
	 l1gvgDmoPIScLE+W/T/LHJPMzK6PxXv8CitvYYwhgjVja+p+BCaroWv+UdC+u55sg8
	 CiGuL/FpyYYlHPPawLMpuWReJV1Or3vhEYKjNip1Xmg7Hpr0MS0SCL86emqFqVxwxm
	 yazy/75CjUCutaqLLxgLNfWc2/M+YsJ+Clg2lM8h0A9e8mOVat06VID9IzNkYcohmz
	 Im1c0oj4Gm61Q==
Date: Tue, 29 Apr 2025 18:02:44 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 19/22] irqchip/gic-v5: Add GICv5 CPU interface/IRS
 support
Message-ID: <aBD4JCtyDmk9Fx1b@lpieralisi>
References: <20250424-gicv5-host-v2-0-545edcaf012b@kernel.org>
 <20250424-gicv5-host-v2-19-545edcaf012b@kernel.org>
 <868qnkjngi.wl-maz@kernel.org>
 <aBDoD1orGbYqAmda@lpieralisi>
 <86cycvhtb9.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cycvhtb9.wl-maz@kernel.org>

On Tue, Apr 29, 2025 at 04:38:02PM +0100, Marc Zyngier wrote:
> On Tue, 29 Apr 2025 15:54:07 +0100,
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > 
> > On Mon, Apr 28, 2025 at 04:49:17PM +0100, Marc Zyngier wrote:
> > > On Thu, 24 Apr 2025 11:25:30 +0100,
> > > Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > > > 
> > > > Implement GICv5 CPU interface and IRS support, to manage interrupt
> > > > state, priority and routing for all GICv5 interrupt types.
> > > > 
> > > > The GICv5 CPU interface implements support for PE-Private Peripheral
> > > > Interrupts (PPI), that are handled (enabled/prioritized/delivered)
> > > > entirely within the CPU interface hardware.
> > > > 
> > > > To enable PPI interrupts, implement the baseline GICv5 host kernel
> > > > driver infrastructure required to handle interrupts on a GICv5 system.
> > > > 
> > > > Add the exception handling code path and definitions for GICv5
> > > > instructions.
> > > > 
> > > > Add GICv5 PPI handling code as a specific IRQ domain to:
> > > > 
> > > > - Set-up PPI priority
> > > > - Manage PPI configuration and state
> > > > - Manage IRQ flow handler
> > > > - IRQs allocation/free
> > > > - Hook-up a PPI specific IRQchip to provide the relevant methods
> > > > 
> > > > PPI IRQ priority is chosen as the minimum allowed priority by the
> > > > system design (after probing the number of priority bits implemented
> > > > by the CPU interface).
> > > > 
> > > > The GICv5 Interrupt Routing Service (IRS) component implements
> > > > interrupt management and routing in the GICv5 architecture.
> > > > 
> > > > A GICv5 system comprises one or more IRSes, that together
> > > > handle the interrupt routing and state for the system.
> > > > 
> > > > An IRS supports Shared Peripheral Interrupts (SPIs), that are
> > > > interrupt sources directly connected to the IRS; they do not
> > > > rely on memory for storage. The number of supported SPIs is
> > > > fixed for a given implementation and can be probed through IRS
> > > > IDR registers.
> > > > 
> > > > SPI interrupt state and routing are managed through GICv5
> > > > instructions.
> > > > 
> > > > Each core (PE in GICv5 terms) in a GICv5 system is identified with
> > > > an Interrupt AFFinity ID (IAFFID).
> > > > 
> > > > An IRS manages a set of cores that are connected to it.
> > > > 
> > > > Firmware provides a topology description that the driver uses
> > > > to detect to which IRS a CPU (ie an IAFFID) is associated with.
> > > > 
> > > > Use probeable information and firmware description to initialize
> > > > the IRSes and implement GICv5 IRS SPIs support through an
> > > > SPI-specific IRQ domain.
> > > > 
> > > > The GICv5 IRS driver:
> > > > 
> > > > - Probes IRSes in the system to detect SPI ranges
> > > > - Associates an IRS with a set of cores connected to it
> > > > - Adds an IRQchip structure for SPI handling
> > > > 
> > > > SPIs priority is set to a value corresponding to the lowest
> > > > permissible priority in the system (taking into account the
> > > > implemented priority bits of the IRS and CPU interface).
> > > > 
> > > > Since all IRQs are set to the same priority value, the value
> > > > itself does not matter as long as it is a valid one.
> > > > 
> > > > An IRS supports Logical Peripheral Interrupts (LPIs) and implement
> > > > Linux IPIs on top of it.
> > > > 
> > > > LPIs are used for interrupt signals that are translated by a
> > > > GICv5 ITS (Interrupt Translation Service) but also for software
> > > > generated IRQs - namely interrupts that are not driven by a HW
> > > > signal, ie IPIs.
> > > > 
> > > > LPIs rely on memory storage for interrupt routing and state.
> > > > 
> > > > Memory storage is handled by the IRS - that is configured
> > > > at probe time by the driver with the required memory.
> > > > 
> > > > LPIs state and routing information is kept in the Interrupt
> > > > State Table (IST).
> > > > 
> > > > IRSes provide support for 1- or 2-level IST tables configured
> > > > to support a maximum number of interrupts that depend on the
> > > > OS configuration and the HW capabilities.
> > > > 
> > > > On systems that provide 2-level IST support, always allow
> > > > the maximum number of LPIs; On systems with only 1-level
> > > > support, limit the number of LPIs to 2^12 to prevent
> > > > wasting memory (presumably a system that supports a 1-level
> > > > only IST is not expecting a large number of interrupts).
> > > > 
> > > > On a 2-level IST system, L2 entries are allocated on
> > > > demand.
> > > > 
> > > > The IST table memory is allocated using the kmalloc() interface;
> > > > the allocation required may be smaller than a page and must be
> > > > made up of contiguous physical pages if larger than a page.
> > > > 
> > > > On systems where the IRS is not cache-coherent with the CPUs,
> > > > cache mainteinance operations are executed to clean and
> > > > invalidate the allocated memory to the point of coherency
> > > > making it visible to the IRS components.
> > > > 
> > > > Add an LPI IRQ domain to:
> > > > 
> > > > - Manage LPI state and routing
> > > > - Add LPI IRQchip structure and callbacks
> > > > - LPI domain allocation/de-allocation
> > > > 
> > > > On GICv5 systems, IPIs are implemented using LPIs.
> > > > 
> > > > Implement an IPI-specific IRQ domain created as a child/subdomain
> > > > of the LPI domain to allocate the required number of LPIs needed
> > > > to implement the IPIs.
> > > > 
> > > > Move the arm64 IPI enum declaration to a header file so that the
> > > > GICv5 driver code can detect how many IPIs are required by arch code.
> > > > 
> > > > IPIs are backed by LPIs, add LPIs allocation/de-allocation
> > > > functions.
> > > > 
> > > > The LPI INTID namespace is managed using an IDA to alloc/free LPI
> > > > INTIDs.
> > > > 
> > > > Associate an IPI irqchip with IPI IRQ descriptors to provide
> > > > core code with the irqchip.ipi_send_single() method required
> > > > to raise an IPI.
> > > > 
> > > > Co-developed-by: Sascha Bischoff <sascha.bischoff@arm.com>
> > > > Signed-off-by: Sascha Bischoff <sascha.bischoff@arm.com>
> > > > Co-developed-by: Timothy Hayes <timothy.hayes@arm.com>
> > > > Signed-off-by: Timothy Hayes <timothy.hayes@arm.com>
> > > > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > ---
> > > >  MAINTAINERS                         |    2 +
> > > >  arch/arm64/include/asm/arch_gicv5.h |   91 +++
> > > >  arch/arm64/include/asm/smp.h        |   17 +
> > > >  arch/arm64/kernel/smp.c             |   17 -
> > > >  drivers/irqchip/Kconfig             |    5 +
> > > >  drivers/irqchip/Makefile            |    1 +
> > > >  drivers/irqchip/irq-gic-v5-irs.c    |  841 ++++++++++++++++++++++++++++
> > > >  drivers/irqchip/irq-gic-v5.c        | 1058 +++++++++++++++++++++++++++++++++++
> > > >  drivers/irqchip/irq-gic-v5.h        |  184 ++++++
> > > 
> > > Nit: the split between include/asm/arch_gicv5.h and
> > > drivers/irqchip/irq-gic-v5.h is pretty pointless (this is obviously
> > > inherited from the GICv3 on 32bit setup). Given that GICv5 is strictly
> > > arm64, this split is no longer necessary.
> > 
> > That's true but I thought I would leave sys instructions and barriers
> > in arm64 arch code headers rather than moving them out. I am up for
> > whatever you folks think it is best.
> 
> I can see two options:
> 
> - either you unify the two and place the result in
>   include/linux/irqchip/arm-gic-v5.h
> 
> - or you move the system stuff and the barriers to
>   arch/arm64/include/asm/sysreg.h together with the rest of the pile,
>   *and* move the other include file as above

Probably go for the second option.

> > > > +#define GSB_ACK				__emit_inst(0xd5000000 | sys_insn(1, 0, 12, 0, 1) | 31)
> > > > +#define GSB_SYS				__emit_inst(0xd5000000 | sys_insn(1, 0, 12, 0, 0) | 31)
> > > 
> > > Can you please express this in terms of __SYS_BARRIER_INSN(), with a
> > > slight rework of the SB definition? It would limit the propagation of
> > > the 0xd5 constant and make it clear what 31 stands for.
> > 
> > I tried but the __SYS_BARRIER_INSN() is a different class (GICv5
> > barriers are sys instructions the SB barrier has a slightly different
> > encoding), so maybe something like this ?
> > 
> > #define GSB_ACK __msr_s(sys_insn(1, 0, 12, 0, 1), "xzr")
> 
> Why a different encoding? It looks completely similar to me. What I
> was expecting to see is something along the lines of (completely
> untested):
> 
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index 1ca947d5c9396..7a00781d1d788 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -44,6 +44,8 @@
>  						 SB_BARRIER_INSN"nop\n",	\
>  						 ARM64_HAS_SB))
>  
> +#define gsb_ack()	asm volatile("GSC_ACK_BARRIER_INSN\n" : : : "memory")
> +
>  #ifdef CONFIG_ARM64_PSEUDO_NMI
>  #define pmr_sync()						\
>  	do {							\
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 690b6ebd118f4..a84993c3d117b 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -112,10 +112,13 @@
>  /* Register-based PAN access, for save/restore purposes */
>  #define SYS_PSTATE_PAN			sys_reg(3, 0, 4, 2, 3)
>  
> -#define __SYS_BARRIER_INSN(CRm, op2, Rt) \
> -	__emit_inst(0xd5000000 | sys_insn(0, 3, 3, (CRm), (op2)) | ((Rt) & 0x1f))
> +#define __SYS_BARRIER_INSN(op0, op1, CRn, CRm, op2, Rt)			\
> +	__emit_inst(0xd5000000 |					\
> +		    sys_insn((op0), (op1), (CRn), (CRm), (op2)) |	\
> +		    ((Rt) & 0x1f))
>  
> -#define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 7, 31)
> +#define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 3, 3, 0, 7, 31)
> +#define GSB_ACK_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 1, 31)

Fine by me if that's fine by you, Catalin and Will.

>  
>  /* Data cache zero operations */
>  #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
> 
> and the same thing for GSB SYS.
> 
> > > > +#include "irq-gic-v5.h"
> > > 
> > > Why the ""? The normal include path (linux/irqchip) should work.
> > 
> > irq-gic-v5.h lives in drivers/irqchip, should I move it into
> > include/linux/irqchip (or I am missing something, likely) ?
> > 
> > I did not do it because it is only consumed by files in that directory.
> 
> I full intend for KVM to consume all of this pretty much directly, and
> the KVM code will definitely not live in drivers/irqchip.

Understood but KVM code is not part of this series, we could move it
out of drivers/irqchip when it is needed.

Anyway, this does not matter, I will move it to include/linux/irqchip.

> > > > +	ret = readl_poll_timeout_atomic(reg, tmp, tmp & mask, 1, 10 * USEC_PER_MSEC);
> > > > +
> > > > +	if (val)
> > > > +		*val = tmp;
> > > 
> > > Updating the result value on error is rather odd. Do you rely on this
> > > anywhere? If not, consider avoiding the write-back on timeout.
> > 
> > I do rely on it to avoid reading the register once again on return if
> > the wait succeeded (but we don't know unless for some registers we
> > check another bit in the returned value).
> 
> That's a bit annoying. But hey...
> 
> > > > +	/*
> > > > +	 * The polling wait (in gicv5_wait_for_op()) on a GIC register
> > > > +	 * provides the memory barriers (through MMIO accessors)
> > > > +	 * required to synchronize CPU and GIC access to IST memory.
> > > > +	 */
> > > 
> > > This comment would be better placed with the helper itself, and avoid
> > > the repeats that I can see in the rest of the code.
> > 
> > On this, I thought about that. The problem is, the comment would be
> > buried in a helper function whereas it is in this function that we
> > are actually handing over memory to the GIC so in a way I thought
> > it was more appropriate to add it where the explanation is needed
> > and possibly clearer.
> 
> It's not clearer. If you want it to be clearer, name the helper in a
> way that makes it actions explicit (gicv5_irs_ist_synchronise() ?),
> and let the comment explain how the synchronisation is enforced next
> to the helper.
> 
> Using explicit names is far better than duplicating comments, IMHO.

OK.

> > > > +	list_for_each_entry(irs_data, &irs_nodes, entry) {
> > > > +		if (!irs_data->spi_range)
> > > > +			continue;
> > > > +
> > > > +		min = irs_data->spi_min;
> > > > +		max = irs_data->spi_min + irs_data->spi_range - 1;
> > > > +		if (spi_id >= min && spi_id <= max)
> > > > +			return irs_data;
> > > > +	}
> > > 
> > > Funnily enough, this is exactly the sort of iterative searches the
> > > maple tree could have avoided, by storing INTID (and range) specific
> > > data. Never mind.
> > 
> > I did it with a range store with an Xarray but then removed it because
> > I thought it was overkill, one of those things I am not sure what's
> > best.
> 
> Probably not an issue for now. Time will tell as we get larger
> machines with multiple IRSes.

+1

> > > Just a passing comment: consider splitting this patch in two (IRS on
> > > one side, CPUif on the other). I'm only half-way through, and it's
> > > quite tiring... :-/
> > 
> > Well, on this I am having a hard time as I replied to Thomas as well.
> > 
> > We do need CPUIF + IRS (LPI so IPIs) to make this a functional
> > patch.
> 
> We don't need things to be functional. We need things to not break the
> build. So as long as things are split in a logical way and, this
> should be fine.

That's what I did in v1.

> > If I split per component, this might simplify review (and that's what
> > I did in v1 but Thomas complained that could not find SMP
> > initialization).
> 
> Well, you could have one patch clearly labelled as "SMP init", which
> would both satisfy tglx's requirements *and* my tired brain.

https://lore.kernel.org/lkml/20250408-gicv5-host-v1-21-1f26db465f8d@kernel.org

> > What I could do to reduce the number of lines is moving SPI support
> > in a separate patch but I don't think there is a way to split CPUIF
> > and IRS and have a patch series that is bisectable and works at every
> > stage (by the way the last patch should be merged with this one because
> > technically with this patch we have a working GICv5).
> 
> The trivial way to make it bisectable is to avoid compiling it until
> it is sufficiently feature-complete. Any sizeable amount of new code
> relies on this to a degree or another.
> 
> Also, think of the commit messages: what you have here is a massive
> wall of text that would be more appropriate for a cover letter, and
> could be much smaller on a per-patch basis without losing any
> meaningful content.

Sounds like v1, back to the splitting board.

Thanks,
Lorenzo

