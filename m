Return-Path: <linux-kernel+bounces-736212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADC4B09A20
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 05:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61CE517ED34
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 03:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C854814F121;
	Fri, 18 Jul 2025 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIefvjJ/"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE31400C;
	Fri, 18 Jul 2025 03:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752808644; cv=none; b=Wfc4hL8bF9KIDsp+Ka07wcgFFsx6h5HlDybUXJMIhpb6Ys5HuYDykfJIHVpOm+/fczxigkxQ5tvgN1EvnfbYimUNM3XAJPs1vzew66lex9RfGm9IOtbpK+84LANTCpoAQh9OZiCPu7Y3wrX05OlNy/1GdRT5NzZr7Qi3kFtiKfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752808644; c=relaxed/simple;
	bh=lxayXSqvokqrTEjYHa9AUo75ZKKOi9qgsaPYBbCZaIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DG53uzPmEfwFmhPggzfhqbymm2cjW9vlS2621CL145E+fx/oTV/1CbaEG2y3PfG3NCwx60su/8qPBkz3JUFx67VrAeaBpYVk4aF0q+yxcI0gN65YyLE8VAuEXUsmmQfuBzVMeEGsC5Zke6B2FTpLSe1ZIp8+zVPP65R2j3tKokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIefvjJ/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45634205adaso7945375e9.2;
        Thu, 17 Jul 2025 20:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752808640; x=1753413440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xLyVZDIwAcj1HEAQ8+4rL33smyGPoUW6kEINY6RwQw=;
        b=SIefvjJ/AKmHXvHga+Nj3yod6PyftaFiRv+H/HLajRb7Z6AX4BddN6KP8BlMzGZZrZ
         +9yuVLyC3Dlrj5QBYI0MiJKc8YIlHXCg/7kXxiyoUSBLTVGl8z+zqzYJ85qMoEOK48ta
         r9A6lojcE7dyqtBZ4Q69LkdckL1PkPRS4UiIyxvLlRU6QnwDIi/GtJfbqgn4nIUaFFNF
         Pt66BwQr7AOJf2xI+QBpu6tyLLeSiusitXRtwWsMhibYfRvcWW0dLXVYH8LNFWTwkjPQ
         +n/ZuPv287iG4DAPdy8vayPGykOBxYcWCjnsDpqReNhZNbrvBFYWiDlk4G0brnRtj1Sh
         1SwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752808640; x=1753413440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xLyVZDIwAcj1HEAQ8+4rL33smyGPoUW6kEINY6RwQw=;
        b=E5nfKHSDw+Wkwtt3Cw3pgzvhBr9A6EiUUc/k3tFgR1EvMGlvWCiD7E4lcJaxVSogRL
         f7CsV5aHr1o69+dK3oyOAuCjC4Jr9skmCTu58Uwp4UB3O9zsNGIUsxhL3gonkZ1slapl
         oCGwbS1CzYYZhCeowoVFh6LdbL/oPlKQsjOQGokpklBLLNH5IyPzI6xxSJ7Xf3S9Pj//
         u9RLrWSUrHcrQ9A+KeiqiI5TBvvsT2mA3Xw5ldWAZ9gRcSL25SpdDXHGqHMrGrNZS5Ve
         DsRTa/aoHT4GjeXbI1hIIpM4sTLddSjFzyokjFhf0Uod2nXSaC6Jo7Q5b6FhKFjw2yjS
         2YuA==
X-Forwarded-Encrypted: i=1; AJvYcCVR6zUmfDfE55kdsmNd/uC5QG/FkOorbpIuQWjgcx+0opl/SCiFbNph6w5Fu4TJ883cerWclzRXfQsCdCT9@vger.kernel.org, AJvYcCWfUpSrIiCLPa2jYBLdBiUociKMBmrl5fEnuk+qZ3+VzA48yrt9JlGx6E4mciRVhAfFci0fqZkTqjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfuCa5/GN8HTdPUV1DW8vwcQ1BGfI6kPGxyBUSg61bmg0RovJf
	reYHT3v7Krb9Ng/em8SIrrujQDuIvZxSQhv+UusxXRv+FhSJq9Rxk5zg9OAbo49UxzITZIyjAWR
	jiEY1r0UsZs/Sy3X1TNo/DwxbcccJyEU=
X-Gm-Gg: ASbGncsbUsIDxQzLfnFCybsu/m+ulvDpJn4N3Z+BIeMREfR+PLypJIPMZ0WbsBAKvMY
	P/0szEhyyn7Mwaxu9kjoALR4YaoBpOynq5keRY1htjt0OJBnnXVL6k/4Msh3F2zTVPFIui8Yvh1
	ppHkkYqYBtxNHAimK2/9XFjDEVLo5BoM6JLspoG2+GX4OpLN66/gMsWbsw6f40XL4bUnK+BNxNS
	6YmJJTd
