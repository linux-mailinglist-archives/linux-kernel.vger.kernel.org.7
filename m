Return-Path: <linux-kernel+bounces-887726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EF8C38F52
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1486F1A23C13
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12FE2BE621;
	Thu,  6 Nov 2025 03:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl7MNJCP"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E91126ACB
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 03:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399468; cv=none; b=Gbz61ievnK6fqXS6fcg4ntMAFbEslfGb+pGl/CY83oMd5pd/2CT+JHqnuHdQSEFkYs3qDIYvbW2taje4vCaivxpeU6TvAZD+VSSF3ebbXVjlhzkYg6f6ps923ezNlJCrGRZJkM48wBvEcquYnxLD+EW5cDrlajrxwtM5b6exwUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399468; c=relaxed/simple;
	bh=kmXnB7s7f6K9YvqaS01eSnU+9D3eKb8CXbR3i1lnLJM=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgscWAHphLf0srwnMpPMNsws0Iy3WBqnEl/mC27YzX5IvZ7yW1HcqiuFPGqOmtKIX6/B1Mm9OafiWfc4geiLXCdBZTDEsDqdZNPGWyuRpuPhZxBwNiXdDzBrXr29U0xICC3hCHerPd3FmRx8V1t/n1JbluIaEgNPc0Q9kpx/dK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gl7MNJCP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee130237a8so300760f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 19:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762399465; x=1763004265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWriRyYYR8ghNgV297L9OCEioZWlmVeoKEJ1s2bnlQ8=;
        b=Gl7MNJCP6k4LatKiu2TxwCtqd6xfrHvrzqjIIGpTfStgciy6A9qQjbDsXalXABcgV2
         Yz4Rrz5Wzeo01eVLnG1z2/1j8z06qv01F5pIxa4OY2iyjFceRyVksM0LA+kQqKKHbjEE
         WmaC9sjaAyHfuktDUWGfE1jDfcCPno5T7myqq5icRVoow75x6Jc5JJtasm4ZGFdODRbJ
         x0cpbEwU8dfoC2fFRXYTCNld9eo8Ej6Pcyt1dr+nzyMic5PzjUWO4oZxsVgrQEkV5RN1
         ACueFhIIUZr7r3ik9N9AvnYYngqTcea4aWGOsPn1o4vE0LmEh8sWrrAQ+bI65X0vHeAK
         Ncrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762399465; x=1763004265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XWriRyYYR8ghNgV297L9OCEioZWlmVeoKEJ1s2bnlQ8=;
        b=LGp1n9V3en+vqBRuqr7I7ffO8iZEfhx0eOO6FClySHQwapSJbkICMIUlka74E5J1jj
         btGWNhY7ZvKHkxss4ecylTY1R7xw8e5BGKrkkIVHMfSv9K7MtPNrDHZSSBDaWEWfF8SF
         lED3FPz4m2YgPnnYzBY4WSHifwMzVS8kWjDOPCskYAysiP8JUOCpijSW1mLP3Y09vAIv
         tRzYIgZMZF+yB7VanOitbqR2d4tcA+/XrpnyutTzpe9O7NRG9uSgQ4MEGfbLY8SFyaDs
         0O9QYB9G0ZDDHQfXcO7VAe4lgTgxqqsMeS9/1k2CwmJYk+PRaTuFZj9/Zm+A9n+oJBlh
         Rrdg==
X-Forwarded-Encrypted: i=1; AJvYcCVfeux7Aw/w7JGNd2J/UED8j10xrOkW0puzASCiasASxmaUrmO7CFuJxOC5geOr9ke044y7ozWXWZePzUU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySXwd67Ln2EnYB97DDkJ3YtI+c8uvCKA/vPpKnFbGsOlSu3L2S
	qbGZxs8PWTQGGt9BORMSpgA90TZ5t6WvqT3bMQVLDr8yxLcsuvkTP2zL6VFjuj4vM3YgZAcYU78
	0/5bnVbl1WnbAXpP5b5loVjiyZMIfzBU=
X-Gm-Gg: ASbGnct6maRGYBJIPaVksSsSKgPc2/xFFt4HhHwTAx449saE+p3zRchRDKu7dmq5g9O
	hromhhOEANuh1MasheQtDOcDPFP7Y1n6emW/CohNWSKx32G7RLXdjFkDa4muypgVCWDYHhjDirF
	o/v/3hG06uruID0t7bUXGLHjAsSl8eEFa3SX9buRr9iIt08zxbzNZB4jM4hySa2DBYIIfuPYVVo
	TKdZbwNOXjhoUJbOijI0y1zuSfDkpH4fIFVWvl17dgbLWpaZHELPMUXETGk
