Return-Path: <linux-kernel+bounces-814603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BBFB55651
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3E81B22AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114F218E25;
	Fri, 12 Sep 2025 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UaePTPzt"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA62A1BB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702234; cv=none; b=Dtqyh0FkUgwuC7t6301qCrB9x4wFBekzG8jEZqXLMpN9dwPLQcieY9EI6ZKgVQQ2Yyw9DBQ7NmzQsMAIm/7907eWfKcBLIzFPmOBTn0RgGl1cV4mub19MT491qhMU2sCZyyIeII0qSqjKKlz2SlbQAbvXnWBl9NwU4B5zBSMxcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702234; c=relaxed/simple;
	bh=+uLL73ESbQiAGHCJIihKVzb4SWfooEbOCP6UJcEcy2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1LOfQ9kdlkdPA8xYs3FXT1aborVoIGpP+2IkTi+1mP03b2o1Uy5U0RenmhaAYK0BFpi2xNvta/KD+NWnX4CXyECtiFJzJDwflrRTdzUUD2vj/Y5y4AZp5x+jt1+ZZueZENzQrRM0vOSz6SEchk423CqY13iWHIi1TkpVrQOjEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UaePTPzt; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5449fc0a7f1so1802437e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757702232; x=1758307032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5LpCqgd6cuTc0c8Co1kvdyn21Z6xUMeh+u0WbfeIVU=;
        b=UaePTPztSeWrg3Sba+DqsU2RM2fVzVF5j+qzJFqS9RY23owhOVHYqKUWin0i+Xj7rv
         TQw9Dfp4LjepuvvIL2opMHwtqANq56feFetX3UtIifOsft68LB4ksFc7Y92dmLOn96ct
         PgRe/BJJIghp8SC31HA2Oo2UxjzhHGZHaKf7E+uHUapnBYL4Dex1NkvjzhPgTAKyQCSi
         i/1QbN7TCX/CS0JJeEs9pEgdQ8BY314Y8xOHiYeSLcTFUTXSWRgiPbWakFWi9cbSwdF/
         vOS8ftCb5LEQJ/uX9j0uiCdNrPdHs2AC8gtL/WH1iAkshl9tGufwTvaPrGe8kbYeSekc
         7/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757702232; x=1758307032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5LpCqgd6cuTc0c8Co1kvdyn21Z6xUMeh+u0WbfeIVU=;
        b=sa+ArnCwaYqCCTB4cn3rcvnCsDEv0UdSJIpyARpGEIJD6/Jw9w1DoiG1ZzXrKyJeA8
         1jRlrV7EiBbrYipHf8qOBYZi9UzYvwgP/udOhWxwZAEhHbsauJav4i5t2/oQS6uqG2GZ
         s9FypRhmkdZ7rdmb949M68tgZrOf7II5NZW7wpf4Jh8mYISNUFkVjKGkdQ+oOefE6vjN
         OJ9SfRImuEX6IkVokTHkewbhXFoOHYUoxLb19oANdXv3TuLsoCZuponQ2VqPc0tu9ZJp
         89+BwUtbAqiTSui8dxct3Xd+/Qc9oqEqqMWi+Bzs3pNqfByZ2ZTuRrk+xEffCiofdhMX
         olyw==
X-Forwarded-Encrypted: i=1; AJvYcCWvkTYTsVHx+VTq/nfIUWZW6tzAZMXPpuHvXyrLeTm0iOUoabcTKNfkU0IHVhExfbbaR7yPJkc+qZX+euA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIeRCo00hY+kKtqjdLJYSnYNa5tFip2dYWPRaAonOBvNxucc/S
	j0M2R8sAIqPwXtOfwKoF/6SRSG9lwWFWpKFg4rxWvxpGGs7B/1i+qPIZCDxM8PaTmwAjCnDKYPa
	NKnEmKgMsM9JCkNBU8Kn2vxhimfR0Ctu5x7662UBa
