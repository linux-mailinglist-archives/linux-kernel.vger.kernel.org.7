Return-Path: <linux-kernel+bounces-751567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEC9B16AF5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C19D18C60E3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53481FAC48;
	Thu, 31 Jul 2025 03:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVoBqUaH"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7812F41
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753933677; cv=none; b=uuD9bozIhuVbsMosxAiJbXYoFwe7aTB2/v3VzH5lKrdrPyLdRiU9aYifyD5g7lo2nOobDe4FoU86OBq1AFMPAUg7L4TyEbizHLu7jjwzanzfJRUZYgxv0Z477qzIOMgwyGL5GSbuxhkd6nww5jc8xmbp39DeKgj1o9vMfbE62fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753933677; c=relaxed/simple;
	bh=QiAbcnoqzswL6KgBgm0UrfO52wb+Jm7aPysoeMwjEV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAs15xY9yosPLq97ybR2fRowHruqdvOrMDXMgvi6kq+obrFRyVnN1yYmlleR/daqLuuqZGHwMGfk8rS2K6K0flMfGULIwsm2ROhASc0YFRUHbrRMRuAk4IbIm1jMfXBWTlyuzv8ZdwCMQXU45rNaXJ3ozDJlZlnstuuOawzmtG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVoBqUaH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61543f03958so596792a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753933674; x=1754538474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TipReVIbHYikOGm96b9ccV0Al10yALQ5vwodidB34xQ=;
        b=GVoBqUaHPRFNsLoOGSVlWInt0rm7/h02b/wRlXF3SjezvdBzDArX7VsxMWM/cgXtS1
         2Km/ZTn54T2JhJdw8P3Y/tzdpp6ttDX76xY3JFocEjOcMad97TPlSMY5YteEM+Dm1S/L
         EfLOD9eJVzFMR6McHjdeKKihvJGhep9aG/3Okgc6pkLdxYpo3aD8fD5bNUG33lAwc5zb
         9wtSOULYp7X1WpsSAwZeDe9jZbuBZBaAP+tvb3UNXNWowVWvstehTzvKveZRI9mXhK//
         gJyWNW04spnPyywHj/zFqP2LCfff+0QEB1g6dm4lca08DdNDcAxcUxxUOP6TEAPU5SPh
         ORDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753933674; x=1754538474;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TipReVIbHYikOGm96b9ccV0Al10yALQ5vwodidB34xQ=;
        b=qpLY8k1wPYyJ3ZFtH+M4HBT5kbBq3T1lqiBXY5c7pXRfifW4oY/0Ib/Qyak8iZEugK
         r9HH/yoCa6ekq6xw8jdf2gqBvHZmEx/9SD/oBkSm+BhbB/Yfu1FPZfAkvXE74oTdnCnO
         /CjoubNhyaHJmW0BOhcRZJshNBPGCzvwDAVR2QcXn0UuRJ3Xg8iOO5LJOkG3iOfoeGZo
         tYOrfxpJqxLLWP2qlhMCT9sjUXal4zQh7l+VNXVIFlccVlxM2W/X4BRR9zvH60d37Czp
         8F3hDwH9tIQOoyZy2U4SLaFlOa4XIkX4zUA1jNg2Sg7JIgIL4vs0xERnHuz6vJhTeG4Z
         jItQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0/lbVSBHyynGEciQBdFY14/FTm5RVyrIw4y/dAgInndVbh9ZugGvTDmorcS+e4ThW+Gtz111ibNdaWWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8B0UQeABzVMH8u24inzy3r3QphWxH1tgnTrM42spFq0GRyH9
	G7avs4uOablFiS742BaNM2dXm8cQAae2lWC48elR6HSvvmX9Slo6dFuXQT4KWYnXxiTIPgpMJ/k
	OIcdUoYP44bT526jfDEQydmMYfibA2rc=
X-Gm-Gg: ASbGnctZwV6baCBx67lUiodNnvhLG4gRMKhaorgcdL1VMYdO8+aSk8IZFafjkw4tDSW
	Lqq9DF3WcP8Xmr0E2OPT4zvUifIn7zXa9tuOZSsy/W3PSHKjulTmIXO6frkl60sL7+M2LxPgmzE
	GfRTmP5tN6GQJTU2HMmhNxJ2hNvKkBQkpBOKk26A1jV9SCrdlAQVzXdHD+VdWnMliIsFtECjSKe
	7VxOxD8TXjQM6Wd
X-Google-Smtp-Source: AGHT+IEvTAydO0B8dvzIZ0V9dPskizzLo7/Pc73sLswWKrpceGhyGfj+u9TePveB4an+PFx0VzXm+x86pMJ7Umh2hIY=
X-Received: by 2002:a17:907:7ba3:b0:ae3:7113:d6f1 with SMTP id
 a640c23a62f3a-af8fd77fd70mr767905066b.25.1753933673729; Wed, 30 Jul 2025
 20:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com> <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
In-Reply-To: <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 31 Jul 2025 13:47:42 +1000
X-Gm-Features: Ac12FXwzj7aR8cH3Q3BwHUffq5oqwa0xpVNoHkTPAr_dHLtsTxCt0qqTKuewNo8
Message-ID: <CAPM=9tze2EcWTyi7VZxEY6Ys+YSrep4U15TtizZghFSD6eWjsQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 13:41, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 30 Jul 2025 at 20:05, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Again: I'm not going to guarantee that I got it right. I *think* I did
> > - I'm not feeling particularly unhappy with my merge end result.
>
> I spoke too soon.
>
> I'm very unhappy with the end result, because it just results in a
> black screen at boot for me. No signal.
>
> It works on my laptop (Intel i915), but my Radeon desktop is very very dead.

Is that the Polaris card still? I don't think the merge would cause
too many problems in that area,

I'll pull out my Polaris card and run some builds here as well just to check.

Dave.
>                Linus

