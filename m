Return-Path: <linux-kernel+bounces-875674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE360C1991F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 11:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3783B7CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FC52E1F01;
	Wed, 29 Oct 2025 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FH/PbGyD"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA923817E
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732339; cv=none; b=LQO4JGa9hjUtR0iELBzX3kN7Q/OoFTUadOTbVdJ7kJZX40IONklfOac4y/1MqRxdbOAqpneBheRKujB1rvSvQdsDRxeLvmT5/FiPfqYS0u2f8atubtBVNh6ByYiXvFhTZw+hZYkgWpYVP7Oal8fxCG/Vzebw1aWqPI3vCyYiIuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732339; c=relaxed/simple;
	bh=KV9/sQTEHrkmP/D5R6ssSEZBRY0jTWjI+EqTUrYSo5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jj3BVfxK9nsxOOOnD38gw20gpdbCHhTUt4MLu7+0BLF2cllchdQzwq7X5nqLyGNrxatIInqjVxhqa5jAxr/8Vg0+QH8nmZh2vqih0JK/lzrlvQOF//XEjvf9/uGEpXMT1bqHZS5S4EHnLGvAgxbSfEJ+Q1teX7LxyhFgTWZWloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FH/PbGyD; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4EfSbQRENAnb6xrrxJrgRnQituqdbvmeF7oK8vdoiNM=; b=FH/PbGyD8GldkojYpfmHGLnzSd
	Grn0DfsKShzPg9xiaiOjSKBchpKa/YSdCyYADZh9ECqV9zRSxjKOSgJc8BZnse5BO6Eu7saYTFY/h
	YNsnLv8WfZ7aB/RTxX4AW8c9zj41lt9lZD6kJkuqVfi8EboKPQwxUOyLpM2FpwzIBlo6c+GLCuoVD
	ZPHM+NgpCvAfjdbNy6TTSKgHjFIbr9AHwQBJYE/ySfZqHGi65kyR/0XMKkkjA3yoMNQ0aV1V2pRsb
	mDWW3QqZaE249brVH6gKVycEsPgWt9rPRKySBbd67cG9bfJQmOu/T3KFtrsMgVZsnzcH4qKAUK9MC
	ECrC2YBA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE2Bv-00000006Oc3-2O0v;
	Wed, 29 Oct 2025 09:10:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DA2E7300220; Wed, 29 Oct 2025 11:05:33 +0100 (CET)
Date: Wed, 29 Oct 2025 11:05:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: odd objtool 'unreachable instruction' warning
Message-ID: <20251029100533.GF3419281@noisy.programming.kicks-ass.net>
References: <CAHk-=wi6goUT36sR8GE47_P-aVrd5g38=VTRHpktWARbyE-0ow@mail.gmail.com>
 <20251029095638.06cce7c7@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029095638.06cce7c7@pumpkin>

On Wed, Oct 29, 2025 at 09:56:38AM +0000, David Laight wrote:
> On Tue, 28 Oct 2025 12:29:11 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > Josh, Peter,
> >  due to another entirely unrelated discussion, I ended up resurrecting
> > my "make asm readable" patch that I have had in my local tree when I
> > want to look at the actual generated code for user accesses.
> > 
> > That is a local hack that just removes the alternative noise for the
> > common ops, so that I actually see the fences and clac/stac
> > instructions as such, instead of seeing them as nops in the object
> > file or as horrible noise in the assembler output.
> 
> I've toyed with using explicit nop sequences that would be identifiable
> as stac, clac and lfence.
> 
> At least that would tell you which is which.
> 
> Since the flags can be trashed there are plenty to choose from.
> (eg all the cmpb $n,%reg if you don't mind a false dependency.)

As long as you ensure that insn_is_nop() recognises it as such, they
won't actually ever get ran after alternative patching, since they'll be
rewritten in canonical nops by optimize_nops().

(be sure to use the tip/master branch, since I unified the various
is_nop implementations).

