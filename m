Return-Path: <linux-kernel+bounces-886540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92595C35E17
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32B854E8C82
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696B7322DB7;
	Wed,  5 Nov 2025 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xr1AKjrA"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B21253F13
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350043; cv=none; b=pQiK1U39J4MJblBIdyQHf6xNxxjVaJl52nu2t6Lfkg73Xv45/w7GfZoLL5z8pgUKF5EyDJGl+rz0J+89x46IPdeMpyw/jogRWiVTeEzv1VsR0KIfllrgvyEduSPz2xb7I08Js1LO/nEysZZexAID7dRTrQNkL6jRzNowXAPZlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350043; c=relaxed/simple;
	bh=IfJpl7p8Eyo9EYu7HKE2ENdcDGvvdi1k9xcJF8YzUwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXrvM2F+/04OT3KOA8R/aaFPm2zDno+Obt91ONfLk18UjmX8RnE+65OOiIlrtkVPxJXz3k/gaA83SJXKeLuytKguL6cQBeICvbKLfVH2BXW0ccITm/hyiuhjEdNwYR+mg0eC4N5NOm2USwQ3hxtEEegZi8+vlCUB5N5K9cU/y0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xr1AKjrA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7adc44440c6so142041b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 05:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762350042; x=1762954842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfJpl7p8Eyo9EYu7HKE2ENdcDGvvdi1k9xcJF8YzUwc=;
        b=Xr1AKjrAqoxget3o0WmPm8cxbimj1o1cPv3a4Lh614G6EsiYu+xhyLQxLZoWSjvY/6
         lqXTtwdTAkx1/lomv+JJlDt8F92EpqQ3BrOgghvdf9010CqhfsMlsIPUP0Ihvh6umMR5
         XGI3JGXOK8gaiM10Tjzzxs3E97Q2FvCc+WectkYIiBApb9ncgm7OUO24RFHhKLttcU5/
         TH/Noc1c7TMb1SVDtlVMNjuqkGINyuythgXoR+lDu2uDx4s7NJM/c29GFy8MFBiqxVEM
         SKF5d+9+V9I7fj1KThbo4oghFfnfc6H6ZmKslTRVesevfQErfYZ37jHgrTdAc4+P1MhP
         R1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762350042; x=1762954842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfJpl7p8Eyo9EYu7HKE2ENdcDGvvdi1k9xcJF8YzUwc=;
        b=S+nEDZMZ0a/2mIbBPr/pXLeLd46bkKH7MoCGTbx9NH6w2WzAsoiBUJi9d2YDd2r7L4
         7Bq7ULuXgu6XNUMlrEbiSo7Q0OXOmZajNcwcubBHfJv1Pvh2GIwmDn10JLN8m6QSt/03
         B7xarzjGaDuGyFnSTo53dfZt9yKb+f/BJPfAeLMvZpUk2aNEr7hGYSrS1ukSfjhVHRA9
         gBMKO12YhRLglAqsUDCsWz7TZb2e46KO9OUVZVPg9v3R0aOlgQdABN9WgEelZ+PZKxs1
         0F/94GWCFjIJhk25WkZxV7kjFYyrM9Zvg8dIs9vbE6YZBwJVD+EEV8GoGgxlk9PvVlvH
         c/1w==
X-Forwarded-Encrypted: i=1; AJvYcCVpVZ+R2htuyVMVB23XlKZ2NMwTKmowTjHXk80nxxGwMPyewjxPIRS2vLg0E7NmvjnYKKHFDMl5/cpMXuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi2XdQzIRyCgnxVG/9WJLfr3CA9KlM2Yn/7A4wctxnCgAOGIG8
	9viZu1BxVEPGZClh6njQVfXY6fZyrHBsskyFk2zCiKK4z5N2wShtm+f9Ri34PZFPg61a+aJUH9p
	fDbKkLPMZIe6N6m7j1L47BGuPnTnh0Rs=
X-Gm-Gg: ASbGncuwlvNKf+eqFecno4ciHT3j0MxY3dk3oij5QjnAaCYZnqMQkOlTeaWGcRZmhTY
	/RhPxtUYD53uk8TYgjjOBhUWk5JAxuVXPLnkL5fD9G833QFuKzBGeuoqw7g86GTYvE7U235nmg2
	egAULjgXe+6YzJXBBkDZ5AjJq4cnrewkojCPZN7juOepGKsbgvskswtEcIa3QOp0qjbykZWAdKk
	VDsM1KKlcQ1mq257g4hgdyefxBTigj1OpkLLQ6P6O4nCfIPVjqjWfuB6AQkiiXxiORE60uW4aad
	xQAiu0fMKtiP2nD5aOipQaB/3U+lWeqEGKiAyKEB9aEEgNj2G005xoUEWob3iQfIrBueYYjFZeH
	nWOE=
X-Google-Smtp-Source: AGHT+IF6J5XKQIh5lvr1phXMqKtXh65G/ocWfAYSngWfTSEeBXF/cRzivlt4tvYKH1TgBVYnuLE+h/PQqLxNVfW0pnk=
X-Received: by 2002:a05:6a20:7484:b0:34f:5e79:d1af with SMTP id
 adf61e73a8af0-34f86af92ebmr2206267637.5.1762350041793; Wed, 05 Nov 2025
 05:40:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <df3a68334760b2b254219a69426982bf858dee39.1762221537.git.chenmiao@openatom.club>
 <CANiq72=WZJ5=UACpFLWCVJ7mcXbc93X9MyYAZP8-0F==2b0adw@mail.gmail.com> <8d865a46-82c8-428d-a371-407889eefb62@openatom.club>
In-Reply-To: <8d865a46-82c8-428d-a371-407889eefb62@openatom.club>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Nov 2025 14:40:26 +0100
X-Gm-Features: AWmQ_bkkdd1TITNlXEXZk4E4kPCOhviuiBsqHVQwAGIH7Lk_3rk5UsX4g08ILZ4
Message-ID: <CANiq72=OE3JNpemanR-r1efbgKqQrZCiQ7hY2-=_bvxLyJZ-HQ@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: Support more jump_label api
To: Chen Miao <chenmiao@openatom.club>
Cc: ojeda@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	"open list:RUST" <rust-for-linux@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 2:35=E2=80=AFPM Chen Miao <chenmiao@openatom.club> w=
rote:
>
> I can understand, but I'd like to make a brief explanation here. "Chen Mi=
ao"
> is my name, so the prefix of all my email addresses is "chenmiao." Theref=
ore,
> "Chen Miao" and "chenmiao" are equivalent.

That is fine, but what I was trying to say is that, in that case the
Signed-off-by should be "Chen Miao".

Please see https://docs.kernel.org/process/submitting-patches.html#sign-you=
r-work-the-developer-s-certificate-of-origin
-- thanks!

Cheers,
Miguel

