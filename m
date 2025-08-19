Return-Path: <linux-kernel+bounces-775041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4562B2BA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BD73A4469
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312A030F7FC;
	Tue, 19 Aug 2025 07:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="VJyfMOCc"
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE0230DEBB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588048; cv=none; b=HXXiWrX7OmALae7x1Qnui5TbYyaHFgFAhYHhrREIKQ8Zx6rVfL5+vj0iAKYP6+ac2j9mCeljUG2CwoGPKacwH0NmLN6ot3CcHTjEuYSYG3tef2HwCiS2xpDURsIrjCdyHll89ucoG4GdqGtcs6CGurMcCrdKOFbjpDYAXARwZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588048; c=relaxed/simple;
	bh=hEInWWvVuimsSgo00wydCxibxfOgUyiXLzwqsMTbVLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hupDgONIGO8qoHdaMF4cEgGYz43k8FWP7QFEk3zWVjBPtYWdjRvrwSC9W9MfIxxM12CmfxOgzDBhSWiKcs2x6k7Bp97w2aXcxtE3bm2trnByosrnNGYFifMoMNRW+I6Tg/VYzHcm2yH8y4XfLV3xnUSg2AMFsM1Cko3rjr0fyhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=VJyfMOCc; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1755588028;
	bh=1qP799HCzPVRg6CVmxhJ70r3qHFwwlZzjYjvl4iTNhU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=VJyfMOCcDL+nQrcBh3m8Vc617N+ZQmWOtHBvNzFD+SXPrEhlk6upTIHDqPEHAoMtU
	 pcILK5fnX5ykTv0gttmZOU9oPGGR6Cu8rBHbZYZf0fy4SaRCxtS53ftjSI4lMnpC3x
	 ETjJsQyhIUG5kYdZVWGbnrSyIv6bOxVOaHXe87CU=
X-QQ-mid: esmtpgz14t1755588022ted6cad14
X-QQ-Originating-IP: CRVqxCUX8FlZvzrs7fdWOZvzYBV2M4m8nCWB082vSFU=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 19 Aug 2025 15:20:20 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11168661325422464048
EX-QQ-RecipientCnt: 15
Date: Tue, 19 Aug 2025 15:20:20 +0800
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
To: Jimmy Ho <jimmy.ho@sifive.com>, linux-riscv@lists.infradead.org
Cc: troy.mitchell@linux.spacemit.com, ziyao@disroot.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, cyrilbur@tenstorrent.com, cleger@rivosinc.com,
	charlie@rivosinc.com, kees@kernel.org, ben.dooks@codethink.co.uk,
	jszhang@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: fix using wrong load type
