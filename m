Return-Path: <linux-kernel+bounces-886332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7489CC35439
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9B9F4F6729
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AACC30E847;
	Wed,  5 Nov 2025 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjMcy7OW"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB963081D8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340057; cv=none; b=qfCD5+1YLIvJGG0bQ44Z+FtWyJvx8uOAe3XiyRY2bJN9FZlK6oSL2dXZs/8AaIogbpMdkjJfsNXRL5g3OO8INY7z8zZaU4KLG0litFNR/qR8YHeimVWnhiOC704vF2Dw09DEJtpEbGvUpz1LkSONRwBTZrFSPVDNne690A6WqWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340057; c=relaxed/simple;
	bh=rLYGShjvH0ii87qREH3WO35v8IHXOBPLvlHQQ38IJz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOj68o30QcGUh6wLwkXMpqVNN+kZBIdwaAj+/YT+E4wc/IA5x1JgVwY33+dCTKyOamyBjByLeceQGRAzBVKl7AEhsdS05wE2WJmNGnCeEC8eJGr7/9gXtlAP3o7hFoBZTBfvZlmVdt0hPlJWRYDIXH5RC+7rSBsUYgOwA75lHpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjMcy7OW; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c28c21aba1so4008921a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762340055; x=1762944855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI+zvnrKdhRN8SIehVxo9mkD9QgvEwvxC3LXtBEgkQ0=;
        b=UjMcy7OWjWCaW/DCk7GTJ1FQ67cT7FkJi1DDY8H6kgwpZmbp582osfW1a/6LLO/vz6
         96Njttx+wh8KMTeGERtKg2chOONmr1/XY3r5s03kP4MWfe5x9K6k6Vi2tUJCpDJljUae
         g44mr2LtI/IpJ7VzpNq55ie/c3HN5CFj07V4pnSVMDhruUPdo9anhAc5YUPJFJF3WudR
         uQaBrFr0i4WJB8TJo3Z2HFyuv8CA3yUfw3Km2Oq2xxpvvCrQjLBm3uepCFNGffJ1+Sfi
         erCEZF6zygeE9tvy1VtCIAPxe126MSk4HO/XYhf1RLN/dfCSPGIjd2anFtxnG42uMGz8
         zg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762340055; x=1762944855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UI+zvnrKdhRN8SIehVxo9mkD9QgvEwvxC3LXtBEgkQ0=;
        b=qBwHapaCvOdoMr1IiGRQQnhVYgCbdaL32sDh/UZTwtYAjf1DqF0U/3dQKJdHjnhjrW
         ZuJUnE4hisI45h5ocqWzpDTJccCsOmKEgEYAlwP6yD3lInkQxNRSB4tEU8xdYzDrcj9x
         9EyQ2Hys1QPwCmUGkJ6Apcskg+eLCa3OagiXQW4PoFcWrlxSzARu5QHrZCA7xa9ZG/jD
         SXFUJKchExy9TWVnvWGjx80u0DZDXonMIByeVubB7vzYsmmsl/whCHyQGFhIhma1RpDE
         uor/5MrqlCrQw26HsvNN09SuHmIfh+2IvDymoP6jITVHxB/LngyZ1Q8JOd0HTf8HiVXw
         v/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUOjxRhNDeb4pkyUqE7yAI5YQYc/bwAGxeuLeRGPVmEZf4m7xnIzUGg5WDkFoyyocaKJkWNjaHbTDm65PA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAxtN2E4f7rg694NJwqUp44dXHw44d1dkuafOIbawQbQOo9m0o
	a2n7d3XgcPFuJfCB+GnupMz0+ufP4HR/mnHaP1gDdikLZZ0SKeSJfO2CYXnCaIWVLHQ+ZvbrAdm
	EPkYX9DacUz91XMF9zfPAwWTfdSTcIQ4=
X-Gm-Gg: ASbGnct6S1LInju9Wn3b9kzz+wLA9Us1irwafMUnssdSUv6ZogBg2cvHZ7AqNDslhZw
	8Le7egtcqd5s/F3hrQKeuvPDY8LAVFT6kCFizR8RTXhzfUrgaySabHoZRXbDJbtafo0f3XP5P0f
	097PZV8txfCbdMA3a4h4yXhlXapAvaK1RjiNw7D66iwmwN0xehEOecMabZWAhDsagEpdLqxzda8
	T+nqW2Ed31jm6qb9O5nVH0uA8JI1NqydNoX5boc6uNHhF4MrZS/B9nLzsiXq4Ez7OGQnpg=
