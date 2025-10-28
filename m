Return-Path: <linux-kernel+bounces-874334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD1FC160CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 421E94EE75B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8622347FE3;
	Tue, 28 Oct 2025 17:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sFtFGqja"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52413345CB5
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671272; cv=none; b=c8xR//d+XoC4gTG7gM5LEiGg50RyJNjcHsjyT662xVXvC6DXlqym26L0ApwignTsyMCXE0dWK/8OVmKVHnK+1BQeZxo2EjGtIFufunW1IwBrM4GMpAz0RFqEF0BPbgVY18RMQWQ5ajixUY6yipprqXCAemD1/2qVfm0bhp810pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671272; c=relaxed/simple;
	bh=Tkq/5dhl0C1EAwayK8NcDVl7wbCLG7vllV38MaSxRjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H74GjfDTRQCkdpoOYrrSjIQGIvUrYKySUFbGL9LB7GBIMjwlgQrhK5XEQrr/VZqRkOV2zepd/GMSCagDaGH9Qg+R4gKGIGzKkofSMzeqG+iB3apG5CXpHDOCr3NjV0Al+GA/ku33zhthb3rSUFo8icXpWNilcSDb0eG7okKCB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sFtFGqja; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4ecfafb92bcso11791cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761671267; x=1762276067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlYRN294fgCC2VAZY8tAv4lYbAWWl+5+yhrp8qWvOQM=;
        b=sFtFGqjaEwoUyBe5nMWJ62D4cF+B7xNs23cZI4AQauf8Nzs7KaBhBmAdy08gkjuJ/B
         TOpN6tX40MGRCv9UPzb1v4C0MVltnrxVHarK5QAABBujlJMUwj7VPTu+HoLj0gie8erb
         N7GnifiCHOZk/m1OtTBKSwcjbAfGYPwhHCvT0waebca0QsV4CGb+EftokQA8h/6vGgwP
         E+k9p2kJj/gpC5dgYvGHzH1k+eVLyRrXbBQN+Ey6JfsLxt084fJKvKiSbvSpJjhiBSQd
         0Pv3IiNR76anDGmvHFVwhHJbB3CS3Cvox0j9ChcQaIlozujXRmtmdr5eaoAbd3Uf+XXy
         TPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671267; x=1762276067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlYRN294fgCC2VAZY8tAv4lYbAWWl+5+yhrp8qWvOQM=;
        b=AN7SPrIR4SGY6pU4eROD2qIDgkOWxz/TDj1ONbn2dPGB++HDRdVSwcWaHf47xXwhGN
         Q5FnFSz7zWFQ1Ll1E7dfP4VwwI4ssIdFGaM6HPykxThbk94aRSzZjLHQzAmYfK4dWFbl
         VgEUHy6TZBEzxqdOvxCWIArDD6TOXFXGBfhQZffy4AtYptYg4h7mA9WJeD556lSClWPj
         f0L4HZ2gxHhmILkaAeqQ0u7tOGEsPhflhduNqB5LXMUuUEDaA3rzASWkRP8XHbDyx9nE
         RKPvj2salT9z1bw2Tb29aYc5X1a1crZRYvkfSnC85z96Roi6N6m/jMOaMX+uC1MSgFci
         uMfA==
X-Forwarded-Encrypted: i=1; AJvYcCUBktRDpvF+lOa0U9+36TqyK6JUs7b95wjvkLQLm6Jez1yLf7prwjYvZ+PFKmNIGvxxOiHj/VWihIBNpJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OGlWoPrbfrImxBK+U4u6OLJAxUkNaTSCd99/KAFqrfbPD/mJ
	WT/FGTR/PmlrBaUTVFMUhsBgisH9uqIW9AJ2wGFqPTnuxEbP+oPcAzbWJQ6auqzB2pH3u7LzMBe
	Ys8laVDJrcjodq+i+g/6LzJykUTWloYYW2RkzCZhC
