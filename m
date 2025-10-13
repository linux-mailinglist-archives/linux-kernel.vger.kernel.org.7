Return-Path: <linux-kernel+bounces-851195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98815BD5BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25D94212FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8037E2D6E7A;
	Mon, 13 Oct 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5ibWWF0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A3E2D5955
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760380556; cv=none; b=FiK5i3Zgg/YuX/XvPl882PgycC/FTfBzb74A6/PqzjRUd4Y8J4/7veOvkNGSL4T0LjXt/aBnsYZGds4WIQBOTGhW8B8qZu9sBg8UzA1XCDOJ0EVd7Rkt6nHvL+uXz3yxIEuNXCQZcgjo3zr0Vd29IysSbx3OQYzWXKiF+CqsxEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760380556; c=relaxed/simple;
	bh=zJB6NmYQd7LUbWynkjqCiC8IVIQo06Gd1NNqWWbfhgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDIJfQ+KTMTwrJdsc7WS3I28kou5OLB8i1L5/q932AYcXoMilGlUAJHCAn4ZTm/q0tQqTmKODVks+rAHZGCLCgRQzILGlPG2E0gKW5q2276/wDh5eOYHivpg2UFTMUKQ3+O0iNmo5xOdABd4/PS0254plw+Ga9CLrhWqKIJKH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5ibWWF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C98C4CEE7
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760380556;
	bh=zJB6NmYQd7LUbWynkjqCiC8IVIQo06Gd1NNqWWbfhgo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B5ibWWF01JOByorqAmYB1lR2QxHCL4+ygDhS774yxU8EyuqDikgp7P6SERD4Y8VwH
	 aQFzC4OTJHVedAhZwNK68RojRUmnd2RK3gTjFXl45Je3q53k0tB19aY7dG3Md8V/9x
	 ITARKjX9ijIlTiuzo6XTD8qOE4oputN/hTjBkDBuzvSYPVKkSyE7pk7Twr7NWiCg99
	 BCx29GZOI0A8XahCWKNzy2/J4fDguTVqwbARFYWxZoXkSFW0WN7YSrh4xm66xqjN2J
	 ERXbGswTyRnNc3iXatn6BUwj3ri0eLcE+JbTwAmAQ4hzmbvjRqghwtSsnGRSkNX5/4
	 7SYGKH6sUPJxA==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-43fb0baa305so2377098b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:35:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0ugKsLQOOqL5r+WQXEtQnr+IThBIE+HM/GG8iWtOGHfkY6JW8jqRCqISz+QCDPqMn39yyLhzDDxzULGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwncAIDT+0TcYuBtfHzZQ6C2nAViBtSnJkZnnIgf1DTGkn1DxvK
	hwBGPazeXbqpJvVqyWZ2lHDGaOqtcwSLlj9ZkWZF5Ff0U55Faw0wYPY7q3qDKlK/+7qVb/YWPLJ
	nbcvT3aZ0Y8rhGp6hqbunaE/+EMJHCVQ=
X-Google-Smtp-Source: AGHT+IHOQjWU/7yBEhHdOZhc6hKTgqTojZ/jcwV1r5BMnvXK+M2EkuWqdsFSSZm72loMz3KtLCr9SfC3Z+Sgk0EbSLo=
X-Received: by 2002:a05:6808:50cd:b0:441:8f74:e98 with SMTP id
 5614622812f47-4418f741d79mr7368955b6e.66.1760380555988; Mon, 13 Oct 2025
 11:35:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757680816.git.luoxueqin@kylinos.cn> <1764e5db50a9e6a7809f0ec59a7b59e66c1f155f.1757680816.git.luoxueqin@kylinos.cn>
In-Reply-To: <1764e5db50a9e6a7809f0ec59a7b59e66c1f155f.1757680816.git.luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Oct 2025 20:35:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0go3fOmipsBmmqS9xbKA8AbnMqtu52XsrV3iGYEGhegZw@mail.gmail.com>
X-Gm-Features: AS18NWD0PxPs2FXqcTaQpzJxIbymhsAKIH4iAY_tkeD4okFD7WV8j5ct_zMNqok
Message-ID: <CAJZ5v0go3fOmipsBmmqS9xbKA8AbnMqtu52XsrV3iGYEGhegZw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PM: hibernate: make compression threads configurable
To: Xueqin Luo <luoxueqin@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 4:23=E2=80=AFAM Xueqin Luo <luoxueqin@kylinos.cn> w=
rote:
>
> The number of compression/decompression threads has a direct impact on
> hibernate image generation and resume latency. Using more threads can
> reduce overall resume time, but on systems with fewer CPU cores it may
> also introduce contention and reduce efficiency.
>
> Performance was evaluated on an 8-core ARM system, averaged over 10 runs:
>
>     cmp_threads   hibernate time (s)   resume time (s)
>     --------------------------------------------------
>           3             12.14              18.86
>           4             12.28              17.48
>           5             11.09              16.77
>           6             11.08              16.44
>
> With 5=E2=80=936 threads, resume latency improves by approximately 12% co=
mpared
> to the default 3-thread configuration, with negligible impact on
> hibernate time.
>
> Introduce a new kernel parameter `cmp_threads=3D` that allows users and
> integrators to tune the number of compression/decompression threads at
> boot. This provides a way to balance performance and CPU utilization
> across a wide range of hardware without recompiling the kernel.
>
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  kernel/power/swap.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/power/swap.c b/kernel/power/swap.c
> index f8c13f5672ec..dfa9b7c0f96c 100644
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -519,8 +519,8 @@ static int swap_writer_finish(struct swap_map_handle =
*handle,
>                                 CMP_HEADER, PAGE_SIZE)
>  #define CMP_SIZE       (CMP_PAGES * PAGE_SIZE)
>
> -/* Maximum number of threads for compression/decompression. */
> -#define CMP_THREADS    3
> +/* Default number of threads for compression/decompression. */
> +static int cmp_threads =3D 3;
>
>  /* Minimum/maximum number of pages for read buffering. */
>  #define CMP_MIN_RD_PAGES       1024
> @@ -741,7 +741,7 @@ static int save_compressed_image(struct swap_map_hand=
le *handle,
>          * footprint.
>          */
>         nr_threads =3D num_online_cpus() - 1;
> -       nr_threads =3D clamp_val(nr_threads, 1, CMP_THREADS);
> +       nr_threads =3D clamp_val(nr_threads, 1, cmp_threads);
>
>         page =3D (void *)__get_free_page(GFP_NOIO | __GFP_HIGH);
>         if (!page) {
> @@ -1257,7 +1257,7 @@ static int load_compressed_image(struct swap_map_ha=
ndle *handle,
>          * footprint.
>          */
>         nr_threads =3D num_online_cpus() - 1;
> -       nr_threads =3D clamp_val(nr_threads, 1, CMP_THREADS);
> +       nr_threads =3D clamp_val(nr_threads, 1, cmp_threads);
>
>         page =3D vmalloc_array(CMP_MAX_RD_PAGES, sizeof(*page));
>         if (!page) {
> @@ -1697,3 +1697,19 @@ static int __init swsusp_header_init(void)
>  }
>
>  core_initcall(swsusp_header_init);
> +
> +static int __init cmp_threads_setup(char *str)
> +{
> +       int rc =3D kstrtouint(str, 0, &cmp_threads);
> +
> +       if (rc)
> +               return rc;
> +
> +       if (cmp_threads < 1)
> +               cmp_threads =3D 1;

Why not use the default (3) here or return an error?

> +
> +       return 1;
> +
> +}
> +
> +__setup("cmp_threads=3D", cmp_threads_setup);
> --

