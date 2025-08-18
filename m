Return-Path: <linux-kernel+bounces-774554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6964AB2B414
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111E71B66CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC942773CD;
	Mon, 18 Aug 2025 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf3pDsbC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771F17A2E3;
	Mon, 18 Aug 2025 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755556045; cv=none; b=rygtfbwwprUuWQ1b0BK080UjjCNLnR8YV29J0xpiZysGxGV8AxE4ZT17T8T58fCRcBq5W1zKshwfl0r0tbUnKVuFsnVGfSSwMuGhW+8B4iB/mXh3dSn4+j3279Ta1LqaiNFOk9l9OZmdH6KrDWNInmTsvKjFa6oo9GEElYcUG/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755556045; c=relaxed/simple;
	bh=mL7bjSQLh4IOfTR++S4NwnZtMzCJn26uG02XVJtqMwI=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=GMdyovJHiqd12T0YLeMPbAfCxD59oOWU3U+HNILSYUtNxlYl94feIlecSngaTZYircgZIpBcyfoxNuEXnqSdabpixVdPCivSowWqiECnUm5/fkCEOVEx37vscWMsydP1UDCZRSNd9Ms861+X4cQZELOKPBO2eibzjbOApRplZYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf3pDsbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84248C4CEEB;
	Mon, 18 Aug 2025 22:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755556044;
	bh=mL7bjSQLh4IOfTR++S4NwnZtMzCJn26uG02XVJtqMwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rf3pDsbCo3PS8ke9C98zEE4LvCqj6FrzZqos+6TXFQZ71ZcjW1PstuCBkdDR6UEUF
	 jqLI0k1Nj2GiVGOxZUxRpbDdyFGOCwiPzwSOy5FTtA3AkS7BzSZUjpHjziRIZDqF/s
	 pL2Y8xr/burSQT8YNH2C6iUjAmJ4L1RdvMfonktaL1w/ySTdYsczLP2mATZfWN9kTv
	 JtsgLAjbamRbfifxxHGpF9qhuzeumBoftqG1ErhV4aTaG6++VBUZnfw+1iqM5tPeBn
	 +51WwkSessfNWnql66fGeddawMxFBvs1hjwXiKPMfZTokg1OBFzYmDYBx5YbS05fx5
	 WjxGmSbNFPxeQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 00:27:21 +0200
Message-Id: <DC5WOFIKX7VQ.30UNUNE37LOO5@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Oliver Mangold" <oliver.mangold@pm.me>, "Andreas Hindborg"
 <a.hindborg@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Asahi Lina" <lina+kernel@asahilina.net>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/4] rust: types: Add Ownable/Owned types
X-Mailer: aerc 0.20.1
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <2OkNj7ab-vTaPaqMj_KRpIjaKTWgOW-F9Cn-CxnR12E6Dwg4lnjr6fx1vkjnoTx0boUeReeIVDbSyVFBWlYx7g==@protonmail.internalid> <20250618-unique-ref-v11-1-49eadcdc0aa6@pm.me> <87o6scdchf.fsf@t14s.mail-host-address-is-not-set> <aKMkvHAfDozzDjkB@mango>
In-Reply-To: <aKMkvHAfDozzDjkB@mango>

On Mon Aug 18, 2025 at 3:04 PM CEST, Oliver Mangold wrote:
> On 250818 1446, Andreas Hindborg wrote:
>> "Oliver Mangold" <oliver.mangold@pm.me> writes:
>> > +impl<T: OwnableMut> DerefMut for Owned<T> {
>> > +    fn deref_mut(&mut self) -> &mut Self::Target {
>> > +        // SAFETY: The type invariants guarantee that the object is v=
alid, and that we can safely
>> > +        // return a mutable reference to it.
>> > +        unsafe { self.ptr.as_mut() }
>> > +    }
>> > +}
>>=20
>> I think someone mentioned this before, but handing out mutable
>> references can be a problem if `T: !Unpin`. For instance, we don't want
>> to hand out `&mut Page` in case of `Owned<Page>`.
>>
>
> That was the reason, why `OwnableMut` was introduced in the first place.
> It's clear, I guess, that as-is it cannot be implemented on many classes.

Yeah the safety requirements ensure that you can't implement it on
`!Unpin` types.

But I'm not sure it's useful then? As you said there aren't many types
that will implement the type then, so how about we change the meaning
and make it give out a pinned mutable reference instead?

> Good question, I have been thinking about it, too. But it might
> be, that it isn't needed at all. As I understand, usually Rust wrappers
> are around non-movable C structs. Do we actually have a useful applicatio=
n
> for OwnableMut?

Also, do we even need two different traits? Which types would only
implement `Ownable` but not `OwnableMut`?

---
Cheers,
Benno

