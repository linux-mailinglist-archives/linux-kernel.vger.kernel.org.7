Return-Path: <linux-kernel+bounces-825563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB38DB8C3D0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 10:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2ACB7C39AE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 08:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B073279DB4;
	Sat, 20 Sep 2025 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzCDD84P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0235277023
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758356645; cv=none; b=UFpJmnnaGmuWEyjUAoUePq7Zk+aDUMDi4EoGXEBCqhthnl1FUDBs62Zyh2uhQNjlheiXUIwCh/odQXaN92whkheBCbF+x0n47IhTe4+VL/WFgP4BAr1wdIsnvkTmKz3qBH/mh5lI+5bN36RSPidceeUfW+EmfpaDzefSuXn4Kz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758356645; c=relaxed/simple;
	bh=YnYHhp0UWx6XtM/X67tIf+lKn9tz3bkw4GNRmkXRbv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=If5HpYB9LNqfJzoY1sjS6Io5eVH/xhK2Ymr84i1UIEFV8f2RuwjtJ66IlZicIOBL0u4a1+syBH8a8rY+yX2OesFTOGG+XnrIVMxa9dFMhnAWivwb1hqMRJh7zSFyIwwqfnaC1kCCXwaxYByHy8k1pUDats/uwQfhm29+CADI0Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzCDD84P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D19C4CEFD
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 08:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758356645;
	bh=YnYHhp0UWx6XtM/X67tIf+lKn9tz3bkw4GNRmkXRbv8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KzCDD84PSE0a+6xvX8MuJ9W5b4IwFfji0hSiIrcuqyFjHch8oDjbmtRkf606RoSVP
	 3nKsM5hig0jTNTV+2EY6MBPqNQiDgfLEgRYtO3CRj+aXxwI2M1mMgBDHWr1zPEDl2H
	 9+KDVba66jdYpONszXv81CtoMwiIztx3LsN2YNVVU1lBNQDMRFFoSEmBdA8/ZSUYTS
	 feGqJZm+uVzcXW6wGj+HFuDEPN6ti5hAPA9JNLR9F8VER+slltFqNWBM6eoo5ECgFy
	 zREbF37zmbtf2h7Nheh0olIYfxhvtTOnQNVGVKquQx44oD25EDmSq0P3jDnkdsGB+K
	 ORBmnxF8drCpA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7322da8so531627966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 01:24:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXa5V8cjv22VcRVwRMJPNtNA8iU7xfRnik0g3y+VDIT/LyW5TLzHKY6glDj+oJEoYPaQaLkAaWZbTsuteg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpOgXkMErneMM8HR4Vf+eDDA39WTVxTWILIoAeIjy+8XR9FUdq
	qtok8Cib/8afBG0+xI3S/n4RKoQSo56oR78p3s0WaA0DSWGSld4inrUxaiEwk5OQ0jRNw/zw/O5
	XV7bui8S86N+YBBzQPgMYTsIvbIdWm4M=
X-Google-Smtp-Source: AGHT+IE1V69IB770zqWYjhjaCj6tn8iJPPv0SBnhYKLAU9Ntgj5lSyQh1CuISoGxQ9p9ufFMB1R9rGUANEUSEmP/28o=
X-Received: by 2002:a17:906:c155:b0:b24:3412:7cfe with SMTP id
 a640c23a62f3a-b24f5b59e7dmr574572866b.63.1758356643803; Sat, 20 Sep 2025
 01:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909092707.3127-1-yangtiezhu@loongson.cn> <20250909092707.3127-2-yangtiezhu@loongson.cn>
 <20250920061536.GA1460394@ax162>