X-Google-Smtp-Source: AGHT+IGOrCYrmHNMLavSyZ02ydICrKRBss+q8PZq/0Rzc5ZPlgYctyKGHcxtmk3f5rN9LiTKlT/v4xGFjERNNmxuico=
X-Received: by 2002:a05:6808:21a3:b0:43f:5e91:d556 with SMTP id
 5614622812f47-44fed48970cmr1063735b6e.44.1762340054900; Wed, 05 Nov 2025
 02:54:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-2-joelagnelf@nvidia.com> <DDX1WYWQNTAB.BBEICMO8NM30@nvidia.com>
 <20251104005812.GA2101511@joelbox2> <DDZYCRCPYMOL.RMTIF0R404Q4@nvidia.com>
 <CANiq72=Cj_gJ27+EAiytxYGYk1dMwu7M3xQpLGByD4QstgDsHw@mail.gmail.com>
 <CAAOQCfQ_d_C7oZ9uq2siJHn1+m+j059qYUMBvTWOnQ5Etk91ug@mail.gmail.com>
 <CANiq72nLzuCXh0r5W0HMM36f9yTSQfP9yCxXbzH+wS7VxFM2Eg@mail.gmail.com> <CANiq72kYYu9C94aY72HK1ELSmvktF3nq+G4+smdAW_Xaxw1kqw@mail.gmail.com>
In-Reply-To: <CANiq72kYYu9C94aY72HK1ELSmvktF3nq+G4+smdAW_Xaxw1kqw@mail.gmail.com>
From: Guillaume Gomez <guillaume1.gomez@gmail.com>
Date: Wed, 5 Nov 2025 11:54:03 +0100
X-Gm-Features: AWmQ_bkMmilAyN1uUJZCacC-4Uedu5I4tT8-UDX7Z-O78YpFpr8K3EAt082H5zI
Message-ID: <CAAOQCfSRVqFZAJN_m-kGLe6fnqKYyhLUf_WOKdHHMW-C6NShkA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] rust: clist: Add abstraction for iterating over C
 linked lists
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, dakr@kernel.org, 
	David Airlie <airlied@gmail.com>, Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, joel@joelfernandes.org, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Andrea Righi <arighi@nvidia.com>, Philipp Stanner <phasta@kernel.org>, nouveau@lists.freedesktop.org, 
	Nouveau <nouveau-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You can add your own tags in the doctests, and with our patch waiting
to use the new rustdoc doctests extraction, it should be pretty easy
to plug such a feature into it. We can check it together if you want
when the patch is merged to see if we already have everything needed
or if I need to add more things on rustdoc side.

Le mar. 4 nov. 2025 =C3=A0 20:06, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> a =C3=A9crit :
>
> On Tue, Nov 4, 2025 at 7:35=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Orthogonally, the script that generates the doctests could perhaps
> > help to automate some of that. For instance, we could have a way to
> > specify an "environment" for a given Rust file or Rust `mod` or
> > similar, and then every doctests would have the code prefixed to them.
>
> I guess this could probably best generalized as "tagging" doctests
> with custom tags that `rustdoc` just forwards in the generated JSON.
>
> Something like:
>
>     /// ```tag:foo,tag:bar
>
> would give us a:
>
>     "tags": ["foo", "bar"]
>
> in the JSON. Then a custom generator like the one we have could do
> whatever it needs with it, including prepending code or other things.
>
> Now, I see there is already an `unknown` field in the attributes which
> already give us the unrecognized ones, which is great and we could
> potentially use that.
>
> However, should there be a particular way/namespace we should create
> our custom tags so that we don't conflict in the future with `rustdoc`
> ones?
>
> I have added it to the usual list:
>
>     https://github.com/Rust-for-Linux/linux/issues/350
>
> (There is also the question about supporting the old non-JSON way for
> things like this, but I am ignoring that for now)
>
> Cheers,
> Miguel

