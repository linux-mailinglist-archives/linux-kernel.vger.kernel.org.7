Return-Path: <linux-kernel+bounces-719582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6731CAFAFE0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 11:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F71A1AA2E9D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 09:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDB328B516;
	Mon,  7 Jul 2025 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="D5wg2CKD"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193BE28B41D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 09:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881029; cv=none; b=kiFJjM4oxCC6fuE8iY8A/a2IdYzhzFfd+uEfURKlM9eisoYy42zSuTFXXxOh3W78rzgPD9Ktrlh47uruc+zyzT0k8RfIr45m78s0AsQbppu1bfNYqg9usnAbAa2W85capsep8xc6Sxd1NF+5uBpiRUOOCwV9p/oGdt24j9+/WSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881029; c=relaxed/simple;
	bh=SYLryKLAzyfZUajtOxDGatOvMMnUda+6b5kKcAomvx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o3ANG6XqXvOa5sxtSiSiePWHGp8Gnc1rxsn+tI4ccnp/DxSILCedzIapZoGmkGjm6POmPZPqE5U/rJoIlUGgrpKDuy2LMyjgtC4cIKwoG0hysnWkREzSzp8TiEJYOg691pcog0gORsdUizupt4v52nnTqMpiDLqT+NkS8w9TM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=D5wg2CKD; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-873501d2ca1so51016439f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 02:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1751881027; x=1752485827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VfweRdHv9ufprfg1Atwss0HvbCxmH7kEC9W20OMaU4=;
        b=D5wg2CKDeLHHC3TH+iX9NCGzZSpVlOCJ9u+VGMI7rN08fccH3ubIJ+H3WIkMvxXun4
         bIC7ehkSYeuQXAHdnPZTZu501i+WqavWN62QeHfag+u1JGj1hDhO//0MUsXb6Ggd7M5M
         TmaQXcX/WVVcG7Cs4E7wq0ELHyRfOstKVv0b8dEpHAtg8inyUA+XG/MY79gZl8bkGrwW
         qQJv9YJ9n0qQatUySsw9FXzAcWINLe6URRL5+yOUkm67Ns4zwG6DJ282TMwHLy6h55J3
         Qc+hoWxWt9K6SlzSLcjdq/jpoYugxvY6Izg1pVeVvmM3NxOIgek9uF6RBRZNZWv/ONYB
         1fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751881027; x=1752485827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VfweRdHv9ufprfg1Atwss0HvbCxmH7kEC9W20OMaU4=;
        b=mP4zgxp15ydbQ5UvXJQ3u49vz7QaJ1YvKWivke4GZFsUWXdSmFsVVeZU0dSJiXEJWL
         X5UcaljekYJ3G+6d2yuueseDBOqUpZMGorf2Cy9bFmeZ8CX6yzH384zRppSKNIDiCMXE
         XDqzjg2SEPM66dgMXiX5P50VFJ0tXHbsZ4SIM9iv5nMLkgpLNzfUxyyD0ccSgwMGauU0
         jehWqjynT+eLlpWRvGlHg+SH2Drnp+OS284cRj5mgDq3XvyKZLvuhQbOjvfRjSBidlfJ
         OGXBiiis4OqyfU1hOlspecGju4SMj5qUK/DbSBhD9LEAh3ojZtfiUS1MDkVX+BJGzciV
         ZxOA==
X-Forwarded-Encrypted: i=1; AJvYcCXZCmKjTgxRz/0gioe23Fo+0z3bWtL/hnij7MPplA+xUn10SN6oWZDBtnyEwZ5OeaeXwqXAsloDj5WHzAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTkOo7TctisMSJbFm8BYnsU+xiF0QDhS0zvnSFEeuOL0uHNAwt
	xhxEM+v8ktOc82vMxLKt9tpsL/Yzp7S7GLjY2tbB1f5FOZ28CMbSJahrIU0awnbffJVfoGe2RPY
	ayJw4Bin3TopRlJgS0eoVIYsPSp1pWkQ7Z5Z08td+cQ==
X-Gm-Gg: ASbGncvHhvrEbWevb4zJy/8SnNUApB3uwM/r9iGMCJX0uOQ6aUvUfXlnFb1UGsojiBk
	Hmdo6Ob0yVis0iSF7q2/PRO3sjUboSQfKYynP1RVOyh9gzhkSSRrm0/oHoXqX4qZMMVu6Ud0iVA
	ZG7uQvSJ39D9lmpOx3Sdh+mtiCv5emMHbaFmNqP3xhNNyE
X-Google-Smtp-Source: AGHT+IH+SePIS0aSzniflQp0S8Iw7JaUsbC6szdrpRvO5SkC/AQGSEVL3nboJR1AEhxiDDNFmQa8kIbvcXwwHXpVOK4=
X-Received: by 2002:a05:6e02:380d:b0:3df:2f47:dc21 with SMTP id
 e9e14a558f8ab-3e137204107mr107268135ab.22.1751881026965; Mon, 07 Jul 2025
 02:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org> <20250701114733.636510-12-ulf.hansson@linaro.org>
In-Reply-To: <20250701114733.636510-12-ulf.hansson@linaro.org>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 7 Jul 2025 15:06:55 +0530
X-Gm-Features: Ac12FXxpaKMFAHlr5TcRHSgcV-Hs57tR_KopRD8ZRlv3-fvgnPWZ2ytZglu0vVg
Message-ID: <CAAhSdy1V_hGt8CG4CBVTAeYk07Nbd7aT3WtJrgXhnsj7rUpQvg@mail.gmail.com>
Subject: Re: [PATCH v3 11/24] cpuidle: riscv-sbi: Opt-out from genpd's common
 ->sync_state() support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 5:17=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> The riscv-sbi-domain implements its own specific ->sync_state() callback.
> Let's set the GENPD_FLAG_NO_SYNC_STATE to inform genpd about it.
>
> Moreover, let's call of_genpd_sync_state() to make sure genpd tries to
> power off unused PM domains.
>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: linux-riscv@lists.infradead.org
> Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
> Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xi=
linx ZynqMP ZCU106
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidl=
e-riscv-sbi.c
> index 0fe1ece9fbdc..83d58d00872f 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -347,11 +347,16 @@ static int sbi_cpuidle_init_cpu(struct device *dev,=
 int cpu)
>
>  static void sbi_cpuidle_domain_sync_state(struct device *dev)
>  {
> +       struct sbi_pd_provider *pd_provider;
> +
>         /*
>          * All devices have now been attached/probed to the PM domain
>          * topology, hence it's fine to allow domain states to be picked.
>          */
>         sbi_cpuidle_pd_allow_domain_state =3D true;
> +
> +       list_for_each_entry(pd_provider, &sbi_pd_providers, link)
> +               of_genpd_sync_state(pd_provider->node);
>  }
>
>  #ifdef CONFIG_DT_IDLE_GENPD
> @@ -396,7 +401,8 @@ static int sbi_pd_init(struct device_node *np)
>         if (!pd_provider)
>                 goto free_pd;
>
> -       pd->flags |=3D GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
> +       pd->flags |=3D GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN |
> +                    GENPD_FLAG_NO_SYNC_STATE;
>
>         /* Allow power off when OSI is available. */
>         if (sbi_cpuidle_use_osi)
> --
> 2.43.0
>

