Return-Path: <linux-kernel+bounces-862876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F107BF66AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97DBC18A47D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299712F3C1C;
	Tue, 21 Oct 2025 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TtoFpAgr"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851F21578D
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049373; cv=none; b=XfQrVREqqZxv/3e5IgfRSCLsf4uaK4OWcV3wQ3WFFPGBIUjKvLGRqBwQvnYYqyCat86LRRFaonWci/AZo3FvOi78CXu7kKeBukbCJorscP0UaMDS00U/+5d3o5wPYhNyjPbx0q9GiJBe/E5GnNUCI1xsSNRu12BlOpLOhV4hXhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049373; c=relaxed/simple;
	bh=f3De6rNTLERtBCHNMZ22urpVrMEnrkSKkBp8ZJH0Ey0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMl+oT71xCv1nXR0AqGxxFS6OI+kYDWd7y4RKFELDt8sd+DNgmmCMc3bktIHBXJV5gRxS6rYqweBCGCBIFqUbK/VQjFtzDbH75MdTMpo9cPKWzB8HeUfWBEY66neUVvaipNKqpNz0RQ3BF1DrdwjRsG7gxqQhDqk5AEIBnOFaEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TtoFpAgr; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7847ee5f59dso43183087b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761049370; x=1761654170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0gsO0Mv1FrcyGXkqaqLTVsEMXbut/odQDvF8E5ZP8zg=;
        b=TtoFpAgr9EvntFhc0LWUKCHatbEH+caEZo4EJERzFHvdgEZ435S+nNHROPl0IAYd+k
         sVmMOlEAdxm3e9IaZzJD4xUzSrfyV99GKaMkGVFioYvU2ZHHMOTRqmJNuOs1bjnGK2UE
         LX6E9RBByJFXuE7uCDXc4enjwrYVuWbtom6kBXhR8wl3PlvqA8/v4208U9y2jWMQpTrr
         +YXtHmo5dvsH3yJGWHHtjcFNcNkggoGWxjbwpdsATMLfoGQbW47rzsiQKby2eGfN12AB
         KnVexQom0e4V8BDfgWImOuLLu/ljhJoAlHNATfdVHJeAktbmcdUnFwQxq3l/HCMRfcjH
         d5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049370; x=1761654170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gsO0Mv1FrcyGXkqaqLTVsEMXbut/odQDvF8E5ZP8zg=;
        b=bpxjp4GM+8Z6qkHk7KKHzSbSpHTCFGo5e2RJrM8lNq04sAzN8ZpytvMfmFkEex6JjE
         5l0kmRj+ALJsoCxAhS2T5PxhC0Vuldi5wZmRHddPskmLgSl9macWoxodbktBBlpzkCP2
         A7j7tBprc+3kNsfgd1Er2SEdprRMsrv2BObYwa9l3GifaClXmatiIB7chpeERHLGoCBy
         KwctAZB59A9n8r3Fnq/6jyABPw17O6aY2aJ6AWMx2GkyAbEXzMR/LCei3dH+JO7cjUJt
         ncYqoD9gUccSvMyfNxtguQBKLsCtn8JWM9ublGXbySV5HS724cy443O6VmRBWLIMeXmr
         65WA==
X-Forwarded-Encrypted: i=1; AJvYcCXOGRV7Cl3Mnr50yyzpM9mv6U5RU0cVVdPH6Gwo6Up82kB6MUfdg64ip0hn0yB9n8/y47u5Y6CfZjayUgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlb6YyudSRzkDO80BA5TBygEt/wN9nmVXbjenrhtLC4iCb95K4
	6s0LSugvcRqhlPNVfphlN6/EJkJrVMaRNggn+BTasbHPufGwtpcAn+OjkVe20+Lr8yU2DExGN/O
	GMBzb9cX1BQp5A6ShUPzctJRYWMSl3PUk7gqurcRXge1aHkcm5V+B228=
X-Gm-Gg: ASbGnctQtKyE8IS3bOJMyHW0w0oj0g1F+TuyrtFEDUhjEmCi2UcekC9vN0252bMSDmK
	vDr9BCgSiEmXBKcfLa2oWabgkZmj3AEI3x8L6H759+nbMe9bSXeFS++Rdl26BjGwFfk6qx9FD9t
	fcWyjoqRuQHt7Bi5c68Srsbo5/NEiAIgHi7KXL4aHzHjFyT5zae9igaK/NwQjVrZRVE3e58IbzL
	QeM+Ucu/guAaUyYr5mg49mofSIBTlM6dZeneb+s+XJ91tWZ/RA694gtt+KtopdZhouSlEoL
X-Google-Smtp-Source: AGHT+IEjsTRnovw4ePg20FTB4OUKNJwNiI+HcgpJ0npXrx4jgsZXBfmlUSYcGf7LNK6sqZ0vKa1Fghky5U1mlT7+5do=
X-Received: by 2002:a53:acd5:0:20b0:63e:102f:e00e with SMTP id
 956f58d0204a3-63e1625aee1mr12332024d50.53.1761049369570; Tue, 21 Oct 2025
 05:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910-uart-daisy-chain-pmdomain-v2-1-6d0215f4af32@ti.com>
