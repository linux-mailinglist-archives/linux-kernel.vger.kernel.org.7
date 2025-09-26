Return-Path: <linux-kernel+bounces-833768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33472BA3020
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AFAE7B3119
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 08:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A85E299A8C;
	Fri, 26 Sep 2025 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oewmB4a8"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BA326FA4E;
	Fri, 26 Sep 2025 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876504; cv=none; b=dRHHDOgsqdDdBLaZ1j3mAO5kwy608xYCM+mYwyEt3TvgXiFpwjoT9JJWr4DZxnAeeXDiFjLGdr/MfSEcA0P/RKTEazxPwoog52AQZ16AghnAzlamsOpdB87Imk18Q5tD1BkNYBFH7a+hOCvpSxqpSkZ7W6NrrEumgFYMLCeEBOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876504; c=relaxed/simple;
	bh=7De3nQZm4PVTdWyp59mYSwiaxDz6Qyhn9LYb89sbxxg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lo322fKVlEoHP/l5T1kKsBe89E/Y1r7sxh3Q+JWNS424c4N0cnXnyBZNIHb62S6bPSdeXSSnKPoWWu39HeDZ49sIY35YIvjWdHgKQoTElEyWMTlV8VIyBVQ05zkqGW1yBxYvHdl5iReKtWrTCQNvGzY0PTdpcliIYDR43Nxfn2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=oewmB4a8; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cY44243YHz9st3;
	Fri, 26 Sep 2025 10:48:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758876498; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7De3nQZm4PVTdWyp59mYSwiaxDz6Qyhn9LYb89sbxxg=;
	b=oewmB4a8fvEjTKbGN/DAs/n7MBgg9RL9DiXgxDoYuwrY9a6lV0LDNw6hF3+0nR9hXA+6je
	cIvS2p05i6RvXBKFYs0lbZSaRNAiwuQXBdDzYQieJtLK+G1hVZSc3mwBekxUfjGsAKc/gO
	gBYbiN5IhJjZcx1BHnbtZxChkf6rG6VfoNmz6YgzIRPRLnSG1GWtzolVcvfeBNxEtLmEti
	bAwIebXzzwxtIljpNiA/zhyDL+Kmghl8qlMpO+SdCd0Jej/4NjaEV1wOo8kXJ8a8CXBDMw
	aozeNUa8SAm0VHmRzk/Rom5JKxPnlq/MGxCrCSGKG4mk64KC5xilz9uhtTqPBg==
Message-ID: <12c09de235023c99a8a864b17b2f797c7339bb7b.camel@mailbox.org>
Subject: Re: [RFC PATCH] rust: sync: Add dma_fence abstractions
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Boqun Feng <boqun.feng@gmail.com>, Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Gary Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>, Will
 Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  Viresh Kumar
 <viresh.kumar@linaro.org>, Asahi Lina <lina+kernel@asahilina.net>, Daniel
 Almeida <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, FUJITA
 Tomonori <fujita.tomonori@gmail.com>, Krishna Ketan Rai
 <prafulrai522@gmail.com>, Lyude Paul <lyude@redhat.com>, Mitchell Levy
 <levymitchell0@gmail.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, llvm@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
Date: Fri, 26 Sep 2025 10:48:06 +0200
In-Reply-To: <aMwOoYe1xGDBg0Zv@tardis-2.local>
References: <20250918123100.124738-2-phasta@kernel.org>
	 <aMwOoYe1xGDBg0Zv@tardis-2.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: dcc294d54bd9f90528a
X-MBO-RS-META: c53m4ic87syjzwty5tfmxisedsq4b4ff

On Thu, 2025-09-18 at 15:52 +0200, Boqun Feng wrote:
> On Thu, Sep 18, 2025 at 02:30:59PM +0200, Philipp Stanner wrote:
> [...]
> > ---
> > So. =C2=A1Hola!
> >=20
> > This is a highly WIP RFC. It's obviously at many places not yet
> > conforming very well to Rust's standards.
> >=20
> > Nevertheless, it has progressed enough that I want to request comments
> > from the community.
> >=20
> > There are a number of TODOs in the code to which I need input.
> >=20
> > Notably, it seems (half-)illegal to use a shared static reference to an
> > Atomic, which I currently use for the dma_fence unit test / docstring
>=20
> The `CHECKER` static you mean? If so, it should be a `static CHECKER`
> instead of `static mut CHECKER`, also for future versions please use
> LKMM (Linux Kernel Memory Model) atomics [1] instead of Rust native
> atomics (you probably need to define `CHECKER` as `Atomic<i32>` because
> AtomicBool is not supported by LKMM and potentially sub-optimial in some
> cases).

Thanks.

Thinking about it I realized that for that example code I don't even
need atomics. So I'll drop them for now.

>=20
> > test. I'm willing to rework that if someone suggests how.
> > (Still, shouldn't changing a global Atomic always be legal? It can race=
,
> > of course. But that's kind of the point of an atomic)
> >=20
> > What I want comments on the most is the design of the callbacks. I thin=
k
> > it's a great opportunity to provide Rust drivers with rust-only
> > callbacks, so that they don't have to bother about the C functions.
> >=20
> > dma_fence wise, only the most basic callbacks currently get implemented=
.
> > For Nova, AFAICS, we don't need much more than signalling fences and
> > registering callbacks.
> >=20
> >=20
> > Another, solvable, issue I'm having is designing the
> > dma_fence_begin_signallin() abstractions. There are TODOs about that in
> > the code. That should ideally be robust and not racy. So we might want
> > some sort of synchronized (locked?) way for using that abstraction.
> >=20
> >=20
> > Regarding the manually created spinlock of mine: I so far never need
> > that spinlock anywhere in Rust and wasn't sure what's then the best way
> > to pass a "raw" spinlock to C.
> >=20
>=20
> You can use `SpinLock<()>` for this purpose, no need to add new
> bindings.

The dma_fence C backend needs a spinlock pointer, given to it by the
driver (so Rust code).

How do I pass a SpinLock<()> to a C function? AFAICS SpinLock doesn't
implement as_raw(), so I'd have to implement it, wouldn't I?

Or rather, as it looks, I'd have to implement it for SpinLockBackend?


P.

>=20
> [1]: https://lore.kernel.org/rust-for-linux/20250905044141.77868-1-boqun.=
feng@gmail.com/
>=20
> Regards,
> Boqun
>=20
> >=20
> > So much from my side. Hope to hear from you.
> >=20
> > (I've compiled and tested this with the unit test on the current -rc3)
> >=20
> > Philipp
> > ---
> [...]


