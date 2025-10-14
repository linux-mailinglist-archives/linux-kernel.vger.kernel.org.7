Return-Path: <linux-kernel+bounces-851721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48523BD7225
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7831134DB24
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188CC3054FA;
	Tue, 14 Oct 2025 03:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opnsrc.net header.i=@opnsrc.net header.b="LF/xrn8Y"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FEC1E990E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760410979; cv=none; b=j3obAML3EwZbrA5qeq6xg0005eTyA4+x/UNrN+UWWINDirvsr8XdexWX0mevBmzEggRE9v5T70xn3+AQN6wxt9SVOAPrnVRUcNw61UzmOwPgaKg1ZakJ1Aw+nDcYB/Pla+ozGSFTUfsCIDSbZDtmrxh1NnR4cxMYGgzV9xTHtPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760410979; c=relaxed/simple;
	bh=J2+vB/o5Z0HvxSwF1pxo/ZbmkiIAbTdDIfPLcr8sr0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aC7NgKdL3WwmoI+ZzVblfjcz3ep3wwZ8AJebx9OGfTmroue8etJkSwl/1hVC64rZT0CsNbvKYhYAU2yEfplYWV7BWKSi/VwreUH+UL2Auk1u6bkOkNYrfm/yg2cCyP/YK7yl/cQjB5jOL6fnqt48dRoVDjta8Mv/0HcKY+liDTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=opnsrc.net; spf=pass smtp.mailfrom=opnsrc.net; dkim=pass (2048-bit key) header.d=opnsrc.net header.i=@opnsrc.net header.b=LF/xrn8Y; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=opnsrc.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opnsrc.net
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3544c64380eso6166752fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=opnsrc.net; s=google; t=1760410976; x=1761015776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2+vB/o5Z0HvxSwF1pxo/ZbmkiIAbTdDIfPLcr8sr0E=;
        b=LF/xrn8YGpeGM6ubFARCXEktdLu9JQx8nTwdfDPj0lLnPdqsYJ1bhVBV8A6M7EIWgd
         5p6myh+nWTX1JdS7H3nVGk4Twv6aX+A2x+UF6Z7WUda7Q0RoXTzMqk9+X6njfUO7GrIb
         9smFFLS/s91OYZNr6WMJcwxu6BigV73wWlhyFqIkPVQgqE7XDpvPmUcOWng+dMJRstMh
         GIp7THCzR5N/dbTbTzGeNPnWvGH3KGo1Sn4w1GxbPZyKMh5K1dINoJ+eRgT24nXFxIms
         s2qu/pmkW+videbJAMEpz+0U7WN+xDGO5yOYRTz1Un/A3cyWkMwz03vt4J2y1FKPNy4h
         KH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760410976; x=1761015776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2+vB/o5Z0HvxSwF1pxo/ZbmkiIAbTdDIfPLcr8sr0E=;
        b=AgAlskHo1Edo2AsD40fpYaLpXmXLTf13Em3Kycbf4YUG/n9RXKU76yil8D7ot8RyaT
         yMJV1JstZ6OxPJxKzfAfAEZPTeCiK+8eTIdDS8m3H2Tvd1E+44fZrawXKXXok20CLBFa
         j1NOXkbJx5PIqWGWEk+qTYEBrOixi2+5vHVdbzVzSsTXTHTP/A4bzWvMTYu6yy0plI7p
         6GBB7EKU2uSxBpPGd0mKESEoetrusY50BUJPUXGtMf7eUG+fJx4v69q9ggpBBm34yDXD
         ceMXULiHR+jL6+MIPa71W19flehyGXxXhqlUElVbHf3M0/y/zP96Q8mNAQ/LB4pRcZJc
         6rWg==
X-Forwarded-Encrypted: i=1; AJvYcCWLM8VpZaje/KNZ8XBpdkZO8nccB5cgwEbpgycrBnV0Igm8hP/czxIY81RlP5QVO2eEskL7cYvQwqs8+tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSGogTL0cAzQovmgPeaECR35L/BFRuoQHFm8HNaMD4ZtPfIy+c
	/PYQbMpyBMfsf3o/d+dgrQw9mfA2ByvnvzQnoPOkzg6JYfKYZgLm0WnWKkykwa7/KcTknIAf6G9
	Wooz00VA+crB3dS1piQgu8CT5nJ3Y4iOvUl19YFhH8w==
X-Gm-Gg: ASbGncs3KUmtFsVF8a64Pdxu6RCUN5ISYahahfGYJRjfyHrceH0MmgKPjq8IlSOEiUH
	gOpmLFVaO04WW5XmxRdCrXkrr7RM1I5ERv5Uf8LDC1ed0PYwbSNft21BCV9YvjL3FE7KqF6hWfo
	NctvhlJhTD4Tm4vtokPDRJnmhSPfd9sd/BxbLcFdTlb33QDY7RKqd6ZV96p/hT1D8v6J04/ubwb
	pZBdaHZLoDnv5vxqTdlDnjZXIQnbvLFBxCBrOFT4HkFrIamYNYJJZoyzhAem7EuRW4bXLdRDjIr
	WfM310MH5XKF1zpk1uDBl6Ok1UBS
