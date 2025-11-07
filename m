Return-Path: <linux-kernel+bounces-890836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A145C41230
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 18:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6215618847DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EDA3370E1;
	Fri,  7 Nov 2025 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPyiuHMe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35528258CE7;
	Fri,  7 Nov 2025 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537460; cv=none; b=oOZQlURu2Cl3V8TvJr4LBcPfth3JQ90HNqte6AkNqJtB3FnGe3wBZCpknL9fRFQORTKPCx4HRLp/SbGcWz2hBtBXkfKqY14Jb85m1QOENKe2RYHUtd1ZG3cqQRtYtiDwBksTsxcWCOgz51xj84+gX8aA5DzyelHZBsES1P+OBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537460; c=relaxed/simple;
	bh=vUXVxSlqnlNC2tbqdDtNDX2ebfN1pxrOSHo7fEAw12Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaApRAzSSxEhrsL1q+U+X+LEa25xMlIfYK+o7KGgTh7WS8VLCXzlqP4GcRWnRgAi+PGsTn2vDZKCtWmaGgch977J4Q/nQCDil8TOmeAcoJT1ROKXmqcGF4GWo6++FuKKdgFRjx5JOFZBHQASm2J08/FjWJBaepyq37TMzyMJefQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPyiuHMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C74EC4CEF8;
	Fri,  7 Nov 2025 17:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762537459;
	bh=vUXVxSlqnlNC2tbqdDtNDX2ebfN1pxrOSHo7fEAw12Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nPyiuHMehYfo3g71SbYqe2NgLFsFFVMXj4vT7odT8obZ75hR69ps6sjFs7W80FROW
	 hsZ6pFPi88FRX2UD5Cm6+HC771R2+6brdPgwss1tTPliJYG2gsSBF458IPzk2biX4F
	 RNucbaE7viPNG0fA44kswLaF1vDw1xdcVm24mb9XAzFuUudPzZP2zjF7PkN8uRFPi3
	 v/mOgSdMqYEV8CsIQEdTu+nRG2wJjym0S+q1IPuIpdL1evYiCtDNkU1SRaMYdZVVx9
	 XorcU2JIf9Jvp9EVNM6QQghP36vq0hw9+ssncfOeRNtG4AI3En7iA7OjYAWpfAG3M0
	 mh5MCTsRK1scA==
Date: Fri, 7 Nov 2025 09:44:17 -0800
From: Drew Fustini <fustini@kernel.org>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	James Morse <james.morse@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v4 3/3] RISC-V: Add support for srmcfg CSR from Ssqosid
 ext
Message-ID: <aQ4v8QhQjRYrxNK3@x1>
References: <20251007-ssqosid-v4-0-e8b57e59d812@kernel.org>
 <20251007-ssqosid-v4-3-e8b57e59d812@kernel.org>
 <DDDL94HT7HYF.3VU2WQYU4WZY5@ventanamicro.com>
 <aOqjggmTr4ioHwB/@x1>
 <DDH2Q0N2HLKF.2QSW4DB5FTJI6@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DDH2Q0N2HLKF.2QSW4DB5FTJI6@ventanamicro.com>

On Mon, Oct 13, 2025 at 11:06:50AM +0200, Radim Krčmář wrote:
> 2025-10-11T11:35:46-07:00, Drew Fustini <fustini@kernel.org>:
> > On Thu, Oct 09, 2025 at 08:47:27AM +0200, Radim Krčmář wrote:
> >> 2025-10-07T23:21:12-07:00, Drew Fustini <fustini@kernel.org>:
> >> > diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
> >> > +static inline void __switch_to_srmcfg(struct task_struct *next)
> >> > +{
> >> > +	u32 *cpu_srmcfg_ptr = this_cpu_ptr(&cpu_srmcfg);
> >> > +	u32 thread_srmcfg;
> >> > +
> >> > +	thread_srmcfg = READ_ONCE(next->thread.srmcfg);
> >> > +
> >> > +	if (thread_srmcfg != *cpu_srmcfg_ptr) {
> >> 
> >> Wouldn't prev->thread.srmcfg have the value of CSR_SRMCFG when executing
> >> switch_to?
> >
> > Thanks for reviewing. Yes, you are right that prev->thread.srmcfg should
> > have same value as CSR_SRMCFG. Are you suggesting that the cpu_srmcfg is
> > not necessary as prev->thread.srmcfg should have same value?
> 
> Yes, it would be more consistent with other context switched state.
> I just wasn't sure if srmcfg doesn't have special race conditions.

I did some testing and the per-cpu cache of CSR_SRMCFG is needed. This
is because thread.srmcfg is changed asynchronously from when CSR_SRMCFG
is updated in __switch_to_srmcfg.

The srmcfg value for a thread is updated when a user writes the pid to a
control group's tasks file in the resctrl virtual filesystem:

void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
{
       u32 srmcfg;

       WARN_ON_ONCE((closid & SRMCFG_RCID_MASK) != closid);
       WARN_ON_ONCE((rmid & SRMCFG_MCID_MASK) != rmid);

       srmcfg = rmid << SRMCFG_MCID_SHIFT;
       srmcfg |= closid;
       WRITE_ONCE(tsk->thread.srmcfg, srmcfg);
}

I'm getting a full patch series ready that has both the Ssqosid and the
CBQRI resctrl patches, and I will post that soon. I'm also preparing
a freshly rebased Qemu series that adds the CBQRI controllers.

Thanks,
Drew