X-Gm-Gg: ASbGncsLW+jVmO4iW2rZW32muAYowIJkzpfS1+U5F2D9MLsw6mPXzq10lKlDjpm9WIR
	+63oFkE4UIU9Kssu3ZUgOynJ0iZMat9mBJXj51iiF1bty8JehiMNU3Maa1+bmVbdPR1hFqaLtSi
	v6/vIvXFILE/WlZXs3CPGN7tsCq2RH1eN2aYTV0ho2L058trSz5894esuUYytAIbTavbHo+UxDe
	bVNhB/EpJk2rz6cYceCkQk1rhJMCe829+wwWt11amSOCov+hiJ6q9qF0B8HKIIXfNpPvM0WCDNn
	YfkosrdeqmzDJw==
X-Google-Smtp-Source: AGHT+IEH8agpQadoFcoRQ/2MeIJtx9Vpo7xkxV0Ddwgdw1gUNOo7yRYt4+8OXghuG6MI4C1mNRU+jAVu3QS3Eg88QDo=
X-Received: by 2002:a05:622a:1654:b0:4e4:f2b9:55aa with SMTP id
 d75a77b69052e-4ed15946e3amr6841cf.17.1761671266361; Tue, 28 Oct 2025 10:07:46
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027220914.2665978-1-xur@google.com> <b1e13b0b-19fa-4177-8ae1-0fcbf6d076c6@cachyos.org>
In-Reply-To: <b1e13b0b-19fa-4177-8ae1-0fcbf6d076c6@cachyos.org>
From: Rong Xu <xur@google.com>
Date: Tue, 28 Oct 2025 10:07:31 -0700
X-Gm-Features: AWmQ_bmMAkhivM1KCn6RbeGX2tX36dDFl8J5mkr59voL9h-OSoodOBVJDzKptCA
Message-ID: <CAF1bQ=Q-97ovXXQgtXq75zZUL_FtXo4LHoATHHYLgL-cPi5CdQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] kbuild: distributed build support for Clang ThinLTO
To: Piotr Gorski <piotrgorski@cachyos.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Alice Ryhl <aliceryhl@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, 
	Rafael Aquini <aquini@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Stafford Horne <shorne@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Teresa Johnson <tejohnson@google.com>, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for testing this!

The culprit was the string -D'pr_fmt(fmt)=3DKBUILD_MODNAME ": " fmt'.

The previous patch parsed c_flags and removed -D% and a bunch of other
FE flags. Masahiro suggested using _c_flags instead.
I erroneously assumed there were no -D% in _c_flags. But this is
wrong. It seems that we do need to filter out -D% even using _c_flags.

I'll send an updated patch shortly.

Best regards,

-Rong


