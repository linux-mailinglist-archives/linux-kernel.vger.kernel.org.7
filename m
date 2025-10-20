Return-Path: <linux-kernel+bounces-861102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B0DBF1CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C62D4347604
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9770B320CC3;
	Mon, 20 Oct 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNPVEWPZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB425A328;
	Mon, 20 Oct 2025 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969913; cv=none; b=srXjPVXttThxwTbQjV6WsVvDdM/3V7VKvOXbGVknlCoOktK7u7qrDfZlTIjrKwBh9mbGl3ViPYsxqZNFe6JS3hL0DtZPoUoXoLEGOwc2AncHi94/RdnG3rUK/hUC0Y9Ea7pG8VMzzL4PSiT5uGj0CF4Nz/uhdfyZJCeHHe8BJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969913; c=relaxed/simple;
	bh=8HJxbzJJnrOiosib5efl2b2t4vbzloiJMAS1tH7HNGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1/7iot62d4QkyHyBKaetVkwIewSgU15qReIBDzbyQVsV4wdAw40H53tLzdrkQVi5v2vPK/msRKHoS47WzMAALbrs9V2kn5XUKkJT2RGj222D9TuKCfD5Dm5WW83eenk2uMUAxh+qYBp8BA21MAPxTQl0RE2T1hYi8BjtuYLu+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNPVEWPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C92EC4CEF9;
	Mon, 20 Oct 2025 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760969912;
	bh=8HJxbzJJnrOiosib5efl2b2t4vbzloiJMAS1tH7HNGA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CNPVEWPZqyulQz0P8V+Wl+/qSuQyIc8aPOGqvRyLzDAOBEMGzUJ15W7TqYUX+7I13
	 oHvoPpnPae5MlcMlSuMXvjxdVmwONf/2Uhh02wmejh4Bgbnmrl/1XIfa8ZsPSFcqjX
	 vQmJQ2u1A8wU7TwpqXVSKWkgv1zwOnT6xfDo9Ezhx4Ma9TEmCrsqeB6PclqFWrQNIZ
	 y+0CxD2xtYPJJHJNDCZ5094fH9klXNwPBd4e0jyKqNoL1SaICC1Rxd4ruPr83Pc5Mr
	 YJmXk7n3onwisVhBA2ThQKYC8jd3Anj1MczlQyKqpXlJkYQHyAza7GoGL2Yasp9fje
	 63uQ66WhkwK2w==
Message-ID: <3bad6983-b412-4386-931c-4eca3ed54da3@kernel.org>
Date: Mon, 20 Oct 2025 16:18:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN
 constants
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yury Norov <yury.norov@gmail.com>, =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, Todd Kjos <tkjos@android.com>,
 Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251020-binder-bitmap-v1-0-879bec9cddc1@google.com>
 <20251020-binder-bitmap-v1-1-879bec9cddc1@google.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251020-binder-bitmap-v1-1-879bec9cddc1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 3:33 PM, Alice Ryhl wrote:
> To avoid hard-coding these values in drivers, define constants for them
> that drivers can reference.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Yes, please! :)

Acked-by: Danilo Krummrich <dakr@kernel.org>

> @@ -238,11 +244,11 @@ pub fn new(nbits: usize, flags: Flags) -> Result<Self, AllocError> {
>                  nbits,
>              });
>          }
> -        if nbits > i32::MAX.try_into().unwrap() {
> +        if nbits > Self::MAX_LEN {
>              return Err(AllocError);
>          }
>          let nbits_u32 = u32::try_from(nbits).unwrap();

Can we also get rid of this please? :)

> -        // SAFETY: `BITS_PER_LONG < nbits` and `nbits <= i32::MAX`.
> +        // SAFETY: `BITS_PER_LONG < nbits` and `nbits <= MAX_LEN`.
>          let ptr = unsafe { bindings::bitmap_zalloc(nbits_u32, flags.as_raw()) };
>          let ptr = NonNull::new(ptr).ok_or(AllocError)?;
>          // INVARIANT: `ptr` returned by C `bitmap_zalloc` and `nbits` checked.

