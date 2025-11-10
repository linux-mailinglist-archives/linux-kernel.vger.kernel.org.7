Return-Path: <linux-kernel+bounces-894185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D37C496F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C781884BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C708F2F5A02;
	Mon, 10 Nov 2025 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0M0zD4y"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCA632D0C4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810738; cv=none; b=sBsjI0MeRbJtp/zKtPcC6ANp+kdbQpgYCqg6pfTvg+m+VmZyY3wb7zSHKaaqE5XnuOUveYnbccBiLsNCvHQF47KMNyJuRsfbsC+omaaov4OmDSbPzWTuOcJ9bYklzH0jgyr2yH20mpVqtlDH+K+VTxnOhlMisrYN6WAPkvWKIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810738; c=relaxed/simple;
	bh=cTdgEbBzQVj0+Jsk5gVE414ysvFa19EZPgFiisqpJ5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IftA2e4JaVwQsySDeEmXrN7dsHcc+cdd7WRQwRuXaakcaffPspPUwWIoBExA/oM7mOKydCD8YxTBGqpASmgnJZoh+YbDZpoTyb3TxYtsDyQJM3Gq+giDz0XwK4mhejXbEdkiWF0GzrA/JPuU5jFEhlWRfNE/+bwsaTXolLsFwco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0M0zD4y; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b379cd896so1008202f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762810735; x=1763415535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKeG3s/W/qSrdcqT78Gs/bWuaBXLVMnbI+0M79sKo3Y=;
        b=O0M0zD4yMInmGF4eOihyFDaAgWyYoOc27QE4JrLLkCp+3LXrp3NR8P8KAz9Zwbu4sz
         CvCce64n+UxDj+WzS81orgUR/dP7R0YQbkocflym6zejHQ6Zr3+gTYURyW8DD0jzPac9
         sgGAD9j57W05FcB7zR+k6fWQSZ8mGrRY9Q/akuHecCXjDZZw4w8IakgVK3zaJHv8S0fI
         pkW4Lf7Jj7D0Pl++zllNNOZ4vt5FNmBwng1jHsAT//tdOo9nUusm0Uy8v9ENXaIk0LIe
         kr69PjaTMNu9eFN26yE/83INQBKP0/kKgQocIDM9JmJJ31Ot/wxffS9qCNeenM/rQ/Ug
         mpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762810735; x=1763415535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gKeG3s/W/qSrdcqT78Gs/bWuaBXLVMnbI+0M79sKo3Y=;
        b=iVTbxjGQP3d35ok3ZKEb2q/dE0EozMnlkUuUN4h64UK29OM/s9XizNffr3NQDVCnQ3
         uHlNJOQcVkitH4uVj7tsxPp3XyHm0qvV6RavmFLDl3qzkFcXSn4IGN/oOgTWnafLnwqq
         UfNXKxZbAYbj4dd3uxnxctyWgfol0ke/T9sdV+bTUzUCKvKPqX0pMWhcuoOTX/uOIGKP
         GVs0J7wt6+fVXusvcsl+hgCr5tgoNZDDGnf/cEKfg8gKgysp6gB91JmaW2+ux/WpazfT
         TsGPVhl0hAOjNAcHA6OkPncI78WuPDXVSHCtGguXJWk1zKMbhakk6P90IMbQZrNhbLJs
         GRpg==
X-Forwarded-Encrypted: i=1; AJvYcCUShKad076vA+6rU+SKjQQjwoAmjhFqyW9IW3Y1UxQ9TZiajYv2HBmUISRU7t+GOp6AyU1bCoXlDbSM+H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywHg56dhtOfcpB2mOSjqxL/zIUUyIZj7LKyBKB5GFmiOdrAls9
	9oprrKyl1a6hnh79QoNGgtF97m0x7m7h1prc7+4nkFEg1DVRytIeAgCoXwV+Q+OhejPTch6+Kc7
	wKYTnRMSMZiYyyXLCy+Um03kwkYWTEgg=
