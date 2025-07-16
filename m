Return-Path: <linux-kernel+bounces-734075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBB3B07CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 20:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1679F7A046D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 18:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F4529DB71;
	Wed, 16 Jul 2025 18:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIuvixBK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DDC29C353;
	Wed, 16 Jul 2025 18:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690156; cv=none; b=lUG9EdvGMWcQ/zIFdxNkefs/Enuc/OJhM1yLFLZG50qTZzJ8NUN2wabEIbf66U1c+D29wvZTFSF/g/3XPvqnmxbrqLlgx7zpPvUauklygDdAhfy/TjEvL2Hwh+kyaDgBHS8tIDQxWYL5hdhaq12Q91J+hBa3HgGbJ5bMJzYRUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690156; c=relaxed/simple;
	bh=OeN+yejltezB0oHCvVEcUaFL4aGPQNlK36DE8/EOhCM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=E0Brl2T7Rkq8FFDa6e53meMzgAVaeChjO3dSq7JXBEurxTt7IX0NIu63v+YtcsSfVbX8IioBme0rk+n6+dUY3fpajEdZ9IPHmHyj28TfRZYy7cQ0IRgopgl7scndnwkzigD75IzV7FMaLf2tyvUfEJb0qolncAqj5q58Xo7ssQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIuvixBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B324C4CEF5;
	Wed, 16 Jul 2025 18:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752690155;
	bh=OeN+yejltezB0oHCvVEcUaFL4aGPQNlK36DE8/EOhCM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=tIuvixBKvt01pdq5U/fT9qlDLFCiTTfA+FTWSfwDLnEZX39iX/+1NWnADEFFr3q0F
	 Alzef/ZpSKZo+smrTOx82AmeXYGIbViLpwDwhxXYowwEyAPShmRDNUjPF+wqQzrBwE
	 EZQocoYx2mZ7bdUHPWXFF5psb5ij5bb5VR7O528HMmyvY+WqV4S8VJ5adOf1GybLW7
	 /FZ5zkmg9aMXmM5B5D3NUYWrzRKOHTYxgEdWrFbPwBetJopEydrlxQ8FBkI9/zazcr
	 2Owi2whXSHxEyPmZS1SQX+TLZW393t2718FjSL97EkKARJlI52M68T4dyP0iO1XfJh
	 p7+zJ4W3ZtTFw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 20:22:30 +0200
Message-Id: <DBDOSZJJGD99.3FX4Y4MDJR37O@kernel.org>
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
References: <68762e19.170a0220.33e203.a0b7@mx.google.com>
 <DBCLFG5F4MPW.2LF4T3KWOE12R@kernel.org> <aHZhcNCayTOQhvYh@Mac.home>
 <DBCR1OCNYAUW.1VLAY1HWCHLGI@kernel.org> <aHaCUFNUd_mErL7S@Mac.home>
 <DBCTCZ5HUZOF.2DJX63Q0VWWFN@kernel.org> <aHbJUfcsjHA92OlE@tardis-2.local>
 <DBDESSQOH6MB.2I4GNLPBP5ORJ@kernel.org> <aHfGV3l4NCmYSRuv@Mac.home>
 <DBDNIAW09Z7W.EXO6C61HCNVP@kernel.org> <aHfm1gcdRZbVnwE9@Mac.home>
In-Reply-To: <aHfm1gcdRZbVnwE9@Mac.home>

On Wed Jul 16, 2025 at 7:52 PM CEST, Boqun Feng wrote:
> On Wed, Jul 16, 2025 at 07:21:32PM +0200, Benno Lossin wrote:
>> On Wed Jul 16, 2025 at 5:33 PM CEST, Boqun Feng wrote:
>> > On Wed, Jul 16, 2025 at 12:32:04PM +0200, Benno Lossin wrote:
>> >> On Tue Jul 15, 2025 at 11:34 PM CEST, Boqun Feng wrote:
>> >> > On Tue, Jul 15, 2025 at 07:44:01PM +0200, Benno Lossin wrote:
>> >> > [...]
>> >> >> >> >
>> >> >> >> > First of all, `thread_local!` has to be implemented by some s=
ys-specific
>> >> >> >> > unsafe mechanism, right? For example on unix, I think it's us=
ing
>> >> >> >> > pthread_key_t:
>> >> >> >> >
>> >> >> >> > 	https://pubs.opengroup.org/onlinepubs/009695399/functions/pt=
hread_key_create.html
>> >> >> >> >
>> >> >> >> > what we are implementing (or wrapping) is the very basic unsa=
fe
>> >> >> >> > mechanism for percpu here. Surely we can explore the design f=
or a safe
>> >> >> >> > API, but the unsafe mechanism is probably necessary to look i=
nto at
>> >> >> >> > first.
>> >> >> >>=20
>> >> >> >> But this is intended to be used by drivers, right? If so, then =
we should
>> >> >> >
>> >> >> > Not necessarily only for drivers, we can also use it for impleme=
nting
>> >> >> > other safe abstraction (e.g. hazard pointers, percpu counters et=
c)
>> >> >>=20
>> >> >> That's fair, but then it should be `pub(crate)`.
>> >> >>=20
>> >> >
>> >> > Fine by me, but please see below.
>> >> >
>> >> >> >> do our usual due diligence and work out a safe abstraction. Onl=
y fall
>> >> >> >> back to unsafe if it isn't possible.
>> >> >> >>=20
>> >> >> >
>> >> >> > All I'm saying is instead of figuring out a safe abstraction at =
first,
>> >> >> > we should probably focus on identifying how to implement it and =
which
>> >> >> > part is really unsafe and the safety requirement for that.
>> >> >>=20
>> >> >> Yeah. But then we should do that before merging :)
>> >> >>=20
>> >> >
>> >> > Well, who's talknig about merging? ;-) I thought we just began revi=
ewing
>> >> > here ;-)
>> >>=20
>> >> I understand [PATCH] emails as "I want to merge this" and [RFC PATCH]=
 as
