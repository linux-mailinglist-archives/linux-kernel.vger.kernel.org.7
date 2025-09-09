Return-Path: <linux-kernel+bounces-809082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93641B50845
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 23:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4836E179FC9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FB1257ACF;
	Tue,  9 Sep 2025 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xjx+RpHU"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D9F2571D8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 21:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757453802; cv=none; b=iiMr1ZbcufoeA6RCyYzPRVvq9mv3fYvAY6nYP6JOArOnk3HwWSgGYXVzOL/2F/KzjC2mV+T5QMDz9zIksphdllXk0VrqluyOWhi3xxxSH4JzcqnmJMp210K1fZ3nDHcDnpDkpEJtFzVSI/ehhvYT0wQdaodKP8ZA47cxNtAkT3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757453802; c=relaxed/simple;
	bh=Tri659oiLVCd6VfYpPQXtF9OQ4WThWRJ/JELvDiFurY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ib/k/uG9qiTzhDrq6CsGMWm8a5QFT/dS5r1MOhOAdA5jIqw2DvnnCn2Y/76ad1CQoan4paO+ScR4tgv+oB+MD5BBxRY/vnB8Bwbjyhux8EBVJ9lSUzqb8mk94OwGcctitFAR0NInS7cHgeSsF6ARb3PyLF2b18r6Gv2ccOVyW7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xjx+RpHU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32d69b5d737so406295a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 14:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757453800; x=1758058600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tri659oiLVCd6VfYpPQXtF9OQ4WThWRJ/JELvDiFurY=;
        b=Xjx+RpHUSLLOy0uvMzm1wo+fgvYuD9p7y4DG/SIpDyYjqC/ZtkpJmpesIyCLdWC3VB
         Tn57c9CffxUZ+auHxLbX41OMfVr9cGTozun1h4xvRCR0f+7HcSgf3rRfcNmErIRXYXlj
         ywOLsI3JL/o/lOArNOYIfkdN2wh41CheZRzZqAlgvNW+EfW4i+Ms6fTz9iMHyZ3d4bOZ
         0M7q2j4xzJFeJWQ2FqNvZh4KpFx06FVBvruiLxmuZpaN4BWiwHQGph9zI8oYk+iuuHCm
         23t0bGYmme5hvHndzaS1jNyTg10Ln07vMMkg2NDcwm7amomZsyDgQI1eHOxyybU3fgFg
         2M9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757453800; x=1758058600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tri659oiLVCd6VfYpPQXtF9OQ4WThWRJ/JELvDiFurY=;
        b=gYk8JkZCOwnE3XDDTexFJzHzDca5biOxq6FS1gQlRFCBCvNsZasZD7MXR57C1IpCi3
         RqoiBJd0sqDjexYyrIEzLsaycX3Jyb7Hie1byGfgoomd6SHxQRzARewmaiHt2V/EZOQQ
         X90+1c9bfxTibUyK7ZlOhzwFgQkpjhZaD4hxgihYvSlxyjUhADWnz4F6bhuk0TY56Vq4
         YyWJvgmw2oULXnWhQTDYOHDJnFRClhEkhC33VbQUfN/fQMVelwZ0up+uDv/63LhOUJT6
         vJRYT6X6i/Y3c20v14GAFz9hubFADwbA5COmg8XeY16shLlxpxzgxVhsKQaDbQs3eugI
         h5Zw==
X-Gm-Message-State: AOJu0Yz86xqkYrXKHOKwUhIxOBMMQViQYtHyMTOOp6/ku4bX/t5bizWk
	b7i01hcnRBiKL+gwfve7lWl429GGOMsr/nLChuNd5w9CYclXZn65Go/a3sesMHM3iftIVnqccO0
	eZOzq8oN7x/yVXzIxuHyacTKQs/SmYmc=
X-Gm-Gg: ASbGncu1LL2IM8j84xW+TtVkWWdJFcsYsQTNg6lRU9NcAb5v6UnC2T965FTIaB2IOjd
	UqSZPA+kBO2MxnXLpGHsMiEySRNXf1Vlr2FPF/6fBwL/9Qh6jFfukRCmilwcnrnvUUU/g0Vo3d2
	zHQVi2URywLARqewnINtGMEMmQVDueVbhYkJKQLuGChZY3LdCZjyDCw2QsxSTOcnAnJOgaE4btp
	EkTBFg+nIH9XSE76vAPz8/9P+bYMmz7c9omOJgzC2YE6QQirSzrcc//FX3OIC0KikrIYUQhGdR1
	jTDl5+L47KgYWlUE25oRa+bToGwZmlXsyAyzoNpSGKLFV0E=
X-Google-Smtp-Source: AGHT+IGfWuRbBLApbA1biIsSRGuFYUHQhWq6XH4sIOFxuFSe8wgAAY/n3W+S5dtyGYo44L8oScz+D23Y+e9Y2jG9A1c=
X-Received: by 2002:a17:90a:c10d:b0:32d:a2c5:902a with SMTP id
 98e67ed59e1d1-32da2c5994bmr2271358a91.5.1757453798983; Tue, 09 Sep 2025
 14:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909212039.227221-1-joelagnelf@nvidia.com> <20250909212039.227221-5-joelagnelf@nvidia.com>
In-Reply-To: <20250909212039.227221-5-joelagnelf@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Sep 2025 23:36:25 +0200
X-Gm-Features: AS18NWBWIRvK8uXY04bEb1NxF81YxjlANyREK55xtT2E0vJdhqdmuYSI_9VSyBo
Message-ID: <CANiq72nPQps8ow00AmUe3shArHyhCUSSJX4=6QPHfHQZ_QeqcA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] rust: Move register and bitfield macros out of Nova
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dakr@kernel.org, acourbot@nvidia.com, Alistair Popple <apopple@nvidia.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Yury Norov <yury.norov@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	nouveau@lists.freedesktop.org, 
	rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 11:21=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> Out of broad need for these macros in Rust, move them out. Several folks
> have shown interest (Nova, Tyr GPU drivers).

Please Cc the rust-for-Linux mailing list, especially so for patches
that add things to the core infrastructure.

I notice easily because I tag the ones that are in my client :)

> [Added F: record to MAINTAINERS file entry as suggested by Yury.]

Please don't use [ ... ] nor the past tense -- for normal changes,
please use the imperative instead.

(I guess you picked this up from other [ ... ] notation, but that is
normally only done for modifications of a patch by someone else, e.g.
by maintainers.)

Thanks!

Cheers,
Miguel

