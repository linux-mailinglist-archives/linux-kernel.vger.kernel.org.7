Return-Path: <linux-kernel+bounces-752505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E42B17669
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F12958071C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3624166F;
	Thu, 31 Jul 2025 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJh7BvAF"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FE823ABB1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988669; cv=none; b=N2goDd/Z3sEe8ufGi9KwbgsJ5eEFoiZW73C1/R4SAB2J7gXVrLB0bU6Wr2mgZckSupVrVAAkMN2BSVAQZqJxAA4tN7uIuSowYguUxjJPcd4jQvl2ga81Vw8uFVXyhBMHenzpTo6728tfLeSHGLAfZ9o++jx841xKHxCTCU/KK7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988669; c=relaxed/simple;
	bh=gJXzkDWaDEoED0mXWlnwlQgnRDnNkaAlLSo4DQeBxzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gu/h+JFn3XcdT3gRxOeaP00RIoUBTbwPdn2OHWn6qZklKgivkIRq5cRlOLpwSuyy06auynIfEfaFJhHspzJXWQwGgRPEew1dy0lWXW5lCJQXbOGdVZNmiTTBNMgUJbSdi03as5Ifmlg0v6yQ/DJbGiNa5OD7GFa38SWOV/h+ZvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJh7BvAF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-312a806f002so184524a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753988668; x=1754593468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9hLQS1Qj2wO2t6Q4M7+LSgEvKKDPESGAJRbvOUbOkk=;
        b=CJh7BvAFhtpP1HgjOcXfxqdcHaYncBB/ydsZZYw1FCn76aaUSCwXgcB/6mhdjsiRHh
         jNrvjNDJoT01srNitQYKsDEC/1aoybtHQPGy1mukj2/SHaBwHT9e/YPFhvAW1ksRHrt5
         x2DzFiucu4LsXb7MdA3xBaj6k9iiDC0F9dQsEqVCojVNeGaRzWx1x0PEaDGhUfLf9Ijf
         HZIMs0PLvzwSUFY4G846GDdPBPd92LcW9alqCtdB2m8z/IhX49UguWvuuAjk2YAJODjw
         G71AMjtvY7mgit6CpFLzzbi//+mNE+9/z+iyOtvKs9dY1fzeNRrZvDf3u00HjQ3umhVh
         EHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753988668; x=1754593468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9hLQS1Qj2wO2t6Q4M7+LSgEvKKDPESGAJRbvOUbOkk=;
        b=ngfA5cmSZ0bAHnmPlgBDi4R9ypr1PKclBACtS96Om022YsvFFFuCR8iP10m8sKP4Tz
         GnwqldHQYMiQphtjCfRevqoiAY7pdAMRW3WuGIKV26nuDzBJxBs4pkRuQzCnoC8JZ3Mo
         vyAPpVbFk57Vu8Adw2MWMLKV69IJjZ8e3u6DHnfbfxLFbVqoGRaVGGuuNMBmedr4nSPi
         KbPxARHUQVF9yib/3OTsmnu9wZnDNfNr0KbVMoF5WHcDQ5lWK4maKojgSyWs5oXAiaUb
         U+SrABqxOwdBJJscw50X5aF7bimra7TH8mykx0Fbe7RALZLMVL3zoGRCu2l5fsObcWEn
         xWVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBiGPI+Rp0c0dV/FQxFXs4iPNhAOBJy0JQgbifY2hdTogq8YiaPTQtsEuFuv+Xyz14fvlg5my60H0veeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXLvyugGqpk2Sjb4L+w/7jl2gIW6MpkHXed/AOJYyItF3NrWC
	F8yeC0rg4cMRGobTHf4NOzWK2vF6XcsTwgpv2gb5meeO2ZRDNN1kNsqxu/fukATbMoZyaJIlEiR
	LBQweNsid1AP2/PWDnxmwHSvNMmKbJ3c=
X-Gm-Gg: ASbGncuBByDDj3wMfnST6y1odUVlxlQaR0EcGanwBuRmNdPT6nIFH0iOAGNKvdHeSNz
	qtyftMJgsYR7Agy1eIgA0gd0j8MRhenSw3AFi3aMrgUSJ/NLC+Hb9aokv0QInFpbtikXE3yOhYg
	zk6Zhmd8GHk2LAARbuXtkGw7VIFudG9/h+XNDc8D9lNpGPq/jNdHoiB7VVLxhxZfEfUFYVsSiA7
	HOob1KV
X-Google-Smtp-Source: AGHT+IF2bYEl2+BEOAeHiljf3vUKpTyZm8+ers0QVY/s0tVH7OkxrGDLUBtiEkAByU+NxHzaKfQ59C63xqQyq7UvwYc=
X-Received: by 2002:a17:90b:380a:b0:31f:ea:ca84 with SMTP id
 98e67ed59e1d1-31f5dda82d5mr633555a91.2.1753988667626; Thu, 31 Jul 2025
 12:04:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
 <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
 <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
 <CAPM=9tygJqtbmYzB5gktxp-7fBfv_9gNq9p9+SdZ6wiYE2-6PQ@mail.gmail.com>
 <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com>
 <CAPM=9tyb1mELymOJv62KJom4mGF0UBifbVqLJUFdS1C7Eeu3jg@mail.gmail.com>
 <CAPM=9tzDWmYBKQGB0ybDzhYHkg0p98_6PJA8OuPahRep8+QPvQ@mail.gmail.com>
 <CAHk-=whOb_ebQQbnXeqb8uXf32WA32nrL3=HQ2y8hBm9hFgVOw@mail.gmail.com>
 <CAHk-=wh+79KkMXsNqyPxeU+c5U2h-n13ko6J_QzwtjyYCKhrSw@mail.gmail.com>
 <CAHk-=wgEGn0azq0n5BfWg4ZStrZYanLCX1a+quug7HKmjimhpw@mail.gmail.com>
 <CADnq5_NBM1Kso==+N=1xCjF+xiS7Vy4g47uvUN7sSWs8bontZQ@mail.gmail.com> <CAHk-=wiN+0FBwxwj1UiKsfHgW=C_aWy20F6PPt5M_ACnfukehQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiN+0FBwxwj1UiKsfHgW=C_aWy20F6PPt5M_ACnfukehQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 31 Jul 2025 15:04:16 -0400
X-Gm-Features: Ac12FXzIgbuFXPjEc5kXfIQBbe_eDpBAwA8exmzuGM7zNQzkl_SPo-Foyl2jwFI
Message-ID: <CADnq5_MjQbDYZYvSi5D5sVN1oeaLdxRPCQdt99LkMW=FWdcOQQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>, Dillon Varone <dillon.varone@amd.com>, 
	Ivan Lipski <ivan.lipski@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 2:01=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 31 Jul 2025 at 06:09, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > I think it may be fixed here:
> > https://patchwork.freedesktop.org/patch/663973/
>
> Yes, this patch fixes the problem for me.
>
> I don't know if it's due to the pointer validation (ie this part):
>
> -       if (!dsc)
> +       if (!dsc || !dsc->ctx || !dsc->ctx->dc ||
> dsc->ctx->dc->debug.disable_dsc)
>                 return;
>
> or whether it's the divide-by-zero that the commit talks about.
>
> Should I just apply this directly, or expect a pull request in the
> next day or two?

Just typing up the PR now to send to Dave and Simona.

Thanks,

Alex

