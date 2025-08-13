Return-Path: <linux-kernel+bounces-767698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7683FB257CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 225553B3733
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677CC2FC89F;
	Wed, 13 Aug 2025 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTAuFPbG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B096E2F60DC;
	Wed, 13 Aug 2025 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129070; cv=none; b=g7Y/N2GNz9UOlEEHJtuGqxvEyIe8pTnS5xJqSJG1M5uiCej0xsnW4iIgR+rERCo+1vc1LuQMlvwdviiNyVUOgYIZZ1aQF3D2bkCsfYE4HHFR+yziXtT733/7xBueyEMPZQZpzqqI5gmVD+ySkahQtLuZVmjpW8TX022fKj3mxUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129070; c=relaxed/simple;
	bh=rpY2NW9ov2yVQk0j9eopj/8vPRHm/mRuzvT2FDOUZr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lz1B2HBR76xpyYDONKak5pqpxZ8N+D+pH//bEzYzf1hvKFvFRbruKXBs7BTMilvwq3SaBH/v93Pk8FGkbLKddMLH11KZAGouTyWHlhmAGwYDWP13sDFy9+2QOBvZaMlfJOjmEUEssPgDMVtXHOtO1yr7BlMa0iNnYKdWv7sR6vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTAuFPbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DB7C4CEEB;
	Wed, 13 Aug 2025 23:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755129070;
	bh=rpY2NW9ov2yVQk0j9eopj/8vPRHm/mRuzvT2FDOUZr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dTAuFPbGC0ifswIMz7jlq6o9S8frtwR4FQFaWstqoeSKm9yYjK0JKVcALM6EZacf+
	 782nphC6cQdE3ujXEwSCgXwQghBJfei6gH2OhmHuBj05kUa5qi5pnFFujGuvuNz7mk
	 Hh2h01WhN9UoEGJM0bu61z3LbLsPm6Kd5i6S1kzrvLslSTkWIsCnTIJ+y164+NpFaQ
	 uXX6sdZsSf9FIUh85fhQC9ULeoA1mv8y5usNgFoQThjDGjHyuy/RnWOb4dZrjP23OT
	 CVoQt0AmcljDdNRy4s9MgiYGpIxNPqC1tqVDzZ61LTu63NKf1RVYnKtoWmCwPv7h3m
	 /MjxpK0yYvtzA==
Date: Thu, 14 Aug 2025 01:51:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 02/13] docs: move checktransupdate.py to tools/doc
Message-ID: <20250814015106.2d7d0bf7@foz.lan>
In-Reply-To: <20250813213218.198582-3-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-3-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Wed, 13 Aug 2025 15:32:01 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> The checktranslate.py tool currently languishes in scripts/; move it to
> tools/doc and update references accordingly.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>=20
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/doc-guide/checktransupdate.rst              | 6 +++---
>  .../translations/zh_CN/doc-guide/checktransupdate.rst     | 6 +++---
>  Documentation/translations/zh_CN/how-to.rst               | 2 +-
>  MAINTAINERS                                               | 2 +-
>  {scripts =3D> tools/doc}/checktransupdate.py                | 8 ++++----
>  5 files changed, 12 insertions(+), 12 deletions(-)
>  rename {scripts =3D> tools/doc}/checktransupdate.py (98%)
>=20
> diff --git a/Documentation/doc-guide/checktransupdate.rst b/Documentation=
/doc-guide/checktransupdate.rst
> index dfaf9d373747..48bf1ee9a62e 100644
> --- a/Documentation/doc-guide/checktransupdate.rst
> +++ b/Documentation/doc-guide/checktransupdate.rst
> @@ -27,15 +27,15 @@ Usage
> =20
>  ::
> =20
> -   ./scripts/checktransupdate.py --help
> +   tools/doc/checktransupdate.py --help
> =20
>  Please refer to the output of argument parser for usage details.
> =20
>  Samples
> =20
> --  ``./scripts/checktransupdate.py -l zh_CN``
> +-  ``tools/doc/checktransupdate.py -l zh_CN``
>     This will print all the files that need to be updated in the zh_CN lo=
cale.
> --  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-=
tools/testing-overview.rst``
> +-  ``tools/doc/checktransupdate.py Documentation/translations/zh_CN/dev-=
tools/testing-overview.rst``
>     This will only print the status of the specified file.
> =20
>  Then the output is something like:
> diff --git a/Documentation/translations/zh_CN/doc-guide/checktransupdate.=
rst b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> index d20b4ce66b9f..165e25155084 100644
> --- a/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> +++ b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> @@ -28,15 +28,15 @@
> =20
>  ::
> =20
> -    ./scripts/checktransupdate.py --help
> +    tools/doc/checktransupdate.py --help
> =20
>  =E5=85=B7=E4=BD=93=E7=94=A8=E6=B3=95=E8=AF=B7=E5=8F=82=E8=80=83=E5=8F=82=
=E6=95=B0=E8=A7=A3=E6=9E=90=E5=99=A8=E7=9A=84=E8=BE=93=E5=87=BA
> =20
>  =E7=A4=BA=E4=BE=8B
> =20
> --  ``./scripts/checktransupdate.py -l zh_CN``
> +-  ``tools/doc/checktransupdate.py -l zh_CN``
>     =E8=BF=99=E5=B0=86=E6=89=93=E5=8D=B0 zh_CN =E8=AF=AD=E8=A8=80=E4=B8=
=AD=E9=9C=80=E8=A6=81=E6=9B=B4=E6=96=B0=E7=9A=84=E6=89=80=E6=9C=89=E6=96=87=
=E4=BB=B6=E3=80=82
> --  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-=
tools/testing-overview.rst``
> +-  ``tools/doc/checktransupdate.py Documentation/translations/zh_CN/dev-=
tools/testing-overview.rst``
>     =E8=BF=99=E5=B0=86=E5=8F=AA=E6=89=93=E5=8D=B0=E6=8C=87=E5=AE=9A=E6=96=
=87=E4=BB=B6=E7=9A=84=E7=8A=B6=E6=80=81=E3=80=82
> =20
>  =E7=84=B6=E5=90=8E=E8=BE=93=E5=87=BA=E7=B1=BB=E4=BC=BC=E5=A6=82=E4=B8=8B=
=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=9A
> diff --git a/Documentation/translations/zh_CN/how-to.rst b/Documentation/=
translations/zh_CN/how-to.rst
> index ddd99c0f9b4d..cf66c72ee0c5 100644
> --- a/Documentation/translations/zh_CN/how-to.rst
> +++ b/Documentation/translations/zh_CN/how-to.rst
> @@ -437,7 +437,7 @@ git email =E9=BB=98=E8=AE=A4=E4=BC=9A=E6=8A=84=E9=80=
=81=E7=BB=99=E6=82=A8=E4=B8=80=E4=BB=BD=EF=BC=8C=E6=89=80=E4=BB=A5=E6=82=A8=
=E5=8F=AF=E4=BB=A5=E5=88=87=E6=8D=A2=E4=B8=BA=E5=AE=A1=E9=98=85=E8=80=85=E7=
=9A=84=E8=A7=92
>  =E5=AF=B9=E4=BA=8E=E9=A6=96=E6=AC=A1=E5=8F=82=E4=B8=8E Linux =E5=86=85=
=E6=A0=B8=E4=B8=AD=E6=96=87=E6=96=87=E6=A1=A3=E7=BF=BB=E8=AF=91=E7=9A=84=E6=
=96=B0=E6=89=8B=EF=BC=8C=E5=BB=BA=E8=AE=AE=E6=82=A8=E5=9C=A8 linux =E7=9B=
=AE=E5=BD=95=E4=B8=AD=E8=BF=90=E8=A1=8C=E4=BB=A5=E4=B8=8B=E5=91=BD=E4=BB=A4=
=EF=BC=9A
>  ::
> =20
> -	./script/checktransupdate.py -l zh_CN``
> +	tools/doc/checktransupdate.py -l zh_CN``
> =20
>  =E8=AF=A5=E5=91=BD=E4=BB=A4=E4=BC=9A=E5=88=97=E5=87=BA=E9=9C=80=E8=A6=81=
=E7=BF=BB=E8=AF=91=E6=88=96=E6=9B=B4=E6=96=B0=E7=9A=84=E8=8B=B1=E6=96=87=E6=
=96=87=E6=A1=A3=EF=BC=8C=E7=BB=93=E6=9E=9C=E5=90=8C=E6=97=B6=E4=BF=9D=E5=AD=
=98=E5=9C=A8 checktransupdate.log =E4=B8=AD=E3=80=82
> =20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dafc11712544..a3a396fc1c3f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7301,8 +7301,8 @@ S:	Maintained
>  P:	Documentation/doc-guide/maintainer-profile.rst
>  T:	git git://git.lwn.net/linux.git docs-next
>  F:	Documentation/
> +F:	tools/doc/
>  F:	scripts/check-variable-fonts.sh
> -F:	scripts/checktransupdate.py
>  F:	scripts/documentation-file-ref-check
>  F:	scripts/get_abi.py
>  F:	scripts/kernel-doc*
> diff --git a/scripts/checktransupdate.py b/tools/doc/checktransupdate.py
> similarity index 98%
> rename from scripts/checktransupdate.py
> rename to tools/doc/checktransupdate.py
> index e39529e46c3d..61bd7b02ca55 100755
> --- a/scripts/checktransupdate.py
> +++ b/tools/doc/checktransupdate.py
> @@ -9,9 +9,9 @@ commit to find the latest english commit from the transla=
tion commit
>  differences occur, report the file and commits that need to be updated.
> =20
>  The usage is as follows:
> -- ./scripts/checktransupdate.py -l zh_CN
> +- tools/doc/checktransupdate.py -l zh_CN
>  This will print all the files that need to be updated or translated in t=
he zh_CN locale.
> -- ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-too=
ls/testing-overview.rst
> +- tools/doc/checktransupdate.py Documentation/translations/zh_CN/dev-too=
ls/testing-overview.rst
>  This will only print the status of the specified file.
> =20
>  The output is something like:
> @@ -168,7 +168,7 @@ def check_per_file(file_path):
>  def valid_locales(locale):
>      """Check if the locale is valid or not"""
>      script_path =3D os.path.dirname(os.path.abspath(__file__))
> -    linux_path =3D os.path.join(script_path, "..")
> +    linux_path =3D os.path.join(script_path, "../..")
>      if not os.path.isdir(f"{linux_path}/Documentation/translations/{loca=
le}"):
>          raise ArgumentTypeError("Invalid locale: {locale}")
>      return locale
> @@ -232,7 +232,7 @@ def config_logging(log_level, log_file=3D"checktransu=
pdate.log"):
>  def main():
>      """Main function of the script"""
>      script_path =3D os.path.dirname(os.path.abspath(__file__))
> -    linux_path =3D os.path.join(script_path, "..")
> +    linux_path =3D os.path.join(script_path, "../..")
> =20
>      parser =3D ArgumentParser(description=3D"Check the translation updat=
e")
>      parser.add_argument(



Thanks,
Mauro

