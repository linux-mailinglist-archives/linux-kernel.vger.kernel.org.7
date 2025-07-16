Return-Path: <linux-kernel+bounces-734009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F322B07BE4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF8A7B0523
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB7D2F5C3B;
	Wed, 16 Jul 2025 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCfXXjU3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF59277030;
	Wed, 16 Jul 2025 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752686499; cv=none; b=k4ebCVe82OOTo2AXTnUwHD8O/H2EQRpZ0tJMSkTrhD2t0QiD1Z4Tbnwe8czRUif2ki2Vhc3HaJ6y+wgLJ3zpuYad9jMU/ZLXYNSqEfF6mNZenzCLrSZ2M8uySftE5Bw9KWf8WjBWciykoVRjV0zJeQ+slgJLLjMA2MejVAVbVI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752686499; c=relaxed/simple;
	bh=2negnZkD72TZWe3BsPmibIcM1Vow8UKfserRA3k3YuA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=KYd+4u32Zhs8tIy8DU3ndz4/B3sTwAd9ZRsTyw1IsRwyvS6KY8w5SeQN3Z862H7G9qfG+4jWN2pN4AhXhscJwZtVL8F+++a+QEUHjEpBFmgBU5CmYC7ILJy5sXpgWNsnp+898FxFZyGzGOqIOmX0hoEuQAcYOwBrA0dV0eCHZ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCfXXjU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B7DC4CEE7;
	Wed, 16 Jul 2025 17:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752686497;
	bh=2negnZkD72TZWe3BsPmibIcM1Vow8UKfserRA3k3YuA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UCfXXjU3lbjom+okhpOsljp81vLHkWGlaWmae1qR96mYl372TUjEiuJRLvOBMmYzK
	 h1vGipHbIGGghf3CL8Lfnlvb6bwMbhGpwOLbzYY3LCXya3d1Tjvx1lKnsTAxCan4aY
	 G3hjFk+fLeA+H5LhNOrzVggbfaSZ3jEU9KSXyo2j4qzq7g0bkGe6cE6hyvBX9cLFn6
	 A51OOAWDIrHGhgzDIr26/6ad0uXdWdcTZ2log3q7a3ASDWgk3Kowgt8et2m9bEeu4H
	 bu/sir6KbdIjZnfaBxe8MraXhTsGLPN8djzl7aa5DO7T7wsSBEUXhZAaE/u3IT1f7y
	 Xt7aLkCkgRwmg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 19:21:32 +0200
Message-Id: <DBDNIAW09Z7W.EXO6C61HCNVP@kernel.org>
Cc: "Mitchell Levy" <levymitchell0@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Dennis Zhou"
 <dennis@kernel.org>, "Tejun Heo" <tj@kernel.org>, "Christoph Lameter"
 <cl@linux.com>, "Danilo Krummrich" <dakr@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: Re: [PATCH v2 3/5] rust: percpu: add a rust per-CPU variable test
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250712-rust-percpu-v2-3-826f2567521b@gmail.com>
 <DBATM1CUS704.28MKE6BIBQB7G@kernel.org>
 <68762e19.170a0220.33e203.a0b7@mx.google.com>
 <DBCLFG5F4MPW.2LF4T3KWOE12R@kernel.org> <aHZhcNCayTOQhvYh@Mac.home>
 <DBCR1OCNYAUW.1VLAY1HWCHLGI@kernel.org> <aHaCUFNUd_mErL7S@Mac.home>
 <DBCTCZ5HUZOF.2DJX63Q0VWWFN@kernel.org> <aHbJUfcsjHA92OlE@tardis-2.local>
 <DBDESSQOH6MB.2I4GNLPBP5ORJ@kernel.org> <aHfGV3l4NCmYSRuv@Mac.home>
In-Reply-To: <aHfGV3l4NCmYSRuv@Mac.home>

On Wed Jul 16, 2025 at 5:33 PM CEST, Boqun Feng wrote:
> On Wed, Jul 16, 2025 at 12:32:04PM +0200, Benno Lossin wrote:
>> On Tue Jul 15, 2025 at 11:34 PM CEST, Boqun Feng wrote:
>> > On Tue, Jul 15, 2025 at 07:44:01PM +0200, Benno Lossin wrote:
>> > [...]
>> >> >> >
>> >> >> > First of all, `thread_local!` has to be implemented by some sys-=
specific
>> >> >> > unsafe mechanism, right? For example on unix, I think it's using
>> >> >> > pthread_key_t:
>> >> >> >
>> >> >> > 	https://pubs.opengroup.org/onlinepubs/009695399/functions/pthre=
ad_key_create.html
>> >> >> >
>> >> >> > what we are implementing (or wrapping) is the very basic unsafe
>> >> >> > mechanism for percpu here. Surely we can explore the design for =
a safe
>> >> >> > API, but the unsafe mechanism is probably necessary to look into=
 at
