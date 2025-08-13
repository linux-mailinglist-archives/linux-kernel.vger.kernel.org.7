Return-Path: <linux-kernel+bounces-767682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828BDB257A1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3878F3AB274
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A272B19D082;
	Wed, 13 Aug 2025 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KriPv9+Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79C2F60B3;
	Wed, 13 Aug 2025 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755128038; cv=none; b=RQ9uyNul5e4q0l0+U9fg/6OV1Agr2yWPfUOLD4e57+AVLldcP9moELzCvaPt70UD5V7lzvvLxThJRhZtN9F+B1GSvRUenXvog8eCdxXTgDfQlEMYQWfG5k2a31aySngHc6tvtaaY19X6+r+5X9AMAZjbrNCZkE5kh0DQy/pyPWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755128038; c=relaxed/simple;
	bh=/fqav50fh/UHsLl/cNli+s8eynjv05qGf9V1vrShBpY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0aMpQED+119oadwLjS5db3nn07+sHVJymLmLNKphUS4k4YtqNU9pXeaNdQhcCxKgBcWInttI9+igZpZEbeCpIu5AI4oDY7xCXvucm/uuwjsMFIausuyuaYpIo23qapDu20TSUIQlxHKyY8G7wVpZ4g32yBWf0lP0cRE14s9gqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KriPv9+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDFC5C4CEEB;
	Wed, 13 Aug 2025 23:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755128037;
	bh=/fqav50fh/UHsLl/cNli+s8eynjv05qGf9V1vrShBpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KriPv9+YVV0HN+uI0MISCd02QP6gQHWFzIz4C8HmiHUs1OQsMJEwtfkS0YaQ6ULrq
	 VD/w0o/1WkG6iY+f1h7o4nTLRoO+vaKilRasx9/ZgKfkl2jB+cnLKbNSgHTkWN5BR2
	 AbOCv8UjtDZs2ORCB/WRYrM1imX9qjG5jloGM0q3/DJIsKnRI8JyupaQVn41Y2Ycd5
	 sJi69ZAKFuq4ERaVhjM6qtSkuiuWo+02YONXDKVvkBNtMIy69fn2wNo0XqCReIHQTJ
	 1kzHESaLqJaKRdCmmC9zfPsbRsa6IIZu69Ll1T9jZAZh9feIqQ/BATLEbmo1AT1ly4
	 b2jMLJ1tV0dag==
