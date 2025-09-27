Return-Path: <linux-kernel+bounces-834880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3F8BA5BC1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C118F17FBDC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49172D5950;
	Sat, 27 Sep 2025 09:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HaDqZxRs"
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D782283FC2;
	Sat, 27 Sep 2025 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758963720; cv=none; b=J4XX7CYUpIRcaAoGKvWOkVtHUSjxUdzEXE8OFqT5H6EOM6tUjJjOa1pUV+/qvLdO6hCcbE5uJEasD2EmdMrPbEB2yACy7LOMJzWg5m3FcXVFRIsTd0vGO2RTUaOtbx6Gdg824o6k/zIjBDEwN3mGKHCqbPAJACtVjWrVdo7lTb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758963720; c=relaxed/simple;
	bh=N6dMzxmUsCPkVpnZwfIAz+BTqenxeQnJX0cDJbhkkc8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UR5JPAWNGehq9A8d4ZmmZjRCFQB/4MH0Eu99+rCzONyEsrLgkHQ8w1VASLOnqC00vH5a4dHjtcFgf/hJy2d4/ZZU9uK/WoEZzIvzaEkFJr+YR1rC7VJtL4vIioRymKTcAIWFkARiicFlzqD8hF71+VjBpWVMo4D8Q8Z2Q0djpK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=HaDqZxRs; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cYhK84ZjGz9svD;
	Sat, 27 Sep 2025 11:01:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1758963708; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N6dMzxmUsCPkVpnZwfIAz+BTqenxeQnJX0cDJbhkkc8=;
	b=HaDqZxRs7cCTUmSiy9RO+8saBbGSlcVQV7nk5gvZGyLfz3YSdY3WjdV+OpAqjtWXrGh3hu
	XdRKIo218o8Vv5/bBcJfYojCCttx2Oa7VV8sd3ZfqDi3d89/FG59ARrhQHC6Xpyms7O5iC
	JJV2SxRcJTjPj1PQ1Z391UUp+EDPix55jjfr3Kp1owvY+2jH5M9Sym1Ka3hKV9XTxb1Wgp
	4R6La9PA+7gdKxw2YmYlSELIkRHdahxXB8CniKWLq3g6AqpSClg+cnc23RKSmctsRR6T14
	hhxP91b6vje+LLbG42D8EpZiKz9Jqosc8bBiQVUyQL6HuOnHh/L1Bod06qr+pw==
Message-ID: <2aa5150d913fcd4d321db52bc6bad1770f68e778.camel@mailbox.org>
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
Date: Sat, 27 Sep 2025 11:01:38 +0200
In-Reply-To: <aNa7BDpKS2KA__4M@tardis.local>
References: <20250918123100.124738-2-phasta@kernel.org>
	 <aNa7BDpKS2KA__4M@tardis.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: 1ubho5oa9dpzptjdu7eqkp4bqikqpmed
X-MBO-RS-ID: ecfc66f5dfc11acbca0

On Fri, 2025-09-26 at 09:10 -0700, Boqun Feng wrote:
> On Thu, Sep 18, 2025 at 02:30:59PM +0200, Philipp Stanner wrote:
> > dma_fence is a synchronization mechanism which is needed by virtually
> > all GPU drivers.
> >=20
> > A dma_fence offers many features, among which the most important ones
> > are registering callbacks (for example to kick off a work item) which
> > get executed once a fence gets signalled.
> >=20
> > dma_fence has a number of callbacks. Only the two most basic ones
> > (get_driver_name(), get_timeline_name() are abstracted since they are
> > enough to enable the basic functionality.
> >=20
> > Callbacks in Rust are registered by passing driver data which implement=
s
> > the Rust callback trait, whose function will be called by the C backend=
.
> >=20
> > dma_fence's are always refcounted, so implement AlwaysRefcounted for
> > them. Once a reference drops to zero, the C backend calls a release
> > function, where we implement drop_in_place() to conveniently marry that
> > C-cleanup mechanism with Rust's ownership concepts.
> >=20
> > This patch provides basic functionality, but is still missing:
> > =C2=A0 - An implementation of PinInit<T, Error> for all driver data.
> > =C2=A0 - A clever implementation for working dma_fence_begin_signalling=
()
> > =C2=A0=C2=A0=C2=A0 guards. See the corresponding TODO in the code.
> > =C2=A0 - Additional useful helper functions such as dma_fence_is_signal=
ed().
> > =C2=A0=C2=A0=C2=A0 These _should_ be relatively trivial to implement, t=
hough.
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
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
> >=20
> > So much from my side. Hope to hear from you.
> >=20
> > (I've compiled and tested this with the unit test on the current -rc3)
> >=20
> > Philipp
> > ---
> > =C2=A0rust/bindings/bindings_helper.h |=C2=A0=C2=A0 1 +
> > =C2=A0rust/helpers/dma_fence.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 23 ++
> > =C2=A0rust/helpers/helpers.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0rust/helpers/spinlock.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 5 +
> > =C2=A0rust/kernel/sync.rs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> > =C2=A0rust/kernel/sync/dma_fence.rs=C2=A0=C2=A0 | 388 +++++++++++++++++=
+++++++++++++++
>=20
> I missed this part, and I don't think kernel::sync is where dma_fence
> should be, as kernel::sync is mostly for the basic synchronization
> between threads/irqs. dma_fence is probably better to be grouped with
> dma-buf and other dma related primitives. Maybe in kernel::dma? Like:
>=20
> rust/kernel/dma.rs
> rust/kernel/dma/dma_buf.rs
> rust/kernel/dma/dma_fence.rs
>=20
> Thoughts? Miguel, Greg, Danilo and Lyude, any idea or suggestion?

@Christian K=C3=B6nig's opinion would be valuable, too.

I'm not super convinced of that because dma_fence has not really much
to do with DMA. They're not very different from completions and are a
mechanism to synchronize consumers and producers.

Actually, before f54d1867005c3 they were just called "fence" and then
renamed to "dma_fence" because someone wanted that name.


Anyways, I don't have strong objections and mostly care about having
them available somewhere.

P.

>=20
> Regards,
> Boqun
>=20
> > =C2=A06 files changed, 420 insertions(+)
> > =C2=A0create mode 100644 rust/helpers/dma_fence.c
> > =C2=A0create mode 100644 rust/kernel/sync/dma_fence.rs
> >=20
> [...]


