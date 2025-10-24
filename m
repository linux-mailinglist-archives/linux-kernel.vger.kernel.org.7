Return-Path: <linux-kernel+bounces-869420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A50C07D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6380F1B804CA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEC83557EE;
	Fri, 24 Oct 2025 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6LLnX63"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F72C15A2
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332733; cv=none; b=VYNcT6aH6Z/aUgYrSvOLTFj2ibM3QjNiQraEXz2ltbDVcJudB3SHrQORsu1PvXY4JuQeBP/Qh/40zyJwkz2+EEzGT5UXmSFdgI++eT4Ia/4oHnY+iNF5jFNN2JTvUjMQ3dChGRofF5c7BOCD9ktfcDbD5zfh2tpPDQsKUasQUHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332733; c=relaxed/simple;
	bh=rHL4FE/dtNnPtIVflrQewItkPhmWUwSP3OT4qUFqjkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxKzYOCBiibimqBUFthMC/Ldu8af5fS61wldtCZoYLoZPA3/uTnydXgeyqtZB/9FE+YElaBHgpQSicRVDORPYNlre8+3vTbEwGIGXSHZ9OJA3cEuKxpuel1DeBOX6oa7uBbBTpOq9R5qIiWbKjehDDPwGjHOvTjdfr3zFkQySbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6LLnX63; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-290a38a2fe4so3034745ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761332731; x=1761937531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHL4FE/dtNnPtIVflrQewItkPhmWUwSP3OT4qUFqjkI=;
        b=F6LLnX63jlcyljaJsB1Tn0I2FLbDyxACVpEEVK7kaMnqfJDOljIH0Jio9QhHUgvS5n
         ODXtl+XsnuHbagiQWN2FWip6xfwmWSbvcMbOgs9yxlqwZmRCJHYzEAA32BjMVCNJBIi3
         2B7TrufK3+rRYZSDhlVUVTC0tQ38DPYIKEvnjyrf0OcZL+jWrrUGkfCEDBirY6RDTN3g
         0T0F2I62NXYO07YEnBChvLUfpHAjaIGiTsRZzwYGVwzG3DK3msM613QJNFe++BNYIPZi
         ceeomhyhJFrV9ZcUC6E7yUXpdeCg7iXYWMY1Urk2Qu0rjJmGL6fUrFmwGHGAvuXVaxTe
         7Q6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761332731; x=1761937531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHL4FE/dtNnPtIVflrQewItkPhmWUwSP3OT4qUFqjkI=;
        b=D/kslEZcXRtnF17rIRdzhZ3ZchwyKYWwyONLcPJvHMlD8OePWInY6jPv7CggJkfspK
         E4IR5Dp/sPb+Zhjcz8nePDNRHN3meHfKi+Fy+QhFv4oX5HHNwpwzJ4zl7RP3X9MFVwit
         kJGnmAdyd2A7KlaZTpP/Nyee1VATJ0aU3gc3jEUxguaWupNoTLNj/TuKYyHbczqRqbKS
         P3/ICRYhsVK7WbQeVKgkLLDCawWtUmm0iUO9KYTKdCZyWH1lP11yFWQgiF1emIY4If5z
         izlNsmP/WANt9rG9YbNFtlFHfGkmbaO5+4b53ppuklrkUQ8T5+16Od5ueF41sLo6usKY
         9bww==
X-Forwarded-Encrypted: i=1; AJvYcCV4GMFbGaPZYLEeS464/6Q++gI157SDEBgbE01t9oRgboYT98dBwUio+1o0dqxuKr2VXTGzydP3GbCiCBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6azB8A38hUKXsEvrlSvyQfq6v1qohCCJuFOxVAMdJ4cdb8A2C
	BXlpj/AxU/jQjAPhJbKHHtLRCAw1TYVL3YRrj5oEbsupfFQAjSo3yZLNutd0NH2iNZcvOQNTWXL
	I240/PdF44Jd9hJ+hoLhaotgq/ZCEiqM=
