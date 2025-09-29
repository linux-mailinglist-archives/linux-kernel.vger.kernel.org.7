Return-Path: <linux-kernel+bounces-836467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EDDBA9C5B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CEC166E87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5F130AAD7;
	Mon, 29 Sep 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mp0ue+1M"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA582BB17
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759159061; cv=none; b=NHjUjhsgRqWCw2LjRYiIco0f6gmoCowSP7SQwfghmlyTLr35/rJ20vWoyS76LPZmWZuiGTX3Fvo4PSO4W1kI9hEtjI43Zb8sUx+gqygemmd1SzQZkYWaHC9gDpyKJhryM5fcaubmfg66zjruCRRWcu2HZz0HwFkgovFk6NE5Qlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759159061; c=relaxed/simple;
	bh=1iLyMxHlvLqemJX+awTsijKkDTe2O7NspoX88eyf7wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzdc7cR95BbCw1DTGp0BeuQvvxiTCl7r/UiQpb4TEE6ufkawQMQPj4ZHfV0jTuzqCponOACr9kLgR9xO2NRVriOmRwtVDXOa+oPsQqAl5Tch0V3iRfu+2/0cLrPFO9attcysdTgzPEtMsWzhRnXLdmxV+QtFgPDP0m1gATpZtBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mp0ue+1M; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27eda3a38ceso12170315ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759159059; x=1759763859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iLyMxHlvLqemJX+awTsijKkDTe2O7NspoX88eyf7wY=;
        b=Mp0ue+1Mek1z7NthHslyJt9iESP3VDtVXl/XbGZT6lI4rK0mx/Nw5Th8BW7sIvlpzV
         aXNA4JKYKQbcHQuItWu7r5PvoJJba1iRBWBWipxjs/rmrfAbNb4cvGYJ2/T72aHyxmDi
         IEOT76nfKfY0x97sOEk7iXJ7MeD1Ivxg9IKS0rTRQux9iqnM5uls57XQABiek7YLuAX8
         x50jjLAdSSAPHv/ZUCtO+RHPK3IoKjoe8jjkUj9gmJqMgNgs1zL6tws8YlNIS+hE9N4v
         kJ0ijBQkotVlRcdtX2QM02ENPRAHDB59qXNOYipQZlUrGADhCC2gHprXnVo2jU5qlxfJ
         EZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759159059; x=1759763859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iLyMxHlvLqemJX+awTsijKkDTe2O7NspoX88eyf7wY=;
        b=D+bwAPrUcbb/9hML6VSqBSucSRx6VZsCCvSMBPgpcBGlHvNA5cZSh8INIszUlAI6ve
         i+goYicv07DM9on+2DASAeFd70f/SPZ0KqhiAsNjIwVbmoaVVaL65v9/Fg9hpHnXZQyi
         BY0rFrlEebV3hIiiKRsxjTLiCwjkso7xLOsvPouQ4Hu1Azy+Yr1CNOozx2lTuaU6XQ7H
         b+G4MumeOTgyAKnbjLDkNUL4wlgZwttc1d8xfX0QmTWdsPmBR5rjrbltsFVHH024UbU9
         eafgbRiXd1nUT9EWUpObZM7pRKzV4Sfzwl1md8Brs4zFt3U5rodmy3Q5XPVLe557k0X5
         sIwg==
X-Forwarded-Encrypted: i=1; AJvYcCU0upkHEa40HT+gR/xXSVWvs/8cDzZhiRabvYbPCOgVWdF6QOar81MOnrz7SCuxMOgFeaWz5G2VPGUznqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjsD1wgONuzbZrTMUclD1xf6Xpsaaif/Tq+LmKx6Uk1d3AiDUF
	DGCTfYTQVmwJuJocrTe/tDYaD79rFlUvMq+7+ur0H1223C3HqTF6bVuDSdcIAdXRh3nY8piHMl4
	yJ44OFgHLHi6exKpjw2jlzRg/VeKM7Fk=
X-Gm-Gg: ASbGncsPcbcFfDnjlOjecpfqoAPhIFMtX8xfBe4/arBZShQ0BKW+IUtwa9vVrgQuRNm
	vf1euBFqdlkgoSEDzDWqoBLJ8jRHe9MrqAvUil9gGCcCuvk8y2UZ5PjGlwMPMS7ltz8oNmBnY/k
	YE4LNKvnFQXDD8zpCNnJAkVfsrTl+UmTNrQZw3VvPBEOS0UPc9eEGaIX025SpCG/uZMRZ7C8esh
	0wfbIH1jUXBJhOF3gFhAK9FCPYdTlnqrYth6A8PhfSAiZIERGGa8c1NTC7T2v350rdwRKc/9Jnm
	eHgw5e077Ihznf+RFUOlE/9gwg==
X-Google-Smtp-Source: AGHT+IF+JvH4jpihgghfd5nlg8ufLea8+tJ9snOXOMk1JKbPQlxyBxaIt2jz343GE+cDEAtKIOGKVPpUKeLyULsn0zo=
X-Received: by 2002:a17:903:1386:b0:267:8b4f:df1f with SMTP id
 d9443c01a7336-27ed4f8284dmr68541345ad.1.1759159059465; Mon, 29 Sep 2025
 08:17:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920182232.2095101-1-joelagnelf@nvidia.com>
 <20250920182232.2095101-7-joelagnelf@nvidia.com> <CANiq72k3kE-6KPkKwiDLgfkGHCQj4a2K7h9c4T13WMa5b4BAnQ@mail.gmail.com>
 <DD5D59FH4JTT.2G5WEXF3RBCQJ@nvidia.com>
In-Reply-To: <DD5D59FH4JTT.2G5WEXF3RBCQJ@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Sep 2025 17:17:27 +0200
X-Gm-Features: AS18NWCkUheGDFaapzA6FmlukqlhAVxssnWmdmmXWlzMCMUthOlFQRmkWB4hggM
Message-ID: <CANiq72nTrp0Mt72hJ_5qwZtJYSg_ir10ENcX5nXELC_=5vvpew@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] rust: bitfield: Use 'as' operator for setter type conversion
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	dakr@kernel.org, Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Yury Norov <yury.norov@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 4:45=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> A bit radical maybe, but correcness ensues. :)

I am all for Ada/Pascal-like ranges and similar ones as long as we can
make them ergonomic enough with our current Rust and as long as we
still define newtypes over those when appropriate.

Rust may get support for that eventually too (called pattern types),
but we may want to do our own thing meanwhile, just like `Alignment`.

Cheers,
Miguel

