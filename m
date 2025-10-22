Return-Path: <linux-kernel+bounces-864185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D017ABFA1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9043E3B0839
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 05:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F39223DF0;
	Wed, 22 Oct 2025 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epN3avjR"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A0B1DA60F
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761112302; cv=none; b=rz5GjCSwKK3axda/IvqhHy1rf6x08bzGxMi7km2jefiCm+4Gyzafuv/R+v64O9xOH8XUhQg1nujRELAmUsq1d1My7ZT5LgRHduDn2KHxHHRn0JjEH7ZjgyoDNXqleEd3PKK7QV/GVnUuORn1R8MH6i7pGiU4oWnObe3fjjtmnGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761112302; c=relaxed/simple;
	bh=ucp7DRPRvHlKQ1ImYNBcM1swIw52ku73Waj6AkYdHBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlMPaic7eR2SQM3dI7+frW5ywfVTtI5AZ11u2ttTVpInCU4GmK1AaKTHIJoBMgvo7nS8O+NCIVsnATMxyFDA/xiotKh3e74J59hRYctUKDTxCteuc2Gq/PwjGsr5snTbGkQiR+gTeeRFODR0uMYzQIZvKU51XqS2++puM52HocM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epN3avjR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-290bcb326deso8869885ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761112300; x=1761717100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzCSS40w0uA4KnNFZqxxDzrNoeqUCAqBFU1DIktR0u0=;
        b=epN3avjR2Eel9JYyx/QBPgE3S1bFbdtBh5dt9uFcSUtkcrjePiwdpp1BkM9ONRzPSG
         AaDOOyZuBgnSjC7p4dT56PPdVpTJSSFkJEgLYlBd58/FtdNvucuY7TRQCKloVbz0zax9
         J0U7UXdji56VW8x+cpxkpI7vtKq89CBhUtARE/raf4k9C/TvyOXJF3JmlMgbg0gTaoMz
         WTNsMy/CJ3ty42k7/TW7JD7qIxUNEvuofmEXfMfKzsw8sisNYAodbWr1Laah1c5K8Fzc
         T69d1izwljm3IiRrHD5dOCfYinl5gAp6zH8QESSrryGYPRdiUBYcFyWuBpYeBOrgl9xl
         LWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761112300; x=1761717100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzCSS40w0uA4KnNFZqxxDzrNoeqUCAqBFU1DIktR0u0=;
        b=WEllO7XAGJKfEJ2QktW0KcAprxHuRA3HYtGE8PQiwoPIN+/HfttZAW94B9HnJtcTVO
         VDkC2ZqtTNEKdcW6kM/uU8HZy0A0e2NbZ1KScp+SdIUVqWgVIbhV/cT0Tuao7yR5JLqE
         nlqrEZ24/eRC8YEuq1ClDBhfDl5Y9Dzg8FMPOD3MZ7+2e0ZwbsPMBciG7Ve24k0ekXxh
         SwVclAdf46FM2qycD6/5pRQFHYF80kjZEPVGoVIVvU/g6TYdXksBAHXH0/qJMF/L9qxj
         rvkLB3A7fJK2w3ecAgMMooaiF6OafqNdOSs+8HHP3oo5RV1fC1GV1GhNG1FlCbZOqgH9
         dGag==
X-Forwarded-Encrypted: i=1; AJvYcCW7HSh4ACR1ocF2uVpvjoR4UXYaUPn0Am6YthXuY4TyOxY6AaBv3MM1gIgTx0JaWX8V4b/iJ8bcIRnHRkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7QGphWD7E3DukNQgQCPH8/fuInUhaCE2n3Ok/31l8FzFtQD5t
	OgXfExuu9cgII+Y5qz7dciRpub8weJOL5D94a2iCrOSQlJQ3mEKJYg7A31uUGI84npRHztF1boY
	4i6m5tUO/AAS4f4o8yO9x3e02roWod4g=
X-Gm-Gg: ASbGncu3nZuF6JgPKtRA+EfCRhH0hSrFnNJDUTRZTDbktdlCUC+LJpyFFGyK2eGaG2M
	a9No/BPz20KyVWVy3zlP2WWILV59wVFKS6Pc3T5bVIJAnAuXmJHrnYRzc0OBP4AntqRMthUsoRW
	//lcJFu2tFHTkmYcT11aJcxtXUy4UAL/DBUWXeWZkc6DZd6IS4woL/ZvDDQiDCoU6uLBkRxhQuO
	7fdFpRxyNtY63ujc9In61TkbLxfFtqL74xG/L1wnmwQqW52F2ftAht3/3kdBjJfW17EM1jxmvND
	1CWZq9jql993hUIiMYHDrPpUXlq5UpUfK1TkN9EFzyUbQRkXqHSST7kghWw5kFk4epkvGSlIsEu
	KQGssgwxXMyvaBA==
X-Google-Smtp-Source: AGHT+IFL/AlUAelBKUAAV2lgJId/DywOqoyxOM/upbkNU/Z4R83S4fX6yCXSYO1AvV8pIvJROMYrR3nU31E1ptU2DLs=
X-Received: by 2002:a17:903:90d:b0:290:ab25:29a7 with SMTP id
 d9443c01a7336-292d3f611a1mr35174355ad.5.1761112300109; Tue, 21 Oct 2025
 22:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-cstr-debug-utf-8-v1-1-1933c0a6d6b9@kernel.org>
In-Reply-To: <20251020-cstr-debug-utf-8-v1-1-1933c0a6d6b9@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 22 Oct 2025 07:51:27 +0200
X-Gm-Features: AS18NWAMP3cE-lqZND8qnxVgW5VA3HNm9VtVw2nMIdotUhmYWrQh10vv7hgwlSw
Message-ID: <CANiq72mM-scMGCFxogHXP=4Omr23uVEg4cBBsZARhSCt+9kHuQ@mail.gmail.com>
Subject: Re: [PATCH] rust: fix tests under Rust 1.89.0's `CStr` `Debug` impl
To: Tamir Duberstein <tamird@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 5:27=E2=80=AFPM Tamir Duberstein <tamird@kernel.org=
> wrote:
>
> Starting with Rust 1.89.0, `<CStr as Debug>::fmt` prints UTF-8 sequences
> unescaped.
>
> Thus update our test to expect the new behavior starting with Rust
> 1.89.0.
>
> Fixes: a1ec674cd709 ("rust: replace `CStr` with `core::ffi::CStr`")
> Link: https://github.com/rust-lang/rust/commit/a82062055af1ecdcb7f4d33718=
55aae843fc0ae3
> Signed-off-by: Tamir Duberstein <tamird@kernel.org>
> ---
> Hi Miguel, please feel free to rebase this in, if easier.

Thanks Tamir, yeah, I saw the test failing in my CI.

To keep things simple, I just removed that assert for the moment -- if
we care about the escaping behavior on debug formatting to the point
of testing the behavior on different Rust versions, then we can
re-introduce it.

    [ Removed assert that would now depend on the Rust version. - Miguel ]

I took the chance to take the tags we got so far too.

I appreciate that you took the time to put the link to the relevant
commit upstream (in this case, it was yourself, but still :)

Cheers,
Miguel

