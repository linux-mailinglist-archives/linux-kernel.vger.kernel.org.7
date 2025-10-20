Return-Path: <linux-kernel+bounces-861631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEA9BF3397
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119F218C1603
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A97D2DAFBA;
	Mon, 20 Oct 2025 19:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCEYthJf"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A902D4B40
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988832; cv=none; b=EEjPsljo5jsKPxxMoiH3XPqYDXzSibTpjQ6vQXF+iOPpPfJAO3UDe6Zaxu/sOu2UY9c5fHCPjWhEC67lAY02TJlYlHUTW+BEXHuo3CDhjSXKt/xHA6YbL8nIpa2++EGx0goItARnf3ULov4cz8+HaDv8ibez0CUnn6ExGxAiCoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988832; c=relaxed/simple;
	bh=m4RGynpIughTHkD+PB1z5lB1bY2hDb2eCFbfLzPsofo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikAetWoQNIkSWIl0ttQhB4wdAEfN9jW8DLypxvz5lZxRu5cKBs8dTU1+hwLthT1Sximp+dkXvALGWzKMwFU+CwK3U8GZ0I1HIzdP2GgmhxyxFrO51fgSkSeKktQiDgEmHJOP1sB+NyMP7cQjiWcTEQtU/9dynbukRvszlt2+iWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCEYthJf; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57bb7ee3142so5450183e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760988829; x=1761593629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOZrEQGvFr32CqnxYimuk+C7dEMMeQPJQMGMDm8/JmQ=;
        b=MCEYthJfQGuDqXzN32AHTC1bM/vjZM6f1+Y3ma+UJa0xxY+VvYLSlvT+4mZ7YX5Uiz
         vAf8GcexbfYqHJXD2aafQ9GPtVaR5koaSxKfL9sfPlnFhSlet9eI1iwtzjy0Z9rYSY77
         iPbEG41s//uEpjcyTAE+zro3WZawX4rbow0rGiBcwlNV4BIAQYt7JypRpus2zVnza03l
         JEsytCxAxEr0GK1Xg9tIxacNtRpkTzXpnz/MNB+emHo61L4BfVG+8BfInrp4LPcIWdkY
         lihjKXLgJM+pce9FupvWJ7o58Y2lAdgrcYpPabd+wfWUbwucd9c47i7gb1H3FKRfgDmn
         l51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760988829; x=1761593629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOZrEQGvFr32CqnxYimuk+C7dEMMeQPJQMGMDm8/JmQ=;
        b=GdJG562JUrxibP0m16krSN/8ZB5E49Sm3OJCrLPN89fTsaoWbzZshRgDVKzVjVtgeI
         VEB/u6GMDn4wMonx5gApaT+8uF19NCTzu5W/s4IfG7V1fMNCXJEQiDnKROhUrO5y3Wf0
         z5KMYKZX5mZ0H2fBpzAOEVdu56hgkFqw7BdKixj95NoFyOHQDaMRQLuiPvXafz3j82SQ
         7Gd2naKjsb8VhxT1QRlJWRRHtouGQSBQ/InjPis3Pezz9VqvPDE0leyGLoonurxAZNRj
         LuwO33IMYhCkdlik9bHMw8LRj60tFQBkiHgdd5eP+oxFWdIAJ9WyRxTUl5eE7eYNoiKz
         vMhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIPPCTw7AkDj93XxpVK2BdIQtowjSERReuz9TfK7YJQ9rMjTQUC2bd8zAAL5cRfs/YmRktDrbKbsdlNWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsz0aAMGQJBN4Z8+HdVsuzHg9X+iKB47NHBCANOolQo+XXho/Y
	+7gd5O8pIZQl3Z4al9/JyTKgPYrU1YCRguALD0GQCIoZFEoDVUrRtPHdA581nTZM3S8kBkziB1U
	4aTMkSUkTt1h31g3gLylfmCtAYTPGakA=
X-Gm-Gg: ASbGncvKIBS8mQVjPCRj492GO6F5GfEEHe3gwHMYSaISDLhLBrsC0GOGksUa5Hvjwdk
	D4yruNDwSqzNqGCk9x3PIq8gMXFKrAPeCVLilIu5Suvno3qD8bfCmDG09+riU31auWC0qV2iQCr
	ah+OwW3UHerOLxBk6bBf6UwB1vmrzU2cDqonagwRhBIxlVkbktpye0edv36WyqL6e66c0lNvq/h
	tyc6v4mPw9kEtZMIp+Tfs6xUSsvk8du9aBWKAmcORTPv2BqbpAOravhHpmlttblr0/5aC190pPU
	nq0VOmPrvQFkpqcoUg==