X-Google-Smtp-Source: AGHT+IF6HqZhMnM1S5SriTeRFu45wU1jwnPvEWa5YJwPLmPns1dVqf+yP0H+WgfkvxP0STMyHCOWZiUQMc0r+vOOQWk=
X-Received: by 2002:a5d:6f1d:0:b0:3b2:fe46:9812 with SMTP id
 ffacd0b85a97d-3b60e4d3e2cmr5229036f8f.19.1752808640240; Thu, 17 Jul 2025
 20:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718-k1-clk-i2s-v1-1-e92c10fd0f60@linux.spacemit.com>
In-Reply-To: <20250718-k1-clk-i2s-v1-1-e92c10fd0f60@linux.spacemit.com>
From: Jesse T <mr.bossman075@gmail.com>
Date: Thu, 17 Jul 2025 23:16:43 -0400
X-Gm-Features: Ac12FXxu7iDTL6EHvyzjs4TsEjO7dBDwq7U1sYpuaMmupzIdSEt8fvtu992HPZw
Message-ID: <CAJFTR8TfctXn=+o0SbjUgC0xHu6w7JPrAR7rERrL1u1EvLgKyw@mail.gmail.com>
Subject: Re: [PATCH] clk: spacemit: fix sspax_clk
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Yixun Lan <dlan@gentoo.org>, linux-clk@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 10:10=E2=80=AFPM Troy Mitchell
<troy.mitchell@linux.spacemit.com> wrote:
>
> In the SpacemiT public document, when the FNCLKSEL field of
> the APBC_SSPAX_CLK_RST register is 7 (3'b111),
> which is a reserved value. And BIT3 of the same register is
> a reserved bit.
>
> But the document is wrong, the actual situation is:
> when FNCLKSEL is 7 (3'b111), and the purpose of bit 3 is
> if to select i2s_bclk as the parent clock.
>
> And only when FNCLKSEL is 7 (3'b111), The bit 3 is not a reserved bit.
>
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> ---
>  drivers/clk/spacemit/ccu-k1.c  |  4 ++--
>  drivers/clk/spacemit/ccu_mix.c | 29 +++++++++++++++++++++++++++++
>  drivers/clk/spacemit/ccu_mix.h | 14 ++++++++++++++
>  3 files changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.=
c
> index cdde37a0523537c2f436e481ae8d6ec5a581b87e..0e22f6fb2c45b68ab20a9b156=
3a1a6dec1a7e16c 100644
> --- a/drivers/clk/spacemit/ccu-k1.c
> +++ b/drivers/clk/spacemit/ccu-k1.c
> @@ -359,8 +359,8 @@ static const struct clk_parent_data sspa_parents[] =
=3D {
>         CCU_PARENT_HW(pll1_d3072_0p8),
>         CCU_PARENT_HW(i2s_bclk),
>  };
> -CCU_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4, 3, B=
IT(1), 0);
> -CCU_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4, 3, B=
IT(1), 0);
> +CCU_SSPA_MUX_GATE_DEFINE(sspa0_clk, sspa_parents, APBC_SSPA0_CLK_RST, 4,=
 3, BIT(1), 0);
> +CCU_SSPA_MUX_GATE_DEFINE(sspa1_clk, sspa_parents, APBC_SSPA1_CLK_RST, 4,=
 3, BIT(1), 0);
>  CCU_GATE_DEFINE(dro_clk, CCU_PARENT_HW(apb_clk), APBC_DRO_CLK_RST, BIT(1=
), 0);
>  CCU_GATE_DEFINE(ir_clk, CCU_PARENT_HW(apb_clk), APBC_IR_CLK_RST, BIT(1),=
 0);
>  CCU_GATE_DEFINE(tsen_clk, CCU_PARENT_HW(apb_clk), APBC_TSEN_CLK_RST, BIT=
(1), 0);
> diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mi=
x.c
> index 9b852aa61f78aed5256bfe6fc3b01932d6db6256..bfc65fc00df67299523eb5d1d=
2ed479c61fc6141 100644
> --- a/drivers/clk/spacemit/ccu_mix.c
> +++ b/drivers/clk/spacemit/ccu_mix.c
> @@ -191,6 +191,25 @@ static int ccu_mux_set_parent(struct clk_hw *hw, u8 =
index)
>         return ccu_mix_trigger_fc(hw);
>  }
>
> +static int ccu_mux_set_sspa_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct ccu_mix *mix =3D hw_to_ccu_mix(hw);
> +       struct ccu_mux_config *mux =3D &mix->mux;
> +       u32 mask, val;
> +
> +       mask =3D GENMASK(mux->width + mux->shift - 1, mux->shift);
> +       val =3D index << mux->shift;
> +
> +       if (index =3D=3D 7) {
> +               mask |=3D BIT(3);
> +               val |=3D BIT(3);

Can the value 3 here be a macro like FNCLKSEL_SSPX_I2S_BCLK_PARENT.
A comment would be nice too.

> +       }
> +
> +       ccu_update(&mix->common, ctrl, mask, val);
> +
> +       return ccu_mix_trigger_fc(hw);
> +}
> +
>  const struct clk_ops spacemit_ccu_gate_ops =3D {
>         .disable        =3D ccu_gate_disable,
>         .enable         =3D ccu_gate_enable,
> @@ -235,6 +254,16 @@ const struct clk_ops spacemit_ccu_mux_gate_ops =3D {
>         .set_parent     =3D ccu_mux_set_parent,
>  };
>
> +const struct clk_ops spacemit_ccu_sspa_mux_gate_ops =3D {
> +       .disable        =3D ccu_gate_disable,
> +       .enable         =3D ccu_gate_enable,
> +       .is_enabled     =3D ccu_gate_is_enabled,
> +
> +       .determine_rate =3D ccu_mix_determine_rate,
> +       .get_parent     =3D ccu_mux_get_parent,
> +       .set_parent     =3D ccu_mux_set_sspa_parent,
> +};
> +
>  const struct clk_ops spacemit_ccu_div_gate_ops =3D {
>         .disable        =3D ccu_gate_disable,
>         .enable         =3D ccu_gate_enable,
> diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mi=
x.h
> index 51d19f5d6aacb7203d1eddf96047cf3174533601..7753446386353bf849787ed4e=
c7c85c298238ab5 100644
> --- a/drivers/clk/spacemit/ccu_mix.h
> +++ b/drivers/clk/spacemit/ccu_mix.h
> @@ -124,6 +124,19 @@ static struct ccu_mix _name =3D {                   =
                                 \
>         }                                                                =
       \
>  }
>
> +#define CCU_SSPA_MUX_GATE_DEFINE(_name, _parents, _reg_ctrl,            =
       \

I think it would be better to add a flags bit to struct ccu_mux_config
Then add CCU_MUX_GATE_DEFINE_FLAGS, something like how
drivers/clk/nxp/clk-lpc18xx-ccu.c has CCU_BRANCH_HAVE_DIV2 and CCU_BRANCH_I=
S_BUS
This would allow for multiple different variants of the same mux to be
added without having a bunch of
peripheral specific functions.

> +                                    _shift, _width, _mask_gate, _flags) =
       \
