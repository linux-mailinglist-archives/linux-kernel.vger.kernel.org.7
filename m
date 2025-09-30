Return-Path: <linux-kernel+bounces-837279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0543ABABD9E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC0D189F779
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0218222E004;
	Tue, 30 Sep 2025 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C1KfOBv/"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB2D220F34
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217959; cv=none; b=YtndGd2kVHigHIPYqq9PBlDFyiVRoA1O2rAuPRFWi335x6+29+MpcR1Ujij1p7ibYT75paab+zcnzPH/CZjywQ9P2s4nwfMUOXfOhTbHdT6ImA0is/9mq1i29ng4Kv6ndnlVlLSweN6SMfy5tmGbEedqweCnj1Uooq7n9J2qdBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217959; c=relaxed/simple;
	bh=yJxlyTUV20W97zmgBmGNsk7qWb1oBqLf527bf1rnqic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrklVVuk9sVbGKC/fMjaNBUc9M3I2SmaAdwTFqDLW3uOyMk/4ZCtTpPRMgyyd+ClBrNMjfcFGs08DGHo3qQQtsqBiRlQpvOdcY+S+gLhvB858TV/NA4Xze+p/575BBDimbk9rXV6zSHWHXDhZr5CKZYvCBfCSWQGhWKLbaYLYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C1KfOBv/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=rSXqOl0zkkwOpacR4Yn9LdgvTNFsHUf0M1ax3Pdtub8=; b=C1KfOBv/k1hGkDVwYR1i724dtw
	hnAnC19WeTmkIcZYVVdeGD8LLwNB5kwOk1oevGyBaO6lBwZN7f/xa5H2AHZeeYpo7A1wLT/HNQfY/
	v2AJefEpDBbd56XwiRh+tzLFqjoI2I/aa42KYIcDE99zPThD2ly+lyY4aC/zajDgIC7hoZmcNJeni
	87NfUYG8nzfGGvo2wgmr63aUwubaa5fNFJFYH2YVgzTY8V4ls7KZCg06xmy/w6vyriwHnArKkyijG
	FkGpm0EHr0QM1A07UpJ07W39TuFtOyAK3+TdDr1BUUBd7NSdAuahuUQm/gO4t3l+cuYIaNUxtPQGz
	kR6ZGxAg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3Ux3-00000006fqf-2BeZ;
	Tue, 30 Sep 2025 07:39:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3DE703001D4; Tue, 30 Sep 2025 09:39:10 +0200 (CEST)
Date: Tue, 30 Sep 2025 09:39:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/3] x86/alternative: Patch a single alternative location
 only once
Message-ID: <20250930073910.GH4067720@noisy.programming.kicks-ass.net>
References: <20250929112947.27267-1-jgross@suse.com>
 <20250929112947.27267-4-jgross@suse.com>
 <20250930072643.GF3245006@noisy.programming.kicks-ass.net>
 <bd595b07-5f00-420f-8bc0-4009237d040c@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bd595b07-5f00-420f-8bc0-4009237d040c@suse.com>

On Tue, Sep 30, 2025 at 09:33:25AM +0200, J=FCrgen Gro=DF wrote:
> On 30.09.25 09:26, Peter Zijlstra wrote:

> > > @@ -692,14 +698,19 @@ void __init_or_module noinline apply_alternativ=
es(struct alt_instr *start,
> > >   		 * - feature not present but ALT_FLAG_NOT is set to mean,
> > >   		 *   patch if feature is *NOT* present.
> > >   		 */
> > > -		if (!boot_cpu_has(a->cpuid) =3D=3D !(a->flags & ALT_FLAG_NOT)) {
> > > -			memcpy(insn_buff, instr, a->instrlen);
> > > -			optimize_nops(instr, insn_buff, a->instrlen);
> > > -		} else {
> > > +		if (!boot_cpu_has(a->cpuid) !=3D !(a->flags & ALT_FLAG_NOT)) {
> > >   			apply_one_alternative(instr, insn_buff, a);
> > > +			patched =3D true;
> > >   		}
> > > -		text_poke_early(instr, insn_buff, a->instrlen);
> > > +		instances--;
> > > +		if (!instances) {
> > > +			if (!patched) {
> > > +				memcpy(insn_buff, instr, a->instrlen);
> > > +				optimize_nops(instr, insn_buff, a->instrlen);
> > > +			}
> > > +			text_poke_early(instr, insn_buff, a->instrlen);
> > > +		}
> > >   	}
> > >   	kasan_enable_current();
> >=20
> > I think you lost the optimize_nops() call for the patched case.
> >=20
> > That is, note how apply_one_alternative() does 0x90 padding, but then
> > you only do optimize_nops() when !patched.
>=20
> The call of optimize_nops() is part of text_poke_apply_relocation() when
> patching, like without my series.

Indeed it is. Clearly I need more wakeup juice :-)

Therefore the patches seem fine. I'll try and hold onto them until the
merge window closes and then stick them in x86/core or thereabout.

