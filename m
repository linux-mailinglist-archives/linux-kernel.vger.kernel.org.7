Return-Path: <linux-kernel+bounces-787321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676C8B37482
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F08361E83
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 21:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54902D23A3;
	Tue, 26 Aug 2025 21:46:31 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3193298CA6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756244791; cv=none; b=r9jb6Un3iwoKCDQDbVfJgMycsOR7VYFLG5H4aEZJwcEhOoh07q38dWw3Z6no/CtJ+ZWqQSQUwCde1uVSjXDxIZ9yhBCyQdbkJ+1ROp9UU26COmFH/NCxXGhB5/P/TVEhsfNQYFeRZQGAs9ouvTBPdQcaF3HHhscJJkMBH97ppmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756244791; c=relaxed/simple;
	bh=wxjUVhxbok5IPGUPMxHmf/MxyRnEbApTzZPax+WoJ1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSoZ7TRhxA+fDRYPYUaxJ6dRYU1qXdqd9UTDlQJGO8kNVi+d8r0aBU0CIEhXRc2gVbMz8PXOrRIGoamAoptEqvpG+2URLt5etAj3wtrz1rr1DCmj8gH8jHOiCjciObCC5Mrjz3Tv/Owcjjph0mJN/NaGr55qNjuywuhrndqrDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61ca9a5b41bso703392a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756244787; x=1756849587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlR2W8sGPsNFxVXAPLkKkhjl01WcoRvDHaUyBoigeGE=;
        b=EEhRP7Jy/LXMgNu/3M9ibkQZt+9CYRNwGqcIkkmrS3U/3unO+9RZGvxOvIS9W9rPZe
         3KXu7mBxIa8Hc31dIEOIRVmwjJ28FvjRXxjArZvnEZzj/+m++wW7GcboqPvOCM2vG8XF
         rMrI6OKCp1bgdJnoAP5mMlcoA0t/T3RGaS1HlHM3+68Nqm1kFbiWfAqt5nL5gqC1LrXZ
         5QXdgOMtbfUbNoWCQdPUwBK9ZoB+lY7ucW0Sn/mi8akLTYfXkDlre/zTh1d6eJgDwHmG
         inETaImSLRNOFqixD89KKWwnKkx/GSFAjCno7GQNDwVEzGkM+5kLEn0ILPdK85gRLrrh
         f6Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVe9AR6AW+Nn8Yx4m5n6gYH0U4D+rwzdT12jl9POQV0o3ebgmIPkt4Ny4dNZ+hRaBBbvymqYCmPeIBrxfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQDnz7YhwuL1u47p5LhV/ry/n4XkZpYOiAD3xiZcYGq6CG2jZ
	C/PQUtew9iY8MrpV8P7UC29fhkZkIRnoTy+G+zsFxo28Oexq78y0shDqiHjJ12GA
X-Gm-Gg: ASbGncvhI8QgtGBX+k3OdjStIxLK+L87Z8+q/vG60Zq+B6FaDkr8OpcbU6zqYmR3eR6
	p6zSnRdWSAbWB3tjMLESD+feuwyRG/PbCVXbxF4yqv5XFhZ9v+03j3SD9n8dojFLrIcwQ2sWX6m
	27hmA1qz9GQq41SAC2grnnO+00w9MbAqGvkkQWreT90tu8KtVebKB1hEqXz9DCFZXpxul7hs+2y
	mTtwXurprcXZh3QCc5bwcXneAZTt82NhV+4AanEOTbZ1/7zUJGim5ZQBSh0eeNk6dFhukb9TcUw
	DvamBdbGgnKFJiuyvkXjH+8wEUK0kQchb79sXIFufkdeS9rMA4LMBb7nmzgGwmHgVrY4uawAWP+
	lU5HGJpFrkQK1FNvqQkgxwZQ5tr6vcU/vll1Ja0VMfeEBScBTsYKcUtH+cX0kGY1h+XyhU/ZnR/
	uW7egjat43CCgiwDhvWQo=
X-Google-Smtp-Source: AGHT+IHGx9/iXEbj8Lhtvc9OrdoBXibHV8ndElWafZFD0/3aXo+jxuGmAQphqwFsw+DfBht2w9xtwA==
X-Received: by 2002:a05:6402:2342:b0:618:20c1:7e61 with SMTP id 4fb4d7f45d1cf-61c1b6fb6ebmr17473031a12.27.1756244787208;
        Tue, 26 Aug 2025 14:46:27 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c3174f77fsm7720384a12.56.2025.08.26.14.46.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 14:46:26 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b72b7caso8275449a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:46:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBVAoNdS4a6YDe3G9C96hpd+P3xbGpwe9QpWtPy1Gpgo/G9ic/pZ+hj+QnmTGou3wbGnTSMyE8lDGcA7o=@vger.kernel.org
X-Received: by 2002:a05:6402:34d2:b0:61c:979a:e7a1 with SMTP id
 4fb4d7f45d1cf-61c979ae911mr2475028a12.16.1756244786336; Tue, 26 Aug 2025
 14:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826-dart-t8110-stream-error-v1-1-e33395112014@jannau.net>
In-Reply-To: <20250826-dart-t8110-stream-error-v1-1-e33395112014@jannau.net>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 26 Aug 2025 17:45:48 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8F_n9J5aBsTBm6RgAL9DdXKTgyMNxDo_aPOR42GzGUkA@mail.gmail.com>
X-Gm-Features: Ac12FXwA-HRfgwtoditQ_gzG_vHw6fQHNUVW4nCA0dkeveZIhrlsxxZOpuqsYBc
Message-ID: <CAEg-Je8F_n9J5aBsTBm6RgAL9DdXKTgyMNxDo_aPOR42GzGUkA@mail.gmail.com>
Subject: Re: [PATCH] iommu/apple-dart: Clear stream error indicator bits for
 T8110 DARTs
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 6:57=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:
>
> From: Hector Martin <marcan@marcan.st>
>
> These registers exist and at least on the t602x variant the IRQ only
> clears when theses are cleared.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> I've overlooked this change for the 4 level page table / t6020 support
> series [1]. There are no dependencies to series so this can go in on its
> own.
>
> Janne
>
> 1: https://lore.kernel.org/asahi/20250821-apple-dart-4levels-v2-0-e39af79=
daa37@jannau.net/
> ---
>  drivers/iommu/apple-dart.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 190f28d76615159527649cd288df395a50d950ef..8b1272b7bb44a1ebc03ca4ddf=
3be43a1e42c97ed 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -122,6 +122,8 @@
>  #define DART_T8110_ERROR_ADDR_LO 0x170
>  #define DART_T8110_ERROR_ADDR_HI 0x174
>
> +#define DART_T8110_ERROR_STREAMS 0x1c0
> +
>  #define DART_T8110_PROTECT 0x200
>  #define DART_T8110_UNPROTECT 0x204
>  #define DART_T8110_PROTECT_LOCK 0x208
> @@ -1077,6 +1079,9 @@ static irqreturn_t apple_dart_t8110_irq(int irq, vo=
id *dev)
>                 error, stream_idx, error_code, fault_name, addr);
>
>         writel(error, dart->regs + DART_T8110_ERROR);
> +       for (int i =3D 0; i < BITS_TO_U32(dart->num_streams); i++)
> +               writel(U32_MAX, dart->regs + DART_T8110_ERROR_STREAMS + 4=
 * i);
> +
>         return IRQ_HANDLED;
>  }
>
>
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250826-dart-t8110-stream-error-1c2bbbf4fb63
>

LGTM.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

