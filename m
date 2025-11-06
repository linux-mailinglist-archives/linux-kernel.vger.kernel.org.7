Return-Path: <linux-kernel+bounces-887695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC11C38E65
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8318118C7A12
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517F823EABB;
	Thu,  6 Nov 2025 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAEuchzn"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E734414
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396859; cv=none; b=S6YvcOA+6G2hSePGOenoyxXmKmzeUPb98xR2YdnoMertIy4ikZOyRwWg4OGHBQGqIhNsVeK0wgqPtDumS8GrQxdQgB92PnNkHglxkrmssKRccnwSYAXB/TZgg1R5dFLOShau0h01gBROHvxv6Cntu5tAGpx0FLcpapZuhoFrHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396859; c=relaxed/simple;
	bh=Fz3VOOaK2WJzX49TNEhoEpdRHL0wcrha2M363m/VmQg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aydhhI/Juuv4X/Hnx9M+v7FxUUgXi2uAvQHlWu6wnNuNdnZgDKT97qELss4uDZEnOuuvLrJ1+al/VrnSbnMs/vRzYmgXJ62qqeDlkZP7fV4P3cY98nNlCvmZXhwhkeoXmHYqEcXEhRtoUB0bZwvCBhQwrA+Rc3KAH5OUzlqosxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAEuchzn; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5d967b67003so384750137.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762396857; x=1763001657; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fz3VOOaK2WJzX49TNEhoEpdRHL0wcrha2M363m/VmQg=;
        b=RAEuchznZzA2IMlLfO8dqM+mwiQCeM3//dza5Bs+RgYDAKLouQoAK0dt3c3FRQDXta
         SbS23wErn6lXAhGHxI3lR4tQn4/tg3hqi7PNJ54MpH/ST/631B1i6JYLFitNMOMmTsV4
         BdMx9rjAIldEdqHVVzsHU8yLlFN7BBnOajUdjNY2P8AOKKfvxuG2KSDX0jrsVFfrfkHx
         z4kqRj7ZMq4WUPfceaSMIUIpdQriVIkpK4lQsf5vYs2sibiApfMfBqgllea19NiG5WH7
         aHkeFCXQmUlObhT4tt5Ur8P02e3sW78quGVwKHF8xwLph8eAYPOLTlYxpFtrxk6ziABp
         COQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762396857; x=1763001657;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fz3VOOaK2WJzX49TNEhoEpdRHL0wcrha2M363m/VmQg=;
        b=sbQFWyXTXkIZ482P04sQWRZ6gAPm1OPYAm2WJ7eJ/+jzeu02po1P0tNCvADBhevxci
         32kWQu7WO1IscTx+XpOgLgm0m+9H9e9pZeArt/b9LU6tfmREGrCuCscvCMe1L942jIU3
         +CMw7HDNm4F++e01h9HxGQkCNmq3MLQI9dLqTq2vmoEaI/y42KfAsGdiWkjiESsfkCzF
         nvQaAi3M5/DtoHhNxcKM+T8un18qrUEoo4lWyzGQMK79uWOJfzQva+s/rqumAZYe0aRL
         0C4jUBiiztWnx92B9rwtnJQpwXLUgOXRfJ1UGAp5m/97nIjB3YpX7LRb9uaRilaW2+28
         Mz5A==
X-Forwarded-Encrypted: i=1; AJvYcCV8DFOukQGEJRKXx/zwt62xaBalFL9ymbgtrx09dYK8aVSThcRxjHPXG5m48v/QEcqxR0iirnKg0kBLeuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YykdpWsBRrNWPgareAE6F1XQvthEd8HgFa5vGs+PsS77Ft/nkWC
	cHs/VNRRdz/Avwc9ZPK3miaO9YfooScOGOvxIqSjXXjE9zeyt4LASUhe
