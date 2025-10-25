Return-Path: <linux-kernel+bounces-869892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED57C08F0F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A32F7407220
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B5E2F25FD;
	Sat, 25 Oct 2025 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9kmdAHd"
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7364A1FBEAC
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761388227; cv=none; b=WCQ0T3lgA8wehFClUWga6YamPPGrSGEgb8PGO8SfnW63faURTTw/BOjOno/ClAC7gEeasVAp+9wEgekCSbEKxiZrA5X0t/xwro/sl65D9QhnM+vbKg9/Mzh3YCiwUFa9U+z8wMQdIbZ/PHNmDAwLjTrdv3Mf6VykO3tBqQVmNIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761388227; c=relaxed/simple;
	bh=y54jRnBPr+cX8ZHfCbSEr8i0VMuZLwAyADHQPCqAqac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbOIWKrSD6mDWJVNjZh1Ogqf3Y4dh+9EBgJi+Sc0hoPE1wIXOESFMVkWXafW9lh1Hp7TRhQlX1VWOFhSFEFDQmYnuDq5sCXD5HNerCSnXMiJErZODDsHTcejStVVbG9n+gV8YZD2CVK4x44lvyP8FRKBpX3eE56KyUwwr8UkWzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9kmdAHd; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63d8788b18dso3295323d50.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 03:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761388224; x=1761993024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEPvmheIE2io12AVHL9xDSvnSfkDXeIW08ryJ+C9gcw=;
        b=U9kmdAHdrv/yRO57F4skTZCkeEJM7r22fJIsOBdA0Qh7sZBID0jhc4rCzOC8PDp1/F
         vniJZu5UY6o5XAAvHmACkpnYocrdbvy5Bam2TzeC7DksOHSiqof/Z5eal459lFK5aseW
         1gjToFpIuEQRGV7T9OCxx9Ph6wC9fQxXHtLc6P6pCsoiKbdPm2wi1vqd4fodkQkp0PDb
         9F14pjqqlrk98UHqpWnEmPIbxdirzyRZ6Ga+xuWS7inT5o/iOtbDL/0OJoikawQPYq9I
         PZ9lZ9N1jgwulFXcqAVkYefRXajgnIlGYWP0WU/4uur3RGfQdMni4CuDArZRlHI4lfyh
         81Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761388224; x=1761993024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MEPvmheIE2io12AVHL9xDSvnSfkDXeIW08ryJ+C9gcw=;
        b=VAD2oEAJidgOpqyaVVn9QHI8BOLO9K5b7d+V79ptOsFYxLiwIoyNcjyU+in7D11SS2
         fbH/Z+Yxq2xUw2TsI43HbVdP5Ph4XPHkoi5lw3hMbZ6hRjhcXNRloX+CKgxn4TUrkVUg
         N+2vIYeh8tGlPy9H62QH/iB5yKQVWkSOJKsJwiL+N14bud6gE2SSRksSbClLSweEouBz
         +q5MIa9LhWOYU6MeGf2HgMJriApkTifj6dhSgTAIk1E369ItiV4qlXZgHUyQn2Rvno1V
         k7HWE+37EorRV6zOEMBIx4Zcneo/Ckz3bqkQH2MgV+kn82f4OZ1qm5C6clV8/0kk1tIY
         mwJg==
X-Forwarded-Encrypted: i=1; AJvYcCX0AtKqJwGNFmlz7g5nL9S8LpTher9o4bFfC0/0YfXsIw9/B+Sy8/Sr6Rf78eZsD3q82M4/meFI2xHWdBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLciwlM8J6fWjSgsbP0GqtRpmUy278oA154pEUZsH2iyHY3Pzc
	MoIvo9V3tkh53husPkW0SJ8ki1ouyzWW7FThKfzG2skuw6MV8c1yWn0eCNJD1lboNIMdaP2LL/R
	D3tLCxh2Ybci+/2g1Vue3eAVsaavIxHpAKw==