Date: Thu, 14 Aug 2025 01:33:53 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 10/13] docs: move kernel-doc to tools/doc
Message-ID: <20250814013353.623b20c8@foz.lan>
In-Reply-To: <20250813213218.198582-11-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-11-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Wed, 13 Aug 2025 15:32:09 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Move kernel-doc to join the rest of the tools, and update references
> throughout the tree.
>=20

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/conf.py                                |  2 +-
>  Documentation/doc-guide/kernel-doc.rst               | 12 ++++++------
>  Documentation/kbuild/kbuild.rst                      |  2 +-
>  Documentation/process/coding-style.rst               |  2 +-
>  .../translations/it_IT/doc-guide/kernel-doc.rst      |  8 ++++----
>  .../translations/sp_SP/process/coding-style.rst      |  2 +-
>  .../translations/zh_CN/doc-guide/kernel-doc.rst      | 10 +++++-----
>  Documentation/translations/zh_CN/kbuild/kbuild.rst   |  2 +-
>  .../translations/zh_CN/process/coding-style.rst      |  2 +-
>  .../translations/zh_TW/process/coding-style.rst      |  2 +-
>  MAINTAINERS                                          |  1 -
>  Makefile                                             |  2 +-
>  drivers/gpu/drm/i915/Makefile                        |  2 +-
>  scripts/find-unused-docs.sh                          |  2 +-
>  scripts/kernel-doc                                   |  1 -
>  scripts/kernel-doc.py =3D> tools/doc/kernel-doc        |  0
>  16 files changed, 25 insertions(+), 27 deletions(-)
>  delete mode 120000 scripts/kernel-doc
>  rename scripts/kernel-doc.py =3D> tools/doc/kernel-doc (100%)
>=20
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index f9828f3862f9..600cf5d32af8 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -564,7 +564,7 @@ pdf_documents =3D [
>  # kernel-doc extension configuration for running Sphinx directly (e.g. b=
y Read
>  # the Docs). In a normal build, these are supplied from the Makefile via=
 command
>  # line arguments.
> -kerneldoc_bin =3D "../scripts/kernel-doc.py"
> +kerneldoc_bin =3D "../tools/doc/kernel-doc.py"
>  kerneldoc_srctree =3D ".."
> =20
>  # ----------------------------------------------------------------------=
--------
> diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-g=
uide/kernel-doc.rst
> index af9697e60165..6fc89d444ada 100644
> --- a/Documentation/doc-guide/kernel-doc.rst
> +++ b/Documentation/doc-guide/kernel-doc.rst
> @@ -54,7 +54,7 @@ Running the ``kernel-doc`` tool with increased verbosit=
y and without actual
>  output generation may be used to verify proper formatting of the
>  documentation comments. For example::
> =20
> -	scripts/kernel-doc -v -none drivers/foo/bar.c
> +	tools/doc/kernel-doc -v -none drivers/foo/bar.c
> =20
>  The documentation format is verified by the kernel build when it is
>  requested to perform extra gcc checks::
> @@ -349,7 +349,7 @@ differentiated by whether the macro name is immediate=
ly followed by a
>  left parenthesis ('(') for function-like macros or not followed by one
>  for object-like macros.
> =20
> -Function-like macros are handled like functions by ``scripts/kernel-doc`=
`.
> +Function-like macros are handled like functions by ``tools/doc/kernel-do=
c``.
>  They may have a parameter list. Object-like macros have do not have a
>  parameter list.
> =20
> @@ -571,7 +571,7 @@ from the source file.
> =20
>  The kernel-doc extension is included in the kernel source tree, at
>  ``Documentation/sphinx/kerneldoc.py``. Internally, it uses the
> -``scripts/kernel-doc`` script to extract the documentation comments from=
 the
> +``tools/doc/kernel-doc`` script to extract the documentation comments fr=
om the
>  source.
> =20
>  .. _kernel_doc:
> @@ -582,17 +582,17 @@ How to use kernel-doc to generate man pages
>  If you just want to use kernel-doc to generate man pages you can do this
>  from the kernel git tree::
> =20
> -  $ scripts/kernel-doc -man \
> +  $ tools/doc/kernel-doc -man \
>      $(git grep -l '/\*\*' -- :^Documentation :^tools) \
>      | scripts/split-man.pl /tmp/man
> =20
>  Some older versions of git do not support some of the variants of syntax=
 for
>  path exclusion.  One of the following commands may work for those versio=
ns::
> =20
> -  $ scripts/kernel-doc -man \
> +  $ tools/doc/kernel-doc -man \
>      $(git grep -l '/\*\*' -- . ':!Documentation' ':!tools') \
>      | scripts/split-man.pl /tmp/man
> =20
> -  $ scripts/kernel-doc -man \
> +  $ tools/doc/kernel-doc -man \
>      $(git grep -l '/\*\*' -- . ":(exclude)Documentation" ":(exclude)tool=
s") \
>      | scripts/split-man.pl /tmp/man
> diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuil=
d.rst
> index 3388a10f2dcc..ae7b0669e3ec 100644
> --- a/Documentation/kbuild/kbuild.rst
> +++ b/Documentation/kbuild/kbuild.rst
> @@ -180,7 +180,7 @@ architecture.
>  KDOCFLAGS
>  ---------
>  Specify extra (warning/error) flags for kernel-doc checks during the bui=
ld,
> -see scripts/kernel-doc for which flags are supported. Note that this doe=
sn't
> +see tools/doc/kernel-doc for which flags are supported. Note that this d=
oesn't
>  (currently) apply to documentation builds.
> =20
>  ARCH
> diff --git a/Documentation/process/coding-style.rst b/Documentation/proce=
ss/coding-style.rst
> index d1a8e5465ed9..b2d16449a27b 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -614,7 +614,7 @@ it.
> =20
>  When commenting the kernel API functions, please use the kernel-doc form=
at.
>  See the files at :ref:`Documentation/doc-guide/ <doc_guide>` and
> -``scripts/kernel-doc`` for details. Note that the danger of over-comment=
ing
> +``tools/doc/kernel-doc`` for details. Note that the danger of over-comme=
nting
>  applies to kernel-doc comments all the same. Do not add boilerplate
>  kernel-doc which simply reiterates what's obvious from the signature
>  of the function.
> diff --git a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst b/=
Documentation/translations/it_IT/doc-guide/kernel-doc.rst
> index aa0e31d353d6..05ea0f03c80b 100644
> --- a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
> +++ b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
> @@ -80,7 +80,7 @@ Al fine di verificare che i commenti siano formattati c=
orrettamente, potete
>  eseguire il programma ``kernel-doc`` con un livello di verbosit=C3=A0 al=
to e senza
>  che questo produca alcuna documentazione. Per esempio::
> =20
> -	scripts/kernel-doc -v -none drivers/foo/bar.c
> +	tools/doc/kernel-doc -v -none drivers/foo/bar.c
> =20
>  Il formato della documentazione =C3=A8 verificato della procedura di gen=
erazione
>  del kernel quando viene richiesto di effettuare dei controlli extra con =
GCC::
> @@ -378,7 +378,7 @@ distinguono in base al fatto che il nome della macro =
simile a funzione sia
>  immediatamente seguito da una parentesi sinistra ('(') mentre in quelle =
simili a
>  oggetti no.
> =20
> -Le macro simili a funzioni sono gestite come funzioni da ``scripts/kerne=
l-doc``.
> +Le macro simili a funzioni sono gestite come funzioni da ``tools/doc/ker=
nel-doc``.
>  Possono avere un elenco di parametri. Le macro simili a oggetti non hann=
o un
>  elenco di parametri.
> =20
> @@ -595,7 +595,7 @@ documentazione presenti nel file sorgente (*source*).
> =20
>  L'estensione kernel-doc fa parte dei sorgenti del kernel, la si pu=C3=B2=
 trovare
>  in ``Documentation/sphinx/kerneldoc.py``. Internamente, viene utilizzato
> -lo script ``scripts/kernel-doc`` per estrarre i commenti di documentazio=
ne
> +lo script ``tools/doc/kernel-doc`` per estrarre i commenti di documentaz=
ione
>  dai file sorgenti.
> =20
>  Come utilizzare kernel-doc per generare pagine man
> @@ -604,4 +604,4 @@ Come utilizzare kernel-doc per generare pagine man
>  Se volete utilizzare kernel-doc solo per generare delle pagine man, pote=
te
>  farlo direttamente dai sorgenti del kernel::
> =20
> -  $ scripts/kernel-doc -man $(git grep -l '/\*\*' -- :^Documentation :^t=
ools) | scripts/split-man.pl /tmp/man
> +  $ tools/doc/kernel-doc -man $(git grep -l '/\*\*' -- :^Documentation :=
^tools) | scripts/split-man.pl /tmp/man
> diff --git a/Documentation/translations/sp_SP/process/coding-style.rst b/=
Documentation/translations/sp_SP/process/coding-style.rst
> index 025223be9706..73c43b49480f 100644
> --- a/Documentation/translations/sp_SP/process/coding-style.rst
> +++ b/Documentation/translations/sp_SP/process/coding-style.rst
> @@ -633,7 +633,7 @@ posiblemente POR QU=C3=89 hace esto.
> =20
>  Al comentar las funciones de la API del kernel, utilice el formato
>  kernel-doc. Consulte los archivos en :ref:`Documentation/doc-guide/ <doc=
_guide>`
> -y ``scripts/kernel-doc`` para m=C3=A1s detalles.
> +y ``tools/doc/kernel-doc`` para m=C3=A1s detalles.
> =20
>  El estilo preferido para comentarios largos (de varias l=C3=ADneas) es:
> =20
> diff --git a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst b/=
Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
> index ccfb9b8329c2..b242e52f911c 100644
> --- a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
> +++ b/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
> @@ -43,7 +43,7 @@ kernel-doc=E6=B3=A8=E9=87=8A=E7=94=A8 ``/**`` =E4=BD=9C=
=E4=B8=BA=E5=BC=80=E5=A7=8B=E6=A0=87=E8=AE=B0=E3=80=82 ``kernel-doc`` =E5=
=B7=A5=E5=85=B7=E5=B0=86=E6=8F=90=E5=8F=96
>  =E7=94=A8=E8=AF=A6=E7=BB=86=E6=A8=A1=E5=BC=8F=E5=92=8C=E4=B8=8D=E7=94=9F=
=E6=88=90=E5=AE=9E=E9=99=85=E8=BE=93=E5=87=BA=E6=9D=A5=E8=BF=90=E8=A1=8C ``=
kernel-doc`` =E5=B7=A5=E5=85=B7=EF=BC=8C=E5=8F=AF=E4=BB=A5=E9=AA=8C=E8=AF=
=81=E6=96=87=E6=A1=A3=E6=B3=A8=E9=87=8A=E7=9A=84=E6=A0=BC=E5=BC=8F
>  =E6=98=AF=E5=90=A6=E6=AD=A3=E7=A1=AE=E3=80=82=E4=BE=8B=E5=A6=82::
> =20
> -	scripts/kernel-doc -v -none drivers/foo/bar.c
> +	tools/doc/kernel-doc -v -none drivers/foo/bar.c
> =20
>  =E5=BD=93=E8=AF=B7=E6=B1=82=E6=89=A7=E8=A1=8C=E9=A2=9D=E5=A4=96=E7=9A=84=
gcc=E6=A3=80=E6=9F=A5=E6=97=B6=EF=BC=8C=E5=86=85=E6=A0=B8=E6=9E=84=E5=BB=BA=
=E5=B0=86=E9=AA=8C=E8=AF=81=E6=96=87=E6=A1=A3=E6=A0=BC=E5=BC=8F::
> =20
> @@ -473,7 +473,7 @@ doc: *title*
>  =E5=A6=82=E6=9E=9C=E6=B2=A1=E6=9C=89=E9=80=89=E9=A1=B9=EF=BC=8Ckernel-do=
c=E6=8C=87=E4=BB=A4=E5=B0=86=E5=8C=85=E5=90=AB=E6=BA=90=E6=96=87=E4=BB=B6=
=E4=B8=AD=E7=9A=84=E6=89=80=E6=9C=89=E6=96=87=E6=A1=A3=E6=B3=A8=E9=87=8A=E3=
=80=82
> =20
>  kernel-doc=E6=89=A9=E5=B1=95=E5=8C=85=E5=90=AB=E5=9C=A8=E5=86=85=E6=A0=
=B8=E6=BA=90=E4=BB=A3=E7=A0=81=E6=A0=91=E4=B8=AD=EF=BC=8C=E4=BD=8D=E4=BA=8E=
 ``Documentation/sphinx/kerneldoc.py`` =E3=80=82
> -=E5=9C=A8=E5=86=85=E9=83=A8=EF=BC=8C=E5=AE=83=E4=BD=BF=E7=94=A8 ``script=
s/kernel-doc`` =E8=84=9A=E6=9C=AC=E4=BB=8E=E6=BA=90=E4=BB=A3=E7=A0=81=E4=B8=
=AD=E6=8F=90=E5=8F=96=E6=96=87=E6=A1=A3=E6=B3=A8=E9=87=8A=E3=80=82
> +=E5=9C=A8=E5=86=85=E9=83=A8=EF=BC=8C=E5=AE=83=E4=BD=BF=E7=94=A8 ``tools/=
doc/kernel-doc`` =E8=84=9A=E6=9C=AC=E4=BB=8E=E6=BA=90=E4=BB=A3=E7=A0=81=E4=
=B8=AD=E6=8F=90=E5=8F=96=E6=96=87=E6=A1=A3=E6=B3=A8=E9=87=8A=E3=80=82
> =20
>  .. _kernel_doc_zh:
> =20
> @@ -482,18 +482,18 @@ kernel-doc=E6=89=A9=E5=B1=95=E5=8C=85=E5=90=AB=E5=
=9C=A8=E5=86=85=E6=A0=B8=E6=BA=90=E4=BB=A3=E7=A0=81=E6=A0=91=E4=B8=AD=EF=BC=
=8C=E4=BD=8D=E4=BA=8E ``Documentation/sphinx/k
> =20
>  =E5=A6=82=E6=9E=9C=E6=82=A8=E5=8F=AA=E6=83=B3=E4=BD=BF=E7=94=A8kernel-do=
c=E7=94=9F=E6=88=90=E6=89=8B=E5=86=8C=E9=A1=B5=EF=BC=8C=E5=8F=AF=E4=BB=A5=
=E4=BB=8E=E5=86=85=E6=A0=B8git=E6=A0=91=E8=BF=99=E6=A0=B7=E5=81=9A::
> =20
> -  $ scripts/kernel-doc -man \
> +  $ tools/doc/kernel-doc -man \
>      $(git grep -l '/\*\*' -- :^Documentation :^tools) \
>      | scripts/split-man.pl /tmp/man
> =20
>  =E4=B8=80=E4=BA=9B=E6=97=A7=E7=89=88=E6=9C=AC=E7=9A=84git=E4=B8=8D=E6=94=
=AF=E6=8C=81=E8=B7=AF=E5=BE=84=E6=8E=92=E9=99=A4=E8=AF=AD=E6=B3=95=E7=9A=84=
=E6=9F=90=E4=BA=9B=E5=8F=98=E4=BD=93=E3=80=82
>  =E4=BB=A5=E4=B8=8B=E5=91=BD=E4=BB=A4=E4=B9=8B=E4=B8=80=E5=8F=AF=E8=83=BD=
=E9=80=82=E7=94=A8=E4=BA=8E=E8=BF=99=E4=BA=9B=E7=89=88=E6=9C=AC::
> =20
> -  $ scripts/kernel-doc -man \
> +  $ tools/doc/kernel-doc -man \
>      $(git grep -l '/\*\*' -- . ':!Documentation' ':!tools') \
>      | scripts/split-man.pl /tmp/man
> =20
> -  $ scripts/kernel-doc -man \
> +  $ tools/doc/kernel-doc -man \
>      $(git grep -l '/\*\*' -- . ":(exclude)Documentation" ":(exclude)tool=
s") \
>      | scripts/split-man.pl /tmp/man
> =20
> diff --git a/Documentation/translations/zh_CN/kbuild/kbuild.rst b/Documen=
tation/translations/zh_CN/kbuild/kbuild.rst
> index e5e2aebe1ebc..3650a48a8db6 100644
> --- a/Documentation/translations/zh_CN/kbuild/kbuild.rst
> +++ b/Documentation/translations/zh_CN/kbuild/kbuild.rst
> @@ -158,7 +158,7 @@ UTS_MACHINE =E5=8F=98=E9=87=8F=EF=BC=88=E5=9C=A8=E6=
=9F=90=E4=BA=9B=E6=9E=B6=E6=9E=84=E4=B8=AD=E8=BF=98=E5=8C=85=E6=8B=AC=E5=86=
=85=E6=A0=B8=E9=85=8D=E7=BD=AE=EF=BC=89=E6=9D=A5=E7=8C=9C=E6=B5=8B=E6=AD=A3=
=E7=A1=AE
>  KDOCFLAGS
>  ---------
>  =E6=8C=87=E5=AE=9A=E5=9C=A8=E6=9E=84=E5=BB=BA=E8=BF=87=E7=A8=8B=E4=B8=AD=
=E7=94=A8=E4=BA=8E kernel-doc =E6=A3=80=E6=9F=A5=E7=9A=84=E9=A2=9D=E5=A4=96=
=EF=BC=88=E8=AD=A6=E5=91=8A/=E9=94=99=E8=AF=AF=EF=BC=89=E6=A0=87=E5=BF=97=
=EF=BC=8C=E6=9F=A5=E7=9C=8B
> -scripts/kernel-doc =E4=BA=86=E8=A7=A3=E6=94=AF=E6=8C=81=E7=9A=84=E6=A0=
=87=E5=BF=97=E3=80=82=E8=AF=B7=E6=B3=A8=E6=84=8F=EF=BC=8C=E8=BF=99=E7=9B=AE=
=E5=89=8D=E4=B8=8D=E9=80=82=E7=94=A8=E4=BA=8E=E6=96=87=E6=A1=A3=E6=9E=84=E5=
=BB=BA=E3=80=82
> +tools/doc/kernel-doc =E4=BA=86=E8=A7=A3=E6=94=AF=E6=8C=81=E7=9A=84=E6=A0=
=87=E5=BF=97=E3=80=82=E8=AF=B7=E6=B3=A8=E6=84=8F=EF=BC=8C=E8=BF=99=E7=9B=AE=
=E5=89=8D=E4=B8=8D=E9=80=82=E7=94=A8=E4=BA=8E=E6=96=87=E6=A1=A3=E6=9E=84=E5=
=BB=BA=E3=80=82
> =20
>  ARCH
>  ----
> diff --git a/Documentation/translations/zh_CN/process/coding-style.rst b/=
Documentation/translations/zh_CN/process/coding-style.rst
> index 0484d0c65c25..64f0c13ff831 100644
> --- a/Documentation/translations/zh_CN/process/coding-style.rst
> +++ b/Documentation/translations/zh_CN/process/coding-style.rst
> @@ -545,7 +545,7 @@ Linux =E9=87=8C=E8=BF=99=E6=98=AF=E6=8F=90=E5=80=A1=
=E7=9A=84=E5=81=9A=E6=B3=95=EF=BC=8C=E5=9B=A0=E4=B8=BA=E8=BF=99=E6=A0=B7=E5=
=8F=AF=E4=BB=A5=E5=BE=88=E7=AE=80=E5=8D=95=E7=9A=84=E7=BB=99=E8=AF=BB=E8=80=
=85=E6=8F=90=E4=BE=9B
>  =E4=B9=9F=E5=8F=AF=E4=BB=A5=E5=8A=A0=E4=B8=8A=E5=AE=83=E5=81=9A=E8=BF=99=
=E4=BA=9B=E4=BA=8B=E6=83=85=E7=9A=84=E5=8E=9F=E5=9B=A0=E3=80=82
> =20
>  =E5=BD=93=E6=B3=A8=E9=87=8A=E5=86=85=E6=A0=B8 API =E5=87=BD=E6=95=B0=E6=
=97=B6=EF=BC=8C=E8=AF=B7=E4=BD=BF=E7=94=A8 kernel-doc =E6=A0=BC=E5=BC=8F=E3=
=80=82=E8=AF=A6=E8=A7=81
> -Documentation/translations/zh_CN/doc-guide/index.rst =E5=92=8C scripts/k=
ernel-doc =E3=80=82
> +Documentation/translations/zh_CN/doc-guide/index.rst =E5=92=8C tools/doc=
/kernel-doc =E3=80=82
> =20
>  =E9=95=BF (=E5=A4=9A=E8=A1=8C) =E6=B3=A8=E9=87=8A=E7=9A=84=E9=A6=96=E9=
=80=89=E9=A3=8E=E6=A0=BC=E6=98=AF=EF=BC=9A
> =20
> diff --git a/Documentation/translations/zh_TW/process/coding-style.rst b/=
Documentation/translations/zh_TW/process/coding-style.rst
> index 311c6f6bad0b..1e9dee6bbdd0 100644
> --- a/Documentation/translations/zh_TW/process/coding-style.rst
> +++ b/Documentation/translations/zh_TW/process/coding-style.rst
> @@ -548,7 +548,7 @@ Linux =E8=A3=8F=E9=80=99=E6=98=AF=E6=8F=90=E5=80=A1=
=E7=9A=84=E5=81=9A=E6=B3=95=EF=BC=8C=E5=9B=A0=E7=88=B2=E9=80=99=E6=A8=A3=E5=
=8F=AF=E4=BB=A5=E5=BE=88=E7=B0=A1=E5=96=AE=E7=9A=84=E7=B5=A6=E8=AE=80=E8=80=
=85=E6=8F=90=E4=BE=9B
>  =E4=B9=9F=E5=8F=AF=E4=BB=A5=E5=8A=A0=E4=B8=8A=E5=AE=83=E5=81=9A=E9=80=99=
=E4=BA=9B=E4=BA=8B=E6=83=85=E7=9A=84=E5=8E=9F=E5=9B=A0=E3=80=82
> =20
>  =E7=95=B6=E8=A8=BB=E9=87=8B=E5=85=A7=E6=A0=B8 API =E5=87=BD=E6=95=B8=E6=
=99=82=EF=BC=8C=E8=AB=8B=E4=BD=BF=E7=94=A8 kernel-doc =E6=A0=BC=E5=BC=8F=E3=
=80=82=E8=A9=B3=E8=A6=8B
> -Documentation/translations/zh_CN/doc-guide/index.rst =E5=92=8C scripts/k=
ernel-doc =E3=80=82
> +Documentation/translations/zh_CN/doc-guide/index.rst =E5=92=8C tools/doc=
/kernel-doc =E3=80=82
> =20
>  =E9=95=B7 (=E5=A4=9A=E8=A1=8C) =E8=A8=BB=E9=87=8B=E7=9A=84=E9=A6=96=E9=
=81=B8=E9=A2=A8=E6=A0=BC=E6=98=AF=EF=BC=9A
> =20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2d2ce92bf79..0fa427577f15 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7302,7 +7302,6 @@ P:	Documentation/doc-guide/maintainer-profile.rst
>  T:	git git://git.lwn.net/linux.git docs-next
>  F:	Documentation/
>  F:	tools/doc/
> -F:	scripts/kernel-doc*
>  F:	scripts/lib/abi/*
>  F:	scripts/lib/kdoc/*
>  F:	tools/net/ynl/pyynl/lib/doc_generator.py
> diff --git a/Makefile b/Makefile
> index 6bfe776bf3c5..44577bd357bb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -460,7 +460,7 @@ HOSTPKG_CONFIG	=3D pkg-config
> =20
>  # the KERNELDOC macro needs to be exported, as scripts/Makefile.build
>  # has a logic to call it
> -KERNELDOC       =3D $(srctree)/scripts/kernel-doc.py
> +KERNELDOC       =3D $(srctree)/tools/doc/kernel-doc.py
>  export KERNELDOC
> =20
>  KBUILD_USERHOSTCFLAGS :=3D -Wall -Wmissing-prototypes -Wstrict-prototype=
s \
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 853543443072..6e732e0079c1 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -426,7 +426,7 @@ always-$(CONFIG_DRM_I915_WERROR) +=3D \
> =20
>  quiet_cmd_hdrtest =3D HDRTEST $(patsubst %.hdrtest,%.h,$@)
>        cmd_hdrtest =3D $(CC) $(filter-out $(CFLAGS_GCOV), $(c_flags)) -S =
-o /dev/null -x c /dev/null -include $<; \
> -		$(srctree)/scripts/kernel-doc -none -Werror $<; touch $@
> +		$(srctree)/tools/doc/kernel-doc -none -Werror $<; touch $@
> =20
>  $(obj)/%.hdrtest: $(src)/%.h FORCE
>  	$(call if_changed_dep,hdrtest)
> diff --git a/scripts/find-unused-docs.sh b/scripts/find-unused-docs.sh
> index d6d397fbf917..0ae445dec2e4 100755
> --- a/scripts/find-unused-docs.sh
> +++ b/scripts/find-unused-docs.sh
> @@ -54,7 +54,7 @@ for file in `find $1 -name '*.c'`; do
>  	if [[ ${FILES_INCLUDED[$file]+_} ]]; then
>  	continue;
>  	fi
> -	str=3D$(PYTHONDONTWRITEBYTECODE=3D1 scripts/kernel-doc -export "$file" =
2>/dev/null)
> +	str=3D$(PYTHONDONTWRITEBYTECODE=3D1 tools/doc/kernel-doc -export "$file=
" 2>/dev/null)
>  	if [[ -n "$str" ]]; then
>  	echo "$file"
>  	fi
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> deleted file mode 120000
> index 3b6ef807791a..000000000000
> --- a/scripts/kernel-doc
> +++ /dev/null
> @@ -1 +0,0 @@
> -kernel-doc.py
> \ No newline at end of file
> diff --git a/scripts/kernel-doc.py b/tools/doc/kernel-doc
> similarity index 100%
> rename from scripts/kernel-doc.py
> rename to tools/doc/kernel-doc



Thanks,
Mauro