In-Reply-To: <20250910-uart-daisy-chain-pmdomain-v2-1-6d0215f4af32@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 14:22:13 +0200
X-Gm-Features: AS18NWBw6aYnNOt7sX3hV723CfvlVkoslKqfPhuE6iOIYmHabXQ8nFw-lI3bkVE
Message-ID: <CAPDyKFrOjFeZDOs84egaCAmRwtnXcj5bZLniOb1gkDkDH0214g@mail.gmail.com>
Subject: Re: [PATCH v2] pmdomain: ti_sci: Handle wakeup constraint if device
 has pinctrl wakeup state
To: Kendall Willis <k-willis@ti.com>, khilman@baylibre.com
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, d-gole@ti.com, 
	vishalm@ti.com, sebin.francis@ti.com, msp@baylibre.com, a-kaur@ti.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Sept 2025 at 23:16, Kendall Willis <k-willis@ti.com> wrote:
>
> For TI K3 SoCs with IO daisy-chaining using pinctrl wakeup state, avoid
> sending wakeup constraints to the PM co-processor. This allows the SoC to
> enter deeper low power states while still maintaining wakeup capability
> for peripherals using IO daisy-chain wakeup via pinctrl wakeup state,
> similar to the existing wake IRQ mechanism added in commit b06bc47279919
> ("pmdomain: ti_sci: handle wake IRQs for IO daisy chain wakeups").
>
> Detect the pinctrl wakeup state in the suspend path, and if it exists,
> skip sending the constraint.
>
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
> Implementation
> --------------
> This patch is intended to be implemented along with the following
> series. This patch has no dependencies on any of the other series:
>
> 1. "pmdomain: ti_sci: Handle wakeup constraint if device has pinctrl
>    wakeup state": (this patch) skips setting constraints for wakeup
>    sources that use pinctrl state 'wakeup'.
>
> 2. "serial: 8250: omap: Add wakeup support": Implements wakeup from
>    the UARTs for TI K3 SoCs
>    https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-8250-omap
>
> 3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": Implements the
>    functionality to wakeup the system from the Main UART
>    https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-dts
>
> Testing
> -------
> Tested on a AM62P SK EVM board with all series and dependencies
> implemented. Suspend/resume verified with the Main UART wakeup source
> by entering a keypress on the console.
>
> This github branch has all the necessary patches to test the series
> using linux-next:
> https://github.com/kwillis01/linux/tree/uart-daisy-chain
>
> Version History
> ---------------
> Changes from v1 to v2:
>  - Reworded commit message to be concise and to reference commit
>    b06bc47279919
>
> v1: https://lore.kernel.org/all/20250904211607.3725897-1-k-willis@ti.com/
> ---
>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/pmdomain/ti/ti_sci_pm_domains.c b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> index 82df7e44250bb64f9c4a2108b5e97bd782a5976d..884905fd0686c1b94aba68c03da038e577428adf 100644
> --- a/drivers/pmdomain/ti/ti_sci_pm_domains.c
> +++ b/drivers/pmdomain/ti/ti_sci_pm_domains.c
> @@ -10,6 +10,7 @@
>  #include <linux/err.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_qos.h>
> @@ -84,9 +85,24 @@ static inline void ti_sci_pd_set_wkup_constraint(struct device *dev)
>         struct generic_pm_domain *genpd = pd_to_genpd(dev->pm_domain);
>         struct ti_sci_pm_domain *pd = genpd_to_ti_sci_pd(genpd);
>         const struct ti_sci_handle *ti_sci = pd->parent->ti_sci;
> +       struct pinctrl *pinctrl = devm_pinctrl_get(dev);
> +       struct pinctrl_state *pinctrl_state_wakeup;
>         int ret;
>
>         if (device_may_wakeup(dev)) {
> +               /*
> +                * If device can wakeup using pinctrl wakeup state,
> +                * we do not want to set a constraint
> +                */
> +               if (!IS_ERR_OR_NULL(pinctrl)) {
> +                       pinctrl_state_wakeup = pinctrl_lookup_state(pinctrl, "wakeup");
> +                       if (!IS_ERR_OR_NULL(pinctrl_state_wakeup)) {
> +                               dev_dbg(dev, "%s: has wake pinctrl wakeup state, not setting " \
> +                                               "constraints\n", __func__);
> +                               return;
> +                       }
> +               }

Relying on the above condition and the wakeirq check that was added in
b06bc47279919, seems fragile and doesn't really seem like the best
approach to me.

I would rather think that we should rely on the driver for the
consumer device to successfully have completed its parts, by enabling
the out-band system-wakeup IRQ. In other words, make the consumer
driver to call device_set_out_band_wakeup() and then use
device_out_band_wakeup() instead of the pinctrl+wakeirq check above,
to understand if QoS constraints shall be sent to the FW or not.

> +
>                 /*
>                  * If device can wakeup using IO daisy chain wakeups,
>                  * we do not want to set a constraint.
>
> ---
> base-commit: 5f540c4aade9f1d58fb7b9490b4b7d5214ec9746
> change-id: 20250910-uart-daisy-chain-pmdomain-b83b2db2c3cc
>
> Best regards,
> --
> Kendall Willis <k-willis@ti.com>
>

Kind regards
Uffe

