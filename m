Return-Path: <linux-kernel+bounces-752606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926EFB177DE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF8607B378E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E43257455;
	Thu, 31 Jul 2025 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hplrprN4"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7113DBA0;
	Thu, 31 Jul 2025 21:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753996355; cv=none; b=RPQ9F3nzXwSlf7kWCOu9cMmDc6G8Xqcwz/ZA9M1U6sifurz6C0KtgPSy6oiiY7byNBFp0YHKFXjuXFjAeUe3xql77CFrdkieJ/3vWIofkGFWiSyuNojJwhNq5SQ1VBnCXYGPCBIiJc82PbD48er9NT8VEpvuUbXEnUXA7EACVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753996355; c=relaxed/simple;
	bh=7zOQ73lGD3r2DctJnYtsm4yLzBnd93klxhREuCXh1hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YQ6TaRfyqBMQT26bx/HCRr/XUQJ4S6Kv0itBqBbplkqQxEAN39bTmnLEazfFPIxcvTUzPmI2PctNtYmBIe9BnBKKfwScQS1WIu8NsCB/5KYwYuBqjzmFI/WL7c3LelMfzuHgvYeblWw4qC8vCDOIr31ydFteyDoyNpoAgmm0SwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hplrprN4; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2400a0c3cf7so2406535ad.0;
        Thu, 31 Jul 2025 14:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753996353; x=1754601153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zOQ73lGD3r2DctJnYtsm4yLzBnd93klxhREuCXh1hs=;
        b=hplrprN4EfAKj51vGuvk3Vb1hBTuhdkeIs5hpSn2xAf/BK2GDIfWPEzgovuqITYDmX
         ns0Rnio5ptfajPUCAR6JQJPp5kPpJjQ3npZGSlTTxF38vcswL4B3oEBsI9+nEthV2nCz
         w+ctMZwnPXbU2E+/mwqwHXYB2GIvLnZZtmZy5r0mx3KWJpONc+AUYdgh1/yIwMDx4Vnf
         SVjmpxfwydDRoh2ZygimeuDliw9CWYxdKuZAGedYM6YMDYY25Xb8iHLdTWgP1mgAiFNM
         7eHnIPbMTHqTauY2IoM2vIboptlB5a05afUutpL5MG+nxak05Hl3DgAnejMive/S18el
         Kr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753996353; x=1754601153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zOQ73lGD3r2DctJnYtsm4yLzBnd93klxhREuCXh1hs=;
        b=e+2gc5GAZjn1hCLInrK+Jh69Ny7GwscO0l8WRcvl5WZ4FxM4akeRFLKfu5CYrqFGc3
         7eSi13DSvQj48FeN8aI3FyPA7BYRZu8EH+MYtt81z2wP0xl0IRo7IHNitgDVwFlnGR/p
         TJO7q6xdQUjQa7XY+rtUubwrmfhXePRCNvgKdOk+LcuDF8oQT6D1tgR1dIiI8oiIXWQs
         TX/jA+YuIfoG6Njw+OgHwG0f1C7c45VW/FrsvQZKSWoO1GA3hJ7VdkGF3sffI+FMkfJf
         n6r++OleYidxh6HZUNiwZk2U0xwCcnP+9WOeqSqMAfC5i3/FuyoYVtXsgm3+CGqCjOWy
         pLSA==
X-Forwarded-Encrypted: i=1; AJvYcCUfAGxK96/eisTyGSq/Y+kxdlE2UKBLPS0cxUfqJHZyAyLI+HoP05vREQffxzUZcHrJWCApGznQ0YpUG1o=@vger.kernel.org, AJvYcCVOh5sZVSRFXkH2iSJcFAd6G38zmcdzd3XILREIOPuw+QBBhj4EqejonRLGUM4XTIR20UQK5fZq0wgvceqZdno=@vger.kernel.org
X-Gm-Message-State: AOJu0YysQZpv33WvXjnO173a/juQib/Nyge2VjUtPicC8rx2BTRA3B2r
	xPh8tBMFNFmAgCrwsI1551oI9lsUYbNty9zQS/EnC4/I15QYadt14e1sxTPiFb/hvCK7rOHkjJS
	+cWXzkTblggoJXihRi+VpEqKKN8MAYfU=
X-Gm-Gg: ASbGnctU5Vh043oOuPY2LTxDlZzzd7AlytRY6h0G89bNhl8PB4LMgwWE+E0yJ3I+XNM
	1kQnPN+43qS205KrPDBXnjsbYVQYyUoTQByCSSO7JOQF14TG6DzYGotU9AYUeUHGYzyQGtIbtZe
	OgNNcjWou40krBWtuZVuTO0M7tugJgC3hr7i9Pc60SwfxSKg6mUNe9HVKw+fzbwpAjJePyNz6JQ
	SDyjRkz
X-Google-Smtp-Source: AGHT+IFD0ndUn7SQ7ptwWXChuUa9WfO4EGQJram6R5x2DK0GyiQaaAfe5Cmbwo8R00FznA7ZqRl3T2VMTHDhftH0baU=
X-Received: by 2002:a17:90b:3ecd:b0:31f:3d6:6d98 with SMTP id
 98e67ed59e1d1-31f5dfad39amr5839526a91.5.1753996353130; Thu, 31 Jul 2025
 14:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724185700.557505-1-lyude@redhat.com> <20250724185700.557505-3-lyude@redhat.com>
 <aIXVzIwBDvY1ZVjL@google.com> <f92b5f82b3ad7bb8d5bf60b272aac8cf1e6ced24.camel@redhat.com>
 <aIi7ZycRtmOZNtcf@google.com> <ddea64af3b845d2c32d807c5aab6146a9ce3c2bf.camel@redhat.com>
In-Reply-To: <ddea64af3b845d2c32d807c5aab6146a9ce3c2bf.camel@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 31 Jul 2025 23:12:20 +0200
X-Gm-Features: Ac12FXzIVGgNmeyHw_nmbRnUyJUFR8tt6n3aZ0qpRd8k2GirdGYqI2FwpgK8sus
Message-ID: <CANiq72kL_4=5LwGtJ-67djXzOyjn7VsZsvStUky=JAv4sdS-uw@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: time: Implement basic arithmetic operations for Delta
To: Lyude Paul <lyude@redhat.com>
Cc: Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 10:47=E2=80=AFPM Lyude Paul <lyude@redhat.com> wrot=
e:
>
> Gotcha, I will do that. Ideally I would at least like to have us only cal=
l the
> bindings:: method so long as we're on a config where we really need it. W=
hich
> brings me to ask - do we actually have a way of checking BITS_PER_LONG in
> #[cfg()]? I would have assumed it'd be simple but I don't actually seem t=
o be
> able to reference BITS_PER_LONG.

It is not in the config, so we don't have it. We could add it if you
think it is really useful, but it is based on `CONFIG_64BIT` anyway,
no?

Cheers,
Miguel