X-Gm-Gg: ASbGncuiraUBaar99GOIDZj7Cr9tk95c0UlEXERr0x2JzRvATpVOeN9bp21GcS1xOoH
	PJHnuEKenQehWY6ymz9g97OgV5rBSczDEezVU8lQ9TN5CMbpXQ1xMfZqNnXE9Jx8RaNiDymmCPw
	7ZjjNerVEHyuNgPkCHZg7HTZi7iFf901H6JsmjkE1JvScE90Xayz5wCU0PtSeUxk0dM68U0CAAO
	8pTd9ZIrEIciGZQW4gSvg6R5owLRq3YUoDe26J5LZ77eaSEBj8dzSIeqT66BcRsXexbGXwfhuBB
	KSTso/3PPAf4B6PH7f0/aWqnp3WvHzYsJUUSHhqA9g+iCxvf9+iWa9hWIvKzRxllJXHhT70up6V
	MsgruvFOz1HMCV4BfDJKQ6qgpe1n2qSWlMSoy+XK5XLccQpzdpqPSu/v1h4fmfQXvxQ8lTs6qDn
	UESYZKNoYsny/YR/yDDyPKZE3K7vZLgymQ3XkgokDkerkvErpnF/yvgyc=
X-Google-Smtp-Source: AGHT+IG48Ju4qzSiYeWrBUsxbdpp5+5EAVK8wecVkm+QFCx/tSKCn4HCOp+AQxx2reLlG02y/qKwQQ==
X-Received: by 2002:a05:6102:304d:b0:59d:ad3:e1e4 with SMTP id ada2fe7eead31-5dd89174feamr2084724137.5.1762396856783;
        Wed, 05 Nov 2025 18:40:56 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3? ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93708862f07sm500320241.7.2025.11.05.18.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 18:40:56 -0800 (PST)
Message-ID: <149f5bb52a21becedc17a5b0bf1a586672940af6.camel@gmail.com>
Subject: Re: linux-next-20251029 - build error in amdgpu
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Amit Dhingra <mechanicalamit@gmail.com>
Cc: Valdis =?UTF-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>, Alex
 Deucher	 <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>, David
 Airlie	 <airlied@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel	 <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org
Date: Thu, 06 Nov 2025 03:40:52 +0100
In-Reply-To: <CAO=gReF+sWpKZFa+wbtGxa3+wSjAQG1UMG3iJaDt2EOPmH-7mQ@mail.gmail.com>
References: <1043551.1761844832@turing-police>
	 <32ed124e9d603cad950c4836c7a14a3ba8bc2068.camel@gmail.com>
	 <1296761.1762045181@turing-police>
	 <CAFF-SiU3XL5pZAzsB=eXi7e1LKzx5XwiNOyfGpPXOnnc6uo2cw@mail.gmail.com>
	 <CAO=gReF+sWpKZFa+wbtGxa3+wSjAQG1UMG3iJaDt2EOPmH-7mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 18:34 -0800, Amit Dhingra wrote:
>=20
> >=20
> > What do I need to do to trigger the warning?
> >=20
> I have the same problem.
>=20
> linux-next on Arch Linux
> GCC : 15.2.1 20250813
>=20
>=20
> Steps to reproduce the error
> - make mrproper
> - make allmodconfig
> - make drivers/gpu/drm/amd/amdgpu/
>=20
> Turns out its due to randconfig, See [1]
>=20
> Setting RANDSTRUCT_NONE=3Dy seems to stop the error.

Can you please try and see if this fixes the warning?
https://pastebin.com/raw/b8j3UABj

Alternatively, if anyone has other recommendations on how to fix it,
I'm also open to suggestions.

Thanks,
Timur


> >=20
> > Valdis Kl=C4=93tnieks <valdis.kletnieks@vt.edu> ezt =C3=ADrta (id=C5=91=
pont: 2025.
> > nov.
> > 2., Vas 1:59):
> >=20
> > > On Thu, 30 Oct 2025 19:05:30 +0100, Timur Krist=C3=B3f said:
> > >=20
> > > > Can you say how to reproduce that?
> > > > I use the same version of GCC but it hasn't given me any
> > > > warning or
> > > > error for that patch.
> > >=20
> > > Upon further testing,
> > >=20
> > > [/usr/src/linux-next] make
> > >=20
> > > is sufficient on my system. Turns out that it errors out even
> > > without W=3D1.
> > > My
> > > next guess was that it had to do with -Werror, which would cause
> > > warnings
> > > to
> > > be treated as errors, but my .config has
> > >=20
> > > # CONFIG_WERROR is not set
> > > # CONFIG_DRM_WERROR is not set
> > > # CONFIG_DRM_AMDGPU_WERROR is not set
> > >=20
> > > Do you perhaps have patches in your tree that aren't in next-
> > > 20251029?
> > >=20
> > > I wonder if Fedora's build of gcc 15.2.1 is different somehow
> > > from the
> > > build you're using....
> > >=20
> > >=20
> > >=20
> > >=20

