Return-Path: <linux-kernel+bounces-807416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07D5B4A415
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABD917BA9C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E50305940;
	Tue,  9 Sep 2025 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEYpH0i6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07081FF1C4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403865; cv=none; b=qruoGPuRMNhvRhHY3YK30+K42oiCt2E30Vgu2TOh1ix1bn0YKg4sJzsUyldzlKxoyXB1pJ7kt9MvGiQy8yKfQkgHPzBFWcQZAl4reIOY8sDjHlCzyG8Z3sZG3svl6xvz79XyEFdOsl9DusAex1NGjVD8yeZTpcxIzNkdOyLG7zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403865; c=relaxed/simple;
	bh=4WyM0AdWxEAbZ8DBkgh+c8d/r+Xm5rEvrCtPJsPTlpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyH6CFpr1jzDyd6VHrmKr6NP+oJKH5rFvGbk3Xul8bX+zSuLoTqPlBTHCTS2W74ZIpzLHYuRupy9/7Q0eKWH6kmJMfS5ASozGIvyz+7i2wATHQ3PWa6kXZEbPt5vVCe+VJ1DS7KViahxFibV8sRRi5qsglhigeQ8rT0LsOUvaiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEYpH0i6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951F9C4CEF5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757403865;
	bh=4WyM0AdWxEAbZ8DBkgh+c8d/r+Xm5rEvrCtPJsPTlpE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OEYpH0i6l649sXqKc7zhL56RIdpDIPMHKjmui0rkCoC4hOYHZh0qm+T38gG0uP1LV
	 2/8rItXgZgc+VaVb9nGNoEd0dzMZQ2oa+lmpzSJRh3VN0oMEuQXsDjafwcJGe9QR7Y
	 2BxJmHxMlVgKU6eiKlV3G/Wa1+pIeFArbbnm4GlKoBHilIecpDHv6ER/f5uR2OuwKY
	 sr6KIT96cDJGbLhmeU/va5qQStKyLzbuTSi5tCIOvkOh3iOXIMp1nQqNN+pUzUaBeS
	 ODlIukMm1se8U/C+2ACnd32u+89CrzOQbG4dIUoe51yi80LsGH4VPD41SeGw7CZokW
	 8iGuPj84nkH0w==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b04770a25f2so714094466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:44:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCavsScfWr+sfVLlC13d5bWEwh2C88qojDuzToeM8OJf/rQn0iCF1flqmYUCoUY+wXviK83WMF9tQNfz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxer9WZ4iqQaL0LUV3YoLT4yFn0FE1nNkLt5onTEjXbcFq6PWUo
	xgmIijjVdzH3tw5JOsuJPw01n54o3KAIo/D9fjQLOLh9zFblslRyS6wp3PkzRWaW8vav/FvYLAS
	kvhfJtvykh3g5HXFGIc3230joc7XlgE8=
X-Google-Smtp-Source: AGHT+IHMhZ+oLMqWLCOD2Z5j9DT/R+U7Agd45tjcYW8JTzXUWCyeZprCu8hKKpGzLPh+gIG5bE+thw8uQfSoC1ZxlYs=
X-Received: by 2002:a17:907:940c:b0:afd:be7d:725 with SMTP id
 a640c23a62f3a-b04b17030b3mr994408066b.61.1757403864156; Tue, 09 Sep 2025
 00:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909071942.1846204-1-cuitao@kylinos.cn>
In-Reply-To: <20250909071942.1846204-1-cuitao@kylinos.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 9 Sep 2025 15:44:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5CjH8i81dGNxaVrzdVUiTwqMUYeuBifQ0wSW_Mw9wSTw@mail.gmail.com>
X-Gm-Features: Ac12FXxf3LaqCs7jXp6D00GcZbiMdW49-LZI3fByvD8rGcT0rmebhzAWov6mjzY
Message-ID: <CAAhV-H5CjH8i81dGNxaVrzdVUiTwqMUYeuBifQ0wSW_Mw9wSTw@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch: Add a check for the return value when
 creating the kobj
To: cuitao <cuitao@kylinos.cn>
Cc: loongarch@lists.linux.dev, kernel@xen0n.name, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 3:20=E2=80=AFPM cuitao <cuitao@kylinos.cn> wrote:
>
> Add a check for the return value of kobject_create_and_add to ensure
> that the kobj allocation succeeds.
>
> Signed-off-by: cuitao <cuitao@kylinos.cn>
> ---
> v2: Removed the unnecessary modifications.
> https://lore.kernel.org/all/CAAhV-H7ECnVeOgf93SEXLHLc4wvhQMjQXDbGKCR-KXKW=
f8Vgtg@mail.gmail.com/
> ---
>  arch/loongarch/kernel/env.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/loongarch/kernel/env.c b/arch/loongarch/kernel/env.c
> index c0a5dc9aeae2..f4ae894f4219 100644
> --- a/arch/loongarch/kernel/env.c
> +++ b/arch/loongarch/kernel/env.c
> @@ -109,6 +109,10 @@ static int __init boardinfo_init(void)
>         struct kobject *loongson_kobj;
>
>         loongson_kobj =3D kobject_create_and_add("loongson", firmware_kob=
j);
> +       if (!loongson_kobj) {
> +               pr_warn("loongson: Firmware registration failed.\n");
The check is useful but the warning is unnecessary, because it is not
fatal for system use.

Huacai

> +               return -ENOMEM;
> +       }
>
>         return sysfs_create_file(loongson_kobj, &boardinfo_attr.attr);
>  }
> --
> 2.48.1
>

