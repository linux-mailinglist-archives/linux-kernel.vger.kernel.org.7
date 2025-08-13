Return-Path: <linux-kernel+bounces-767695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C55B257D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 01:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA1C188C345
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931082FC89F;
	Wed, 13 Aug 2025 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwKM6yTY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED3D2F5486;
	Wed, 13 Aug 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129010; cv=none; b=hM0erxliRmn6A2KgPekM23UJCXsVUg8hCYAs9OTW3q39VmW4B9MU3qO0R6I54sSxRaKCAzZdB4kjQkb6xrTh917LCXmsmds7Z19xk7a8clSLMZedxH2hzBoJE8bRySBolrajxzxhQ5+4ipBG2GRyi1izB5vPV0K7P2TWqUgw1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129010; c=relaxed/simple;
	bh=Bfa1R9PdPt54oMTeMBbf5OyYs5cCUkD2CO7qy0S3TH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=arVDvNv6ls+Xht6GA91ApgrCtiZhYpgLEqALt5tu9K53WYNSfai+EgFiA71Vj/YimgTOtHWp7ovT2zMYy6KtURoTruIpBWKTbvY9r72ONMipVQm0445JKGN04tRXkUDMWgiUv+7PxpkeYjZuzyHBVPOBX7DlpBPx8Xyx7J7ErvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwKM6yTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA7EC4CEEB;
	Wed, 13 Aug 2025 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755129009;
	bh=Bfa1R9PdPt54oMTeMBbf5OyYs5cCUkD2CO7qy0S3TH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PwKM6yTY6q+wTiuOKSi/BWxP9u3Lu77Nj5Badk16Kk8bZFe5hFhiR9Ps6XcnKAZsJ
	 O13VAAd2/WwSiwqgREjYNaOZ3dGlPch6ftHI+gUvddKIBWTYLIKC5vACCferabi1Nx
	 AeBSKDmkX0N66X69bDYDvBQI9D2nexH62YzfRvFv0AT3/cBJfGlFycUB+T50WAVcMW
	 X5ayA/doUbM0dse+wJeMAUC7kC+VyVQlmJnPe147kN4RQUCXu0fOw2YRQLVUb0V5o8
	 eyf304IIgVjoQ8hZjwxcBLl2Zzkft8BT5ANzOm06f1Ei2j1tUcPjseDAkHLprxgDnw
	 kAVnwtjpCOzcA==
Date: Thu, 14 Aug 2025 01:50:05 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 11/13] docs: move split-man.pl to tools/doc
Message-ID: <20250814015005.22f0fced@foz.lan>
In-Reply-To: <20250813213218.198582-12-corbet@lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-12-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Wed, 13 Aug 2025 15:32:10 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> ...and update all references to it.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Btw, I was not aware of this. It makes sense to move its logic to
the new sphinx-build-wrapper Python script that I'll be submitting
soon.

>=20
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  Documentation/doc-guide/kernel-doc.rst                    | 6 +++---
>  Documentation/translations/it_IT/doc-guide/kernel-doc.rst | 2 +-
>  Documentation/translations/zh_CN/doc-guide/kernel-doc.rst | 6 +++---
>  {scripts =3D> tools/doc}/split-man.pl                       | 0
>  4 files changed, 7 insertions(+), 7 deletions(-)
>  rename {scripts =3D> tools/doc}/split-man.pl (100%)
>=20
> diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-g=
uide/kernel-doc.rst
> index 6fc89d444ada..b7c8ce55323c 100644
> --- a/Documentation/doc-guide/kernel-doc.rst
> +++ b/Documentation/doc-guide/kernel-doc.rst
> @@ -584,15 +584,15 @@ from the kernel git tree::
> =20
>    $ tools/doc/kernel-doc -man \
>      $(git grep -l '/\*\*' -- :^Documentation :^tools) \
> -    | scripts/split-man.pl /tmp/man
> +    | tools/doc/split-man.pl /tmp/man
> =20
>  Some older versions of git do not support some of the variants of syntax=
 for
