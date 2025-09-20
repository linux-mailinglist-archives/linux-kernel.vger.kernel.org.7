Return-Path: <linux-kernel+bounces-825652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF5AB8C6EB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 13:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13531BC0671
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228892FD7DA;
	Sat, 20 Sep 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEML+i9L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC542FDC27
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758368481; cv=none; b=mp4lYRWKWLO0q/0uLsf/I5iUWuKja7W8hqk0NA3KcKY8C5a3uBUf1+6HFwsVNVC15J74OsjG6XU2EePBZot8HrDLnyMlA9PqNj9gKx6tgfrV1TNMbyOCzOHDmYcWSngl4HX/XfYuwVkwMjRQI4/mIyM/C30JpKFWmB7pca+7+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758368481; c=relaxed/simple;
	bh=wRo0YLaw8DyQub6BzFo7m0B5qda32As3YYQaoqnwGqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IQTHN1wpA4+w+6UeDhmsyhohkbK2awKalHraUsfESFZNBU7vJcoidb9er1DEPc/Fl5opfcVqa9ADffBJjBITRDQlo+rD5v21oHBPwwQvsFWnMFbazEVnc8eBmrtjw0hzitifZaWyXrFEJVrq8s9Uo7m5WoeHd3sFr+Ff/94TLTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEML+i9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C2CC16AAE
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 11:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758368480;
	bh=wRo0YLaw8DyQub6BzFo7m0B5qda32As3YYQaoqnwGqk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZEML+i9LJ8WSQqXcDjWGAEKlNnPfsYWxZ2Zjcm3/fm0RxKUbMNePRtZCguOufgIeU
	 W9UxlwKcHhfMDdeX6EcQ7OFFF8gpwej6Iw56cmOtm3GIL5oFTkzWsqyoVSG1syfOoW
	 3q17vT+VIBoNBFXhpbxjmzsZhZXIz8PbEveSOtjcx/HLh3/BtSkTQE8EurkwmCpeDS
	 jdGlpE1i3Gza06+ZA/mnGqPL9/JPJ4e4ZFoG8i1P0+7/iFH/fZ2T7u9eFSbZZDXyC8
	 F4jYv8mluAeVm1DNY+yxK0HhaHwVPY7joIR3xHrQotZw512lUPp/fCxzoOjmPYXx3q
	 JyxCwTz7UWERw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso3049772a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 04:41:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWJPiS0j3OFaSJT7ii/Pop0y6hCpiBIkxo2Kb2dgq+C1G0RLn7SZkAukt6tUXhl+GddJYM1sTXhJr+fp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMCLSAeQKWGinuJHEtkVMntYVOgx7vnN8YnWXRlnL1mRoNIQVR
	snXaexeq8kVnBHkJ9GXecYxOJcNuTnYW/jKZvvnisNg5xRS6gE2rULMN1kXBQE80cN1Fo2hlWAO
	gWTP6CVrg+82o+ZtDM2yCh5WCdIVIH/M=
X-Google-Smtp-Source: AGHT+IFZzHAyQ1PhqneBePuVKq1gxKghmUHATguF6ZPm4CtfFp3f4mVb6XLErzMCUoIWIkpOEn0J/WcwRy7at4Yq6iI=
X-Received: by 2002:a17:907:7292:b0:afe:a83a:87ce with SMTP id
 a640c23a62f3a-b24ee6ef584mr767720966b.2.1758368479046; Sat, 20 Sep 2025
 04:41:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909092707.3127-1-yangtiezhu@loongson.cn> <20250909092707.3127-2-yangtiezhu@loongson.cn>
 <20250920061536.GA1460394@ax162> <CAAhV-H5=w82CDx=1=PZjf4FVW_dGWe_e__QazwDTwE3kKXtPLQ@mail.gmail.com>
 <c9c4c0e6-946d-95de-9c03-a4b8e1636b81@loongson.cn> <7eafa4a6-55bf-2fcb-19ef-b18bd51bfd39@loongson.cn>
In-Reply-To: <7eafa4a6-55bf-2fcb-19ef-b18bd51bfd39@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 20 Sep 2025 19:41:03 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4xx-C28-a8H7yJTK30+r90zL9XTSAb87Jr4zLc5ShBoA@mail.gmail.com>
X-Gm-Features: AS18NWDT4qeGtVwPk4bf2a0_rM3HNkQd7evhHdSpldq9OK81OM-K1U_xJkU-KhY
Message-ID: <CAAhV-H4xx-C28-a8H7yJTK30+r90zL9XTSAb87Jr4zLc5ShBoA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] LoongArch: Make LTO case independent in Makefile
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, WANG Rui <wangrui@loongson.cn>, 
	rust-for-linux@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 6:22=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 9/20/25 17:19, Tiezhu Yang wrote:
> > On 9/20/25 16:23, Huacai Chen wrote:
> >> On Sat, Sep 20, 2025 at 2:15=E2=80=AFPM Nathan Chancellor <nathan@kern=
el.org>
> >> wrote:
> >>>
> >>> Hi Tiezhu,
> >>>
> >>> On Tue, Sep 09, 2025 at 05:27:06PM +0800, Tiezhu Yang wrote:
> >>>> LTO is not only used for Clang, it maybe used for Rust, make LTO
> >>>> case out
> >>>> of CONFIG_CC_HAS_ANNOTATE_TABLEJUMP in Makefile.
> >>>>
> >>>> This is preparation for later patch, no function changes.
> >>>>
> >>>> Suggested-by: WANG Rui <wangrui@loongson.cn>
> >>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >>>> ---
> >>>>   arch/loongarch/Makefile | 10 +++++-----
> >>>>   1 file changed, 5 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> >>>> index a3a9759414f4..9d80af7f75c8 100644
> >>>> --- a/arch/loongarch/Makefile
> >>>> +++ b/arch/loongarch/Makefile
> >>>> @@ -102,16 +102,16 @@ KBUILD_CFLAGS                   +=3D $(call
> >>>> cc-option,-mthin-add-sub) $(call cc-option,-Wa$(comma)
> >>>>
> >>>>   ifdef CONFIG_OBJTOOL
> >>>>   ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
> >>>> +KBUILD_CFLAGS                        +=3D -mannotate-tablejump
> >>>> +else
> >>>> +KBUILD_CFLAGS                        +=3D -fno-jump-tables # keep
> >>>> compatibility with older compilers
> >>>> +endif
> >>>> +ifdef CONFIG_LTO_CLANG
> >>>>   # The annotate-tablejump option can not be passed to LLVM backend
> >>>> when LTO is enabled.
> >>>>   # Ensure it is aware of linker with LTO,
> >>>> '--loongarch-annotate-tablejump' also needs to
> >>>>   # be passed via '-mllvm' to ld.lld.
> >>>> -KBUILD_CFLAGS                        +=3D -mannotate-tablejump
> >>>> -ifdef CONFIG_LTO_CLANG
> >>>>   KBUILD_LDFLAGS                       +=3D -mllvm
> >>>> --loongarch-annotate-tablejump
> >>>>   endif
> >>>> -else
> >>>> -KBUILD_CFLAGS                        +=3D -fno-jump-tables # keep
> >>>> compatibility with older compilers
> >>>> -endif
> >>>>   endif
> >>>>
> >>>>   KBUILD_RUSTFLAGS             +=3D
> >>>> --target=3Dloongarch64-unknown-none-softfloat -Ccode-model=3Dsmall
> >>>> --
> >>>> 2.42.0
> >>>>
> >>>
> >>> This change is now in -next as commit b15212824a01 ("LoongArch: Make =
LTO
> >>> case independent in Makefile"), where it breaks the build for clang-1=
8,
> >>> as '--loongarch-annotate-tablejump' is unimplemented there but there =
is
> >>> no version check before using it.
> >>>
> >>>    $ make -skj"$(nproc)" ARCH=3Dloongarch LLVM=3D1 mrproper defconfig
> >>>
> >>>    $ scripts/config -d LTO_NONE -e LTO_CLANG_THIN
> >>>
> >>>    $ make -skj"$(nproc)" ARCH=3Dloongarch LLVM=3D1 olddefconfig vmlin=
uz.efi
> >>>    ld.lld: error: -mllvm: ld.lld: Unknown command line argument
> >>> '--loongarch-annotate-tablejump'.
> >>>    ...
> >>>
> >>>    $ scripts/config -s CC_HAS_ANNOTATE_TABLEJUMP
> >>>    undef
> >> Hmm, maybe we need this?
> >> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> >> index ae419e32f22e..fcfa793f9bb0 100644
> >> --- a/arch/loongarch/Makefile
> >> +++ b/arch/loongarch/Makefile
> >> @@ -115,7 +115,7 @@ ifdef CONFIG_LTO_CLANG
> >>   # The annotate-tablejump option can not be passed to LLVM backend
> >> when LTO is enabled.
> >>   # Ensure it is aware of linker with LTO,
> >> '--loongarch-annotate-tablejump' also needs to
> >>   # be passed via '-mllvm' to ld.lld.
> >> -KBUILD_LDFLAGS                 +=3D -mllvm
> >> --loongarch-annotate-tablejump
> >> +KBUILD_LDFLAGS                 +=3D $(call ld-option,-mllvm
> >> --loongarch-annotate-tablejump)
> >>   endif
> >>   endif
> >
> > We need to handle the other case to use -fno-jump-tables if llvm does
> > not support -loongarch-annotate-tablejump.
> >
> > So, it is better to update the minimal version of llvm to 20, which
> > includes the following two important commits:
> >
> > [LoongArch] Add options for annotate tablejump
> > https://github.com/llvm/llvm-project/commit/4c2c17756739
> >
> > [LoongArch] Avoid indirect branch jumps using the ra register
> > https://github.com/llvm/llvm-project/commit/21ef17c62645
> >
> > If you are OK, I will send a patch to modify the following file:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/scripts/min-tool-version.sh#n29
> >
> >
> > and keep arch/loongarch/Makefile as is.
>
> The other way is to keep scripts/min-tool-version.sh as is, and only
> modify arch/loongarch/Makefile, something like this (not tested):
>
> config LLD_HAS_ANNOTATE_TABLEJUMP
>         def_bool LLD_VERSION >=3D 200000
>
> ifdef CONFIG_LTO_CLANG
> ifdef CONFIG_LLD_HAS_ANNOTATE_TABLEJUMP
> KBUILD_LDFLAGS                  +=3D -mllvm --loongarch-annotate-tablejum=
p
> else
> KBUILD_LDFLAGS                  +=3D -mllvm --no-jump-tables
> endif
So complicated?

I think below is enough, no?
ifdef CONFIG_LTO_CLANG
# The annotate-tablejump option can not be passed to LLVM backend when
LTO is enabled.
# Ensure it is aware of linker with LTO,
'--loongarch-annotate-tablejump' also needs to
# be passed via '-mllvm' to ld.lld.
KBUILD_LDFLAGS                  +=3D $(call ld-option,-mllvm
--loongarch-annotate-tablejump,-mllvm --no-jump-tables)
endif

Huacai
>
> Update the minimal llvm version or change Makefile to compat various
> llvm versions, which one do you prefer? Pease let me know.
>
> Thanks,
> Tiezhu
>

