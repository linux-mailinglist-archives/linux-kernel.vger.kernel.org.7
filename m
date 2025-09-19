Return-Path: <linux-kernel+bounces-825216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAAEB8B4D4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5AA17594B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B682C21D8;
	Fri, 19 Sep 2025 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApVwj5H8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E239B2C0F7D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758316398; cv=none; b=AJ7wb6SFRB5GC2ssFxnNe7TOIzeFxX9/QbX+3D9LArqtco6mJiMQ7jCNzaVK3wt0oHTK3ODFFtpDclf64JSqyP7aFslW7WzYJSjFua2tBzNJYy9o2P5UvMqUPf6323HvKZebTndoDTmLY5Jaea5XV+r6gnJS6UnFoeYMwXoOLnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758316398; c=relaxed/simple;
	bh=1LBZm3tViyEk9WGaszF/av9kAKvUmA0Io1A5lN/1dZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsT/pgGgbUKlCOZvDwfcsBVbIMNeHh2qJJsh70/cQprgloK2PDgIJQXw+zWmV+cO1c1K5/B7YgXXH1T/v4W9+V0zdMPxPQhU+1u6FIaiwZ89dk+/KU5VGp87eONZAPzBcVfIw3NdeBHpU2tEKfzB/SWCca5oQsiTyBfPz/8y2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApVwj5H8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975E9C4AF09
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758316395;
	bh=1LBZm3tViyEk9WGaszF/av9kAKvUmA0Io1A5lN/1dZo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ApVwj5H8ttH2IulpCgrBg6J61DErEa+Utr7mDJJehyEkTO+S8miKnVRp17Lo+xckL
	 hEkkaqTkFAKSBge45o5M+xX0eOeWDyg3uZXmqojN7xYK5F7K/JoPZdjmlyuYkr4Au8
	 TtzhVLuUD46704cLAeUeVnqdX2P4iI/PSmbS0OVETVAX5mnfXb9LIZ/7CKAj5xXcFw
	 uG+QD7iiCFq3VmKNbw90UzV0Wp+dfTwuJvcyHmkJvbEb4OJ3c33NqGSbpHwC5Hheih
	 8GJj171ro/y3UEXKt/fmAhzYiQ5smEYZTgVPermnChpPKpYGcyekDEI3SUpD0+hYEg
	 7mnlcSxIZ5x4w==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-62189987b54so1384329eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:13:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpW30gZJ/Ocz8wiXyi6g8bUBVRdQnptcbf4K1ERdkNXxgiGLJxb6es4Y+MBxQH9oRGwy+0nNPTde4B0IA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyirk4GV1cFdUgYzBQvt1ENK3+TFMs8Dp+G0NmAf78HCjkQgPHR
	EXpT0BPFOKATEKj0EG2coTXIpEJNvg0qCxGGqCbONdOCqdY9xULfKdL3uIEEQATnCyx7hwhPWcw
	Qgfbi54JMjw4xzNbSEM/a76gYorvVIk8=
X-Google-Smtp-Source: AGHT+IGrZ2HA8FzwQTb4wfxWm0JgX+FFPpSWCNkTt8xhrFxqOZm12RFgGMRNz7CcJstpbEB9LUbsULzu0tyPgfQMhGQ=
X-Received: by 2002:a05:6808:7003:b0:439:aeb9:88fb with SMTP id
 5614622812f47-43d6c18d966mr2642320b6e.17.1758316394912; Fri, 19 Sep 2025
 14:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908085738.31602-1-zhangzihuan@kylinos.cn>
In-Reply-To: <20250908085738.31602-1-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 23:13:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hgku5V-3GNVH2w8GT2JzkHOU2NZkfHdrRDT-Hb80tuuQ@mail.gmail.com>
X-Gm-Features: AS18NWDehhhPB2xlBMFibfeDQnR-pUHpEQp9MKkCkOVUsCVFU0wJxcZWkJDLnb4
Message-ID: <CAJZ5v0hgku5V-3GNVH2w8GT2JzkHOU2NZkfHdrRDT-Hb80tuuQ@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: Add defensive checks during driver registration
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: "Rafael J . wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	zhenglifeng <zhenglifeng1@huawei.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 10:57=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> Currently, cpufreq allows drivers to implement both has_target() and
> has_target_index(), which can lead to ambiguous or incorrect behavior.
>
> This patch adds defensive checks in the driver registration path to
> prevent invalid implementations. For example, a driver is no longer
> allowed to implement both has_target() and has_target_index() at the
> same time. These checks help catch driver mistakes early and improve
> overall robustness, without affecting existing valid drivers.
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  drivers/cpufreq/cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index a615c98d80ca..cead6d4fa1ad 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2922,6 +2922,7 @@ int cpufreq_register_driver(struct cpufreq_driver *=
driver_data)
>                 return -EPROBE_DEFER;
>
>         if (!driver_data || !driver_data->verify || !driver_data->init ||
> +            (driver_data->target_index && driver_data->target) ||
>              (!!driver_data->setpolicy =3D=3D (driver_data->target_index =
|| driver_data->target)) ||
>              (!driver_data->get_intermediate !=3D !driver_data->target_in=
termediate) ||
>              (!driver_data->online !=3D !driver_data->offline) ||
> --

Applied as 6.18 material with edits in the subject and changelog, thanks!

