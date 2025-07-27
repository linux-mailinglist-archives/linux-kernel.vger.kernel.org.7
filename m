Return-Path: <linux-kernel+bounces-747080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C46FB12F73
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 14:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC563B6158
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85155213E89;
	Sun, 27 Jul 2025 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/u3CxM9"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C78086329;
	Sun, 27 Jul 2025 12:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753619353; cv=none; b=o+CMo1JvlwV0ybNV8hSAnOnHLX/aA2R/bLCQqYqwllqXDZBGYpYUrId1kgE2+BYBL2qc78xxSbYXUJWtw9RgBN6B1d/WHGtxh3XeMtWjAwpMfiNr/euEkKAMLoxHPSiLfqvuBZqTewLCSpFExV12Et2tFmbikjW+d3HptH9Yi4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753619353; c=relaxed/simple;
	bh=mmM9rY0g6VokwqWJ860/H6N7xd1b5p5xZYCMAzEMwGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFCrG8RXuHlg9O+xtauMQoek9I5mIopfk65ptf6uwUv0Vk077+em7ws7fsxz5/EwUVbhb0dxY3RQieM2IKUsYTxL4izbj3R3Ltvu7n5xVF7j/BmxF39atRaC3fCfOLiJJ8NyPL8tgfIYR/im3zBp5qZ+d9OCWaFdG7/BTbp4Q+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/u3CxM9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31306794b30so609516a91.2;
        Sun, 27 Jul 2025 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753619352; x=1754224152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmM9rY0g6VokwqWJ860/H6N7xd1b5p5xZYCMAzEMwGs=;
        b=J/u3CxM9UCPk0fm+h6he7q+Yf+kiA477ChgO1oOO7WAkcSY0cuJ8OU1l3iZclg5WYd
         vrrpvf9Nv4bhSpO0+LEszr3ylThNaa+YYeGQI8qzVoA5iRYWrZNNV4JBUgh9Xa54+w6/
         7OKXxbG3QFI3EPW8SF9Wv73zNhcbaRb4VaqLSPGGDbu3U2sJT7NgWjpiCKyeA6zo0TCC
         jIPHv0bj+Y3At0ZG9vPr2p+Mp8k4yQxxB4BK21WKGQDaHt/dH9U0vzdToxvl28EDblu0
         LsXMGqyWjWFBIsBB55MfW5VDLEqyb5YvPWmGANIRju5+PMUDRiGYYmI4NfH/l/m1MAPi
         AoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753619352; x=1754224152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmM9rY0g6VokwqWJ860/H6N7xd1b5p5xZYCMAzEMwGs=;
        b=TEoaysAtvxEFR7AA1nqh9wZUeQh0pssN3BO0VopqTMwWT9LWe9Ogp0FYChe93R57A+
         BiIbTV/h+evnlOrJ15xVzEd8qceUF4Hy/Lt6nAeXJA+FL/8QKFP474Muu42xLgLVgE5r
         W1KHkkPKDIHAURqx7ZXb/0Fd+JdW1b7TgLW2WEvPrGZ5jSKERs4c9l8jpCfeP/fJWF51
         khOgiZyqEoXzByWZJuy3V0TZEK922Cbi7+F+3+QB6ED7oUIe6DCBXdQL/qdLHBpaPI+u
         G7FYOv1QRhFeY3Qyed2/yEheEGW+sGUd1SRI1tu6V41JR4fW7A0RZhmvPBEsMwL8LHKp
         AA2w==
X-Forwarded-Encrypted: i=1; AJvYcCXvcpeDEQwKTwyMP7uZdwxtIdRCRYqljzOh7S0tN1AkVkQL0Sd1/XxQ52c92gSUqVDVJgEHAd9hjmQAFZ8O0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDvONap7TZd4nZdqPwcRl+HbiiUBWB1+sMbEcBkpy+IyaK2Cf2
	sQJcfAO1ELnMuOTeMCIXN4fCFyGv+eOy/UkULeKk4nR1gbw1nGQBYHUltPAGgnlN/GS9fhr9mXn
	gP1eL9yOafVxhYk0U7AoRU8PrRXDS7h0=
X-Gm-Gg: ASbGncu4T/X39CZ2jENeakhcDtLOcGlKXbvSHJY+FIpKJxMulEdpNBbpi6qpDLfdaBq
	MrNLfX3wjVnT75AwXUgfsK6ra4BszlQfhJLIu3Npo5++mupuEaTeZigAOAny3/iGSg/rs0sHjoL
	Y1O2l43lxX1w6gJY6Nan170DWT562zkctjYHsR2BvpdY0t1aIBdkvKQtKPJau6MYBKQC2U7TCPf
	qkwXshz
X-Google-Smtp-Source: AGHT+IFVtxe00ZxfKroFuUM0I/isAA07jfSyysKsr+M6C9iUQ+Uo8pOWrZcC7GjMXvs748aHWl7Qb2Vf8XU95MtGlqw=
X-Received: by 2002:a17:90a:e7c3:b0:30a:80bc:ad4 with SMTP id
 98e67ed59e1d1-31e776ab52bmr4948508a91.0.1753619351622; Sun, 27 Jul 2025
 05:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717073450.15090-1-shankari.ak0208@gmail.com>
 <CAPRMd3nhDKApttF_wBU01es76NG=qAyZMAer_gjbbtTSH_FmSA@mail.gmail.com>
 <CANiq72=uDrg9HBVM97dgJGaC946Or964-2aF6OJVV0ih_vWuRA@mail.gmail.com> <CAPRMd3kXUJC6rC_X4i41dWNpS2tx4aEXFmBuEwncXmdJewinDA@mail.gmail.com>
In-Reply-To: <CAPRMd3kXUJC6rC_X4i41dWNpS2tx4aEXFmBuEwncXmdJewinDA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 27 Jul 2025 14:28:59 +0200
X-Gm-Features: Ac12FXyATkSAPPzydv5QEebi1BwRHhwpqn6L-MDbVPOX9QWRYs48J-CopDB_UVc
Message-ID: <CANiq72kw-OiU6YO8TKMVMdtJF+j7r9nBDsAa9Q2tdBzM=DyxDg@mail.gmail.com>
Subject: Re: [PATCH 7/7] rust: kernel: update ARef and AlwaysRefCounted
 imports from sync::aref
To: Shankari Anand <shankari.ak0208@gmail.com>
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

On Sun, Jul 27, 2025 at 9:30=E2=80=AFAM Shankari Anand
<shankari.ak0208@gmail.com> wrote:
>
> Apologies for the early ping, I was unsure about the appropriate way
> to split the patches and wanted to confirm before proceeding.

No worries at all, that is fine :)

> Sure, I'll carefully split the patches accordingly in the next version
> to align with the relevant maintainers and trees.

Thanks, that will be useful.

> Regarding the series notation (e.g., "7/7"), I included it to indicate
> the overall scope of changes as part of the same effort. However,
> since the patches are independent and target different subsystems,
> I=E2=80=99ll avoid that format going forward, as suggested.

Thanks -- sometimes people do it in a single series, even if they are
technically independent, especially if they expect everything to go in
at once (which may not be the case here).

However, I was mainly talking about using the "7/7" notation but
having the emails be separate, i.e. if one uses that notation, then
people will likely be a bit confused when they don't see the other
patches in the series. So if it is not a series, then it is best to
avoid that notation; and if it is a series, then the notation should
be used.

I hope that clarifies!

Cheers,
Miguel

