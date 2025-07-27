Return-Path: <linux-kernel+bounces-746999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F62B12E15
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84491174108
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 07:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAED1DED64;
	Sun, 27 Jul 2025 07:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnG1dpsG"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311D2EAF9;
	Sun, 27 Jul 2025 07:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753601415; cv=none; b=hAEMc1tRn03RYy9OuJIw9ISsIzVWH0+sRAkh9oeJrw+3d8OsjBw63t2hrjlF2djWFOL3hgVvWbjtXc5DpCwlfTf0cVgM2YzgngavCctDj+mxs9vpJOf+etUgs+rI7xnzoxwiJbkg57uATp72Fbs4OHaiUdag2QK7sdXN+7EZIhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753601415; c=relaxed/simple;
	bh=kNV8aCBViV7hWYcNaZGYfd7eiThGpZ/0Xoi3AWdOKJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ornE6d/eh0GegXd4Ug0v1EeI2+IqTrCnDmXN0hqrgNbMB3y4mB7BdVmKdeX7kkMGYE8fogpc8/CpOu3pWPNmn97Di+UqLW0Na6JQCQvbHYzWLbhG/7aUFAN2a0w+oHEvSBT3Gg7j94lTBEQivVrFCdSAZO4Q4zK53gIZiqNqTg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnG1dpsG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso3796748a12.2;
        Sun, 27 Jul 2025 00:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753601413; x=1754206213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPA0Qh607WmQawob0H0xv3xGagvAWpiX4FTZcJVfoAg=;
        b=LnG1dpsGAr5bCBkz5yNRwbtP57Mt7XjqHeyuR3TvyxK9kty03x4VtMY2/K5HykLVhz
         5aNOJ37arZ72pjqpRXZv9Dvlhjl05KuZGVzPlqat/pT6O92no3Vt/MsfEW2zysW7tVeo
         9pqaA/DPUbPtTTxF9qEf1VZ8DBIKGQK2XljZCqJUo25+difMj/Wxd7e4ZM42Im6Rxjo6
         hs0XShjhZ45iMFP2VqrP/mVYixJ7l2SHnbEq6iBDZxzioFuVQfpQiiA2BF90Cvf/Vvz4
         K1yVIGQc0dIQL2/ST+w5oUmWCpRcKiLq9ldYDDRT2/f0vcRYQrA9pzKdJUskTea4pb5A
         v0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753601413; x=1754206213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPA0Qh607WmQawob0H0xv3xGagvAWpiX4FTZcJVfoAg=;
        b=Bp+IrybPcMeNmeAUCy7D85G6gW11zaFB7J8ed/Eh0LOYtUvMa5nJfT35NJMxwdsMFP
         ETMnRpgKkBMQTDb0dm1OPo7dKT0ga9TbTb/3jLim4noxWJk9mUE/xsSV+8QFjJ45KwID
         fsHmcwhAK/3gRYYaWSHpcFcZ65BJvOSP7q0pXqvUpUGhgki7MS7oU/pzY6Rp8DI6MbEp
         LZJgAew0b1VhH0taEfu8CemUxzo/KtPYfsDAJPl8JuJop+QwbXzJ1ce215mEc9gZP9Xn
         QstRIElsKU/pBbFC5sKFAdPD8gAhJ01C+2ce3GHAZX2AFKARqDPDtGp1TKAtDTJUv+Gv
         OqyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7s+a/lcwFAWAyVikTZNV4Nl3y8zR4L7UEUs47yw9LSQr8gJz+99XG81OZ+ybHbPntFATwodmTXZbGMwvwfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/R9KFYdnz5eQ8zGlTOxkx/eYIT3BdHOym/b6vNxkrNoUlk74g
	1GHLTDhPfi8Hm7Hy/iuH84XYW43oF5el+RAh6xRI3K5akWlsRwbLnYj4MWZhQWB2hR8TrYkmW0t
	zFdL+8r/1FDrK1xZGXaT/p3peE1d/XUc=
