Return-Path: <linux-kernel+bounces-899699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FB3C58A51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37207364ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E4D351FA7;
	Thu, 13 Nov 2025 15:46:50 +0000 (UTC)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE51350A1C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048810; cv=none; b=BWRA9ELr5lJvVPQr04XlAdJCI2aUYbYxfb+5mudsFKv5PlydaOoMMha613mXXkhdMQKfkfy5CuoQG4QNt4jm0tVZQqK5lnxsLawfHPIRrod0CLGRJl4Y6/Aj6NnPOxqdrZJHE3lf4KQLKxAaC2pubchCTAqYd9RGUtPrYkRTMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048810; c=relaxed/simple;
	bh=JbMu6ahMlLII1KW/kjAvmBsc+G89KXscjqjvlqGkV2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVIAHUWRzBUZYshjONsPKVy3I94NrKYYiA1ByPVcgtPQzKM1vaQ4AI5nTE6F+eowIvlhwKIgJeK36mvSMOdPFPqU2LVmGhF4e8GgzOYVd07Ykjkobr5+9naUwMftIks9oGu3/c84OJZTENCZ/9DDGX4fBeA9klTdW/WxBXreGbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5597330a34fso689947e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763048806; x=1763653606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScuVkhi+y4j9hXy/c6rksPSqjbU1qzqA5VKC3tcakUw=;
        b=R95c0v0UUGQIrOf3B1oCIbe7MPoSG6s0S3ZJmrEijPtEtPMDMZYW2tJ1bPhETHmWer
         P/+Av5yFymkIDqn3NbXloDnLsSWslSaROj9e57kERROlBNKeOBtO5YOPwyQCiR8KTmzk
         VQGGKdcx0YkKIgdPxp1ka896/nAMzRsx9AW0/HXC4BrHdovEkuf0yHVEI8Ua2AM6HYLi
         nCCvMSpzFdWXYMnW1PWi3QLeHTVcTURMTDe7KXynpZSfFohrUys6LWnkncmnvukyEIvn
         W55K93A6qsyhPFgB07iHv9BdgTS5D/9R2z2pi1RlRmukGkrqLBSnG3SIr9CpuuqZPJH8
         IvMw==
X-Forwarded-Encrypted: i=1; AJvYcCXT7Aj6og/Yuc+7RUhH59qD1bfwIFLw9L3vf7/9lWUxjNigc3APYdo3ar/fEutubE83FeBjz5+FY8Bywk4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5cSxcE4fD6Ym2HyKaRIOiJQwhjxgCWORZRuNsR6CTh4/WBRwF
	8kZWIhCzq18Qo4Od+uO7KMzZMTaMSWEtVMWx5zeYjDG7B/tlyL41wRPTgsN4HW9kaLs=
X-Gm-Gg: ASbGncscAbj00IYT4l8rUON5tXthdJ5PFaUBh5oCxl8axrRLvp2L90GHmITrP2l3w2n
	6cteRnezLNg6d3YggtS8xe/7QWKM9jP/ZWf+DBcyADsolmhWHAXUph97u0EzCUNVxCRphA8oMOz
	aWAPgqtXycCwihw7q7t4qaI//UcESwZ/216jy+9SbynImaAMc/yzna0056YAWbyT25D81q4tLgQ
	59IOWNzsUQJnWhzPlLWdVYJgPor8Y88ho6KKAo4gya8s/g7fqOci2J/+4R0oDf//FyVXR4+50DA
	5GKD0DYQw2dT7FuKJd1DQvITg4BME2rLXtVv3izzxXU1Nw9/9xh9Gvk4JTlCM4uE9CRRUOqj8Ca
	Vfv4H6fitbvofz9EsuYpRb66ynYHGEHwwWYiEFUH7c+O5OTwPMHwAUAUS5F/UXIWYK5MRowAyMc
	niwOEFyZB7FD0BmdzwHk/oeR5/a9xei9ynzq2ajg==
X-Google-Smtp-Source: AGHT+IFUBCoLtiRHAVXyCMYcsr78Cq344916iOx03/1OqdpPTI3RoMBeaW3vB1P8K13bEd8RPbkH1w==
X-Received: by 2002:a05:6122:200f:b0:559:6b0c:1ca2 with SMTP id 71dfb90a1353d-55b1bf24454mr7648e0c.16.1763048806117;
        Thu, 13 Nov 2025 07:46:46 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f463cb8sm777669e0c.19.2025.11.13.07.46.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 07:46:45 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5dbd3dbbde3so669904137.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:46:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYfp8X6sk2R2vjHMbqBqwV88zZ7omhSR+pVXshrm3/Bx2KGPPjpgvTUYJpEb0lMdCQ94Gwezft1jdBVYk=@vger.kernel.org
X-Received: by 2002:a05:6102:cc8:b0:5db:ce49:5c71 with SMTP id
 ada2fe7eead31-5dfc55b0bbfmr40115137.18.1763048805410; Thu, 13 Nov 2025
 07:46:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110203926.692242-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20251110203926.692242-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 16:46:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVt2rtKs+yRqLBPK+_CwSwZC2XmBor-wmVf_JDyPiFbmA@mail.gmail.com>
X-Gm-Features: AWmQ_bkGYm2i_ZaT0N1d4rO7PGzb0yXpIqlcQJ7vIAPvPbw4btR7TgMuI9BaYk4
Message-ID: <CAMuHMdVt2rtKs+yRqLBPK+_CwSwZC2XmBor-wmVf_JDyPiFbmA@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: renesas: rzt2h-n2h-evk: Enable Ethernet support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Nov 2025 at 21:39, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable Ethernet support on the RZ/T2H and RZ/N2H EVKs.
>
> Configure the MIIC converter in mode 0x6:
>   Port 0 <-> ETHSW Port 0
>   Port 1 <-> ETHSW Port 1
>   Port 2 <-> GMAC2
>   Port 3 <-> GMAC1
>
> Enable the ETHSS, GMAC1 and GMAC2 nodes. ETHSW support will be added
> once the switch driver is available.
>
> Configure the MIIC converters to map ports according to the selected
> switching mode, with converters 0 and 1 mapped to switch ports and
> converters 2 and 3 mapped to GMAC ports.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.19.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

