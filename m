Return-Path: <linux-kernel+bounces-804300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92635B4717F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9961C23A23
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071BF1EF397;
	Sat,  6 Sep 2025 14:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Ijuxr2VC"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653E13FBB3;
	Sat,  6 Sep 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757170286; cv=pass; b=BQuSWNf+MKLFJWuKjynUijxU+MMM/ouMzRGGCSchO86op2PPLfALABLWYIhejjrI//7+24DuZmK9et34mrFVCdnRgdVDo6qMPTe0526ZX0EOEjBCaE+Tjf9o53VHpkOUr4t9oovhqSp11/218dH0hL8MYF177fdHzxeWrGUksEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757170286; c=relaxed/simple;
	bh=vtt3+yku9UVk04Ss05FrOniUhbb4snsL5iJsqiVvet8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RKqfYkaWeuMWy33Fg2bvNcZl4C91Zy7Qebtit1vmGZmbREIcOBXAxEr1i0t9GSAQnhgaIYKgatsvRWwugywAg3+xr28TJmjQ1ighP4AUNWRzio2s+Z+KKvBt8ZjHmbR9AtNj5ZYTqZmbH7zWMOIJKAyuAao95Q21/lr/iQfAk1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Ijuxr2VC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757170269; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UvRrrLYnoNaE3nwa0VE0ebLyiuvCwRAODWnYkfBadqsowGFJQ5WA3oYQNGKoxVY4Y1D0xq+QJbNcIfPuZrawF5uJ69zVrtgVIq9nmCYZrnhQSP7pwTBwFcqI1JQmeyDABC456ng/oK0B1KytxpdCNv2OsCUV8O3d6me1GXBiZog=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757170269; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VGqQTPS0dGyDSq3uWQWj0ODgui49CmJ1bsZcGVpP9Qg=; 
	b=B2QMAAgvor0/zUlLTlBxJzTbedZoZ1B9iQGJwN8Xm/VbgUyNSpuOhy8km2+yuTdKkzTwusps10XH2liR3uMn/ljhdQWIvqVLhcehJ3IkYb5k2qxPY0KO2su+FS5g/+41e7/7K+DBoeUXdj3d4GcqmkXDmNRCI2HDFQ8RbDWN0PM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757170269;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=VGqQTPS0dGyDSq3uWQWj0ODgui49CmJ1bsZcGVpP9Qg=;
	b=Ijuxr2VC3yPNSyXKEbBPgG0Ks9Ihqz7pxDt2gjQM78jiYByQQSgd1xrY8vq/v7Gq
	tfi5MeLt+GiDbDN5AVRBXraIiKWSb+AW/JIs9cwvtZZ7ewUU5FC8jmpTuj+S+QempqQ
	Ck+a4HHMT+q3c0e9qw7u+Bx4h2QJak+T4Z4Qs7Q4=
Received: by mx.zohomail.com with SMTPS id 1757170267380100.64996508403033;
	Sat, 6 Sep 2025 07:51:07 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 2/2] samples: rust: add a USB driver sample
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DCLQZZHU42HN.4Y4PP0PPR10O@kernel.org>
Date: Sat, 6 Sep 2025 11:50:50 -0300
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-usb@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9657C897-087E-4544-849B-964E99D95A50@collabora.com>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
 <2025090618-smudgy-cringing-a7a4@gregkh>
 <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
 <2025090601-iron-glitter-c77d@gregkh>
 <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>
 <DCLQZZHU42HN.4Y4PP0PPR10O@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Danilo,

> On 6 Sep 2025, at 10:22, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Sat Sep 6, 2025 at 2:41 PM CEST, Daniel Almeida wrote:
>>>>=20
>>>> I thought that an iterative approach would work here, i.e.: merge =
this, then
>>>> URBs, then more stuff, etc.
>>>=20
>>> Ah, that makes sense, I didn't realize you want that here.  What USB
>>> device do you want to write a rust driver for?  Are you going to =
need
>>> bindings to the usb major number, or is it going to talk to some =
other
>>> subsystem instead?
>>>=20
>>> Right now, these bindings don't really do anything USB specific at =
all
>>> except allow a driver to bind to a device.
>>>=20
>>> thanks,
>>>=20
>>> greg k-h
>>=20
>> To be honest, I'm trying to pave the way for others.
>>=20
>> I often hear people saying that they would look into Rust drivers if =
only they
>> did not have to write all the surrounding infrastructure themselves. =
On the
>> other hand, there is no infrastructure because there are no drivers.
>=20
> I think saying that there is no infrastructure for writing Rust =
drivers is not
> accurate:
>=20
> We already have lots of infrastructure in place, such as device / =
driver core
> infrastructure, PCI, platform (with OF and ACPI), faux and auxilirary =
bus
> infrastructure, I/O, workqueues, timekeeping, cpufreq, firmware, DMA =
and a lot
> more.
>=20
> Not to forget the absolute core primitives, such as kernel allocators, =
xarray,
> locking infrastructure or very recently maple tree and LKMM atomics.
>=20
> Besides that we also have a lot of infrastructure that we do not have =
in C
> because it's simply not possible or applicable.
>=20
> However, it is in fact true that there is no USB infrastructure yet.

Ah yes, of course there=E2=80=99s plenty of things but this is =
specifically about
USB. I worked on a few of those so I'm not denying them, I guess I =
should have
written this more clearly :)

I=E2=80=99ve also been told the same about media drivers. For example, =
someone
trying to write a USB media driver stares at work needed to just _start_ =
doing
what they had initially planned and simply gives up. It creates a =
scenario
where people continuously wait on each other to do the "heavy work", =
i.e.: to
come up with the common code/abstractions.

So far I see a pattern where sample drivers count as users. This has =
been the
case, for example, for rust_dma.rs. I was under the impression that the =
same
would apply here. Although I do realize that there were plans for dma =
code
other than rust_dma.rs, of course.

>=20
>> It's a chicken and egg problem that I am trying to solve.
>=20
> This is exactly why we develop Nova in-tree, such that we have a =
justification
> for adding all this infrastructure.
>=20
> Lot's of the stuff I listed above originates from that and I think the =
Nova
> project has proven that we can break this chicken and egg problem. I =
think
> one proof for that is that Tyr follows the approach.
>=20
> However, I agree that it still remains that someone (i.e. some driver) =
has to
> take the burden of doing the "heavy lifting" for a particular =
subsystem.

As for Nova and Tyr, these are projects with a lot of big companies =
involved.

They were able to break this chicken and egg situation in part due to =
that,
because companies were willing to allocate engineers for both the =
drivers _and_
the required infrastructure. Unless the same can be said for USB, media =
or any
other subsystems, I don't see it happening. Also, even if there is a =
company
interested, smaller ones are not willing to work on the infrastructure =
either,
only on the actual end results (i.e.: drivers).

That's just my humble opinion, of course.



