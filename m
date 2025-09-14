Return-Path: <linux-kernel+bounces-815684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E9B569C9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2825E189E5D6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D46D229B2E;
	Sun, 14 Sep 2025 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyJ9u22k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7702264C6;
	Sun, 14 Sep 2025 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757860970; cv=none; b=i/yyF6fzdqFgij1Fcnvlpm3vRHrpktJe3I5zmfI//Z6KI3fjx4MyGru2yv+QA38GJmPzZCFGgrSLog1GUTNn6hw4TuatKKzWpx8yIeIVyo7TSR1IUQMxwUl8wtowNpvQPIdREgKHpQe5RtNaWFLQJGCcz7xQNO6VM5ObQDsU9XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757860970; c=relaxed/simple;
	bh=PzQNP+iXhbAYk0sG25Qch7JW6l/swG0JTlYB7VYGAkA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=pvIVnJiFMwuqDuLpFPMszpF0A5s+RWRWZEqD35Us8VbmyiGNVHym99YRnRm/CcM0krK9RSEeKTV+0XZRnKuOjb1c4LtVz0CzHdHBQJctAdSt+G6Q3pzp7f1YFp/zu8Sf8DV4Cgg1dEWaWlQ30V7Ydr7AdUaYHMVnOjt7xjrAp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyJ9u22k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FD2C4CEF0;
	Sun, 14 Sep 2025 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757860970;
	bh=PzQNP+iXhbAYk0sG25Qch7JW6l/swG0JTlYB7VYGAkA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=SyJ9u22kZEM6Iy0bBBL385iaJikOGqSCcxn6kHCIXdE55aDFRSzFnWoOFyM8oO2X0
	 SIL5oADcHfk8ScoXvbqrIvH88vkT7H3zunH9yAL589yrZK/X/QOED+GFejo1JvVYg7
	 eV9Yeo3L2S++pidfDuVhbjGcdf0vd/c43fH5nZTCgI4Ri77mgfZdUaVIQj8XG6xfy1
	 cn2GN9mUONavKphnFQbAXXjp/iq0y4OBSwwEh3oCRldFO1PpmE5jRUkaAxcy/eAilS
	 ZftbG+SKU7MEC8+hUcYjMkalaZWheyBM3F+hIagCwjlSVt4O+l1wwEJydCF0uO+TsU
	 4k38Rf3H52BkQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Sep 2025 16:42:40 +0200
Message-Id: <DCSLPCSQRYOY.3BX3008H5CVQP@kernel.org>
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 02/12] gpu: nova-core: move GSP boot code to a
 dedicated method
From: "Benno Lossin" <lossin@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20250911-nova_firmware-v5-2-5a8a33bddca1@nvidia.com>
 <e1755470-587b-4a43-8171-3d031b7fb4f4@kernel.org>
 <DCPYQNZG1OJK.2EE4JWJAROK57@nvidia.com>
 <ce74db34-77bc-4207-94c8-6e0580189448@kernel.org>
 <DCQ074EMFNIK.1OJLWJXWZLDXZ@nvidia.com> <20250913010226.GA1478480@joelbox2>
 <DCRPJKD0UHDQ.IOWSOB2IK06E@kernel.org> <20250913171357.GA1551194@joelbox2>
 <CANiq72n50MaMXeWdwvVOEQd3YEHbDRqeeRzbdY8hPnePtq-hnw@mail.gmail.com>
 <b1aea815-68b4-4d6c-9e12-3a949ee290c6@nvidia.com>
 <20250913220625.GA1564550@joelbox2> <DCS59IDCIKH1.2M3I6H0NVD0RG@nvidia.com>
In-Reply-To: <DCS59IDCIKH1.2M3I6H0NVD0RG@nvidia.com>

On Sun Sep 14, 2025 at 3:49 AM CEST, Alexandre Courbot wrote:
> On Sun Sep 14, 2025 at 7:06 AM JST, Joel Fernandes wrote:
>> On Sat, Sep 13, 2025 at 02:29:54PM -0700, John Hubbard wrote:
>>> Yes. It's only "paranoia" if the code is bug-free. So Rust itself
>>> naturally will look "a little" paranoid, that's core to its mission. :)
>>
>> This seems to be taken out-of-context, I said "paranoia" mainly because =
I am
>> not sure if excessive use of pinning may tend to cause other problems. T=
he
>> "paranoia" is about over-usage of pinning. Personally, I don't prefer to=
 pin
>> stuff in my code until I absolutely need to, or when I start having need=
s for
>> pinning, like using spinlocks. Maybe I am wrong, but the way I learnt Ru=
st,
>> data movement is baked into it. I am not yet confident pinning will not
>> constraint Rust code gen -- but that could just be a part of my learning
>> journey that I have to convince myself it is Ok to do so in advance of
>> actually requiring it even if you simply hypothetically anticipate needi=
ng it
>> (as Danilo pointed out that in practice this is not an issue and I do te=
nd to
>> agree with Miguel and Danilo because they are usually right :-D). I am
>> researching counter examples :-)
>
> You can look at the definition for `Pin` in [1], but it is so short we
> can paste it here:
>
>     #[repr(transparent)]
>     #[derive(Copy, Clone)]
>     pub struct Pin<Ptr> {
>         pointer: Ptr,
>     }
>
> There isn't much getting in the way of optimized code generation - its
> purpose is simply to constraint the acquisition of mutable references to
> prevent moving the pointee out.
>
> I started this patchset a little bit skeptical about the need to pin so
> many things, but after seeing the recent additions to `pin_init` and
> rewriting the code as Danilo suggested, it starteds to click. The
> supposed restrictions are in practice avoided by embracing the concept
> fully, and in the end I got that feeling (familiar when writing Rust) of
> being guided towards the right design - a bit like playing bowling with
> gutter guards.

That's a great way to put it -- I had a similar experience when writing
pin-init and thinking about it purely theoretically. Good to see that it
works out in practice (and continues to do so :).

> Yes, that means redesigning and rebasing our code, but that's also the
> cost of learning a new language.
>
> And yes, things can still be a little bit rough around the edges, but
> there is awareness and action taken to address these issues, at the
> compiler level when relevant. This makes me confident for the future.

If you have an issue that you cannot work around, or something that
looks off, let me know. Maybe that's something that pin-init can deal
better with or we can have another library that helps with it. After all
pin-init is specially tailored for the kernel to work :)

---
Cheers,
Benno