>> >
>> > But it doesn't mean "merge as it is", right? I don't think either I or
>> > Mitchell implied that, I'm surprised that you had to mention that,
>>=20
>> Yeah that is true, but it at least shows the intention :)
>>=20
>> > also based on "I often mute those" below, making it "[PATCH]" seems to
>> > be a practical way to get more attention if one wants to get some
>> > reviews.
>>=20
>> That is true, I do usually read the titles of RFC patches though and
>> sometimes take a look eg your atomics series.
>>=20
>> >> "I want to talk about merging this". It might be that I haven't seen =
the
>> >> RFC patch series, because I often mute those.
>> >>=20
>> >
>> > Well, then you cannot blame people to move from "RFC PATCH" to "PATCH"
>> > stage for more reviews, right? And you cannot make rules about what th=
e
>> > difference between [PATCH] and [RFC PATCH] if you ignore one of them ;=
-)
>>=20
>> I'm not trying to blame anyone. I saw a lot of unsafe in the example and
>> thought "we can do better" and since I haven't heard any sufficient
>> arguments showing that it's impossible to improve, we should do some
>> design work.
>>=20
>
> I agree with you, and I like what you're proposing, but I think design
> work can be done at "PATCH" stage, right? And sometimes, it's also OK to
> do some design work even at some version like "v12" ;-)

Yeah of course. The thing is just that nobody asked why there was unsafe
and thus I got the impression that people thought this would be a good
abstraction for percpu. (don't take from this that it's bad :)

> Also I want to see more forward-progress actions about the design work
> improvement. For example, we can examine every case that makes
> unsafe_get_per_cpu!() unsafe, and see if we can improve that by typing
> or something else. We always can "do better", but the important part is
> how to get there ;-)

Yeah that would be a starting point :)

>> >> >> >> I'm not familiar with percpu, but from the name I assumed that =
it's
>> >> >> >> "just a variable for each cpu" so similar to `thread_local!`, b=
ut it's
>> >> >> >> bound to the specific cpu instead of the thread.
>> >> >> >>=20
>> >> >> >> That in my mind should be rather easy to support in Rust at lea=
st with
>> >> >> >> the thread_local-style API. You just need to ensure that no ref=
erence
>> >> >> >> can escape the cpu, so we can make it `!Send` & `!Sync` + rely =
on klint
>> >> >> >
>> >> >> > Not really, in kernel, we have plenty of use cases that we read =
the
>> >> >> > other CPU's percpu variables. For example, each CPU keeps it's o=
wn
>> >> >> > counter and we sum them other in another CPU.
>> >> >>=20
>> >> >> But then you need some sort of synchronization?
>> >> >>=20
>> >> >
>> >> > Right, but the synchronization can exist either in the percpu opera=
tions
>> >> > themselves or outside the percpu operations. Some cases, the data t=
ypes
>> >> > are small enough to fit in atomic data types, and operations are ju=
st
>> >> > load/store/cmpxchg etc, then operations on the current cpu and remo=
te
>> >> > read will be naturally synchronized. Sometimes extra synchronizatio=
n is
>> >> > needed.
>> >>=20
>> >> Sure, so we probably want direct atomics support. What about "extra
>> >> synchronization"? Is that using locks or RCU or what else?
>> >>=20
>> >
>> > It's up to the users obviously, It could be some sort of locking or RC=
U,
>> > it's case by case.
>>=20
>> Makes sense, what do you need in the VMS driver?
>>=20
>
> In VMBus driver, it's actually isolate, i.e. each CPU only access it's
> own work_struct, so synchronization between CPUs is not needed.

I see, so we could either just start out with no sync support or --
which I would prefer -- get a list of the most common use-cases and
implement those too (or at least design the first part compatibly with
further extensions).

---
Cheers,
Benno