> +static struct ccu_mix _name =3D {                                       =
                 \
> +       .gate   =3D CCU_GATE_INIT(_mask_gate),                           =
         \
> +       .mux    =3D CCU_MUX_INIT(_shift, _width),                        =
         \
> +       .common =3D {                                                    =
         \
> +               .reg_ctrl       =3D _reg_ctrl,                           =
         \
> +               CCU_MIX_INITHW_PARENTS(_name, _parents,                  =
       \
> +                                      spacemit_ccu_sspa_mux_gate_ops,   =
       \
> +                                      _flags),                          =
       \
> +       }                                                                =
       \
> +}
> +
>  #define CCU_DIV_GATE_DEFINE(_name, _parent, _reg_ctrl, _shift, _width,  =
       \
>                             _mask_gate, _flags)                          =
       \
>  static struct ccu_mix _name =3D {                                       =
                 \
> @@ -213,6 +226,7 @@ extern const struct clk_ops spacemit_ccu_div_ops;
>  extern const struct clk_ops spacemit_ccu_factor_gate_ops;
>  extern const struct clk_ops spacemit_ccu_div_gate_ops;
>  extern const struct clk_ops spacemit_ccu_mux_gate_ops;
> +extern const struct clk_ops spacemit_ccu_sspa_mux_gate_ops;
>  extern const struct clk_ops spacemit_ccu_mux_div_ops;
>  extern const struct clk_ops spacemit_ccu_mux_div_gate_ops;
>  #endif /* _CCU_DIV_H_ */
>
> ---
> base-commit: 733923397fd95405a48f165c9b1fbc8c4b0a4681
> change-id: 20250717-k1-clk-i2s-e4272f1f915b
>
> Best regards,
> --
> Troy Mitchell <troy.mitchell@linux.spacemit.com>

Congrats on working at spacemit!!

Thanks,
Jesse Taube
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

