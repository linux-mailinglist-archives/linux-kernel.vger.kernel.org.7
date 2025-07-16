Return-Path: <linux-kernel+bounces-733351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C040DB07379
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF741C251F8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5AB27C84B;
	Wed, 16 Jul 2025 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvyQTHES"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4528585260;
	Wed, 16 Jul 2025 10:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752661930; cv=none; b=G6JQMXNENzylmPBk0kud6Ad2ZHTrNGBwr90q2L2LB9bg465KD1tgrWEhzdcT8zjrlM1onLDwiJ8JFtxR5wH3o7XUFEB8BUVDoi74DN2RZzoS/Uxnfe52o4/u9S4jBYDwDW/VlUQZIhA9E77fjqLo1yGexoeRsBSFhxfrtPL350k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752661930; c=relaxed/simple;
	bh=4MZ1bakhn2IrJDIzOvrnSvSgvN0+Mb+1IfcHUPCpa+Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qlko8f76C4JcWbgPTMAb/hSoSX8R6BDM2kXmFizKhJqrr+DuhlqzQbfY3o64TGZIuynXboMfDtC5/vm3Muxzf5M4h6Sy9eEjlJ9wIR1HEOh6WVOsow/hm3wk3hzzrOMjoltNC8K9pn2oHjDvs00viTtreVW04rcmBQdsDMDaSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvyQTHES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D3AC4CEF0;
	Wed, 16 Jul 2025 10:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752661929;
	bh=4MZ1bakhn2IrJDIzOvrnSvSgvN0+Mb+1IfcHUPCpa+Y=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=bvyQTHESXLlAvBKivoq3pKLQrlaqma74imBvhg2c7VhpXXYKCTvuCpjn3U7ul+S4e
	 dRtU2UQjMYlZIMH/ACKSn4+RDTa1gwitf0B+s/snWu0c7PrsG9Fn3sqUmxx3hDdgkL
	 cKKgFsWEXs64aME/J2OPZNOygILHVpNuAuIIP3tS1RsmtMQOPopjO3uL8qdtqq9Jr4
	 rxSCjetOzvZ4QQOJnl17nfHburlktXBzc05hje4nqrV1RaWe8EJ08FbREe32fh+fkL
	 HndYM7E2MRWD1y+I/Zelma+KOp9ipCJjazfoXV8Am8g+XUCYxeww3tbbS+ofrSVtvi
	 CAzBKjJ3hTskg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 12:32:04 +0200
Message-Id: <DBDESSQOH6MB.2I4GNLPBP5ORJ@kernel.org>
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
References: <20250712-rust-percpu-v2-0-826f2567521b@gmail.com>
 <20250712-rust-percpu-v2-3-826f2567521b@gmail.com>
 <DBATM1CUS704.28MKE6BIBQB7G@kernel.org>
 <68762e19.170a0220.33e203.a0b7@mx.google.com>
 <DBCLFG5F4MPW.2LF4T3KWOE12R@kernel.org> <aHZhcNCayTOQhvYh@Mac.home>
 <DBCR1OCNYAUW.1VLAY1HWCHLGI@kernel.org> <aHaCUFNUd_mErL7S@Mac.home>
 <DBCTCZ5HUZOF.2DJX63Q0VWWFN@kernel.org> <aHbJUfcsjHA92OlE@tardis-2.local>
In-Reply-To: <aHbJUfcsjHA92OlE@tardis-2.local>

On Tue Jul 15, 2025 at 11:34 PM CEST, Boqun Feng wrote:
> On Tue, Jul 15, 2025 at 07:44:01PM +0200, Benno Lossin wrote:
> [...]
>> >> >
>> >> > First of all, `thread_local!` has to be implemented by some sys-spe=
cific
>> >> > unsafe mechanism, right? For example on unix, I think it's using
>> >> > pthread_key_t:
>> >> >
>> >> > 	https://pubs.opengroup.org/onlinepubs/009695399/functions/pthread_=
key_create.html
>> >> >
>> >> > what we are implementing (or wrapping) is the very basic unsafe
>> >> > mechanism for percpu here. Surely we can explore the design for a s=
afe
>> >> > API, but the unsafe mechanism is probably necessary to look into at
>> >> > first.
>> >>=20
>> >> But this is intended to be used by drivers, right? If so, then we sho=
uld
>> >
>> > Not necessarily only for drivers, we can also use it for implementing
>> > other safe abstraction (e.g. hazard pointers, percpu counters etc)
>>=20
>> That's fair, but then it should be `pub(crate)`.
>>=20
>
> Fine by me, but please see below.
>
>> >> do our usual due diligence and work out a safe abstraction. Only fall
>> >> back to unsafe if it isn't possible.
>> >>=20
>> >
>> > All I'm saying is instead of figuring out a safe abstraction at first,
>> > we should probably focus on identifying how to implement it and which
>> > part is really unsafe and the safety requirement for that.
>>=20
>> Yeah. But then we should do that before merging :)
>>=20
>
> Well, who's talknig about merging? ;-) I thought we just began reviewing
> here ;-)

I understand [PATCH] emails as "I want to merge this" and [RFC PATCH] as
"I want to talk about merging this". It might be that I haven't seen the
RFC patch series, because I often mute those.

>> >> I'm not familiar with percpu, but from the name I assumed that it's
>> >> "just a variable for each cpu" so similar to `thread_local!`, but it'=
s
>> >> bound to the specific cpu instead of the thread.
>> >>=20
>> >> That in my mind should be rather easy to support in Rust at least wit=
h
>> >> the thread_local-style API. You just need to ensure that no reference
>> >> can escape the cpu, so we can make it `!Send` & `!Sync` + rely on kli=
nt
>> >
>> > Not really, in kernel, we have plenty of use cases that we read the
>> > other CPU's percpu variables. For example, each CPU keeps it's own
>> > counter and we sum them other in another CPU.
>>=20
>> But then you need some sort of synchronization?
>>=20
>
> Right, but the synchronization can exist either in the percpu operations
> themselves or outside the percpu operations. Some cases, the data types
> are small enough to fit in atomic data types, and operations are just
> load/store/cmpxchg etc, then operations on the current cpu and remote
> read will be naturally synchronized. Sometimes extra synchronization is
> needed.

Sure, so we probably want direct atomics support. What about "extra
synchronization"? Is that using locks or RCU or what else?

> Keyword find all these cases are `per_cpu_ptr()`:
>
> 	https://elixir.bootlin.com/linux/v6.15.6/A/ident/per_cpu_ptr

Could you explain to me how to find them? I can either click on one of
the files with horrible C preprocessor macros or the auto-completion in
the search bar. But that one only shows 3 suggestions `_hyp_sym`,
`_nvhe_sym` and `_to_phys` which doesn't really mean much to me.

---
Cheers,
Benno

