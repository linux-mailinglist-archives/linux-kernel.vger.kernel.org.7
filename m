Return-Path: <linux-kernel+bounces-826373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1079BB8E5A3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 22:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEBCE3BC360
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 20:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5D828C2D2;
	Sun, 21 Sep 2025 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRVDTveE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A481524D1;
	Sun, 21 Sep 2025 20:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758488018; cv=none; b=I1XP0Qvmz0oe748So0IRth5Cjdl4LSEsYABaQBvMiutZDh5Vk2MpxJ4NvRpqtA1c8el5bFyXOiLirAkPi7/8B9SS392P8s4zyV3ZhMououK5osRlcxk8S/ayM0SQYldhEUUa2uit0UDSNlWBqk2ZCZPjJIPdHRJMsN9rN/8WAaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758488018; c=relaxed/simple;
	bh=J1ZFtX4yvxKI22ZawNgw40HCJY1KhiYNmPZ1GeiDW/4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=IIDd8ACB/1yl0DNSW8Pe67jlpn9WUegXcAl9y5YDK69jYnbQtRsaofcA+1FAwpSVjlIdxXzVQlfLjY6HuBQHkbDkpHvLn3+PfNcDQ8X093rinDWntfF5cg/RcbT262en5wl4+zY0BOKUfqQDytN40kXOrAi79XNSu5kDTXH/uRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRVDTveE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760B0C4CEE7;
	Sun, 21 Sep 2025 20:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758488016;
	bh=J1ZFtX4yvxKI22ZawNgw40HCJY1KhiYNmPZ1GeiDW/4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jRVDTveEzhJOLghwziVd7Tm+Ldcwbt82QotkmsuvKUdp7Jvz0BAws0jDBUZPKU4MQ
	 9LPG5u+RcZlEGes07BgeCvTInni3yuLi8L+vdb98PcOveEDuFM4GOhbSCF/5Txz1tv
	 ynPSOzP3Y2YCsjFLb9LzX+sRoh/2B9FlNIXlZzyyhITerup96M96/68ZxQH6icvrDm
	 do5NyYEbZgOaals9q5hWcbSOvpBtBwzNa8nfe3qzBpiWY07A7/oH8p+pJSSeJvsDfc
	 Zhw9MO976iGvHj1G1evMMoAWGQ10aV5k7hIWzSloGDQovXY0rq7mv3UuJEl0pD258F
	 U4mIQSUgWETeA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250915-clk-ssc-version1-v4-2-5a2cee2f0351@nxp.com>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com> <20250915-clk-ssc-version1-v4-2-5a2cee2f0351@nxp.com>
Subject: Re: [PATCH v4 2/5] clk: Introduce clk_hw_set_spread_spectrum
From: Stephen Boyd <sboyd@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To: Brian Masney <bmasney@redhat.com>, Conor Dooley <conor+dt@kernel.org>, Cristian Marussi <cristian.marussi@arm.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Date: Sun, 21 Sep 2025 13:53:34 -0700
Message-ID: <175848801471.4354.13819701022920596111@lazor>
User-Agent: alot/0.11

Quoting Peng Fan (2025-09-15 01:29:36)
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index b821b2cdb155331c85fafbd2fac8ab3703a08e4d..06db8918a1b35e3280e565272=
bc4603a88295a92 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -2802,6 +2802,32 @@ int clk_set_max_rate(struct clk *clk, unsigned lon=
g rate)
>  }
>  EXPORT_SYMBOL_GPL(clk_set_max_rate);
> =20
> +int clk_hw_set_spread_spectrum(struct clk_hw *hw, struct clk_spread_spec=
trum *conf)
> +{
> +       struct clk_core *core;
> +       int ret;
> +
> +       if (!hw)
> +               return 0;
> +
> +       core =3D hw->core;
> +
> +       clk_prepare_lock();
> +
> +       ret =3D clk_pm_runtime_get(core);
> +       if (ret)
> +               goto fail;
> +
> +       if (core->ops->set_spread_spectrum)
> +               ret =3D core->ops->set_spread_spectrum(hw, conf);
> +
> +       clk_pm_runtime_put(core);
> +
> +fail:
> +       clk_prepare_unlock();
> +       return ret;
> +}

Does it need to be exported?=20

> +
>  /**
>   * clk_get_parent - return the parent of a clk
>   * @clk: the clk whose parent gets returned
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 630705a47129453c241f1b1755f2c2f2a7ed8f77..4f48a4df95a1c54638a0e91e0=
a449fcc8aa40b80 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -84,6 +84,19 @@ struct clk_duty {
>         unsigned int den;
>  };
> =20
> +/**
> + * struct clk_spread_spectrum - Structure encoding spread spectrum of a =
clock
> + *
> + * @modfreq_hz:                Modulation frequency
> + * @spread_bp:         Modulation percent in permyriad
> + * @method:            Modulation method
> + */
> +struct clk_spread_spectrum {
> +       u32 modfreq_hz;
> +       u32 spread_bp;
> +       u32 method;

What are the possible values of 'method'? I'm guessing it's the defines
in the dt-bindings header? Please connect these two somehow, maybe
through an enum. Also, why are these u32? Shouldn't these be more common
types like unsigned long or unsigned long long instead being exactly 32
bits?

> +};
> +
>  /**
>   * struct clk_ops -  Callback operations for hardware clocks; these are =
to
>   * be provided by the clock implementation, and will be called by drivers
> @@ -178,6 +191,12 @@ struct clk_duty {
>   *             separately via calls to .set_parent and .set_rate.
>   *             Returns 0 on success, -EERROR otherwise.
>   *
> + * @set_spread_spectrum: Optional callback used to configure the spread
> + *             spectrum modulation frequency, percentage, and method
> + *             to reduce EMI by spreading the clock frequency over a
> + *             wider range.
> + *             Returns 0 on success, -EERROR otherwise.
> + *
>   * @recalc_accuracy: Recalculate the accuracy of this clock. The clock a=
ccuracy
>   *             is expressed in ppb (parts per billion). The parent accur=
acy is
>   *             an input parameter.
> @@ -255,6 +274,8 @@ struct clk_ops {
>         int             (*set_rate_and_parent)(struct clk_hw *hw,
>                                     unsigned long rate,
>                                     unsigned long parent_rate, u8 index);
> +       int             (*set_spread_spectrum)(struct clk_hw *hw,
> +                                              struct clk_spread_spectrum=
 *clk_ss);

const clk_ss pointer? And is it actually 'conf' or 'ss_conf'?

>         unsigned long   (*recalc_accuracy)(struct clk_hw *hw,
>                                            unsigned long parent_accuracy);
>         int             (*get_phase)(struct clk_hw *hw);
> @@ -1430,6 +1451,7 @@ void clk_hw_get_rate_range(struct clk_hw *hw, unsig=
ned long *min_rate,
>                            unsigned long *max_rate);
>  void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
>                            unsigned long max_rate);
> +int clk_hw_set_spread_spectrum(struct clk_hw *hw, struct clk_spread_spec=
trum *conf);

const conf? And 'ss_conf' again?

