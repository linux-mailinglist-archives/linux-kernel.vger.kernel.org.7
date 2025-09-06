Return-Path: <linux-kernel+bounces-804318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8867B47201
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 17:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8003A916F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 15:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6D7221F1C;
	Sat,  6 Sep 2025 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AC/KHFZn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B71C4A0A;
	Sat,  6 Sep 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757172165; cv=none; b=Jq55QkmYSA2K1tAa3tYbLwcKuWruEmDsqKjY7qE4E5yuIXuW7AOi5tt+egrEu2w7elYfZ+qM5PEqmfmHrLCEV9+xYTEkgrQZ8weAChatB4Q92k3Ia/Fw8O+haMM42EwDkKRE/T7r0Kc2HzDS2SOKdSaHGUOBA+GRn6Gh+3nXC5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757172165; c=relaxed/simple;
	bh=2Cc+y+nYgnXueTnsUZYSLj+5OAuyyh/BgYgWxkTKnGg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=kdX4tueBwAn99IpQL/EDu/UcQ4dKT5PAeSpeth8quV9z/p2ihepTO3D06t48KP9/FQu/LOGA404IrN3LtJntUIpcJ9J/V+nszZFgiWzFrhRMbBOKkIy6KzF98ny0/3qqeBwDNksso3eGlFFWw4vNXdr7virojx1XUi3oyhjDSGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC/KHFZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49804C4CEE7;
	Sat,  6 Sep 2025 15:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757172165;
	bh=2Cc+y+nYgnXueTnsUZYSLj+5OAuyyh/BgYgWxkTKnGg=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=AC/KHFZnlJhJkkKKxrzfCtHXTj8Q6PELcIschWfrR+TNZdZnOf2miZdvxOH/ar+/i
	 ba+zZ6s2ECkyZ/+z1LO5plSw8+Tv4PQdJM2BR0rNmgpjBeVqiOBIOORWAdcfT+QFU5
	 1q3p5km08PCnLX9jaKKuhTH9tSP8L9jE3xOp/Wwpg5QgkJxjuHuMkGLTuhsUxlAwXH
	 dM1xpDhI7F4+M4hbW6cCEss2wD2R8TdNoPICKkX7JwvFuDI+RoFeVhI8IsmJuUWCKA
	 R9HZv6nBbuYr0E6P1m6XX1Uk6AEgaTD0sGxb64iSWjwJB3RSDxmuafp4CSImxHPsd0
	 qyeGrBzleLPSQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 06 Sep 2025 17:22:40 +0200
Message-Id: <DCLTJMIAMCVL.35U236MMS5CCK@kernel.org>
Subject: Re: [PATCH 2/2] samples: rust: add a USB driver sample
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Michal
 Wilczynski" <m.wilczynski@samsung.com>, "Igor Korotin"
 <igor.korotin.linux@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-usb@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
 <2025090618-smudgy-cringing-a7a4@gregkh>
 <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
 <2025090601-iron-glitter-c77d@gregkh>
 <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>
 <DCLQZZHU42HN.4Y4PP0PPR10O@kernel.org>
 <9657C897-087E-4544-849B-964E99D95A50@collabora.com>
In-Reply-To: <9657C897-087E-4544-849B-964E99D95A50@collabora.com>

On Sat Sep 6, 2025 at 4:50 PM CEST, Daniel Almeida wrote:
> So far I see a pattern where sample drivers count as users. This has been=
 the
> case, for example, for rust_dma.rs. I was under the impression that the s=
ame
> would apply here. Although I do realize that there were plans for dma cod=
e
> other than rust_dma.rs, of course.

This isn't the case, we have those sample drivers to make it easy to review=
 the
the code and illustrate in an isolated context how it works. But, there has
always been a "real" user behind that. In the case of the DMA work it was N=
ova.

> As for Nova and Tyr, these are projects with a lot of big companies invol=
ved.
>
> They were able to break this chicken and egg situation in part due to tha=
t,
> because companies were willing to allocate engineers for both the drivers=
 _and_
> the required infrastructure. Unless the same can be said for USB, media o=
r any
> other subsystems, I don't see it happening.

Well, this is true for Nova and Tyr, but I disagree that this is the reason=
 we
were able to break the chicken and egg problem.

For instance, the initial lift around the driver core, PCI, I/O, etc.
infrastructure was done by me, a single person. This could have been happen=
ing
in the context of a very simple and small driver as well, rather than a big=
 GPU
driver with lots of companies and people involved.

Igor (Cc) is doing the initial lift for I2C and Michal (Cc) for PWM for
instance.

So, I see those things happen and I don't think that such initial lifting
necessarily needs big companies with dozens of engineers being involved.

If we know people who want to write drivers for a subsystem that doesn't ye=
t
have Rust infrastructure (such as USB), let's encourage them to get started=
 /
involved anyways and let's help them as they go.

But also please don't get me wrong, I understand and very much appreciate y=
ou
want to get the ball rolling, but let's not discourage people by making it
sounds as if it would be impossible for individuals.

