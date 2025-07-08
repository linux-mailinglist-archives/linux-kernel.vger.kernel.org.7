Return-Path: <linux-kernel+bounces-721852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F441AFCEA6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D082E16D4E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40F82E091A;
	Tue,  8 Jul 2025 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohnQET+e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C67F26FA56;
	Tue,  8 Jul 2025 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987492; cv=none; b=ConqLpzOAQaihNszo1EiMByG3oSZqdocr5vg3mEBiV0Akjjv7rae4RGpXd3SYYzqTRZf1FoJbkmRrL8rkSrNResGbNvNf8KgK05O7rGWE5sjHzkKzBxINJFDuVgIJCqwOSpYbfxXiezV8uetErWR3DoBs5fbIWfPbXCZhTxw4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987492; c=relaxed/simple;
	bh=NRRNtg6vb+K/sjejePJsbFo5EUJno2MwHh8cVe80W/M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=vBiOT6GCGlmxK9zKo8EjvyH2EqjxLdIL39kvxIkwDKaJ9mrEKx31FoiZA/XI3BK3+Jz1Tm4Sjn+AYdbH5ReRd71+o8j+NnOnM2UMBM3VzAIQkX66WcOoHVNEq8g/8usAyuyie8UXsgsc9yhveT43QhK7Ihqw3/wY+/Oxi6N0EJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohnQET+e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11743C4CEED;
	Tue,  8 Jul 2025 15:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751987491;
	bh=NRRNtg6vb+K/sjejePJsbFo5EUJno2MwHh8cVe80W/M=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=ohnQET+eQxGJXcUGGacq3S9BmTACp9gcbeanlc8UFNYikvcNwBLqA3wp7IAx88NDN
	 mQhwZ4Fbv+SNQRI33D6CAj2qHgR/VWgyyiz/QUgLfAWeGrmNlrCeS+U/sq27ocWSgW
	 2w97t8GUtWaa8YpBO37ZY/4go8HuwLheGNZPEfbkI7O5goC3AyWTLI90fuNqt0iyo6
	 Y/HZ4haLXe4nBArO7sOiuxZLJ78+vt4pH6OMF4YtUVJiVrDBD1NHTFy5QFkaJlpoGJ
	 C2ThD/lJMOH1clYyfb7uz6zVdH1teZ8xik/B+iAv9NadUV4To5lgasIkriO5/UZL58
	 g4oo/teCrkyYA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 17:11:28 +0200
Message-Id: <DB6RQCZYHPSA.1UEPUVMC3FBBI@kernel.org>
Subject: Re: [PATCH v11 0/4] support large align and nid in Rust allocators
Cc: "Vitaly Wool" <vitaly.wool@konsulko.se>, <linux-mm@kvack.org>,
 <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Vlastimil
 Babka" <vbabka@suse.cz>, <rust-for-linux@vger.kernel.org>, "Liam Howlett"
 <liam.howlett@oracle.com>
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local>
 <aG0HJte0Xw55z_y4@pollux>
 <54fc10ce-c3b6-4571-93e7-eebfc538d0c7@lucifer.local>
 <DB6QKIHD2VGS.AHEOXL25SSXW@kernel.org>
 <4c122436-db58-4ca5-bc64-5ca596f03952@lucifer.local>
In-Reply-To: <4c122436-db58-4ca5-bc64-5ca596f03952@lucifer.local>

On Tue Jul 8, 2025 at 4:39 PM CEST, Lorenzo Stoakes wrote:
> On Tue, Jul 08, 2025 at 04:16:48PM +0200, Danilo Krummrich wrote:
>> (Please also see the explanation in [1].)
>>
>> There's a thin abstraction layer for allocators in Rust, represented by =
the
>> kernel's Allocator trait [2] (which has a few differences to the Allocat=
or trait in
>> upstream Rust, which, for instance, can't deal with GFP flags).
>>
>> This allocator trait is implemented by three backends, one for each of
>> krealloc(), vrealloc() and kvrealloc() [3].
>>
>> Otherwise, the alloc module implements Rust's core allocation primitives=
 Box and
