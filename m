Return-Path: <linux-kernel+bounces-876066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D13CC1A8A6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EEAF585870
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C044A20297E;
	Wed, 29 Oct 2025 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IRnjwtmM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C6E2C0F9C
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742346; cv=none; b=JXErBVvqa1HfyGbKChrMqJ6lpUgy29lzO9qr9mhxRjuHBcPQVyM3z8tpt+479GT/LLuX0TSiOXAQiUXR4quC7Ha5hTTYrTQm3qN35etRrkWsr45z0kXNcOXLWNScipvclHg7BUzOhHpZ9icdelhoFv/ul65iaWlucImGRcpOeoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742346; c=relaxed/simple;
	bh=WD9EMqtY5DL24YH0FouMSik/1xj4e29em6i20aKt1qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbcwyPLG+LwFLo8qfLkFWXJ1cB7rkccIvMmsqTPaZWACJJz8eJUoSneKyywNIg0LwiU5C66bIfr251pIXxEIf9TNrCysnb8+YZ8kNXI1Y3XVJkTiiG01je1/vNkOlEhgErt4gcV4hSQX4UByNXjLZ9fI+w8SDiVyN4XtnNsNA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IRnjwtmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FA5C4CEFF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761742346;
	bh=WD9EMqtY5DL24YH0FouMSik/1xj4e29em6i20aKt1qc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IRnjwtmMIpE4PFfid0J3Jju6xXLjnRMEOV/8gCobN/Y/nU0JBdjA+qc7M4/fq0AHw
	 6kc7MqmBneT8KcOiT0xl6iF2qJffySGUolAWB+/XeQq+FpMrM+/Ah/gvioQA10g3Tc
	 pvBo2ZVUAejDSoAFZsDaqvhasTh15WtbIKWaArhAmwPn15bswC7pa9zcYKkSeLOFXI
	 /dD9Lq7MR90sEIUacprXdJtCyeFbo9sNpBU8+Hkd5Cz0gGoOSuqLXdZyzD2V97WZHr
	 z0iRUxhm8N9/CJ17d4rv59Uoq9VBIPSXK/niDNlDNgue3uwYtkK4D/tiSkLLlwstaT
	 AXQcN+z4F4B6Q==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-44da449a3fdso2552562b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:52:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4EA0TBCtTFWXrh1t9I9/H4AwYdRbP/SIZ5AFbpxmViv7fR0PKYQQeTR/e4mphuwfVeCc6dhZVLkbrUQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJAnhFC3HmDEziNGWBWD82HWBwM3fSVLWIoHOqFHMKkzFjQHc5
	tx1xc1ZHG+qX/PrTzHoMFnULcHio3fbXlbKosUWgfbziEWFshvPWktMup5wpwlAa31KuK1ONJmY
	OwteDPu5xgVTyaTTRSRkH50tXIgRr5Pg=
X-Google-Smtp-Source: AGHT+IHz5MC1L5WHI4iPMvlWhwpNewNUXtmrTxAhrnnvCJh3KI8D8c4nRHpxFV467AmBxXAtJ87fFJEGmQYPasJKDAo=
X-Received: by 2002:a05:6808:30a4:b0:44d:c03e:657a with SMTP id
 5614622812f47-44f7a4200dcmr1485327b6e.7.1761742345329; Wed, 29 Oct 2025
 05:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017095338.4122406-1-luriwen@kylinos.cn>
In-Reply-To: <20251017095338.4122406-1-luriwen@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Oct 2025 13:52:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h9hz51=wa0DvdyUti4GtQ0UaBorFfDRh_yisSpeYMMkA@mail.gmail.com>
X-Gm-Features: AWmQ_bmi-iUWFPMuT0qtJBT3xKEJMGgyl9TUyxGmvwjtPJ8KHbKShjmD2BG_vEY
Message-ID: <CAJZ5v0h9hz51=wa0DvdyUti4GtQ0UaBorFfDRh_yisSpeYMMkA@mail.gmail.com>
Subject: Re: [PATCH v1] PM: suspend: Make pm_test delay interruptible by
 wakeup events
To: Riwen Lu <luriwen@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xiongxin <xiongxin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 11:53=E2=80=AFAM Riwen Lu <luriwen@kylinos.cn> wrot=
e:
>
> Modify the suspend_test() function to make the test delay can be
> interrupted by wakeup events.
>
> This improves the responsiveness of the system during suspend testing
> when wakeup events occur, allowing the suspend process to proceed
> without waiting for the full test delay to complte when wakeup events
> are detected.
>
> Additionally, using msleep() instead of mdelay() avoids potential soft
> lockup "CPU stuck" issues when long test delays are configured.
>
> Signed-off-by: Riwen Lu <luriwen@kylinos.cn>
> Signed-off-by: xiongxin <xiongxin@kylinos.cn>
> ---
>  kernel/power/suspend.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 4bb4686c1c08..8f022d279635 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -344,10 +344,18 @@ MODULE_PARM_DESC(pm_test_delay,
>  static int suspend_test(int level)
>  {
>  #ifdef CONFIG_PM_DEBUG
> +       int i;
> +
>         if (pm_test_level =3D=3D level) {
> -               pr_info("suspend debug: Waiting for %d second(s).\n",

The message need not be changed, it is still valid in the absence of
wakeup events.

> +               for (i =3D 0; i < pm_test_delay; i++) {
> +                       if (pm_wakeup_pending())
> +                               break;
> +                       msleep(1000);
> +               }

This can be rewritten as follows

              for (i =3D 0; i < pm_test_delay && !pm_wakeup_pending(); i++)
                      msleep(1000);

> +               if (i =3D=3D pm_test_delay)
> +                       pr_info("suspend debug: Already wait %d second(s)=
.\n",

And this isn't necessary.

>                                 pm_test_delay);
> -               mdelay(pm_test_delay * 1000);
> +
>                 return 1;
>         }
>  #endif /* !CONFIG_PM_DEBUG */
> --

