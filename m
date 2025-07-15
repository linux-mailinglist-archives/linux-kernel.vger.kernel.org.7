Return-Path: <linux-kernel+bounces-732075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98147B061E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603435A2FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2C1D79BE;
	Tue, 15 Jul 2025 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDScMyq7"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D26F137923
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752590173; cv=none; b=NENJM0axZlozMbgRTny5zqm3v8XPE3xL1iDu5Fp4LirA9cUlQQUMOwXbZzmYq+tTNBG9BewHNvZwLSqKedE57CNmwk+Thoujs3S2XoFH1UbSKcBjNdhS3QQHPqSPsUPSSxkpw9PkymI2XEEzHqAjN9uDwDQOW6pB4dtjIIyBUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752590173; c=relaxed/simple;
	bh=EecG0RfOgPK7guoEmHKkFnJxuOMZMfGIgo2mOHDfw1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQm1wxYaZxV0xeIuJZyvWhXMNJATG7ZrdlTabqDR+PCecXOLAhSdkzC32HifSPeXRBuR3B44rgGmiQHlGeLgetGJDLbGyx2bZ/CtnAw1IzymYvaiH6nWhrBjZmbRV0IWbK+p++eo8Ubi9XYzj1OwHYUQJbELR1055QavNGbyNiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TDScMyq7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so3173164f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752590168; x=1753194968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGvfBdhqi/ZhPT44V9PeuAZ38V5//XMxkKdYPmm5xrM=;
        b=TDScMyq7G4ZAkuHRue+1e5eFKgBcqEF1BKX23YP85NkYZktStaC1B2azhuyOHn+v8d
         AQzq71dbQIDhf9NfHaBe1Bin/A+Sgoqnuj4DGfTPJIrEazGqvAKj0pZAVpTadsmu2Bob
         vLWoucqStq7BtYCe9b+H1d4NJgW3P1gpw3NmN3Q8fp9rNEulLXgcO8UiV0EZ9LUVLxoQ
         hOTI0epfWCBLa4siKuxuk1y7XROooVRmiC+6sVduHAIIgLU8vjt8uKzJro/Y96tkburU
         srGx9xTAy37hxMBxjnnNxbX1jHBPsuSdWlBgXOWXapqCuKUfT22DamzA/zJebg4sK//y
         8o4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752590168; x=1753194968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGvfBdhqi/ZhPT44V9PeuAZ38V5//XMxkKdYPmm5xrM=;
        b=jaNvt3Q/RfiNYMQN2/Qx1XhAPcJkeckjvQrkzUtmFKdJ96/9oTIlXYaTwEbxLbc4Ay
         F/qs80HZFYchG/mspVCqBxH7NvTRlMVFeVHbyalw+AMgkN/H1VNL7d4JadS/0zYGTkol
         EL+as1Rr/MlJ+GE6dYuxIgns2kwP5AH4PJOy2TCBymt1AW6x2j4mIcx1zkD22N3/ifi4
         99NYWQavL3Jvf/V1iZMjiJM2NBw0SCJGxA0PI0gEedFh7Ht9X4tb9jgPGasftZSjghAB
         fznmH1NCXeZ4uL4nOMbt5kDzkjzNOjoTqXWnvpiGM30uXYmP/1Z1w9yK0ALAJE+kmYOx
         S0gA==
X-Forwarded-Encrypted: i=1; AJvYcCX7ffLe69BR8iIaWQ/ltW5s/DsIHQHwY3Hu2DVgi/skHHivQ86jLWJRd+t628UEbB9LBeSqUrZvUiBK7Xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjWZRMwGPPpsgKrWQaqDHSL0/GQPVIjDl5JhnvXhU/hJujNVN7
	SXNYXHYxax+DEaThGbOpfbj9+WE+P84fCFOCQnaYvIFTff1lW9/0qX9ioRUC6RZ367HaOFBYPaF
	3u6uIXLBN2kDG5PUbqvjWrK2yF31eec6BcsgJXw3H
X-Gm-Gg: ASbGnctt6O9UIZBPjT38r0cWyXQhEkj4YvdcC129aUr0INGMuV5TnjcMDRLWY3H6iPR
	ysxhQgh75U9IRU0VIKjFiY/jY8duDNgMu29VkezPGKqbmUDDz7gnSkWrpksNXEfPvYcIkl+JC8j
	LkWWdLjnfUZxNRFrsH8I9hqFESdchVHs6z7tVrmHlgSyaEaGrTOzTnBKvmkwL3l3WcA5f+zWKJa
	gcw/pudH0Uu4bJJkey7B+TPuPJxp8YM0Xj1r+sasv2/m4CC
X-Google-Smtp-Source: AGHT+IHchtZYVjwPT3Jbtde6bA8r0SM1a6NSKREDZEHuUKb1xV+X3nINxk5+iqwyl1LWyFSQCr/TULZEuO0NWNXPtg0=
X-Received: by 2002:a05:6000:4022:b0:3b6:938:86b7 with SMTP id
 ffacd0b85a97d-3b6093886bbmr3936441f8f.35.1752590168224; Tue, 15 Jul 2025
 07:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com>
 <20250715-align-min-allocator-v1-1-3e1b2a5516c0@google.com> <DBCOPL040H7H.2MZO6ZBIR0Z2T@kernel.org>
In-Reply-To: <DBCOPL040H7H.2MZO6ZBIR0Z2T@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 15 Jul 2025 16:35:56 +0200
X-Gm-Features: Ac12FXxYoaHrfSJ6mWRMdg4R-V_viczknh-7oNSEIV-JL9gT_TR3g9iuEJIcalQ
Message-ID: <CAH5fLgi+6Ahh_mKrdxyfc+SBKymEhqQhgg=6MxxG7MSvpJjveg@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: alloc: specify the minimum alignment of each allocator
To: Danilo Krummrich <dakr@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Tamir Duberstein <tamird@gmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 4:05=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Tue Jul 15, 2025 at 3:46 PM CEST, Alice Ryhl wrote:
> > diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> > index a2c49e5494d334bfde67328464dafcdb31052947..c12753a5fb1c7423a406355=
3674b537a775c860e 100644
> > --- a/rust/kernel/alloc.rs
> > +++ b/rust/kernel/alloc.rs
> > @@ -137,6 +137,14 @@ pub mod flags {
> >  /// - Implementers must ensure that all trait functions abide by the g=
uarantees documented in the
> >  ///   `# Guarantees` sections.
> >  pub unsafe trait Allocator {
> > +    /// The minimum alignment satisfied by all allocations from this a=
llocator.
> > +    ///
> > +    /// # Guarantees
> > +    ///
> > +    /// Any pointer allocated by this allocator must be aligned to `MI=
N_ALIGN` even if the
> > +    /// requested layout has a smaller alignment.
>
> I'd say "is guaranteed to be aligned to" instead, "must be" reads like a
> requirement.

Yes I agree that sounds better.

> Speaking of which, I think this also needs to be expressed as a safety
> requirement of the Allocator trait itself, which the specific allocator
> implementations need to justify.

The trait safety requirements already says that the implementation
must provide the guarantee listed on each item in the trait.

Alice

