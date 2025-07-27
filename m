Return-Path: <linux-kernel+bounces-747213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E685DB13104
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45623AC115
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 17:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ABB221DA5;
	Sun, 27 Jul 2025 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho6iF6+D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAC71DC1AB;
	Sun, 27 Jul 2025 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753639116; cv=none; b=nsl+KoSZLT7Okv5SbOTjRAIeVlOJg5s7XRUiZ8zQwn1rjVR0yewPPuoFFP0v1J8Na7YCl70qaPqIQvtykdsJZXt5uf0WvkLPMXZYE8T206hlU7s6D+f1mdgLkBTqcbCF+xiOXhY8gAv9hgnVVVAoHZGzwlK29vogHQqM0sAX9YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753639116; c=relaxed/simple;
	bh=Iwn3XPBdN9lZzu6LYqj2ZmytSx/X7jvM81u539xI4GQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JLkAf/J4c4dyZJbxd1AOhiQATUB09HxbpBKhTUd5U/sJiCf6r1z6qndJBQVW4/B9XZCAowu8peIsrUMAjPy03Hh7yeiQWPHhwIfliqB/xawha+Ll6L8quu7lDTWuvtJw03Nd20+66EHBjqDnrsCQ1RP7gpNWhW1Vx3e9DrvG0JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho6iF6+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6821AC4CEEB;
	Sun, 27 Jul 2025 17:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753639115;
	bh=Iwn3XPBdN9lZzu6LYqj2ZmytSx/X7jvM81u539xI4GQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ho6iF6+DDRD5xSDzfJPRAJmU315Gm4C8R0k1cec+bE6OCydzkXQ5jvEX6jEiUXXOJ
	 G2lAeIMojvUU2OPEe6oXKkBdYMiWKjfRbKv0bfUf3+fi/+GNd6Q6m2yIt/fNXCv3/p
	 takoTjhPnVbo3gUQW7AA/YVJE8VSgKgWkIrQg6PXvtMnj25fm96xXj5VSilwV99xBx
	 vkoCKT9VmWA1S5E1gGIs6beF6/pPpAs4qsun6HlLj6UjSfAT3JzdaSh1/C/lmofsBA
	 EstBFHDbsOxyySrhMNp04GuZnfqr5F4qJvC29l7mP3KgL7IG5ImywQ0k6wDj9svhWZ
	 O1uaBDGWVv4rg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Jul 2025 19:58:30 +0200
Message-Id: <DBN16LSXVANU.1LMW8POGVF2CJ@kernel.org>
Cc: <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <me@kloenk.dev>, <chrisi.schrefl@gmail.com>,
 <rust-for-linux@vger.kernel.org>, <skhan@linuxfoundation.org>,
 <linux-kernel-mentees@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust/pin-init: remove workaround for type inference
 cycle
From: "Benno Lossin" <lossin@kernel.org>
To: "Suchit K" <suchitkarunakaran@gmail.com>
X-Mailer: aerc 0.20.1
References: <20250727170217.206794-1-suchitkarunakaran@gmail.com>
 <DBN0JG0QP7TU.PZSZ8NZL5LD6@kernel.org>
 <CAO9wTFisWa5qY2qQE+BEdD40vacGwtzw=2xxPnV0V_w=Gt4jwg@mail.gmail.com>
In-Reply-To: <CAO9wTFisWa5qY2qQE+BEdD40vacGwtzw=2xxPnV0V_w=Gt4jwg@mail.gmail.com>

On Sun Jul 27, 2025 at 7:44 PM CEST, Suchit K wrote:
> On Sun, 27 Jul 2025 at 22:58, Benno Lossin <lossin@kernel.org> wrote:
>> On Sun Jul 27, 2025 at 7:02 PM CEST, Suchit Karunakaran wrote:
>> > The `cast_pin_init` and `cast_init` functions previously used an
>> > intermediate `let` binding before returning the result expression to w=
ork
>> > around a Rust compiler issue causing type inference cycles. With the
>> > minimum Rust compiler version for the kernel now at 1.78.0, where this
>> > issue is fixed, the workaround is no longer needed. This patch removes=
 the
>> > unnecessary `let` variables and returns the expressions directly.
>> >
>> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
>>
>> I still encounter the cycle when compiling with 1.78.0, which version
>> did you test this with?
>>
>
> Oops, I just realised that I compiled it locally and forgot that I had
> installed version 1.78.0 on my VM and not on my local system. I
> actually compiled it with version 1.88.0. Sorry for the inconvenience.

No worries.

>> Do note the comment mentioning that it is needed for version 1.78 here,
>> so I think this patch still needs to wait until we bump the minimum.
>>
>
> Yup got it. I'll send the patch after the minimum version is
> increased. Thanks for reviewing.

If you do, then please send the patch upstream at [1], that makes things
easier for me, thanks!

[1]: https://github.com/rust-for-linux/pin-init

---
Cheers,
Benno

