Return-Path: <linux-kernel+bounces-873311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8545CC13A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291FC188F343
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C5A2DA757;
	Tue, 28 Oct 2025 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnz35cur"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154062D978C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641452; cv=none; b=lHPBKtU01VBoaH4pQbhmBbmBgV/ozMbim6Z3oICoCDaxS98Li62lrCXQQJAzeJPSyQKG14GcDUC9Ali5mpO6yfVVmLqUhQqPRT4bAkGRkVPR7z4D+KWp6gaIKMbIBCiGdpGk5QWobKlYdgPYJ+9U9NcvLIhhYirE7/ZgZt2ipf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641452; c=relaxed/simple;
	bh=Xdha3Rbw7q8Rx3Aq6GUDX3Wcq227kyf0sjRqcy5XAr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q27X1qukLXU7tNWGqNN7pyEl8mZ+6MdGdGsiDHipIHE3LmOvZ8PsY1k+o62tPZHLhiOqdGADY6BUAnF4xry0KXSSIBdMY5AGMKOmHRAehx7aMrp2r6v7TfFOgOuPE4esjuYjqQM8VJvboz9f5ZgP7HvhCYX4XmksFUXDo1YG12E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tnz35cur; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-653652a4256so2806477eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761641449; x=1762246249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xOPNx4zwn1gWAqQlraw+KqNJSUJbyMQN3Nqh5AP2GY=;
        b=tnz35curujTGu1Evgajx1FDmpULIezDYf0XhoEJLyohl3m1jldRAVaKrHm1OEKGNfa
         OisuRTv5+BiUfCmeTJlULFQQiJByi6F7OfkSM/xUHI+o/TG5j7X7zu1BLI0xmDUl9nDH
         8OXDkbHDLWUeI0F+QRZ5mYVwsAbvNU1/hgdK6rZW7RAEobMOcTk0Eo6xTKIa9x+13fCY
         Hd1cAn+nDERP7AHXTeqi95ZG19gb4l5iymeF0jQfA64kn5KL1nSIXjh5gercsfy10fpP
         VZwpGyzpO/IDmf/8Cb6JGtahuzjeCQoKhezabB8cK23jYhIl5A7k5wxVf/LTKFGBDDEI
         NMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761641449; x=1762246249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xOPNx4zwn1gWAqQlraw+KqNJSUJbyMQN3Nqh5AP2GY=;
        b=Hj8jK8Y8fxd8ri3poTVPs60ue21ZigLhUnG1QPwv5vqKPz1lwah971WSfRiIHoJYBe
         b43n8L3azidUy3+fBo5+uIhF4B7C6haf4iPb6P9r5YTL6l4AmUfi1HJdiEKWmKEuO7+Z
         n9e1vVqJKWHVeLuyIdfa4DeUc9jzMTF2DRuz/m77JnRGlPR8JUWsjzkj+1+5g0x6d7Sc
         pLbF6HrZtHrKHLEtJnnagF9R3CaTf+YcuKyEtqICqunQsQQwlmmHvGsKhTJ+DJa0EUdi
         QNMDV6yit9sfONWdbKeCDnEe3NnvpO06f42JG6hRIT9mLu0ZhPpCeYGHwlWT+C0a5sX6
         sHjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV86FtqD/Jadxz1sm5iEuJ46yuJdSkc/Xk1S36uo6RGzUmD4B/dnIzpZEVlL54mUsBqSp0CMM57uNMzMwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj3CZ26Tc0cz0oFzOzA4h/pOIYgu/m2RL6Hq6sBnmY8+xiB3fZ
	IjIJz5YmT5p0+uaxMms7+p9yKo3spaZTmECj2kGq1StA1/QeTz8c3wBGLQkedmeVhrR8S5zfF23
	/1j1XXl4y1EvJ4szxht+DoqtMQNcLf3v8nxwKQBCQIw==
