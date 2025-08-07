Return-Path: <linux-kernel+bounces-758971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1B4B1D67A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7470C5650EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2035277C8D;
	Thu,  7 Aug 2025 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klW2AVwf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84710957;
	Thu,  7 Aug 2025 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754565526; cv=none; b=R40sF+N+/nsYUPrKKUSgjPPcvl4KQGpQS9BINHfkh1kB8mZGcudJEXSD6jWiWC+3mk7Nz/sHNEE2WC6RqWLg1a7ul5jZv9GB662sRX6YxBasR/TWawpp9qHziIJHUoXgtuoGYPbDMIRj9d4CQMCIqzQ2ytOwF/Ylp2Wow+qw2Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754565526; c=relaxed/simple;
	bh=SNXnu7Rt9Zoc2uVopx6+PRx7OnYFz9kFvWry42q0m1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jxieN5fHMDsU7D1svhA3FsGV9gz4GigD8znSE1vICidjm/Zv6cUWjghWZ+1bbEIoE9+pv2VX3J92vZ8qTQ57L7bkQc2aDEJb+lL9pGmX1nIZCzETVjPPbMES7zm3zZ02ixHls9zu2f6CVBwVopVa07JaTRgrFLv5atxCZ1FdHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klW2AVwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B192CC4CEFA;
	Thu,  7 Aug 2025 11:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754565525;
	bh=SNXnu7Rt9Zoc2uVopx6+PRx7OnYFz9kFvWry42q0m1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=klW2AVwfEp3Pifc6IN1Bhegq8gYIJQ/uezN0WoV/6txnRafEnLnrKYNG5lZDdKPVU
	 DziJY9s6NAkHfuLMbHrQTJuwfwdQMwCwusQ/HTHu3iFsUiqlwm2JkmSJFNUjsvM/1o
	 tAF4Atbyqb93U3m73gYXmzUc1lvTut34t6O1Alum8aAq0kVb+qTkBSwUfE5SeelLwZ
	 Ukt/jyPVmcCDIxzb5VaE1OElA1B5fU4oqW0I2QrQfoZQaWwd0BLGAqWGCazlGkHz0o
	 03U1GD4Jl40Cbue3XsZN5PmbSdwa0iWHZxOqjWQA9Md3IqelejguZq++6cIAcRAHrB
	 6WYNqrMKh6wsQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af9a25f091fso134120966b.0;
        Thu, 07 Aug 2025 04:18:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxAnEagEHBJ5ONWNoIwsJhRLj1tILZRRRGacBM6CJblefZrGkXpJMOkH/N+1w4GNay0Bi2CgkSXexB@vger.kernel.org, AJvYcCVYiwqtv9EyaU+D/So1sVh56BY20iVGX+wa1gih67fuvCtiTZop+Yf5PqT+skdRvgNwfAH3UIjTnYbVe41X@vger.kernel.org, AJvYcCXGlCl5vNKA5Q84SuiiL4qhl/czVQ9jqooGllBIBWhS+jp19WKwEUHCs0t06yE9x95sMk2s9Xy3gQAQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw64lSph+bcjgXeOFBkxnmJqHpaSSkWwve5uZsCIVj5sm9cm6dr
	jaf7hqdk7LXFdXGW6r5AywkeR6sqYgRFTWqvxazD2Xf5D7fjibPNrOfvlBIebnwLuPoJ+hTURbP
	Mv8t93MOb8sgMSY7dB2XaDRcR2HweK1o=
X-Google-Smtp-Source: AGHT+IHEjSHnG7sgGC41mrjTccGY+FWHNNKIvN23/AttbupNxhHTNKLac68J3AfeFYH2LfWy5QXo/Ok67IaGK8fFSqQ=
X-Received: by 2002:a17:907:7f0d:b0:ae0:bee7:ad7c with SMTP id
 a640c23a62f3a-af9904565e6mr584086366b.46.1754565524213; Thu, 07 Aug 2025
 04:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805150147.25909-1-ziyao@disroot.org> <20250805150147.25909-4-ziyao@disroot.org>
In-Reply-To: <20250805150147.25909-4-ziyao@disroot.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 7 Aug 2025 19:18:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H59x+KGJ8Jr4bDG7EG78aFSN=Rn7ZbkroPwHw-YPTf49Q@mail.gmail.com>
X-Gm-Features: Ac12FXzsjaHwZ-WI0P5JgdkTbdSE9eiqwcWiBL1ouBoKsAyt9EMwkNbWUsVsgt8
Message-ID: <CAAhV-H59x+KGJ8Jr4bDG7EG78aFSN=Rn7ZbkroPwHw-YPTf49Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] clk: loongson2: Support scale clocks with an
 alternative mode
To: Yao Zi <ziyao@disroot.org>
Cc: Yinbo Zhu <zhuyinbo@loongson.cn>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Yao,

Can the subject line use "clk: loongson2: Allow ..." like Patch-2 and Patch=
-4?

Huacai

On Tue, Aug 5, 2025 at 11:04=E2=80=AFPM Yao Zi <ziyao@disroot.org> wrote:
>
> Loongson 2K0300 and 2K1500 ship scale clocks with an alternative mode.
> There's one mode bit in clock configuration register indicating the
> operation mode.
>
> When mode bit is unset, the scale clock acts the same as previous
> generation of scale clocks. When it's set, a different equation for
> calculating result frequency, Fout =3D Fin / (scale + 1), is used.
>
> This patch adds frequency calculation support for the scale clock
> variant. A helper macro, CLK_SCALE_MODE, is added to simplify
> definitions.
>
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  drivers/clk/clk-loongson2.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clk/clk-loongson2.c b/drivers/clk/clk-loongson2.c
> index cc3fb13e770f..bba97270376c 100644
> --- a/drivers/clk/clk-loongson2.c
> +++ b/drivers/clk/clk-loongson2.c
> @@ -42,6 +42,7 @@ struct loongson2_clk_data {
>         u8 div_width;
>         u8 mult_shift;
>         u8 mult_width;
> +       u8 bit_idx;
>  };
>
>  struct loongson2_clk_board_info {
> @@ -96,6 +97,19 @@ struct loongson2_clk_board_info {
>                 .div_width      =3D _dwidth,                      \
>         }
>
> +#define CLK_SCALE_MODE(_id, _name, _pname, _offset,            \
> +                 _dshift, _dwidth, _midx)                      \
> +       {                                                       \
> +               .id             =3D _id,                          \
> +               .type           =3D CLK_TYPE_SCALE,               \
> +               .name           =3D _name,                        \
> +               .parent_name    =3D _pname,                       \
> +               .reg_offset     =3D _offset,                      \
> +               .div_shift      =3D _dshift,                      \
> +               .div_width      =3D _dwidth,                      \
> +               .bit_idx        =3D _midx + 1,                    \
> +       }
> +
>  #define CLK_GATE(_id, _name, _pname, _offset, _bidx)           \
>         {                                                       \
>                 .id             =3D _id,                          \
> @@ -243,13 +257,18 @@ static const struct clk_ops loongson2_pll_recalc_op=
s =3D {
>  static unsigned long loongson2_freqscale_recalc_rate(struct clk_hw *hw,
>                                                      unsigned long parent=
_rate)
>  {
> -       u64 val, mult;
> +       u64 val, scale;
> +       u32 mode =3D 0;
>         struct loongson2_clk_data *clk =3D to_loongson2_clk(hw);
>
>         val  =3D readq(clk->reg);
> -       mult =3D loongson2_rate_part(val, clk->div_shift, clk->div_width)=
 + 1;
> +       scale =3D loongson2_rate_part(val, clk->div_shift, clk->div_width=
) + 1;
> +
> +       if (clk->bit_idx)
> +               mode =3D val & BIT(clk->bit_idx - 1);
>
> -       return div_u64((u64)parent_rate * mult, 8);
> +       return mode =3D=3D 0 ? div_u64((u64)parent_rate * scale, 8) :
> +                          div_u64((u64)parent_rate, scale);
>  }
>
>  static const struct clk_ops loongson2_freqscale_recalc_ops =3D {
> @@ -284,6 +303,7 @@ static struct clk_hw *loongson2_clk_register(struct l=
oongson2_clk_provider *clp,
>         clk->div_width  =3D cld->div_width;
>         clk->mult_shift =3D cld->mult_shift;
>         clk->mult_width =3D cld->mult_width;
> +       clk->bit_idx    =3D cld->bit_idx;
>         clk->hw.init    =3D &init;
>
>         hw =3D &clk->hw;
> --
> 2.50.1
>

