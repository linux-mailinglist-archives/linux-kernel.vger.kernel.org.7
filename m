Return-Path: <linux-kernel+bounces-790004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ED1B39E25
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95E03B6E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9363101AA;
	Thu, 28 Aug 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NOWP2W1a"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626DE30F55F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386366; cv=none; b=RMvO+vL517b44+pGUV7/8i/kcAQh+YuQTVgEy76VS8EdACQiEDN1qTmCEYldi7/OXJQKQRfFOkja4YW9LMsJ95bnU57fRNSt1VFd9ZzdQfhDpuBlfDb5mlDLcBBV3oTNHMRfsEBoSW+8PuBGlw3xkqUt7mPd0x4GssEFzypxbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386366; c=relaxed/simple;
	bh=Hjgvl7t3N4uxdg+VbGK4c3KB1Vgb26p6IUDC/BXZ9bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7YwvngL0zgVKPeWZOPNPeO7hOhCSY/Nb+KiX41rvhM9quXkvfu/gTDPLsOOq5kHQggwrO+zIZbsQF4oRG9mwd+zLzcZAMhu+SEq8z2ZyHPPda8SoHsfgnKM8soaCsELuebuLGRKV6CO5kbju2Duar19iFrKU9JFgSbC2VjOPp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NOWP2W1a; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24457fe9704so9528455ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756386364; x=1756991164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEg72LM7YmmLe/X9iW3od6t+U8qtbnknaRFc97jQIUM=;
        b=NOWP2W1aIoUpJHmT/oS8pr05zrI0tG3rCgqCcycFfnToXluWIRz1zLY6IJm2jkk+8v
         QEriiyHIc21IPmX85Onvzer0FaQBWscmUFPYmT3odB+loMJY/1ThGuW6K+zQY6p7qEvt
         DYpI3txbEu95L2ODb8jm9twujLr/hJ2VfD8JfSOiCSdfAMDgb8eDsdpWqJod3SpiMytu
         zwDPB2pc/epHSD8dTpDM5I/hwxa30HfnA2PpCg62pfQYjE22hyVkaLE2k9kAaAfQdX2r
         NlJXao8IbYGZcUf/F42YVktaFV0srowHziZAAvzn1Tg/T7Ddf0TjxRLleXhgdX5G2q8B
         Bhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386364; x=1756991164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dEg72LM7YmmLe/X9iW3od6t+U8qtbnknaRFc97jQIUM=;
        b=B0AVGmnEyQO7WN9RML+7/1/y85RwErcsZVgxzHI+BkOTqeVRJtgIV9G7fHXa60JroS
         nzehMsXfnq8hMk3aIJYEmWfz+U7IOmIW2BY8lzQQ0ZfFfb6yEeJ64gPIgW6u6YKghCYB
         /FB4PUYrJe3+vykCuv+W4E+WsHJ3N0FKk5ItbczIjswY0uvcGnCrjgZlZSWIWehXySKs
         TShz8im76K6py0VimBxVjbkSiAaS1KEuQlVGZEgbU5xTRuO91/t74TpnzdSr1wOmSsaP
         70R/7paF4no59aExUzxxhAQngI7MIu9xxCCJGSSswoatY/fqGDw45H2PlnVIniTpdQB8
         bK6A==
X-Forwarded-Encrypted: i=1; AJvYcCXVg8/U5lYajniQ8Gb2sLUuOQ5MC1ZtwXZ5abD2XNCYknplJNR4FRBUHHxVi6ednULDHB7GmulCivRvQAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH3pVnTukDgUm6jdQGs3D5BXM8aM+6jZ3rMA+IAZieOGGMztKh
	jGORAeBLbc1nIdfYrjbVA/fkY2lMCQPxFREVuMACXV0lDSppWvqZINsPjklMbV/x1Jg/VQZliy4
	1yDFO/g+a9vEuumuDOmvrFBdUnNmsoAk916GwuvAG
X-Gm-Gg: ASbGncsa1FH9qyBPV5nzPOawppUMO7v+Ot23jsQZYvp6+RCU4pbYeOif8uqLZtjtuwM
	ayb7u0jdk6lyc5bk1FjM3Hu056ZjM1izQAptNf7z1HQ76jEuccLrRf8B0uLOHnlJK9jYvZakRDN
	kIeaxbEITVlOy3vlbQO0Qr9XjKm6cxiWnjN/zfDdy55VStBJI7IM/ibViXify5Kvo/wsf7MUzxT
	Pm2gbDnHuKj2/utD+YneFj7MUTRsSmsOgFITeiXOIPD9vwtVjzawd+a7OdtiMfJjSh8vdD+AmY=
X-Google-Smtp-Source: AGHT+IEijpLfmDUkI2YRHjD1JTnwxBU7IhvhlzVkA/BtS2G2IpI0QWOacCq7I9/JLZl5QwxZz27rxdhYKViR835y/Ls=
X-Received: by 2002:a17:902:da4b:b0:248:f30e:6a10 with SMTP id
 d9443c01a7336-248f30e6dcbmr10418755ad.35.1756386363491; Thu, 28 Aug 2025
 06:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755235180.git.y.j3ms.n@gmail.com> <948a28f26a0e9924d82eb1d8d377e3ddc7335b24.1755235180.git.y.j3ms.n@gmail.com>
 <CAH5fLgjyd7zNqLFT4T0_=tzcPFyw9xwZX+QTA8ShBxZ_Fa6o6Q@mail.gmail.com> <DCDVIR91LFHQ.1C87G5A0OBJ39@kernel.org>
In-Reply-To: <DCDVIR91LFHQ.1C87G5A0OBJ39@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 28 Aug 2025 15:05:48 +0200
X-Gm-Features: Ac12FXwH4U9kGaajYn8SjgOofY0bZTg3SyJryTzi3q7AIGGDgeurcC2n44p8_rs
Message-ID: <CAH5fLgjDwayRzHXS2Dp6ztURBvnv3md3_jnzyL0ZmBQzTnH7gA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] rust: macros: extend custom `quote!()` macro
To: Benno Lossin <lossin@kernel.org>
Cc: Jesung Yang <y.j3ms.n@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 9:14=E2=80=AFAM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Thu Aug 28, 2025 at 8:39 AM CEST, Alice Ryhl wrote:
> > On Fri, Aug 15, 2025 at 7:32=E2=80=AFAM Jesung Yang <y.j3ms.n@gmail.com=
> wrote:
> >> +    (@proc $v:ident $span:ident =3D=3D $($tt:tt)*) =3D> {
> >> +        $v.push(::proc_macro::TokenTree::Punct(
> >> +                ::proc_macro::Punct::new('=3D', ::proc_macro::Spacing=
::Joint)
> >> +        ));
> >> +        $v.push(::proc_macro::TokenTree::Punct(
> >> +                ::proc_macro::Punct::new('=3D', ::proc_macro::Spacing=
::Alone)
> >> +        ));
> >> +        quote_spanned!(@proc $v $span $($tt)*);
> >
> > Not a blocker, but if the way to implement this one is to push =3D
> > twice, then I think the pattern should just be a single =3D and then yo=
u
> > push a =3D once. The pattern can match twice to handle =3D=3D.
>
> You can't do that, since the first one needs the `Joint` spacing and the
> second one the `Alone` one. `=3D=3D` also is a single token in macro inpu=
t,
> so matching only on `=3D` doesn't work.

Ah, ok. LGTM then.

