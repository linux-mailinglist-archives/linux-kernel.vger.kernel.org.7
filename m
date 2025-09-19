Return-Path: <linux-kernel+bounces-824516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B41C1B89715
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A101C230C3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACDE2FFDDB;
	Fri, 19 Sep 2025 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXOfoDEC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683971E520F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284822; cv=none; b=RMMVKjUv3o385Ss0eMjbFwScUIAK28/zbV/FDQF9XmbSbdk8xq+s7080AwOFaoYuJ5acjDREiafhiaG1m89ece/6QbwmkkTj7dh5klIqgZmVGxtOs33lJr0UmPnjOSvFhvZWSjO708kmumCawKhb+k0WiwZZZdlkKC8TbhlkFpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284822; c=relaxed/simple;
	bh=xvXVACMtVmjwR/uF2cNi1EvWp8KFjthvH+n7UtD4Q0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbQWLsliLa/5WULraMOXgeuNOWdc+9dzOZnorg3QrHZx+5DOYYOBgNvOWwkWrUbmEe7JIivImAxVpjwoTmTsSWt/eX5Ew/nWbwZdAw64iuVojQJWCD/kQZKtcRf6HeQm29PTJ6QMy818xs749ZWsKS7UanVhqlPJSyC532e4Acc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXOfoDEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE08C4CEF0;
	Fri, 19 Sep 2025 12:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758284822;
	bh=xvXVACMtVmjwR/uF2cNi1EvWp8KFjthvH+n7UtD4Q0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXOfoDECzJmSR0aLrQkfmubtR60hT208P4kJQ3WoagY6awJl/5QFfJ605CNITy/nj
	 SU0KW2rbTGV59kC+5sllteeYDojIrvN9t/1UxOrKikovz1scgDqvOeATzE+8nb4LCi
	 hMrH+xzoGbM2I2CaiLq2GOzmuxw/cOpgm7vvTb6r+4Vxo0fbcGYDBnJOJKHgW9m/9u
	 dcQ6nLd8zESiZOgXgkz+P4rwaUCx5ttOl9OFMJTyTUyplQpUZMKkJbdDF0IVw124yA
	 3e4uB3raA1Yc1u9CIq2bWDbfy1zGUZNOE2uDA3kCwZCArfSvWqf8+4QAQpU7RBTvlT
	 o+9z1eomYSTOw==
Date: Fri, 19 Sep 2025 13:26:56 +0100
From: Will Deacon <will@kernel.org>
To: Dev Jain <dev.jain@arm.com>
Cc: catalin.marinas@arm.com, anshuman.khandual@arm.com,
	quic_zhenhuah@quicinc.com, ryan.roberts@arm.com,
	kevin.brodsky@arm.com, yangyicong@hisilicon.com, joey.gouly@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	david@redhat.com, mark.rutland@arm.com, urezki@gmail.com,
	jthoughton@google.com
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
Message-ID: <aM1MEF3pANiL3p2Z@willie-the-truck>
References: <20250723161827.15802-1-dev.jain@arm.com>
 <aMk8QhkumtEoPVTh@willie-the-truck>
 <aMrXBArFNLTdwWs3@willie-the-truck>
 <839ac455-f954-428f-b1a7-89778c57ee8b@arm.com>
 <aM0yQwt3_8WuxBC2@willie-the-truck>
 <b93b0cca-04ac-402c-b522-cda8f39a52bc@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b93b0cca-04ac-402c-b522-cda8f39a52bc@arm.com>

