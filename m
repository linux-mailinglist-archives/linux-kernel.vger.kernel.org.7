Return-Path: <linux-kernel+bounces-841752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42D9BB8238
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC3B3A7125
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50021256C9B;
	Fri,  3 Oct 2025 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlKvIP96"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24BB3987D
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524473; cv=none; b=YpGdWrtDpET3b+RownqLELDzX/TaFIHOeYFA1O16o7zKs5NP4TH+DxKfdf1rbB0Dxt/7KB3SMpvxU8LTMgLTBMXhLc/m7Ps2LyJggaSwK0tiSuiLVaCgGeW774aKAW8heAor9BEjD4g4KgZyvr+joQtCqc2HGeMd8l8dkuKncjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524473; c=relaxed/simple;
	bh=MHoXLWg3HvpW49PRCoLLv1E052ODwx10RLVlPGCpiHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIHTt6k4wWh25l+CnXgKVKOgU8gKxs/Bj4PGElcSOKpLXqnan6vv56aq5aF7buN57Vb8uA6RAbZQCiU/EFVxoJajv0kRJTBYQPHEtTHiAMM59iKD7tHIzkYK1Su8eO3Hxd8YyL2QHtbtSkeLy9jD+qhyfzpSeSgQu6UyG/WomOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlKvIP96; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7501c24a731so32082197b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759524471; x=1760129271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ec07GK8IeebwUTlhOReO08byQCiI8XurDvMqhbTfpDs=;
        b=hlKvIP96ETlMNTcctkUps4Rp3bu8GayWk1dye8kfWKZeJmZPrn2xu5PWNK7tcDcnca
         8J6QOoYZz/UczJ53iUQ+ODjzYaCL9jCFbfKm5I5zDM/Y0qY8SHgfjS3ANDkQR3I7BV0N
         YTiCQm7+Z0opwMD0G7QvJa1N6+eytVQ5jmmM9pdfY+7uAEARJ1egzvqFrmhpoB+QmYwW
         L+pOCGclpsgtNd3b1VBcf+8oB6iuUAE1kC7KKnm9nXNMHV07GGi+b3wgj0JmqB+Vm2ZZ
         M9/8wI00qisEY3O42//cOu7x4TKc5BgSKtFRDvD63/pV2RGbhLo8fIoflI1ej5TRnpv2
         95dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759524471; x=1760129271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ec07GK8IeebwUTlhOReO08byQCiI8XurDvMqhbTfpDs=;
        b=Bo5L1e7RX8FYL93kgu/Pt8vY3gzC7XJpIF/tSHRVuwH+CFW0KCSapb66HsQDnRmwMM
         CwEER/gJwebuj/kLemeuBickBH/5bHM/0nVfGBVlwVFtRPSGf85XFNEo8EIDDZHdUAKR
         VI8nL621Ztgw7/KGBjlNVkFIQ+vBi0LQmIUaWMHV7F2AZHERcBOjfa8DU5yvfzeV1dMN
         sEoIruNlkhpujgs52lLjug/Kcnu49LhGIb9+kxM7YLmqa90raEf3rIHlXe9RU+A0iJRZ
         Q51FOWIWjx4Tucsf6gRjYDseUre1Akk9UWfQHYQfZnctmeq9PKeyPHX4g55sKvMwtIqq
         GMCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG0KlEaY3QRNZRPprO15gKy22feF9qZynd66Yl7rZKJDxJQPY3VIeIu0EWwsSmRYzzkhQ6CY4ofBr0ilI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOee1cuAqIT8ezp0+BgZsyOTEtNvudWl5rIlJ2OQqJKms1eJO
	Y0XMHEoOeusJwR4vH+Nmy8tzEzqQy8beQNKB8NNKNNsTm7GXNzUy1xSLh+f42udGE3jhtUVZmnz
	umZkhEVC4stxKsqbZ6IHjsdJdpv4+l2g=
X-Gm-Gg: ASbGncuZSgHwNxqmwDNvZs/YijTSA3VbfJ2SzXJVTD8KDjTTP4xJOV9fa/UiGE63IL6
	G5PLu4Mavq26o6dOIIkxUt7E1uyo3iB38YDXXT/cdeQpP5/Nqdi9DOtcUNqFO8SoZdri+L44Nic
	ak7/3zq3jhLKUlaX2Bhenftn4Es2KlPp2PMxyvkI+Knixegks8HFkQSL0jGEJTqLIYMIDqo1JkM
	xkP/i+RslcNxI6+8HbKOHilOSq5VqQK5sBS9tDpsxOxQDMaWbmVzp4cSB75kgeen814jwcIEbby
	rHuulh5kGm2OdvhB5S9WTA==