>  path exclusion.  One of the following commands may work for those versio=
ns::
> =20
>    $ tools/doc/kernel-doc -man \
>      $(git grep -l '/\*\*' -- . ':!Documentation' ':!tools') \
> -    | scripts/split-man.pl /tmp/man
> +    | tools/doc/split-man.pl /tmp/man
> =20
>    $ tools/doc/kernel-doc -man \
>      $(git grep -l '/\*\*' -- . ":(exclude)Documentation" ":(exclude)tool=
s") \
> -    | scripts/split-man.pl /tmp/man
> +    | tools/doc/split-man.pl /tmp/man
> diff --git a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst b/=
Documentation/translations/it_IT/doc-guide/kernel-doc.rst
> index 05ea0f03c80b..bf04ceea2d83 100644
> --- a/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
> +++ b/Documentation/translations/it_IT/doc-guide/kernel-doc.rst
> @@ -604,4 +604,4 @@ Come utilizzare kernel-doc per generare pagine man
>  Se volete utilizzare kernel-doc solo per generare delle pagine man, pote=
te
>  farlo direttamente dai sorgenti del kernel::
> =20
> -  $ tools/doc/kernel-doc -man $(git grep -l '/\*\*' -- :^Documentation :=
^tools) | scripts/split-man.pl /tmp/man
> +  $ tools/doc/kernel-doc -man $(git grep -l '/\*\*' -- :^Documentation :=
^tools) | tools/doc/split-man.pl /tmp/man
> diff --git a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst b/=
Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
> index b242e52f911c..a807295bc403 100644
> --- a/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
> +++ b/Documentation/translations/zh_CN/doc-guide/kernel-doc.rst
> @@ -484,16 +484,16 @@ kernel-doc=E6=89=A9=E5=B1=95=E5=8C=85=E5=90=AB=E5=
=9C=A8=E5=86=85=E6=A0=B8=E6=BA=90=E4=BB=A3=E7=A0=81=E6=A0=91=E4=B8=AD=EF=BC=
=8C=E4=BD=8D=E4=BA=8E ``Documentation/sphinx/k
> =20
>    $ tools/doc/kernel-doc -man \
>      $(git grep -l '/\*\*' -- :^Documentation :^tools) \
> -    | scripts/split-man.pl /tmp/man
> +    | tools/doc/split-man.pl /tmp/man
> =20
>  =E4=B8=80=E4=BA=9B=E6=97=A7=E7=89=88=E6=9C=AC=E7=9A=84git=E4=B8=8D=E6=94=
=AF=E6=8C=81=E8=B7=AF=E5=BE=84=E6=8E=92=E9=99=A4=E8=AF=AD=E6=B3=95=E7=9A=84=
=E6=9F=90=E4=BA=9B=E5=8F=98=E4=BD=93=E3=80=82
>  =E4=BB=A5=E4=B8=8B=E5=91=BD=E4=BB=A4=E4=B9=8B=E4=B8=80=E5=8F=AF=E8=83=BD=
=E9=80=82=E7=94=A8=E4=BA=8E=E8=BF=99=E4=BA=9B=E7=89=88=E6=9C=AC::
> =20
>    $ tools/doc/kernel-doc -man \
>      $(git grep -l '/\*\*' -- . ':!Documentation' ':!tools') \
> -    | scripts/split-man.pl /tmp/man
> +    | tools/doc/split-man.pl /tmp/man
> =20
>    $ tools/doc/kernel-doc -man \
>      $(git grep -l '/\*\*' -- . ":(exclude)Documentation" ":(exclude)tool=
s") \
> -    | scripts/split-man.pl /tmp/man
> +    | tools/doc/split-man.pl /tmp/man
> =20
> diff --git a/scripts/split-man.pl b/tools/doc/split-man.pl
> similarity index 100%
> rename from scripts/split-man.pl
> rename to tools/doc/split-man.pl



Thanks,
Mauro

