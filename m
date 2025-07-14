Return-Path: <linux-kernel+bounces-729770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8380CB03B51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CF2189881D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 09:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5538242D7B;
	Mon, 14 Jul 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9CUVXgs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA7323F41D;
	Mon, 14 Jul 2025 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752486589; cv=none; b=AvQ3OMQje5CWDL2hFuMe2igK/K7CF+wyWzA/NT+L22iBUbc5CcxStpK9txG7f/2iugj0eKQ3/b5IZNaNJt1A9nS4s5tRp841UXdth8wnozDDbOpyNEhUoYnUmJv8ETi4JVYCLruGg3kaja+fkuFRi9iVqOE45we44zLoVQtMIPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752486589; c=relaxed/simple;
	bh=6Pi4vWH/FNwr6vj0hUHJc4WguZ+oLxIkRNeYBOuG9eA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=NSfMcp3URmcTJgqtVa0/s/sQgx4H/13EYVd3W8o0gbjJuzsR2MA+oujNKX1NLUK61j7JwmkwwYPuzfQnnOC+NfEOyOC+ZQ8sJSrL67wyuSYfHlklNvKaLvBd/A3bg+z4gk2FTh6fsNk9FfigOmI7XrDXTQ7gZgnIDN1BHF/7f+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9CUVXgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D569C4CEF4;
	Mon, 14 Jul 2025 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752486588;
	bh=6Pi4vWH/FNwr6vj0hUHJc4WguZ+oLxIkRNeYBOuG9eA=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=o9CUVXgsG8LGcukZyMpLGiPz/OfA65Vo7qmN1vvCnNJTNccD2LjjKG/wTAl0SFKY7
	 G6QUqrRoKA+gA0cXlAyuSK5z41m1M9Qt4eWxMOy2vrqQwa6hJUZK7ujtE7vEYCkndp
	 VdKk/ez88p+Qcr5X76SoLwBWk9UQA1bFmePkP7uS4L2Nuo3XxcKAW9IPl9KmaAJsHv
	 37fja+9SzJwyu/2IP/umkHTJoQV1IdeCU8GFKhB+F4/bs1VteMITAc3ag9kO9KlA0B
	 d9fx14MrmrUwqD47NGbMovZzEtBWatV3ddKTWDWwTpWuxaaTx0uhoYk8Mnfk0gFbJo
	 hXUTCpz7bSjEw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 11:49:44 +0200
Message-Id: <DBBONAMQ0C3X.825M3H3R2IUY@kernel.org>
To: "Greg KH" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/2] rust: device: implement Device::as_bound()
Cc: <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <daniel.almeida@collabora.com>,
 <m.wilczynski@samsung.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20250713182737.64448-1-dakr@kernel.org>
 <20250713182737.64448-2-dakr@kernel.org>
 <2025071411-casually-cold-6aff@gregkh>
In-Reply-To: <2025071411-casually-cold-6aff@gregkh>

On Mon Jul 14, 2025 at 7:30 AM CEST, Greg KH wrote:
> On Sun, Jul 13, 2025 at 08:26:54PM +0200, Danilo Krummrich wrote:
>> Provide an unsafe functions for abstractions to convert a regular
>> &Device to a &Device<Bound>.
>>=20
>> This is useful for registrations that provide certain guarantees for the
>> scope of their callbacks, such as IRQs or certain class device
>> registrations (e.g. PWM, miscdevice).
>
> Do we have an example where this can be used today in the tree, or is
> this only for new stuff going forward that would use it?

There's miscdevice in tree, but to be fair, miscdevice doesn't need it with=
out
my patch series [1] adding driver support for the existing miscdevice
abstractions; the patch in [2] out of this series would use it within
args_from_registration().

The PWM abstractions [3] need it in bound_parent_device(). The use-case is =
the
same as everywhere else, PWM chips never out-live driver unbind, hence they=
 can
provide the corresponding bus device as &Device<Bound>.

The same is true for IRQ registrations [4]. free_irq() is guaranteed to be
called before driver unbind, hence we can provide a &Device<Bound> in the I=
RQ
callbacks.

Ultimately, we want to provide this "cookie" in any driver scope that can b=
e
proven to be lifetime wise limited to device / driver unbind, so there'll b=
e
much more users.

[1] https://lore.kernel.org/lkml/20250530142447.166524-1-dakr@kernel.org/
[2] https://lore.kernel.org/lkml/20250530142447.166524-7-dakr@kernel.org/
[3] https://lore.kernel.org/lkml/20250710-rust-next-pwm-working-fan-for-sen=
ding-v11-3-93824a16f9ec@samsung.com/
[4] https://lore.kernel.org/lkml/20250703-topics-tyr-request_irq-v6-3-74103=
bdc7c52@collabora.com/

