Return-Path: <linux-kernel+bounces-827673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C38DB92607
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2076216EE54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6D53128CC;
	Mon, 22 Sep 2025 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8CUpcCd"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB251DA23
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561403; cv=none; b=oDmvpCGV9XeQAbiJThJWHXyr+iuZ16crVayz7wKDSfquyi6HDja+qdztMxLfsAV9FBz/nBytJnNdEkaa8WYqzRsWNqEzwLGoT7GVD49mIPddVPujsjCdoPZIPKdOqpSpokxk/b71Fi9WmofST+pNwEaY/JMpdksmF99wMBgEWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561403; c=relaxed/simple;
	bh=MZX3BArSyTfdsbf0Ts7rcUcL2FK6diGQFYx85udDcL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/HyxO2e1IWS7L536u5Ao0SqMmc8jOne2dMb2gA+TzrIpsEAtV/kIo4LDxawMhJKLn8yGk0tQfIS46jgl1qrM1J73m0AZNftbmFIy9cgNEKpDWcb5rLo6Z32C8wbfD08w+Ixoz7Yh/YN1E7xBufON4AOSXOqz4UN2VFv/SUgi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8CUpcCd; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso100428e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758561400; x=1759166200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZX3BArSyTfdsbf0Ts7rcUcL2FK6diGQFYx85udDcL0=;
        b=P8CUpcCdB7YzHdt5pwLOeEp2TCZu7rEGsfrszs4aO7AYxslxbTMfwsPdEOqpbPi3gl
         3XKOf+VwbaWx2UvpiU4rXkFUaXieUaT9VAE0YyseDDvV9rRtFmnkOm1qzyu9HoG+81TI
         sfrwEAHQ9x97yPwbwV2mCEZuGREfzk+vn4hTsJKLAFsKCmWOGILloksjejdwdngyLDZV
         h/SLjc5fpQXKk3pPU564nQohrbSYUUXb1uURwzLN6La0AlJkQXX7wSFxMaC3cYlCacuw
         maFFlNZlYLa54nCEKO/fxVqIWsI1IItCkK5swvHNehLCKBJsiP4JZ0XCpSrA2VVli91R
         yxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758561400; x=1759166200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZX3BArSyTfdsbf0Ts7rcUcL2FK6diGQFYx85udDcL0=;
        b=j+rNXo7unvTbQfHLEXfTkYiPQ+ui9KLph4GEswPAS2lYFr5PRFoiku0hbk22tCoF9m
         ZUZpTfXGuy0Me8YmHh1hkIOz/bxfhKbgZGxKNuwk4EjLXUtRY9od0JYlTp/I6b3EWlhO
         JpCjy3kcidQoUGVLrN11PvYSQ1FYjQyQ3VUu3obBv9BcBuZ3GZkDSnISkdgnEecNpm1O
         E08rTBO43+o5IVaI5Vw1cklvps+MCJpgRJz+8QoBG2gPXUaJcJXMdU1wtDBw534hPRW/
         w75MLuMH3ZH2qmsO3e0J9lp8jagoqmCSKtuEzPiVt2QXtiuZ1pru8DtOjPINiIv/r+kb
         2pCg==
X-Forwarded-Encrypted: i=1; AJvYcCWIpzlaB+jVexA7dm6GGpkOFcnx+hBf7XvEge5/iOhsQAPWKQ7TcPjoe9pJvMd04V3g9Efoa0PEbAMxLTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwy+KnozUfHcNTaJQkGo0J9C+NH4hcU9qseVsRyRRmJvUONQQ1
	DzCgEm6AgaxJ6Sb8avn8GJ5pOcgGybFCU/hyfQxNOfd0EISWNwWK039HDrz4MUcq9j4PK5Yocfe
	0tZmeJGJ4VqaJoSu09cZSgg7TbLit5iU=