In-Reply-To: <20250920061536.GA1460394@ax162>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 20 Sep 2025 16:23:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5=w82CDx=1=PZjf4FVW_dGWe_e__QazwDTwE3kKXtPLQ@mail.gmail.com>
X-Gm-Features: AS18NWDYHVIbI5779aN0UyncebCxN_ZOrrIzZhLpspFq65G-qD9jtCDFkKgouS4
Message-ID: <CAAhV-H5=w82CDx=1=PZjf4FVW_dGWe_e__QazwDTwE3kKXtPLQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] LoongArch: Make LTO case independent in Makefile
To: Nathan Chancellor <nathan@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Miguel Ojeda <ojeda@kernel.org>, 
	WANG Rui <wangrui@loongson.cn>, rust-for-linux@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2025 at 2:15=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> Hi Tiezhu,
>
> On Tue, Sep 09, 2025 at 05:27:06PM +0800, Tiezhu Yang wrote:
> > LTO is not only used for Clang, it maybe used for Rust, make LTO case o=
ut
> > of CONFIG_CC_HAS_ANNOTATE_TABLEJUMP in Makefile.
> >
> > This is preparation for later patch, no function changes.
> >
> > Suggested-by: WANG Rui <wangrui@loongson.cn>
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  arch/loongarch/Makefile | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index a3a9759414f4..9d80af7f75c8 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -102,16 +102,16 @@ KBUILD_CFLAGS                   +=3D $(call cc-op=
tion,-mthin-add-sub) $(call cc-option,-Wa$(comma)
> >
> >  ifdef CONFIG_OBJTOOL
> >  ifdef CONFIG_CC_HAS_ANNOTATE_TABLEJUMP
> > +KBUILD_CFLAGS                        +=3D -mannotate-tablejump
> > +else
> > +KBUILD_CFLAGS                        +=3D -fno-jump-tables # keep comp=
atibility with older compilers
> > +endif
> > +ifdef CONFIG_LTO_CLANG
> >  # The annotate-tablejump option can not be passed to LLVM backend when=
 LTO is enabled.
> >  # Ensure it is aware of linker with LTO, '--loongarch-annotate-tableju=
mp' also needs to
> >  # be passed via '-mllvm' to ld.lld.
> > -KBUILD_CFLAGS                        +=3D -mannotate-tablejump
> > -ifdef CONFIG_LTO_CLANG
> >  KBUILD_LDFLAGS                       +=3D -mllvm --loongarch-annotate-=
tablejump
> >  endif
> > -else
> > -KBUILD_CFLAGS                        +=3D -fno-jump-tables # keep comp=
atibility with older compilers
> > -endif
> >  endif
> >
> >  KBUILD_RUSTFLAGS             +=3D --target=3Dloongarch64-unknown-none-=
softfloat -Ccode-model=3Dsmall
> > --
> > 2.42.0
> >
>
> This change is now in -next as commit b15212824a01 ("LoongArch: Make LTO
> case independent in Makefile"), where it breaks the build for clang-18,
> as '--loongarch-annotate-tablejump' is unimplemented there but there is
> no version check before using it.
>
>   $ make -skj"$(nproc)" ARCH=3Dloongarch LLVM=3D1 mrproper defconfig
>
>   $ scripts/config -d LTO_NONE -e LTO_CLANG_THIN
>
>   $ make -skj"$(nproc)" ARCH=3Dloongarch LLVM=3D1 olddefconfig vmlinuz.ef=
i
>   ld.lld: error: -mllvm: ld.lld: Unknown command line argument '--loongar=
ch-annotate-tablejump'.
>   ...
>
>   $ scripts/config -s CC_HAS_ANNOTATE_TABLEJUMP
>   undef
Hmm, maybe we need this?
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index ae419e32f22e..fcfa793f9bb0 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -115,7 +115,7 @@ ifdef CONFIG_LTO_CLANG
 # The annotate-tablejump option can not be passed to LLVM backend
when LTO is enabled.
 # Ensure it is aware of linker with LTO,
'--loongarch-annotate-tablejump' also needs to
 # be passed via '-mllvm' to ld.lld.
-KBUILD_LDFLAGS                 +=3D -mllvm
--loongarch-annotate-tablejump
+KBUILD_LDFLAGS                 +=3D $(call ld-option,-mllvm
--loongarch-annotate-tablejump)
 endif
 endif
>
> Cheers,
> Nathan

