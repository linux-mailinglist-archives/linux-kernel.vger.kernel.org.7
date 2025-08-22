Return-Path: <linux-kernel+bounces-782457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014E3B320A2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2879D3BFD78
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B053054E8;
	Fri, 22 Aug 2025 16:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="np2Wvbla"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4D2F83D4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755880463; cv=none; b=t1FRXIv7R0V5009BZvco+ruwGW+5te3tgKQMHP54GDJgyd+5jS39YjNnhm8VYYAd//LIdFhGBTq42aPIF7lzDq4GcoOgrtIJJrtDPLK35w2qlWn0qcJji4Bf/qKrK1/Fuvu8IxEh7tzSeyADJ3AVd5hBNYFmY203AaC+8TfDaQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755880463; c=relaxed/simple;
	bh=O26kbNpQZ29uf5FWMn81YzUR6Goj2XaZVIL952w+g7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGVnFR0MXLe+jUJ6tWXVULkeF2QpPQMLQ1cANKjdbQOYyEVwGOQkeUV2TfrmH4PlZDl+oAzWP66lQizFSttStHuACGxI353zFM2yR2PYCw1jT0NBw4DQIG4KMG22wKJIAEXqI1/4bNOyDMaF9JZqUrzt6LzlACb1U2JUrbHZpJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=np2Wvbla; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-246257e49c8so2035ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755880461; x=1756485261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KZvnoDpowHbBxCKIBWeXXKI0VchYJSYQk9OXSBvIs0=;
        b=np2Wvblao3+m7SN8rjGObg/bWFt5OmSE4KWEoE4YYr7jtBUz9ogq9XglTzyRzXZs86
         1zlaGUqYX8C6+krTVi+L8J3Fb5T3Ev2ky9ojHEGyBaP/kbEZ1wN9qExYuu5mBeEmZ/Ac
         R0m5VfKBwgHq56GGsB664zN7b+cqbMIB+Rh4347HQijAX4febhBkWaE3E63KRD61M6Wd
         DhO8ol8ISRVKxDMlVdX7/b03EIbaiWwHhsnMmAHNJQydxoYzuuDrFD63DRm1B8pAT+/3
         BYRUDfsLvXHD1VuaLAnNNT5XLqDEvYiTb3e9I82iW72w9PSvuL1pdQIlrDGGXPYjI0y6
         OWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755880461; x=1756485261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KZvnoDpowHbBxCKIBWeXXKI0VchYJSYQk9OXSBvIs0=;
        b=YAK+yHGdyXd85aOV2m7dX5l+lgAtvjhLdWLcZ0yzrKKOT1Ot+MKHaABUfkDgsHdCgC
         E9+dZAHqjWcOuYWJZmWb1r55+KmQIjVmRNZm/i4r4M4xcv1pg4IlsUNiAlV8QmWe4TI1
         eOb7jyYWk85jBT505qG195GRhCqfv+2JhRpT4MtGGpHF8ACMhGp4iKea6ejuP6fM3Hf9
         ACiLcOi3iJc1FIPRlOMr1BPTvXs380Qzuci9xE3PX81ktErKDJwehQqKltkl0dLE8lFy
         /sPuZyzPv3fXvqXmK35OASQz13tOwaCPFDLT0wc5m80HZLHY3uwET1wfbt/9n4O3/pa9
         fxQw==
X-Forwarded-Encrypted: i=1; AJvYcCWcXPRICAD8qxfllxN/p36+akcSbpoWrZz0hSpnDczWakLhduCmmHu1r4Pfqh6OFl93veNBcCq1WZ9idEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlgIqI8rUQhuhHb44uTh6eJnR5fWZ9uUU8JRXYNgOpSBNBMffD
	WyYqqsMzVRwLZR9+d/16a9yQVSgeYJivwQlCqRH2J1TN0PYdd3FzTlHKIp1RcIfNTjHypqmy1vK
	IAFhJ20MQuUH1IpsBqj4gfI8dWqVcKSft7klWl/Y0
X-Gm-Gg: ASbGncsP8bx4TY++J7iIY9IMGKv2FoZkxDQPiWvTmTNW9cW53UVCcTJs+ts1pI7ztMh
	Zctr0da7AmioYwxqFYwimpMoJEIbFvFjFxKY58MBmPv7xUF0GROenb5fyV532KFsiUcHRblZcSB
	ZFCTe4M/ap6+GZ3dYgjaXSVd6OE3x5IH8X1jcEWHEm0Tjl5g+cRMlSKNlSu42YnvWRAG6lS7haF
	JRQd3tyIW30oMk=
X-Google-Smtp-Source: AGHT+IGGSIuhs3GJS9EYCX9Nq1FLnFppcrk5WGLd58NivGob9/epeE//UhWWfQhRd8FghR2Q7Fw2qH7GI0yQwhNCcLA=
X-Received: by 2002:a17:902:f551:b0:240:589e:c8c9 with SMTP id
 d9443c01a7336-24632886c79mr4427565ad.10.1755880460470; Fri, 22 Aug 2025
 09:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822162506.316844-3-ysk@kzalloc.com>
In-Reply-To: <20250822162506.316844-3-ysk@kzalloc.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 22 Aug 2025 09:34:07 -0700
X-Gm-Features: Ac12FXzt1TRfDXL6mh9uaaicEceXfMfdgG91vqeba--a39pkYR1DOWobi5cFZ2c
Message-ID: <CAP-5=fUcsd--WrwEnRja2pX+-5Z6d4Qyf7t4Fybhixw+WYY-5Q@mail.gmail.com>
Subject: Re: [PATCH] perf util: Fix compression checks returning -1 as bool
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 9:28=E2=80=AFAM Yunseong Kim <ysk@kzalloc.com> wrot=
e:
>
> The lzma_is_compressed and gzip_is_compressed functions are declared
> to return a "bool" type, but in case of an error (e.g., file open
> failure), they incorrectly returned -1.
>
> A bool type is a boolean value that is either true or false.
> Returning -1 for a bool return type can lead to unexpected behavior
> and may violate strict type-checking in some compilers.
>
> Fix the return value to be false in error cases, ensuring the function
> adheres to its declared return type improves for preventing potential
> bugs related to type mismatch.
>
> Fixes: 4b57fd44b61b ("perf tools: Add lzma_is_compressed function")
> Fixes: 88c74dc76a30 ("perf tools: Add gzip_is_compressed function")
> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/lzma.c | 2 +-
>  tools/perf/util/zlib.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
> index bbcd2ffcf4bd..c355757ed391 100644
> --- a/tools/perf/util/lzma.c
> +++ b/tools/perf/util/lzma.c
> @@ -120,7 +120,7 @@ bool lzma_is_compressed(const char *input)
>         ssize_t rc;
>
>         if (fd < 0)
> -               return -1;
> +               return false;
>
>         rc =3D read(fd, buf, sizeof(buf));
>         close(fd);
> diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
> index 78d2297c1b67..1f7c06523059 100644
> --- a/tools/perf/util/zlib.c
> +++ b/tools/perf/util/zlib.c
> @@ -88,7 +88,7 @@ bool gzip_is_compressed(const char *input)
>         ssize_t rc;
>
>         if (fd < 0)
> -               return -1;
> +               return false;
>
>         rc =3D read(fd, buf, sizeof(buf));
>         close(fd);
> --
> 2.50.0
>

