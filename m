Return-Path: <linux-kernel+bounces-723559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFB1AFE878
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 873611893351
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075F52D8366;
	Wed,  9 Jul 2025 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cm70kIr8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63540285050;
	Wed,  9 Jul 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752062299; cv=none; b=mE4mjDRCp0sdzjubsVT61V5QKdbWcc9bGeulruoTosZV4WB3VkIdRyJyfytiMtH+gTSMW76ZFxLVbJYv/Q1Q4ZTOij1NlODGJFgJqryIL3oS5W6HWTitZBTF+DQuh7ys0IpyqPFEWaupoISXrhdgYpD5hirAZbuIWt28P3owVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752062299; c=relaxed/simple;
	bh=A+BHhP1su6nb/CSpfmYIOo+ec8S2z1mjer+FDb7D/nw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dnwr7J7GyUGZSqpd+KXHxUERplEPVS9OIzhQaHUSYVU9+SYoInjXV1F/Qy1O0z2xCkOKvxC7AED5lae+/6wsf+bU13ujqEt9fZR9ZZ7phr3AT1T30g+99z31lFGjWbueqORNykc+59/QcqhKFmnlQHXD/Ky0w5gFcvmJaPgyxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cm70kIr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12E9C4CEEF;
	Wed,  9 Jul 2025 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752062298;
	bh=A+BHhP1su6nb/CSpfmYIOo+ec8S2z1mjer+FDb7D/nw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Cm70kIr8Np+uzp3wOojKajmOPpbuiAejWtj8peWZxewvthD6JcZOv4dHArHgQyv87
	 mvuDQXMgf33yWNk6TBPGb56XCzoBexOuNMzRgFvLRaLJQJ4KTIvAwZM0Aa7PoOu1nr
	 2h+wOaeCESgsTLAWqLp47b4MgstB14endIVh6KHLdWnwarFCOg/Jc+qO/TuawpLetX
	 ffT+2TpKlhwTSDvLYpy1gfh04VBhc0gMK20ymrsKy/esVUrIAM3ZYGkKltK/q6Degx
	 0rUQ8NUVF+Z9EvKX4rzjcAo0oVExCvab4d+x+RXRLJUMWn7ISbfpeCyxGStpoF9ElT
	 HJ48u4Makz+NA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,  "Alexander Viro"
 <viro@zeniv.linux.org.uk>,  "Arnd Bergmann" <arnd@arndb.de>,  "Miguel
 Ojeda" <ojeda@kernel.org>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary
 Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Matthew Maurer" <mmaurer@google.com>,  "Lee Jones"
 <lee@kernel.org>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>,  "Benno Lossin" <lossin@kernel.org>
Subject: Re: [PATCH v2 3/4] rust: miscdevice: Provide additional
 abstractions for iov_iter and kiocb structures
In-Reply-To: <aG5NzRx7dIWzTwdf@google.com> (Alice Ryhl's message of "Wed, 09
	Jul 2025 11:09:01 +0000")
References: <20250704-iov-iter-v2-0-e69aa7c1f40e@google.com>
	<A6L7hDRsDyJJvX_NuoUG_Zb-Jy_BMdGLhjsq5xUSRkl6hpItQD9ZvX5ChAr9QIFH4eeDBpW-Q-582Tt4Nef5SA==@protonmail.internalid>
	<20250704-iov-iter-v2-3-e69aa7c1f40e@google.com>
 <87wm8in3c0.fsf@kernel.org>
	<r5izPCJZMxWLMRHI_0ct-IhjtM7ORTcUfH3F_V0FRYB4Put8E1ZaD2IRubSmWY-3zjhr_QsbtZT611mNphGUkQ==@protonmail.internalid>
	<aG5NzRx7dIWzTwdf@google.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 09 Jul 2025 13:58:11 +0200
Message-ID: <878qkxlgoc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Tue, Jul 08, 2025 at 04:51:11PM +0200, Andreas Hindborg wrote:
>> "Alice Ryhl" <aliceryhl@google.com> writes:
>> > +/// Wrapper for the kernel's `struct kiocb`.
>> > +///
>> > +/// The type `T` represents the private data of the file.
>>
>> Could you give more context? Please describe the purpose for the type
>> and intended use. Perhaps give an example that can be compile tested.
>
> Right now, it's basically a `(&mut i64, &T)` tuple providing access to
> the file position and private data. That's it.

Great! Let's get something along those lines in the docs.


Best regards,
Andreas Hindborg