>> >> >> > first.
>> >> >>=20
>> >> >> But this is intended to be used by drivers, right? If so, then we =
should
>> >> >
>> >> > Not necessarily only for drivers, we can also use it for implementi=
ng
>> >> > other safe abstraction (e.g. hazard pointers, percpu counters etc)
>> >>=20
>> >> That's fair, but then it should be `pub(crate)`.
>> >>=20
>> >
>> > Fine by me, but please see below.
>> >
>> >> >> do our usual due diligence and work out a safe abstraction. Only f=
all
>> >> >> back to unsafe if it isn't possible.
>> >> >>=20
>> >> >
>> >> > All I'm saying is instead of figuring out a safe abstraction at fir=
st,
>> >> > we should probably focus on identifying how to implement it and whi=
ch
>> >> > part is really unsafe and the safety requirement for that.
>> >>=20
>> >> Yeah. But then we should do that before merging :)
>> >>=20
>> >
>> > Well, who's talknig about merging? ;-) I thought we just began reviewi=
ng
>> > here ;-)
>>=20
>> I understand [PATCH] emails as "I want to merge this" and [RFC PATCH] as
>
> But it doesn't mean "merge as it is", right? I don't think either I or
> Mitchell implied that, I'm surprised that you had to mention that,

Yeah that is true, but it at least shows the intention :)

> also based on "I often mute those" below, making it "[PATCH]" seems to
> be a practical way to get more attention if one wants to get some
> reviews.

That is true, I do usually read the titles of RFC patches though and
sometimes take a look eg your atomics series.

>> "I want to talk about merging this". It might be that I haven't seen the
>> RFC patch series, because I often mute those.
>>=20
>
> Well, then you cannot blame people to move from "RFC PATCH" to "PATCH"
> stage for more reviews, right? And you cannot make rules about what the
> difference between [PATCH] and [RFC PATCH] if you ignore one of them ;-)

I'm not trying to blame anyone. I saw a lot of unsafe in the example and
thought "we can do better" and since I haven't heard any sufficient
arguments showing that it's impossible to improve, we should do some
design work.

>> >> >> I'm not familiar with percpu, but from the name I assumed that it'=
s
>> >> >> "just a variable for each cpu" so similar to `thread_local!`, but =
it's
>> >> >> bound to the specific cpu instead of the thread.
>> >> >>=20
>> >> >> That in my mind should be rather easy to support in Rust at least =
with
>> >> >> the thread_local-style API. You just need to ensure that no refere=
nce
>> >> >> can escape the cpu, so we can make it `!Send` & `!Sync` + rely on =
klint
>> >> >
>> >> > Not really, in kernel, we have plenty of use cases that we read the
>> >> > other CPU's percpu variables. For example, each CPU keeps it's own
>> >> > counter and we sum them other in another CPU.
>> >>=20
>> >> But then you need some sort of synchronization?
>> >>=20
>> >
>> > Right, but the synchronization can exist either in the percpu operatio=
ns
>> > themselves or outside the percpu operations. Some cases, the data type=
s
>> > are small enough to fit in atomic data types, and operations are just
>> > load/store/cmpxchg etc, then operations on the current cpu and remote
>> > read will be naturally synchronized. Sometimes extra synchronization i=
s
>> > needed.
>>=20
>> Sure, so we probably want direct atomics support. What about "extra
>> synchronization"? Is that using locks or RCU or what else?
>>=20
>
> It's up to the users obviously, It could be some sort of locking or RCU,
> it's case by case.

Makes sense, what do you need in the VMS driver?

>> > Keyword find all these cases are `per_cpu_ptr()`:
>> >
>> > 	https://elixir.bootlin.com/linux/v6.15.6/A/ident/per_cpu_ptr
>>=20
>> Could you explain to me how to find them? I can either click on one of
>> the files with horrible C preprocessor macros or the auto-completion in
>> the search bar. But that one only shows 3 suggestions `_hyp_sym`,
>> `_nvhe_sym` and `_to_phys` which doesn't really mean much to me.
>>=20
>
> You need to find the usage of `per_cpu_ptr()`, which is a function that
> gives you a pointer to a percpu variable on the other CPU, and then
> that's usually the case where a "remote" read of percpu variable
> happens.

Ahh gotcha, I thought you pointed me to some definitions of operations
on percpu pointers.

---
Cheers,
Benno

