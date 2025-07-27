Return-Path: <linux-kernel+bounces-747112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C41DAB12FD9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FF81890B90
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 14:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655182192E5;
	Sun, 27 Jul 2025 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bo0YOAnm"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AF0126BF1;
	Sun, 27 Jul 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753626401; cv=none; b=YZWPRVHhlsAFqa+AcQh4c3rIQ9CO1iMbTJAhL+zXzk422pcNc2ahJEhi1Ph9PVs7uGJG7VcwgIpvAbfle93Dyg+nrGaZudY9iCqDxYkZlM8cf3UIM3dvnzu8iJyFWK51ZzWuH3lWTESmFkV794YQNHG8FUxP27i0Nn2qAVUs8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753626401; c=relaxed/simple;
	bh=mZp1PU9fmN+OYBLE87U2j834maP1HDJ1iVSdhmTIa+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6jo/T+87UkQDZ/zMoD2H4jESnX2OvJMjVEQqt5e5966LeCEqfADsJc023ubsJELCEWfo0twWdHR5XsxvcoIqs2Ou3gXMiYHpSBHE427+LxbwSkrwNuj+Rc+1cYNbtqWayxva45swJCtEnbYM/pORWxM2LsEEDOw5hSp1dbGPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bo0YOAnm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-748e60725fcso342282b3a.3;
        Sun, 27 Jul 2025 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753626399; x=1754231199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZp1PU9fmN+OYBLE87U2j834maP1HDJ1iVSdhmTIa+Y=;
        b=Bo0YOAnmENnekSNFS/rhpcnqNbi2T3FUpdDZJ/MZDalX0l6/NJWppIGI0eVbnh4Lzv
         sQuGtrCNRtFLhBRMWBqcc0dzrzJvzMyhiQ+jhCSaFMWSO588Y6K8dn1IynTRxtdBpHFm
         51NrWwgxwZK+5qNvU2Xqq2gqzW05E3zuqOlA5pQxZTtTvPm+aYiuS4Tfd8UmODW9Bz6X
         jlDJufTqedNYehzT9IDKvKq/nTLAqvKPa+JR2xslqKJq4LxgoH7Wn3IClyc95uinrGqn
         n/Uux+a+eRg9gHCOk/vo2SAMGcGix2Kqt4mgVCCx4vIpX/nY4MJ6tjoRCHI/M7rfZeRC
         /+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753626399; x=1754231199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZp1PU9fmN+OYBLE87U2j834maP1HDJ1iVSdhmTIa+Y=;
        b=wSBv6HpIoBFz8N5oIIQ35xOjycS8hovJBCGHQw5kGkldx6RV/lwafHBz/v2nUf+ZHs
         3RehY6zkngVN06QMyPYfMjj1zFYjjKUsjKkHs9IkdULUuv/QmAEQrPTv7zrz4+SrC3N9
         xZi9kgy3yw+My5JtfIjyXbkfzqSYjbOx47bSCwhN/CeKDfgsPGYuWJSiRjRSDvdbSl+V
         2ScEnHpKt+fKrPS3fY8o2tTuOfMbxRzfh/g23RVbQz5x/30zZjvASGOoXV41jI+Cn59j
         JAE45R7ECGiSn9iLbnFIbGOgn8idXy0HUy5gIQypc0EG9JKWO+cyEtQDa2a+cTQyKbCM
         +/8w==
X-Forwarded-Encrypted: i=1; AJvYcCWrgKhHs3z5m+4bR+XoYFFDiBIK5C+F70WEBhOOALrjqUuHLaBAdbMO+9j52oAqaqTkhRenLzJEpPdY6rc6+HU=@vger.kernel.org, AJvYcCWzEFaEVNzvvujlMPDrJJ0qAtqC7KbKayaMjKHKZfZuYUY9id/dewTChI5H9nufViE3aswDsFdW158ywNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUgKD4T2JxCUtfi1kGHg1rM6QygejKGXd4niSCmIJH13gWaMEn
	V+4U2+z1erTyRvJNGhD0yXNmRTajmhZoq7oDYBHfPZlVQ1ctkBcj1SX3Ddrcw60TH1FZM/u0Bso
	8gZscO9Jika/91gOGCvQY2eMXpQK+IJs=
X-Gm-Gg: ASbGncv8YYYhGhP3ilINgR8TvZ2Sp9HaaJrva4aIS4GcQGZc8N91s7sgZAYqNl6lA1q
	cj7QMzMOiBDHkfsAFkWYIiemjyDz7oQ1mm4YDsR+7tM1/y16RTEUx4UecjR57efsKax54whOmHr
	7HwTmLo8i/5FvV4YYsXCl6XIFYZYkjf14M4ZeD9SLGkQCw1/jYegCiKjYEen1UQIwVPbkdsPSQA
	/k/XukW
X-Google-Smtp-Source: AGHT+IEPqK9/b/GzYd7MTTPdSgKjVVUt/7rPLfRW6QkOmmzvFF+PDtVQ/0dflAuvIiwxbtK1iF9Ffbiym06PMjDEw1M=
X-Received: by 2002:a17:90b:4a47:b0:31e:f50d:89ac with SMTP id
 98e67ed59e1d1-31ef50d8dbcmr86820a91.7.1753626399225; Sun, 27 Jul 2025
 07:26:39 -0700 (PDT)
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
 <CANiq72kw-OiU6YO8TKMVMdtJF+j7r9nBDsAa9Q2tdBzM=DyxDg@mail.gmail.com> <DBMUCVDVWM77.2M60X06IBGVA5@kernel.org>
In-Reply-To: <DBMUCVDVWM77.2M60X06IBGVA5@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 27 Jul 2025 16:26:26 +0200
X-Gm-Features: Ac12FXw5utZrKsaYiKjsWjvVQHV_Iv6UNoJWGch6_SHp3Q8oUQsUiOuZ6s50zvw
Message-ID: <CANiq72nBHtbZqt8R0dMSK6iWY7Z3vKLbeP_2dN2NaLOxRfOvCA@mail.gmail.com>
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

On Sun, Jul 27, 2025 at 2:37=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> That's good advice. I want to add that in this case, I think a series is
> better sending 7 independent patches. Using a series allows people to
> see if it is complete (ie there might be places that are missed). It
> also allows someone to send a single mail reviewing all patches & giving
> general comments about all patches in the series.

It is fine if places are missed, since in this case they are not meant
to be applied at once -- maintainers may think they are supposed to
give Acked-bys instead of applying them, and here the idea was to try
to see if we could get a migration like this via different trees
slowly, rather than the way we did the others.

For the "final series" that removes the re-export, it should
definitely be a series, because in such a case the idea is to apply
them all and remove the re-export at the end of it.

I guess it depends a bit on what maintainers want to do and the case
(e.g. if it is a tricky change, it may be best to have a series).
Sometimes same people may do it differently, e.g. [1][2].

But I agree that many independent patches are painful too, including
in Lore; and that it is always nice to have an "index" of all the
patches for those that want to see it as you say -- perhaps providing
a link to a Lore search, or having them all in the same thread can
help (though that can be confusing on its own), or having a first RFC
version as a series that can be linked later before splitting.

Cheers,
Miguel

[1] https://lore.kernel.org/all/20241127091036.444330-2-u.kleine-koenig@bay=
libre.com/
[2] https://lore.kernel.org/lkml/20221118224540.619276-1-uwe@kleine-koenig.=
org/

