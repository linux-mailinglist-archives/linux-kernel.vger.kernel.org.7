Return-Path: <linux-kernel+bounces-885377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C72C32BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77A4188F0DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B16334C17;
	Tue,  4 Nov 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UG10ciNg"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC172E62A6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283215; cv=none; b=JNIiJexpeASJ1i6reimy6LKneAClLiNeXPHCq3xK2ru8MF3IiZgFK0dZGaGVs0GlgM58vwgn/ypVhrXz2A5ZgcJciKfKrsY/ixpEjPiOXifOl3f3wauY8UOwOqTPO3wLjoWDtq06V53uLuEPDK7VNVM6F0sAf92lAjphErpqUnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283215; c=relaxed/simple;
	bh=hcYL8k8PGVIqmqm+I5iUSWXrgxNbr2ybXnIE8pG67Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwLFP+1lzzTIAls90nCgbptoIz07Hjxm9dnMGhKNibfZN3vUGecEP5w+KL1BHjWZcb23XPXnXB5je4VWq+j+R8HtM/lUz1TjjQGxOx9F1AMbLd2cm2h87i/6lTMAo9GhLt+ze1YhRFE3MOvZjmoVfxUzkhMYo8rdDcFMlkxg0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UG10ciNg; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-78283098d7dso289863b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762283214; x=1762888014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wAeCuRxzb2BXeoNq8+i8slzGY9RtvDmLaGwdLPgLzA=;
        b=UG10ciNgrf/5ojW2OtFJQcHE2fJSXCWmmcV+prCD+PLOEXg3Ev2RxMDBZKAZFWpocO
         MdgmuqQvRvNCN3NQMPdhqYS7Z9qQ+fU7ANUcYYtLfyKwD3PPR9VdFv9Yxk4tBeuJMacE
         umT/NGniNcvyJvj8PPAD5lQpGDNgmedXOyj7BIJXATbUGKVn4ut11pdspoHl7XxTJQpe
         HZaVZy0sO61d0OhoASIIappR2wNFBa0BCkdenYyaM9g4d+Cb8hFqf6hXDSReLXYlzotW
         BSsGYqbPjwQbzwo//TfLy8ueo/n6Lk+eYKPVwXBkQ4iSlh28aEObQxBjgt+9hvihXPw0
         nRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762283214; x=1762888014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wAeCuRxzb2BXeoNq8+i8slzGY9RtvDmLaGwdLPgLzA=;
        b=Pf/OB+ddbdSieJB4Pslm+W7HEP4HvSv+ABrugLCbgLMdo1KdZ2j55GUGeTBG/wt0TB
         aFJCDV62+tXk3KX/hNG29WxgX/foykBJMz92R66K30Gg1NT400TDK8hTsNgAXT2vYN8d
         ZjO6zEs5vzl18H8d5brQtVssaQd/aKDy3rhBZQa5FpXwiuEhaX+++3GWfpYdO4DW2a77
         BFoyq8LzrDk2xrjtkwHnr7wEyhyNLqAeQubXApXHk/MSOwL5W69GwB1CaEH5hUMkaamJ
         OpkWFS8gAVDqPSin/6BDPammd9j+eJrP1EtnwWm1T8nQ3Qrc37wSA7lGqnnpl4m7yXEp
         ZgZg==
X-Forwarded-Encrypted: i=1; AJvYcCU//UaXFQAg/7dYehaaJCkrYf4P+xHn6LvluDA/b88KI14BPUe0Bp5LxU6TUidu0lCImndu0GqlPYul7B4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3HTTgHxAZLFE/MTd634epoM5WcVvCYel+/cCkG+FhaVhKqLOk
	kXlQahi1uHt6eihlM/JBq8/DUTfz6Kd1VwAk6QOl08ZmvxlPyi8VL7+tL2pou0J2CSVtZIv2Syn
	aNqR49oT1fe4Q64flsxlln6ieoHpBRag=
X-Gm-Gg: ASbGncuymk1INvwvuDQctZU38tTjbIYcBXbd3fGL7NnJvHkkuNFyJp13c63gcihzwod
	9wGhcK71uW6Kf+2bMegg3n2fVXsNXZLxaCOy8g9GSZ8kJm7WW4nUqRPAvGBaMLZ7hOjjrgFlMYz
	6Txh0OVqYS1sul+aI68SQylQnuvYU9vIGiIdD+yrbIdxEPzMIwBHL08k8ItSVXPx3uaDJ64EQoD
	LjK7AGLgL3vUguCaXSjGuclRZ+KMT9+QN8oC/6gKZc32z3Swbm1ZIhQSg9YKEAf+4fnHkKnHMnq
	hQ9UG9lkk0JlCL86TE+N4Y2oSnR5l/lPT0N88XtphL641XdZ8ptGfYO4abPf0cW9YqqhP0ANu1Z
	FwrI=
X-Google-Smtp-Source: AGHT+IE6zMw0orjCDwKe71BtT9keGPs74U4T3Nt51J7XxmrJZBuNOyX0hJ52/hdnOd+9OYS5PomAI+ZTVm+Zm9uBsjU=
X-Received: by 2002:a05:6a20:3d8f:b0:341:29af:3be7 with SMTP id
 adf61e73a8af0-34f86d04830mr209534637.7.1762283213593; Tue, 04 Nov 2025
 11:06:53 -0800 (PST)
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
 <CAAOQCfQ_d_C7oZ9uq2siJHn1+m+j059qYUMBvTWOnQ5Etk91ug@mail.gmail.com> <CANiq72nLzuCXh0r5W0HMM36f9yTSQfP9yCxXbzH+wS7VxFM2Eg@mail.gmail.com>
In-Reply-To: <CANiq72nLzuCXh0r5W0HMM36f9yTSQfP9yCxXbzH+wS7VxFM2Eg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Nov 2025 20:06:41 +0100
X-Gm-Features: AWmQ_bnwMN6fmA9J5YYRK5sVTYidOU0VW_dN7yFlDXkN-QCauIAosWdhzgT_uW8
Message-ID: <CANiq72kYYu9C94aY72HK1ELSmvktF3nq+G4+smdAW_Xaxw1kqw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] rust: clist: Add abstraction for iterating over C
 linked lists
To: Guillaume Gomez <guillaume1.gomez@gmail.com>
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

On Tue, Nov 4, 2025 at 7:35=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Orthogonally, the script that generates the doctests could perhaps
> help to automate some of that. For instance, we could have a way to
> specify an "environment" for a given Rust file or Rust `mod` or
> similar, and then every doctests would have the code prefixed to them.

I guess this could probably best generalized as "tagging" doctests
with custom tags that `rustdoc` just forwards in the generated JSON.

Something like:

    /// ```tag:foo,tag:bar

would give us a:

    "tags": ["foo", "bar"]

in the JSON. Then a custom generator like the one we have could do
whatever it needs with it, including prepending code or other things.

Now, I see there is already an `unknown` field in the attributes which
already give us the unrecognized ones, which is great and we could
potentially use that.

However, should there be a particular way/namespace we should create
our custom tags so that we don't conflict in the future with `rustdoc`
ones?

I have added it to the usual list:

    https://github.com/Rust-for-Linux/linux/issues/350

(There is also the question about supporting the old non-JSON way for
things like this, but I am ignoring that for now)

Cheers,
Miguel

