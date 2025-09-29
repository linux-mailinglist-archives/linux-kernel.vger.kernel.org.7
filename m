Return-Path: <linux-kernel+bounces-836413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A62BBA99CB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4FB19219A8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B6430AD04;
	Mon, 29 Sep 2025 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEN5ky2g"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1795430AAB1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156708; cv=none; b=lPYY6xrRcdiBNVTUYQeoBzQbeXrWXZ/Q9UA46nT2ZY6y3Zod/BHzqtpUDGp3qXJ/EdCZaCmPKizj3Sen4P3jD8g3oLIzMt69vLv77tsCNW1wLK3i7cKHMpWHXuy82QIrESt1T6e3bblICXiZ+7xyXhnbNgt4oSejtbREFNCP4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156708; c=relaxed/simple;
	bh=6wxzuRD2+UgfGobNcQjA07eqzttSMbasZ+Ip7tu3YNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIm2ShUHhxrU03+R+TUKuLIlodOACERk1n4d54FOX1MjNguAWp8DitdVHOFiNZcZqDBC8yk3ijrXhbH/8UkZuemk4aCgwLEOdrzhOf9b5vdxXGa2zzC9vbDoVdEpsKDQoiz5imFqdt7NyHU0gM2BotGPltFptpEAnVqAdqBzRiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEN5ky2g; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27eda3a38ceso12070735ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759156706; x=1759761506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wxzuRD2+UgfGobNcQjA07eqzttSMbasZ+Ip7tu3YNU=;
        b=eEN5ky2g6AYmWBueMlsqZnRnrGXeb1EBB5t1k5PbAxfA85oRwI6LJes4SBoHQauyqT
         1UvAGJvHYXr7xpGxkhePf71Io9ag/lZKGRxx4C6GIb4ZWfHd7hnsM1yt3Hu++RXQ+6bA
         WJaj0fVkGl1pIsWXZkzeuPyxVBqjFvaiLu6zUYxWxFLoRpQCgLzw4M8ZhNqD+Hhp51bo
         X4Xt2Y0+DATNNAVRv7aMHYr2zN6l6fbdJFmYfHBt6LpqQDhOJ2offK6B1bqayKludhYV
         ilg5QFaHOo+DcRQkhCM0D2ItNgDdAbHpfnRM/2XQfz9sNyKY/Id84goF6PQxPtq6+mvz
         ad0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759156706; x=1759761506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wxzuRD2+UgfGobNcQjA07eqzttSMbasZ+Ip7tu3YNU=;
        b=WOF+Yu8yWfcVTwEDOTOqCpnbTFrm1C5/pZ+rX1Uu0SsiNIVFiGsH4vvBPHQTUPUdm3
         mZldsyaRWywSt9Uz7WEmgq/9W5uIcSYnGmUujsnsxIQg0pPTj4SmFBdIw1R4GT0PFJ4D
         r2G6msI8QSMTcosbQrKxZu60UsPxTKsh1bsGsT1XcTI7r8Ib1b/9B0KdzLGH0lF8P1Ip
         hKBT4XKICl9hmYVEZQkWLbQkS2o+t53HAfBMifsH5nPKVzCZOFzEsQv2p8/8LzPQee+h
         Iat7aRPzakFtFIMZh8hZNK+B8aJJtuVbubA06D6WsA9ELSxOxklPgQg5JE6ZrFIqjPy9
         CrCg==
X-Forwarded-Encrypted: i=1; AJvYcCUL98TzNRyOUqCR1fnHrycS9EMukceCdWZ+F1uQL2qTPQLfmG7IewW7W6YNredbyRQYM3O+9Tp7xd14/Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRfgMqgxt1+3yZDVOG4qhL0JzcZHDr91JP5WoQMj2C+9w1C+vR
	WnbfUsy/jvv2muXHeTVAFaM5MenASf2h/ydlovsORjRX0NcDVc1MK5T4Of+A6yNlvJJA9EAZo3S
	JpvZ2jVgbY4nc6+fXXDSB0e6GVouAphs=
X-Gm-Gg: ASbGnctm/amr0vUoSNULT9ngu+VbkOthoygZklAaAkp9NRSvX8Red1FZkuww9bPGlrr
	c8x/cKMEDwqpSWoettrQ82DrXHM34DxPc+ry1M9rsgU1TO6uTWpOZy6AslEgohUPtW9GZ1QA+Ga
	Q6VFC7a1olRGnTNLnVSmjjKF34HI7pUfN62b5ZxyMSepPsAQxw1DchZ35ZkxJTLjU5lafqsGYm1
	jXtpCLrT3uulix5Cqctpui4znJfRTPI6qWPC7jlHuA1WrcPMWjsi+JtxdiTvJSoVDBrR6BdQEVW
	P5vb2LorH4kiN85Ae4xkJmuoicnotRamkaUOHCLLSf1wRcA=
X-Google-Smtp-Source: AGHT+IEuajVdRt/zkJ/UX7z6Wnp/1y6NOw3KWFiaL0wSJ/2A6J51idlMClGnkDk/Tn16oxOvOKsoW449qVwpqNver/w=
X-Received: by 2002:a17:903:1a68:b0:275:c066:33dd with SMTP id
 d9443c01a7336-27ed4ab64a4mr106185325ad.10.1759156706206; Mon, 29 Sep 2025
 07:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922113026.3083103-1-apopple@nvidia.com> <20250922113026.3083103-6-apopple@nvidia.com>
 <DD2GCDGQ7Q4W.1CSFYSETFSN5H@nvidia.com> <7brvf66smc3ltqrw7tm7smth6wnefeqykdm2n4qahi5xnr6d5o@4l5xfdbznlp3>
 <DD5CXDR294YD.2RL474PWBDWTV@nvidia.com>
In-Reply-To: <DD5CXDR294YD.2RL474PWBDWTV@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Sep 2025 16:38:12 +0200
X-Gm-Features: AS18NWBU5ftnpGhJqKd4k_6D7IlxaPNAUhkxayMY9q8yLGmTLeUS7TVSiAU2z4g
Message-ID: <CANiq72k3qkj1HxjnCoknAdWhdM7O1ZBkZDqBsVS7vxYH-tRCWg@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] gpu: nova-core: gsp: Add GSP command queue handling
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, dakr@kernel.org, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, John Hubbard <jhubbard@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 4:34=E2=80=AFPM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> I think you will also need to explicitly enable the feature somewhere -
> for the kernel crate it is in `rust/kernel/lib.rs`, but Nova being a
> different crate I am not sure where we are supposed to do it...

`rust_allowed_features` in `scripts/Makefile.build`.

I hope that helps!

Cheers,
Miguel

