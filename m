Return-Path: <linux-kernel+bounces-776452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E7BB2CD7C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89541687449
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36FB3101DA;
	Tue, 19 Aug 2025 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fiK6RmiL"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B26304BD7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634002; cv=none; b=fgBEt3SiT7R/lA8LyETBZ7UbC5e1v3VgVCCeJJfwAWjtH4McasCK+emUANWhtTjoTVuHO2eS3Z08UQrSLZMUQu16bvUdAVH5jgiEEKDgmSPT8elY3Pkmo5MzloAjY+9j3XVYWj+jaroR4rdOMY7TOMGuc1xIuk6sl5qIgMcE63Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634002; c=relaxed/simple;
	bh=6C7QObJMPTFtgGJIId7CRBPWyV4FKO1/eq+Hnu6qUCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWGtar9oVMjKjckWIQru5cLHWPrVyCGQmBBArL950460ahatH7t6nevP59Dmeh2qRqZnX8u4nkfPv8wkJODdHFMJwSplWI/3GtHztHX2zWxYl/eMmB1+/3GuYc5wjfOQXTTgpmNY5YXkaKajYhZ5Y/WaQKvTOKB3fsl6sgiGN6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fiK6RmiL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-323266b6ff5so178662a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755633999; x=1756238799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dbnrRYjA6r8sWlA78GZUM/iB+0DcVA0eZZwoGwYzm0=;
        b=fiK6RmiLIW/OQJti9UmZuPb4gSwF4/uL4Ffk2VnyLkbxVn4nn9yb0X1TkjjqikdETb
         ym/D/DKZU+BJOkadeNJQ9ifxO2ME0zf4T8QgxOybCiMWQilovEJfSETyZejIztir56oK
         EQC+ZCw1G2Zs1VVGMYWxI62lm3rDCU2xOd+dCM6cx/l7OwpI6eRRm9Ic9eQfi34bZNXb
         ffFNCdwgqq+FdHzal9/a4ZuFPOhz2lwADYPVS/ASEWesAKS/76Isoq8hd8c+s/L9LYey
         cSXlnPJMIQsJwTzqBYMu5252h5DnVuVV3ooXEIftOQSgFaUDX9oW1egSc8X2ayNcjkEU
         2ygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755633999; x=1756238799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dbnrRYjA6r8sWlA78GZUM/iB+0DcVA0eZZwoGwYzm0=;
        b=vQet8acgXrXmIvV7UYa+rdLh5ZgykiQo4904Dfpwngx6yE4CrUP8Di03juYYKz/qvO
         io2FE4NBnIJcDFtk5yyryZHo9pRfLm+uT40Pa3YtCBpuhCTshMdJY/J0woPt5sFwen0Q
         QjCuWJHdR1ifkcY6SGG6mUW7i9ssamsTvWRjt0kLmOu600cwSISpwhclYdmkUTJODCmA
         0i/vpU0yqfOy2BmxfPG5c+hisgSFp9gaaozT8JoOTRMlOdgQbYbD3fkVtg+h/tqPDvtW
         TxORzvFc69219WtKqNPh/BTUkekzKtsCH/H3OZQU7L16b0JzDRvLo4isB9RuruBgPKp8
         w15A==
X-Forwarded-Encrypted: i=1; AJvYcCV5s6aIWTbMADnrDm3TXwPo1MbEoda9IcwRkJ0/lOGJaVNpLi5mArNuvnx1hoZgRBYFddT3heQYgRNtjUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnE7sVwWvS0XpkuwFh60EEcmy+8sHxbgVYi89izRNGZacwj1i
	2XsINdK0OgFxX1Q5NIFhiLt5WggWip00f8FjKzJ3CKJB4r7GwOpYhEK4NAksK+n1KKGsRVwrg4x
	SxDd3lYT4kCtaCn4M4l3qu4Xl6FtYbyfflv8fvWd8
