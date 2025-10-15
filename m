Return-Path: <linux-kernel+bounces-855163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB8BE06E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA3F25010FD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA1D30B537;
	Wed, 15 Oct 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKhj5fJt"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA727E05F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760556586; cv=none; b=eqBpHZWytywjErwNpqRwHf6+mShi9sVO/78D3k4A52pD34Ai8YzIVbJqzkZ2lSKA88ztC2o73vwCPoEaKXobPUOek2y6apCaX7iCaWzaAzkk2MEc15iaYZFLjDQzlppyXVDXT1K8u+X5gexi6bWIFXIHUfeglnqQC3iEIhbhfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760556586; c=relaxed/simple;
	bh=PIriNEl1QINcRygfPV3g4fvxTFN2kEqSnPbk62zLE6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8msLnEbK7Z0bRNqY2xR9ZlQTf4hHG8oyQRzimzcRlz3TWCmpMdrsPjGv7B81KHVuXxmFBWc1ylyxlw6SDISOa8PFaYNdMRKTU7zo244yetQfFAB7wUpu2oEIYQRy8t9pG7Z5g8qF99KkaEeoz9cPMuD91oqNWOpfW7ajHeBH+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKhj5fJt; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3c2db014easo466691466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760556582; x=1761161382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ksEMbgKeIvUZBJjpo4N52YV+1hwQuAsDSMHWnzo/ss=;
        b=TKhj5fJtrNz4feapeW+0BK2MENorh0xfEIf4HeOhca9C4ugfPEesr5Rvj/9LJKP265
         +Fv94g6YH9ge6yTTOEBaxpfjboKa6lVggSOP8GyE15m0yJZ7w72JCAdlw+kcfVkZQRfE
         aD/g0AbzPQYM6a8be7MQ/q6yuPiort3pyrIOg9kHtQ3lRxu/wzwhKLcpyHYxjWf66tcA
         5D1GiEJuydLItL24D53kl+Gg50c6LjqVM6l0E2++vjF+tcaF68PkusKomjrlZOBAViWq
         AoVA7IOpVVj8B/rBZ34p8sV8lcA7+Nxw6yW4GPF188pfJTNfmXkCXhDcuY1lOI2Frn5G
         2b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760556582; x=1761161382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ksEMbgKeIvUZBJjpo4N52YV+1hwQuAsDSMHWnzo/ss=;
        b=Exq+uuCTvsdCKB8eCDdViASIx5MwbY1RbLiBCa7K/2Du5FxBu2xrJ/RqdYE4sNFG4Y
         WSxj4yXS7I7x3btgpAEqGA8kJdbOqhtMhVzcDSLesH+yvlZssIgJkvkVB6m8YoXx1y4C
         XrulcTxmVDdGw5RU/TpDsaxCvp7uakO73Qxzy+G5+e0ibGw/56mzblEyGRUxRwYc9D5I
         kiRvucx/i61qJGoszI1XYD7hI6bxT63yD1/d0Yb4Wo1LftUkvh8eyYyoku1s0bMIrPEe
         q5l6OBKHazB7ebouluOnpTpP71QF5iIzWtb7XC105wOeD6I+zpvEqUDGy43fkbslITxF
         kUPw==
X-Forwarded-Encrypted: i=1; AJvYcCU7TOPBklqApIyWxrv9jRdDSqoZGIylkA21Dp1FOX5E3rmfkvcx0t4pBBWFjTp+surUdsm3+SOaOpZ5Dew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwODMnQy33qWJa/HxKResYrWM4bHpgsYZ7G1gRO0q+MLLvMOlJm
	xdykvZDCs10RZU/iNdUZ5S3jgBd08pjUYan9+Y2lerVQQjkiIaMazSCW8Mnpy03jSNc54xncKcK
	fdiXrOYyZ29xp32D/0Lwr6iydzhXtbVM=
X-Gm-Gg: ASbGnctup5/gZpW4mQN3u/l49XmsItxP+/AAMHN0bpisohX7S4CtDAdZH4QPwDX0NFb
	aptZHJS+Mau2ZiywYpDybNjoEsaCPEhs5/xeKyUappLXSq6nvI47vmmOqB1kP6YKWJeSIksLJi+
	k6/xUoHMhdagLvgHnddz8ubwWbrrGC1oa0FnOtuD4apO1fxtZ4XPf97fTEo7ZKD+HnvesM1yc+P
	Y0JoruFYqT14yQMtB+dXzZmnqvSVZ0OQTOGOxMTcNW+DsCScwd3WeRUoM8U3NlWmC4TXegn6oPV
	ArD9ch7hyeRYekO7mzSDnF3KPAQrXvUxYJdjWpkPsRXZ+llmpVJMu1/FlMR0rLdOjzFVV3/e+BJ
	djy5iTAXvIEvwPwNCuXZQA5PgMp3OP7mKIvHlv3b/z81tNteKNOqn
X-Google-Smtp-Source: AGHT+IGtfw5s80CNJkem4TNXL/X5g30lTuJ5LAlCBEIiiOXle0xqvtrIM2mLDYUfLHDwkWL5hMYZfB33sxDVPZ7wk+M=
X-Received: by 2002:a17:907:5c8:b0:b40:b6a9:f70f with SMTP id
 a640c23a62f3a-b50a9c5b352mr3117730966b.4.1760556581571; Wed, 15 Oct 2025
 12:29:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-cstr-core-v17-0-dc5e7aec870d@gmail.com> <20251015-cstr-core-v17-6-dc5e7aec870d@gmail.com>
In-Reply-To: <20251015-cstr-core-v17-6-dc5e7aec870d@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 15 Oct 2025 15:29:05 -0400
X-Gm-Features: AS18NWAV3lBjrdoX5xVPTxh-gkxtXMZeTFZJaDEZjzjbFJTQq56Dz3hw5BWoKLo
Message-ID: <CAJ-ks9myBRqJJEErMU3Zt5-nx-AJ=D=gMNf07e3jFFj=SH_QGg@mail.gmail.com>
Subject: Re: [PATCH v17 06/11] rust: alloc: use `kernel::fmt`
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 3:25=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Reduce coupling to implementation details of the formatting machinery by
> avoiding direct use for `core`'s formatting traits and macros.
>
> This backslid in commit 9def0d0a2a1c ("rust: alloc: add
> Vec::push_within_capacity").
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/alloc/kvec/errors.rs | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/rust/kernel/alloc/kvec/errors.rs b/rust/kernel/alloc/kvec/er=
rors.rs
> index 21a920a4b09b..e7de5049ee47 100644
> --- a/rust/kernel/alloc/kvec/errors.rs
> +++ b/rust/kernel/alloc/kvec/errors.rs
> @@ -2,14 +2,14 @@
>
>  //! Errors for the [`Vec`] type.
>
> -use kernel::fmt::{self, Debug, Formatter};
> +use kernel::fmt;
>  use kernel::prelude::*;

Oops, this one is not necessary. Just a style change here.

