Return-Path: <linux-kernel+bounces-899932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BD2C5912B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F80F352D30
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01C1368283;
	Thu, 13 Nov 2025 17:00:14 +0000 (UTC)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295836827D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053214; cv=none; b=F/BFS8uTS7imHeJhb3mbavdJ8bZPmKidIOZbjDdX+gjXKjrvAGhQdyi2omZylpwZg41T3Jhc1ZJDWr8VUJQtAp3IRwVhPKvphsb7MGPsAe9EnFItzoLXxi1Yj98HGZbjUtaPvsY+6IpoR2d8rku4vfADK4MyYB8tt3CObg+h97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053214; c=relaxed/simple;
	bh=Dbv+NvA54eQnU138bJCOz6IuOnEx2OSaA5K0SN9S/FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G8BpdOscv56V1BKsLana7QtCNayCY4oEqZYnY2L5gt4A5HZWIpL20qSavg94jdRU8KnRQlxNEaqKeGXgDMlomqp6BHQVHo79vta4lUu/wYDAj1zC3xk4vZoNRLtQ8Hh/Ekrwc/ZFTq9/JaxyURh22N/av/byu2/RJeA5w69WlOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5597330a34fso747036e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763053211; x=1763658011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbQvAYO3eNdTVb0fT9wjAGvduLlBPUoVXxd3qKsckAE=;
        b=ouMh3OfwTlNnly6t/pIFawi4fTIsw/jVgCBjShHu6QacEzn3CIxFhvD8iCa12gzihD
         iDcfpTy23cUtYuQ3HOEFvbPbJu56PaoLBcTvCoGaGB3MP5wtBSkvcBQmOuZwl8peJk7G
         /wKr9lq9U6DE86RwNf08TYJpmTXCXV+PvmsYwEQRY1Vdt2jqxiJ55DwQeS6y/gDz8p8C
         iD4c4qu2QPLtX3hcmRyBs4qEDRmB0RNS05QVZvXMiIRt0u+MiRGW6VU/Xl9a76djSzvh
         k6wW+ufUyDOVm3aRlz6HgASBDiZEEVaQv9vI8qUkt2Eh9SUnfsu+RmjGoCUQ9wemzIbn
         Q2vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCxaVz9rNU2FOY0ZH0EFvNBPUZDQwiM/RCdCUcJg77h3B0tZ2XtjvWIg0fQqcHhu28cul+jgTSAmjF/Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx122AG9WAanWgvD9YEuNIk4JK+tqQML9ESNMK0RciszrXk4Kms
	2b78Cvf4D5Dgzyw8fXwFfvD+zsU4YoGLDR6BlQiKBpFj2G9QOslQgjTM7Guuxk4ZTQM=
X-Gm-Gg: ASbGncs3/hGdDPdPDMmqOeq+knAxZzKSmf1Jnt6UlQSyNjCELh9Mjsm3O5uLbFM0sbI
	RL9BwtOUwVrg7RvPLRbuuYy47L2R3/OCnKoq0MZEORktQZy6LootzbUWWKNQs1gVT3gjyGNk1mC
	pSyIQPUKMYJFEnXLFhv8YjDFVqCMWlaYaAzvilMbdlSmdbfjyC4uBnid+UbnQfC/zt/JQTBz4g1
	O3B925/yxkqLUEzjszB1/IbHYJ4IFs0VdPVACBEbNTee5BjvdxKO84YYKXd3hKHoIuoZgVvyg1K
	8DHAYUmv2qykSdlUEVBG+ldWTFWzkAzweHf9BTNl7zLAbx/EF4w1Xl2W/3e5SpJIcsMZQSvXp+A
	2YwCOnrhKrPigU2ISbmtU3v8qC7eKbcQcMAkf6yb3PSBQzLhX8qUN8qk6eWk/lY/QOnZ5Jrb/o1
	xBo0cI1VXt86AwctBbTk7sJeU1LiFVzhtExTjxLw==
X-Google-Smtp-Source: AGHT+IFtVwRjIIELAR+6FKnsf8l0DKSz+3pDVOicPSQicKSSkpg/M8gtmbFbmLBVqYGRaMtetmg8dQ==
X-Received: by 2002:a05:6122:1799:b0:559:623a:3aa9 with SMTP id 71dfb90a1353d-55b1bce4c5fmr198988e0c.1.1763053211044;
        Thu, 13 Nov 2025 09:00:11 -0800 (PST)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f35db02sm841940e0c.9.2025.11.13.09.00.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 09:00:10 -0800 (PST)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5d967b67003so713604137.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:00:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5/teax1I+9HnoBbF6n7I+kKqalMqp1InheBFuV6w3hZZC45BZqepvCrkiSqQpY3hq0f+UI/rrT+sNWyo=@vger.kernel.org
X-Received: by 2002:a05:6102:2908:b0:5db:f5d1:5790 with SMTP id
 ada2fe7eead31-5dfc5587ea4mr226528137.13.1763052811529; Thu, 13 Nov 2025
 08:53:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101050034.738807-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251101050034.738807-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251101050034.738807-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 17:53:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVo2DGVm0KMx10Heytif4aQTRU1OcXb-xSzLs5SP7Me+w@mail.gmail.com>
X-Gm-Features: AWmQ_bl5EDLinjz9IEQUBnCdqQ9y_TsmjBBKKZa6y0pw8az6LRSt_Iws6T3ZPNQ
Message-ID: <CAMuHMdVo2DGVm0KMx10Heytif4aQTRU1OcXb-xSzLs5SP7Me+w@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: clock: renesas,r9a09g057-cpg: Add USB3.0
 core clocks
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Nov 2025 at 06:00, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Add definitions for USB3.0 core clocks in the R9A09G057 CPG DT bindings
> header file.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in a branch shared by clock driver and DTS source files.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