X-Gm-Gg: ASbGncvmxuv/SQqJwqQDLhQLYemcBxXNVNMFh6SefSSgefopqdJAE7BOjzhL2jKG2X3
	4y56p4vvFq87J4LOsWoHQEh+nMxPRJ4aOMliBoX46tgCIXM721QdZ82WuaYTGuowCM+InljHQJa
	MQ/ZpS09LFQH7lpW/wIGuKOjNqkcfjker+NqyB4+amnayDisbXLkUn++F7TmhQzmb0n5Ef2WwN6
	i8Khp4=
X-Google-Smtp-Source: AGHT+IE57Vpn4Z/uLflLQmdS1WKySyLuxyfc5IrS7pgY9y0NqhnygvL19NrSeye7I82eCLBPuD+9tEQKPBa1kQf69dE=
X-Received: by 2002:a17:90b:1dca:b0:31e:7417:9e86 with SMTP id
 98e67ed59e1d1-324d34f0608mr5508407a91.9.1755633998729; Tue, 19 Aug 2025
 13:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250816114409.10107-1-shankari.ak0208@gmail.com>
 <aKKdULYbLFRMS9qe@mail.hallyn.com> <CAHC9VhRwpYx0jVybcAnGdm4AGDno-GwyCzZCS7U+56Fwu2tuCg@mail.gmail.com>
 <CAH5fLgin9OhTmf52i2hQKztYLcHTxE+n1gMPXDFN83atE+u_oA@mail.gmail.com>
In-Reply-To: <CAH5fLgin9OhTmf52i2hQKztYLcHTxE+n1gMPXDFN83atE+u_oA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Aug 2025 16:06:26 -0400
X-Gm-Features: Ac12FXx10lJQLGyCNfT5IQBtbILTFmhFyVz6sTMSaLCEXVmUXNmYmvs8TLi8yIM
Message-ID: <CAHC9VhSoyh3EqFqYD7tXDmPXsao8FLQo2PMAKEmJVJ6khPA51Q@mail.gmail.com>
Subject: Re: [PATCH] rust: cred: update AlwaysRefCounted import to sync::aref
To: Alice Ryhl <aliceryhl@google.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Shankari Anand <shankari.ak0208@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 6:06=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> On Mon, Aug 18, 2025 at 11:22=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > On Sun, Aug 17, 2025 at 11:26=E2=80=AFPM Serge E. Hallyn <serge@hallyn.=
com> wrote:
> > > On Sat, Aug 16, 2025 at 05:14:09PM +0530, Shankari Anand wrote:
> > > > Update the import of `AlwaysRefCounted` in `cred.rs` to use `sync::=
aref`
> > > > instead of `types`.
> > >
> > > Thank you for forwarding, Miguel.
> > >
> > > As far as I can see from the included links, this looks good.
> > >
> > > > This is part of the ongoing effort to move `ARef` and
> > > > `AlwaysRefCounted` to the `sync` module for better modularity.
> > > >
> > > > Suggested-by: Benno Lossin <lossin@kernel.org>
> > > > Link: https://github.com/Rust-for-Linux/linux/issues/1173
> > > > Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> > > Acked-by: Serge Hallyn <serge@hallyn.com>
> >
> > As mentioned previously, I'm still not well versed in Rust so as long
> > as Serge is happy with it, I'm good with it too :)
> >
> > I'm guessing it probably makes sense to include rust/kernel/cred.rs in
> > the creds MAINTAINERS section just as we did (or will do) with the LSM
> > Rust shim?
>
> That would make sense to me.

Okay, patch sent.

https://lore.kernel.org/linux-security-module/20250819195841.238246-2-paul@=
paul-moore.com

> My understanding is that this patch, unlike the pin-init one, is
> intended to go through the LSM / CRED tree rather than taking
> everything through a shared tree with Acked-bys.

In that case, I've gone ahead and merged Shankari's patch into lsm/dev
and will plan to send it up to Linus during the next merge window.  If
something changes and the Rust folks want to send this up via a Rust
tree just let me know and I'll drop the patch.

--=20
paul-moore.com

