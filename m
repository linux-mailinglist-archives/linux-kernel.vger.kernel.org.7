Return-Path: <linux-kernel+bounces-872568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C063C11782
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 331634EE804
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19238324B19;
	Mon, 27 Oct 2025 21:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghoEx6N+"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4C92E7F29
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599114; cv=none; b=QDXnKL5HJ04OyqZsXHv9uFgxm/NhjWrfgHb98VinPLku4kLJy+ezqL7jcS/ig2M2JMmybL5Pqtty+Al/s3K5kYT9dCgSocG4KYitxdptWX3Bqd96z/Mpzg7i5b6wvvCCwSwt8N0GQYYUfLQ6SVGxMZIFaVSk+76obh4Z0hq1bIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599114; c=relaxed/simple;
	bh=XIDl/ERO9aKNyZxFoRMGRXdIovseLN8Xy2xPzQVYRgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akNG64bMjDP8FlHxZtSNBEXlGoedh5XWFuIEVuoxqwt9DaiECuloBBcOj49/5lOeqB7MOnsrPDMvBKPy+9NYAGxIw4WUMviJdsqCI1Vt8rEOcxRMvUN5lDydfPZqOxtM7BoPJek/PtNvjWCRshGtWeK2E5VfLX+WVKDOgx9qYZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghoEx6N+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso5202689f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761599111; x=1762203911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoP6sWXXFNGFX4Zpq9+V9L/LMjEEOr7rE32h6+1IRjs=;
        b=ghoEx6N+UTJ262ic2N/Gf8mx2wyMC1iHx3o3Wl14zxTLiw/ZdGXPNGh7R0Sbl6Mq3w
         WVxl89hJDpR3uL9qrAREUeV1PsUPryL5UKbsPrTqQfdyqkgQKAxGwr/8TFWJYoEemRg4
         wbCrdVEC9SER9akg8ocru8R2dLPNSPLU26v7N67U4S33wmVYHaJ8TH8J6wV4VgOMLlBZ
         PIaYaCtweQOKyC56/LRlRDVMZPCAGlbgxD1gcMgbrWGc4ehZuTpUwP41j23ijgB0sw54
         BcMaMxFz2ihBGuDSe6qusxVwE8wfdTF9d3Pz9Wlvr4CjbqOpVqh8z/MdDJ5xiGxQFucl
         Y4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761599111; x=1762203911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoP6sWXXFNGFX4Zpq9+V9L/LMjEEOr7rE32h6+1IRjs=;
        b=sewvt0lks3wGJBsrqYDVyMijAl5QT2zV0hRysK9O0IXCo4ceGetj+KL9kOBlZDWScK
         wXvMQE6tjuj2Hxx4y6WneJY5NA07D3CxwMgNcVmfGt5YhcDtXb97w3hYmcp/dYxlSsPE
         rbw6zGvwR7CACzL9SZUMcLQ+54t0eFcj1yfs4/5IOVtiWDxWs+v9wXDkrJP2+hULOv1P
         ugSvpcCMDgAuNQG0LXw0Kclgi+JDhDu44CFxfwzsY5IIkjX7u13M6EQHScIX3Q4APwoR
         YeIKw0ODymiJib/viqWCNQRs33Sb8fuvkZP1W6xe8rnedpDJrRWjtwFLmL7fOBjiHUYC
         4W4g==
X-Forwarded-Encrypted: i=1; AJvYcCVYqeqEIrsvPS2KkeUxntMNRBTVls2QkwtpbQI97/EMqobxi5cGSqUPsjPS98e661M4kRcEObr3bZ4pNZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgBQe9mwwgK4HtYnym+E7iqY893unsh6GHI/pUvMJlmk7P6JI3
	bfi3HeSGUALTk1E+gA86SlFxF2YjQ82/9rywiv2UsdvvQDmHahkqp2f9FBwcSYSX5eo94nvfFLK
	1C2d/WN+twR//2FEyqzFbDe1OtU3XToM=
X-Gm-Gg: ASbGnculTh1z23NfIcpwN5JfmtoZDP01kmOTpNlY8veU7C9jthblcQJ9P8LQySD36vx
	3CF48Itu+omKn/cGF5GT5QBJFtYi1XwBOolUlacFzBiTQF5ORa7utJ8cipyDfE/JtOtuvMp9P4x
	hflVyw6ALp+FwRDFB6Ijpknr7wtuA7DgTow9InR/hs8RJUXZ1OKqZzE2u83XdU70lZPTLWJRhCn
	zHF2G2fMbcg10wIk/EI5nt9/zze/ZBMThzcaIiO2mDz3/hhaYzJhnYfrzAz
X-Google-Smtp-Source: AGHT+IHk2BlyZjRFVUILloQdhusl5C3XR9jf4ug3ST318DPm7lP7GrQepTteSylu4Lm1lrHkxRCafckMptsRpnQAp2c=
X-Received: by 2002:a5d:5c8a:0:b0:429:8d46:fc40 with SMTP id
 ffacd0b85a97d-429a7e4f541mr1140944f8f.25.1761599110650; Mon, 27 Oct 2025
 14:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014151325.160062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251014151325.160062-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdXU_aOg+bfRBJ7UOQW59QUxqa4a7WXTj27RyCyiNHV8qA@mail.gmail.com>
In-Reply-To: <CAMuHMdXU_aOg+bfRBJ7UOQW59QUxqa4a7WXTj27RyCyiNHV8qA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 27 Oct 2025 21:04:43 +0000
X-Gm-Features: AWmQ_bnLKxvnu2wt9shyDeaA5MSq9GtqCcfZY2URt6Hj7wb0HhH2yB8dTxpJ5hg
Message-ID: <CA+V-a8soq2HJD0dM8GPhprpd_tyW735MSC-FkHwrY6wb-dqTZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: renesas: r9a09g077: Add xSPI core and module clocks
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Fri, Oct 24, 2025 at 11:08=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, 14 Oct 2025 at 17:13, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add module and core clocks used by xSPI (Expanded SPI) IP on the
> > R9A09G077 SoC.
> >
> > The xSPI block uses PCLKH as its bus clock, while the operation clock
> > (XSPI_CLKn) is derived from PLL4. To support this, define new selectors
> > and dividers (FSELXSPI0/1 and DIVSEL_XSPI0/1) in SCKCR.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/clk/renesas/r9a09g077-cpg.c
> > +++ b/drivers/clk/renesas/r9a09g077-cpg.c
>
> > @@ -105,6 +113,15 @@ static const struct clk_div_table dtable_1_2[] =3D=
 {
> >         {0, 0},
> >  };
> >
> > +static const struct clk_div_table dtable_6_8_16_32_64[] =3D {
> > +       {6, 64},
> > +       {5, 32},
> > +       {4, 16},
> > +       {3, 8},
> > +       {2, 6},
> > +       {0, 0},
> > +};
> > +
> >  static const struct clk_div_table dtable_24_25_30_32[] =3D {
> >         {0, 32},
> >         {1, 30},
> > @@ -119,6 +136,7 @@ static const char * const sel_clk_pll0[] =3D { ".lo=
co", ".pll0" };
> >  static const char * const sel_clk_pll1[] =3D { ".loco", ".pll1" };
> >  static const char * const sel_clk_pll2[] =3D { ".loco", ".pll2" };
> >  static const char * const sel_clk_pll4[] =3D { ".loco", ".pll4" };
> > +static const char * const sel_clk_pll4d1_div3_div4[] =3D { ".pll4d1_di=
v3", ".pll4d1_div4" };
> >
> >  static const struct cpg_core_clk r9a09g077_core_clks[] __initconst =3D=
 {
> >         /* External Clock Inputs */
> > @@ -154,6 +172,15 @@ static const struct cpg_core_clk r9a09g077_core_cl=
ks[] __initconst =3D {
> >         DEF_DIV(".sci5async", CLK_SCI5ASYNC, CLK_PLL4D1, DIVSCI5ASYNC,
> >                 dtable_24_25_30_32),
> >
> > +       DEF_FIXED(".pll4d1_div3", CLK_PLL4D1_DIV3, CLK_PLL4D1, 3, 1),
> > +       DEF_FIXED(".pll4d1_div4", CLK_PLL4D1_DIV4, CLK_PLL4D1, 4, 1),
> > +       DEF_MUX(".divselxspi0", CLK_DIVSELXSPI0_SCKCR, DIVSEL_XSPI0,
> > +               sel_clk_pll4d1_div3_div4,
> > +               ARRAY_SIZE(sel_clk_pll4d1_div3_div4), CLK_MUX_HIWORD_MA=
SK),
> > +       DEF_MUX(".divselxspi1", CLK_DIVSELXSPI1_SCKCR, DIVSEL_XSPI1,
> > +               sel_clk_pll4d1_div3_div4,
> > +               ARRAY_SIZE(sel_clk_pll4d1_div3_div4), CLK_MUX_HIWORD_MA=
SK),
> > +
> >         /* Core output clk */
> >         DEF_DIV("CA55C0", R9A09G077_CLK_CA55C0, CLK_SEL_CLK_PLL0, DIVCA=
55C0,
> >                 dtable_1_2),
> > @@ -178,9 +205,15 @@ static const struct cpg_core_clk r9a09g077_core_cl=
ks[] __initconst =3D {
> >         DEF_FIXED("ETCLKC", R9A09G077_ETCLKC, CLK_SEL_CLK_PLL1, 10, 1),
> >         DEF_FIXED("ETCLKD", R9A09G077_ETCLKD, CLK_SEL_CLK_PLL1, 20, 1),
> >         DEF_FIXED("ETCLKE", R9A09G077_ETCLKE, CLK_SEL_CLK_PLL1, 40, 1),
> > +       DEF_DIV("XSPI_CLK0", R9A09G077_XSPI_CLK0, CLK_DIVSELXSPI0_SCKCR=
,
> > +               FSELXSPI0, dtable_6_8_16_32_64),
> > +       DEF_DIV("XSPI_CLK1", R9A09G077_XSPI_CLK1, CLK_DIVSELXSPI1_SCKCR=
,
> > +               FSELXSPI1, dtable_6_8_16_32_64),
> >  };
>
> Perhaps we need a custom clock for this?
> According to Section 7.3.1 "SCKCR : System Clock Control Register",
> some divider combinations are prohibited:
>   - 4 x 6,
>   - 4 x 32,
>   - 4 x 64.
> The last two are probably not an issue iff the xSPI driver never tries
> to set the corresponding clock rates.
> However, the first one may be an issue, as both 3 x 8 (valid) and 4 x 6
> (prohibited) yield the same resulting divider, and I believe we cannot
> be sure the clock core will never pick the prohibited combination.
>
Agreed, I think I will have to compose both MUX and the divider into a
single clock so that the dividers can be adjusted based on the MUX
value, or do you have any suggestion to just adjust the divider clocks
and leave the MUX clocks as is?

Cheers,
Prabhakar