X-Gm-Gg: ASbGncsmQ5X7gJK3xj6/LBZXBOBBBoApOQlpJWd8dyh7Xk1gVCxi12kK4RVJ75cWPtc
	rR1Xb2UUeHIkJ+XTK2liALdv8qKkL00UBsd6tb89IKG6XtDfY5PatAlMmXtBDdhDJnfh5A1Ac2p
	YqNtVxsAZQfoKJmunlGFZG1BO3J1CeIIwPkcboQm1igTSHq/sXbVln/ovWxm+8IRVJkH4YraBh/
	kvZjOaXaH9jGUTwCwBs87zb96EkwMvzxM9jWMPyPpea+ZE4a4sxeC4opb37/fGpCGvcg5lr0wLi
	Z1aBmsMKZCPPrZcYaI9aFAzxrEsr/hjKbXWuBH7Tpoxvdpglog/7AqaAIh0k+svFHIsxiFw0ZbI
	Np3I=
X-Google-Smtp-Source: AGHT+IHC/LmSx7U8/fIkf7hqohtOWqKh9LKWk6SPDoT/grppijaYwSmTjW7vhEVsjW8KHUqY21yzGxrgOXjCeBQtfAs=
X-Received: by 2002:a17:902:f787:b0:290:aaff:344e with SMTP id
 d9443c01a7336-292d3e447f2mr110350145ad.2.1761332731541; Fri, 24 Oct 2025
 12:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DDO3G26SIZTK.1KV7Q0PQXHWTA@kernel.org> <CANiq72nUiizxo3YFgxUZ1jiczRNbY2ATao2YUBiCEC7k5hbv6Q@mail.gmail.com>
 <DDO3OMBHS8TB.2LDODR1AFRCU3@kernel.org> <20251022.193230.585171330619599845.fujita.tomonori@gmail.com>
 <vTqqW7yepc41IJ7rUH2GAcWAJ1HHAUQ2_NeQ_os6L5MKNZ-acMHFwH9u3m0oRDumL2YQPnZ6Qu58-iLlAv0Tew==@protonmail.internalid>
 <aPjmKSrETqrchW_e@google.com> <877bwkhfrr.fsf@t14s.mail-host-address-is-not-set>
 <aPtGgNajcXKWpji0@google.com>
In-Reply-To: <aPtGgNajcXKWpji0@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 24 Oct 2025 21:05:19 +0200
X-Gm-Features: AWmQ_bl0Z3bZ7APKg36k88fOBuFGdgN0OinvXHmiYOi28xOnOj8ytbzou7iQKEs
Message-ID: <CANiq72=wkL_tfmStR1HYOBsyV5_o41YXTtUsCM5t+i80+urxxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, dakr@kernel.org, 
	daniel.almeida@collabora.com, alex.gaynor@gmail.com, ojeda@kernel.org, 
	anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	frederic@kernel.org, gary@garyguo.net, jstultz@google.com, 
	linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com, 
	rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de, 
	tmgross@umich.edu, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 11:27=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> For range checks, seemingly unrelated code changes turn out to affect
> these optimizations and break the code.

Most of these calls use constants, so in those cases it would be fine
(and otherwise it is really an issue on the optimizer).

But, yes, using `build_assert!` on the "normal" version of `udelay()`
will eventually surprise someone, because someone out there will start
using it with runtime values that happen to work and that later may
not when code gets shuffled around, especially given it shares the
name with C.

So for functions that do `build_assert!` on parameters we may want at
least a suffix with a particular word (e.g. `_const`) or similar, so
that it is clear calling them may have issues if not "obviously
constant for the optimizer", leaving the "normal" name for the runtime
one or the const generics one etc.

Here, I would suggest we do what we did for `fsleep()` and likely move
both to `debug_assert!` plus `pr_warn!` (and likely `pr_warn_once!`
when supported).

Hopefully we will get soon enough const generics that are flexible
enough -- but passing primitives seems bad here, we want the `Delta`.
So we may want the `udelay_const()` here still.

It pains me a bit that the common case would have the longer name, but
such is life.

Cheers,
Miguel