X-Gm-Gg: ASbGnctn6KanPP14qjzGJTGjIigSrh8qyVbatTaMK8G2vhAWIMnOLl6YwLNb24IT/FU
	UiTbDrxk1ZBahC5r1WduZITv7O5vhOejaFwionW+uSHHQpIL+mITDY47gbg/1hWoiWbya/u5WUH
	+CjN1OPCRd3rhXvFLA2VKtXW1nj3Xg6uDwPHVfkaRvoWKUVtCF/rFB202aGaxp21aR1VmLubnnD
	p19Pa8=
X-Google-Smtp-Source: AGHT+IHarbzJ6Y0Kx1EuBP51HF3QqIRaq6W5hGvo9rzQ11VJWCv4CphDndWPOoVT25Wb0mhT/VW8OhKl1IyEHjMkBl8=
X-Received: by 2002:a05:6512:2913:b0:57d:8870:e96d with SMTP id
 2adb3069b0e04-57d8870f70emr1592623e87.30.1758561399443; Mon, 22 Sep 2025
 10:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903-tegra210-speedo-v3-1-73e09e0fbb36@gmail.com>
 <2334a545-9a06-42d9-8282-674b94fdcb2f@nvidia.com> <CALHNRZ_gNzCEOzcYBY4o5Hz-efS5b52K4uZqmw5ps5zEfKoOEw@mail.gmail.com>
 <5e1b09f0-7f4a-421c-b09f-4f95c1c6ec3b@nvidia.com>
In-Reply-To: <5e1b09f0-7f4a-421c-b09f-4f95c1c6ec3b@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 22 Sep 2025 12:16:28 -0500
X-Gm-Features: AS18NWChSC7X3N75Jv-gvVc8Hq-b8TEe-hBz8bqB2KABn75M9vUKybGGxS149pE
Message-ID: <CALHNRZ-43RHsjiw1NJAxc3qAqHEoEYongtB0MzsfP5q93H7_XA@mail.gmail.com>
Subject: Re: [PATCH v3] soc: tegra: fuse: speedo-tegra210: Update speedo ids
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Joseph Lo <josephl@nvidia.com>, 
	Stephen Boyd <sboyd@kernel.org>, Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 4:55=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
> On 18/09/2025 18:19, Aaron Kling wrote:
> > On Thu, Sep 18, 2025 at 4:45=E2=80=AFAM Jon Hunter <jonathanh@nvidia.co=
m> wrote:
> >>
> >>
> >> On 04/09/2025 02:58, Aaron Kling via B4 Relay wrote:
> >>> From: Aaron Kling <webgeek1234@gmail.com>
> >>>
> >>> Existing code only sets cpu and gpu speedo ids 0 and 1. The cpu dvfs
> >>> code supports 11 ids and nouveau supports 5. This aligns with what th=
e
> >>> downstream vendor kernel supports. Align skus with the downstream lis=
t.
> >>
> >> Do you have a reference for the downstream kernel change you are
> >> referring to? I have found this change [0]. However, this does not qui=
te
> >> align with what you have in this patch.
> >
> > This is based on L4T r32.7.6 [0], which builds up the list over
> > several commits, so I can't link to just one. The first revision only
> > added sku's that I had specifically verified. Mikko suggested to just
> > import everything from downstream and to simplify the conditionals.
> > And that's this revision.
>
> ...
>
> > [0] https://nv-tegra.nvidia.com/r/plugins/gitiles/linux-4.9/+/refs/tags=
/tegra-l4t-r32.7.6_good/drivers/soc/tegra/fuse/speedo-tegra210.c#72
>
>
> Thanks! I saw Mikko's comments on V2 and that makes sense. The problem I
> have is that comparing this with the above, it is not clear that these
> are equivalent. The above is using the 'a02' chip version for setting
> the speedo IDs but this is using the speedo revision. Now it might turn
> out this is equivalent, but it is not obvious to me. Ideally we would
> end up with something similar to the above.

Thanks for noticing this discrepancy. I will fix and verify, then send
a new revision.

Aaron

