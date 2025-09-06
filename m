Return-Path: <linux-kernel+bounces-804349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A71BB472B2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE967BDF7D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3180B226861;
	Sat,  6 Sep 2025 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="C1QJQ72b"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D701221DA5;
	Sat,  6 Sep 2025 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757173620; cv=pass; b=LN5hvWasFah4dhfJ677cpAnQQBSFZ6OFNvwjRex8lybarhVGdsmoe12UmBlzURPlMvjpeJo9fWL+U75W5XNlAmjwBR10xVBS5z2cvyWrufdrvwc4vNLRcn7iMUFXVYp29lMqmLftylTRJVNvPb17SXk88vMUMhPm7/K2pBHoHus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757173620; c=relaxed/simple;
	bh=VA7kkpTRw1dX65/GV/SaJakAPJCKyDGAQtNokg2YDCI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bk4UE+UDZyZm0E5D5EsggA/3tdu8XhT4z/tpIUzeM4MWFce9kJAcb4CjROlUFI/vey+dOzTylHX2ox1SZ2IIDcJ5wyaa95lucGHkka5ilBX4A9vMANhn6pFt0ICblCyhY3C0g/KnmPgjc8F03Jw2mAtE3yjfbbex6/T/K3XXU/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=C1QJQ72b; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757173600; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L8svGQZhM8ULK+IbmqYBzLQJhWGG7xrcDGxSq9mwb/qYgr6/DtvtulwOrsia9DxkIBV4MqhkMbHc7POK5xcA4c6aM9Z3QcHRO8ZhSEI7TuRHWlcgekH5OPvMw3lFG1QrW4tl3QkwDf8cfcuuPv6cM5v+qlmm2E6kBwAraRE8ZGM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757173600; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VA7kkpTRw1dX65/GV/SaJakAPJCKyDGAQtNokg2YDCI=; 
	b=be6UgmwDq6moPPE1daGzn7rXVVc5JWEQDepqmKZDTmUYDLTgH5urJ9wlxtdTZ1iUdgzAmDo0DZd6xejcTLNFBE2F/gmCrmxS5cn/2MJePEvQtojI83vhfPfDLYQS/G17tOwuA0waK87lD5pzbcZ2kv9rueT/Z17FlkxmqDPCx1E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757173600;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=VA7kkpTRw1dX65/GV/SaJakAPJCKyDGAQtNokg2YDCI=;
	b=C1QJQ72bIgmw/olAKUwaIo7QtMzbkXGLNG3iPmw+oynErQZyzV4vtkg66KNOon2b
	KEwnLGHrj7bVxbqr4RpQWtgU37wu0wxjSLQ1BaoCWcT/Qa+hmQDuOxPftUjvMLKf0M0
	/j4xGyHQ4F+R6h5hB4RIK6ZgG0KXqR/Gi/7Ct1QY=
Received: by mx.zohomail.com with SMTPS id 1757173596944669.3937713519095;
	Sat, 6 Sep 2025 08:46:36 -0700 (PDT)
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
In-Reply-To: <DCLTJMIAMCVL.35U236MMS5CCK@kernel.org>
Date: Sat, 6 Sep 2025 12:46:20 -0300
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
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Igor Korotin <igor.korotin.linux@gmail.com>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-usb@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <85B643A9-1657-43ED-BE98-BE7E502D08DA@collabora.com>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
 <2025090618-smudgy-cringing-a7a4@gregkh>
 <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
 <2025090601-iron-glitter-c77d@gregkh>
 <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>
 <DCLQZZHU42HN.4Y4PP0PPR10O@kernel.org>
 <9657C897-087E-4544-849B-964E99D95A50@collabora.com>
 <DCLTJMIAMCVL.35U236MMS5CCK@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 6 Sep 2025, at 12:22, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Sat Sep 6, 2025 at 4:50 PM CEST, Daniel Almeida wrote:
>> So far I see a pattern where sample drivers count as users. This has =
been the
>> case, for example, for rust_dma.rs. I was under the impression that =
the same
>> would apply here. Although I do realize that there were plans for dma =
code
>> other than rust_dma.rs, of course.
>=20
> This isn't the case, we have those sample drivers to make it easy to =
review the
> the code and illustrate in an isolated context how it works. But, =
there has
> always been a "real" user behind that. In the case of the DMA work it =
was Nova.

I see, thanks for clarifying!

>=20
>> As for Nova and Tyr, these are projects with a lot of big companies =
involved.
>>=20
>> They were able to break this chicken and egg situation in part due to =
that,
>> because companies were willing to allocate engineers for both the =
drivers _and_
>> the required infrastructure. Unless the same can be said for USB, =
media or any
>> other subsystems, I don't see it happening.
>=20
> Well, this is true for Nova and Tyr, but I disagree that this is the =
reason we
> were able to break the chicken and egg problem.
>=20
> For instance, the initial lift around the driver core, PCI, I/O, etc.
> infrastructure was done by me, a single person. This could have been =
happening
> in the context of a very simple and small driver as well, rather than =
a big GPU
> driver with lots of companies and people involved.
>=20
> Igor (Cc) is doing the initial lift for I2C and Michal (Cc) for PWM =
for
> instance.
>=20
> So, I see those things happen and I don't think that such initial =
lifting
> necessarily needs big companies with dozens of engineers being =
involved.

It=E2=80=99s not about the number of people, or the work being out of =
reach for a
single person, but more of someone asking themselves why it should be =
them to
do it when there=E2=80=99s no big project like Nova or Tyr to justify it =
and employ
them to do it all, vs employ them only for the actual drivers but not =
for the
abstractions. Or if they=E2=80=99re working on their free time, it =
becomes even
harder to justify spending energy on the abstractions if all they want =
is
to write a driver.

But if anyone got the impression that it is impossible to do it, my bad. =
It
isn=E2=80=99t.

>=20
> If we know people who want to write drivers for a subsystem that =
doesn't yet
> have Rust infrastructure (such as USB), let's encourage them to get =
started /
> involved anyways and let's help them as they go.
>=20
> But also please don't get me wrong, I understand and very much =
appreciate you
> want to get the ball rolling, but let's not discourage people by =
making it
> sounds as if it would be impossible for individuals.
>=20

Yeah, point taken :)

As I said to Greg above, I=E2=80=99m here to help if anyone wants to =
write a USB
driver. Those interested are free to reach out to me and we will work =
together
to merge the required abstractions with a real user in mind. Hopefully =
this
encourages others to join in this work :)


=E2=80=94 Daniel=

