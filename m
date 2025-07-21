Return-Path: <linux-kernel+bounces-739372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB219B0C57A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD5373B8183
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA862D9797;
	Mon, 21 Jul 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ihrpzh3f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A80C28DEF8;
	Mon, 21 Jul 2025 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105691; cv=none; b=bY/538kbyeGCfw2ZkpJwXARYqDkAjpDKMKZRzoGmU7x0xtXvFvFCviZuAIfqMR44LRui3JFQQ1VxvUu+5uhvPDhlNO1IMG/Gtbo8gvFqkBqi3SFbUTgT/xY1tlKg5uXIgq9d0RxTR5bxr0I5m7OhxViZ+4UuaNf6TR1dTdG5nds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105691; c=relaxed/simple;
	bh=VpKp5fA+cfu0K6mV/x0ED2EWSxOilnoSZia0h19Gcj4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=mCD/vFgyvlukMe8ZHjdo492Nr3J/A7gm871h5D9K7P/1xhbw3SDEXp58r1dGN8UyIxJb0QgbQ4EaHe0tV0KnTEpitRRnlIyMjdsBIePNYGAI/FKFYfKUkABrHRrRaFNyacl6R8TnlPSegY4IC0VD+bQq3TrTBmF9ztXo/g9V+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ihrpzh3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D474C4CEED;
	Mon, 21 Jul 2025 13:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753105690;
	bh=VpKp5fA+cfu0K6mV/x0ED2EWSxOilnoSZia0h19Gcj4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Ihrpzh3fUfUL9D9XzyKlJ1G5+ProsLiOEz6bfPXlaJ62kal3vgGVko39tYDe+3F9y
	 cjhyQZmH48tLMPAshYYOB+Rty0uJsejMxN7jQPfhqbL2N4bPnsJJicpB2FRXvazTpI
	 Ix40dumAkT75Zm1wkFAguAZ1Jp0AF5q3/OrvuNhok0rOirSWleWLqFA3EHefcTF+bM
	 jbgcHkPATZvrutz80yMn0Frwh92L0hqVHqrXHZcZq40RDMHN0Od3WbbYaiof6dYQF6
	 EmX6yxcNETEYZ2NHsZcsYbN/L2a8YqcEhagxTy1OnjgfyJGh2mT9wCEnzwCKcpeA9f
	 PtyWLSmP8XoxQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Jul 2025 15:48:06 +0200
Message-Id: <DBHS3M032PU8.3UCTIWJB5COOZ@kernel.org>
Subject: Re: [PATCH 1/3] device: rust: documentation for DeviceContext
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250717224806.54763-1-dakr@kernel.org>
 <20250717224806.54763-2-dakr@kernel.org>
 <DBF6M9BZUX3C.2VXBZJKQYGN84@nvidia.com>
 <DBF7IACHZEUW.29EHD3V4OF5GA@kernel.org>
In-Reply-To: <DBF7IACHZEUW.29EHD3V4OF5GA@kernel.org>

On Fri Jul 18, 2025 at 3:14 PM CEST, Danilo Krummrich wrote:
> On Fri Jul 18, 2025 at 2:32 PM CEST, Alexandre Courbot wrote:
>> On Fri Jul 18, 2025 at 7:45 AM JST, Danilo Krummrich wrote:
>>> +///
>>> +/// Bus devices can automatically implement the dereference hierarchy =
by using
>>> +/// [`impl_device_context_deref`](kernel::impl_device_context_deref).
>>>  pub trait DeviceContext: private::Sealed {}
>>> =20
>>> -/// The [`Normal`] context is the context of a bus specific device whe=
n it is not an argument of
>>> -/// any bus callback.
>>> +/// The [`Normal`] context is the default [`DeviceContext`] of any [`D=
evice`].
>>> +///
>>> +/// The normal context does not indicate any specific scope. Any `Devi=
ce<Ctx>` is also a valid
>>> +/// [`Device<Normal>`]. It is the only [`DeviceContext`] for which it =
is valid to implement
>>> +/// [`AlwaysRefCounted`](kernel::types::AlwaysRefCounted) for.
>>>  pub struct Normal;
>>
>> `Normal` as a name can be interpreted in many different ways, and in the
>> case of a device context it is not clear what the "normal" state is. I
>> think it would be helpful if we can elaborate a bit more on what this
>> implies (i.e. what concretely speaking are the limitations), and if
>> possible why this name has been chosen.
>
> It's the context that does not guarantee any specific scope. But that's a=
lso
> what the documentation says.
>
> I also wouldn't speak of limitations, it's just that it doesn't allow to =
make
> *additional* assumptions compared to other device context types.
>
> Yet, if you have suggestions on what to add specifically, please let me k=
now
> (maybe simply my previous sentence?).
>
> Regarding the name, "Normal" seems reasonable for the device context that=
 does
> not guarantee any specific scope. We could have also named it just "Defau=
lt".
>
> I think "Normal" is fine, as in "it's just a normal device reference, no
> specific scope guaranteed".

Not sure if this helps, but `Plain` might carry a slightly different
meaning from `Normal` that is better in this case?

(but you probably can't infer much from the name anyways)

---
Cheers,
Benno