X-Google-Smtp-Source: AGHT+IH0vBqmN+LTAnJJzTmqxPzFdBvxXGxIJUipsj9IOUkXfyL3ZCw2Oj0hPsddXQWER7iw5AD7RTA8CqGrUJA6+tI=
X-Received: by 2002:a05:6000:184a:b0:426:ff8f:a0a3 with SMTP id
 ffacd0b85a97d-429e33079d0mr4277837f8f.34.1762399464476; Wed, 05 Nov 2025
 19:24:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Nov 2025 19:24:22 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Nov 2025 19:24:22 -0800
From: Amit Dhingra <mechanicalamit@gmail.com>
References: <1043551.1761844832@turing-police> <32ed124e9d603cad950c4836c7a14a3ba8bc2068.camel@gmail.com>
 <1296761.1762045181@turing-police> <CAFF-SiU3XL5pZAzsB=eXi7e1LKzx5XwiNOyfGpPXOnnc6uo2cw@mail.gmail.com>
 <CAO=gReF+sWpKZFa+wbtGxa3+wSjAQG1UMG3iJaDt2EOPmH-7mQ@mail.gmail.com> <149f5bb52a21becedc17a5b0bf1a586672940af6.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <149f5bb52a21becedc17a5b0bf1a586672940af6.camel@gmail.com>
Date: Wed, 5 Nov 2025 19:24:22 -0800
X-Gm-Features: AWmQ_bm9b1RXq8yhr8e0aiNKvpL0O5UD001Mf3JquUOc7CURAMP3z_K9Ea3kHh0
Message-ID: <CAO=gReERBacxH6SjLrcCNcStiAzMosR=aW5D4W925CJ_yjzbhA@mail.gmail.com>
Subject: Re: linux-next-20251029 - build error in amdgpu
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>, 
	Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	David Airlie <airlied@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 03:40:52AM +0100, Timur Krist=C3=B3f wrote:
> On Wed, 2025-11-05 at 18:34 -0800, Amit Dhingra wrote:
> >
> > >
> > > What do I need to do to trigger the warning?
> > >
> > I have the same problem.
> >
> > linux-next on Arch Linux
> > GCC : 15.2.1 20250813
> >
> >
> > Steps to reproduce the error
> > - make mrproper
> > - make allmodconfig
> > - make drivers/gpu/drm/amd/amdgpu/
> >
> > Turns out its due to randconfig, See [1]
> >
> > Setting RANDSTRUCT_NONE=3Dy seems to stop the error.
>
> Can you please try and see if this fixes the warning?
> https://pastebin.com/raw/b8j3UABj

The patch above defining all fields seems to fix the error.

>
> Alternatively, if anyone has other recommendations on how to fix it,
> I'm also open to suggestions.
>

What seemed to also work for me is to defining the struct as below
without an initialization.

static const struct stream_encoder_funcs dce110_an_str_enc_funcs;

Its static so should be initialized zeroed out. objdump shows correct size
allocation.

objdump -x dce_stream_encoder.o

  0000000000000b60 l     O .rodata	0000000000000130 dce110_str_enc_funcs
  0000000000000a00 l     O .rodata	0000000000000130 dce110_an_str_enc_funcs


> Thanks,
> Timur
>
>
> > >
> > > Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu> ezt =C3=ADrta (id=C5=
=91pont: 2025.
> > > nov.
> > > 2., Vas 1:59):
> > >
> > > > On Thu, 30 Oct 2025 19:05:30 +0100, Timur Krist=C3=B3f said:
> > > >
> > > > > Can you say how to reproduce that?
> > > > > I use the same version of GCC but it hasn't given me any
> > > > > warning or
> > > > > error for that patch.
> > > >
> > > > Upon further testing,
> > > >
> > > > [/usr/src/linux-next] make
> > > >
> > > > is sufficient on my system. Turns out that it errors out even
> > > > without W=3D1.
> > > > My
> > > > next guess was that it had to do with -Werror, which would cause
> > > > warnings
> > > > to
> > > > be treated as errors, but my .config has
> > > >
> > > > # CONFIG_WERROR is not set
> > > > # CONFIG_DRM_WERROR is not set
> > > > # CONFIG_DRM_AMDGPU_WERROR is not set
> > > >
> > > > Do you perhaps have patches in your tree that aren't in next-
> > > > 20251029?
> > > >
> > > > I wonder if Fedora's build of gcc 15.2.1 is different somehow
> > > > from the
> > > > build you're using....
> > > >
> > > >
> > > >
> > > >