X-Google-Smtp-Source: AGHT+IGbRtPbh98BClkNFwaUaMJb45w8kt4Jk0KxRGScag36Tw0xGWcnBknxDwxYEhQPRsDsxQjX2aqyBPDcA2KuG7Q=
X-Received: by 2002:a53:8550:0:b0:638:53e9:bab0 with SMTP id
 956f58d0204a3-63b9a0ee753mr3639824d50.24.1759524470895; Fri, 03 Oct 2025
 13:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003-mt8196-gpufreq-v6-0-76498ad61d9e@collabora.com> <20251003-mt8196-gpufreq-v6-6-76498ad61d9e@collabora.com>
In-Reply-To: <20251003-mt8196-gpufreq-v6-6-76498ad61d9e@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 3 Oct 2025 13:47:39 -0700
X-Gm-Features: AS18NWBGD0pXXLOymrZv-_f8nOh4HIhBGy-SAER5xKOoIW_DOui92j81TfsOhUs
Message-ID: <CAPaKu7Q==RvuZR-pgJekF++Y4HOdkryEvYV8QGJd_os0_if_vQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/7] drm/panthor: Use existing OPP table if present
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Steven Price <steven.price@arm.com>, 
	Liviu Dudau <liviu.dudau@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@collabora.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 1:16=E2=80=AFPM Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
>
> On SoCs where the GPU's power-domain is in charge of setting performance
> levels, the OPP table of the GPU node will have already been populated
> during said power-domain's attach_dev operation.
>
> To avoid initialising an OPP table twice, only set the OPP regulator and
> the OPPs from DT if there's no OPP table present.
>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 26 ++++++++++++++++---------=
-
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/=
panthor/panthor_devfreq.c
> index 978f193a2aee561fadd9a976e9b1417118260889..6beb6170d6eea3dd65880dfe6=
4a61abbdd5f08da 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -143,6 +143,7 @@ int panthor_devfreq_init(struct panthor_device *ptdev=
)
>         struct panthor_devfreq *pdevfreq;
>         struct dev_pm_opp *opp;
>         unsigned long cur_freq;
> +       struct opp_table *t;
>         unsigned long freq =3D ULONG_MAX;
>         int ret;
>
> @@ -152,18 +153,23 @@ int panthor_devfreq_init(struct panthor_device *ptd=
ev)
>
>         ptdev->devfreq =3D pdevfreq;
>
> -       ret =3D devm_pm_opp_set_regulators(dev, reg_names);
> -       if (ret) {
> -               if (ret !=3D -EPROBE_DEFER)
> -                       DRM_DEV_ERROR(dev, "Couldn't set OPP regulators\n=
");
> -
> -               return ret;
> +       t =3D dev_pm_opp_get_opp_table(dev);
"t" is too short for a long function like this one. We should either
rename it to "opp_table" or refactor this out to a shorter function.

dev_pm_domain_set_performance_state is new to me. It might just be me,
but a short comment explaining that the opp table might have been set
up by the pmdomain can be helpful.

With that, Reviewed-by: Chia-I Wu <olvaffe@gmail.com>.

> +       if (IS_ERR_OR_NULL(t)) {
> +               ret =3D devm_pm_opp_set_regulators(dev, reg_names);
> +               if (ret) {
> +                       if (ret !=3D -EPROBE_DEFER)
> +                               DRM_DEV_ERROR(dev, "Couldn't set OPP regu=
lators\n");
> +
> +                       return ret;
> +               }
> +
> +               ret =3D devm_pm_opp_of_add_table(dev);
> +               if (ret)
> +                       return ret;
> +       } else {
> +               dev_pm_opp_put_opp_table(t);
>         }
>
> -       ret =3D devm_pm_opp_of_add_table(dev);
> -       if (ret)
> -               return ret;
> -
>         spin_lock_init(&pdevfreq->lock);
>
>         panthor_devfreq_reset(pdevfreq);
>
> --
> 2.51.0
>

