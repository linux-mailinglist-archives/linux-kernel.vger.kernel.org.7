Return-Path: <linux-kernel+bounces-898947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B534AC5658D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA5A3B6C41
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0BC2DC352;
	Thu, 13 Nov 2025 08:48:07 +0000 (UTC)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8985274B37
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023687; cv=none; b=JCm84FibTNBcX6zykDl5+4w8DXYwIixGBgiv5vNn5ZJuVjQXJJtZLWGL2ey3+j/Ed/4DNlTraubr0m8egr7ClOpFfcrqFP5o7ev1lhlcSPdFZolXGpTWRgiUhgdsRyl+eNC9Iy2EsHfX5XI4p2Sm/fsYf5d2Xo4F6kKOLVsY+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023687; c=relaxed/simple;
	bh=0aM3HY/1aVJh4jGU5kIYvSVpXhXTpBy3+OCQo3m3IRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RM0Umfl2+yhQqh5goIw0CCoLm9gBwklqphDzDiYa2xlqu/51UuTTjKJg+aGC5XICVY45erYHmhivgtpkmOva0d8HaxpNdFYgLqlxfY1yEXucZmpo8da6JmYPYFLj0PHRlnWS7EtVFxTp5Sbd4xasHu2QRkXhMGcMBI/dkoDznas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55965c96fd7so141505e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763023684; x=1763628484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75iAsF6vZT2LRBqNQRnHkvddKffQGnmtAsacOCaiC7I=;
        b=VTYK2UOpOP4rDod1cKUG9zsoR3wwR5ZGe1Sj6ctWe1DuWNR5FPwauPd0z5ANuFlYbB
         cy4WtBVwm8jLZ/STc7rp2zMnhXzIFmf3Rbq0VEUezE1q+lWfGrxVgtIff9jyIAAOsROX
         Cn5W3HiBkPXguTKJuPl6H/Fpe/viBg+FRIukenlwNlC498ts/HbH6TsG8Efsw2tOtsnK
         ekLDB2rrgyxpofxo2ZNswlPcQgo+o5OInJxxZ0/5Ls/DeDI5ms9AghyszF3X4daEl8UR
         VnxH0xYkD8DwIACGdnR/0YnzPealOghxo4HTsrvbirL/Md8lRbPaEH3oTbNZfKnvg3K4
         Jd8g==
X-Forwarded-Encrypted: i=1; AJvYcCW9hk81cKa6VQxRWB/r5WKDyQ1oi+XEexfI2/OCcN/Gu5jxJAs9Hq5wBHlSyaKbCGbrTk9di5y9l8Lh1sM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4nK1n9wdG1cIRGVBKeEsg+ym0zWnMSSd+jNv/SxU0V+xaNPwZ
	iNP4VI7tAlA4ZH6qcMRxWhpJX/YDDyfaOlrZNLl4bFZJWLDIcU/mPHwTo3hmlwRZzZ0=
X-Gm-Gg: ASbGncuWlgrgtPIiNc1KFmJQL/nvXtOQHDL4n5tdh99KEa8EJa+T66+mUuT2bYBtnfS
	ByHYsGXVplETcjzzUTEv0JMC8MY8Epx7hw8VIZ00zC4iPMQ7qYwlJieztmPM1sk6v38Ln9qKUSk
	aezDxGaVzsaLlLS8cR9ibu7zPC+PE+jU0+38JnTQROsGmnDZeJ3jM1tjKWDkCj0ZT4zfvkR3iiD
	Xj/6p7kX/HvqqEBx4adc9cxPdyhbsSLtRFEs4RyEvaZ021BMOGrp7a+vgrbihYHxPxfsi8BHBKg
	xkOtb3+u5mFaFpQoPHtQFKb1+PnLmfSBI05v9mMUrtmaVH6L3JjSq2QIqr8uXqsoG5PBFfnO22A
	53JrKS3Z/9ZCaldBi7xDStYFr24ZfGWpE+1I22IitipwtJDZiNjWgLxf5k1Wnw0QK9wx/yHVVId
	G2L0Ur4H7pTw4eRBlo4ERNyzPa1MIgdxUBJVNoPA==
X-Google-Smtp-Source: AGHT+IGlrrn3kPw0xMCe8ganoYF5X0L+Z5qusmVM1N9Mqegb0bLaRs/gMpkUhElRYkEvoQg/rp4rTw==
X-Received: by 2002:a05:6123:2eb:b0:55b:16ba:2854 with SMTP id 71dfb90a1353d-55b16ba2ee6mr80198e0c.5.1763023684167;
        Thu, 13 Nov 2025 00:48:04 -0800 (PST)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f4426a5sm493904e0c.12.2025.11.13.00.48.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 00:48:03 -0800 (PST)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5dfaf0a5da3so188553137.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:48:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQk1GTEeU9DZ7TlBnR9ubU69ALjbtkDe20thMccS57UgSjJIvJfOIWtd62RxS6QMF6LWztOd1cmUXne5I=@vger.kernel.org
X-Received: by 2002:a05:6102:e09:b0:5db:f440:f1b7 with SMTP id
 ada2fe7eead31-5de07ebd7d3mr2100093137.32.1763023683344; Thu, 13 Nov 2025
 00:48:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112154115.1048298-1-biju.das.jz@bp.renesas.com>
 <20251112154115.1048298-4-biju.das.jz@bp.renesas.com> <87bjl6wkf6.wl-kuninori.morimoto.gx@renesas.com>
 <TY3PR01MB113468318B32BF2E23953198586CDA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113468318B32BF2E23953198586CDA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 09:47:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXqBOpczZ-Kw64AQODSh0Q8HEAzBseUjwD7TO+dKq9==g@mail.gmail.com>
X-Gm-Features: AWmQ_blYo73iDu2aXnp11g8_9sf8FYwelNX4VYfCxNFVK76qka1yJ2ScCZVozO8
Message-ID: <CAMuHMdXqBOpczZ-Kw64AQODSh0Q8HEAzBseUjwD7TO+dKq9==g@mail.gmail.com>
Subject: Re: [PATCH 3/7] ASoC: renesas: rz-ssi: Use dev variable in probe()
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "biju.das.au" <biju.das.au@gmail.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Thu, 13 Nov 2025 at 09:02, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > >
> > > Replace '&pdev->dev'->dev in probe(), this makes few error paths shorter.
> >
> > nitpick
> >
> > '&pdev->dev'->'dev' ?

Woow, that "->"-pipeline looks confusing ;-)

>
> OK, will fix this.

Please use English where it makes sense:

    Replace <foo> by <bar> ...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

