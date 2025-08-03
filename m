Return-Path: <linux-kernel+bounces-754504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18625B19503
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 21:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87ED1893A37
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 19:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF861EA7CF;
	Sun,  3 Aug 2025 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPUk4mjW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D14C2C9;
	Sun,  3 Aug 2025 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754249840; cv=none; b=ue8fKurXUlHHwpz/KFwL1VUdTUdxk31htz3KJ2LiCdE9KQnWPRK0P2+/Vhwng4sx4Pncd99VtSYcx3DmjP8dzNzTiQIMsr4/WeezipbeIuY8IZZpj0go9bmd0DImeFyMehjnoa0DkSnPtldOBZDftzE/OXOUVDfDG1L9D2DppLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754249840; c=relaxed/simple;
	bh=7Ju8EZEaySWefzeVfXBR25v/1hG4k5/G/1h3M7aC3NU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=CdFLdR/OjBymejy3LkaX6gUnfvbKtuJeoQC7jJlJnbjRw0MGT/AL23bQw12L/7d8Fo6q2sTmmLYdhYtT1jfFAprBBOkw1Njpu3UR4BC/movlniOwFFprEVd0VVkgk8zkvKmqNc8eB/PuG8Mmo3L73xRnPGYQR+yEZv/YPA9y22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPUk4mjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51E3C4CEEB;
	Sun,  3 Aug 2025 19:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754249838;
	bh=7Ju8EZEaySWefzeVfXBR25v/1hG4k5/G/1h3M7aC3NU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=oPUk4mjWAaAX3gV1CfTtH3KYYOXZZISE/uw1PR9veTKk80Pg1RmvWCwn1Ex2Absvc
	 jaisBysJTnE+IrHUswvr3hh4M7HHzaAO8yniXOVVAWS0VSNfghA67xS1lRDe1MCA8y
	 VJKrAr5K+uqTsavrIeerxaHeAYsKUERgdxfBr5gHw3dnhpynlUMAZgZ/K5WHden5Ud
	 VQcKL03ZR7+KCar8n0a0yp2ZkSfmOSgZaXULk7+BMJ2tJ7jRPKp4hLhOieMcIcS9aa
	 vOw+0nX9+BdCJM5Rxg7gmEoF5YibNqLQQye1xe543Ee1cE9hmUQwDdRnUxC3JykfZf
	 TCBhqkThubHSQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 Aug 2025 21:37:14 +0200
Message-Id: <DBT1O0IBXKYN.39J9Z1PHMT9GA@kernel.org>
Subject: Re: [PATCH] rust: kernel: add missing safety comments
From: "Benno Lossin" <lossin@kernel.org>
To: "Jinheng LI" <ahengljh@gmail.com>, <ojeda@kernel.org>,
 <rust-for-linux@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <alex.gaynor@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>
X-Mailer: aerc 0.20.1
References: <CA+TpbOLLATyTRtNxVEJ9Dz6=YSZHAyYOrt20TR8AAEfP+qm1Qw@mail.gmail.com>
In-Reply-To: <CA+TpbOLLATyTRtNxVEJ9Dz6=YSZHAyYOrt20TR8AAEfP+qm1Qw@mail.gmail.com>

On Sun Aug 3, 2025 at 7:10 PM CEST, Jinheng LI wrote:
> diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> index c391c30b80f8..b9dbb73a7ebe 100644
> --- a/rust/kernel/list.rs
> +++ b/rust/kernel/list.rs
> @@ -456,7 +456,10 @@ pub fn pop_front(&mut self) -> Option<ListArc<T, ID>=
> {
>   ///
>   /// `item` must not be in a different linked list (with the same id).
>   pub unsafe fn remove(&mut self, item: &T) -> Option<ListArc<T, ID>> {
> -        // SAFETY: TODO.
> +        // SAFETY: The caller guarantees that `item` is not in a
> different linked list with the

This looks like your email client wrapped the diff, please take a look
at [1] and perform the necessary steps for your email client. Otherwise
it won't be easy to apply your patch.

[1]: https://docs.kernel.org/process/email-clients.html

---
Cheers,
Benno

> +        // same ID. Since we have a mutable reference to the list, we
> have exclusive access to all

