Return-Path: <linux-kernel+bounces-779574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0020B2F5D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26B56021DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7363430C352;
	Thu, 21 Aug 2025 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+EP45zS"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6752E88A6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774273; cv=none; b=clrgs0QD/1bYnPlBEOok+5IzsMhApgUWHI3kSIpReeYi09/nLqgIaN+L/LvsaO0VyJVHWn+pGO2e9JQ7aSOR7QvaL1EsltLfjz+xcj6DqKlWQvPtH61FqMLU6PmzcsGzzud3pUF0WdkW7kN833OWfAYeulRpPWS0lkoPPnslMTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774273; c=relaxed/simple;
	bh=gtCct3hkoKkrZgjCiP3EN7V8X9FP5OPXqQUd7lmuILY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLyg1uNmSvkkLrQDuIgnOWbiOayYguz7mpwWM7aDszDLzE8XaMVWUocv6LYfPUtiRX0rEFkQpK52vZo4sqn5oM9q2TIRel8MxBNeIOYm6b58jAOZzSJizZGMJ5d62RvAbRNAtGR7Heql2bkWGHMQM5CqGUMorf5rsPXbsgI0wtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H+EP45zS; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c51f0158d8so275366f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755774270; x=1756379070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfPX2n5b7RZOQ67iFlZ3PAAf3pSrwoG8EnHEM8eRlBY=;
        b=H+EP45zSdN5mFNHJLqfXS/xcGhtFhpgKnBGVLXR54XEdn5Fbuc0xHe3fkblgknVKB+
         pKI+reMUbPmKiUJs5OefR/En5k5uXmqbygmQy5vqtgC5q4UzJl7fouSVJYc+Ix05dVee
         piVkbTMlLNwsg1vzxNibalRIPadTi2ngfOsmKyCV02dBh33+PIPq4SnRqPjzRiX1naku
         d6itlNNTnrzpD5/oqaRucp4u1A9BuOVhE1cyBmqbbU/DDE7rP9zvOSPYDn4/rAdSc3g5
         XMmQz0awnni6dlMjW3rBkMNjKR60Y/+Gn0rTW3FwSncZ1SQi5pri/9HA5I69Qnoh09Zm
         dqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755774270; x=1756379070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfPX2n5b7RZOQ67iFlZ3PAAf3pSrwoG8EnHEM8eRlBY=;
        b=nKYzBhyvJERTp4hQGVyeqadZPnpNx+EmvOKRraSmm1SQqk+XJS1LaGJyLeiu301PXE
         ltH0Hi7Bu5j8a9/iV3fi2xbaLvaPM7E084pXJbxMjpy2s35XBx4GHdRXmEt6pnBXcwKv
         kjzib4utPyJnwKblQ93mAmTF+QNiKMaOqyGHJE9z3ZNjTmiWNLJP8/pDlQdT3ZB7WuQp
         g8bpS4tyvelkExZkBc35v/N84qNJlumk8rMuB8ypbNxXmogngz21bPmIN27HO7VopbAa
         EuoQuUS30sXj7o9DUxlRUUl0UhR4TQxranvhgbalInzrgyibwkeaX2842WzZ4/UqRJWm
         +bcw==
X-Forwarded-Encrypted: i=1; AJvYcCUOg+Wrj4143TUFkQvqBPr67OwnKUNzG5UOa8xyNPRslzRx5gGgt88+hacFbhEv4sM2WU0pwFhQJbco7xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eU9lhxYX8lY0tLzg7cI5gVaPTqvS1dNekpd37orRVUkt4tU+
	zVLMvvQiNepeQ6c1RKfvSx0To+SzxDINhllAEN72sotH+BbZJoWn1uY5Vd/QPVzxYNzmsgTY836
	F/7752TkmQn1cR9UAYUrJd5mk9NSMYRJLraDr3shs
X-Gm-Gg: ASbGncu3lnLGlOCbHlw8GerJycJTMgxI+XPd70IOzWB+J/LMfJ13PPe0w+LPzpQFMZX
	T4LvMGxG29yP4ndqh2DU7wG14rtSWVtFvmZr/18NnawjYMr/uy4vAOeDSYpoOS5B70qDkwg6LQb
	5i17lh0fyTbMdS+A5v8qidBI1PwT24rdrY1WWotyBr1xIIlZpbHLN9varuKvovrlQ+rr4SaRNgV
	WL58ZSXMTxOYheoFc9EkjfPGQSbfDwmWRGwgE0Y18c=
X-Google-Smtp-Source: AGHT+IHgOGoMhaTa9VhhXZFRdIAaGgTFJI1CxCuz15nSKtJ98ajJqUyW/ax3PptR8mwQGQhKcZsghp+IJbj5MTDcdY0=
X-Received: by 2002:a05:6000:2dc2:b0:3b7:8af8:b91d with SMTP id
 ffacd0b85a97d-3c496da8ffcmr1551530f8f.35.1755774270043; Thu, 21 Aug 2025
 04:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821091939.14019-1-work@onurozkan.dev>
In-Reply-To: <20250821091939.14019-1-work@onurozkan.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Aug 2025 13:04:18 +0200
X-Gm-Features: Ac12FXyjravb4kNV6MTgmXx4NcBxLdtboXOoPPQbRpKvqa0Wbh59JRNT5StbcPQ
Message-ID: <CAH5fLggt4YJe93xo9KTr=hTQoj28=jjJtaxo=gFmnTbWmm8SRg@mail.gmail.com>
Subject: Re: [PATCH] rust: uaccess: use to_result for error handling
To: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: rust-for-linux@vger.kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	tamird@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 11:19=E2=80=AFAM Onur =C3=96zkan <work@onurozkan.de=
v> wrote:
>
> Simplifies error handling by replacing the manual check
> of the return value with the `to_result` helper.
>
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>
> ---
>  rust/kernel/uaccess.rs | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index a8fb4764185a..9992eece2694 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -7,7 +7,7 @@
>  use crate::{
>      alloc::{Allocator, Flags},
>      bindings,
> -    error::Result,
> +    error::{to_result, Result},
>      ffi::{c_char, c_void},
>      prelude::*,
>      transmute::{AsBytes, FromBytes},
> @@ -495,9 +495,7 @@ fn raw_strncpy_from_user(dst: &mut [MaybeUninit<u8>],=
 src: UserPtr) -> Result<us
>          )
>      };
>
> -    if res < 0 {
> -        return Err(Error::from_errno(res as i32));
> -    }
> +    to_result(res as i32)?;

This is wrong. The type of `res` is isize, and casting a positive
isize to i32 can result in a negative number and incorrectly trigger
this error. For example: 2147483650i64 as i32 is -2147483646.

Alice

