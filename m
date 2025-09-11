Return-Path: <linux-kernel+bounces-811694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7CBB52CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AEE486EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB42E7BB4;
	Thu, 11 Sep 2025 09:07:20 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EBD2E7646
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581639; cv=none; b=BeW8kR3IJBcdXKwuBs0FEuAk7bAEikCeHFhVvvv2boD5ywRwHvayEMJrJ+qsn6KOBOwpBpsrKJxQmHRnED9SNvFRvJEFXEnC6uxXoDFOMvlg51A5xti0qNm4f1ig4zM0/gnmx5aBtUZzlmIBfSuObbSazUd7Ds9zdOT4DVyZs3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581639; c=relaxed/simple;
	bh=ICmlsaYKwcvKV+REXNGRI/oYch0wW2QWDCRm+WbsTt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4VJUqL42W7o2RQ4AJoXHKI97m7MqclyUyeEwWG1b6er/QiS76lYgTsMv9swjwhvXNNu/HXco0C/3I+wMA+2rvbN0+ZCIjUHGDQteA6KQ4a1/7H+4v31GQJzuTc8lRV/pJyuEeJ8ZCX+ht3dShJKfsT22nrJq0lZ4eg6tUxBGho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-70ba7aa131fso4447886d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757581637; x=1758186437;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ma/6vP6cw0Ynsztpbgjyb4FEYEjAJYKzRW150ld1Q7A=;
        b=AlOdVVkfTnMEGLWNbqns23wMUvGyEZbhosF91h5nGl72PBvXCjNMA3AFg4f25M84vZ
         YelqfuXPtM/MqSiDv/9QXYzOOLqa9yB/vuu1e6nIg6uuBXsE/1UFs0GZxc7mhAigHhZU
         Ybkvhby+n418s99zWuiw/oDVzrnVReIdSd3S9zk7WtWCDJgkr2OZ+0+eviAD+hiSlYmK
         lBnx7JxYyxp1pTHBEbRkvNG8qxgDECRvZSeUyPj0Hpox1z5IEuLlJXnbCsTp2JL4Ibfk
         sI+gJJLUgovR533zTJ4sSW+0bK0BYkvaT6Iz9OtHnGh4Gfg+9IAZzrRN985bB9xM9sbx
         5Zmw==
X-Forwarded-Encrypted: i=1; AJvYcCVD3OVSHvxtMYwRpqshK0YGS0LdxKNBDIArBQwHjqWkh2D+/STE8vIcFTEmbGPCGFnGdKN8FdDwy+f1LBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyncfLANa8k5w3xegqBylv+vDND21zNLP6P/1u48SreoSjrF4+n
	Kj7FhRkD+jqsin2uCX5DIjCjCckilGDQWJTPSYUlCKrNVmpVaBsNO9l1fTQthlL9
X-Gm-Gg: ASbGnct8CcFON2paXigpuxUZ/e5E+fQayTRdUhVB6IzTPT+mtK6Awtm31XB7V0wBb36
	WSKosOggCqb8TIMDz/ngqpMFBW+a7XVi4lK7xS3taJWoRObVDFUh8FVF1CbovlfnLENRfTaCkF3
	ssY52RAeanuDzoQIun8kichmOdUwI8BpHE+Dk46KcWXcY1/XG3oBpssFZKKWpetotgYM+vJtcXR
	iv010DX9qSc8u3ZLmXtPHS802/8C35CwM5oUA+SJGwivdtfpf3xACggiU1ABXGAzk98/JLnDnia
	Mx+fa3p4ELgol/A7Duq9bOlB5vkSJOrAcxLsGGY5fCYBitIDeQGqMRrlg0Bc23U8LF7o5Nj6yfq
	BReQ8UMcPdZkw8/lESta95Idm3XQvCby6FfSxk7v3yDfejUWVDjGUFvz1yD+Ii4V2
X-Google-Smtp-Source: AGHT+IFaeSgOCQ6nPrpBcAsAn5xyxZ4WOBw16TTet05v6iKUXQruhqMBJOUz5Bbe9H4l2kren1G3WQ==
X-Received: by 2002:ad4:4ea7:0:b0:763:4dd3:feff with SMTP id 6a1803df08f44-7634dd40baamr16945496d6.57.1757581636990;
        Thu, 11 Sep 2025 02:07:16 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-763b670a402sm7514926d6.31.2025.09.11.02.07.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 02:07:16 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e872c3a0d5so43413885a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:07:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuhowttKUy7g0NbCHDVIa0GSdnxhPZ+MvvjK1l5+UtdaeAN/q4tDxQ7wr3miZr7zm2BH/4eOI86HoeHEg=@vger.kernel.org
X-Received: by 2002:a05:6102:3e0b:b0:522:1013:cace with SMTP id
 ada2fe7eead31-53d1c2e1cbamr6471994137.10.1757581321304; Thu, 11 Sep 2025
 02:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909111130.132976-1-ulf.hansson@linaro.org> <20250909111130.132976-4-ulf.hansson@linaro.org>
In-Reply-To: <20250909111130.132976-4-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2025 11:01:50 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWB05sQpv0nKgU2NNn4=KAmNCpHhAnz3s15Gopu8FKVkQ@mail.gmail.com>
X-Gm-Features: AS18NWB_6gJmqKrqPl8hBI-saW-lKUrGeAKCkd2NAqUJ0GfWChjmTWPU1ec2v1s
Message-ID: <CAMuHMdWB05sQpv0nKgU2NNn4=KAmNCpHhAnz3s15Gopu8FKVkQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] pmdomain: renesas: rcar-sysc: Don't keep unused PM
 domains powered-on
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org, 
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

Hi Ulf,

On Tue, 9 Sept 2025 at 13:11, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The recent changes to genpd makes a genpd OF provider that is powered-on at
> initialization to stay powered-on, until the ->sync_state() callback is
> invoked for it.
>
> This may not happen at all, if we wait for a consumer device to be probed,
> leading to wasting energy. There are ways to enforce the ->sync_state()
> callback to be invoked, through sysfs or via the probe-defer-timeout, but
> none of them in its current form are a good fit for rcar-sysc PM domains.
>
> Let's therefore opt-out from this behaviour of genpd for now, by using the
> GENPD_FLAG_NO_STAY_ON.
>
> Link: https://lore.kernel.org/all/20250701114733.636510-1-ulf.hansson@linaro.org/
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 0e789b491ba0 ("pmdomain: core: Leave powered-on genpds on until sync_state")
> Fixes: 13a4b7fb6260 ("pmdomain: core: Leave powered-on genpds on until late_initcall_sync")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

> --- a/drivers/pmdomain/renesas/rcar-sysc.c
> +++ b/drivers/pmdomain/renesas/rcar-sysc.c
> @@ -241,6 +241,7 @@ static int __init rcar_sysc_pd_setup(struct rcar_sysc_pd *pd)
>                 }
>         }
>
> +       genpd->flags |= GENPD_FLAG_NO_STAY_ON;

So this applies to all PM Domains.  While this doesn't hurt, perhaps it
should not be set for always-on domains, and thus moved up, to become
an "else" branch in the "if/else if/..."-logic handling always-on
domains at the top of the function?

This applies to rar-gen4-sysc.c, too.

>         genpd->power_off = rcar_sysc_pd_power_off;
>         genpd->power_on = rcar_sysc_pd_power_on;
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