X-Gm-Gg: ASbGncsT/y15cHh2eGRonStc7uXFa63QGSgwLWmUwhbe+GAZieF5IRuQ/JvJ5L5WEx4
	bvgB4F4HH4ZHBpak/ed/WEMQwJXe1I84asQh27g+y3iOfdXKL7vp47vmXcup7PvyEmb/uIkZEip
	O/xB2ooHr8s87JEpeIB1CpwJjKtp3JP7XCZhx3J4bd/xmkqXBQlCxFCwEciBLzxvl25lBoVdBkl
	c7LWd6kGZzBEwDbAFYnYyuwsPlxwnSj4R5FUZyIpAx6IA9XITWjENmUaNTFZA==
X-Google-Smtp-Source: AGHT+IEkjjibfkmx2CZAzFzB++b/Z6pjVW3//MbnY2TuzRb79D5BUaXVRojqYqi9CAVOksR9Vhda87sXtYzfjBEJpEA=
X-Received: by 2002:a05:6000:200e:b0:427:9d7:86f9 with SMTP id
 ffacd0b85a97d-42b2dca3f67mr8790808f8f.47.1762810734542; Mon, 10 Nov 2025
 13:38:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028165127.991351-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251028165127.991351-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWSB4OvS5AeWqOBQPNG2J9VMYe9YUeXAp9kPjcJEQm3+g@mail.gmail.com>
In-Reply-To: <CAMuHMdWSB4OvS5AeWqOBQPNG2J9VMYe9YUeXAp9kPjcJEQm3+g@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 10 Nov 2025 21:38:28 +0000
X-Gm-Features: AWmQ_bkBTTeO5RvxzqkAQX0F83hRREO1oo07OyPg6IEMnJcpjj4Wjh6daMvSTc4
Message-ID: <CA+V-a8sC44HeShCFdk2xwTHMdcOo+8btNh9i0hthTEUMdnhqAQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] clk: renesas: r9a09g077: Add xSPI core and module clocks
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

On Mon, Nov 10, 2025 at 1:48=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, 28 Oct 2025 at 17:52, Prabhakar <prabhakar.csengg@gmail.com> wrot=
e:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add core clocks and module clock definitions required by the xSPI
> > (Expanded SPI) IP on the R9A09G077 SoC.
> >
> > Define the new SCKCR fields FSELXSPI0/FSELXSPI1 and DIVSEL_XSPI0/1 and
> > add two new core clocks XSPI_CLK0 and XSPI_CLK1. The xSPI block uses
> > PCLKH as its bus clock (use as module clock parent) while the operation
> > clock (XSPI_CLKn) is derived from PLL4. To support this arrangement
> > provide mux/div selectors and divider tables for the supported
> > XSPI operating rates.
> >
> > Add CLK_TYPE_RZT2H_FSELXSPI to implement a custom divider/mux clock
> > where the determine_rate() callback enforces the hardware constraint:
> > when the parent output is 600MHz only dividers 8 and 16 are valid,
> > whereas for 800MHz operation the full divider set (6,8,16,32,64) may
> > be used. The custom determine_rate() picks the best parent/divider pair
> > to match the requested rate and programs the appropriate SCKCR fields.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> > - Added custom divider clock type for XSPI clocks to enforce hardware
> >   constraints on supported operating rates.
>
> Thanks for the update!
>
> > --- a/drivers/clk/renesas/r9a09g077-cpg.c
> > +++ b/drivers/clk/renesas/r9a09g077-cpg.c
>
> > @@ -54,12 +56,19 @@
> >  #define DIVSCI3ASYNC   CONF_PACK(SCKCR3, 12, 2)
> >  #define DIVSCI4ASYNC   CONF_PACK(SCKCR3, 14, 2)
> >
> > +#define FSELXSPI0      CONF_PACK(SCKCR, 0, 3)
> > +#define FSELXSPI1      CONF_PACK(SCKCR, 8, 3)
> > +#define DIVSEL_XSPI0   CONF_PACK(SCKCR, 6, 1)
> > +#define DIVSEL_XSPI1   CONF_PACK(SCKCR, 14, 1)
> >  #define SEL_PLL                CONF_PACK(SCKCR, 22, 1)
> >
> > +#define DIVSELXSPI_RATE_600MHZ         600000000UL
> > +#define DIVSELXSPI_RATE_800MHZ         800000000UL
>
> I find it a bit weird that the name of the define includes its value.
> Perhaps just use "600 * MEGA" resp. "800 * MEGA" in the code instead?
OK.

> But see below...
>
> > @@ -154,6 +180,15 @@ static const struct cpg_core_clk r9a09g077_core_cl=
ks[] __initconst =3D {
> >         DEF_DIV(".sci5async", CLK_SCI5ASYNC, CLK_PLL4D1, DIVSCI5ASYNC,
> >                 dtable_24_25_30_32),
> >
> > +       DEF_FIXED(".pll4d1_div3", CLK_PLL4D1_DIV3, CLK_PLL4D1, 3, 1),
> > +       DEF_FIXED(".pll4d1_div4", CLK_PLL4D1_DIV4, CLK_PLL4D1, 4, 1),
>
> Please move these two just below the existing entry for ".pll4d1".
>
Ok, I will move it below .pll4d1

> > +       DEF_MUX(".divselxspi0", CLK_DIVSELXSPI0_SCKCR, DIVSEL_XSPI0,
> > +               sel_clk_pll4d1_div3_div4,
> > +               ARRAY_SIZE(sel_clk_pll4d1_div3_div4), 0),
> > +       DEF_MUX(".divselxspi1", CLK_DIVSELXSPI1_SCKCR, DIVSEL_XSPI1,
> > +               sel_clk_pll4d1_div3_div4,
> > +               ARRAY_SIZE(sel_clk_pll4d1_div3_div4), 0),
> > +
> >         /* Core output clk */
> >         DEF_DIV("CA55C0", R9A09G077_CLK_CA55C0, CLK_SEL_CLK_PLL0, DIVCA=
55C0,
> >                 dtable_1_2),
>
> > @@ -264,6 +305,116 @@ r9a09g077_cpg_mux_clk_register(struct device *dev=
,
> >         return clk_hw->clk;
> >  }
> >
> > +static int r9a09g077_cpg_fselxspi_determine_rate(struct clk_hw *hw,
> > +                                                struct clk_rate_reques=
t *req)
> > +{
> > +       struct clk_divider *divider =3D to_clk_divider(hw);
> > +       unsigned long parent_rate, best =3D 0, now;
> > +       const struct clk_div_table *clkt;
> > +       unsigned long rate =3D req->rate;
> > +       int div =3D 0;
>
> unsigned int
>
Ok.

> > +
> > +       if (!rate)
> > +               rate =3D 1;
> > +
> > +       for (clkt =3D divider->table; clkt->div; clkt++) {
> > +               parent_rate =3D clk_hw_round_rate(req->best_parent_hw, =
rate * clkt->div);
>
> I had expected the use of some *_determinate_rate_*() helper, as the
> parent can be changed to find a better clock rate?
> Perhaps you should use a composite clock for that?
>
> > +               /*
> > +                * DIVSELXSPIx supports 800MHz and 600MHz operation.
> > +                * When the parent_rate is 600MHz, only dividers of 8 a=
nd 16
> > +                * are supported otherwise dividers of 6, 8, 16, 32, 64=
 are supported.
> > +                * This check ensures that FSELXSPIx is set correctly.
> > +                */
> > +               if (parent_rate =3D=3D DIVSELXSPI_RATE_600MHZ &&
>
> Does this actually work as expected? I doubt parent_rate is guaranteed
> to be exactly 600 or 800 MHz, and expect it can differ slightly due
> to rounding.  Hence I would look at clk_fixed_factor.div instead.
>
With below diff, Ive got the below results for the various freqs
requested where appropriate parent and divider clocks are picked.

@@ -317,6 +317,7 @@ static int
r9a09g077_cpg_fselxspi_determine_rate(struct clk_hw *hw,

        for (clkt =3D divider->table; clkt->div; clkt++) {
                parent_rate =3D clk_hw_round_rate(req->best_parent_hw,
rate * clkt->div);
+               pr_err("parent_rate=3D%lu, req-rate=3D%lu div=3D%u\n",
parent_rate, rate, clkt->div);
                /*
                 * DIVSELXSPIx supports 800MHz and 600MHz operation.
                 * When the parent_rate is 600MHz, only dividers of 8 and 1=
6

Logs:
---------

Case 0# assigned-clock-rates =3D <133333334>;
[   15.419300] parent_rate=3D800000000, req-rate=3D133333334 div=3D64
[   15.437698] parent_rate=3D800000000, req-rate=3D133333334 div=3D32
[   15.455224] parent_rate=3D800000000, req-rate=3D133333334 div=3D16
[   15.501291] parent_rate=3D800000000, req-rate=3D133333334 div=3D8
[   15.507801] parent_rate=3D800000000, req-rate=3D133333334 div=3D6
[   15.519221] parent_rate=3D800000000, req-rate=3D133333334 div=3D64
[   15.525789] parent_rate=3D800000000, req-rate=3D133333334 div=3D32
[   15.549625] parent_rate=3D800000000, req-rate=3D133333334 div=3D16
[   15.556120] parent_rate=3D800000000, req-rate=3D133333334 div=3D8
[   15.564110] parent_rate=3D800000000, req-rate=3D133333334 div=3D6

root@rzt2h-evk:~# cat /sys/kernel/debug/clk/clk_summary | grep -e
"xspi0" -e "XSPI_CLK0" -e "divselxspi0"
                .divselxspi0         1       1        0
800000000   0          0     50000      Y                  deviceless
                    no_connection_id
                   XSPI_CLK0         1       1        0
133333334   0          0     50000      Y
801c0000.spi                    spi
             xspi0                   0       1        0
250000000   0          0     50000      N               deviceless
                 of_clk_get_from_provider
root@rzt2h-evk:~#

Case 1# assigned-clock-rates =3D <100000000>;
[   15.496291] parent_rate=3D800000000, req-rate=3D100000000 div=3D64
[   15.510068] parent_rate=3D800000000, req-rate=3D100000000 div=3D32
[   15.517142] parent_rate=3D800000000, req-rate=3D100000000 div=3D16
[   15.524047] parent_rate=3D800000000, req-rate=3D100000000 div=3D8
[   15.533174] parent_rate=3D600000000, req-rate=3D100000000 div=3D6
[   15.540096] parent_rate=3D800000000, req-rate=3D100000000 div=3D64
[   15.548135] parent_rate=3D800000000, req-rate=3D100000000 div=3D32
[   15.555119] parent_rate=3D800000000, req-rate=3D100000000 div=3D16
[   15.562395] parent_rate=3D800000000, req-rate=3D100000000 div=3D8
[   15.573521] parent_rate=3D600000000, req-rate=3D100000000 div=3D6

root@rzt2h-evk:~# cat /sys/kernel/debug/clk/clk_summary | grep -e
"xspi0" -e "XSPI_CLK0" -e "divselxspi0"
                .divselxspi0         1       1        0
800000000   0          0     50000      Y                  deviceless
                    no_connection_id
                   XSPI_CLK0         1       1        0
100000000   0          0     50000      Y
801c0000.spi                    spi
             xspi0                   0       1        0
250000000   0          0     50000      N               deviceless
                 of_clk_get_from_provider
root@rzt2h-evk:~#


Case 2# assigned-clock-rates =3D <75000000>;
[   12.288507] parent_rate=3D800000000, req-rate=3D75000000 div=3D64
[   12.310528] parent_rate=3D800000000, req-rate=3D75000000 div=3D32
[   12.318426] parent_rate=3D800000000, req-rate=3D75000000 div=3D16
[   12.326361] parent_rate=3D600000000, req-rate=3D75000000 div=3D8
[   12.341540] parent_rate=3D0, req-rate=3D75000000 div=3D6
[   12.347546] parent_rate=3D800000000, req-rate=3D75000000 div=3D64
[   12.357593] parent_rate=3D800000000, req-rate=3D75000000 div=3D32
[   12.367148] parent_rate=3D800000000, req-rate=3D75000000 div=3D16
[   12.418871] parent_rate=3D600000000, req-rate=3D75000000 div=3D8
[   12.433560] parent_rate=3D0, req-rate=3D75000000 div=3D6

root@rzt2h-evk:~# cat /sys/kernel/debug/clk/clk_summary | grep -e
"xspi0" -e "XSPI_CLK0" -e "divselxspi0"
                .divselxspi0         1       1        0
600000000   0          0     50000      Y                  deviceless
                    no_connection_id
                   XSPI_CLK0         1       1        0
75000000    0          0     50000      Y
801c0000.spi                    spi
             xspi0                   0       1        0
250000000   0          0     50000      N               deviceless
                 of_clk_get_from_provider
root@rzt2h-evk:~#

Case 3# assigned-clock-rates =3D <50000000>;
[   15.240214] parent_rate=3D800000000, req-rate=3D50000000 div=3D64
[   15.253498] parent_rate=3D800000000, req-rate=3D50000000 div=3D32
[   15.261521] parent_rate=3D800000000, req-rate=3D50000000 div=3D16
[   15.272941] parent_rate=3D0, req-rate=3D50000000 div=3D8
[   15.280532] parent_rate=3D0, req-rate=3D50000000 div=3D6
[   15.289979] parent_rate=3D800000000, req-rate=3D50000000 div=3D64
[   15.298745] parent_rate=3D800000000, req-rate=3D50000000 div=3D32
[   15.309879] parent_rate=3D800000000, req-rate=3D50000000 div=3D16
[   15.319881] parent_rate=3D0, req-rate=3D50000000 div=3D8
[   15.327977] parent_rate=3D0, req-rate=3D50000000 div=3D6

root@rzt2h-evk:~# cat /sys/kernel/debug/clk/clk_summary | grep -e
"xspi0" -e "XSPI_CLK0" -e "divselxspi0"
                .divselxspi0         1       1        0
800000000   0          0     50000      Y                  deviceless
                    no_connection_id
                   XSPI_CLK0         1       1        0
50000000    0          0     50000      Y
801c0000.spi                    spi
             xspi0                   0       1        0
250000000   0          0     50000      N               deviceless
                 of_clk_get_from_provider
root@rzt2h-evk:~#


Case 4# assigned-clock-rates =3D <37500000>;
[   71.710064] parent_rate=3D800000000, req-rate=3D37500000 div=3D64
[   71.718567] parent_rate=3D800000000, req-rate=3D37500000 div=3D32
[   71.725137] parent_rate=3D600000000, req-rate=3D37500000 div=3D16
[   71.731550] parent_rate=3D0, req-rate=3D37500000 div=3D8
[   71.740622] parent_rate=3D0, req-rate=3D37500000 div=3D6
[   71.746376] parent_rate=3D800000000, req-rate=3D37500000 div=3D64
[   71.752887] parent_rate=3D800000000, req-rate=3D37500000 div=3D32
[   71.767422] parent_rate=3D600000000, req-rate=3D37500000 div=3D16
[   71.778671] parent_rate=3D0, req-rate=3D37500000 div=3D8
[   71.790895] parent_rate=3D0, req-rate=3D37500000 div=3D6

root@rzt2h-evk:~# cat /sys/kernel/debug/clk/clk_summary | grep -e
"xspi0" -e "XSPI_CLK0" -e "divselxspi0"
                .divselxspi0         1       1        0
600000000   0          0     50000      Y                  deviceless
                    no_connection_id
                   XSPI_CLK0         1       1        0
37500000    0          0     50000      Y
801c0000.spi                    spi
             xspi0                   0       1        0
250000000   0          0     50000      N               deviceless
                 of_clk_get_from_provider
root@rzt2h-evk:~#


Case 5# assigned-clock-rates =3D <25000000>;
[   12.411660] parent_rate=3D800000000, req-rate=3D25000000 div=3D64
[   12.429285] parent_rate=3D800000000, req-rate=3D25000000 div=3D32
[   12.436144] parent_rate=3D0, req-rate=3D25000000 div=3D16
[   12.448110] parent_rate=3D0, req-rate=3D25000000 div=3D8
[   12.458785] parent_rate=3D0, req-rate=3D25000000 div=3D6
[   12.465401] parent_rate=3D800000000, req-rate=3D25000000 div=3D64
[   12.482547] parent_rate=3D800000000, req-rate=3D25000000 div=3D32
[   12.497126] parent_rate=3D0, req-rate=3D25000000 div=3D16
[   12.509619] parent_rate=3D0, req-rate=3D25000000 div=3D8
[   12.518212] parent_rate=3D0, req-rate=3D25000000 div=3D6

root@rzt2h-evk:~# cat /sys/kernel/debug/clk/clk_summary | grep -e
"xspi0" -e "XSPI_CLK0" -e "divselxspi0"
                .divselxspi0         1       1        0
800000000   0          0     50000      Y                  deviceless
                    no_connection_id
                   XSPI_CLK0         1       1        0
25000000    0          0     50000      Y
801c0000.spi                    spi
             xspi0                   0       1        0
250000000   0          0     50000      N               deviceless
                 of_clk_get_from_provider
root@rzt2h-evk:~#

Case 6# assigned-clock-rates =3D <12500000>;
[   87.409877] parent_rate=3D800000000, req-rate=3D12500000 div=3D64
[   87.470663] parent_rate=3D0, req-rate=3D12500000 div=3D32
[   87.485940] parent_rate=3D0, req-rate=3D12500000 div=3D16
[   87.492760] parent_rate=3D0, req-rate=3D12500000 div=3D8
[   87.498313] parent_rate=3D0, req-rate=3D12500000 div=3D6


root@rzt2h-evk:~# cat /sys/kernel/debug/clk/clk_summary | grep -e
"xspi0" -e "XSPI_CLK0" -e "divselxspi0"
                .divselxspi0         1       1        0
800000000   0          0     50000      Y                  deviceless
                    no_connection_id
                   XSPI_CLK0         1       1        0
12500000    0          0     50000      Y
801c0000.spi                    spi
             xspi0                   0       1        0
250000000   0          0     50000      N               deviceless
                 of_clk_get_from_provider
root@rzt2h-evk:~#

Looking at the logs I think I could optimize the code to continue when
 parent_rate =3D=3D 0

Based on the above logs, would you prefer me to represent it as a
composite clock?

> > +                   (clkt->div !=3D 8 && clkt->div !=3D 16))
> > +                       continue;
> > +               now =3D DIV_ROUND_UP_ULL((u64)parent_rate, clkt->div);
>
> No need to cast to u64 (DIV_ROUND_*_ULL() handle this internally).
>
> > +               if (abs(rate - now) < abs(rate - best)) {
> > +                       div =3D clkt->div;
> > +                       best =3D now;
> > +                       req->best_parent_rate =3D parent_rate;
> > +               }
> > +       }
> > +
> > +       if (!div) {
> > +               u8 maxdiv =3D 0;
> > +
> > +               req->best_parent_rate =3D clk_hw_round_rate(req->best_p=
arent_hw, 1);
> > +               /*
> > +                * If DIVSELXSPIx is set to 800MHz set the maximum divi=
der
> > +                * or else fall back to divider of 16 which is a maximu=
m
> > +                * supported divider for 600MHz operation.
> > +                */
> > +               if (req->best_parent_rate =3D=3D DIVSELXSPI_RATE_800MHZ=
) {
> > +                       for (clkt =3D divider->table; clkt->div; clkt++=
) {
> > +                               if (clkt->div > maxdiv)
> > +                                       maxdiv =3D clkt->div;
> > +                       }
> > +                       div =3D maxdiv;
>
> Why not hardcode the divider, like in the else branch?
>
Agreed.

> > +               } else {
> > +                       div =3D 16;
> > +               }
> > +       }
> > +
> > +       req->rate =3D DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div)=
;
>
> No need to cast to u64.
>
Ok.

Cheers,
Prabhakar

