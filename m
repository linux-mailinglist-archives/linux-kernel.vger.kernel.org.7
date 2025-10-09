Return-Path: <linux-kernel+bounces-847477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC25EBCAEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80F719E4BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63E22848A8;
	Thu,  9 Oct 2025 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaUSiFvV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E004284678
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760045262; cv=none; b=ineT6tT84d6+PdYAOeok2pdNIhC5HRGSwmqyBRZYyt50olMZL/vWvv3nao/evk6oUFVMezaowURzFqyHJyDC05+A9sdcAYn+OphGhXMlqFdVUiNrLbopao1j6VLrTBWZ2xQLNM7UONsCplsK5PDwd3GtdCEcqv3jqrDq8ADgpGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760045262; c=relaxed/simple;
	bh=4loDIqhblCjJ30GBRu0k7u8qIz2dPxyVOru+CGKtJ74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uE/cSXmnj+MmO8sG2gao6JQXz7UfqOgNSYqEwcS6mbjgNFQkcqCCDImANaoVo+3MISvIWCCqTaSEpVpWR3X8KL0pjJhY7YacuxPJbdoLj/mYvMFmr0E9uyGdGM+Egt2tN8H+EvlXSB+3CSZYIjjKfVQjAPR8htML3ju8Otp1zJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaUSiFvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897B8C19422
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760045261;
	bh=4loDIqhblCjJ30GBRu0k7u8qIz2dPxyVOru+CGKtJ74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YaUSiFvVHVUtoMbaMFXZECh1Ue/nAlF7ytJcjfdOBeUZ5qKjrmG4Vw4ZQV3Ab6/o0
	 8oGRq2w0ekpTSCJuSDfKPzp3ylv9u3fDE5hKK6xoJQh44VL8D2XNG02kUCqrRGhGSA
	 9q9R5MidL2Uoio3BihyomjeV9rCOfM2a9q8pyVj5fDn/I1FxIq4pRmjRsaLiWtAqh9
	 ESrpzXme7KEHLYul0nVhvk0eVXvBJX0insfF9UFSLR05ft9rZ5PZy0+WcynhkLqA4i
	 W5V76/vMCSX72cgCNwUFm5+5lBcL60I6Jykh8MY6aJj+Z0YV1FUhsj34rgK17XeEQr
	 tqi/cR5jFxMTA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso1652315e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:27:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVL3OXq6+nUASmCXY2wXiHGiuazwdROX8MFAn9dqGmxz2EhKuOva3a+OiH4oLZnbicTf9Nsg9/Go/6xc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWWADp5AAZAzLFMl9oUow0yVciuY7dYO9nCXC3OB5osIXKrSlc
	S3zvaqbiFIYok2UO25u7vHvUhqoh6r2VapMzkWjRWmn8lDrlp1WzZVafxMKLgdGEF28YtvzDK5b
	S6OXClDL9+tqxh7zTT+UNsKl/gDiDb04=
X-Google-Smtp-Source: AGHT+IER/TjSS/ftsXuN+vL0Qr19tffVlZEETaCj2FrKKovdy0RneNyLm8hMt38oGA2BPK1mfYI7btUasVrhpusvupY=
X-Received: by 2002:a05:6512:3ca8:b0:57d:92ec:67de with SMTP id
 2adb3069b0e04-5906daeb7b6mr2786494e87.57.1760045259802; Thu, 09 Oct 2025
 14:27:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009150621.3886079-2-ardb+git@google.com> <bbc089aa-934d-4dd3-825a-53f8e98dfd3f@amd.com>
 <15d5b9dc-8452-411c-9957-ba759d307223@amd.com>
In-Reply-To: <15d5b9dc-8452-411c-9957-ba759d307223@amd.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 9 Oct 2025 14:27:27 -0700
X-Gmail-Original-Message-ID: <CAMj1kXGLdNDJRgQg2Hr9YM4Ke6Sb6KLr8Ws-QY+umR4NpXjg4w@mail.gmail.com>
X-Gm-Features: AS18NWBLRyAo4AK5pdIQjAzn4UZLNTXw2YS4IciwUevqRyoiy4COy88E11E6XIM
Message-ID: <CAMj1kXGLdNDJRgQg2Hr9YM4Ke6Sb6KLr8Ws-QY+umR4NpXjg4w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Permit DC_FP_START/END only in non-FP
 compilation units
To: Harry Wentland <harry.wentland@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Austin Zheng <austin.zheng@amd.com>, 
	Jun Lei <jun.lei@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Oct 2025 at 13:41, Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2025-10-09 12:19, Christian K=C3=B6nig wrote:
> > On 09.10.25 17:06, Ard Biesheuvel wrote:
> >> From: Ard Biesheuvel <ardb@kernel.org>
> >>
> >> Test the existing CPP macro _LINUX_FPU_COMPILATION_UNIT, which is set
> >> when building source files that are permitted to use floating point,
> >> in the implementation of DC_FP_START/END so that those are only usable
> >> in non-FP code. This is a requirement of the generic kernel mode FPU
> >> API, as some architectures (i.e., arm64) cannot safely enable FP codeg=
en
> >> in arbitrary code.
> >
> > If I'm not completely mistaken that is actually an issue on basically a=
ll architectures, at least x86 is affected as well if I'm not completely mi=
staken.
> >
> >> Cc: Austin Zheng <austin.zheng@amd.com>
> >> Cc: Jun Lei <jun.lei@amd.com>
> >> Cc: Harry Wentland <harry.wentland@amd.com>
> >> Cc: Leo Li <sunpeng.li@amd.com>
> >> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> >> Cc: Alex Deucher <alexander.deucher@amd.com>
> >> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> >> Cc: amd-gfx@lists.freedesktop.org
> >> Cc: dri-devel@lists.freedesktop.org
> >> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > Anyway, patch looks sane to me but I'm not so deep in the DC code to fu=
lly judge.
> >
> > Fell free to add Acked-by: Christian K=C3=B6nig <christian.koenig@amd.c=
om>, but Harry and Leo need to take a look.
> >
>
> Thanks. Good safe-guard. Flags a bunch of issues in the
> current code. Let me fix them before merging it.
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>

Thanks.

I already fixed a bunch here:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3Dddbfac152830e38d488ff8e45ab7eaf5d72f8527

