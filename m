Return-Path: <linux-kernel+bounces-767697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AD0B257C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F26467B4006
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94DF2FC898;
	Wed, 13 Aug 2025 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXKVK3yU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B92F60A6;
	Wed, 13 Aug 2025 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129045; cv=none; b=RAcrzqrYc36Js+TTM3BC9XG6YjntCYXHgxYtHuhLFmcsDLa8gmqkRDj+MDywYx8an9KTQ+4wGYaLUrmIJRDpMvwhPOjvuWfMDjD9Dhq7ZgLdkNFcyOLEQU+dAFHUqDHWMNZRiiCJgk1o+KnpjUIfMRQzbo81aa2jMu3yfS4XWR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129045; c=relaxed/simple;
	bh=V8NGTu6nVm3ohtX2JeGDiq1FMx/+4PB7zIAIRxX49yM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gxf3nbe7EjHsc+QzqYx1g2kJ5sd3c9j1ew/W10qpKCK1JOyTBalN6cN9Vyi9pvxTigDf6Lwv8PYeX4UlKo/sB8KZ41gW4LzRsyICBTLoyjlIAo8+YjQV1hdnTjkhs30IrHsUqo+CueZI2/yG0RJqbtLaVg5ag17OjXnCc52nVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXKVK3yU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89585C4CEEB;
	Wed, 13 Aug 2025 23:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755129044;
	bh=V8NGTu6nVm3ohtX2JeGDiq1FMx/+4PB7zIAIRxX49yM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QXKVK3yUA2IeBNFkLFJNoz/wxOnaIhyVJ4nb0g0DbGOPfbmcCeBIZMS1qx+v7P1vg
	 IhzBAQukl/v8hFqdlivGUkj9vqnS3K5FHzHRD14xHQGG66bvT80MWsZI5xVv793jov
	 MOQ2uoVOmTL3XLM4HaPlI2it+ozz/TGDEqVqbxZ3Fpp5ximwwqunfsMFWMme6Vwinj
	 5IK+0rUoj70pvyn3krKPU4I1RNh2kEQGS0RZZKNaIKheBvRPkg2aCFZlgadvaJBAsM
	 wmaTVW8B/ZUoB88khtp+UkVAuHkzAGWGMwbynuJhZovx5uIU8IqfCuGZXIgMjFuSmT
	 4GwiBVvRWwENg==
Date: Thu, 14 Aug 2025 01:50:40 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 12/13] docs: move find-unused-docs.sh to tools/doc
Message-ID: <20250814015040.09db5b0c@foz.lan>
In-Reply-To: <20250813213218.198582-13-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-13-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Wed, 13 Aug 2025 15:32:11 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> ...and update references accordingly.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