X-Gm-Gg: ASbGncuKeFyzueeaNk7U7OJ/by6CCvDMDp5QLc5fM7tB7UBd6UJ63aMbl/CvcBDU8EL
	3Nc6UGyePtOLVNoNYBlEjH8+BDe7VEePVUrH+LwgGlersIuUNVUhRJKXjdoZXn/vryIZ5dX02Ap
	dTSoyhZ1QGKWolVveQ0wR4H6a2Fs3xQ9nlecYIHhgYREwtalPULFoYu0dA3/A8St3NL+glAPqgg
	62BcQSR2lCt04yZmu97DEQ=
X-Google-Smtp-Source: AGHT+IHUXgE+IihNEnKdjmOQEwLekUUvu3+aWzgDFOUfZi4sULxM7CrV7gKrH879sJaDGgzOnRIOHdgF+J3gqIizJi4=
X-Received: by 2002:a05:6102:3a09:b0:525:3802:c260 with SMTP id
 ada2fe7eead31-55608e9e69cmr2203452137.3.1757702231508; Fri, 12 Sep 2025
 11:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909111130.132976-1-ulf.hansson@linaro.org>
In-Reply-To: <20250909111130.132976-1-ulf.hansson@linaro.org>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 12 Sep 2025 11:36:35 -0700
X-Gm-Features: AS18NWBJYwHlx6gFzPDiQm-A363FKAFgsm5_uMk29VFYTcWjd5qUP9Ell1HnVXs
Message-ID: <CAGETcx9W5MXyHA2r1kDh9=WJiQWLF1xdPaSCH=jXYeAHqQW60w@mail.gmail.com>
Subject: Re: [PATCH 0/5] pmdomain: Restore behaviour for disabling unused PM domains
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, linux-pm@vger.kernel.org, 
	Stephen Boyd <sboyd@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Sebin Francis <sebin.francis@ti.com>, 
	Diederik de Haas <didi.debian@cknow.org>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 4:11=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> Recent changes to genpd prevents those PM domains being powered-on during
> initialization from being powered-off during the boot sequence. Based upo=
n
> whether CONFIG_PM_CONFIG_PM_GENERIC_DOMAINS_OF is set of not, genpd relie=
s
> on the sync_state mechanism or the genpd_power_off_unused() (which is a
> late_initcall_sync), to understand when it's okay to allow these PM domai=
ns
> to be powered-off.
>
> This new behaviour in genpd has lead to problems on different platforms [=
1].
>
> In this series, I am therefore suggesting to restore the behavior of
> genpd_power_off_unused() along with introducing a new genpd config flag,
> GENPD_FLAG_NO_STAY_ON, to allow genpd OF providers to opt-out from the ne=
w
> behaviour.
>
> Kind regards
> Ulf Hansson
>
> [1]
> https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.or=
g/
> https://lore.kernel.org/all/20250902-rk3576-lockup-regression-v1-1-c4a0c9=
daeb00@collabora.com/

I'm surprised this is happening. The default behavior of sync_state()
is to never turn off a power domain until all the consumers have
probed.

Is there a consumer that's not captured correctly? If so, can we add them?

Also, there are already sync_state related kernel configs, command
line options and sysfs files that should allow people to power off
devices (at different levels of granularity) even if its consumers
haven't probed.

Thanks,
Saravana

>
> Ulf Hansson (5):
>   pmdomain: core: Restore behaviour for disabling unused PM domains
>   pmdomain: rockchip: Fix regulator dependency with
>     GENPD_FLAG_NO_STAY_ON
>   pmdomain: renesas: rcar-sysc: Don't keep unused PM domains powered-on
>   pmdomain: renesas: rcar-gen4-sysc: Don't keep unused PM domains
>     powered-on
>   pmdomain: renesas: rmobile-sysc: Don't keep unused PM domains
>     powered-on
>
>  drivers/pmdomain/core.c                   | 20 ++++++++++++++------
>  drivers/pmdomain/renesas/rcar-gen4-sysc.c |  1 +
>  drivers/pmdomain/renesas/rcar-sysc.c      |  1 +
>  drivers/pmdomain/renesas/rmobile-sysc.c   |  3 ++-
>  drivers/pmdomain/rockchip/pm-domains.c    |  2 +-
>  include/linux/pm_domain.h                 |  7 +++++++
>  6 files changed, 26 insertions(+), 8 deletions(-)
>
> --
> 2.43.0
>