X-Gm-Gg: ASbGnctbBa/CyazYGuzMVOBYsehuCj/JdlkfUl6nfa3U3Wno/Fwcz7xMJh+IInGQJw3
	4q3SxwKx6jbZrMcrMzyLVE1UG1sZT3NPZMKSjC0wN9rVCJot5Od3slA16w4lA3ieT/+tZRAOrRU
	5jwBfvF3//hCAnGnEOmRSbxZfT5cb14GmlTRtGmdnSPYezA5QlikvwX+ho3Yu593GmBgcXvcw7z
	0bqjFNPnDI1jvvOJB/ingJ5U2eOsDAXAs6QBAr1IQQvdzZfJIxn8+2Q+mC7rw==
X-Google-Smtp-Source: AGHT+IE8XR7jUP3YwCIJt23WPnfZM4pIYayIeDLjyezkC4j1esW05XCMYLHUQF9g4zUeA4ZG7nBSBl8dzKK1zoq+Iek=
X-Received: by 2002:a05:6871:3319:b0:3d4:5e0e:c8c6 with SMTP id
 586e51a60fabf-3d5d74e6a50mr1145224fac.10.1761641448899; Tue, 28 Oct 2025
 01:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
 <20251013-automatic-clocks-v1-7-72851ee00300@linaro.org> <fade8bd8d912b2672ec839e5819367691fec6b72.camel@linaro.org>
In-Reply-To: <fade8bd8d912b2672ec839e5819367691fec6b72.camel@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 28 Oct 2025 08:50:38 +0000
X-Gm-Features: AWmQ_blHaBCCu6DqUdAbN0Qtt_o_yvlPCdoUZP2SPo2otNX3lrxRWvxkXTQp3wg
Message-ID: <CADrjBPq9aPFZ5Oqw_R6MyZiWtuFaQtzRO7PYGs0FLLfHy7UgtA@mail.gmail.com>
Subject: Re: [PATCH 7/9] clk: samsung: Implement automatic clock gating mode
 for CMUs
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Will McVicker <willmcvicker@google.com>, Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

Thanks for the review feedback!

On Thu, 16 Oct 2025 at 10:40, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> Hi Peter,
>
> On Mon, 2025-10-13 at 21:51 +0100, Peter Griffin wrote:
> > Update exynos_arm64_init_clocks() so that it enables the automatic cloc=
k
> > mode bits in the CMU option register if the auto_clock_gate flag and
> > option_offset fields are set for the CMU.
> >
> > The CMU option register bits are global and effect every clock componen=
t in
> > the CMU, as such clearing the GATE_ENABLE_HWACG bit and setting GATE_MA=
NUAL
> > bit on every gate register is only required if auto_clock_gate is false=
.
> >
> > Additionally if auto_clock_gate is enabled the dynamic root clock gatin=
g
> > and memclk registers will be configured in the corresponding CMUs sysre=
g
> > bank. These registers are exposed via syscon, so the register
> > suspend/resume paths are updated to handle using a regmap.
> >
> > As many gates for various Samsung SoCs are already exposed in the Samsu=
ng
> > clock drivers a new samsung_auto_clk_gate_ops is implemented. This uses
> > some CMU debug registers to report whether clocks are enabled or disabl=
ed
> > when operating in automatic mode. This allows
> > /sys/kernel/debug/clk/clk_summary to still dump the entire clock tree a=
nd
> > correctly report the status of each clock in the system.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>
> It's great to see some effort on this topic as this makes the clock handl=
ing
> on new Exynos much easier and less error prone and time-consuming, and ha=
ving
> the hardware decide which clocks need to be enabled at a given point in t=
ime
> allows for a significantly more dynamic environment.
>
> Just some initial comments below.
>
> > ---
> >  drivers/clk/samsung/clk-exynos-arm64.c   |  47 +++++++--
> >  drivers/clk/samsung/clk-exynos4.c        |   6 +-
> >  drivers/clk/samsung/clk-exynos4412-isp.c |   4 +-
> >  drivers/clk/samsung/clk-exynos5250.c     |   2 +-
> >  drivers/clk/samsung/clk-exynos5420.c     |   4 +-
> >  drivers/clk/samsung/clk.c                | 161 +++++++++++++++++++++++=
+++++---
> >  drivers/clk/samsung/clk.h                |  49 +++++++++-
> >  7 files changed, 244 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/clk/samsung/clk-exynos-arm64.c b/drivers/clk/samsu=
ng/clk-exynos-arm64.c
> > index bf7de21f329ec89069dcf817ca578fcf9b2d9809..c302c836e8f9f6270753d86=
d7d986c88e6762f4f 100644
> > --- a/drivers/clk/samsung/clk-exynos-arm64.c
> > +++ b/drivers/clk/samsung/clk-exynos-arm64.c
> > @@ -24,6 +24,16 @@
> >  #define GATE_MANUAL          BIT(20)
> >  #define GATE_ENABLE_HWACG    BIT(28)
> >
> > +/* Option register bits */
> > +#define OPT_EN_DBG                   BIT(31)
> > +#define OPT_UNKNOWN                  BIT(30)
>
> Except for AOC, bit 30 is called ENABLE_LAYER2_CTRL in all gs101 CMUs.

Will fix.

>
> > +#define OPT_EN_PWR_MANAGEMENT                BIT(29)
> > +#define OPT_EN_AUTO_GATING           BIT(28)
> > +#define OPT_EN_MEM_PM_GATING         BIT(24)
> > +
> > +#define CMU_OPT_GLOBAL_EN_AUTO_GATING        (OPT_EN_DBG | OPT_UNKNOWN=
 | \
> > +     OPT_EN_PWR_MANAGEMENT | OPT_EN_AUTO_GATING | OPT_EN_MEM_PM_GATING=
)
> > +
> >  /* PLL_CONx_PLL register offsets range */
> >  #define PLL_CON_OFF_START    0x100
> >  #define PLL_CON_OFF_END              0x600
> > @@ -37,6 +47,8 @@ struct exynos_arm64_cmu_data {
> >       unsigned int nr_clk_save;
> >       const struct samsung_clk_reg_dump *clk_suspend;
> >       unsigned int nr_clk_suspend;
> > +     struct samsung_clk_reg_dump *clk_sysreg_save;
> > +     unsigned int nr_clk_sysreg;
> >
> >       struct clk *clk;
> >       struct clk **pclks;
> > @@ -82,13 +94,28 @@ static void __init exynos_arm64_init_clocks(struct =
device_node *np,
> >       if (!reg_base)
> >               panic("%s: failed to map registers\n", __func__);
> >
> > +     if (cmu->auto_clock_gate && cmu->option_offset) {
> > +             /*
> > +              * Enable the global automatic mode for the entire CMU.
> > +              * This overrides the individual HWACG bits in each of th=
e
> > +              * individual gate, mux and qch registers.
> > +              */
> > +             writel(CMU_OPT_GLOBAL_EN_AUTO_GATING,
> > +                    reg_base + cmu->option_offset);
> > +     }
> > +
> >       for (i =3D 0; i < reg_offs_len; ++i) {
> >               void __iomem *reg =3D reg_base + reg_offs[i];
> >               u32 val;
> >
> >               if (cmu->manual_plls && is_pll_con1_reg(reg_offs[i])) {
> >                       writel(PLL_CON1_MANUAL, reg);
> > -             } else if (is_gate_reg(reg_offs[i])) {
> > +             } else if (is_gate_reg(reg_offs[i]) && !cmu->auto_clock_g=
ate) {
> > +                     /*
> > +                      * Setting GATE_MANUAL bit (which is described in=
 TRM as
> > +                      * reserved!) overrides the global CMU automatic =
mode
> > +                      * option.
> > +                      */
> >                       val =3D readl(reg);
> >                       val |=3D GATE_MANUAL;
> >                       val &=3D ~GATE_ENABLE_HWACG;
> > @@ -219,7 +246,7 @@ void __init exynos_arm64_register_cmu(struct device=
 *dev,
> >   * Return: 0 on success, or negative error code on error.
> >   */
> >  int __init exynos_arm64_register_cmu_pm(struct platform_device *pdev,
> > -                                     bool set_manual)
> > +                                     bool init_clk_regs)
>
> kerneldoc needs updating

Good spot. Will fix

>
> >  {
> >       const struct samsung_cmu_info *cmu;
> >       struct device *dev =3D &pdev->dev;
> > @@ -249,7 +276,7 @@ int __init exynos_arm64_register_cmu_pm(struct plat=
form_device *pdev,
> >               dev_err(dev, "%s: could not enable bus clock %s; err =3D =
%d\n",
> >                      __func__, cmu->clk_name, ret);
> >
> > -     if (set_manual)
> > +     if (init_clk_regs)
> >               exynos_arm64_init_clocks(np, cmu);
> >
> >       reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> > @@ -280,14 +307,18 @@ int exynos_arm64_cmu_suspend(struct device *dev)
> >       struct exynos_arm64_cmu_data *data =3D dev_get_drvdata(dev);
> >       int i;
> >
> > -     samsung_clk_save(data->ctx->reg_base, data->clk_save,
> > +     samsung_clk_save(data->ctx->reg_base, NULL, data->clk_save,
> >                        data->nr_clk_save);
> >
> > +     if (data->ctx->sysreg)
> > +             samsung_clk_save(NULL, data->ctx->sysreg, data->clk_save,
> > +                              data->nr_clk_save);
> > +
>
> I think this should be
>
> +               samsung_clk_save(NULL, data->ctx->sysreg, data->clk_sysre=
g_save,
> +                                data->nr_clk_sysreg);

Yes, you're correct! Will fix.
>
> ?
>
> >       for (i =3D 0; i < data->nr_pclks; i++)
> >               clk_prepare_enable(data->pclks[i]);
> >
> >       /* For suspend some registers have to be set to certain values */
> > -     samsung_clk_restore(data->ctx->reg_base, data->clk_suspend,
> > +     samsung_clk_restore(data->ctx->reg_base, NULL, data->clk_suspend,
> >                           data->nr_clk_suspend);
> >
> >       for (i =3D 0; i < data->nr_pclks; i++)
> > @@ -308,9 +339,13 @@ int exynos_arm64_cmu_resume(struct device *dev)
> >       for (i =3D 0; i < data->nr_pclks; i++)
> >               clk_prepare_enable(data->pclks[i]);
> >
> > -     samsung_clk_restore(data->ctx->reg_base, data->clk_save,
> > +     samsung_clk_restore(data->ctx->reg_base, NULL, data->clk_save,
> >                           data->nr_clk_save);
> >
> > +     if (data->ctx->sysreg)
> > +             samsung_clk_restore(NULL, data->ctx->sysreg, data->clk_sa=
ve,
> > +                                 data->nr_clk_save);
> > +
>
> dito.

Will fix.

>
> >       for (i =3D 0; i < data->nr_pclks; i++)
> >               clk_disable_unprepare(data->pclks[i]);
> >
>
> [...]
>
> > diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> > index dbc9925ca8f46e951dfb5d391c0e744ca370abcc..07b2948ae7ea48f126ab420=
be57d8c2705979464 100644
> > --- a/drivers/clk/samsung/clk.c
> > +++ b/drivers/clk/samsung/clk.c
> > @@ -12,8 +12,10 @@
> >  #include <linux/clkdev.h>
> >  #include <linux/clk-provider.h>
> >  #include <linux/io.h>
> > +#include <linux/mfd/syscon.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/of_address.h>
> > +#include <linux/regmap.h>
> >  #include <linux/syscore_ops.h>
> >
> >  #include "clk.h"
> > @@ -21,19 +23,29 @@
> >  static LIST_HEAD(clock_reg_cache_list);
> >
> >  void samsung_clk_save(void __iomem *base,
> > +                                 struct regmap *regmap,
> >                                   struct samsung_clk_reg_dump *rd,
> >                                   unsigned int num_regs)
> >  {
> > -     for (; num_regs > 0; --num_regs, ++rd)
> > -             rd->value =3D readl(base + rd->offset);
> > +     for (; num_regs > 0; --num_regs, ++rd) {
> > +             if (base)
> > +                     rd->value =3D readl(base + rd->offset);
> > +             if (regmap)
>
> Should this be else if?

I will update it like you suggest to protect against that
>
> > +                     regmap_read(regmap, rd->offset, &rd->value);
>
> Otherwise users that (incorrectly) pass both base and regmap would
> cause this to end up reading the offset from the wrong memory
> region.
>
> At least this way that won't happen, but maybe this constrains should
> be made even more explicit.
>
> > +     }
> >  }
> >
> >  void samsung_clk_restore(void __iomem *base,
> > +                                   struct regmap *regmap,
> >                                     const struct samsung_clk_reg_dump *=
rd,
> >                                     unsigned int num_regs)
> >  {
> > -     for (; num_regs > 0; --num_regs, ++rd)
> > -             writel(rd->value, base + rd->offset);
> > +     for (; num_regs > 0; --num_regs, ++rd) {
> > +             if (base)
> > +                     writel(rd->value, base + rd->offset);
> > +             if (regmap)
> > +                     regmap_write(regmap, rd->offset, rd->value);
>
> dito.

Will fix.
>
> > +     }
> >  }
> >
> >  struct samsung_clk_reg_dump *samsung_clk_alloc_reg_dump(
> > @@ -227,6 +239,82 @@ void __init samsung_clk_register_div(struct samsun=
g_clk_provider *ctx,
> >       }
> >  }
> >
> > +#define ACG_MSK GENMASK(6, 4)
> > +#define CLK_IDLE GENMASK(5, 4)
> > +static int samsung_auto_clk_gate_is_en(struct clk_hw *hw)
> > +{
> > +     u32 reg;
> > +     struct clk_gate *gate =3D to_clk_gate(hw);
> > +
> > +     reg =3D readl(gate->reg);
> > +     return ((reg & ACG_MSK) =3D=3D CLK_IDLE) ? 0 : 1;
> > +}
> > +
> > +/* enable and disable are nops in automatic clock mode */
> > +static int samsung_auto_clk_gate_en(struct clk_hw *hw)
> > +{
> > +     return 0;
> > +}
> > +
> > +static void samsung_auto_clk_gate_dis(struct clk_hw *hw)
> > +{
> > +}
> > +
> > +static const struct clk_ops samsung_auto_clk_gate_ops =3D {
> > +     .enable =3D samsung_auto_clk_gate_en,
> > +     .disable =3D samsung_auto_clk_gate_dis,
> > +     .is_enabled =3D samsung_auto_clk_gate_is_en,
> > +};
> > +
> > +struct clk_hw *samsung_register_auto_gate(struct device *dev,
> > +             struct device_node *np, const char *name,
> > +             const char *parent_name, const struct clk_hw *parent_hw,
> > +             const struct clk_parent_data *parent_data,
> > +             unsigned long flags,
> > +             void __iomem *reg, u8 bit_idx,
> > +             u8 clk_gate_flags, spinlock_t *lock)
> > +{
> > +     struct clk_gate *gate;
> > +     struct clk_hw *hw;
> > +     struct clk_init_data init =3D {};
> > +     int ret =3D -EINVAL;
> > +
> > +     /* allocate the gate */
> > +     gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> > +     if (!gate)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     init.name =3D name;
> > +     init.ops =3D &samsung_auto_clk_gate_ops;
> > +     init.flags =3D flags;
> > +     init.parent_names =3D parent_name ? &parent_name : NULL;
> > +     init.parent_hws =3D parent_hw ? &parent_hw : NULL;
> > +     init.parent_data =3D parent_data;
> > +     if (parent_name || parent_hw || parent_data)
> > +             init.num_parents =3D 1;
> > +     else
> > +             init.num_parents =3D 0;
> > +
> > +     /* struct clk_gate assignments */
> > +     gate->reg =3D reg;
> > +     gate->bit_idx =3D bit_idx;
> > +     gate->flags =3D clk_gate_flags;
> > +     gate->lock =3D lock;
> > +     gate->hw.init =3D &init;
> > +
> > +     hw =3D &gate->hw;
> > +     if (dev || !np)
> > +             ret =3D clk_hw_register(dev, hw);
> > +     else if (np)
> > +             ret =3D of_clk_hw_register(np, hw);
> > +     if (ret) {
> > +             kfree(gate);
> > +             hw =3D ERR_PTR(ret);
> > +     }
> > +
> > +     return hw;
> > +}
> > +
> >  /* register a list of gate clocks */
> >  void __init samsung_clk_register_gate(struct samsung_clk_provider *ctx=
,
> >                               const struct samsung_gate_clock *list,
> > @@ -234,11 +322,21 @@ void __init samsung_clk_register_gate(struct sams=
ung_clk_provider *ctx,
> >  {
> >       struct clk_hw *clk_hw;
> >       unsigned int idx;
> > +     void __iomem *reg_offs;
> >
> >       for (idx =3D 0; idx < nr_clk; idx++, list++) {
> > -             clk_hw =3D clk_hw_register_gate(ctx->dev, list->name, lis=
t->parent_name,
> > -                             list->flags, ctx->reg_base + list->offset=
,
> > +             reg_offs =3D ctx->reg_base + list->offset;
> > +
> > +             if (ctx->auto_clock_gate && ctx->gate_dbg_offset)
> > +                     clk_hw =3D samsung_register_auto_gate(ctx->dev, N=
ULL,
> > +                             list->name, list->parent_name, NULL, NULL=
,
> > +                             list->flags, reg_offs + ctx->gate_dbg_off=
set,
> >                               list->bit_idx, list->gate_flags, &ctx->lo=
ck);
> > +             else
> > +                     clk_hw =3D clk_hw_register_gate(ctx->dev, list->n=
ame,
> > +                             list->parent_name, list->flags,
> > +                             ctx->reg_base + list->offset, list->bit_i=
dx,
> > +                             list->gate_flags, &ctx->lock);
> >               if (IS_ERR(clk_hw)) {
> >                       pr_err("%s: failed to register clock %s\n", __fun=
c__,
> >                               list->name);
>
> Maybe the error message should include the actual error clk_hw here?

Will update as you suggest.

>
> > @@ -276,10 +374,11 @@ static int samsung_clk_suspend(void)
> >       struct samsung_clock_reg_cache *reg_cache;
> >
> >       list_for_each_entry(reg_cache, &clock_reg_cache_list, node) {
> > -             samsung_clk_save(reg_cache->reg_base, reg_cache->rdump,
> > -                             reg_cache->rd_num);
> > -             samsung_clk_restore(reg_cache->reg_base, reg_cache->rsusp=
end,
> > -                             reg_cache->rsuspend_num);
> > +             samsung_clk_save(reg_cache->reg_base, reg_cache->sysreg,
> > +                              reg_cache->rdump, reg_cache->rd_num);
> > +             samsung_clk_restore(reg_cache->reg_base, reg_cache->sysre=
g,
> > +                                 reg_cache->rsuspend,
> > +                                 reg_cache->rsuspend_num);
> >       }
> >       return 0;
> >  }
> > @@ -289,8 +388,8 @@ static void samsung_clk_resume(void)
> >       struct samsung_clock_reg_cache *reg_cache;
> >
> >       list_for_each_entry(reg_cache, &clock_reg_cache_list, node)
> > -             samsung_clk_restore(reg_cache->reg_base, reg_cache->rdump=
,
> > -                             reg_cache->rd_num);
> > +             samsung_clk_restore(reg_cache->reg_base, reg_cache->sysre=
g,
> > +                                 reg_cache->rdump, reg_cache->rd_num);
> >  }
> >
> >  static struct syscore_ops samsung_clk_syscore_ops =3D {
> > @@ -299,6 +398,7 @@ static struct syscore_ops samsung_clk_syscore_ops =
=3D {
> >  };
> >
> >  void samsung_clk_extended_sleep_init(void __iomem *reg_base,
> > +                     struct regmap *sysreg,
> >                       const unsigned long *rdump,
> >                       unsigned long nr_rdump,
> >                       const struct samsung_clk_reg_dump *rsuspend,
> > @@ -319,6 +419,7 @@ void samsung_clk_extended_sleep_init(void __iomem *=
reg_base,
> >               register_syscore_ops(&samsung_clk_syscore_ops);
> >
> >       reg_cache->reg_base =3D reg_base;
> > +     reg_cache->sysreg =3D sysreg;
> >       reg_cache->rd_num =3D nr_rdump;
> >       reg_cache->rsuspend =3D rsuspend;
> >       reg_cache->rsuspend_num =3D nr_rsuspend;
> > @@ -334,6 +435,12 @@ void samsung_clk_extended_sleep_init(void __iomem =
*reg_base,
> >  void __init samsung_cmu_register_clocks(struct samsung_clk_provider *c=
tx,
> >                                       const struct samsung_cmu_info *cm=
u)
> >  {
> > +     ctx->auto_clock_gate =3D cmu->auto_clock_gate;
> > +     ctx->gate_dbg_offset =3D cmu->gate_dbg_offset;
> > +     ctx->option_offset =3D cmu->option_offset;
> > +     ctx->drcg_offset =3D cmu->drcg_offset;
> > +     ctx->memclk_offset =3D cmu->memclk_offset;
> > +
> >       if (cmu->pll_clks)
> >               samsung_clk_register_pll(ctx, cmu->pll_clks, cmu->nr_pll_=
clks);
> >       if (cmu->mux_clks)
> > @@ -353,6 +460,31 @@ void __init samsung_cmu_register_clocks(struct sam=
sung_clk_provider *ctx,
> >               samsung_clk_register_cpu(ctx, cmu->cpu_clks, cmu->nr_cpu_=
clks);
> >  }
> >
> > +/* Enable Dynamic Root Clock Gating of bus components*/
>
> missing space before */

will fix.

>
> > +void samsung_en_dyn_root_clk_gating(struct device_node *np,
> > +                                 struct samsung_clk_provider *ctx,
> > +                                 const struct samsung_cmu_info *cmu)
> > +{
> > +     if (ctx && !ctx->auto_clock_gate)
>
> ctx can not be NULL here. If it could, then the following lines would als=
o
> need updating, but again, it can not be NULL, if ctx allocation fails, th=
e
> code will panic() before this here is reached.

I'll remove that check.
>
> > +             return;
> > +
> > +     ctx->sysreg =3D syscon_regmap_lookup_by_phandle(np, "samsung,sysr=
eg");
> > +     if (!IS_ERR_OR_NULL(ctx->sysreg)) {
> > +             regmap_write(ctx->sysreg, ctx->drcg_offset, 0xffffffff);
>
> What does 0xffffffff mean? Maybe a macro or at least a comment would help=
.

Setting a bit "enables dynamic root clock gating (drcg)". Different
bits in the register correspond to different bus components. So this
is enabling drcg for everything.

>
> > +             /* not every sysreg controller has memclk reg*/
>
> missing space before */

Will fix
>
> Can you please check all such comments, since it seems to be recurring :-=
)

Will check!
>
> +               if (ctx->memclk_offset)
> > +                     regmap_write_bits(ctx->sysreg, ctx->memclk_offset=
, 0x1, 0x0);
> > +
> > +             samsung_clk_extended_sleep_init(NULL, ctx->sysreg,
> > +                                             cmu->sysreg_clk_regs,
> > +                                             cmu->nr_sysreg_clk_regs,
> > +                                             NULL, 0);
> > +     } else {
> > +             pr_warn("%pOF: Unable to get CMU sysreg\n", np);
> > +             ctx->sysreg =3D NULL;
> > +     }
> > +}
> > +
> >  /*
> >   * Common function which registers plls, muxes, dividers and gates
> >   * for each CMU. It also add CMU register list to register cache.
> > @@ -374,11 +506,14 @@ struct samsung_clk_provider * __init samsung_cmu_=
register_one(
> >       samsung_cmu_register_clocks(ctx, cmu);
> >
> >       if (cmu->clk_regs)
> > -             samsung_clk_extended_sleep_init(reg_base,
> > +             samsung_clk_extended_sleep_init(reg_base, NULL,
> >                       cmu->clk_regs, cmu->nr_clk_regs,
> >                       cmu->suspend_regs, cmu->nr_suspend_regs);
> >
> >       samsung_clk_of_add_provider(np, ctx);
> >
> > +     /* sysreg DT nodes reference a clock in this CMU */
> > +     samsung_en_dyn_root_clk_gating(np, ctx, cmu);
> > +
>
> samsung_cmu_register_one() is not called when the clocks are registered
> using exynos_arm64_register_cmu_pm(). Does the pm version need a call to
> samsung_en_dyn_root_clk_gating() somewhere?

Yes, good point, I will add it in v2. That should make things smoother
when we switch to the exynos_arm64_register_cmu_pm() version.

>
> >       return ctx;
> >  }
> > diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
> > index 18660c1ac6f0106b17b9efc9c6b3cd62d46f7b82..b719e057f45489e9d92ba54=
031fe633a8c9264ce 100644
> > --- a/drivers/clk/samsung/clk.h
> > +++ b/drivers/clk/samsung/clk.h
> > @@ -12,6 +12,7 @@
> >
> >  #include <linux/clk-provider.h>
> >  #include <linux/mod_devicetable.h>
> > +#include <linux/regmap.h>
> >  #include "clk-pll.h"
> >  #include "clk-cpu.h"
> >
> > @@ -19,13 +20,25 @@
> >   * struct samsung_clk_provider - information about clock provider
> >   * @reg_base: virtual address for the register base
> >   * @dev: clock provider device needed for runtime PM
> > + * @sysreg: syscon regmap for clock-provider sysreg controller
> >   * @lock: maintains exclusion between callbacks for a given clock-prov=
ider
> > + * @auto_clock_gate: enable auto clk mode for all clocks in clock-prov=
ider
> > + * @gate_dbg_offset: gate debug reg offset. Used for all gates in auto=
 clk mode
> > + * @option_offset: option reg offset. Enables auto mode for clock-prov=
ider
> > + * @drcg_offset: dynamic root clk gate enable register offset
> > + * @memclk_offset: memclk enable register offset
>
> The last two are in the sysreg space, maybe the comment should mention th=
at.

Will update the comment.

>
> >   * @clk_data: holds clock related data like clk_hw* and number of cloc=
ks
> >   */
> >  struct samsung_clk_provider {
> >       void __iomem *reg_base;
> >       struct device *dev;
> > +     struct regmap *sysreg;
> >       spinlock_t lock;
> > +     bool auto_clock_gate;
> > +     u32 gate_dbg_offset;
> > +     u32 option_offset;
> > +     u32 drcg_offset;
> > +     u32 memclk_offset;
> >       /* clk_data must be the last entry due to variable length 'hws' a=
rray */
> >       struct clk_hw_onecell_data clk_data;
> >  };
> > @@ -310,6 +323,7 @@ struct samsung_cpu_clock {
> >  struct samsung_clock_reg_cache {
> >       struct list_head node;
> >       void __iomem *reg_base;
> > +     struct regmap *sysreg;
> >       struct samsung_clk_reg_dump *rdump;
> >       unsigned int rd_num;
> >       const struct samsung_clk_reg_dump *rsuspend;
> > @@ -338,7 +352,14 @@ struct samsung_clock_reg_cache {
> >   * @suspend_regs: list of clock registers to set before suspend
> >   * @nr_suspend_regs: count of clock registers in @suspend_regs
> >   * @clk_name: name of the parent clock needed for CMU register access
> > + * @sysreg_clk_regs: list of sysreg clock registers
> > + * @nr_sysreg_clk_regs: count of clock registers in @sysreg_clk_regs
> >   * @manual_plls: Enable manual control for PLL clocks
> > + * @auto_clock_gate: enable auto clock mode for all components in CMU
> > + * @gate_dbg_offset: gate debug reg offset. Used by all gates in auto =
clk mode
> > + * @option_offset: option reg offset. Enables auto clk mode for entire=
 CMU
> > + * @drcg_offset: dynamic root clk gate enable register offset
> > + * @memclk_offset: memclk enable register offset
>
> dito.

Will fix

Thanks again for your time spent reviewing, some great feedback.

regards,

Peter

