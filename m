Return-Path: <linux-kernel+bounces-892639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4304CC45808
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2878347A27
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683082FE593;
	Mon, 10 Nov 2025 09:04:12 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4639D2FE577
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765452; cv=none; b=h5Vf7blova+uQYHRuXJ4jzI3zvodMHnX6EIY6zfNjdjwvWl6VpmG5xO8j0v2zWrCExKIiLgGqXzQUdeCi6onmT2kGBIRQBeONca8vBD71m3TsKnE1EMAB+Ow1n37pY+5imqs4az+Af2ouQvm/qlltVPoL+sZ6OY4JmdP2zwfjZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765452; c=relaxed/simple;
	bh=iMmeLUV3xBgFjt2Cqbl9hMdgFQ6BlMWa/0ymtrQbpCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=it7B01ye0CcJSrz0mIXiJhHQil6FL96xTG5GDMjmd7PVZ2RLWWkY3zDiN9NU0ZU1aQBw7YADEmmYr6GrtCG62cnEbILv0aXF7QP1Tr1PaQ4e8w2SDPIXwiX/lNETbLCobeIPRSinfOCimvsHguPt7JDMYGq/sKl4niT1osMDV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-89018e9f902so1345130241.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762765448; x=1763370248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZFprYnk3afJ7bXwWWifURut5yD9UujyFxRDAYwHR2A=;
        b=A6V0mbsbBmQM85XbZArOxhDvnKyIEgdVWlJ1qnIneeucrh9ijTgGU8hIQNkoigwXbH
         OoW0e8XqIIt+YObW5sm6ec7JWlRzEO6QjlCtZpvQR9ksxnW+luRwZ1k54ZK/0a+yiSDE
         /cxA7/MCb7grLffU0uQfOiUpeX2e5PjVbYbf1APU0W+sICTBRL7H6nqiB8wkqMsn0j5/
         kCq2n1muEqEFo/QbHlTm6Oyy1kSgZwepU/aF+4R17Opt8bGeLglKRQGnAe/jLKrkeU/4
         glBUoKdI0qqNRYler0ZXHJWrF2mhaBMDGx9u01+49uulSgpNktocS7z6BVOSuGBVjbHL
         eBOA==
X-Forwarded-Encrypted: i=1; AJvYcCXHDab++MZxwpg3Wp/tU9tSgFxKG/SjMfMHjevpi0jabcZuYwcHhkmgU3YCCni3Gv2BwRmMAdgM8ujEVik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR3KiDiQKUAB3RHK97FpgaFr3rrBlFSyHa/PATdl/g0KGtci+o
	Z/zkICQGDXHvFNhIv9+jQ5cN6vovtuyu099LCgxcfEEoctSeT7+irXUnA6LobZeT
X-Gm-Gg: ASbGncuGOIgkdtNtLq/8Ih1Ck2rnLattZLSSjyWjOs2YCfqPQ4MhJNICxvMb03pa+ig
	hsX7EmGz4SfGK0dExDziOKPmtm8GaygoLmA2gQxg+qcOeGR5Eencp+TUzuD9Y6R8iF3a+qaTa4z
	o8euaqMdCZlFavF61qtNOzJ+0yyclHpqwVV5TdV1RIcSjY678TCDcAjIyBu8MmxGw+IxDuktdgw
	NF+vgZMUur0A4oSCvlrUA6Mykx/nUA26BGRdD/eOvA7aMSAmBb++GtHECeOYr6zDjbmsQ9pdhQ2
	KudFxXPYcddSnCv/Ht6Gosnl0ZIjaelBbxHvSLIE00UjqMacptNB36bRV9q5Zsm5Nu+HvHYRC37
	K96ZjAft368dLxzJPk9mB+6MRex1XI95Dw85jr3iCsEz/PkxoeU1KKXthUHRptFDItyi89Sm4nD
	V63z7QOOmJ1Dm5mgWpXUHgE/ixrTQNMgSp7ifa8Hgzkw==
X-Google-Smtp-Source: AGHT+IG0HEM5Bck9HYdGODCku4nel2Da4k6veeaOftMhHcruNDMq7QJQbQYg9/SdrCuruZxHJY4UbA==
X-Received: by 2002:a05:6102:41a3:b0:5db:cc25:dd7a with SMTP id ada2fe7eead31-5ddc474f9c3mr2924985137.28.1762765447714;
        Mon, 10 Nov 2025 01:04:07 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9370898da95sm5642636241.13.2025.11.10.01.04.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 01:04:07 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-89018e9f902so1345121241.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:04:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyD5eH+jK4qo01pD7SyhaGEoowLaaWMy9wwU6cXeqYzdMB126IrwOPFNkvxFs3Iic2hqkCxgNF3QGB9kU=@vger.kernel.org
X-Received: by 2002:a05:6102:c54:b0:5db:c9cd:673d with SMTP id
 ada2fe7eead31-5ddc4751f8bmr2299299137.26.1762765446858; Mon, 10 Nov 2025
 01:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762588494.git.gaohan@iscas.ac.cn> <bc141425b71f0cfc8f3ef0a3c6d08104fde1281f.1762588494.git.gaohan@iscas.ac.cn>
In-Reply-To: <bc141425b71f0cfc8f3ef0a3c6d08104fde1281f.1762588494.git.gaohan@iscas.ac.cn>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 10:03:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVtAmM6MySzaUZZMZLY2z_99Pb-zcvyQd+q5-NS3A=c_Q@mail.gmail.com>
X-Gm-Features: AWmQ_blbgQuyL2K-QWPxMEybBZ_lWHdEHYJOPJXLh-zobJqSsJnJFWv08QlcdnY
Message-ID: <CAMuHMdVtAmM6MySzaUZZMZLY2z_99Pb-zcvyQd+q5-NS3A=c_Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] riscv: defconfig: enable SUNXI_XUANTIE and SUNXI_ANDES
To: gaohan@iscas.ac.cn
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Yixun Lan <dlan@gentoo.org>, Drew Fustini <fustini@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Guodong Xu <guodong@riscstar.com>, 
	Haylen Chu <heylenay@4d2.org>, Joel Stanley <joel@jms.id.au>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Han Gao <rabenda.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Gaohan,

On Sat, 8 Nov 2025 at 09:21, <gaohan@iscas.ac.cn> wrote:
> From: Han Gao <gaohan@iscas.ac.cn>
>
> These options need to be enabled to prepare for v821/v861/v881.
>
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>

Thanks for your patch!

> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -29,6 +29,8 @@ CONFIG_ARCH_SOPHGO=y
>  CONFIG_ARCH_SPACEMIT=y
>  CONFIG_SOC_STARFIVE=y
>  CONFIG_ARCH_SUNXI=y
> +CONFIG_ARCH_SUNXI_XUANTIE=y
> +CONFIG_ARCH_SUNXI_ANDES=y
>  CONFIG_ARCH_THEAD=y
>  CONFIG_ARCH_VIRT=y
>  CONFIG_ARCH_CANAAN=y

Other subarchs handle this with "default y" in drivers/soc/*/Kconfig.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

