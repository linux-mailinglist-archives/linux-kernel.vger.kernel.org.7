Return-Path: <linux-kernel+bounces-826048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBB1B8D671
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1497F188D0DA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA64B2D373D;
	Sun, 21 Sep 2025 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqPeKBcd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11832281529;
	Sun, 21 Sep 2025 07:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758438770; cv=none; b=sPfxYVfjMoBp7gIXV9W6UjP7sL6SAZNua0E1w/li2FJjYz3n3hf5lV1swxtqxIkFjdqEI6MdtxKKXw7Ez3mNzeEsq/7litbaviCKRMa/T/+dWTGycj7HQECL8cAbzZlJvxyYS94CMRiN63wKE3iLVGRhrXP6wPXRPmihnmyhK3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758438770; c=relaxed/simple;
	bh=N7wQpM3AuWf1x6myznjf28SYBWAdznf18w3jUx31/u8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=JHXaQy5FIhtQkYlqyXWR/e8LG07hGXrKpajwHXA86EmKSgYw2L6F1VkXI+dAzCtTRB20oICacDdIQEeQ/571vzkHqv+jutQNyESPrMPhmC+9LZYzOMf8xENonj5sbl3ASLW1oryTdBYBViEMvOug6N6OUsEJrVd6+YBUqAx/eZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqPeKBcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE53AC4CEE7;
	Sun, 21 Sep 2025 07:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758438769;
	bh=N7wQpM3AuWf1x6myznjf28SYBWAdznf18w3jUx31/u8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=DqPeKBcdNKIKHHsq0oylZbyVTiAXQcWUL0TmpQeHRUpa6tGgMGFQx0GDvr9tKNjQQ
	 /HtFKOTQ2VJ3c7t0XZYciZhltxOEtHt+fNwBO7DIMq05SGn6qYrQgH0MLCJKe5NgSM
	 CpuHNGmI9msieZIVQNrqiM7D7frKOWkrIdF70MhghE4g4ffRcZc7bLLYXd/jCeJeXu
	 I+NeGft32hQVtecKXzTBijh0KlCuZISnAyjiXXcY/54XSfcRqtIiCp+28TCNBIEIMM
	 V2aMVkJV6m207JuLPYWCA5FWhQ6meu3y9715fw54vb4YFeRF4IWs3jNZZwcAO2x4kG
	 /U4wIseXVV1zA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Sep 2025 09:12:45 +0200
Message-Id: <DCYAIOO2W2KT.1CANHTH6GRVO@kernel.org>
Subject: Re: [PATCH] rust: print: Fix issue with rust_build_error
From: "Benno Lossin" <lossin@kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20250920161958.2079105-1-joelagnelf@nvidia.com>
 <DCXWEV3YO443.2EUZL32P96Z0D@kernel.org> <20250921004517.GA2101443@joelbox2>
In-Reply-To: <20250921004517.GA2101443@joelbox2>

On Sun Sep 21, 2025 at 2:45 AM CEST, Joel Fernandes wrote:
> On Sat, Sep 20, 2025 at 10:09:30PM +0200, Benno Lossin wrote:
>> On Sat Sep 20, 2025 at 6:19 PM CEST, Joel Fernandes wrote:
>> > When printing just before calling io.write32(), modpost fails due to
>> > build_assert's missing rust_build_error symbol. The issue is that, the
>> > printk arguments are passed as reference in bindings code, thus Rust
>> > cannot trust its value and fails to optimize away the build_assert.
>> >
>> > The issue can be reproduced with the following simple snippet:
>> >   let offset =3D 0;
>> >   pr_err!("{}", offset);
>> >   io.write32(base, offset);
>>=20
>> I took a long time to understand this and I think I got it now, but
>> maybe I'm still wrong: passing `offset` to `printk` via a reference
>> results in the compiler thinking that the value of `offset` might be
>> changed (even though its a shared reference I assume). For this reason
>> the `build_assert!` used by `io.write32` cannot be optimized away.
>
> Yes, that's correct and that's my understanding. I in fact also dumped th=
e IR
> and see that the compiler is trying to reload the pointer to the offset. =
I
> feel this is a compiler bug, and for immutable variables, the compiler sh=
ould
> not be reloading them even if they are passed to external code? Because i=
f
> external code is modifying immutable variables, that is buggy anyway.

It would be great if you could add all of the extra info that you looked
at into the commit message here. So all of the code to reproduce the
issue, the IR you looked at...

>> > Fix it by just using a closure to call printk. Rust captures the
>> > arguments into the closure's arguments thus breaking the dependency.
>> > This can be fixed by simply creating a variable alias for each variabl=
e
>> > however the closure is a simple and concise fix.
>>=20
>> I don't think this is the fix we want to have.
>
> Yeah its ugly, though a small workaround. IMO ideally the fix should be i=
n
> the compiler. I want to send a proposal for this in fact. I looked at the=
 MIR
> and I believe with my limited understanding, that the MIR should be issui=
ng a
> copy before making a pointer of the immutable variable if pointers to
> immutable variables are being passed to external functions.

... and definitely the MIR.

> If I were to send a proposal to the Rust language to start a discussion
> leading to a potential RFC stage, would you mind guiding me on doing so?

I agree that this should be fixed in the compiler if we aren't missing
some attribute on one of our functions.

Note that this probably doesn't require an RFC, since it's not a big
feature and I imagine that there isn't much controversy about it. We can
mention this in our sync meeting on Wednesday with the Rust folks & see
what they have to say about it. After that we probably want to open an
issue about it, I'll let you know.

>> In fact it already
>> doesn't compile all of the existing code:
>
> Oh gosh, I should have run doctests. I just did a normal build. Let me se=
e
> if I can fix this closure issue.

We might just want to live with this until we get the compiler fixed. Or
is there a different workaround like this:

    let offset =3D 0;
    let offset_pr =3D offset;
    pr_err!("{}", offset_pr);
    io.write32(base, offset);

In that case, we might want to prefer that over using a closure... Let's
see how some others respond to this.

>>     error[E0277]: the `?` operator can only be used in a closure that re=
turns `Result` or `Option` (or another type that implements `FromResidual`)
>>         --> rust/doctests_kernel_generated.rs:3446:70
>>          |
>>     3446 |     pr_info!("The frequency at index 0 is: {:?}\n", table.fre=
q(index)?);
>>          |     ---------------------------------------------------------=
--------^-
>>          |     |                                                        =
        |
>>          |     |                                                        =
        cannot use the `?` operator in a closure that returns `()`
>>          |     this function should return `Result` or `Option` to accep=
t `?`
>>=20
>> (originating from `rust/kernel/cpufreq.rs:217`)
>>=20
>> Can't we just mark the pointer properly as read-only?
>
> I found no way yet to do that. If there is something you'd like me to try=
,
> let me know. But even if the pointer is a C const pointer, LLVM seems to
> always want to reload it.

Might be an LLVM bug then? Wouldn't be the first that Rust found :)

---
Cheers,
Benno

