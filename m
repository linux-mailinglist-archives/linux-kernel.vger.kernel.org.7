Return-Path: <linux-kernel+bounces-873718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A05C14869
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8934278E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEA92D5957;
	Tue, 28 Oct 2025 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ka2yzJ6Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D5E2EA473
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653027; cv=none; b=GfFmHyHsAJII/ECpPxWCf1BjVV8oEsjzXdtrHg/N8GPo225/uMYb5C69LDE/PjlGAKd8PDXK3B1A6WHbDliuYx/0YWcj1B9VpkAdwhh37Wn7ujY9WrMj07wlEgo9ib8Ka3LlEFkBKBT/E9ZbNvx32GU+0XFSJXTuV5agZy0w7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653027; c=relaxed/simple;
	bh=NGL+IZJGTIxbqCDdaa88n3D2XlIAHmLG1x6h5o24+AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSus0mgQEWCDCHXefWQWyFJzRlpkPIIH+vZBPRGQLmcyhUXEsO3Q3ahk77xegl3GFfNRI2msaPb8DrEjbpFk8k7Cq9j9Oqa3Bx9xKJ8JqahphdaxUvjFitGL8dSXhaxB9ynNdWfpemloxbnTlBJ2i5RCJZejxlu+xtWBcgtsywA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ka2yzJ6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42455C4CEE7
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 12:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761653027;
	bh=NGL+IZJGTIxbqCDdaa88n3D2XlIAHmLG1x6h5o24+AM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ka2yzJ6YVCcqht6zYotA60ouOMgNIYzL6TW+yPsfl1fLH5835e0SAf6BR/1BJrTL/
	 jBU+ZDqjQDp3/CW5reGTDVfsTc4SWMGDkceSAnB3pqJpYXo0fp1Ie7md80ZKjnRHqJ
	 KGtDa+f5MckIXEn81ma31OC83W3hjRmdkE2JnhLihPsNcamMuKKL6X7j3X3am8XGN/
	 o7lxlMPem3YGGx1YiZ4MAOe99mKElS2Tfu59zzSaQOQpioQk27yrzLYlhwZttr+qyG
	 bGUlgTo0X8UbVzmhphkA4L38GcLFlQ/i3HdtVJXlb7zoohjNCChvMu0igPhICa9kGl
	 i7pIww7iLoOEw==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7c53215c3c8so3727266a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 05:03:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvJty24U0Q1gc6lwBl2wmuXBxKrUfPCqWDXxVxbx2kvGEe1WAkEdNIThARcW/J1gEx29CxQ/aQReTZW4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOrhW4LmlzKgW1DjovWMCCKXNARqpNhaeh4h5hUcset7CoH8J3
	nIB0elA0oRoEVGJIJBibmwB1CaTWxBoeS1wBsAzBoGpls8szdsi5/+fpntLk8OmNej5Cz7/2lm0
	Jjpme8YBu8qHh/063qZqz5sffua+YMEM=
X-Google-Smtp-Source: AGHT+IEbl+yOB806CIHgJBzvgTOTmW/YIaJ+LahZDXUFEDenvFO7sdJjf1V/C6J1whcFN9oW6EKkellD/nj1/P2u1tc=
X-Received: by 2002:a05:6808:c2a4:b0:441:8f74:fce with SMTP id
 5614622812f47-44f6bb54097mr1093233b6e.59.1761653026571; Tue, 28 Oct 2025
 05:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028060829.65434-1-linmq006@gmail.com>
In-Reply-To: <20251028060829.65434-1-linmq006@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 Oct 2025 13:03:34 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h3YMqT9uH+aLxu7SKsqY12AN7R04fRrL8Q+Z4wo0JaOA@mail.gmail.com>
X-Gm-Features: AWmQ_bkQc9jm8EG6beNx1vkq6okGIrtKCtxYZsndpTWZCgkZ3fOY0fn_g05yUDg
Message-ID: <CAJZ5v0h3YMqT9uH+aLxu7SKsqY12AN7R04fRrL8Q+Z4wo0JaOA@mail.gmail.com>
Subject: Re: [PATCH] thermal: thermal_of: Fix device node reference leak in thermal_of_cm_lookup
To: Miaoqian Lin <linmq006@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:08=E2=80=AFAM Miaoqian Lin <linmq006@gmail.com> w=
rote:
>
> In thermal_of_cm_lookup(), of_parse_phandle() returns a device node with
> its reference count incremented. The caller is responsible for releasing
> this reference when the node is no longer needed.
>
> Add of_node_put(tr_np) to fix the reference leaks.
>
> Found via static analysis.
>
> Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initiali=
zation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/thermal/thermal_of.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 1a51a4d240ff..2bb1b8e471cf 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -284,8 +284,11 @@ static bool thermal_of_cm_lookup(struct device_node =
*cm_np,
>                 int count, i;
>
>                 tr_np =3D of_parse_phandle(child, "trip", 0);
> -               if (tr_np !=3D trip->priv)
> +               if (tr_np !=3D trip->priv) {
> +                       of_node_put(tr_np);
>                         continue;
> +               }
> +               of_node_put(tr_np);

This will also work because tr_np is not dereferenced below:

                tr_np =3D of_parse_phandle(child, "trip", 0);
                of_node_put(tr_np);
                if (tr_np !=3D trip->priv)
                                continue;

but a more general question is whether or not device nodes used for
populating thermal zone trip points can be let go.

If not, then this change needs to be combined with another one that
will prevent them from going away.

Presumably they need to be reference counted in
thermal_of_populate_trip().  Daniel?

>
>                 /* The trip has been found, look up the cdev. */
>                 count =3D of_count_phandle_with_args(child, "cooling-devi=
ce",
> --

