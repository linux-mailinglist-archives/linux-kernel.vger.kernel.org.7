Return-Path: <linux-kernel+bounces-831180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B3CB9BCAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97401B20386
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F38721765B;
	Wed, 24 Sep 2025 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAYq+UtF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F01273FD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758744059; cv=none; b=ixti/YEtu52LiaYIymE2l2szMIu2ZzWPqKg7cJk44ei0GqJYGaCY5LVuzpAbeNj3I3Nllzk2z3eTxYdrmtTQASzsgZcyfhcabh2wPnF2wVUp87WhbwhfAj19VyCD6ojw+oEbnVaCGjoYrzk9Z4CFv0dR9E3ZNvYgrCjcwCXC7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758744059; c=relaxed/simple;
	bh=pv7Wdu3vq+pLKYb3yilVPJd+S/SY274zXqytMR6SqGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtQ8Jfr5fXmHBK8M46gRj4kXzDr/lDDYSiDwVa/j0ux0JefFwQt98FZqyIIY1WRA8kTddCW/DSTpiGqJYmehtOmMt/W34biEU/2ZHB9sSo5tKisv1TKL4EfV22yDmWSHgSutDJdKQM7T2wB0Gu7sEhTih78F8f8YoFHuQdDzAF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAYq+UtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7C6C4CEF8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758744059;
	bh=pv7Wdu3vq+pLKYb3yilVPJd+S/SY274zXqytMR6SqGU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XAYq+UtFx1JzIMwWJI4ecwoTZMlYkCKc6ukhenJSYd164KcEDVmGzkKFoFCRdtL+U
	 w21x44Ib9y0NodUAnSTageWXqh7iDuQL/JL27BVKlN8birhzciVbnWioUj67mr5bA/
	 Mh3jM6bdQKBMNmpCHxpp5bmBg5sSei1CBUnokVirl75oenirJYdSoXhRmfXG+VaIyp
	 M9TnnReUUbPcmrPzQd7loEc0FIhcZFW8Y/7TTFApTFCcpULFd37fJdOlS1QQaLzNV+
	 mmyJJKfm84ci+W+RYxFJWBIJzYKnYdpBoyktOx0/8bhrOZl18toNX/al60vE3uwd2b
	 3Kgbil8ISx4Sg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-342d8f2f507so64510fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:00:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbRMEVLhdODLzOpBx1KrSfQqExnecvAWrmuZOBrQ4Yry7LeAN3BZRdx3pHthe4pyFO8L3gSD8/MUDlGTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV+QHzXhagfAk+iPsjPik2/S6wYfwrRuKyJ2VvPI4SLC5pAKAm
	c+uU4M+NufHRuImiK20Otd+5T5cWeZVT67+1v9WKKOXRUuKmQrwDs9nqeIxDlGfklGOfujYNU4l
	H0jaxOXE8AnI9EOZDSNvRejmnLzbSpPI=
X-Google-Smtp-Source: AGHT+IF2fcqm03lGtDEEmvO+zgdB1dwoBuRGhYKeJ07GD8/szEpXc2Hl71eYWfVldYOJwVzfOGOkGDSN7h9EH7Q/1JI=
X-Received: by 2002:a05:6870:586:b0:315:26b8:8ee8 with SMTP id
 586e51a60fabf-35ee7ac5facmr430116fac.24.1758744058860; Wed, 24 Sep 2025
 13:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923205631.3056590-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250923205631.3056590-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Sep 2025 22:00:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h4ozxCLE1utLLb=iehJq2m6wkAegP08AdhwucNpe0KvQ@mail.gmail.com>
X-Gm-Features: AS18NWDQdDBfi2G_-WKvRjfrd_PiJiisPmjAZjq0fDTTa5pa7XqG0owNNEsrN1A
Message-ID: <CAJZ5v0h4ozxCLE1utLLb=iehJq2m6wkAegP08AdhwucNpe0KvQ@mail.gmail.com>
Subject: Re: [PATCH] thermal: intel: int340x: Power Slider: Validate
 slider_balance range
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 10:56=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> When the module parameter slider_balance is set to the performance
> slider value of 0, the SoC slider profile switches to performance mode.
> This can cause the Linux power-profiles-daemon to change the system
> power mode to performance from balanced mode. This happens when there
> is only one platform profile is registered as there will be no conflict
> with other platform profiles.
>
> Same issue occurs when the slider_balance is set to the power-saver
> slider value.
>
> Prevent module parameter slider_balance from overlapping with
> performance and power-saver slider values by adding range validation.
> Return an error when an invalid value is provided.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Rebased on top of bleeding-edge branch of linux-pm
>
>  .../intel/int340x_thermal/processor_thermal_soc_slider.c       | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_=
slider.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slid=
er.c
> index 20d70cb01542..49ff3bae7271 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_soc_slider.=
c
> @@ -67,7 +67,8 @@ static int slider_def_balance_set(const char *arg, cons=
t struct kernel_param *kp
>
>         ret =3D kstrtou8(arg, 16, &slider_val);
>         if (!ret) {
> -               if (slider_val > SOC_SLIDER_VALUE_MAXIMUM)
> +               if (slider_val <=3D slider_values[SOC_POWER_SLIDER_PERFOR=
MANCE] ||
> +                   slider_val >=3D slider_values[SOC_POWER_SLIDER_POWERS=
AVE])
>                         return -EINVAL;
>
>                 slider_balanced_param =3D slider_val;
> --

Applied, thanks!

I'm wondering though what happens if slider_balance is set to
SOC_SLIDER_VALUE_BALANCE and there is no other platform profile
driver. Will it cause the demon to switch over to the "balanced"
profile?

