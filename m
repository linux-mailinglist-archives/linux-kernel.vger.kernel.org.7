Return-Path: <linux-kernel+bounces-893433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3E5C47627
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83DF3349E28
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD77314B80;
	Mon, 10 Nov 2025 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEOzgDM9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4894E3101C9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786772; cv=none; b=tpDOyU3btRowHuegF+DcNS5XOR4HnXNjp9XQANBgKhO1D4sN4fkjar3z7jXXCqCCSoCFecqTG32yMVCMQn1jEqPj3aaM/2EWTn2KzIHuQlRVB7lI2JiRVPEabIEXrBTGVf0lPs7aMCb4r6Fnn/4/oq18hMybHosi960g4HxUKRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786772; c=relaxed/simple;
	bh=PkKyE5AHzhJy/4LiMXi5ErssS1dpQk0dA4EYefZXhSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwhZWa85ivxK8iAYI/JCAgCueQsgudGATn6vTSmNrGxuFHwvzUewxWMuV6dX1dic6NFGetGomTJqv+O8Tqneo6r2FY9+ybgW7jZVhecpNSyXMIaDY1urWhQRqQYzo4ax0ZY8RPbQ3mA7W1Ps1Kg/iM7LvijPCXbj6VofkLSIHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEOzgDM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF333C19422
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762786771;
	bh=PkKyE5AHzhJy/4LiMXi5ErssS1dpQk0dA4EYefZXhSg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gEOzgDM9R0a/p53FlGWYVEa3CsSsK/CtHPFgq+wXAfttTi0u42ZZCI+AiFPNi1XuS
	 2VZ825oKkmpbz+K/hjywe29ZEDUCjnjS1xcTvv28MmDmAuRzmiTObdQjkFlH4hGWlA
	 okFEtbUK80hDvhk8uvs/VA9PQYJa+Pfqq4Gaop7DLYhN19ubpl/Vncq98D3VGDChyF
	 RfAQM/DTFGsIruCyATZMolbqc9N4mXAQA640gvDj8HRN4H/Hs72tlD/98jLhcdbBDC
	 AVVx/BxGAFNZYFGd5jVohnAoJNWe//5krIa8P8Pa1WOJug4a9PBGVeuBNpJ9fny8Vj
	 guc5BOPOZIgzQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b72cbc24637so576818666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:59:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWW2RlGxw32FXoBEoeNTePEgOQuIS4s68HabjTBF67qWkmJ/7jgXSEJ86BNbp8oWygMWQ4+DC4u6816qtA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Ky8u2lMVAso4jpzXy8ZkQ/FVgcXxvkAsj3nq5kOqKUk6Aznq
	vpO25yK3MmSfr9uAvyLg2vhkVK9fOz8tP+fMgFdjrPM+p5uMY00bhQJwxG4UsgVtfEijtenD5wd
	sYpFPOH45wKhNQyaV6m6P3vSWwzCoQJM=
X-Google-Smtp-Source: AGHT+IH0g5tuzCAga9f8nm1U6xI8QuDy+NNxNGTsAl9AUpJHsCKMTDvBZoGWU5yHN3ywDyiM40N1FGtq7yVontI2ESQ=
X-Received: by 2002:a17:907:3f9b:b0:b72:62b2:26a1 with SMTP id
 a640c23a62f3a-b72e0337345mr675259266b.19.1762786770480; Mon, 10 Nov 2025
 06:59:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110025906.17096-1-yangtiezhu@loongson.cn>
 <CAAhV-H4=ZfYfRFE8VYmxyKxTAi8E=YKysG1fzed4kZRWnMUoeA@mail.gmail.com> <4deb96d9-509c-3b3f-934f-58de8d29241b@loongson.cn>
In-Reply-To: <4deb96d9-509c-3b3f-934f-58de8d29241b@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 10 Nov 2025 22:59:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4J0VAYBDNMK0APws5uZXDJ--cpgmKdjU40+iSu62rNpA@mail.gmail.com>
X-Gm-Features: AWmQ_bmOvCgFAGs2qsph0XjgIEaCahryG7gsqdcwWrN3RaQSfyH_JD2xqw2_P2Q
Message-ID: <CAAhV-H4J0VAYBDNMK0APws5uZXDJ--cpgmKdjU40+iSu62rNpA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] LoongArch: Refine init_hw_perf_events()
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, vishal.moola@gmail.com, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 8:24=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> =E5=9C=A8 2025/11/10 =E4=B8=8B=E5=8D=882:48, Huacai Chen =E5=86=99=E9=81=
=93:
> > V1 was applied last week and now in linux-next, don't do meaningless wo=
rk.
> >
> > Huacai
> >
> > On Mon, Nov 10, 2025 at 10:59=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongs=
on.cn> wrote:
> >>
> >> This version is based on 6.18-rc5, use the proper patch title
> >> to make it clear.
> >>
> >> Tiezhu Yang (2):
> >>    LoongArch: Use CPUCFG6_PMNUM_SHIFT to get PMU number
> >>    LoongArch: Detect PMU bits via CPUCFG instruction
> >>
> >>   arch/loongarch/include/asm/loongarch.h | 1 +
> >>   arch/loongarch/kernel/perf_event.c     | 7 ++++---
> >>   2 files changed, 5 insertions(+), 3 deletions(-)
>
> I do not like to argue with you, but I do not think what you said is
> right, there are double standards here.
>
> The code are rebased frequently by you in linux-loongson.git, the latest
> is after 6.18-rc5 that is in this week, my patch is also rebased.
>
> You accepted the suggestion of your patch v1 title [1] and send v2 [2]
> although v1 has been applied by Andrew, because you think it is a good
> suggestion.
>
> I just do the similar and right thing,  but your reply is not polite
> and friendly, and also do not do the thing what you should to do as a
> maintainer.
If my words make you uncomfortable, I apologize for that.

But something is different.

1, I asked Andrew whether I should re-submit V2, Andrew said yes, then
I re-submit. You asked me, too, but you re-submit in a hurry before I
reply.

2, Yes, linux-loongson.git is rebased, but the commits keep the same,
this is because: A, changeset for PR should be based on a tag commit
rather than a random commit; B, the commits in linux-next should keep
stable for at least two days before send PR.

Huacai

>
> [1]
> https://lore.kernel.org/linux-mm/20251108084724.3e389b6597294900347b0476@=
linux-foundation.org/
>
> [2]
> https://lore.kernel.org/linux-mm/20251109021817.346181-1-chenhuacai@loong=
son.cn/
>
> [3]
> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson=
.git/commit/?h=3Dloongarch-fixes&id=3D4c8a7c982772
>
> Thanks,
> Tiezhu
>

