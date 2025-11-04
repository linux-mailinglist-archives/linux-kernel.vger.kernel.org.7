Return-Path: <linux-kernel+bounces-885358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C85C32AEE
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 19:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 014EE4E9265
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 18:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F4033E352;
	Tue,  4 Nov 2025 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9gR/pui"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0475E23741
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 18:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762281350; cv=none; b=dUYwV6nfDi3e6B2cGGLeI7KDeNC7XFmRHTpKakHTBCSkoZbJpi3KkEzSyc+OZFQvYAqcIRyuOfaWy2MPMVFaXnKUapDC4hbIujR57c8geVJGUVcKm7P6UEGnJnt7tbyMw12Kb0vbmYa1YtP/VkuLJPGRqzzqhNxsUuVWG6zeXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762281350; c=relaxed/simple;
	bh=pDB/Q9lx5j80vNN8jyV2lRu5iagSZIvfFZ7cYndtLs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6k8chJ8b0S0ubn4oWNgV6L8HgmrWRJX3Q4A4uYtAMqeIMb5ATMcWducuIXiHFo1tua6gK9SZo8etX+phFTwWXO/U3NtifNWJZNXvkPurUI7LkyLGZgmvKP2TH9DlDWzhilgNvt4rhoj+/BzSs1SCjedPkU5dKqs3e5xvrbUc8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9gR/pui; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b9a2e3c4afcso246778a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 10:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762281348; x=1762886148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDB/Q9lx5j80vNN8jyV2lRu5iagSZIvfFZ7cYndtLs4=;
        b=K9gR/pui9JmK5ZhIOvbsddgLPEXFpDeaTu2Dw2DdiRKcFJYMOHjGd5+kcMnO+NnQJh
         0VXDKeyDxNfVN2gAv+kyPZKe43zAWn5i54xeK1Hv7FhYDuydAc/m0/aFz059VoeJ67Ss
         GwIy7lgnmT/da01W7F/V9KS0pq6ATslD3+W/PTbgsv2ih+h2/W1iqU2y56rNGjQCbqzZ
         /DnZbjP7m8l83NpmpkyGcDES595N68EYQcIT0C7C2uJZOdqc/ASn/C2TvoECqmAZEGSD
         rwZiI0X1oBA9ECXthzj63v3MtbU2J4WyqoGIhe5/4PWkX84oT/g5it0SAuPE3UJntzH/
         RFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762281348; x=1762886148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDB/Q9lx5j80vNN8jyV2lRu5iagSZIvfFZ7cYndtLs4=;
        b=NdUZwfzPI+DGqWaQwl91n8nVZOCd1SaImcZbhLPzfDnidoqT6/HQz9ykvPsinfnRV/
         KEdOCDN4Sto3BhZjP3adUzlelXwcwycOvN1FKs+v5VwAml798SBg/EqqlK6LbWjVQEYk
         LlHz4nx9Pc/yZ/Qez/u+qvDfMSiQqtv4fRxOxxJA5WFOMxg69V2Oef/FnJnorNIHPypS
         gxSh9ZE1y5pvladgjppG8kHE8vvL3ikq/AL+B+YhStYTXFqxzwCFIDkoc5MP6s7odeEN
         kmscgVL1SU8Qb4LEhT+lEVjuYH60NSuNuxRx+l9cQkXpXH1ABZgkCbe4jgm5QLYipCe5
         x8eg==
X-Forwarded-Encrypted: i=1; AJvYcCV7Rlh7qJMir/tosc8bezPTj9D2eSD+fSW6TzMXPwa1cCC6nVU4K/DE3yPqVbkHYoxnKNCC7Ev9EyMOOmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3W4V1eZGuZG7z8uDhSzUUDHSJqjZvRrmsjjUMA432F/N4xZtn
	q8fOcRq1tjovCp5e5X9AMVNxSR29PYl7iLh9mYd7misQQ6G+WeljhrCR4U20mytE2OlfhjIaNCU
	xMgl8ttGZNjCXVqTe/V9kH69HZUq3LXc=
