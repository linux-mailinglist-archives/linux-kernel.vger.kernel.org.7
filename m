Return-Path: <linux-kernel+bounces-831103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BFDB9B8BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A261BC1C44
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BFC3064A0;
	Wed, 24 Sep 2025 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LZR+Ulfz"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8400313D72
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739325; cv=none; b=rDRKtwIhxq1mVBYR1gz8q/bTz6QZwdLcdwgx/1AWad8jDCEaX3xX0KaKqqo0IghNGRs6NSMTvY1O63Q0o7G4GDPYsEO8QQthE11OA2H7W9GuWZVMN4e/gdI2W7IKwMU8Ea+JpDWCIPFCMjYGfEGRn43GUTMwc7rZqJWE7/5IsF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739325; c=relaxed/simple;
	bh=QlAfzwYudRHesOZoA0cxTGtSQ8bsNVkEIUREwZTUKXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuyONNZdFhyiKQ+c4IDLGUnBhv7dgUsWiRrIC8xwBmhXAF1Aq3oZjA8huqNEKGjFIRJW4O5l5jnH+/vz4WM1c2uqjADQpjomZv83JMjNJMh50YMR2lEL34VX6+121uvK7RwlOYthzxkTOnCaghqiHBucYEvKiWufs3WGGa61cD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LZR+Ulfz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ff9PWlpoEgGNmgBhVmVmUyMch2yLaudF062SSixoSks=; b=LZR+UlfzupKLTgs0xTw/aVPflV
	H6aqUF06QzDfU78BAMXLTFRLvy8MeX0dhxXeZ41le5CQuM3lkY58E0tyt6ER9xh7Va8Jd9JKojhCQ
	lpFMBkamqR2A7stIUXM4dFYevlqsYGkpiBhBT7Gqn1JYeLhpoLS40bijJm7xhbeJp1AdUjrHf1cpQ
	X9vMaqcBkOyZWjpYJo3At52mUOL23dKJE1yr6bYswvU6T41TRyzfiRqnnjzUb63Gw3VbVxt3QslPq
	fHcyA7WUqU/3SgHCh0o17HMRbGOimMpYqcXb4N4BcTJngbYfGT3nxGPGiyZ4ciFMU4QVN2WiUadYK
	8HFdnoqQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1URD-00000008oEH-3Q42;
	Wed, 24 Sep 2025 18:42:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC1EB30043D; Wed, 24 Sep 2025 20:41:58 +0200 (CEST)
Date: Wed, 24 Sep 2025 20:41:58 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: jpoimboe@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] objtool/x86: Fix NOP decode
Message-ID: <20250924184158.GZ3245006@noisy.programming.kicks-ass.net>
References: <20250924134507.288529132@infradead.org>
 <20250924134644.154610650@infradead.org>
 <b6aaa53d-2658-491a-9308-32ae2b5aefb1@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6aaa53d-2658-491a-9308-32ae2b5aefb1@oracle.com>

On Wed, Sep 24, 2025 at 07:34:00PM +0200, Alexandre Chartre wrote:
> 
> On 9/24/25 15:45, Peter Zijlstra wrote:
> > For x86_64 the kernel consistently uses 2 instructions for all NOPs:
> > 
> >    90       - NOP
> >    0f 1f /0 - NOPL
> > 
> > 
> > Notably:
> > 
> >   - REP NOP is PAUSE, not a NOP instruction.
> > 
> >   - 0f {0c...0f} is reserved space,
> >     except for 0f 0d /1, which is PREFETCHW, not a NOP.
> > 
> >   - 0f {19,1c...1f} is reserved space,
> >     except for 0f 1f /0, which is NOPL.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >   tools/objtool/arch/x86/decode.c |   12 +++++++-----
> >   1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > --- a/tools/objtool/arch/x86/decode.c
> > +++ b/tools/objtool/arch/x86/decode.c
> > @@ -494,7 +494,8 @@ int arch_decode_instruction(struct objto
> >   		break;
> >   	case 0x90:
> > +		if (prefix != 0xf3) /* REP NOP := PAUSE */
> > +			insn->type = INSN_NOP;
> >   		break;
> 
> So this covers NOP1 (0x90) and NOP2 (0x66 0x90), right?

Yes. Everything with opcode 0x90, except 0xf3 0x90, which as stated is
PAUSE.

> >   	case 0x9c:
> > @@ -547,13 +548,14 @@ int arch_decode_instruction(struct objto
> >   		} else if (op2 == 0x0b || op2 == 0xb9) {
> > +			/* ud2, ud1 */
> >   			insn->type = INSN_BUG;
> > +		} else if (op2 == 0x1f) {
> > +			/* 0f 1f /0 := NOPL */
> > +			if (modrm_reg == 0)
> > +				insn->type = INSN_NOP;
> >   		} else if (op2 == 0x1e) {
> 
> And this covers all other NOPs (0x0f 0x1f ...), including NOP6 which has
> a 0x66 preifx (0x66 0xf 0x1f ...) ?

Sorta, it accepts everything with opcode 0f 1f and modrm_reg==0, which is
how NOPL is encoded.

Both: 66 66 66 66 66 66 66 66 66 66 66 66 66 66 90 (NOP15)
And:  66 66 66 66 66 66 66 0f 1f 84 00 00 00 00 00 (NOP15)

will be accepted here as max length instructions. The kernel will not
actually use those, since a bunch of micro archs have decode penalties
for too many prefixes.

> From arch/x86/include/asm/nops.h we have:

You're looking at old code :-)

> /*
>  * Generic 64bit nops from GAS:
>  *
>  * 1: nop
>  * 2: osp nop
>  * 3: nopl (%eax)
>  * 4: nopl 0x00(%eax)
>  * 5: nopl 0x00(%eax,%eax,1)
>  * 6: osp nopl 0x00(%eax,%eax,1)
>  * 7: nopl 0x00000000(%eax)
>  * 8: nopl 0x00000000(%eax,%eax,1)

 * 9: cs nopl 0x00000000(%eax,%eax,1)
 * 10: osp cs nopl 0x00000000(%eax,%eax,1)
 * 11: osp osp cs nopl 0x00000000(%eax,%eax,1)

>  */
> #define BYTES_NOP1      0x90
> #define BYTES_NOP2      0x66,BYTES_NOP1
> #define BYTES_NOP3      0x0f,0x1f,0x00
> #define BYTES_NOP4      0x0f,0x1f,0x40,0x00
> #define BYTES_NOP5      0x0f,0x1f,0x44,0x00,0x00
> #define BYTES_NOP6      0x66,BYTES_NOP5
> #define BYTES_NOP7      0x0f,0x1f,0x80,0x00,0x00,0x00,0x00
> #define BYTES_NOP8      0x0f,0x1f,0x84,0x00,0x00,0x00,0x00,0x00

#define BYTES_NOP9      0x2e,BYTES_NOP8
#define BYTES_NOP10     0x66,BYTES_NOP9
#define BYTES_NOP11     0x66,BYTES_NOP10

But yes, first two are NOP and then it switches to NOPL for 3 bytes and
longer (2 opcode, 1 modrm). Where for 11 bytes we have:

 - 3 prefixes
 - 2 opcode
 - 1 modrm
 - 1 sib
 - 4 displacement


