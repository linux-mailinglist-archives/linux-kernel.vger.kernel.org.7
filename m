Return-Path: <linux-kernel+bounces-870413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCFCC0AADC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06B5189E9C2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCF52DF15E;
	Sun, 26 Oct 2025 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQK1HyZB"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4F8187332
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 14:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761490171; cv=none; b=rpYd0ZCHTP19Rh4zeJvOk44vKV5KZ+0I4HZ8f8uBNFyOf12JK+pqnDLTpHP7CHJB/ZBwk2ECObkdXmQ58pTeqUj8JKpDnLoEMZArM+78DU3FFX9//FmnYWgwGagsC7UCNZhDwvPS4LAX4CM3DyT4bqwdVyVbenVmqXZJx/bYWyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761490171; c=relaxed/simple;
	bh=acZ4e+1KY6LceXz3Koq9xdo6+VSQuOj1Oijaluceq6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0QD3nfjiXF4rRWb39lL6rkiKRlFQibZ4noXnzHACic15hNtI9dyOmJ9PdWWq0FE8D1MHqyUo1zj4KrCYwjht4nIfBJ1krBhzFK85CCHRMHyToYdIs9rYZWh1NiJgBdTd3pHjGroM+ea5SXApAs+Hjszi/vCk/HxHweKRH5d0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQK1HyZB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-26987b80720so6589975ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 07:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761490169; x=1762094969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lb6ES41tqXu+5foRoOY9F6w8rssbd1JAOpMDC5HrpGE=;
        b=RQK1HyZBMKWXja4erMaepxLlwIggQ1qE2zekGkybl/ApYejLYfC+yOFfiSS7LeobMj
         7Xazwy20lIfV1CDZez+wH64HaeOhRT1vlupGADVHzZNLAPk22aegvVDXJJVN1VFrALB0
         Bq7ZIlh3FcZE9jmt5Qz9NilV640S5FF9dXfY2EvnkhgwlMZIfTXw/wF4Nm+r1fjY6gTe
         jWkOIDmh7Hf34IQPnqerLdwkF/cpIsLqWFR5fDSPShpoqAthG7Gl8YUOpw2ICMaXEkZ+
         ursGZVOewBHqBWkP+KbDBieJ45yGHc2GMLUrhqxSIL4wI4tNK4kZu9dg8Ixs2ThNZF+a
         +g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761490169; x=1762094969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lb6ES41tqXu+5foRoOY9F6w8rssbd1JAOpMDC5HrpGE=;
        b=WdlKu3iW1soEub+wzCVuzzGXliP8STbT6A9vZJRCuKU/AJysVOwWRUrfTCNxMLPLOB
         /fcDsEa67A2xKntGXGAb/iKA01K45/9YNdKXf4b8tt2u+fvq2aNUtcVAU+0sEtAhk5lH
         b6mSVuBMm+gLJQpFU4+Cj50N0boa24tl2XjvGBQEWqmvYmouef2FdiwowQ+UCBPOW5Ur
         9b/wi6bmyKvGfUTv4qBU9gph9HQcBHZTca3tzGMYW+ig2kmOOHhhMnUYLtrPhvhtC6Ak
         CX1KRopBXf09RiwJl0ixe9a4N7v70Jq8CLT0+JuTeGw9j4ZKIA62BFwU65Z9LOkUAzu1
         TAMg==
X-Forwarded-Encrypted: i=1; AJvYcCWZmrZMnZsyZ4ltWicQ69S5RA2sWvNZ24qthZbK2jbsvYFyPJf52e3UpdrxowjXowHOC5rxFnyukmvJ0VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybOEaIgbyhVnP/FvWBt4Kaj64t7Tnfb7jyYCZE+7tCGwbZo/f6
	VMzsAz9+jBNmHRSm1XBX5JC0k0OfiRtdJ6rwoRkwzxRl7YWVhqbX6jheX92+tRm3QsfIAH0ndhS
	IHK2LraLDkzOQaL3kgzEmJbOwxywVI2A=
X-Gm-Gg: ASbGncvZnkpTuX3RITN+yR/qvL2UVyNEYx+L512saK+KNc245ZytYLf6aeFjdzJ+Sv3
	9Mp8vayhzuVrNAbVGaVseuw1fzBc+ubnT/d9IDQvocVE5JSwDk/b08kjH1qj1NAOsWos3PwdVkU
	CQcnNH95QY5ClxeQB/ruBh5yIHxfZoWwe7shKBCZp4RHwAUAIA1sZPhC6bHU5W3kAFSud9bHmyD
	gZ+CUpCsHNDVb9yKxLouztEzkV21ItAeiNxwSx2IF8DAJd6S1smdjd3Lc8/ue9JYrgrA+kEuSsM
	31f2OOU8PtJK/mxyZ16ylkTztbYxShKZD31tMyGl6sSva4xvWXDT0V7mzGK4yKs5oPmlY1dydPP
	4Oo7/DZPWm+sJ3g==
X-Google-Smtp-Source: AGHT+IEbq1idU6mFUHaEkLHxYClYVOJgW4+NCUJadAvg7TkFzSAWnge1vJm7GcM3ks9O9zyxp995r9uERHVQy8bNrcs=
X-Received: by 2002:a17:903:120b:b0:28e:aacb:e6f7 with SMTP id
 d9443c01a7336-292d3e61e60mr119561235ad.3.1761490168926; Sun, 26 Oct 2025
 07:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <877bwkhfrr.fsf@t14s.mail-host-address-is-not-set>
 <aPtGgNajcXKWpji0@google.com> <CANiq72=wkL_tfmStR1HYOBsyV5_o41YXTtUsCM5t+i80+urxxw@mail.gmail.com>
 <20251026.221126.278291666422815679.fujita.tomonori@gmail.com>
In-Reply-To: <20251026.221126.278291666422815679.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 26 Oct 2025 15:49:16 +0100
X-Gm-Features: AWmQ_bk1MM-IWjmjcUhQCFzYQ8EoO_-8B_XmoPKX-aSUCiL4ZygZDVzwkcDRXBs
Message-ID: <CANiq72nVz64-8W4rYK=oyexMugW9YD7+eMGhcbf9W61kW7Y5tQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: aliceryhl@google.com, a.hindborg@kernel.org, dakr@kernel.org, 
	daniel.almeida@collabora.com, alex.gaynor@gmail.com, ojeda@kernel.org, 
	anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	frederic@kernel.org, gary@garyguo.net, jstultz@google.com, 
	linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de, 
	tmgross@umich.edu, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 2:11=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> I've sent v3 with debug_assert! added.
>
> Is anyone currently working on pr_*_once? If I remember correctly,
> there were a few proposals in the past, but they didn=E2=80=99t reach a
> conclusion on how to implement it and never got merged.

Thanks Tomo -- I think the latest was:

    https://lore.kernel.org/rust-for-linux/20241126-pr_once_macros-v4-0-410=
b8ca9643e@tuta.io/

Cheers,
Miguel

