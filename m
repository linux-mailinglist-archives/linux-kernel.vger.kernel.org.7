Return-Path: <linux-kernel+bounces-852014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55006BD7F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE77E427FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880892D8DAF;
	Tue, 14 Oct 2025 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCiTwd0U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACAD30E835
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427201; cv=none; b=UpulPuXhhSlbiH8eBfGz+p4d6wePxS5kUoNN+BniX+R9ZqjRWkVLUxQLJvyENonjsOIPDE2eQmoWsPK9efBYtw9QE0Y3PwIyB7lnKOJw+ZZIq+opGLV/QiZTK3GNfnvmcZt7Xxl4W/TIWXFcW+GNaygLh4TbCtmpnw+uDl4Ci6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427201; c=relaxed/simple;
	bh=cH5DIwFsVy6Nw8TwJb1Z+ejcHY8Vpyz3tBKZIv6CZvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMPdQSuzw/M+/mKYtbbyQ+UQsuJIKWg3kt2swSLY1r0rZ8UAAW7bvFn1ONPQSer7gGX0mNTXLT2crOqbh3/dG/zvUSf2/ETM1VyjIO3wOkRb0tHM105ZCod/JjdSzP61BqQt/MzpIRFUZ1ZdVXd+5cIbJv0Ukfj+27dadErHH+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCiTwd0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F397C116D0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760427201;
	bh=cH5DIwFsVy6Nw8TwJb1Z+ejcHY8Vpyz3tBKZIv6CZvs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SCiTwd0Up3vnEw2qS5wfZwbgv9dab+XHfWUv7c9ia1VoYi3x3nG38DB2osDlDxCao
	 wsnliE1L9V3SuC8ZbtGXXsKjCfuC7LvE6l258ZCUmcFbpZwJBbiCDIM5ua7BAiCVoL
	 Qbqs2i6nx5OIsskivnfmA/e+fVsQulQzyQfhtSE1BmbU7/OSPQEw7wJVRdXP8mhAW2
	 tR6LC5CPIEMM55OzpWLDEYh4inS8YZzoyh1Uu2lvkmAC+H4h4nkdPtHz6aDgowOVlI
	 iA1uX189kKcyXiCcyF7XVnj2jOUtF/+80rng3L1Y9aQs8ErggIl5q+phuOskfPo1U9
	 741YMq2gj+upQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3627a1979a0so3490168fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:33:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqpX6TCqd8QqQOc9Zgq9ux3x8qhxmibxI2ny2BwY2JpJd2kRVXHOV27cq0RZWZGY03lIeeRFGgydRFptA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxepL3XLE3ezLfOot3Kum84e6uE+Wic+UTMg6bMDQr0oXOy6SU5
	yzBzztSfbp0nacVLcvIxov8fT/dzSYQV4di8y2kNaLCUuhFMfO+C+YbOMqpMaqeIVOBUNISi+BL
	GfTN61tBoeVMXso/NGilJusRWlAdQwAo=
X-Google-Smtp-Source: AGHT+IEVzJJLhlo+ge61CBtv2HNYJfWVk5+8m0W9vSDO6yAaFjugC+feiJ+wT8OgVbcCjfcOjcc6zRAa+JGqSIDZyyk=
X-Received: by 2002:a05:6870:70a7:b0:381:e796:fbdd with SMTP id
 586e51a60fabf-3c0f8db730dmr13485981fac.35.1760427200600; Tue, 14 Oct 2025
 00:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f80021c8-f8e1-9ed2-4791-705c4d7b7b8a@redhat.com>
In-Reply-To: <f80021c8-f8e1-9ed2-4791-705c4d7b7b8a@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 14 Oct 2025 09:33:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHsiSB6aQVhqTbS0vhcEgk0TpP+4bxzSA5T0s6WrK2ZjQ@mail.gmail.com>
X-Gm-Features: AS18NWDIakW39j6DvQPonyPRzolkq_4roZLA308ca2ajlGiqeuyh2W7vkUyhWu4
Message-ID: <CAMj1kXHsiSB6aQVhqTbS0vhcEgk0TpP+4bxzSA5T0s6WrK2ZjQ@mail.gmail.com>
Subject: Re: [PATCH] objtool: fix failure when being compiled on x32 system
To: Mikulas Patocka <mpatocka@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(cc lkml)

On Mon, 13 Oct 2025 at 22:21, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> Fix compilation failure when compiling the kernel with the x32 toolchain.
>
> In file included from check.c:16:
> check.c: In function =E2=80=98check_abs_references=E2=80=99:
> /usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:47:17: error:=
 format =E2=80=98%lx=E2=80=99 expects argument of type =E2=80=98long unsign=
ed int=E2=80=99, but argument 7 has type =E2=80=98u64=E2=80=99 {aka =E2=80=
=98long
> long unsigned int=E2=80=99} [-Werror=3Dformat=3D]
>    47 |                 "%s%s%s: objtool" extra ": " format "\n",        =
       \
>       |                 ^~~~~~~~~~~~~~~~~
> /usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:54:9: note: i=
n expansion of macro =E2=80=98___WARN=E2=80=99
>    54 |         ___WARN(severity, "", format, ##__VA_ARGS__)
>       |         ^~~~~~~
> /usr/src/git/linux-2.6/tools/objtool/include/objtool/warn.h:74:27: note: =
in expansion of macro =E2=80=98__WARN=E2=80=99
>    74 | #define WARN(format, ...) __WARN(WARN_STR, format, ##__VA_ARGS__)
>       |                           ^~~~~~
> check.c:4713:33: note: in expansion of macro =E2=80=98WARN=E2=80=99
>  4713 |                                 WARN("section %s has absolute rel=
ocation at offset 0x%lx",
>       |                                 ^~~~
>
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Fixes: 0d6e4563fc03 ("objtool: Add action to check for absence of absolut=
e relocations")
>
> ---
>  tools/objtool/check.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: linux-2.6/tools/objtool/check.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/tools/objtool/check.c        2025-10-13 21:42:48.00000=
0000 +0200
> +++ linux-2.6/tools/objtool/check.c     2025-10-13 21:48:33.000000000 +02=
00
> @@ -4710,8 +4710,8 @@ static int check_abs_references(struct o
>
>                 for_each_reloc(sec->rsec, reloc) {
>                         if (arch_absolute_reloc(file->elf, reloc)) {
> -                               WARN("section %s has absolute relocation =
at offset 0x%lx",
> -                                    sec->name, reloc_offset(reloc));
> +                               WARN("section %s has absolute relocation =
at offset 0x%llx",
> +                                    sec->name, (unsigned long long)reloc=
_offset(reloc));
>                                 ret++;
>                         }
>                 }

Acked-by: Ard Biesheuvel <ardb@kernel.org>