X-Gm-Gg: ASbGncuQmO+DJ8CVvALx5PhjYNHM7E9Y2HrQo/DjgYF1YsDCd14tFWGDIsnXI+3b4Xl
	Eo/i+hqFfrc6f6/3PsTjZrr/wwHHfqq0j0tjBx0elugjpRSSEgA0MOd/Qp5hFZ9pBxGzu4MOaCh
	iiXfKOjIZTwlC0P/+OX++5Jk64v63C1/okYu2A9ljmflGXOMS8MeuCTi20exE/k2KluV0fCJEHN
	sA7tg==
X-Google-Smtp-Source: AGHT+IH7q4rWNmN9N5xGF8NFaSfx4/P19wRIZA2UaLxZEZpA6oBfH+rOaUYZQRgchbMabEJy1zR92XjDyn9QLqKQ1aE=
X-Received: by 2002:a17:90b:394b:b0:314:2840:8b21 with SMTP id
 98e67ed59e1d1-31e77b1ae45mr8972492a91.32.1753601413402; Sun, 27 Jul 2025
 00:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717073450.15090-1-shankari.ak0208@gmail.com>
 <CAPRMd3nhDKApttF_wBU01es76NG=qAyZMAer_gjbbtTSH_FmSA@mail.gmail.com> <CANiq72=uDrg9HBVM97dgJGaC946Or964-2aF6OJVV0ih_vWuRA@mail.gmail.com>
In-Reply-To: <CANiq72=uDrg9HBVM97dgJGaC946Or964-2aF6OJVV0ih_vWuRA@mail.gmail.com>
From: Shankari Anand <shankari.ak0208@gmail.com>
Date: Sun, 27 Jul 2025 13:00:00 +0530
X-Gm-Features: Ac12FXxmJp8Tg27F3w3FCMdKdLvSDzVHyq-RdKwTv2IEOeBNO3sOiPFS_LzOIgE
Message-ID: <CAPRMd3kXUJC6rC_X4i41dWNpS2tx4aEXFmBuEwncXmdJewinDA@mail.gmail.com>
Subject: Re: [PATCH 7/7] rust: kernel: update ARef and AlwaysRefCounted
 imports from sync::aref
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> It has been only a week (and we are close to the merge window, thus
> maintainers are typically dealing with other things/patches):
>   https://docs.kernel.org/process/submitting-patches.html#don-t-get-disco=
uraged-or-impatient

Apologies for the early ping, I was unsure about the appropriate way
to split the patches and wanted to confirm before proceeding.

>  Having said that, I am not sure why this one in particular has e.g.
> `opp.rs` and `devres.rs` -- those are different
> entries/trees/maintainers in `MAINTAINERS`. So it would likely help to
> perform a split that doesn't involve different subsystems.

Sure, I'll carefully split the patches accordingly in the next version
to align with the relevant maintainers and trees.

>  By the way, if you meant to send the patches as completely independent
> ones, then I would suggest avoiding the series notation (e.g. "7/7")
> -- at least I see them in Lore as separate threads:

Regarding the series notation (e.g., "7/7"), I included it to indicate
the overall scope of changes as part of the same effort. However,
since the patches are independent and target different subsystems,
I=E2=80=99ll avoid that format going forward, as suggested.

Thanks for your guidance.
~ Shankari


On Fri, Jul 25, 2025 at 7:33=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Jul 25, 2025 at 3:02=E2=80=AFPM Shankari Anand
> <shankari.ak0208@gmail.com> wrote:
> >
> > Can this be picked up for review? Should I be splitting each core
> > kernel file into a separate patch?
>
> It has been only a week (and we are close to the merge window, thus
> maintainers are typically dealing with other things/patches):
>
>     https://docs.kernel.org/process/submitting-patches.html#don-t-get-dis=
couraged-or-impatient
>
> Having said that, I am not sure why this one in particular has e.g.
> `opp.rs` and `devres.rs` -- those are different
> entries/trees/maintainers in `MAINTAINERS`. So it would likely help to
> perform a split that doesn't involve different subsystems.
>
> By the way, if you meant to send the patches as completely independent
> ones, then I would suggest avoiding the series notation (e.g. "7/7")
> -- at least I see them in Lore as separate threads:
>
>     https://lore.kernel.org/rust-for-linux/20250717073450.15090-1-shankar=
i.ak0208@gmail.com/
>
> Thanks!
>
> Cheers,
> Miguel