On Tue, Oct 28, 2025 at 3:43=E2=80=AFAM Piotr Gorski <piotrgorski@cachyos.o=
rg> wrote:
>
> I tried using this on kernel 6.17.5, but unfortunately I get this error.
> I previously tested the version in CachyOS:
> https://github.com/CachyOS/linux/commit/68984063b5e27854272241549e47cb293=
0ef9710
> and https://github.com/CachyOS/linux/
> commit/00a3ff73a566b7e27b4ced46af4ce27177d9fc37 and everything works fine=
.
>
> /bin/sh: -c: line 1: syntax error near unexpected token `('
> /bin/sh: -c: line 1: `set -e;    trap 'rm -f
> drivers/net/wireguard/main.o; trap - HUP; kill -s HUP $$' HUP; trap 'rm
> -f drivers/net/wireguard/main.o; trap - INT; kill -s INT $$' INT;  trap
> 'rm -f drivers/net/wireguard/main.o
> ; trap - QUIT; kill -s QUIT $$' QUIT;  trap 'rm -f
> drivers/net/wireguard/main.o; trap - TERM; kill -s TERM $$' TERM; trap
> 'rm -f drivers/net/wireguard/main.o; trap - PIPE; kill -s PIPE $$' PIPE;
> printf '\n%s\n' 'saved_c_flag
> s_drivers/net/wireguard/main.o :=3D -D__KERNEL__ --target=3Dx86_64-linux-=
gnu
> -fintegrated-as -Werror=3Dignored-optimization-argument
> -Werror=3Doption-ignored -std=3Dgnu11 -fshort-wchar -funsigned-char
> -fno-common -fno-PIE -fno-strict-a
> liasing -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
> -fcf-protection=3Dbranch -fno-jump-tables -m64 -falign-loops=3D1 -mno-803=
87
> -mno-fp-ret-in-387 -mstack-alignment=3D8 -mskip-rax-setup -march=3Dznver4
> -mno-red-zone -mcmodel=3Dkern
> el -mstack-protector-guard-reg=3Dgs
> -mstack-protector-guard-symbol=3D__ref_stack_chk_guard -Wno-sign-compare
> -fno-asynchronous-unwind-tables -mretpoline-external-thunk
> -mindirect-branch-cs-prefix -mfunction-return=3Dthunk-extern -m
> harden-sls=3Dall -fpatchable-function-entry=3D16,16
> -fno-delete-null-pointer-checks -O3 -fstack-protector-strong
> -ftrivial-auto-var-init=3Dzero -fno-stack-clash-protection -pg -mfentry
> -DCC_USING_NOP_MCOUNT -DCC_USING_FENTRY -fno-l
> to -flto=3Dthin -fsplit-lto-unit -fvisibility=3Dhidden -falign-functions=
=3D16
> -fstrict-flex-arrays=3D3 -fno-strict-overflow -fno-stack-check
> -fno-builtin-wcslen -Wall -Wextra -Wundef
> -Werror=3Dimplicit-function-declaration -Werror=3Dimpl
> icit-int -Werror=3Dreturn-type -Wno-format-security -Wno-trigraphs
> -Wno-frame-address -Wno-address-of-packed-member -Wmissing-declarations
> -Wmissing-prototypes -Wframe-larger-than=3D2048 -Wno-gnu
> -Wno-format-overflow-non-kprintf
> -Wno-format-truncation-non-kprintf -Wno-default-const-init-unsafe
> -Wno-pointer-sign -Wcast-function-type
> -Wno-unterminated-string-initialization -Wimplicit-fallthrough
> -Werror=3Ddate-time -Wenum-conversion -Wunused -Wno-unused-
> but-set-variable -Wno-unused-const-variable -Wno-format-overflow
> -Wno-override-init -Wno-pointer-to-enum-cast
> -Wno-tautological-constant-out-of-range-compare -Wno-unaligned-access
> -Wno-enum-compare-conditional -Wno-missing-fi
> eld-initializers -Wno-type-limits -Wno-shift-negative-value
> -Wno-enum-enum-conversion -Wno-sign-compare -Wno-unused-parameter -g
> -gdwarf-5 -D'pr_fmt(fmt)=3DKBUILD_MODNAME ": " fmt'' >>
> drivers/net/wireguard/.main.o.cmd'
> make[5]: *** [scripts/Makefile.build:287: drivers/net/wireguard/main.o]
> Error 2
> make[5]: *** Deleting file 'drivers/net/wireguard/main.o'
> make[4]: *** [scripts/Makefile.build:556: drivers/net/wireguard] Error 2
>
> LLVM/CLANG: 21.1.4
>
> If necessary, I can send more logs.
>
> Best regards,
>
> Piotr
>
> W dniu 27.10.2025 o 23:09, xur@google.com pisze:
> > From: Rong Xu <xur@google.com>
> >
> > This V4 is based on the reimplementation provided by Masahiro Yamada
> > on May 26. The difference is that this version now saves the compiler
> > flags (_c_flags) from the Front-End (FE) compilation and re-uses them
> > for the subsequent Back-End (BE) compilation.
> >
> > Rong Xu (2):
> >    kbuild: move vmlinux.a build rule to scripts/Makefile.vmlinux_a
> >    kbuild: distributed build support for Clang ThinLTO
> >
> >   .gitignore                 |  2 +
> >   Makefile                   | 25 +++++-------
> >   arch/Kconfig               | 19 +++++++++
> >   scripts/Makefile.lib       |  7 ++++
> >   scripts/Makefile.thinlto   | 40 ++++++++++++++++++
> >   scripts/Makefile.vmlinux_a | 83 +++++++++++++++++++++++++++++++++++++=
+
> >   scripts/mod/modpost.c      | 15 +++++--
> >   7 files changed, 174 insertions(+), 17 deletions(-)
> >   create mode 100644 scripts/Makefile.thinlto
> >   create mode 100644 scripts/Makefile.vmlinux_a
> >
> >
> > base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa

