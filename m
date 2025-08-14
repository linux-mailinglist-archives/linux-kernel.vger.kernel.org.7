Return-Path: <linux-kernel+bounces-767839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85936B259B1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3EF91BC7FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 03:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D3F146D45;
	Thu, 14 Aug 2025 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8IIJGvT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF9D17CA1B;
	Thu, 14 Aug 2025 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755140929; cv=none; b=TqyEJdccc/EFzJCJ36tHA38YP2jhAtqeIQ2X7mMB1LsGlb89nvn42hgOTmic+8R2WqS6OoznqMbVc3hkLo6agMFM50+rZBcvTbs7h6eUC/mrb+CSbQWsDbvKe4w8n8hkdpRGvJ9HAyD4RhGfCyiyc3zGAGLxPEgSAzdExCqk+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755140929; c=relaxed/simple;
	bh=XMoDAuCN1ioFag0z3tig59rfJ/M/O4cipfIwE477rSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gg5go+Pkvkt+2T65bWAnzF5ea7+GHeXX3sr7HRY4/wBaxOJC7p68ALFUHYb8pyItpK7F+43co/86z9InzX6xPWSlWxFLoRwAmynBzkK0hApikEBEKRLwOOZSI6Onge/vftpzFNLMBSvUWjaGqrp0Hh8K5oiJx1E4VlsGAJ7Ohe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8IIJGvT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499E8C4CEF6;
	Thu, 14 Aug 2025 03:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755140929;
	bh=XMoDAuCN1ioFag0z3tig59rfJ/M/O4cipfIwE477rSU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=o8IIJGvTiYTrLUfAiII30d6SgzYwkSVpXwPMgFtHgHlwGrmo0bAesHhiKMAaOYZfq
	 Gut42r0slDm/dLdTKSN9HZrepND3kAlZnWM9qr9sq0BfZdUNvnw6DEWnb1rwQMwAdn
	 W1ZzHO/54PkunKuxskcEb7NnZJk5TJIbYkC1nAFYLrVPQGHs2RK/lXhqCGFLhxRDBH
	 oic6jrAr3LDRtK4uaEGcknahxIQ8IgygFTrxfyENk2qsIumarXgMfHaIsJxxGN1E7s
	 +PYiUaeT1S/8VhE/I4bbq68YXfVpa1nTw8MGLz2VXUhIvc1ay14vcgAMPr5ev0pEHj
	 Nx1aEOresxypQ==
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9e41669d6so307694f8f.2;
        Wed, 13 Aug 2025 20:08:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUk5b6Q9ilpfT3CILv1ALZTjYLL4R12OZzuJS2SOHzh/IXidiT9WMLlbtn4LlO1xAEFfUI+YNS+Xyo=@vger.kernel.org, AJvYcCW5AaXyjcoVnNGubO2HYLpb/Z2WEFJoHLZf+B77Z91p4dtIL/oymHh658R9YjqnDQsWO3iB1x1P//4758kh@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHOjZpxbbGdebI2UH7uuiB4oAC9mQ1YQGzjEGc31M+2a6DuGx
	svuHqa7QCmJ/U1lZ4vvHcrBQBHBne1/B4W45UrpGRQBSmV9c7zC4da1/3/qIE5GmOdGtMd7mxBf
	tA/uVGmOSsxBVxOssUQ21jGEVkmIaMyc=
X-Google-Smtp-Source: AGHT+IHGd7cgmKnfjDug7VCZOddgtHMo0WTzcqAwgWgOWT8QpHL13mPQ+EjzzmkPDFoDHnBeDEdISH57LxmKuzEzqio=
X-Received: by 2002:a05:6000:2505:b0:3b7:6828:5f71 with SMTP id
 ffacd0b85a97d-3b9edf1ad51mr1227756f8f.9.1755140927522; Wed, 13 Aug 2025
 20:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813171136.2213309-1-uwu@icenowy.me> <20250813171136.2213309-3-uwu@icenowy.me>
In-Reply-To: <20250813171136.2213309-3-uwu@icenowy.me>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 14 Aug 2025 11:08:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT-ryXrM87BwvK_wp9F_ZEsqUHKJdkxKbtJmiq_07g2rA@mail.gmail.com>
X-Gm-Features: Ac12FXzVcxaStMtfbYxgXX23VvxyuR7WndlfjsAegHOeemSEsiMSjGU5Ja913-I
Message-ID: <CAJF2gTT-ryXrM87BwvK_wp9F_ZEsqUHKJdkxKbtJmiq_07g2rA@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: thead: th1520-ap: fix parent of padctrl0 clock
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Drew Fustini <fustini@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Yao Zi <ziyao@disroot.org>, 
	Han Gao <rabenda.cn@gmail.com>, linux-riscv@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 1:12=E2=80=AFAM Icenowy Zheng <uwu@icenowy.me> wrot=
e:
>
> The padctrl0 clock seems to be a child of the perisys_apb4_hclk clock,
> gating the later makes padctrl0 registers stuck too.
>
> Fix this relationship.
Should it add a "Fixes:" tag?

Others, LGTM!

Reviewed-by: Guo Ren <guoren@kernel.org>

>
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  drivers/clk/thead/clk-th1520-ap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/thead/clk-th1520-ap.c b/drivers/clk/thead/clk-th=
1520-ap.c
> index d08e7fb387e50..f6f3d63d53353 100644
> --- a/drivers/clk/thead/clk-th1520-ap.c
> +++ b/drivers/clk/thead/clk-th1520-ap.c
> @@ -888,13 +888,16 @@ static CCU_GATE(CLK_PERISYS_APB3_HCLK, perisys_apb3=
_hclk, "perisys-apb3-hclk", p
>                 0x150, 11, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_PERISYS_APB4_HCLK, perisys_apb4_hclk, "perisys-apb4-=
hclk", perisys_ahb_hclk_pd,
>                 0x150, 12, 0);
> +static const struct clk_parent_data perisys_apb4_hclk_pd[] =3D {
> +       { .hw =3D &perisys_apb4_hclk.gate.hw },
> +};
>  static CCU_GATE(CLK_NPU_AXI, npu_axi_clk, "npu-axi", axi_aclk_pd, 0x1c8,=
 5, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_CPU2VP, cpu2vp_clk, "cpu2vp", axi_aclk_pd, 0x1e0, 13=
, CLK_IS_CRITICAL);
>  static CCU_GATE(CLK_EMMC_SDIO, emmc_sdio_clk, "emmc-sdio", emmc_sdio_ref=
_clk_pd, 0x204, 30, 0);
>  static CCU_GATE(CLK_GMAC1, gmac1_clk, "gmac1", gmac_pll_clk_pd, 0x204, 2=
6, 0);
>  static CCU_GATE(CLK_PADCTRL1, padctrl1_clk, "padctrl1", perisys_apb_pclk=
_pd, 0x204, 24, 0);
>  static CCU_GATE(CLK_DSMART, dsmart_clk, "dsmart", perisys_apb_pclk_pd, 0=
x204, 23, 0);
> -static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb_pclk=
_pd, 0x204, 22, 0);
> +static CCU_GATE(CLK_PADCTRL0, padctrl0_clk, "padctrl0", perisys_apb4_hcl=
k_pd, 0x204, 22, 0);
>  static CCU_GATE(CLK_GMAC_AXI, gmac_axi_clk, "gmac-axi", axi4_cpusys2_acl=
k_pd, 0x204, 21, 0);
>  static CCU_GATE(CLK_GPIO3, gpio3_clk, "gpio3-clk", peri2sys_apb_pclk_pd,=
 0x204, 20, 0);
>  static CCU_GATE(CLK_GMAC0, gmac0_clk, "gmac0", gmac_pll_clk_pd, 0x204, 1=
9, 0);
> --
> 2.50.1
>


--=20
Best Regards
 Guo Ren