X-Google-Smtp-Source: AGHT+IFuo9BWRk6hYpcALRtWhZkhOZuiJf6QVGwEIxc2I01tkH6J6hjL6coCCzYE7o+uwNX4Z00eSk3vCmxMBTvNOjk=
X-Received: by 2002:a05:6870:e38b:b0:322:2712:c89d with SMTP id
 586e51a60fabf-3c0f66f6f29mr9665301fac.11.1760410975986; Mon, 13 Oct 2025
 20:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008201955.3919537-1-salil.mehta@opnsrc.net>
 <86v7koxk1z.wl-maz@kernel.org> <CAFEAcA8=yhQ-ygoA-fqxzwg69OkdW2nBM0O9X3Lmww4eXuVMWA@mail.gmail.com>
 <867bwzxe9r.wl-maz@kernel.org> <CAFEAcA8FhgcaM_OsHKB3+3Z7B_oZJqU4LHX_j9p-ZQrHfWGX7g@mail.gmail.com>
In-Reply-To: <CAFEAcA8FhgcaM_OsHKB3+3Z7B_oZJqU4LHX_j9p-ZQrHfWGX7g@mail.gmail.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Tue, 14 Oct 2025 03:02:44 +0000
X-Gm-Features: AS18NWCHVyfmTyyU2mlQmmXG_PQvjHWpMLxJ42vucNDZHSZthXnK7-j7Wv1f-mw
Message-ID: <CAJ7pxebGOj5Z1iW6VPjzj73eY1hZFjS5uXMkee8XCm09DtFcKQ@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: arm64: vgic-v3: Cache ICC_CTLR_EL1 and allow
 lockless read when ready
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
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
Content-Transfer-Encoding: quoted-printable

Hi Peter

On Mon, Oct 13, 2025 at 4:48=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
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
> > > > > Userspace reads of ICC_CTLR_EL1 via KVM device attributes current=
ly takes a slow
> > > > > path that may acquire all vCPU locks. Under workloads that exerci=
se userspace
> > > > > PSCI CPU_ON flows or frequent vCPU resets, this can cause vCPU lo=
ck contention
> > > > > in KVM and, in the worst cases, -EBUSY returns to userspace.
> > > > >
> > > > > When PSCI CPU_ON and CPU_OFF calls are handled entirely in KVM, t=
hese operations
> > > > > are executed under KVM vCPU locks in the host kernel (EL1) and ap=
pear atomic to
> > > > > other vCPU threads. In this context, system register accesses are=
 serialized
> > > > > under KVM vCPU locks, ensuring atomicity with respect to other vC=
PUs. After
> > > > > SMCCC filtering was introduced, PSCI CPU_ON and CPU_OFF calls can=
 now exit to
> > > > > userspace (QEMU). During the handling of PSCI CPU_ON call in user=
space, a
> > > > > cpu_reset() is exerted which reads ICC_CTLR_EL1 through KVM devic=
e attribute
> > > > > IOCTLs. To avoid transient inconsistency and -EBUSY errors, QEMU =
is forced to
> > > > > pause all vCPUs before issuing these IOCTLs.
> > > >
> > > > I'm going to repeat in public what I already said in private.
> > > >
> > > > Why does QEMU need to know this? I don't see how this is related to
> > > > PSCI, and outside of save/restore, there is no reason why QEMU shou=
ld
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
>
> That would bring ICC_CTLR_EL1 into line with the other cpuif
> registers, where QEMU assumes it knows what the kernel's
> reset value of them is (mostly "0") and doesn't bother to ask.
> This is different from how we handle ONE_REG sysregs, where
> I'm pretty sure we do ask the kernel the value of all of them
> on a vcpu reset. (And then write the values back again, which
> is a bit silly but nobody's ever said it was a performance
> problem for them :-))


This is effectively what the mentioned patch in the commit-log is doing.
Pasting here again:

https://lore.kernel.org/qemu-devel/20251001010127.3092631-22-salil.mehta@op=
nsrc.net/

Can this patch be accepted independently then?


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
>
> (Also, if the kernel had failed EINVAL unconditionally for
> an attempt to do this on a not-stopped VM then we'd probably
> have found this mismatch in understanding about how the
> API should work years ago. "Mostly works but sometimes fails
> EBUSY" is the worst of all worlds.)
>
> I haven't yet got as far as thinking about the KVM interface
> for GICv5 yet...
>
> -- PMM

