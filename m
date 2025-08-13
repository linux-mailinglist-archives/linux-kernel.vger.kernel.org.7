Return-Path: <linux-kernel+bounces-767680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3985B2579C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE825A449A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131582F60D4;
	Wed, 13 Aug 2025 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fo44jUDO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C134C81;
	Wed, 13 Aug 2025 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127968; cv=none; b=J4W3lL1E73fdM60GKwDawhxNUTAdNNGuWn2IkCgpGm+k0oZLcEJWepv+dj6a+mYfdVL+o7Kd4j+vvEGAmNAlNYrsPHoqdVy0BdRwYkCRCgoOzuJUP0Zb/n1ESal6ymskDvW/ONd4cPVAgyjup+kkDK56Q0XPmNaQuOsBSPugbTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127968; c=relaxed/simple;
	bh=eWXNfRA8jH9kqmgUuTBes6szpto1H6c4q+ww/qlIhjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3Dlaztx14iRsEi0XuHqgvDJSnNL0ZbIGtzuPElxevlyBegqkG47kStNJUP5dO0F0nxaQWW0GwYVeiWh0+NJIenrjsydevHofiCSdXa7av+3+knuH7oxTeG+/L3ORr6UFH0swQCKQojsum2pnwNudgokSzjF8/z5g6n1InEn1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fo44jUDO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE64AC4CEEB;
	Wed, 13 Aug 2025 23:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755127967;
	bh=eWXNfRA8jH9kqmgUuTBes6szpto1H6c4q+ww/qlIhjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fo44jUDOUUSsjFmWRtSVsZsVMr1AsGxnlTQ0ofXruLeB85BhPVc4PQm1IFq87nmU1
	 CFA8ia3Pd8b8kZ6kwP0KaFulBe9SWB35diRnCKE5jK6/cB84bbMbKXdE6WT8kVAEus
	 6+PBkogPqlVf1Ll+TzJVfp6fjeyIfi8cvQUr1hPu4XOqymU3SQOYqtU2chg2+okzNs
	 h0WHcRgbtzz/nIrPyLkXL7eA+pv01ZyC4C/gReG5dQ2jD3YjxwTtEcz1eHSApsqQHK
	 SxKfl0gt9EOmn/vvb9mlz9D7zTq66Y/8We9R52+vbRt4YoIYzVhpVSCQqbj+6SMkGI
	 OVVc0xjIwmj+Q==
Date: Thu, 14 Aug 2025 01:32:44 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 09/13] docs: move parse-headers.pl to tools/doc
Message-ID: <20250814013244.1297f3d5@foz.lan>
In-Reply-To: <20250813213218.198582-10-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-10-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Wed, 13 Aug 2025 15:32:08 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Move the tool and fix all the references, including the numerous ones that
> said "parse_headers" instead of "parse-headers".

This will conflict with my series getting converting it to Python.

I prefer if you don't merge this one.


>=20
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/doc-guide/parse-headers.rst                   | 6 +++---
>  .../translations/it_IT/doc-guide/parse-headers.rst          | 6 +++---
>  .../translations/zh_CN/doc-guide/parse-headers.rst          | 6 +++---
>  Documentation/userspace-api/media/Makefile                  | 2 +-
>  MAINTAINERS                                                 | 1 -
>  {Documentation/sphinx =3D> tools/doc}/parse-headers.pl        | 4 ++--
>  6 files changed, 12 insertions(+), 13 deletions(-)
>  rename {Documentation/sphinx =3D> tools/doc}/parse-headers.pl (98%)
>=20
> diff --git a/Documentation/doc-guide/parse-headers.rst b/Documentation/do=
c-guide/parse-headers.rst
> index 204b025f1349..954cd81523a0 100644
> --- a/Documentation/doc-guide/parse-headers.rst
> +++ b/Documentation/doc-guide/parse-headers.rst
> @@ -15,14 +15,14 @@ about how to use it inside the Kernel tree.
> =20
>  .. _parse_headers:
> =20
> -parse_headers.pl
> +parse-headers.pl
>  ^^^^^^^^^^^^^^^^
> =20
>  NAME
>  ****
> =20
> =20
> -parse_headers.pl - parse a C file, in order to identify functions, struc=
ts,
> +parse-headers.pl - parse a C file, in order to identify functions, struc=
ts,
>  enums and defines and create cross-references to a Sphinx book.
> =20
> =20
> @@ -30,7 +30,7 @@ SYNOPSIS
>  ********
> =20
> =20
> -\ **parse_headers.pl**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FI=
LE>]
> +\ **parse-headers.pl**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FI=
LE>]
> =20
>  Where <options> can be: --debug, --help or --usage.
> =20
> diff --git a/Documentation/translations/it_IT/doc-guide/parse-headers.rst=
 b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
