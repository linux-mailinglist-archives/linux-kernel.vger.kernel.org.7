Return-Path: <linux-kernel+bounces-864591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFA7BFB211
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DA124F903E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EE331329E;
	Wed, 22 Oct 2025 09:20:13 +0000 (UTC)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A398311C1B
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124812; cv=none; b=CRXex5mllZcVz2hSVUf1UfP9ViTad3Av5kup4onL36hCJr3tbysAEVpAQNrdpmZOMDt3TfVYQPsCO2mvHQjGbQ54b3QiF58jphNtFUYFjUZpsTtbF7JBA0jCweb5iN8T34nfhF5lmhWu6DG08lBeOKxl7ql4/c46IwE2Yq+FY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124812; c=relaxed/simple;
	bh=G1iH8NrfXxiIzi56l5MFL/KIcTZCh+2ywldp0HMaEXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WETWMr7+AAfl5KYFOxMXDOn4rHADb12w0dq1XZmDxetHr34ul1B/aTSf6zNbfJfI0T9wMoLmBU1KCv2TRcC+tdg0dhCo4qWkpwJr0gNzQ49yKzm4keuGijgNYzGDAkz8R8dn6tojjPtQgEV7w5FEjHFBuXbdDM5XyQ7NIVFg2Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-932e88546a8so511454241.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761124809; x=1761729609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SzTfM6hHw1WxEGlErp6V2knAaHaB2xPtuGLl169CGwA=;
        b=K+nBJLpcjX9qpW0Ts997Cg1/W24jzJbkMDlbPt1WPBu8e/4C9LJopZsfegiVZ9dQG0
         OK3E1KMq19ddUz/hz0pOjkQDfqgFm3CvPjwXDFvd8va8wg/pQ/wNY4T9lx/+t459PcNr
         8cUMin7yJIjX0QVXJlGBVnEGubfJDP89jPZfxLy66H/lRfOz9hi7/XImG2Y9PMeMl1c/
         i3gYBkYqsyP6EH++gefMH3kjYe4mWnqK7ITeDPrv6OzzGRNKdHB2mE6uOA+morujtQkp
         okGh0JnsqVEbw+ke+wFiqLDSzcFMlIt/4okalDiAGloohTOQOJlluGq2sMlnLJ7uSz7+
         NBOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjjL5262/daXgTW7sL4ClcMP1T0j14bYHkFNcDzlJt+1qmTIjRRbSPsSAhBCZbqyAfKiUvL1ZU17YFzHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/wwFfb3IDAba3wFnyrs94Tpned8CwPDr1t59Eu7rY0/CwtEf2
	p0hT45j1I+QI3cAkmiXfNZBq2yI35J4fsp4jXiu6mJjtCpjgHkqvxZUwdsPsdjVG
X-Gm-Gg: ASbGncvk65DlQ6IEF2OmrsCzN9prU0ZO8rUeHAE+I1buiMKdD5AT3JulGNYQtm+o8ma
	yPF8VeQ8G6o5EP7nBK5o6BYwisPWlxfg4fTmQe12yG7IRTRH1w0Kr27Lroc3Iw9Mv266QjwtMsf
	DUSptDj3bWH/ewz+sey9+0rfSkb35RDS2IaeiIcTxiuUhzPn2wIoy2Vh1z4IMuxenQFeEOjWLOy
	TmVArFFjTpoxvo+MNSOznkMXfcTcQWgKs1UdJwXZ9aqRvgLpztuJMslatLizQo2T1Gdv+wtlPEs
	Vz1ideRbAfLwNECsnIrtOj2YoCsx2LIBXEypp1Lvalc2Dhz0zbOY+o/Hr6D8DfZjNayf0PNIykX
	rHgAEGhqpAiwRWDDzo1B1Lbws5e7Cd92nIAO86P1pbzA8VyfWVSvd1uRDAO14teMKV5cc5j/L0m
	tFK/J7yy5N/SiOgg/PP0ATnx5k3hCxPHnODwes9w==
X-Google-Smtp-Source: AGHT+IFDx3GaRZF4HqV1tam76kzZEd2GNLDj4GoULGlZedkLnFdkbmLHxje1TMQ/AwD4jlWcm8N6Cw==
X-Received: by 2002:a67:f04f:0:b0:5db:2168:77bd with SMTP id ada2fe7eead31-5db237966ccmr210156137.2.1761124809546;
        Wed, 22 Oct 2025 02:20:09 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-932c3da29f5sm4396218241.6.2025.10.22.02.20.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 02:20:09 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5d967a34203so748199137.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:20:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxGPL8IRH2AqQlnaPRGJxzA1oYo6uCDo07X7hUILLjoCM3uz1tm8y8vA5SbckSN5NQx7enbsISdZ4d29Q=@vger.kernel.org
X-Received: by 2002:a05:6102:81c6:b0:5d5:f6ae:3902 with SMTP id
 ada2fe7eead31-5db23866f45mr206045137.19.1761124808623; Wed, 22 Oct 2025
 02:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022073800.1993223-1-cosmin-gabriel.tanislav.xa@renesas.com>
In-Reply-To: <20251022073800.1993223-1-cosmin-gabriel.tanislav.xa@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Oct 2025 11:19:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXqXGPfQNB3SUQkcsHkaWhxjfN2KG0CNeYdoKwNAT7dYQ@mail.gmail.com>
X-Gm-Features: AS18NWAO1T4xKgR0pZBbqyleSonlF8IGxjXfESnWqWSdqh6DHcID-GTrRDaxhws
Message-ID: <CAMuHMdXqXGPfQNB3SUQkcsHkaWhxjfN2KG0CNeYdoKwNAT7dYQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sh: rz_dmac: remove braces around single
 statement if block
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Wed, 22 Oct 2025 at 09:39, Cosmin Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> Braces around single statement if blocks are unnecessary, remove them.
>
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -336,13 +336,12 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
>         lmdesc->chext = 0;
>         lmdesc->header = HEADER_LV;
>
> -       if (dmac->has_icu) {
> +       if (dmac->has_icu)
>                 rzv2h_icu_register_dma_req(dmac->icu.pdev, dmac->icu.dmac_index,
>                                            channel->index,
>                                            RZV2H_ICU_DMAC_REQ_NO_DEFAULT);
> -       } else {
> +       else
>                 rz_dmac_set_dmars_register(dmac, channel->index, 0);
> -       }

Seeing this same construct being repeated three times, I think it
would be good to introduce a helper (in a separate patch, of course).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