X-Google-Smtp-Source: AGHT+IHyTGZaPo3S/K25PKLJguJnxMhZ/EEoaJso13PfVnZvGhvkHIZ7OJAroNHBm4G74WPgdMcadPoHbwdva7EW71Y=
X-Received: by 2002:a05:6512:3406:b0:590:656c:d106 with SMTP id
 2adb3069b0e04-591d857b65bmr4459273e87.53.1760988828589; Mon, 20 Oct 2025
 12:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923-tegra210-speedo-v4-1-c12b5400ca91@gmail.com> <43f48d63-7bcb-47f5-814e-dd95fdf0b246@nvidia.com>
In-Reply-To: <43f48d63-7bcb-47f5-814e-dd95fdf0b246@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 20 Oct 2025 14:33:36 -0500
X-Gm-Features: AS18NWBaJbZyWBa5YnvuCdCG0my8mvhA3u_5SZarMD7eJUrtWS681KWxAhho7Yg
Message-ID: <CALHNRZ-48T+ZuhTLeQb5w1sAdTtnMP6LX=MrWiE+Qze4tii4FQ@mail.gmail.com>
Subject: Re: [PATCH v4] soc: tegra: fuse: speedo-tegra210: Update speedo ids
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Joseph Lo <josephl@nvidia.com>, 
	Stephen Boyd <sboyd@kernel.org>, Thierry Reding <treding@nvidia.com>, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 9:55=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
>
> On 23/09/2025 17:58, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > Existing code only sets cpu and gpu speedo ids 0 and 1. The cpu dvfs
> > code supports 11 ids and nouveau supports 5. This aligns with what the
> > downstream vendor kernel supports. Align skus with the downstream list.
> >
> > The Tegra210 CVB tables were added in the first referenced fixes commit=
.
> > Since then, all Tegra210 socs have tried to scale to 1.9 GHz, when the
> > supported devkits are only supposed to scale to 1.5 or 1.7 GHZ.
> > Overclocking should not be the default state.
> >
> > Fixes: 2b2dbc2f94e5 ("clk: tegra: dfll: add CVB tables for Tegra210")
> > Fixes: 579db6e5d9b8 ("arm64: tegra: Enable DFLL support on Jetson Nano"=
)
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> > The Tegra210 CVB tables were added in commit 2b2dbc2f94e5. Since then,
> > all Tegra210 socs have tried to scale the cpu to 1.9 GHz, when the
> > supported devkits are only supposed to scale to 1.5 or 1.7 GHZ.
> > Overclocking should not be the default state.
> > ---
> > Changes in v4:
> > - Check soc chip revision instead of speedo revision in speedo id
> >    conversion
> > - Link to v3: https://lore.kernel.org/r/20250903-tegra210-speedo-v3-1-7=
3e09e0fbb36@gmail.com
> >
> > Changes in v3:
> > - Drop all patches related to limiting cpu frequency from a dt property
> > - Link to v2: https://lore.kernel.org/r/20250903-tegra210-speedo-v2-0-8=
9e6f86b8942@gmail.com
> >
> > Changes in v2:
> > - Define units in patch 1
> > - Update patch 1 commit message to better explain the need
> > - Pull all downstream sku's into patch 2, which eliminates patch 3
> > - Update patch 4 commit message to indicate the limit is due to thermal
> >    constraints.
> > - Link to v1: https://lore.kernel.org/r/20250816-tegra210-speedo-v1-0-a=
981360adc27@gmail.com
> > ---
> >   drivers/soc/tegra/fuse/speedo-tegra210.c | 62 ++++++++++++++++++++++-=
---------
> >   1 file changed, 43 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/soc/tegra/fuse/speedo-tegra210.c b/drivers/soc/teg=
ra/fuse/speedo-tegra210.c
> > index 695d0b7f9a8abe53c497155603147420cda40b63..a8cc3632977230fbfda0f8c=
3bfa7b7b25c2378fe 100644
> > --- a/drivers/soc/tegra/fuse/speedo-tegra210.c
> > +++ b/drivers/soc/tegra/fuse/speedo-tegra210.c
> > @@ -65,27 +65,51 @@ static void __init rev_sku_to_speedo_ids(struct teg=
ra_sku_info *sku_info,
> >       sku_info->gpu_speedo_id =3D 0;
> >       *threshold =3D THRESHOLD_INDEX_0;
> >
> > -     switch (sku) {
> > -     case 0x00: /* Engineering SKU */
> > -     case 0x01: /* Engineering SKU */
> > -     case 0x07:
> > -     case 0x17:
> > -     case 0x27:
> > -             if (speedo_rev >=3D 2)
> > +     if (sku_info->revision >=3D TEGRA_REVISION_A02) {
>
> The dowstream changes just have 'revision =3D=3D A02' here and not greate=
r
> or equal to. That said, I believe that A02 is the greatest revision of
> this device and so this should be fine. Thierry can make a final call,
> but otherwise ...

Reminder to review or pick up this patch.

Aaron