X-Gm-Gg: ASbGncv1oQZz7PcmZw80oMBXW0aVYX8L23eHCLiYtwbXwXesCqbnRvdvgrxA/sSUm0+
	6HRrgDTowN1DgCkpGwy9W8PAFqaw1cD3rI2xtTPEKtJrdxAUUH5WibhCWCO7DZkuGgZyQhCsyhp
	8xTqqGkRGdDAZqXDlGCDwqogB1e3cq7DBq1I5hg/HPJQ1y41430nnwP0zzofb76bksnQVQTs/TI
	aChwEZaq1qoirfTqxtEDWqp2/whJ/w3FJuEclHIJ8f52mSRet7PLI/x6eMFPFYI0Y5e1D9bq5Nr
	+CgT
X-Google-Smtp-Source: AGHT+IHqdFZ6FVQ+TQor9Uo2YmrGqmMyGnJwa+WAS5cPRNDGc0OEkDDC6Hkm/7FiJx7ww0Hh/CbVVPfA2w9uri8cBDk=
X-Received: by 2002:a53:b3ce:0:b0:63e:914:28c8 with SMTP id
 956f58d0204a3-63e1620d7e3mr18349848d50.68.1761388224129; Sat, 25 Oct 2025
 03:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023161027.697135-1-corbet@lwn.net> <20251023161027.697135-3-corbet@lwn.net>
In-Reply-To: <20251023161027.697135-3-corbet@lwn.net>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Sat, 25 Oct 2025 18:29:57 +0800
X-Gm-Features: AS18NWCSGESk1mh9FMM1MDcf8MIWdtKIxuZGnpbWgHA2kyMR70V2hPW9GWGohbQ
Message-ID: <CAD-N9QUyd0AbFpdOqxwGAvCoGwcCVVyE+2vcT4XopopcKoMU+A@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] docs: move checktransupdate.py to tools/docs
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 12:11=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> The checktranslate.py tool currently languishes in scripts/; move it to
> tools/docs and update references accordingly.
>
> Cc: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <si.yanteng@linux.dev>
> Cc: Dongliang Mu <dzm91@hust.edu.cn>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

> ---
>  Documentation/doc-guide/checktransupdate.rst              | 6 +++---
>  .../translations/zh_CN/doc-guide/checktransupdate.rst     | 6 +++---
>  Documentation/translations/zh_CN/how-to.rst               | 2 +-
>  MAINTAINERS                                               | 2 +-
>  {scripts =3D> tools/docs}/checktransupdate.py               | 8 ++++----
>  5 files changed, 12 insertions(+), 12 deletions(-)
>  rename {scripts =3D> tools/docs}/checktransupdate.py (97%)
>
> diff --git a/Documentation/doc-guide/checktransupdate.rst b/Documentation=
/doc-guide/checktransupdate.rst
> index dfaf9d373747..7b25375cc6d9 100644
> --- a/Documentation/doc-guide/checktransupdate.rst
> +++ b/Documentation/doc-guide/checktransupdate.rst
> @@ -27,15 +27,15 @@ Usage
>
>  ::
>
> -   ./scripts/checktransupdate.py --help
> +   tools/docs/checktransupdate.py --help
>
>  Please refer to the output of argument parser for usage details.
>
>  Samples
>
> --  ``./scripts/checktransupdate.py -l zh_CN``
> +-  ``tools/docs/checktransupdate.py -l zh_CN``
>     This will print all the files that need to be updated in the zh_CN lo=
cale.
> --  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-=
tools/testing-overview.rst``
> +-  ``tools/docs/checktransupdate.py Documentation/translations/zh_CN/dev=
-tools/testing-overview.rst``
>     This will only print the status of the specified file.
>
>  Then the output is something like:
> diff --git a/Documentation/translations/zh_CN/doc-guide/checktransupdate.=
rst b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> index d20b4ce66b9f..dbfd65398077 100644
> --- a/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> +++ b/Documentation/translations/zh_CN/doc-guide/checktransupdate.rst
> @@ -28,15 +28,15 @@
>
>  ::
>
> -    ./scripts/checktransupdate.py --help
> +    tools/docs/checktransupdate.py --help
>
>  =E5=85=B7=E4=BD=93=E7=94=A8=E6=B3=95=E8=AF=B7=E5=8F=82=E8=80=83=E5=8F=82=
=E6=95=B0=E8=A7=A3=E6=9E=90=E5=99=A8=E7=9A=84=E8=BE=93=E5=87=BA
>
>  =E7=A4=BA=E4=BE=8B
>
> --  ``./scripts/checktransupdate.py -l zh_CN``
> +-  ``tools/docs/checktransupdate.py -l zh_CN``
>     =E8=BF=99=E5=B0=86=E6=89=93=E5=8D=B0 zh_CN =E8=AF=AD=E8=A8=80=E4=B8=
=AD=E9=9C=80=E8=A6=81=E6=9B=B4=E6=96=B0=E7=9A=84=E6=89=80=E6=9C=89=E6=96=87=
=E4=BB=B6=E3=80=82
> --  ``./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-=
tools/testing-overview.rst``
> +-  ``tools/docs/checktransupdate.py Documentation/translations/zh_CN/dev=
-tools/testing-overview.rst``
>     =E8=BF=99=E5=B0=86=E5=8F=AA=E6=89=93=E5=8D=B0=E6=8C=87=E5=AE=9A=E6=96=
=87=E4=BB=B6=E7=9A=84=E7=8A=B6=E6=80=81=E3=80=82
>
>  =E7=84=B6=E5=90=8E=E8=BE=93=E5=87=BA=E7=B1=BB=E4=BC=BC=E5=A6=82=E4=B8=8B=
=E7=9A=84=E5=86=85=E5=AE=B9=EF=BC=9A
> diff --git a/Documentation/translations/zh_CN/how-to.rst b/Documentation/=
translations/zh_CN/how-to.rst
> index ddd99c0f9b4d..0d51bdf72e95 100644
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
>
> -       ./script/checktransupdate.py -l zh_CN``
> +       tools/docs/checktransupdate.py -l zh_CN``
>
>  =E8=AF=A5=E5=91=BD=E4=BB=A4=E4=BC=9A=E5=88=97=E5=87=BA=E9=9C=80=E8=A6=81=
=E7=BF=BB=E8=AF=91=E6=88=96=E6=9B=B4=E6=96=B0=E7=9A=84=E8=8B=B1=E6=96=87=E6=
=96=87=E6=A1=A3=EF=BC=8C=E7=BB=93=E6=9E=9C=E5=90=8C=E6=97=B6=E4=BF=9D=E5=AD=
=98=E5=9C=A8 checktransupdate.log =E4=B8=AD=E3=80=82
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dafc11712544..1b5413e779f4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7301,8 +7301,8 @@ S:        Maintained
>  P:     Documentation/doc-guide/maintainer-profile.rst
>  T:     git git://git.lwn.net/linux.git docs-next
>  F:     Documentation/
> +F:     tools/docs/
>  F:     scripts/check-variable-fonts.sh
> -F:     scripts/checktransupdate.py
>  F:     scripts/documentation-file-ref-check
>  F:     scripts/get_abi.py
>  F:     scripts/kernel-doc*
> diff --git a/scripts/checktransupdate.py b/tools/docs/checktransupdate.py
> similarity index 97%
> rename from scripts/checktransupdate.py
> rename to tools/docs/checktransupdate.py
> index e39529e46c3d..e894652369a5 100755
> --- a/scripts/checktransupdate.py
> +++ b/tools/docs/checktransupdate.py
> @@ -9,9 +9,9 @@ commit to find the latest english commit from the transla=
tion commit
>  differences occur, report the file and commits that need to be updated.
>
>  The usage is as follows:
> -- ./scripts/checktransupdate.py -l zh_CN
> +- tools/docs/checktransupdate.py -l zh_CN
>  This will print all the files that need to be updated or translated in t=
he zh_CN locale.
> -- ./scripts/checktransupdate.py Documentation/translations/zh_CN/dev-too=
ls/testing-overview.rst
> +- tools/docs/checktransupdate.py Documentation/translations/zh_CN/dev-to=
ols/testing-overview.rst
>  This will only print the status of the specified file.
>
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
>
>      parser =3D ArgumentParser(description=3D"Check the translation updat=
e")
>      parser.add_argument(
> --
> 2.51.0
>
>

