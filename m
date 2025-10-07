Return-Path: <linux-kernel+bounces-844763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2210BC2B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C66C3A49AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06B23D289;
	Tue,  7 Oct 2025 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CE0S4v0e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846235464D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759870355; cv=none; b=ianvTHZADR2UdfxJXqU5N2S6L5MxbXvQxmUy9/ioGIU6otnkgohQ94lewGXxpB9a01DVPWOvQBxzBwkjlN2ctwd5sjhD1rIJyUB0XS7VuNA4SMUXxLkHMlZzdqm/ZWezCgSuR/Ih5c+ohg/jSeiZ36IkJHNRW3+YzdU4Z2EKIV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759870355; c=relaxed/simple;
	bh=y8/GMUldGG3w+0pZPoxpukYxq6AmGwZnw9wcgcC5hw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Krfc/lU8q4rjQh0L9Y7kdeunbWgEC90ad/Wx7CB/HGT7glHZhSOrUprwdcxqBngIcBknWHHm9LLshJmGGpcBgfx4MM3wJA0xqm4f5cFo2LKVem9F5rfuSCFYWLYQPHLSug0KM3y0Jpb2X1jva5Ajz4hi/zyTrlnhFROJsf/wy0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CE0S4v0e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB3DC4CEFF
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759870355;
	bh=y8/GMUldGG3w+0pZPoxpukYxq6AmGwZnw9wcgcC5hw8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CE0S4v0eb4SvIu9cYkNeO8SZpv/02gbFtSP5tQebsDHrs+6NT5zYnwT7b6iUWHLho
	 W55kL+t1f/pqDC8H8A8ZenEzpty98DQMItE0PHI3JSswbh/m0ntC1qTchisqbwFT0j
	 3qHSo4wbFIgWjmhN5Y038PWu6Wo9CWnfqAZqB75gcnk+V4f+QByD+1awtZjXEv35A3
	 9B0zpylF53vJwCgtcqSfp5vhTjSk+Kk9DA6S0+wC8057ZRgSCt9fMuzpKZJ0LxBSqK
	 Eji0VOEnXpDhwZtdGv/8Phf7pp/BW3SxxhL78lhIsMn50+ZZChgM6221ON9zmMptt9
	 qzgm+rXyDbL1w==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-58d29830058so6701814e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:52:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmqGoZIHLll+GOYZpzVR/1u/XetR5xE0LwqnUMKiCwAjovoFl+7uZ78FKdSP7fCbaZR7vHM9EPKrevxIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+zxkibmEpEoXoI+Iej9hB0TfnVFtXZCRmOnqS3ADV0bUOeAnG
	pSlkhaPTZLeER/IosXUxOjW+jHJsY3lXKATAiBTGxOV2GZKPE54oQvlA6y8R10v/19ZP/TGY4Sy
	zRPXdBITE4vIsxuIlhokId/fZBgWrUxA=
X-Google-Smtp-Source: AGHT+IFWqLgtXiTrJW6mGp3mRySogk1jb7z6qNnqnVCTlvVrrsiW7mc/3XsIbu+BF3mk4txNgZWky6Zv0V7pXdHDgXU=
X-Received: by 2002:a2e:bd16:0:b0:338:8b9:293a with SMTP id
 38308e7fff4ca-37609d72b5emr2423171fa.13.1759870353542; Tue, 07 Oct 2025
 13:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002210044.1726731-2-ardb+git@google.com> <5824c012-dcb2-4312-9b16-810656290831@amd.com>
 <CAMj1kXHUjL7=CPz0viSBvfeX=BKNYuUkrpTizn9H1ZgJecB6cQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHUjL7=CPz0viSBvfeX=BKNYuUkrpTizn9H1ZgJecB6cQ@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 7 Oct 2025 13:52:22 -0700
X-Gmail-Original-Message-ID: <CAMj1kXEzNPJOE_-gndNcFmE9CjLpsFCjfytaXbvm-1Khu62XRA@mail.gmail.com>
X-Gm-Features: AS18NWCUcEc5v5iNbYwR-ag_-_0hSbWa3FKTC6RSEE69o8OM0SeSucBijz0KzNY
Message-ID: <CAMj1kXEzNPJOE_-gndNcFmE9CjLpsFCjfytaXbvm-1Khu62XRA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix unsafe uses of kernel mode FPU
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, broonie@kernel.org, 
	Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Oct 2025 at 12:59, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 6 Oct 2025 at 19:42, Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
> >
> > On 02.10.25 23:00, Ard Biesheuvel wrote:
> > > From: Ard Biesheuvel <ardb@kernel.org>
> > >
> > > The point of isolating code that uses kernel mode FPU in separate
> > > compilation units is to ensure that even implicit uses of, e.g., SIMD
> > > registers for spilling occur only in a context where this is permitte=
d,
> > > i.e., from inside a kernel_fpu_begin/end block.
> > >
> > > This is important on arm64, which uses -mgeneral-regs-only to build a=
ll
> > > kernel code, with the exception of such compilation units where FP or
> > > SIMD registers are expected to be used. Given that the compiler may
> > > invent uses of FP/SIMD anywhere in such a unit, none of its code may =
be
> > > accessible from outside a kernel_fpu_begin/end block.
> > >
> > > This means that all callers into such compilation units must use the
> > > DC_FP start/end macros, which must not occur there themselves. For
> > > robustness, all functions with external linkage that reside there sho=
uld
> > > call dc_assert_fp_enabled() to assert that the FPU context was set up
> > > correctly.
> >
> > Thanks a lot for that, I've pointed out this restriction before as well=
.
> >
> > Since we had that issue multiple times now would it be somehow possible=
 to automate rejecting new code getting this wrong?
> >
> > E.g. adding something to the DC_FP_START()/DC_FP_END() or kernel_fpu_be=
gin/end macros to make sure that they fail to compile on compolation units =
where FP use is enabled?
> >
>
> Something like the below perhaps?
>

Never mind, that doesn't work. dc_fpu_begin() is an out-of-line
function, and so it is the DC_FP_START() macro that evaluates to
something that includes an arch-provided assert. I'll code something
and send it out.

