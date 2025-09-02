Return-Path: <linux-kernel+bounces-796924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0E5B4097C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDDF9543F07
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2763D322DCB;
	Tue,  2 Sep 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAX0SbfC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810D230DEAE
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827866; cv=none; b=r6HGKWanw27mTf4BcWEf7SREhiJCrybZyRZwDnXR835U/ub6Bg2Ccc4NiLybBPFBP1RfPwZahaveWgfsRJ/iD9suWjwk0Hd7n35Qv8fHPobOYYl2JGIUB+TSmWGE9sOIk+BhJ0g6qVySqV5ymeTZQUc0nEw/zPKvHKSfuVlqLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827866; c=relaxed/simple;
	bh=tRuf/GDyIIArpeIiuGsBiOMQ7cIVqbvoG7nMpsSi53k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oPcFza33/0gFMvNOZdS4Hqs8K80h04zeG1F2GpX5TR9gFxW3Y7YsKOGCwPNCOL5QRA+ccJcAu7y5q2Z9F4LCY29M25dgBXNFTYVho8/ZcadRIJAR1NKUYH2Eh1LRkk8eoTqRJ9T0946eyOiBFzRRIlNhZ9YQDsVWNM98C+7k3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAX0SbfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EABC4CEF6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756827866;
	bh=tRuf/GDyIIArpeIiuGsBiOMQ7cIVqbvoG7nMpsSi53k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gAX0SbfCGmL2kk92IUNicUapOCeZeZbABa9LoFy/S7Fa2rRwHDeFupg2dRzJ/RW+L
	 ubRqwavV7lirCTfbfhYvbPKpq8NMmJK1ujj9bGoimll3OGjHd7K/f3Kny3ujSel/4R
	 VW7say78jC7AB0bv7PVc2e3CtrCk0kIrcteOWyFOXcsLuVHq3Xc+zRczJj3oS1Yj3y
	 zfsjx7jgw77ShduBbX3ZQ/ut+yWRsXH4ZlQkR9HprsBkudASI/9iDVrXW7VeoFWr24
	 I4kj45VxCzWuovoylvy4IpnW3UM4wUPIqeCJRrUcKbPdNb6QyMY/R7RPN7xK/JgXeQ
	 hi/FS6MuEnp6w==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7a16441so869199766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:44:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpXGmDAQjlhjEPDQd6NhU1YkH3RSWOmancVl/j4NoIAl1W/WR12tPR0eXFzsDjqp4zj+M0h6unLeFLWog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2lzu8BU7qhizi+SA66SXmNDRRK/HdAXY5CRyITkWYFHStP//d
	QJBcj9zcsSHjMmgs3U8zPP9wac5HFhgG3b1UMveVvM4QOVlXDJO8hq/TyDinOm1pLd7t6xzKord
	3JC9NXN4V8l0JT1PvAnjpGWkFnBXQrzE=
X-Google-Smtp-Source: AGHT+IFO70924iVFolgzUjIZaE0GLn7wGy/Aud1H3aa/R/fGPcETwNoCLZ0tk7y3JHUXV0aqFuX5gzk/udJutrbJioY=
X-Received: by 2002:a17:907:86aa:b0:afe:b5fa:2adc with SMTP id
 a640c23a62f3a-b01d8c7d928mr1279558566b.24.1756827864719; Tue, 02 Sep 2025
 08:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901072156.31361-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250901072156.31361-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 2 Sep 2025 23:43:24 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Q7CPHjuvHns5OevW1DZ-jC30xtEQ5Ao=DYva-LZWStQ@mail.gmail.com>
X-Gm-Features: Ac12FXzky8itaIyvk-uerpxxb7YE4Vi6IRA9i6mbSOw_hcFwFsBBCvi-usHWc7E
Message-ID: <CAAhV-H6Q7CPHjuvHns5OevW1DZ-jC30xtEQ5Ao=DYva-LZWStQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Fix objtool warnings if LTO is enabled for
 LoongArch (Part 2)
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nathan Chancellor <nathan@kernel.org>, loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:22=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> The previous patches [1] [2] are to fix most of the warnings (total 3030)=
:
>
>   sibling call from callable instruction with modified stack frame
>
> This series is a follow up to fix 2 kinds of warnings (total 24), it only
> touches the objtool and LoongArch related code:
>
>   falls through to next function
>   unreachable instruction
This series seems the best solution from my point of view. So if no
one has objections, I will take it.

Huacai

>
> With this series, there is only 1 kind of warning (total 3), it does not
> only touch the objtool and LoongArch related code:
>
>   missing __noreturn in .c/.h or NORETURN() in noreturns.h
>
> In order to silence the above warnings, it needs to change the related
> code to give the functions __noreturn attribute, and have a NORETURN()
> annotation in tools/objtool/noreturns.h. IMO, it will touch all of the
> archs and the generic code, so this needs much more work to avoid the
> side effect or regression, once it is done I will send out the patch.
>
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3Da47bc954cf0e [1]
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?id=3D5dfea6644d20 [2]
>
> Tiezhu Yang (3):
>   objtool/LoongArch: Fix fall through warning about efi_boot_kernel()
>   objtool/LoongArch: Fix unreachable instruction warnings about EFISTUB
>   LoongArch: Fix unreachable instruction warnings about entry functions
>
>  arch/loongarch/kernel/Makefile | 2 --
>  arch/loongarch/kernel/head.S   | 6 ++----
>  tools/objtool/check.c          | 8 ++++++++
>  3 files changed, 10 insertions(+), 6 deletions(-)
>
> --
> 2.42.0
>