On Fri, Sep 19, 2025 at 05:44:52PM +0530, Dev Jain wrote:
> 
> On 19/09/25 4:29 pm, Will Deacon wrote:
> > On Fri, Sep 19, 2025 at 03:58:46PM +0530, Dev Jain wrote:
> > > On 17/09/25 9:13 pm, Will Deacon wrote:
> > > > On Tue, Sep 16, 2025 at 11:30:26AM +0100, Will Deacon wrote:
> > > > > I'm currently trying to put together a litmus test with James (cc'd) so
> > > > > maybe we can help you out with that part.
> > > > Here's what we came up with. There's not a good way to express the IPI
> > > > from kick_all_cpus_sync() but it turns out that the ISB from the TLB
> > > > invalidation is sufficient anyway. Does it make sense to you?
> > > > 
> > > > 
> > > > AArch64 ptdump
> > > > Variant=Ifetch
> > > > {
> > > > uint64_t pud=0xa110c;
> > > > uint64_t pmd;
> > > > 
> > > > 0:X0=label:"P1:L0"; 0:X1=instr:"NOP"; 0:X2=lock; 0:X3=pud; 0:X4=pmd;
> > > >                       1:X1=0xdead;      1:X2=lock; 1:X3=pud; 1:X4=pmd;
> > > > }
> > > >    P0				| P1				;
> > > >    (* static_key_enable *)	| (* pud_free_pmd_page *)	;
> > > >    STR	W1, [X0]		| LDR	X9, [X3]		;
> > > >    DC	CVAU,X0			| STR	XZR, [X3]		;
> > > >    DSB	ISH			| DSB	ISH			;
> > > >    IC	IVAU,X0			| ISB				;
> > > >    DSB	ISH			|				;
> > > >    ISB				| (* static key *)		;
> > > > 				| L0:				;
> > > >    (* mmap_lock *)		| B	out1			;
> > > >    Lwlock:			|				;
> > > >    MOV	W7, #1			| (* mmap_lock *)		;
> > > >    SWPA	W7, W8, [X2]		| Lrlock:			;
> > > > 				| MOV	W7, #1			;
> > > > 				| SWPA	W7, W8, [X2]		;
> > > >    (* walk pgtable *)		|				;
> > > >    LDR	X9, [X3]		| (* mmap_unlock *)		;
> > > >    CBZ	X9, out0		| STLR	WZR, [X2]		;
> > > >    EOR	X10, X9, X9		|				;
> > > >    LDR	X11, [X4, X10]		| out1:				;
> > > > 				| EOR	X10, X9, X9		;
> > > >    out0:				| STR	X1, [X4, X10]		;
> > > > 
> > > > exists (0:X8=0 /\ 1:X8=0 /\	(* Lock acquisitions succeed *)
> > > > 	0:X9=0xa110c /\		(* P0 sees the valid PUD ...*)
> > > > 	0:X11=0xdead)		(* ... but the freed PMD *)
> > > > 
> > > > 
> > > Is the syntax correct? I cannot use the herd7 command to run this.
> > Weird, what happens? It runs for me:
> > 
> > $ herd7 -version
> > 7.58+1, Rev: e39a86f5d59dee3174d08d9ab5b13155c75936fd
> > 
> > $ herd7 ptdump.litmus
> > Test ptdump Allowed
> > States 5
> > 0:X8=0; 0:X9=0; 0:X11=0; 1:X8=0;
> > 0:X8=0; 0:X9=0; 0:X11=0; 1:X8=1;
> > 0:X8=0; 0:X9=659724; 0:X11=0; 1:X8=1;
> > 0:X8=0; 0:X9=659724; 0:X11=57005; 1:X8=1;
> > 0:X8=1; 0:X9=0; 0:X11=0; 1:X8=0;
> > No
> > Witnesses
> > Positive: 0 Negative: 9
> > Flag Assuming-common-inner-shareable-domain
> > Condition exists (0:X8=0 /\ 1:X8=0 /\ 0:X9=659724 /\ 0:X11=57005)
> > Observation ptdump Never 0 9
> > Time ptdump 1.65
> > Hash=238908ee9413a36507c61b92a31a366a
> 
> I was using some other command :) yup this works.

Nice.

> I'll try posting the next version today itself, but will you be
> okay merging this if I post on Monday?

On my desk 9am, Monday please!

Joking aside: the sooner, the better but please make sure you've tested
the new static key (inc/dec) stuff as I didn't look particularly deeply
into it.

Will

