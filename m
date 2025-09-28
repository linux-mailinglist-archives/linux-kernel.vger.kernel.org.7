Return-Path: <linux-kernel+bounces-835445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F914BA71C0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 16:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D8D18998DC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF3820101D;
	Sun, 28 Sep 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQHRjPwL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8561714B7
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759070485; cv=none; b=HSpT/IdkqjntmNH3U9/yivbblLoQ6/QlfzwzchS1ixm3T4jbYCDlpjP7VE+gYwO9Keo8YXBk4cKpqTvQnu4Qgql1av2rjZkbat2/cHLGr8jE0NLGLsvgRn2s2XWOptgOpwc9op9m24rFqd+JX0M26fKgckGIyuNM0Mx9KFxnRAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759070485; c=relaxed/simple;
	bh=zEl3HK9Huv3wAo8Gz3obptdVAl3BiTe7KlwyVun45hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pj/UcXva5JFthsTXV3HZZIuAZ6AqcWHZiVG3/J4qd+CC3FDdMAylqeJ1jRERpTO1Y5EOXEt4edNt/rnV5CLjaFubkJEBSyzwmzmDjmVu2pK6boUBDUA6n3kXCxUxBGRFJZjGPxcoQHVXmoibg1Y1E1afomuJnvooYa+SFzwpNAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQHRjPwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F25BC116C6
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759070485;
	bh=zEl3HK9Huv3wAo8Gz3obptdVAl3BiTe7KlwyVun45hk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KQHRjPwLC5G8brFRuLi7o+fpS7n5vnimwAp70vgaHEgFmGnQ+8/JXmEMwOpYluWwc
	 gPh8y3NdWf05BAJsL1h89OUxuFiv9K0M0HAyMqKJAYGCpmKa3ACFswAt33tdsAo0Uw
	 WdTCh+3Jn7TMW4j+oJj7r1EF6IJOs7ve0Px1LcHX9VnhjdE0r+UEpc5Xm6wBzwl3Yu
	 a8fnF/rbiGqU15Qg4uTENsF6mjnkIPDm1zebsaCCre5mcLnUqjqOoCMEqJWnK6oHig
	 l3Ae2UGbCke7CAP4d0CH4r2FibiszgEoGSh6Cq/uBnrxy4QLsw0AP9aujqJ9E7H1Ur
	 kFjd+rIM8OAoQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57bc9775989so3571149e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 07:41:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSYHtf/DfcwgYzsLf88ovfKrgZwjCcNGo3boKulSo11QbLCn6ixJVUvq+16+EflHf5HjUfkUfx/BaMDJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu88BxkT/g7hLPdcNeii7K95uBRbRrFZZ8WfX98tsdmlJLxvT4
	GYNdr/ZYzI5ioUvUTvxsm8l+hcVv9t3yGmsRnDHwUTTOyUN4bFsVkXWr+UIJ1Z2fRYb+32Pz5vr
	YkvAVmfc0q+fBWxZLnXLZWTI6UcWnU6I=
X-Google-Smtp-Source: AGHT+IFWQQN6QdQWgcfYnmBFENB0KuvC1Z/xcGcpQuzj5V+hESZTuEgEU7p0gTVxJK5oi7ZFD+wA09OxaRIm8jBNjGM=
X-Received: by 2002:ac2:4f07:0:b0:55b:8afb:e638 with SMTP id
 2adb3069b0e04-582d295ce23mr4091918e87.28.1759070484041; Sun, 28 Sep 2025
 07:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250928085506.4471-1-yangtiezhu@loongson.cn> <CAMj1kXG8Wi+THa2SeLxiDT=+t_TKx0AL4H-azZO4DNJvyyv96g@mail.gmail.com>
 <CAAhV-H7xOf8DEwOrNh+GQGHktOT4Ljp+7SqutGvvDZp6GLXJrA@mail.gmail.com> <CAMj1kXG=EFkRAMkvKMSjPixoGqU-tZXVoRkJJ6Wcnzs3x52X6Q@mail.gmail.com>
In-Reply-To: <CAMj1kXG=EFkRAMkvKMSjPixoGqU-tZXVoRkJJ6Wcnzs3x52X6Q@mail.gmail.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 28 Sep 2025 16:41:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHWe2uGY3S1NJ6mckqD4n116rPmaOzw3_Qbvxyjh7ECMw@mail.gmail.com>
X-Gm-Features: AS18NWDKeRljEYzTakhM3NRe_gYKBPPHlUPXn-bSPODAX07vV2YYljZFZWHKAg0
Message-ID: <CAMj1kXHWe2uGY3S1NJ6mckqD4n116rPmaOzw3_Qbvxyjh7ECMw@mail.gmail.com>
Subject: Re: [PATCH v2] efistub: Only link libstub to final vmlinux
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	loongarch@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Sept 2025 at 16:39, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Sun, 28 Sept 2025 at 15:52, Huacai Chen <chenhuacai@kernel.org> wrote:
> >
> > Hi, Ard,
> >
> > On Sun, Sep 28, 2025 at 9:42=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
> > > On Sun, 28 Sept 2025 at 10:55, Tiezhu Yang <yangtiezhu@loongson.cn> w=
rote:
> > > >
> > > > When compiling with LLVM and CONFIG_LTO_CLANG is set, there exists
> > > > the following objtool warning on LoongArch:
> > > >
> > > >   vmlinux.o: warning: objtool: __efistub_efi_boot_kernel()
> > > >   falls through to next function __efistub_exit_boot_func()
> > > >
> > > > This is because efi_boot_kernel() doesn't end with a return instruc=
tion
> > > > or an unconditional jump, then objtool has determined that the func=
tion
> > > > can fall through into the next function.
> > > >
> > > > At the beginning, try to do something to make efi_boot_kernel() end=
s with
> > > > an unconditional jump instruction, but this modification seems not =
proper.
> > > >
> > > > Since the efistub functions are useless for stack unwinder, they ca=
n be
> > > > ignored by objtool. After many discussions, no need to link libstub=
 to
> > > > the vmlinux.o, only link libstub to the final vmlinux.
> > > >
> > >
> > > Please try keeping these changes confined to arch/loongarch. This
> > > problem does not exist on other architectures, and changing the way
> > > vmlinux is constructed might create other issues down the road.
> > ARM, RISC-V and LoongArch do things exactly in the same way. Now
> > LoongArch is the first of the three to enable objtool, so we meet the
> > problem first.
> >
> > But yes, I also don't want to change the way of constructing vmlinux.
> > So I prefer the earliest way to fix this problem.
> > https://lore.kernel.org/loongarch/CAAhV-H7fRHGFVKV8HitRgmuoDPt5ODt--iSu=
V0EmeeUb9d5FNw@mail.gmail.com/T/#meef7411abd14f4c28c85e686614aa9211fccdca0
> >
>
> Can we just drop the __noreturn annotation from kernel_entry_t, and
> return EFI_SUCCESS from efi_boot_kernel()?

... or add efi_boot_kernel() to ./tools/objtool/noreturns.h?

