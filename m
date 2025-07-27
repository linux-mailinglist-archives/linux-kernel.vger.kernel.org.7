Return-Path: <linux-kernel+bounces-747219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80C6B13115
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5988F3B4829
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6467F2222C7;
	Sun, 27 Jul 2025 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAXxqUtW"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815E610D;
	Sun, 27 Jul 2025 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753639571; cv=none; b=NhXe3J1zojilii1wRZDbd4+EDR7o2n3H/ffr7u3EaB/V7Po3PesIPDCMs+afYAymceaWVdMFJUBTOjF/V0yFxLpr+z+CTnHS0uuNl8sctN021Rr6pgq4xVr2BCQoUeWbl0GErEwIYUIEsq+ruzP4XZXtEqgtDIutQcL6YjPjnx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753639571; c=relaxed/simple;
	bh=bZ/JXJc19nkrcW+WON5HjOh7f+Qm4DzRNAzejFL1y2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qit1TXq3idqVdU8XRRVS4FrKa4/NKxBA/6XJTcQrp/hHMbWU6CvL9li5mwpe2AMeiu5l+fZm2/+MLzsSlum0ln4c+cXbCLI/h1AxGqJJvJ+fMDVMksrojxWZxVfc67e0cVwymXcnTeAO0M5hASOXL+c70cWSAPrSSWAj2mBDE0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAXxqUtW; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31ef3e9f0adso39340a91.1;
        Sun, 27 Jul 2025 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753639570; x=1754244370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZ/JXJc19nkrcW+WON5HjOh7f+Qm4DzRNAzejFL1y2k=;
        b=IAXxqUtWh+IkO7rWe2A9ueqmoKXk8MuRh3sWjHmpNIrmJTDiCtl+qYYe/SoTGVq3Cz
         MiNhfeBNTGOaRGu5pH35q63gzzvY3pR4U4+u6ZLC0SmMCoOND0AIck1gaGwIxlbKozRj
         XPlE9C9XfZi1AENu9W4eL3r7YRm84dslCz49WyzsY5+q5Fvm8k8TXywdF+o5aRaXRbwa
         Sfw3xKUBLKJSYAa69aEsG0XHFI3dZesgtzpTzzf2MTVdYN+LPaCcSIIeK1HluPr8/EVr
         qmeo/Z1Qez7qSg4+p5K2LhWp07sVAxXDVBF9/Sbve1w0f+3w4mV98eVoIXvyOd6fVMmT
         qJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753639570; x=1754244370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZ/JXJc19nkrcW+WON5HjOh7f+Qm4DzRNAzejFL1y2k=;
        b=EmXolphLO9yxj8b7RC2qU4GUkRHl/nsuFemh5tqnsB2KUmEib6Av0nerTOiraWZ52u
         ZKSYoQB/qRwUjlqllEn8UepDxg/i+x+f+eCNaZ4MMrulvOKKo0ItzQhcAN4pdKf9hyX+
         svBjwAiMjyaD2DpLJBop3V0OAPOgbRAEzPnIKgT6aaparZ6ANrzZmL7uvP1B7HESwVa5
         UY1xI3tBeF2/KQusVzUstkdoBR7G4BCEm1LCDDO66cuYvy7Mi8PTlB42yR2cUkMqFAPE
         KR9EogXOevXAII9jO1XvJFTdUFhqgF9RS6bN7QNYNJNNMVlZ579hesCoUSweuDmW0syK
         yKfw==
X-Forwarded-Encrypted: i=1; AJvYcCWOBJhulIPXAXMPprvVRXWEyVdurjyFaEsdq2DwOOhlyj68MI5he593B/oKNuwQXMIl/Az3y+fdJV52Bp4=@vger.kernel.org, AJvYcCWa3GQUt1H0C8VqlGbLzGKj6UtiGg89GWj4tenANBhfhoEOiqMQd0sdabAlYyFwwGP7XTU4BuTGBtJ1jWzHj9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZFCHfHRS5Mu4yWUAGThDuHtifFcCtXJxUG304vbY/jyXzF38K
	8b359BoodgQaege6eos0beFce1iozL4O5w0OtbNpycRHcvhgOYtJHHMRVRibUQUjlh+t68Klp/G
	VEAWIWWcHiHodsflK6Fcj7IJ07HLpcFc=
X-Gm-Gg: ASbGncvrmN7XFr38iBH+5bY8XZpbG01oSu4VE0poNLXo86+9WkAQlxu2O84YIx1LMvu
	vsk6+8pDQ5nlBWyx8iMvbVNqH5bG+Hjed3QEkZRo0qWsmfgTC2mkSAi83SBTWI4iJ1qRfPRT8SV
	yk+I5YxVnHk17HefeBBz4am4EKMp/cQs4Dvp1k6l5Z94wyb0uUALkoeFGElSzpo25m4CEU4kd/V
	pai6kG0
X-Google-Smtp-Source: AGHT+IFc1oDi3ttzKyiq8xCPzeqbI2VYL6bu7FlM3gZWatkcZqVsTgMusJlK5RfvMADLXbz5b1obFkorHk7kDIOn744=
X-Received: by 2002:a05:6a20:431a:b0:21f:5430:8fb7 with SMTP id
 adf61e73a8af0-23d704bb173mr6115388637.10.1753639569850; Sun, 27 Jul 2025
 11:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717073450.15090-1-shankari.ak0208@gmail.com>
 <CAPRMd3nhDKApttF_wBU01es76NG=qAyZMAer_gjbbtTSH_FmSA@mail.gmail.com>
 <CANiq72=uDrg9HBVM97dgJGaC946Or964-2aF6OJVV0ih_vWuRA@mail.gmail.com>
 <CAPRMd3kXUJC6rC_X4i41dWNpS2tx4aEXFmBuEwncXmdJewinDA@mail.gmail.com>
 <CANiq72kw-OiU6YO8TKMVMdtJF+j7r9nBDsAa9Q2tdBzM=DyxDg@mail.gmail.com>
 <DBMUCVDVWM77.2M60X06IBGVA5@kernel.org> <CANiq72nBHtbZqt8R0dMSK6iWY7Z3vKLbeP_2dN2NaLOxRfOvCA@mail.gmail.com>
 <DBN0D5J10BH9.3I1FHJC1KZ79A@kernel.org>
In-Reply-To: <DBN0D5J10BH9.3I1FHJC1KZ79A@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 27 Jul 2025 20:05:57 +0200
X-Gm-Features: Ac12FXyKqx2O59Ph-48CSD2k8mkM4uvBPoNaAGIqepjHuYbNY2Y06KFqgdFsr2s
Message-ID: <CANiq72=qbAwqcH0+ogH=STMC2UF4pV5St=gPrg6VmymvZkh6tg@mail.gmail.com>
Subject: Re: [PATCH 7/7] rust: kernel: update ARef and AlwaysRefCounted
 imports from sync::aref
To: Benno Lossin <lossin@kernel.org>
Cc: Shankari Anand <shankari.ak0208@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 27, 2025 at 7:20=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> AFAIK maintainers can pick different parts of a series', right?

It depends -- some may not be able to be picked independently by
different trees because it would break the build.

Even for those series where there are subsets that can be picked
separately, typically in a normal series if I get Cc'd in a single
patch, then I would assume I am supposed to give my Acked-by so that
it gets picked elsewhere. So unless the cover letter says otherwise, I
would expect a series to be applied as a series.

At the end of the day, it is about coordinating and case-by-case.

Cheers,
Miguel