>=20
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/doc-guide/contributing.rst                    | 2 +-
>  Documentation/translations/zh_CN/doc-guide/contributing.rst | 2 +-
>  {scripts =3D> tools/doc}/find-unused-docs.sh                  | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
>  rename {scripts =3D> tools/doc}/find-unused-docs.sh (85%)
>=20
> diff --git a/Documentation/doc-guide/contributing.rst b/Documentation/doc=
-guide/contributing.rst
> index 662c7a840cd5..81633c6c6c11 100644
> --- a/Documentation/doc-guide/contributing.rst
> +++ b/Documentation/doc-guide/contributing.rst
> @@ -152,7 +152,7 @@ generate links to that documentation.  Adding ``kerne=
l-doc`` directives to
>  the documentation to bring those comments in can help the community deri=
ve
>  the full value of the work that has gone into creating them.
> =20
> -The ``scripts/find-unused-docs.sh`` tool can be used to find these
> +The ``tools/doc/find-unused-docs.sh`` tool can be used to find these
>  overlooked comments.
> =20
>  Note that the most value comes from pulling in the documentation for
> diff --git a/Documentation/translations/zh_CN/doc-guide/contributing.rst =
b/Documentation/translations/zh_CN/doc-guide/contributing.rst
> index 394a13b438b0..d205f8ed9fce 100644
> --- a/Documentation/translations/zh_CN/doc-guide/contributing.rst
> +++ b/Documentation/translations/zh_CN/doc-guide/contributing.rst
> @@ -124,7 +124,7 @@ C=E4=BB=A3=E7=A0=81=E7=BC=96=E8=AF=91=E5=99=A8=E5=8F=
=91=E5=87=BA=E7=9A=84=E8=AD=A6=E5=91=8A=E5=B8=B8=E5=B8=B8=E4=BC=9A=E8=A2=AB=
=E8=A7=86=E4=B8=BA=E8=AF=AF=E6=8A=A5=EF=BC=8C=E4=BB=8E=E8=80=8C=E5=AF=BC=E8=
=87=B4=E5=87=BA=E7=8E=B0=E4=BA=86
>  =E8=BF=99=E4=BD=BF=E5=BE=97=E8=BF=99=E4=BA=9B=E4=BF=A1=E6=81=AF=E6=9B=B4=
=E9=9A=BE=E6=89=BE=E5=88=B0=EF=BC=8C=E4=BE=8B=E5=A6=82=E4=BD=BFSphinx=E6=97=
=A0=E6=B3=95=E7=94=9F=E6=88=90=E6=8C=87=E5=90=91=E8=AF=A5=E6=96=87=E6=A1=A3=
=E7=9A=84=E9=93=BE=E6=8E=A5=E3=80=82=E5=B0=86 ``kernel-doc``
>  =E6=8C=87=E4=BB=A4=E6=B7=BB=E5=8A=A0=E5=88=B0=E6=96=87=E6=A1=A3=E4=B8=AD=
=E4=BB=A5=E5=BC=95=E5=85=A5=E8=BF=99=E4=BA=9B=E6=B3=A8=E9=87=8A=E5=8F=AF=E4=
=BB=A5=E5=B8=AE=E5=8A=A9=E7=A4=BE=E5=8C=BA=E8=8E=B7=E5=BE=97=E4=B8=BA=E7=BC=
=96=E5=86=99=E6=B3=A8=E9=87=8A=E6=89=80=E5=81=9A=E5=B7=A5=E4=BD=9C=E7=9A=84=
=E5=85=A8=E9=83=A8=E4=BB=B7=E5=80=BC=E3=80=82
> =20
> -``scripts/find-unused-docs.sh`` =E5=B7=A5=E5=85=B7=E5=8F=AF=E4=BB=A5=E7=
=94=A8=E6=9D=A5=E6=89=BE=E5=88=B0=E8=BF=99=E4=BA=9B=E8=A2=AB=E5=BF=BD=E7=95=
=A5=E7=9A=84=E8=AF=84=E8=AE=BA=E3=80=82
> +``tools/doc/find-unused-docs.sh`` =E5=B7=A5=E5=85=B7=E5=8F=AF=E4=BB=A5=
=E7=94=A8=E6=9D=A5=E6=89=BE=E5=88=B0=E8=BF=99=E4=BA=9B=E8=A2=AB=E5=BF=BD=E7=
=95=A5=E7=9A=84=E8=AF=84=E8=AE=BA=E3=80=82
> =20
>  =E8=AF=B7=E6=B3=A8=E6=84=8F=EF=BC=8C=E5=B0=86=E5=AF=BC=E5=87=BA=E7=9A=84=
=E5=87=BD=E6=95=B0=E5=92=8C=E6=95=B0=E6=8D=AE=E7=BB=93=E6=9E=84=E5=BC=95=E5=
=85=A5=E6=96=87=E6=A1=A3=E6=98=AF=E6=9C=80=E6=9C=89=E4=BB=B7=E5=80=BC=E7=9A=
=84=E3=80=82=E8=AE=B8=E5=A4=9A=E5=AD=90=E7=B3=BB=E7=BB=9F=E8=BF=98=E5=85=B7=
=E6=9C=89=E4=BE=9B=E5=86=85=E9=83=A8
>  =E4=BD=BF=E7=94=A8=E7=9A=84kernel-doc=E6=B3=A8=E9=87=8A=EF=BC=9B=E9=99=
=A4=E9=9D=9E=E8=BF=99=E4=BA=9B=E6=B3=A8=E9=87=8A=E6=94=BE=E5=9C=A8=E4=B8=93=
=E9=97=A8=E9=92=88=E5=AF=B9=E7=9B=B8=E5=85=B3=E5=AD=90=E7=B3=BB=E7=BB=9F=E5=
=BC=80=E5=8F=91=E4=BA=BA=E5=91=98=E7=9A=84=E6=96=87=E6=A1=A3=E4=B8=AD=EF=BC=
=8C
> diff --git a/scripts/find-unused-docs.sh b/tools/doc/find-unused-docs.sh
> similarity index 85%
> rename from scripts/find-unused-docs.sh
> rename to tools/doc/find-unused-docs.sh
> index 0ae445dec2e4..a64389a15f09 100755
> --- a/scripts/find-unused-docs.sh
> +++ b/tools/doc/find-unused-docs.sh
> @@ -5,10 +5,10 @@
>  # This script detects files with kernel-doc comments for exported functi=
ons
>  # that are not included in documentation.
>  #
> -# usage: Run 'scripts/find-unused-docs.sh directory' from top level of k=
ernel
> +# usage: Run 'tools/doc/find-unused-docs.sh directory' from top level of=
 kernel
>  # 	 tree.
>  #
> -# example: $scripts/find-unused-docs.sh drivers/scsi
> +# example: $tools/doc/find-unused-docs.sh drivers/scsi
>  #
>  # Licensed under the terms of the GNU GPL License
> =20
> @@ -18,7 +18,7 @@ if ! [ -d "Documentation" ]; then
>  fi
> =20
>  if [ "$#" -ne 1 ]; then
> -	echo "Usage: scripts/find-unused-docs.sh directory"
> +	echo "Usage: tools/doc/find-unused-docs.sh directory"
>  	exit 1
>  fi
> =20



Thanks,
Mauro

