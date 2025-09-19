Return-Path: <linux-kernel+bounces-824421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E601FB892A9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBC941BC7698
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB7630AD09;
	Fri, 19 Sep 2025 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUoVKEGc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3E19755B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279557; cv=none; b=MohTt1KqicKxqIwZMMQFvBbRaixACUB/6wK3xrlIpYBbMaR4xkCPeUEUOWzWyJZrzHZNYAbqWfVnxokF3xoewZwZuhGoMsV/PkpbGkK+6GM3CcgxGmLrBJ/Hsk/EYdIooL6Wk8ud2H5kK1yVsggNDJaDJGVcLVue5WJmPflxOH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279557; c=relaxed/simple;
	bh=hsmmEYu19Jrlfnz1Q6U31avR4m1JeXoyCSE/cjj2idA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjdSIwsTEd57/dutwrP5YajFEuqjr313Gvbw16y4oUM9T/Oc0F/aZdkX5Wx5WY21BbgMu5Kg3LOpXfzR3s17sS5ftszHu5+HeuRDAtFBtQVAkm/yMiipmFS5zqQ7vlOiBfjVZyV4CBBkXxGVboqbHYahEcTuIfuSuUMc89RkJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUoVKEGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66191C4CEF1;
	Fri, 19 Sep 2025 10:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758279556;
	bh=hsmmEYu19Jrlfnz1Q6U31avR4m1JeXoyCSE/cjj2idA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUoVKEGcgz+UAX65NrdVNu00zw97SPOvUWp03D4jjO8uihmoVUxNGS44yErkvBAAK
	 5d6xKd/lL6LbPczRn/qbdiwUB+rSB9SPTHjP8gWhmIoHo8BjlR4/brPB6pGZRjfT2l
	 6BKf9SuQ35rS1hS+qK4hBlghbmtp6gcC6Rmn0bub8qGLijwfZF/Tt/Zcj6M/z3evt5
	 zyXrYBYWh3frzJG30OBpqGbqo1sddGAl5kIfdxyfu2hXBibHtT3F48XRH/krKhS0tx
	 FJtAZzbSCllnHGmxGJE02rGu+xvUoP3YBNYviAKAUCN8qP3tTT63OHZKXyhXtAIbfE
	 1ycyIX1w9H9lQ==
Date: Fri, 19 Sep 2025 11:59:10 +0100
From: Will Deacon <will@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: catalin.marinas@arm.com, anshuman.khandual@arm.com,
	quic_zhenhuah@quicinc.com, ryan.roberts@arm.com,
	kevin.brodsky@arm.com, yangyicong@hisilicon.com, joey.gouly@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	david@redhat.com, mark.rutland@arm.com, urezki@gmail.com,
	jthoughton@google.com
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
Message-ID: <aM0yQwt3_8WuxBC2@willie-the-truck>
References: <20250723161827.15802-1-dev.jain@arm.com>
 <aMk8QhkumtEoPVTh@willie-the-truck>
 <aMrXBArFNLTdwWs3@willie-the-truck>
 <839ac455-f954-428f-b1a7-89778c57ee8b@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <839ac455-f954-428f-b1a7-89778c57ee8b@arm.com>

On Fri, Sep 19, 2025 at 03:58:46PM +0530, Dev Jain wrote:
> 
> On 17/09/25 9:13 pm, Will Deacon wrote:
> > On Tue, Sep 16, 2025 at 11:30:26AM +0100, Will Deacon wrote:
> > > I'm currently trying to put together a litmus test with James (cc'd) so
> > > maybe we can help you out with that part.
> > Here's what we came up with. There's not a good way to express the IPI
> > from kick_all_cpus_sync() but it turns out that the ISB from the TLB
> > invalidation is sufficient anyway. Does it make sense to you?
> > 
> > 
> > AArch64 ptdump
> > Variant=Ifetch
> > {
> > uint64_t pud=0xa110c;
> > uint64_t pmd;
> > 
> > 0:X0=label:"P1:L0"; 0:X1=instr:"NOP"; 0:X2=lock; 0:X3=pud; 0:X4=pmd;
> >                      1:X1=0xdead;      1:X2=lock; 1:X3=pud; 1:X4=pmd;
> > }
> >   P0				| P1				;
> >   (* static_key_enable *)	| (* pud_free_pmd_page *)	;
> >   STR	W1, [X0]		| LDR	X9, [X3]		;
> >   DC	CVAU,X0			| STR	XZR, [X3]		;
> >   DSB	ISH			| DSB	ISH			;
> >   IC	IVAU,X0			| ISB				;
> >   DSB	ISH			|				;
> >   ISB				| (* static key *)		;
> > 				| L0:				;
> >   (* mmap_lock *)		| B	out1			;
> >   Lwlock:			|				;
> >   MOV	W7, #1			| (* mmap_lock *)		;
> >   SWPA	W7, W8, [X2]		| Lrlock:			;
> > 				| MOV	W7, #1			;
> > 				| SWPA	W7, W8, [X2]		;
> >   (* walk pgtable *)		|				;
> >   LDR	X9, [X3]		| (* mmap_unlock *)		;
> >   CBZ	X9, out0		| STLR	WZR, [X2]		;
> >   EOR	X10, X9, X9		|				;
> >   LDR	X11, [X4, X10]		| out1:				;
> > 				| EOR	X10, X9, X9		;
> >   out0:				| STR	X1, [X4, X10]		;
> > 
> > exists (0:X8=0 /\ 1:X8=0 /\	(* Lock acquisitions succeed *)
> > 	0:X9=0xa110c /\		(* P0 sees the valid PUD ...*)
> > 	0:X11=0xdead)		(* ... but the freed PMD *)
> > 
> > 
> > Will
> 
> Is the syntax correct? I cannot use the herd7 command to run this.

Weird, what happens? It runs for me:

$ herd7 -version
7.58+1, Rev: e39a86f5d59dee3174d08d9ab5b13155c75936fd

$ herd7 ptdump.litmus
Test ptdump Allowed
States 5
0:X8=0; 0:X9=0; 0:X11=0; 1:X8=0;
0:X8=0; 0:X9=0; 0:X11=0; 1:X8=1;
0:X8=0; 0:X9=659724; 0:X11=0; 1:X8=1;
0:X8=0; 0:X9=659724; 0:X11=57005; 1:X8=1;
0:X8=1; 0:X9=0; 0:X11=0; 1:X8=0;
No
Witnesses
Positive: 0 Negative: 9
Flag Assuming-common-inner-shareable-domain
Condition exists (0:X8=0 /\ 1:X8=0 /\ 0:X9=659724 /\ 0:X11=57005)
Observation ptdump Never 0 9
Time ptdump 1.65
Hash=238908ee9413a36507c61b92a31a366a

Will

