Return-Path: <linux-kernel+bounces-899797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA51C590EF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4ECEA540AF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9D3346A0F;
	Thu, 13 Nov 2025 16:23:16 +0000 (UTC)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589DB2F0C46
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050996; cv=none; b=pteI9i/mY5GBm+ui2sr7c2qE1w0EnRkKohh6a0wfimXsp0SwNdQ3qN8onreIuHPo+6QtzpwdoQ+fxs1Nseg4wXgSVYVzTsm5mshvyk1SgtVamjy/f328iNu94yJYuKYPljmipZiaYMLt8v5rb7/Rhi6po9lXuHixls7gs83IfVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050996; c=relaxed/simple;
	bh=tLAT9m5zzv27vIHramdo70fQ6JjFWjWlaXUWQOyCtIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bzkBudoVqupPYIyVQHobht53qbB3vj0xS68iaiNvaD1fMFTxfQrJ1VH7O+ZS8NjWfFre1nk5xcKD8SSzH2PCSqttp470pmB9NgpowVKW9druoVYvchqXavRTcv0eH03cLlWsTeka5Q1fdAkNvvEBszFNXPJmDQIrSGIOxj4Ti54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-937268fe284so521452241.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050993; x=1763655793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5xOhgj3KLUbudZf/OSfykos9RtGD8I/iauuwMcQjwE=;
        b=nUoh/ka2s3dOqmV0TSIFSKq2rXw3M8S1+f3nUnFmmD1Q0YUIQNhZRhFWo4DSBOY5if
         L+SMS/D9iajDN4YFMqVoTulF3cQRM3R7T5oTudTe6d0tZLD02yyMvMYT/E7dGJYaDe0l
         GHy7M32Th2tINgmgg6NQAiltpdXqE4pf3Abw76WJdmvoDZpPUako16+/wKZ+nh4kr+i/
         IITzpXy/knuVqDrgtTvmleiULAzawiwlQll2XNinNft+viurUUFJu4qNLW7Fu/H8itv2
         T0SknofbNcxWak0YYGEp7sC9Pd7svrZ2HiVPUjzUdv/mxXPtCkAFIbPqGmHd7aeCMDpA
         WP4A==
X-Forwarded-Encrypted: i=1; AJvYcCXt2NK/hxM+L+2j+LqnPVGfjZsN1p+VnugltWQ+JnwEEBrjxmadIc3ZFoszRxIiqf/ptDoOD1R9I9QZE7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg8ljtyKkWPLTBj8Ni4/UaMa3/CIsLoOvs9dGjV4KeemIl0VzI
	qRnbNYQMuVFdtxLoC48/GeaNw8co22NuMz19yq2R6wVL0j56XFwbbYNihIV1yM3osQQ=
X-Gm-Gg: ASbGncuVB7ream51LHKT7SBR+nh+CztMypxt37uvz3yMmhD146dQSVYgTBiMQ1HykC7
	SGCDHH9ofT2VJrP/lXoGV5lDhTdj765zZ0f8uQExku9fzq2LJk3q79T8E8LMGrL46eHd2QSYhVH
	4ExTwOpy52CpVs7RZr6ocQK6Tc7hgAjocHVlsVOsSDW39KExXw1006gn1yA+p+AbPu4c+KAwj/D
	XOs24RgS2XfM5QAOsZjy9ViYaGZwX+VhZnXjYJYpMC3SqpQLvll46jfNE9cE+ES4abpACqs8QBf
	icmefUl2zyzjzditfsTNj76AK1PcPD0M8+UKv7GdPAf2liijywyZLXs2ir4WnhbyLhY5UcgArFD
	cniWh2ntW//hJ9/EuzPaeoUXTCedScMJwTXCCfZMTQjjBdIe4hR1JHwsgmqgc7CSenXgZS6qRgO
	hWt8bhsurK867GuAUa5enjvZg5Pei8yeGoa45zfg==
X-Google-Smtp-Source: AGHT+IHLhp1xvxeE9pMHQOH/WRtGHjTBpK+Jgkz2uU8aZwasNUb/us10PrQyoZqaB9IdgOOlJbN7Vg==
X-Received: by 2002:a05:6102:4193:b0:5d7:bd64:cc72 with SMTP id ada2fe7eead31-5dfc5556d0dmr145093137.15.1763050992973;
        Thu, 13 Nov 2025 08:23:12 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dfb7232b03sm735132137.11.2025.11.13.08.23.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 08:23:12 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-93518a78d0aso532537241.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:23:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVS/AlOVm4hzObf03fH1byHtRkSdtg+o8CJmhcaSJRocnjxkWw4Ba4sRAHtYbOdm3M88UpCzRjEQRBHi0g=@vger.kernel.org
X-Received: by 2002:a05:6102:a49:b0:5df:b31d:d5ce with SMTP id
 ada2fe7eead31-5dfc567727bmr157516137.28.1763050991936; Thu, 13 Nov 2025
 08:23:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106125256.122133-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251106125256.122133-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 17:23:00 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVP3xOGa4gj6LRBU1fdGPbihAayGF8xUCCZjJctyR-DOQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnISpr8jjnwV1qnu3HpPH36xFUGAy4ZFaDHn-fPMgUSA8TJ75exCa3iTno
Message-ID: <CAMuHMdVP3xOGa4gj6LRBU1fdGPbihAayGF8xUCCZjJctyR-DOQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Vinod Koul <vkoul@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>, 
	linux-renesas-soc@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

Thanks for your patch!

On Thu, 6 Nov 2025 at 13:53, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> After audio full duplex testing, playing the recorded file contains a few
> playback frames for the first time. The rz_dmac_terminate_all() does not

... frames from the previous time?

> reset all the hardware descriptors queued previously, leading to the wrong
> descriptor being picked up during the next DMA transfer. Fix this issue by
> resetting all descriptor headers for a channel in rz_dmac_terminate_all()
> as rz_dmac_lmdesc_recycle() points to the proper descriptor header filled
> by the rz_dmac_prepare_descs_for_slave_sg().
>
> Cc: stable@kernel.org
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

The code change LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

