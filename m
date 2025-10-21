Return-Path: <linux-kernel+bounces-863025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8935EBF6CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E51465CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6B3338915;
	Tue, 21 Oct 2025 13:35:29 +0000 (UTC)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52433891A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053729; cv=none; b=D6HA7Xz6tZJgBtdhuULDMqYeEIKGsX7Kr3pT0I0I92Zv7n4yKcPQlFUJOqzsJFa9Xp/LdeM/Y243gexwzaRFx5uvk8P2P+UPsCxOmia246/LYTAeBLc/mFqHmQRcZh1lJX93KMs9MYfFshrwCfJSGpmNL5YT85GGOrEztp918I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053729; c=relaxed/simple;
	bh=gnF9AkJgPkgv+c5e70+0S/TuXUz2qGPWDAKnDZ2oFUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l7IrFFYjtkUHHX2j4dB2QlKKTin7NFI6tjkmWZMxsvs90xU7JI13sOgRPfFBe1OBYll1DJWaXuBbWSabw/XH8dBxh7iAIExkr1JNGhWW/MjKMxelB6skxJWXX3xyKqjSI+YwgDBTUW5cWS4/x2MelO8VVOFkfIQlPcowoR9cfZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54bc04b9d07so2194179e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053726; x=1761658526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2TkKqx+vxrv5wCaSsuSiP+PuBVA5+FMh9B80POq+sr0=;
        b=fhORMzlZXUWl8HOZRFSkwFj/U92D9ujBPeeWGfWO11mmxbAmTyAjp8roeWUYk6tvDS
         fnFJ2RzJZZVIffMUNH5HzvRzPPw5Sim5vBY3fxtNd2Irdxmznkp6sIMX/E5sh6WSZzpV
         7pByBv+Uwobq4eRv5SAQex8Tq51g6RrH0B8gaTiYWLRTT/3uQNdfHCeZKdP0n1EF2r/r
         FBK4h1BMnnjAPaTzXoPk8Z6KdlB/mw8CEFutrTnR6NShX0Ku1jE3jMukptIuv72Cw2Zv
         W91/NXahV65bM+jvBbPovsyyLGIhwR61WsNrwHR0HEz0IuOLeoTuVi0iYgyzh/grcn/r
         f/CA==
X-Forwarded-Encrypted: i=1; AJvYcCVhnEGityr1QCbOV1Nssp+mglWmdGrStmj1FoHla8m3xNl7qcwhtOrXsTZB5ZTNcAHAK5Fi1Wv8VWuKVN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDudc0F7SRkBgkDzStlZZU/aN46Gxe8I8igRVK363CrludKKa8
	qUhwsTeG+TGC/p4zl5vIq7o4pa2+Ehcjzf/juxpt1QR2iKUyhcz/sguxbGiMEBtl
X-Gm-Gg: ASbGncvxlkITgbxE+Alu8pN1IwNI/8H5rwg4Haz92m9/1LbhMHQ55BZm0NzUfybbxzo
	PsK+CumkHdcRyzLZYDS2bz3wL/8bxKzRBIXnPLHZhq9uGWAqx5ISVHMfPWbGP4xXEx3ZbLIp4Bm
	gLLvHj+MUju+ATdoKpHTx64GEVy+VMpcUAkZFCbcHu0CK1KXTcfxdeliXNCYVTR2XUaCdNmEizI
	2deGcLWy2aEXfuKShFlbjcLr5y4ASBEhioRkDvyFdQnmkObTPN37dEYcmCFSBY3cKRFERaNl+g1
	b8JBkyVrPTLK91r3poPz9z5U2t7qpXw3unJL+UNTL8wjvWrjO1RLcrTNyCenBxJDa47ASRdR6Fv
	7JKaf+Lyfdc4BtLvVcSFW59minZUmj8M35QL3t0r6k3Gz+FXhkNz0jh9vIeCN0QIpt3UKTJ+9OQ
	JByaNWrUSDTTQS/rC6bgmucEUOL0j5SkZmWyl+Vqr+FuatVUEs
X-Google-Smtp-Source: AGHT+IGPPLggcVtQbWD3K4DrACXlpA8fcOd7LW31NTBEA8zZn4FqN7VGPtKa2hMrffAKHHO6HGWeMw==
X-Received: by 2002:a05:6122:8d4:b0:54a:71f6:900f with SMTP id 71dfb90a1353d-5564eca636emr4425127e0c.0.1761053726542;
        Tue, 21 Oct 2025 06:35:26 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55693a2aae7sm143186e0c.26.2025.10.21.06.35.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 06:35:25 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5d6266f1a33so2481255137.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:35:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6p3WlhzJzKQPHfu7fcUGB+BHMwC2RVymYaeIUzkd2dSi+RaKduXdSdXPd46t4+1H6GmpXFJFCVHyMwos=@vger.kernel.org
X-Received: by 2002:a05:6102:390a:b0:5d5:f6ae:38de with SMTP id
 ada2fe7eead31-5d7dd6ba33emr4614068137.41.1761053723732; Tue, 21 Oct 2025
 06:35:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021080705.18116-1-ovidiu.panait.rb@renesas.com> <20251021080705.18116-2-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251021080705.18116-2-ovidiu.panait.rb@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Oct 2025 15:35:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU+=c-HseXicppm+185qq3fcc7=qq3Nu4LjoKZuYF0d-A@mail.gmail.com>
X-Gm-Features: AS18NWDE7aRGEcmYizQFJmtQta7msQIG0JXTbcDHGFqFLxinOoGCd4ViST3rwwc
Message-ID: <CAMuHMdU+=c-HseXicppm+185qq3fcc7=qq3Nu4LjoKZuYF0d-A@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] clk: renesas: r9a09g057: Add clock and reset
 entries for RTC
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: claudiu.beznea.uj@bp.renesas.com, alexandre.belloni@bootlin.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org, 
	p.zabel@pengutronix.de, linux-rtc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 10:07, Ovidiu Panait
<ovidiu.panait.rb@renesas.com> wrote:
> Add module clock and reset entries for the RTC module on the Renesas RZ/V2H
> (R9A09G057) SoC.
>
> Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

