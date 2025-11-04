Return-Path: <linux-kernel+bounces-884850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAB4C314F6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC45218C464F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB40329E6D;
	Tue,  4 Nov 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBkuWwjl"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D4B328B7C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264338; cv=none; b=bddDw9G9hsUPZdzdFOqV1Y9a3XYvS+7ByvoJJy3RsFvc0Zu7eAdqj0934Lc8BPGkk4Hdw8ikmAAbC63jK9Eye3oltkCd/l70oz9Wm8gXGi8NrK97DTONQldm5YoGuGmPI4uomWKM71GfTZ5CYsAol6Sc1WyKIH40pYY56fL3haA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264338; c=relaxed/simple;
	bh=r6Hua29X/7gS1gkkx42NgjYUqsmKHO9v/7TQQDlpL/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=po5wVQ+7GFDE4POhkxFt1L7peszzSrw05opU+1OUFpsXYquEK1FdLUjhOsRZ6TLhWmrc8PNKW941VPSZiUt+trIEoq+kIIUXZEw0sBlk9zcciDEc+zJanAO9DA/teyUmmglp82VkODGY8pNIMR/ZyFoXbf96MDXXu/N1PNxqNS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBkuWwjl; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-340bb45e37cso756440a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 05:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762264336; x=1762869136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgxSC2aKqxilandHAezVm5gKzGGQcz0P4+qV+dri/oU=;
        b=DBkuWwjl+yg6GnaiaExuVDPA5t/BMSFBzVn+PvRpmGFY4b8oUyASuL4lE2eO3f/ROG
         tRUAZ8kutKsncFzzFLAgL24dubPUS5I+DBG2yrysoPFbnTqXEHfsAoA6daal469Csli0
         USD9IMnAhovp67G4oAOzoPejKALHqsW3XxGHKkmj/3yCaHU6LPc6g9gYsfCznfYDuZ7i
         6OXVmFzJWQmYAa15Z+v1VB36tds4Fa0K9vnqnKRrsWjOiow4pMsSFjuCDOrdllkEJOZw
         qq0JEXfFoFuyrCOFKycAZ866VLTGPjYaJ1lnOQtlWLEohxU2X273bS1bf7O7Y/kYjzB2
         qe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762264336; x=1762869136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgxSC2aKqxilandHAezVm5gKzGGQcz0P4+qV+dri/oU=;
        b=rklvD53OW/+1Q1iExJOigwPO0P+y/ooV9yiNYiN8WGtz6GaIKCGPyYp8HwmbEuAb86
         JX3V8x0/F799lKVyctsWMt4ea0ipWn90yH20pPKCXx/Bh2y3SQSguLhU6nHsvf1u52Bg
         0A2yfigTX+Rgw/gfPGZimBls/7v+H7hbl4To1cNteb5OSCxKM51uvWqRNuheXN9fww4e
         2uIGmyWdCSigIFKcekLZekMuUbYy/jpvy+12bb29HT+AncF8voja1po0J8C9/SD5s6lX
         mPqd6uQUdZVjSTbDM2nW0IQdJ5qItQqWzk9xUCQMitP3F5spxSenYGKJx9h0PYLPPFlh
         WivQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjphB5NvQVy9cJIgozvP7phmkBguy+gqrStLweJPcPFO24bhl1WzUDgd/nR1JOKwqFABC1tg1Chqxs5w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn4xWokn2f9FmFvvccO3qTZW8t3dVQciRKkDnEd8FxiRKVYeNi
	XS79p0JlKKPsSpqpfSl0dbqwakuHebJZuRs1ILuolp7q2rLk0wnAl1byxrib9CSSTG4VR1zGCSf
	NWAiVrsMAGeVKmyq5iYQ8yIiXvPLhDlI=
X-Gm-Gg: ASbGncvhDSiDyMN6NPYKh9vF9bPjxD89cjO7WhRH+vwc+Abb67yJuIIQVNKg23WS/4X
	jIcAxQuU8qHpUkTDfoEgY7AEVIzMT/B84Gm9TW8DzI6Q2Orf/cQql2/J1YPvn20JzItkS0ui/us
	UWD/UvghnKuqFFIyn1NiKjHKda5f59rH6YG8Pw/92oSDkDUE7ulH6W6kDeGz+FH7cfbLB3P/TRK
	zJDRfAIrs0lumcgYMJjnw3UUyqLFG6/LOxzo6jQvFb5vqQwEiJGQnCtj5bRO2JmR0Q0Ip3J6fBu
	0I94LasYmX/U3oDYsDPkC4dXg/D4mEIqZQ8mqGuP8+5a/noShHD/YUkqCJnf2nQA8I10z1VLHGv
	JTjU=
X-Google-Smtp-Source: AGHT+IEHIHWibqjAZGWyvY0H8m2w47BvrG2lZbXh2UQMD9AI1DeCBy/GvhFpcB4QhflEwGDTQ3v2/JNfuI82Byb03zs=
X-Received: by 2002:a17:90b:3b87:b0:340:b8f2:250c with SMTP id
 98e67ed59e1d1-340b8f22df9mr9464706a91.1.1762264336293; Tue, 04 Nov 2025
 05:52:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030190613.1224287-1-joelagnelf@nvidia.com>
 <20251030190613.1224287-2-joelagnelf@nvidia.com> <DDX1WYWQNTAB.BBEICMO8NM30@nvidia.com>
 <20251104005812.GA2101511@joelbox2>
In-Reply-To: <20251104005812.GA2101511@joelbox2>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 4 Nov 2025 14:52:03 +0100
X-Gm-Features: AWmQ_blJ7jEt0nl7CKtiOJzaUdItBJ90fhDQUgIcURkC12jl_69-w8beSolcQvU
Message-ID: <CANiq72m692bb+W32QN1G+LJa7sHs=gU8k6dri3mu95Smj7GiRw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/4] rust: clist: Add abstraction for iterating over C
 linked lists
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dakr@kernel.org, David Airlie <airlied@gmail.com>, Alistair Popple <apopple@nvidia.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
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

On Tue, Nov 4, 2025 at 1:58=E2=80=AFAM Joel Fernandes <joelagnelf@nvidia.co=
m> wrote:
>
> Perhaps wrapping it is #cfg is sufficient.

`cfg` attributes and the `cfg!` macro should work in doctests -- we
have already a few instances, e.g. this hidden one:

    /// ```
    /// # #![cfg(CONFIG_OF)]
    /// use kernel::clk::Hertz;

Cheers,
Miguel

