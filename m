Return-Path: <linux-kernel+bounces-897783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D1BC53CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B55A541270
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15DE34402B;
	Wed, 12 Nov 2025 16:54:47 +0000 (UTC)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77E2C0277
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966486; cv=none; b=Z3/dFexy+WFYTvP0zEpoNg8/9r39puqHx4i/zD+fJ346iYD3fKrBrzvTWTra2hYTn+ViU49xu2aKFVVD0Hm1Y4rg4YdLXkYtvdNbwWhTlr35QOrn+M+rIyg4dwBMe2H0mY3bromuGx8kHoQ5zQXcAQV7xZweTA7jw9dUlp8peOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966486; c=relaxed/simple;
	bh=vKzJGeF4YKf07MSl7Wfxofmo26UplM6I0vKinTzU5Bk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRgG1SRZgX3r/ajutmZ2EtNnipJpzcDidkJfRL0eIbFq4c0NattQHIsgdZtsXkIDXPumaX7I54GgIhnEd1n2plE8BvSgNUYgy6tCi4cFtRVsMHdQ7u/3cekFnKDlPMnwcLhjPo5MhzqfYJx66XpIig+RD3ZJppjOn48cZRJOlgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-559f4801609so236989e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:54:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966483; x=1763571283;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKJeMRLbErvhNOYva0m4lCJv2yv5ZqWMM8uB7IOw7Lc=;
        b=IEg880FUIx5238VFcrCN9gcRoZzmmUXviPQaGajxiWgDwYvV+oFerIqKtIop0UU40L
         P/u9or0XjBIN/ToD5B/Bua3QKierm4sjWtSoJB+D0LrQ0uEkb8wA20lL2ooWE3/cFEbS
         0QV82jzOItA5oOO4QYVPf8ON8yKzRTwDWixClwcJksj63MgzMsVJR1nGYDNfARXAzfVs
         NQPkOWbJP9AHXlc26AXWudErh8xndD2UjrUX/hhjinMYfsCet08qsB3xWPSBHFwvOyVr
         SqfsQ3KlrSgpsp20bDJMobLY1RNnvITBsfJGgGAaqjPvqv907q/wqb468xn3iGw/OHCK
         rmrg==
X-Forwarded-Encrypted: i=1; AJvYcCXZiZSQ151KY4u8hGRJ0XIO/+sGqztZ77sG6/Cj/CMeQXld2A2MnOVymLnNC0oKiPlW8LYFp8Mub5+z9+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvqjS4PoXKuLgPArmWhX2MToDImHD/f0pSCTtnHDSTT+iHULkx
	CaXYNb0+pjKm4d7VO0qmhUJOIV/9ZCNYvTEglYv0POFhfFgZH22sX3D9TBXzXt9D
X-Gm-Gg: ASbGnctwrmhkDIOQYzGGKr1IyeRAs+Ud8cti++r2iFO9PFD7j0f/5KqAcs3uDYNCCTL
	yhKDaq9wBSvnpWalK1PmO51WIg71wKD7u76BvpdWOqJ4KC/0s6F5JbzD4+idvFi5kzRzjFXOqaN
	hTKZM2bfgujxuXoN8TvrLah9ZTvtcV0bLFhwxyyDNH9S7z1xhVdNhaG9TB3KzdKeej92mbdyxo7
	pGnQFo8EyCi5h4Ec1AmQVkgZFHNnCZsmW8OYi8M771hiAz3BF7hpWn8HIzlhE56LS4APuZWUbAv
	EiKHmb+Oc/71Xt5OASNUdbyK3Ye//wS9fFDnLPQI8PzMMQMENCphvMUYpa6bBedkga9gGoaioiJ
	ujsuCNz30cam6IgSgQwH0L6WyZEvixFqu7L7x6L5jz+ZLuOpFYpvHqia2pIabdKN5S2RkORjWf0
	hPGa48bN0BaoZPw9mDA4tb9NGNnQtz/Ga/kZlVMA==
X-Google-Smtp-Source: AGHT+IFWpH+RXje0vn2xHs4Scc4kQ/nTt8bO0f8W5dY7ctt61RsOdsZJWTngFVLlFY6B0x+3hYw4Sg==
X-Received: by 2002:a05:6122:c8d:b0:559:6b0c:1ca2 with SMTP id 71dfb90a1353d-559e7dd57e9mr1672744e0c.16.1762966482621;
        Wed, 12 Nov 2025 08:54:42 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559958320aasm9996889e0c.20.2025.11.12.08.54.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 08:54:42 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5dbd3dbbde3so798346137.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:54:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVG441tv4x+3Upr7iCsDcmpncNzmK8uv2Ey2wNelNWolkPxG0jHPOZjs0tFe2Gcj3NzqcukewtuJjHmg/8=@vger.kernel.org
X-Received: by 2002:a05:6102:d8a:b0:5db:f352:afbe with SMTP id
 ada2fe7eead31-5de07ce4801mr1128306137.6.1762966481708; Wed, 12 Nov 2025
 08:54:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112143520.233870-1-yuntao.wang@linux.dev> <20251112143520.233870-10-yuntao.wang@linux.dev>
In-Reply-To: <20251112143520.233870-10-yuntao.wang@linux.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2025 17:54:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVpKC94_JPqp0foeeC9Uz8X6st8NLDryGkBqvCc=-CAdQ@mail.gmail.com>
X-Gm-Features: AWmQ_bl6HMrZVPynAla471JOudFytqZegXGmKBpcCj7HBFaIV3VakgXx4WEQtHs
Message-ID: <CAMuHMdVpKC94_JPqp0foeeC9Uz8X6st8NLDryGkBqvCc=-CAdQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] of/fdt: Fix incorrect use of dt_root_addr_cells in early_init_dt_check_kho()
To: Yuntao Wang <yuntao.wang@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>, 
	Baoquan He <bhe@redhat.com>, Zhen Lei <thunder.leizhen@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Changyuan Lyu <changyuanl@google.com>, 
	Alexander Graf <graf@amazon.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yuntao,

On Wed, 12 Nov 2025 at 15:38, Yuntao Wang <yuntao.wang@linux.dev> wrote:
> When reading the fdt_size value, the argument passed to dt_mem_next_cell()
> is dt_root_addr_cells, but it should be dt_root_size_cells.
>
> The same issue occurs when reading the scratch_size value.
>
> Fix these issues.
>
> Fixes: 274cdcb1c004 ("arm64: add KHO support")
> Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>

Thanks for your patch!

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -894,14 +894,14 @@ static void __init early_init_dt_check_kho(void)
>                 return;
>
>         fdt_start = dt_mem_next_cell(dt_root_addr_cells, &p);
> -       fdt_size = dt_mem_next_cell(dt_root_addr_cells, &p);
> +       fdt_size = dt_mem_next_cell(dt_root_size_cells, &p);

I think it would be worthwhile to have separate dt_mem_next_addr_cell()
and dt_mem_next_size_cell() helpers.  That would us bring a few steps
closer to the following goal stated in <linux/of_fdt.h>:

    /* TBD: Temporary export of fdt globals - remove when code fully merged */
    extern int __initdata dt_root_addr_cells;
    extern int __initdata dt_root_size_cells;

>
>         p = of_get_flat_dt_prop(node, "linux,kho-scratch", &l);
>         if (l != dt_root_addr_size_bytes())
>                 return;
>
>         scratch_start = dt_mem_next_cell(dt_root_addr_cells, &p);
> -       scratch_size = dt_mem_next_cell(dt_root_addr_cells, &p);
> +       scratch_size = dt_mem_next_cell(dt_root_size_cells, &p);
>
>         kho_populate(fdt_start, fdt_size, scratch_start, scratch_size);
>  }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

