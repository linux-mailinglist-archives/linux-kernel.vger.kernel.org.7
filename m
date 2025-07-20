Return-Path: <linux-kernel+bounces-738007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116E7B0B313
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 03:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC7D3C0BF3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 01:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40FD7FBA1;
	Sun, 20 Jul 2025 01:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXshrda+"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981B78F4F
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752973994; cv=none; b=EPTR9DLQDVaKjawDLi86eRPqQS2ab4CTDhIUgMt7EVj+RH1cz4qUwRiAsWEjUts6Gl5XqbzwZldhpl+v9YJkFtxkRMmx3Bank3Y32O0Amx/aYtnnBaVN+Eb4QfnDcBsbisDARiI29rXVEY5zlm684KwCuSi4MsNnOfQ9z/apmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752973994; c=relaxed/simple;
	bh=6uk0W8iKTa8sK0IC32X+KO5Cd8z3THwF1w2LO3/CqWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kciB7AiWelFErAjiqUrYbXvQphv/tTPd+O5llD0H3JI2hAdNSx4zET3WYjxTI6CQO3ooh5EkjFhUUyZsLv6plvvcHtP1Q6WdWRfk67iaT86YJQFtuEbunZLDdhiAj4Zroo0wFBxIblmE5FJoP39+3kdqvvf3ScZpVv8L34Fy9EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXshrda+; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8bd3fbd9f7so2850661276.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 18:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752973992; x=1753578792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qFEhPN5VIreuUIeJZxHGUtVS5WrAHG54xoLttPQ9js=;
        b=TXshrda+lbPI3vQTcaRRSW43oCAbB1whyFm1ZeYqqwDxSumVFviII7TpuZrojo2ZlP
         K5tjyaG8csVQR/fhFs4puyXNB1zg6Cl7U2wlgWljXBET7kMStbAyvxFy0dTtR+LPEH9B
         725idIfWXAqNhOibhD5j4nG/i5NdorDSOz0x9GnN7iisf97fcAPtANE9+sig5FCo11tJ
         jdJeOth9M4OBdeNkYlL1RkffVhK5hhDi0OoxbGxR4DQHB+UawSNK37t2H214mumQKT3o
         +knXQCL8kbb+JXMEOxAiTYlfd/9HlGWyJdW+caUl4FfJ9CxkVNndsb4Hxb70chOdFqmL
         woNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752973992; x=1753578792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+qFEhPN5VIreuUIeJZxHGUtVS5WrAHG54xoLttPQ9js=;
        b=LYaCAAfpHzh1GaVGbP6HDkb3ADe6lTUv8bI0R0G1jZLFR5cUtflD1VU6dlSyuxIxZ2
         8Jvqx2/VONWLWa9aPfHfgS2uArJJANkob9XjvBl+3KNBXIiRmJbOS6b5+C7PwqXWEK+q
         qhO23IvTrMDzzo7OPW4mmBy5xlBaiaz0zO1vMK+ACaXMoi4KOPtUCoelYP/6yxPCPGEP
         a/ppWiPAl2SzPBs50c+eY4VbyVGOK9BGXLY13R4uktQXIrpj3Yj+0/8JGPu2W3KyShxC
         Vsx1+sD5s4R6ExhF7zQ0JULJW2c3uFwXBIcqm5LixMJTjopyHjMXBizFnNOWc51MAalS
         UUgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJDShxw+5I0NCBC0GXF4DnuTAr+bc6gFu5YEyNfBTEdXqRIg6tfU8jCPLYQWpQDm0/soiUloSVicfNDAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqPveu1ctcxer2BUb0MgvtGmksYa6HstoVdrpdOm5Q6ZNlBg6i
	V5fBrfSF4XDIGunJbDzgNPmqc9YyJombiJaR1xuUWjdvpoQ7nYU9C1/KZTE8suLfUA95bg4ycgk
	DLDlnrFl4wt9v+gLRd+TmbfLCtPUdS3zzVzZ0ePQ3Pg==
X-Gm-Gg: ASbGncu6AmR+fJ22m90mwUCY/4jvCvIQ0y51PZqHOYCFJAcTKjDNmbjV7ViIs+fyzFb
	aBDRQoFwGPn6kE47qXtrFiFW92UQe8qa9u/HsQAc7W4sOkpxF0tRKieBsnX2qWUiP8a/PYdX2zV
	27OwPt+Dn4fG1mLi253zOfkVZifx72kUenK/xZc/EMORtCIBm783WjfK27t4flXOKrPfopX0Ndz
	35mQAU=
X-Google-Smtp-Source: AGHT+IG2sbHcr2XjMkZ101kqHgU69/mylWczYFamTwY1x9FdIIUlbsGjpwjbNdGpZntRfHQUrk4/nh8/EUAZOmwoDyw=
X-Received: by 2002:a05:690c:4883:b0:702:52af:7168 with SMTP id
 00721157ae682-71836c271abmr246856567b3.2.1752973991801; Sat, 19 Jul 2025
 18:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720000146.1405060-1-olvaffe@gmail.com> <0198AAC0-2F53-4A20-A869-9D720A086818@collabora.com>
In-Reply-To: <0198AAC0-2F53-4A20-A869-9D720A086818@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Sat, 19 Jul 2025 18:13:00 -0700
X-Gm-Features: Ac12FXyzRH1tJUxlfF1GbrPLiqDGvY7BJ12poIhR_GK4IC5q2ZjK-rXjqJhIFmI
Message-ID: <CAPaKu7QVEXp5Zsp2mNW+_wnci4O_UAienba0gNvXK_8iykwZCg@mail.gmail.com>
Subject: Re: [PATCH 0/9] drm/panthor: add devcoredump support
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 5:41=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Hi Chia-I Wu :)
>
> > On 19 Jul 2025, at 21:01, Chia-I Wu <olvaffe@gmail.com> wrote:
> >
> > This series adds devcoredump support to panthor.
> >
> > This is written from scratch and is not based on the prior work[1]. The
> > main differences are
>
> I wonder why this was started from scratch? IIRC, that work stopped, amon=
g
> other things, because we were not sure about what exactly to include in t=
he
> dump. I don't think it warranted a completely new implementation, IMHO.
As noted in the listed differences, this impl triggers coredumps in
more places (e.g., mmu faults), captures lower-level hw regs,
separates capturing and processing, and outputs in text format.  It
turns out there is little code that can be inherited from the prior
work.

It also does not support dumping successful jobs.

>
> Do you plan to work on the userspace part as well?
Yes, there is a very early tool in
https://gitlab.freedesktop.org/panfrost/linux/-/issues/44.  There is
also a sample dump that shows the raw dump, the decoded one, and the
decoded ringbufs / cmdbufs.

>
> -- Daniel
>