> index 026a23e49767..45b6b6fc4fb5 100644
> --- a/Documentation/translations/it_IT/doc-guide/parse-headers.rst
> +++ b/Documentation/translations/it_IT/doc-guide/parse-headers.rst
> @@ -20,21 +20,21 @@ consultate ``Documentation/userspace-api/media/Makefi=
le``.
> =20
>  .. _it_parse_headers:
> =20
> -parse_headers.pl
> +parse-headers.pl
>  ^^^^^^^^^^^^^^^^
> =20
>  NOME
>  ****
> =20
> =20
> -parse_headers.pl - analizza i file C al fine di identificare funzioni,
> +parse-headers.pl - analizza i file C al fine di identificare funzioni,
>  strutture, enumerati e definizioni, e creare riferimenti per Sphinx
> =20
>  SINTASSI
>  ********
> =20
> =20
> -\ **parse_headers.pl**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FI=
LE>]
> +\ **parse-headers.pl**\  [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FI=
LE>]
> =20
>  Dove <options> pu=C3=B2 essere: --debug, --usage o --help.
> =20
> diff --git a/Documentation/translations/zh_CN/doc-guide/parse-headers.rst=
 b/Documentation/translations/zh_CN/doc-guide/parse-headers.rst
> index a08819e904ed..22253fea5da1 100644
> --- a/Documentation/translations/zh_CN/doc-guide/parse-headers.rst
> +++ b/Documentation/translations/zh_CN/doc-guide/parse-headers.rst
> @@ -19,14 +19,14 @@ Sphinx=E5=B0=86=E7=94=9F=E6=88=90=E8=AD=A6=E5=91=8A=
=E3=80=82=E8=BF=99=E6=9C=89=E5=8A=A9=E4=BA=8E=E4=BF=9D=E6=8C=81=E7=94=A8=E6=
=88=B7=E7=A9=BA=E9=97=B4API=E6=96=87=E6=A1=A3=E4=B8=8E=E5=86=85=E6=A0=B8=E6=
=9B=B4=E6=94=B9
> =20
>  .. _parse_headers_zh:
> =20
> -parse_headers.pl
> +parse-headers.pl
>  ----------------
> =20
>  =E8=84=9A=E6=9C=AC=E5=90=8D=E7=A7=B0
>  ~~~~~~~~
> =20
> =20
> -parse_headers.pl=E2=80=94=E2=80=94=E8=A7=A3=E6=9E=90=E4=B8=80=E4=B8=AAC=
=E6=96=87=E4=BB=B6=EF=BC=8C=E8=AF=86=E5=88=AB=E5=87=BD=E6=95=B0=E3=80=81=E7=
=BB=93=E6=9E=84=E4=BD=93=E3=80=81=E6=9E=9A=E4=B8=BE=E3=80=81=E5=AE=9A=E4=B9=
=89=E5=B9=B6=E5=AF=B9Sphinx=E6=96=87=E6=A1=A3
> +parse-headers.pl=E2=80=94=E2=80=94=E8=A7=A3=E6=9E=90=E4=B8=80=E4=B8=AAC=
=E6=96=87=E4=BB=B6=EF=BC=8C=E8=AF=86=E5=88=AB=E5=87=BD=E6=95=B0=E3=80=81=E7=
=BB=93=E6=9E=84=E4=BD=93=E3=80=81=E6=9E=9A=E4=B8=BE=E3=80=81=E5=AE=9A=E4=B9=
=89=E5=B9=B6=E5=AF=B9Sphinx=E6=96=87=E6=A1=A3
>  =E5=88=9B=E5=BB=BA=E4=BA=A4=E5=8F=89=E5=BC=95=E7=94=A8=E3=80=82
> =20
> =20
> @@ -34,7 +34,7 @@ parse_headers.pl=E2=80=94=E2=80=94=E8=A7=A3=E6=9E=90=E4=
=B8=80=E4=B8=AAC=E6=96=87=E4=BB=B6=EF=BC=8C=E8=AF=86=E5=88=AB=E5=87=BD=E6=
=95=B0=E3=80=81=E7=BB=93=E6=9E=84=E4=BD=93=E3=80=81=E6=9E=9A=E4=B8=BE=E3=80=
=81
>  ~~~~~~~~
> =20
> =20
> -\ **parse_headers.pl**\  [<=E9=80=89=E9=A1=B9>] <C=E6=96=87=E4=BB=B6> <=
=E8=BE=93=E5=87=BA=E6=96=87=E4=BB=B6> [<=E4=BE=8B=E5=A4=96=E6=96=87=E4=BB=
=B6>]
> +\ **parse-headers.pl**\  [<=E9=80=89=E9=A1=B9>] <C=E6=96=87=E4=BB=B6> <=
=E8=BE=93=E5=87=BA=E6=96=87=E4=BB=B6> [<=E4=BE=8B=E5=A4=96=E6=96=87=E4=BB=
=B6>]
> =20
>  <=E9=80=89=E9=A1=B9> =E5=8F=AF=E4=BB=A5=E6=98=AF=EF=BC=9A --debug, --hel=
p =E6=88=96 --usage =E3=80=82
> =20
> diff --git a/Documentation/userspace-api/media/Makefile b/Documentation/u=
serspace-api/media/Makefile
> index 3d8aaf5c253b..632798bca615 100644
> --- a/Documentation/userspace-api/media/Makefile
> +++ b/Documentation/userspace-api/media/Makefile
> @@ -3,7 +3,7 @@
>  # Rules to convert a .h file to inline RST documentation
> =20
>  SRC_DIR=3D$(srctree)/Documentation/userspace-api/media
> -PARSER =3D $(srctree)/Documentation/sphinx/parse-headers.pl
> +PARSER =3D $(srctree)/tools/doc/parse-headers.pl
>  UAPI =3D $(srctree)/include/uapi/linux
>  KAPI =3D $(srctree)/include/linux
> =20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2f1374130240..c2d2ce92bf79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7338,7 +7338,6 @@ DOCUMENTATION SCRIPTS
>  M:	Mauro Carvalho Chehab <mchehab@kernel.org>
>  L:	linux-doc@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/sphinx/parse-headers.pl
>  F:	tools/doc/
> =20
>  DOCUMENTATION/ITALIAN
> diff --git a/Documentation/sphinx/parse-headers.pl b/tools/doc/parse-head=
ers.pl
> similarity index 98%
> rename from Documentation/sphinx/parse-headers.pl
> rename to tools/doc/parse-headers.pl
> index 7b1458544e2e..47b90bf8c96d 100755
> --- a/Documentation/sphinx/parse-headers.pl
> +++ b/tools/doc/parse-headers.pl
> @@ -340,12 +340,12 @@ __END__
> =20
>  =3Dhead1 NAME
> =20
> -parse_headers.pl - parse a C file, in order to identify functions, struc=
ts,
> +parse-headers.pl - parse a C file, in order to identify functions, struc=
ts,
>  enums and defines and create cross-references to a Sphinx book.
> =20
>  =3Dhead1 SYNOPSIS
> =20
> -B<parse_headers.pl> [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
> +B<parse-headers.pl> [<options>] <C_FILE> <OUT_FILE> [<EXCEPTIONS_FILE>]
> =20
>  Where <options> can be: --debug, --help or --usage.
> =20



Thanks,
Mauro