>> Vec, which each of them have a type alias for allocator backends. For in=
stance,
>> there is KBox, VBox and KVBox [4].
>>
>> This was also mentioned in the mm rework in [5] and in the subsequent pa=
tch
>> series reworking the Rust allocator module [6].
>>
>> Before [6], the Rust allocator module only covered the kmalloc allocator=
 (i.e.
>> krealloc()) and was maintained under the "RUST" entry.
>>
>> Since [6], this is maintained under the "RUST [ALLOC]" entry by me.
>>
>> Given that, there is a clear and documented responsibility, which also A=
ndrew is
>> aware of.
>>
>> To me the current setup looks reasonable, but feel free to take a look a=
t the
>> code and its relationship to mm and Rust core infrastructure and let me =
know
>> what you think -- I'm happy to discuss other proposals.
>
> Thanks for the explanation.
>
> To me this is clearly mm rust code. This is an abstraction over mm bits t=
o
> provide slab or vmalloc allocations for rust bits.
>
> To be clear - I'm not suggesting anything dramatic here, nor in any way
> suggesting you ought not maintain this (apologies if this wasn't clear :)
>
> It's really a couple points:
>
> 1. Purely pragmatically - how can we make sure relevant people are pinged=
?

I'm very happy to add more reviewers to the RUST [ALLOC] entry for this pur=
pose.

Can you please send a patch for this?

> 2. Having clarity on what does/does not constitute 'MEMORY MANAGEMENT - R=
UST'
>    (again, perhaps Alice best placed to give some input here from her poi=
nt of
>    view).

In the end that's a question of definition.

The reason RUST [ALLOC] is a thing is because it is very closely related to=
 Rust
core infrastructure with only a thin backend using {k,v}realloc().

Compared to other abstractions, the main purpose is not to expose a Rust
interface for an existing kernel specific API, but rather implement a very =
Rust
specific concept while being a user of an existing kernel C API.

> We could solve 1 very simply by just using the fact we can have files in
> multiple sections in MAINTAINERS.

Please not -- I don't want to have files in multiple entries in MAINTAINERS=
,
especially when there are different maintainers and different trees. I pref=
er
clear responsibility.

> Doing a scripts/get_maintainers.pl invocation will very clearly tell you
> who's in charge of what so there'd be no lack of clarity on this.

How's that when a file is in multiple entries?

> It's a bit messy, obviously. But it'd solve the issue of mm people not
> getting notified when things change.
>
> However, at this stage you might want to just limit this to people who ha=
ve
> _opted in_ to look at mm/rust stuff. In which case then it'd make sense t=
o
> add only to the "MEMORY MANAGEMENT - RUST" section (but here we need to
> address point 2 obviously).
>
> Alternatively we could just add reviewers to the rust alloc bit.

Yeah, let's do that instead please.

>>
>> [1] https://lore.kernel.org/all/aG0HJte0Xw55z_y4@pollux/
>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/rust/kernel/alloc.rs#n139
>> [3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/rust/kernel/alloc/allocator.rs#n130
>> [4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/rust/kernel/alloc/kbox.rs
>> [5] https://lore.kernel.org/all/20240722163111.4766-1-dakr@kernel.org/
>> [6] https://lore.kernel.org/all/20241004154149.93856-1-dakr@kernel.org/
>
>
> I feel it's really important to not separate rust _too much_ from the
> subsystems it utilises - if we intend to have rust be used more and more
> and integrated further in the kernel (something I'd like to see, more so
> when I learn it :P) - the only practical way forward is for the rust stuf=
f
> to be considered a first class citizen and managed hand-in-glove with the
> not-rust stuff.

You're preaching to the choir with this on my end. I'm recommending subsyst=
ems
that receive the first Rust bits to get involved in one or the other way al=
l
the time. And if it's only by reading along. :)

