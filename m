Return-Path: <linux-kernel+bounces-808814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6489EB50510
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFF24E83ED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCC735AAA3;
	Tue,  9 Sep 2025 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="LHo+5Esc"
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB84343D9C;
	Tue,  9 Sep 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757441686; cv=none; b=H4IslfaUeEc7WNXP8zMsC7HqOnhbc6aw+KGVFGOzTjdjgdhYueUEBb89wZ3nrDs8lHko3T7gBUlgySx4kixoTkpxK+C1yBHIdMgSeAB8oFWiUwWNR59pYYg9j/bYAAd4f6cBa/o8KpSU+H4Nk+68V7eelJlLFXLmByGXKTkJ2Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757441686; c=relaxed/simple;
	bh=rfCwCuZ0Y+olP4LfcdQvUQ9BnW95/GthbIGb7VOHB20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKws7UFJ1n/CVdzA1tT+cW+1483dB+1IWfrgxilACXGdft/fh1TILBPMQxeD1mv7zvkKh5NN7lp1VcFx+zqZyX2VxKqIj3dRoSSQovI/ohBtD/U62CI4MD5FHUieHZ6KG4yWPlrZhVqHeMRgm4BhFvHudjqBWH5GMn71AvBAv8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=LHo+5Esc; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 3079B45DB0;
	Tue,  9 Sep 2025 21:14:33 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 6791445D37;
	Tue,  9 Sep 2025 21:14:32 +0300 (EEST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id A596B1FDB50;
	Tue,  9 Sep 2025 21:14:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1757441672;
	bh=261/qkYL8Ozg1pmeT0ZInbHgX/pEncdMpFE/xyghcBA=;
	h=Received:From:Subject:To;
	b=LHo+5EscDDdxWFlc54RDvZigpiShU5s6BzZ/HanjHkRwGUi3HynwzBIpJCmbERjSr
	 zf3oYWMHXsS6yLr3YQeFPhoSvxydl0l7WULswje/UYMLxrZ06BNYPXFCCzuObYj79H
	 9nR4FLmccwDXKnSNQzP0Xm5FWgYpMlf/sdyXF0Td9Kzc1e6Hhy7RP8K8KaC5+fvy4z
	 7Vgo9HTvTHwLMndEsiYuaPZqSk3nLgzrkwVQZ1vDfpup631rGDhNtlqR7nFAzBaipR
	 mlXb7dJVF4xuw4Gk7XzAfbMQxVJFCT1ID5w3XKx0jxadvjS57kmP8ZLhdWdStap4z9
	 hgCMTH49tl75w==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f172.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-336b071e7e5so48935651fa.1;
        Tue, 09 Sep 2025 11:14:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YyHbDh4dIw54hdpMDoQjgXEPhjcgfrOJB2zjDGdtt+B9LmC6Jw2
	bRvt935dOmO+Q4H6d9cevgcpS4Wzy2xLfm+CPx/sYvqFnL0jhD+xdkAsbPa/laVcopz/k32dnE0
	hpo/xq5bMb2gvx9SR98cXOcup7QxJJ00=
X-Google-Smtp-Source: 
 AGHT+IGl4tJNPX39/QxJHsyiL/+sEMH7ruK1LlHUwq13DB98ZUZJmJdHD5spz4J0iJNsulb8E9jifUGh54axpmui5UQ=
X-Received: by 2002:a2e:bea7:0:b0:32b:53b1:c8ab with SMTP id
 38308e7fff4ca-33b52891a4bmr30941051fa.22.1757441670945; Tue, 09 Sep 2025
 11:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904132252.3041613-1-lkml@antheas.dev>
In-Reply-To: <20250904132252.3041613-1-lkml@antheas.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 9 Sep 2025 20:14:19 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwGrWWbOy52BgdzjnMUBVPvizhHnM-bqMVLn4F-0xh_D0g@mail.gmail.com>
X-Gm-Features: Ac12FXwsGsNa0hHChPm_RWw63nfh9TJ-nDMpQskUb4u7CfhFR7kilECV0LA8VQg
Message-ID: 
 <CAGwozwGrWWbOy52BgdzjnMUBVPvizhHnM-bqMVLn4F-0xh_D0g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] platform/x86: oxpec: Add support for OneXPlayer
 X1Pro EVA-02
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
 Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Eileen <eileen@one-netbook.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <175744167196.1963518.1717473078307626244@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Thu, 4 Sept 2025 at 15:25, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> It is a special edition of X1Pro with Intel and a different color.
                                                            /---------\
Small oversight here. I was told by Eileen this is an AMD unit, which
is true. I had recalled the user told me it was AMD. So these two
words should be removed. Functionality-wise the patch is ok.

Antheas

>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/platform/x86/oxpec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/platform/x86/oxpec.c b/drivers/platform/x86/oxpec.c
> index eb076bb4099b..4f540a9932fe 100644
> --- a/drivers/platform/x86/oxpec.c
> +++ b/drivers/platform/x86/oxpec.c
> @@ -306,6 +306,13 @@ static const struct dmi_system_id dmi_table[] = {
>                 },
>                 .driver_data = (void *)oxp_x1,
>         },
> +       {
> +               .matches = {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> +                       DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER X1Pro EVA-02"),
> +               },
> +               .driver_data = (void *)oxp_x1,
> +       },
>         {},
>  };
>
>
> base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
> --
> 2.51.0
>
>