X-Gm-Gg: ASbGnctWz7q1StG4p2M7A1CNJ4C6uFS4MbOQiGoC33OP8slBwb+MWdzC4YAVIMfGKFA
	zkOCrMw70H+vlpDowGiRn/Tu5bqfYR3QaD1zkaY4eI+Q67W8c8J+qdf8n5TwHp1cFlS0nYs03JX
	ipQJAt/Rw8Kd1ke0rj/D7fE3eAR9S0XQjoKHd0TvYmmXTb3xSMFz59RJeS35uaa+ZocjbElaqyZ
	P83Fk0mIbnulVCMjY5dA1Gg2KcOQUIsZEsGGEdCYUTXwY9Pg6tlFCloCjGf+3vjB8JxQ/LWe0wO
	eOl/TG5MEz6PgdyxaHAx04KYWihIt1CFUSlGU94nmJf/0OwICdX6UE7/ZOH5D/K345YzSnCOqTo
	JWl4=
X-Google-Smtp-Source: AGHT+IGILpSUE4gVnXtKxcfD5gs3NAicKe3yGxxboyBy/726/XJYsRyq6U0De47lxh6jH86MUyGGWjvhPdulmM5+3So=
X-Received: by 2002:a05:6a20:6a0d:b0:244:aefe:71ef with SMTP id
 adf61e73a8af0-34f8620acbbmr152946637.6.1762281348226; Tue, 04 Nov 2025
 10:35:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-2-joelagnelf@nvidia.com> <DDX1WYWQNTAB.BBEICMO8NM30@nvidia.com>
 <20251104005812.GA2101511@joelbox2> <DDZYCRCPYMOL.RMTIF0R404Q4@nvidia.com>
 <CANiq72=Cj_gJ27+EAiytxYGYk1dMwu7M3xQpLGByD4QstgDsHw@mail.gmail.com> <CAAOQCfQ_d_C7oZ9uq2siJHn1+m+j059qYUMBvTWOnQ5Etk91ug@mail.gmail.com>
In-Reply-To: <CAAOQCfQ_d_C7oZ9uq2siJHn1+m+j059qYUMBvTWOnQ5Etk91ug@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Nov 2025 19:35:35 +0100
X-Gm-Features: AWmQ_bn9ka2mYlunhef8Qs1JQYv0mviCoj_SNM7trLL_sBiialuKhkFBTWi90tg
Message-ID: <CANiq72nLzuCXh0r5W0HMM36f9yTSQfP9yCxXbzH+wS7VxFM2Eg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] rust: clist: Add abstraction for iterating over C
 linked lists
To: Guillaume Gomez <guillaume1.gomez@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, dakr@kernel.org, 
	David Airlie <airlied@gmail.com>, Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, joel@joelfernandes.org, 
	Elle Rhumsaa <elle@weathered-steel.dev>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Andrea Righi <arighi@nvidia.com>, Philipp Stanner <phasta@kernel.org>, nouveau@lists.freedesktop.org, 
	Nouveau <nouveau-bounces@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 3:35=E2=80=AFPM Guillaume Gomez
<guillaume1.gomez@gmail.com> wrote:
>
> You can use `cfg(doc)` and `cfg(doctest)` to only include parts of the
> docs when running doctests (if that's what this is about).

Thanks for the quick reply!

I think this is more about having some code essentially "prefixed" to
certain doctests without having to repeat it in every one. Or, more
generally, to provide custom "environments" for certain doctests,
including perhaps a custom prelude and things like that.

So one way would be writing a `mod` (perhaps with a `path` attribute)
or an `include` to manually do that. Or perhaps having an auxiliary
crate or similar that contains those mods/files (that probably only
gets built when the KUnit doctests are enabled).

Orthogonally, the script that generates the doctests could perhaps
help to automate some of that. For instance, we could have a way to
specify an "environment" for a given Rust file or Rust `mod` or
similar, and then every doctests would have the code prefixed to them.
But I prefer to wait until we have real users of this and the new JSON
generation.

Using `cfg(doctest)` in some code in the `kernel` crate wouldn't work,
unless I am missing something, because we wouldn't want to have a
"parallel `kernel` crate" in the same build that only the doctests
would use.

Cheers,
Miguel

