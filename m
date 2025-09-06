Return-Path: <linux-kernel+bounces-804001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D172B46894
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197C37BCD9F
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 03:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1A322F177;
	Sat,  6 Sep 2025 03:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Utz0GLM"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A0A22A808
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 03:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757128792; cv=none; b=lmOMtLyceVaW6Gh4tMtQ6tU/YV3ah7Y4wX+3s09yS+mlKJVNmQYnrGlgIPAf505ktgy6chxFNB2TL9kzEdupOBp+cd9ocqoQ1evE/SBoaoWEjQRe0vSTewlmDtihRY99ZYDR3Aw+QMa2oGOO0pWgED8Dytq1DYRZ5wPWJoqEUrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757128792; c=relaxed/simple;
	bh=i0jDtPuAuQMt1NM0OTOsP3ZSUoN0wBDTLoW32cCtkys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9i1AjSDL80Ll59SRlk7EFlcCO8xWWKvuAtHSsjI+P8CC4bmaMlByLW0bRw9t2kdwzsLXIT5dxjcYGaNz5QdM0I0V+Sdmi/n8piCnXRbmhAhcOW/oAlIjCoGAUIR3A5Rf4BUI11Z/feGo8fTChMd9Lz53aIni1L+lINXja1wsYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Utz0GLM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61cfbb21fd1so4344a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 20:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757128789; x=1757733589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUnrEbym8cWaiMWORTWqmwUrvmW7nXo4vpAgjGxb8aQ=;
        b=0Utz0GLMuP8tViw6Sga50ji7n51DEttRaPkRwSYoYkYxK7Kd7OCcjDn2CKLtSZCL+8
         rj7OURbwlM2I1rCmuS1vj1zwNYdjiYKdaihLYeiy9xcXreS3gdqFHiGeLlW2QT7e+xp8
         2unFmSPXZPRM5wO2sLcEz11rUS2ifITnjL4W4J//S2fGlDPNSxmhbc1Pk68R3eGa198s
         Ngm2HE7VKAp5UTy8JDohS0Y1LjUKj8ql7y6GgdCN9gVDoBhVvsC/yje+M7Kbj0x/3Ia/
         lPDlwqT7NUmtcdfV8cJ9k9nUGOddgKqSSvULwMOmK5c3H8oyZDFAOkY2Vt8UuI1eFeVm
         DiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757128789; x=1757733589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUnrEbym8cWaiMWORTWqmwUrvmW7nXo4vpAgjGxb8aQ=;
        b=BNKU+5LOvUDveITQQTw1JbVr2fd6i0t1kJqpXLd1+319i5CSG0rBJ0y3gx0ictTGq3
         8iNs8RI0VvidJmjp1JRciahvuESTzx6IGuxMzgibbrISWcheR+/tadj12kqZlVv3rpUu
         QHpJ4Lg0Op3lvE+yXQk6FcZD7oag1Rk7QTkjpSfhKUPdFcGHdTAtUj42twClF59CjJhP
         EeYYYwuW/6CQu6nqHF82AOz3dFzV6S5VIYLD98xALT0wHarSXOQ8zwPfk0AobbUIRdHn
         dRPsXJGHlS0Wfy7gkjL94xledv4TVdIsWisZrT3eaMQFxx8gqRRsaBSUG3Hmz0IZ8JHt
         8tqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/ZU3cfmf4/YawO3mGQBoz3pUQBFw30YVXQ13oSxIGNdEDh8ftLmDjXmke48kG3WygY6vMq2anyLdeMxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfYgrlFBM8icy2NooJbC8G5DnpqslNDme6ac1932hWBiG4wHw0
	D2+adzYHp13+XPL017dJlJ6qZmvJ9Bkb/47DjJEkHE8I2oT3pRCU1iBC/s0m7lQLU7/ZiHuALqr
	ONCTEp7qpq/podQbiSItVeMePCA6gesVimi3wpGHc
X-Gm-Gg: ASbGncsuUCTcmCP/8sMqfNPxDeTKx4rEkgFYUtEhmRKGVdj3OJkDZHVjgaI+3tSUt9w
	OAM8A56PXTGHu+7Ymu9ySrbSNA9OBqmDMQN/ndm0pMghE/lEux9wsaRm+TgTqKlrje4orXHzocT
	PyroJizNE8XwV0FZz6f0TYiBqoXkNTR1P/sV23VqHIAo3mePa1zKNu/boB6feWypD+9gR4su8ep
	0gQqKVhkvRkEb1dChjmuaLQi0kwlqE+ys6Y8/zs8w4bRQ5Cgf4=
X-Google-Smtp-Source: AGHT+IEpbvl1msst8Y8AhGIvfgeiQKuRecMVvBy0eQgxYcmCQKMzwJNAg62WHMaeTshzfL236ebrPRRUZ+ytR5USn9g=
X-Received: by 2002:a50:d506:0:b0:61e:ce79:1da7 with SMTP id
 4fb4d7f45d1cf-62356cc4e97mr35864a12.6.1757128788834; Fri, 05 Sep 2025
 20:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-5-7d12a165685a@google.com> <DCKQS4126EVC.38ZJ0GOFDYCP7@kernel.org>
In-Reply-To: <DCKQS4126EVC.38ZJ0GOFDYCP7@kernel.org>
From: Matthew Maurer <mmaurer@google.com>
Date: Fri, 5 Sep 2025 20:19:37 -0700
X-Gm-Features: Ac12FXyiznx642yKmGiPP2r86OtClJU0KrUs-LmHZJ_nsO5FoE6RnPhhD18rLLU
Message-ID: <CAGSQo01He7cNvcOQBxAqLicSjKniSp=97K6GupnxS4B=G9p4rw@mail.gmail.com>
Subject: Re: [PATCH v11 5/7] samples: rust: Add debugfs sample driver
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Timur Tabi <ttabi@nvidia.com>, Benno Lossin <lossin@kernel.org>, 
	Dirk Beheme <dirk.behme@de.bosch.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 2:00=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Thu Sep 4, 2025 at 11:13 PM CEST, Matthew Maurer wrote:
> > +kernel::acpi_device_table!(
> > +    ACPI_TABLE,
> > +    MODULE_ACPI_TABLE,
> > +    <RustDebugFs as platform::Driver>::IdInfo,
> > +    [(acpi::DeviceId::new(c_str!("LNUXDEBF")), ())]
>
> This should use "LNUXBEEF", as we explicitly reserved it for sample and t=
est
> code.
>
> I think we could reserve more if we see a benefit, but so far it's only u=
sed by
> the platform driver sample, so we should be good.
>
> Either way, no need to resend for this only, it can be fixed up on apply.=
 :)

Ah, thanks, I was unaware that it was specially reserved and so tried
to pick something distinct. You fixing up this and the `OF_ID_TABLE`
on apply SGTM.

>
> > +);
> > +
> > +impl platform::Driver for RustDebugFs {
> > +    type IdInfo =3D ();
> > +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> =3D None;
>
> NIT: This defaults to None, so it can be omitted.
>
> > +    const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> =3D Some(=
&ACPI_TABLE);