Message-ID: <D49B33DEEB859CD5+aKQltEZ8Ef3v6rB9@LT-Guozexi>
References: <20250819071318.21103-1-jimmy.ho@sifive.com>
 <B1669DA80470EE6A+aKQldVbfZ9rnlD9o@LT-Guozexi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B1669DA80470EE6A+aKQldVbfZ9rnlD9o@LT-Guozexi>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: N+xKvJx64zdHyVcpVeC153sbYsokP1LeqKX/tTR5isQz0pgziin2DZ/1
	8QM/tr1/ZC3XODelTtwZJGMOxobyUzm6nOr02PD/2IB3qGi2JgEatyu5QvHgHFraRY5z3R+
	FRTTL30aDAZ3jIaX450CTWg9qJe9bgYKeWkRNgoxxCSSk/YEM8ImeDCC5CHu7jDmMypM9Jn
	QFayOBdxpJ9zrtEKAk+WaXCkjA7wFNEOO++2yCX/JBGJ+0Q1R9JJnySqwweOPMmVqOAaAbe
	wZlzrhVXXgTida7/9VbTShrNddK0UCEX9bAzNdzaxNwZQXuKyANQLuyMMto4cx/ZNhU3Frp
	Q+gRHajS/2nzFIEdm055fhohsHHp7lRwhqXKnNQebV3lZIxFUHHqQ3xg9oQboJbEy/EHvz/
	Ap4dEKtAv5Eh1WzjVjOQYLZp20jStmP0ZHO88+mhRelbFBZbcUT+poubGSdbs/hVeur5o7d
	wIY5RyAY01FipdQahXfQWtcYahN4VBOeH8EHjv2Ue/zD71ITGgId5/8wfqHIuED6KX325o0
	dz4YKWHH5fczUcxEVPbQnukmA6IRF3/vhtypt6HIUsoCNFmAutE026i7e9NirhZ5Mqx4qSI
	3T8awD9Oi83leRfZTJJD9m4+/6+t8DQ7q8ytZ9n2rCHmWPn8rNxkOzDFYhpIrl38oMd/Vmm
	nG0bqh9Ac/pKLN68uZgnHhk2W8Zu7EDz5dGDO0kWa5TxjmicvRs0R8e2n4+6jxikEzKtmal
	7uM48wyz1mH2/WNmImYzTHbSS9qTDjFERgyrmFwWrSdPHFFstY3DizrE4JXs+HS4m5cGLMg
	m6vRQR2k9VXTWSN1N1zmfgXsieF++Jph1BN4F9yj+yv8nav6nyVGV+kF2EXO2XJpaHsLyts
	gsEYA3u4PubSCJixTwRBqpaNxd9vb3roIXb6RlBPLorBHpseBUEjNr668PgadvvSiPofQa6
	9g6PhP0ghzoQmF+SNezKa08I7iLSdfmq943JXL2lGmYnT467g9+rgZsaOkD3nWITM+63Njh
	lkpeA2GaPynP8U39yLujOKQBWOLthI8wAyCzACCLWdmRrtJ+wHDtAmg2AyuuwEwj6Be+yk3
	uOj+2a1bHpkG0aO9KPzDwzmNgBxbyz6tTXEcQAkmhOnTsjboOxXSRWkvms6zUQh78XS1V9x
	e2SA
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Tue, Aug 19, 2025 at 03:19:17PM +0800, Troy Mitchell wrote:
> On Tue, Aug 19, 2025 at 03:13:18PM +0800, Jimmy Ho wrote:
> > thread_info.cpu field is 32 bits wide,
> > but is accessed using an XLEN-bit load, which might be 64bit load, fix it
> > 
> > Changes in v3:
> > - replace space with tab to keep it aligned with code block
> > - Add "Fixes" tag
> Please add previous version link.
> 
> > 
> > Changes in v2:
> > - add a comment to explain why use lw instead of REG_L.
> > - correct commit message
> ditto.
> 
> Additionally, I see a patch here that serves the same purpose as yours,
Sry I forgot to put link:
https://lore.kernel.org/all/20250722160556.2216925-4-rkrcmar@ventanamicro.com/

                 - Troy

> but it's more comprehensive and was submitted earlier.
> 
> In any case, if you'd like to proceed, here is the:
> Acked-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> > 
> > Fixes: 503638e0babf3 ("riscv: Stop emitting preventive sfence.vma for new vmalloc mappings")
> > Signed-off-by: Jimmy Ho <jimmy.ho@sifive.com>
> > ---
> >  arch/riscv/kernel/entry.S | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index 3a0ec6fd5956..492ae936dccd 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -45,8 +45,10 @@
> >  	 * Computes:
> >  	 * a0 = &new_vmalloc[BIT_WORD(cpu)]
> >  	 * a1 = BIT_MASK(cpu)
> > +	 * 
> > +	 * using lw instead of REG_L is because the thread_info.cpu field is 32 bits wide
> >  	 */
> > -	REG_L 	a2, TASK_TI_CPU(tp)
> > +	lw	a2, TASK_TI_CPU(tp)
> >  	/*
> >  	 * Compute the new_vmalloc element position:
> >  	 * (cpu / 64) * 8 = (cpu >> 6) << 3
> > -- 
> > 2.39.3
> > 
> > 

